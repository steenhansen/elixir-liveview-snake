#   https://studioindie.co/blog/heex-guide/

defmodule RenderBoard do
  use MultiGameWeb, :live_view

  def renderMount(assigns) do
    ~H"""
      <div>
        Mounting
      </div>
    """
  end

  def renderCollect(assigns) do
    ~H"""
      <div style="margin-left:8px">
        <.live_component module={HtmlMobile} id="html-mobile"  user_is_mobile ={@live_user.user_is_mobile} />
        <div style="max-width:333px">
          <.live_component module={HtmlPlayers} id="html-players"  user_team ={@live_user.user_team}  game_name ={@game_name} />
        </div>
        <div style="float:right; margin-top:16px; margin-bottom:16px;">
          <.button phx-click="start-game"  style="background-color:blue"
                   phx-value-person-name= { @live_user.user_name } >START <%= @game_name %></.button>
        </div>

        <hr style="width:100%; height:18px">

        <.live_component module={JsPing} id="js-ping"  user_time_start ={@live_user.user_time_start} />
        <.live_component module={CssPlain} id="css-plain" />
        <div>
        <.live_component module={HtmlChoices} id="html-form" 
                         select_speed={@optional_selections.select_speed} 
                         select_rotate={@optional_selections.select_rotate}
                         select_length={@optional_selections.select_length}
                         select_surface={@optional_selections.select_surface} 
        user_max_robots={@live_user.user_max_robots} 
                         select_computers={@optional_selections.select_computers}
                           select_movement={@optional_selections.select_movement}
                          />
                   
        

          </div>
          
          <div style="color:#DCDCDC; float:none; margin-top:60px; clear:both"><br><br><br>ping = <%= @live_user.user_ping %></div>
         <.live_component module={JsOnload} id="js-onload"  />
      </div>
    """
  end

  def renderPlay(assigns) do
    ~H"""
      <div id="user-html" style="width: 360px">
       <div id="user-moniker"  style= {"#{if @live_user.user_show_grid, do: 'visibility:visible', else: 'visibility:hidden'}"} > <%= @live_user.user_name %> </div>
        <div id='live_user' style= {"#{if @live_user.user_show_grid, do: 'visibility:visible', else: 'visibility:hidden'}"} >
          <.live_component module={JsPing} id="js-ping"  user_time_start ={@live_user.user_time_start} />
          <.live_component module={CssPlain} id="css-plain" />
          <.live_component module={CssVars} id="css-vars"
          data_snake_dead={@html_data.data_snake_dead}
            data_rotate={@html_data.data_rotate}
            data_colors={@html_data.data_colors}
            data_jump_opacity={@html_data.data_jump_opacity}
            data_tile_px={@html_data.data_tile_px}
            data_rows={@html_data.data_rows} 
            data_w_px={@html_data.data_w_px}
            data_h_px={@html_data.data_h_px}
            data_scale={@html_data.data_scale}
                       
            data_offset_x={@html_data.data_offset_x}
            data_offset_y={@html_data.data_offset_y} />
          <.live_component module={CssCalc} id="css-calc"
            data_rotate={@html_data.data_rotate}
            data_colors={@html_data.data_colors} 
            data_jump_opacity={@html_data.data_jump_opacity}
            data_tile_px={@html_data.data_tile_px} 
            data_rows={@html_data.data_rows} 
            data_w_px={@html_data.data_w_px}
            data_h_px={@html_data.data_h_px}
             data_zooming={@html_data.data_zooming}
            data_rot_w_px={@html_data.data_rot_w_px}
            data_rot_h_px={@html_data.data_rot_h_px}/>
          <.live_component module={HtmlBoard} id="html-board"  
            data_rows_jump_inds={@html_data.data_rows_jump_inds} 
            data_rows_svg_inds ={@html_data.data_rows_svg_inds} 
            data_jump_classes={@html_data.data_jump_classes} />
        </div>
        <div id="nesw-spacer" >&nbsp;</div>
          <.live_component module={HtmlNESW} id="n-e-s-w"   />
          <div style="color:#DCDCDC; float:none; margin-top:60px; clear:both">max ping = <%= @seq_max_ping %></div>
        <.live_component module={JsOnload} id="js-onload"  />
      </div>
    """
  end

  # STEP_5_UN_ROTATE
  # STEP_6_ZOOM_IN
  def render(assigns) do
    user_step = assigns.live_user.user_step
    cond do
      user_step == "step_1_collect_players" -> renderCollect(assigns)
      user_step == "step_2_load_html" -> renderPlay(assigns)
      user_step == "step_3_count_down" -> renderPlay(assigns)
      user_step == "step_4_play_game" -> renderPlay(assigns)
      user_step == "step_5_see_winner" -> renderPlay(assigns)


      true -> renderPlay(assigns)
    end
  end
end
