package game.peacefree
{
   public class Achievement
   {
      
      public var achID:int;
      
      public var title:String;
      
      public var desc:String;
      
      public var check:Function;
      
      public var pgame:PeacefreeGame;
      
      public var rewardValue:int = 1;
      
      public function Achievement(param1:PeacefreeGame, param2:int, param3:String, param4:String, param5:Function, param6:int = 1)
      {
         super();
         this.pgame = param1;
         this.achID = param2;
         this.title = param3;
         this.desc = param4;
         this.check = param5;
         this.rewardValue = param6;
      }
      
      public function isUnlocked() : Boolean
      {
         if(pgame.achievementManager.achievements.indexOf(achID) != -1)
         {
            return true;
         }
         return false;
      }
      
      public function unlock() : void
      {
         if(pgame.achievementManager.achievements.indexOf(achID) == -1)
         {
            pgame.achievementManager.maxTechPoints += rewardValue;
            pgame.achievementManager.achievements.push(achID);
            pgame.saveGameData();
         }
      }
      
      public function dispose() : void
      {
         check = null;
         pgame = null;
      }
   }
}

