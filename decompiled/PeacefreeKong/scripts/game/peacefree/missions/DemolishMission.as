package game.peacefree.missions
{
   import game.peacefree.Building;
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   import starling.display.Image;
   
   public class DemolishMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 6;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var mineralCost:int;
      
      public var maxTime:int;
      
      public var buildImage:Image;
      
      public function DemolishMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(6,param1);
         this.bMaximize = param2;
         cost = Building.getDemolishCost(param2);
         timeLeft = maxTime = Building.getDemolishTime(param2);
         timeLeftTextField.text = "Ð" + timeLeft;
         mineralCost = Math.ceil(Building.getMineralCost(param1.building.type) / 2);
         param1.building.alpha = 0;
         if(!param3)
         {
            param1.map.deductTP(cost);
         }
         switch(param1.building.type - 401)
         {
            case 0:
               buildImage = new Image(Assets.getAtlas().getTexture("building_400_01"));
               break;
            default:
               buildImage = new Image(Assets.getAtlas().getTexture("building_" + param1.building.type + "_01"));
         }
         buildImage.color = 16714240;
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
         if(tile.building != null)
         {
            tile.building.alpha = 1;
         }
      }
      
      override public function complete() : void
      {
         super.complete();
         tile.map.addMinerals(mineralCost);
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ð " + Building.getBuildingName(tile.building.type) + " demolished.");
         tile.removeBuilding();
         tile.map.updateMap();
      }
      
      override public function getMissionTitle() : String
      {
         return "Demolishing " + Building.getBuildingName(tile.building.type);
      }
      
      override public function getMissionDescription() : String
      {
         return "You will recover Â" + mineralCost + " after demolishing this " + Building.getBuildingName(tile.building.type) + ".";
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
         timeLeftTextField.text = "Ð" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + mineralCost + "#" + maxTime;
      }
   }
}

