package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.BigTileOption;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   
   public class TradeOptionList extends TileOptionList
   {
      
      public static const TRADE_FOOD:int = 1;
      
      public static const TRADE_MINERALS:int = 2;
      
      private var map:Map;
      
      private var tile:Tile;
      
      private var type:int;
      
      private var trade20FoodOption:BigTileOption;
      
      private var trade100FoodOption:BigTileOption;
      
      private var trade20MineralsOption:BigTileOption;
      
      private var trade100MineralsOption:BigTileOption;
      
      private var cancelOption:TileOption;
      
      public function TradeOptionList(param1:Map)
      {
         var trade20FoodTooltip:Tooltip;
         var trade100FoodTooltip:Tooltip;
         var trade20MineralsTooltip:Tooltip;
         var trade100MineralsTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         trade20FoodOption = new BigTileOption("icon_trade","");
         trade20FoodOption.x = 0;
         trade20FoodOption.y = 0;
         trade20FoodOption.visible = false;
         trade20FoodOption.releaseCallback = function():void
         {
            map.tradeFood(20);
            setType(type,tile);
         };
         addChild(trade20FoodOption);
         trade100FoodOption = new BigTileOption("icon_trade","");
         trade100FoodOption.x = 110;
         trade100FoodOption.y = 0;
         trade100FoodOption.visible = false;
         trade100FoodOption.releaseCallback = function():void
         {
            map.tradeFood(100);
            setType(type,tile);
         };
         addChild(trade100FoodOption);
         trade20MineralsOption = new BigTileOption("icon_trade","");
         trade20MineralsOption.x = 0;
         trade20MineralsOption.y = 0;
         trade20MineralsOption.visible = false;
         trade20MineralsOption.releaseCallback = function():void
         {
            map.tradeMinerals(20);
            setType(type,tile);
         };
         addChild(trade20MineralsOption);
         trade100MineralsOption = new BigTileOption("icon_trade","");
         trade100MineralsOption.x = 110;
         trade100MineralsOption.y = 0;
         trade100MineralsOption.visible = false;
         trade100MineralsOption.releaseCallback = function():void
         {
            map.tradeMinerals(100);
            setType(type,tile);
         };
         addChild(trade100MineralsOption);
         cancelOption = new TileOption("icon_cancel");
         cancelOption.x = 180;
         cancelOption.y = 60;
         cancelOption.releaseCallback = function():void
         {
            map.mapHUD.setSelectedTile(tile);
         };
         addChild(cancelOption);
         trade20FoodTooltip = new Tooltip(170,100,"[1] Trade È20 for Â","Exchange È20 food for Âminerals.");
         trade20FoodTooltip.x = -202;
         trade20FoodTooltip.y = 10;
         trade20FoodOption.tooltip = trade20FoodTooltip;
         addChild(trade20FoodTooltip);
         trade100FoodTooltip = new Tooltip(170,100,"[2] Trade È100 for Â","Exchange È100 food for Âminerals.");
         trade100FoodTooltip.x = -202;
         trade100FoodTooltip.y = 10;
         trade100FoodOption.tooltip = trade100FoodTooltip;
         addChild(trade100FoodTooltip);
         trade20MineralsTooltip = new Tooltip(170,100,"[1] Trade Â20 for È","Exchange Â20 minerals for Èfood.");
         trade20MineralsTooltip.x = -202;
         trade20MineralsTooltip.y = 10;
         trade20MineralsOption.tooltip = trade20MineralsTooltip;
         addChild(trade20MineralsTooltip);
         trade100MineralsTooltip = new Tooltip(170,100,"[2] Trade Â100 for È","Exchange Â100 minerals for Èfood.");
         trade100MineralsTooltip.x = -202;
         trade100MineralsTooltip.y = 10;
         trade100MineralsOption.tooltip = trade100MineralsTooltip;
         addChild(trade100MineralsTooltip);
      }
      
      public function setType(param1:int, param2:Tile) : void
      {
         this.tile = param2;
         this.type = param1;
         if(param1 == 1)
         {
            trade20FoodOption.setIsEnabled(map.player.food >= 20);
            trade100FoodOption.setIsEnabled(map.player.food >= 100);
            trade20FoodOption.setHint("-È20\n+Â10\n");
            trade100FoodOption.setHint("-È100\n+Â50\n");
            trade20FoodOption.visible = true;
            map.mapHUD.num1Callback = trade20FoodOption;
            trade100FoodOption.visible = true;
            map.mapHUD.num2Callback = trade100FoodOption;
            trade20MineralsOption.visible = false;
            trade100MineralsOption.visible = false;
         }
         else
         {
            trade20MineralsOption.setIsEnabled(map.player.minerals >= 20);
            trade100MineralsOption.setIsEnabled(map.player.minerals >= 100);
            trade20MineralsOption.setHint("-Â20\n+È10\n");
            trade100MineralsOption.setHint("-Â100\n+È50\n");
            trade20FoodOption.visible = false;
            trade100FoodOption.visible = false;
            trade20MineralsOption.visible = true;
            map.mapHUD.num1Callback = trade20MineralsOption;
            trade100MineralsOption.visible = true;
            map.mapHUD.num2Callback = trade100MineralsOption;
         }
         map.mapHUD.num8Callback = cancelOption;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         tile = null;
         trade20FoodOption = null;
         trade100FoodOption = null;
         trade20MineralsOption = null;
         trade100MineralsOption = null;
         cancelOption = null;
         super.dispose();
      }
   }
}

