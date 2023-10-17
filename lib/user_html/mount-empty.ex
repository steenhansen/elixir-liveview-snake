defmodule MountEmpty do
  # use MultiGameWeb, :live_component

  def emptyOptional() do
    %OptionalSelections{
      # SPEED-FAST
      select_speed: "speed-fast",
      select_rotate: false,
      # LENGTH-LONG
      select_length: "length-long",
      # SURFACE-LARGE
      select_surface: "surface-large",
      # COMPUTERS-1
      select_computers: "computers-1"
    }
  end

  def emptyChosens() do
    %MatchChosens{
      chosen_frames_per_sec: TheConsts.c_speed_fast_50_a_sec(),
      chosen_rotate: 0,
      chosen_length: 16,
      #### must match above
      chosen_tile_width: 44,
      chosen_tile_height: 44,
      chosen_obstacles: [{12, 12}, {13, 13}, {14, 14}],
      chosen_computers: 1
    }
  end

  def emptyData() do
    %HtmlData{
      data_scale: 1,
      data_offset_x: "0px",
      data_offset_y: "0px",
      data_pid_tick: %{},
      data_colors: nil
    }
  end

  def emptyUser(user_tab, user_name) do
    %LiveUser{
      # STEP_1_COLLECT and STEP_1_OTHER
      user_step: "step_1_collect_players",
      user_show_grid: false,
      user_tab: user_tab,
      user_name: user_name,
      user_ping: 0,
      user_time_start: -43210,
      user_team: [""],
      user_is_mobile: false
    }
  end

  # def render(assigns) do
  #   ~H"""
  #   ...
  #   """
  # end
end
