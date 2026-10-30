package game.peacefree.effects
{
   import game.peacefree.GameEffect;
   import game.peacefree.Tile;
   import starling.display.Image;
   
   public class TileEffect extends GameEffect
   {
      
      private var tile:Tile;
      
      private var image:Image;
      
      public var spriteName:String;
      
      public function TileEffect(param1:Tile, param2:String)
      {
         super();
         touchable = false;
         this.tile = param1;
         this.spriteName = param2;
         image = new Image(Assets.getAtlas().getTexture(param2));
         image.y = 125 - image.height;
         addChild(image);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         image = null;
         tile = null;
         super.dispose();
      }
   }
}

