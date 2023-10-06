#  https://elixir-lang.org/getting-started/typespecs-and-behaviours.html

# https://elixirschool.com/en/lessons/advanced/typespec

# defprotocol SnakePlayer do
#   @callback snakeId(pid) :: String.t()
#   @callback jumpSnake(pid, pid) :: any
# end

##################
defmodule BoardSnake do
  defstruct color_snake: 1,
            xys_set_snake: MapSet.new([{0, 1}, {1, 1}, {5, 1}]),
            front_snake: {1, 1},
            rump_snake: {4, 1},
            killed_snake: false,
            jump_snake: 0,
            leap_snake: Map.new()
end

defmodule SnakePlayer do
  @callback snakeId(pid) :: String.t()
  @callback jumpSnake(pid, pid) :: any
end

#  init_pixel ={2,2}
#  [{2, 2}, {2, 2}, {2, 2}, {2, 2}]
defmodule PlayerSnake do
  def initSnake(init_pixel) do
    _init_snake_xys_list =
      for _x <- 1..TheConsts.c_snake_len(),
          do: init_pixel
  end

  def isMoveHorizontal(new_front, pent_square) do
    {_front_x, front_y} = new_front
    {_pent_x, pent_y} = pent_square
    front_y == pent_y
  end

  def moveUp(x_front, y_front, height_game) do
    if y_front == 0 do
      {x_front, height_game - 1}
    else
      {x_front, y_front - 1}
    end
  end

  def moveRight(x_front, y_front, width_game) do
    if x_front == width_game - 1 do
      {0, y_front}
    else
      {x_front + 1, y_front}
    end
  end

  def moveDown(x_front, y_front, height_game) do
    if y_front == height_game - 1 do
      {x_front, 0}
    else
      {x_front, y_front + 1}
    end
  end

  def moveLeft(x_front, y_front, width_game) do
    if x_front == 0 do
      {width_game - 1, y_front}
    else
      {x_front - 1, y_front}
    end
  end
end
