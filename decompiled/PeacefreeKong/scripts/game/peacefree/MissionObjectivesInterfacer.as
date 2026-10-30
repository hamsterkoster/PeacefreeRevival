package game.peacefree
{
   import game.peacefree.interfaces.MissionObjectiveEntry;
   import starling.display.Sprite;
   
   public class MissionObjectivesInterfacer extends Sprite
   {
      
      private var objectiveEntries:Array = [];
      
      public var map:Map;
      
      public function MissionObjectivesInterfacer(param1:Map)
      {
         super();
         this.map = param1;
      }
      
      public function addEntry(param1:MissionObjective) : void
      {
         var _loc2_:MissionObjectiveEntry = new MissionObjectiveEntry(map,param1);
         objectiveEntries.push(_loc2_);
         addChild(_loc2_);
         progress(0);
      }
      
      public function hasEntry(param1:MissionObjective) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < objectiveEntries.length)
         {
            if(objectiveEntries[_loc2_].missionObjective == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function progress(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:MissionObjectiveEntry = null;
         var _loc4_:Boolean = false;
         try
         {
            _loc3_ = int(objectiveEntries.length);
            _loc5_ = 0;
            while(_loc5_ < objectiveEntries.length)
            {
               _loc2_ = objectiveEntries[_loc5_];
               _loc2_.progress(param1);
               if(_loc2_.isComplete())
               {
                  _loc2_.removeFromParent(true);
                  objectiveEntries.splice(_loc5_,1);
                  _loc5_--;
                  _loc3_ = int(objectiveEntries.length);
                  _loc4_ = true;
               }
               _loc5_++;
            }
         }
         catch(error:Error)
         {
         }
         _loc3_ = int(objectiveEntries.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            objectiveEntries[_loc5_].y = 25 * _loc5_;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(!contains(objectiveEntries[_loc5_]))
            {
               addChild(objectiveEntries[_loc5_]);
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            map.next();
         }
      }
   }
}

