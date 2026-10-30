package game.peacefree.interfaces.tileoptionlists
{
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.interfaces.TileOption;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.missions.AbandonMission;
   import game.peacefree.missions.InterceptMission;
   import game.peacefree.missions.InvadeMission;
   import game.peacefree.missions.RescueMission;
   import game.peacefree.missions.SalvageMission;
   import game.peacefree.missions.ScoutMission;
   import game.peacefree.missions.SecureMission;
   
   public class QuickConfirmMissionOptionList extends TileOptionList
   {
      
      public static const TYPE_NONE:int = 0;
      
      public static const TYPE_SCOUT:int = 1;
      
      public static const TYPE_RESCUE:int = 2;
      
      public static const TYPE_SECURE:int = 3;
      
      public static const TYPE_SALVAGE:int = 4;
      
      public static const TYPE_DEMOLISH:int = 5;
      
      public static const TYPE_INTERCEPT:int = 6;
      
      public static const TYPE_ABANDON:int = 7;
      
      public static const TYPE_ABORT:int = 8;
      
      private var type:int = 0;
      
      private var map:Map;
      
      private var minFPPickOption:TileOption;
      
      private var maxFPPickOption:TileOption;
      
      private var minTPPickOption:TileOption;
      
      private var maxTPPickOption:TileOption;
      
      private var minSPPickOption:TileOption;
      
      private var maxSPPickOption:TileOption;
      
      public var cancelOption:TileOption;
      
      private var bMaximizeFP:Boolean = false;
      
      private var bMaximizeTP:Boolean = false;
      
      private var bMaximizeSP:Boolean = false;
      
      public function QuickConfirmMissionOptionList(param1:Map)
      {
         var minFPPickToolip:Tooltip;
         var maxFPPickToolip:Tooltip;
         var minTPPickToolip:Tooltip;
         var maxTPPickToolip:Tooltip;
         var minSPPickToolip:Tooltip;
         var maxSPPickToolip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         minFPPickOption = new TileOption("icon_min_fp","á");
         minFPPickOption.x = 0;
         minFPPickOption.y = 0;
         minFPPickOption.visible = false;
         minFPPickOption.releaseCallback = function():void
         {
            bMaximizeFP = false;
            minFPPickOption.setHint("á");
            maxFPPickOption.setHint("à");
            setMissionType(type);
         };
         addChild(minFPPickOption);
         maxFPPickOption = new TileOption("icon_max_fp","à");
         maxFPPickOption.x = 60;
         maxFPPickOption.y = 0;
         maxFPPickOption.visible = false;
         maxFPPickOption.releaseCallback = function():void
         {
            bMaximizeFP = true;
            minFPPickOption.setHint("à");
            maxFPPickOption.setHint("á");
            setMissionType(type);
         };
         addChild(maxFPPickOption);
         minTPPickOption = new TileOption("icon_min_tp","á");
         minTPPickOption.x = 0;
         minTPPickOption.y = 0;
         minTPPickOption.visible = false;
         minTPPickOption.releaseCallback = function():void
         {
            bMaximizeTP = false;
            minTPPickOption.setHint("á");
            maxTPPickOption.setHint("à");
            setMissionType(type);
         };
         addChild(minTPPickOption);
         maxTPPickOption = new TileOption("icon_max_tp","à");
         maxTPPickOption.x = 60;
         maxTPPickOption.y = 0;
         maxTPPickOption.visible = false;
         maxTPPickOption.releaseCallback = function():void
         {
            bMaximizeTP = true;
            minTPPickOption.setHint("à");
            maxTPPickOption.setHint("á");
            setMissionType(type);
         };
         addChild(maxTPPickOption);
         minSPPickOption = new TileOption("icon_min_sp","á");
         minSPPickOption.x = 0;
         minSPPickOption.y = 0;
         minSPPickOption.visible = false;
         minSPPickOption.releaseCallback = function():void
         {
            bMaximizeSP = false;
            minSPPickOption.setHint("á");
            maxSPPickOption.setHint("à");
            setMissionType(type);
         };
         addChild(minSPPickOption);
         maxSPPickOption = new TileOption("icon_max_sp","à");
         maxSPPickOption.x = 60;
         maxSPPickOption.y = 0;
         maxSPPickOption.visible = false;
         maxSPPickOption.releaseCallback = function():void
         {
            bMaximizeSP = true;
            minSPPickOption.setHint("à");
            maxSPPickOption.setHint("á");
            setMissionType(type);
         };
         addChild(maxSPPickOption);
         cancelOption = new TileOption("icon_cancel");
         cancelOption.x = 120;
         cancelOption.y = 60;
         cancelOption.releaseCallback = function():void
         {
            map.selectTile(null);
            setMissionType(0);
            map.mapHUD.quickMissionInterfacer.show();
            minFPPickOption.visible = false;
            maxFPPickOption.visible = false;
            minTPPickOption.visible = false;
            maxTPPickOption.visible = false;
            minSPPickOption.visible = false;
            maxSPPickOption.visible = false;
         };
         addChild(cancelOption);
         minFPPickToolip = new Tooltip(150,100,"Basic Mission","Spend least Æ needed to complete this mission.");
         minFPPickToolip.x = -192;
         minFPPickToolip.y = 10;
         minFPPickOption.tooltip = minFPPickToolip;
         addChild(minFPPickToolip);
         maxFPPickToolip = new Tooltip(150,100,"Expedite Mission","Spend extra Æ to speed up this mission.");
         maxFPPickToolip.x = -192;
         maxFPPickToolip.y = 10;
         maxFPPickOption.tooltip = maxFPPickToolip;
         addChild(maxFPPickToolip);
         minTPPickToolip = new Tooltip(150,100,"Basic Mission","Spend least Ê needed to complete this mission.");
         minTPPickToolip.x = -192;
         minTPPickToolip.y = 10;
         minTPPickOption.tooltip = minTPPickToolip;
         addChild(minTPPickToolip);
         maxTPPickToolip = new Tooltip(150,100,"Expedite Mission","Spend extra Ê to speed up this mission.");
         maxTPPickToolip.x = -192;
         maxTPPickToolip.y = 10;
         maxTPPickOption.tooltip = maxTPPickToolip;
         addChild(maxTPPickToolip);
         minSPPickToolip = new Tooltip(150,100,"Basic Mission","Spend least Å needed to complete this mission.");
         minSPPickToolip.x = -192;
         minSPPickToolip.y = 10;
         minSPPickOption.tooltip = minSPPickToolip;
         addChild(minSPPickToolip);
         maxSPPickToolip = new Tooltip(150,100,"Expedite Mission","Spend extra Å to speed up this mission.");
         maxSPPickToolip.x = -192;
         maxSPPickToolip.y = 10;
         maxSPPickOption.tooltip = maxSPPickToolip;
         addChild(maxSPPickToolip);
      }
      
      public function setMissionType(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         this.type = param1;
         minFPPickOption.visible = false;
         maxFPPickOption.visible = false;
         minTPPickOption.visible = false;
         maxTPPickOption.visible = false;
         minSPPickOption.visible = false;
         maxSPPickOption.visible = false;
         switch(param1)
         {
            case 0:
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null)
                  {
                     map.tiles[_loc3_].hideTileDetails();
                  }
                  _loc3_++;
               }
               break;
            case 1:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Scout Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select which tiles to scout and gather information from.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null)
                  {
                     if(map.tiles[_loc3_].mission == null && map.tiles[_loc3_].mob == null && !map.tiles[_loc3_].bScouted && map.tiles[_loc3_].isVisible() && map.tiles[_loc3_].bScoutedNearby)
                     {
                        _loc2_ = "Á" + map.tiles[_loc3_].getScoutTime(bMaximizeSP) + ":00\n" + "Å" + map.tiles[_loc3_].getScoutCost(bMaximizeSP);
                        if(map.player.curSearchpower >= map.tiles[_loc3_].getScoutCost(bMaximizeSP))
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,1);
                        }
                        else
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,0.25);
                        }
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
               break;
            case 2:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Rescue Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select which tiles to rescue and recruit É civilians.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null)
                  {
                     if(map.tiles[_loc3_].mission == null && map.tiles[_loc3_].mob == null && map.tiles[_loc3_].bScouted && map.tiles[_loc3_].isVisible() && map.tiles[_loc3_].recruits > 0)
                     {
                        _loc2_ = "Á" + map.tiles[_loc3_].getRescueTime(bMaximizeFP) + ":00\n" + "Æ" + map.tiles[_loc3_].getRescueCost(bMaximizeFP) + "\n" + "É" + " " + map.tiles[_loc3_].recruits;
                        if(map.player.curFirepower >= map.tiles[_loc3_].getRescueCost(bMaximizeFP))
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,1);
                        }
                        else
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,0.25);
                        }
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
               break;
            case 3:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Secure Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select tiles to secure. You will automatically recruit all É civilians found.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null)
                  {
                     if(map.tiles[_loc3_].mission == null && map.tiles[_loc3_].mob == null && !map.tiles[_loc3_].bSecured && map.tiles[_loc3_].bScouted && map.tiles[_loc3_].bSecuredNearby && map.tiles[_loc3_].isVisible())
                     {
                        _loc2_ = "Á" + map.tiles[_loc3_].getSecureTime(bMaximizeFP) + ":00\n" + "Æ" + map.tiles[_loc3_].getSecureCost(bMaximizeFP);
                        if(map.tiles[_loc3_].recruits > 0)
                        {
                           _loc2_ += "\nÉ" + map.tiles[_loc3_].recruits;
                        }
                        if(map.player.curFirepower >= map.tiles[_loc3_].getSecureCost(bMaximizeFP))
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,1);
                        }
                        else
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,0.25);
                        }
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
               break;
            case 4:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Salvage Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select which tiles to salvage and gather food and minerals.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null)
                  {
                     if(map.tiles[_loc3_].mission == null && map.tiles[_loc3_].mob == null && map.tiles[_loc3_].isVisible() && map.tiles[_loc3_].isSalvagable())
                     {
                        _loc2_ = "Á" + map.tiles[_loc3_].getSalvageTime(bMaximizeSP) + ":00\n" + "Å" + map.tiles[_loc3_].getSalvageCost(bMaximizeSP) + "\n";
                        if(map.tiles[_loc3_].food > 0)
                        {
                           _loc2_ += "È" + map.tiles[_loc3_].food;
                        }
                        if(map.tiles[_loc3_].minerals > 0)
                        {
                           if(map.tiles[_loc3_].food > 0)
                           {
                              _loc2_ += " ";
                           }
                           _loc2_ += "Â" + map.tiles[_loc3_].minerals;
                        }
                        if(map.player.curSearchpower >= map.tiles[_loc3_].getSalvageCost(bMaximizeSP))
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,1);
                        }
                        else
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,0.25);
                        }
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
               break;
            case 6:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Intercept Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select which enemies to intercept and destroy.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null && !map.bTDMode)
                  {
                     if(map.tiles[_loc3_].mission == null && map.tiles[_loc3_].mob != null && map.tiles[_loc3_].isVisible() && !map.tiles[_loc3_].mob.bIntercepted && map.tiles[_loc3_].bScoutedNearby || map.tiles[_loc3_].mission != null && map.tiles[_loc3_].mission is InvadeMission && !map.tiles[_loc3_].mob.bIntercepted)
                     {
                        _loc2_ = "Á" + map.tiles[_loc3_].mob.getInterceptTime(bMaximizeFP) + ":00\n" + "Æ" + map.tiles[_loc3_].mob.getInterceptCost(bMaximizeFP) + "\n";
                        if(map.player.curFirepower >= map.tiles[_loc3_].mob.getInterceptCost(bMaximizeFP))
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,1);
                        }
                        else
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,0.25);
                        }
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
               break;
            case 7:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Abandon Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select which tiles you want to leave and abandon.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null && !map.bTDMode)
                  {
                     if(map.tiles[_loc3_].mission == null && map.tiles[_loc3_].bSecured && map.tiles[_loc3_].mapX + map.tiles[_loc3_].mapY * map.mapWidth != map.startPoint)
                     {
                        _loc2_ = "Á" + map.tiles[_loc3_].getAbandonTime(bMaximizeTP) + ":00\n" + "Ê" + map.tiles[_loc3_].getAbandonCost(bMaximizeTP) + "\n";
                        if(map.player.curTechpower >= map.tiles[_loc3_].getAbandonCost(bMaximizeTP))
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,1);
                        }
                        else
                        {
                           map.tiles[_loc3_].showTileDetails(_loc2_,0.25);
                        }
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
               break;
            case 8:
               map.mapHUD.quickMissionInterfacer.tileNameTextField.text = "Quick Abort Mission";
               map.mapHUD.quickMissionInterfacer.tileDescTextField.text = "Select which missions you want to abort.";
               _loc3_ = 0;
               while(_loc3_ < map.tiles.length)
               {
                  if(map.tiles[_loc3_] != null)
                  {
                     if(map.tiles[_loc3_].mission != null)
                     {
                        map.tiles[_loc3_].showTileDetails("Ñ",1);
                     }
                     else
                     {
                        map.tiles[_loc3_].hideTileDetails();
                     }
                  }
                  _loc3_++;
               }
         }
      }
      
      public function startQuickMission(param1:Tile) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         switch(type - 1)
         {
            case 0:
               if(param1.mission == null && !param1.bScouted && param1.isVisible() && param1.bScoutedNearby)
               {
                  _loc2_ = param1.getScoutCost(bMaximizeSP);
                  if(map.player.curSearchpower >= _loc2_)
                  {
                     param1.setMission(new ScoutMission(param1,bMaximizeSP));
                     setMissionType(type);
                  }
               }
               break;
            case 1:
               if(param1.mission == null && param1.bScouted && param1.isVisible() && param1.recruits > 0)
               {
                  _loc2_ = param1.getRescueCost(bMaximizeFP);
                  if(map.player.curFirepower >= _loc2_)
                  {
                     param1.setMission(new RescueMission(param1,bMaximizeFP));
                     setMissionType(type);
                  }
               }
               break;
            case 2:
               if(param1.mission == null && !param1.bSecured && param1.bScouted && param1.bSecuredNearby && param1.isVisible())
               {
                  _loc2_ = param1.getSecureCost(bMaximizeFP);
                  if(map.player.curFirepower >= _loc2_)
                  {
                     param1.setMission(new SecureMission(param1,bMaximizeFP));
                     setMissionType(type);
                  }
               }
               break;
            case 3:
               if(param1.mission == null && param1.isVisible() && param1.isSalvagable())
               {
                  _loc2_ = param1.getSalvageCost(bMaximizeSP);
                  if(map.player.curSearchpower >= _loc2_)
                  {
                     param1.setMission(new SalvageMission(param1,bMaximizeSP));
                     setMissionType(type);
                  }
               }
               break;
            case 5:
               if(!map.bTDMode)
               {
                  if(param1.mission == null && param1.mob != null && param1.isVisible() && !param1.mob.bIntercepted && param1.bScoutedNearby || param1.mission != null && param1.mission is InvadeMission && !param1.mob.bIntercepted)
                  {
                     _loc2_ = param1.mob.getInterceptCost(bMaximizeFP);
                     if(map.player.curFirepower >= _loc2_)
                     {
                        param1.setMission(new InterceptMission(param1,bMaximizeFP));
                        setMissionType(type);
                     }
                  }
               }
               break;
            case 6:
               if(!map.bTDMode)
               {
                  if(param1.mission == null && param1.bSecured && param1.mapX + param1.mapY * map.mapWidth != map.startPoint)
                  {
                     _loc2_ = param1.getAbandonCost(bMaximizeTP);
                     if(map.player.curTechpower >= _loc2_)
                     {
                        param1.setMission(new AbandonMission(param1,bMaximizeTP));
                        setMissionType(type);
                     }
                  }
               }
               break;
            case 7:
               if(param1.mission != null)
               {
                  param1.mission.cancel();
               }
         }
      }
      
      override public function refresh() : void
      {
         setMissionType(type);
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

