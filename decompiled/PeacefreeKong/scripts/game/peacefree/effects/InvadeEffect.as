package game.peacefree.effects
{
   import game.peacefree.GameEffect;
   import game.peacefree.Tile;
   import starling.core.Starling;
   import starling.display.MovieClip;
   
   public class InvadeEffect extends GameEffect
   {
      
      private var tile:Tile;
      
      private var image:MovieClip;
      
      public function InvadeEffect(param1:Tile)
      {
         super();
         this.tile = param1;
         touchable = false;
         image = new MovieClip(Assets.getAtlas().getTextures("effect_invade"));
         image.loop = true;
         image.y = 35;
         addChild(image);
         Starling.juggler.add(image);
         image.play();
      }
      
      public function updateFPS() : void
      {
         if(tile.map.timeMultiplier == 0)
         {
            image.pause();
         }
         else
         {
            if(!image.isPlaying)
            {
               image.play();
            }
            switch(tile.map.timeMultiplier - 1)
            {
               case 0:
                  image.fps = 12;
                  break;
               case 3:
                  image.fps = 24;
                  break;
               case 7:
                  image.fps = 48;
            }
         }
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
         tile = null;
         super.dispose();
      }
   }
}

