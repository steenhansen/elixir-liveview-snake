
defmodule HtmlBoard do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do

    ~H"""
    <div id="zoom-board" style="position:relative; "  >

          <div id="rotator_nesw"></div>
          <.live_component module={HtmlMatrix} id="html-matrix" 
          html_rows_jump_inds={@html_rows_jump_inds}  html_rows_svg_inds ={@html_rows_svg_inds}
         
            html_jump_classes={@html_jump_classes}/>
                    <div id="rotator_hash"></div>
        </div>
    """
  end
end
