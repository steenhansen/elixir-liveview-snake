# wrong_live ==> player_live PlayerLive

defmodule SpinTable do
  use MultiGameWeb, :live_component


  @doc since: """
         


      jump_classes ----> hide_big_jump



    img{ visibility: visible; }

    .not-jumping { visibility: hidden; }

    #p_1_0 {position: absolute; scale: 1.5; z-index:12; }
    #p_1_1 {position: absolute; scale: 1.5; z-index:12; }
    #p_1_2 {position: absolute; scale: 1.5; z-index:12; }
    #p_1_3 {position: absolute; scale: 1.5; z-index:12; }

    So the first image in every div is set to class="not-jumping"

    Then when jumping the class is cleared, and thus visible via image tag css
    
       """

  def render(assigns) do
    dbg(assigns.jump_classes)

    ~H"""
        <div class="_row" id={"r_#{@rr}"}>
        <div>
          <img id={"p_#{@rr}_0"} class={"#{@jump_classes[0]}"} src={"/images/colored-icons.svg##{@vv[0]}"} />
          </div>
          <div>
          <img id={"p_#{@rr}_1"} class={"#{@jump_classes[1]}"} src={"/images/colored-icons.svg##{@vv[1]}"} />
                    </div>



          <div>
              <img src={"/images/colored-icons.svg##{@vv[2]}"} id={"p_#{@rr}_2"} class={"#{@jump_classes[2]}"} />
              <img src={"/images/colored-icons.svg##{@vv[2]}"} />
          </div>


          <div>
              <img src={"/images/colored-icons.svg##{@vv[3]}"} id={"p_#{@rr}_3"} class={"#{@jump_classes[3]}"}  />
              <img src={"/images/colored-icons.svg##{@vv[3]}"} />
          </div>
                  


          <div>
          <img id={"p_#{@rr}_4"} class={"#{@jump_classes[4]}"} src={"/images/colored-icons.svg##{@vv[4]}"} />
                    </div>
          <div>
          <img id={"p_#{@rr}_5"} class={"#{@jump_classes[5]}"} src={"/images/colored-icons.svg##{@vv[5]}"} />
                    </div>
          <div>
          <img id={"p_#{@rr}_6"} class={"#{@jump_classes[6]}"} src={"/images/colored-icons.svg##{@vv[6]}"} />
                    </div>
          <div>
          <img id={"p_#{@rr}_7"} class={"#{@jump_classes[7]}"} src={"/images/colored-icons.svg##{@vv[7]}"} />
                    </div>
          <div>
          <img id={"p_#{@rr}_8"} class={"#{@jump_classes[8]}"} src={"/images/colored-icons.svg##{@vv[8]}"} />
                    </div>
          <div>
          <img id={"p_#{@rr}_9"} class={"#{@jump_classes[9]}"} src={"/images/colored-icons.svg##{@vv[9]}"} />
          </div>
          
          
          
          <div>



          <img id={"p_#{@rr}_10"} class={"#{@jump_classes[10]}"} src={"/images/colored-icons.svg##{@vv[10]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_11"} class={"#{@jump_classes[11]}"} src={"/images/colored-icons.svg##{@vv[11]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_12"} class={"#{@jump_classes[12]}"} src={"/images/colored-icons.svg##{@vv[12]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_13"} class={"#{@jump_classes[13]}"} src={"/images/colored-icons.svg##{@vv[13]}"} />   
                      </div>
          <div>
          <img id={"p_#{@rr}_14"} class={"#{@jump_classes[14]}"} src={"/images/colored-icons.svg##{@vv[14]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_15"} class={"#{@jump_classes[15]}"} src={"/images/colored-icons.svg##{@vv[15]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_16"} class={"#{@jump_classes[16]}"} src={"/images/colored-icons.svg##{@vv[16]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_17"} class={"#{@jump_classes[17]}"} src={"/images/colored-icons.svg##{@vv[17]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_18"} class={"#{@jump_classes[18]}"} src={"/images/colored-icons.svg##{@vv[18]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_19"} class={"#{@jump_classes[19]}"} src={"/images/colored-icons.svg##{@vv[19]}"} />

                         </div>
          <div>
          <img id={"p_#{@rr}_20"} class={"#{@jump_classes[20]}"} src={"/images/colored-icons.svg##{@vv[20]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_21"} class={"#{@jump_classes[21]}"} src={"/images/colored-icons.svg##{@vv[21]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_22"} class={"#{@jump_classes[22]}"} src={"/images/colored-icons.svg##{@vv[22]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_23"} class={"#{@jump_classes[23]}"} src={"/images/colored-icons.svg##{@vv[23]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_24"} class={"#{@jump_classes[24]}"} src={"/images/colored-icons.svg##{@vv[24]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_25"} class={"#{@jump_classes[25]}"} src={"/images/colored-icons.svg##{@vv[25]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_26"} class={"#{@jump_classes[26]}"} src={"/images/colored-icons.svg##{@vv[26]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_27"} class={"#{@jump_classes[27]}"} src={"/images/colored-icons.svg##{@vv[27]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_28"} class={"#{@jump_classes[28]}"} src={"/images/colored-icons.svg##{@vv[28]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_29"} class={"#{@jump_classes[29]}"} src={"/images/colored-icons.svg##{@vv[29]}"} />

                         </div>
          <div>
          <img id={"p_#{@rr}_30"} class={"#{@jump_classes[30]}"} src={"/images/colored-icons.svg##{@vv[30]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_31"} class={"#{@jump_classes[31]}"} src={"/images/colored-icons.svg##{@vv[31]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_32"} class={"#{@jump_classes[32]}"} src={"/images/colored-icons.svg##{@vv[32]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_33"} class={"#{@jump_classes[33]}"} src={"/images/colored-icons.svg##{@vv[33]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_34"} class={"#{@jump_classes[34]}"} src={"/images/colored-icons.svg##{@vv[34]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_35"} class={"#{@jump_classes[35]}"} src={"/images/colored-icons.svg##{@vv[35]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_36"} class={"#{@jump_classes[36]}"} src={"/images/colored-icons.svg##{@vv[36]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_37"} class={"#{@jump_classes[37]}"} src={"/images/colored-icons.svg##{@vv[37]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_38"} class={"#{@jump_classes[38]}"} src={"/images/colored-icons.svg##{@vv[38]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_39"} class={"#{@jump_classes[39]}"} src={"/images/colored-icons.svg##{@vv[39]}"} />
               </div>
          <div>
          
          <img id={"p_#{@rr}_40"} class={"#{@jump_classes[40]}"} src={"/images/colored-icons.svg##{@vv[40]}"} />
               </div>
          <div>
                    <img id={"p_#{@rr}_41"} class={"#{@jump_classes[41]}"} src={"/images/colored-icons.svg##{@vv[41]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_42"} class={"#{@jump_classes[42]}"} src={"/images/colored-icons.svg##{@vv[42]}"} />
                         </div>
          <div>
          <img id={"p_#{@rr}_43"} class={"#{@jump_classes[43]}"} src={"/images/colored-icons.svg##{@vv[43]}"} />
               </div>
          





      </div>
    """
  end
end
