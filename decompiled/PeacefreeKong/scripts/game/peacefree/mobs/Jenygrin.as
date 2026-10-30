package game.peacefree.mobs
{
   import game.library.MathLibrary;
   import game.peacefree.Map;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   import game.peacefree.effects.ChargeParticleEffect;
   import game.peacefree.effects.PoofEffect;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Jenygrin extends Mob
   {
      
      private var bodySprite:Image;
      
      private var tweenHover:Tween;
      
      private var age:int = -1;
      
      private var arrMobs:Array = null;
      
      public function Jenygrin(param1:Tile, param2:int = 0, param3:int = -1, param4:Boolean = false)
      {
         super(param1,22,param4);
         if(param3 == -1)
         {
            switch(param2 - 1)
            {
               case 0:
                  param3 = 240000 * 0.5;
                  break;
               case 1:
                  param3 = 240000 * 1;
                  break;
               case 2:
                  param3 = 240000 * 2.5;
            }
         }
         else
         {
            this.extraCounter = param3;
         }
         init2();
         cycle = new Array(6,6,6,6,6,6,6,6,6,6,6,6,7);
         if(param1.map.mobs.length < 20)
         {
            waypoints = generateWaypoints();
         }
         if(param2 == 0 && param1.map.act != null)
         {
            param1.map.act.onNewSpawn(this);
         }
      }
      
      override protected function init() : void
      {
      }
      
      protected function init2() : void
      {
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
         checkAge(true);
         mobFPS = 6;
         updateFPS();
      }
      
      override public function progress(param1:int) : void
      {
         super.progress(param1);
         if(isDying() || isTrash())
         {
            return;
         }
         if(age < 3 && !bIntercepted)
         {
            extraCounter += param1;
            checkAge();
         }
      }
      
      private function checkAge(param1:Boolean = true) : void
      {
         if(extraCounter >= 240000 * 2.5)
         {
            if(age != 3)
            {
               age = 3;
               if(bodySprite != null)
               {
                  bodySprite.removeFromParent(true);
               }
               bodySprite = new Image(Assets.getAtlas().getTexture("mob_jenygrin_3"));
               bodySprite.x = 112 / 2 - bodySprite.width / 2;
               bodySprite.y = getFloat();
               shipSprite.addChild(bodySprite);
               if(param1)
               {
                  health = getMaxHealth();
               }
            }
         }
         else if(extraCounter >= 240000 * 1)
         {
            if(age != 2)
            {
               age = 2;
               if(bodySprite != null)
               {
                  bodySprite.removeFromParent(true);
               }
               bodySprite = new Image(Assets.getAtlas().getTexture("mob_jenygrin_2"));
               bodySprite.x = 112 / 2 - bodySprite.width / 2;
               bodySprite.y = getFloat();
               shipSprite.addChild(bodySprite);
               if(param1)
               {
                  health = getMaxHealth();
               }
            }
         }
         else if(extraCounter >= 240000 * 0.5)
         {
            if(age != 1)
            {
               age = 1;
               if(bodySprite != null)
               {
                  bodySprite.removeFromParent(true);
               }
               bodySprite = new Image(Assets.getAtlas().getTexture("mob_jenygrin_1"));
               bodySprite.x = 112 / 2 - bodySprite.width / 2;
               bodySprite.y = getFloat();
               shipSprite.addChild(bodySprite);
               if(param1)
               {
                  health = getMaxHealth();
               }
            }
         }
         else if(age != 0)
         {
            age = 0;
            if(bodySprite != null)
            {
               bodySprite.removeFromParent(true);
            }
            bodySprite = new Image(Assets.getAtlas().getTexture("mob_jenygrin_0"));
            bodySprite.x = 112 / 2 - bodySprite.width / 2;
            bodySprite.y = getFloat();
            shipSprite.addChild(bodySprite);
            if(param1)
            {
               health = getMaxHealth();
            }
         }
      }
      
      private function getMaxHealth() : int
      {
         switch(age - 1)
         {
            case 0:
               return 150;
            case 1:
               return 300;
            case 2:
               return 500;
            default:
               return 100;
         }
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
            if(shipSprite.scaleX < 1)
            {
               tweenHover = new Tween(shipSprite,2 / tile.map.timeMultiplier);
               tweenHover.moveTo(0,0);
               tweenHover.animate("scaleX",1);
               tweenHover.animate("scaleY",0.5);
            }
            else
            {
               tweenHover = new Tween(shipSprite,0.5 / tile.map.timeMultiplier);
               tweenHover.animate("scaleX",0.5);
               tweenHover.animate("scaleY",1);
               switch(age)
               {
                  case 0:
                     tweenHover.moveTo(bodySprite.width + 5,getAnimateFloat());
                     break;
                  case 1:
                     tweenHover.moveTo(bodySprite.width * 0.5 + 10,getAnimateFloat());
                     break;
                  case 2:
                     tweenHover.moveTo(bodySprite.width * 0.5 + 5,getAnimateFloat());
                     break;
                  default:
                     tweenHover.moveTo(bodySprite.width * 0.25 + 5,getAnimateFloat());
               }
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
      
      override public function refreshColors() : void
      {
         if(noxCounter > 0)
         {
            bodySprite.color = 12648192;
         }
         else
         {
            bodySprite.color = 16777215;
         }
      }
      
      override public function updateSprite() : void
      {
         refreshColors();
         updateFPS();
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
         poofCount = 5;
         switch(age - 1)
         {
            case 0:
               poofCount = 15;
               break;
            case 1:
               poofCount = 20;
               break;
            case 2:
               poofCount = 30;
         }
         if(poofCount > 1)
         {
            i = 0;
            while(i < poofCount)
            {
               tile.map.effectSprite.addChild(new PoofEffect(tile.map,position.x + MathLibrary.randomize(0,bodySprite.width / 2) - MathLibrary.randomize(0,bodySprite.width / 2),position.y + MathLibrary.randomize(0,bodySprite.height / 2) - MathLibrary.randomize(0,bodySprite.height / 2) - getFloat(),(i * 200 + 500) / Math.max(1,map.timeMultiplier)));
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
      
      private function generateWaypoints() : Array
      {
         var _loc3_:Array = [];
         var _loc2_:int = 3;
         _loc3_.push(tile.mapX + tile.mapY * tile.map.mapWidth);
         var _loc1_:int = tile.mapX + MathLibrary.randomize(-_loc2_,_loc2_);
         if(_loc1_ < tile.map.mapWidth)
         {
            _loc3_.push(_loc1_ + tile.mapY * tile.map.mapWidth);
         }
         _loc1_ = tile.mapX - MathLibrary.randomize(-_loc2_,_loc2_);
         if(_loc1_ >= 0)
         {
            _loc3_.push(_loc1_ + tile.mapY * tile.map.mapWidth);
         }
         _loc1_ = tile.mapY + MathLibrary.randomize(-_loc2_,_loc2_);
         if(_loc1_ < tile.map.mapHeight)
         {
            _loc3_.push(tile.mapX + _loc1_ * tile.map.mapWidth);
         }
         _loc1_ = tile.mapY - MathLibrary.randomize(-_loc2_,_loc2_);
         if(_loc1_ >= 0)
         {
            _loc3_.push(tile.mapX + _loc1_ * tile.map.mapWidth);
         }
         _loc3_.push(-3);
         return _loc3_;
      }
      
      override public function onDeath() : void
      {
         super.onDeath();
         switch(age - 1)
         {
            case 0:
               addMinerals(120);
               break;
            case 1:
               addMinerals(80);
               break;
            case 2:
               addMinerals(50);
               break;
            default:
               addMinerals(20);
         }
      }
      
      override protected function performAction() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Mob = null;
         if(tile.map.mobs.length >= 50)
         {
            return;
         }
         if(age < 3)
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
         var _loc2_:int = 1;
         _loc4_ = 0;
         while(_loc4_ < 1 + 2 * _loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < 1 + 2 * _loc2_)
            {
               _loc1_ = checkMobAt(tile.mapX - _loc2_ + _loc4_,tile.mapY - _loc2_ + _loc3_);
               if(_loc1_ != null)
               {
                  arrMobs.push(_loc1_);
               }
               _loc3_++;
            }
            _loc4_++;
         }
         if(arrMobs.length < 6)
         {
            tile.map.addMob(new Jenygrin(tile));
         }
      }
      
      override public function makeChargeParticle() : void
      {
         if(age < 3)
         {
            return;
         }
         tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY(),31999));
      }
      
      override public function getFloat() : int
      {
         switch(age - 3)
         {
            case 0:
               return -20;
            default:
               return 40;
         }
      }
      
      override public function getMarkerFloat() : int
      {
         return -10;
      }
      
      private function getAnimateFloat() : int
      {
         switch(age)
         {
            case 0:
               return -40;
            case 1:
               return -90;
            case 2:
               return -100;
            default:
               return -70;
         }
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
         bodySprite = null;
         tweenHover = null;
         arrMobs = null;
         super.dispose();
      }
   }
}

