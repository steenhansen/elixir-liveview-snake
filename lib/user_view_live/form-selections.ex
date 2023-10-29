defmodule FormSelections do
  def userChoices(phx_validate) do
    %{
      "_target" => _target,
      "select_speed" => select_speed,
      "select_rotate" => select_rotate,
      "select_length" => select_length,
      "select_surface" => select_surface,
      "select_computers" => select_computers,
      "select_movement" => select_movement
    } =
      phx_validate

    %{"radio-speed" => speed_selection} = select_speed

    rotation_speed = TheConsts.rotation_rate()
    rotation_selection = select_rotate
    choice_rotation = if(rotation_selection == "true", do: rotation_speed, else: 0)

    frames_per_sec =
      case speed_selection do
        "speed-fast" -> TheConsts.speed_fast()
        "speed-medium" -> TheConsts.speed_medium()
        "speed-slow" -> TheConsts.speed_slow()
      end

    %{"radio-movement" => movement_selection} = select_movement
    %{"radio-length" => length_selection} = select_length

    snake_length =
      case length_selection do
        "length-long" -> TheConsts.length_long()
        "length-medium" -> TheConsts.length_medium()
        "length-short" -> TheConsts.length_short()
      end

    %{"radio-surface" => surface_selection} = select_surface

    surface_x_y =
      case surface_selection do
        "surface-large" -> TheConsts.large_board()
        "surface-small" -> TheConsts.small_board()
        "surface-rectangle" -> TheConsts.rectangle_board()
        "surface-obstacles" -> TheConsts.obstacle_board()
      end

    nesw_left_offset =
      case surface_selection do
        "surface-large" -> TheConsts.large_left_offset()
        "surface-small" -> TheConsts.small_left_offset()
        "surface-rectangle" -> TheConsts.rectangle_left_offset()
        "surface-obstacles" -> TheConsts.obstacle_left_offset()
      end

    nesw_top_offset =
      case surface_selection do
        "surface-large" -> TheConsts.large_top_offset()
        "surface-small" -> TheConsts.small_top_offset()
        "surface-rectangle" -> TheConsts.rectangle_top_offset()
        "surface-obstacles" -> TheConsts.obstacle_top_offset()
      end

    {tile_width, tile_height} = surface_x_y

    obstacle_x_y =
      case surface_selection do
        "surface-large" -> [{}]
        "surface-small" -> [{}]
        "surface-rectangle" -> [{}]
        #        "surface-obstacles" -> [{21,21}, {1,1}, {42,1}, {42,42}, {1,42}]   # test here
        "surface-obstacles" -> TheConsts.large_obstacles()
      end

    %{"radio-computers" => computer_selection} = select_computers

    number_computers =
      case computer_selection do
        "computers-0" -> 0
        "computers-1" -> 1
        "computers-2" -> 2
        "computers-3" -> 3
        "computers-4" -> 4
        "computers-5" -> 5
        "computers-6" -> 6
        "computers-7" -> 7
        "computers-8" -> 8
      end

    seq_match_choices = %MatchChosens{
      chosen_frames_per_sec: frames_per_sec,
      chosen_rotate: choice_rotation,
      chosen_length: snake_length,
      chosen_tile_width: tile_width,
      chosen_control_offset: nesw_left_offset,
      chosen_top_control_offset: nesw_top_offset,
      chosen_tile_height: tile_height,
      chosen_obstacles: obstacle_x_y,
      chosen_computers: number_computers,
      chosen_movement: movement_selection
    }

    optional_selections = %OptionalSelections{
      select_speed: speed_selection,
      select_rotate: rotation_selection,
      select_length: length_selection,
      select_surface: surface_selection,
      select_computers: computer_selection,
      select_movement: movement_selection
    }

    {seq_match_choices, optional_selections}
  end
end
