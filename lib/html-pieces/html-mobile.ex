

# https://studioindie.co/blog/heex-guide/

defmodule HtmlMobile do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do
    ~H"""
      <div style="float:none">
        <%= if @user_is_mobile do %>
          <p style="color:red">Mobile is too slow for game.</p>
          <br/>
          <br/>
          <br/>
        <% end %>
      </div>
    """
  end
end
