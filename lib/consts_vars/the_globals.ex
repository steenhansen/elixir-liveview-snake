defmodule TheGlobals do
  def c_board_walls, do: [{}]        # [{43, 43}]


  # this must be at least 4 !
  def g_real_snake_len, do: 8     # def c_jump_states, do: 4
##qqqqqq



  # Samsung Galaxy S8+


  # 26x26  x=8 y=2

  # 22x12  x= y=0

  # 4 is the smallest MUST BE EVEN  44 
  def g_board_hor, do: 12           ## 26 smawll
  def g_board_ver, do: 22           ## 26 small

# 44 x 44 x_offset==8+9=17  
#         y_offset==2+13=15  browser_countdown


  # c_glacial
  # c_slow_super       
  # c_slow_12_5_a_sec
  # c_med_25_a_sec
  # c_fast_50_a_sec
  def g_frames_per_sec, do: TheConsts.c_med_25_a_sec()





  # 0 stop           60 med      120 slow
  def g_start_rotation, do: 0


  def g_num_computer, do: 1


  # def debug_board_4x1, do: 0

end





#  consts_vars


