package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class SmokePuffEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      private var origX:int;
      
      private var origY:int;
      
      public function SmokePuffEffect(param1:Map, param2:int, param3:int, param4:int = 0)
      {
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         var timeout:int = param4;
         super();
         this.origX = posX;
         this.origY = posY;
         touchable = false;
         setTimeout(function():void
         {
            var tween_smokePuff:Tween;
            var multiplier:Number = Math.max(1,map.timeMultiplier);
            image = new MovieClip(Assets.getAtlas().getTextures("effect_smoke_puff"),Math.max(1,4 * multiplier));
            image.loop = false;
            image.x = posX;
            image.y = posY;
            addChild(image);
            Starling.juggler.add(image);
            image.play();
            tween_smokePuff = new Tween(image,2 / multiplier);
            tween_smokePuff.fadeTo(0);
            tween_smokePuff.moveTo(origX + 30,origY - 40);
            tween_smokePuff.onComplete = function():void
            {
               Starling.juggler.remove(tween_smokePuff);
               removeFromParent(true);
            };
            Starling.juggler.add(tween_smokePuff);
         },timeout);
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

