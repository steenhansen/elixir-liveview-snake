#  FROM - https://elixirforum.com/t/how-to-make-proper-two-dimensional-data-structures-in-elixir/872/6

defmodule TickMoment do
  use GenServer

  def start_link(starter_person) do
    GenServer.start_link(TickMoment, starter_person)
  end

  def robot_snakes(num_robots, pid_board) do
    if num_robots < 1 do
      %{}
    else
      _robot_players =
        for comp_number <- 1..num_robots, into: %{} do
          robot_index = comp_number - 1
          {x_start, y_start, dir_start} = TheConsts.start_coord_dir()[robot_index]
          straight_start = List.duplicate(dir_start, TheConsts.c_start_follow())

          comp_snake = %RobotStart{
            start_number: robot_index,
            start_directions: straight_start,
            start_x: x_start,
            start_y: y_start
          }

          {:ok, pid_snake} = RobotPlayer.start_link(comp_snake)
          GameBoard.place_robot(pid_board, robot_index)
          {robot_index, %{pid_snake: pid_snake}}
        end
    end
  end

  def init(game_name) do
    participants_live = CollectParticipants.get_participants(game_name)

    start_board = %StartBoard{
      width_game: TheConsts.c_board_hor(),
      height_game: TheConsts.c_board_ver(),
      board_walls: TheGlobals.c_board_walls()
    }

    {:ok, pid_board} = GameBoard.start_link(start_board)

    num_robots = TheGlobals.g_num_computer()
    robot_players = robot_snakes(num_robots, pid_board)

    human_players =
      participants_live
      |> Enum.with_index(1)
      |> Enum.map(fn {pid_user__person_name, color_index} ->
        {person_name, pid_user} = pid_user__person_name
        {x_start, y_start, dir_start} = TheConsts.start_coord_dir()[color_index]

        person_snake = %HumanStart{
          game_name: game_name,
          start_name: person_name,
          start_direction: dir_start,
          start_x: x_start,
          start_y: y_start
        }

        {:ok, pid_snake} = HumanPlayer.start_link(person_snake)
        GameBoard.place_player(pid_board, person_name)
        {person_name, %{pid_snake: pid_snake, pid_user: pid_user}}
      end)
      |> Map.new()

    started_moment = %GameMoments{
      pid_board: pid_board,
      human_players: human_players,
      robot_players: robot_players,
      max_game_ping: 0,
      finished_game: false,
      game_scale: 1,
      start_countdown: 3
    }

    {:ok, started_moment}
  end

  def handle_info({:update_tick}, tick_moment) do
    started_moment = GameLoop.browser_message(self(), tick_moment)
    Process.send_after(self(), {:update_tick}, TheGlobals.g_frames_per_sec())
    {:noreply, started_moment}
  end

  def snake_change_dir(tid, person_name, new_dirr) do
    GenServer.cast(tid, {:snake_change_dir, person_name, new_dirr})
  end

  ############## 

  def handle_info({:do_countdown}, old_moment) do
    if old_moment.start_countdown > 0 do
      Process.send_after(self(), {:do_countdown}, TheConsts.c_count_down_second())
      started_moment = GameLoop.browser_countdown(self(), old_moment)
      {:noreply, started_moment}
    else
      Process.send_after(self(), {:update_tick}, TheGlobals.g_frames_per_sec())
      {:noreply, old_moment}
    end
  end

  ######################
  def begin_game(pid_tick) do
    GenServer.cast(pid_tick, {:begin_game})
  end

  def handle_cast({:begin_game}, old_moment) do

# draw initial 2  start squares so user can see where he starts and the direction
GameLoop.gameCycle22(self(), old_moment, old_moment.human_players, old_moment.robot_players)  

    Process.send_after(self(), {:do_countdown}, TheConsts.c_count_down_second())
    {:noreply, old_moment}
  end

  #####################
  def handle_cast({:snake_change_dir, person_name, new_dirr}, started_moment) do
    down_snake = Map.get(started_moment.human_players, person_name)
    %{pid_snake: pid_snake} = down_snake
    HumanPlayer.change_direction(pid_snake, new_dirr)
    {:noreply, started_moment}
  end

  def jump_over(tid, person_name) do
    GenServer.cast(tid, {:jump_over, person_name})
  end

  def handle_cast({:jump_over, person_name}, started_moment) do
    down_snake = Map.get(started_moment.human_players, person_name)
    %{pid_snake: pid_snake} = down_snake
    HumanPlayer.jump_over(pid_snake)
    {:noreply, started_moment}
  end
end
