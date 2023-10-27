defmodule MatrixGrid do
     use Norm


  @doc  """
         walled_matrix = %{{0, 0} => 0, {0, 1} => 0,          # NEW WAY 4  
                           {1, 0} => 0, {1, 1} => 1,
                           {2, 0} => 0, {2, 1} => 1 }
              
        snakes_pixels = %{    {1, 0} => 11,    {2, 0} => 22 }    

         snake_segments = (snakes_pixels
           |> Enum.map(fn(a_segment) ->
               {xy_coord, segment_color}= a_segment
               {xy_coord, segment_color} 
           end)  
          |> Map.new()   )


         # %{{1, 0} => 11, {2, 0} => 22}

          x = ( walled_matrix
               |> Enum.map(fn ({xy_coord, color_0_1})-> 
                      if Map.has_key?(snake_segments, xy_coord) do
                       snake_color = snake_segments[xy_coord]
                        {xy_coord, snake_color}
                      else 
                        {xy_coord, color_0_1}
                      end 
                 end)  |> Map.new()    )
         # %{ {0,0} => 0, {0,1} => 0, {1,0} => 11, {1,1}=> 1,       
         #    {2,0} => 22, {2,1} => 1,   {3,0} => 0, {3,1}=> 0      } 
       """
  def snakesToMatrix(m_walled_matrix, m_snakes_pixels) do
    m_snaked_matrix =
      m_walled_matrix
      |> Enum.map(fn {xy_coord, color_0_1} ->
        if Map.has_key?(m_snakes_pixels, xy_coord) do
          m_xySvgCss = m_snakes_pixels[xy_coord]

            {xy_coord, m_xySvgCss}
        else
          m_xySvgCss = %XySvgCss{svgCss_icon_ind: color_0_1, svgCss_css_jump: "no-jump"}
          {xy_coord, m_xySvgCss}
        end
      end)
      |> Map.new()

    m_snaked_matrix
  end

  @doc  """
          board_width = 1               #NEW WAY 1 == NEW WAY 2 !!!!!!!!!
          board_height = 1 
          all_empty =
             for x <- 0..board_width,
                 y <- 0..board_height,
                 into: Map.new(),
                 do: {{x, y}, 0}
       MapSet.new([{{0, 0}, 0}, {{0, 1}, 0}, {{1, 0}, 0}, {{1, 1}, 0}])
       """
         #@contract rgb_to_hex(r :: rgb(), g :: rgb(), b :: rgb()) :: hex()
# all_empty = %{
#   {38, 2} => %XySvgCss{svgCss_icon_ind: 0, svgCss_css_jump: "no-jump"}

  def emptyMatrix(board_width, board_height) do

#      user_schema = Norm.schema(%{
        
#      svgCss_icon_ind: spec(is_integer()),
#      svgCss_css_jump: spec(is_binary() and &(&1 > 0))
#  })



    all_empty =
      for x <- 0..board_width,
          y <- 0..board_height,
          into: MapSet.new(),
          do: {x, y}   
    all_empty
  end

  @doc  """
         board_walls = MapSet.new([{1, 1}, {2,1}])                               # NEW WAY 3
         empty_matrix = MapSet.new([{0,0}, {1,0}, {2,0}, {3,0},
                           {0,1}, {1,1}, {2,1}, {3,1}      ])
         x = ( empty_matrix
               |> Enum.map(fn (xy_coord)-> 
                      if MapSet.member?(board_walls,xy_coord) do
                        {xy_coord, 1}
                      else 
                        {xy_coord, 0}
                      end 
                 end)   |> Map.new()   )
       %{ {0,0} => 0, {1,0} => 0, {2,0} => 0, {3,0}=> 0,
          {0,1} => 0, {1,1} => 1, {2,1} => 1, {3,1}=> 0      } 
       """

  def walledMatrix(empty_matrix, board_walls) do
    walled_matrix =
      empty_matrix
      |> Enum.map(fn xy_coord ->
        if MapSet.member?(board_walls, xy_coord) do
          {xy_coord, 1}
        else
          {xy_coord, 0}
        end
      end)
      |> Map.new()

    walled_matrix
  end

  def asciiBoard(players_matrix, current_board) do
    as_lists =
      for y <- 0..current_board.board_height, into: [] do
        for x <- 0..current_board.board_width do
          players_matrix[y][x]
        end
      end

    _ascii_board =
      Enum.reduce(
        as_lists,
        "",
        fn row, acc_rows ->
          row_str =
            Enum.reduce(
              row,
              "\n",
              fn col, acc_cols ->
                col_str = to_string(col)
                acc_cols <> col_str
              end
            )

          acc_rows <> row_str
        end
      )

   # _ascii_board
  end
end
