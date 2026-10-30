package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class HypelBlastEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      public function HypelBlastEffect(param1:Map, param2:Tile, param3:int, param4:int = 0)
      {
         var map:Map = param1;
         var tile:Tile = param2;
         var blastDamage:int = param3;
         var delay:int = param4;
         super();
         touchable = false;
         setTimeout(function():void
         {
            var multiplier:Number;
            var tween_poof:Tween;
            if(tile == null)
            {
               return;
            }
            multiplier = 8;
            image = new MovieClip(Assets.getAtlas().getTextures("effect_hypel_blast"),12);
            image.alpha = 0;
            image.x = tile.getCanvasX() + 112 / 2 - image.width / 2;
            image.y = tile.getCanvasY() - 200 - 112;
            addChild(image);
            Starling.juggler.add(image);
            image.play();
            tween_poof = new Tween(image,1.5 / multiplier);
            tween_poof.fadeTo(1);
            tween_poof.moveTo(tile.getCanvasX() + 112 / 2 - image.width / 2,tile.getCanvasY() - 112);
            tween_poof.onComplete = function():void
            {
               Starling.juggler.remove(tween_poof);
               removeFromParent(true);
               map.effectSprite.addChild(new ExplosionEffect(map,tile));
               var _loc2_:int = Math.min(tile.danger,blastDamage);
               var _loc1_:String = "";
               if(_loc2_ > 0)
               {
                  _loc1_ += "-" + _loc2_ + "Ä" + " ";
               }
               if(tile.mob != null)
               {
                  tile.mob.health -= blastDamage;
                  _loc1_ += "-" + blastDamage + "Ø";
               }
               tile.danger -= _loc2_;
               if(_loc1_ != "")
               {
                  tile.addFloatText(_loc1_);
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

