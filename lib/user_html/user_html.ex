defmodule MultiGameWeb.UserHtml do
  use MultiGameWeb, :live_view

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
       # "brother-game2",
       game_name: prev_socket.assigns.game_name,
       live_user: new_live_user
     )}
  end

  def handle_cast({:end_game}, ended_socket) do
    user_name = ended_socket.assigns.live_user.user_name
    game_name = ended_socket.assigns.game_name
    game_winner = ended_socket.assigns.game_winner
    dbg(game_winner)

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
    # dbg(winner_name)
    html_data =
      GameSteps.stepWinner(
        pid_board,
        data_pid_tick,
        players_matrix,
        new_scale,
        scale_x_px,
        scale_y_px,
        seq_game_sizes,
        old_socket
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
        seq_max_ping
      ) do
    GenServer.call(
      pid_user,
      {:send_board, pid_board, data_pid_tick, players_matrix, seq_match_choices, seq_game_sizes,
       seq_max_ping}
    )
  end

  # @doc since: """

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

  @doc since: """
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

    {:noreply,
     assign(socket,
       data_pid_tick: data_pid_tick,
       live_user: new_live_user
     )}
  end

  def handle_call({:color_index, pid_board}, _from, old_socket) do
    the_colors = GameBoard.board_colors(pid_board)
    user_name = old_socket.assigns.live_user.user_name
    this_color = the_colors[user_name]
    {:reply, this_color, old_socket}
  end

  def handle_call(
        {:send_board, pid_board, data_pid_tick, players_matrix, seq_match_choices, seq_game_sizes,
         seq_max_ping},
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
        seq_max_ping,
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

  def mount(params, _session, old_socket) do
    Process.send_after(self(), {:step_1_collect_players}, 1000)

    {game_name, live_user, optional_selections, seq_match_choices, html_data} =
      GameSteps.stepMount(params, self())

    new_socket =
      assign(old_socket,
        game_name: game_name,
        seq_max_ping: 17,
        live_user: live_user,
        optional_selections: optional_selections,
        seq_match_choices: seq_match_choices,
        html_data: html_data
      )

    {:ok, new_socket}
  end
end
