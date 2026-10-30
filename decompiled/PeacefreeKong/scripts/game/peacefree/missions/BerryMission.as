package game.peacefree.missions
{
   import game.library.MathLibrary;
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   
   public class BerryMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 25;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      public function BerryMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(25,param1);
         this.bMaximize = param2;
         cost = param1.getLumberCost(param2);
         timeLeft = maxTime = param1.getLumberTime(param2);
         timeLeftTextField.text = "Ð" + timeLeft;
         if(!param3)
         {
            param1.map.deductTP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         timeLeftTextField.text = "Ð" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addTP(Math.ceil(timeLeft / maxTime * cost));
      }
      
      override public function complete() : void
      {
         super.complete();
         tile.removeBuilding();
         var _loc1_:int = MathLibrary.randomize(20,40);
         tile.addFloatText("+" + _loc1_ + "È");
         tile.map.player.food += _loc1_;
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ð Harvested Berries.");
         tile.map.mapHUD.bUpdateMiniMap = true;
         tile.map.bMapChanged = true;
      }
      
      override public function getMissionTitle() : String
      {
         return "Harvesting Lumber";
      }
      
      override public function getMissionDescription() : String
      {
         return "We are harvesting edible herbs and berries from the local terrain.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         timeLeftTextField.text = "Ð" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + maxTime;
      }
   }
}

