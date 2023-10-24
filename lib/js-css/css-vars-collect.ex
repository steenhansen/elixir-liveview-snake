# wrong_live ==> player_live PlayerLive

defmodule CssVarsCollect do
  use MultiGameWeb, :live_component

  ##   ALL SHOULD BE 3 SYLABLLES, AND DASHES
  def render(assigns) do
    ~H"""
      <div>
        <style >
          :root {
            --give_url_a_name: <%= @user_nameless %>;
          }
        </style>
      </div>
    """
  end
end
