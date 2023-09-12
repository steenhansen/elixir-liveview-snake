# wrong_live ==> player_live PlayerLive

defmodule MatrixRows do
  use MultiGameWeb, :live_component  
  
  def render(assigns) do
    ~H"""
     <div id="_rotator">
                 <.live_component module={SpinTable} id="spin-table-0" rr={0} vv={@vv[0]} />
                       <.live_component module={SpinTable} id="spin-table-1" rr={1} vv={@vv[1]} />
                       <.live_component module={SpinTable} id="spin-table-2" rr={2} vv={@vv[2]} />
                       <.live_component module={SpinTable} id="spin-table-3" rr={3} vv={@vv[3]} />
                       <.live_component module={SpinTable} id="spin-table-4" rr={4} vv={@vv[4]} />
                       <.live_component module={SpinTable} id="spin-table-5" rr={5} vv={@vv[5]} />
                       <.live_component module={SpinTable} id="spin-table-6" rr={6} vv={@vv[6]} />
                       <.live_component module={SpinTable} id="spin-table-7" rr={7} vv={@vv[7]} />
                       <.live_component module={SpinTable} id="spin-table-8" rr={8} vv={@vv[8]} />
                       <.live_component module={SpinTable} id="spin-table-9" rr={9} vv={@vv[9]} />

                       <.live_component module={SpinTable} id="spin-table-10" rr={10} vv={@vv[10]} />
                       <.live_component module={SpinTable} id="spin-table-11" rr={11} vv={@vv[11]} />
                       <.live_component module={SpinTable} id="spin-table-12" rr={12} vv={@vv[12]} />
                       <.live_component module={SpinTable} id="spin-table-13" rr={13} vv={@vv[13]} />
                       <.live_component module={SpinTable} id="spin-table-14" rr={14} vv={@vv[14]} />
                       <.live_component module={SpinTable} id="spin-table-15" rr={15} vv={@vv[15]} />
                       <.live_component module={SpinTable} id="spin-table-16" rr={16} vv={@vv[16]} />
                       <.live_component module={SpinTable} id="spin-table-17" rr={17} vv={@vv[17]} />
                       <.live_component module={SpinTable} id="spin-table-18" rr={18} vv={@vv[18]} />
                       <.live_component module={SpinTable} id="spin-table-19" rr={19} vv={@vv[19]} />

                       <.live_component module={SpinTable} id="spin-table-20" rr={20} vv={@vv[20]} />
                       <.live_component module={SpinTable} id="spin-table-21" rr={21} vv={@vv[21]} />
                       <.live_component module={SpinTable} id="spin-table-22" rr={22} vv={@vv[22]} />
                       <.live_component module={SpinTable} id="spin-table-23" rr={23} vv={@vv[23]} />
                       <.live_component module={SpinTable} id="spin-table-24" rr={24} vv={@vv[24]} />
                       <.live_component module={SpinTable} id="spin-table-25" rr={25} vv={@vv[25]} />
                       <.live_component module={SpinTable} id="spin-table-26" rr={26} vv={@vv[26]} />
                       <.live_component module={SpinTable} id="spin-table-27" rr={27} vv={@vv[27]} />
                       <.live_component module={SpinTable} id="spin-table-28" rr={28} vv={@vv[28]} />
                       <.live_component module={SpinTable} id="spin-table-29" rr={29} vv={@vv[29]} />

                       <.live_component module={SpinTable} id="spin-table-30" rr={30} vv={@vv[30]} />
                       <.live_component module={SpinTable} id="spin-table-31" rr={31} vv={@vv[31]} />
                       <.live_component module={SpinTable} id="spin-table-32" rr={32} vv={@vv[32]} />
                       <.live_component module={SpinTable} id="spin-table-33" rr={33} vv={@vv[33]} />
                       <.live_component module={SpinTable} id="spin-table-34" rr={34} vv={@vv[34]} />
                       <.live_component module={SpinTable} id="spin-table-35" rr={35} vv={@vv[35]} />
                       <.live_component module={SpinTable} id="spin-table-36" rr={36} vv={@vv[36]} />
                       <.live_component module={SpinTable} id="spin-table-37" rr={37} vv={@vv[37]} />
                       <.live_component module={SpinTable} id="spin-table-38" rr={38} vv={@vv[38]} />
                       <.live_component module={SpinTable} id="spin-table-39" rr={39} vv={@vv[39]} />

                       <.live_component module={SpinTable} id="spin-table-40" rr={40} vv={@vv[40]} />
                       <.live_component module={SpinTable} id="spin-table-41" rr={41} vv={@vv[41]} />
                       <.live_component module={SpinTable} id="spin-table-42" rr={42} vv={@vv[42]} />
                       <.live_component module={SpinTable} id="spin-table-43" rr={43} vv={@vv[43]} />

                     
            </div>
    """
  end
end
