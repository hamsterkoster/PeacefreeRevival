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
   
   public class ResearchTroopPowersOptionList extends TileOptionList
   {
      
      private var map:Map;
      
      private var tile:Tile;
      
      private var fpUpOption:ResearchCommandOption;
      
      private var tpUpOption:ResearchCommandOption;
      
      private var spUpOption:ResearchCommandOption;
      
      private var cancelButton:TileOption;
      
      public function ResearchTroopPowersOptionList(param1:Map)
      {
         var spUpTooltip:Tooltip;
         var fpUpTooltip:Tooltip;
         var tpUpTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         spUpOption = new ResearchCommandOption("icon_max_sp",9,"");
         spUpOption.x = 0;
         spUpOption.y = 0;
         spUpOption.visible = true;
         spUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(9);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(9);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(9,false),map.research.getResearchCost(9,false),function():void
            {
               tile.setMission(new ResearchMission(tile,9,false));
               map.selectTile(null);
            },map.research.getResearchTime(9,true),map.research.getResearchCost(9,true),function():void
            {
               tile.setMission(new ResearchMission(tile,9,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchTroopPowersOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchTroopPowersOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(spUpOption);
         fpUpOption = new ResearchCommandOption("icon_max_fp",7,"");
         fpUpOption.x = 60;
         fpUpOption.y = 0;
         fpUpOption.visible = true;
         fpUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(7);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(7);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(7,false),map.research.getResearchCost(7,false),function():void
            {
               tile.setMission(new ResearchMission(tile,7,false));
               map.selectTile(null);
            },map.research.getResearchTime(7,true),map.research.getResearchCost(7,true),function():void
            {
               tile.setMission(new ResearchMission(tile,7,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchTroopPowersOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchTroopPowersOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(fpUpOption);
         tpUpOption = new ResearchCommandOption("icon_max_tp",8,"");
         tpUpOption.x = 120;
         tpUpOption.y = 0;
         tpUpOption.visible = true;
         tpUpOption.releaseCallback = function():void
         {
            map.mapHUD.tileNameTextField.text = Research.getResearchTitle(8);
            map.mapHUD.tileDescTextField.text = map.research.getResearchDesc(8);
            map.mapHUD.confirmMissionOptionList.setValues(2,map.research.getResearchTime(8,false),map.research.getResearchCost(8,false),function():void
            {
               tile.setMission(new ResearchMission(tile,8,false));
               map.selectTile(null);
            },map.research.getResearchTime(8,true),map.research.getResearchCost(8,true),function():void
            {
               tile.setMission(new ResearchMission(tile,8,true));
               map.selectTile(null);
            },function():void
            {
               map.mapHUD.researchTroopPowersOptionList.setTile(tile);
               map.mapHUD.setOptionList(map.mapHUD.researchTroopPowersOptionList);
            });
            map.mapHUD.setOptionList(map.mapHUD.confirmMissionOptionList);
         };
         addChild(tpUpOption);
         cancelButton = new TileOption("icon_cancel");
         cancelButton.x = 180;
         cancelButton.y = 60;
         cancelButton.releaseCallback = function():void
         {
            map.mapHUD.setSelectedTile(tile);
         };
         addChild(cancelButton);
         spUpTooltip = new Tooltip(170,100,"[1] Seachpower Upg.","Increases your max Å searchpower and recovery.");
         spUpTooltip.x = -202;
         spUpTooltip.y = 10;
         spUpOption.tooltip = spUpTooltip;
         addChild(spUpTooltip);
         fpUpTooltip = new Tooltip(170,100,"[2] Firepower Upg.","Increases your max Æ firepower and recovery.");
         fpUpTooltip.x = -202;
         fpUpTooltip.y = 10;
         fpUpOption.tooltip = fpUpTooltip;
         addChild(fpUpTooltip);
         tpUpTooltip = new Tooltip(170,100,"[3] Techpower Upg.","Increases your max Ê techpower and recovery.");
         tpUpTooltip.x = -202;
         tpUpTooltip.y = 10;
         tpUpOption.tooltip = tpUpTooltip;
         addChild(tpUpTooltip);
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
         spUpOption.check(map,param1);
         map.mapHUD.num1Callback = spUpOption;
         fpUpOption.check(map,param1);
         map.mapHUD.num2Callback = fpUpOption;
         tpUpOption.check(map,param1);
         map.mapHUD.num3Callback = tpUpOption;
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
         fpUpOption = null;
         tpUpOption = null;
         spUpOption = null;
         cancelButton = null;
         super.dispose();
      }
   }
}

