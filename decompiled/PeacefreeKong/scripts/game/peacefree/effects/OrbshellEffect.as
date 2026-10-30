package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class OrbshellEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      private var origX:int;
      
      private var origY:int;
      
      public function OrbshellEffect(param1:Map, param2:int, param3:int, param4:int)
      {
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         var delay:int = param4;
         super();
         touchable = false;
         setTimeout(function():void
         {
            var tween_smokePuff:Tween;
            var multiplier:Number = Math.max(1,map.timeMultiplier);
            origX = posX - 5;
            origY = posY;
            image = new MovieClip(Assets.getAtlas().getTextures("effect_orbshell"),Math.max(1,6 * multiplier));
            image.loop = false;
            image.x = origX;
            image.y = origY;
            addChild(image);
            Starling.juggler.add(image);
            image.play();
            tween_smokePuff = new Tween(image,1.5 / multiplier);
            tween_smokePuff.moveTo(origX + 40,origY + 40);
            tween_smokePuff.onComplete = function():void
            {
               Starling.juggler.remove(tween_smokePuff);
               removeFromParent(true);
               map.effectSprite.addChild(new PoofEffect(map,posX,posY));
            };
            Starling.juggler.add(tween_smokePuff);
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

