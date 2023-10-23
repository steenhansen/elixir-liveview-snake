# 
defmodule HtmlData do
  defstruct pid_board: %{},
            data_pid_tick: %{},
            data_snake_dead: 0.9,  # maybe an opacity const?
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
            data_jump_opacity: TheConsts.c_init_opacity_0(),
            data_colors: "0,0,223",     # data_colors => data_rgb_color
            data_zooming: false
end