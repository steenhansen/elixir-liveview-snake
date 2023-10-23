#  https://elixir-lang.org/getting-started/typespecs-and-behaviours.html

# https://elixirschool.com/en/lessons/advanced/typespec


##################


defmodule SnakePlayer do
  @callback snakeId(pid) :: String.t()
    @callback snakeDead(pid) :: boolean()
 # @callback jumpSnake(pid, pid) :: any
end

#  init_pixel ={2,2}
#  [{2, 2}, {2, 2}, {2, 2}, {2, 2}]
defmodule PlayerSnake do
  def initSnake(init_pixel, snake_length) do
    _init_snake_xys_list =
      for _x <- 1..snake_length,
          do: init_pixel
  end


  def isMoveHorizontal(new_front, pent_square) do
    {_front_x, front_y} = new_front
    {_pent_x, pent_y} = pent_square
    front_y == pent_y
  end

  def moveUp(x_front, y_front, board_height) do
    if y_front == 0 do
      {x_front, board_height - 1}
    else
      {x_front, y_front - 1}
    end
  end

  def moveRight(x_front, y_front, board_width) do
    if x_front == board_width - 1 do
      {0, y_front}
    else
      {x_front + 1, y_front}
    end
  end

  def moveDown(x_front, y_front, board_height) do
    if y_front == board_height - 1 do
      {x_front, 0}
    else
      {x_front, y_front + 1}
    end
  end

  def moveLeft(x_front, y_front, board_width) do
    if x_front == 0 do
      {board_width - 1, y_front}
    else
      {x_front - 1, y_front}
    end
  end
end
