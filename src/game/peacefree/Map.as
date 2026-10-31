package game.peacefree
{
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import game.acts.Act1;
   import game.acts.DemoMap;
   import game.container.GameConfig;
   import game.container.Tracer;
   import game.interfaces.clickables.HiddenClickable;
   import game.library.FileLibrary;
   import game.library.MapLibrary;
   import game.library.MathLibrary;
   import game.library.SoundLibrary;
   import game.peacefree.effects.FireballEffect;
   import game.peacefree.effects.HypelBlastEffect;
   import game.peacefree.effects.NoxEffect;
   import game.peacefree.effects.OrbshellEffect;
   import game.peacefree.effects.ShockEffect;
   import game.peacefree.effects.SparkEffect;
   import game.peacefree.interfaces.DialogueInterfacer;
   import game.peacefree.interfaces.OptionsInterfacer;
   import game.peacefree.missions.AbandonMission;
   import game.peacefree.missions.BerryMission;
   import game.peacefree.missions.BuildMission;
   import game.peacefree.missions.DemolishMission;
   import game.peacefree.missions.InterceptMission;
   import game.peacefree.missions.InvadeMission;
   import game.peacefree.missions.LumberMission;
   import game.peacefree.missions.RescueMission;
   import game.peacefree.missions.ResearchMission;
   import game.peacefree.missions.SalvageMission;
   import game.peacefree.missions.ScoutMission;
   import game.peacefree.missions.SecureMission;
   import game.peacefree.missions.UpgradeMission;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.KeyboardEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.extensions.PDParticleSystem;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class Map extends Sprite
   {
      
      public static const UPDATE_TIMEOUT:int = 100;
      
      public static const DAY_TIMEOUT:int = 240000;
      
      public static const DIFFICULTY_EASY:int = 0;
      
      public static const DIFFICULTY_NORMAL:int = 1;
      
      public static const DIFFICULTY_HARD:int = 2;
      
      public static const DIFFICULTY_HEROIC:int = 3;
      
      public static var VIEW_ALL_MODE:Boolean = false;
      
      public static var SECURE_ALL_MODE:Boolean = false;
      
      public static const CAMERA_SPEED:int = 100;
      
      private static var GAME_OVER_QUAD:Texture = null;
      
      public var zoomScale:Number = 1;
      
      public var tiles:Array;
      
      public var hours:Number = 24;
      
      public var days:Number = 1;
      
      private var timerCounter:int = 0;
      
      public var player:Player;
      
      private var bPressed:Boolean = false;
      
      public var bMapChanged:Boolean = true;
      
      public var mobSprite:Sprite;
      
      public var effectSprite:Sprite;
      
      public var mapSprite:HiddenClickable;
      
      public var mapHUD:MapHUD;
      
      public var dialogueInterfacer:DialogueInterfacer;
      
      public var startPoint:int;
      
      public var altStartPoints:Array = null;
      
      public var selectedTile:Tile;
      
      public var mapWidth:int;
      
      public var mapHeight:int;
      
      private var originX:int = -1;
      
      private var originY:int = -1;
      
      private var startX:int = -1;
      
      private var startY:int = -1;
      
      public var dragX:int = -1;
      
      public var dragY:int = -1;
      
      public var timeMultiplier:int = 1;
      
      public var bUpdateFPS:Boolean = false;
      
      public var mobs:Array = null;
      
      public var mobGenerators:Array = null;
      
      public var difficulty:int = 1;
      
      private var unlockIDs:Array = [];
      
      public var act:Act;
      
      private var moveToCamera:Point = new Point(0,0);
      
      private var bUpdatedMoveToCamera:Boolean = false;
      
      public var pgame:PeacefreeGame;
      
      public var bTDMode:Boolean = false;
      
      public var kills:Array = [];
      
      public var bgList:Array = new Array("act_1");
      
      private var bPausedBGM:Boolean = false;
      
      public var bEnableBGM:Boolean = true;
      
      private var bgIndex:int = 0;
      
      private var blackFilmQuad:HiddenClickable;
      
      private var gameOverBg:HiddenClickable;
      
      private var resultImage:Image;
      
      private var tapToExitLabel:TextField;
      
      private var gameOverDetailsLabel:TextField;
      
      private var bCanExit:Boolean = false;
      
      public var bHasTechLab:Boolean = false;
      
      public var bUnlockedV2:Boolean = false;
      
      public var research:Research;
      
      public var bLoaded:Boolean = false;
      
      private var bPressedUp:Boolean = false;
      
      private var bPressedLeft:Boolean = false;
      
      private var bPressedRight:Boolean = false;
      
      private var bPressedDown:Boolean = false;
      
      public var optionsInterfacer:OptionsInterfacer;
      
      private var bShowingOptions:Boolean = false;
      
      private var updateTimeout:int = 0;
      
      private var bRemembered:Boolean = false;
      
      private var lastPosition:Point = new Point(0,0);
      
      private var bGameOver:Boolean = false;
      
      public var targetTiles:Array = null;
      
      public var bResetBuildingGrowths:Boolean = true;
      
      public var bVictory:Boolean = false;
      
      private var zoomGoToTile:Tile = null;
      
      public function Map(param1:PeacefreeGame, param2:Act, param3:Boolean = true, param4:int = 1)
      {
         super();
         this.pgame = param1;
         this.bEnableBGM = param1.bEnabledBGM;
         this.difficulty = param4;
         x = 0;
         y = 0;
         research = new Research();
         player = new Player(this);
         mapWidth = 25;
         mapHeight = 25;
         var _loc5_:HiddenClickable = new HiddenClickable(Texture.fromColor(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,4278190080));
         _loc5_.pressedCallback = onPressed;
         _loc5_.dragCallback = onPressed;
         _loc5_.releaseCallback = onRelease;
         addChild(_loc5_);
         mapSprite = new HiddenClickable(Texture.fromColor(1,1,0));
         mapSprite.pressedCallback = onPressed;
         mapSprite.dragCallback = onPressed;
         mapSprite.releaseCallback = onRelease;
         mapSprite.scaleX = zoomScale;
         mapSprite.scaleY = zoomScale;
         addChild(mapSprite);
         mobSprite = new Sprite();
         mapSprite.addChild(mobSprite);
         effectSprite = new Sprite();
         mapSprite.addChild(effectSprite);
         mobs = [];
         mobGenerators = [];
         tiles = new Array(mapWidth * mapHeight);
         dialogueInterfacer = new DialogueInterfacer(this);
         optionsInterfacer = new OptionsInterfacer(param1);
         mapHUD = new MapHUD(this);
         mapHUD.changeSpeed(4);
         if(!param1.bEnabledBGM)
         {
            mapHUD.toggleBGM(false);
         }
         if(!SoundLibrary.ENABLE_SFX)
         {
            mapHUD.toggleSFX(false);
         }
         addChild(mapHUD);
         this.act = param2;
         if(param3)
         {
            param2.init(this);
            mapHUD.miniMap.setMap(this);
            player.init();
         }
      }
      
      public static function getHour(param1:int) : int
      {
         return param1 % 24;
      }
      
      public static function getMinutes(param1:int) : int
      {
         return Math.floor(param1 / (240000 / 24) * 60);
      }
      
      public static function formatTime(param1:int, param2:int) : String
      {
         var _loc3_:String = "";
         param2 = int(param2 / 10) * 10;
         if(param1 < 10)
         {
            _loc3_ += "0";
         }
         _loc3_ += param1 + ":";
         if(param2 < 10)
         {
            _loc3_ += "0";
         }
         return _loc3_ + param2;
      }
      
      public static function formatCooldown(param1:int) : String
      {
         var _loc4_:int = Math.floor(param1 / (240000 / 24));
         var _loc3_:int = Math.ceil(param1 % (240000 / 24) / 166.66666666666666);
         var _loc2_:String = "";
         if(_loc4_ < 10)
         {
            _loc2_ += "0";
         }
         _loc2_ += _loc4_ + ":";
         if(_loc3_ < 10)
         {
            _loc2_ += "0";
         }
         return _loc2_ + _loc3_;
      }
      
      public static function loadData(param1:PeacefreeGame, param2:String) : Map
      {
         var _loc7_:int = 0;
         var _loc16_:Array = null;
         var _loc6_:int = 0;
         var _loc17_:int = 0;
         var _loc15_:int = 0;
         var _loc5_:String = null;
         var _loc11_:Tile = null;
         var _loc3_:Object = FileLibrary.getData(param2);
         if(_loc3_ == null || _loc3_.data == null || _loc3_.data.gameData == null)
         {
            return null;
         }
         var _loc9_:Object = JSON.parse(_loc3_.data.gameData);
         var _loc4_:Object = _loc9_.act;
         var _loc13_:Act = Act.getAct(_loc4_.actNumber);
         var _loc12_:Map = new Map(param1,_loc13_,false,_loc9_.difficulty);
         _loc12_.days = _loc9_.days;
         _loc12_.hours = _loc9_.hours;
         _loc12_.timerCounter = _loc9_.timerCounter;
         _loc12_.research.setData(_loc9_.research);
         _loc12_.player.setData(_loc9_.player);
         _loc12_.mapHUD.setData(_loc9_.mapHUD);
         _loc12_.loadMap(MapLibrary.parseMapData(_loc9_.mapData),false,false,false);
         var _loc14_:Array = _loc9_.mobData;
         _loc7_ = 0;
         while(_loc7_ < _loc14_.length)
         {
            _loc12_.addMob(Mob.generate(_loc12_,_loc14_[_loc7_]));
            _loc7_++;
         }
         var _loc8_:Array = _loc9_.mobGenData;
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            _loc12_.addMobGenerator(MobGenerator.generate(_loc12_,_loc8_[_loc7_]));
            _loc7_++;
         }
         var _loc10_:Array = _loc9_.missionData;
         _loc7_ = 0;
         while(_loc7_ < _loc10_.length)
         {
            _loc16_ = _loc10_[_loc7_].split(":");
            _loc6_ = int(_loc16_[0]);
            _loc17_ = int(_loc16_[1]);
            _loc15_ = int(_loc16_[2]);
            _loc5_ = _loc16_[3];
            _loc11_ = _loc12_.tiles[_loc17_ + _loc15_ * _loc12_.mapWidth];
            switch(_loc6_)
            {
               case 26:
                  _loc11_.setMission(new AbandonMission(_loc11_,false,true));
                  break;
               case 25:
                  _loc11_.setMission(new BerryMission(_loc11_,false,true));
                  break;
               case 3:
                  _loc11_.setMission(new BuildMission(_loc11_,1,false,true));
                  break;
               case 6:
                  _loc11_.setMission(new DemolishMission(_loc11_,false,true));
                  break;
               case 13:
                  _loc11_.setMission(new InterceptMission(_loc11_,false,true));
                  break;
               case 12:
                  _loc11_.setMission(new InvadeMission(_loc11_.mob,_loc11_,true));
                  break;
               case 9:
                  _loc11_.setMission(new LumberMission(_loc11_,false,true));
                  break;
               case 5:
                  _loc11_.setMission(new RescueMission(_loc11_,false,true));
                  break;
               case 19:
                  _loc11_.setMission(new ResearchMission(_loc11_,1,false,true));
                  break;
               case 1:
                  _loc11_.setMission(new SalvageMission(_loc11_,false,true));
                  break;
               case 2:
                  _loc11_.setMission(new ScoutMission(_loc11_,false,true));
                  break;
               case 4:
                  _loc11_.setMission(new SecureMission(_loc11_,false,true));
                  break;
               case 20:
                  _loc11_.setMission(new UpgradeMission(_loc11_,1,false,true));
            }
            _loc11_.mission.setCounter(_loc5_);
            _loc7_++;
         }
         _loc12_.kills = _loc9_.kills;
         _loc12_.unlockIDs = _loc9_.unlockIDs;
         _loc13_.init(_loc12_,false);
         _loc13_.completedMissions = _loc4_.completedMissions;
         _loc13_.fastForwardTo(_loc4_.sequence);
         _loc13_.cache = _loc4_.cache;
         _loc12_.mapHUD.miniMap.setMap(_loc12_);
         _loc12_.next();
         _loc12_.goToTile(_loc12_.tiles[_loc12_.startPoint]);
         _loc12_.setEnableBGM(param1.bEnabledBGM);
         _loc12_.stopBGM();
         _loc12_.updateMap();
         if(_loc9_.timeMultiplier == 0)
         {
            _loc12_.mapHUD.pause();
         }
         else
         {
            _loc12_.mapHUD.changeSpeed(_loc9_.timeMultiplier);
         }
         _loc12_.progressMobs(0);
         _loc12_.progressTiles(0);
         _loc12_.mapHUD.update();
         return _loc12_;
      }
      
      public function loadMap(param1:Array, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Array = null;
         var _loc5_:Tile = null;
         _loc7_ = 0;
         while(_loc7_ < param1.length && _loc7_ < mapHeight)
         {
            _loc8_ = 0;
            while(_loc8_ < param1[_loc7_].length)
            {
               if(param1[_loc7_][_loc8_] != "")
               {
                  _loc6_ = param1[_loc7_][_loc8_].split(":");
                  try
                  {
                     _loc5_ = new Tile(this,_loc8_,_loc7_,int(_loc6_[0]));
                  }
                  catch(error:Error)
                  {
                     Tracer.trace("Error with tileID: " + _loc6_[0]);
                     _loc5_ = new Tile(this,_loc8_,_loc7_,1);
                  }
                  if(_loc6_[1] != "")
                  {
                     _loc5_.setBuilding(new Building(int(_loc6_[1]),_loc5_));
                  }
                  if(_loc6_[2] != "")
                  {
                     _loc5_.setDecor(int(_loc6_[2]));
                  }
                  _loc5_.danger = int(_loc6_[3]);
                  if(param4)
                  {
                     switch(difficulty)
                     {
                        case 0:
                           _loc5_.danger /= 2;
                           break;
                        case 1:
                           break;
                        case 2:
                           _loc5_.danger *= 1.5;
                           break;
                        case 3:
                           _loc5_.danger *= 2;
                     }
                  }
                  _loc5_.food = int(_loc6_[4]);
                  _loc5_.minerals = int(_loc6_[5]);
                  _loc5_.recruits = int(_loc6_[6]);
                  _loc5_.lockID = int(_loc6_[7]);
                  _loc5_.bSecured = int(_loc6_[8]) > 0;
                  _loc5_.bScouted = int(_loc6_[9]) > 0;
                  _loc5_.bScoutedNearby = int(_loc6_[10]) > 0;
                  _loc5_.bSecuredNearby = int(_loc6_[11]) > 0;
                  if(_loc6_.length > 12)
                  {
                     _loc5_.bRescued = int(_loc6_[12]) > 0;
                     _loc5_.bVisible = int(_loc6_[13]) > 0;
                  }
                  if(VIEW_ALL_MODE || param2 || param3)
                  {
                     if((SECURE_ALL_MODE || param3) && _loc5_.type != 0)
                     {
                        _loc5_.bSecured = true;
                        _loc5_.bSecuredNearby = true;
                     }
                     _loc5_.bScouted = true;
                     _loc5_.bScoutedNearby = true;
                     _loc5_.bVisible = true;
                  }
                  if(_loc5_.bSecured)
                  {
                     _loc5_.bSecuredNearby = true;
                     if(_loc5_.building != null)
                     {
                        _loc5_.building.gain();
                     }
                  }
                  if(_loc5_.bScouted)
                  {
                     _loc5_.bScoutedNearby = true;
                  }
                  try
                  {
                     _loc5_.refreshColors();
                  }
                  catch(error:Error)
                  {
                     Tracer.trace("Error with tileID: " + param1[_loc7_][_loc8_]);
                  }
                  tiles[_loc7_ * mapWidth + _loc8_] = _loc5_;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         _loc7_ = mapHeight;
         if(_loc7_ < param1.length)
         {
            _loc8_ = 0;
            while(_loc8_ < param1[_loc7_].length)
            {
               if(param1[_loc7_][_loc8_] != "")
               {
                  addMob(Mob.generate(this,param1[_loc7_][_loc8_]));
               }
               _loc8_++;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < mapHeight)
         {
            _loc8_ = 0;
            while(_loc8_ < mapWidth)
            {
               if(tiles[_loc8_ + _loc7_ * mapWidth] != null)
               {
                  Tile(tiles[_loc8_ + _loc7_ * mapWidth]).updateWalls();
               }
               _loc8_++;
            }
            _loc7_++;
         }
         bMapChanged = true;
      }
      
      public function isLocked(param1:int) : Boolean
      {
         if(VIEW_ALL_MODE)
         {
            return false;
         }
         if(param1 == 0 || unlockIDs.indexOf(param1) != -1)
         {
            return false;
         }
         return true;
      }
      
      public function unlock(param1:int) : void
      {
         if(unlockIDs.indexOf(param1) == -1)
         {
            unlockIDs.push(param1);
            updateMap();
         }
      }
      
      public function addMob(param1:Mob) : void
      {
         mobs.push(param1);
         mapHUD.miniMap.addMob(param1);
         updateMap();
      }
      
      public function addMobGenerator(param1:MobGenerator) : void
      {
         mobGenerators.push(param1);
      }
      
      public function onPressed(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.phase == "began")
         {
            bPressed = true;
            originX = mapSprite.x;
            originY = mapSprite.y;
            startX = _loc2_.globalX;
            startY = _loc2_.globalY;
            dragX = startX;
            dragY = startY;
         }
         else if(_loc2_.phase == "ended")
         {
            onRelease();
         }
         else if(_loc2_.phase == "moved")
         {
            if(mapHUD.miniMap.bEnableMovement)
            {
               dragX = _loc2_.globalX;
               dragY = _loc2_.globalY;
               mapSprite.x = originX - startX + dragX;
               mapSprite.y = originY - startY + dragY;
               bMapChanged = true;
            }
         }
      }
      
      public function onRelease() : void
      {
         var _loc1_:Tile = null;
         bPressed = false;
         bMapChanged = true;
         if(Math.abs(startX - dragX) <= 15 && Math.abs(startY - dragY) <= 15)
         {
            _loc1_ = getTileOn((-mapSprite.x + dragX) * (1 / zoomScale),(-mapSprite.y + dragY) * (1 / zoomScale));
            if(_loc1_ != null && _loc1_.type != 0 && _loc1_.bScoutedNearby && !_loc1_.isLocked())
            {
               SoundLibrary.playSFX("click");
               selectTile(_loc1_);
            }
            else
            {
               selectTile(null);
            }
         }
      }
      
      public function goToCamera(param1:int, param2:int) : void
      {
         mapSprite.x = param1;
         mapSprite.y = param2;
         bMapChanged = true;
      }
      
      public function goToTile(param1:Tile) : void
      {
         if(param1 == null)
         {
            return;
         }
         mapSprite.x = (-param1.getCanvasX() - 112 / 2) * zoomScale + GameConfig.GAME_WIDTH / 2;
         mapSprite.y = (-param1.getCanvasY() - 112 / 2) * zoomScale + GameConfig.GAME_HEIGHT / 2;
         bMapChanged = true;
      }
      
      public function moveToTile(param1:Tile) : void
      {
         moveToCamera.x = (-param1.getCanvasX() - 112 / 2) * zoomScale + GameConfig.GAME_WIDTH / 2;
         moveToCamera.y = (-param1.getCanvasY() - 112 / 2) * zoomScale + GameConfig.GAME_HEIGHT / 2;
         bUpdatedMoveToCamera = true;
      }
      
      public function updateCamera() : void
      {
         if(zoomGoToTile != null)
         {
            goToTile(zoomGoToTile);
            zoomGoToTile = null;
         }
         if(bUpdatedMoveToCamera)
         {
            if(Math.abs(mapSprite.x - moveToCamera.x) <= 100)
            {
               mapSprite.x = moveToCamera.x;
            }
            else if(mapSprite.x < moveToCamera.x)
            {
               mapSprite.x += 100;
            }
            else if(mapSprite.x > moveToCamera.x)
            {
               mapSprite.x -= 100;
            }
            if(Math.abs(mapSprite.y - moveToCamera.y) <= 100)
            {
               mapSprite.y = moveToCamera.y;
            }
            else if(mapSprite.y < moveToCamera.y)
            {
               mapSprite.y += 100;
            }
            else if(mapSprite.y > moveToCamera.y)
            {
               mapSprite.y -= 100;
            }
            if(mapSprite.x == moveToCamera.x && mapSprite.y == moveToCamera.y)
            {
               bUpdatedMoveToCamera = false;
               updateTimeout = 0;
            }
            updateMap();
         }
         else
         {
            if(bPressedUp)
            {
               mapSprite.y += 12;
            }
            else if(bPressedDown)
            {
               mapSprite.y -= 12;
            }
            if(bPressedLeft)
            {
               mapSprite.x += 12;
            }
            else if(bPressedRight)
            {
               mapSprite.x -= 12;
            }
            if(bPressedUp || bPressedDown || bPressedLeft || bPressedRight)
            {
               updateMap();
            }
         }
         if(mapSprite.y > 112 * 1)
         {
            mapSprite.y = 112 * 1;
         }
         else if(mapSprite.y < -112 * (mapHeight * zoomScale - 4))
         {
            mapSprite.y = -112 * (mapHeight * zoomScale - 4);
         }
         if(mapSprite.x > 112 * mapWidth * zoomScale / 2)
         {
            mapSprite.x = 112 * mapWidth * zoomScale / 2;
         }
         else if(mapSprite.x < -112 * mapWidth * zoomScale / 2 + 112 * 6)
         {
            mapSprite.x = -112 * mapWidth * zoomScale / 2 + 112 * 6;
         }
      }
      
      public function progress(param1:int) : void
      {
         if(!bLoaded)
         {
            return;
         }
         playBGM();
         if(bShowingOptions)
         {
            return;
         }
         mapHUD.progress(param1);
         var _loc2_:int = param1;
         param1 *= timeMultiplier;
         timerCounter += param1;
         updateCamera();
         progressMobs(param1);
         progressTiles(param1,_loc2_);
         mapHUD.update();
         while(timerCounter > 240000 / 24)
         {
            timerCounter -= 240000 / 24;
            hours += 1;
            days = Math.floor(hours / 24);
            player.generate();
            if(hours % 12 == 0)
            {
               player.deductFood();
            }
            if(hours % 24 == 0)
            {
               if(act != null && !(act is DemoMap) && !(act is Act1) && !bGameOver)
               {
                  saveData("save-0");
               }
               if(act != null)
               {
                  act.onNewDay();
               }
            }
         }
      }
      
      public function progressMobs(param1:int) : void
      {
         var _loc12_:int = 0;
         var _loc4_:MobGenerator = null;
         var _loc11_:Mob = null;
         var _loc8_:Mob = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:Mob = null;
         var _loc6_:Boolean = bUpdateFPS;
         var _loc10_:Boolean = false;
         var _loc3_:int = 0;
         var _loc9_:int = int(mobGenerators.length);
         _loc12_ = 0;
         while(_loc12_ < _loc9_)
         {
            _loc4_ = mobGenerators[_loc12_];
            if(_loc4_.isTrash())
            {
               mobGenerators.splice(_loc12_,1);
               _loc12_--;
               _loc9_ = int(mobGenerators.length);
            }
            else
            {
               _loc4_.progress(param1);
            }
            _loc12_++;
         }
         _loc9_ = int(mobs.length);
         _loc12_ = 1;
         while(_loc12_ < _loc9_)
         {
            _loc11_ = mobs[_loc12_];
            _loc8_ = mobs[_loc12_ - 1];
            _loc2_ = _loc11_.tile.mapX + _loc11_.tile.mapY * mapWidth;
            _loc5_ = _loc8_.tile.mapX + _loc8_.tile.mapY * mapWidth;
            if(_loc2_ < _loc5_)
            {
               mobs[_loc12_] = _loc8_;
               mobs[_loc12_ - 1] = _loc11_;
               _loc10_ = true;
            }
            _loc12_++;
         }
         _loc12_ = 0;
         while(_loc12_ < _loc9_)
         {
            _loc7_ = mobs[_loc12_];
            _loc7_.progress(param1);
            if(_loc6_)
            {
               _loc7_.updateFPS();
            }
            if(!isOnScreen(_loc7_.getCanvasX(),_loc7_.getCanvasY()) || !_loc7_.tile.isVisible() || _loc7_.isTrash())
            {
               if(mobSprite.contains(_loc7_))
               {
                  mobSprite.removeChild(_loc7_);
               }
            }
            else if(!mobSprite.contains(_loc7_))
            {
               _loc10_ = true;
               mobSprite.addChild(_loc7_);
            }
            else if(_loc10_)
            {
               mobSprite.removeChild(_loc7_);
               mobSprite.addChild(_loc7_);
            }
            if(_loc7_.isTrash())
            {
               mobs.splice(_loc12_,1);
               _loc12_--;
               _loc9_ = int(mobs.length);
            }
            _loc12_++;
         }
      }
      
      public function progressTiles(param1:int, param2:int = 0) : void
      {
         var _loc10_:int = 0;
         var _loc5_:Tile = null;
         player.curEnergy = 0;
         bHasTechLab = false;
         bUnlockedV2 = false;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc3_:Boolean = bMapChanged;
         var _loc4_:Boolean = bUpdateFPS;
         var _loc7_:Boolean = bResetBuildingGrowths;
         if(updateTimeout > 0)
         {
            updateTimeout -= param2;
            _loc3_ = false;
         }
         else if(_loc3_)
         {
            updateTimeout = 100;
         }
         if(_loc4_)
         {
            bUpdateFPS = false;
         }
         if(_loc7_)
         {
            player.resetBuildingGrowths();
            bResetBuildingGrowths = false;
         }
         var _loc6_:int = int(tiles.length);
         _loc10_ = 0;
         while(_loc10_ < _loc6_)
         {
            if(tiles[_loc10_] != null && tiles[_loc10_] != undefined)
            {
               _loc5_ = tiles[_loc10_];
               if(_loc7_ && _loc5_.bSecured && _loc5_.building != null)
               {
                  _loc5_.building.gain();
               }
               _loc5_.progress(param1);
               if(_loc4_)
               {
                  _loc5_.updateFPS();
               }
               if(_loc3_)
               {
                  if(!_loc5_.isVisible() || !isOnScreen(_loc5_.getCanvasX(),_loc5_.getCanvasY()))
                  {
                     if(mapSprite.contains(_loc5_))
                     {
                        mapSprite.removeChild(_loc5_);
                     }
                  }
                  else
                  {
                     _loc8_++;
                     if(!mapSprite.contains(_loc5_))
                     {
                        _loc9_ = true;
                        mapSprite.addChild(_loc5_);
                     }
                     else if(_loc9_)
                     {
                        mapSprite.removeChild(_loc5_);
                        mapSprite.addChild(_loc5_);
                     }
                  }
               }
            }
            _loc10_++;
         }
         if(_loc3_)
         {
            bMapChanged = false;
            mapSprite.removeChild(mobSprite);
            mapSprite.addChild(mobSprite);
            mapSprite.removeChild(effectSprite);
            mapSprite.addChild(effectSprite);
            mapHUD.miniMap.updateCursor();
         }
      }
      
      public function isOnScreen(param1:int, param2:int) : Boolean
      {
         if(mapSprite.x + param1 * zoomScale < -224 || mapSprite.y + param2 * zoomScale < -224 || mapSprite.x + param1 * zoomScale - 112 > GameConfig.GAME_WIDTH || mapSprite.y + param2 * zoomScale - 112 > GameConfig.GAME_HEIGHT)
         {
            return false;
         }
         return true;
      }
      
      public function addFloatText(param1:String, param2:int, param3:int, param4:Number = 16777215) : void
      {
         var tween_floatText:Tween;
         var text:String = param1;
         var x:int = param2;
         var y:int = param3;
         var color:Number = param4;
         var floatText:TextField = new TextField(200,200,text,Fonts.getDefaultFont().fontName,16,color,true);
         floatText.x = x;
         floatText.y = y;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         effectSprite.addChild(floatText);
         tween_floatText = new Tween(floatText,1.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(x + 15,y - 40);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.5);
            tween_floatText.moveTo(x + 20,y - 55);
            tween_floatText.fadeTo(0);
            tween_floatText.onComplete = function():void
            {
               floatText.removeFromParent(true);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function addFood(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var food:int = param1;
         player.food += food;
         floatText = new TextField(200,200,"+È" + food,Fonts.getDefaultFont().fontName,18,65280,true);
         floatText.x = 140;
         floatText.y = 30;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(140,40);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(140,60);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function deductFood(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var food:int = param1;
         player.food -= food;
         floatText = new TextField(200,200,"-È" + food,Fonts.getDefaultFont().fontName,18,16711680,true);
         floatText.x = 140;
         floatText.y = 30;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(140,40);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(140,60);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function addMinerals(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var minerals:int = param1;
         player.minerals += minerals;
         floatText = new TextField(200,200,"+Â" + minerals,Fonts.getDefaultFont().fontName,18,65280,true);
         floatText.x = 40;
         floatText.y = 30;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(40,40);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(40,60);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function deductMinerals(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var minerals:int = param1;
         player.minerals -= minerals;
         floatText = new TextField(200,200,"-Â" + minerals,Fonts.getDefaultFont().fontName,18,16711680,true);
         floatText.x = 40;
         floatText.y = 30;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(40,40);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(40,60);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function addFP(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var firepower:int = param1;
         player.curFirepower += firepower;
         if(player.curFirepower > player.maxFirepower)
         {
            player.curFirepower = player.maxFirepower;
         }
         floatText = new TextField(200,200,"+Æ" + firepower,Fonts.getDefaultFont().fontName,18,65280,true);
         floatText.x = mapHUD.firepowerTextField.x + 20;
         floatText.y = mapHUD.firepowerTextField.y - 10;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(floatText.x,floatText.y - 10);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(floatText.x,floatText.y - 20);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function deductFP(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var firepower:int = param1;
         player.curFirepower -= firepower;
         floatText = new TextField(200,200,"-Æ" + firepower,Fonts.getDefaultFont().fontName,18,16711680,true);
         floatText.x = mapHUD.firepowerTextField.x + 20;
         floatText.y = mapHUD.firepowerTextField.y - 10;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(floatText.x,floatText.y - 10);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(floatText.x,floatText.y - 20);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function addTP(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var techpower:int = param1;
         player.curTechpower += techpower;
         if(player.curTechpower > player.maxTechpower)
         {
            player.curTechpower = player.maxTechpower;
         }
         floatText = new TextField(200,200,"+Ê" + techpower,Fonts.getDefaultFont().fontName,18,65280,true);
         floatText.x = mapHUD.techpowerTextField.x + 20;
         floatText.y = mapHUD.techpowerTextField.y - 10;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(floatText.x,floatText.y - 10);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(floatText.x,floatText.y - 20);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function deductTP(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var techpower:int = param1;
         player.curTechpower -= techpower;
         floatText = new TextField(200,200,"-Ê" + techpower,Fonts.getDefaultFont().fontName,18,16711680,true);
         floatText.x = mapHUD.techpowerTextField.x + 20;
         floatText.y = mapHUD.techpowerTextField.y - 10;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(floatText.x,floatText.y - 10);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(floatText.x,floatText.y - 20);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function addSP(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var searchpower:int = param1;
         player.curSearchpower += searchpower;
         if(player.curSearchpower > player.maxSearchpower)
         {
            player.curSearchpower = player.maxSearchpower;
         }
         floatText = new TextField(200,200,"+Å" + searchpower,Fonts.getDefaultFont().fontName,18,65280,true);
         floatText.x = mapHUD.searchpowerTextField.x + 20;
         floatText.y = mapHUD.searchpowerTextField.y - 10;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(floatText.x,floatText.y - 10);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(floatText.x,floatText.y - 20);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function deductSP(param1:int) : void
      {
         var floatText:TextField;
         var tween_floatText:Tween;
         var searchpower:int = param1;
         player.curSearchpower -= searchpower;
         floatText = new TextField(200,200,"-Å" + searchpower,Fonts.getDefaultFont().fontName,18,16711680,true);
         floatText.x = mapHUD.searchpowerTextField.x + 20;
         floatText.y = mapHUD.searchpowerTextField.y - 10;
         floatText.alpha = 0;
         floatText.vAlign = "top";
         floatText.hAlign = "left";
         floatText.touchable = false;
         floatText.autoScale = true;
         addChild(floatText);
         tween_floatText = new Tween(floatText,0.25);
         tween_floatText.fadeTo(1);
         tween_floatText.moveTo(floatText.x,floatText.y - 10);
         tween_floatText.onComplete = function():void
         {
            tween_floatText = new Tween(floatText,0.55);
            tween_floatText.onComplete = function():void
            {
               tween_floatText = new Tween(floatText,0.25);
               tween_floatText.moveTo(floatText.x,floatText.y - 20);
               tween_floatText.fadeTo(0);
               tween_floatText.onComplete = function():void
               {
                  floatText.removeFromParent(true);
               };
               Starling.juggler.add(tween_floatText);
            };
            Starling.juggler.add(tween_floatText);
         };
         Starling.juggler.add(tween_floatText);
      }
      
      public function getTime() : String
      {
         return formatTime(getHour(hours),getMinutes(timerCounter));
      }
      
      private function secureNearbyTile(param1:int, param2:int) : void
      {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 > mapHeight)
         {
            return;
         }
         var _loc3_:Map = this;
         if(param1 >= 0 && param1 < mapWidth && param2 >= 0 && param2 < mapHeight)
         {
            if(_loc3_.tiles[param1 + param2 * mapWidth] != null)
            {
               _loc3_.tiles[param1 + param2 * mapWidth].bSecuredNearby = true;
               _loc3_.tiles[param1 + param2 * mapWidth].refreshColors();
            }
         }
      }
      
      private function updateWalls(param1:int, param2:int) : void
      {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 > mapHeight)
         {
            return;
         }
         var _loc3_:Map = this;
         if(param1 >= 0 && param1 < mapWidth && param2 >= 0 && param2 < mapHeight)
         {
            if(_loc3_.tiles[param1 + param2 * mapWidth] != null)
            {
               _loc3_.tiles[param1 + param2 * mapWidth].updateWalls();
            }
         }
      }
      
      public function updateTileWalls(param1:Tile) : void
      {
         param1.updateWalls();
         updateWalls(param1.mapX,param1.mapY - 1);
         updateWalls(param1.mapX - 1,param1.mapY);
         updateWalls(param1.mapX + 1,param1.mapY);
         updateWalls(param1.mapX,param1.mapY + 1);
      }
      
      public function secureTile(param1:Tile) : void
      {
         if(!param1.bSecured)
         {
            param1.secure();
            param1.recruits = 0;
            param1.danger = 0;
         }
         param1.updateWalls();
         param1.refreshColors();
         scoutTile(param1);
         secureNearbyTile(param1.mapX,param1.mapY - 1);
         secureNearbyTile(param1.mapX - 1,param1.mapY);
         secureNearbyTile(param1.mapX + 1,param1.mapY);
         secureNearbyTile(param1.mapX,param1.mapY + 1);
         updateWalls(param1.mapX,param1.mapY - 1);
         updateWalls(param1.mapX - 1,param1.mapY);
         updateWalls(param1.mapX + 1,param1.mapY);
         updateWalls(param1.mapX,param1.mapY + 1);
      }
      
      public function unsecureTile(param1:Tile) : void
      {
         if(param1.bSecured && param1.building != null)
         {
            param1.building.lose();
         }
         param1.bSecured = false;
         param1.updateWalls();
         param1.refreshColors();
         unsecureNearbyTile(param1.mapX,param1.mapY - 1);
         unsecureNearbyTile(param1.mapX - 1,param1.mapY);
         unsecureNearbyTile(param1.mapX + 1,param1.mapY);
         unsecureNearbyTile(param1.mapX,param1.mapY + 1);
         updateWalls(param1.mapX,param1.mapY - 1);
         updateWalls(param1.mapX - 1,param1.mapY);
         updateWalls(param1.mapX + 1,param1.mapY);
         updateWalls(param1.mapX,param1.mapY + 1);
      }
      
      private function unsecureNearbyTile(param1:int, param2:int) : void
      {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 > mapHeight)
         {
            return;
         }
         var _loc4_:Map = this;
         var _loc3_:Tile = tiles[param1 + param2 * mapWidth];
         if(_loc3_ == null)
         {
            return;
         }
         if(!_loc4_.tiles[param1 + param2 * mapWidth].bSecured)
         {
            if(!isSecured(_loc3_.mapX,_loc3_.mapY - 1) && !isSecured(_loc3_.mapX - 1,_loc3_.mapY) && !isSecured(_loc3_.mapX + 1,_loc3_.mapY) && !isSecured(_loc3_.mapX,_loc3_.mapY + 1))
            {
               _loc4_.tiles[param1 + param2 * mapWidth].bSecuredNearby = false;
               _loc4_.tiles[param1 + param2 * mapWidth].refreshColors();
            }
         }
      }
      
      public function isSecured(param1:int, param2:int) : Boolean
      {
         if(tiles[param1 + param2 * mapWidth] == null)
         {
            return false;
         }
         return tiles[param1 + param2 * mapWidth].bSecured;
      }
      
      private function scoutNearbyTile(param1:int, param2:int) : void
      {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 > mapHeight)
         {
            return;
         }
         var _loc3_:Map = this;
         if(param1 >= 0 && param1 < mapWidth && param2 >= 0 && param2 < mapHeight)
         {
            if(_loc3_.tiles[param1 + param2 * mapWidth] != null)
            {
               _loc3_.tiles[param1 + param2 * mapWidth].bScoutedNearby = true;
               _loc3_.tiles[param1 + param2 * mapWidth].refreshColors();
            }
         }
      }
      
      public function scoutTile(param1:Tile) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.bScouted = true;
         param1.bScoutedNearby = true;
         param1.refreshColors();
         scoutNearbyTile(param1.mapX - 1,param1.mapY - 1);
         scoutNearbyTile(param1.mapX,param1.mapY - 1);
         scoutNearbyTile(param1.mapX + 1,param1.mapY - 1);
         scoutNearbyTile(param1.mapX - 1,param1.mapY);
         scoutNearbyTile(param1.mapX + 1,param1.mapY);
         scoutNearbyTile(param1.mapX - 1,param1.mapY + 1);
         scoutNearbyTile(param1.mapX,param1.mapY + 1);
         scoutNearbyTile(param1.mapX + 1,param1.mapY + 1);
      }
      
      public function makeVisibleTile(param1:Tile) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.bVisible = true;
         param1.refreshColors();
      }
      
      public function findMob(param1:int) : Mob
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < mobs.length)
         {
            if(mobs[_loc2_].missionObjID == param1)
            {
               return mobs[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setStartTile(param1:int, param2:int) : void
      {
         scoutTile(tiles[param2 * mapWidth + param1]);
         scoutTile(tiles[(param2 - 1) * mapWidth + param1]);
         scoutTile(tiles[(param2 + 1) * mapWidth + param1]);
         scoutTile(tiles[param2 * mapWidth + param1 + 1]);
         scoutTile(tiles[param2 * mapWidth + param1 - 1]);
         secureTile(tiles[param2 * mapWidth + param1]);
         startPoint = param2 * mapWidth + param1;
         goToTile(tiles[param2 * mapWidth + param1]);
      }
      
      public function selectTile(param1:Tile) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1 != null && targetTiles != null)
         {
            _loc3_ = false;
            _loc2_ = int(targetTiles.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               if(targetTiles[_loc4_] == param1 && param1.mission == null)
               {
                  _loc3_ = true;
               }
               else if(mapHUD.commandInterfacer.isCommandSelected())
               {
                  _loc3_ = true;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               return;
            }
         }
         if(selectedTile != null)
         {
            selectedTile.setIsHighlight(false);
         }
         selectedTile = param1;
         mapHUD.setSelectedTile(param1);
         if(selectedTile != null && selectedTile.bScoutedNearby)
         {
            selectedTile.setIsHighlight(true);
         }
      }
      
      public function getTileOn(param1:int, param2:int) : Tile
      {
         var _loc4_:int = Math.max(0,Math.min(mapWidth - 1,(param2 + param1 - 112 / 2) / 112));
         var _loc3_:int = Math.max(0,Math.min(mapHeight - 1,(param2 - param1 + 112 / 2) / 112));
         if(_loc4_ < 0 || _loc4_ >= mapWidth || _loc3_ < 0 || _loc3_ > mapHeight)
         {
            return null;
         }
         return tiles[_loc4_ + _loc3_ * mapWidth];
      }
      
      public function getTile(param1:int, param2:int) : Tile
      {
         if(param1 < 0 || param1 >= mapWidth || param2 < 0 || param2 > mapHeight)
         {
            return null;
         }
         if(tiles[param1 + param2 * mapWidth].lockID == 100)
         {
            return null;
         }
         return tiles[param1 + param2 * mapWidth];
      }
      
      public function hypel(param1:Tile, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Tile = null;
         if(param1 == null)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  _loc3_ = getTile(param1.mapX + _loc6_ - 1,param1.mapY + _loc4_ - 1);
                  effectSprite.addChild(new HypelBlastEffect(this,_loc3_,param2,1000 * (_loc6_ + _loc4_ + _loc5_ * 3 + MathLibrary.randomize(0,2) * 0.5) / Math.max(1,8)));
                  _loc4_++;
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function blast(param1:Tile, param2:int) : void
      {
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < param2 / 2)
         {
            effectSprite.addChild(new OrbshellEffect(this,param1.getCanvasX(),param1.getCanvasY(),600 * _loc5_ / Math.max(1,param1.map.timeMultiplier)));
            _loc5_++;
         }
         var _loc4_:int = Math.min(param1.danger,param2);
         var _loc3_:String = "";
         if(_loc4_ > 0)
         {
            _loc3_ += "-" + _loc4_ + "Ä" + " ";
         }
         if(param1.mob != null)
         {
            param1.mob.health -= param2;
            _loc3_ += "-" + param2 + "Ø";
         }
         param1.danger -= _loc4_;
         if(_loc3_ != "")
         {
            param1.addFloatText(_loc3_);
         }
      }
      
      public function addKill(param1:int) : void
      {
         var _loc2_:int = 0;
         if(kills[param1] == null)
         {
            kills[param1] = 1;
         }
         else
         {
            kills[param1] += 1;
         }
         if(GameConfig.KONG_VERSION)
         {
            _loc2_ = 0;
            for(var _loc3_:String in kills)
            {
               _loc2_ += kills[_loc3_];
            }
            pgame.updateMostKills(_loc2_);
         }
      }
      
      public function fireball(param1:Tile, param2:Tile, param3:int) : void
      {
         var _loc6_:int = 0;
         if(param1 == null || param2 == null)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param3 / 2)
         {
            effectSprite.addChild(new FireballEffect(param1.map,param1.getCanvasX(),param1.getCanvasY(),param2.getCanvasX(),param2.getCanvasY(),600 * _loc6_ / Math.max(1,param1.map.timeMultiplier)));
            _loc6_++;
         }
         var _loc5_:int = Math.min(param2.danger,param3);
         var _loc4_:String = "";
         if(_loc5_ > 0)
         {
            _loc4_ += "-" + _loc5_ + "Ä" + " ";
         }
         if(param2.mob != null)
         {
            param2.mob.health -= param3;
            _loc4_ += "-" + param3 + "Ø";
         }
         param2.danger -= _loc5_;
         if(_loc4_ != "")
         {
            param2.addFloatText(_loc4_);
         }
      }
      
      public function zap(param1:Tile, param2:int, param3:int, param4:int = 100) : void
      {
         if(param1 == null)
         {
            return;
         }
         effectSprite.addChild(new SparkEffect(param1.map,param1.getCanvasX(),param1.getCanvasY()));
         var _loc6_:int = Math.min(param1.danger,param2);
         var _loc5_:String = "";
         if(_loc6_ > 0)
         {
            _loc5_ += "-" + _loc6_ + "Ä" + " ";
         }
         if(param1.mob != null)
         {
            param1.mob.health -= param2;
            param1.mob.zap(param3,param4);
            _loc5_ += "-" + param2 + "Ø";
         }
         param1.danger -= _loc6_;
         if(_loc5_ != "")
         {
            param1.addFloatText(_loc5_);
         }
      }
      
      public function shock(param1:int, param2:int, param3:int = 100) : void
      {
         var _loc7_:int = 0;
         var _loc6_:Tile = null;
         var _loc5_:int = 0;
         var _loc4_:String = null;
         if(pgame.shockLeft < 1)
         {
            return;
         }
         if(mobs.length < 1)
         {
            return;
         }
         pgame.shockLeft--;
         _loc7_ = 0;
         while(_loc7_ < mobs.length)
         {
            _loc6_ = mobs[_loc7_].tile;
            _loc5_ = Math.min(_loc6_.danger,param1);
            _loc4_ = "";
            effectSprite.addChild(new ShockEffect(_loc6_.map,_loc6_.getCanvasX(),_loc6_.getCanvasY()));
            if(_loc5_ > 0)
            {
               _loc4_ += "-" + _loc5_ + "Ä" + " ";
            }
            if(_loc6_.mob != null)
            {
               _loc6_.mob.health -= param1;
               _loc6_.mob.jam(param2,param3);
               _loc4_ += "-" + param1 + "Ø";
            }
            _loc6_.danger -= _loc5_;
            if(_loc4_ != "")
            {
               _loc6_.addFloatText(_loc4_);
            }
            _loc7_++;
         }
      }
      
      public function nox(param1:Tile, param2:int, param3:int, param4:Number) : void
      {
         if(param1 == null)
         {
            return;
         }
         effectSprite.addChild(new NoxEffect(param1.map,param1.getCanvasX(),param1.getCanvasY()));
         var _loc6_:int = Math.min(param1.danger,param2);
         var _loc5_:String = "";
         if(_loc6_ > 0)
         {
            _loc5_ += "-" + _loc6_ + "Ä" + " ";
         }
         if(param1.mob != null)
         {
            param1.mob.health -= param2;
            param1.mob.nox(param3,param4);
            _loc5_ += "-" + param2 + "Ø";
         }
         param1.danger -= _loc6_;
         if(_loc5_ != "")
         {
            param1.addFloatText(_loc5_);
         }
      }
      
      public function noxBomb(param1:int, param2:int, param3:Number) : void
      {
         var _loc7_:int = 0;
         var _loc6_:Tile = null;
         var _loc5_:int = 0;
         var _loc4_:String = null;
         if(pgame.noxLeft < 1)
         {
            return;
         }
         if(mobs.length < 1)
         {
            return;
         }
         pgame.noxLeft--;
         SoundLibrary.playSFX("poof");
         _loc7_ = 0;
         while(_loc7_ < mobs.length)
         {
            _loc6_ = mobs[_loc7_].tile;
            _loc5_ = Math.min(_loc6_.danger,param1);
            _loc4_ = "";
            effectSprite.addChild(new NoxEffect(_loc6_.map,_loc6_.getCanvasX(),_loc6_.getCanvasY()));
            if(_loc5_ > 0)
            {
               _loc4_ += "-" + _loc5_ + "Ä" + " ";
            }
            if(_loc6_.mob != null)
            {
               _loc6_.mob.health -= param1;
               _loc6_.mob.nox(param2,param3);
               _loc4_ += "-" + param1 + "Ø";
            }
            _loc6_.danger -= _loc5_;
            if(_loc4_ != "")
            {
               _loc6_.addFloatText(_loc4_);
            }
            _loc7_++;
         }
      }
      
      public function next() : void
      {
         act.next();
      }
      
      public function updateMap() : void
      {
         bMapChanged = true;
         mapHUD.bUpdateMiniMap = true;
      }
      
      public function load() : void
      {
         pgame.fadeIn(function():void
         {
            next();
            goToTile(tiles[startPoint]);
            bLoaded = true;
         });
      }
      
      // PeacefreeRevival: mute pauses the song and unmute continues it (to-do 7); the original
      // stopped it and started the next song on unmute. Skipping is nextBGM's.
      public function setEnableBGM(param1:Boolean) : void
      {
         this.bEnableBGM = param1;
         pgame.bEnabledBGM = param1;
         if(!param1)
         {
            SoundLibrary.pauseBGM();
         }
         else
         {
            SoundLibrary.resumeBGM();
            playBGM();
         }
      }

      // PeacefreeRevival: the options panel's Next button (to-do 7): the list's next song from
      // its start; with one song, that song again. Nothing while muted.
      public function nextBGM() : void
      {
         if(!bEnableBGM || bgList.length < 1)
         {
            return;
         }
         stopBGM();
         bgIndex = (bgIndex + 1) % bgList.length;
         playBGM();
      }

      public function playBGM() : void
      {
         if(!bEnableBGM || bgList.length < 1 || bPausedBGM || SoundLibrary.isBGMPlaying())
         {
            return;
         }
         if(bgIndex >= bgList.length)
         {
            bgIndex = 0;
         }
         SoundLibrary.playBGM(bgList[bgIndex],function():void
         {
            bgIndex = (bgIndex + 1) % bgList.length;
            playBGM();
         });
      }
      
      public function stopBGM() : void
      {
         SoundLibrary.stopBGM();
      }
      
      public function pauseBGM() : void
      {
         bPausedBGM = true;
         stopBGM();
      }
      
      public function unpauseBGM() : void
      {
         bPausedBGM = false;
      }
      
      public function showGameOver(param1:Boolean, param2:String) : void
      {
         var tween_mapHUD:Tween;
         var particleBackground:PDParticleSystem;
         var rewardImageName:String;
         var achievementSprite:Sprite;
         var medal3:Image;
         var medal2:Image;
         var medal1:Image;
         var difficultyRewardText:TextField;
         var medalQuad:Quad;
         var medalBust:Image;
         var tween_blackFilmQuad:Tween;
         var bVictory:Boolean = param1;
         var details:String = param2;
         stopBGM();
         if(bGameOver)
         {
            return;
         }
         this.bVictory = bVictory;
         bGameOver = true;
         if(bVictory)
         {
            pgame.updateLongestGame(int(days));
         }
         if(GAME_OVER_QUAD == null)
         {
            GAME_OVER_QUAD = Texture.fromColor(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,4278190080);
         }
         dialogueInterfacer.hide();
         tween_mapHUD = new Tween(mapHUD,0.5);
         tween_mapHUD.fadeTo(0);
         Starling.juggler.add(tween_mapHUD);
         blackFilmQuad = new HiddenClickable(GAME_OVER_QUAD);
         blackFilmQuad.alpha = 0;
         blackFilmQuad.x = 0;
         blackFilmQuad.y = 0;
         blackFilmQuad.releaseCallback = function():void
         {
            if(bCanExit)
            {
               pgame.goToCampaignScreen();
            }
         };
         addChild(blackFilmQuad);
         if(bVictory)
         {
            particleBackground = new PDParticleSystem(XML(new ParticleAssets.ParticleVictoryXML()),Assets.getAtlas().getTexture("particle"));
         }
         else
         {
            particleBackground = new PDParticleSystem(XML(new ParticleAssets.ParticleDefeatXML()),Assets.getAtlas().getTexture("particle"));
         }
         particleBackground.x = GameConfig.GAME_WIDTH / 2;
         particleBackground.y = GameConfig.GAME_HEIGHT / 2 - 100;
         Starling.juggler.add(particleBackground);
         rewardImageName = "defeat";
         if(bVictory)
         {
            rewardImageName = "victory";
         }
         addChild(particleBackground);
         particleBackground.start();
         resultImage = new Image(Assets.getAtlas().getTexture(rewardImageName));
         resultImage.scaleX = 2;
         resultImage.scaleY = 2;
         resultImage.x = 0 - resultImage.width;
         resultImage.y = GameConfig.GAME_HEIGHT / 2 - 250;
         resultImage.touchable = false;
         addChild(resultImage);
         gameOverDetailsLabel = new TextField(600,60,"",Fonts.getDefaultFont().fontName,28,16777215,true);
         gameOverDetailsLabel.x = GameConfig.GAME_WIDTH / 2 - 300;
         gameOverDetailsLabel.y = GameConfig.GAME_HEIGHT / 2 - 30;
         gameOverDetailsLabel.visible = false;
         gameOverDetailsLabel.vAlign = "top";
         gameOverDetailsLabel.hAlign = "center";
         gameOverDetailsLabel.touchable = false;
         gameOverDetailsLabel.text = details;
         gameOverDetailsLabel.autoScale = true;
         addChild(gameOverDetailsLabel);
         tapToExitLabel = new TextField(300,60,"Click to Continue",Fonts.getDefaultFont().fontName,36,16777215,true);
         tapToExitLabel.x = GameConfig.GAME_WIDTH / 2 - 150;
         tapToExitLabel.y = GameConfig.GAME_HEIGHT - 70;
         tapToExitLabel.visible = false;
         tapToExitLabel.vAlign = "top";
         tapToExitLabel.hAlign = "center";
         tapToExitLabel.touchable = false;
         addChild(tapToExitLabel);
         achievementSprite = new Sprite();
         achievementSprite.alpha = 0;
         achievementSprite.touchable = false;
         addChild(achievementSprite);
         medal3 = null;
         medal2 = null;
         medal1 = null;
         difficultyRewardText = null;
         if(bVictory)
         {
            medalQuad = new Quad(600,160,0);
            medalQuad.x = GameConfig.GAME_WIDTH / 2 - medalQuad.width / 2;
            medalQuad.y = GameConfig.GAME_HEIGHT - 240;
            medalQuad.alpha = 0.75;
            achievementSprite.addChild(medalQuad);
            medalBust = new Image(Assets.getAtlas().getTexture("medal_bust"));
            medalBust.x = GameConfig.GAME_WIDTH / 2 - medalBust.width * 0.5 - 130;
            medalBust.y = GameConfig.GAME_HEIGHT - 150;
            achievementSprite.addChild(medalBust);
            difficultyRewardText = new TextField(300,200,"Heroic\nAchievement",Fonts.getDefaultFont().fontName,40,16433664,true);
            difficultyRewardText.x = GameConfig.GAME_WIDTH / 2 - 58 + 90;
            difficultyRewardText.y = GameConfig.GAME_HEIGHT - 210;
            difficultyRewardText.vAlign = "top";
            difficultyRewardText.hAlign = "left";
            difficultyRewardText.touchable = false;
            difficultyRewardText.alpha = 0;
            achievementSprite.addChild(difficultyRewardText);
            switch(difficulty)
            {
               case 3:
                  medal3 = new Image(Assets.getAtlas().getTexture("gold_medal"));
                  medal3.x = GameConfig.GAME_WIDTH / 2 - 116 - 120;
                  medal3.y = GameConfig.GAME_HEIGHT - 220 - 10;
                  medal3.alpha = 0;
                  achievementSprite.addChild(medal3);
                  break;
               case 2:
                  medal2 = new Image(Assets.getAtlas().getTexture("gold_medal"));
                  medal2.x = GameConfig.GAME_WIDTH / 2 - 120;
                  medal2.y = GameConfig.GAME_HEIGHT - 220 - 10;
                  medal2.alpha = 0;
                  achievementSprite.addChild(medal2);
               case 0:
               case 1:
                  medal1 = new Image(Assets.getAtlas().getTexture("gold_medal"));
                  medal1.x = GameConfig.GAME_WIDTH / 2 - 58 - 120;
                  medal1.y = GameConfig.GAME_HEIGHT - 220;
                  medal1.alpha = 0;
                  achievementSprite.addChild(medal1);
            }
            switch(difficulty)
            {
               case 0:
                  difficultyRewardText.text = "Easy\nAchievement";
                  break;
               case 1:
                  difficultyRewardText.text = "Normal\nAchievement";
                  break;
               case 2:
                  difficultyRewardText.text = "Hard\nAchievement";
                  break;
               case 3:
                  difficultyRewardText.text = "Heroic\nAchievement";
            }
         }
         tween_blackFilmQuad = new Tween(blackFilmQuad,0.5);
         tween_blackFilmQuad.fadeTo(0.8);
         tween_blackFilmQuad.onComplete = function():void
         {
            var tween_resultImage:Tween = new Tween(resultImage,0.25);
            tween_resultImage.moveTo(GameConfig.GAME_WIDTH / 2 - resultImage.width / 2,GameConfig.GAME_HEIGHT / 2 - 250);
            tween_resultImage.onComplete = function():void
            {
               var tween_achievementSprite:Tween;
               if(bVictory)
               {
                  gameOverDetailsLabel.visible = true;
                  tween_achievementSprite = new Tween(achievementSprite,0.25);
                  tween_achievementSprite.fadeTo(1);
                  Starling.juggler.add(tween_achievementSprite);
                  if(medal3 != null)
                  {
                     setTimeout(function():void
                     {
                        var _loc1_:Tween = new Tween(medal3,0.25);
                        _loc1_.fadeTo(1);
                        Starling.juggler.add(_loc1_);
                     },150);
                  }
                  if(medal2 != null)
                  {
                     setTimeout(function():void
                     {
                        var _loc1_:Tween = new Tween(medal2,0.25);
                        _loc1_.fadeTo(1);
                        Starling.juggler.add(_loc1_);
                     },300);
                  }
                  if(medal1 != null)
                  {
                     setTimeout(function():void
                     {
                        var _loc1_:Tween = new Tween(medal1,0.25);
                        _loc1_.fadeTo(1);
                        Starling.juggler.add(_loc1_);
                     },450);
                  }
                  setTimeout(function():void
                  {
                     var _loc1_:Tween = new Tween(difficultyRewardText,0.25);
                     _loc1_.fadeTo(1);
                     Starling.juggler.add(_loc1_);
                  },600);
                  setTimeout(function():void
                  {
                     bCanExit = true;
                     tapToExitLabel.visible = true;
                  },1500);
               }
               else
               {
                  setTimeout(function():void
                  {
                     bCanExit = true;
                     tapToExitLabel.visible = true;
                  },1000);
               }
            };
            Starling.juggler.add(tween_resultImage);
         };
         Starling.juggler.add(tween_blackFilmQuad);
      }
      
      public function saveData(param1:String) : void
      {
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc7_:String = null;
         var _loc3_:Tile = null;
         var _loc5_:Object = {};
         var _loc8_:String = "";
         var _loc6_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < mapHeight)
         {
            _loc7_ = "";
            _loc12_ = 0;
            while(_loc12_ < mapWidth)
            {
               _loc3_ = tiles[_loc12_ + _loc9_ * mapWidth];
               _loc7_ += _loc3_.getData() + ";";
               if(_loc3_.mission != null)
               {
                  _loc6_.push(_loc3_.mission.getData());
               }
               _loc12_++;
            }
            if(_loc9_ > 0)
            {
               _loc8_ += "\n";
            }
            _loc8_ += _loc7_;
            _loc9_++;
         }
         var _loc10_:Array = [];
         _loc11_ = 0;
         while(_loc11_ < mobs.length)
         {
            if(Mob(mobs[_loc11_]).tile != null)
            {
               _loc10_.push(Mob(mobs[_loc11_]).getData());
            }
            _loc11_++;
         }
         var _loc2_:Array = [];
         _loc11_ = 0;
         while(_loc11_ < mobGenerators.length)
         {
            if(!MobGenerator(mobGenerators[_loc11_]).isTrash())
            {
               _loc2_.push(MobGenerator(mobGenerators[_loc11_]).getData());
            }
            _loc11_++;
         }
         var _loc4_:Object = {};
         _loc4_.act = act.getData();
         _loc4_.difficulty = difficulty;
         _loc4_.days = days;
         _loc4_.hours = hours;
         _loc4_.timerCounter = timerCounter;
         _loc4_.timeMultiplier = timeMultiplier;
         _loc4_.player = player.getData();
         _loc4_.mapHUD = mapHUD.getData();
         _loc4_.unlockIDs = unlockIDs;
         _loc4_.mapData = _loc8_;
         _loc4_.missionData = _loc6_;
         _loc4_.mobData = _loc10_;
         _loc4_.mobGenData = _loc2_;
         _loc4_.kills = kills;
         _loc4_.research = research.getData();
         _loc5_.data = {};
         _loc5_.data.gameData = JSON.stringify(_loc4_);
         FileLibrary.saveData(param1,_loc5_);
      }
      
      public function tradeFood(param1:int) : void
      {
         if(player.food >= param1)
         {
            deductFood(param1);
            addMinerals(param1 / 2);
            SoundLibrary.playSFX("aid");
         }
      }
      
      public function tradeMinerals(param1:int) : void
      {
         if(player.minerals >= param1)
         {
            deductMinerals(param1);
            addFood(param1 / 2);
            SoundLibrary.playSFX("aid");
         }
      }
      
      // PeacefreeRevival: the options panel's Controls page lists these keys
      // (OptionsInterfacer.CONTROLS); a changed key goes there too. They do nothing while the
      // panel is open (to-do 9): the mission is frozen then (progress), but they still acted
      // on it (Aid at once, the speed). onKeyUp still runs, so a held key isn't left pressed.
      public function onKeyDown(param1:KeyboardEvent) : void
      {
         if(bShowingOptions || !mapHUD.visible || mapHUD.alpha == 0)
         {
            return;
         }
         switch(param1.keyCode)
         {
            case 192:
               SoundLibrary.playSFX("click");
               selectTile(null);
               mapHUD.quickMissionInterfacer.hide();
               break;
            case 81:
               if(mapHUD.commandInterfacer.rushCommand.parent != null)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.commandInterfacer.rushCommand.releaseCallback();
               }
               break;
            case 70:
               if(mapHUD.commandInterfacer.aidCommand.parent != null)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.commandInterfacer.aidCommand.releaseCallback();
               }
               break;
            case 69:
               if(mapHUD.commandInterfacer.blastCommand.parent != null)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.commandInterfacer.blastCommand.releaseCallback();
               }
               break;
            case 82:
               if(mapHUD.commandInterfacer.zapCommand.parent != null)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.commandInterfacer.zapCommand.releaseCallback();
               }
               break;
            case 84:
               if(mapHUD.commandInterfacer.hypelCommand.parent != null)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.commandInterfacer.hypelCommand.releaseCallback();
               }
               break;
            case 71:
               SoundLibrary.playSFX("click");
               if(mapHUD.lastTile != null)
               {
                  mapHUD.setSelectedTile(null);
               }
               else if(mapHUD.quickMissionInterfacer.quickOptionPaneSprite.visible)
               {
                  mapHUD.quickMissionInterfacer.show();
               }
               else
               {
                  mapHUD.quickMissionInterfacer.hide();
               }
               break;
            case 88:
               if(!mapHUD.timeControlsSprite.visible)
               {
                  return;
               }
               SoundLibrary.playSFX("click");
               switch(timeMultiplier - 1)
               {
                  case 0:
                     mapHUD.pause();
                     break;
                  case 3:
                     mapHUD.changeSpeed(1);
                     break;
                  case 7:
                     mapHUD.changeSpeed(4);
               }
               break;
            case 67:
               if(!mapHUD.timeControlsSprite.visible)
               {
                  return;
               }
               SoundLibrary.playSFX("click");
               switch(timeMultiplier)
               {
                  case 0:
                     mapHUD.changeSpeed(1);
                     break;
                  case 1:
                     mapHUD.changeSpeed(4);
                     break;
                  case 4:
                     mapHUD.changeSpeed(8);
               }
               break;
            case 87:
            case 38:
               if(!mapHUD.miniMap.bEnableMovement)
               {
                  return;
               }
               bPressedUp = true;
               break;
            case 65:
            case 37:
               if(!mapHUD.miniMap.bEnableMovement)
               {
                  return;
               }
               bPressedLeft = true;
               break;
            case 83:
            case 40:
               if(!mapHUD.miniMap.bEnableMovement)
               {
                  return;
               }
               bPressedDown = true;
               break;
            case 68:
            case 39:
               if(!mapHUD.miniMap.bEnableMovement)
               {
                  return;
               }
               bPressedRight = true;
               break;
            case 32:
               if(!mapHUD.timeControlsSprite.visible)
               {
                  return;
               }
               SoundLibrary.playSFX("click");
               mapHUD.pause();
               break;
            case 49:
               if(mapHUD.num1Callback != null && mapHUD.num1Callback.bEnabled && mapHUD.num1Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num1Callback.releaseCallback();
               }
               break;
            case 50:
               if(mapHUD.num2Callback != null && mapHUD.num2Callback.bEnabled && mapHUD.num2Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num2Callback.releaseCallback();
               }
               break;
            case 51:
               if(mapHUD.num3Callback != null && mapHUD.num3Callback.bEnabled && mapHUD.num3Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num3Callback.releaseCallback();
               }
               break;
            case 52:
               if(mapHUD.num4Callback != null && mapHUD.num4Callback.bEnabled && mapHUD.num4Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num4Callback.releaseCallback();
               }
               break;
            case 53:
               if(mapHUD.num5Callback != null && mapHUD.num5Callback.bEnabled && mapHUD.num5Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num5Callback.releaseCallback();
               }
               break;
            case 54:
               if(mapHUD.num6Callback != null && mapHUD.num6Callback.bEnabled && mapHUD.num6Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num6Callback.releaseCallback();
               }
               break;
            case 55:
               if(mapHUD.num7Callback != null && mapHUD.num7Callback.bEnabled && mapHUD.num7Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num7Callback.releaseCallback();
               }
               break;
            case 56:
               if(mapHUD.num8Callback != null && mapHUD.num8Callback.bEnabled && mapHUD.num8Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num8Callback.releaseCallback();
               }
               break;
            case 57:
               if(mapHUD.num9Callback != null && mapHUD.num9Callback.bEnabled && mapHUD.num9Callback.visible)
               {
                  SoundLibrary.playSFX("click");
                  mapHUD.num9Callback.releaseCallback();
               }
         }
      }
      
      public function onKeyUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 87:
            case 38:
               bPressedUp = false;
               break;
            case 65:
            case 37:
               bPressedLeft = false;
               break;
            case 83:
            case 40:
               bPressedDown = false;
               break;
            case 68:
            case 39:
               bPressedRight = false;
         }
      }
      
      public function showOptionsInterface() : void
      {
         var tween_options:Tween;
         bShowingOptions = true;
         optionsInterfacer.alpha = 0;
         optionsInterfacer.refresh();
         addChild(optionsInterfacer);
         tween_options = new Tween(optionsInterfacer,0.5);
         tween_options.fadeTo(1);
         tween_options.onComplete = function():void
         {
            Starling.juggler.remove(tween_options);
         };
         Starling.juggler.add(tween_options);
      }
      
      public function hideOptionsInterface() : void
      {
         var tween_options:Tween = new Tween(optionsInterfacer,0.5);
         tween_options.fadeTo(0);
         tween_options.onComplete = function():void
         {
            Starling.juggler.remove(tween_options);
            removeChild(optionsInterfacer);
            bShowingOptions = false;
         };
         Starling.juggler.add(tween_options);
      }
      
      public function rememberPosition() : void
      {
         if(bRemembered)
         {
            return;
         }
         bRemembered = true;
         lastPosition.x = mapSprite.x;
         lastPosition.y = mapSprite.y;
      }
      
      public function recallPosition() : void
      {
         bRemembered = false;
         moveToCamera.x = lastPosition.x;
         moveToCamera.y = lastPosition.y;
         bUpdatedMoveToCamera = true;
      }
      
      public function updateTotalRescues() : void
      {
         if(act != null)
         {
            pgame.updateMostRescues(act.cache.rescue);
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(tiles != null)
         {
            tiles.splice(0);
         }
         if(mobs != null)
         {
            _loc1_ = 0;
            while(_loc1_ < mobs.length)
            {
               mobs[_loc1_].dispose();
               _loc1_++;
            }
            mobs.splice(0);
         }
         if(mobGenerators != null)
         {
            _loc1_ = 0;
            while(_loc1_ < mobGenerators.length)
            {
               mobGenerators[_loc1_].dispose();
               _loc1_++;
            }
            mobGenerators.splice(0);
         }
         if(unlockIDs != null)
         {
            unlockIDs.splice(0);
         }
         if(kills != null)
         {
            kills.splice(0);
         }
         if(bgList != null)
         {
            bgList.splice(0);
         }
         if(act != null)
         {
            act.dispose();
         }
         if(player != null)
         {
            player.dispose();
         }
         if(research != null)
         {
            research.dispose();
         }
         if(altStartPoints != null)
         {
            altStartPoints.splice(0);
         }
         tiles = null;
         player = null;
         mobSprite = null;
         effectSprite = null;
         mapSprite = null;
         mapHUD = null;
         dialogueInterfacer = null;
         selectedTile = null;
         mobs = null;
         mobGenerators = null;
         unlockIDs = null;
         act = null;
         moveToCamera = null;
         pgame = null;
         kills = null;
         bgList = null;
         blackFilmQuad = null;
         gameOverBg = null;
         resultImage = null;
         tapToExitLabel = null;
         gameOverDetailsLabel = null;
         research = null;
         optionsInterfacer = null;
         lastPosition = null;
         altStartPoints = null;
         super.dispose();
      }
      
      public function setZoom(param1:Number) : void
      {
         var _loc2_:Tile = getTileOn((-mapSprite.x + GameConfig.GAME_WIDTH / 2) * (1 / zoomScale),(-mapSprite.y + GameConfig.GAME_HEIGHT / 2) * (1 / zoomScale));
         zoomScale = param1;
         mapSprite.scaleX = zoomScale;
         mapSprite.scaleY = zoomScale;
         updateMap();
         zoomGoToTile = _loc2_;
      }
   }
}

