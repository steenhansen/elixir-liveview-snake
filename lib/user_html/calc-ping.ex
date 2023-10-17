defmodule CalcPing do
  use MultiGameWeb, :live_component

  def db_start_ms() do
    _current_ms = ping_current_ms(DateTime.utc_now())
  end

  ##  db_start_ms = JsPing.db_start_ms() 
  ##  JsPing.db_end_ms(db_start_ms)
  def db_end_ms(start_ms) do
    _ping_ms = calc_ping(start_ms, DateTime.utc_now())
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
    ...
    """
  end
end
