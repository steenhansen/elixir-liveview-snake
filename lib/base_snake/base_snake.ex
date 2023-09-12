#  https://elixir-lang.org/getting-started/typespecs-and-behaviours.html

# https://elixirschool.com/en/lessons/advanced/typespec

# defprotocol Snakeplayer do
#   @callback snakeId(pid) :: String.t()
#   @callback slither_move(pid, pid) :: any
# end

defmodule SnakeSlither do
  defstruct front_snake: {1, 2},
            snake_rump: {3, 4},
            snake_cleanup: true,
            snake_id: "1",
            snake_dead: false
end

defmodule Snakeplayer do
  @callback snakeId(pid) :: String.t()
  @callback slither_move(pid, pid) :: any
end

#  init_pixel ={2,2}
#  [{2, 2}, {2, 2}, {2, 2}, {2, 2}]
defmodule BaseSnake do
  def initSnake(init_pixel) do
    _init_snake_path =
      for _x <- 1..TheConsts.c_snake_len(),
          do: init_pixel
  end

  def moveSnake(snake_id, pid_board, a_snake, head_direction) do
    if a_snake.dead_stop do
      a_snake
    else
      [x_range, y_range] = GameBoard.board_size(pid_board)
      [tailpiece | new_tail] = a_snake.snake_path
      new_last = hd(new_tail)
      erasing_tail = new_last != tailpiece
      {x_front, y_front} = a_snake.front_snake
      # new_dir =
      #       case a_snake.snake_direction do
      #         "up" -> Enum.random(["right", "up", "left"])
      #         "right" -> Enum.random(["up", "down", "right"])
      #         "down" ->Enum.random(["down", "right", "left"])
      #         "left" -> Enum.random(["up", "left", "down"])
      #       end
      new_front =
        case head_direction do
          "up" -> BaseSnake.moveUp(x_front, y_front, y_range)
          "right" -> BaseSnake.moveRight(x_front, y_front, x_range)
          "down" -> BaseSnake.moveDown(x_front, y_front, y_range)
          "left" -> BaseSnake.moveLeft(x_front, y_front, x_range)
        end

      new_snake_path = new_tail ++ [new_front]

      a_slither = %SnakeSlither{
        front_snake: new_front,
        snake_id: snake_id,
        snake_rump: new_last,
        snake_cleanup: erasing_tail,
        snake_dead: false
      }

      ran_into = GameBoard.snake_move(pid_board, a_slither)

      if ran_into == "no_crash" do
        _moved_snake = %{
          a_snake
          | front_snake: new_front,
            snake_path: new_snake_path
        }
      else
        _moved_snake = %{
          a_snake
          | front_snake: new_front,
            dead_stop: true,
            snake_path: new_snake_path
        }
      end
    end
  end

  def moveUp(x_front, y_front, y_range) do
    if y_front == 0 do
      {x_front, y_range - 1}
    else
      {x_front, y_front - 1}
    end
  end

  def moveRight(x_front, y_front, x_range) do
    if x_front == x_range - 1 do
      {0, y_front}
    else
      {x_front + 1, y_front}
    end
  end

  def moveDown(x_front, y_front, y_range) do
    if y_front == y_range - 1 do
      {x_front, 0}
    else
      {x_front, y_front + 1}
    end
  end

  def moveLeft(x_front, y_front, x_range) do
    if x_front == 0 do
      {x_range - 1, y_front}
    else
      {x_front - 1, y_front}
    end
  end

  # we should have snake ends also, as the below mapSet have no order
  @doc since: """
         players_snakes = %{                         # NEW WAY  5   
             "jill" => MapSet.new([ {0,0}, {1,0}, {2,0}]),
             "bob" => MapSet.new([ {3,3}, {3,4}, {3,5}])
           }
         player_colors = %{"1" => 3, "jill" => 1, "bob" => 2}
         snake_fronts = %{"1" => MapSet.new([]), "jill" => {0,0}, "bob" => {3, 3}}
         snake_rumps = %{"1" => MapSet.new([]), "jill" => {2, 0}, "bob" => {3, 5}}
          
         GameBoard.snakeColors(players_snakes, player_colors, snake_fronts, snake_rumps) 

        %{ {0,0} => 10, {1,0} => 11, {2,0} => 12, {3,3} => 20, {3,4} => 21, {3,5} => 22  } 
       """
  def snakeColors(players_snakes, player_colors, snake_fronts, snake_rumps, killed_bys) do
    snake_segments =
      players_snakes
      |> Enum.map(fn {user_name, xy_coords} ->
        snake_color = player_colors[user_name]
        snake_front = snake_fronts[user_name]
        snake_rump = snake_rumps[user_name]
        killed_by = Map.get(killed_bys, user_name, 0)
        colorASnake16(snake_color, xy_coords, snake_front, snake_rump, killed_by)
      end)

    _merge_snakes_ =
      Enum.reduce(
        snake_segments,
        Map.new(),
        fn xy_colors, acc ->
          Map.merge(acc, xy_colors)
        end
      )
  end

  def possibleColors(player_color, killed_by) do
    if killed_by == 0 do
      head_color = player_color * 10 + TheConsts.c_head_col_offset()
      midl_color = player_color * 10 + TheConsts.c_midl_col_offset()
      tail_color = player_color * 10 + TheConsts.c_tail_col_offset()
      {head_color, midl_color, tail_color}
    else
      dead_color = player_color * 10 + TheConsts.c_dead_offset()
      head_color = dead_color
      midl_color = dead_color
      tail_color = dead_color
      {head_color, midl_color, tail_color}
    end
  end

  @doc since: """
         BaseSnake.colorASnake(1, MapSet.new([ {0,0}, {1,0}, {2,0}]), {0,0}, {2,0})
         {{0, 0}, 10}, {{1, 0}, 11}, {{2, 0}, 12}}
       """
  def colorASnake16(player_color, xy_coords, snake_front, snake_rump, killed_by) do
    {head_color, midl_color, tail_color} = possibleColors(player_color, killed_by)
    _colored_snake =
      xy_coords
      |> Enum.map(fn xy_coord ->
        case xy_coord do
          ^snake_front -> {xy_coord, head_color}
          _ -> {xy_coord, midl_color}
        end
      end)
      |> Map.new()
      |> Map.put(snake_rump, tail_color)
  end
end
