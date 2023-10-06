# html_ping

defmodule JsPing do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""
      <div id="js_ping.ex">

        <script>

    function livePingTime(){

        window.live_hooks = this;
        server_ms_time = serverMsFromClient();
        this.pushEvent("update-ping", server_ms_time);
        setTimeout(() => {
            nesw_div = document.getElementById("nesw");
             if (nesw_div!==null && nesw_div.style.visibility == "hidden") {
              nesw_div.style.visibility = "visible";
            } 
          }, "500");
    }



          function serverMsFromClient() {

              ping_elem = document.getElementById("ping-box-ms");
              ping_ms = ping_elem.value;
      const path_name = location.pathname
      const path_parts = path_name.split('/');

      const game_name = path_parts[1]
      const user_name = path_parts[2]
    console.info("xxxx", game_name, "**", user_name )
              return { ping_server_ms: ping_ms, game_name: game_name, user_name: user_name };
          }
        </script>

        <input phx-hook="PingTime" type="text" value={"#{@html_server_ms}"}
         hidden id="ping-box-ms" >
      </div>
    """
  end
end
