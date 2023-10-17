
defmodule HtmlBoard do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do

    ~H"""
    <div id="zoom-board" style="position:relative; "  >

          <div id="rotator_nesw"></div>
          <.live_component module={HtmlMatrix} id="html-matrix" 
          data_rows_jump_inds={@data_rows_jump_inds}  data_rows_svg_inds ={@data_rows_svg_inds}
         
            data_jump_classes={@data_jump_classes}/>
                    <div id="rotator_hash"></div>
        </div>
    """
  end
end
