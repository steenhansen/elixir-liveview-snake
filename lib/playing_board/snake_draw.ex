defmodule SnakeDraw do
  def robot_to_board({:place_robot, a_number}, prev_board) do
    number_str = Integer.to_string(a_number)
    old_colors = prev_board.board_colors
    old_board_ids = prev_board.board_ids

    player_id = Enum.count(old_colors) + 1
    new_ids = Map.put(old_board_ids, player_id, number_str)
    new_colors = Map.put(old_colors, number_str, player_id)
    old_board_snakes_xys = prev_board.board_snakes_xys

    new_plots = Map.put(old_board_snakes_xys, number_str, MapSet.new())

    old_fronts = prev_board.board_fronts
    new_fronts = Map.put(old_fronts, number_str, Map.new())

    old_rumps = prev_board.board_rumps
    new_rumps = Map.put(old_rumps, number_str, Map.new())
    
    old_deads = prev_board.board_deads
    new_deads = Map.put(old_deads, number_str, Map.new())

    old_jumps = prev_board.board_jumps
    new_jumps = Map.put(old_jumps, number_str, Map.new())


    old_leaps = prev_board.board_leaps
    new_leaps = Map.put(old_leaps, number_str, Map.new())

    next_board = %ServerBoard{
      prev_board
      | board_colors: new_colors,
        board_fronts: new_fronts,
        board_rumps: new_rumps,
              board_deads: new_deads,
        board_jumps: new_jumps,
        board_leaps: new_leaps,
        board_snakes_xys: new_plots,
        board_ids: new_ids
    }

    {:noreply, next_board}
  end

  def human_to_board({:place_player, pid_user}, prev_board) do


    old_colors = prev_board.board_colors
    old_board_ids = prev_board.board_ids

    player_id = Enum.count(old_colors) + 1
    new_ids = Map.put(old_board_ids, player_id, pid_user)
    new_colors = Map.put(old_colors, pid_user, player_id)
    old_board_snakes_xys = prev_board.board_snakes_xys
    new_plots = Map.put(old_board_snakes_xys, pid_user, MapSet.new())


    next_board = %ServerBoard{
      prev_board
      | board_colors: new_colors,
        board_snakes_xys: new_plots,
        board_ids: new_ids
    }

    {:noreply, next_board}
  end

  def hit_snake?(snake_change, _the_emptys, snake_bodies) do
    _snake_hit =
      snake_bodies
      |> Enum.map(fn {pid_user, snake_body} ->
          if Enum.count(snake_body) > 0 do
             front_hit_other = MapSet.member?(snake_body, snake_change.change_front)
             snake_not_jump = snake_change.change_jump==0

            if front_hit_other and snake_not_jump do
              pid_user
            end
          end
      end)
      |> Enum.filter(fn a_name -> a_name end)


  end
end
