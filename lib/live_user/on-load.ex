defmodule OnLoad do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""
      <script>
        window.onload = function (){
          eventHandler = function (e){
            phoenix_hooks = window.live_hooks;
            key_code = e.keyCode;
            if (key_code == 37 ) { 
              phoenix_hooks.pushEvent("key-west","key_west");
            } else if (key_code == 38 ) { 
              phoenix_hooks.pushEvent("key-north","key_north");
            } else if (key_code == 39 ) { 
              phoenix_hooks.pushEvent("key-east","key_east");
            } else if (key_code == 40 ) { 
              phoenix_hooks.pushEvent("key-south","key_south");
            } else if (key_code == 32 ) { 
              phoenix_hooks.pushEvent("key-jump","key_jump");
              }
          }
          window.addEventListener('keydown', eventHandler, false);
        } 

        function snakeJump(key_jump) {
          const path_name = location.pathname;
          const path_parts = path_name.split('/');
          const user_name = path_parts[1];
          window.live_hooks.pushEvent(key_jump, user_name);
        } 

        function headingChange(the_dir) {
          const path_name = location.pathname;
          const path_parts = path_name.split('/');
          const user_name = path_parts[1];
          window.live_hooks.pushEvent(the_dir, user_name);
        } 

        function flash(target) {
          target.style.backgroundColor = "rgba(var(--the-player-colors), .1)";
        } 

        function enterM(bid) {
          button = document.getElementById(bid);
          button.style.backgroundColor = "#808080";
        }

        function leaveM(bid) {
          button = document.getElementById(bid);
          button.style.backgroundColor = "";
        }

        function enterJump(bid) {
          button = document.getElementById("jump-0");
          button.style.opacity = 1;
        }

        function leaveJump(bid) {
          button = document.getElementById("jump-0");
          button.style.opacity = 0;
        }
      </script>
    """
  end
end
