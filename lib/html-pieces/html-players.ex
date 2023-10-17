

# https://studioindie.co/blog/heex-guide/

defmodule HtmlPlayers do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do
    ~H"""
      <ul>
      <li><b>Players</b></li>
        <%= for a_user <- @user_team do %>
          <li><%= a_user %></li>
        <% end %>
      </ul>
    """
  end
end
