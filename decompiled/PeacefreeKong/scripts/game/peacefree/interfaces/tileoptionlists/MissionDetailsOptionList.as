package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.InvadeMission;
   
   public class MissionDetailsOptionList extends TileOptionList
   {
      
      public var map:Map;
      
      public var abortOption:TileOption;
      
      public var interceptOption:TileOption;
      
      public var cancelOption:TileOption;
      
      public var tile:Tile;
      
      private var interceptTooltip:Tooltip;
      
      public function MissionDetailsOptionList(param1:Map)
      {
         var abortTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         abortOption = new TileOption("icon_abort");
         abortOption.x = 120;
         abortOption.y = 60;
         abortOption.releaseCallback = function():void
         {
            tile.mission.cancel();
         };
         addChild(abortOption);
         interceptOption = new TileOption("icon_intercept","");
         interceptOption.x = 0;
         interceptOption.y = 0;
         interceptOption.visible = false;
         interceptOption.releaseCallback = function():void
         {
            if(map.player.curFirepower >= tile.mob.getInterceptCost(false))
            {
               InvadeMission(tile.mission).intercept(false);
               map.selectTile(null);
            }
         };
         addChild(interceptOption);
         cancelOption = new TileOption("icon_cancel");
         cancelOption.x = 180;
         cancelOption.y = 60;
         cancelOption.releaseCallback = function():void
         {
            map.selectTile(null);
         };
         addChild(cancelOption);
         abortTooltip = new Tooltip(170,100,"[7] Abort Mission","Abort this mission and recover some spent resources.");
         abortTooltip.x = -202;
         abortTooltip.y = 10;
         abortOption.tooltip = abortTooltip;
         addChild(abortTooltip);
         interceptTooltip = new Tooltip(170,115,"[1] Defend the Area","Send a team to destroy the invading enemy.");
         interceptTooltip.x = -202;
         interceptTooltip.y = -25;
         interceptOption.tooltip = interceptTooltip;
         addChild(interceptTooltip);
      }
      
      public function setTile(param1:Tile) : void
      {
         this.tile = param1;
         if(param1.mission is InvadeMission && !InvadeMission(param1.mission).bDefenseMode)
         {
            interceptOption.visible = true;
            abortOption.visible = false;
            interceptOption.setHint(param1.mob.getInterceptCost(false) + "Æ");
            interceptOption.setIsEnabled(param1.map.player.curFirepower >= param1.mob.getInterceptCost(false));
            interceptTooltip.bodyTextField.text = "Send a team to destroy the invading enemy.\n\nRequires: Á" + param1.mob.getInterceptTime(false) + ":00";
            map.mapHUD.num1Callback = interceptOption;
         }
         else
         {
            interceptOption.visible = false;
            abortOption.visible = true;
            map.mapHUD.num7Callback = abortOption;
         }
         map.mapHUD.num8Callback = cancelOption;
      }
      
      override public function refresh() : void
      {
         if(tile.mission == null)
         {
            map.mapHUD.setSelectedTile(null);
         }
         else
         {
            setTile(tile);
            map.mapHUD.tileNameTextField.text = tile.mission.getMissionTitle();
            map.mapHUD.tileDescTextField.text = tile.mission.getMissionDescription();
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         abortOption = null;
         interceptOption = null;
         cancelOption = null;
         tile = null;
         interceptTooltip = null;
         super.dispose();
      }
   }
}

