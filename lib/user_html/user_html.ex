defmodule ServerHtml do
  defstruct game_name: "game-name",
            html_rotate: 0,
            html_title: "the-title",
            html_user: "users-name",
            html_tile_px: TheConsts.c_tile_pixels(),
            html_rows: TheConsts.c_tile_pixels(),
            html_w_px: TheConsts.c_board_hor_px(),
            html_h_px: TheConsts.c_board_ver_px(),
            rotate_w_px: TheConsts.c_board_hor_px() + 1,
            rotate_h_px: TheConsts.c_board_ver_px() + 1,
            html_scale: 1,
            html_offset_x: "0px",
            html_offset_y: "0px",
            html_ping: 0,
            html_server_ms: -4321,
            html_jump_opacity: TheConsts.c_init_opacity_0(),
            html_colors: nil,
            html_alive: %{},
            html_current: "",
            html_mobile: false
end

defmodule MultiGameWeb.UserHtml do
  use MultiGameWeb, :live_view

  def handle_event("begin-game", phx_value_person_name, socket) do
    %{"person-name" => _starter_person} = phx_value_person_name
    game_name = socket.assigns.game_name
    {:ok, html_pid_tick} = TickMoment.start_link(game_name)
    TickMoment.begin_game(html_pid_tick)
    {:noreply, assign(socket, html_pid_tick: html_pid_tick)}
  end

  def handle_event("key-north", _dir, socket) do
    starter_person = socket.assigns.html_user
    TickMoment.snake_change_dir(socket.assigns.html_pid_tick, starter_person, "up")
    {:noreply, socket}
  end

  def handle_event("key-east", _dir, socket) do
    starter_person = socket.assigns.html_user
    TickMoment.snake_change_dir(socket.assigns.html_pid_tick, starter_person, "right")

    {:noreply, socket}
  end

  def handle_event("key-south", _dir, socket) do
    starter_person = socket.assigns.html_user
    TickMoment.snake_change_dir(socket.assigns.html_pid_tick, starter_person, "down")

    {:noreply, socket}
  end

  def handle_event("key-west", _diXXr, socket) do
    starter_person = socket.assigns.html_user
    TickMoment.snake_change_dir(socket.assigns.html_pid_tick, starter_person, "left")
    {:noreply, socket}
  end

  def handle_event("key-jump", _key, socket) do
    starter_person = socket.assigns.html_user
    TickMoment.jump_over(socket.assigns.html_pid_tick, starter_person)
    {:noreply, socket}
  end


    def handle_event(
        "update-ping",
        %{
          "ping_server_ms" => string_ping_ms,
                 "is_mobile" => is_mobile,
          "game_name" => _game_name,
          "user_name" => _user_name
        },
        socket
      ) do

    {start_ping_ms, ""} = Integer.parse(string_ping_ms)
    new_ping_ms = CalcPing.calc_ping(start_ping_ms, DateTime.utc_now())
    {:noreply, assign(socket, html_ping: new_ping_ms, html_mobile: is_mobile)}
  end



  def handle_info({:find_ping_time}, socket) do
    Process.send_after(self(), {:find_ping_time}, 1000)
    current_ms = CalcPing.ping_current_ms(DateTime.utc_now())
    game_name = socket.assigns.game_name
    current_players = CollectParticipants.get_participants(game_name)
    html_current = Enum.map(current_players, fn {person_name, _pid} -> person_name end)

    {:noreply,
     assign(
       socket,
       html_server_ms: current_ms,
       html_current: html_current
     )}
  end

  def mount(params, _session, old_socket) do

    Process.send_after(self(), {:find_ping_time}, 1000)
    user_names = params["path"]
    [game_name | [user_name | _]] = user_names
    pid_user = self()
    CollectParticipants.add_participant(game_name, user_name, pid_user)
    the_title = user_name <> " : " <> game_name

    new_socket =
      assign(old_socket,
        game_name: game_name,
        html_rotate: 0,
        html_title: the_title,
        html_user: user_name,
        html_tile_px: TheConsts.c_tile_pixels(),
        html_rows: TheConsts.c_tile_pixels(),
        html_w_px: TheConsts.c_board_hor_px(),
        html_h_px: TheConsts.c_board_ver_px(),
        rotate_w_px: TheConsts.c_board_hor_px() + 1,
        rotate_h_px: TheConsts.c_board_ver_px() + 1,
        html_scale: 1,
        html_offset_x: "0px",
        html_offset_y: "0px",
        html_ping: 0,
        html_server_ms: -4321,
        html_jump_opacity: TheConsts.c_init_opacity_0(),
        html_colors: nil,
        html_alive: %{},
         html_current: "",
            html_mobile: false
      )

    {:ok, new_socket}
  end

  def send_winner(
        pid_user,
        html_pid_board,
        html_pid_tick,
        players_matrix,
        new_scale,
        scale_x_px,
        scale_y_px
      ) do
    GenServer.call(
      pid_user,
      {:send_winner, html_pid_board, html_pid_tick, players_matrix, new_scale, scale_x_px,
       scale_y_px}
    )
  end

  def send_board(pid_user, html_pid_board, html_pid_tick, players_matrix) do
    GenServer.call(
      pid_user,
      {:send_board, html_pid_board, html_pid_tick, players_matrix}
    )
  end

  @doc since: """
       """

  def getColors(m_the_html_rows_svg_inds) do
    columns_current = TheConsts.c_max_hor() - 1

    _the_colors =
      m_the_html_rows_svg_inds
      |> Enum.map(fn {the_row, the_columns} ->
        all_columns = 0..columns_current

        full_empty_row =
          Enum.map(all_columns, fn x ->
            # x==cur_column
            if(x > TheConsts.c_board_hor()) do
              {x, 0}
            else
              m_xySvgCss = the_columns[x]
              svg_index = m_xySvgCss.svg_index
              {x, svg_index}
            end
          end)

        full_empty_row
        |> Map.new()
        |> then(fn a_row -> {the_row, a_row} end)
      end)
      |> Map.new()

    _the_colors
  end

  def getIcons(the_html_rows_svg_inds) do
    columns_current = TheConsts.c_max_hor() - 1

    _icons =
      the_html_rows_svg_inds
      |> Enum.map(fn {the_row, the_columns} ->
        all_columns = 0..columns_current

        full_empty_row =
          Enum.map(all_columns, fn x_column ->
            if(x_column > TheConsts.c_board_hor()) do
              # out of viewing bounds, ie 22x22wide board
              {x_column, 0}
            else
              m_xySvgCss = the_columns[x_column]
              css_jump = m_xySvgCss.css_jump
              svg_index = m_xySvgCss.svg_index

              case css_jump do
                "no-jump" ->
                  {x_column, 0}

                # 11+5=16            10+5=15
                "hor-jump" ->
                  {x_column, svg_index + 5}

                # 11+7=18     10+7=17 
                "ver-jump" ->
                  {x_column, svg_index + 7}
              end
            end
          end)

        full_empty_row
        |> Map.new()
        |> then(fn a_row -> {the_row, a_row} end)
      end)
      |> Map.new()
  end

  def getJumps(m_the_html_rows_svg_inds) do
    _jumps =
      m_the_html_rows_svg_inds
      |> Enum.map(fn {the_row, the_columns} ->
        the_columns
        |> Enum.map(fn {x_column, m_xySvgCss} ->
          css_jump = m_xySvgCss.css_jump
          {x_column, css_jump}
        end)
        |> Map.new()
        |> then(fn a_row -> {the_row, a_row} end)
      end)
      |> Map.new()

    _jumps
  end

  #################
  #################
  ###############
  #################
  #############
  def handle_call(
        {:send_board, html_pid_board, html_pid_tick, players_matrix},
        _from,
        old_socket
      ) do
    db_start_ms = CalcPing.db_start_ms()
    max_hv_size = TheConsts.c_max_hor()

    players_html_rows_svg_inds = ListToXy.makeAllRows(players_matrix, max_hv_size, max_hv_size)

    the_colors = GameBoard.board_colors(html_pid_board)
    html_user = old_socket.assigns.html_user
    _game_name = old_socket.assigns.game_name
    this_color = the_colors[html_user]

    opacity_jump_2 = Map.replace(TheConsts.c_init_opacity_0(), this_color - 1, 1)
    user_rgb = TheConsts.c_convert_color_id_to_rgb()[this_color - 1]

    da_colors = getColors(players_html_rows_svg_inds)

    html_rows_jump_inds = getIcons(players_html_rows_svg_inds)

    da_jumps = getJumps(players_html_rows_svg_inds)

    new_socket =
      assign(old_socket,
        html_rotate: TheGlobals.g_start_rotation(),
        html_tile_px: TheConsts.c_tile_pixels(),
        html_rows: TheConsts.c_tile_pixels(),
        html_w_px: TheConsts.c_board_hor_px(),
        html_h_px: TheConsts.c_board_ver_px(),
        rotate_w_px: TheConsts.c_board_hor_px() + 1,
        rotate_h_px: TheConsts.c_board_ver_px() + 1,
        html_scale: 1,
        html_offset: "0px",
        html_rows_svg_inds: da_colors,
        html_rows_jump_inds: html_rows_jump_inds,
        html_jump_classes: da_jumps,
        html_pid_board: html_pid_board,
        html_pid_tick: html_pid_tick,
        html_jump_opacity: opacity_jump_2,
        html_colors: user_rgb,
        html_current: "send-board"
      )

    CalcPing.db_end_ms(db_start_ms)


    my_var = old_socket.assigns.html_ping


    {:reply, my_var, new_socket}
  end

  def render(assigns) do
    if assigns.html_colors == nil do
      ~H"""
        <div>


          <.live_component module={JsOnload} id="js-onload"  />
          <.live_component module={JsPing} id="js-ping"  html_server_ms ={@html_server_ms} />

            <.live_component module={CssPlain} id="css-plain" />
            
          <.live_component module={CssVars} id="css-vars" html_rotate={@html_rotate}
              html_colors={@html_colors}    html_jump_opacity={@html_jump_opacity}
              html_tile_px={@html_tile_px} html_rows={@html_rows} 
              html_w_px={@html_w_px} html_h_px={@html_h_px}
                html_scale={@html_scale} html_offset_x={@html_offset_x} html_offset_y={@html_offset_y} />


         <.live_component module={CssCalc} id="css-calc"  html_rotate={@html_rotate}
              html_colors={@html_colors}    html_jump_opacity={@html_jump_opacity}
              html_tile_px={@html_tile_px} html_rows={@html_rows} 
              html_w_px={@html_w_px} html_h_px={@html_h_px} 
              
              rotate_w_px={@rotate_w_px} rotate_h_px={@rotate_h_px} />

          <.link href="#" phx-click="begin-game" phx-value-person-name= { @html_user } >Begin [[<%= @game_name %>]]</.link>
          ping=<%= @html_ping %> - 
      html_current == <%= @html_current %> - 
            html_mobile == <%= @html_mobile %> - 
        </div>
      """
    else
      ############ html_colors is blank???
      ~H"""
        <div id="user-html" style="width: 360px">
           
          <.live_component module={JsOnload} id="js-onload"  />
          <div id='live_user'>
                <.live_component module={JsPing} id="js-ping"  html_server_ms ={@html_server_ms} />

                <.live_component module={CssPlain} id="css-plain" />


                <.live_component module={CssVars} id="css-vars" html_rotate={@html_rotate}
                  html_colors={@html_colors}    html_jump_opacity={@html_jump_opacity}
                  html_tile_px={@html_tile_px} html_rows={@html_rows} 
                  html_w_px={@html_w_px} html_h_px={@html_h_px}
                                            html_scale={@html_scale} html_offset_x={@html_offset_x} html_offset_y={@html_offset_y} />



                <.live_component module={CssCalc} id="css-calc"  html_rotate={@html_rotate}
                      html_colors={@html_colors}    html_jump_opacity={@html_jump_opacity}
                      html_tile_px={@html_tile_px} html_rows={@html_rows} 
                      html_w_px={@html_w_px} html_h_px={@html_h_px}
                      rotate_w_px={@rotate_w_px} rotate_h_px={@rotate_h_px}/>
                    <.live_component module={HtmlBoard} id="html-board"  
                              html_rows_jump_inds={@html_rows_jump_inds} html_rows_svg_inds ={@html_rows_svg_inds} html_jump_classes={@html_jump_classes}/>
                      
          </div>
                <div id="nesw-spacer" >&nbsp;</div>
                      <.live_component module={HtmlNESW} id="n-e-s-w"  />
            <div>     <%= @html_user %> is playing <%= @game_name %> , ping=<%= @html_ping %>
            
            
            </div>

            

        </div>
      """
    end
  end

  # def send_waiting(pid_user, html_alive) do
  #   GenServer.cast(pid_user, {:send_waiting, html_alive})
  # end

  # @doc since: """

  #      """

  def handle_call(
        {:send_winner, html_pid_board, html_pid_tick, players_matrix, new_scale, scale_x_px,
         scale_y_px},
        _from,
        old_socket
      ) do
    
   adjust_finish_scale =  if(old_socket.assigns.html_mobile, do: 1, else: new_scale)
  

    db_start_ms = CalcPing.db_start_ms()
    max_hv_size = TheConsts.c_max_hor()

    players_html_rows_svg_inds = ListToXy.makeAllRows(players_matrix, max_hv_size, max_hv_size)

    the_colors = GameBoard.board_colors(html_pid_board)
    html_user = old_socket.assigns.html_user
    _game_name = old_socket.assigns.game_name
    this_color = the_colors[html_user]

    opacity_jump_2 = Map.replace(TheConsts.c_init_opacity_0(), this_color - 1, 1)
    user_rgb = TheConsts.c_convert_color_id_to_rgb()[this_color - 1]


    da_colors = getColors(players_html_rows_svg_inds)

    html_rows_jump_inds = getIcons(players_html_rows_svg_inds)

    da_jumps = getJumps(players_html_rows_svg_inds)

    new_socket =
      assign(old_socket,
        html_rotate: TheGlobals.g_start_rotation(),
        html_tile_px: TheConsts.c_tile_pixels(),
        html_rows: TheConsts.c_tile_pixels(),
        html_w_px: TheConsts.c_board_hor_px(),
        html_h_px: TheConsts.c_board_ver_px(),
        rotate_w_px: TheConsts.c_board_hor_px() + 1,
        rotate_h_px: TheConsts.c_board_ver_px() + 1,
        html_scale: adjust_finish_scale,
        html_offset_x: scale_x_px,
        html_offset_y: scale_y_px,
        html_rows_svg_inds: da_colors,
        html_rows_jump_inds: html_rows_jump_inds,
        html_jump_classes: da_jumps,
        html_pid_board: html_pid_board,
        html_pid_tick: html_pid_tick,
        html_jump_opacity: opacity_jump_2,
        html_colors: user_rgb,
        html_current: "send-board"
      )

    CalcPing.db_end_ms(db_start_ms)
        my_var = old_socket.assigns.html_ping
    {:reply, my_var, new_socket}
  end

  def end_game(pid_user) do
    GenServer.cast(pid_user, {:end_game})
  end

  def handle_cast({:end_game}, ended_socket) do
    {:noreply, push_navigate(ended_socket, to: "/brother-game2/b12")}
  end

  #########################
  #########################
  #########################
  #########################
  #########################
  #########################

  def color_index(pid_user, pid_board) do
    GenServer.call(
      pid_user,
      {:color_index, pid_board}
    )
  end

  def handle_call({:color_index, pid_board}, _from, old_socket) do
    the_colors = GameBoard.board_colors(pid_board)
    html_user = old_socket.assigns.html_user
    this_color = the_colors[html_user]
    {:reply, this_color, old_socket}
  end

  def send_countdown(pid_user, html_pid_board, html_pid_tick, players_matrix) do
    GenServer.call(
      pid_user,
      {:send_countdown, html_pid_board, html_pid_tick, players_matrix}
    )
  end

  def handle_call(
        {:send_countdown, html_pid_board, html_pid_tick, players_matrix},
        _from,
        old_socket
      ) do
    db_start_ms = CalcPing.db_start_ms()
    max_hv_size = TheConsts.c_max_hor()

    players_html_rows_svg_inds = ListToXy.makeAllRows(players_matrix, max_hv_size, max_hv_size)

    the_colors = GameBoard.board_colors(html_pid_board)
    html_user = old_socket.assigns.html_user

    _game_name = old_socket.assigns.game_name
    this_color = the_colors[html_user]

    opacity_jump_2 = Map.replace(TheConsts.c_init_opacity_0(), this_color - 1, 1)
    user_rgb = TheConsts.c_convert_color_id_to_rgb()[this_color - 1]

    da_colors = getColors(players_html_rows_svg_inds)

    html_rows_jump_inds = getIcons(players_html_rows_svg_inds)

    da_jumps = getJumps(players_html_rows_svg_inds)

    new_socket =
      assign(old_socket,
        html_rotate: TheGlobals.g_start_rotation(),
        html_tile_px: TheConsts.c_tile_pixels(),
        html_rows: TheConsts.c_tile_pixels(),
        html_w_px: TheConsts.c_board_hor_px(),
        html_h_px: TheConsts.c_board_ver_px(),
        rotate_w_px: TheConsts.c_board_hor_px() + 1,
        rotate_h_px: TheConsts.c_board_ver_px() + 1,
        html_scale: 1,
        html_offset: "0px",
        html_rows_svg_inds: da_colors,
        html_rows_jump_inds: html_rows_jump_inds,
        html_jump_classes: da_jumps,
        html_pid_board: html_pid_board,
        html_pid_tick: html_pid_tick,
        html_jump_opacity: opacity_jump_2,
        html_colors: user_rgb,
        html_current: "send-board"
      )

    CalcPing.db_end_ms(db_start_ms)
    
    my_var = old_socket.assigns.html_ping
    {:reply, my_var, new_socket}
  end
end
