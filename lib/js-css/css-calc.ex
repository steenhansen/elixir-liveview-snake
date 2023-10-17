# wrong_live ==> player_live PlayerLive

defmodule CssCalc do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>

      <style >

          @keyframes rotation {
            from { transform: rotate(0deg); }
            to { transform: rotate(359deg); }
          }

          /*  data_rotate 0 on die */


          #rotator_nesw {
            width: <%= @data_w_px %>px;
            height: <%= @data_h_px %>px;
             animation: rotation  <%= @data_rotate %>s infinite linear;
            transform-origin: center;
            background-position: center;
            overflow: hidden;
            position: absolute;
            opacity: 0.33;
            background-image: url('/images/compass-nesw.svg'); 
            background-size: contain;
            background-repeat: no-repeat;
          }

          #rotator_squares {
            width: <%= @data_w_px %>px;
            height: <%= @data_h_px %>px;
            animation: rotation  <%= @data_rotate %>s infinite linear;
            transform-origin: center;
            background-position: center;
            position: absolute;
                     <%!-- overflow: hidden; --%>
            }

          #_board {
            width:  <%= @data_w_px %>px;
            height: <%= @data_h_px %>px;
            position: absolute;
          }

          #rotator_hash {
            width: <%= @data_rot_w_px %>px;
            height: <%= @data_rot_h_px %>px;
            animation: rotation  <%= @data_rotate %>s infinite linear;
            transform-origin: center;
            background-position: center;
            overflow: hidden;
            position: absolute;
            background-image: url('/images/matrix-mesh.svg');     
            border: solid 1px;
          }

       img{
            width: <%= @data_tile_px %>px;
            height: <%= @data_tile_px %>px;
            float: left;
            position: relative;
        }

          ._row {
            width:  <%= @data_w_px %>px;
            height: <%= @data_rows %>px;
            position: relative;
          }



     

        </style>



        </div>
    """
  end
end
