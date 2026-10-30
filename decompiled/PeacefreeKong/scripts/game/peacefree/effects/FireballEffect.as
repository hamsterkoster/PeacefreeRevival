package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class FireballEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      private var origX:int;
      
      private var origY:int;
      
      public function FireballEffect(param1:Map, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         var toPosX:int = param4;
         var toPosY:int = param5;
         var delay:int = param6;
         super();
         touchable = false;
         setTimeout(function():void
         {
            var tween_Fireball:Tween;
            var multiplier:Number = Math.max(1,map.timeMultiplier);
            origX = posX - 5;
            origY = posY;
            image = new MovieClip(Assets.getAtlas().getTextures("effect_orbshell"),Math.max(1,24 * multiplier));
            image.loop = true;
            image.x = origX + 40;
            image.y = origY + 40;
            addChild(image);
            Starling.juggler.add(image);
            image.play();
            tween_Fireball = new Tween(image,1 / multiplier);
            tween_Fireball.moveTo(toPosX + 40,toPosY + 40);
            tween_Fireball.onComplete = function():void
            {
               Starling.juggler.remove(tween_Fireball);
               removeFromParent(true);
               try
               {
                  map.effectSprite.addChild(new PoofEffect(map,toPosX,toPosY));
               }
               catch(error:Error)
               {
               }
            };
            Starling.juggler.add(tween_Fireball);
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

