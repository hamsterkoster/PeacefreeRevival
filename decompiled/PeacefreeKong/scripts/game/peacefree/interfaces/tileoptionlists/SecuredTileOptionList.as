package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Building;
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.BuildOption;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.AbandonMission;
   import game.peacefree.missions.BerryMission;
   import game.peacefree.missions.DemolishMission;
   import game.peacefree.missions.LumberMission;
   import game.peacefree.missions.SalvageMission;
   import game.peacefree.missions.UpgradeMission;
   
   public class SecuredTileOptionList extends TileOptionList
   {
      
      private var map:Map;
      
      public var salvageOption:TileOption;
      
      public var buildOption:TileOption;
      
      public var interceptOption:TileOption;
      
      public var abandonOption:TileOption;
      
      public var demolishOption:TileOption;
      
      private var cancelOption:TileOption;
      
      private var tile:Tile;
      
      private var troopPowerUpgradeOption:TileOption;
      
      private var commandPowerUpgradeOption:TileOption;
      
      private var buildingExtrasUpgradeOption:TileOption;
      
      private var harvestLumberOption:TileOption;
      
      private var harvestBerriesOption:TileOption;
      
      private var buildBlasterCannonOption:BuildOption;
      
      private var buildNoxxerCannonOption:BuildOption;
      
      private var buildZapCannonOption:BuildOption;
      
      private var tradeFoodOption:TileOption;
      
      private var tradeMineralsOption:TileOption;
      
      private var upgradeToAgripodOption:BuildOption;
      
      private var upgradeToPowerhouseOption:BuildOption;
      
      private var upgradeToReactorOption:BuildOption;
      
      private var upgradeToCommandCenterV2Option:BuildOption;
      
      private var upgradeToBlasterSentryOption:BuildOption;
      
      private var upgradeToNoxxerSentryOption:BuildOption;
      
      private var upgradeToZapSentryOption:BuildOption;
      
      private var salvageTooltip:Tooltip;
      
      private var abandonTooltip:Tooltip;
      
      public var bEnableSalvage:Boolean = true;
      
      public var bEnableAbandon:Boolean = true;
      
      public var bEnableBuild:Boolean = true;
      
      public function SecuredTileOptionList(param1:Map)
      {
         var buildTooltip:Tooltip;
         var interceptTooltip:Tooltip;
         var demolishTooltip:Tooltip;
         var troopPowerUpgradeTooltip:Tooltip;
         var commandPowerUpgradeTooltip:Tooltip;
         var buildingExtrasUpgradeTooltip:Tooltip;
         var harvestLumberTooltip:Tooltip;
         var harvestBerriesTooltip:Tooltip;
         var buildBlasterCannonTooltip:Tooltip;
         var buildNoxxerCannonTooltip:Tooltip;
         var buildZapCannonTooltip:Tooltip;
         var tradeFoodTooltip:Tooltip;
         var tradeMineralsTooltip:Tooltip;
         var upgradeToAgripodTooltip:Tooltip;
         var upgradeToPowerhouseTooltip:Tooltip;
         var upgradeToReactorTooltip:Tooltip;
         var upgradeToCommandCenterV2Tooltip:Tooltip;
         var upgradeToBlasterSentryTooltip:Tooltip;
         var upgradeToNoxxerSentryTooltip:Tooltip;
         var upgradeToZapSentryTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         interceptOption = new TileOption("icon_intercept");
         interceptOption.x = 0;
         interceptOption.y = 60;
         interceptOption.setIsEnabled(false);
         addChild(interceptOption);
         salvageOption = new TileOption("icon_salvage","");
         salvageOption.x = 0;
         salvageOption.y = 0;
         salvageOption.releaseCallback = function():void
         {
            if(tile.map.player.curSearchpower >= tile.getSalvageCost(false))
            {
               tile.setMission(new SalvageMission(tile,false));
               map.selectTile(null);
            }
         };
         addChild(salvageOption);
         buildOption = new TileOption("icon_build");
         buildOption.x = 60;
         buildOption.y = 0;
         buildOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Select which structure to build on this tile.";
            map.mapHUD.buildOptionList.setTile(tile);
            map.mapHUD.setOptionList(map.mapHUD.buildOptionList);
         };
         addChild(buildOption);
         abandonOption = new TileOption("icon_abandon");
         abandonOption.x = 120;
         abandonOption.y = 60;
         abandonOption.releaseCallback = function():void
         {
            tile.setMission(new AbandonMission(tile,false));
            map.selectTile(null);
         };
         addChild(abandonOption);
         demolishOption = new TileOption("icon_demolish");
         demolishOption.x = 60;
         demolishOption.y = 60;
         demolishOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Pick how much Ê to spend. Use more Ê to reduce time required. You will recover " + Building.getMineralCost(tile.building.type) / 2 + "Â" + " from this " + Building.getBuildingName(tile.building.type) + ".";
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getDemolishTime(false),Building.getDemolishCost(false),function():void
            {
               tile.setMission(new DemolishMission(tile,false));
               map.selectTile(null);
            },Building.getDemolishTime(true),Building.getDemolishCost(true),function():void
            {
               tile.setMission(new DemolishMission(tile,true));
               map.selectTile(null);
            },function():void
            {
               map.selectTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(demolishOption);
         cancelOption = new TileOption("icon_cancel");
         cancelOption.x = 180;
         cancelOption.y = 60;
         cancelOption.releaseCallback = function():void
         {
            map.selectTile(null);
         };
         addChild(cancelOption);
         troopPowerUpgradeOption = new TileOption("icon_research");
         troopPowerUpgradeOption.x = 0;
         troopPowerUpgradeOption.y = 0;
         troopPowerUpgradeOption.visible = false;
         troopPowerUpgradeOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Select which Troop Power to upgrade.";
            map.mapHUD.researchTroopPowersOptionList.setTile(tile);
            map.mapHUD.setOptionList(map.mapHUD.researchTroopPowersOptionList);
         };
         addChild(troopPowerUpgradeOption);
         commandPowerUpgradeOption = new TileOption("icon_intercept");
         commandPowerUpgradeOption.x = 60;
         commandPowerUpgradeOption.y = 0;
         commandPowerUpgradeOption.visible = false;
         commandPowerUpgradeOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Select which Command Power to upgrade.";
            map.mapHUD.researchCommandsOptionList.setTile(tile);
            map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
         };
         addChild(commandPowerUpgradeOption);
         buildingExtrasUpgradeOption = new TileOption("icon_extras");
         buildingExtrasUpgradeOption.x = 120;
         buildingExtrasUpgradeOption.y = 0;
         buildingExtrasUpgradeOption.visible = false;
         buildingExtrasUpgradeOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Select which Building Extras to research.";
            map.mapHUD.researchBuildingExtrasOptionList.setTile(tile);
            map.mapHUD.setOptionList(map.mapHUD.researchBuildingExtrasOptionList);
         };
         addChild(buildingExtrasUpgradeOption);
         harvestLumberOption = new TileOption("icon_build","Â");
         harvestLumberOption.x = 0;
         harvestLumberOption.y = 0;
         harvestLumberOption.visible = false;
         harvestLumberOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Pick how much Ê to spend. Use more Ê to reduce time required. You will harvest between Â20 to Â40.";
            map.mapHUD.confirmMissionOptionList.setValues(2,tile.getLumberTime(false),tile.getLumberCost(false),function():void
            {
               tile.setMission(new LumberMission(tile,false));
               map.selectTile(null);
            },tile.getLumberTime(true),tile.getLumberCost(true),function():void
            {
               tile.setMission(new LumberMission(tile,true));
               map.selectTile(null);
            },function():void
            {
               map.selectTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(harvestLumberOption);
         harvestBerriesOption = new TileOption("icon_build","È");
         harvestBerriesOption.x = 0;
         harvestBerriesOption.y = 0;
         harvestBerriesOption.visible = false;
         harvestBerriesOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Pick how much Ê to spend. Use more Ê to reduce time required. You will harvest between È20 to È40.";
            map.mapHUD.confirmMissionOptionList.setValues(2,tile.getLumberTime(false),tile.getLumberCost(false),function():void
            {
               tile.setMission(new BerryMission(tile,false));
               map.selectTile(null);
            },tile.getLumberTime(true),tile.getLumberCost(true),function():void
            {
               tile.setMission(new BerryMission(tile,true));
               map.selectTile(null);
            },function():void
            {
               map.selectTile(tile);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(harvestBerriesOption);
         buildBlasterCannonOption = new BuildOption(110);
         buildBlasterCannonOption.x = 0;
         buildBlasterCannonOption.y = 0;
         buildBlasterCannonOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(110,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(110,false),Building.getBuildCost(110,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,110,false));
               map.selectTile(null);
            },Building.getBuildTime(110,true),Building.getBuildCost(110,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,110,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(110));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildBlasterCannonOption);
         buildNoxxerCannonOption = new BuildOption(111);
         buildNoxxerCannonOption.x = 60;
         buildNoxxerCannonOption.y = 0;
         buildNoxxerCannonOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(111,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(111,false),Building.getBuildCost(111,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,111,false));
               map.selectTile(null);
            },Building.getBuildTime(111,true),Building.getBuildCost(111,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,111,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(111));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildNoxxerCannonOption);
         buildZapCannonOption = new BuildOption(113);
         buildZapCannonOption.x = 120;
         buildZapCannonOption.y = 0;
         buildZapCannonOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(113,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(113,false),Building.getBuildCost(113,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,113,false));
               map.selectTile(null);
            },Building.getBuildTime(113,true),Building.getBuildCost(113,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,113,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(113));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(buildZapCannonOption);
         tradeFoodOption = new TileOption("icon_trade","È");
         tradeFoodOption.x = 0;
         tradeFoodOption.y = 0;
         tradeFoodOption.visible = false;
         tradeFoodOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Select how much È to trade in exchange for Â in the Miroda Galaxy Trade Market.";
            map.mapHUD.tradeOptionList.setType(1,tile);
            map.mapHUD.setOptionList(map.mapHUD.tradeOptionList);
         };
         addChild(tradeFoodOption);
         tradeMineralsOption = new TileOption("icon_trade","Â");
         tradeMineralsOption.x = 60;
         tradeMineralsOption.y = 0;
         tradeMineralsOption.visible = false;
         tradeMineralsOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = "Select how much Â to trade in exchange for È in the Miroda Galaxy Trade Market.";
            map.mapHUD.tradeOptionList.setType(2,tile);
            map.mapHUD.setOptionList(map.mapHUD.tradeOptionList);
         };
         addChild(tradeMineralsOption);
         upgradeToAgripodOption = new BuildOption(202);
         upgradeToAgripodOption.x = 0;
         upgradeToAgripodOption.y = 0;
         upgradeToAgripodOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(202,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(202,false),Building.getBuildCost(202,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,202,false));
               map.selectTile(null);
            },Building.getBuildTime(202,true),Building.getBuildCost(202,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,202,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(202));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToAgripodOption);
         upgradeToPowerhouseOption = new BuildOption(201);
         upgradeToPowerhouseOption.x = 0;
         upgradeToPowerhouseOption.y = 0;
         upgradeToPowerhouseOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(201,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(201,false),Building.getBuildCost(201,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,201,false));
               map.selectTile(null);
            },Building.getBuildTime(201,true),Building.getBuildCost(201,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,201,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(201));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToPowerhouseOption);
         upgradeToReactorOption = new BuildOption(302);
         upgradeToReactorOption.x = 0;
         upgradeToReactorOption.y = 0;
         upgradeToReactorOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(302,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(302,false),Building.getBuildCost(302,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,302,false));
               map.selectTile(null);
            },Building.getBuildTime(302,true),Building.getBuildCost(302,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,302,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(201));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToReactorOption);
         upgradeToCommandCenterV2Option = new BuildOption(200);
         upgradeToCommandCenterV2Option.x = 0;
         upgradeToCommandCenterV2Option.y = 0;
         upgradeToCommandCenterV2Option.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(200,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(200,false),Building.getBuildCost(200,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,200,false));
               map.selectTile(null);
            },Building.getBuildTime(200,true),Building.getBuildCost(200,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,200,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(200));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToCommandCenterV2Option);
         upgradeToBlasterSentryOption = new BuildOption(205);
         upgradeToBlasterSentryOption.x = 0;
         upgradeToBlasterSentryOption.y = 0;
         upgradeToBlasterSentryOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(205,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(205,false),Building.getBuildCost(205,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,205,false));
               map.selectTile(null);
            },Building.getBuildTime(205,true),Building.getBuildCost(205,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,205,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(205));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToBlasterSentryOption);
         upgradeToNoxxerSentryOption = new BuildOption(207);
         upgradeToNoxxerSentryOption.x = 0;
         upgradeToNoxxerSentryOption.y = 0;
         upgradeToNoxxerSentryOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(207,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(207,false),Building.getBuildCost(207,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,207,false));
               map.selectTile(null);
            },Building.getBuildTime(207,true),Building.getBuildCost(207,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,207,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(207));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToNoxxerSentryOption);
         upgradeToZapSentryOption = new BuildOption(209);
         upgradeToZapSentryOption.x = 0;
         upgradeToZapSentryOption.y = 0;
         upgradeToZapSentryOption.releaseCallback = function():void
         {
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(209,map);
            map.mapHUD.confirmMissionOptionList.setValues(2,Building.getBuildTime(209,false),Building.getBuildCost(209,false),function():void
            {
               tile.setMission(new UpgradeMission(tile,209,false));
               map.selectTile(null);
            },Building.getBuildTime(209,true),Building.getBuildCost(209,true),function():void
            {
               tile.setMission(new UpgradeMission(tile,209,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.setOptionList(map.mapHUD.securedTileOptions);
               map.mapHUD.securedTileOptions.setTile(tile);
            },"Build " + Building.getBuildingName(209));
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(upgradeToZapSentryOption);
         salvageTooltip = new Tooltip(170,135,"[1] Salvage Tile","Collect all food and minerals found in the area.");
         salvageTooltip.x = -202;
         salvageTooltip.y = -25;
         salvageOption.tooltip = salvageTooltip;
         addChild(salvageTooltip);
         buildTooltip = new Tooltip(170,100,"[2] Build Structure","Make new buildings and facilities.");
         buildTooltip.x = -202;
         buildTooltip.y = 10;
         buildOption.tooltip = buildTooltip;
         addChild(buildTooltip);
         interceptTooltip = new Tooltip(170,115,"[5] Intercept Enemy","Send a team to attack the enemy.\n\nNo ships to intercept.");
         interceptTooltip.x = -202;
         interceptTooltip.y = -5;
         interceptOption.tooltip = interceptTooltip;
         addChild(interceptTooltip);
         abandonTooltip = new Tooltip(170,115,"[7] Abandon Area","Leave and unsecure this tile.");
         abandonTooltip.x = -202;
         abandonTooltip.y = -5;
         abandonOption.tooltip = abandonTooltip;
         addChild(abandonTooltip);
         demolishTooltip = new Tooltip(170,100,"[6] Demolish Area","Destroy current building and recover some minerals.");
         demolishTooltip.x = -202;
         demolishTooltip.y = 10;
         demolishOption.tooltip = demolishTooltip;
         addChild(demolishTooltip);
         troopPowerUpgradeTooltip = new Tooltip(170,100,"[1] Troop Upg.","Research upgrades to increase troop powers.");
         troopPowerUpgradeTooltip.x = -202;
         troopPowerUpgradeTooltip.y = 10;
         troopPowerUpgradeOption.tooltip = troopPowerUpgradeTooltip;
         addChild(troopPowerUpgradeTooltip);
         commandPowerUpgradeTooltip = new Tooltip(170,100,"[2] Command Upg.","Research upgrades to increase command powers.");
         commandPowerUpgradeTooltip.x = -202;
         commandPowerUpgradeTooltip.y = 10;
         commandPowerUpgradeOption.tooltip = commandPowerUpgradeTooltip;
         addChild(commandPowerUpgradeTooltip);
         buildingExtrasUpgradeTooltip = new Tooltip(170,100,"[3] Building Extras","Research extras to increase building production.");
         buildingExtrasUpgradeTooltip.x = -202;
         buildingExtrasUpgradeTooltip.y = 10;
         buildingExtrasUpgradeOption.tooltip = buildingExtrasUpgradeTooltip;
         addChild(buildingExtrasUpgradeTooltip);
         harvestLumberTooltip = new Tooltip(170,100,"[1] Harvest Lumber","Harvest trees and trade the lumber for minerals.");
         harvestLumberTooltip.x = -202;
         harvestLumberTooltip.y = 10;
         harvestLumberOption.tooltip = harvestLumberTooltip;
         addChild(harvestLumberTooltip);
         harvestBerriesTooltip = new Tooltip(170,100,"[1] Harvest Berries","Collect food by harvesting these wild berries.");
         harvestBerriesTooltip.x = -202;
         harvestBerriesTooltip.y = 10;
         harvestBerriesOption.tooltip = harvestBerriesTooltip;
         addChild(harvestBerriesTooltip);
         buildBlasterCannonTooltip = new Tooltip(170,100,"[1] Blaster Cannon","Upgrade to Blaster Cannon, deals more damage.");
         buildBlasterCannonTooltip.x = -202;
         buildBlasterCannonTooltip.y = 10;
         buildBlasterCannonOption.tooltip = buildBlasterCannonTooltip;
         addChild(buildBlasterCannonTooltip);
         buildNoxxerCannonTooltip = new Tooltip(170,100,"[2] Noxxer Cannon","Upgrade to Noxxer Cannon, deals area damage and slows.");
         buildNoxxerCannonTooltip.x = -202;
         buildNoxxerCannonTooltip.y = 10;
         buildNoxxerCannonOption.tooltip = buildNoxxerCannonTooltip;
         addChild(buildNoxxerCannonTooltip);
         buildZapCannonTooltip = new Tooltip(170,100,"[3] Zap Cannon","Upgrade to Zap Cannon with ability chance to stun.");
         buildZapCannonTooltip.x = -202;
         buildZapCannonTooltip.y = 10;
         buildZapCannonOption.tooltip = buildZapCannonTooltip;
         addChild(buildZapCannonTooltip);
         tradeFoodTooltip = new Tooltip(170,100,"[1] Trade Food","Exchange Èfood for Âminerals.");
         tradeFoodTooltip.x = -202;
         tradeFoodTooltip.y = 10;
         tradeFoodOption.tooltip = tradeFoodTooltip;
         addChild(tradeFoodTooltip);
         tradeMineralsTooltip = new Tooltip(170,100,"[2] Trade Minerals","Exchange Âminerals for Èfood.");
         tradeMineralsTooltip.x = -202;
         tradeMineralsTooltip.y = 10;
         tradeMineralsOption.tooltip = tradeMineralsTooltip;
         addChild(tradeMineralsTooltip);
         upgradeToAgripodTooltip = new Tooltip(170,100,"[1] Agripod","Upgrade to Agripod, generates more È.");
         upgradeToAgripodTooltip.x = -202;
         upgradeToAgripodTooltip.y = 10;
         upgradeToAgripodOption.tooltip = upgradeToAgripodTooltip;
         addChild(upgradeToAgripodTooltip);
         upgradeToPowerhouseTooltip = new Tooltip(170,100,"[1] Powerhouse","Upgrade to Powehouse, generates more Ë.");
         upgradeToPowerhouseTooltip.x = -202;
         upgradeToPowerhouseTooltip.y = 10;
         upgradeToPowerhouseOption.tooltip = upgradeToPowerhouseTooltip;
         addChild(upgradeToPowerhouseTooltip);
         upgradeToReactorTooltip = new Tooltip(170,100,"[1] Reactor","Upgrade to Reactor, generates even more Ë.");
         upgradeToReactorTooltip.x = -202;
         upgradeToReactorTooltip.y = 10;
         upgradeToReactorOption.tooltip = upgradeToReactorTooltip;
         addChild(upgradeToReactorTooltip);
         upgradeToCommandCenterV2Tooltip = new Tooltip(170,100,"[1] C. Center V2","Upgrade to C. Center V2, unlocks more buildings.");
         upgradeToCommandCenterV2Tooltip.x = -202;
         upgradeToCommandCenterV2Tooltip.y = 10;
         upgradeToCommandCenterV2Option.tooltip = upgradeToCommandCenterV2Tooltip;
         addChild(upgradeToCommandCenterV2Tooltip);
         upgradeToBlasterSentryTooltip = new Tooltip(170,100,"[1] Blaster Sentry","Upgrade to Blaster Sentry. Reaches enemies 3 tiles away.");
         upgradeToBlasterSentryTooltip.x = -202;
         upgradeToBlasterSentryTooltip.y = 10;
         upgradeToBlasterSentryOption.tooltip = upgradeToBlasterSentryTooltip;
         addChild(upgradeToBlasterSentryTooltip);
         upgradeToNoxxerSentryTooltip = new Tooltip(170,100,"[1] Noxxer Sentry","Upgrade to Noxxer Sentry. Increases slow effect to 50%.");
         upgradeToNoxxerSentryTooltip.x = -202;
         upgradeToNoxxerSentryTooltip.y = 10;
         upgradeToNoxxerSentryOption.tooltip = upgradeToNoxxerSentryTooltip;
         addChild(upgradeToNoxxerSentryTooltip);
         upgradeToZapSentryTooltip = new Tooltip(170,100,"[1] Zap Sentry","Upgrade to Zap Sentry. Has 60% stun chance.");
         upgradeToZapSentryTooltip.x = -202;
         upgradeToZapSentryTooltip.y = 10;
         upgradeToZapSentryOption.tooltip = upgradeToZapSentryTooltip;
         addChild(upgradeToZapSentryTooltip);
      }
      
      public function setTile(param1:Tile) : void
      {
         this.tile = param1;
         if(param1.building == null)
         {
            map.mapHUD.tileNameTextField.text = param1.tileName;
            map.mapHUD.tileDescTextField.text = param1.tileDesc;
            salvageOption.visible = true;
            buildOption.visible = true;
            interceptOption.visible = true;
            if(param1.food + param1.minerals > 0 && bEnableSalvage)
            {
               salvageOption.setHint(param1.getSalvageCost(false) + "Å");
               salvageOption.setIsEnabled(param1.map.player.curSearchpower >= param1.getSalvageCost(false));
               salvageTooltip.bodyTextField.text = "Collect all food and minerals found in the area.\n\nRequires: Á" + param1.getSalvageTime(false) + ":00";
               map.mapHUD.num1Callback = salvageOption;
            }
            else
            {
               salvageOption.setHint("");
               salvageOption.setIsEnabled(false);
            }
            buildOption.setIsEnabled(bEnableBuild);
            map.mapHUD.num2Callback = buildOption;
            abandonOption.setIsEnabled(!map.bTDMode && bEnableAbandon);
            abandonOption.visible = true;
            map.mapHUD.num7Callback = abandonOption;
            abandonTooltip.bodyTextField.text = "Leave and unsecure this tile.\n\nRequires: Á" + param1.getAbandonTime(false) + ":00";
            demolishOption.visible = false;
            troopPowerUpgradeOption.visible = false;
            commandPowerUpgradeOption.visible = false;
            buildingExtrasUpgradeOption.visible = false;
            harvestLumberOption.visible = false;
            harvestBerriesOption.visible = false;
            buildBlasterCannonOption.visible = false;
            buildNoxxerCannonOption.visible = false;
            buildZapCannonOption.visible = false;
            tradeFoodOption.visible = false;
            tradeMineralsOption.visible = false;
            upgradeToAgripodOption.visible = false;
            upgradeToPowerhouseOption.visible = false;
            upgradeToReactorOption.visible = false;
            upgradeToCommandCenterV2Option.visible = false;
            upgradeToBlasterSentryOption.visible = false;
            upgradeToNoxxerSentryOption.visible = false;
            upgradeToZapSentryOption.visible = false;
         }
         else
         {
            map.mapHUD.tileNameTextField.text = Building.getBuildingName(param1.building.type);
            map.mapHUD.tileDescTextField.text = Building.getBuildingDescription(param1.building.type,map);
            salvageOption.setHint("");
            salvageOption.visible = false;
            buildOption.visible = false;
            interceptOption.visible = false;
            if(param1.building.type == 106)
            {
               troopPowerUpgradeOption.visible = true;
               commandPowerUpgradeOption.visible = true;
               buildingExtrasUpgradeOption.visible = true;
               map.mapHUD.num1Callback = troopPowerUpgradeOption;
               map.mapHUD.num2Callback = commandPowerUpgradeOption;
               map.mapHUD.num3Callback = buildingExtrasUpgradeOption;
            }
            else
            {
               troopPowerUpgradeOption.visible = false;
               commandPowerUpgradeOption.visible = false;
               buildingExtrasUpgradeOption.visible = false;
            }
            if(param1.building.type == 10 || param1.building.type == 14 || param1.building.type == 15 || param1.building.type == 16 || param1.building.type == 17 || param1.building.type == 18 || param1.building.type == 19 || param1.building.type == 20 || param1.building.type == 21)
            {
               harvestLumberOption.visible = true;
               map.mapHUD.num1Callback = harvestLumberOption;
            }
            else
            {
               harvestLumberOption.visible = false;
            }
            if(param1.building.type == 30 || param1.building.type == 31)
            {
               harvestBerriesOption.visible = true;
               map.mapHUD.num1Callback = harvestBerriesOption;
            }
            else
            {
               harvestBerriesOption.visible = false;
            }
            if(param1.building.type == 105)
            {
               buildBlasterCannonOption.visible = true;
               buildNoxxerCannonOption.visible = true;
               buildZapCannonOption.visible = true;
               buildBlasterCannonOption.check(map,param1);
               buildNoxxerCannonOption.check(map,param1);
               buildZapCannonOption.check(map,param1);
               map.mapHUD.num1Callback = buildBlasterCannonOption;
               map.mapHUD.num2Callback = buildNoxxerCannonOption;
               map.mapHUD.num3Callback = buildZapCannonOption;
            }
            else
            {
               buildBlasterCannonOption.visible = false;
               buildNoxxerCannonOption.visible = false;
               buildZapCannonOption.visible = false;
            }
            if(param1.building.type == 108)
            {
               tradeFoodOption.visible = true;
               tradeMineralsOption.visible = true;
               map.mapHUD.num1Callback = tradeFoodOption;
               map.mapHUD.num2Callback = tradeMineralsOption;
            }
            else
            {
               tradeFoodOption.visible = false;
               tradeMineralsOption.visible = false;
            }
            if(param1.building.type == 102)
            {
               upgradeToAgripodOption.visible = true;
               upgradeToAgripodOption.check(map,param1);
               map.mapHUD.num1Callback = upgradeToAgripodOption;
            }
            else
            {
               upgradeToAgripodOption.visible = false;
            }
            if(param1.building.type == 101)
            {
               upgradeToPowerhouseOption.visible = true;
               upgradeToPowerhouseOption.check(map,param1);
               map.mapHUD.num1Callback = upgradeToPowerhouseOption;
            }
            else
            {
               upgradeToPowerhouseOption.visible = false;
            }
            if(param1.building.type == 201)
            {
               upgradeToReactorOption.visible = true;
               upgradeToReactorOption.check(map,param1);
               map.mapHUD.num1Callback = upgradeToReactorOption;
            }
            else
            {
               upgradeToReactorOption.visible = false;
            }
            if(param1.building.type == 100)
            {
               upgradeToCommandCenterV2Option.visible = true;
               upgradeToCommandCenterV2Option.check(map,param1);
               map.mapHUD.num1Callback = upgradeToCommandCenterV2Option;
            }
            else
            {
               upgradeToCommandCenterV2Option.visible = false;
            }
            if(param1.building.type == 110 && map.pgame.isPremiumPlayer())
            {
               upgradeToBlasterSentryOption.visible = true;
               upgradeToBlasterSentryOption.check(map,param1);
               map.mapHUD.num1Callback = upgradeToBlasterSentryOption;
            }
            else
            {
               upgradeToBlasterSentryOption.visible = false;
            }
            if(param1.building.type == 111 && map.pgame.isPremiumPlayer())
            {
               upgradeToNoxxerSentryOption.visible = true;
               upgradeToNoxxerSentryOption.check(map,param1);
               map.mapHUD.num1Callback = upgradeToNoxxerSentryOption;
            }
            else
            {
               upgradeToNoxxerSentryOption.visible = false;
            }
            if(param1.building.type == 113 && map.pgame.isPremiumPlayer())
            {
               upgradeToZapSentryOption.visible = true;
               upgradeToZapSentryOption.check(map,param1);
               map.mapHUD.num1Callback = upgradeToZapSentryOption;
            }
            else
            {
               upgradeToZapSentryOption.visible = false;
            }
            abandonOption.setIsEnabled(!map.bTDMode);
            demolishOption.setIsEnabled(true);
            if(param1.building.type == 100 || param1.building.type == 200 || param1.building.type == 301)
            {
               demolishOption.setIsEnabled(false);
               abandonOption.setIsEnabled(false);
               demolishOption.visible = true;
               abandonOption.visible = true;
               map.mapHUD.num6Callback = demolishOption;
               map.mapHUD.num7Callback = abandonOption;
               abandonTooltip.bodyTextField.text = "Leave and unsecure this tile.\n\nCannot be abandoned.";
            }
            else if(param1.building.type == 10 || param1.building.type == 14 || param1.building.type == 15 || param1.building.type == 16 || param1.building.type == 17 || param1.building.type == 18 || param1.building.type == 19 || param1.building.type == 20 || param1.building.type == 21 || param1.building.type == 30 || param1.building.type == 31)
            {
               demolishOption.visible = false;
            }
            else
            {
               demolishOption.visible = true;
               abandonOption.visible = true;
               map.mapHUD.num6Callback = demolishOption;
               map.mapHUD.num7Callback = abandonOption;
            }
         }
         map.mapHUD.num8Callback = cancelOption;
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
         salvageOption = null;
         buildOption = null;
         interceptOption = null;
         abandonOption = null;
         demolishOption = null;
         cancelOption = null;
         tile = null;
         troopPowerUpgradeOption = null;
         commandPowerUpgradeOption = null;
         buildingExtrasUpgradeOption = null;
         harvestLumberOption = null;
         harvestBerriesOption = null;
         buildBlasterCannonOption = null;
         buildNoxxerCannonOption = null;
         buildZapCannonOption = null;
         tradeFoodOption = null;
         tradeMineralsOption = null;
         upgradeToAgripodOption = null;
         upgradeToPowerhouseOption = null;
         upgradeToReactorOption = null;
         upgradeToCommandCenterV2Option = null;
         upgradeToBlasterSentryOption = null;
         upgradeToNoxxerSentryOption = null;
         upgradeToZapSentryOption = null;
         salvageTooltip = null;
         abandonTooltip = null;
         super.dispose();
      }
   }
}

