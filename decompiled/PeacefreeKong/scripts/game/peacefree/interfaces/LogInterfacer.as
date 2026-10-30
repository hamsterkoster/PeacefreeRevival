package game.peacefree.interfaces
{
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import starling.display.Sprite;
   
   public class LogInterfacer extends Sprite
   {
      
      public static const MAX_VISIBLE_ENTRIES:int = 5;
      
      public var logEntries:Array;
      
      public var map:Map;
      
      private var bShowLogs:Boolean = false;
      
      public function LogInterfacer(param1:Map)
      {
         super();
         this.map = param1;
         logEntries = [];
      }
      
      public function addLogEntry(param1:Tile, param2:String) : void
      {
         var _loc4_:LogEntry = null;
         var _loc5_:int = 0;
         var _loc3_:LogEntry = new LogEntry(param1,map.getTime(),param2);
         logEntries.unshift(_loc3_);
         while(logEntries.length > 5)
         {
            _loc4_ = LogEntry(logEntries.pop());
            if(contains(_loc4_))
            {
               removeChild(_loc4_);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < logEntries.length)
         {
            logEntries[_loc5_].y = -23 * _loc5_;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < logEntries.length)
         {
            if(!contains(logEntries[_loc5_]))
            {
               addChild(logEntries[_loc5_]);
            }
            _loc5_++;
         }
      }
      
      public function progress(param1:int) : void
      {
         var _loc2_:int = 0;
         try
         {
            if(bShowLogs)
            {
               _loc2_ = 0;
               while(_loc2_ < logEntries.length)
               {
                  logEntries[_loc2_].alpha = 1;
                  logEntries[_loc2_].visible = true;
                  _loc2_++;
               }
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < logEntries.length)
               {
                  logEntries[_loc2_].progress(param1);
                  _loc2_++;
               }
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function setShowAllLogs(param1:Boolean) : void
      {
         this.bShowLogs = param1;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         logEntries.splice(0);
         logEntries = null;
         map = null;
         super.dispose();
      }
   }
}

