package game.peacefree.interfaces
{
   import game.peacefree.Map;
   import starling.display.Sprite;
   
   public class QuickMissionOptionList extends Sprite
   {
      
      private var map:Map;
      
      private var scoutOption:TileOption;
      
      private var rescueOption:TileOption;
      
      private var secureOption:TileOption;
      
      private var salvageOption:TileOption;
      
      private var interceptOption:TileOption;
      
      private var abandonOption:TileOption;
      
      private var abortOption:TileOption;
      
      private var cancelButton:TileOption;
      
      public function QuickMissionOptionList(param1:Map)
      {
         var scoutTooltip:Tooltip;
         var rescueTooltip:Tooltip;
         var secureTooltip:Tooltip;
         var salvageTooltip:Tooltip;
         var interceptTooltip:Tooltip;
         var abortTooltip:Tooltip;
         var abandonTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         scoutOption = new TileOption("icon_scout");
         scoutOption.x = 0;
         scoutOption.y = 0;
         scoutOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(1);
         };
         addChild(scoutOption);
         rescueOption = new TileOption("icon_rescue");
         rescueOption.x = 60;
         rescueOption.y = 0;
         rescueOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(2);
         };
         addChild(rescueOption);
         secureOption = new TileOption("icon_secure");
         secureOption.x = 120;
         secureOption.y = 0;
         secureOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(3);
         };
         addChild(secureOption);
         salvageOption = new TileOption("icon_salvage");
         salvageOption.x = 0;
         salvageOption.y = 60;
         salvageOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(4);
         };
         addChild(salvageOption);
         interceptOption = new TileOption("icon_intercept");
         interceptOption.x = 60;
         interceptOption.y = 60;
         interceptOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(6);
         };
         addChild(interceptOption);
         abortOption = new TileOption("icon_abort");
         abortOption.x = 120;
         abortOption.y = 60;
         abortOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(8);
         };
         addChild(abortOption);
         abandonOption = new TileOption("icon_abandon");
         abandonOption.x = 0;
         abandonOption.y = 120;
         abandonOption.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.showMissionType(7);
         };
         addChild(abandonOption);
         cancelButton = new TileOption("icon_cancel");
         cancelButton.x = 120;
         cancelButton.y = 120;
         cancelButton.releaseCallback = function():void
         {
            map.mapHUD.quickMissionInterfacer.hide();
         };
         addChild(cancelButton);
         scoutTooltip = new Tooltip(170,100,"[1] Scout the Area","Send team to gather information on selected tiles.");
         scoutTooltip.x = -182;
         scoutTooltip.y = 10;
         scoutOption.tooltip = scoutTooltip;
         addChild(scoutTooltip);
         rescueTooltip = new Tooltip(170,100,"[2] Rescue Civilians","Send team to rescue and recruit civilians.");
         rescueTooltip.x = -182;
         rescueTooltip.y = 10;
         rescueOption.tooltip = rescueTooltip;
         addChild(rescueTooltip);
         secureTooltip = new Tooltip(170,100,"[3] Secure the Area","Take control of selected tiles and expand your base.");
         secureTooltip.x = -182;
         secureTooltip.y = 10;
         secureOption.tooltip = secureTooltip;
         addChild(secureTooltip);
         salvageTooltip = new Tooltip(170,100,"[4] Salvage Tiles","Collect food and minerals found in selected tiles.");
         salvageTooltip.x = -182;
         salvageTooltip.y = 10;
         salvageOption.tooltip = salvageTooltip;
         addChild(salvageTooltip);
         interceptTooltip = new Tooltip(170,100,"[5] Intercept Enemy","Send a team to attack an enemy.");
         interceptTooltip.x = -182;
         interceptTooltip.y = 10;
         interceptOption.tooltip = interceptTooltip;
         addChild(interceptTooltip);
         abortTooltip = new Tooltip(170,100,"[6] Abort Mission","Abort missions and recover some spent resources.");
         abortTooltip.x = -182;
         abortTooltip.y = 10;
         abortOption.tooltip = abortTooltip;
         addChild(abortTooltip);
         abandonTooltip = new Tooltip(170,100,"[7] Abandon Area","Leave and unsecure unwanted tiles.");
         abandonTooltip.x = -182;
         abandonTooltip.y = 10;
         abandonOption.tooltip = abandonTooltip;
         addChild(abandonTooltip);
      }
      
      public function setNumCallbacks() : void
      {
         map.mapHUD.num1Callback = scoutOption;
         map.mapHUD.num2Callback = rescueOption;
         map.mapHUD.num3Callback = secureOption;
         map.mapHUD.num4Callback = salvageOption;
         map.mapHUD.num5Callback = interceptOption;
         map.mapHUD.num6Callback = abortOption;
         map.mapHUD.num7Callback = abandonOption;
         map.mapHUD.num9Callback = cancelButton;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         scoutOption = null;
         rescueOption = null;
         secureOption = null;
         salvageOption = null;
         interceptOption = null;
         abandonOption = null;
         abortOption = null;
         cancelButton = null;
         super.dispose();
      }
   }
}

