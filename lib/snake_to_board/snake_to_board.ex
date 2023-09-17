defmodule SnakeToBoard do
  def hit_snake?(a_slither, the_emptys, snake_bodies) do
    _snake_hit =
      snake_bodies
      |> Enum.map(fn {the_name, snake_body} ->
        if a_slither.snake_id != the_name do
          if Enum.count(snake_body) > 0 do
            if MapSet.member?(snake_body, a_slither.front_snake) do
              the_name
            end
          end
        end
      end)
      |> Enum.filter(fn a_name -> a_name end)

    _snake_hit
  end

  def board_move(old_fronts, old_rumps, old_penultimates, old_emptys, old_plots, a_slither, front_snake, snake_penultimate) do
    snake_id = a_slither.snake_id
    new_fronts = Map.put(old_fronts, snake_id, front_snake)
    shrunk_emptys = Map.delete(old_emptys, front_snake)
    old_worm = old_plots[snake_id]
    
    new_rumps = Map.put(old_rumps, snake_id, a_slither.snake_rump)
new_penultimates = Map.put(old_penultimates, snake_id, snake_penultimate)

    moved_worm = MapSet.put(old_worm, front_snake)

    _moved_snake = %{
      :empty_plots => shrunk_emptys,
      :snake_fronts => new_fronts,
      :snake_rumps => new_rumps,
      :snake_penultimates => new_penultimates,
      :moved_worm => moved_worm,
      :snake_dead => a_slither.snake_dead
    }

    _moved_snake
  end
end
