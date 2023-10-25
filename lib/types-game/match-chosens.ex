defmodule MatchChosens do
  defstruct chosen_frames_per_sec: TheConsts.c_speed_fast(),
            chosen_rotate: 0,
            chosen_length: TheConsts.c_length_long(),
            chosen_tile_width: TheConsts.c_max_hor(),
            chosen_tile_height: TheConsts.c_max_hor(),
            # default large 44x44
            chosen_control_offset: TheConsts.c_matrix_rectangle_left(),
            # default large 44x44
            chosen_top_control_offset: TheConsts.c_large_top_offset(),
            chosen_obstacles: [],
            chosen_computers: 1,
            chosen_movement: "movement-average"
end
