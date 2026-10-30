package game.library
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import game.container.GameConfig;
   import game.container.Tracer;
   
   public class MapLibrary extends EventDispatcher
   {
      
      private static const DEBUG_MODE:Boolean = false;
      
      private static const EVENT_UPDATE:String = "MapLoadUpdate";
      
      private static const EVENT_ERROR:String = "MapLoadError";
      
      private static var INSTANCE:MapLibrary;
      
      private var mapData:Array;
      
      private var onComplete:Function;
      
      private var onError:Function;
      
      private var numOfResources:int;
      
      private var numOfResourcesLoaded:int = 0;
      
      public function MapLibrary()
      {
         super();
      }
      
      public static function parseMapData(param1:String) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:Array = param1.split("\n");
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_].split(";");
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function setInstance(param1:MapLibrary) : void
      {
         INSTANCE = param1;
      }
      
      public static function getInstance() : MapLibrary
      {
         if(INSTANCE == null)
         {
            INSTANCE = new MapLibrary();
         }
         return INSTANCE;
      }
      
      public function loadMap(param1:String, param2:Function, param3:Function = null) : void
      {
         this.onComplete = param2;
         this.onError = param3;
         var _loc4_:URLLoader = new URLLoader();
         _loc4_.addEventListener("complete",loadMapData);
         if(param3 != null)
         {
            _loc4_.addEventListener("ioError",param3);
         }
         _loc4_.load(new URLRequest(GameConfig.GAME_HOST + param1));
         if(INSTANCE == null)
         {
            INSTANCE = this;
         }
      }
      
      private function loadMapData(param1:Event) : void
      {
         try
         {
            mapData = parseMapData(param1.target.data);
         }
         catch(e:Error)
         {
            Tracer.trace("There was an error loading map library.");
         }
         onComplete();
      }
      
      public function getMapData() : Array
      {
         return mapData;
      }
   }
}

