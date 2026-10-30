package game.interfaces.clickables
{
   import flash.ui.Mouse;
   import game.interfaces.Clickable;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.Texture;
   
   public class HiddenClickable extends Clickable
   {
      
      public function HiddenClickable(param1:Texture, param2:String = "", param3:Texture = null)
      {
         super(param1,param2,param3);
         useHandCursor = false;
      }
      
      override protected function onPressed(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_ == null)
         {
            if(bHovered)
            {
               bHovered = false;
               if(exitCallback != null)
               {
                  exitCallback();
               }
               if(tooltip != null)
               {
                  tooltip.visible = false;
               }
            }
            return;
         }
         if(!bEnabled)
         {
            bHovered = false;
            bPressed = false;
            if(tooltip != null)
            {
               if(_loc2_.phase == "hover")
               {
                  if(!bHovered)
                  {
                     bHovered = true;
                     if(hoverCallback != null)
                     {
                        hoverCallback(param1);
                     }
                     if(tooltip != null)
                     {
                        tooltip.visible = true;
                     }
                  }
               }
            }
            return;
         }
         Mouse.cursor = "arrow";
         if(_loc2_.phase == "began")
         {
            bPressed = true;
            if(pressedCallback != null)
            {
               pressedCallback(param1);
            }
         }
         else if(_loc2_.phase == "ended")
         {
            bPressed = false;
         }
         else if(_loc2_.phase == "moved")
         {
            if(dragCallback != null)
            {
               dragCallback(param1);
            }
         }
         else if(_loc2_.phase == "hover")
         {
            if(!bHovered)
            {
               bHovered = true;
               if(hoverCallback != null)
               {
                  hoverCallback(param1);
               }
               if(tooltip != null)
               {
                  tooltip.visible = true;
               }
            }
         }
      }
   }
}

