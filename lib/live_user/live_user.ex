defmodule MultiGameWeb.LiveUser do
  use MultiGameWeb, :live_view

  def handle_event("begin-game", phx_value_person, socket) do
    %{"person" => starter_person} = phx_value_person
    {:ok, pid_tick} = TickMoment.start_link(starter_person)
    TickMoment.begin_game(pid_tick)
    ## tid_tick
    {:noreply, assign(socket, pid_tick: pid_tick)}
  end

  def handle_event("key-north", _dir, socket) do
    starter_person = socket.assigns.the_name
    TickMoment.snake_change_dir(socket.assigns.pid_tick, starter_person, "up")
    {:noreply, socket}
  end

  def handle_event("key-east", _dir, socket) do
    starter_person = socket.assigns.the_name
    TickMoment.snake_change_dir(socket.assigns.pid_tick, starter_person, "right")

    {:noreply, socket}
  end

  def handle_event("key-south", _dir, socket) do
    starter_person = socket.assigns.the_name
    TickMoment.snake_change_dir(socket.assigns.pid_tick, starter_person, "down")

    {:noreply, socket}
  end
  
  def handle_event("key-west", _dir, socket) do
    starter_person = socket.assigns.the_name
    TickMoment.snake_change_dir(socket.assigns.pid_tick, starter_person, "left")
    {:noreply, socket}
  end

  def handle_event("update-ping", %{"ping_server_ms" => string_ping_ms}, socket) do
    {start_ping_ms, ""} = Integer.parse(string_ping_ms)
    new_ping_ms = JsPing.calc_ping(start_ping_ms, DateTime.utc_now())
    _max_old_ping_ms = socket.assigns.current_ping_ms
    {:noreply, assign(socket, current_ping_ms: new_ping_ms)}
  end

  def handle_info({:find_ping_time}, socket) do
    Process.send_after(self(), {:find_ping_time}, 1000)
    current_ms = JsPing.ping_current_ms(DateTime.utc_now())

    {:noreply,
     assign(
       socket,
       server_time_ms: current_ms
     )}
  end

  def mount(params, _session, socket) do
    Process.send_after(self(), {:find_ping_time}, 1000)
    user_names = params["path"]
    [game_moniker | [ the_name | _ ]] = user_names
    live_id = self()
    CollectParticipants.add_participant(game_moniker, the_name, live_id)
    the_title = the_name <> " : " <> game_moniker
    the_assign3 =
      assign(socket,
        live_rotate: 0,
        page_title: the_title,
        game_moniker: game_moniker,
        the_name: the_name,
         tile_size: TheConsts.c_tile_pixels(),
         row_height: TheConsts.c_tile_pixels(),
         width_px: TheConsts.c_board_hor_px(),
         height_px: TheConsts.c_board_ver_px(),
        current_ping_ms: 0,
        server_time_ms: -4321,
        jump_svg: TheConsts.init_opacity_0(),
        the_player_colors: nil
      )
    {:ok, the_assign3}
  end

  def send_board(pid_live, pid_board, pid_tick, players_matrix, x_range, y_range) do
    GenServer.call(pid_live, {:send_board, pid_board, pid_tick, players_matrix, x_range, y_range})
  end

  @doc since: """


        

       """
  def handle_call(
        {:send_board, pid_board, pid_tick, players_matrix, x_range, y_range},
        _from,
        old_socket
      ) do
    db_start_ms = JsPing.db_start_ms()
    players_vv = ListToXy.makeAllRows(players_matrix, x_range, y_range)

    my_var = old_socket.assigns.current_ping_ms

    the_colors = GameBoard.player_colors(pid_board)
    the_name = old_socket.assigns.the_name
    game_moniker = old_socket.assigns.game_moniker
    this_color = the_colors[the_name]

    opacity_jump_2 = Map.replace(TheConsts.init_opacity_0(), this_color - 1, 1)
    user_rgb = TheConsts.convert_color_id_to_rgb()[this_color - 1]

    new_socket =
      assign(old_socket,
        # 60,
        live_rotate: TheConsts.c_start_rotation(),
        tile_size: TheConsts.c_tile_pixels(),
        row_height: TheConsts.c_tile_pixels(),
        width_px: TheConsts.c_board_hor_px(),
        height_px: TheConsts.c_board_ver_px(),
        vv: players_vv,
        pid_board: pid_board,
        pid_tick: pid_tick,
        jump_svg: opacity_jump_2,
        the_player_colors: user_rgb
      )

    JsPing.db_end_ms(db_start_ms)
    {:reply, my_var, new_socket}
  end

  # @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    if assigns.the_player_colors == nil do
      ~H"""
        <div>
          <.live_component module={OnLoad} id="on-load"  />
          <.live_component module={JsPing} id="js-ping"  server_time_ms ={@server_time_ms} />
          <.live_component module={CssVars} id="css-vars" live_rotate={@live_rotate}
              the_player_colors={@the_player_colors}    jump_svg={@jump_svg}
              tile_size={@tile_size} row_height={@row_height} 
              width_px={@width_px} height_px={@height_px}/>
          <.link href="#" phx-click="begin-game" phx-value-person= { @the_name } >Begin <%= @game_moniker %></.link>
          <br />current_ping_ms == <%= @current_ping_ms %>
        </div>
      """
    else
      ~H"""
        <div>
          <.live_component module={OnLoad} id="on-load"  />
          <div id='live_user'>
            <.live_component module={JsPing} id="js-ping"  server_time_ms ={@server_time_ms} />
            <.live_component module={CssVars} id="css-vars" live_rotate={@live_rotate}
              the_player_colors={@the_player_colors}    jump_svg={@jump_svg}
              tile_size={@tile_size} row_height={@row_height} 
              width_px={@width_px} height_px={@height_px}/>
            <br /> "<%= @the_name %>" is playing "<%= @game_moniker %>""
   
            <br />current_ping_ms == <%= @current_ping_ms %>
            <.live_component module={RotateBoard} id="rotate-board" vv ={@vv}/>
            <div style="height:400px">&nbsp;</div>
             <.live_component module={NESW} id="n-e-s-w"  />
          </div>
        </div>
      """
    end
  end


end
