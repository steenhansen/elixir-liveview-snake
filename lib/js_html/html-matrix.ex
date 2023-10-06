# wrong_live ==> player_live PlayerLive

defmodule HtmlMatrix do
  use MultiGameWeb, :live_component

  def render(assigns) do

    ~H"""
     <div id="rotator_squares">
                       <.live_component module={HtmlRow} id="row-0" row_id={0} svg_ind_plain={@html_rows_svg_inds[0]} svg_ind_jump={@html_rows_jump_inds[0]} 
                       jump_classes={@html_jump_classes[0]} />
                       <.live_component module={HtmlRow} id="row-1" row_id={1} svg_ind_plain={@html_rows_svg_inds[1]} svg_ind_jump={@html_rows_jump_inds[1]} jump_classes={@html_jump_classes[1]} />
                       <.live_component module={HtmlRow} id="row-2" row_id={2} svg_ind_plain={@html_rows_svg_inds[2]} svg_ind_jump={@html_rows_jump_inds[2]} jump_classes={@html_jump_classes[2]} />
                       <.live_component module={HtmlRow} id="row-3" row_id={3} svg_ind_plain={@html_rows_svg_inds[3]} svg_ind_jump={@html_rows_jump_inds[3]} jump_classes={@html_jump_classes[3]} />
                       <.live_component module={HtmlRow} id="row-4" row_id={4} svg_ind_plain={@html_rows_svg_inds[4]} svg_ind_jump={@html_rows_jump_inds[4]} jump_classes={@html_jump_classes[4]} />
                       <.live_component module={HtmlRow} id="row-5" row_id={5} svg_ind_plain={@html_rows_svg_inds[5]} svg_ind_jump={@html_rows_jump_inds[5]} jump_classes={@html_jump_classes[5]} />
                       <.live_component module={HtmlRow} id="row-6" row_id={6} svg_ind_plain={@html_rows_svg_inds[6]} svg_ind_jump={@html_rows_jump_inds[6]} jump_classes={@html_jump_classes[6]} />
                       <.live_component module={HtmlRow} id="row-7" row_id={7} svg_ind_plain={@html_rows_svg_inds[7]} svg_ind_jump={@html_rows_jump_inds[7]} jump_classes={@html_jump_classes[7]} />
                       <.live_component module={HtmlRow} id="row-8" row_id={8} svg_ind_plain={@html_rows_svg_inds[8]} svg_ind_jump={@html_rows_jump_inds[8]} jump_classes={@html_jump_classes[8]} />
                       <.live_component module={HtmlRow} id="row-9" row_id={9} svg_ind_plain={@html_rows_svg_inds[9]} svg_ind_jump={@html_rows_jump_inds[9]} jump_classes={@html_jump_classes[9]} />

                       <.live_component module={HtmlRow} id="row-10" row_id={10} svg_ind_plain={@html_rows_svg_inds[10]} svg_ind_jump={@html_rows_jump_inds[10]} jump_classes={@html_jump_classes[10]} />
                       <.live_component module={HtmlRow} id="row-11" row_id={11} svg_ind_plain={@html_rows_svg_inds[11]} svg_ind_jump={@html_rows_jump_inds[11]} jump_classes={@html_jump_classes[11]} />
                       <.live_component module={HtmlRow} id="row-12" row_id={12} svg_ind_plain={@html_rows_svg_inds[12]} svg_ind_jump={@html_rows_jump_inds[12]} jump_classes={@html_jump_classes[12]} />
                       <.live_component module={HtmlRow} id="row-13" row_id={13} svg_ind_plain={@html_rows_svg_inds[13]} svg_ind_jump={@html_rows_jump_inds[13]} jump_classes={@html_jump_classes[13]} />
                       <.live_component module={HtmlRow} id="row-14" row_id={14} svg_ind_plain={@html_rows_svg_inds[14]} svg_ind_jump={@html_rows_jump_inds[14]} jump_classes={@html_jump_classes[14]} />
                       <.live_component module={HtmlRow} id="row-15" row_id={15} svg_ind_plain={@html_rows_svg_inds[15]} svg_ind_jump={@html_rows_jump_inds[15]} jump_classes={@html_jump_classes[15]} />
                       <.live_component module={HtmlRow} id="row-16" row_id={16} svg_ind_plain={@html_rows_svg_inds[16]} svg_ind_jump={@html_rows_jump_inds[16]} jump_classes={@html_jump_classes[16]} />
                       <.live_component module={HtmlRow} id="row-17" row_id={17} svg_ind_plain={@html_rows_svg_inds[17]} svg_ind_jump={@html_rows_jump_inds[17]} jump_classes={@html_jump_classes[17]} />
                       <.live_component module={HtmlRow} id="row-18" row_id={18} svg_ind_plain={@html_rows_svg_inds[18]} svg_ind_jump={@html_rows_jump_inds[18]} jump_classes={@html_jump_classes[18]} />
                       <.live_component module={HtmlRow} id="row-19" row_id={19} svg_ind_plain={@html_rows_svg_inds[19]} svg_ind_jump={@html_rows_jump_inds[19]} jump_classes={@html_jump_classes[19]} />

                       <.live_component module={HtmlRow} id="row-20" row_id={20} svg_ind_plain={@html_rows_svg_inds[20]} svg_ind_jump={@html_rows_jump_inds[20]} jump_classes={@html_jump_classes[20]} />
                       <.live_component module={HtmlRow} id="row-21" row_id={21} svg_ind_plain={@html_rows_svg_inds[21]} svg_ind_jump={@html_rows_jump_inds[21]} jump_classes={@html_jump_classes[21]} />
                       <.live_component module={HtmlRow} id="row-22" row_id={22} svg_ind_plain={@html_rows_svg_inds[22]} svg_ind_jump={@html_rows_jump_inds[22]} jump_classes={@html_jump_classes[22]} />
                       <.live_component module={HtmlRow} id="row-23" row_id={23} svg_ind_plain={@html_rows_svg_inds[23]} svg_ind_jump={@html_rows_jump_inds[23]} jump_classes={@html_jump_classes[23]} />
                       <.live_component module={HtmlRow} id="row-24" row_id={24} svg_ind_plain={@html_rows_svg_inds[24]} svg_ind_jump={@html_rows_jump_inds[24]} jump_classes={@html_jump_classes[24]} />
                       <.live_component module={HtmlRow} id="row-25" row_id={25} svg_ind_plain={@html_rows_svg_inds[25]} svg_ind_jump={@html_rows_jump_inds[25]} jump_classes={@html_jump_classes[25]} />
                       <.live_component module={HtmlRow} id="row-26" row_id={26} svg_ind_plain={@html_rows_svg_inds[26]} svg_ind_jump={@html_rows_jump_inds[26]} jump_classes={@html_jump_classes[26]} />
                       <.live_component module={HtmlRow} id="row-27" row_id={27} svg_ind_plain={@html_rows_svg_inds[27]} svg_ind_jump={@html_rows_jump_inds[27]} jump_classes={@html_jump_classes[27]} />
                       <.live_component module={HtmlRow} id="row-28" row_id={28} svg_ind_plain={@html_rows_svg_inds[28]} svg_ind_jump={@html_rows_jump_inds[28]} jump_classes={@html_jump_classes[28]} />
                       <.live_component module={HtmlRow} id="row-29" row_id={29} svg_ind_plain={@html_rows_svg_inds[29]} svg_ind_jump={@html_rows_jump_inds[29]} jump_classes={@html_jump_classes[29]} />

                       <.live_component module={HtmlRow} id="row-30" row_id={30} svg_ind_plain={@html_rows_svg_inds[30]} svg_ind_jump={@html_rows_jump_inds[30]} jump_classes={@html_jump_classes[30]} />
                       <.live_component module={HtmlRow} id="row-31" row_id={31} svg_ind_plain={@html_rows_svg_inds[31]} svg_ind_jump={@html_rows_jump_inds[31]} jump_classes={@html_jump_classes[31]} />
                       <.live_component module={HtmlRow} id="row-32" row_id={32} svg_ind_plain={@html_rows_svg_inds[32]} svg_ind_jump={@html_rows_jump_inds[32]} jump_classes={@html_jump_classes[32]} />
                       <.live_component module={HtmlRow} id="row-33" row_id={33} svg_ind_plain={@html_rows_svg_inds[33]} svg_ind_jump={@html_rows_jump_inds[33]} jump_classes={@html_jump_classes[33]} />
                       <.live_component module={HtmlRow} id="row-34" row_id={34} svg_ind_plain={@html_rows_svg_inds[34]} svg_ind_jump={@html_rows_jump_inds[34]} jump_classes={@html_jump_classes[34]} />
                       <.live_component module={HtmlRow} id="row-35" row_id={35} svg_ind_plain={@html_rows_svg_inds[35]} svg_ind_jump={@html_rows_jump_inds[35]} jump_classes={@html_jump_classes[35]} />
                       <.live_component module={HtmlRow} id="row-36" row_id={36} svg_ind_plain={@html_rows_svg_inds[36]} svg_ind_jump={@html_rows_jump_inds[36]} jump_classes={@html_jump_classes[36]} />
                       <.live_component module={HtmlRow} id="row-37" row_id={37} svg_ind_plain={@html_rows_svg_inds[37]} svg_ind_jump={@html_rows_jump_inds[37]} jump_classes={@html_jump_classes[37]} />
                       <.live_component module={HtmlRow} id="row-38" row_id={38} svg_ind_plain={@html_rows_svg_inds[38]} svg_ind_jump={@html_rows_jump_inds[38]} jump_classes={@html_jump_classes[38]} />
                       <.live_component module={HtmlRow} id="row-39" row_id={39} svg_ind_plain={@html_rows_svg_inds[39]} svg_ind_jump={@html_rows_jump_inds[39]} jump_classes={@html_jump_classes[39]} />

                       <.live_component module={HtmlRow} id="row-40" row_id={40} svg_ind_plain={@html_rows_svg_inds[40]}  svg_ind_jump={@html_rows_jump_inds[40]}  jump_classes={@html_jump_classes[40]} />
                       <.live_component module={HtmlRow} id="row-41" row_id={41} svg_ind_plain={@html_rows_svg_inds[41]}  svg_ind_jump={@html_rows_jump_inds[41]}  jump_classes={@html_jump_classes[41]} />
                       <.live_component module={HtmlRow} id="row-42" row_id={42} svg_ind_plain={@html_rows_svg_inds[42]}  svg_ind_jump={@html_rows_jump_inds[42]}  jump_classes={@html_jump_classes[42]} />
                       <.live_component module={HtmlRow} id="row-43" row_id={43} svg_ind_plain={@html_rows_svg_inds[43]}  svg_ind_jump={@html_rows_jump_inds[43]}  jump_classes={@html_jump_classes[43]} />

                     
            </div>
    """
  end
end
