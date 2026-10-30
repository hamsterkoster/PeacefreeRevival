package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import starling.display.Image;
   import starling.text.TextField;
   
   public class BigTileOption extends Clickable
   {
      
      public var image:Image;
      
      public var hintTextField:TextField;
      
      public function BigTileOption(param1:String, param2:String)
      {
         super(Assets.getAtlas().getTexture("button_gloss2"));
         image = new Image(Assets.getAtlas().getTexture(param1));
         addChild(image);
         hintTextField = new TextField(45,height,param2,Fonts.getDefaultFont().fontName,20,16777215,true);
         hintTextField.x = 52;
         hintTextField.y = 0;
         hintTextField.vAlign = "center";
         hintTextField.hAlign = "center";
         hintTextField.touchable = false;
         hintTextField.autoScale = true;
         addChild(hintTextField);
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
            hintTextField.color = 16777215;
         }
         else
         {
            image.color = 3355443;
            hintTextField.color = 3355443;
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

