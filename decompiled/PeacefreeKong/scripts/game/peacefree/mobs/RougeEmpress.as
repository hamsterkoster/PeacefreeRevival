package game.peacefree.mobs
{
   import game.container.Tracer;
   import game.library.MathLibrary;
   import game.library.SoundLibrary;
   import game.peacefree.Map;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   import game.peacefree.effects.ChargeParticleEffect;
   import game.peacefree.effects.PoofEffect;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.utils.deg2rad;
   
   public class RougeEmpress extends Mob
   {
      
      private var leftWingSprite:Image;
      
      private var rightWingSprite:Image;
      
      private var downBodySprite:Image;
      
      private var upBodySprite:Image;
      
      private var tweenHover:Tween;
      
      private var tweenLeftWing:Tween;
      
      private var tweenRightWing:Tween;
      
      private var bFlappingUp:Boolean = false;
      
      public function RougeEmpress(param1:Tile, param2:Boolean = false)
      {
         super(param1,21,param2);
      }
      
      override protected function init() : void
      {
         leftWingSprite = new Image(Assets.getAtlas().getTexture("mob_empress_wing_1"));
         leftWingSprite.pivotX = leftWingSprite.width - 10;
         leftWingSprite.pivotY = leftWingSprite.height - 10;
         leftWingSprite.x = 40;
         leftWingSprite.y = -20;
         leftWingSprite.alpha = 0.75;
         rightWingSprite = new Image(Assets.getAtlas().getTexture("mob_empress_wing_1"));
         rightWingSprite.pivotX = leftWingSprite.width - 10;
         rightWingSprite.pivotY = leftWingSprite.height - 10;
         rightWingSprite.x = 70;
         rightWingSprite.y = -20;
         rightWingSprite.scaleX = -1;
         rightWingSprite.alpha = 0.75;
         downBodySprite = new Image(Assets.getAtlas().getTexture("mob_empress_1"));
         upBodySprite = new Image(Assets.getAtlas().getTexture("mob_empress_2"));
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
         downBodySprite.x = 112 / 2 - downBodySprite.width / 2;
         downBodySprite.y = getFloat();
         upBodySprite.x = 112 / 2 - upBodySprite.width / 2;
         upBodySprite.y = getFloat();
         shipSprite.addChild(leftWingSprite);
         shipSprite.addChild(rightWingSprite);
         shipSprite.addChild(downBodySprite);
         mobFPS = 6;
         updateFPS();
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
      
      private function animateWings() : void
      {
         try
         {
            if(tweenLeftWing != null)
            {
               return;
            }
            if(tile == null)
            {
               return;
            }
            bFlappingUp = !bFlappingUp;
            tweenLeftWing = new Tween(leftWingSprite,0.25 / tile.map.timeMultiplier);
            if(bFlappingUp)
            {
               tweenLeftWing.animate("rotation",deg2rad(65));
            }
            else
            {
               tweenLeftWing.animate("rotation",-deg2rad(65));
            }
            tweenLeftWing.onComplete = function():void
            {
               tweenLeftWing = null;
               tweenRightWing = null;
               animateWings();
            };
            Starling.juggler.add(tweenLeftWing);
            tweenRightWing = new Tween(rightWingSprite,0.25 / tile.map.timeMultiplier);
            if(bFlappingUp)
            {
               tweenRightWing.animate("rotation",-deg2rad(65));
            }
            else
            {
               tweenRightWing.animate("rotation",deg2rad(65));
            }
            Starling.juggler.add(tweenRightWing);
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
            if(tweenLeftWing != null)
            {
               Starling.juggler.remove(tweenLeftWing);
               tweenLeftWing = null;
            }
            if(tweenRightWing != null)
            {
               Starling.juggler.remove(tweenRightWing);
               tweenRightWing = null;
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
            animateWings();
         }
      }
      
      override public function refreshColors() : void
      {
         if(noxCounter > 0)
         {
            downBodySprite.color = 12648192;
            upBodySprite.color = 12648192;
         }
         else
         {
            downBodySprite.color = 16777215;
            upBodySprite.color = 16777215;
         }
      }
      
      override public function updateSprite() : void
      {
         if(direction == 2 || direction == 1)
         {
            shipSprite.addChildAt(upBodySprite,0);
            shipSprite.removeChild(downBodySprite);
         }
         else
         {
            shipSprite.addChild(downBodySprite);
            shipSprite.removeChild(upBodySprite);
         }
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
         poofCount = 50;
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
         if(tile.map.mobs.length >= 50)
         {
            return;
         }
         var _loc1_:Number = 1;
         switch(tile.map.difficulty)
         {
            case 0:
               _loc1_ = 0.2;
               break;
            case 1:
               _loc1_ = 1;
               break;
            case 2:
               _loc1_ = 1.5;
               break;
            case 3:
               _loc1_ = 2;
         }
         Tracer.trace(health + " " + _loc1_);
         if(health > 500 * _loc1_ && tile.map.days < 5)
         {
            tile.map.addMob(new Mob(tile,17));
         }
         else if(health > 400 * _loc1_ && tile.map.days < 10)
         {
            tile.map.addMob(new Mob(tile,18));
         }
         else if(health > 300 * _loc1_ && tile.map.days < 15)
         {
            tile.map.addMob(new Mob(tile,19));
         }
         else
         {
            tile.map.addMob(new Mob(tile,20));
         }
      }
      
      override public function makeChargeParticle() : void
      {
         tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY()));
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
         if(tweenLeftWing != null)
         {
            Starling.juggler.remove(tweenLeftWing);
         }
         if(tweenRightWing != null)
         {
            Starling.juggler.remove(tweenRightWing);
         }
         leftWingSprite = null;
         rightWingSprite = null;
         downBodySprite = null;
         upBodySprite = null;
         tweenHover = null;
         tweenLeftWing = null;
         tweenRightWing = null;
         super.dispose();
      }
   }
}

