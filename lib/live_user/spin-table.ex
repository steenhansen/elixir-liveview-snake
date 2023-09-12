# wrong_live ==> player_live PlayerLive

defmodule SpinTable do
use MultiGameWeb, :live_component 

def render(assigns) do  
~H"""
    <div class="_row" id={"r_#{@rr}"}>
     <img id={"p_#{@rr}_0"} class="_tile" src={"/images/colored-icons.svg##{@vv[0]}"} />
      <img id={"p_#{@rr}_1"} class="_tile" src={"/images/colored-icons.svg##{@vv[1]}"} />
      <img id={"p_#{@rr}_2"} class="_tile" src={"/images/colored-icons.svg##{@vv[2]}"} />
      <img id={"p_#{@rr}_3"} class="_tile" src={"/images/colored-icons.svg##{@vv[3]}"} />
      <img id={"p_#{@rr}_4"} class="_tile" src={"/images/colored-icons.svg##{@vv[4]}"} />
      <img id={"p_#{@rr}_5"} class="_tile" src={"/images/colored-icons.svg##{@vv[5]}"} />
      <img id={"p_#{@rr}_6"} class="_tile" src={"/images/colored-icons.svg##{@vv[6]}"} />
      <img id={"p_#{@rr}_7"} class="_tile" src={"/images/colored-icons.svg##{@vv[7]}"} />
      <img id={"p_#{@rr}_8"} class="_tile" src={"/images/colored-icons.svg##{@vv[8]}"} />
      <img id={"p_#{@rr}_9"} class="_tile" src={"/images/colored-icons.svg##{@vv[9]}"} />

      <img id={"p_#{@rr}_10"} class="_tile" src={"/images/colored-icons.svg##{@vv[10]}"} />
      <img id={"p_#{@rr}_11"} class="_tile" src={"/images/colored-icons.svg##{@vv[11]}"} />
      <img id={"p_#{@rr}_12"} class="_tile" src={"/images/colored-icons.svg##{@vv[12]}"} />
      <img id={"p_#{@rr}_13"} class="_tile" src={"/images/colored-icons.svg##{@vv[13]}"} />
      <img id={"p_#{@rr}_14"} class="_tile" src={"/images/colored-icons.svg##{@vv[14]}"} />
      <img id={"p_#{@rr}_15"} class="_tile" src={"/images/colored-icons.svg##{@vv[15]}"} />
      <img id={"p_#{@rr}_16"} class="_tile" src={"/images/colored-icons.svg##{@vv[16]}"} />
      <img id={"p_#{@rr}_17"} class="_tile" src={"/images/colored-icons.svg##{@vv[17]}"} />
      <img id={"p_#{@rr}_18"} class="_tile" src={"/images/colored-icons.svg##{@vv[18]}"} />
      <img id={"p_#{@rr}_19"} class="_tile" src={"/images/colored-icons.svg##{@vv[19]}"} />

      <img id={"p_#{@rr}_20"} class="_tile" src={"/images/colored-icons.svg##{@vv[20]}"} />
      <img id={"p_#{@rr}_21"} class="_tile" src={"/images/colored-icons.svg##{@vv[21]}"} />
      <img id={"p_#{@rr}_22"} class="_tile" src={"/images/colored-icons.svg##{@vv[22]}"} />
      <img id={"p_#{@rr}_23"} class="_tile" src={"/images/colored-icons.svg##{@vv[23]}"} />
      <img id={"p_#{@rr}_24"} class="_tile" src={"/images/colored-icons.svg##{@vv[24]}"} />
      <img id={"p_#{@rr}_25"} class="_tile" src={"/images/colored-icons.svg##{@vv[25]}"} />
      <img id={"p_#{@rr}_26"} class="_tile" src={"/images/colored-icons.svg##{@vv[26]}"} />
      <img id={"p_#{@rr}_27"} class="_tile" src={"/images/colored-icons.svg##{@vv[27]}"} />
      <img id={"p_#{@rr}_28"} class="_tile" src={"/images/colored-icons.svg##{@vv[28]}"} />
      <img id={"p_#{@rr}_29"} class="_tile" src={"/images/colored-icons.svg##{@vv[29]}"} />

      <img id={"p_#{@rr}_30"} class="_tile" src={"/images/colored-icons.svg##{@vv[30]}"} />
      <img id={"p_#{@rr}_31"} class="_tile" src={"/images/colored-icons.svg##{@vv[31]}"} />
      <img id={"p_#{@rr}_32"} class="_tile" src={"/images/colored-icons.svg##{@vv[32]}"} />
      <img id={"p_#{@rr}_33"} class="_tile" src={"/images/colored-icons.svg##{@vv[33]}"} />
      <img id={"p_#{@rr}_34"} class="_tile" src={"/images/colored-icons.svg##{@vv[34]}"} />
      <img id={"p_#{@rr}_35"} class="_tile" src={"/images/colored-icons.svg##{@vv[35]}"} />
      <img id={"p_#{@rr}_36"} class="_tile" src={"/images/colored-icons.svg##{@vv[36]}"} />
      <img id={"p_#{@rr}_37"} class="_tile" src={"/images/colored-icons.svg##{@vv[37]}"} />
      <img id={"p_#{@rr}_38"} class="_tile" src={"/images/colored-icons.svg##{@vv[38]}"} />
      <img id={"p_#{@rr}_39"} class="_tile" src={"/images/colored-icons.svg##{@vv[39]}"} />

      <img id={"p_#{@rr}_40"} class="_tile" src={"/images/colored-icons.svg##{@vv[40]}"} />
      <img id={"p_#{@rr}_41"} class="_tile" src={"/images/colored-icons.svg##{@vv[41]}"} />
      <img id={"p_#{@rr}_42"} class="_tile" src={"/images/colored-icons.svg##{@vv[42]}"} />
      <img id={"p_#{@rr}_43"} class="_tile" src={"/images/colored-icons.svg##{@vv[43]}"} />






  </div>
"""
end
end