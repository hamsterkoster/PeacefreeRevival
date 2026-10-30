package game.peacefree
{
   import flash.events.Event;
   import game.container.GameConfig;
   
   public class OnActivateListener
   {
      
      public var onActivate:Function = null;
      
      public var onDeactivate:Function = null;
      
      public function OnActivateListener(param1:Function, param2:Function)
      {
         super();
         this.onActivate = param1;
         this.onDeactivate = param2;
         GameConfig.STAGE.addEventListener("activate",onActivateEvent,false,0,true);
         GameConfig.STAGE.addEventListener("deactivate",onDeactivateEvent,false,0,true);
      }
      
      public function onActivateEvent(param1:Event) : void
      {
         if(onActivate != null)
         {
            onActivate();
         }
      }
      
      public function onDeactivateEvent(param1:Event) : void
      {
         if(onDeactivate != null)
         {
            onDeactivate();
         }
      }
   }
}

