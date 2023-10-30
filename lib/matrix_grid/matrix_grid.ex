defmodule MatrixGrid do
  use Norm

  @contract snakesToMatrix(
              m_walled_matrix :: S.is_a_xy_to_0_1(),
              m_snakes_pixels :: S.is_a_xy_to_SvgCss()
            ) :: S.is_a_xy_to_SvgCss()
  def snakesToMatrix(m_walled_matrix, m_snakes_pixels) do
    m_snaked_matrix =
      m_walled_matrix
      |> Enum.map(fn {xy_coord, color_0_1} ->
        if Map.has_key?(m_snakes_pixels, xy_coord) do
          m_XySvg = m_snakes_pixels[xy_coord]

          {xy_coord, m_XySvg}
        else
          m_XySvg = %XySvg{svgCss_icon_ind: color_0_1, svgCss_css_jump: "no-jump"}
          {xy_coord, m_XySvg}
        end
      end)
      |> Map.new()
    m_snaked_matrix
  end

  @contract emptyMatrix(
              board_width :: S.is_a_coord(),
              board_height :: S.is_a_coord()
            ) :: S.is_a_xy_set()
  def emptyMatrix(board_width, board_height) do
    all_empty =
      for x <- 0..board_width,
          y <- 0..board_height,
          into: MapSet.new(),
          do: {x, y}
    all_empty
  end

  @contract walledMatrix(
              empty_matrix :: S.is_a_xy_set(),
              board_walls :: S.is_a_xy_set()
            ) :: S.is_a_xy_to_0_1()
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
  end
end
