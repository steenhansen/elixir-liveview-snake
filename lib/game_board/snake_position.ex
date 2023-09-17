defmodule SnakePosition do
  def snake_to_board({:snake_matrix}, prev_board) do
 dbg({" 3 penultimate", prev_board.snake_penultimates})
    %{
      user_plots: user_plots,
      player_colors: player_colors,
      snake_fronts: snake_fronts,
      snake_rumps: snake_rumps,
      killed_bys: killed_bys,
      snake_penultimates: snake_penultimates
    } = prev_board

    snakes_pixels =
      BaseSnake.snakeColors(user_plots, player_colors, snake_fronts, snake_rumps, killed_bys, snake_penultimates)  ### (prev_board) !!!

    current_matrix =
      MatrixGrid.emptyMatrix(prev_board.x_range, prev_board.y_range)
      |> MatrixGrid.walledMatrix(prev_board.wall_plots)
      |> MatrixGrid.snakesToMatrix(snakes_pixels)

      #dbg({"33", current_matrix})
    {:reply, current_matrix, prev_board}
  end

  def move_snake({:snake_move, a_slither}, prev_board) do
  #  dbg(a_slither)
    %{empty_plots: empty_plots, wall_plots: wall_plots, user_plots: user_plots} = prev_board
    hit_other_snake = SnakeToBoard.hit_snake?(a_slither, empty_plots, user_plots)

    if length(hit_other_snake) > 0 do
      TakeTurn.snake_crashed(hit_other_snake, prev_board, a_slither.snake_id)
    else
      hit_wall = MapSet.member?(wall_plots, a_slither.front_snake)

      if hit_wall do
        TakeTurn.hit_a_wall(prev_board, a_slither.snake_id)
      else
        front_empty = MapSet.member?(empty_plots, a_slither.front_snake)

        if front_empty do
          TakeTurn.go_forward(prev_board, a_slither)
        else
          {:reply, "no_crash", prev_board}
        end
      end
    end
  end
end
