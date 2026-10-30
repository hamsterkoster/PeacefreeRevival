package game.acts
{
   import flash.utils.ByteArray;
   import game.library.MapLibrary;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.StorySequence;
   
   public class DemoMap extends Act
   {
      
      public static const MapInfo:Class = exmission4_txt;
      
      public function DemoMap()
      {
         super();
      }
      
      override public function init(param1:Map, param2:Boolean = true) : void
      {
         var _loc3_:StorySequence = null;
         super.init(param1);
         var _loc4_:ByteArray = new MapInfo() as ByteArray;
         param1.loadMap(MapLibrary.parseMapData(_loc4_.toString()),true,true);
         param1.setStartTile(7,13);
         param1.mapHUD.visible = false;
         param1.touchable = false;
         _loc3_ = new StorySequence(param1,getNextStoryID(),3);
         story.push(_loc3_);
      }
   }
}

