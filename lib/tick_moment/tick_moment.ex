#  FROM - https://elixirforum.com/t/how-to-make-proper-two-dimensional-data-structures-in-elixir/872/6

defmodule GameSizes do
  defstruct size_board_hor: 44,
            size_board_ver: 44,
            size_board_hor_px: 431,
            size_board_ver_px: 431,
            size_last_hor: 44 - 1,
            size_last_ver: 44 - 1,
            size_nw_hor: trunc(44 * 1 / 3),
            size_nw_ver: trunc(44 * 1 / 3),
            size_ne_hor: trunc(44 * 1 / 3),
            size_ne_ver: trunc(44 * 2 / 3),
            size_se_hor: trunc(44 * 2 / 3),
            size_se_ver: trunc(44 * 2 / 3),
            size_sw_hor: trunc(44 * 1 / 3),
            size_sw_ver: trunc(44 * 2 / 3),
            size_center_x: trunc(44 / 2),
            size_center_y: trunc(44 / 2)
end

defmodule GameSequences do
  defstruct pid_board: nil,
            seq_humans: Map.new(),
            seq_robots: Map.new(),
            seq_max_ping: 0,
            seq_finished: false,
            seq_scale: 1,
            seq_countdown: 3,
            seq_winner_front: {0, 0},
            seq_winner_name: "Bob",
            seq_match_choices: %MatchChosens{
              chosen_frames_per_sec: TheConsts.c_speed_fast_50_a_sec(),
              chosen_rotate: false,
              chosen_length: 8,
              chosen_tile_width: 44,
              chosen_tile_height: 44,
              chosen_obstacles: [{40, 40}, {41, 41}, {42, 42}],
              chosen_computers: 1
            },
            seq_game_sizes: %GameSizes{
              size_board_hor: 44,
              size_board_ver: 44,
              size_board_hor_px: 391,
              size_board_ver_px: 391,
              size_last_hor: 44 - 1,
              size_last_ver: 44 - 1,
              size_nw_hor: trunc(44 * 1 / 3),
              size_nw_ver: trunc(44 * 1 / 3),
              size_ne_hor: trunc(44 * 1 / 3),
              size_ne_ver: trunc(44 * 2 / 3),
              size_se_hor: trunc(44 * 2 / 3),
              size_se_ver: trunc(44 * 2 / 3),
              size_sw_hor: trunc(44 * 1 / 3),
              size_sw_ver: trunc(44 * 2 / 3),
              size_center_x: trunc(44 / 2),
              size_center_y: trunc(44 / 2)
            }
end

defmodule TickMoment do
  use GenServer

  def start_link({starter_person, seq_match_choices, seq_game_sizes, start_locations}) do
    GenServer.start_link(
      TickMoment,
      {starter_person, seq_match_choices, seq_game_sizes, start_locations}
    )
  end

  def init({game_name, seq_match_choices, seq_game_sizes, start_locations}) do
    participants_live = CollectParticipants.get_participants(game_name)

    size_board_hor = seq_game_sizes.size_board_hor
    size_board_ver = seq_game_sizes.size_board_ver

    start_board = %StartBoard{
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
      |> Enum.with_index(1)
      |> Enum.map(fn {pid_user__person_name, color_index} ->
        {person_name, pid_user} = pid_user__person_name
        {x_start, y_start, dir_start} = start_locations[color_index]

        person_snake = %HumanStart{
          game_name: game_name,
          start_name: person_name,
          start_direction: dir_start,
          start_x: x_start,
          start_y: y_start
        }

        {:ok, pid_snake} = HumanPlayer.start_link(person_snake, snake_length)
        GameBoard.place_player(pid_board, person_name)
        {person_name, %{pid_snake: pid_snake, pid_user: pid_user}}
      end)
      |> Map.new()

    started_moment = %GameSequences{
      pid_board: pid_board,
      seq_humans: seq_humans,
      seq_robots: seq_robots,
      seq_max_ping: 0,
      seq_finished: false,
      seq_scale: 1,
      seq_countdown: 3,
      seq_match_choices: seq_match_choices,
      seq_game_sizes: seq_game_sizes
    }

    {:ok, started_moment}
  end

  def snake_change_dir(tid, person_name, new_dirr) do
    GenServer.cast(tid, {:snake_change_dir, person_name, new_dirr})
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
    started_moment = GameLoop.browser_message(self(), tick_moment)
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

  def jump_over(tid, person_name) do
    GenServer.cast(tid, {:jump_over, person_name})
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
  def handle_cast({:snake_change_dir, person_name, new_dirr}, started_moment) do
    down_snake = Map.get(started_moment.seq_humans, person_name)
    %{pid_snake: pid_snake} = down_snake
    HumanPlayer.change_direction(pid_snake, new_dirr)
    {:noreply, started_moment}
  end

  def handle_cast({:jump_over, person_name}, started_moment) do
    down_snake = Map.get(started_moment.seq_humans, person_name)
    %{pid_snake: pid_snake} = down_snake
    HumanPlayer.jump_over(pid_snake)
    {:noreply, started_moment}
  end
end
