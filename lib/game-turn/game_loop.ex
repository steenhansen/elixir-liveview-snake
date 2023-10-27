defmodule GameLoop do
  alias MultiGameWeb.UserViewLive

  def browser_countdown(pid_tick, tick_moment) do
    seq_humans = tick_moment.seq_humans
    pid_board = tick_moment.pid_board
    seq_countdown = tick_moment.seq_countdown
    seq_match_choices = tick_moment.seq_match_choices
    seq_game_sizes = tick_moment.seq_game_sizes

    for {%{pid_user: pid_user}, %{pid_snake: _pid_snake, person_name: _person_name}} <-
          seq_humans,
        into: [] do
      user_color = UserViewLive.color_index(pid_user, pid_board)
      x_offset = seq_game_sizes.size_count_x_off
      y_offset = seq_game_sizes.size_count_y_off

      players_matrix =
        Countdown321.make_countdown(pid_board, user_color, x_offset, y_offset, seq_countdown)

      UserViewLive.send_countdown(
        pid_user,
        pid_board,
        pid_tick,
        players_matrix,
        seq_match_choices,
        seq_game_sizes
      )
    end

    _started_moment = %GameSequences{
      tick_moment
      | seq_countdown: seq_countdown - 1
    }
  end

  ##############################
  def browser_message(pid_tick, tick_moment) do
    seq_step = tick_moment.seq_step
    seq_humans = tick_moment.seq_humans
    seq_robots = tick_moment.seq_robots

    players_alive = PlayingBoard.players_alive(tick_moment.pid_board)

    just_finished? = players_alive < TheConsts.c_two_players()

    if just_finished? && seq_step == "play_seq_1" do
      stopSeq_2(tick_moment, seq_humans, seq_robots)
    else
 
      _next_moment =
        cond do
          seq_step == "play_seq_1" -> playSeq_1(pid_tick, tick_moment, seq_humans, seq_robots)
          #           "stop_seq_2" 
          seq_step == "free_seq_3" -> freezeSeq_3(tick_moment)
          seq_step == "zoom_seq_4" -> zoomSeq_4(tick_moment)
          seq_step == "end_seq_5" -> endSeq_5(pid_tick, tick_moment)
        end
    end
  end

  def playSeq_1(pid_tick, tick_moment, seq_humans, seq_robots) do
    max_ping = gameCycle(pid_tick, tick_moment, seq_humans, seq_robots)

    _started_moment = %GameSequences{
      tick_moment
      | seq_max_ping: max_ping
    }
  end

  def gameCycle(pid_tick, tick_moment, seq_humans, seq_robots) do
    pid_board = tick_moment.pid_board
    seq_match_choices = tick_moment.seq_match_choices
    seq_game_sizes = tick_moment.seq_game_sizes
    seq_max_ping = tick_moment.seq_max_ping
    chosen_movement=seq_match_choices.chosen_movement

    for {_robot_number, pid_only_snake} <- seq_robots, into: [] do
      pid_snake = pid_only_snake.pid_snake
      RobotPlayer.jumpSnake(pid_snake, pid_board, chosen_movement)
    end

    for {%{pid_user: _pid_user}, %{pid_snake: pid_snake, person_name: _person_name}} <-
          seq_humans,
        into: [] do
      HumanPlayer.jumpSnake(pid_snake, pid_board)
    end

    players_matrix = PlayingBoard.snake_matrix(pid_board)

    max_pings =
      for {%{pid_user: pid_user}, %{pid_snake: pid_snake, person_name: _person_name}} <-
            seq_humans,
          into: [] do
        is_snake_dead = HumanPlayer.snakeDead(pid_snake)

        UserViewLive.send_board(
          pid_user,
          pid_board,
          pid_tick,
          players_matrix,
          seq_match_choices,
          seq_game_sizes,
          seq_max_ping,
          is_snake_dead
        )
      end

    _max_ping = Enum.max(max_pings)
  end

  def showStartPositions(tick_moment, seq_humans, seq_robots) do
    pid_board = tick_moment.pid_board
    seq_match_choices = tick_moment.seq_match_choices
        chosen_movement=seq_match_choices.chosen_movement

    for {_robot_number, pid_only_snake} <- seq_robots, into: [] do
      pid_snake = pid_only_snake.pid_snake

      RobotPlayer.jumpSnake(pid_snake, pid_board, chosen_movement)
    end

    for {%{pid_user: _pid_user}, %{pid_snake: pid_snake, person_name: _person_name}} <-
          seq_humans,
        into: [] do
      HumanPlayer.jumpSnake(pid_snake, pid_board)
    end

    PlayingBoard.snake_matrix(pid_board)
  end

  def adjustCenter(winner_front) do
    {x_front, y_front} = winner_front
    x_adjust = (x_front - 36) / 80
    y_adjust = (y_front - 36) / 80
    adjust_x = x_front + x_adjust
    adjust_y = y_front + y_adjust
    {adjust_x, adjust_y}
  end

  def stopSeq_2(tick_moment, seq_humans, seq_robots) do
    human_front_winner = humanWinCoord(seq_humans)
    robot_front_winner = robotWinCoord(seq_robots)
    empty_square = PlayingBoard.free_square(tick_moment.pid_board)
    human_win = human_front_winner != nil
    robot_win = robot_front_winner != nil

    _the_winner =
      cond do
        human_win ->
          [winner_front, winner_name] = human_front_winner

          _user_tick = %GameSequences{
            tick_moment
            | seq_winner_front: winner_front,
              seq_winner_name: winner_name,
              seq_step: "free_seq_3",
              seq_winner_countdown: TheConsts.c_winner_wait(),
              seq_freeze_countdown: TheConsts.c_freeze_wait()
          }

        robot_win ->
          [winner_front, winner_name] = robot_front_winner

          _user_tick = %GameSequences{
            tick_moment
            | seq_winner_front: winner_front,
              seq_winner_name: winner_name,
              seq_step: "free_seq_3",
              seq_winner_countdown: TheConsts.c_winner_wait(),
              seq_freeze_countdown: TheConsts.c_freeze_wait()
          }

        true ->

          _user_tick = %GameSequences{
            tick_moment
            | seq_winner_front: empty_square,
              seq_step: "free_seq_3"
          }
      end
  end

  def freezeSeq_3(tick_moment) do
    countdown = tick_moment.seq_freeze_countdown - 1
    if countdown == 0 do
      _do_zoom_in = %GameSequences{
        tick_moment
        | seq_winner_countdown: TheConsts.c_winner_wait(),
          seq_step: "zoom_seq_4"
      }
    else
      _do_zoom_in = %GameSequences{
        tick_moment
        | seq_freeze_countdown: countdown,
          seq_step: "free_seq_3"
      }
    end
  end

  def zoomSeq_4(tick_moment) do
    countdown = tick_moment.seq_winner_countdown - 1
    if countdown == 0 do
      _do_zoom_in = %GameSequences{
        tick_moment
        | seq_step: "end_seq_5"
      }
    else
      _do_zoom_in = %GameSequences{
        tick_moment
        | seq_winner_countdown: countdown,
          seq_step: "zoom_seq_4"
      }
    end
  end

  def endSeq_5(pid_tick, tick_moment) do
    pid_board = tick_moment.pid_board
    seq_humans = tick_moment.seq_humans
    seq_game_sizes = tick_moment.seq_game_sizes
    old_scale = tick_moment.seq_scale
    {winner_x, winner_y} = tick_moment.seq_winner_front
    winner_name = tick_moment.seq_winner_name
    winner_center = {winner_x + 0.5, winner_y + 0.5}
    [new_scale, scale_x_px, scale_y_px] = endScale(old_scale, winner_center)
    players_matrix = PlayingBoard.snake_matrix(pid_board)

    for {%{pid_user: pid_user}, %{pid_snake: _pid_snake, person_name: _person_name}} <-
          seq_humans,
        into: [] do
      if old_scale > TheConsts.c_scaling_steps() do
        UserViewLive.end_game(pid_user)
      else
        UserViewLive.send_winner(
          pid_user,
          pid_board,
          pid_tick,
          players_matrix,
          new_scale,
          scale_x_px,
          scale_y_px,
          seq_game_sizes,
          winner_name
        )
      end
    end

    _winner_tick = %GameSequences{
      tick_moment
      | seq_scale: new_scale
    }
  end

  def humanWinCoord(seq_humans) do
    xy_name_list =
      for {%{pid_user: _pid_user}, %{pid_snake: pid_snake, person_name: _person_name}} <-
            seq_humans,
          HumanPlayer.winnerHead(pid_snake),
          into: [] do
        snake_front_and_name = HumanPlayer.winnerHead(pid_snake)

        if snake_front_and_name do
          snake_front_and_name
        end
      end

    winner_xy_name = Enum.at(xy_name_list, 0)
    winner_xy_name
  end


  def robotWinCoord(seq_robots) do
    xy_name_list =
      for {_robot_index, %{pid_snake: pid_snake}} <-
            seq_robots,
          RobotPlayer.winnerHead(pid_snake),
          into: [] do
        snake_front_and_name = RobotPlayer.winnerHead(pid_snake)

        if snake_front_and_name do
          snake_front_and_name
        end
      end
    winner_xy_name = Enum.at(xy_name_list, 0)
    winner_xy_name
  end


  def float2Px(scale_offset) do
    _scaled_px = "-" <> Integer.to_string(round(scale_offset)) <> "px"
  end

  def endScale(prev_scale, seq_winner_front) do
    {coord_x, coord_y} = seq_winner_front

    offset_x_size = coord_x * TheConsts.c_tile_pixels()
    offset_y_size = coord_y * TheConsts.c_tile_pixels()

    scale_offset_x = offset_x_size * prev_scale
    scale_x_px = float2Px(scale_offset_x)
    scale_offset_y = offset_y_size * prev_scale
    scale_y_px = float2Px(scale_offset_y)

    if prev_scale > TheConsts.c_scaling_steps() do
      [prev_scale, scale_x_px, scale_y_px]
    else
      [prev_scale + 1, scale_x_px, scale_y_px]
    end
  end
end
