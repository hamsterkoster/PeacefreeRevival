package game.peacefree.effects
{
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class RushEffect extends GameEffect
   {
      
      private var image:Image;
      
      private var origX:int;
      
      private var origY:int;
      
      public function RushEffect(param1:Map, param2:int, param3:int)
      {
         var tween_floatRush:Tween;
         var map:Map = param1;
         var posX:int = param2;
         var posY:int = param3;
         super();
         touchable = false;
         image = new Image(Assets.getAtlas().getTexture("effect_rush"));
         image.alpha = 0;
         image.x = posX + 112 / 2 - image.width / 2;
         image.y = posY + 112 / 2;
         addChild(image);
         origX = image.x;
         origY = image.y;
         tween_floatRush = new Tween(image,0.5);
         tween_floatRush.fadeTo(1);
         tween_floatRush.moveTo(origX,origY - 30);
         tween_floatRush.onComplete = function():void
         {
            Starling.juggler.remove(tween_floatRush);
            tween_floatRush = new Tween(image,0.5);
            tween_floatRush.fadeTo(0);
            tween_floatRush.moveTo(origX,origY - 60);
            tween_floatRush.onComplete = function():void
            {
               Starling.juggler.remove(tween_floatRush);
               removeFromParent(true);
            };
            Starling.juggler.add(tween_floatRush);
         };
         Starling.juggler.add(tween_floatRush);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         image = null;
         super.dispose();
      }
   }
}

