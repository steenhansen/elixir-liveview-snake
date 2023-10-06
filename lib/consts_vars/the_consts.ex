defmodule TheConsts do
  def c_from_plain_to_hor_jump, do: 5
  def c_from_plain_to_ver_jump, do: 7

  def c_not_jumping, do: "no-jump"

def c_scaling_steps, do: 100

def c_two_players, do: 2

  def c_glacial, do: 10000
  def c_slow_super, do: 1000
  def c_slow_12_5_a_sec, do: 80
  def c_med_25_a_sec, do: 40
  def c_fast_50_a_sec, do: 20

  def c_count_down_second, do: 2000


  def c_old_snake_len, do: TheGlobals.g_real_snake_len() - 1

  def c_max_hor() do
    real_max_hor = 44    #   to match tables ... TheGlobals.g_board_hor()
    test_max_hor = TheDebug.d_max_hor()
    max_hor_current = TheDebug.smallTestTable("c_max_hor() ", real_max_hor, test_max_hor)
    max_hor_current
  end

  def c_snake_len() do
    real_snake_len = TheGlobals.g_real_snake_len() - 1
    test_snake_len = TheDebug.d_snake_len()
    snake_len_current = TheDebug.smallTestTable("c_snake_len()", real_snake_len, test_snake_len)
    snake_len_current
  end

  def c_board_hor() do
    real_board_hor = TheGlobals.g_board_hor()
    test_board_hor = TheDebug.d_board_hor()
    board_hor_current = TheDebug.smallTestTable("c_board_hor()", real_board_hor, test_board_hor)
    board_hor_current
  end

  def c_board_ver() do
    real_board_ver = TheGlobals.g_board_ver()
    test_board_ver = TheDebug.d_board_ver()
    board_ver_current = TheDebug.smallTestTable("c_board_ver()", real_board_ver, test_board_ver)
    board_ver_current
  end

  # 8+1border TheConsts.c_tile_pixels
  def c_tile_visible, do: 8

  # 8+1border TheConsts.c_tile_pixels
  def c_tile_pixels, do: TheConsts.c_tile_visible() + 1
  # TheConsts.c_board_hor_px
  def c_board_hor_px, do: TheGlobals.g_board_hor() * TheConsts.c_tile_pixels()
  # TheConsts.c_board_ver_px
  def c_board_ver_px, do: TheGlobals.g_board_ver() * TheConsts.c_tile_pixels()

  # constants have 3


  def c_no_jump, do: "no-jump"
  def c_ver_jump, do: "ver-jump"
  def c_hor_jump, do: "hor-jump"

  @doc since: """
       jump state 0 = x x x x x

       jump state 4 = s M x x x
       jump state 3 = s M B x x
       jump state 2 = s s B M x
       jump state 1 = s s s M x
       jump state 0 = s s s s s

       human_jump starts at 4 then goes to 0
       with the head and pent segments
       getting growing to Medium and Big


       starts at 5-1=4 really

       """
  def c_jump_states, do: 4

  # def c_ ==> computer

  def c_start_follow, do: 20

  # s=>snake

  def c_wall_kill, do: "--wall--killed--"

  #   -wall-killed-

  def c_head_svg_offset, do: 0
  def c_midl_svg_offset, do: 1
  def c_tail_svg_offset, do: 2
  def c_dead_svg_offset, do: 3
  #
  #  
  #
  #

  ## def c_do_rotation, do: true

  def c_init_opacity_0,
    do: %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}

  #     def c_board_hor, do: 44     # TheConsts.c_board_hor
  # def c_board_ver, do: 44      # TheConsts.c_board_hor

  def c_last_hor, do: TheConsts.c_board_hor() - 1
  def c_last_ver, do: TheConsts.c_board_ver() - 1

  def c_nw_hor, do: trunc(TheConsts.c_board_hor() * 1 / 3)
  def c_nw_ver, do: trunc(TheConsts.c_board_ver() * 1 / 3)

  def c_ne_hor, do: trunc(TheConsts.c_board_hor() * 1 / 3)
  def c_ne_ver, do: trunc(TheConsts.c_board_ver() * 2 / 3)

  def c_se_hor, do: trunc(TheConsts.c_board_hor() * 2 / 3)
  def c_se_ver, do: trunc(TheConsts.c_board_ver() * 2 / 3)

  def c_sw_hor, do: trunc(TheConsts.c_board_hor() * 1 / 3)
  def c_sw_ver, do: trunc(TheConsts.c_board_ver() * 2 / 3)

  def c_center_x, do: trunc(TheConsts.c_board_hor() / 2)
  def c_center_y, do: trunc(TheConsts.c_board_ver() / 2)
  # 1                 2
  #      5         6
  #           9
  #     8          7
  # 4                  3

  def start_coord_dir,
    do: %{
      0 => {0, 0, "right"},
      1 => {TheConsts.c_last_hor(), 0, "down"},
      #2 => {1,1, "right"},
      2 => {TheConsts.c_last_hor(), TheConsts.c_last_ver(), "left"},
      3 => {0, TheConsts.c_last_ver(), "up"},
      4 => {TheConsts.c_nw_hor(), TheConsts.c_nw_ver(), "right"},
      5 => {TheConsts.c_ne_hor(), TheConsts.c_ne_ver(), "down"},
      6 => {TheConsts.c_se_hor(), TheConsts.c_se_ver(), "left"},
      7 => {TheConsts.c_sw_hor(), TheConsts.c_sw_ver(), "up"},
      # extra
      8 => {TheConsts.c_center_x(), TheConsts.c_center_y(), "right"}
    }



  def c_convert_color_id_to_rgb,
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


    end