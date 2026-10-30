package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import starling.display.Quad;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class GenericScreenButton extends Clickable
   {
      
      public var bgQuad:Quad;
      
      public var textField:TextField;
      
      public function GenericScreenButton(param1:int, param2:int, param3:String, param4:int = 20, param5:Number = 136726, param6:Number = 2003199590)
      {
         super(Texture.fromColor(param1,param2,param6));
         bgQuad = new Quad(param1 - 4,param2 - 4,param5);
         bgQuad.x = 2;
         bgQuad.y = 2;
         addChild(bgQuad);
         textField = new TextField(param1 - 4,param2 - 4,param3,Fonts.getDefaultFont().fontName,param4,16777215,true);
         textField.x = 2;
         textField.y = 2;
         textField.vAlign = "center";
         textField.hAlign = "center";
         textField.touchable = false;
         textField.autoScale = true;
         addChild(textField);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         bgQuad = null;
         textField = null;
         super.dispose();
      }
   }
}

