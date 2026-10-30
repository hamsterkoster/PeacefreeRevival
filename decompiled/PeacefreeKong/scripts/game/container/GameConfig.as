package game.container
{
   import flash.display.Stage;
   import flash.external.ExternalInterface;
   
   public class GameConfig
   {
      
      public static const VERSION:String = "Ver.1.08";
      
      public static const WEB_VERSION:Boolean = true;
      
      public static const IPAD_VERSION:Boolean = false;
      
      public static const DEBUG_MODE:Boolean = false;
      
      public static const CHEAT_MODE:Boolean = false;
      
      public static const ENABLE_FULLSCREEN:Boolean = false;
      
      public static const ENABLE_SITELOCK:Boolean = false;
      
      public static const QUALITY_LOW:int = 1;
      
      public static const QUALITY_MEDIUM:int = 2;
      
      public static const QUALITY_HIGH:int = 3;
      
      public static var GAME_WIDTH:int = 2272;
      
      public static var GAME_HEIGHT:int = 1280;
      
      public static var GAME_SCALE_X:Number = 1;
      
      public static var GAME_SCALE_Y:Number = 1;
      
      public static var FPS:int = 60;
      
      public static var STAGE:Stage;
      
      public static var GLOEBIT_VERSION:Boolean = false;
      
      public static var KONG_VERSION:Boolean = true;
      
      public static var GAME_HOST:String = "http://www.peacefree.adventurecat.us/";
      
      public function GameConfig()
      {
         super();
      }
      
      public static function setScreenResolution(param1:int, param2:int, param3:Stage) : void
      {
         GAME_WIDTH = param1;
         GAME_HEIGHT = param2;
         GAME_SCALE_X = param3.fullScreenWidth / GameConfig.GAME_WIDTH;
         GAME_SCALE_Y = param3.fullScreenHeight / GameConfig.GAME_HEIGHT;
         STAGE = param3;
      }
      
      public static function isSiteLocked() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:String = ExternalInterface.call("window.location.href.toString");
         var _loc1_:Array = new Array("kongregate.com","adventurecat.us");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc2_.search(_loc1_[_loc3_]) > -1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
   }
}

