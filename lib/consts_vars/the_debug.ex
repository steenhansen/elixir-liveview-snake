defmodule TheDebug do
  @doc since: """
       to make a 4 x 1 game board to view states in console
            def debug_board_4x1, do: 0

       to run normally, comment out
           # def debug_board_4x1, do: 0

          
                TheConsts.c_board_hor()
                TheConsts.c_board_ver()

       """

   #def debug_board_4x1, do: 0

  def smallTestTable(from_func, normal_val, small_test_val) do
    if normal_val == small_test_val do
     # db g({"something is amiss", from_func, normal_val, small_test_val})
    end
    is_func_exported = function_exported?(TheDebug, :debug_board_4x1, 0)
    maybe_test_val =
      if(is_func_exported,
        do: small_test_val,
        else: normal_val
      )

 
    maybe_test_val
  end

  # below makes the board state down 
  #   to sets of 4x1=4 tiles
  #   from 44x44=1936 tiles



  # have only one row of tiles
  def d_makeAllRows, do: 0

  # only produce 4 columns of tiles
  def d_max_hor, do: 4

  # max snake size is 4 tiles +1
  def d_snake_len, do: 3

  # board is 4 tiles wide
  def d_board_hor, do: 4

  # board is 1 tile tall
  def d_board_ver, do: 1
end
