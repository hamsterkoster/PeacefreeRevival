package game.peacefree
{
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MiniTile extends Sprite
   {
      
      private var tile:Tile = null;
      
      private var tileSprite:Image;
      
      private var buildingSprite:Image;
      
      private var mapScale:Number;
      
      private var offset:int;
      
      public function MiniTile(param1:Tile, param2:Number, param3:int)
      {
         super();
         this.tile = param1;
         this.mapScale = param2;
         this.offset = param3;
         update();
      }
      
      public function setTile(param1:Tile) : void
      {
         this.tile = param1;
         update();
      }
      
      public function update() : void
      {
         unflatten();
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         if(tile != null && tile.isVisible())
         {
            if(tileSprite == null)
            {
               tileSprite = new Image(Assets.getAtlas().getTexture("floor_" + tile.type));
            }
            else
            {
               tileSprite.texture = Assets.getAtlas().getTexture("floor_" + tile.type);
            }
            tile.updateTileImageColor(tileSprite);
            addChild(tileSprite);
            if(tile.building != null)
            {
               if(buildingSprite == null)
               {
                  switch(tile.building.type - 401)
                  {
                     case 0:
                        buildingSprite = new Image(Assets.getAtlas().getTexture("building_400_01"));
                        break;
                     default:
                        buildingSprite = new Image(Assets.getAtlas().getTexture("building_" + tile.building.type + "_01"));
                  }
               }
               else
               {
                  switch(tile.building.type - 401)
                  {
                     case 0:
                        buildingSprite.texture = Assets.getAtlas().getTexture("building_400_01");
                        break;
                     default:
                        buildingSprite.texture = Assets.getAtlas().getTexture("building_" + tile.building.type + "_01");
                  }
               }
               addChild(buildingSprite);
               tile.building.updateBuildingImageColor(buildingSprite);
            }
            scaleX = mapScale;
            scaleY = mapScale;
            x = tile.getCanvasX() * scaleX + offset;
            y = tile.getCanvasY() * scaleY;
         }
         flatten();
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         tile = null;
         tileSprite = null;
         buildingSprite = null;
         super.dispose();
      }
   }
}

