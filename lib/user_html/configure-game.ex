defmodule ConfigureGame do
  def configure_game(seq_match_choices) do
    %MatchChosens{
      chosen_frames_per_sec: _chosen_frames_per_sec,
      chosen_rotate: _chosen_rotate,
      chosen_tile_width: chosen_tile_width,
      chosen_tile_height: chosen_tile_height,
      chosen_obstacles: _chosen_obstacles,
      chosen_computers: _chosen_computers
    } =
      seq_match_choices

    size_board_hor_px = chosen_tile_width * TheConsts.c_tile_pixels()
    size_board_ver_px = chosen_tile_height * TheConsts.c_tile_pixels()

    size_last_hor = chosen_tile_width - 1
    size_last_ver = chosen_tile_height - 1
    size_nw_hor = trunc(chosen_tile_width * 1 / 3)
    size_nw_ver = trunc(chosen_tile_height * 1 / 3)
    size_ne_hor = trunc(chosen_tile_width * 1 / 3)
    size_ne_ver = trunc(chosen_tile_height * 2 / 3)
    size_se_hor = trunc(chosen_tile_width * 2 / 3)
    size_se_ver = trunc(chosen_tile_height * 2 / 3)
    size_sw_hor = trunc(chosen_tile_width * 1 / 3)
    size_sw_ver = trunc(chosen_tile_height * 2 / 3)
    size_center_x = trunc(chosen_tile_width / 2)
    size_center_y = trunc(chosen_tile_height / 2)

    seq_game_sizes = %GameSizes{
      size_board_hor: chosen_tile_width,
      size_board_ver: chosen_tile_height,
      size_board_hor_px: size_board_hor_px,
      size_board_ver_px: size_board_ver_px,
      size_last_hor: size_last_hor,
      size_last_ver: size_last_ver,
      size_nw_hor: size_nw_hor,
      size_nw_ver: size_nw_ver,
      size_ne_hor: size_ne_hor,
      size_ne_ver: size_ne_ver,
      size_se_hor: size_se_hor,
      size_se_ver: size_se_ver,
      size_sw_hor: size_sw_hor,
      size_sw_ver: size_sw_ver,
      size_center_x: size_center_x,
      size_center_y: size_center_y
    }

    start_locations = %{
      0 => {0, 0, "right"},
      1 => {size_last_hor, 0, "down"},
      2 => {size_last_hor, size_last_ver, "left"},
      3 => {0, size_last_ver, "up"},
      4 => {size_nw_hor, size_nw_ver, "right"},
      5 => {size_ne_hor, size_ne_ver, "down"},
      6 => {size_se_hor, size_se_ver, "left"},
      7 => {size_sw_hor, size_sw_ver, "up"},
      8 => {size_center_x, size_center_y, "right"}
    }

    {seq_game_sizes, start_locations}
  end
end
