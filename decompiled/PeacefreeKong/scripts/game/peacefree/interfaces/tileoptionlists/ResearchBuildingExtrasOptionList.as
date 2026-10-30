package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Building;
   import game.peacefree.Map;
   import game.peacefree.Research;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.BuildingExtraOption;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.ResearchMission;
   
   public class ResearchBuildingExtrasOptionList extends TileOptionList
   {
      
      private var map:Map;
      
      private var tile:Tile;
      
      private var foodUpOption:BuildingExtraOption;
      
      private var energyUpOption:BuildingExtraOption;
      
      private var mineralUpOption:BuildingExtraOption;
      
      private var popUpOption:BuildingExtraOption;
      
      private var cancelButton:TileOption;
      
      public function ResearchBuildingExtrasOptionList(param1:Map)
      {
         var foodUpTooltip:Tooltip;
         var energyUpTooltip:Tooltip;
         var mineralUpTooltip:Tooltip;
         var popUpTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         foodUpOption = new BuildingExtraOption(102,10,"È");
         foodUpOption.x = 0;
         foodUpOption.y = 0;
         foodUpOption.visible = true;
         foodUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(10);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(10);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(10,false),map.research.getResearchCost(10,false),function():void
            {
               tile.setMission(new ResearchMission(tile,10,false));
               map.selectTile(null);
            },map.research.getResearchTime(10,true),map.research.getResearchCost(10,true),function():void
            {
               tile.setMission(new ResearchMission(tile,10,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchBuildingExtrasOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchBuildingExtrasOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(foodUpOption);
         energyUpOption = new BuildingExtraOption(101,11,"Ë");
         energyUpOption.x = 60;
         energyUpOption.y = 0;
         energyUpOption.visible = true;
         energyUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(11);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(11);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(11,false),map.research.getResearchCost(11,false),function():void
            {
               tile.setMission(new ResearchMission(tile,11,false));
               map.selectTile(null);
            },map.research.getResearchTime(11,true),map.research.getResearchCost(11,true),function():void
            {
               tile.setMission(new ResearchMission(tile,11,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchBuildingExtrasOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchBuildingExtrasOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(energyUpOption);
         mineralUpOption = new BuildingExtraOption(103,12,"Â");
         mineralUpOption.x = 120;
         mineralUpOption.y = 0;
         mineralUpOption.visible = true;
         mineralUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(12);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(12);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(12,false),map.research.getResearchCost(12,false),function():void
            {
               tile.setMission(new ResearchMission(tile,12,false));
               map.selectTile(null);
            },map.research.getResearchTime(12,true),map.research.getResearchCost(12,true),function():void
            {
               tile.setMission(new ResearchMission(tile,12,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchBuildingExtrasOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchBuildingExtrasOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(mineralUpOption);
         popUpOption = new BuildingExtraOption(104,13,"É");
         popUpOption.x = 180;
         popUpOption.y = 0;
         popUpOption.visible = true;
         popUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(13);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(13);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(13,false),map.research.getResearchCost(13,false),function():void
            {
               tile.setMission(new ResearchMission(tile,13,false));
               map.selectTile(null);
            },map.research.getResearchTime(13,true),map.research.getResearchCost(13,true),function():void
            {
               tile.setMission(new ResearchMission(tile,13,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchBuildingExtrasOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchBuildingExtrasOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(popUpOption);
         cancelButton = new TileOption("icon_cancel");
         cancelButton.x = 180;
         cancelButton.y = 60;
         cancelButton.releaseCallback = function():void
         {
            map.mapHUD.setSelectedTile(tile);
         };
         addChild(cancelButton);
         foodUpTooltip = new Tooltip(170,100,"[1] Fertilizers","Increases È produced by Hydropods and Agripods.");
         foodUpTooltip.x = -202;
         foodUpTooltip.y = 10;
         foodUpOption.tooltip = foodUpTooltip;
         addChild(foodUpTooltip);
         energyUpTooltip = new Tooltip(170,100,"[2] C. Batteries","Increases Ë produced by Generator buildings.");
         energyUpTooltip.x = -202;
         energyUpTooltip.y = 10;
         energyUpOption.tooltip = energyUpTooltip;
         addChild(energyUpTooltip);
         mineralUpTooltip = new Tooltip(170,100,"[3] Mining Drill","Increases Â produced by Extractors.");
         mineralUpTooltip.x = -202;
         mineralUpTooltip.y = 10;
         mineralUpOption.tooltip = mineralUpTooltip;
         addChild(mineralUpTooltip);
         popUpTooltip = new Tooltip(170,100,"[4] Extra Housing","Increases É produced by Resthouses.");
         popUpTooltip.x = -202;
         popUpTooltip.y = 10;
         popUpOption.tooltip = popUpTooltip;
         addChild(popUpTooltip);
      }
      
      public function setTile(param1:Tile) : void
      {
         this.tile = param1;
         if(param1.building == null)
         {
            map.mapHUD.tileNameTextField.text = param1.tileName;
            map.mapHUD.tileDescTextField.text = param1.tileDesc;
         }
         else
         {
            map.mapHUD.tileNameTextField.text = Building.getBuildingName(param1.building.type);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(param1.building.type,map);
         }
         foodUpOption.check(map,param1);
         energyUpOption.check(map,param1);
         mineralUpOption.check(map,param1);
         popUpOption.check(map,param1);
         map.mapHUD.num1Callback = foodUpOption;
         map.mapHUD.num2Callback = energyUpOption;
         map.mapHUD.num3Callback = mineralUpOption;
         map.mapHUD.num4Callback = popUpOption;
         map.mapHUD.num8Callback = cancelButton;
      }
      
      override public function refresh() : void
      {
         setTile(tile);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         tile = null;
         foodUpOption = null;
         energyUpOption = null;
         mineralUpOption = null;
         popUpOption = null;
         cancelButton = null;
         super.dispose();
      }
   }
}

