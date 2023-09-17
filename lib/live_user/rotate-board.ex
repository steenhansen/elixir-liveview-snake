
defmodule RotateBoard do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do
    ~H"""
    <div style="position:relative">
          <div id="rotator_hash"></div>
          <div id="rotator_nesw"></div>
          <.live_component module={MatrixRows} id="matrix-rows"  vv ={@vv}  jump_classes={@jump_classes}/>
        </div>
    """
  end
end
