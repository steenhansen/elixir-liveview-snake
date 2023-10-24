defmodule JsOnload do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""
      <script>
        function getCssVar(css_var_name){
          d_c = document.documentElement
          a_var = getComputedStyle(d_c).getPropertyValue(css_var_name);
          return a_var;
        }

        function getCssVarNumber(css_var_name){
          d_c = document.documentElement
          an_int = Number(getComputedStyle(d_c).getPropertyValue(css_var_name));
          return an_int;
        }

        function setCssVar(css_var_name, var_value){
          d_c = document.documentElement
          d_c.style.setProperty(css_var_name, var_value);
        }

        function tryJump(){
          ok_jump_time =getCssVarNumber("--jump-var-can-jump-milli")
          cur_time = Date.now();
          if (cur_time > ok_jump_time) {
            jump_wait = jumpWaitTime() 
            jump_opacity = opacityJumpWait()
            next_time = cur_time + jump_wait;
            setCssVar("--jump-var-can-jump-milli", next_time)
            jump_man = document.getElementById("jump-man")
            jump_man.style.opacity = jump_opacity
            window.live_hooks.pushEvent("key-jump"); 
          }
        }

        function opacityJumpWait() {
          return 0.2
        }

        function jumpWaitTime(){
          return 3000;
        }         

        function opacityJumpOk() {
          return 1
        }
        
        function waitHalfSecond(){
          return 500
        }

        function neswHoverColor(){
          return "#000102"
        } 

        function fixJump(){
          ok_jump_time =getCssVarNumber("--jump-var-can-jump-milli")
          cur_time = Date.now();
          jump_man = document.getElementById("jump-man")
          if (jump_man !== null && cur_time > ok_jump_time) {
            jump_man.style.opacity = opacityJumpOk()
          }
        }

        window.onload = function (){
          give_url_a_name =getCssVar("--give_url_a_name")
          if (give_url_a_name=='true') {
            const nameless_location = window.location.toString(); 
            const last_char_slash = nameless_location.slice(-1) == "/"
            const player_name = last_char_slash ? "Player-Name" : "/Player-Name"; 
            const namefull_location = nameless_location + player_name; 
            window.location.replace(namefull_location);
          }
          setInterval(function () {fixJump()}, waitHalfSecond());
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
              tryJump()   
              }
          }

          window.addEventListener('keydown', eventHandler, false);
        }

        <%!-- function flash(target) {
          target.style.backgroundColor = "rgba(var(--the-player-colors), .1)";
        }  --%>

        function enterNesw(bid) {
          button = document.getElementById(bid);
          button.style.backgroundColor = neswHoverColor();
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
