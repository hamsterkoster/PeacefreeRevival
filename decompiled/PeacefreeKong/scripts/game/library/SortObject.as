package game.library
{
   public class SortObject
   {
      
      public function SortObject()
      {
         super();
      }
      
      public static function sort(param1:int, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_.addItem(null);
            _loc3_++;
         }
         mergeSort(param1,param2,_loc4_,0,param2.length - 1);
      }
      
      private static function mergeSort(param1:int, param2:Array, param3:Array, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         if(param4 < param5)
         {
            _loc6_ = (param4 + param5) / 2;
            mergeSort(param1,param2,param3,param4,_loc6_);
            mergeSort(param1,param2,param3,_loc6_ + 1,param5);
            merge(param1,param2,param3,param4,_loc6_ + 1,param5);
         }
      }
      
      private static function merge(param1:int, param2:Array, param3:Array, param4:int, param5:int, param6:int) : void
      {
         var _loc9_:int = 0;
         var _loc7_:int = param5 - 1;
         var _loc8_:int = param4;
         var _loc10_:int = param6 - param4 + 1;
         while(param4 <= _loc7_ && param5 <= param6)
         {
            if(param2[param4].compareTo(param1,param2[param5]) <= 0)
            {
               param3[_loc8_++] = param2[param4++];
            }
            else
            {
               param3[_loc8_++] = param2[param5++];
            }
         }
         while(param4 <= _loc7_)
         {
            param3[_loc8_++] = param2[param4++];
         }
         while(param5 <= param6)
         {
            param3[_loc8_++] = param2[param5++];
         }
         _loc9_ = 0;
         while(_loc9_ < _loc10_)
         {
            param2[param6] = param3[param6];
            _loc9_++;
            param6--;
         }
      }
      
      public function getSortValue(param1:int, param2:SortObject) : Number
      {
         return 0;
      }
      
      public function compareTo(param1:int, param2:SortObject) : int
      {
         return int(getSortValue(param1,param2) - param2.getSortValue(param1,param2));
      }
   }
}

