defmodule JsOnload do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""
      <script>
        window.onload = function (){
          eventHandler = function (e){
            phoenix_hooks = window.live_hooks;
            key_code = e.keyCode;
            if (key_code == 37 ) { 
              e.preventDefault();                   
              phoenix_hooks.pushEvent("key-west");
            } else if (key_code == 38 ) { 
              e.preventDefault();                   
              phoenix_hooks.pushEvent("key-north");
            } else if (key_code == 39 ) { 
              e.preventDefault();                   
              phoenix_hooks.pushEvent("key-east");
            } else if (key_code == 40 ) { 
              e.preventDefault();                   
              phoenix_hooks.pushEvent("key-south");
            } else if (key_code == 32 ) { 
              e.preventDefault();                   
              phoenix_hooks.pushEvent("key-jump");
              }
          }

          window.addEventListener('keydown', eventHandler, false);
        }

        
        function flash(target) {
          target.style.backgroundColor = "rgba(var(--the-player-colors), .1)";
        } 

        function enterNesw(bid) {
          button = document.getElementById(bid);
          button.style.backgroundColor = "#000102";
        }

        function leaveNesw(bid) {
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
