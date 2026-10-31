package
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import game.container.GameConfig;
   import starling.core.Starling;
   
   [SWF(width="800", height="540", backgroundColor="#ffffff", frameRate="60")]
   public class StarlingPreloader extends MovieClip
   {
      
      public static var INSTANCE:StarlingPreloader;
      
      private static const PROGRESS_BAR_HEIGHT:Number = 20;

      // PeacefreeRevival: Starling's Stage3D profile (baselineConstrained) draws at most 2048
      // pixels wide (Adobe's docs), and nothing under 32x32 (a minimized window).
      private static const MAX_GAME_WIDTH:int = 2048;

      private static const MIN_GAME_SIZE:int = 32;

      public static var logo:Class = adventurecat_png$a22491f7792cdedf7f3ce027265c270d1254035083;
      
      private var _starling:Object;
      
      private var logoBitmap:Bitmap;
      
      private var loadingText:TextField;
      
      public function StarlingPreloader()
      {
         super();
         INSTANCE = this;
         var _loc2_:Stage = stage;
         _loc2_.quality = "low";
         _loc2_.displayState = "normal";
         _loc2_.align = "TL";
         _loc2_.scaleMode = "noScale";
         GameConfig.setScreenResolution(800,540,_loc2_);
         logoBitmap = new logo();
         logoBitmap.x = this.stage.stageWidth / 2 - logoBitmap.width / 2;
         logoBitmap.y = 50;
         addChild(logoBitmap);
         loadingText = new TextField();
         var _loc1_:TextFormat = new TextFormat("Arial",24,0);
         loadingText.defaultTextFormat = _loc1_;
         loadingText.text = "Loading... Please wait.";
         loadingText.width = 300;
         loadingText.x = 50;
         loadingText.y = this.stage.stageHeight - 20 - 60;
         addChild(loadingText);
         this.stop();
         this.loaderInfo.addEventListener("progress",loaderInfo_progressHandler);
         this.loaderInfo.addEventListener("complete",loaderInfo_completeHandler);
      }
      
      private function loaderInfo_progressHandler(param1:ProgressEvent) : void
      {
         this.graphics.clear();
         this.graphics.beginFill(0);
         this.graphics.drawRect(50,this.stage.stageHeight - 20 - 20,(this.stage.stageWidth - 100) * param1.bytesLoaded / param1.bytesTotal,20);
         this.graphics.endFill();
      }
      
      private function loaderInfo_completeHandler(param1:Event) : void
      {
         removeChild(loadingText);
         removeChild(logoBitmap);
         this.graphics.clear();
         this.gotoAndStop(2);
         var _loc3_:Class = getDefinitionByName("starling.core.Starling") as Class;
         var _loc2_:Class = getDefinitionByName("game.peacefree.PeacefreeGame") as Class;
         // PeacefreeRevival: rebuild the graphics when Windows resets the graphics device (resizing
         // the projector window does). Without this, Starling stops with "Fatal error: The
         // application lost the device context!". Must be set before Starling is created.
         Starling.handleLostContext = true;
         this._starling = new _loc3_(_loc2_,this.stage);
         // PeacefreeRevival: the game stays 800x540 inside, whatever the window's size when
         // Starling starts; fitToWindow scales it. The window around the game turns black (the
         // loading screen stays white; Starling keeps the white it was made with).
         this._starling.stage.stageWidth = GameConfig.GAME_WIDTH;
         this._starling.stage.stageHeight = GameConfig.GAME_HEIGHT;
         this.stage.color = 0;
         fitToWindow();
         this.stage.addEventListener("resize",fitToWindow);
         this._starling.start();
         this.stage.addEventListener("keyDown",onStatsKey);
      }

      // PeacefreeRevival: fits the game to the window (to-do 8): its own 800x540 shape, centred,
      // black bars around it, at most MAX_GAME_WIDTH wide. Runs at the start and on every resize:
      // dragging the window's edge, maximizing, fullscreen on or off (Esc included).
      private function fitToWindow(param1:Event = null) : void
      {
         var scale:Number = Math.min(stage.stageWidth / GameConfig.GAME_WIDTH,stage.stageHeight / GameConfig.GAME_HEIGHT,MAX_GAME_WIDTH / GameConfig.GAME_WIDTH);
         var gameWidth:int = Math.round(GameConfig.GAME_WIDTH * scale);
         var gameHeight:int = Math.round(GameConfig.GAME_HEIGHT * scale);
         if(gameWidth < MIN_GAME_SIZE || gameHeight < MIN_GAME_SIZE)
         {
            return;
         }
         this._starling.viewPort = new Rectangle(Math.round((stage.stageWidth - gameWidth) / 2),Math.round((stage.stageHeight - gameHeight) / 2),gameWidth,gameHeight);
      }

      // PeacefreeRevival: the P key shows or hides Starling's stats box (FPS, memory, draw calls).
      private function onStatsKey(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 80)
         {
            this._starling.showStats = !this._starling.showStats;
         }
      }
      
      // PeacefreeRevival: the game's own fullscreen toggle (PeacefreeGame.toggleFullScreen) calls
      // these two; nothing reaches it now (its title button is off, its Esc code never runs).
      // They stretched the game to the screen and back; if it's ever reached, they fit it instead.
      public function resizeStage(param1:Event) : void
      {
         fitToWindow();
      }

      public function resizeBack() : void
      {
         fitToWindow();
      }
   }
}

