package game.peacefree
{
   import flash.geom.Point;
   import game.library.MathLibrary;
   import game.peacefree.effects.InvadeEffect;
   import game.peacefree.effects.TileEffect;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class Tile extends Sprite
   {
      
      public static const INJURED_SYMBOL:String = "À";
      
      public static const CLOCK_SYMBOL:String = "Á";
      
      public static const MINERAL_SYMBOL:String = "Â";
      
      public static const WARNING_SYMBOL:String = "Ã";
      
      public static const VIRPURIS_SYMBOL:String = "Ä";
      
      public static const SEARCHPOWER_SYMBOL:String = "Å";
      
      public static const FIREPOWER_SYMBOL:String = "Æ";
      
      public static const GREEN_TARGET_SYMBOL:String = "Ç";
      
      public static const FOOD_SYMBOL:String = "È";
      
      public static const TROOP_SYMBOL:String = "É";
      
      public static const TECHPOWER_SYMBOL:String = "Ê";
      
      public static const ENERGY_SYMBOL:String = "Ë";
      
      public static const WEAPON_SYMBOL:String = "Ì";
      
      public static const DAY_SYMBOL:String = "Í";
      
      public static const UNKNOWN_SYMBOL:String = "Î";
      
      public static const ITEM_SYMBOL:String = "Ï";
      
      public static const BUILD_SYMBOL:String = "Ð";
      
      public static const ABORTED_SYMBOL:String = "Ñ";
      
      public static const CLOSED_LOG_SYMBOL:String = "Ò";
      
      public static const OPEN_LOG_SYMBOL:String = "Ó";
      
      public static const FX_SYMBOL:String = "Ô";
      
      public static const BGM_SYMBOL:String = "Õ";
      
      public static const SAVE_FILE_SYMBOL:String = "Ö";
      
      public static const DEAD_SYMBOL:String = "×";
      
      public static const HEALTH_SYMBOL:String = "Ø";
      
      public static const INFECTED_SYMBOL:String = "Ù";
      
      public static const ACHIEVEMENT_SYMBOL:String = "Ú";
      
      public static const COPYRIGHT_SYMBOL:String = "Û";
      
      public static const OBJECTIVE_1_SYMBOL:String = "Ü";
      
      public static const OBJECTIVE_2_SYMBOL:String = "Ý";
      
      public static const OBJECTIVE_3_SYMBOL:String = "Þ";
      
      public static const CLOSE_BUTTON_SYMBOL:String = "ß";
      
      public static const EMPTY_CHECKBOX_SYMBOL:String = "à";
      
      public static const FILL_CHECKBOX_SYMBOL:String = "á";
      
      public static const FULLSCREEN_SYMBOL:String = "â";
      
      public static const SEARCH_SYMBOL:String = "ã";
      
      public static const BUILD_ICON_OPT:String = "ä";
      
      public static const SALVAGE_ICON_OPT:String = "å";
      
      public static const SCOUT_ICON_OPT:String = "æ";
      
      public static const SECURE_ICON_OPT:String = "ç";
      
      public static const RESCUE_ICON_OPT:String = "è";
      
      public static const HIGHLIGHT_COLOR:uint = 4293759265;
      
      public static const CELL_HEIGHT:int = 112;
      
      public static const CELL_WIDTH:int = 112;
      
      public static const TILE_EMPTY:int = 0;
      
      public static const TILE_CEMENT:int = 1;
      
      public static const TILE_GRASS_1:int = 2;
      
      public static const TILE_GRASS_2:int = 3;
      
      public static const TILE_GRASS_3:int = 4;
      
      public static const TILE_GRASS_4:int = 5;
      
      public static const TILE_GRASS_5:int = 6;
      
      public static const TILE_GRASS_6:int = 7;
      
      public static const TILE_GRASS_7:int = 8;
      
      public static const TILE_GRASS_8:int = 9;
      
      public static const TILE_GRASS_9:int = 10;
      
      public static const TILE_GRASS_10:int = 11;
      
      public static const TILE_GRASS_11:int = 12;
      
      public static const TILE_GRASS_12:int = 13;
      
      public static const TILE_GRASS_13:int = 14;
      
      public static const TILE_WASTE_1:int = 15;
      
      public static const TILE_WASTE_2:int = 16;
      
      public static const TILE_WASTE_3:int = 17;
      
      public static const TILE_WASTE_4:int = 18;
      
      public static const TILE_WASTE_5:int = 19;
      
      public static const TILE_WASTE_6:int = 20;
      
      public static const TILE_WASTE_7:int = 21;
      
      public static const TILE_WASTE_8:int = 22;
      
      public static const TILE_WASTE_9:int = 23;
      
      public static const TILE_WASTE_10:int = 24;
      
      public static const TILE_WASTE_11:int = 25;
      
      public static const TILE_WASTE_12:int = 26;
      
      public static const TILE_WASTE_13:int = 27;
      
      public static const TILE_WASTE_14:int = 28;
      
      public static const TILE_WASTE_15:int = 29;
      
      public static const TILE_MINERAL:int = 30;
      
      public static const TILE_PAVEMENT:int = 31;
      
      public static const TILE_GRASS_14:int = 32;
      
      public static const TILE_PAVEMENT_2:int = 33;
      
      public static const TILE_WASTE_16:int = 34;
      
      public static const TILE_MINERAL_2:int = 35;
      
      public static const DECOR_NONE:int = 0;
      
      public static const DECOR_STREET:int = 1;
      
      public static const SHADOW_1_COLOR:Number = 3355443;
      
      public static const SHADOW_2_COLOR:Number = 8947848;
      
      public static const SHADOW_3_COLOR:Number = 1118481;
      
      public var map:Map;
      
      public var mapX:int;
      
      public var mapY:int;
      
      public var type:int;
      
      public var decor:int;
      
      public var bSecured:Boolean = false;
      
      public var bScouted:Boolean = false;
      
      public var bScoutedNearby:Boolean = false;
      
      public var bSecuredNearby:Boolean = false;
      
      public var bVisible:Boolean = false;
      
      public var danger:Number = 0;
      
      public var food:int = 0;
      
      public var minerals:int = 0;
      
      public var recruits:int = 0;
      
      public var lockID:int = 0;
      
      public var building:Building = null;
      
      public var mission:Mission = null;
      
      private var dangerGrowthTimeout:int = 0;
      
      public var tileSprite:Image;
      
      public var decorSprite:Image;
      
      public var bottomSprite:Sprite;
      
      public var midSprite:Sprite;
      
      public var topWallEffect:TileEffect;
      
      public var bottomWallEffect:TileEffect;
      
      public var bHighlighted:Boolean = false;
      
      public var tileDetailsTextField:TextField;
      
      public var tileName:String;
      
      public var tileDesc:String;
      
      public var mob:Mob;
      
      private var invadeEffect:InvadeEffect;
      
      public var bRescued:Boolean = false;
      
      private var altStartPoint:Point = null;
      
      public function Tile(param1:Map, param2:int, param3:int, param4:int, param5:int = 0)
      {
         super();
         this.map = param1;
         this.mapX = param2;
         this.mapY = param3;
         this.type = param4;
         this.decor = param5;
         this.x = getCanvasX();
         this.y = getCanvasY();
         if(param4 == 0)
         {
            return;
         }
         food = MathLibrary.randomize(0,60);
         minerals = MathLibrary.randomize(0,60);
         recruits = MathLibrary.randomize(0,4);
         danger = MathLibrary.randomize(5,10);
         if(param4 == 0)
         {
            return;
         }
         bottomSprite = new Sprite();
         addChild(bottomSprite);
         tileSprite = new Image(Assets.getAtlas().getTexture("floor_" + param4));
         tileSprite.y = 125 - tileSprite.height;
         bottomSprite.addChild(tileSprite);
         midSprite = new Sprite();
         addChild(midSprite);
         if(param5 != 0)
         {
            decorSprite = new Image(Assets.getAtlas().getTexture("decor_" + param5));
            decorSprite.touchable = false;
            bottomSprite.addChild(decorSprite);
         }
         tileDetailsTextField = new TextField(112,125,"È 999",Fonts.getDefaultFont().fontName,18,16777215,true);
         tileDetailsTextField.x = getCanvasX();
         tileDetailsTextField.y = getCanvasY() - 20;
         tileDetailsTextField.vAlign = "center";
         tileDetailsTextField.hAlign = "center";
         tileDetailsTextField.touchable = false;
         tileDetailsTextField.autoScale = true;
         refreshColors();
         switch(param4)
         {
            case 0:
               tileName = "Empty";
               tileDesc = "An empty space.";
               break;
            case 1:
               tileName = "Empty Lot";
               tileDesc = "An empty concrete lot. You can build structures here.";
               break;
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 32:
               tileName = "Grassland";
               tileDesc = "A fertile grassy area, perfect for building Hydropods.";
               break;
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 34:
               tileName = "Wasteland";
               tileDesc = "A dusty, barren wasteland. It might still have some resources we can salvage though.";
               break;
            case 30:
            case 35:
               tileName = "Mineral Field";
               tileDesc = "There is a large mineral deposit that we can harvest underneath the hard, rocky surface.";
               break;
            case 31:
            case 33:
               tileName = "Concrete Pavement";
               tileDesc = "A flat area paved with concrete. Mainly used as roads and alleys.";
         }
      }
      
      public function setDecor(param1:int) : void
      {
         if(decorSprite != null)
         {
            decorSprite.removeFromParent(true);
         }
         if(param1 != 0)
         {
            decorSprite = new Image(Assets.getAtlas().getTexture("decor_" + param1));
            decorSprite.touchable = false;
            decorSprite.y = 125 - decorSprite.height;
            bottomSprite.addChild(decorSprite);
         }
      }
      
      public function getCanvasX() : int
      {
         return mapX * 112 / 2 - mapY * 112 / 2;
      }
      
      public function getCanvasY() : int
      {
         return mapX * 112 / 2 + mapY * 112 / 2;
      }
      
      public function setBuilding(param1:Building) : void
      {
         if(param1 == this.building)
         {
            return;
         }
         if(param1 != null)
         {
            removeBuilding();
         }
         this.building = param1;
         param1.x = 0;
         param1.y = 0;
         midSprite.addChildAt(param1,0);
         if(mission != null)
         {
            setMission(mission);
         }
         refreshColors();
      }
      
      public function isVisible() : Boolean
      {
         if(isLocked())
         {
            return false;
         }
         return bVisible || bScoutedNearby || bScouted || bSecured;
      }
      
      public function setIsScouted(param1:Boolean) : void
      {
         this.bScouted = param1;
         refreshColors();
      }
      
      public function setIsScoutedNearby(param1:Boolean) : void
      {
         this.bScoutedNearby = param1;
         refreshColors();
      }
      
      public function secure() : void
      {
         bSecured = true;
         bScouted = true;
         bScoutedNearby = true;
         bVisible = true;
         if(building != null)
         {
            building.gain();
         }
         map.updateTileWalls(this);
         refreshColors();
      }
      
      public function unsecure() : void
      {
         if(building != null && bSecured)
         {
            building.lose();
         }
         bSecured = false;
         map.unsecureTile(this);
         refreshColors();
      }
      
      public function refreshColors() : void
      {
         if(bHighlighted)
         {
            tileSprite.color = 4293759265;
         }
         else if(bSecured)
         {
            tileSprite.color = 16777215;
         }
         else if(bScouted)
         {
            tileSprite.color = 8947848;
         }
         else if(bScoutedNearby)
         {
            tileSprite.color = 3355443;
         }
         else if(isVisible())
         {
            tileSprite.color = 1118481;
         }
         else
         {
            tileSprite.color = 0;
         }
         if(decorSprite !== null)
         {
            decorSprite.color = tileSprite.color;
         }
         if(building != null)
         {
            building.refreshColors();
         }
      }
      
      public function updateTileImageColor(param1:Image) : void
      {
         if(bSecured)
         {
            param1.color = 16777215;
         }
         else if(bScouted)
         {
            param1.color = 8947848;
         }
         else if(bScoutedNearby)
         {
            param1.color = 3355443;
         }
         else
         {
            param1.color = 1118481;
         }
      }
      
      public function progress(param1:int) : void
      {
         if(isLocked())
         {
            return;
         }
         if(mission != null)
         {
            mission.progress(param1);
         }
         if(building != null)
         {
            building.progress(param1);
         }
         if(mob != null && mob.isTrash())
         {
            removeInvadeEffect();
            mob = null;
         }
         if(!bSecured && !map.bTDMode && map.difficulty == 3)
         {
            dangerGrowthTimeout += param1;
            if(dangerGrowthTimeout >= 240000 / 2)
            {
               dangerGrowthTimeout -= 240000 / 2;
               danger += 1;
            }
         }
      }
      
      public function setMission(param1:Mission) : void
      {
         if(this.mission != null)
         {
            map.effectSprite.removeChild(this.mission);
         }
         this.mission = param1;
         if(param1 != null)
         {
            param1.x = getCanvasX();
            param1.y = getCanvasY();
            map.effectSprite.addChild(param1);
         }
         else
         {
            removeInvadeEffect();
         }
      }
      
      public function removeMission() : void
      {
         if(mission != null)
         {
            map.effectSprite.removeChild(mission);
            mission = null;
         }
      }
      
      public function updateWalls() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(!bSecured)
         {
            _loc1_ = null;
            _loc2_ = null;
         }
         else if(map.tiles[mapY * map.mapWidth + mapX - 1] != null && !map.tiles[mapY * map.mapWidth + mapX - 1].bSecured && map.tiles[mapY * map.mapWidth + mapX + 1] != null && !map.tiles[mapY * map.mapWidth + mapX + 1].bSecured && map.tiles[(mapY - 1) * map.mapWidth + mapX] != null && !map.tiles[(mapY - 1) * map.mapWidth + mapX].bSecured && map.tiles[(mapY + 1) * map.mapWidth + mapX] != null && !map.tiles[(mapY + 1) * map.mapWidth + mapX].bSecured)
         {
            _loc1_ = "wall_2";
            _loc2_ = "wall_5";
         }
         else if((map.tiles[mapY * map.mapWidth + mapX - 1] == null || map.tiles[mapY * map.mapWidth + mapX - 1].bSecured) && (map.tiles[mapY * map.mapWidth + mapX + 1] == null || map.tiles[mapY * map.mapWidth + mapX + 1].bSecured) && (map.tiles[(mapY - 1) * map.mapWidth + mapX] == null || map.tiles[(mapY - 1) * map.mapWidth + mapX].bSecured) && (map.tiles[(mapY + 1) * map.mapWidth + mapX] == null || map.tiles[(mapY + 1) * map.mapWidth + mapX].bSecured))
         {
            _loc1_ = null;
            _loc2_ = null;
         }
         else
         {
            if(map.tiles[mapY * map.mapWidth + mapX - 1] != null && !map.tiles[mapY * map.mapWidth + mapX - 1].bSecured)
            {
               if(map.tiles[(mapY - 1) * map.mapWidth + mapX] != null && !map.tiles[(mapY - 1) * map.mapWidth + mapX].bSecured)
               {
                  _loc1_ = "wall_2";
               }
               else
               {
                  _loc1_ = "wall_1";
               }
            }
            else if(map.tiles[(mapY - 1) * map.mapWidth + mapX] != null && !map.tiles[(mapY - 1) * map.mapWidth + mapX].bSecured)
            {
               _loc1_ = "wall_3";
            }
            else
            {
               _loc1_ = null;
            }
            if(map.tiles[(mapY + 1) * map.mapWidth + mapX] != null && !map.tiles[(mapY + 1) * map.mapWidth + mapX].bSecured)
            {
               if(map.tiles[mapY * map.mapWidth + mapX + 1] != null && !map.tiles[mapY * map.mapWidth + mapX + 1].bSecured)
               {
                  if(_loc1_ != null)
                  {
                     _loc2_ = "wall_5";
                  }
                  else
                  {
                     _loc2_ = "wall_8";
                  }
               }
               else if(_loc1_ != null)
               {
                  _loc2_ = "wall_4";
               }
               else
               {
                  _loc2_ = "wall_7";
               }
            }
            else if(map.tiles[mapY * map.mapWidth + mapX + 1] != null && !map.tiles[mapY * map.mapWidth + mapX + 1].bSecured)
            {
               if(_loc1_ != null)
               {
                  _loc2_ = "wall_6";
               }
               else
               {
                  _loc2_ = "wall_9";
               }
            }
            else
            {
               _loc2_ = null;
            }
         }
         if(_loc1_ == null)
         {
            if(topWallEffect != null)
            {
               if(bottomSprite.contains(topWallEffect))
               {
                  bottomSprite.removeChild(topWallEffect);
               }
               topWallEffect.dispose();
               topWallEffect = null;
            }
         }
         else if(topWallEffect == null || topWallEffect.spriteName != _loc1_)
         {
            if(topWallEffect != null)
            {
               if(bottomSprite.contains(topWallEffect))
               {
                  bottomSprite.removeChild(topWallEffect);
               }
               topWallEffect.dispose();
               topWallEffect = null;
            }
            topWallEffect = new TileEffect(this,_loc1_);
            bottomSprite.addChild(topWallEffect);
         }
         if(_loc2_ == null)
         {
            if(bottomWallEffect != null)
            {
               if(midSprite.contains(bottomWallEffect))
               {
                  midSprite.removeChild(bottomWallEffect);
               }
               bottomWallEffect.dispose();
               bottomWallEffect = null;
            }
         }
         else if(bottomWallEffect == null || bottomWallEffect.spriteName != _loc2_)
         {
            if(bottomWallEffect != null)
            {
               if(midSprite.contains(bottomWallEffect))
               {
                  midSprite.removeChild(bottomWallEffect);
               }
               bottomWallEffect.dispose();
               bottomWallEffect = null;
            }
            bottomWallEffect = new TileEffect(this,_loc2_);
            midSprite.addChild(bottomWallEffect);
         }
      }
      
      public function setIsHighlight(param1:Boolean) : void
      {
         this.bHighlighted = param1;
         refreshColors();
         updateFPS();
      }
      
      public function isLocked() : Boolean
      {
         return map.isLocked(lockID);
      }
      
      public function showTileDetails(param1:String, param2:Number = 1) : void
      {
         tileDetailsTextField.text = param1;
         tileDetailsTextField.alpha = param2;
         map.effectSprite.addChild(tileDetailsTextField);
      }
      
      public function hideTileDetails() : void
      {
         if(map.effectSprite.contains(tileDetailsTextField))
         {
            map.effectSprite.removeChild(tileDetailsTextField);
         }
      }
      
      public function isSalvagable() : Boolean
      {
         return bSecured && building == null && (food > 0 || minerals > 0);
      }
      
      public function addFloatText(param1:String) : void
      {
         map.addFloatText(param1,getCanvasX() + 112 / 2,getCanvasY() + 112 / 3);
      }
      
      private function getAltStartPoint() : Point
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(altStartPoint == null)
         {
            _loc4_ = map.startPoint % map.mapWidth;
            _loc1_ = map.startPoint / map.mapWidth;
            _loc5_ = 0;
            while(_loc5_ < map.altStartPoints.length)
            {
               _loc2_ = map.altStartPoints[_loc5_] % map.mapWidth;
               _loc3_ = map.altStartPoints[_loc5_] / map.mapWidth;
               if(MathLibrary.distanceFormula(_loc2_,_loc3_,mapX,mapY) < MathLibrary.distanceFormula(_loc4_,_loc1_,mapX,mapY))
               {
                  _loc4_ = _loc2_;
                  _loc1_ = _loc3_;
               }
               _loc5_++;
            }
            altStartPoint = new Point(_loc4_,_loc1_);
         }
         return altStartPoint;
      }
      
      public function getBaseX() : int
      {
         if(map.altStartPoints != null && map.altStartPoints.length > 0)
         {
            return getAltStartPoint().x;
         }
         return map.startPoint % map.mapWidth;
      }
      
      public function getBaseY() : int
      {
         if(map.altStartPoints != null && map.altStartPoints.length > 0)
         {
            return getAltStartPoint().y;
         }
         return map.startPoint / map.mapWidth;
      }
      
      public function getScoutCost(param1:Boolean) : int
      {
         var _loc3_:int = getBaseX();
         var _loc2_:int = getBaseY();
         var _loc4_:int = Math.ceil(2.5 * MathLibrary.distanceFormula(_loc3_,_loc2_,mapX,mapY));
         if(param1)
         {
            _loc4_ *= 2;
         }
         return _loc4_;
      }
      
      public function getScoutTime(param1:Boolean) : int
      {
         var _loc4_:int = getBaseX();
         var _loc2_:int = getBaseY();
         var _loc3_:int = Math.min(4,Math.ceil(MathLibrary.distanceFormula(_loc4_,_loc2_,mapX,mapY)));
         if(param1)
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      public function getLumberCost(param1:Boolean) : int
      {
         var _loc2_:int = 5;
         if(param1)
         {
            _loc2_ *= 2;
         }
         return _loc2_;
      }
      
      public function getLumberTime(param1:Boolean) : int
      {
         var _loc2_:int = 12;
         if(param1)
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      public function getAbandonCost(param1:Boolean) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = 5;
         }
         return _loc2_;
      }
      
      public function getAbandonTime(param1:Boolean) : int
      {
         var _loc2_:int = 4;
         if(param1)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function getSalvageCost(param1:Boolean) : int
      {
         var _loc3_:int = getBaseX();
         var _loc2_:int = getBaseY();
         var _loc4_:int = 2 + Math.ceil(2 * MathLibrary.distanceFormula(_loc3_,_loc2_,mapX,mapY));
         if(param1)
         {
            _loc4_ *= 2;
         }
         return _loc4_;
      }
      
      public function getSalvageTime(param1:Boolean) : int
      {
         var _loc2_:int = Math.max(1,Math.ceil(Math.max(food,minerals) / 5));
         if(param1)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function getRescueCost(param1:Boolean) : int
      {
         var _loc3_:int = getBaseX();
         var _loc2_:int = getBaseY();
         var _loc4_:int = Math.ceil(1 + danger / 3) + Math.ceil(MathLibrary.distanceFormula(_loc3_,_loc2_,mapX,mapY));
         if(param1)
         {
            _loc4_ *= 2;
         }
         return _loc4_;
      }
      
      public function getRescueTime(param1:Boolean) : int
      {
         var _loc2_:int = recruits * 1.5 + Math.ceil(danger / 10);
         if(param1)
         {
            _loc2_ = Math.max(1,_loc2_ / 4);
         }
         return _loc2_;
      }
      
      public function getSecureCost(param1:Boolean) : int
      {
         var _loc3_:int = getBaseX();
         var _loc2_:int = getBaseY();
         var _loc4_:int = Math.ceil(1 + danger / 2) + Math.ceil(MathLibrary.distanceFormula(_loc3_,_loc2_,mapX,mapY));
         if(param1)
         {
            _loc4_ *= 2;
         }
         return _loc4_;
      }
      
      public function getSecureTime(param1:Boolean) : int
      {
         var _loc4_:int = getBaseX();
         var _loc2_:int = getBaseY();
         var _loc3_:int = Math.ceil(MathLibrary.distanceFormula(_loc4_,_loc2_,mapX,mapY)) + danger / 8;
         if(param1)
         {
            _loc3_ = Math.max(1,_loc3_ / 4);
         }
         return Math.max(1,_loc3_);
      }
      
      public function updateFPS() : void
      {
         if(building != null)
         {
            building.updateFPS();
         }
         if(mission != null)
         {
            mission.updateFPS();
         }
         if(invadeEffect != null)
         {
            invadeEffect.updateFPS();
         }
      }
      
      public function addInvadeEffect() : void
      {
         invadeEffect = new InvadeEffect(this);
         midSprite.addChild(invadeEffect);
         invadeEffect.updateFPS();
      }
      
      public function removeInvadeEffect() : void
      {
         if(invadeEffect != null)
         {
            invadeEffect.removeFromParent(true);
            invadeEffect = null;
         }
      }
      
      public function removeBuilding() : void
      {
         if(building != null)
         {
            if(bSecured)
            {
               building.lose();
            }
            building.removeFromParent(true);
            building = null;
         }
      }
      
      public function getData() : String
      {
         var _loc1_:String = "";
         _loc1_ += type;
         if(building != null)
         {
            _loc1_ += ":" + building.type;
         }
         else
         {
            _loc1_ += ":";
         }
         if(decor != 0)
         {
            _loc1_ += ":" + decor;
         }
         else
         {
            _loc1_ += ":";
         }
         _loc1_ += ":" + danger;
         _loc1_ += ":" + food;
         _loc1_ += ":" + minerals;
         _loc1_ += ":" + recruits;
         _loc1_ += ":" + lockID;
         _loc1_ += ":" + (bSecured ? "1" : "0");
         _loc1_ += ":" + (bScouted ? "1" : "0");
         _loc1_ += ":" + (bScoutedNearby ? "1" : "0");
         _loc1_ += ":" + (bSecuredNearby ? "1" : "0");
         _loc1_ += ":" + (bRescued ? "1" : "0");
         return _loc1_ + (":" + (bVisible ? "1" : "0"));
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         building = null;
         mission = null;
         tileSprite = null;
         decorSprite = null;
         bottomSprite = null;
         midSprite = null;
         topWallEffect = null;
         bottomWallEffect = null;
         tileDetailsTextField = null;
         tileName = null;
         tileDesc = null;
         mob = null;
         invadeEffect = null;
         altStartPoint = null;
         super.dispose();
      }
   }
}

