defmodule GameSteps do
  def stepMount(params, pid_user) do
    user_names = params["path"]
    optional_selections = %OptionalSelections{}
    seq_match_choices = %MatchChosens{}
    html_data = %HtmlData{}

    if length(user_names) == 1 do
      [game_name | _] = user_names

      live_user = %LiveUser{
        user_tab: "no-name-tab",
        user_name: "no-name_user",
        user_nameless: true
      }

      {game_name, live_user, optional_selections, seq_match_choices, html_data}
    else
      [game_name | [user_name | _]] = user_names
      CollectParticipants.add_participant(game_name, user_name, pid_user)
      user_tab = user_name <> " : " <> game_name

      live_user = %LiveUser{
        user_tab: user_tab,
        user_name: user_name
      }

      {game_name, live_user, optional_selections, seq_match_choices, html_data}
    end
  end

  def stepStart(phx_value_person_name, prev_socket) do
    seq_match_choices = prev_socket.assigns.seq_match_choices
    {seq_game_sizes, start_locations} = ConfigureGame.configure_game(seq_match_choices)

    %{"person-name" => _starter_person} = phx_value_person_name
    game_name = prev_socket.assigns.game_name

    participants_live = CollectParticipants.get_participants(game_name)

    number_users = Enum.count(participants_live)

    if number_users > 0 do
      CollectParticipants.clear_participants(game_name)

      {:ok, data_pid_tick} =
        TickMoment.start_link(
          {game_name, seq_match_choices, seq_game_sizes, start_locations, participants_live}
        )

      TickMoment.begin_game(data_pid_tick)

      old_live_user = prev_socket.assigns.live_user

      new_live_user = %LiveUser{
        old_live_user
        | user_step: "step_2_load_html",
          user_show_grid: false
      }

      {data_pid_tick, new_live_user}
    else
      {"already-started", prev_socket}
    end
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
    user_pid = self()
    is_snake_dead = false
    is_freezing = false
    chosen_control_offset = seq_match_choices.chosen_control_offset
    chosen_top_control_offset = seq_match_choices.chosen_top_control_offset
    old_live_user = prev_socket.assigns.live_user

    html_data =
      MiscRoutines.drawBoard(
        {user_pid, pid_board, data_pid_tick, players_matrix, 1, "0px", "0px", rotation_speed,
         seq_game_sizes, is_snake_dead, is_freezing, chosen_control_offset,
         chosen_top_control_offset}
      )

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
        is_snake_dead,
        prev_socket
      ) do
    old_max = prev_socket.assigns.seq_max_ping

    new_max = if(seq_max_ping > old_max, do: seq_max_ping, else: old_max)

    db_start_ms = CalcPing.db_start_ms()
    user_pid = self()
    rotation_speed = seq_match_choices.chosen_rotate
    is_freezing = false
    old_live_user = prev_socket.assigns.live_user
    chosen_control_offset = seq_match_choices.chosen_control_offset
    chosen_top_control_offset = seq_match_choices.chosen_top_control_offset

    html_data =
      MiscRoutines.drawBoard(
        {user_pid, pid_board, data_pid_tick, players_matrix, 1, "0px", "0px", rotation_speed,
         seq_game_sizes, is_snake_dead, is_freezing, chosen_control_offset,
         chosen_top_control_offset}
      )

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
        seq_game_sizes
      ) do
    rotation_speed = 0
    user_pid = self()
    is_snake_dead = false
    is_freezing = true
    chosen_control_offset = -1
    chosen_top_control_offset = -1

    MiscRoutines.drawBoard(
      {user_pid, pid_board, data_pid_tick, players_matrix, new_scale, scale_x_px, scale_y_px,
       rotation_speed, seq_game_sizes, is_snake_dead, is_freezing, chosen_control_offset,
       chosen_top_control_offset}
    )
  end

  def changeDirection(to_direction, socket) do
    data_pid_tick = socket.assigns.html_data.data_pid_tick
    pid_user = socket.root_pid
    TickMoment.snake_change_dir(data_pid_tick, pid_user, to_direction)
  end

  def snakeJump(socket) do
    data_pid_tick = socket.assigns.html_data.data_pid_tick
    pid_user = socket.root_pid

    TickMoment.jump_over(data_pid_tick, pid_user)
  end

  def collectPlayers(prev_socket) do
    utc_now = DateTime.utc_now()
    current_ms = CalcPing.ping_current_ms(utc_now)
    game_name = prev_socket.assigns.game_name
    current_players = CollectParticipants.get_participants(game_name)
    current_players = Enum.map(current_players, fn {_pid_user, person_name} -> person_name end)
    old_live_user = prev_socket.assigns.live_user
    amount_robots = MiscRoutines.get_maxRobots(game_name)

    %LiveUser{
      old_live_user
      | user_time_start: current_ms,
        user_team: current_players,
        user_max_robots: amount_robots
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
