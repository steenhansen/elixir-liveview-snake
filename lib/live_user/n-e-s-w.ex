# wrong_live ==> player_live PlayerLive

defmodule NESW do
  use MultiGameWeb, :live_component  
  
  def render(assigns) do
    ~H"""
     <div id="nesw">
            
<div class="px-4 sm:px-6 lg:px-8">
  <div class="max-w-2xl mx-auto">



<div style="margin-left:140px; width:120px; height:120px" id="thermostat" class="max-w-2xl mx-auto">
      <div class="flex-grid">
        <div class="flex-col"></div>
        <div id="nnn" class="xxx-n" class="flex-col"  onclick=' headingChange("key-north") ' onmouseenter='enterM("nnn")'   onmouseleave='leaveM("nnn")'>
            <img id="the-n"  src="/images/n_north.svg"  class="_control" />
        </div>
        <div class="flex-col"></div>
      </div>
      <div class="flex-grid">
        <div  class="xxx-n"  class="flex-col"  onclick=' headingChange("key-west") '>

            <img id="_0cd_4" src="/images/w_west.svg" class="_control" />

        </div>
        <div   id="mmmm" class="flex-col"  style="width:40px; height:40px">

            <div   class="flex-col" style="display:relative"  onmouseenter='enterJ("da_0")'   onmouseleave='leaveJ("da_0")'>


                  <img id="da_0" src="/images/colored-icons.svg#14" class="_control" />
                  <img id="da_1" src="/images/colored-icons.svg#24" class="_control" />
                  <img id="da_2" src="/images/colored-icons.svg#34" class="_control" />
                  <img id="da_3" src="/images/colored-icons.svg#44" class="_control" />
                  <img id="da_4" src="/images/colored-icons.svg#54" class="_control" />
                  <img id="da_5" src="/images/colored-icons.svg#64" class="_control" />
                  <img id="da_6" src="/images/colored-icons.svg#74" class="_control" />
                  <img id="da_7" src="/images/colored-icons.svg#84" class="_control" />
                  <img id="da_8" src="/images/colored-icons.svg#94" class="_control" />

                  <img id="da_XX" src="/images/colored-icons.svg#4" class="_control" />
                  
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
