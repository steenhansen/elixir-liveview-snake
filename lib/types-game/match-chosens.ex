defmodule MatchChosens do
  defstruct chosen_frames_per_sec: TheConsts.speed_fast(),
            chosen_rotate: 0,
            chosen_length: TheConsts.length_long(),
            chosen_tile_width: TheConsts.max_hor(),
            chosen_tile_height: TheConsts.max_hor(),
            # default large 44x44
            chosen_control_offset: TheConsts.matrix_rectangle_left(),
            # default large 44x44
            chosen_top_control_offset: TheConsts.large_top_offset(),
            chosen_obstacles: [],
            chosen_computers: 1,
            chosen_movement: "movement-average"
end
