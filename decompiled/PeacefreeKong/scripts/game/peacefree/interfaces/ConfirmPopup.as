package game.peacefree.interfaces
{
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class ConfirmPopup extends Sprite
   {
      
      public var titleTextField:TextField;
      
      public var bodyTextField:TextField;
      
      public var yesButton:GenericScreenButton;
      
      public var noButton:GenericScreenButton;
      
      public function ConfirmPopup(param1:int, param2:int, param3:String, param4:String, param5:Function, param6:Function)
      {
         super();
         var _loc7_:Quad = new Quad(param1,param2,136726);
         _loc7_.x = 0;
         _loc7_.y = 0;
         _loc7_.alpha = 0.95;
         addChild(_loc7_);
         var _loc9_:Quad = new Quad(param1 + 1,1,6710886);
         _loc9_.x = 0;
         _loc9_.y = 0;
         addChild(_loc9_);
         var _loc8_:Quad = new Quad(param1 + 1,1,6710886);
         _loc8_.x = 0;
         _loc8_.y = 0 + param2;
         addChild(_loc8_);
         var _loc11_:Quad = new Quad(1,param2,6710886);
         _loc11_.x = 0;
         _loc11_.y = 0;
         addChild(_loc11_);
         var _loc10_:Quad = new Quad(1,param2,6710886);
         _loc10_.x = 0 + param1;
         _loc10_.y = 0;
         addChild(_loc10_);
         titleTextField = new TextField(param1 - 15,param2,param3,Fonts.getDefaultFont().fontName,24,4293759265,true);
         titleTextField.x = 10;
         titleTextField.y = 5;
         titleTextField.vAlign = "top";
         titleTextField.hAlign = "center";
         titleTextField.touchable = false;
         titleTextField.autoScale = true;
         addChild(titleTextField);
         bodyTextField = new TextField(param1 - 15,param2,param4,Fonts.getDefaultFont().fontName,20,16777215,true);
         bodyTextField.x = 10;
         bodyTextField.y = 30;
         bodyTextField.vAlign = "top";
         bodyTextField.hAlign = "center";
         bodyTextField.touchable = false;
         bodyTextField.autoScale = true;
         addChild(bodyTextField);
         yesButton = new GenericScreenButton(100,30,"Yes",24);
         yesButton.x = param1 / 2 - yesButton.width - 10;
         yesButton.y = param2 - yesButton.height - 10;
         yesButton.releaseCallback = param5;
         addChild(yesButton);
         noButton = new GenericScreenButton(100,30,"No",24);
         noButton.x = param1 / 2 + 10;
         noButton.y = param2 - noButton.height - 10;
         noButton.releaseCallback = param6;
         addChild(noButton);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         titleTextField = null;
         bodyTextField = null;
         yesButton = null;
         noButton = null;
         super.dispose();
      }
   }
}

