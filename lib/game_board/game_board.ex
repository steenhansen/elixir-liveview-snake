defmodule GameBoard do
  use GenServer



  @doc since: """
          width_game = 1              #NEW WAY 1 == NEW WAY 2 !!!!!!!!!
          height_game = 1 
         all_empty =
           for x <- 0..width_game,
               y <- 0..height_game,
               into: MapSet.new(),
               do: {x, y}
       MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}])
       """
  def start_link(new_game) do
    GenServer.start_link(GameBoard, new_game)
  end

  def init(new_game) do
    myboard_walls = MapSet.new(new_game.board_walls)
    width_game = new_game.width_game
    height_game = new_game.height_game

    all_empty = MatrixGrid.emptyMatrix(width_game, height_game)

    new_board = %ServerBoard{
      width_game: width_game,
      height_game: height_game,
      empty_xys_game: all_empty,
      board_fronts: Map.new(),
      board_rumps: Map.new(),
      board_walls: myboard_walls,
      board_colors: Map.new(),
      board_snakes_xys: Map.new(),
      board_ids: Map.new(),
      board_deads: Map.new(),
      board_jumps: Map.new(),
      board_leaps: Map.new()
    }

    {:ok, new_board}
  end

  def snake2Board(pid_board, snake_change) do
    GenServer.call(pid_board, {:snake2Board, snake_change})
  end

  def board_colors(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:board_colors})
  end

  def handle_call({:board_colors}, _from, prev_board) do
    the_colors = prev_board.board_colors
    {:reply, the_colors, prev_board}
  end

  def handle_call({:players_alive}, _from, prev_board) do

   players_killed =  Enum.count(prev_board.board_deads, 
                 fn ({key, val}) -> val == true end)

    players_total = Enum.count(prev_board.board_ids)
    players_left = players_total - players_killed
    {:reply, players_left, prev_board}
  end

  def handle_call({:board_size}, _from, prev_board) do
    board_size = [prev_board.width_game, prev_board.height_game]

    {:reply, board_size, prev_board}
  end

  def handle_call({:ascii_print, players_matrix}, _, prev_board) do
    ascii_board = MatrixGrid.asciiBoard(players_matrix, prev_board)
    {:reply, ascii_board, prev_board}
  end


  def handle_call({:snake2Board, snake_change}, _from, prev_board) do
    a = SnakePosition.move_snake({:snake2Board, snake_change}, prev_board)
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
    a = SnakeDraw.robot_to_board({:place_robot, a_number}, prev_board)
  end

  def handle_cast({:place_player, a_name}, prev_board) do
    a = SnakeDraw.human_to_board({:place_player, a_name}, prev_board)
  end

  def place_player(pid_board, a_name) do
    GenServer.cast(pid_board, {:place_player, a_name})
  end

  # bart
  def ascii_print(pid, players_matrix) do
    GenServer.call(pid, {:ascii_print, players_matrix})
  end

    def players_alive(pid) do
    GenServer.call(pid, {:players_alive})
  end


############

  def snake_matrix(pid_board) do
    GenServer.call(pid_board, {:snake_matrix})
  end
  
  def handle_call({:snake_matrix}, _from, prev_board) do
    a = SnakePosition.snake_to_board(prev_board)
    {:reply, current_matrix, prev_board} = a
    a
  end
###############

  def free_square(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:free_square})
  end

  def handle_call({:free_square}, _from, current_board) do
    empty_xys = current_board.empty_xys_game
    first_emtpy = Enum.at(empty_xys, 0)

    {:reply, first_emtpy, current_board}
  end
end
