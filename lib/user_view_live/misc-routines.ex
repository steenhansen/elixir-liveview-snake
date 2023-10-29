defmodule MiscRoutines do
  use MultiGameWeb, :live_component

  @doc  """
       """

  def getColors(m_the_data_rows_svg_inds, size_board_hor) do
    columns_current = TheConsts.max_hor() - 1

    _the_colors =
      m_the_data_rows_svg_inds
      |> Enum.map(fn {the_row, the_columns} ->
        all_columns = 0..columns_current

        full_empty_row =
          Enum.map(all_columns, fn x ->
            if(x > size_board_hor) do
              {x, 0}
            else
              m_XySvg = the_columns[x]
              svgCss_icon_ind = m_XySvg.svgCss_icon_ind
              {x, svgCss_icon_ind}
            end
          end)

        full_empty_row
        |> Map.new()
        |> then(fn a_row -> {the_row, a_row} end)
      end)
      |> Map.new()
  end

  def getIcons(the_data_rows_svg_inds, size_board_hor) do
    columns_current = TheConsts.max_hor() - 1

    _icons =
      the_data_rows_svg_inds
      |> Enum.map(fn {the_row, the_columns} ->
        all_columns = 0..columns_current

        full_empty_row =
          Enum.map(all_columns, fn x_column ->
            if(x_column > size_board_hor) do
              # out of viewing bounds, ie 22x22wide board
              {x_column, 0}
            else
              m_XySvg = the_columns[x_column]
              svgCss_css_jump = m_XySvg.svgCss_css_jump
              svgCss_icon_ind = m_XySvg.svgCss_icon_ind

              case svgCss_css_jump do
                "no-jump" ->
                  {x_column, 0}

                # 11+5=16            10+5=15
                "hor-jump" ->
                  {x_column, svgCss_icon_ind + 5}

                # 11+7=18     10+7=17 
                "ver-jump" ->
                  {x_column, svgCss_icon_ind + 7}
              end
            end
          end)

        full_empty_row
        |> Map.new()
        |> then(fn a_row -> {the_row, a_row} end)
      end)
      |> Map.new()
  end

  def getJumps(m_the_data_rows_svg_inds) do
    _jumps =
      m_the_data_rows_svg_inds
      |> Enum.map(fn {the_row, the_columns} ->
        the_columns
        |> Enum.map(fn {x_column, m_XySvg} ->
          svgCss_css_jump = m_XySvg.svgCss_css_jump
          {x_column, svgCss_css_jump}
        end)
        |> Map.new()
        |> then(fn a_row -> {the_row, a_row} end)
      end)
      |> Map.new()
  end

  def getDeadOpacity(is_snake_dead) do
    if is_snake_dead do
      0.3
    else
      1
    end
  end

  def drawBoard(
        {user_pid, pid_board, data_pid_tick, players_matrix, new_scale, scale_x_px, scale_y_px,
         rotation_speed, seq_game_sizes, is_snake_dead, is_freezing, chosen_control_offset,
         chosen_top_control_offset}
      ) do
    max_hv_size = TheConsts.max_hor()
    players_data_rows_svg_inds = ListToXy.makeAllRows(players_matrix, max_hv_size, max_hv_size)
    the_colors = PlayingBoard.boardColors(pid_board)
    this_color = the_colors[user_pid]

    opacity_jump_2 = Map.replace(TheConsts.init_opacity_0(), this_color - 1, 1)
    user_rgb = TheConsts.convert_color_id_to_rgb()[this_color - 1]
    da_colors = MiscRoutines.getColors(players_data_rows_svg_inds, seq_game_sizes.size_board_hor)

    data_rows_jump_inds =
      MiscRoutines.getIcons(players_data_rows_svg_inds, seq_game_sizes.size_board_hor)

    da_jumps = MiscRoutines.getJumps(players_data_rows_svg_inds)
    control_opacity = MiscRoutines.getDeadOpacity(is_snake_dead)

    data_zooming = if is_freezing, do: "hidden", else: "visible"

    html_data = %HtmlData{
      pid_board: pid_board,
      data_snake_dead: control_opacity,
      data_pid_tick: data_pid_tick,
      data_rotate: rotation_speed,
      data_tile_px: TheConsts.tile_pixels(),
      data_rows: TheConsts.tile_pixels(),
      data_w_px: seq_game_sizes.size_board_hor_px,
      data_h_px: seq_game_sizes.size_board_ver_px,
      data_rot_w_px: seq_game_sizes.size_board_hor_px + 1,
      data_rot_h_px: seq_game_sizes.size_board_ver_px + 1,
      data_board_left: seq_game_sizes.size_board_left_indent,
      data_scale: new_scale,
      data_offset_x: scale_x_px,
      data_offset_y: scale_y_px,
      data_control_left: chosen_control_offset,
      data_control_top: chosen_top_control_offset,
      data_rows_svg_inds: da_colors,
      data_rows_jump_inds: data_rows_jump_inds,
      data_jump_classes: da_jumps,
      data_jump_opacity: opacity_jump_2,
      data_zooming: data_zooming,
      # data_colors => data_rgb_color
      data_colors: user_rgb
    }

    html_data
  end

  def get_maxRobots(game_name) do
    current_players = CollectParticipants.get_participants(game_name)
    current_players = Enum.map(current_players, fn {_pid_user, person_name} -> person_name end)

    amount_users = length(current_players)
    amount_robots = 9 - amount_users

    amount_robots
  end

  def render(assigns) do
    ~H"""
    ...
    """
  end
end
