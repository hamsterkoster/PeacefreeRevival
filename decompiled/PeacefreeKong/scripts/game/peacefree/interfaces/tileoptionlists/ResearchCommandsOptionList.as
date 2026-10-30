package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Building;
   import game.peacefree.Map;
   import game.peacefree.Research;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.ResearchCommandOption;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.ResearchMission;
   
   public class ResearchCommandsOptionList extends TileOptionList
   {
      
      private var map:Map;
      
      private var tile:Tile;
      
      private var blastPowerOption:ResearchCommandOption;
      
      private var bigBlastOption:ResearchCommandOption;
      
      private var quickBlastOption:ResearchCommandOption;
      
      private var zapPowerOption:ResearchCommandOption;
      
      private var zapStunOption:ResearchCommandOption;
      
      private var aidPowerOption:ResearchCommandOption;
      
      private var cancelButton:TileOption;
      
      public function ResearchCommandsOptionList(param1:Map)
      {
         var blastPowerTooltip:Tooltip;
         var bigBlastTooltip:Tooltip;
         var quickBlastTooltip:Tooltip;
         var zapPowerTooltip:Tooltip;
         var zapStunTooltip:Tooltip;
         var aidPowerTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         blastPowerOption = new ResearchCommandOption("command_blast",1,"POW",1.75);
         blastPowerOption.x = 0;
         blastPowerOption.y = 0;
         blastPowerOption.visible = true;
         blastPowerOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(1);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(1);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(1,false),map.research.getResearchCost(1,false),function():void
            {
               tile.setMission(new ResearchMission(tile,1,false));
               map.selectTile(null);
            },map.research.getResearchTime(1,true),map.research.getResearchCost(1,true),function():void
            {
               tile.setMission(new ResearchMission(tile,1,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchCommandsOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(blastPowerOption);
         bigBlastOption = new ResearchCommandOption("command_blast",2,"RNG",1.75);
         bigBlastOption.x = 60;
         bigBlastOption.y = 0;
         bigBlastOption.visible = true;
         bigBlastOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(2);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(2);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(2,false),map.research.getResearchCost(2,false),function():void
            {
               tile.setMission(new ResearchMission(tile,2,false));
               map.selectTile(null);
            },map.research.getResearchTime(2,true),map.research.getResearchCost(2,true),function():void
            {
               tile.setMission(new ResearchMission(tile,2,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchCommandsOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(bigBlastOption);
         quickBlastOption = new ResearchCommandOption("command_blast",3,"CD",1.75);
         quickBlastOption.x = 120;
         quickBlastOption.y = 0;
         quickBlastOption.visible = true;
         quickBlastOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(3);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(3);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(3,false),map.research.getResearchCost(3,false),function():void
            {
               tile.setMission(new ResearchMission(tile,3,false));
               map.selectTile(null);
            },map.research.getResearchTime(3,true),map.research.getResearchCost(3,true),function():void
            {
               tile.setMission(new ResearchMission(tile,3,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchCommandsOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(quickBlastOption);
         zapPowerOption = new ResearchCommandOption("command_zap",4,"POW",1.75);
         zapPowerOption.x = 180;
         zapPowerOption.y = 0;
         zapPowerOption.visible = true;
         zapPowerOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(4);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(4);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(4,false),map.research.getResearchCost(4,false),function():void
            {
               tile.setMission(new ResearchMission(tile,4,false));
               map.selectTile(null);
            },map.research.getResearchTime(4,true),map.research.getResearchCost(4,true),function():void
            {
               tile.setMission(new ResearchMission(tile,4,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchCommandsOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(zapPowerOption);
         zapStunOption = new ResearchCommandOption("command_zap",5,"DUR",1.75);
         zapStunOption.x = 0;
         zapStunOption.y = 60;
         zapStunOption.visible = true;
         zapStunOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(5);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(5);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(5,false),map.research.getResearchCost(5,false),function():void
            {
               tile.setMission(new ResearchMission(tile,5,false));
               map.selectTile(null);
            },map.research.getResearchTime(5,true),map.research.getResearchCost(5,true),function():void
            {
               tile.setMission(new ResearchMission(tile,5,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchCommandsOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(zapStunOption);
         aidPowerOption = new ResearchCommandOption("command_aid",6,"POW",1.75);
         aidPowerOption.x = 60;
         aidPowerOption.y = 60;
         aidPowerOption.visible = true;
         aidPowerOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(6);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(6);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(6,false),map.research.getResearchCost(6,false),function():void
            {
               tile.setMission(new ResearchMission(tile,6,false));
               map.selectTile(null);
            },map.research.getResearchTime(6,true),map.research.getResearchCost(6,true),function():void
            {
               tile.setMission(new ResearchMission(tile,6,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchCommandsOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchCommandsOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(aidPowerOption);
         cancelButton = new TileOption("icon_cancel");
         cancelButton.x = 180;
         cancelButton.y = 60;
         cancelButton.releaseCallback = function():void
         {
            map.mapHUD.setSelectedTile(tile);
         };
         addChild(cancelButton);
         blastPowerTooltip = new Tooltip(170,100,"[1] Blast Power","Increase damage dealt by your Blast Command.");
         blastPowerTooltip.x = -202;
         blastPowerTooltip.y = 10;
         blastPowerOption.tooltip = blastPowerTooltip;
         addChild(blastPowerTooltip);
         bigBlastTooltip = new Tooltip(170,100,"[2] Big Blast","Increase area of effect of your Blast Command.");
         bigBlastTooltip.x = -202;
         bigBlastTooltip.y = 10;
         bigBlastOption.tooltip = bigBlastTooltip;
         addChild(bigBlastTooltip);
         quickBlastTooltip = new Tooltip(170,100,"[3] Quick Blast","Reduces cooldown time of your Blast Command.");
         quickBlastTooltip.x = -202;
         quickBlastTooltip.y = 10;
         quickBlastOption.tooltip = quickBlastTooltip;
         addChild(quickBlastTooltip);
         zapPowerTooltip = new Tooltip(170,100,"[4] Zap Power","Increase damage dealt by your Zap Command.");
         zapPowerTooltip.x = -202;
         zapPowerTooltip.y = 10;
         zapPowerOption.tooltip = zapPowerTooltip;
         addChild(zapPowerTooltip);
         zapStunTooltip = new Tooltip(170,100,"[5] Zap Stun","Increase stun duration of your Zap Command.");
         zapStunTooltip.x = -202;
         zapStunTooltip.y = 10;
         zapStunOption.tooltip = zapStunTooltip;
         addChild(zapStunTooltip);
         aidPowerTooltip = new Tooltip(170,100,"[6] Aid Power","Increase max È/Â you can get from Aid Command.");
         aidPowerTooltip.x = -202;
         aidPowerTooltip.y = 10;
         aidPowerOption.tooltip = aidPowerTooltip;
         addChild(aidPowerTooltip);
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
         blastPowerOption.check(map,param1);
         map.mapHUD.num1Callback = blastPowerOption;
         bigBlastOption.check(map,param1);
         map.mapHUD.num2Callback = bigBlastOption;
         quickBlastOption.check(map,param1);
         map.mapHUD.num3Callback = quickBlastOption;
         zapPowerOption.check(map,param1);
         map.mapHUD.num4Callback = zapPowerOption;
         zapStunOption.check(map,param1);
         map.mapHUD.num5Callback = zapStunOption;
         aidPowerOption.check(map,param1);
         map.mapHUD.num6Callback = aidPowerOption;
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
         blastPowerOption = null;
         bigBlastOption = null;
         quickBlastOption = null;
         zapPowerOption = null;
         zapStunOption = null;
         aidPowerOption = null;
         cancelButton = null;
         super.dispose();
      }
   }
}

