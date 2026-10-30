package game.library
{
   import flash.net.SharedObject;
   
   public class FileLibrary
   {
      
      public function FileLibrary()
      {
         super();
      }
      
      public static function loadSharedData(param1:String) : SharedObject
      {
         return SharedObject.getLocal(param1);
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

