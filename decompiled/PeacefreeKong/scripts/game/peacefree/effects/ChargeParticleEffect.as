package game.peacefree.effects
{
   import game.library.MathLibrary;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class ChargeParticleEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      private var origX:int;
      
      private var origY:int;
      
      public function ChargeParticleEffect(param1:Map, param2:int, param3:int, param4:Number = 16711935)
      {
         var multiplier:Number;
         var tween_chargeParticle:Tween;
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         var color:Number = param4;
         super();
         touchable = false;
         multiplier = Math.max(1,map.timeMultiplier);
         origX = posX - 22;
         origY = posY;
         image = new MovieClip(Assets.getAtlas().getTextures("effect_orbshell"),Math.max(1,6 * multiplier));
         image.loop = false;
         image.x = origX + MathLibrary.randomize(-100,100);
         image.y = origY + MathLibrary.randomize(-100,100);
         image.alpha = 0.15;
         image.color = color;
         addChild(image);
         Starling.juggler.add(image);
         image.play();
         tween_chargeParticle = new Tween(image,2 / multiplier);
         tween_chargeParticle.moveTo(origX,origY);
         tween_chargeParticle.fadeTo(0.7);
         tween_chargeParticle.onComplete = function():void
         {
            Starling.juggler.remove(tween_chargeParticle);
            removeFromParent(true);
         };
         Starling.juggler.add(tween_chargeParticle);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(image != null)
         {
            image.stop();
            Starling.juggler.remove(image);
         }
         image = null;
         super.dispose();
      }
   }
}

