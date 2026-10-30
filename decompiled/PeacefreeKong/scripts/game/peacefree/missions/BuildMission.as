package game.peacefree.missions
{
   import game.peacefree.Building;
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   import starling.display.Image;
   
   public class BuildMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 3;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var mineralCost:int;
      
      public var maxTime:int;
      
      public var buildType:int;
      
      public var buildImage:Image;
      
      public function BuildMission(param1:Tile, param2:int, param3:Boolean, param4:Boolean = false)
      {
         super(3,param1);
         this.bMaximize = param3;
         this.buildType = param2;
         cost = Building.getBuildCost(param2,param3);
         mineralCost = Building.getMineralCost(param2,param1.map.difficulty == 0);
         timeLeft = maxTime = Building.getBuildTime(param2,param3);
         timeLeftTextField.text = "Ð" + timeLeft;
         if(!param4)
         {
            param1.map.deductTP(cost);
            param1.map.deductMinerals(mineralCost);
         }
         buildImage = new Image(Assets.getAtlas().getTexture("building_" + param2 + "_01"));
         buildImage.color = 65290;
         buildImage.alpha = 0.35;
         buildImage.y = 125 - buildImage.height;
         addChildAt(buildImage,0);
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
         tile.map.addMinerals(Math.ceil(timeLeft / maxTime * mineralCost));
      }
      
      override public function complete() : void
      {
         super.complete();
         tile.setBuilding(new Building(buildType,tile));
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ð " + Building.getBuildingName(buildType) + " complete.");
         tile.map.updateMap();
      }
      
      override public function getMissionTitle() : String
      {
         return "Building " + Building.getBuildingName(buildType);
      }
      
      override public function getMissionDescription() : String
      {
         return "This building is currently under construction.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         mineralCost = int(_loc2_[4]);
         maxTime = int(_loc2_[5]);
         buildType = int(_loc2_[6]);
         if(buildImage != null)
         {
            buildImage.removeFromParent(true);
         }
         buildImage = new Image(Assets.getAtlas().getTexture("building_" + buildType + "_01"));
         buildImage.color = 65290;
         buildImage.alpha = 0.35;
         buildImage.y = 125 - buildImage.height;
         addChildAt(buildImage,0);
         timeLeftTextField.text = "Ð" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + mineralCost + "#" + maxTime + "#" + buildType;
      }
   }
}

