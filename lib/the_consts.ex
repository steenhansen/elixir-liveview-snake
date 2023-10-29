defmodule TheConsts do
  def max_players, do: 9

  def freeze_wait, do: 20
  def winner_wait, do: 10

  def from_plain_to_hor_jump, do: 5
  def from_plain_to_ver_jump, do: 7

  def not_jumping, do: "no-jump"

  def scaling_steps, do: 80

  def two_players, do: 2

  def glacial_frames, do: 10000
  def very_slow_frames, do: 1000

  # 1000/160==6.25 frames a second
  def frames_6_25_a_sec, do: 160
  def frames_12_5_a_sec, do: 80
  def frames_25_a_sec, do: 40

  # too fast for heroku
  def frames_50_a_sec, do: 20

  def speed_slow, do: frames_6_25_a_sec()
  def speed_medium, do: frames_12_5_a_sec()
  def speed_fast, do: frames_25_a_sec()

  def count_down_second, do: 2000

  # turns into 16
  def length_long, do: 15
  # turns into 8
  def length_medium, do: 7
  # turns into 4
  def length_short, do: 3

  # 8+1border TheConsts.tile_pixels
  def tile_visible, do: 8

  # 8+1border TheConsts.tile_pixels
  def tile_pixels, do: tile_visible() + 1

  # 0 stop           60 med      120 slow
  def rotation_rate, do: 120

  def jump_states, do: 4

  # def  ==> computer

  def start_follow, do: 20

  # s=>snake

  def wall_kill, do: "--wall--killed--"

  #   -wall-killed-

  def head_svg_offset, do: 0
  def midl_svg_offset, do: 1
  def tail_svg_offset, do: 2
  def dead_svg_offset, do: 3
  #

  def init_opacity_0,
    do: %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}

  def max_hor, do: 44

  def large_board, do: {max_hor(), max_hor()}

  def small_board, do: {22, 22}
  def rectangle_board, do: {12, 44}
  def obstacle_board, do: {max_hor(), max_hor()}

  def large_left_offset, do: "230px"
  def small_left_offset, do: "125px"
  def rectangle_left_offset, do: "230px"
  def obstacle_left_offset, do: "230px"

  def large_top_offset, do: "500px"
  def small_top_offset, do: "250px"
  def rectangle_top_offset, do: "410px"
  def obstacle_top_offset, do: "500px"

  def matrix_rectangle_left, do: "240px"
  def matrix_regular_left, do: "84px"

  #  def large_obstacles, do: [{21, 21}, {1, 1}, {42, 1}, {42, 42}, {1, 42}]
  def large_obstacles,
    do: [
      {1, 1},
      {2, 2},
      {3, 3},
      {42, 1},
      {41, 2},
      {40, 3},
      {42, 42},
      {41, 41},
      {40, 40},
      {1, 42},
      {2, 41},
      {3, 40}
    ]

  @doc """
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

  def no_jump, do: "no-jump"
  def ver_jump, do: "ver-jump"
  def hor_jump, do: "hor-jump"

  def convert_color_id_to_rgb,
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
