package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import starling.display.Image;
   import starling.text.TextField;
   
   public class TileOption extends Clickable
   {
      
      public var image:Image;
      
      public var hintTextField:TextField = null;
      
      public function TileOption(param1:String, param2:String = null)
      {
         super(Assets.getAtlas().getTexture("button_gloss"));
         image = new Image(Assets.getAtlas().getTexture(param1));
         addChild(image);
         if(param2 != null)
         {
            hintTextField = new TextField(width,height,param2,Fonts.getDefaultFont().fontName,18,16777215,true);
            hintTextField.x = 0;
            hintTextField.y = 5;
            hintTextField.vAlign = "bottom";
            hintTextField.hAlign = "right";
            hintTextField.touchable = false;
            hintTextField.autoScale = true;
            addChild(hintTextField);
         }
      }
      
      public function setHint(param1:String) : void
      {
         hintTextField.text = param1;
      }
      
      public function setIsEnabled(param1:Boolean) : void
      {
         this.bEnabled = param1;
         if(param1)
         {
            image.color = 16777215;
            if(hintTextField != null)
            {
               hintTextField.color = 16777215;
            }
         }
         else
         {
            image.color = 3355443;
            if(hintTextField != null)
            {
               hintTextField.color = 3355443;
            }
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         image = null;
         hintTextField = null;
         super.dispose();
      }
   }
}

