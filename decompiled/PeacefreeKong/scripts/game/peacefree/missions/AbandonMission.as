package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   
   public class AbandonMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 26;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      public function AbandonMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(26,param1);
         this.bMaximize = param2;
         cost = param1.getAbandonCost(param2);
         timeLeft = maxTime = param1.getAbandonTime(param2);
         timeLeftTextField.text = "Ñ" + timeLeft;
         if(!param3)
         {
            param1.map.deductTP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         timeLeftTextField.text = "Ñ" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addTP(Math.ceil(timeLeft / maxTime * cost));
      }
      
      override public function complete() : void
      {
         super.complete();
         tile.map.unsecureTile(tile);
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ñ Tile abandoned.");
         tile.map.updateMap();
      }
      
      override public function getMissionTitle() : String
      {
         return "Abandon Area";
      }
      
      override public function getMissionDescription() : String
      {
         return "We are preparing to leave and abandon this area.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         timeLeftTextField.text = "Ñ" + timeLeft;
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

