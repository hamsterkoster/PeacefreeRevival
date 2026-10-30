package game.peacefree
{
   public class AchievementManager
   {
      
      public static const SKILL_RATIONS:int = 1;
      
      public static const SKILL_AMMOS:int = 2;
      
      public static const SKILL_ELECTRODES:int = 3;
      
      public static const SKILL_EXPLOSIVES:int = 4;
      
      public static const SKILL_TEAMS:int = 5;
      
      public static const SKILL_STEALTH_SUITS:int = 6;
      
      public static const SKILL_HYPER_LASERS:int = 7;
      
      public static const SKILL_SUPERCOMPUTERS:int = 8;
      
      public var achievements:Array = [];
      
      public var maxTechPoints:int = 0;
      
      public var pgame:PeacefreeGame;
      
      public var skills:Array = [];
      
      public var usedTechPoints:int = 0;
      
      public function AchievementManager(param1:PeacefreeGame)
      {
         super();
         this.pgame = param1;
      }
      
      public static function getSkillName(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "Rations";
            case 1:
               return "Ammos";
            case 2:
               return "Electrodes";
            case 3:
               return "Explosives";
            case 4:
               return "Teams";
            case 5:
               return "Stealth Suits";
            case 6:
               return "Hyper Lasers";
            case 7:
               return "Supercomputers";
            default:
               return "Unknown";
         }
      }
      
      public function getData() : Object
      {
         var _loc1_:Object = {};
         _loc1_.achievements = achievements;
         _loc1_.maxTechPoints = maxTechPoints;
         _loc1_.skills = skills;
         _loc1_.usedTechPoints = usedTechPoints;
         return _loc1_;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         achievements = param1.achievements;
         maxTechPoints = param1.maxTechPoints;
         try
         {
            if(param1.skills != null)
            {
               skills = param1.skills;
            }
            if(param1.usedTechPoints != null)
            {
               usedTechPoints = param1.usedTechPoints;
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function resetSkills() : void
      {
         usedTechPoints = 0;
         skills.splice(0);
      }
      
      public function addSkill(param1:int) : void
      {
         if(usedTechPoints + getSkillCost(param1) > maxTechPoints)
         {
            return;
         }
         usedTechPoints += getSkillCost(param1);
         if(skills[param1] == undefined)
         {
            skills[param1] = 0;
         }
         skills[param1]++;
         pgame.saveGameData();
      }
      
      public function getSkillLevel(param1:int) : int
      {
         if(skills[param1] == undefined)
         {
            return 0;
         }
         return skills[param1];
      }
      
      public function getSkillDesc(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "Start with +20È per level\nCurrent: +" + getSkillLevel(param1) * 20 + "È";
            case 1:
               return "Start with +20Â per level\nCurrent: +" + getSkillLevel(param1) * 20 + "Â";
            case 2:
               return "Ups Zap by -4Ø per level.\nCurrent: -" + getSkillLevel(param1) * 4 + "Ø";
            case 3:
               return "Ups Blast by -4Ø per level.\nCurrent: -" + getSkillLevel(param1) * 4 + "Ø";
            case 4:
               return "Start with +1É per level.\nCurrent: +" + getSkillLevel(param1) * 1 + "É";
            case 5:
               return "Ups max Å by 8 per level.\nCurrent: +" + getSkillLevel(param1) * 8 + "Å";
            case 6:
               return "Ups max Æ by 8 per level.\nCurrent: +" + getSkillLevel(param1) * 8 + "Æ";
            case 7:
               return "Ups max Ê by 8 per level.\nCurrent: +" + getSkillLevel(param1) * 8 + "Ê";
            default:
               return "Unknown";
         }
      }
      
      public function getSkillCost(param1:int) : int
      {
         return getSkillLevel(param1) + 1;
      }
   }
}

