#  FROM - https://elixirforum.com/t/how-to-make-proper-two-dimensional-data-structures-in-elixir/872/6

defmodule TickMoment do
  use GenServer

  alias MultiGameWeb.LiveUser

  def start_link(starter_person) do
    GenServer.start_link(TickMoment, starter_person)
  end

  def init(_starter_person) do
    participants_live = CollectParticipants.get_participants()

    {:ok, pid_board} =
      GameBoard.start_link(%StartBoard{
        x_range: TheConsts.c_board_hor(),
        y_range: TheConsts.c_board_hor(),
        wall_plots: TheConsts. c_wall_plots   #[{0, 0}, {2, 2}]
      })

    #  people_snakes2 =     for {c, counter} <- Enum.with_index(participants_live), do {counter, c}

    people_snakes =
      participants_live
      |> Enum.with_index(0)
      |> Enum.map(fn {pid_live__person_name, color_index} ->
        {{game_moniker, person_name}, pid_live} = pid_live__person_name
        {x_start, y_start, dir_start} = TheConsts.start_coord_dir()[color_index]

        person_snake = %StartPerson{
          game_moniker: game_moniker,
          snake_name: person_name,
          snake_direction: dir_start,
          snake_x: x_start,
          snake_y: y_start
        }

        {:ok, pid_snake} = HumanSnake.start_link(person_snake)
        GameBoard.place_player(pid_board, person_name)
        {person_name, %{pid_snake: pid_snake, pid_live: pid_live}}
      end)
      |> Map.new()

    comp_snakes =
      for comp_number <- 1..TheConsts.c_num_computer, into: %{} do
        comp_snake = %StartComputer{
          snake_number: comp_number,
          # snake_routes
          snake_directions: [
            "left",
            "left",
            "left"
          ],
          snake_x: 3,
          snake_y: 3
        }

        {:ok, pid_snake} = ComputerSnake.start_link(comp_snake)
        GameBoard.place_robot(pid_board, comp_number)
        {comp_number, %{pid_snake: pid_snake}}
      end

    started_moment = %{
      pid_board: pid_board,
      people_snakes: people_snakes,
      comp_snakes: comp_snakes,
      max_game_ping: 0
    }

    {:ok, started_moment}
  end

  def handle_info({:update_tick}, tick_moment) do
    pid_board = tick_moment.pid_board
    people_snakes = tick_moment.people_snakes
    comp_snakes = tick_moment.comp_snakes
    players_matrix = GameBoard.snake_matrix(pid_board)
    [x_range, y_range] = GameBoard.board_size(pid_board)

    for {_robot_number, pid_only_snake} <- comp_snakes, into: [] do
      pid_snake = pid_only_snake.pid_snake
     computer_front= ComputerSnake.slither_move(pid_snake, pid_board)
    end
    pid_tick = self()
    max_pings =
      for {_person_name, pid_live_and_pid_snake} <- people_snakes, into: [] do
        pid_snake = pid_live_and_pid_snake.pid_snake
        pid_live = pid_live_and_pid_snake.pid_live
        human_front = HumanSnake.slither_move(pid_snake, pid_board)
        LiveUser.send_board(pid_live, pid_board, pid_tick, players_matrix, x_range, y_range)
      end

     players_alive = GameBoard.players_alive(pid_board)
     if players_alive ==1 do
      dbg(players_alive)
     end
    # ascii_board = GameBoard.ascii_print(pid_board, players_matrix)
    # dg(ascii_board)

    started_moment = %{
      pid_board: pid_board,
      people_snakes: people_snakes,
      comp_snakes: comp_snakes,
      ## KEEP SO CAN SHOW WHEN PLAY WITH A PHONE TOO
      max_game_ping: Enum.max(max_pings)
    }

 Process.send_after(pid_tick, {:update_tick}, TheConsts.frames_per_sec())
    {:noreply, started_moment}
  end

  def snake_change_dir(tid, person_name, new_dirr) do
    GenServer.cast(tid, {:snake_change_dir, person_name, new_dirr})
  end

  def begin_game(pid_tick) do
    GenServer.cast(pid_tick, {:begin_game})
  end

  def handle_cast({:begin_game}, old_moment) do
    Process.send_after(self(), {:update_tick}, 259)
    {:noreply, old_moment}
  end

  def handle_cast({:snake_change_dir, person_name, new_dirr}, started_moment) do
    down_snake = Map.get(started_moment.people_snakes, person_name)
    %{pid_snake: pid_snake} = down_snake
    HumanSnake.change_direction(pid_snake, new_dirr)
    {:noreply, started_moment}
  end
end
