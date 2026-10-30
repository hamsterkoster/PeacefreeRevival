package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Research;
   import game.peacefree.Tile;
   
   public class ResearchMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 19;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      private var researchID:int;
      
      private var level:int;
      
      public function ResearchMission(param1:Tile, param2:int, param3:Boolean, param4:Boolean = false)
      {
         super(19,param1);
         this.researchID = param2;
         this.bMaximize = param3;
         cost = param1.map.research.getResearchCost(param2,param3);
         timeLeft = maxTime = param1.map.research.getResearchTime(param2,param3);
         timeLeftTextField.text = "Ê" + timeLeft;
         level = param1.map.research.getLevel(param2) + 1;
         param1.map.research.lock(param2);
         if(!param4)
         {
            param1.map.deductTP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         timeLeftTextField.text = "Ê" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addTP(Math.ceil(timeLeft / maxTime * cost));
         tile.map.research.unlock(researchID);
      }
      
      override public function complete() : void
      {
         super.complete();
         tile.map.research.setLevel(researchID,level);
         tile.map.player.updateStats();
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ê Researched " + Research.getResearchTitle(researchID) + " Lv." + tile.map.research.getLevel(researchID) + ".");
         tile.map.research.unlock(researchID);
         switch(researchID - 10)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               tile.map.bResetBuildingGrowths = true;
         }
      }
      
      override public function getMissionTitle() : String
      {
         if(tile.map.research.getLevel(researchID) > 1)
         {
            return "Researching " + Research.getResearchTitle(researchID) + " Lv." + tile.map.research.getLevel(researchID);
         }
         return "Researching " + Research.getResearchTitle(researchID);
      }
      
      override public function getMissionDescription() : String
      {
         return tile.map.research.getResearchDesc(researchID);
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         tile.map.research.unlock(researchID);
         researchID = int(_loc2_[5]);
         tile.map.research.lock(researchID);
         level = int(_loc2_[6]);
         timeLeftTextField.text = "Ê" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + maxTime + "#" + researchID + "#" + level;
      }
   }
}

