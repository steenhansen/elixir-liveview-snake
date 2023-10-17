defmodule GameLoop do
  alias MultiGameWeb.UserHtml

  def browser_countdown(pid_tick, tick_moment) do
    seq_humans = tick_moment.seq_humans
    _seq_robots = tick_moment.seq_robots
    pid_board = tick_moment.pid_board
    seq_countdown = tick_moment.seq_countdown
    seq_match_choices = tick_moment.seq_match_choices
    seq_game_sizes = tick_moment.seq_game_sizes

      for {_person_name, pid_user_and_pid_snake} <- seq_humans, into: [] do
        pid_user = pid_user_and_pid_snake.pid_user
        user_color = UserHtml.color_index(pid_user, pid_board)

        # 26x26   x=8           44 x=17
        x_offset = 0
        # 26x26   y=2           44 y=15
        y_offset = 1

        players_matrix =
          Countdown321.make_countdown(pid_board, user_color, x_offset, y_offset, seq_countdown)

        UserHtml.send_countdown(
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
      |  seq_countdown: seq_countdown - 1
    }
  end

  ##############################
  def browser_message(pid_tick, tick_moment) do
    seq_humans = tick_moment.seq_humans
    seq_robots = tick_moment.seq_robots

    players_alive = GameBoard.players_alive(tick_moment.pid_board)

    just_finished? = players_alive < TheConsts.c_two_players()

    _next_moment =
      cond do
        tick_moment.seq_finished -> endZoomIn(pid_tick, tick_moment)
        just_finished? -> endPrepare(tick_moment, seq_humans, seq_robots)
        true -> playingGame(pid_tick, tick_moment, seq_humans, seq_robots)
      end
  end

  def playingGame(pid_tick, tick_moment, seq_humans, seq_robots) do
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
    seq_max_ping  = tick_moment.seq_max_ping
    for {_robot_number, pid_only_snake} <- seq_robots, into: [] do
      pid_snake = pid_only_snake.pid_snake
      RobotPlayer.jumpSnake(pid_snake, pid_board)
    end

    for {_person_name, pid_user_and_pid_snake} <- seq_humans, into: [] do
      pid_snake = pid_user_and_pid_snake.pid_snake
      HumanPlayer.jumpSnake(pid_snake, pid_board)
    end

    players_matrix = GameBoard.snake_matrix(pid_board)

    max_pings =
      for {_person_name, pid_user_and_pid_snake} <- seq_humans, into: [] do
        pid_user = pid_user_and_pid_snake.pid_user

        UserHtml.send_board(
          pid_user,
          pid_board,
          pid_tick,
          players_matrix,
          seq_match_choices,
          seq_game_sizes, seq_max_ping
        )
      end

    _max_ping = Enum.max(max_pings)
  end

  def showStartPositions(tick_moment, seq_humans, seq_robots) do
    pid_board = tick_moment.pid_board

    for {_robot_number, pid_only_snake} <- seq_robots, into: [] do
      pid_snake = pid_only_snake.pid_snake
      RobotPlayer.jumpSnake(pid_snake, pid_board)
    end

    for {_person_name, pid_user_and_pid_snake} <- seq_humans, into: [] do
      pid_snake = pid_user_and_pid_snake.pid_snake
      HumanPlayer.jumpSnake(pid_snake, pid_board)
    end

    GameBoard.snake_matrix(pid_board)
  end

  def adjustCenter(winner_front) do
    {x_front, y_front} = winner_front
    x_adjust = (x_front-36)/80
    y_adjust = (y_front-36)/80
    adjust_x = x_front + x_adjust
    adjust_y = y_front + y_adjust
     {adjust_x, adjust_y}
  end 

  def endPrepare(tick_moment, seq_humans, seq_robots) do
    human_front_winner = humanWinCoord(seq_humans)
    #   [winner_front, winner_name] = winner_xy_name
   # dbg(human_front_winner)
    robot_front_winner = robotWinCoord(seq_robots)
    empty_square = GameBoard.free_square(tick_moment.pid_board)
    human_win = human_front_winner != nil
    robot_win = robot_front_winner != nil

    # 1,1 =>           #{0.6, 0.6},
    # 21,21 => {20.8,20.8},
    # 36,36 => {36,36}
    # 42,42 =>{42.1,42.1}


    _the_winner =
      cond do
        human_win ->
                          [winner_front, winner_name] = human_front_winner
                    dbg(winner_front)
           # dbg(winner_name)
          _user_tick = %GameSequences{

            tick_moment
            | seq_winner_front: winner_front,
            seq_winner_name: winner_name,
   #         | seq_winner_front: adjustCenter({42,42}),
              seq_finished: true
          }

        robot_win ->
          _user_tick = %GameSequences{
            tick_moment
          | seq_winner_front: robot_front_winner,
#             |      seq_winner_front: adjustCenter({42,42}),
              seq_finished: true
          }

        true ->
          _user_tick = %GameSequences{tick_moment | seq_winner_front: empty_square, seq_finished: true}
      end
  end

  def endZoomIn(pid_tick, tick_moment) do

    pid_board = tick_moment.pid_board
    seq_humans = tick_moment.seq_humans
    seq_game_sizes = tick_moment.seq_game_sizes

    old_scale = tick_moment.seq_scale
    {winner_x, winner_y} = tick_moment.seq_winner_front
      winner_name = tick_moment.seq_winner_name
     # dbg(winner_name)
    winner_center = {winner_x + 0.5, winner_y + 0.5}
    [new_scale, scale_x_px, scale_y_px] = endScale(old_scale, winner_center)
    players_matrix = GameBoard.snake_matrix(pid_board)

      for {_person_name, pid_user_and_pid_snake} <- seq_humans, into: [] do
        pid_user = pid_user_and_pid_snake.pid_user

        if old_scale > TheConsts.c_scaling_steps() do
          UserHtml.end_game(pid_user)
        else
          UserHtml.send_winner(
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
   #   dbg("befor win tick")
    _winner_tick = %GameSequences{
      tick_moment
      | seq_scale: new_scale
    }
  end

  def humanWinCoord(seq_humans) do
    xy_name_list =
      for {_person_name, pid_user_and_pid_snake} <- seq_humans do
        pid_snake = pid_user_and_pid_snake.pid_snake
        snake_front_and_name = HumanPlayer.winnerHead(pid_snake)

        if snake_front_and_name do
          snake_front_and_name
        end
      end
   #   dbg(xy_name_list)

      winner_xy_name =     Enum.at(xy_name_list, 0)
  # dbg(winner_xy_name)
    #  [winner_front, winner_name] = winner_xy_name
         #   dbg(winner_front)
          #  dbg(winner_name)
#    Enum.at(xy, 0)
    #Enum.at(winner_front, 0)
   # winner_front
    winner_xy_name
  end

  def robotWinCoord(seq_robots) do
    xy =
      for {_person_name, pid_only_snake} <- seq_robots do
        pid_snake = pid_only_snake.pid_snake
        snake_front_or_false = RobotPlayer.winnerHead(pid_snake)

        if snake_front_or_false do
          snake_front_or_false
        end
      end

    Enum.at(xy, 0)
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
