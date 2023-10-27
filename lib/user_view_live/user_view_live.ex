defmodule MultiGameWeb.UserViewLive do
  use MultiGameWeb, :live_view

#   defmodule A do
#     def my_inspect(error_term, err_message) do
#       IO.puts(IO.ANSI.format([:yellow_background, :black, inspect(err_message)]))
#       dbg(error_term, limit: :infinity)
#     end
#   end

#   def terminate(reason, _state) do
#     {quit_error, quit_location} = reason

#     if quit_error != :shutdown do
#       A.my_inspect(__MODULE__, "ERROR")
#       A.my_inspect(quit_location, "LOCATION")
#       {e_reason, e_error, current_data} = quit_error
#       A.my_inspect(e_reason, e_error)
#        current_data = slimifyLive(current_data)
#       A.my_inspect(current_data, "slimmed-socket-data")
#     end
#   end

# def slimifyLive(current_data) do
#    # from https://dev.to/noelworden/so-many-ways-to-update-a-map-with-elixir-1aie
#       cur_html_data = current_data.html_data
#       cur_html_data = %{cur_html_data | data_rows_jump_inds: %{0 => %{0 => 0}}}
#       cur_html_data = %{cur_html_data | data_jump_classes: %{0 => %{0 => "no-jump"}}}
#       cur_html_data = %{cur_html_data | data_rows_svg_inds: %{0 => %{0 => 0}}}
#       %{current_data | html_data: cur_html_data}

# end


  def render(assigns) do
    RenderBoard.render(assigns)
  end

  def end_game(pid_user) do
    GenServer.cast(pid_user, {:end_game})
  end

  def color_index(pid_user, pid_board) do
    GenServer.call(
      pid_user,
      {:color_index, pid_board}
    )
  end

  def handle_info({:step_1_collect_players}, prev_socket) do
    Process.send_after(self(), {:step_1_collect_players}, 1000)
    new_live_user = GameSteps.collectPlayers(prev_socket)

    {:noreply,
     assign(
       prev_socket,
       game_name: prev_socket.assigns.game_name,
       live_user: new_live_user
     )}
  end

  def handle_cast({:end_game}, ended_socket) do
    user_name = ended_socket.assigns.live_user.user_name
    game_name = ended_socket.assigns.game_name
    game_winner = ended_socket.assigns.game_winner

    if game_winner == user_name do
      game_count = "/" <> game_name <> "/" <> user_name <> "#Winner"
      {:noreply, push_navigate(ended_socket, to: game_count)}
    else
      game_count = "/" <> game_name <> "/" <> user_name <> "#Loser"
      {:noreply, push_navigate(ended_socket, to: game_count)}
    end
  end

  def handle_cast(
        {:send_countdown, pid_board, data_pid_tick, players_matrix, seq_match_choices,
         seq_game_sizes},
        prev_socket
      ) do
    {new_live_user, html_data} =
      GameSteps.stepCount(
        pid_board,
        data_pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes,
        prev_socket
      )

    new_socket =
      assign(prev_socket,
        live_user: new_live_user,
        html_data: html_data
      )

    {:noreply, new_socket}
  end

  def handle_cast(
        {:send_winner, pid_board, data_pid_tick, players_matrix, new_scale, scale_x_px,
         scale_y_px, seq_game_sizes, winner_name},
        old_socket
      ) do
    html_data =
      GameSteps.stepWinner(
        pid_board,
        data_pid_tick,
        players_matrix,
        new_scale,
        scale_x_px,
        scale_y_px,
        seq_game_sizes
      )

    new_socket =
      assign(old_socket,
        html_data: html_data,
        game_winner: winner_name
      )

    {:noreply, new_socket}
  end

  def send_winner(
        pid_user,
        pid_board,
        data_pid_tick,
        players_matrix,
        new_scale,
        scale_x_px,
        scale_y_px,
        seq_game_sizes,
        winner_name
      ) do
    GenServer.cast(
      pid_user,
      {:send_winner, pid_board, data_pid_tick, players_matrix, new_scale, scale_x_px, scale_y_px,
       seq_game_sizes, winner_name}
    )
  end

  def send_board(
        pid_user,
        pid_board,
        data_pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes,
        seq_max_ping, is_snake_dead
      ) do
    xxx =
      GenServer.call(
        pid_user,
        {:send_board, pid_board, data_pid_tick, players_matrix, seq_match_choices, seq_game_sizes,
         seq_max_ping, is_snake_dead}
      )

    xxx
  end

  # @doc  """

  #      """

  def send_countdown(
        pid_user,
        pid_board,
        data_pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes
      ) do
    GenServer.cast(
      pid_user,
      {:send_countdown, pid_board, data_pid_tick, players_matrix, seq_match_choices,
       seq_game_sizes}
    )
  end

  def handle_event(
        "update-ping",
        %{
          "ping_server_ms" => string_ping_ms,
          "is_mobile" => is_mobile
          #          "game_name" => game_name,
          #          "user_name" => user_name
        },
        prev_socket
      ) do
    new_live_user = GameSteps.isMobilePing(string_ping_ms, is_mobile, prev_socket)


    {:noreply,
     assign(prev_socket,
       live_user: new_live_user
     )}
  end

  @doc  """
       """

  def handle_event("key-north", _dir, socket) do
    GameSteps.changeDirection("up", socket)
    {:noreply, socket}
  end

  def handle_event("key-east", _dir, socket) do
    GameSteps.changeDirection("right", socket)
    {:noreply, socket}
  end

  def handle_event("key-south", _dir, socket) do
    GameSteps.changeDirection("down", socket)
    {:noreply, socket}
  end

  def handle_event("key-west", _diXXr, socket) do
    GameSteps.changeDirection("left", socket)
    {:noreply, socket}
  end

  def handle_event("key-jump", _key, socket) do
    GameSteps.snakeJump(socket)
    {:noreply, socket}
  end

  def handle_event("validate", phx_validate, socket) do
    {seq_match_choices, optional_selections} = FormSelections.userChoices(phx_validate)

    next_socket =
      assign(socket,
        seq_match_choices: seq_match_choices,
        optional_selections: optional_selections
      )

    {:noreply, next_socket}
  end

  def handle_event("start-game", phx_value_person_name, socket) do
    {data_pid_tick, new_live_user} = GameSteps.stepStart(phx_value_person_name, socket)

    if data_pid_tick == "already-started" do
      {:noreply, socket}
    else
      {:noreply,
       assign(socket,
         data_pid_tick: data_pid_tick,
         live_user: new_live_user
       )}
    end
  end




  def mount(params, _session, old_socket) do
    Process.send_after(self(), {:step_1_collect_players}, 1000)
    {game_name, live_user, optional_selections, seq_match_choices, html_data} =
      GameSteps.stepMount(params, self())

 #   user_names = params["path"]
   # [game_name | [_user_name | _]] = user_names

 amount_robots =  MiscRoutines.get_maxRobots(game_name)

     

    if amount_robots == 0 do
      new_socket =
        assign(old_socket,
          game_name: game_name,
          seq_max_ping: 17,
          live_user: live_user,
          optional_selections: %{optional_selections | select_computers: "computers-0"},
          seq_match_choices: %{seq_match_choices | chosen_computers: 0},
          html_data: html_data
        )


      {:ok, new_socket}
    else
      new_socket =
        assign(old_socket,
          game_name: game_name,
          seq_max_ping: 17,
          live_user: live_user,
          optional_selections: %{optional_selections | select_computers: "computers-1"},
          seq_match_choices: %{seq_match_choices | chosen_computers: 1},
          html_data: html_data
        )

      {:ok, new_socket}
    end
  end


  def handle_call({:color_index, pid_board}, _from, old_socket) do
    the_colors = PlayingBoard.boardColors(pid_board)
    pid_user = self()
    this_color = the_colors[pid_user]
    {:reply, this_color, old_socket}
  end

  def handle_call(
        {:send_board, pid_board, data_pid_tick, players_matrix, seq_match_choices, seq_game_sizes,
         seq_max_ping, is_snake_dead},
        _from,
        old_socket
      ) do
    {new_max, new_live_user, html_data, cur_ping_time} =
      GameSteps.stepPlay(
        pid_board,
        data_pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes,
        seq_max_ping, is_snake_dead,
        old_socket
      )


    new_socket =
      assign(old_socket,
        seq_max_ping: new_max,
        live_user: new_live_user,
        html_data: html_data
      )
    

    {:reply, cur_ping_time, new_socket}
  end


end
