# wrong_live ==> player_live PlayerLive

defmodule HtmlChoices do
  use MultiGameWeb, :live_component

  @doc since: """
                 
       """

  def render(assigns) do
    ~H"""
      <div>
      <.form for={} phx-change="validate">
           Game Speed
              &nbsp;&nbsp;&nbsp;&nbsp;
          <label for="fast-speed">Fast</label>
          <input name="select_speed[radio-speed]" type="radio" id="fast-speed" value="speed-fast" label="Fast"   checked={@select_speed == "speed-fast"} />
              &nbsp;&nbsp;&nbsp;&nbsp;
          <label for="medium-speed">Medium</label>
          <input name="select_speed[radio-speed]" type="radio" id="medium-speed" value="speed-medium"  label="Medium"   checked={@select_speed == "speed-medium"}/>
              &nbsp;&nbsp;&nbsp;&nbsp;
          <label for="slow-speed">Slow</label>
          <input name="select_speed[radio-speed]" type="radio" id="slow-speed" value="speed-slow"  label="Slow"   checked={@select_speed == "speed-slow"}/>
          <br><br><br>
          Game Rotates
              &nbsp;&nbsp;&nbsp;&nbsp;
          <.input name="select_rotate" type="checkbox"  value={@select_rotate}   />
           <br><br><br>



                Playing Surface
              &nbsp;&nbsp;&nbsp;&nbsp;
        <label for="surface-large">Large</label>
          <input name="select_surface[radio-surface]" type="radio" id="surface-large" 
              value="surface-large" label="Fastx"   checked={@select_surface == "surface-large"} />
              &nbsp;&nbsp;&nbsp;&nbsp;
          <label for="surface-small">Small</label>
          <input name="select_surface[radio-surface]" type="radio" id="surface-small" 
                value="surface-small"  label="Mediumx"   checked={@select_surface == "surface-small"}/>
              &nbsp;&nbsp;&nbsp;&nbsp;
          <label for="surface-rectangle">Rectangle</label>
          <input name="select_surface[radio-surface]" type="radio" id="surface-rectangle" 
                value="surface-rectangle"  label="Mediumx"   checked={@select_surface == "surface-rectangle"}/>
              &nbsp;&nbsp;&nbsp;&nbsp;
          <label for="surface-obstacles">Obstacles</label>
          <input name="select_surface[radio-surface]" type="radio" id="surface-obstacles" 
                value="surface-obstacles"  label="Mediumx"   checked={@select_surface == "surface-obstacles"}/>



      <br><br><br>
          Computer Players 
              &nbsp;&nbsp;&nbsp;&nbsp;
        <label for="computers-0">0</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-0" value="computers-0"   checked={@select_computers == "computers-0"} /> &nbsp;
        <label for="computers-1">1</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-1" value="computers-1"   checked={@select_computers == "computers-1"} /> &nbsp;
        <label for="computers-2">2</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-2" value="computers-2"   checked={@select_computers == "computers-2"} /> &nbsp;
        <label for="computers-3">3</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-3" value="computers-3"   checked={@select_computers == "computers-3"} /> &nbsp;
        <label for="computers-4">4</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-4" value="computers-4"   checked={@select_computers == "computers-4"} /> &nbsp;
        <label for="computers-5">5</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-5" value="computers-5"   checked={@select_computers == "computers-5"} /> &nbsp;
        <label for="computers-6">6</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-6" value="computers-6"   checked={@select_computers == "computers-6"} /> &nbsp;
        <label for="computers-7">7</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-7" value="computers-7"   checked={@select_computers == "computers-7"} /> &nbsp;
        <label for="computers-8">8</label>
          <input name="select_computers[radio-computers]" type="radio" id="computers-8" value="computers-8"   checked={@select_computers == "computers-8"} />
          
         <br><br><br>
          Snake Length 
              &nbsp;&nbsp;&nbsp;&nbsp;
        <label for="length-long">Long</label>
          <input name="select_length[radio-length]" type="radio" id="length-long" value="length-long"   checked={@select_length == "length-long"} /> &nbsp;
        <label for="length-medium">Medium</label>
          <input name="select_length[radio-length]" type="radio" id="length-medium" value="length-medium"   checked={@select_length == "length-medium"} /> &nbsp;
        <label for="length-short">Short</label>
          <input name="select_length[radio-length]" type="radio" id="length-short" value="length-short"   checked={@select_length == "length-short"} /> &nbsp;
          <br><br><br>


      </.form>
      </div>
    """
  end
end
