package
{
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class Assets
   {
      
      private static var textureAtlas:TextureAtlas;
      
      public static const AtlasTextureGame:Class = sprites_png;
      
      public static const AtlasXmlGame:Class = sprites_xml$064c9a4acb2595c578c571889560f16b1041883139;
      
      private static var textures:Dictionary = new Dictionary();
      
      public static var fsbutton:Class = button_fs_png$027ec0f7d43fac6180fbc1ada54b1a101244139875;
      
      public static var visit_fb:Class = visit_fb_png$414e309eefaad8e14c836f4e91e8eefa2059240829;
      
      public static var visit_twitter:Class = visit_twitter_png$9dfb1e39aa08ce583d8aa6ead2a4a69b507590776;
      
      public function Assets()
      {
         super();
      }
      
      public static function getAtlas() : TextureAtlas
      {
         var _loc1_:Texture = null;
         var _loc2_:XML = null;
         if(textureAtlas == null)
         {
            _loc1_ = getTexture("AtlasTextureGame");
            _loc2_ = XML(new AtlasXmlGame());
            textureAtlas = new TextureAtlas(_loc1_,_loc2_);
         }
         return textureAtlas;
      }
      
      public static function getTexture(param1:String) : Texture
      {
         var _loc2_:Bitmap = null;
         if(textures[param1] == undefined)
         {
            _loc2_ = new Assets[param1]();
            textures[param1] = Texture.fromBitmap(_loc2_,false);
         }
         return textures[param1];
      }
      
      public static function init() : void
      {
      }
   }
}

