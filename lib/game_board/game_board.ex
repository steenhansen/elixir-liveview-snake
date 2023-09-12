#  FROM - https://elixirforum.com/t/how-to-make-proper-two-dimensional-data-structures-in-elixir/872/6

defmodule StartBoard do
  defstruct x_range: 2, y_range: 3, wall_plots: []
end

defmodule BoardStatus do
  defstruct x_range: 44,
            y_range: 44,
            empty_plots: MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}]),
            snake_fronts: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
            snake_rumps: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
            wall_plots: MapSet.new([{1, 1}, {2, 1}]),
            player_colors: %{"1" => 3, "jill" => 1, "bob" => 2},
            user_plots: %{{0, 0} => 10, {1, 0} => 11, {2, 0} => 12},
            player_ids: %{1 => "bob"},
            killed_bys: %{"jill" => "bob"}
end

defmodule GameBoard do
  use GenServer

  @doc since: """
          x_range = 1              #NEW WAY 1 == NEW WAY 2 !!!!!!!!!
          y_range = 1 
         all_empty =
           for x <- 0..x_range,
               y <- 0..y_range,
               into: MapSet.new(),
               do: {x, y}
       MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}])
       """

  def init(new_game) do
    mywall_plots = MapSet.new(new_game.wall_plots)
    x_range = new_game.x_range
    y_range = new_game.y_range

    all_empty = MatrixGrid.emptyMatrix(x_range, y_range)

    new_board = %BoardStatus{
      x_range: x_range,
      y_range: y_range,
      empty_plots: all_empty,
      snake_fronts: Map.new(),
      snake_rumps: Map.new(),
      wall_plots: mywall_plots,
      player_colors: Map.new(),
      user_plots: Map.new(),
      player_ids: Map.new(),
      killed_bys: Map.new()
    }

    {:ok, new_board}
  end

  def snake_move(pid, a_slither) do
    GenServer.call(pid, {:snake_move, a_slither})
  end

  # def xy_in_set?(xy_tuple, some_plots) do
  #   xy_in_set =
  #               some_plots
  #               |> Enum.map(fn {_name, plotSet} -> MapSet.member?(plotSet, xy_tuple) end)
  #               |> Enum.member?(true)
  # end

  #################
  def start_link(new_game) do
    GenServer.start_link(GameBoard, new_game)
  end

  #######################
  def player_colors(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:player_colors})
  end

  def handle_call({:player_colors}, _from, current_board) do
    the_colors = current_board.player_colors
    {:reply, the_colors, current_board}
  end

  def handle_call({:snake_move, a_slither}, _from, old_board) do
    old_emptys = old_board.empty_plots
    the_walls = old_board.wall_plots
    old_plots = old_board.user_plots   # qbert human=set, computer map
    old_rumps = old_board.snake_rumps
    old_fronts = old_board.snake_fronts
    old_kills = old_board.killed_bys

    front_snake = a_slither.front_snake

    hit_snake = SnakeToBoard.hit_snake?(a_slither, old_emptys, old_plots)

    if length(hit_snake) > 0 do
      ran_into = Enum.at(hit_snake, 0)
      new_killed_bys = Map.put(old_kills, a_slither.snake_id, ran_into)
      person_kill = %{
        old_board
        | :killed_bys => new_killed_bys
      }
      {:reply, ran_into, person_kill}
    else
      hit_wall = MapSet.member?(the_walls, front_snake)

      if hit_wall do
        new_killed_bys = Map.put(old_kills, a_slither.snake_id, TheConsts.c_wall_kill())

        wall_kill = %{
          old_board
          | :killed_bys => new_killed_bys
        }

        {:reply, TheConsts.c_wall_kill(), wall_kill}
      else
        front_empty = MapSet.member?(old_emptys, front_snake)

        if front_empty do
          empties_front_rumps =
            SnakeToBoard.board_move(
              old_fronts,
              old_rumps,
              old_emptys,
              old_plots,     # qbert human=set, computer=map
              a_slither,
              front_snake
            )

          %{
            :empty_plots => shrunk_emptys,
            :snake_fronts => new_fronts,
            :snake_rumps => new_rumps,
            :moved_worm => moved_worm
            #  :snake_dead => snake_dead
          } = empties_front_rumps

          if a_slither.snake_cleanup do
            grown_emptys = MapSet.put(shrunk_emptys, a_slither.snake_rump)
            shortened_worm = MapSet.delete(moved_worm, a_slither.snake_rump)
            new_plots = Map.put(old_plots, a_slither.snake_id, shortened_worm)

            new_board = %{
              old_board
              | :empty_plots => grown_emptys,
                :user_plots => new_plots,
                :snake_fronts => new_fronts,
                :snake_rumps => new_rumps
            }

            {:reply, "no_crash", new_board}
          else
            growing_plots = Map.put(old_plots, a_slither.snake_id, moved_worm)

            new_board = %{
              old_board
              | :empty_plots => shrunk_emptys,
                # snake_body
                :user_plots => growing_plots,
                :snake_fronts => new_fronts,
                :snake_rumps => new_rumps
            }

            {:reply, "no_crash", new_board}
          end
        else
          {:reply, "no_crash", old_board}
        end
      end
    end
  end

  def handle_call({:board_size}, _from, current_board) do
    board_size = [current_board.x_range, current_board.y_range]
    {:reply, board_size, current_board}
  end

  def handle_call({:ascii_print, players_matrix}, _, current_board) do
    ascii_board = MatrixGrid.asciiBoard(players_matrix, current_board)
    {:reply, ascii_board, current_board}
  end

  def handle_call({:snake_matrix}, _from, current_board) do
    snakes_pixels =
      BaseSnake.snakeColors(
        current_board.user_plots,
        current_board.player_colors,
        current_board.snake_fronts,
        current_board.snake_rumps,
        current_board.killed_bys
      )

    current_matrix =
      MatrixGrid.emptyMatrix(current_board.x_range, current_board.y_range)
      |> MatrixGrid.walledMatrix(current_board.wall_plots)
      |> MatrixGrid.snakesToMatrix(snakes_pixels)

    {:reply, current_matrix, current_board}
  end

  #####################
  def board_size(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:board_size})
  end

  def place_robot(pid_board, a_number) do
    GenServer.cast(pid_board, {:place_robot, a_number})
  end

  #############################################################

  def handle_cast({:place_robot, a_number}, old_board) do
    number_str = Integer.to_string(a_number)
    old_colors = old_board.player_colors
    old_player_ids = old_board.player_ids
    ### 1 #####   try 2
    player_id = Enum.count(old_colors) + 1
    new_player_ids = Map.put(old_player_ids, player_id, number_str)
    new_colors = Map.put(old_colors, number_str, player_id)
    old_user_plots = old_board.user_plots

# bad    new_user_plots = Map.put(old_user_plots, number_str, Map.new())

    new_user_plots = Map.put(old_user_plots, number_str, MapSet.new())

    old_fronts = old_board.snake_fronts
    new_fronts = Map.put(old_fronts, number_str, Map.new())

    old_rumps = old_board.snake_rumps
    new_rumps = Map.put(old_rumps, number_str, Map.new())

    robot_board = %{
      old_board
      | player_colors: new_colors,
        snake_fronts: new_fronts,
        snake_rumps: new_rumps,
        user_plots: new_user_plots,
        player_ids: new_player_ids
    }

    {:noreply, robot_board}
  end

  ##########################

  def handle_cast({:place_player, a_name}, old_board) do
    old_colors = old_board.player_colors
    old_player_ids = old_board.player_ids

    player_id = Enum.count(old_colors) + 1
    new_player_ids = Map.put(old_player_ids, player_id, a_name)
    new_colors = Map.put(old_colors, a_name, player_id)
    old_user_plots = old_board.user_plots
    new_user_plots = Map.put(old_user_plots, a_name, MapSet.new())

    human_board = %{
      old_board
      | player_colors: new_colors,
        user_plots: new_user_plots,
        player_ids: new_player_ids
    }

    {:noreply, human_board}
  end


  def place_player(pid_board, a_name) do
    GenServer.cast(pid_board, {:place_player, a_name})
  end

  # bart
  def ascii_print(pid, players_matrix) do
    GenServer.call(pid, {:ascii_print, players_matrix})
  end

  def snake_matrix(pid_board) do
    GenServer.call(pid_board, {:snake_matrix})
  end

 def players_alive(pid) do
    GenServer.call(pid, {:players_alive})
  end

  def handle_call({:players_alive}, _from, current_board) do
    players_killed = Enum.count(current_board.killed_bys)
    players_total = Enum.count(current_board.player_ids)
    players_left = players_total - players_killed
    {:reply, players_left, current_board}
  end




  
end
