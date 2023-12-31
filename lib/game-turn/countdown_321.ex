defmodule Countdown321 do
  use Norm

  @contract offsetNumber(
              xy_coords :: S.is_a_xy_set(),
              x_offset :: S.is_a_coord(),
              y_offset :: S.is_a_coord()
            ) :: S.is_a_xy_set()
  def offsetNumber(xy_coords, x_offset, y_offset) do
      xy_coords
      |> Enum.map(fn xy_coord ->
        {x_coord, y_coord} = xy_coord
        x_move = x_coord + x_offset
        y_move = y_coord + y_offset
        {x_move, y_move}
      end)
      |> MapSet.new()
  end

  @contract make_1_2_3(
              count_number :: S.is_a_1_2_3(),
              x_offset :: S.is_a_coord(),
              y_offset :: S.is_a_coord()
            ) ::
              S.is_a_xy_set()
  def make_1_2_3(count_number, x_offset, y_offset) do

    count_3 = MapSet.new([
                  { 2, 0},{ 3, 0},{ 4, 0},{ 5, 0},{ 6, 0},{ 7, 0},{ 8, 0},{ 9, 0},
                  { 2, 1},{ 3, 1},{ 4, 1},{ 5, 1},{ 6, 1},{ 7, 1},{ 8, 1},{ 9, 1},
                  { 2, 2},{ 3, 2},{ 4, 2},{ 5, 2},{ 6, 2},{ 7, 2},{ 8, 2},{ 9, 2},
          { 1, 3},{ 2, 3},{ 3, 3},                                { 8, 3},{ 9, 3},{10, 3},
          { 1, 4},{ 2, 4},{ 3, 4},                                { 8, 4},{ 9, 4},{10, 4},
          { 1, 5},{ 2, 5},{ 3, 5},                                { 8, 5},{ 9, 5},{10, 5},
                                                                  { 8, 6},{ 9, 6},{10, 6},
                                                                  { 8, 7},{ 9, 7},{10, 7},
                                                                  { 8, 8},{ 9, 8},{10, 8},
                                  { 4, 9},{ 5, 9},{ 6, 9},{ 7, 9},{ 8, 9},{ 9, 9},
                                  { 4,10},{ 5,10},{ 6,10},{ 7,10},{ 8,10},{ 9,10},
                                  { 4,11},{ 5,11},{ 6,11},{ 7,11},{ 8,11},{ 9,11},
                                                                  { 8,12},{ 9,12},{10,12},
                                                                  { 8,13},{ 9,13},{10,13},
          { 1,14},{ 2,14},{ 3,14},                                { 8,14},{ 9,14},{10,14},
          { 1,15},{ 2,15},{ 3,15},                                { 8,15},{ 9,15},{10,15},
          { 1,16},{ 2,16},{ 3,16},                                { 8,16},{ 9,16},{10,16},
                  { 2,17},{ 3,17},{ 4,17},{ 5,17},{ 6,17},{ 7,17},{ 8,17},{ 9,17},
                  { 2,18},{ 3,18},{ 4,18},{ 5,18},{ 6,18},{ 7,18},{ 8,18},{ 9,18},
                  { 2,19},{ 3,19},{ 4,19},{ 5,19},{ 6,19},{ 7,19},{ 8,19},{ 9,19}
    ])

  count_2 = MapSet.new([
                { 2, 0},{ 3, 0},{ 4, 0},{ 5, 0},{ 6, 0},{ 7, 0},{ 8, 0},
                { 2, 1},{ 3, 1},{ 4, 1},{ 5, 1},{ 6, 1},{ 7, 1},{ 8, 1},
                { 2, 2},{ 3, 2},{ 4, 2},{ 5, 2},{ 6, 2},{ 7, 2},{ 8, 2},
        { 1, 3},{ 2, 3},                                        { 8, 3},{ 9, 3},{10, 3},
        { 1, 4},{ 2, 4},                                        { 8, 4},{ 9, 4},{10, 4},
        { 1, 5},{ 2, 5},                                        { 8, 5},{ 9, 5},{10, 5},
                                                                { 8, 6},{ 9, 6},{10, 6},
                                                                { 8, 7},{ 9, 7},{10, 7},
                                                        { 7, 8},{ 8, 8},{ 9, 8},
                                                        { 7, 9},{ 8, 9},{ 9, 9},
                                                        { 7,10},{ 8,10},{ 9,10},
                                        { 5,11},{ 6,11},{ 7,11},
                                        { 5,12},{ 6,12},{ 7,12},
                                        { 5,13},{ 6,13},{ 7,13},
                        { 3,14},{ 4,14},{ 5,14},
                        { 3,15},{ 4,15},{ 5,15},
                        { 3,16},{ 4,16},{ 5,16},
        { 1,17},{ 2,17},{ 3,17},{ 4,17},{ 5,17},{ 6,17},{ 7,17},{ 8,17},{ 9,17},{10,17},
        { 1,18},{ 2,18},{ 3,18},{ 4,18},{ 5,18},{ 6,18},{ 7,18},{ 8,18},{ 9,18},{10,18},
        { 1,19},{ 2,19},{ 3,19},{ 4,19},{ 5,19},{ 6,19},{ 7,19},{ 8,19},{ 9,19},{10,19}
    ])

  count_1 = MapSet.new([
                                        { 5, 0},{ 6, 0},{ 7, 0},
                                        { 5, 1},{ 6, 1},{ 7, 1},
                                        { 5, 2},{ 6, 2},{ 7, 2},
                        { 3, 3},{ 4, 3},{ 5, 3},{ 6, 3},{ 7, 3},
                        { 3, 4},{ 4, 4},{ 5, 4},{ 6, 4},{ 7, 4},
                        { 3, 5},{ 4, 5},{ 5, 5},{ 6, 5},{ 7, 5},
                                        { 5, 6},{ 6, 6},{ 7, 6},
                                        { 5, 7},{ 6, 7},{ 7, 7},
                                        { 5, 8},{ 6, 8},{ 7, 8},
                                        { 5, 9},{ 6, 9},{ 7, 9},
                                        { 5,10},{ 6,10},{ 7,10},
                                        { 5,11},{ 6,11},{ 7,11},
                                        { 5,12},{ 6,12},{ 7,12},
                                        { 5,13},{ 6,13},{ 7,13},
                                        { 5,14},{ 6,14},{ 7,14},
                                        { 5,15},{ 6,15},{ 7,15},
                                        { 5,16},{ 6,16},{ 7,16},
        { 1,17},{ 2,17},{ 3,17},{ 4,17},{ 5,17},{ 6,17},{ 7,17},{ 8,17},{ 9,17},{10,17},
        { 1,18},{ 2,18},{ 3,18},{ 4,18},{ 5,18},{ 6,18},{ 7,18},{ 8,18},{ 9,18},{10,18},
        { 1,19},{ 2,19},{ 3,19},{ 4,19},{ 5,19},{ 6,19},{ 7,19},{ 8,19},{ 9,19},{10,19}
    ])

  cond do
    count_number == 1 -> offsetNumber(count_1, x_offset, y_offset)
    count_number == 2 -> offsetNumber(count_2, x_offset, y_offset)
    count_number == 3 -> offsetNumber(count_3, x_offset, y_offset)
  end
end

  @contract make_countdown(
              pid_board :: S.is_a_pid(),
              user_color :: S.is_a_color_int(),
              x_offset :: S.is_a_coord(),
              y_offset :: S.is_a_coord(),
              count_number :: S.is_a_1_2_3()
            ) ::
              S.is_a_xy_to_SvgCss()
  def make_countdown(pid_board, user_color, x_offset, y_offset, count_number) do
    empty_matrix = PlayingBoard.snake_matrix(pid_board)
    number_xy_coords = make_1_2_3(count_number, x_offset, y_offset)
      empty_matrix
      |> Enum.map(fn {xy_coord, xy_svg_css} ->
        if MapSet.member?(number_xy_coords, xy_coord) do
          brightness = count_number - 1
          brightening_color = user_color * 10 + brightness
          {xy_coord, %XySvg{svgCss_icon_ind: brightening_color, svgCss_css_jump: "no-jump"}}
        else
          {xy_coord, xy_svg_css}
        end
      end)
      |> Map.new()
  end
end
