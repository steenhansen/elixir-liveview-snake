defmodule PlaceSnake do
  def robot_to_board({:place_robot, a_number}, prev_board) do
    number_str = Integer.to_string(a_number)
    old_colors = prev_board.player_colors
    old_player_ids = prev_board.player_ids

    player_id = Enum.count(old_colors) + 1
    new_ids = Map.put(old_player_ids, player_id, number_str)
    new_colors = Map.put(old_colors, number_str, player_id)
    old_user_plots = prev_board.user_plots

    new_plots = Map.put(old_user_plots, number_str, MapSet.new())

    old_fronts = prev_board.snake_fronts
    new_fronts = Map.put(old_fronts, number_str, Map.new())

    old_rumps = prev_board.snake_rumps
    new_rumps = Map.put(old_rumps, number_str, Map.new())

    old_penultimates = prev_board.snake_penultimates
    new_penultimates = Map.put(old_penultimates, number_str, Map.new())

    next_board = %{
      prev_board
      | player_colors: new_colors,
        snake_fronts: new_fronts,
        snake_rumps: new_rumps,
        snake_penultimates: new_penultimates,
        user_plots: new_plots,
        player_ids: new_ids
    }

    {:noreply, next_board}
  end

  def human_to_board({:place_player, a_name}, prev_board) do
    old_colors = prev_board.player_colors
    old_player_ids = prev_board.player_ids

    player_id = Enum.count(old_colors) + 1
    new_ids = Map.put(old_player_ids, player_id, a_name)
    new_colors = Map.put(old_colors, a_name, player_id)
    old_user_plots = prev_board.user_plots
    new_plots = Map.put(old_user_plots, a_name, MapSet.new())

    next_board = %{
      prev_board
      | player_colors: new_colors,
        user_plots: new_plots,
        player_ids: new_ids
    }

    {:noreply, next_board}
  end
end
