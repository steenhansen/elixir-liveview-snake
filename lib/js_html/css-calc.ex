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

/*  html_rotate 0 on die */


          #rotator_nesw {
            width: <%= @html_w_px %>px;
            height: <%= @html_h_px %>px;
             animation: rotation  <%= @html_rotate %>s infinite linear;
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
            width: <%= @html_w_px %>px;
            height: <%= @html_h_px %>px;
            animation: rotation  <%= @html_rotate %>s infinite linear;
            transform-origin: center;
            background-position: center;
            position: absolute;
                     <%!-- overflow: hidden; --%>
            }

          #_board {
            width:  <%= @html_w_px %>px;
            height: <%= @html_h_px %>px;
            position: absolute;
          }

          #rotator_hash {
            width: <%= @rotate_w_px %>px;
            height: <%= @rotate_h_px %>px;
            animation: rotation  <%= @html_rotate %>s infinite linear;
            transform-origin: center;
            background-position: center;
            overflow: hidden;
            position: absolute;
            background-image: url('/images/matrix-mesh.svg');     
            border: solid 1px;
          }

       img{
            width: <%= @html_tile_px %>px;
            height: <%= @html_tile_px %>px;
            float: left;
            position: relative;
        }

          ._row {
            width:  <%= @html_w_px %>px;
            height: <%= @html_rows %>px;
            position: relative;
          }



     

        </style>



        </div>
    """
  end
end
