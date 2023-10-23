defmodule MatchChosens do
  defstruct chosen_frames_per_sec: TheConsts.c_speed_fast_50_a_sec(),
            chosen_rotate: 0,
            chosen_length: 16,
            chosen_tile_width: 44,
            chosen_tile_height: 44,
            chosen_obstacles: [],
            chosen_computers: 1,
            chosen_movement: "movement-average"
end
