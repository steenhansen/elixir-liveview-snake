defmodule ListToXy do

  def makeARow(players_matrix, width_game, the_row) do

 columns_current = width_game - 1

    _the_row =
      for x <- 0..columns_current, into: %{} do
        xy_in_game? = Map.has_key?(players_matrix, {x, the_row})
        if xy_in_game? do
          m_xySvgCss = players_matrix[{x, the_row}]
           {x, m_xySvgCss}

        else
          m_xySvgCss = %XySvgCss{  svg_index: 0 ,  css_jump: TheConsts.c_no_jump() }
          {x, m_xySvgCss}
        end
      end

  end

  @doc since: """
                 https://hexdocs.pm/arrays/Arrays.html

                   players_matrix = %{  {0, 0} => 0,  {1, 0} => 10,  {2, 0} => 20,
                                       {0, 1} => 1,  {1, 1} => 11,  {2, 1} => 21,
                                       {0, 2} => 2,  {1, 2} => 12,  {2, 2} => 22   }

                   MultiGameWeb.UserHtml.makeAllRows(players_matrix, 2, 2)

                %{0, %{0 => 0, 1 => 10, 2 => 20}},
                 {1, %{0 => 1, 1 => 11, 2 => 21}},
                 {2, %{0 => 2, 1 => 12, 2 => 22}}

       """

  def makeAllRows(players_matrix, width_game, height_game) do
    real_rows = height_game
    test_rows = TheDebug.d_makeAllRows()
    height_current = TheDebug.smallTestTable("makeAllRows()", real_rows, test_rows)

    _the_rows =
      for y <- 0..height_current, into: %{} do
        the_row = makeARow(players_matrix, width_game, y)
        {y, the_row}
      end
  end
end
