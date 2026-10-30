package game.peacefree.interfaces
{
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class Tooltip extends Sprite
   {
      
      public var titleTextField:TextField;
      
      public var bodyTextField:TextField;
      
      public function Tooltip(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         visible = false;
         var _loc5_:Quad = new Quad(param1,param2,136726);
         _loc5_.x = 0;
         _loc5_.y = 0;
         _loc5_.alpha = 0.95;
         addChild(_loc5_);
         var _loc7_:Quad = new Quad(param1 + 1,1,6710886);
         _loc7_.x = 0;
         _loc7_.y = 0;
         addChild(_loc7_);
         var _loc6_:Quad = new Quad(param1 + 1,1,6710886);
         _loc6_.x = 0;
         _loc6_.y = 0 + param2;
         addChild(_loc6_);
         var _loc9_:Quad = new Quad(1,param2,6710886);
         _loc9_.x = 0;
         _loc9_.y = 0;
         addChild(_loc9_);
         var _loc8_:Quad = new Quad(1,param2,6710886);
         _loc8_.x = 0 + param1;
         _loc8_.y = 0;
         addChild(_loc8_);
         titleTextField = new TextField(param1 - 15,param2,param3,Fonts.getDefaultFont().fontName,18,4293759265,true);
         titleTextField.x = 10;
         titleTextField.y = 5;
         titleTextField.vAlign = "top";
         titleTextField.hAlign = "left";
         titleTextField.touchable = false;
         titleTextField.autoScale = true;
         addChild(titleTextField);
         bodyTextField = new TextField(param1 - 15,param2,param4,Fonts.getDefaultFont().fontName,16,16777215,true);
         bodyTextField.x = 10;
         bodyTextField.y = 30;
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
         super.dispose();
      }
   }
}

