defmodule MatrixGrid do
  @doc since: """
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
  def snakesToMatrix(walled_matrix, snakes_pixels) do
    snake_segments =
      snakes_pixels
      |> Enum.map(fn a_segment ->
        {xy_coord, segment_color} = a_segment
        {xy_coord, segment_color}
      end)
      |> Map.new()

    snaked_matrix =
      walled_matrix
      |> Enum.map(fn {xy_coord, color_0_1} ->
        if Map.has_key?(snake_segments, xy_coord) do
          snake_color = snake_segments[xy_coord]
          {xy_coord, snake_color}
        else
          {xy_coord, color_0_1}
        end
      end)
      |> Map.new()

    # end

    snaked_matrix
  end

  @doc since: """
          x_range = 1               #NEW WAY 1 == NEW WAY 2 !!!!!!!!!
          y_range = 1 
          all_empty =
             for x <- 0..x_range,
                 y <- 0..y_range,
                 into: Map.new(),
                 do: {{x, y}, 0}
       MapSet.new([{{0, 0}, 0}, {{0, 1}, 0}, {{1, 0}, 0}, {{1, 1}, 0}])
       """
  # bart
  def emptyMatrix(x_range, y_range) do
    all_empty =
      for x <- 0..x_range,
          y <- 0..y_range,
          into: MapSet.new(),
          do: {x, y}

    all_empty
  end

  @doc since: """
         wall_plots = MapSet.new([{1, 1}, {2,1}])                               # NEW WAY 3
         empty_matrix = MapSet.new([{0,0}, {1,0}, {2,0}, {3,0},
                           {0,1}, {1,1}, {2,1}, {3,1}      ])
         x = ( empty_matrix
               |> Enum.map(fn (xy_coord)-> 
                      if MapSet.member?(wall_plots,xy_coord) do
                        {xy_coord, 1}
                      else 
                        {xy_coord, 0}
                      end 
                 end)   |> Map.new()   )
       %{ {0,0} => 0, {1,0} => 0, {2,0} => 0, {3,0}=> 0,
          {0,1} => 0, {1,1} => 1, {2,1} => 1, {3,1}=> 0      } 
       """
  # bart
  def walledMatrix(empty_matrix, wall_plots) do
    walled_matrix =
      empty_matrix
      |> Enum.map(fn xy_coord ->
        if MapSet.member?(wall_plots, xy_coord) do
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
      for y <- 0..current_board.y_range, into: [] do
        for x <- 0..current_board.x_range do
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

    _ascii_board
  end
end
