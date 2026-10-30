package game.peacefree
{
   public class StorySequence
   {
      
      public static const TYPE_DIALOGUE:int = 1;
      
      public static const TYPE_OBJECTIVE:int = 2;
      
      public static const TYPE_SKIP:int = 3;
      
      public static const ACTION_NONE:int = 0;
      
      public static const ACTION_SCOUTED:int = 1;
      
      public static const ACTION_SCOUTED_NEARBY:int = 2;
      
      public static const ACTION_UNLOCK_TILE:int = 3;
      
      public static const ACTION_MAKE_VISIBLE:int = 5;
      
      public static const ACTION_SPAWN_MOB:int = 6;
      
      public static const ACTION_ENABLE_CONSUME_FOOD:int = 7;
      
      public static const ACTION_ADD_COUNTDOWN:int = 8;
      
      public static const ACTION_REMOVE_COUNTDOWN:int = 9;
      
      public var storyID:int;
      
      public var type:int;
      
      public var objectives:Array = null;
      
      public var tile:Tile;
      
      public var action:int = 0;
      
      public var data:String;
      
      public var map:Map;
      
      public var onUpdate:Function;
      
      public var bUpdateOnFastForward:Boolean = true;
      
      public var portrait:String = null;
      
      public var dialogue:String = null;
      
      public function StorySequence(param1:Map, param2:int, param3:int)
      {
         super();
         this.map = param1;
         this.storyID = param2;
         this.type = param3;
      }
      
      public function isComplete() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         switch(type - 1)
         {
            case 0:
               return true;
            case 1:
               _loc2_ = true;
               _loc1_ = int(objectives.length);
               _loc3_ = 0;
               while(_loc3_ < _loc1_)
               {
                  if(objectives[_loc3_].priorityType == 2)
                  {
                     _loc2_ = objectives[_loc3_].isComplete() && _loc2_;
                  }
                  _loc3_++;
               }
               return _loc2_;
            case 2:
               return true;
            default:
               return true;
         }
      }
      
      public function addObjective(param1:MissionObjective) : void
      {
         if(objectives == null)
         {
            objectives = [];
         }
         objectives.push(param1);
      }
      
      public function update(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         if(onUpdate != null && (!param1 || bUpdateOnFastForward))
         {
            onUpdate();
         }
         if(map == null)
         {
            return;
         }
         switch(action - 1)
         {
            case 0:
               tile.bScouted = true;
            case 1:
               tile.bScoutedNearby = true;
               tile.refreshColors();
               break;
            case 2:
               map.unlock(int(data));
               break;
            case 4:
               tile.bVisible = true;
               tile.refreshColors();
               break;
            case 6:
               map.player.bConsumeFood = true;
         }
         if(type == 3)
         {
            map.next();
         }
         else if(type == 1 && !param1)
         {
            map.rememberPosition();
            map.dialogueInterfacer.show(dialogue,portrait);
            map.moveToTile(tile);
         }
         else
         {
            map.dialogueInterfacer.hide();
         }
      }
      
      public function dispose() : void
      {
         if(objectives != null)
         {
            objectives.splice(0);
         }
         objectives = null;
         tile = null;
         data = null;
         map = null;
         onUpdate = null;
         portrait = null;
         dialogue = null;
      }
   }
}

