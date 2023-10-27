defmodule TheConsts do
  def c_max_players, do: 9

  def c_freeze_wait, do: 20
  def c_winner_wait, do: 10 

  def c_from_plain_to_hor_jump, do: 5
  def c_from_plain_to_ver_jump, do: 7

  def c_not_jumping, do: "no-jump"

  def c_scaling_steps, do: 80

  def c_two_players, do: 2

  def c_glacial_frames, do: 10000
  def c_very_slow_frames, do: 1000

  # 1000/160==6.25 frames a second
  def c_6_25_frames_a_sec, do: 160
  def c_12_5_frames_a_sec, do: 80
  def c_25_frames_25_a_sec, do: 40

  # too fast for heroku
  def c_50_frames_a_sec, do: 20


  def c_speed_slow, do: c_6_25_frames_a_sec()
  def c_speed_medium, do: c_12_5_frames_a_sec()
  def c_speed_fast, do: c_25_frames_25_a_sec()





  def c_count_down_second, do: 2000

  # turns into 16
  def c_length_long, do: 15
  # turns into 8
  def c_length_medium, do: 7
  # turns into 4
  def c_length_short, do: 3



  # 8+1border TheConsts.c_tile_pixels
  def c_tile_visible, do: 8

  # 8+1border TheConsts.c_tile_pixels
  def c_tile_pixels, do: TheConsts.c_tile_visible() + 1

  # 0 stop           60 med      120 slow
  def c_rotation_rate, do: 120



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

  def c_init_opacity_0,
    do: %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}

      def c_max_hor, do: 44
 

  def c_large_board, do: {c_max_hor(), c_max_hor()}
 
  def c_small_board, do: {22, 22}
  def c_rectangle_board, do: {12, 44}
  def c_obstacle_board, do: {c_max_hor(), c_max_hor()}

  def c_large_left_offset, do: "230px"
  def c_small_left_offset, do: "125px"
  def c_rectangle_left_offset, do: "230px"
  def c_obstacle_left_offset, do: "230px"

  def c_large_top_offset, do: "500px"
  def c_small_top_offset, do: "250px"
  def c_rectangle_top_offset, do: "410px"
  def c_obstacle_top_offset, do: "500px"

  def c_matrix_rectangle_left, do: "240px"
  def c_matrix_regular_left, do: "84px"

#  def c_large_obstacles, do: [{21, 21}, {1, 1}, {42, 1}, {42, 42}, {1, 42}]
  def c_large_obstacles, do: [ 
            {1, 1}, {2,2}, {3,3} ,
            {42, 1}, {41,2}, {40,3} ,
            {42, 42}, {41,41}, {40,40},
            {1, 42}, {2,41}, {3,40} ]



  @doc  """
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

  # constants have 3

  def c_no_jump, do: "no-jump"
  def c_ver_jump, do: "ver-jump"
  def c_hor_jump, do: "hor-jump"


   def c_convert_color_id_to_rgb,
    do: %{
      # red 
      0 => "223, 0 ,0",
      # blue
      1 => "0, 0, 223",
      # green
      2 => "0, 223 ,0",
      # yellow
      3 => "223, 223 ,0",
      # pink
      4 => "229, 107 ,134",
      # ORANGE
      5 => "223, 143 , 0",
      # Cyan
      6 => "0, 223 ,223",
      # purpl
      7 => "143, 0, 223",
      # Deep Sky
      8 => "0, 143 ,223"
    }

end
