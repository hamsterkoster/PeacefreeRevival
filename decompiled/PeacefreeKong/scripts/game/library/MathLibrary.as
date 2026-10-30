package game.library
{
   import flash.utils.Dictionary;
   
   public class MathLibrary
   {
      
      public function MathLibrary()
      {
         super();
      }
      
      public static function randomize(param1:int, param2:int) : int
      {
         return int(param1 + Math.random() * (Math.abs(param2 - param1) + 1));
      }
      
      public static function sizeof(param1:Dictionary) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function distanceFormula(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.sqrt(Math.pow(Math.abs(param1 - param3),2) + Math.pow(Math.abs(param2 - param4),2));
      }
   }
}

