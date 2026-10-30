package
{
   public final class Font
   {
      
      private var _fontName:String;
      
      private var _fontSize:uint;
      
      private var _fontColor:uint;
      
      public function Font(param1:String, param2:uint, param3:uint = 16777215)
      {
         super();
         this.fontName = param1;
         this.fontSize = param2;
         this.fontColor = param3;
      }
      
      public function get fontColor() : uint
      {
         return _fontColor;
      }
      
      public function set fontColor(param1:uint) : void
      {
         _fontColor = param1;
      }
      
      public function get fontSize() : uint
      {
         return _fontSize;
      }
      
      public function set fontSize(param1:uint) : void
      {
         _fontSize = param1;
      }
      
      public function get fontName() : String
      {
         return _fontName;
      }
      
      public function set fontName(param1:String) : void
      {
         _fontName = param1;
      }
   }
}

