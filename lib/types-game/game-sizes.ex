defmodule GameSizes do
  defstruct size_board_hor: 41,
            size_board_ver: 42,
            size_board_left_indent: 84, # 240 for rectangle
            size_count_x_off: 17,
            size_count_y_off: 15,
            size_board_hor_px: 431,
            size_board_ver_px: 431,
            size_last_hor: 44 - 1,
            size_last_ver: 44 - 1,
            size_nw_hor: trunc(44 * 1 / 3),
            size_nw_ver: trunc(44 * 1 / 3),
            size_ne_hor: trunc(44 * 1 / 3),
            size_ne_ver: trunc(44 * 2 / 3),
            size_se_hor: trunc(44 * 2 / 3),
            size_se_ver: trunc(44 * 2 / 3),
            size_sw_hor: trunc(44 * 1 / 3),
            size_sw_ver: trunc(44 * 2 / 3),
            size_center_x: trunc(44 / 2),
            size_center_y: trunc(44 / 2)
end
