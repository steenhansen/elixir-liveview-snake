# wrong_live ==> player_live PlayerLive

defmodule HtmlNESW do
  use MultiGameWeb, :live_component

  @doc since: """
                 
       """

  def render(assigns) do
    ~H"""

     <div id="nesw" style="clear:both; visibility:hidden; position:relative" class="XXXXflex-grid" >
                  <div id="nesw-zoom" >
    <div class=""  >



    <div style="margin-left:0px">
      <div class="flex-grid" >
        <div ></div>
        <div id="direction-n"  class="this-player-color" class="flex-col"  
                    onmousedown = ' window.live_hooks.pushEvent("key-north");  '

            onmouseenter='enterNesw("direction-n")' 
              onmouseleave='leaveNesw("direction-n")'>
            <img id="picture-n"  src="/images/n-north.svg"  />
        </div>
        <div ></div>
      </div>
      <div class="flex-grid" style=" margin-top:10px">
        <div  id="direction-w" class="this-player-color"  class="flex-col"  

         onmousedown = ' window.live_hooks.pushEvent("key-west");  '


          onmouseenter='enterNesw("direction-w")' 
              onmouseleave='leaveNesw("direction-w")'
         >

            <img  id="picture-w"  src="/images/w-west.svg"  />

        </div>
        <div   id="jump-man" 
        
                    onmousedown = 'tryJump()'
                    onmouseenter = 'enterJump()'   
                    onmouseleave = 'leaveJump()'
        >

            <div   id="inside-jump"
                    >


                  <img id="jump-1" src="/images/colored-icons.svg#14" class="colored-jump" />
                  <img id="jump-2" src="/images/colored-icons.svg#24" class="colored-jump" />
                  <img id="jump-3" src="/images/colored-icons.svg#34" class="colored-jump" />
                  <img id="jump-4" src="/images/colored-icons.svg#44" class="colored-jump" />
                  <img id="jump-5" src="/images/colored-icons.svg#54" class="colored-jump" />
                  <img id="jump-6" src="/images/colored-icons.svg#64" class="colored-jump" />
                  <img id="jump-7" src="/images/colored-icons.svg#74" class="colored-jump" />
                  <img id="jump-8" src="/images/colored-icons.svg#84" class="colored-jump" />
                  <img id="jump-9" src="/images/colored-icons.svg#94" class="colored-jump" />
                  <img id="jump-0" src="/images/colored-icons.svg#4" class="colored-jump" />  

                  
           </div>

        </div>
        <div id="direction-e"  class="this-player-color" class="flex-col"  
                            onmousedown = ' window.live_hooks.pushEvent("key-east");  '
         onmouseenter='enterNesw("direction-e")' 
              onmouseleave='leaveNesw("direction-e")' >


            <img  id="picture-e"   src="/images/e-east.svg"  />
          

          </div>
      </div>
      <div class="flex-grid"  style=" margin-top:2px">
        <div ></div>
        <div  id="direction-s" class="this-player-color"  class="flex-col"  
        
         onmousedown = ' window.live_hooks.pushEvent("key-south");  '
        
           onmouseenter='enterNesw("direction-s")' 
              onmouseleave='leaveNesw("direction-s")'
        >

        
            <img  id="picture-s"  src="/images/s-south.svg" />
        </div>
        <div></div>
      </div>
    </div>


    </div>
    </div>

            </div>
    """
  end
end
