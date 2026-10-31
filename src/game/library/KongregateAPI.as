package game.library
{
   // PeacefreeRevival: an offline stand-in for Kongregate, whose purchase service is gone.
   // Kongregate's API is never loaded and nothing goes over the network. The player owns
   // premium, purchases succeed for free, and the bombs are counted here. The counts are not
   // saved (the original game didn't save them either), so every game start begins with
   // START_BOMBS of each bomb. Only the members the game uses are kept.
   public class KongregateAPI
   {
      
      private static const START_BOMBS:int = 10;
      
      private static const BOMBS_PER_PURCHASE:int = 10;
      
      private static const PREMIUM_ID:int = 1;
      
      private static const SHOCK_BOMB_ID:int = 2;
      
      private static const NOX_BOMB_ID:int = 3;
      
      private static var shockBombs:int = START_BOMBS;
      
      private static var noxBombs:int = START_BOMBS;
      
      // The game sets these to its onKongregateLogin, which refreshes the title screen, goes back
      // to it unless a mission is running, and submits high scores. They are never called: there
      // is no Kongregate account to sign in to.
      public static var onLoadComplete:Function = null;
      
      public static var onLogin:Function = null;
      
      public function KongregateAPI()
      {
         super();
      }
      
      // The game passes its getKongregateItems: the owned items are ready at once.
      public static function init(param1:Function = null) : void
      {
         if(param1 != null)
         {
            param1();
         }
      }
      
      // No Kongregate high scores.
      public static function addStats(param1:String, param2:int) : void
      {
      }
      
      // Every purchase succeeds for free; each bomb pack adds BOMBS_PER_PURCHASE bombs.
      public static function purchase(param1:Array, param2:Function = null) : void
      {
         for each(var _loc3_:String in param1)
         {
            if(_loc3_ == "shock_bomb")
            {
               shockBombs += BOMBS_PER_PURCHASE;
            }
            else if(_loc3_ == "nox_bomb")
            {
               noxBombs += BOMBS_PER_PURCHASE;
            }
         }
         if(param2 != null)
         {
            param2(true);
         }
      }
      
      // The item list Kongregate would send for a player who owns premium.
      public static function getItems(param1:Function = null) : void
      {
         if(param1 != null)
         {
            param1({
               "success":true,
               "data":[
                  {"identifier":"premium","id":PREMIUM_ID,"remaining_uses":1},
                  {"identifier":"shock_bomb","id":SHOCK_BOMB_ID,"remaining_uses":shockBombs},
                  {"identifier":"nox_bomb","id":NOX_BOMB_ID,"remaining_uses":noxBombs}
               ]
            });
         }
      }
      
      // Signed in, as far as the game can tell; this hides the title screen's
      // "Sign in to save your high scores" link.
      public static function isGuest() : Boolean
      {
         return false;
      }
      
      // A used bomb is counted down here instead of being posted to Kongregate's server.
      public static function consumeItem(param1:int, param2:Function) : void
      {
         if(param1 == SHOCK_BOMB_ID && shockBombs > 0)
         {
            shockBombs--;
         }
         else if(param1 == NOX_BOMB_ID && noxBombs > 0)
         {
            noxBombs--;
         }
         param2();
      }
      
      public static function showSignUpLogin() : void
      {
      }
   }
}
