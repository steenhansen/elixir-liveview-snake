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
  def start_link(new_game) do
    GenServer.start_link(GameBoard, new_game)
  end

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
      killed_bys: Map.new(),
      snake_penultimates: Map.new()
    }

    {:ok, new_board}
  end

  def snake_move(pid, a_slither) do
    GenServer.call(pid, {:snake_move, a_slither})
  end

  def player_colors(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:player_colors})
  end

  def handle_call({:player_colors}, _from, prev_board) do
    the_colors = prev_board.player_colors
    {:reply, the_colors, prev_board}
  end

  def handle_call({:players_alive}, _from, prev_board) do
    players_killed = Enum.count(prev_board.killed_bys)
    players_total = Enum.count(prev_board.player_ids)
    players_left = players_total - players_killed
    {:reply, players_left, prev_board}
  end

  def handle_call({:board_size}, _from, prev_board) do
    board_size = [prev_board.x_range, prev_board.y_range]

    {:reply, board_size, prev_board}
  end

  def handle_call({:ascii_print, players_matrix}, _, prev_board) do
    ascii_board = MatrixGrid.asciiBoard(players_matrix, prev_board)
    {:reply, ascii_board, prev_board}
  end

  def handle_call({:snake_matrix}, _from, prev_board) do
    a = SnakePosition.snake_to_board({:snake_matrix}, prev_board)
    {:reply, current_matrix, prev_board} = a
    a
  end

  def handle_call({:snake_move, a_slither}, _from, prev_board) do
    a = SnakePosition.move_snake({:snake_move, a_slither}, prev_board)
    {:reply, what_did_hit, prev_board} = a
    a
  end

  def board_size(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:board_size})
  end

  def place_robot(pid_board, a_number) do
    GenServer.cast(pid_board, {:place_robot, a_number})
  end

  def handle_cast({:place_robot, a_number}, prev_board) do
    a = PlaceSnake.robot_to_board({:place_robot, a_number}, prev_board)
  end

  def handle_cast({:place_player, a_name}, prev_board) do
    a = PlaceSnake.human_to_board({:place_player, a_name}, prev_board)
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
end
