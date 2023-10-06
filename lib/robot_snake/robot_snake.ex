defmodule RobotSnake do
  defstruct robot_directions: ["down", "down", "down"],
            robot_number: 1,
            snake_front: {-1, -1},
            snake_rump: {7, 11},
            snake_xys_list: [],
            snake_dead: false
end

defmodule RobotChange do
  defstruct change_front: {1, 2},
            change_rump: {3, 4},
            change_id: "1",
            change_dead: false,
             change_jump: 0,
            change_leap: Map.new()
end

defmodule RobotStart do
  defstruct start_directions: ["down", "down", "down"],
            start_number: 12,
            start_x: 5,
            start_y: 5
end

defmodule RobotRoutes do
  def left_10, do: "LLLLLLLLLLLLLLLLLLLLLLLL"

  def clockwise_10, do: "DRDRRDRDDLDLLDLLULLULUURURRURURR"

  def the_l, do: "DDDLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"

  def going_left_routes, do: [the_l(), left_10()]
end

defmodule RobotPlayer do
  @behaviour SnakePlayer

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
    GenServer.start_link(RobotPlayer, start)
  end

  def init(init_snake) do
    init_pixel = {init_snake.start_x, init_snake.start_y}
    init_snake_xys_list = PlayerSnake.initSnake(init_pixel)

    robot_snake = %RobotSnake{
      robot_directions: init_snake.start_directions,
      robot_number: init_snake.start_number,
      snake_front: init_pixel,
      snake_xys_list: init_snake_xys_list,
      snake_dead: false
    }

    {:ok, robot_snake}
  end

  def snakeId(pid) do
    GenServer.call(pid, {:snakeId})
  end

  def handle_call({:snakeId}, _, snake) do
    robot_number = snake.robot_number
    snake_id = Integer.to_string(robot_number)
    {:reply, snake_id, snake}
  end

  #

  def handle_call({:jumpSnake, pid_board}, _from, robot_snake) do
    [head_direction | smaller_directions] = robot_snake.robot_directions
    moved_snake = moveSnake2(robot_snake, pid_board)

    if moved_snake.snake_dead do
      {:reply, moved_snake.snake_front, moved_snake}
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
          robot_snake
          | snake_front: moved_snake.snake_front,
            snake_xys_list: moved_snake.snake_xys_list,
            robot_directions: urdl_route
        }

        {:reply, moved_snake.snake_front, moved_snake}
      else
        moved_snake = %{
          robot_snake
          | snake_front: moved_snake.snake_front,
            snake_xys_list: moved_snake.snake_xys_list,
            robot_directions: smaller_directions
        }

        {:reply, moved_snake.snake_front, moved_snake}
      end
    end
  end


  def moveSnake2(robot_snake, pid_board) do
    snake_id = Integer.to_string(robot_snake.robot_number)
    head_direction = Enum.at(robot_snake.robot_directions, 0)
    if robot_snake.snake_dead do
      robot_snake
    else
      [width_game, height_game] = GameBoard.board_size(pid_board)
      [new_rump | new_body] = robot_snake.snake_xys_list
      {x_front, y_front} = robot_snake.snake_front

      new_front =
        case head_direction do
          "up" -> PlayerSnake.moveUp(x_front, y_front, height_game)
          "right" -> PlayerSnake.moveRight(x_front, y_front, width_game)
          "down" -> PlayerSnake.moveDown(x_front, y_front, height_game)
          "left" -> PlayerSnake.moveLeft(x_front, y_front, width_game)
        end
      new_snake_xys_list = new_body ++ [new_front]
      the_moved_snake = %{
        robot_snake
        | snake_front: new_front,
          snake_rump: new_rump,
          snake_xys_list: new_snake_xys_list
      }

      robot_change = %RobotChange{
        change_front: new_front,
        change_id: snake_id,
        change_rump: new_rump,
        change_dead: false
      }
      ran_into = GameBoard.snake2Board(pid_board, robot_change)
      if ran_into == "no_crash" do
        _moved_snake = %{
          the_moved_snake
          | snake_dead: false
        }
      else
        _moved_snake = %{
          the_moved_snake
          | snake_dead: true
        }
      end
    end
  end


  def jumpSnake(pid_snake, pid_board) do
    GenServer.call(pid_snake, {:jumpSnake, pid_board})
  end


  def winnerHead(pid_snake) do
    GenServer.call(pid_snake, {:winnerHead})
  end

  def handle_call({:winnerHead}, _from, robot_snake) do
    if robot_snake.snake_dead do
      {:reply, false, robot_snake}
    else
      {:reply, robot_snake.snake_front, robot_snake}
    end
  end



end
