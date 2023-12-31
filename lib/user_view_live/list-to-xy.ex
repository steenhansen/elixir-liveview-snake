defmodule ListToXy do

  @doc  """
                 https://hexdocs.pm/arrays/Arrays.html

                   players_matrix = %{  {0, 0} => 0,  {1, 0} => 10,  {2, 0} => 20,
                                       {0, 1} => 1,  {1, 1} => 11,  {2, 1} => 21,
                                       {0, 2} => 2,  {1, 2} => 12,  {2, 2} => 22   }

                   MultiGameWeb.UserViewLive.makeAllRows(players_matrix, 2, 2)

                %{0, %{0 => 0, 1 => 10, 2 => 20}},
                 {1, %{0 => 1, 1 => 11, 2 => 21}},
                 {2, %{0 => 2, 1 => 12, 2 => 22}}

       """


  def makeARow(players_matrix, board_width, the_row) do
    columns_current = board_width - 1
    _the_row =
      for x <- 0..columns_current, into: %{} do
        xy_in_game? = Map.has_key?(players_matrix, {x, the_row})
        if xy_in_game? do
          m_XySvg = players_matrix[{x, the_row}]
           {x, m_XySvg}
        else
          m_XySvg = %XySvg{  svgCss_icon_ind: 0 ,  svgCss_css_jump: TheConsts.no_jump() }
          {x, m_XySvg}
        end
      end
  end

  def makeAllRows(players_matrix, board_width, board_height) do
    _the_rows =
      for y <- 0..board_height, into: %{} do
        the_row = makeARow(players_matrix, board_width, y)
        {y, the_row}
      end
  end

end
