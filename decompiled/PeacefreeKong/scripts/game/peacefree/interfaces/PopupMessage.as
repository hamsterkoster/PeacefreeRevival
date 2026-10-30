package game.peacefree.interfaces
{
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class PopupMessage extends Sprite
   {
      
      private var titleTextField:TextField;
      
      private var bodyTextField:TextField;
      
      private var image:Image;
      
      public function PopupMessage(param1:int, param2:int, param3:String, param4:String, param5:String)
      {
         super();
         touchable = false;
         var _loc6_:Quad = new Quad(param1,param2,136726);
         _loc6_.x = 0;
         _loc6_.y = 0;
         _loc6_.alpha = 0.85;
         addChild(_loc6_);
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
         var _loc7_:Image = new Image(Assets.getAtlas().getTexture("button_gloss"));
         _loc7_.x = 10;
         _loc7_.y = 15;
         addChild(_loc7_);
         image = new Image(Assets.getAtlas().getTexture(param5));
         image.scaleX = 0.4;
         image.scaleY = 0.4;
         image.x = 10;
         image.y = 70 - image.height;
         image.color = 65290;
         addChild(image);
         titleTextField = new TextField(param1 - 80,param2,param3,Fonts.getDefaultFont().fontName,18,4293759265,true);
         titleTextField.x = 70;
         titleTextField.y = 10;
         titleTextField.vAlign = "top";
         titleTextField.hAlign = "left";
         titleTextField.touchable = false;
         titleTextField.autoScale = true;
         addChild(titleTextField);
         bodyTextField = new TextField(param1 - 80,param2,param4,Fonts.getDefaultFont().fontName,16,16777215,true);
         bodyTextField.x = 70;
         bodyTextField.y = 35;
         bodyTextField.vAlign = "top";
         bodyTextField.hAlign = "left";
         bodyTextField.touchable = false;
         bodyTextField.autoScale = true;
         addChild(bodyTextField);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         titleTextField = null;
         bodyTextField = null;
         image = null;
         super.dispose();
      }
   }
}

