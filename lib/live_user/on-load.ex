defmodule OnLoad do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""

        <script>
            

  window.onload = function (){
    eventHandler = function (e){
      phoenix_hooks = window.myhook
      if (e.keyCode == 37 ) { 
        phoenix_hooks.pushEvent("key-west","key_west");
      } else if (e.keyCode == 38 ) { 
        phoenix_hooks.pushEvent("key-north","key_north");
      } else if (e.keyCode == 39 ) { 
        phoenix_hooks.pushEvent("key-east","key_east");
      } else if (e.keyCode == 40 ) { 
        phoenix_hooks.pushEvent("key-south","key_south");
      }
    }
    window.addEventListener('keydown', eventHandler, false);
    } 

    
    function headingChange(the_dir) {
      const path_name = location.pathname
      const path_parts = path_name.split('/');
      const user_name = path_parts[1]
      window.myhook.pushEvent(the_dir, user_name);
    } 

       function flash(target) {
          target.style.backgroundColor = "rgba(var(--the-player-colors), .1)";
      } 
     

     function enterM(bid) {
  button = document.getElementById(bid)
  button.style.backgroundColor = "#808080";
}

function leaveM(bid) {
  button = document.getElementById(bid)
  button.style.backgroundColor = "";
}

function enterJ(bid) {
  button = document.getElementById(bid)
  button.style.opacity = 0;

    button = document.getElementById("da_XX")
      button.style.opacity = 1;
}

function leaveJ(bid) {
  button = document.getElementById(bid)
  button.style.opacity = 1;

      button = document.getElementById("da_XX")
      button.style.opacity = 0;
}

        </script>


    """
  end
end
