
defmodule RotateBoard do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do
    ~H"""
    <div style="position:relative">
          <div id="_rotator2"></div>
          <div id="_rotator0"></div>
          <.live_component module={MatrixRows} id="matrix-rows"  vv ={@vv}/>
        </div>
    """
  end
end
