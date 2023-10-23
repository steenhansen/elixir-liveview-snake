defmodule BoardSnake do
  defstruct boardSnake_color: 1,  
            boardSnake_xys: MapSet.new([{0, 1}, {1, 1}, {5, 1}]),  
            boardSnake_front: {1, 1}, 
            boardSnake_rump: {4, 1}, 
            boardSnake_killed: false, 
            boardSnake_jump: 0,       
            boardSnake_leap: Map.new()
end
