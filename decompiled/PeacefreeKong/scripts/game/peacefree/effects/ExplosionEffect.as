package game.peacefree.effects
{
   import flash.utils.setTimeout;
   import game.library.SoundLibrary;
   import game.peacefree.Building;
   import game.peacefree.GameEffect;
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.missions.InterceptMission;
   import game.peacefree.missions.InvadeMission;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class ExplosionEffect extends GameEffect
   {
      
      private var image:MovieClip;
      
      public function ExplosionEffect(param1:Map, param2:Tile, param3:int = 0, param4:Function = null)
      {
         var map:Map = param1;
         var tile:Tile = param2;
         var delay:int = param3;
         var callback:Function = param4;
         super();
         touchable = false;
         setTimeout(function():void
         {
            var multiplier:Number;
            var tween_poof:Tween;
            try
            {
               if(tile.building == null || tile.building.type != 300)
               {
                  tile.setBuilding(new Building(300,tile));
               }
               if(tile.mission != null && !(tile.mission is InvadeMission || tile.mission is InterceptMission))
               {
                  tile.removeInvadeEffect();
                  tile.removeMission();
               }
               if(!tile.map.bTDMode)
               {
                  map.unsecureTile(tile);
               }
            }
            catch(error:Error)
            {
            }
            multiplier = Math.max(1,map.timeMultiplier);
            image = new MovieClip(Assets.getAtlas().getTextures("effect_explosion"),Math.max(1,10 * multiplier));
            image.loop = false;
            image.x = tile.getCanvasX() + 112 / 2 - image.width / 2;
            image.y = tile.getCanvasY() - 20;
            addChild(image);
            Starling.juggler.add(image);
            image.play();
            tween_poof = new Tween(image,0.5);
            tween_poof.fadeTo(0);
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
         SoundLibrary.playSFX("fireshell");
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

