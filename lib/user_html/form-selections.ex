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

    rotation_speed = TheConsts.c_rotation_rate()
    rotation_selection = select_rotate
    choice_rotation = if(rotation_selection == "true", do: rotation_speed, else: 0)

    frames_per_sec =
      case speed_selection do
        "speed-fast" -> TheConsts.c_speed_fast_50_a_sec()
        "speed-medium" -> TheConsts.c_speed_medium_25_a_sec()
        "speed-slow" -> TheConsts.c_speed_slow_12_5_a_sec()
      end





    %{"radio-movement" => movement_selection} = select_movement

  #  movement_type = movement_selection
    # movement_type = 
    #   case movement_selection do
    #     "movement-simple" -> TheConsts.c_length_long()
    #     "movement-average" -> TheConsts.c_length_medium()
    #     "movement-complex" -> TheConsts.c_length_short()
    #   end




    %{"radio-length" => length_selection} = select_length

    snake_length =
      case length_selection do
        "length-long" -> TheConsts.c_length_long()
        "length-medium" -> TheConsts.c_length_medium()
        "length-short" -> TheConsts.c_length_short()
      end






    %{"radio-surface" => surface_selection} = select_surface

    surface_x_y =
      case surface_selection do
        "surface-large" -> TheConsts.c_large_board()    #{44, 44}           # SURFACE-LARGE
        "surface-small" -> TheConsts.c_small_board()   #{22, 22}
        "surface-rectangle" -> TheConsts.c_rectangle_board()       #{12, 44}
        "surface-obstacles" -> TheConsts.c_obstacle_board() #       {44, 44}
      end

    {tile_width, tile_height} = surface_x_y

    obstacle_x_y =
      case surface_selection do
        "surface-large" -> [{}]
        "surface-small" -> [{}]
        "surface-rectangle" -> [{}]
#        "surface-obstacles" -> [{21,21}, {1,1}, {42,1}, {42,42}, {1,42}]   # test here
        "surface-obstacles" -> TheConsts.c_large_obstacles()
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
