package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.library.SoundLibrary;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class SparkEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      public function SparkEffect(param1:Map, param2:int, param3:int, param4:Function = null)
      {
         var multiplier:Number;
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         var callback:Function = param4;
         super();
         touchable = false;
         multiplier = Math.max(1,map.timeMultiplier);
         image = new MovieClip(Assets.getAtlas().getTextures("effect_spark"),Math.max(24,Math.min(96,24 * multiplier)));
         image.loop = true;
         image.x = posX + 112 / 2 - image.width / 2;
         image.y = posY;
         addChild(image);
         Starling.juggler.add(image);
         image.play();
         setTimeout(function():void
         {
            if(callback != null)
            {
               callback();
            }
            removeFromParent(true);
         },2000 / multiplier);
         SoundLibrary.playSFX("zap");
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

