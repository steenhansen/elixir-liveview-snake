defmodule GameMoments do
  defstruct pid_board: nil,
            human_players: Map.new(),
            robot_players: Map.new(),
            max_game_ping: 0,
            finished_game: false,
            game_scale: 1,
            start_countdown: 3,
            winner_front: {0, 0}
end

defmodule GameLoop do
  alias MultiGameWeb.UserHtml

  def browser_countdown(pid_tick, tick_moment) do
    human_players = tick_moment.human_players
    robot_players = tick_moment.robot_players
    pid_board = tick_moment.pid_board
    start_countdown = tick_moment.start_countdown

    max_pings =
      for {_person_name, pid_user_and_pid_snake} <- human_players, into: [] do
        pid_user = pid_user_and_pid_snake.pid_user
        user_color = UserHtml.color_index(pid_user, pid_board)

        x_offset = 0         # 26x26   x=8           44 x=17
        y_offset = 1        # 26x26   y=2           44 y=15

        players_matrix =
          Countdown321.make_countdown(pid_board, user_color, x_offset, y_offset, start_countdown)

        UserHtml.send_countdown(pid_user, pid_board, pid_tick, players_matrix)
      end

    started_moment = %GameMoments{
      tick_moment
      | max_game_ping: max_pings,
        start_countdown: start_countdown - 1
    }
  end

  ##############################
  def browser_message(pid_tick, tick_moment) do
    human_players = tick_moment.human_players
    robot_players = tick_moment.robot_players

    _next_moment =
      cond do
        tick_moment.finished_game -> endZoomIn(pid_tick, tick_moment)
        true -> playingGame(pid_tick, tick_moment, human_players, robot_players)
      end
  end

  def playingGame(pid_tick, tick_moment, human_players, robot_players) do
    max_ping = gameCycle(pid_tick, tick_moment, human_players, robot_players)
    players_alive = GameBoard.players_alive(tick_moment.pid_board)
   
    just_finished? = players_alive < TheConsts.c_two_players()

    if just_finished? do
      endPrepare(tick_moment, human_players, robot_players)
    else
      started_moment = %GameMoments{
        tick_moment
        | max_game_ping: max_ping
      }
    end
  end

  def gameCycle(pid_tick, tick_moment, human_players, robot_players) do
    pid_board = tick_moment.pid_board

    for {_robot_number, pid_only_snake} <- robot_players, into: [] do
      pid_snake = pid_only_snake.pid_snake
      _robot_front = RobotPlayer.jumpSnake(pid_snake, pid_board)
    end

    for {_person_name, pid_user_and_pid_snake} <- human_players, into: [] do
      pid_snake = pid_user_and_pid_snake.pid_snake
      _snake_front = HumanPlayer.jumpSnake(pid_snake, pid_board)
    end

    players_matrix = GameBoard.snake_matrix(pid_board)

    max_pings =
      for {_person_name, pid_user_and_pid_snake} <- human_players, into: [] do
        pid_user = pid_user_and_pid_snake.pid_user
        UserHtml.send_board(pid_user, pid_board, pid_tick, players_matrix)
      end

    max_ping = Enum.max(max_pings)
  end

  def gameCycle22(pid_tick, tick_moment, human_players, robot_players) do
    pid_board = tick_moment.pid_board

    for {_robot_number, pid_only_snake} <- robot_players, into: [] do
      pid_snake = pid_only_snake.pid_snake
      _robot_front = RobotPlayer.jumpSnake(pid_snake, pid_board)
    end

    for {_person_name, pid_user_and_pid_snake} <- human_players, into: [] do
      pid_snake = pid_user_and_pid_snake.pid_snake
      _snake_front = HumanPlayer.jumpSnake(pid_snake, pid_board)
    end

    players_matrix = GameBoard.snake_matrix(pid_board)
  end

  def endPrepare(tick_moment, human_players, robot_players) do
    human_front_winner = humanWinCoord(human_players)
    robot_front_winner = robotWinCoord(robot_players)
    empty_square = GameBoard.free_square(tick_moment.pid_board)
    human_win = human_front_winner != nil
    robot_win = robot_front_winner != nil

    _the_winner =
      cond do
        human_win ->
          user_tick = %GameMoments{
            tick_moment
            | winner_front: human_front_winner,
              finished_game: true
          }

        robot_win ->
          user_tick = %GameMoments{
            tick_moment
            | winner_front: robot_front_winner,
              finished_game: true
          }

        true ->
          user_tick = %GameMoments{tick_moment | winner_front: empty_square, finished_game: true}
      end
  end

  def endZoomIn(pid_tick, tick_moment) do
    pid_board = tick_moment.pid_board
    human_players = tick_moment.human_players

    old_scale = tick_moment.game_scale
    {winner_x, winner_y} = tick_moment.winner_front
    winner_center = {winner_x + 0.5, winner_y + 0.5}
    [new_scale, scale_x_px, scale_y_px] = endScale(old_scale, winner_center)
    players_matrix = GameBoard.snake_matrix(pid_board)

    max_pings =
      for {_person_name, pid_user_and_pid_snake} <- human_players, into: [] do
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
            scale_y_px
          )
        end
      end

    winner_tick = %GameMoments{
      tick_moment
      | game_scale: new_scale
    }
  end

  def humanWinCoord(human_players) do
    xy =
      for {_person_name, pid_user_and_pid_snake} <- human_players do
        pid_snake = pid_user_and_pid_snake.pid_snake
        snake_front_or_false = HumanPlayer.winnerHead(pid_snake)

        if snake_front_or_false do
          snake_front_or_false
        end
      end

    Enum.at(xy, 0)
  end

  def robotWinCoord(robot_players) do
    xy =
      for {_person_name, pid_only_snake} <- robot_players do
        pid_snake = pid_only_snake.pid_snake
        snake_front_or_false = RobotPlayer.winnerHead(pid_snake)

        if snake_front_or_false do
          snake_front_or_false
        end
      end

    Enum.at(xy, 0)
  end

  def float2Px(scale_offset) do
    scaled_px = "-" <> Integer.to_string(round(scale_offset)) <> "px"
  end

  def endScale(prev_scale, winner_front) do
    {coord_x, coord_y} = winner_front

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
