package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.library.MathLibrary;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class PoisonEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      public function PoisonEffect(param1:Map, param2:int, param3:int, param4:int = 0, param5:Function = null)
      {
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         var delay:int = param4;
         var callback:Function = param5;
         super();
         touchable = false;
         setTimeout(function():void
         {
            var tween_poof:Tween;
            var multiplier:Number = Math.max(1,map.timeMultiplier);
            image = new MovieClip(Assets.getAtlas().getTextures("effect_poof"),Math.max(1,1 * multiplier));
            image.loop = false;
            image.x = posX + 112 / 2 - image.width / 2;
            image.y = posY + 40;
            image.alpha = 0.5;
            image.color = 6971787;
            addChild(image);
            Starling.juggler.add(image);
            image.play();
            tween_poof = new Tween(image,4 / multiplier);
            tween_poof.fadeTo(0);
            tween_poof.moveTo(image.x - image.width / 2 + MathLibrary.randomize(-112,112),image.y - image.height / 2 + MathLibrary.randomize(-112,112));
            tween_poof.scaleTo(2);
            tween_poof.onComplete = function():void
            {
               Starling.juggler.remove(tween_poof);
               removeFromParent(true);
               if(callback != null)
               {
                  callback();
               }
            };
            Starling.juggler.add(tween_poof);
         },delay);
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

