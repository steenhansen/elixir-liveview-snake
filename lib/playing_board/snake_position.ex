
defmodule BoardSnakePosition do
  def snake_to_board(current_board) do
    m_snakes_pixels = snakeColors(current_board)

    m_current_matrix =
      MatrixGrid.emptyMatrix(current_board.board_width, current_board.board_height)
      |> MatrixGrid.walledMatrix(current_board.board_walls)
      |> MatrixGrid.snakesToMatrix(m_snakes_pixels)
    {:reply, m_current_matrix, current_board}
  end

  def move_snake({:snake2Board, snake_change}, current_board) do
    %{
      board_empty_xys: board_empty_xys,
      board_walls: board_walls,
      board_snakes_xys: board_snakes_xys
    } = current_board

    hit_other_snake = SnakeDraw.hit_snake?(snake_change, board_empty_xys, board_snakes_xys)

    if length(hit_other_snake) > 0 do
      TakeTurn.snake_crashed(hit_other_snake, current_board, snake_change.change_pid_user)
    else
      hit_wall = MapSet.member?(board_walls, snake_change.change_front)
      snake_not_jump = snake_change.change_jump == 0

      if hit_wall and snake_not_jump do
        TakeTurn.hit_a_wall(current_board, snake_change.change_pid_user)
      else
        front_empty = MapSet.member?(board_empty_xys, snake_change.change_front)

        if front_empty do
          TakeTurn.playerToBoard(current_board, snake_change)
        else
          {:reply, "no_crash", current_board}
        end
      end
    end
  end

  @doc  """
         players_snakes = %{                         # NEW WAY  5   
             "jill" => MapSet.new([ {0,0}, {1,0}, {2,0}]),
             "bob" => MapSet.new([ {3,3}, {3,4}, {3,5}])
           }
         board_colors = %{"1" => 3, "jill" => 1, "bob" => 2}
         board_fronts = %{"1" => MapSet.new([]), "jill" => {0,0}, "bob" => {3, 3}}
         board_rumps = %{"1" => MapSet.new([]), "jill" => {2, 0}, "bob" => {3, 5}}
          
         
        %{ {0,0} => 10, {1,0} => 11, {2,0} => 12, {3,3} => 20, {3,4} => 21, {3,5} => 22  } 
       """
  def snakeColors(prev_board) do
    %{
      board_snakes_xys: snake_coords,
      board_colors: board_colors,
      board_fronts: board_fronts,
      board_rumps: board_rumps,
      board_deads: board_deads,
      board_jumps: board_jumps,
      board_leaps: board_leaps
    } = prev_board

    l_snake_segments =
      snake_coords
      |> Enum.map(fn {user_name, boardSnake_xys} ->
        boardSnake_color = board_colors[user_name]
        boardSnake_front = board_fronts[user_name]
        boardSnake_rump = board_rumps[user_name]
        # boardSnake_killed = Map.get(board_deads, user_name, 0)

        boardSnake_killed = board_deads[user_name]

        boardSnake_jump = board_jumps[user_name]
        boardSnake_leap = board_leaps[user_name]

        board_snake = %BoardSnake{
          boardSnake_color: boardSnake_color,
          boardSnake_xys: boardSnake_xys,
          boardSnake_front: boardSnake_front,
          boardSnake_rump: boardSnake_rump,
          boardSnake_killed: boardSnake_killed,
          boardSnake_jump: boardSnake_jump,
          boardSnake_leap: boardSnake_leap
        }

        colorASnake16(board_snake)
      end)

    m_merge_snakes =
      Enum.reduce(
        l_snake_segments,
        Map.new(),
        fn xy_colors, acc ->
          Map.merge(acc, xy_colors)
        end
      )

    m_merge_snakes
  end

  def possibleColors(player_color, snake_kill) do
    if snake_kill do
      dead_svg = player_color * 10 + TheConsts.dead_svg_offset()
      {dead_svg, dead_svg, dead_svg}
    else
      head_svg = player_color * 10 + TheConsts.head_svg_offset()
      midl_svg = player_color * 10 + TheConsts.midl_svg_offset()
      tail_svg = player_color * 10 + TheConsts.tail_svg_offset()
      {head_svg, midl_svg, tail_svg}
    end
  end

  @doc  """
         PlayerSnake.colorASnake(1, MapSet.new([ {0,0}, {1,0}, {2,0}]), {0,0}, {2,0})
         {{0, 0}, 10}, {{1, 0}, 11}, {{2, 0}, 12}}

       add class !


       """

  def headSvgCss(human_leap, head_svg, snake_front) do
    is_front_jump = Map.has_key?(human_leap, snake_front)

    if is_front_jump do
      jump_slice = human_leap[snake_front]

      if jump_slice.slice_vertical do
        %XySvg{svgCss_icon_ind: head_svg, svgCss_css_jump: TheConsts.ver_jump()}
      else
        %XySvg{svgCss_icon_ind: head_svg, svgCss_css_jump: TheConsts.hor_jump()}
      end
    else
      %XySvg{svgCss_icon_ind: head_svg, svgCss_css_jump: TheConsts.no_jump()}
    end
  end

  def bodySvgCss(human_leap, midl_svg, middle_coord, boardSnake_killed) do
    if boardSnake_killed do
      %XySvg{svgCss_icon_ind: midl_svg, svgCss_css_jump: TheConsts.no_jump()}
    else
      is_middle_jump = Map.has_key?(human_leap, middle_coord)

      if is_middle_jump do
        jump_slice = human_leap[middle_coord]

        if jump_slice.slice_vertical do
          %XySvg{svgCss_icon_ind: midl_svg, svgCss_css_jump: TheConsts.ver_jump()}
        else
          %XySvg{svgCss_icon_ind: midl_svg, svgCss_css_jump: TheConsts.hor_jump()}
        end
      else
        %XySvg{svgCss_icon_ind: midl_svg, svgCss_css_jump: TheConsts.no_jump()}
      end
    end
  end

  def colorASnake16(board_snake) do
    %BoardSnake{
      boardSnake_color: boardSnake_color,
      boardSnake_xys: boardSnake_xys,
      boardSnake_front: boardSnake_front,
      boardSnake_rump: boardSnake_rump,
      boardSnake_killed: boardSnake_killed,
      boardSnake_leap: boardSnake_leap
    } = board_snake

    {head_svg, midl_svg, tail_svg} = possibleColors(boardSnake_color, boardSnake_killed)

    m_rump_svg_css = %XySvg{svgCss_icon_ind: tail_svg, svgCss_css_jump: TheConsts.no_jump()}

    m_xys_svg_css =
      boardSnake_xys
      |> Enum.map(fn xy_coord ->
        m_head_svg_css = headSvgCss(boardSnake_leap, head_svg, boardSnake_front)
        m_body_svg_css = bodySvgCss(boardSnake_leap, midl_svg, xy_coord, boardSnake_killed)

        _the_color_16 =
          cond do
            xy_coord == boardSnake_front -> {xy_coord, m_head_svg_css}
            true -> {xy_coord, m_body_svg_css}
          end
      end)
      |> Map.new()
      |> Map.put(boardSnake_rump, m_rump_svg_css)

    m_xys_svg_css
  end
end
