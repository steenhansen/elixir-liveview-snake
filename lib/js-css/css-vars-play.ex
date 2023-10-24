# wrong_live ==> player_live PlayerLive

defmodule CssVarsPlay do
  use MultiGameWeb, :live_component

  ##   ALL SHOULD BE 3 SYLABLLES, AND DASHES
  def render(assigns) do
    ~H"""
      <div>

        <style >

          :root {
                  --user_constrol_opacity:  <%= @data_snake_dead %>;
            --rotator-change:  <%= @data_rotate %>;
          --data_scale:  <%= @data_scale %>;
          --data_offset_x:  <%= @data_offset_x %>;
          --data_offset_y:  <%= @data_offset_y %>;
          --data_board_left:  <%= @data_board_left %>;
                 --nesw_control_left:  <%= @data_control_left %>;
                 --nesw_control_top:  <%= @data_control_top %>;
            --the-player-colors:  <%= @data_colors %>;
            --jump_0_opacity: <%= @data_jump_opacity[0] %>;
            --jump_1_opacity: <%= @data_jump_opacity[1] %>;
            --jump_2_opacity: <%= @data_jump_opacity[2] %>;
            --jump_3_opacity: <%= @data_jump_opacity[3] %>;
            --jump_4_opacity: <%= @data_jump_opacity[4] %>;
            --jump_5_opacity: <%= @data_jump_opacity[5] %>;
            --jump_6_opacity: <%= @data_jump_opacity[6] %>;
            --jump_7_opacity: <%= @data_jump_opacity[7] %>;
            --jump_8_opacity: <%= @data_jump_opacity[8] %>;
            --jump_9_opacity: <%= @data_jump_opacity[9] %>;
            --jump-var-can-jump-milli: -1;
          }

        #live_user {
          clear:both;
          margin-top:84px; 
          margin-left:var(--data_board_left);
           <%!-- margin-left:240px;          84 if large/small, 240 if rectangle --%>
        }


         #nesw-spacer {
        height:var(--nesw_control_top);
        visibility:hidden;
        clear:both;
        }

       #nesw {
        left: var(--nesw_control_left);
        clear:both; 
        visibility:hidden; 
        position:relative;
            opacity: var(--user_constrol_opacity);
        }


       #inside-jump {
               opacity: var(--user_constrol_opacity);
        }

        #zoom-board {
          left: var(--data_offset_x);
          top: var(--data_offset_y);
            scale: var(--data_scale);
        }

        .this-player-color {
          background-color : rgba(var(--the-player-colors), 1) 
        }

        #jump-1 {
          position: absolute;
          opacity: var(--jump_0_opacity);
        }
          #jump-2 {
          position: absolute;
          opacity: var(--jump_1_opacity);
        }
        #jump-3 {
          position: absolute;
          opacity: var(--jump_2_opacity);
        }
          #jump-4 {
          position: absolute;
          opacity: var(--jump_3_opacity);
        }     
        #jump-5 {
          position: absolute;
          opacity: var(--jump_4_opacity);
        }
        #jump-6 {
          position: absolute;
          opacity: var(--jump_5_opacity);
        }
        #jump-7 {
          position: absolute;
          opacity: var(--jump_6_opacity);
        }
        #jump-8 {
          position: absolute;
          opacity: var(--jump_7_opacity);
        }
        #jump-9 {
          position: absolute;
          opacity: var(--jump_8_opacity);
        }


        </style>



        </div>
    """
  end
end
