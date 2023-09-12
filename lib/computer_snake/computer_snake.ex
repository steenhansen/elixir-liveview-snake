defmodule StartComputer do
  defstruct snake_directions: ["down", "down", "down"],
            snake_number: 12,
            snake_x: 5,
            snake_y: 5,
            dead_stop: false
end

defmodule RobotSnake do
  defstruct snake_directions: ["down", "down", "down"],
            snake_number: 1,
            front_snake: {-1, -1},
            snake_path: [],
            dead_stop: false
end

defmodule RobotRoutes do
  def left_10, do: "LLLLLLLLLLLLLLLLLLLLLLLL"

  def clockwise_10, do: "DRDRRDRDDLDLLDLLULLULUURURRURURR"

  def the_l, do: "DDDLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"

  def going_left_routes, do: [the_l(), left_10()]
end

defmodule ComputerSnake do
  @behaviour Snakeplayer

  use GenServer

  defp urdl_to_long(single_urdl) do
    case single_urdl do
      "U" -> "up"
      "R" -> "right"
      "D" -> "down"
      "L" -> "left"
    end
  end

  def start_link(start) do
    GenServer.start_link(ComputerSnake, start)
  end

  def init(init_snake) do
    init_pixel = {init_snake.snake_x, init_snake.snake_y}
    init_snake_path = BaseSnake.initSnake(init_pixel)

    robot_snake = %RobotSnake{
      snake_directions: init_snake.snake_directions,
      snake_number: init_snake.snake_number,
      front_snake: init_pixel,
      snake_path: init_snake_path,
      dead_stop: false
    }

    {:ok, robot_snake}
  end

  def snakeId(pid) do
    GenServer.call(pid, {:snakeId})
  end

  def handle_call({:snakeId}, _, snake) do
    snake_number = snake.snake_number
    snake_id = Integer.to_string(snake_number)
    {:reply, snake_id, snake}
  end

  #

  def slither_move(pid_snake, pid_board) do
    GenServer.call(pid_snake, {:slither_move, pid_board})
  end

  def handle_call({:slither_move, pid_board}, _from, computer_snake) do
    [head_direction | smaller_directions] = computer_snake.snake_directions
    snake_id = Integer.to_string(computer_snake.snake_number)
    moved_snake = BaseSnake.moveSnake(snake_id, pid_board, computer_snake, head_direction)

    if moved_snake.dead_stop do
      {:reply, moved_snake.front_snake, moved_snake}
    else
      if length(smaller_directions) == 0 do
        new_route =
          case head_direction do
            "up" -> RobotRoutes.going_left_routes()
            "right" -> RobotRoutes.going_left_routes()
            "down" -> RobotRoutes.going_left_routes()
            "left" -> RobotRoutes.going_left_routes()
          end

        random_str = Enum.random(new_route)
        str_as_list = String.split(random_str, "", trim: true)
        urdl_route = Enum.map(str_as_list, &urdl_to_long(&1))

        moved_snake = %{
          computer_snake
          | front_snake: moved_snake.front_snake,
            snake_path: moved_snake.snake_path,
            snake_directions: urdl_route
        }

        {:reply, moved_snake.front_snake, moved_snake}
      else
        moved_snake = %{
          computer_snake
          | front_snake: moved_snake.front_snake,
            snake_path: moved_snake.snake_path,
            snake_directions: smaller_directions
        }

        {:reply, moved_snake.front_snake, moved_snake}
      end
    end
  end
end
