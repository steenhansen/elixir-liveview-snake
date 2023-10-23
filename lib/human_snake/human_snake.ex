
defmodule HumanPlayer do
  @behaviour SnakePlayer

  use GenServer

  def start_link(start, snake_length) do
    GenServer.start_link(HumanPlayer, {start, snake_length})
  end

  def init({init_human, snake_length}) do
    init_pixel = {init_human.start_x, init_human.start_y}
    init_human_xys_list = PlayerSnake.initSnake(init_pixel, snake_length)

    human_snake = %HumanSnake{
      human_direction: init_human.start_direction,
      human_name: init_human.start_name,
      snake_front: init_pixel,
      snake_rump: nil,
      snake_xys_list: init_human_xys_list,
      snake_dead: false,
      human_jump: 0,
      human_leap: Map.new(),
      human_pid_user: init_human.pid_user,
      game_name: init_human.game_name
    }

    {:ok, human_snake}
  end

  def jump_over(pid_snake) do
    GenServer.cast(pid_snake, {:jump_over})
  end

    def snakeDead(pid) do
    GenServer.call(pid, {:snakeDead})
  end

  

  def snakeId(pid) do
    GenServer.call(pid, {:snakeId})
  end
  def winnerHead(pid_snake) do
    GenServer.call(pid_snake, {:winnerHead})
  end


  def jumpSnake(pid_snake, pid_board) do
    GenServer.call(pid_snake, {:jumpSnake, pid_board})
  end

  def change_direction(pid_snake, new_direction) do
    GenServer.cast(pid_snake, {:change_direction, new_direction})
  end

  def handle_cast({:change_direction, new_direction}, old_snake) do
    old_direction = old_snake.human_direction
    new_old_dir = {old_direction, new_direction}
    changed_snake = %HumanSnake{old_snake | human_direction: new_direction}

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

  def handle_cast({:jump_over}, sliding_snake) do
    start_jump = TheConsts.c_jump_states()
    jumping_snake = %HumanSnake{sliding_snake | human_jump: start_jump}
    {:noreply, jumping_snake}
  end






  def add_slice(human_snake, snake_front) do
    human_direction = human_snake.human_direction
    human_jump = human_snake.human_jump
    old_leap = human_snake.human_leap

    slice_is_vertical =
      cond do
        human_direction == "up" -> true
        human_direction == "down" -> true
        true -> false
      end

    slice_is_start = human_jump == TheConsts.c_jump_states()
    jump_slice = %JumpSlice{slice_vertical: slice_is_vertical, slice_start: slice_is_start}
    _new_leap = Map.put(old_leap, snake_front, jump_slice)
  end

 

  def jumpedSnake2(human_snake) do
    if human_snake.human_jump > 0 do
      new_leap = HumanPlayer.add_slice(human_snake, human_snake.snake_front)

      _jumped_snake = %{
        human_snake
        | human_leap: new_leap
      }
    else
      the_rump = human_snake.snake_rump
      new_leap = Map.delete(human_snake.human_leap, the_rump)
      _normal_snake = %{human_snake | human_leap: new_leap}
    end
  end

  def moveSnake2(human_snake, pid_board) do
    #snake_id = human_snake.human_name
    head_direction = human_snake.human_direction
    snake_jump = human_snake.human_jump

    if human_snake.snake_dead do
      human_snake
    else
      [board_width, board_height] = GameBoard.board_size(pid_board)
      [new_rump | new_body] = human_snake.snake_xys_list
      {x_front, y_front} = human_snake.snake_front

      new_front =
        case head_direction do
          "up" -> PlayerSnake.moveUp(x_front, y_front, board_height)
          "right" -> PlayerSnake.moveRight(x_front, y_front, board_width)
          "down" -> PlayerSnake.moveDown(x_front, y_front, board_height)
          "left" -> PlayerSnake.moveLeft(x_front, y_front, board_width)
        end

      new_snake_xys_list = new_body ++ [new_front]

      the_moved_snake = %{
        human_snake
        | snake_front: new_front,
          snake_rump: new_rump,
          snake_xys_list: new_snake_xys_list
      }

      ###################################
      the_jumped_snake = jumpedSnake2(the_moved_snake)

      human_change = %HumanChange{
        change_front: new_front,
        change_pid_user: human_snake.human_pid_user, # qbert
        change_rump: new_rump,
        change_dead: false,
        change_jump: snake_jump,
        change_leap: the_jumped_snake.human_leap
      }

      ##############################
      ran_into = GameBoard.snake2Board(pid_board, human_change)

      if ran_into == "no_crash" do
        _moved_snake = %{
          the_moved_snake
          | snake_dead: false
        }
      else
        _moved_snake = %{
          the_moved_snake
          | snake_dead: true,
            human_jump: 0,
            human_leap: Map.new()
        }
      end
    end
  end



  def handle_call({:winnerHead}, _from, human_snake) do
    if human_snake.snake_dead do
      {:reply, false, human_snake}
    else
      winner_name = human_snake.human_name
      winner_front = human_snake.snake_front
      snake_front_and_name = [winner_front, winner_name]
      {:reply, snake_front_and_name, human_snake}
    end
  end


 def handle_call({:jumpSnake, pid_board}, _from, human_snake) do
    human_jump = human_snake.human_jump
    old_leaps = human_snake.human_leap
    moved_snake = moveSnake2(human_snake, pid_board)
    snake_front = moved_snake.snake_front
    if moved_snake.snake_dead do
      {:reply, snake_front, moved_snake}
    else
      if human_jump > 0 do
        new_leap = add_slice(human_snake, snake_front)
        new_jump = human_jump - 1
        jumped_snake = %HumanSnake{
          moved_snake
          | human_jump: new_jump,
            human_leap: new_leap
        }
        {:reply, snake_front, jumped_snake}
      else
        the_rump = moved_snake.snake_rump
        new_leap = Map.delete(old_leaps, the_rump)
        normal_snake = %HumanSnake{moved_snake | human_leap: new_leap}
        {:reply, snake_front, normal_snake}
      end
    end
  end



     def handle_call({:snakeId}, _, snake) do
    snake_id = snake.human_name
    {:reply, snake_id, snake}
  end

    

  def handle_call({:snakeDead}, _, snake) do
    snake_dead = snake.snake_dead
    {:reply, snake_dead, snake}
  end



end
