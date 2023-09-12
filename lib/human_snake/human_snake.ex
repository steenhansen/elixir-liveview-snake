defmodule StartPerson do
  defstruct snake_direction: "up",
            game_moniker: "game-name",
            snake_name: "snake_name",
            snake_x: 3,
            snake_y: 4,
            dead_stop: false
end

defmodule PersonSnake do
  defstruct snake_direction: "up",
           game_moniker: "game-name",
            snake_name: "snake_nameX",
            front_snake: {-1, -1},
            snake_path: [],
            dead_stop: false
end

# defmodule HumanSlither do
#   defstruct front_snake: {1, 2},
#             snake_rump: {3, 4},
#             snake_cleanup: true,
#             snake_name: "snake_name"
# end









defmodule HumanSnake do
  @behaviour Snakeplayer

  use GenServer

  def start_link(start) do
    GenServer.start_link(HumanSnake, start)
  end

  def init(init_snake) do 
     init_pixel = {init_snake.snake_x, init_snake.snake_y}
    init_snake_path = BaseSnake.initSnake(init_pixel)
    human_snake = %PersonSnake{
      snake_direction: init_snake.snake_direction,
      game_moniker: init_snake.game_moniker,
      snake_name: init_snake.snake_name,
      front_snake: init_pixel,
      snake_path: init_snake_path,
      dead_stop: false
    }
    {:ok, human_snake}
  end

  # ############################################

  def snakeId(pid) do
    GenServer.call(pid, {:snakeId})
  end
  def slither_move(pid_snake, pid_board) do
    GenServer.call(pid_snake, {:slither_move, pid_board})
  end
  ### below 
  def handle_call({:snakeId}, _, snake) do
    snake_id = snake.snake_name
    {:reply, snake_id, snake}
  end



  def handle_call({:slither_move, pid_board}, _from, human_snake) do
    snake_id = human_snake.snake_name
    head_direction = human_snake.snake_direction
    moved_snake = BaseSnake.moveSnake(snake_id, pid_board, human_snake, head_direction)
    front_snake =  moved_snake.front_snake
        {:reply, front_snake, moved_snake}
  end

  def change_direction(pid_snake, new_direction) do
    GenServer.cast(pid_snake, {:change_direction, new_direction})
  end

  def handle_cast({:change_direction, new_direction}, old_snake) do
    old_direction = old_snake.snake_direction
    new_old_dir = {old_direction, new_direction}
    changed_snake = %{old_snake | snake_direction: new_direction}
    case new_old_dir do
      {"up", "up"} -> {:noreply, old_snake}
      {"up", "right"} -> {:noreply, changed_snake}
      {"up", "down"} -> {:noreply, old_snake}
      {"up", "left"} -> {:noreply, changed_snake}

      {"right", "up"} -> {:noreply, changed_snake}
      {"right", "right"} -> {:noreply, old_snake}
      {"right", "down"} -> {:noreply, changed_snake}
      {"right", "left"} -> {:noreply, old_snake}

      {"down", "up"} -> {:noreply, old_snake}
      {"down", "right"} -> {:noreply, changed_snake}
      {"down", "down"} -> {:noreply, old_snake}
      {"down", "left"} -> {:noreply, changed_snake}

      {"left", "up"} -> {:noreply, changed_snake}
      {"left", "right"} -> {:noreply, old_snake}
      {"left", "down"} -> {:noreply, changed_snake}
      {"left", "left"} -> {:noreply, old_snake}

      _ -> {:noreply, changed_snake}
    end
  end
end
