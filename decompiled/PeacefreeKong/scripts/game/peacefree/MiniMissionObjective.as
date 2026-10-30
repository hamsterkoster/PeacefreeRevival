package game.peacefree
{
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MiniMissionObjective extends Sprite
   {
      
      public var missionObjective:MissionObjective;
      
      private var mapScale:Number;
      
      private var markerSprite:Image;
      
      public function MiniMissionObjective(param1:MissionObjective, param2:Number)
      {
         super();
         this.missionObjective = param1;
         this.mapScale = param2;
         switch(param1.priorityType)
         {
            case 0:
            case 1:
               markerSprite = new Image(Assets.getAtlas().getTexture("marker_1_01"));
               break;
            case 2:
               markerSprite = new Image(Assets.getAtlas().getTexture("marker_2_01"));
               break;
            case 3:
               markerSprite = new Image(Assets.getAtlas().getTexture("marker_3_01"));
         }
         markerSprite.scaleX = 0.5;
         markerSprite.scaleY = 0.5;
         addChild(markerSprite);
         update();
      }
      
      public function update() : void
      {
         x = missionObjective.getCanvasX() * mapScale - markerSprite.width / 2;
         y = missionObjective.getCanvasY() * mapScale - markerSprite.height / 2;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         missionObjective = null;
         markerSprite = null;
         super.dispose();
      }
   }
}

