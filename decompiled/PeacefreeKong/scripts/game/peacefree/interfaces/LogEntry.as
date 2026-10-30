package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import game.peacefree.Tile;
   import starling.events.TouchEvent;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class LogEntry extends Clickable
   {
      
      public static const INIT_TIMEOUT:int = 10000;
      
      public static var EMPTY_QUAD:Texture = null;
      
      public static var HIGHLIGHT_QUAD:Texture = null;
      
      private var logTextField:TextField;
      
      private var logTimeField:TextField;
      
      private var opacityCounter:int = 10000;
      
      private var opacityTimeout:int = 25;
      
      private var tile:Tile;
      
      private var bHidden:Boolean = false;
      
      public function LogEntry(param1:Tile, param2:String, param3:String)
      {
         if(EMPTY_QUAD == null)
         {
            EMPTY_QUAD = Texture.fromColor(250,24,0);
            HIGHLIGHT_QUAD = Texture.fromColor(250,24,1996625430);
         }
         super(EMPTY_QUAD);
         this.tile = param1;
         hoverCallback = onHovered;
         releaseCallback = onPressed;
         exitCallback = onMouseOut;
         logTimeField = new TextField(50,22,param2,Fonts.getDefaultFont().fontName,20,16777215,true);
         logTimeField.x = 5;
         logTimeField.vAlign = "center";
         logTimeField.hAlign = "left";
         logTimeField.touchable = false;
         logTimeField.autoScale = true;
         addChild(logTimeField);
         logTextField = new TextField(185,22,param3,Fonts.getDefaultFont().fontName,20,16777215,true);
         logTextField.x = 47;
         logTextField.vAlign = "center";
         logTextField.hAlign = "left";
         logTextField.touchable = false;
         logTextField.autoScale = true;
         addChild(logTextField);
      }
      
      public function progress(param1:int) : void
      {
         if(!visible)
         {
            return;
         }
         opacityCounter -= param1;
         if(opacityCounter < 1)
         {
            alpha -= 0.05;
            if(alpha <= 0)
            {
               alpha = 0;
               visible = false;
            }
            opacityCounter += opacityTimeout;
         }
      }
      
      public function onHovered(param1:TouchEvent) : void
      {
         opacityCounter = 10000;
         alpha = 1;
         upState = HIGHLIGHT_QUAD;
      }
      
      public function onMouseOut() : void
      {
         upState = EMPTY_QUAD;
      }
      
      public function onPressed() : void
      {
         opacityCounter = 10000;
         alpha = 1;
         if(tile != null)
         {
            tile.map.goToTile(tile);
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         logTextField = null;
         logTimeField = null;
         tile = null;
         super.dispose();
      }
   }
}

