package game.container
{
   import starling.text.TextField;
   
   public class Tracer
   {
      
      private static var traceText:TextField;
      
      public function Tracer()
      {
         super();
      }
      
      public static function trace(param1:String) : void
      {
         if(traceText == null)
         {
            return;
         }
         traceText.text = param1 + "\n" + traceText.text;
         if(traceText.text.length > 300)
         {
            traceText.text = traceText.text.substring(0,300);
         }
      }
      
      public static function getTrace() : TextField
      {
         if(traceText != null)
         {
            return traceText;
         }
         var _loc1_:TextField = new TextField(300,250,"Tracer initialized:\n",Fonts.getDefaultFont().fontName,20);
         _loc1_.x = 500;
         _loc1_.y = 0;
         _loc1_.touchable = false;
         _loc1_.border = true;
         _loc1_.color = 16711680;
         _loc1_.vAlign = "top";
         _loc1_.hAlign = "left";
         _loc1_.text = "Tracer initialized:\n";
         traceText = _loc1_;
         return traceText;
      }
   }
}

