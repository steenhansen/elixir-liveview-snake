# wrong_live ==> player_live PlayerLive

defmodule HtmlRow do
  use MultiGameWeb, :live_component

  @doc  """
       jump_classes ----> hide_big_jump
           .hor-jump-1 { visibility: visible; scale: 1.35; }
        .hor-jump-2 { visibility: visible; scale: 1.9; }
         #p_1_0 { visibility: hidden; position: absolute; z-index:12; }
         #p_1_1 { visibility: hidden; position: absolute; z-index:12; }
         #p_1_2 { visibility: hidden; position: absolute; z-index:12; }
         #p_1_3 { visibility: hidden; position: absolute; z-index:12; }
          So the first image in every div is set to class="no-jump"
           Then when jumping the class is cleared, and thus visible via image tag css
  """

  def render(assigns) do

    ~H"""
        <div class="_row" id={"r_#{@row_id}"}>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[0]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[0]}"} class={"#{@jump_classes[0]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[1]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[1]}"} class={"#{@jump_classes[1]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[2]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[2]}"} class={"#{@jump_classes[2]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[3]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[3]}"} class={"#{@jump_classes[3]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[4]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[4]}"} class={"#{@jump_classes[4]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[5]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[5]}"} class={"#{@jump_classes[5]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[6]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[6]}"} class={"#{@jump_classes[6]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[7]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[7]}"} class={"#{@jump_classes[7]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[8]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[8]}"} class={"#{@jump_classes[8]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[9]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[9]}"} class={"#{@jump_classes[9]}"} /></div>





            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[10]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[10]}"} class={"#{@jump_classes[10]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[11]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[11]}"} class={"#{@jump_classes[11]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[12]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[12]}"} class={"#{@jump_classes[12]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[13]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[13]}"} class={"#{@jump_classes[13]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[14]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[14]}"} class={"#{@jump_classes[14]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[15]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[15]}"} class={"#{@jump_classes[15]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[16]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[16]}"} class={"#{@jump_classes[16]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[17]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[17]}"} class={"#{@jump_classes[17]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[18]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[18]}"} class={"#{@jump_classes[18]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[19]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[19]}"} class={"#{@jump_classes[19]}"} /></div>

            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[20]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[20]}"} class={"#{@jump_classes[20]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[21]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[21]}"} class={"#{@jump_classes[21]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[22]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[22]}"} class={"#{@jump_classes[22]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[23]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[23]}"} class={"#{@jump_classes[23]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[24]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[24]}"} class={"#{@jump_classes[24]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[25]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[25]}"} class={"#{@jump_classes[25]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[26]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[26]}"} class={"#{@jump_classes[26]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[27]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[27]}"} class={"#{@jump_classes[27]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[28]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[28]}"} class={"#{@jump_classes[28]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[29]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[29]}"} class={"#{@jump_classes[29]}"} /></div>


            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[30]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[30]}"} class={"#{@jump_classes[30]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[31]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[31]}"} class={"#{@jump_classes[31]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[32]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[32]}"} class={"#{@jump_classes[32]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[33]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[33]}"} class={"#{@jump_classes[33]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[34]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[34]}"} class={"#{@jump_classes[34]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[35]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[35]}"} class={"#{@jump_classes[35]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[36]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[36]}"} class={"#{@jump_classes[36]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[37]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[37]}"} class={"#{@jump_classes[37]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[38]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[38]}"} class={"#{@jump_classes[38]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[39]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[39]}"} class={"#{@jump_classes[39]}"} /></div>

            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[40]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[40]}"} class={"#{@jump_classes[40]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[41]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[41]}"} class={"#{@jump_classes[41]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[42]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[42]}"} class={"#{@jump_classes[42]}"} /></div>
            <div><img src={"/images/colored-icons.svg##{@svg_ind_plain[43]}"} />
                 <img src={"/images/colored-icons.svg##{@svg_ind_jump[43]}"} class={"#{@jump_classes[43]}"} /></div>

      </div>
    """
  end
end
