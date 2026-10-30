package game.library
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Security;
   import game.container.GameConfig;
   import game.container.Tracer;
   
   public class KongregateAPI
   {
      
      private static var kongregate:*;
      
      public static var initCallback:Function = null;
      
      public static var onPurchaseCallback:Function = null;
      
      public static var getItemsCallback:Function = null;
      
      public static var onLoadComplete:Function = null;
      
      public static var onLogin:Function = null;
      
      private static const API_KEY:String = "9b78830c-9cfe-45ed-9634-e36da39a2722";
      
      private static var token:String = null;
      
      private static var userID:Number = -1;
      
      public function KongregateAPI()
      {
         super();
      }
      
      public static function init(param1:Function = null) : void
      {
         if(param1 != null)
         {
            initCallback = param1;
         }
         Security.allowDomain("http://assets.kongregate.com");
         Security.allowDomain("http://www.kongregate.com");
         var _loc5_:Object = LoaderInfo(GameConfig.STAGE.loaderInfo).parameters;
         var _loc2_:String = _loc5_.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
         Security.allowDomain(_loc2_);
         if(_loc2_.search("assets.kongregate.com") > -1)
         {
            Security.allowDomain(_loc2_.replace("assets.kongregate.com","www.kongregate.com"));
         }
         var _loc4_:URLRequest = new URLRequest(_loc2_);
         var _loc3_:Loader = new Loader();
         _loc3_.contentLoaderInfo.addEventListener("complete",loadComplete);
         _loc3_.load(_loc4_);
      }
      
      private static function loadComplete(param1:Event) : void
      {
         try
         {
            kongregate = param1.target.content;
            GameConfig.STAGE.addChild(kongregate);
            kongregate.services.connect();
            if(isGuest())
            {
               kongregate.services.addEventListener("login",onKongregateInPageLogin);
            }
            else
            {
               userID = kongregate.services.getUserId();
               token = kongregate.services.getGameAuthToken();
            }
            if(onLoadComplete != null)
            {
               onLoadComplete();
            }
         }
         catch(error:Error)
         {
            GameConfig.KONG_VERSION = false;
         }
         if(initCallback != null)
         {
            initCallback();
            initCallback = null;
         }
      }
      
      public static function getInstance() : *
      {
         return kongregate;
      }
      
      public static function addStats(param1:String, param2:int) : void
      {
         try
         {
            if(GameConfig.KONG_VERSION)
            {
               kongregate.stats.submit(param1,param2);
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public static function purchase(param1:Array, param2:Function = null) : void
      {
         if(param2 != null)
         {
            KongregateAPI.onPurchaseCallback = param2;
         }
         try
         {
            if(GameConfig.KONG_VERSION)
            {
               kongregate.mtx.purchaseItems(param1,onPurchaseResult);
            }
         }
         catch(error:Error)
         {
            Tracer.trace(error.message);
         }
      }
      
      public static function onPurchaseResult(param1:Object) : void
      {
         if(onPurchaseCallback != null)
         {
            onPurchaseCallback(param1.success);
            onPurchaseCallback = null;
         }
      }
      
      public static function getItems(param1:Function = null) : void
      {
         if(param1 != null)
         {
            KongregateAPI.getItemsCallback = param1;
         }
         try
         {
            if(GameConfig.KONG_VERSION)
            {
               kongregate.mtx.requestUserItemList(null,onUserItems);
            }
         }
         catch(error:Error)
         {
            Tracer.trace(error.message);
         }
      }
      
      public static function onUserItems(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = null;
         if(param1.success && false)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.data.length)
            {
               _loc2_ = param1.data[_loc3_];
               Tracer.trace(_loc3_ + 1 + ". " + _loc2_.identifier + ", " + _loc2_.id + "," + _loc2_.data + "," + _loc2_.remaining_uses);
               _loc3_++;
            }
         }
         if(getItemsCallback != null)
         {
            getItemsCallback(param1);
            getItemsCallback = null;
         }
      }
      
      public static function onKongregateInPageLogin(param1:Event) : void
      {
         userID = kongregate.services.getUserId();
         token = kongregate.services.getGameAuthToken();
         if(onLogin != null)
         {
            onLogin();
         }
      }
      
      public static function showKredsDialog() : void
      {
         try
         {
            if(GameConfig.KONG_VERSION)
            {
               kongregate.mtx.showKredPurchaseDialog();
            }
         }
         catch(error:Error)
         {
            Tracer.trace(error.message);
         }
      }
      
      public static function isGuest() : Boolean
      {
         try
         {
            if(GameConfig.KONG_VERSION)
            {
               return kongregate.services.isGuest();
            }
         }
         catch(error:Error)
         {
         }
         return true;
      }
      
      public static function consumeItem(param1:int, param2:Function) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.api_key = "9b78830c-9cfe-45ed-9634-e36da39a2722";
         _loc3_.game_auth_token = token;
         _loc3_.user_id = userID;
         _loc3_.id = param1;
         JSONLibrary.httpPost("http://api.kongregate.com/api/use_item.json",null,param2,param2,_loc3_);
      }
      
      public static function showSignUpLogin() : void
      {
         try
         {
            if(GameConfig.KONG_VERSION)
            {
               kongregate.services.showRegistrationBox();
            }
         }
         catch(error:Error)
         {
            Tracer.trace(error.message);
         }
      }
   }
}

