defmodule StartBoard do
  defstruct x_range: 2, y_range: 3, wall_plots: []
end

#  we need a type for "no_crash" , "hit_wall", "hit_snake"

defmodule BoardStatus do
  use TypeCheck

  defstruct x_range: 44,
            y_range: 44,
            empty_plots: MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}]),
            snake_fronts: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
            snake_rumps: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
            wall_plots: MapSet.new([{1, 1}, {2, 1}]),
            player_colors: %{"1" => 3, "jill" => 1, "bob" => 2},
            user_plots: %{{0, 0} => 10, {1, 0} => 11, {2, 0} => 12},
            player_ids: %{1 => "bob"},
            killed_bys: %{"jill" => "bob"},
            snake_penultimates: %{"b3" => {7, 7}}

  @type! t :: %BoardStatus{x_range: integer, y_range: integer}
end

defmodule TakeTurn do
  use TypeCheck

  def snake_crashed(hit_other_snake, prev_board, snake_id) do
    old_kills = prev_board.killed_bys
    ran_into = Enum.at(hit_other_snake, 0)
    new_killed = Map.put(old_kills, snake_id, ran_into)

    next_board = %{
      prev_board
      | :killed_bys => new_killed
    }

    {:reply, ran_into, next_board}
  end

  @spec! hit_a_wall(BoardStatus.t(), String.t()) :: {:reply, String.t(), BoardStatus.t()}
  def hit_a_wall(prev_board, snake_id) do
    old_kills = prev_board.killed_bys
    c_wall_kill = TheConsts.c_wall_kill()
    new_killed = Map.put(old_kills, snake_id, c_wall_kill)

    next_board = %{
      prev_board
      | :killed_bys => new_killed
    }

    # c_wall_kill = 123           ### this will crash the spec!
    {:reply, c_wall_kill, next_board}
  end

  def cleanup_trail(empties_front_rumps, a_slither, old_plots, prev_board) do
    %{
      :empty_plots => shrunk_emptys,
      :snake_fronts => new_fronts,
      :snake_rumps => new_rumps,
      :snake_penultimates => snake_penultimates,
      :moved_worm => moved_worm
    } = empties_front_rumps

    new_empty = MapSet.put(shrunk_emptys, a_slither.snake_rump)
    shortened_worm = MapSet.delete(moved_worm, a_slither.snake_rump)
    new_plots = Map.put(old_plots, a_slither.snake_id, shortened_worm)

    next_board = %{
      prev_board
      | :empty_plots => new_empty,
        :user_plots => new_plots,
        :snake_fronts => new_fronts,
        :snake_rumps => new_rumps,
              :snake_penultimates => snake_penultimates
    }

    {:reply, "no_crash", next_board}
  end

  def go_forward(prev_board, a_slither) do
    dbg({"B PENUL", a_slither.snake_penultimate})

    %{
      empty_plots: empty_plots,
      user_plots: user_plots,
      snake_rumps: snake_rumps,
      snake_penultimates: snake_penultimates,
      snake_fronts: snake_fronts
    } = prev_board

    empties_front_rumps =
      SnakeToBoard.board_move(
        snake_fronts,
        snake_rumps,
        snake_penultimates,
        empty_plots,
        user_plots,
        a_slither,
        a_slither.front_snake,
        a_slither.snake_penultimate
      )

    if a_slither.snake_cleanup do
      cleanup_trail(empties_front_rumps, a_slither, user_plots, prev_board)
    else
      new_plots = Map.put(user_plots, a_slither.snake_id, empties_front_rumps.moved_worm)

      %{
        empty_plots: new_empty,
        snake_fronts: new_fronts,
        snake_rumps: new_rumps,
              snake_penultimates: snake_penultimates
      } = empties_front_rumps

      next_board = %{
        prev_board
        | :empty_plots => new_empty,
          :user_plots => new_plots,
          :snake_fronts => new_fronts,
          :snake_rumps => new_rumps,
                snake_penultimates: snake_penultimates
      }

      {:reply, "no_crash", next_board}
    end
  end
end
