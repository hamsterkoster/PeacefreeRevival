package game.peacefree.mobs
{
   import game.library.MathLibrary;
   import game.library.SoundLibrary;
   import game.peacefree.Map;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   import game.peacefree.effects.ChargeParticleEffect;
   import game.peacefree.effects.PoofEffect;
   import game.peacefree.effects.SparkEffect;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class GiasRobo extends Mob
   {
      
      private var tweenHover:Tween;
      
      private var arrMobs:Array = null;
      
      public function GiasRobo(param1:Tile, param2:Boolean = false)
      {
         super(param1,23,param2);
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         sprites = new Array(4);
         sprites[0] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 0 + "_"));
         sprites[1] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 1 + "_"));
         sprites[2] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 2 + "_"));
         sprites[3] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type + "_" + 3 + "_"));
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
         while(_loc1_ < sprites.length)
         {
            sprites[_loc1_].x = 112 / 2 - sprites[_loc1_].width / 2;
            sprites[_loc1_].y = getFloat();
            _loc1_++;
         }
         shipSprite.addChild(sprites[direction]);
         mobFPS = 6;
         updateFPS();
         cycle = new Array(6,6,7);
         waypoints = generateWaypoints();
      }
      
      private function animateBody() : void
      {
         try
         {
            if(tweenHover != null)
            {
               return;
            }
            if(tile == null)
            {
               return;
            }
            tweenHover = new Tween(shipSprite,5 / tile.map.timeMultiplier);
            if(shipSprite.y < 0)
            {
               tweenHover.moveTo(0,0);
            }
            else
            {
               tweenHover.moveTo(0,-20);
            }
            tweenHover.onComplete = function():void
            {
               tweenHover = null;
               animateBody();
            };
            Starling.juggler.add(tweenHover);
         }
         catch(error:Error)
         {
         }
      }
      
      override public function updateFPS() : void
      {
         var _loc1_:Number = NaN;
         if(tile.map.timeMultiplier == 0)
         {
            if(tweenHover != null)
            {
               Starling.juggler.remove(tweenHover);
               tweenHover = null;
            }
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
            animateBody();
         }
      }
      
      override public function die() : void
      {
         var map:Map;
         var poofCount:int;
         var i:int;
         if(isTrash() || isDying())
         {
            return;
         }
         map = tile.map;
         poofCount = 50;
         addMinerals(250);
         if(poofCount > 1)
         {
            i = 0;
            while(i < poofCount)
            {
               tile.map.effectSprite.addChild(new PoofEffect(tile.map,position.x + MathLibrary.randomize(0,shipSprite.width / 2) - MathLibrary.randomize(0,shipSprite.width / 2),position.y + MathLibrary.randomize(0,shipSprite.height / 2) - MathLibrary.randomize(0,shipSprite.height / 2) + getFloat(),(i * 200 + 500) / Math.max(1,map.timeMultiplier)));
               i = i + 1;
            }
         }
         tile.map.effectSprite.addChild(new PoofEffect(tile.map,tile.getCanvasX(),tile.getCanvasY() + getFloat(),(poofCount * 200 + 500) / Math.max(1,map.timeMultiplier),function():void
         {
            onDeath();
            trash();
         }));
         if(tile.mission != null)
         {
            tile.setMission(null);
         }
         bDying = true;
      }
      
      override protected function performAction() : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Mob = null;
         var _loc4_:Map = null;
         var _loc1_:Tile = null;
         if(tile.map.mobs.length >= 50)
         {
            return;
         }
         if(arrMobs == null)
         {
            arrMobs = [];
         }
         else
         {
            arrMobs.splice(0);
         }
         var _loc6_:int = 3;
         var _loc5_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc8_ = 0;
         while(_loc8_ < 1 + 2 * _loc6_)
         {
            _loc7_ = 0;
            while(_loc7_ < 1 + 2 * _loc6_)
            {
               _loc2_ = checkMobAt(tile.mapX - _loc6_ + _loc8_,tile.mapY - _loc6_ + _loc7_);
               if(_loc2_ != null)
               {
                  if(_loc2_.type == 24)
                  {
                     _loc5_ = true;
                  }
                  else if(_loc2_.type == 25)
                  {
                     _loc3_ = true;
                  }
                  arrMobs.push(_loc2_);
               }
               _loc7_++;
            }
            _loc8_++;
         }
         if(_loc5_ && _loc3_)
         {
            _loc4_ = tile.map;
            if(_loc4_.getTile(tile.mapX - 1,tile.mapY) != null)
            {
               _loc1_ = _loc4_.getTile(tile.mapX - 1,tile.mapY);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc4_.effectSprite.addChild(new SparkEffect(_loc4_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc4_.getTile(tile.mapX + 1,tile.mapY) != null)
            {
               _loc1_ = _loc4_.getTile(tile.mapX + 1,tile.mapY);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc4_.effectSprite.addChild(new SparkEffect(_loc4_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc4_.getTile(tile.mapX,tile.mapY - 1) != null)
            {
               _loc1_ = _loc4_.getTile(tile.mapX,tile.mapY - 1);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc4_.effectSprite.addChild(new SparkEffect(_loc4_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc4_.getTile(tile.mapX,tile.mapY + 1) != null)
            {
               _loc1_ = _loc4_.getTile(tile.mapX,tile.mapY + 1);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc4_.effectSprite.addChild(new SparkEffect(_loc4_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
            if(_loc4_.getTile(tile.mapX,tile.mapY) != null)
            {
               _loc1_ = _loc4_.getTile(tile.mapX,tile.mapY);
               if(_loc1_.building != null)
               {
                  _loc1_.building.offlineCounter = 240000 / 6;
               }
               _loc4_.effectSprite.addChild(new SparkEffect(_loc4_,_loc1_.getCanvasX(),_loc1_.getCanvasY()));
            }
         }
         else
         {
            if(!_loc5_)
            {
               tile.map.addMob(new GiasRoboHand(tile,24));
            }
            if(!_loc3_)
            {
               tile.map.addMob(new GiasRoboHand(tile,25));
            }
         }
      }
      
      private function generateWaypoints() : Array
      {
         var _loc3_:Array = [];
         var _loc2_:int = 4;
         _loc3_.push(tile.mapX + tile.mapY * tile.map.mapWidth);
         var _loc1_:int = tile.mapX + MathLibrary.randomize(0,_loc2_);
         if(_loc1_ < tile.map.mapWidth)
         {
            _loc3_.push(_loc1_ + tile.mapY * tile.map.mapWidth);
         }
         _loc1_ = tile.mapX - MathLibrary.randomize(0,_loc2_);
         if(_loc1_ >= 0)
         {
            _loc3_.push(_loc1_ + tile.mapY * tile.map.mapWidth);
         }
         _loc1_ = tile.mapY + MathLibrary.randomize(0,_loc2_);
         if(_loc1_ < tile.map.mapHeight)
         {
            _loc3_.push(tile.mapX + _loc1_ * tile.map.mapWidth);
         }
         _loc1_ = tile.mapY - MathLibrary.randomize(0,_loc2_);
         if(_loc1_ >= 0)
         {
            _loc3_.push(tile.mapX + _loc1_ * tile.map.mapWidth);
         }
         _loc3_.push(-3);
         return _loc3_;
      }
      
      override public function makeChargeParticle() : void
      {
         tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY(),10723120));
         SoundLibrary.playSFX("charging");
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(tweenHover != null)
         {
            Starling.juggler.remove(tweenHover);
         }
         if(arrMobs != null)
         {
            arrMobs.splice(0);
         }
         tweenHover = null;
         arrMobs = null;
         super.dispose();
      }
   }
}

