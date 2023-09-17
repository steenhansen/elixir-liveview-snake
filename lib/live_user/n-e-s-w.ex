# wrong_live ==> player_live PlayerLive

defmodule NESW do
  use MultiGameWeb, :live_component

  def render(assigns) do
    ~H"""
     <div id="nesw">
            
    <div class=""  style="clear:both">
    <div class=""  style="float:none">



    <div style="margin-left:145px; width:120px; height:120px; float:none" id="thermostat" class="max-w-2xl mx-auto">
      <div class="flex-grid">
        <div class="flex-col"></div>
        <div id="nnn" class="xxx-n" class="flex-col"  
            onclick=' headingChange("key-north") ' 
            onmouseenter='enterM("nnn")' 
              onmouseleave='leaveM("nnn")'>
            <img id="the-n"  src="/images/n_north.svg"  class="_control" />
        </div>
        <div class="flex-col"></div>
      </div>
      <div class="flex-grid">
        <div  class="xxx-n"  class="flex-col"  onclick=' headingChange("key-west") '>

            <img id="_0cd_4" src="/images/w_west.svg" class="_control" />

        </div>
        <div   id="mmmm" class="flex-col"  style="width:40px; height:40px">

            <div   class="flex-col" style="display:relative" 
                    onclick = 'snakeJump("key-jump")'
                    onmouseenter = 'enterJump()'   
                    onmouseleave = 'leaveJump()'>


                  <img id="jump-1" src="/images/colored-icons.svg#14" class="_control" />
                  <img id="jump-2" src="/images/colored-icons.svg#24" class="_control" />
                  <img id="jump-3" src="/images/colored-icons.svg#34" class="_control" />
                  <img id="jump-4" src="/images/colored-icons.svg#44" class="_control" />
                  <img id="jump-5" src="/images/colored-icons.svg#54" class="_control" />
                  <img id="jump-6" src="/images/colored-icons.svg#64" class="_control" />
                  <img id="jump-7" src="/images/colored-icons.svg#74" class="_control" />
                  <img id="jump-8" src="/images/colored-icons.svg#84" class="_control" />
                  <img id="jump-9" src="/images/colored-icons.svg#94" class="_control" />
                  <img id="jump-0" src="/images/colored-icons.svg#4" class="_control" />  

                  
           </div>

        </div>
        <div  class="xxx-n"  class="flex-col"  onclick=' headingChange("key-east") '>


            <img id="_0cd_6" src="/images/e_east.svg" class="_control" />
          

          </div>
      </div>
      <div class="flex-grid">
        <div class="flex-col"></div>
        <div  class="xxx-n"  class="flex-col"  onclick=' headingChange("key-south") '>

        
            <img id="_0cd_8" src="/images/s_south.svg" class="_control" />
        </div>
        <div class="flex-col"></div>
      </div>
    </div>


    </div>
    </div>
                     
            </div>
    """
  end
end
