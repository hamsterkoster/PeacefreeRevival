package game.interfaces
{
   import flash.ui.Mouse;
   import game.library.SoundLibrary;
   import game.peacefree.interfaces.Tooltip;
   import starling.display.Button;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.Texture;
   
   public class Clickable extends Button
   {
      
      public const DOWN_STATE_ALPHA:Number = 0.55;
      
      public const HOVER_STATE_ALPHA:Number = 0.7;
      
      public var releaseCallback:Function = null;
      
      public var dragCallback:Function = null;
      
      public var pressedCallback:Function = null;
      
      public var beginCallback:Function = null;
      
      public var hoverCallback:Function = null;
      
      public var exitCallback:Function = null;
      
      public var bPressed:Boolean = false;
      
      public var bEnabled:Boolean = true;
      
      public var bHovered:Boolean = false;
      
      public var bChangeAlpha:Boolean = true;
      
      public var tooltip:Tooltip = null;
      
      public function Clickable(param1:Texture, param2:String = "", param3:Texture = null)
      {
         super(param1,param2,param3);
         scaleWhenDown = 1;
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         addEventListener("touch",onPressed);
         addEventListener("triggered",onRelease);
         init();
      }
      
      protected function init() : void
      {
      }
      
      protected function onPressed(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_ == null)
         {
            if(bHovered)
            {
               if(bChangeAlpha)
               {
                  alpha = 1;
               }
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
            if(bChangeAlpha)
            {
               alpha = 1;
            }
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
         Mouse.cursor = "button";
         if(_loc2_.phase == "began")
         {
            if(bChangeAlpha)
            {
               alpha = 0.55;
            }
            bPressed = true;
            if(beginCallback != null)
            {
               beginCallback(param1);
               Mouse.cursor = "arrow";
            }
            SoundLibrary.playSFX("click");
            if(pressedCallback != null)
            {
               pressedCallback(param1);
            }
         }
         else if(_loc2_.phase == "ended")
         {
            if(bChangeAlpha)
            {
               alpha = 1;
            }
            bPressed = false;
            Mouse.cursor = "arrow";
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
               if(bChangeAlpha)
               {
                  alpha = 0.7;
               }
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
      
      protected function onRelease() : void
      {
         if(!bEnabled)
         {
            return;
         }
         if(releaseCallback != null)
         {
            releaseCallback();
         }
         bHovered = false;
         if(tooltip != null)
         {
            tooltip.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         releaseCallback = null;
         dragCallback = null;
         pressedCallback = null;
         beginCallback = null;
         hoverCallback = null;
         exitCallback = null;
         tooltip = null;
         super.dispose();
      }
   }
}

