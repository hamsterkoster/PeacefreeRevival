package game.peacefree
{
   import flash.geom.Point;
   import game.library.MathLibrary;
   import game.library.SoundLibrary;
   import game.peacefree.effects.ChargeParticleEffect;
   import game.peacefree.effects.ExplosionEffect;
   import game.peacefree.effects.PoisonEffect;
   import game.peacefree.effects.PoofEffect;
   import game.peacefree.effects.SparkEffect;
   import game.peacefree.missions.InterceptMission;
   import game.peacefree.missions.InvadeMission;
   import game.peacefree.mobs.GiasRobo;
   import game.peacefree.mobs.GiasRoboHand;
   import game.peacefree.mobs.Jenygrin;
   import game.peacefree.mobs.NilHelios;
   import game.peacefree.mobs.RougeEmpress;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class Mob extends Sprite
   {
      
      public static const DIRECTION_SW:int = 0;
      
      public static const DIRECTION_NW:int = 1;
      
      public static const DIRECTION_NE:int = 2;
      
      public static const DIRECTION_SE:int = 3;
      
      public static const DIRECTION_BASE:int = 4;
      
      public static const DIRECTION_WAYPOINT:int = 5;
      
      public static const DIRECTION_SEEK:int = 6;
      
      public static const DIRECTION_ACTION:int = 7;
      
      public static const DIRECTION_WAIT:int = 8;
      
      public static const MOB_BIOSHIP:int = 1;
      
      public static const MOB_HIVESHIP:int = 2;
      
      public static const MOB_VIROSAUCER:int = 3;
      
      public static const MOB_R_FRAT_FRAT:int = 4;
      
      public static const MOB_G_FRAT_FRAT:int = 5;
      
      public static const MOB_B_FRAT_FRAT:int = 6;
      
      public static const MOB_BIG_R_FRAT_FRAT:int = 7;
      
      public static const MOB_BIG_G_FRAT_FRAT:int = 8;
      
      public static const MOB_BIG_B_FRAT_FRAT:int = 9;
      
      public static const MOB_GOLD_FRAT_FRAT:int = 10;
      
      public static const MOB_NIL_HELIOS:int = 11;
      
      public static const MOB_SLYTHE:int = 12;
      
      public static const MOB_XKRILL:int = 13;
      
      public static const MOB_ROBOID:int = 14;
      
      public static const MOB_VEROBERUS:int = 15;
      
      public static const MOB_VX9600:int = 16;
      
      public static const MOB_HORNET:int = 17;
      
      public static const MOB_BLUE_HORNET:int = 18;
      
      public static const MOB_RED_HORNET:int = 19;
      
      public static const MOB_WHITE_HORNET:int = 20;
      
      public static const MOB_ROUGE_EMPRESS:int = 21;
      
      public static const MOB_JENYGRIN:int = 22;
      
      public static const MOB_GIAS:int = 23;
      
      public static const MOB_GIAS_LEFT_HAND:int = 24;
      
      public static const MOB_GIAS_RIGHT_HAND:int = 25;
      
      public static const WAYPOINT_SEEK:int = -1;
      
      public static const WAYPOINT_ACTION:int = -2;
      
      public static const WAYPOINT_RESET:int = -3;
      
      public var health:int;
      
      public var type:int;
      
      public var tile:Tile;
      
      public var nextTile:Tile = null;
      
      protected var sprites:Array;
      
      protected var direction:int = 0;
      
      protected var position:Point = new Point(-100,-100);
      
      protected var moveCounter:int = 0;
      
      protected var maxMoveCounter:int = 3000;
      
      protected var waitCounter:int = 0;
      
      protected var cyclePos:int = 0;
      
      protected var waypointPos:int = 0;
      
      public var cycle:Array = new Array(6,6,6,7);
      
      public var waypoints:Array = null;
      
      protected var shadowSprite:Image = null;
      
      protected var shipSprite:Sprite = null;
      
      private var bTrash:Boolean = false;
      
      protected var bDying:Boolean = false;
      
      public var bIntercepted:Boolean = false;
      
      protected var zapSprite:MovieClip = null;
      
      protected var jamSprite:MovieClip = null;
      
      public var zapCounter:int = 0;
      
      public var noxCounter:int = 0;
      
      public var noxPower:Number = 0;
      
      protected var actionCounter:int = 0;
      
      protected var chargeCounter:int = 0;
      
      protected var extraCounter:int = 0;
      
      protected var poisonGasCounter:int = 0;
      
      protected var maxPoisonGasCounter:int = 1000;
      
      protected var mobFPS:int = 12;
      
      public var missionObjID:int = 0;
      
      public function Mob(param1:Tile, param2:int, param3:Boolean = false)
      {
         super();
         this.tile = param1;
         this.type = param2;
         init();
      }
      
      public static function getName(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return "Virpuris Tusk";
            case 2:
               return "Virpuris Hiveship";
            case 3:
               return "Virpuris Virosaucer";
            case 4:
               return "Red Frat-frat";
            case 5:
               return "Green Frat-frat";
            case 6:
               return "Blue Frat-frat";
            case 7:
               return "Big Red Frat-frat";
            case 8:
               return "Big Green Frat-frat";
            case 9:
               return "Big Blue Frat-frat";
            case 10:
               return "Big Gold Frat-frat";
            case 11:
               return "Black Nil Helios";
            case 12:
               return "Virpuris Slythe";
            case 13:
               return "Virpuris Xkrill";
            case 16:
               return "VX9600 Prototype";
            case 15:
               return "Veroberus";
            case 14:
               return "Roboid";
            case 17:
               return "Giant Hornet";
            case 18:
               return "Steel Hornet";
            case 19:
               return "Crimson Hornet";
            case 20:
               return "White Hornet";
            case 22:
               return "Jenygrin";
            case 23:
               return "Gias Robo";
            case 25:
               return "Gias Robo Right Hand";
            case 24:
               return "Gias Robo Left Hand";
            default:
               return "Unknown";
         }
      }
      
      public static function getWaitTime(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 240000 / 12;
            case 2:
               return 240000 / 10;
            case 3:
               return 240000 / 8;
            case 4:
               return 240000 / 24;
            case 5:
               return 240000 / 16;
            case 6:
               return 240000 / 50;
            case 7:
               return 240000 / 36;
            case 8:
               return 240000 / 24;
            case 9:
               return 240000 / 70;
            case 10:
               return 240000 / 90;
            case 11:
               return 240000 / 10;
            case 12:
               return 240000 / 12;
            case 13:
               return 240000 / 12;
            case 16:
               return 240000 / 12;
            case 15:
               return 240000 / 12;
            case 14:
               return 240000 / 36;
            case 17:
               return 240000 / 20;
            case 18:
               return 240000 / 18;
            case 19:
               return 240000 / 18;
            case 20:
               return 240000 / 24;
            case 22:
               return 240000 / 8;
            case 23:
               return 240000 / 16;
            case 24:
            case 25:
               break;
            default:
               return 240000 / 24;
         }
         return 240000 / 24;
      }
      
      public static function getInvadeHours(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 8;
            case 2:
               return 4;
            case 3:
               return 12;
            case 11:
               return 4;
            case 12:
               return 12;
            case 13:
               return 24;
            case 16:
               return 4;
            case 15:
               return 4;
            case 14:
               return 12;
            case 17:
               return 12;
            case 18:
               return 8;
            case 19:
               return 7;
            case 20:
               return 4;
            default:
               return 6;
         }
      }
      
      public static function getHealth(param1:Map, param2:int) : int
      {
         var _loc3_:int = 10;
         switch(param2)
         {
            case 1:
               _loc3_ = 25;
               break;
            case 2:
               _loc3_ = 250;
               break;
            case 3:
               _loc3_ = 80;
               break;
            case 4:
               _loc3_ = 15;
               break;
            case 5:
               _loc3_ = 35;
               break;
            case 6:
               _loc3_ = 20;
               break;
            case 7:
               _loc3_ = 300;
               break;
            case 8:
               _loc3_ = 600;
               break;
            case 9:
               _loc3_ = 400;
               break;
            case 10:
               _loc3_ = 1000;
               break;
            case 11:
               _loc3_ = 500;
               break;
            case 12:
               _loc3_ = 25;
               break;
            case 13:
               _loc3_ = 6;
               break;
            case 16:
               _loc3_ = 2000;
               break;
            case 15:
               _loc3_ = 500;
               break;
            case 14:
               _loc3_ = 1;
               break;
            case 17:
               _loc3_ = 18;
               break;
            case 18:
               _loc3_ = 60;
               break;
            case 19:
               _loc3_ = 100;
               break;
            case 20:
               _loc3_ = 160;
               break;
            case 21:
               _loc3_ = 600;
               break;
            case 22:
               _loc3_ = 200;
               break;
            case 23:
               _loc3_ = 500;
               break;
            case 24:
            case 25:
               _loc3_ = 300;
         }
         if(param1.difficulty == 0)
         {
            _loc3_ = Math.ceil(_loc3_ / 5);
         }
         else if(param1.difficulty == 2)
         {
            _loc3_ += _loc3_ / 4;
         }
         else if(param1.difficulty == 3)
         {
            _loc3_ *= 2;
         }
         return _loc3_;
      }
      
      public static function getDanger(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 10;
            case 2:
               return 50;
            case 3:
               return 35;
            case 11:
               return 65;
            case 12:
               return 25;
            case 13:
               return 5;
            case 16:
               return 75;
            case 15:
               return 100;
            case 17:
               return 20;
            case 18:
               return 30;
            case 19:
               return 40;
            case 20:
               return 50;
            default:
               return 0;
         }
      }
      
      public static function generate(param1:Map, param2:String) : Mob
      {
         var _loc6_:Mob = null;
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc8_:Array = param2.split(":");
         var _loc3_:Tile = param1.tiles[int(_loc8_[1]) + int(_loc8_[2]) * param1.mapWidth];
         switch(int(_loc8_[0]) - 11)
         {
            case 0:
               _loc6_ = new NilHelios(_loc3_);
               break;
            case 10:
               _loc6_ = new RougeEmpress(_loc3_);
               break;
            case 11:
               _loc6_ = new Jenygrin(_loc3_,int(_loc8_[15]));
               break;
            case 12:
               _loc6_ = new GiasRobo(_loc3_);
               break;
            case 13:
               _loc6_ = new GiasRoboHand(_loc3_,24);
               break;
            case 14:
               _loc6_ = new GiasRoboHand(_loc3_,25);
               break;
            default:
               _loc6_ = new Mob(_loc3_,int(_loc8_[0]));
         }
         _loc6_.tile = _loc3_;
         _loc6_.tile.mob = _loc6_;
         if(int(_loc8_[3] > 0))
         {
            _loc6_.health = int(_loc8_[3]);
         }
         _loc6_.waitCounter = int(_loc8_[4]);
         _loc6_.zapCounter = int(_loc8_[5]);
         _loc6_.noxPower = Number(_loc8_[6]);
         _loc6_.noxCounter = int(_loc8_[7]);
         _loc6_.missionObjID = int(_loc8_[8]);
         _loc6_.bIntercepted = int(_loc8_[9]) > 0;
         _loc6_.cyclePos = int(_loc8_[10]);
         _loc6_.waypointPos = int(_loc8_[11]);
         _loc6_.cycle = [];
         _loc6_.waypoints = null;
         var _loc4_:Array = _loc8_[12].split(",");
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc6_.cycle.push(int(_loc4_[_loc7_]));
            _loc7_++;
         }
         if(_loc8_[13] != "-1")
         {
            _loc6_.waypoints = [];
            _loc5_ = _loc8_[13].split(",");
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc6_.waypoints.push(int(_loc5_[_loc7_]));
               _loc7_++;
            }
         }
         _loc6_.actionCounter = int(_loc8_[14]);
         _loc6_.extraCounter = int(_loc8_[15]);
         return _loc6_;
      }
      
      protected function init() : void
      {
         var _loc1_:int = 0;
         sprites = new Array(4);
         if(type == 3 || type == 11 || type == 16)
         {
            sprites[0] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_"));
            sprites[1] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_"));
            sprites[2] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_"));
            sprites[3] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_"));
         }
         else if(type == 17 || type == 18 || type == 19 || type == 20)
         {
            sprites[0] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 0 + "_"));
            sprites[1] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 0 + "_"));
            sprites[2] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 2 + "_"));
            sprites[3] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 2 + "_"));
         }
         else
         {
            sprites[0] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 0 + "_"));
            sprites[1] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 1 + "_"));
            sprites[2] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 2 + "_"));
            sprites[3] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 3 + "_"));
         }
         shadowSprite = new Image(Assets.getAtlas().getTexture("effect_shadow"));
         shadowSprite.alpha = 0.3;
         addChild(shadowSprite);
         health = getHealth(tile.map,type);
         x = tile.getCanvasX();
         y = tile.getCanvasY();
         position.x = x;
         position.y = y;
         shipSprite = new Sprite();
         addChild(shipSprite);
         tile.mob = this;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            sprites[_loc1_].x = 112 / 2 - sprites[_loc1_].width / 2;
            sprites[_loc1_].y = getFloat();
            _loc1_++;
         }
         shipSprite.addChild(sprites[direction]);
         Starling.juggler.add(sprites[direction]);
         mobFPS = 6;
         switch(type - 17)
         {
            case 0:
            case 1:
            case 2:
            case 3:
               mobFPS = 12;
         }
         updateFPS();
      }
      
      public function progress(param1:int) : void
      {
         var _loc6_:Map = null;
         var _loc7_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         if(isTrash() || isDying())
         {
            return;
         }
         try
         {
            _loc6_ = tile.map;
            if(health < 1)
            {
               die();
               return;
            }
            if(tile.mob == null)
            {
               tile.mob = this;
            }
            if(moveCounter > 0)
            {
               position.x = tile.getCanvasX();
               position.y = tile.getCanvasY();
               switch(direction)
               {
                  case 0:
                     position.x -= moveCounter / maxMoveCounter * 112 / 2;
                     position.y += moveCounter / maxMoveCounter * 112 / 2;
                     break;
                  case 1:
                     position.x -= moveCounter / maxMoveCounter * 112 / 2;
                     position.y -= moveCounter / maxMoveCounter * 112 / 2;
                     break;
                  case 2:
                     position.x += moveCounter / maxMoveCounter * 112 / 2;
                     position.y -= moveCounter / maxMoveCounter * 112 / 2;
                     break;
                  case 3:
                     position.x += moveCounter / maxMoveCounter * 112 / 2;
                     position.y += moveCounter / maxMoveCounter * 112 / 2;
               }
               x = position.x;
               y = position.y;
            }
            if(zapCounter > 0)
            {
               if(zapSprite == null && jamSprite == null)
               {
                  zap(zapCounter);
               }
               zapCounter -= param1;
               if(zapCounter > 0)
               {
                  return;
               }
               if(zapSprite != null)
               {
                  zapSprite.stop();
                  zapSprite.removeFromParent(true);
                  zapSprite = null;
               }
               if(jamSprite != null)
               {
                  jamSprite.stop();
                  jamSprite.removeFromParent(true);
                  jamSprite = null;
               }
               zapCounter = 0;
            }
            if(noxCounter > 0)
            {
               noxCounter -= param1;
               if(noxCounter > 0)
               {
                  param1 *= 1 - noxPower;
               }
               else
               {
                  noxCounter = 0;
               }
               refreshColors();
            }
            if(tile.mission != null)
            {
               if(tile.mission is InvadeMission || tile.mission is InterceptMission)
               {
                  if(tile.mission is InvadeMission && (type == 3 || type == 16))
                  {
                     if(tile.isVisible())
                     {
                        poisonGasCounter += param1;
                        if(poisonGasCounter >= maxPoisonGasCounter)
                        {
                           poisonGasCounter -= maxPoisonGasCounter;
                           _loc6_.effectSprite.addChildAt(new PoisonEffect(_loc6_,position.x,position.y),0);
                        }
                     }
                  }
                  return;
               }
               SoundLibrary.playSFX("alarm");
               _loc6_.mapHUD.logInterfacer.addLogEntry(tile,"Ä Mission compromised!");
               tile.mission.cancel();
            }
            if(tile.bSecured)
            {
               tile.setMission(new InvadeMission(this,tile));
               SoundLibrary.playSFX("alarm");
               _loc6_.mapHUD.logInterfacer.addLogEntry(tile,"Ä Enemy alert!");
               return;
            }
            if(actionCounter > 0)
            {
               if(tile.bVisible || tile.bScoutedNearby)
               {
                  chargeCounter += param1;
                  if(chargeCounter >= 750)
                  {
                     chargeCounter -= 750;
                     makeChargeParticle();
                  }
               }
               actionCounter -= param1;
               if(actionCounter > 0)
               {
                  return;
               }
               performAction();
               param1 += actionCounter;
            }
            else if(waitCounter > 0)
            {
               waitCounter -= param1;
               if(waitCounter > 0)
               {
                  return;
               }
               param1 += waitCounter;
            }
            if(nextTile != null)
            {
               if(tile != nextTile)
               {
                  moveCounter += param1;
                  if(moveCounter >= maxMoveCounter)
                  {
                     if(_loc6_.mapHUD.lastTile == tile)
                     {
                        _loc6_.mapHUD.setSelectedTile(null);
                     }
                     tile.mob = null;
                     tile = nextTile;
                     nextTile = null;
                     moveCounter = 0;
                     waitCounter = getWaitTime(type);
                     if(tile.map.difficulty == 0)
                     {
                        waitCounter *= 2;
                     }
                     return;
                  }
               }
               else
               {
                  nextTile = null;
               }
            }
            if(nextTile == null && cycle.length > 0)
            {
               direction = cycle[cyclePos];
               if(direction == 8)
               {
                  direction = 0;
                  return;
               }
               if(direction == 6)
               {
                  if(tile.mapX + (tile.mapY - 1) * _loc6_.mapWidth > 0 && Boolean(Tile(_loc6_.tiles[tile.mapX + (tile.mapY - 1) * _loc6_.mapWidth]).bSecured) && (type == 16 || type == 23 || MathLibrary.randomize(0,100) < 50))
                  {
                     direction = 2;
                  }
                  else if(tile.mapX - 1 + tile.mapY * _loc6_.mapWidth > 0 && Boolean(Tile(_loc6_.tiles[tile.mapX - 1 + tile.mapY * _loc6_.mapWidth]).bSecured) && (type == 16 || type == 23 || MathLibrary.randomize(0,100) < 50))
                  {
                     direction = 1;
                  }
                  else if(tile.mapX + 1 + tile.mapY * _loc6_.mapWidth < _loc6_.tiles.length && Boolean(Tile(_loc6_.tiles[tile.mapX + 1 + tile.mapY * _loc6_.mapWidth]).bSecured) && (type == 16 || type == 23 || MathLibrary.randomize(0,100) < 50))
                  {
                     direction = 3;
                  }
                  else if(tile.mapX + (tile.mapY + 1) * _loc6_.mapWidth < _loc6_.tiles.length && Boolean(Tile(_loc6_.tiles[tile.mapX + (tile.mapY + 1) * _loc6_.mapWidth]).bSecured) && (type == 16 || type == 23 || MathLibrary.randomize(0,100) < 50))
                  {
                     direction = 0;
                  }
                  else if(waypoints != null)
                  {
                     direction = 5;
                  }
                  else
                  {
                     direction = 4;
                  }
               }
               _loc7_ = false;
               if(direction == 4 || direction == 5)
               {
                  _loc5_ = _loc6_.startPoint;
                  _loc7_ = true;
                  if(direction == 5)
                  {
                     if(waypoints != null && waypoints.length > 0)
                     {
                        while(waypoints[waypointPos] == tile.mapX + tile.mapY * _loc6_.mapWidth)
                        {
                           waypointPos = waypointPos + 1;
                        }
                        if(waypointPos >= waypoints.length)
                        {
                           if(tile.map.act != null)
                           {
                              tile.map.act.onEscaped();
                           }
                           trash();
                           return;
                        }
                        _loc5_ = int(waypoints[waypointPos]);
                     }
                  }
                  if(_loc5_ == -3)
                  {
                     waypointPos = 0;
                     _loc5_ = int(waypoints[waypointPos]);
                  }
                  if(_loc5_ == -1)
                  {
                     waypoints = null;
                     cycle = new Array(6,6);
                  }
                  else if(_loc5_ == -2)
                  {
                     initAction();
                     waypoints.shift();
                  }
                  else
                  {
                     _loc2_ = _loc5_ % _loc6_.mapWidth;
                     _loc3_ = _loc5_ / _loc6_.mapWidth;
                     _loc4_ = Math.abs(tile.mapX - _loc2_);
                     _loc8_ = Math.abs(tile.mapY - _loc3_);
                     if(_loc4_ > _loc8_)
                     {
                        if(tile.mapX < _loc2_)
                        {
                           direction = 3;
                        }
                        else
                        {
                           direction = 1;
                        }
                     }
                     else if(tile.mapY < _loc3_)
                     {
                        direction = 0;
                     }
                     else
                     {
                        direction = 2;
                     }
                  }
               }
               switch(direction)
               {
                  case 0:
                     nextTile = _loc6_.getTile(tile.mapX,tile.mapY + 1);
                     break;
                  case 1:
                     nextTile = _loc6_.getTile(tile.mapX - 1,tile.mapY);
                     break;
                  case 2:
                     nextTile = _loc6_.getTile(tile.mapX,tile.mapY - 1);
                     break;
                  case 3:
                     nextTile = _loc6_.getTile(tile.mapX + 1,tile.mapY);
               }
               if(direction == 7)
               {
                  initAction();
                  direction = 0;
                  nextTile = null;
                  cyclePos = (cyclePos + 1) % cycle.length;
               }
               else if(_loc6_.bTDMode)
               {
                  if(nextTile != null && !nextTile.bSecured)
                  {
                     nextTile.mob = this;
                     cyclePos = (cyclePos + 1) % cycle.length;
                  }
                  else
                  {
                     nextTile = null;
                  }
               }
               else if(nextTile != null && nextTile.mob == null)
               {
                  nextTile.mob = this;
                  cyclePos = (cyclePos + 1) % cycle.length;
               }
               else if(_loc7_)
               {
                  switch(direction)
                  {
                     case 0:
                     case 2:
                        if(MathLibrary.randomize(0,100) < 50)
                        {
                           direction = 1;
                           nextTile = _loc6_.getTile(tile.mapX - 1,tile.mapY);
                        }
                        else
                        {
                           direction = 3;
                           nextTile = _loc6_.getTile(tile.mapX + 1,tile.mapY);
                        }
                        break;
                     default:
                        if(MathLibrary.randomize(0,100) < 50)
                        {
                           direction = 2;
                           nextTile = _loc6_.getTile(tile.mapX,tile.mapY - 1);
                           break;
                        }
                        direction = 0;
                        nextTile = _loc6_.getTile(tile.mapX,tile.mapY + 1);
                  }
                  if(nextTile != null && nextTile.mob == null)
                  {
                     nextTile.mob = this;
                  }
                  else
                  {
                     nextTile = null;
                     direction = 0;
                     waitCounter = 240000 / 24;
                  }
               }
               else
               {
                  nextTile = null;
               }
               updateSprite();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function zap(param1:int, param2:int = 100) : void
      {
         if(MathLibrary.randomize(0,100) <= param2)
         {
            if(zapSprite == null)
            {
               zapSprite = new MovieClip(Assets.getAtlas().getTextures("effect_zap"));
               zapSprite.alpha = 0.5;
               zapSprite.play();
               zapSprite.x = 112 / 2 - zapSprite.width / 2;
               zapSprite.y = 0;
               addChild(zapSprite);
               Starling.juggler.add(zapSprite);
               updateFPS();
            }
            if(jamSprite != null)
            {
               jamSprite.stop();
               jamSprite.removeFromParent(true);
               jamSprite = null;
            }
            if(param1 > this.zapCounter)
            {
               this.zapCounter = param1;
            }
         }
      }
      
      public function jam(param1:int, param2:int = 100) : void
      {
         if(MathLibrary.randomize(0,100) <= param2)
         {
            if(jamSprite == null)
            {
               jamSprite = new MovieClip(Assets.getAtlas().getTextures("effect_jam"));
               jamSprite.alpha = 0.5;
               jamSprite.play();
               jamSprite.x = 112 / 2 - jamSprite.width / 2;
               jamSprite.y = 0;
               addChild(jamSprite);
               Starling.juggler.add(jamSprite);
               updateFPS();
            }
            if(zapSprite != null)
            {
               zapSprite.stop();
               zapSprite.removeFromParent(true);
               zapSprite = null;
            }
            if(param1 > this.zapCounter)
            {
               this.zapCounter = param1;
            }
         }
      }
      
      public function nox(param1:int, param2:Number) : void
      {
         if(type == 10)
         {
            param2 = Math.min(param2,0.5);
         }
         this.noxPower = param2;
         this.noxCounter = param1;
         refreshColors();
         updateFPS();
      }
      
      public function refreshColors() : void
      {
         if(noxCounter > 0)
         {
            sprites[direction].color = 12648192;
         }
         else
         {
            sprites[direction].color = 16777215;
         }
      }
      
      public function updateSprite() : void
      {
         var _loc1_:MovieClip = null;
         while(shipSprite.numChildren > 0)
         {
            _loc1_ = MovieClip(shipSprite.removeChildAt(0));
            Starling.juggler.remove(_loc1_);
            if(_loc1_.isPlaying)
            {
               _loc1_.stop();
            }
         }
         if(!sprites[direction].isPlaying)
         {
            sprites[direction].play();
         }
         shipSprite.addChild(sprites[direction]);
         Starling.juggler.add(sprites[direction]);
         refreshColors();
         updateFPS();
      }
      
      protected function addMinerals(param1:int) : void
      {
         try
         {
            tile.map.addMinerals(param1);
            tile.addFloatText("+" + param1 + "Â");
         }
         catch(error:Error)
         {
         }
      }
      
      public function die() : void
      {
         var map:Map;
         var poofCount:int;
         var i:int;
         if(isTrash() || isDying())
         {
            return;
         }
         map = tile.map;
         poofCount = 3;
         switch(type - 1)
         {
            case 0:
               break;
            case 1:
               poofCount = 15;
               break;
            case 2:
               poofCount = 6;
               break;
            case 10:
               poofCount = 20;
         }
         if(poofCount > 1)
         {
            i = 0;
            while(i < poofCount)
            {
               tile.map.effectSprite.addChild(new PoofEffect(tile.map,position.x + MathLibrary.randomize(0,sprites[direction].width / 2) - MathLibrary.randomize(0,sprites[direction].width / 2),position.y + MathLibrary.randomize(0,sprites[direction].height / 2) - MathLibrary.randomize(0,sprites[direction].height / 2),(i * 500 + 500) / Math.max(1,map.timeMultiplier)));
               i = i + 1;
            }
         }
         tile.map.effectSprite.addChild(new PoofEffect(tile.map,tile.getCanvasX(),tile.getCanvasY() + getFloat(),(poofCount * 500 + 500) / Math.max(1,map.timeMultiplier),function():void
         {
            try
            {
               onDeath();
               trash();
            }
            catch(error:Error)
            {
            }
         }));
         if(tile.mission != null)
         {
            tile.setMission(null);
         }
         bDying = true;
      }
      
      public function onDeath() : void
      {
         var _loc1_:Tile = null;
         switch(type)
         {
            case 1:
               addMinerals(10);
               break;
            case 3:
               addMinerals(25);
               break;
            case 2:
               addMinerals(50);
               break;
            case 4:
               addMinerals(5);
               break;
            case 5:
               addMinerals(10);
               break;
            case 6:
               addMinerals(15);
               break;
            case 7:
               addMinerals(50);
               break;
            case 8:
               addMinerals(65);
               break;
            case 9:
               addMinerals(80);
               break;
            case 10:
               addMinerals(200);
               break;
            case 11:
               addMinerals(100);
               break;
            case 12:
               addMinerals(15);
               break;
            case 13:
               addMinerals(2);
               break;
            case 16:
               addMinerals(500);
               break;
            case 15:
               addMinerals(50);
               break;
            case 17:
               addMinerals(2);
               break;
            case 21:
               addMinerals(150);
         }
         var _loc2_:Map = tile.map;
         if(type == 12 || type == 25 || type == 24)
         {
            if(_loc2_.getTile(tile.mapX - 1,tile.mapY) != null)
            {
               _loc1_ = _loc2_.getTile(tile.mapX - 1,tile.mapY);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc2_.effectSprite.addChild(new SparkEffect(_loc2_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc2_.getTile(tile.mapX + 1,tile.mapY) != null)
            {
               _loc1_ = _loc2_.getTile(tile.mapX + 1,tile.mapY);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc2_.effectSprite.addChild(new SparkEffect(_loc2_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc2_.getTile(tile.mapX,tile.mapY - 1) != null)
            {
               _loc1_ = _loc2_.getTile(tile.mapX,tile.mapY - 1);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc2_.effectSprite.addChild(new SparkEffect(_loc2_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc2_.getTile(tile.mapX,tile.mapY + 1) != null)
            {
               _loc1_ = _loc2_.getTile(tile.mapX,tile.mapY + 1);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc2_.effectSprite.addChild(new SparkEffect(_loc2_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc2_.getTile(tile.mapX,tile.mapY) != null)
            {
               _loc1_ = _loc2_.getTile(tile.mapX,tile.mapY);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc2_.effectSprite.addChild(new SparkEffect(_loc2_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
         }
         else if(type == 19 || type == 20)
         {
            if(_loc2_.getTile(tile.mapX,tile.mapY) != null)
            {
               _loc2_.effectSprite.addChild(new ExplosionEffect(_loc2_,_loc2_.getTile(tile.mapX,tile.mapY)));
            }
         }
         _loc2_.addKill(type);
         trash();
      }
      
      public function isDying() : Boolean
      {
         return bDying;
      }
      
      public function trash() : void
      {
         bTrash = true;
      }
      
      public function isTrash() : Boolean
      {
         return bTrash;
      }
      
      public function updateFPS() : void
      {
         var _loc1_:Number = NaN;
         if(tile.map.timeMultiplier == 0)
         {
            sprites[direction].pause();
            if(zapSprite != null)
            {
               zapSprite.pause();
            }
         }
         else
         {
            _loc1_ = 1;
            switch(tile.map.timeMultiplier - 1)
            {
               case 0:
                  _loc1_ = 1;
                  break;
               case 3:
                  _loc1_ = 2;
                  break;
               case 7:
                  _loc1_ = 4;
            }
            if(zapSprite != null)
            {
               if(!zapSprite.isPlaying)
               {
                  zapSprite.play();
               }
               zapSprite.fps = 12 * _loc1_;
            }
            if(noxCounter > 0)
            {
               _loc1_ /= 2;
            }
            if(!sprites[direction].isPlaying)
            {
               sprites[direction].play();
            }
            sprites[direction].fps = int(mobFPS * _loc1_);
         }
      }
      
      public function getCanvasX() : int
      {
         return position.x;
      }
      
      public function getCanvasY() : int
      {
         return position.y;
      }
      
      public function getTileAt() : Tile
      {
         return tile;
      }
      
      public function getInterceptTime(param1:Boolean) : int
      {
         var _loc2_:int = Math.max(1,health / 5);
         if(param1)
         {
            _loc2_ = Math.max(1,_loc2_ / 2);
         }
         return _loc2_;
      }
      
      public function getInterceptCost(param1:Boolean) : int
      {
         var _loc2_:int = Math.max(0,health);
         if(param1)
         {
            _loc2_ *= 2;
         }
         return _loc2_;
      }
      
      public function getPosition() : Point
      {
         return position;
      }
      
      public function moveTo(param1:Tile) : void
      {
         this.nextTile = param1;
      }
      
      public function getFloat() : int
      {
         switch(type)
         {
            case 2:
               return -70;
            case 11:
               return -20;
            case 3:
               return -10;
            case 16:
               return 100;
            case 17:
            case 18:
            case 19:
            case 20:
               break;
            case 21:
               return -80;
            case 22:
               return -20;
            case 23:
               return -60;
            case 24:
            case 25:
               return 0;
            default:
               return 30;
         }
         return 20;
      }
      
      public function getMarkerFloat() : int
      {
         switch(type)
         {
            case 2:
               return -70;
            case 11:
               return -40;
            case 3:
               return -10;
            case 16:
               return 100;
            case 17:
            case 18:
            case 19:
            case 20:
               break;
            case 21:
               return -140;
            case 22:
               return -20;
            case 23:
               return -110;
            case 24:
            case 25:
               return 0;
            default:
               return -10;
         }
         return 20;
      }
      
      public function getData() : String
      {
         var _loc1_:String = "" + type;
         _loc1_ += ":" + tile.mapX;
         _loc1_ += ":" + tile.mapY;
         _loc1_ += ":" + health;
         _loc1_ += ":" + waitCounter;
         _loc1_ += ":" + zapCounter;
         _loc1_ += ":" + noxPower;
         _loc1_ += ":" + noxCounter;
         _loc1_ += ":" + missionObjID;
         _loc1_ += ":" + (bIntercepted ? "1" : "0");
         _loc1_ += ":" + cyclePos;
         _loc1_ += ":" + waypointPos;
         _loc1_ += ":" + cycle.toString();
         if(waypoints == null)
         {
            _loc1_ += ":-1";
         }
         else
         {
            _loc1_ += ":" + waypoints.toString();
         }
         _loc1_ += ":" + actionCounter;
         return _loc1_ + (":" + extraCounter);
      }
      
      public function initAction() : void
      {
         switch(type - 11)
         {
            case 0:
               actionCounter = 240000 / 6;
               break;
            case 5:
               actionCounter = 240000 / 8;
               break;
            case 10:
               actionCounter = 240000 / 8;
               break;
            case 11:
               actionCounter = 240000 / 6;
               break;
            case 12:
               actionCounter = 240000 / 8;
               break;
            case 13:
            case 14:
               actionCounter = 240000 / 24;
         }
      }
      
      protected function performAction() : void
      {
      }
      
      public function makeChargeParticle() : void
      {
         tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY()));
         SoundLibrary.playSFX("charging");
      }
      
      protected function checkMobAt(param1:int, param2:int) : Mob
      {
         var _loc3_:Map = tile.map;
         if(param1 >= 0 && param1 < _loc3_.mapWidth && param2 >= 0 && param2 < _loc3_.mapHeight)
         {
            if(_loc3_.tiles[param1 + param2 * _loc3_.mapWidth] != null && _loc3_.tiles[param1 + param2 * _loc3_.mapWidth].mob != null)
            {
               return _loc3_.tiles[param1 + param2 * _loc3_.mapWidth].mob;
            }
         }
         return null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(sprites != null)
         {
            _loc1_ = 0;
            while(_loc1_ < sprites.length)
            {
               sprites[_loc1_].dispose();
               _loc1_++;
            }
            sprites.splice(0);
         }
         if(cycle != null)
         {
            cycle.splice(0);
         }
         if(waypoints != null)
         {
            waypoints.splice(0);
         }
         if(zapSprite != null)
         {
            Starling.juggler.remove(zapSprite);
         }
         tile = null;
         nextTile = null;
         sprites = null;
         position = null;
         cycle = null;
         waypoints = null;
         shadowSprite = null;
         shipSprite = null;
         zapSprite = null;
         super.dispose();
      }
   }
}

