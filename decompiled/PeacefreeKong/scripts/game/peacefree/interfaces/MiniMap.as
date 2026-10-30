package game.peacefree.interfaces
{
   import flash.geom.Point;
   import game.container.GameConfig;
   import game.interfaces.clickables.HiddenClickable;
   import game.peacefree.Map;
   import game.peacefree.MiniMissionObjective;
   import game.peacefree.MiniMob;
   import game.peacefree.MiniTile;
   import game.peacefree.MissionObjective;
   import game.peacefree.Mob;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.text.TextField;
   import starling.textures.RenderTexture;
   import starling.textures.Texture;
   
   public class MiniMap extends HiddenClickable
   {
      
      public static const USE_RENDER_TEXTURE:Boolean = false;
      
      public var bEnableMovement:Boolean = true;
      
      private var miniTiles:Array;
      
      private var map:Map;
      
      private var miniMapSprite:Sprite;
      
      private var miniMobSprite:Sprite;
      
      private var miniObjectiveSprite:Sprite;
      
      public var cursor:Sprite;
      
      private var mapScale:Number = 0.05;
      
      private var renderTexture:RenderTexture;
      
      private var miniMapImage:Image;
      
      private var bUpdate:Boolean = false;
      
      private var updateTimeout:int = 0;
      
      public var northHotkey:TextField;
      
      public var westHotkey:TextField;
      
      public var eastHotkey:TextField;
      
      public var southHotkey:TextField;
      
      private var quad1:Quad;
      
      private var quad2:Quad;
      
      private var quad3:Quad;
      
      private var quad4:Quad;
      
      public function MiniMap()
      {
         var blackQuad:Image;
         var zoomInButton:GenericScreenButton;
         var zoomOutButton:GenericScreenButton;
         super(Texture.fromColor(155,160,2003199590));
         pressedCallback = onPressed;
         dragCallback = onPressed;
         blackQuad = new Image(Texture.fromColor(151,156,4278190080));
         blackQuad.x = 2;
         blackQuad.y = 2;
         addChild(blackQuad);
         miniMapSprite = new Sprite();
         miniMapSprite.x = 3 + 1400 * mapScale;
         miniMapSprite.y = 10;
         addChild(miniMapSprite);
         miniObjectiveSprite = new Sprite();
         miniObjectiveSprite.x = 3 + 1400 * mapScale;
         miniObjectiveSprite.y = 10;
         addChild(miniObjectiveSprite);
         miniMobSprite = new Sprite();
         miniMobSprite.x = 3 + 1400 * mapScale;
         miniMobSprite.y = 10;
         addChild(miniMobSprite);
         cursor = new Sprite();
         cursor.alpha = 0.5;
         quad1 = new Quad(GameConfig.GAME_WIDTH * mapScale,1,65290);
         quad1.x = 0;
         quad1.y = 0;
         quad2 = new Quad(GameConfig.GAME_WIDTH * mapScale,1,65290);
         quad2.x = 0;
         quad2.y = GameConfig.GAME_HEIGHT * mapScale;
         quad3 = new Quad(1,GameConfig.GAME_HEIGHT * mapScale + 1,65290);
         quad3.x = 0;
         quad3.y = 0;
         quad4 = new Quad(1,GameConfig.GAME_HEIGHT * mapScale + 1,65290);
         quad4.x = GameConfig.GAME_WIDTH * mapScale;
         quad4.y = 0;
         cursor.addChild(quad1);
         cursor.addChild(quad2);
         cursor.addChild(quad3);
         cursor.addChild(quad4);
         addChild(cursor);
         northHotkey = new TextField(30,30,"[W]",Fonts.getDefaultFont().fontName,12,65290,true);
         northHotkey.x = 60;
         northHotkey.y = -7;
         northHotkey.vAlign = "center";
         northHotkey.hAlign = "center";
         northHotkey.touchable = false;
         northHotkey.alpha = 0.25;
         addChild(northHotkey);
         westHotkey = new TextField(30,30,"[A]",Fonts.getDefaultFont().fontName,12,65290,true);
         westHotkey.x = -5;
         westHotkey.y = 62;
         westHotkey.vAlign = "center";
         westHotkey.hAlign = "center";
         westHotkey.touchable = false;
         westHotkey.alpha = 0.25;
         addChild(westHotkey);
         eastHotkey = new TextField(30,30,"[D]",Fonts.getDefaultFont().fontName,12,65290,true);
         eastHotkey.x = 130;
         eastHotkey.y = 62;
         eastHotkey.vAlign = "center";
         eastHotkey.hAlign = "center";
         eastHotkey.touchable = false;
         eastHotkey.alpha = 0.25;
         addChild(eastHotkey);
         southHotkey = new TextField(30,30,"[S]",Fonts.getDefaultFont().fontName,12,65290,true);
         southHotkey.x = 60;
         southHotkey.y = 135;
         southHotkey.vAlign = "center";
         southHotkey.hAlign = "center";
         southHotkey.touchable = false;
         southHotkey.alpha = 0.25;
         addChild(southHotkey);
         zoomInButton = new GenericScreenButton(20,20,"+");
         zoomInButton.x = 0;
         zoomInButton.y = -25;
         zoomInButton.bChangeAlpha = false;
         zoomInButton.alpha = 0.25;
         zoomInButton.pressedCallback = function():void
         {
            if(map.zoomScale < 1)
            {
               map.setZoom(map.zoomScale + 0.1);
            }
            if(map.zoomScale < 1)
            {
               zoomInButton.alpha = 1;
            }
            else
            {
               zoomInButton.alpha = 0.25;
            }
            zoomOutButton.alpha = 1;
         };
         addChild(zoomInButton);
         zoomOutButton = new GenericScreenButton(20,20,"-");
         zoomOutButton.x = 25;
         zoomOutButton.y = -25;
         zoomOutButton.bChangeAlpha = false;
         zoomOutButton.pressedCallback = function():void
         {
            if(map.zoomScale > 0.6)
            {
               map.setZoom(map.zoomScale - 0.1);
            }
            if(map.zoomScale > 0.6)
            {
               zoomOutButton.alpha = 1;
            }
            else
            {
               zoomOutButton.alpha = 0.25;
            }
            zoomInButton.alpha = 1;
         };
         addChild(zoomOutButton);
      }
      
      public function setMap(param1:Map) : void
      {
         var _loc2_:int = 0;
         this.map = param1;
         miniTiles = [];
         _loc2_ = 0;
         while(_loc2_ < param1.tiles.length)
         {
            if(param1.tiles != null)
            {
               miniTiles[_loc2_] = new MiniTile(param1.tiles[_loc2_],mapScale,0);
               miniMapSprite.addChild(miniTiles[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public function update() : void
      {
         bUpdate = true;
         quad1.width = GameConfig.GAME_WIDTH * mapScale * (1 / map.zoomScale);
         quad2.y = GameConfig.GAME_HEIGHT * mapScale * (1 / map.zoomScale);
         quad2.width = GameConfig.GAME_WIDTH * mapScale * (1 / map.zoomScale);
         quad3.height = 1 + GameConfig.GAME_HEIGHT * mapScale * (1 / map.zoomScale);
         quad4.height = 1 + GameConfig.GAME_HEIGHT * mapScale * (1 / map.zoomScale);
         quad4.x = GameConfig.GAME_WIDTH * mapScale * (1 / map.zoomScale);
      }
      
      public function addMob(param1:Mob) : void
      {
         var _loc2_:MiniMob = new MiniMob(param1,mapScale);
         miniMobSprite.addChild(_loc2_);
      }
      
      public function addMissionObjective(param1:MissionObjective) : void
      {
         var _loc2_:MiniMissionObjective = new MiniMissionObjective(param1,mapScale);
         miniObjectiveSprite.addChild(_loc2_);
      }
      
      public function progress(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:MiniMob = null;
         var _loc2_:MiniMissionObjective = null;
         if(bUpdate)
         {
            updateTimeout -= param1;
            if(updateTimeout < 1)
            {
               miniMapSprite.unflatten();
               _loc4_ = int(miniTiles.length);
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  miniTiles[_loc6_].update();
                  _loc6_++;
               }
               miniMapSprite.flatten();
               bUpdate = false;
               updateTimeout += 2000;
            }
         }
         var _loc5_:int = miniMobSprite.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = MiniMob(miniMobSprite.getChildAt(_loc6_));
            _loc3_.update();
            if(_loc3_.mob.isTrash())
            {
               _loc3_.removeFromParent(true);
               _loc6_--;
               _loc5_ = miniMobSprite.numChildren;
            }
            _loc6_++;
         }
         _loc5_ = miniObjectiveSprite.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = MiniMissionObjective(miniObjectiveSprite.getChildAt(_loc6_));
            _loc2_.update();
            if(_loc2_.missionObjective.isTrash())
            {
               _loc2_.removeFromParent(true);
               _loc6_--;
               _loc5_ = miniObjectiveSprite.numChildren;
            }
            _loc6_++;
         }
      }
      
      public function updateCursor() : void
      {
         cursor.x = (-map.mapSprite.x * (1 / map.zoomScale) + 1400) * mapScale + 3;
         cursor.y = -map.mapSprite.y * (1 / map.zoomScale) * mapScale + 10;
      }
      
      public function onPressed(param1:TouchEvent) : void
      {
         if(!bEnableMovement)
         {
            return;
         }
         var _loc6_:Touch = param1.getTouch(this);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:Point = _loc6_.getLocation(this);
         if(_loc3_.y < 0)
         {
            return;
         }
         var _loc5_:int = map.mapWidth * 112 * map.zoomScale;
         var _loc9_:int = 151;
         var _loc7_:int = map.mapHeight * 112 * map.zoomScale;
         var _loc8_:int = 156;
         var _loc2_:int = GameConfig.GAME_WIDTH * mapScale * (1 / map.zoomScale);
         var _loc4_:int = GameConfig.GAME_HEIGHT * mapScale * (1 / map.zoomScale);
         map.goToCamera(-((_loc3_.x - _loc2_ / 2) / _loc9_ * _loc5_) + _loc5_ / 2,-(_loc3_.y - _loc4_ / 2) / _loc8_ * _loc7_ + _loc8_);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(miniTiles != null)
         {
            miniTiles.splice(0);
         }
         miniTiles = null;
         map = null;
         miniMapSprite = null;
         miniMobSprite = null;
         miniObjectiveSprite = null;
         cursor = null;
         renderTexture = null;
         miniMapImage = null;
         northHotkey = null;
         eastHotkey = null;
         westHotkey = null;
         southHotkey = null;
         super.dispose();
      }
   }
}

