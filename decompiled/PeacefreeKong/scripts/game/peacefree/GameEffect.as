package game.peacefree
{
   import starling.display.Sprite;
   
   public class GameEffect extends Sprite
   {
      
      private var bTrash:Boolean = false;
      
      public function GameEffect()
      {
         super();
      }
      
      public function progress(param1:int) : void
      {
      }
      
      public function isTrash() : Boolean
      {
         return bTrash;
      }
      
      public function trash() : void
      {
         bTrash = true;
      }
   }
}

