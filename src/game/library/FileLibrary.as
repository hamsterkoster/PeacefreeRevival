package game.library
{
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   
   public class FileLibrary
   {

      // PeacefreeRevival: every save name gets this prefix, so no other local Flash game saving
      // under a plain name such as "game" or "settings" in "/" shares the file.
      private static const SAVE_PREFIX:String = "peacefree-";

      public function FileLibrary()
      {
         super();
      }

      public static function loadSharedData(param1:String) : SharedObject
      {
         // PeacefreeRevival: "/" stores the save under the root instead of under this file's full
         // path, so every build (wherever it is, whatever its name) shares one save. Without a
         // path, each new build started at the tutorial again.
         var _loc2_:SharedObject = SharedObject.getLocal(SAVE_PREFIX + param1,"/");
         var _loc3_:SharedObject = null;
         var _loc4_:ByteArray = null;
         // PeacefreeRevival: while the prefixed save is empty, carry over a copy of the save from
         // before the prefix (same name, no prefix). A copy, because the game changes what it
         // loaded in place (an act won pushes onto unlockedActs), and the old save must stay as
         // it was for older builds. Not flushed here: the game's next save writes it, and until
         // then each start carries it over again. The game never empties a save.
         if(_loc2_.data.content == null)
         {
            _loc3_ = SharedObject.getLocal(param1,"/");
            if(_loc3_.data.content != null)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeObject(_loc3_.data.content);
               _loc4_.position = 0;
               _loc2_.data.content = _loc4_.readObject();
            }
         }
         return _loc2_;
      }
      
      public static function saveData(param1:String, param2:Object) : void
      {
         var _loc3_:SharedObject = loadSharedData(param1);
         _loc3_.data.content = param2;
         _loc3_.flush();
      }
      
      public static function getData(param1:String) : Object
      {
         var _loc2_:SharedObject = null;
         try
         {
            _loc2_ = loadSharedData(param1);
            if(_loc2_ == null || _loc2_.data == null || _loc2_.data.content == null || _loc2_.data.content == undefined)
            {
               return {};
            }
            return _loc2_.data.content;
         }
         catch(e:Error)
         {
            var _loc6_:Object = {};
         }
         return _loc6_;
      }
   }
}

