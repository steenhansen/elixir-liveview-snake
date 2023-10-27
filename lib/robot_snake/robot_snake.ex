defmodule RobotPlayer do
  @behaviour SnakePlayer

  use GenServer
  def snakeId(pid) do
    GenServer.call(pid, {:snakeId})
  end



  
  def snakeDead(pid) do
    GenServer.call(pid, {:snakeDead})
  end



  defp urdl_to_long(single_urdl) do
    case single_urdl do
      "U" -> "up"
      "R" -> "right"
      "D" -> "down"
      "L" -> "left"
    end
  end

    def winnerHead(pid_snake) do
    GenServer.call(pid_snake, {:winnerHead})
  end

  def start_link(start, snake_length) do
    GenServer.start_link(RobotPlayer, {start, snake_length})
  end

  def init({init_snake, snake_length}) do
    init_pixel = {init_snake.start_x, init_snake.start_y}
    init_snake_xys_list = PlayerSnake.initSnake(init_pixel, snake_length)

    robot_snake = %RobotSnake{
      robot_directions: init_snake.start_directions,
      robot_number: init_snake.start_number,
      snake_front: init_pixel,
      snake_xys_list: init_snake_xys_list,
      snake_dead: false
    }

    {:ok, robot_snake}
  end


  #

  def moveSnake2(robot_snake, pid_board) do
    snake_id = Integer.to_string(robot_snake.robot_number)
    head_direction = Enum.at(robot_snake.robot_directions, 0)

    if robot_snake.snake_dead do
      robot_snake
    else
      [board_width, board_height] = PlayingBoard.board_size(pid_board)
      [new_rump | new_body] = robot_snake.snake_xys_list
      {x_front, y_front} = robot_snake.snake_front

      new_front =
        case head_direction do
          "up" -> PlayerSnake.moveUp(x_front, y_front, board_height)
          "right" -> PlayerSnake.moveRight(x_front, y_front, board_width)
          "down" -> PlayerSnake.moveDown(x_front, y_front, board_height)
          "left" -> PlayerSnake.moveLeft(x_front, y_front, board_width)
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
        change_pid_user: snake_id,
        change_rump: new_rump,
        change_dead: false
      }

      ran_into = PlayingBoard.snake2Board(pid_board, robot_change)

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

  def jumpSnake(pid_snake, pid_board, chosen_movement) do
    GenServer.call(pid_snake, {:jumpSnake, pid_board,chosen_movement})
  end



  def handle_call({:snakeDead}, _, snake) do
    snake_dead = snake.snake_dead
    {:reply, snake_dead, snake}
  end


  def handle_call({:winnerHead}, _from, robot_snake) do
    if robot_snake.snake_dead do
      {:reply, false, robot_snake}
    else
      number_string = Integer.to_string(robot_snake.robot_number)
      winner_name = "Computer " <> number_string
      winner_front = robot_snake.snake_front
      snake_front_and_name = [winner_front, winner_name]

      {:reply, snake_front_and_name, robot_snake}
    end
  end

  def handle_call({:jumpSnake, pid_board, chosen_movement}, _from, robot_snake) do
    [head_direction | smaller_directions] = robot_snake.robot_directions
    moved_snake = moveSnake2(robot_snake, pid_board)

    if moved_snake.snake_dead do
      {:reply, moved_snake.snake_front, moved_snake}
    else
      if length(smaller_directions) == 0 do
        new_route =
          case head_direction do
            "up" -> RobotRoutes.going_up_routes(chosen_movement)
            "right" -> RobotRoutes.going_right_routes(chosen_movement)
            "down" -> RobotRoutes.going_down_routes(chosen_movement)
            "left" -> RobotRoutes.going_left_routes(chosen_movement)
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

    def handle_call({:snakeId}, _, snake) do
    robot_number = snake.robot_number
    snake_id = Integer.to_string(robot_number)
    {:reply, snake_id, snake}
  end


  
end
