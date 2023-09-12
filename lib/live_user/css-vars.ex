# wrong_live ==> player_live PlayerLive

defmodule CssVars do
  use MultiGameWeb, :live_component

  def render(assigns) do

    ~H"""
    <div>
    
      <style >
          :root {
            --rotator-change:  <%= @live_rotate %>;
            --rotator-deg:    0deg;
            --the-player-colors:  <%= @the_player_colors %>;
            --jump_0_opacity: <%= @jump_svg[0] %>;
            --jump_1_opacity: <%= @jump_svg[1] %>;
            --jump_2_opacity: <%= @jump_svg[2] %>;
            --jump_3_opacity: <%= @jump_svg[3] %>;
            --jump_4_opacity: <%= @jump_svg[4] %>;
            --jump_5_opacity: <%= @jump_svg[5] %>;
            --jump_6_opacity: <%= @jump_svg[6] %>;
            --jump_7_opacity: <%= @jump_svg[7] %>;
            --jump_8_opacity: <%= @jump_svg[8] %>;
            --jump_9_opacity: <%= @jump_svg[9] %>;
          }

        .xxx-n {
          background-color : rgba(var(--the-player-colors), 1) 
        }
          #da_0 {
          position: absolute;
          opacity: var(--jump_0_opacity);
        }
          #da_1 {
          position: absolute;
          opacity: var(--jump_1_opacity);
        }
        #da_2 {
          position: absolute;
          opacity: var(--jump_2_opacity);
        }
          #da_3 {
          position: absolute;
          opacity: var(--jump_3_opacity);
        }     
        #da_4 {
          position: absolute;
          opacity: var(--jump_4_opacity);
        }
        #da_5 {
          position: absolute;
          opacity: var(--jump_5_opacity);
        }
        #da_6 {
          position: absolute;
          opacity: var(--jump_6_opacity);
        }
        #da_7 {
          position: absolute;
          opacity: var(--jump_7_opacity);
        }
        #da_8 {
          position: absolute;
          opacity: var(--jump_8_opacity);
        }
        #da_XX {
          position: absolute;
          opacity: 0;
        }

          ._tile {
            width: <%= @tile_size %>px;
            height: <%= @tile_size %>px;
            float: left;
          }

          #_board {
            background-image: url('/images/395_v_h.png');
            width:  <%= @width_px %>px;
            height: <%= @height_px %>px;
            position: absolute;
            /* top: var(--tile-size);
            left: var(--tile-size); */

          }

          ._row {
            width:  <%= @width_px %>px;
            height: <%= @row_height %>px;
            overflow: hidden;
            z-index: 2;
            position: relative

          }
          @keyframes rotation {
            from { transform: rotate(0deg); }
            to { transform: rotate(359deg); }
          }
 
          #_rotator0 {
             animation: rotation  <%= @live_rotate %>s infinite linear;

            transform: rotate(var(--rotator-deg));
            transform-origin: center;
            width: <%= @width_px %>px;
            height: <%= @height_px %>px;
            background-position: center;
            overflow: hidden;
            z-index: 1;
            position: absolute;

            opacity: 0.33;
            background-image: url('/images/compass-nesw-grid.svg'); 
          }

          #_rotator {
              animation: rotation  <%= @live_rotate %>s infinite linear;
            <%!-- transform: rotate(var(--rotator-deg)); --%>
            transform-origin: center;
            width: <%= @width_px %>px;
            height: <%= @height_px %>px;
            background-position: center;
            overflow: hidden;
            z-index: 3;
            position: absolute;

              }

          #_rotator2 {
                    animation: rotation  <%= @live_rotate %>s infinite linear;
            <%!-- transform: rotate(var(--rotator-deg)); --%>
            transform-origin: center;
            width: <%= @width_px %>px;
            height: <%= @height_px %>px;
            background-position: center;
            overflow: hidden;
            z-index: 7;
            position: absolute;

            background-image: url('/images/395_v_h_grey.png');
          }


          .flex-grid {
            display: flex;
              align-items: center;
            justify-content: center;
          }
          .flex-col {
            flex: 1;
            text-align: center;
          }


         ._control2 {
            width: 32px;
            height: 32px;
          }


          ._control {
            width: 40px;
            height: 40px;
          }

          
        </style>



        </div>
    """
  end
end
