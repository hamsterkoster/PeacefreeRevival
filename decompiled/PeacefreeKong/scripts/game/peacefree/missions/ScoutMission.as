package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   
   public class ScoutMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 2;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      public function ScoutMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(2,param1);
         this.bMaximize = param2;
         cost = param1.getScoutCost(param2);
         timeLeft = maxTime = param1.getScoutTime(param2);
         timeLeftTextField.text = "ã" + timeLeft;
         if(!param3)
         {
            param1.map.deductSP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         timeLeftTextField.text = "ã" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addSP(Math.ceil(timeLeft / maxTime * cost));
      }
      
      override public function complete() : void
      {
         super.complete();
         tile.map.scoutTile(tile);
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"ã Scout complete.");
         tile.map.mapHUD.bUpdateMiniMap = true;
         tile.map.bMapChanged = true;
      }
      
      override public function getMissionTitle() : String
      {
         return "Scout Mission";
      }
      
      override public function getMissionDescription() : String
      {
         return "Our troops are currently scouting the area for enemies and useful resources.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         timeLeftTextField.text = "ã" + timeLeft;
         updateFPS();
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + maxTime;
      }
   }
}

