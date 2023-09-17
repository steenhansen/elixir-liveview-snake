# current_ping_ms

defmodule JsPing do
   use MultiGameWeb, :live_component

   def db_start_ms() do
      _current_ms = ping_current_ms(DateTime.utc_now())
   end
##  db_start_ms = JsPing.db_start_ms() 
##  JsPing.db_end_ms(db_start_ms)
   def db_end_ms(start_ms) do
      _ping_ms = calc_ping( start_ms, DateTime.utc_now() )
   end 

  #  start_ms = ping_current_ms( DateTime.utc_now() )
  def ping_current_ms(current_time) do
    small_seconds = current_time.second()
    {micro_sec, micro_digits} = current_time.microsecond()
    sec_mult = :math.pow(10, micro_digits)
    sec_with_micro = sec_mult * small_seconds + micro_sec

    _int_ms = trunc(sec_with_micro)
  end
 
  # ping_ms = calc_ping( start_ms, DateTime.utc_now() )
  def calc_ping(start_ms, current_time) do
    stop_time = ping_current_ms(current_time)
    if(stop_time < start_ms) do
      overflow_ms = start_ms - stop_time
      div(overflow_ms, 2)
    else
      both_ways_ms = stop_time - start_ms
      if both_ways_ms > 100_000 do
      end
      div(both_ways_ms, 2)
    end
  end



  def render(assigns) do
    ~H"""
      <div id="js_ping.ex">

        <script>

    function livePingTime(){

        window.live_hooks = this;
        server_ms_time = serverMsFromClient();
        this.pushEvent("update-ping", server_ms_time);
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

        <input phx-hook="PingTime" type="text" value={"#{@server_time_ms}"}
         hidden id="ping-box-ms" >
      </div>
    """
  end
end
