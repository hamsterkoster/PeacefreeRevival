package
{
   import flash.utils.getDefinitionByName;
   import starling.text.BitmapFont;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class Fonts
   {
      
      public static const XML_Regular:Class = cuprum_fnt;
      
      public static const Font_Regular:Class = cuprum_0_png$551a4b32e7b0bc2b0380ba606df7d0321219327202;
      
      public function Fonts()
      {
         super();
      }
      
      public static function getFont(param1:String) : Font
      {
         var _loc2_:Texture = null;
         var _loc3_:XML = null;
         if(Fonts[param1] == undefined)
         {
            _loc2_ = Texture.fromBitmap(new Fonts["Font_" + param1]());
            _loc3_ = XML(new Fonts["XML_" + param1]());
            Fonts[param1] = new BitmapFont(_loc2_,_loc3_);
            TextField.registerBitmapFont(Fonts[param1]);
         }
         return new Font(Fonts[param1].name,Fonts[param1].size);
      }
      
      public static function getDefaultFont() : Font
      {
         return Fonts.getFont("Regular");
      }
   }
}

