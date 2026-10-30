package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class CommandButton extends Clickable
   {
      
      public var quadBg:Quad;
      
      public var readyQuadBg:Quad;
      
      public var highlightQuadBg:Quad;
      
      public var commandImage:Image;
      
      public var extraCheck:Function = null;
      
      public var commandCounter:int;
      
      public var commandTimeout:int;
      
      public var hintTextField:TextField;
      
      public function CommandButton(param1:String, param2:int, param3:String = null)
      {
         super(Texture.fromColor(35,35,0));
         bChangeAlpha = false;
         commandCounter = 0;
         commandTimeout = param2;
         quadBg = new Quad(35,35,3355443);
         quadBg.alpha = 0.5;
         addChild(quadBg);
         highlightQuadBg = new Quad(31,31,136726);
         highlightQuadBg.x = 2;
         highlightQuadBg.y = 2;
         highlightQuadBg.alpha = 0.25;
         addChild(highlightQuadBg);
         readyQuadBg = new Quad(31,33,3355443);
         readyQuadBg.x = 2;
         readyQuadBg.alpha = 1;
         readyQuadBg.height = 25;
         addChild(readyQuadBg);
         commandImage = new Image(Assets.getAtlas().getTexture(param1));
         commandImage.x = 5;
         commandImage.y = 5;
         commandImage.alpha = 0.25;
         addChild(commandImage);
         if(param3 != null)
         {
            hintTextField = new TextField(width,height,param3,Fonts.getDefaultFont().fontName,16,16777215,true);
            hintTextField.x = 0;
            hintTextField.y = 5;
            hintTextField.vAlign = "bottom";
            hintTextField.hAlign = "right";
            hintTextField.touchable = false;
            hintTextField.autoScale = true;
            addChild(hintTextField);
         }
         progress(0);
      }
      
      public function setTimeout(param1:int) : void
      {
         commandTimeout = param1;
      }
      
      public function isReady() : Boolean
      {
         if(extraCheck != null && !extraCheck())
         {
            return false;
         }
         return commandCounter >= commandTimeout;
      }
      
      public function progress(param1:int) : void
      {
         if(extraCheck != null && !extraCheck())
         {
            alpha = 0.5;
         }
         else
         {
            alpha = 1;
         }
         refreshColors();
         if(commandCounter >= commandTimeout)
         {
            return;
         }
         commandCounter += param1;
      }
      
      public function refreshColors() : void
      {
         var _loc1_:int = 0;
         if(isReady())
         {
            highlightQuadBg.alpha = 0.65;
            commandImage.alpha = 1;
            readyQuadBg.visible = false;
            alpha = 1;
         }
         else
         {
            _loc1_ = 31 * commandCounter / commandTimeout;
            readyQuadBg.visible = true;
            readyQuadBg.y = 33 - _loc1_;
            readyQuadBg.height = _loc1_;
            highlightQuadBg.alpha = 0.85;
            commandImage.alpha = 0.25;
            alpha = 0.65;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         quadBg = null;
         readyQuadBg = null;
         highlightQuadBg = null;
         commandImage = null;
         extraCheck = null;
         hintTextField = null;
         super.dispose();
      }
   }
}

