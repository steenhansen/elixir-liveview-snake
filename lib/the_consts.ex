defmodule TheConsts do
  # constants have 3

  # def c_ ==> computer
  def c_num_computer, do: 0
  def c_start_follow, do: 20

  # s=>snake

  def c_wall_kill, do: "--wall--killed--"

  #   -wall-killed-

  def c_wall_plots, do: [{0, 0}, {0, 3}]

  # 13    3 is really 4

  def c_real_snake_len, do: 3
  def c_snake_len, do: c_real_snake_len() - 1

  # TheConsts.c_board_hor
  # do not pass directly, so can change !!!!!!!!!!!  
  # 44 MUST BE EVEN
  def c_board_hor, do: 44
  # TheConsts.c_board_ver
  # 44
  def c_board_ver, do: 44

  def c_glacial, do: 10000
  def c_slow_super, do: 1000
  def c_slow_12_5_a_sec, do: 80
  def c_med_25_a_sec, do: 40
  def c_fast_50_a_sec, do: 20

  def frames_per_sec, do: c_slow_super()

  def c_head_col_offset, do: 0
  def c_midl_col_offset, do: 1
  def c_tail_col_offset, do: 2
  def c_dead_offset, do: 3
  #
  #  
  #
  #
  # 8+1border TheConsts.c_tile_pixels
  def c_tile_visible, do: 8

  # 8+1border TheConsts.c_tile_pixels
  def c_tile_pixels, do: TheConsts.c_tile_visible() + 1

  # TheConsts.c_board_hor_px
  def c_board_hor_px, do: TheConsts.c_board_hor() * TheConsts.c_tile_pixels()
  # TheConsts.c_board_ver_px
  def c_board_ver_px, do: TheConsts.c_board_ver() * TheConsts.c_tile_pixels()

  def c_do_rotation, do: false

  def c_start_rotation, do: 0
  # def c_start_rotation, do 0

  def init_opacity_0,
    do: %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}

  def convert_color_id_to_rgb,
    do: %{
      # red ########### yellow
      ### "223, 223 ,0",
      0 => "223, 0 ,0",
      # blue
      1 => "0, 0, 223",
      # green
      2 => "0, 223 ,0",
      # cyan
      3 => "0, 223, 223",
      # yellow #####red
      ## "223, 0 ,0",
      4 => "223, 223 ,0",
      # pink
      5 => "223, 0 ,223",
      # light blue
      6 => "0, 143 ,223",
      # purpl
      7 => "143, 0, 223",
      # orange
      # EXTRA
      8 => "223, 143 ,0"
    }

  #     def c_board_hor, do: 44     # TheConsts.c_board_hor
  # def c_board_ver, do: 44      # TheConsts.c_board_hor

  def c_last_hor, do: c_board_hor() - 1
  def c_last_ver, do: c_board_ver() - 1

  def c_nw_hor, do: trunc(c_board_hor() * 1 / 3)
  def c_nw_ver, do: trunc(c_board_ver() * 1 / 3)

  def c_ne_hor, do: trunc(c_board_hor() * 1 / 3)
  def c_ne_ver, do: trunc(c_board_ver() * 2 / 3)

  def c_se_hor, do: trunc(c_board_hor() * 2 / 3)
  def c_se_ver, do: trunc(c_board_ver() * 2 / 3)

  def c_sw_hor, do: trunc(c_board_hor() * 1 / 3)
  def c_sw_ver, do: trunc(c_board_ver() * 2 / 3)

  def c_center_x, do: trunc(c_board_hor() / 2)
  def c_center_y, do: trunc(c_board_ver() / 2)
  # 1                 2
  #      5         6
  #           9
  #     8          7
  # 4                  3

  def start_coord_dir,
    do: %{
      0 => {0, 1, "right"},
      1 => {TheConsts.c_last_hor(), 0, "down"},
      2 => {TheConsts.c_last_hor(), TheConsts.c_last_ver(), "left"},
      3 => {0, TheConsts.c_last_ver(), "up"},
      4 => {TheConsts.c_nw_hor(), TheConsts.c_nw_ver(), "right"},
      5 => {TheConsts.c_ne_hor(), TheConsts.c_ne_ver(), "down"},
      6 => {TheConsts.c_se_hor(), TheConsts.c_se_ver(), "left"},
      7 => {TheConsts.c_sw_hor(), TheConsts.c_sw_ver(), "up"},
      # extra
      8 => {TheConsts.c_center_x(), TheConsts.c_center_y(), "right"}
    }
end
