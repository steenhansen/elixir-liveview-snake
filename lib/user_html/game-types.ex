defmodule LiveUser do
  defstruct user_step: "step_1_collect_players",
            user_show_grid: false,
            user_tab: "b12: brother-game",
            user_name: "Bill",
            user_ping: 0,
            user_time_start: -43210,
            user_team: ["mounting"],
            user_is_mobile: false
end

# 
defmodule HtmlData do
  defstruct pid_board: %{},
            data_rotate: 0,
            data_tile_px: 11,
            data_rows: 22,
            data_w_px: 33,
            data_h_px: 44,
            data_rot_w_px: 55,
            data_rot_h_px: 66,
            data_scale: 1,
            data_offset_x: "0px",
            data_offset_y: "0px",
            data_rows_svg_inds: %{},
            data_rows_jump_inds: %{},
            data_jump_classes: %{},
            data_pid_tick: %{},
            data_jump_opacity: TheConsts.c_init_opacity_0(),
            data_colors: nil,
            data_alive: %{}
end

defmodule MatchChosens do
  defstruct chosen_frames_per_sec: 50,
            chosen_rotate: 0,
            chosen_length: 8,
            chosen_tile_width: 12,
            chosen_tile_height: 44,
           chosen_obstacles: [{1,7}, {1,8}, {1, 9}],
#  {0,0} {43,0} {43, 43} {0,43}
#  {22,22} 
   #         chosen_obstacles: [{0,0}],
            chosen_computers: 1
end

defmodule OptionalSelections do
  defstruct select_speed: "speed-fast",
            select_rotate: true,
            select_length: "length-long",
            select_surface: "surface-large",
            select_computers: "computers-2"
end
