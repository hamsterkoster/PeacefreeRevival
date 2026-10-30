package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Map;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.InterceptMission;
   import game.peacefree.missions.RescueMission;
   import game.peacefree.missions.ScoutMission;
   import game.peacefree.missions.SecureMission;
   
   public class UnsecuredTileOptionList extends TileOptionList
   {
      
      private var map:Map;
      
      public var scoutOption:TileOption;
      
      public var rescueOption:TileOption;
      
      public var secureOption:TileOption;
      
      public var interceptOption:TileOption;
      
      public var cancelOption:TileOption;
      
      private var tile:Tile;
      
      private var scoutTooltip:Tooltip;
      
      private var rescueTooltip:Tooltip;
      
      private var secureTooltip:Tooltip;
      
      private var interceptTooltip:Tooltip;
      
      public var bEnableSecure:Boolean = true;
      
      public var bEnableIntercept:Boolean = true;
      
      public function UnsecuredTileOptionList(param1:Map)
      {
         var map:Map = param1;
         super();
         this.map = map;
         scoutOption = new TileOption("icon_scout","");
         scoutOption.x = 0;
         scoutOption.y = 0;
         scoutOption.releaseCallback = function():void
         {
            if(tile.map.player.curSearchpower >= tile.getScoutCost(false))
            {
               tile.setMission(new ScoutMission(tile,false));
               map.selectTile(null);
            }
         };
         addChild(scoutOption);
         rescueOption = new TileOption("icon_rescue","");
         rescueOption.x = 60;
         rescueOption.y = 0;
         rescueOption.releaseCallback = function():void
         {
            if(tile.map.player.curFirepower >= tile.getRescueCost(false))
            {
               tile.setMission(new RescueMission(tile,false));
               map.selectTile(null);
            }
         };
         addChild(rescueOption);
         secureOption = new TileOption("icon_secure","");
         secureOption.x = 120;
         secureOption.y = 0;
         secureOption.releaseCallback = function():void
         {
            if(tile.map.player.curFirepower >= tile.getSecureCost(false))
            {
               tile.setMission(new SecureMission(tile,false));
               map.selectTile(null);
            }
         };
         addChild(secureOption);
         interceptOption = new TileOption("icon_intercept","");
         interceptOption.x = 0;
         interceptOption.y = 60;
         interceptOption.releaseCallback = function():void
         {
            if(tile.mob != null && tile.map.player.curFirepower >= tile.mob.getInterceptCost(false))
            {
               tile.setMission(new InterceptMission(tile,false));
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
         scoutTooltip = new Tooltip(170,135,"[1] Scout the Area","Send team to gather information in this area.");
         scoutTooltip.x = -202;
         scoutTooltip.y = -25;
         scoutOption.tooltip = scoutTooltip;
         addChild(scoutTooltip);
         rescueTooltip = new Tooltip(170,135,"[2] Rescue Civilians","Send team to rescue and recruit civilians from a distance.");
         rescueTooltip.x = -202;
         rescueTooltip.y = -25;
         rescueOption.tooltip = rescueTooltip;
         addChild(rescueTooltip);
         secureTooltip = new Tooltip(170,115,"[3] Secure the Area","Take control of this tile and rescue all civilians.");
         secureTooltip.x = -202;
         secureTooltip.y = -25;
         secureOption.tooltip = secureTooltip;
         addChild(secureTooltip);
         interceptTooltip = new Tooltip(170,115,"[5] Intercept Enemy","Send a team to attack the enemy.");
         interceptTooltip.x = -202;
         interceptTooltip.y = -5;
         interceptOption.tooltip = interceptTooltip;
         addChild(interceptTooltip);
      }
      
      public function setTile(param1:Tile) : void
      {
         this.tile = param1;
         if(param1.mob != null)
         {
            scoutOption.setHint("");
            rescueOption.setHint("");
            secureOption.setHint("");
            scoutOption.setIsEnabled(false);
            rescueOption.setIsEnabled(false);
            secureOption.setIsEnabled(false);
            if(map.bTDMode)
            {
               interceptOption.setHint("");
               interceptOption.setIsEnabled(false);
            }
            else
            {
               interceptOption.setHint(param1.mob.getInterceptCost(false) + "Æ");
               interceptOption.setIsEnabled(bEnableIntercept && param1.map.player.curFirepower >= param1.mob.getInterceptCost(false));
               interceptTooltip.bodyTextField.text = "Send a team to attack the enemy.\n\nRequires: Á" + param1.mob.getInterceptTime(false) + ":00";
               map.mapHUD.num5Callback = interceptOption;
            }
            map.mapHUD.tileDescTextField.text = "A " + Mob.getName(param1.mob.type) + " with " + "Ø" + param1.mob.health + " is currently occupying this area.";
            scoutTooltip.bodyTextField.text = "Send team to gather information in this area.\n\nDestroy enemy first.";
            rescueTooltip.bodyTextField.text = "Send team to rescue and recruit civilians from a distance.\n\nDestroy enemy first.";
            secureTooltip.bodyTextField.text = "Take control of this tile and rescue all civilians.\n\nDestroy enemy first.";
         }
         else if(param1.bScouted)
         {
            scoutOption.setHint("");
            scoutOption.setIsEnabled(false);
            if(param1.recruits > 0)
            {
               rescueOption.setHint(param1.getRescueCost(false) + "Æ");
               rescueOption.setIsEnabled(param1.map.player.curFirepower >= param1.getRescueCost(false));
               rescueTooltip.bodyTextField.text = "Send team to rescue and recruit civilians from a distance.\n\nRequires: Á" + param1.getRescueTime(false) + ":00";
               map.mapHUD.num2Callback = rescueOption;
            }
            else
            {
               rescueOption.setHint("");
               rescueOption.setIsEnabled(false);
               rescueTooltip.bodyTextField.text = "Send team to rescue and recruit civilians from a distance.\n\nNo civilians found.";
            }
            if(param1.bSecuredNearby && bEnableSecure)
            {
               secureOption.setHint(param1.getSecureCost(false) + "Æ");
               secureOption.setIsEnabled(param1.map.player.curFirepower >= param1.getSecureCost(false));
               secureTooltip.bodyTextField.text = "Take control of this tile and rescue all civilians.\n\nRequires: Á" + param1.getSecureTime(false) + ":00";
               map.mapHUD.num3Callback = secureOption;
            }
            else
            {
               secureOption.setHint("");
               secureOption.setIsEnabled(false);
            }
            interceptOption.setHint("");
            interceptOption.setIsEnabled(false);
            scoutTooltip.bodyTextField.text = "Send team to gather information in this area.\n\nScout Complete.";
            interceptTooltip.bodyTextField.text = "Send a team to attack the enemy.\n\nNo ships to intercept.";
         }
         else
         {
            if(param1 != null)
            {
               scoutOption.setHint(param1.getScoutCost(false) + "Å");
            }
            else
            {
               scoutOption.setHint("");
            }
            rescueOption.setHint("");
            secureOption.setHint("");
            interceptOption.setHint("");
            scoutOption.setIsEnabled(param1.map.player.curSearchpower >= param1.getScoutCost(false));
            map.mapHUD.num1Callback = scoutOption;
            scoutTooltip.bodyTextField.text = "Send team to gather information in this area.\n\nRequires: Á" + param1.getScoutTime(false) + ":00";
            rescueOption.setIsEnabled(false);
            secureOption.setIsEnabled(false);
            interceptOption.setIsEnabled(false);
            rescueTooltip.bodyTextField.text = "Send team to rescue and recruit civilians from a distance.\n\nScout tile first.";
            secureTooltip.bodyTextField.text = "Take control of this tile and rescue all civilians.\n\nScout tile first.";
            interceptTooltip.bodyTextField.text = "Send a team to attack the enemy.\n\nNo ships to intercept.";
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
         scoutOption = null;
         rescueOption = null;
         secureOption = null;
         interceptOption = null;
         cancelOption = null;
         tile = null;
         scoutTooltip = null;
         rescueTooltip = null;
         secureTooltip = null;
         interceptTooltip = null;
         super.dispose();
      }
   }
}

