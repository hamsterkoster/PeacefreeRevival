package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Map;
   import game.peacefree.interfaces.BigTileOption;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   
   public class ConfirmMissionOptionList extends TileOptionList
   {
      
      public static const TYPE_FIREPOWER:int = 1;
      
      public static const TYPE_TECHPOWER:int = 2;
      
      public static const TYPE_SEARCHPOWER:int = 3;
      
      private var map:Map;
      
      private var minFPPickOption:BigTileOption;
      
      private var maxFPPickOption:BigTileOption;
      
      private var minTPPickOption:BigTileOption;
      
      private var maxTPPickOption:BigTileOption;
      
      private var minSPPickOption:BigTileOption;
      
      private var maxSPPickOption:BigTileOption;
      
      private var cancelOption:TileOption;
      
      private var minCost:int = 0;
      
      private var maxCost:int = 0;
      
      private var type:int = 1;
      
      public function ConfirmMissionOptionList(param1:Map)
      {
         super();
         this.map = param1;
         minFPPickOption = new BigTileOption("icon_min_fp","");
         minFPPickOption.x = 0;
         minFPPickOption.y = 0;
         minFPPickOption.visible = false;
         addChild(minFPPickOption);
         maxFPPickOption = new BigTileOption("icon_max_fp","");
         maxFPPickOption.x = 110;
         maxFPPickOption.y = 0;
         maxFPPickOption.visible = false;
         addChild(maxFPPickOption);
         minTPPickOption = new BigTileOption("icon_min_tp","");
         minTPPickOption.x = 0;
         minTPPickOption.y = 0;
         minTPPickOption.visible = false;
         addChild(minTPPickOption);
         maxTPPickOption = new BigTileOption("icon_max_tp","");
         maxTPPickOption.x = 110;
         maxTPPickOption.y = 0;
         maxTPPickOption.visible = false;
         addChild(maxTPPickOption);
         minSPPickOption = new BigTileOption("icon_min_sp","");
         minSPPickOption.x = 0;
         minSPPickOption.y = 0;
         minSPPickOption.visible = false;
         addChild(minSPPickOption);
         maxSPPickOption = new BigTileOption("icon_max_sp","");
         maxSPPickOption.x = 110;
         maxSPPickOption.y = 0;
         maxSPPickOption.visible = false;
         addChild(maxSPPickOption);
         cancelOption = new TileOption("icon_cancel");
         cancelOption.x = 180;
         cancelOption.y = 60;
         addChild(cancelOption);
         var _loc2_:Tooltip = new Tooltip(170,100,"[1] Basic Mission","Spend lowest Æ needed to complete this mission.");
         _loc2_.x = -202;
         _loc2_.y = 10;
         minFPPickOption.tooltip = _loc2_;
         addChild(_loc2_);
         var _loc6_:Tooltip = new Tooltip(170,100,"[2] Expedite Mission","Spend extra Æ to complete this mission faster.");
         _loc6_.x = -202;
         _loc6_.y = 10;
         maxFPPickOption.tooltip = _loc6_;
         addChild(_loc6_);
         var _loc7_:Tooltip = new Tooltip(170,100,"[1] Basic Mission","Spend lowest Ê needed to complete this mission.");
         _loc7_.x = -202;
         _loc7_.y = 10;
         minTPPickOption.tooltip = _loc7_;
         addChild(_loc7_);
         var _loc3_:Tooltip = new Tooltip(170,100,"[2] Expedite Mission","Spend extra Ê to complete this mission faster.");
         _loc3_.x = -202;
         _loc3_.y = 10;
         maxTPPickOption.tooltip = _loc3_;
         addChild(_loc3_);
         var _loc5_:Tooltip = new Tooltip(170,100,"[1] Basic Mission","Spend lowest Å needed to complete this mission.");
         _loc5_.x = -202;
         _loc5_.y = 10;
         minSPPickOption.tooltip = _loc5_;
         addChild(_loc5_);
         var _loc4_:Tooltip = new Tooltip(170,100,"[2] Expedite Mission","Spend extra Å to complete this mission faster.");
         _loc4_.x = -202;
         _loc4_.y = 10;
         maxSPPickOption.tooltip = _loc4_;
         addChild(_loc4_);
      }
      
      public function setValues(param1:int, param2:int, param3:int, param4:Function, param5:int, param6:int, param7:Function, param8:Function, param9:String = null) : void
      {
         this.minCost = param3;
         this.maxCost = param6;
         this.type = param1;
         minFPPickOption.visible = false;
         maxFPPickOption.visible = false;
         minTPPickOption.visible = false;
         maxTPPickOption.visible = false;
         minSPPickOption.visible = false;
         maxSPPickOption.visible = false;
         switch(param1 - 1)
         {
            case 0:
               minFPPickOption.visible = true;
               minFPPickOption.setHint("Á " + param2 + "\n" + "Æ" + param3);
               minFPPickOption.releaseCallback = param4;
               maxFPPickOption.visible = true;
               maxFPPickOption.setHint("Á " + param5 + "\n" + "Æ" + param6);
               maxFPPickOption.releaseCallback = param7;
               minFPPickOption.setIsEnabled(map.player.curFirepower >= param3);
               maxFPPickOption.setIsEnabled(map.player.curFirepower >= param6);
               map.mapHUD.num1Callback = minFPPickOption;
               map.mapHUD.num2Callback = maxFPPickOption;
               break;
            case 1:
               minTPPickOption.visible = true;
               minTPPickOption.setHint("Á " + param2 + "\n" + "Ê" + param3);
               minTPPickOption.releaseCallback = param4;
               maxTPPickOption.visible = true;
               maxTPPickOption.setHint("Á " + param5 + "\n" + "Ê" + param6);
               maxTPPickOption.releaseCallback = param7;
               minTPPickOption.setIsEnabled(map.player.curTechpower >= param3);
               maxTPPickOption.setIsEnabled(map.player.curTechpower >= param6);
               map.mapHUD.num1Callback = minTPPickOption;
               map.mapHUD.num2Callback = maxTPPickOption;
               break;
            case 2:
               minSPPickOption.visible = true;
               minSPPickOption.setHint("Á " + param2 + "\n" + "Å" + param3);
               minSPPickOption.releaseCallback = param4;
               maxSPPickOption.visible = true;
               maxSPPickOption.setHint("Á " + param5 + "\n" + "Å" + param6);
               maxSPPickOption.releaseCallback = param7;
               minSPPickOption.setIsEnabled(map.player.curSearchpower >= param3);
               maxSPPickOption.setIsEnabled(map.player.curSearchpower >= param6);
               map.mapHUD.num1Callback = minSPPickOption;
               map.mapHUD.num2Callback = maxSPPickOption;
         }
         cancelOption.releaseCallback = param8;
         map.mapHUD.num8Callback = cancelOption;
         if(param9 != null)
         {
            map.mapHUD.tileNameTextField.text = param9;
         }
      }
      
      override public function refresh() : void
      {
         minFPPickOption.setIsEnabled(map.player.curFirepower >= minCost);
         maxFPPickOption.setIsEnabled(map.player.curFirepower >= maxCost);
         minTPPickOption.setIsEnabled(map.player.curTechpower >= minCost);
         maxTPPickOption.setIsEnabled(map.player.curTechpower >= maxCost);
         minSPPickOption.setIsEnabled(map.player.curSearchpower >= minCost);
         maxSPPickOption.setIsEnabled(map.player.curSearchpower >= maxCost);
         switch(type - 1)
         {
            case 0:
               map.mapHUD.num1Callback = minFPPickOption;
               map.mapHUD.num2Callback = maxFPPickOption;
               break;
            case 1:
               map.mapHUD.num1Callback = minTPPickOption;
               map.mapHUD.num2Callback = maxTPPickOption;
               break;
            case 2:
               map.mapHUD.num1Callback = minSPPickOption;
               map.mapHUD.num2Callback = maxSPPickOption;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         minFPPickOption = null;
         maxFPPickOption = null;
         minTPPickOption = null;
         maxTPPickOption = null;
         minSPPickOption = null;
         maxSPPickOption = null;
         cancelOption = null;
         super.dispose();
      }
   }
}

