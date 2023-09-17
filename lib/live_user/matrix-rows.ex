# wrong_live ==> player_live PlayerLive

defmodule MatrixRows do
  use MultiGameWeb, :live_component

  def render(assigns) do
    # new_plots = Map.put(old_user_plots, number_str, MapSet.new())
    #dbg({"VV render", assigns.vv})
   # dbg({"JJJ render", assigns.jump_classes})
    # da_cols = Map.new()
    # da_jump = Map.new()
  #   color =
  #     assigns.vv
  #     |> Enum.map(fn {the_row, the_columns} ->
  #       # dbg({"ROW", the_row, the_columns})

  #       the_columns
  #       |> Enum.map(fn {the_column, {the_color, the_jump}} ->
  #         #  dbg({"COLUMN", the_row, the_column, the_color, the_jump})
  #         {the_column, the_color}
  #       end)
  #       |> Map.new()
  #       |> then(fn a_row -> {the_row, a_row} end)
  #     end)
  #     |> Map.new()

  #   dbg({"AAAAAAAAAAAAAA render col", color})
  # #   assigns.color=color
    #       dbg({"AA render {col, jump}", assigns.vv[0]})
    #  dbg({"AA render col", color})
    #   dbg({"AA render jump}", color[0]})      jump_classes={@jump_classes[0]}

    ~H"""
     <div id="rotator_squares">
                       <.live_component module={SpinTable} id="spin-table-0" rr={0} vv={@vv[0]}  jump_classes={@jump_classes[0]} />
                       <.live_component module={SpinTable} id="spin-table-1" rr={1} vv={@vv[1]}  jump_classes={@jump_classes[1]} />
                       <.live_component module={SpinTable} id="spin-table-2" rr={2} vv={@vv[2]}  jump_classes={@jump_classes[2]} />
                       <.live_component module={SpinTable} id="spin-table-3" rr={3} vv={@vv[3]}  jump_classes={@jump_classes[3]} />
                       <.live_component module={SpinTable} id="spin-table-4" rr={4} vv={@vv[4]}  jump_classes={@jump_classes[4]} />
                       <.live_component module={SpinTable} id="spin-table-5" rr={5} vv={@vv[5]}  jump_classes={@jump_classes[5]} />
                       <.live_component module={SpinTable} id="spin-table-6" rr={6} vv={@vv[6]}  jump_classes={@jump_classes[6]} />
                       <.live_component module={SpinTable} id="spin-table-7" rr={7} vv={@vv[7]}  jump_classes={@jump_classes[7]} />
                       <.live_component module={SpinTable} id="spin-table-8" rr={8} vv={@vv[8]}  jump_classes={@jump_classes[8]} />
                       <.live_component module={SpinTable} id="spin-table-9" rr={9} vv={@vv[9]}  jump_classes={@jump_classes[9]} />

                       <.live_component module={SpinTable} id="spin-table-10" rr={10} vv={@vv[10]}  jump_classes={@jump_classes[10]} />
                       <.live_component module={SpinTable} id="spin-table-11" rr={11} vv={@vv[11]}  jump_classes={@jump_classes[11]} />
                       <.live_component module={SpinTable} id="spin-table-12" rr={12} vv={@vv[12]}  jump_classes={@jump_classes[12]} />
                       <.live_component module={SpinTable} id="spin-table-13" rr={13} vv={@vv[13]}  jump_classes={@jump_classes[13]} />
                       <.live_component module={SpinTable} id="spin-table-14" rr={14} vv={@vv[14]}  jump_classes={@jump_classes[14]} />
                       <.live_component module={SpinTable} id="spin-table-15" rr={15} vv={@vv[15]}  jump_classes={@jump_classes[15]} />
                       <.live_component module={SpinTable} id="spin-table-16" rr={16} vv={@vv[16]}  jump_classes={@jump_classes[16]} />
                       <.live_component module={SpinTable} id="spin-table-17" rr={17} vv={@vv[17]}  jump_classes={@jump_classes[17]} />
                       <.live_component module={SpinTable} id="spin-table-18" rr={18} vv={@vv[18]}  jump_classes={@jump_classes[18]} />
                       <.live_component module={SpinTable} id="spin-table-19" rr={19} vv={@vv[19]}  jump_classes={@jump_classes[19]} />

                       <.live_component module={SpinTable} id="spin-table-20" rr={20} vv={@vv[20]}  jump_classes={@jump_classes[20]} />
                       <.live_component module={SpinTable} id="spin-table-21" rr={21} vv={@vv[21]}  jump_classes={@jump_classes[21]} />
                       <.live_component module={SpinTable} id="spin-table-22" rr={22} vv={@vv[22]}  jump_classes={@jump_classes[22]} />
                       <.live_component module={SpinTable} id="spin-table-23" rr={23} vv={@vv[23]}  jump_classes={@jump_classes[23]} />
                       <.live_component module={SpinTable} id="spin-table-24" rr={24} vv={@vv[24]}  jump_classes={@jump_classes[24]} />
                       <.live_component module={SpinTable} id="spin-table-25" rr={25} vv={@vv[25]}  jump_classes={@jump_classes[25]} />
                       <.live_component module={SpinTable} id="spin-table-26" rr={26} vv={@vv[26]}  jump_classes={@jump_classes[26]} />
                       <.live_component module={SpinTable} id="spin-table-27" rr={27} vv={@vv[27]}  jump_classes={@jump_classes[27]} />
                       <.live_component module={SpinTable} id="spin-table-28" rr={28} vv={@vv[28]}  jump_classes={@jump_classes[28]} />
                       <.live_component module={SpinTable} id="spin-table-29" rr={29} vv={@vv[29]}  jump_classes={@jump_classes[29]} />

                       <.live_component module={SpinTable} id="spin-table-30" rr={30} vv={@vv[30]}  jump_classes={@jump_classes[30]} />
                       <.live_component module={SpinTable} id="spin-table-31" rr={31} vv={@vv[31]}  jump_classes={@jump_classes[31]} />
                       <.live_component module={SpinTable} id="spin-table-32" rr={32} vv={@vv[32]}  jump_classes={@jump_classes[32]} />
                       <.live_component module={SpinTable} id="spin-table-33" rr={33} vv={@vv[33]}  jump_classes={@jump_classes[33]} />
                       <.live_component module={SpinTable} id="spin-table-34" rr={34} vv={@vv[34]}  jump_classes={@jump_classes[34]} />
                       <.live_component module={SpinTable} id="spin-table-35" rr={35} vv={@vv[35]}  jump_classes={@jump_classes[35]} />
                       <.live_component module={SpinTable} id="spin-table-36" rr={36} vv={@vv[36]}  jump_classes={@jump_classes[36]} />
                       <.live_component module={SpinTable} id="spin-table-37" rr={37} vv={@vv[37]}  jump_classes={@jump_classes[37]} />
                       <.live_component module={SpinTable} id="spin-table-38" rr={38} vv={@vv[38]}  jump_classes={@jump_classes[38]} />
                       <.live_component module={SpinTable} id="spin-table-39" rr={39} vv={@vv[39]}  jump_classes={@jump_classes[39]} />

                       <.live_component module={SpinTable} id="spin-table-40" rr={40} vv={@vv[40]}  jump_classes={@jump_classes[40]} />
                       <.live_component module={SpinTable} id="spin-table-41" rr={41} vv={@vv[41]}  jump_classes={@jump_classes[41]} />
                       <.live_component module={SpinTable} id="spin-table-42" rr={42} vv={@vv[42]}  jump_classes={@jump_classes[42]} />
                       <.live_component module={SpinTable} id="spin-table-43" rr={43} vv={@vv[43]}  jump_classes={@jump_classes[43]} />

                     
            </div>
    """
  end
end
