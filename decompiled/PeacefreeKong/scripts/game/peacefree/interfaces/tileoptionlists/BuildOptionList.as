package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Building;
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.BuildOption;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.BuildMission;
   
   public class BuildOptionList extends TileOptionList
   {
      
      private var map:Map;
      
      private var tile:Tile;
      
      public var buildGeneratorOption:BuildOption;
      
      public var buildHydropodOption:BuildOption;
      
      public var buildExtractorOption:BuildOption;
      
      public var buildResthouseOption:BuildOption;
      
      public var buildWatchtowerOption:BuildOption;
      
      public var buildTechlabOption:BuildOption;
      
      public var buildPortShuttleOption:BuildOption;
      
      public var bEnableResthouse:Boolean = true;
      
      public var bEnableGenerator:Boolean = true;
      
      private var cancelButton:TileOption;
      
      private var buildGeneratorTooltip:Tooltip;
      
      private var buildHydropodTooltip:Tooltip;
      
      private var buildExtractorTooltip:Tooltip;
      
      private var buildResthouseTooltip:Tooltip;
      
      public function BuildOptionList(param1:Map)
      {
         var buildWatchtowerTooltip:Tooltip;
         var buildTechlabTooltip:Tooltip;
         var buildPortShuttleTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         buildGeneratorOption = new BuildOption(101);
         buildGeneratorOption.x = 0;
         buildGeneratorOption.y = 0;
         buildGeneratorOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(101);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(101,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(101,false),Building.getBuildCost(101,false),function():void
            {
               tile.setMission(new BuildMission(tile,101,false));
               map.selectTile(null);
            },Building.getBuildTime(101,true),Building.getBuildCost(101,true),function():void
            {
               tile.setMission(new BuildMission(tile,101,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildGeneratorOption);
         buildHydropodOption = new BuildOption(102);
         buildHydropodOption.x = 60;
         buildHydropodOption.y = 0;
         buildHydropodOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(102);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(102,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(102,false),Building.getBuildCost(102,false),function():void
            {
               tile.setMission(new BuildMission(tile,102,false));
               map.selectTile(null);
            },Building.getBuildTime(102,true),Building.getBuildCost(102,true),function():void
            {
               tile.setMission(new BuildMission(tile,102,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildHydropodOption);
         buildExtractorOption = new BuildOption(103);
         buildExtractorOption.x = 120;
         buildExtractorOption.y = 0;
         buildExtractorOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(103);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(103,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(103,false),Building.getBuildCost(103,false),function():void
            {
               tile.setMission(new BuildMission(tile,103,false));
               map.selectTile(null);
            },Building.getBuildTime(103,true),Building.getBuildCost(103,true),function():void
            {
               tile.setMission(new BuildMission(tile,103,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildExtractorOption);
         buildResthouseOption = new BuildOption(104);
         buildResthouseOption.x = 180;
         buildResthouseOption.y = 0;
         buildResthouseOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(104);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(104,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(104,false),Building.getBuildCost(104,false),function():void
            {
               tile.setMission(new BuildMission(tile,104,false));
               map.selectTile(null);
            },Building.getBuildTime(104,true),Building.getBuildCost(104,true),function():void
            {
               tile.setMission(new BuildMission(tile,104,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildResthouseOption);
         buildWatchtowerOption = new BuildOption(105);
         buildWatchtowerOption.x = 0;
         buildWatchtowerOption.y = 60;
         buildWatchtowerOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(105);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(105,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(105,false),Building.getBuildCost(105,false),function():void
            {
               tile.setMission(new BuildMission(tile,105,false));
               map.selectTile(null);
            },Building.getBuildTime(105,true),Building.getBuildCost(105,true),function():void
            {
               tile.setMission(new BuildMission(tile,105,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildWatchtowerOption);
         buildTechlabOption = new BuildOption(106);
         buildTechlabOption.x = 60;
         buildTechlabOption.y = 60;
         buildTechlabOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(106);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(106,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(106,false),Building.getBuildCost(106,false),function():void
            {
               tile.setMission(new BuildMission(tile,106,false));
               map.selectTile(null);
            },Building.getBuildTime(106,true),Building.getBuildCost(106,true),function():void
            {
               tile.setMission(new BuildMission(tile,106,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildTechlabOption);
         buildPortShuttleOption = new BuildOption(108);
         buildPortShuttleOption.x = 120;
         buildPortShuttleOption.y = 60;
         buildPortShuttleOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = "Build " + Building.getBuildingName(108);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(108,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(108,false),Building.getBuildCost(108,false),function():void
            {
               tile.setMission(new BuildMission(tile,108,false));
               map.selectTile(null);
            },Building.getBuildTime(108,true),Building.getBuildCost(108,true),function():void
            {
               tile.setMission(new BuildMission(tile,108,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
               map.mapHUD.buildOptionList.setTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildPortShuttleOption);
         cancelButton = new TileOption("icon_cancel");
         cancelButton.x = 180;
         cancelButton.y = 60;
         cancelButton.releaseCallback = function():void
         {
            map.mapHUD.setSelectedTile(tile);
         };
         addChild(cancelButton);
         buildGeneratorTooltip = new Tooltip(170,100,"[1] " + Building.getBuildingName(101),Building.getBuildingDescription(101,map,false));
         buildGeneratorTooltip.x = -202;
         buildGeneratorTooltip.y = 10;
         buildGeneratorOption.tooltip = buildGeneratorTooltip;
         addChild(buildGeneratorTooltip);
         buildHydropodTooltip = new Tooltip(170,100,"[2] " + Building.getBuildingName(102),Building.getBuildingDescription(102,map,false));
         buildHydropodTooltip.x = -202;
         buildHydropodTooltip.y = 10;
         buildHydropodOption.tooltip = buildHydropodTooltip;
         addChild(buildHydropodTooltip);
         buildExtractorTooltip = new Tooltip(170,100,"[3] " + Building.getBuildingName(103),Building.getBuildingDescription(103,map,false));
         buildExtractorTooltip.x = -202;
         buildExtractorTooltip.y = 10;
         buildExtractorOption.tooltip = buildExtractorTooltip;
         addChild(buildExtractorTooltip);
         buildResthouseTooltip = new Tooltip(170,100,"[4] " + Building.getBuildingName(104),Building.getBuildingDescription(104,map,false));
         buildResthouseTooltip.x = -202;
         buildResthouseTooltip.y = 10;
         buildResthouseOption.tooltip = buildResthouseTooltip;
         addChild(buildResthouseTooltip);
         buildWatchtowerTooltip = new Tooltip(170,100,"[5] " + Building.getBuildingName(105),Building.getBuildingDescription(105,map,false));
         buildWatchtowerTooltip.x = -202;
         buildWatchtowerTooltip.y = 10;
         buildWatchtowerOption.tooltip = buildWatchtowerTooltip;
         addChild(buildWatchtowerTooltip);
         buildTechlabTooltip = new Tooltip(170,100,"[6] " + Building.getBuildingName(106),Building.getBuildingDescription(106,map,false));
         buildTechlabTooltip.x = -202;
         buildTechlabTooltip.y = 10;
         buildTechlabOption.tooltip = buildTechlabTooltip;
         addChild(buildTechlabTooltip);
         buildPortShuttleTooltip = new Tooltip(170,100,"[7] " + Building.getBuildingName(108),Building.getBuildingDescription(108,map,false));
         buildPortShuttleTooltip.x = -202;
         buildPortShuttleTooltip.y = 10;
         buildPortShuttleOption.tooltip = buildPortShuttleTooltip;
         addChild(buildPortShuttleTooltip);
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
         buildGeneratorOption.check(map,param1);
         map.mapHUD.num1Callback = buildGeneratorOption;
         if(!bEnableGenerator)
         {
            buildGeneratorOption.setIsEnabled(false);
         }
         buildHydropodOption.check(map,param1);
         map.mapHUD.num2Callback = buildHydropodOption;
         buildExtractorOption.check(map,param1);
         map.mapHUD.num3Callback = buildExtractorOption;
         buildResthouseOption.check(map,param1);
         map.mapHUD.num4Callback = buildResthouseOption;
         if(!bEnableResthouse)
         {
            buildResthouseOption.setIsEnabled(false);
         }
         buildWatchtowerOption.check(map,param1);
         map.mapHUD.num5Callback = buildWatchtowerOption;
         buildTechlabOption.check(map,param1);
         map.mapHUD.num6Callback = buildTechlabOption;
         buildPortShuttleOption.check(map,param1);
         map.mapHUD.num7Callback = buildPortShuttleOption;
         map.mapHUD.num8Callback = cancelButton;
         buildGeneratorTooltip.bodyTextField.text = Building.getBuildingDescription(101,map,false);
         buildHydropodTooltip.bodyTextField.text = Building.getBuildingDescription(102,map,false);
         buildExtractorTooltip.bodyTextField.text = Building.getBuildingDescription(103,map,false);
         buildResthouseTooltip.bodyTextField.text = Building.getBuildingDescription(104,map,false);
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
         buildGeneratorOption = null;
         buildHydropodOption = null;
         buildExtractorOption = null;
         buildResthouseOption = null;
         buildWatchtowerOption = null;
         buildTechlabOption = null;
         buildPortShuttleOption = null;
         buildGeneratorTooltip = null;
         buildHydropodTooltip = null;
         buildExtractorTooltip = null;
         buildResthouseTooltip = null;
         cancelButton = null;
         super.dispose();
      }
   }
}

