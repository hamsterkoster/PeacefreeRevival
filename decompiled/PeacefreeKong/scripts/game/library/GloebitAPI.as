package game.library
{
   import flash.net.URLVariables;
   import game.container.GameConfig;
   
   public class GloebitAPI
   {
      
      public static const GLOEBIT_ENDPOINT:String = "http://www.peacefree.adventurecat.us/gloebit.php";
      
      public function GloebitAPI()
      {
         super();
      }
      
      public static function getBalance(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "balance";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
      
      public static function getItems(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "retrieve";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
      
      public static function buyPremium(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "premium";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
      
      public static function buyNox(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "nox";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
      
      public static function buyShock(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "shock";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
      
      public static function useNox(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "usenox";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
      
      public static function useShock(param1:Function, param2:Function) : void
      {
         var _loc4_:Object = {};
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.type = "useshock";
         _loc3_.session = GameConfig.STAGE.loaderInfo.parameters["phpsessionid"];
         JSONLibrary.httpGet("http://www.peacefree.adventurecat.us/gloebit.php",_loc4_,param1,param2,_loc3_);
      }
   }
}

