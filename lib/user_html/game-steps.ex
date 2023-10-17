defmodule GameSteps do
  def stepMount(params, pid_user) do
    user_names = params["path"]
    [game_name | [user_name | _]] = user_names
    CollectParticipants.add_participant(game_name, user_name, pid_user)
    user_tab = user_name <> " : " <> game_name

    live_user = MountEmpty.emptyUser(user_tab, user_name)
    optional_selections = MountEmpty.emptyOptional()
    seq_match_choices = MountEmpty.emptyChosens()
    html_data = MountEmpty.emptyData()

    {game_name, live_user, optional_selections, seq_match_choices, html_data}
  end

  def stepStart(phx_value_person_name, prev_socket) do
    seq_match_choices = prev_socket.assigns.seq_match_choices
    {seq_game_sizes, start_locations} = ConfigureGame.configure_game(seq_match_choices)

    %{"person-name" => _starter_person} = phx_value_person_name
    game_name = prev_socket.assigns.game_name

    {:ok, data_pid_tick} =
      TickMoment.start_link({game_name, seq_match_choices, seq_game_sizes, start_locations})

    TickMoment.begin_game(data_pid_tick)

    old_live_user = prev_socket.assigns.live_user

    new_live_user = %LiveUser{
      old_live_user
      | user_step: "step_2_load_html",
        user_show_grid: false
    }

    {data_pid_tick, new_live_user}
  end

  def stepCount(
        pid_board,
        data_pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes,
        prev_socket
      ) do
    _db_start_ms = CalcPing.db_start_ms()
    rotation_speed = seq_match_choices.chosen_rotate
    user_name = prev_socket.assigns.live_user.user_name

    html_data =
      MiscRoutines.drawBoard(
        {user_name, pid_board, data_pid_tick, players_matrix, 1, "0px", "0px", rotation_speed,
         seq_game_sizes}
      )

    old_live_user = prev_socket.assigns.live_user

    new_live_user = %LiveUser{
      old_live_user
      | user_step: "step_3_count_down",
        user_show_grid: true
    }

    {new_live_user, html_data}
  end

  def stepPlay(
        pid_board,
        data_pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes,
        seq_max_ping,
        prev_socket
      ) do
    old_max = prev_socket.assigns.seq_max_ping

    new_max = if(seq_max_ping > old_max, do: seq_max_ping, else: old_max)

    db_start_ms = CalcPing.db_start_ms()
    user_name = prev_socket.assigns.live_user.user_name
    rotation_speed = seq_match_choices.chosen_rotate

    html_data =
      MiscRoutines.drawBoard(
        {user_name, pid_board, data_pid_tick, players_matrix, 1, "0px", "0px", rotation_speed,
         seq_game_sizes}
      )

    old_live_user = prev_socket.assigns.live_user
    new_live_user = %LiveUser{old_live_user | user_step: "step_4_play_game"}
    cur_ping_time = CalcPing.db_end_ms(db_start_ms)
    {new_max, new_live_user, html_data, cur_ping_time}
  end

  def stepWinner(
        pid_board,
        data_pid_tick,
        players_matrix,
        new_scale,
        scale_x_px,
        scale_y_px,
        seq_game_sizes,
        prev_socket
      ) do
    rotation_speed = 0
    user_name = prev_socket.assigns.live_user.user_name

    MiscRoutines.drawBoard(
      {user_name, pid_board, data_pid_tick, players_matrix, new_scale, scale_x_px, scale_y_px,
       rotation_speed, seq_game_sizes}
    )
  end

  def changeDirection(to_direction, socket) do
    data_pid_tick = socket.assigns.data_pid_tick
    starter_person = socket.assigns.live_user.user_name
    TickMoment.snake_change_dir(data_pid_tick, starter_person, to_direction)
  end

  def snakeJump(socket) do
    data_pid_tick = socket.assigns.data_pid_tick
    starter_person = socket.assigns.live_user.user_name
    TickMoment.jump_over(data_pid_tick, starter_person)
  end

  def collectPlayers(prev_socket) do
    utc_now = DateTime.utc_now()
    current_ms = CalcPing.ping_current_ms(utc_now)
    game_name = prev_socket.assigns.game_name
    current_players = CollectParticipants.get_participants(game_name)
    current_players = Enum.map(current_players, fn {person_name, _pid} -> person_name end)
    old_live_user = prev_socket.assigns.live_user

    %LiveUser{
      old_live_user
      | user_time_start: current_ms,
        user_team: current_players
    }
  end

  def isMobilePing(string_ping_ms, is_mobile, prev_socket) do
    {start_ping_ms, ""} = Integer.parse(string_ping_ms)
    utc_now = DateTime.utc_now()
    new_ping_ms = CalcPing.calc_ping(start_ping_ms, utc_now)

    old_live_user = prev_socket.assigns.live_user
    %LiveUser{old_live_user | user_ping: new_ping_ms, user_is_mobile: is_mobile}
  end
end
