package game.peacefree
{
   import starling.core.Starling;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class MiniMob extends Sprite
   {
      
      public var mob:Mob;
      
      private var mapScale:Number;
      
      private var redMarker:MovieClip;
      
      public function MiniMob(param1:Mob, param2:Number)
      {
         super();
         this.mob = param1;
         this.mapScale = param2;
         redMarker = new MovieClip(Assets.getAtlas().getTextures("redmarker"),8);
         redMarker.loop = true;
         redMarker.x = -2;
         redMarker.y = -2;
         addChild(redMarker);
         update();
      }
      
      public function update() : void
      {
         visible = mob.tile.isVisible();
         x = mob.tile.getCanvasX() * mapScale;
         y = mob.tile.getCanvasY() * mapScale;
         if(mob.tile.bSecured)
         {
            Starling.juggler.add(redMarker);
            redMarker.play();
         }
         else
         {
            Starling.juggler.remove(redMarker);
            redMarker.stop();
            redMarker.currentFrame = 0;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         mob = null;
         redMarker = null;
         super.dispose();
      }
   }
}

