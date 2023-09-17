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
        #jump-0 {
          position: absolute;
          opacity: 0;
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
        div{
          float:left;
        }
        img{
            width: <%= @tile_size %>px;
            height: <%= @tile_size %>px;
             float: left;
            position: relative;
               visibility: visible;
        }




        .not-jumping {
          visibility: hidden;
        }

        #p_1_0 {position: absolute; scale: 1.5; z-index:12; }
        #p_1_1 {position: absolute; scale: 1.5; z-index:12; }
        #p_1_2 {position: absolute; scale: 1.5; z-index:12; }
        #p_1_3 {position: absolute; scale: 1.5; z-index:12; }


          ._tile {
            <%!-- float: left;
            position: relative; --%>
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
            <%!-- overflow: hidden; --%>
            z-index: 2;
            position: relative;
         /*   overflow: hidden;       */         /*     screws up when small verically */

          }
          @keyframes rotation {
            from { transform: rotate(0deg); }
            to { transform: rotate(359deg); }
          }
 
          #rotator_nesw {
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

          #rotator_squares {
              animation: rotation  <%= @live_rotate %>s infinite linear;
            <%!-- transform: rotate(var(--rotator-deg)); --%>
            transform-origin: center;
            width: <%= @width_px %>px;
            height: <%= @height_px %>px;
            background-position: center;
            overflow: hidden;
            z-index: 11;
            position: absolute;

              }

          #rotator_hash {
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

          #nesw{
            clear:both
          }

          .flex-grid {
            display: flex;
              align-items: center;
            justify-content: center;
            float:none;
          }
          .flex-col {
            flex: 1;
            text-align: center;
            float:none
          }


         ._control2 {
            width: 32px;
            height: 32px;
          }


          ._control {
            width: 40px;
            height: 40px;
          }

          

        #p_1_0 {position: absolute; scale: 1.5; z-index:12; }
        #p_1_1 {position: absolute; scale: 1.5; z-index:12; }
        #p_1_2 {position: absolute; scale: 1.5; z-index:12; }
        #p_1_3 {position: absolute; scale: 1.5; z-index:12; }





        </style>



        </div>
    """
  end
end
