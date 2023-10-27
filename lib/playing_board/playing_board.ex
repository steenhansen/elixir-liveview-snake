defmodule PlayingBoard do
  use GenServer

  @doc  """
          board_width = 1              #NEW WAY 1 == NEW WAY 2 !!!!!!!!!
          board_height = 1 
         all_empty =
           for x <- 0..board_width,
               y <- 0..board_height,
               into: MapSet.new(),
               do: {x, y}
       MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}])
       """
  def start_link(new_game) do
    GenServer.start_link(PlayingBoard, new_game)
  end

  def init(new_game) do
    myboard_walls = MapSet.new(new_game.board_walls)
    board_width = new_game.board_width
    board_height = new_game.board_height

    all_empty = MatrixGrid.emptyMatrix(board_width, board_height)

    new_board = %ServerBoard{
      board_width: board_width,
      board_height: board_height,
      board_empty_xys: all_empty,
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

  def players_alive(pid) do
    GenServer.call(pid, {:players_alive})
  end

  def snake_matrix(pid_board) do
    GenServer.call(pid_board, {:snake_matrix})
  end

  def free_square(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:free_square})
  end

  def board_size(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:board_size})
  end

  def boardColors(pid_board) do
    ### this should be an info
    GenServer.call(pid_board, {:boardColors})
  end

  def place_robot(pid_board, a_number) do
    GenServer.cast(pid_board, {:place_robot, a_number})
  end

  def snake2Board(pid_board, snake_change) do
    GenServer.call(pid_board, {:snake2Board, snake_change})
  end

  def place_player(pid_board, pid_user) do
    GenServer.cast(pid_board, {:place_player, pid_user})
  end

  def ascii_print(pid, players_matrix) do
    GenServer.call(pid, {:ascii_print, players_matrix})
  end

  def handle_cast({:place_robot, a_number}, prev_board) do
    _a = SnakeDraw.robot_to_board({:place_robot, a_number}, prev_board)
  end

  def handle_cast({:place_player, pid_user}, prev_board) do
    _a = SnakeDraw.human_to_board({:place_player, pid_user}, prev_board)
  end

  def handle_call({:boardColors}, _from, prev_board) do
    the_colors = prev_board.board_colors
    {:reply, the_colors, prev_board}
  end


  def handle_call({:board_size}, _from, prev_board) do
    board_size = [prev_board.board_width, prev_board.board_height]

    {:reply, board_size, prev_board}
  end

  def handle_call({:ascii_print, players_matrix}, _, prev_board) do
    ascii_board = MatrixGrid.asciiBoard(players_matrix, prev_board)
    {:reply, ascii_board, prev_board}
  end

  def handle_call({:snake2Board, snake_change}, _from, prev_board) do
    return = BoardSnakePosition.move_snake({:snake2Board, snake_change}, prev_board)
    #  {:reply, what_did_hit, prev_board} = return
    return
  end

  def handle_call({:snake_matrix}, _from, prev_board) do
    return = BoardSnakePosition.snake_to_board(prev_board)
    return
  end


  def handle_call({:free_square}, _from, current_board) do
    empty_xys = current_board.board_empty_xys
    first_emtpy = Enum.at(empty_xys, 0)

    {:reply, first_emtpy, current_board}
  end


  
  def handle_call({:players_alive}, _from, prev_board) do
    players_killed =
      Enum.count(
        prev_board.board_deads,
        fn {_key, val} -> val == true end
      )

    players_total = Enum.count(prev_board.board_ids)
    players_left = players_total - players_killed
    {:reply, players_left, prev_board}
  end

  
end
