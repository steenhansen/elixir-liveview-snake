# wrong_live ==> player_live PlayerLive

defmodule CssVars do
  use MultiGameWeb, :live_component

  ##   ALL SHOULD BE 3 SYLABLLES, AND DASHES
  def render(assigns) do
    ~H"""
      <div>

        <style >

          :root {
            --rotator-change:  <%= @data_rotate %>;
     --data_scale:  <%= @data_scale %>;
          --data_offset_x:  <%= @data_offset_x %>;
          --data_offset_y:  <%= @data_offset_y %>;
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
