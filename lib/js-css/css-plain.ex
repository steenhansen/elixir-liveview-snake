# wrong_live ==> player_live PlayerLive

defmodule CssPlain do
  use MultiGameWeb, :live_component



  def render(assigns) do
    ~H"""
    <div>

      <style >






         #jump-0 {
          position: absolute;
          opacity: 0;
        }
      
        div{
          float:left;
        }

          .flex-grid {
            display: flex;
              align-items: center;
            justify-content: center;
            float:none;
          }
          .flex-col {
            flex: 1;
            text-align: center;
            float:none
          }

         .colored-jump {
            width: 40px;
            height: 40px;
          } 

                      #jump-man {
                   width:40px; 
                   height:40px; 
                    margin-right:6px
             } 

          #direction-n{
          margin-left:14px;
          }
          #direction-s{
          margin-left:13px;
          }
          
          
          #picture-n{
            width:31px;
            height:40px;
          }

          #direction-e{
          }

          #picture-e{
            width:21px;
            height:30px;
          }

          #picture-s{
            width:23px;
            height:30px;
          }

          #picture-w{
            width:40px;
            height:30px;
          }


          


      
        .hor-jump { position: absolute;  z-index:11; width: 9px; height:18px;  top:-4px;          }
        .ver-jump { position: absolute;  z-index:11; width:18px; height: 9px;  margin-left:-4px;  }
        .no-jump  { position: absolute;  }



        </style>



        </div>
    """
  end
end
