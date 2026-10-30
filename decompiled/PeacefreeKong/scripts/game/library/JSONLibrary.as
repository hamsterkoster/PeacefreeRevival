package game.library
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import game.container.Tracer;
   
   public class JSONLibrary
   {
      
      public function JSONLibrary()
      {
         super();
      }
      
      public static function httpGet(param1:String, param2:Object, param3:Function, param4:Function, param5:URLVariables = null) : void
      {
         var vars:URLVariables;
         var req:URLRequest;
         var loader:URLLoader;
         var url:String = param1;
         var data:Object = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var extraVars:URLVariables = param5;
         if(extraVars != null)
         {
            vars = extraVars;
         }
         else
         {
            vars = new URLVariables();
         }
         if(data != null)
         {
            vars.data = JSON.stringify(data);
         }
         req = new URLRequest();
         req.method = "GET";
         req.data = vars;
         req.url = url;
         try
         {
            loader = new URLLoader();
            loader.addEventListener("complete",function(param1:Event):void
            {
               callback(param1.target.data);
            });
            loader.addEventListener("ioError",function(param1:Event):void
            {
               errorCallback(param1.target.data);
            });
            loader.addEventListener("securityError",function(param1:Event):void
            {
               errorCallback(param1.target.data);
            });
            loader.load(req);
         }
         catch(error:Error)
         {
            errorCallback();
         }
      }
      
      public static function httpPost(param1:String, param2:Object, param3:Function, param4:Function, param5:URLVariables = null) : void
      {
         var vars:URLVariables;
         var req:URLRequest;
         var loader:URLLoader;
         var url:String = param1;
         var data:Object = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var extraVars:URLVariables = param5;
         if(extraVars != null)
         {
            vars = extraVars;
         }
         else
         {
            vars = new URLVariables();
         }
         if(data != null)
         {
            vars.data = JSON.stringify(data);
         }
         req = new URLRequest();
         req.method = "POST";
         req.data = vars;
         req.url = url;
         try
         {
            loader = new URLLoader();
            loader.addEventListener("complete",function(param1:Event):void
            {
               callback(param1.target.data);
            });
            loader.addEventListener("ioError",function(param1:Event):void
            {
               Tracer.trace("IOError in httpPost.");
               errorCallback(param1.target.data);
            });
            loader.addEventListener("securityError",function(param1:Event):void
            {
               Tracer.trace("SecurityError in httpPost.");
               errorCallback(param1.target.data);
            });
            loader.load(req);
         }
         catch(error:Error)
         {
            errorCallback();
         }
      }
      
      public static function makeJSONRequest(param1:String, param2:Object) : String
      {
         return param1 + "?data=" + JSON.stringify(param2);
      }
   }
}

