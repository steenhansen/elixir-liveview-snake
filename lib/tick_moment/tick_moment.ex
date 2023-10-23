
defmodule TickMoment do
  use GenServer

  def start_link({starter_person, seq_match_choices, seq_game_sizes, start_locations,participants_live}) do
    GenServer.start_link(
      TickMoment,
      {starter_person, seq_match_choices, seq_game_sizes, start_locations,participants_live}
    )
  end

  def init({game_name, seq_match_choices, seq_game_sizes, start_locations,participants_live}) do
    size_board_hor = seq_game_sizes.size_board_hor
    size_board_ver = seq_game_sizes.size_board_ver

    start_board = %ServerBoard{
      board_width: size_board_hor,
      board_height: size_board_ver,
      board_walls: seq_match_choices.chosen_obstacles
    }


    {:ok, pid_board} = GameBoard.start_link(start_board)

    snake_length = seq_match_choices.chosen_length

    num_robots = seq_match_choices.chosen_computers

    seq_robots = robot_snakes(num_robots, pid_board, start_locations, snake_length)

    seq_humans =
      participants_live
      |> Enum.with_index(num_robots)  
      |> Enum.map(fn {pid_user__person_name, color_index} ->
        {pid_user, person_name} = pid_user__person_name
        {x_start, y_start, dir_start} = start_locations[color_index]


        person_snake = %HumanStart{
          game_name: game_name,
          start_name: person_name,
          start_direction: dir_start,
          start_x: x_start,
          start_y: y_start,
         pid_user: pid_user
        }
        {:ok, pid_snake} = HumanPlayer.start_link(person_snake, snake_length)
        GameBoard.place_player(pid_board, pid_user)
        { %{pid_user: pid_user}, %{pid_snake: pid_snake, person_name: person_name}}
      end)
      |> Map.new()

    started_moment = %GameSequences{
      pid_board: pid_board,
      seq_humans: seq_humans,
      seq_robots: seq_robots,
      seq_max_ping: 0,
       seq_step: "play_seq_1",
      seq_winner_countdown: 0,
      seq_scale: 1,
      seq_countdown: 3,
      seq_match_choices: seq_match_choices,
      seq_game_sizes: seq_game_sizes
    }

    {:ok, started_moment}
  end

  def snake_change_dir(tid, pid_user, new_dirr) do
    GenServer.cast(tid, {:snake_change_dir, pid_user, new_dirr})
  end

  def robot_snakes(num_robots, pid_board, start_locations, snake_length) do
    if num_robots < 1 do
      %{}
    else
      _seq_robots =
        for comp_number <- 1..num_robots, into: %{} do
          robot_index = comp_number - 1
          {x_start, y_start, dir_start} = start_locations[robot_index]
          straight_start = List.duplicate(dir_start, TheConsts.c_start_follow())

          comp_snake = %RobotStart{
            start_number: robot_index,
            start_directions: straight_start,
            start_x: x_start,
            start_y: y_start
          }

          {:ok, pid_snake} = RobotPlayer.start_link(comp_snake, snake_length)
          GameBoard.place_robot(pid_board, robot_index)
          {robot_index, %{pid_snake: pid_snake}}
        end
    end
  end

  ############## 
  def handle_info({:update_tick}, tick_moment) do
    pid_tick = self()

    started_moment = GameLoop.browser_message(pid_tick, tick_moment)
    chosen_frames_per_sec = tick_moment.seq_match_choices.chosen_frames_per_sec
    Process.send_after(self(), {:update_tick}, chosen_frames_per_sec)
    {:noreply, started_moment}
  end

  def handle_info({:do_countdown}, old_moment) do
    if old_moment.seq_countdown > 0 do
      Process.send_after(self(), {:do_countdown}, TheConsts.c_count_down_second())
      started_moment = GameLoop.browser_countdown(self(), old_moment)
      {:noreply, started_moment}
    else
      chosen_frames_per_sec = old_moment.seq_match_choices.chosen_frames_per_sec
      Process.send_after(self(), {:update_tick}, chosen_frames_per_sec)
      {:noreply, old_moment}
    end
  end

  ######################
  def begin_game(pid_tick) do
    GenServer.cast(pid_tick, {:begin_game})
  end

  def jump_over(tid, pid_user) do
    GenServer.cast(tid, {:jump_over, pid_user})
  end

  def handle_cast({:begin_game}, old_moment) do
    GameLoop.showStartPositions(
      old_moment,
      old_moment.seq_humans,
      old_moment.seq_robots
    )

    Process.send_after(
      self(),
      {:do_countdown},
      TheConsts.c_count_down_second()
    )

    {:noreply, old_moment}
  end

  #####################
  def handle_cast({:snake_change_dir, pid_user, new_dirr}, started_moment) do
    down_snake = Map.get(started_moment.seq_humans, %{pid_user: pid_user})
    %{pid_snake: pid_snake} = down_snake
    HumanPlayer.change_direction(pid_snake, new_dirr)
    {:noreply, started_moment}
  end

  def handle_cast({:jump_over, pid_user}, started_moment) do
        down_snake = Map.get(started_moment.seq_humans,  %{pid_user: pid_user})
    %{pid_snake: pid_snake} = down_snake
    HumanPlayer.jump_over(pid_snake)
    {:noreply, started_moment}
  end
end
