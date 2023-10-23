

# https://studioindie.co/blog/heex-guide/

defmodule HtmlPlayers do
  use MultiGameWeb, :live_component 
   
  def render(assigns) do

    ~H"""
      <ul>
      <li><b>Players</b> in <%= @game_name %></li>
        <%= for a_user <- @user_team do %>
          <li>&nbsp;&nbsp;<%= a_user %></li>
        <% end %>
      </ul>
    """
  end
end
