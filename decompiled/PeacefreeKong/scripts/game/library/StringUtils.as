package game.library
{
   public class StringUtils
   {
      
      public function StringUtils()
      {
         super();
      }
      
      public static function trim(param1:String) : String
      {
         return param1.replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm,"$2");
      }
      
      public static function replaceAll(param1:String, param2:String, param3:String) : String
      {
         return param1.replace(new RegExp(param2,"g"),param3);
      }
   }
}

