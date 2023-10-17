defmodule StartBoard do
  defstruct board_width: 2,
   board_height: 3, 
   board_walls: []
end

#  we need a type for "no_crash" , "hit_wall", "hit_snake"

  defmodule ServerBoard do
    use Norm

    defstruct board_width: 44,
              board_height: 44,
              board_empty_xys: MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}]),
              board_fronts: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
              board_rumps: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
              board_walls: MapSet.new([{1, 1}, {2, 1}]),
              board_colors: %{"1" => 3, "jill" => 1, "bob" => 2},
              board_snakes_xys: %{{0, 0} => 10, {1, 0} => 11, {2, 0} => 12},
              board_ids: %{1 => "bob"},
              board_deads: %{"jill" => "bob"},
              board_jumps: %{"b3" => %{{0, 0} => 10, {1, 0} => 11, {2, 0} => 12}},
              board_leaps: Map.new()
  end

defmodule TakeTurn do
  def snake_crashed(hit_other_snake, prev_board, snake_id) do
    old_deads = prev_board.board_deads
    ran_into = Enum.at(hit_other_snake, 0)
    
    new_killed = Map.put(old_deads, snake_id, true)
    next_board = %ServerBoard{
      prev_board
      | :board_deads => new_killed
    }

    {:reply, ran_into, next_board}
  end

  def hit_a_wall(prev_board, snake_id) do
    old_deads = prev_board.board_deads
    c_wall_kill = TheConsts.c_wall_kill()
    new_killed = Map.put(old_deads, snake_id, true)

    next_board = %ServerBoard{
      prev_board
      | :board_deads => new_killed
    }

    {:reply, c_wall_kill, next_board}
  end

  # this is where the snake does its move
  def playerToBoard(prev_board, snake_change) do
    prev_fronts = prev_board.board_fronts
    prev_rumps = prev_board.board_rumps
    prev_deads = prev_board.board_deads

    prev_jumps = prev_board.board_jumps
    prev_leaps = prev_board.board_leaps
    prev_plots = prev_board.board_snakes_xys
    prev_empty = prev_board.board_empty_xys

    snake_front = snake_change.change_front
    snake_id = snake_change.change_id
    snake_rump = snake_change.change_rump
    snake_dead = snake_change.change_dead
    human_jump = snake_change.change_jump
    human_leap = snake_change.change_leap

    this_plots = prev_plots[snake_id]
    this_emptys = Map.delete(prev_empty, snake_front)

    next_fronts = Map.put(prev_fronts, snake_id, snake_front)
    next_rumps = Map.put(prev_rumps, snake_id, snake_rump)
    next_deads = Map.put(prev_deads, snake_id, snake_dead)

    next_jumps = Map.put(prev_jumps, snake_id, human_jump)
    next_leaps = Map.put(prev_leaps, snake_id, human_leap)

    fronted_plots = MapSet.put(this_plots, snake_front)
    next_emptys = MapSet.put(this_emptys, snake_rump)

    shortened_snake = MapSet.delete(fronted_plots, snake_rump)

    next_plots = Map.put(prev_plots, snake_id, shortened_snake)

    next_board = %ServerBoard{
      prev_board
      | :board_empty_xys => next_emptys,
        :board_fronts => next_fronts,
        :board_rumps => next_rumps,
                :board_deads => next_deads,     
        :board_jumps => next_jumps,
        :board_leaps => next_leaps,
        :board_snakes_xys => next_plots
    }

    {:reply, "no_crash", next_board}
  end
end
