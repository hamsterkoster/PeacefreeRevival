package game.peacefree
{
   public class Research
   {
      
      public static const BLAST_POWER:int = 1;
      
      public static const BLAST_RANGE:int = 2;
      
      public static const BLAST_COOLDOWN:int = 3;
      
      public static const ZAP_POWER:int = 4;
      
      public static const ZAP_STUN:int = 5;
      
      public static const AID_POWER:int = 6;
      
      public static const FP_UP:int = 7;
      
      public static const TP_UP:int = 8;
      
      public static const SP_UP:int = 9;
      
      public static const FOOD_UP:int = 10;
      
      public static const ENERGY_UP:int = 11;
      
      public static const MINERAL_UP:int = 12;
      
      public static const POP_UP:int = 13;
      
      public var locks:Array = [];
      
      public var levels:Array = [];
      
      public function Research()
      {
         super();
      }
      
      public static function getResearchMaxLevel(param1:int) : int
      {
         var _loc2_:int = 1;
         switch(param1 - 1)
         {
            case 0:
               return 10;
            case 1:
               return 2;
            case 2:
               return 10;
            case 3:
               return 10;
            case 4:
               return 2;
            case 9:
               return 5;
            case 10:
               return 5;
            case 11:
               return 5;
            case 12:
               return 5;
            default:
               return 50;
         }
      }
      
      public static function getResearchTitle(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "Blast Power";
            case 1:
               return "Blast Range";
            case 2:
               return "Blast Cooldown";
            case 3:
               return "Zap Power";
            case 4:
               return "Zap Stun";
            case 5:
               return "Aid Power";
            case 6:
               return "Firepower Upg.";
            case 7:
               return "Techpower Upg.";
            case 8:
               return "Searchpower Upg.";
            case 9:
               return "Fertilizers";
            case 10:
               return "C. Batteries";
            case 11:
               return "Mining Drill";
            case 12:
               return "Extra Housing";
            default:
               return "Unknown Research";
         }
      }
      
      public function getResearchCost(param1:int, param2:Boolean) : int
      {
         var _loc3_:int = getLevel(param1) + 1;
         var _loc4_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc4_ = _loc3_ * 20;
               break;
            case 1:
               _loc4_ = _loc3_ * 50;
               break;
            case 2:
               _loc4_ = _loc3_ * 15;
               break;
            case 3:
               _loc4_ = _loc3_ * 15;
               break;
            case 4:
               _loc4_ = _loc3_ * 25;
               break;
            case 5:
               _loc4_ = _loc3_ * 15;
               break;
            case 6:
               _loc4_ = _loc3_ * 30;
               break;
            case 7:
               _loc4_ = _loc3_ * 30;
               break;
            case 8:
               _loc4_ = _loc3_ * 30;
               break;
            case 9:
               _loc4_ = _loc3_ * 80;
               break;
            case 10:
               _loc4_ = _loc3_ * 125;
               break;
            case 11:
               _loc4_ = _loc3_ * 120;
               break;
            case 12:
               _loc4_ = _loc3_ * 100;
         }
         if(param2)
         {
            _loc4_ *= 2;
         }
         return _loc4_;
      }
      
      public function unlock(param1:int) : void
      {
         locks[param1] = false;
      }
      
      public function lock(param1:int) : void
      {
         locks[param1] = true;
      }
      
      public function isLocked(param1:int) : Boolean
      {
         if(locks[param1] != undefined)
         {
            return locks[param1];
         }
         return false;
      }
      
      public function getLevel(param1:int) : int
      {
         if(levels[param1] != undefined && levels[param1] != null)
         {
            return levels[param1];
         }
         return 0;
      }
      
      public function setLevel(param1:int, param2:int) : void
      {
         if(levels[param1] == undefined || levels[param1] == null)
         {
            levels[param1] = param2;
         }
         else if(levels[param1] < param2)
         {
            levels[param1] = param2;
         }
      }
      
      public function getResearchTime(param1:int, param2:Boolean) : int
      {
         var _loc4_:int = getLevel(param1) + 1;
         var _loc3_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = _loc4_ * 6;
               break;
            case 1:
               _loc3_ = _loc4_ * 12;
               break;
            case 2:
               _loc3_ = _loc4_ * 6;
               break;
            case 3:
               _loc3_ = _loc4_ * 6;
               break;
            case 4:
               _loc3_ = _loc4_ * 6;
               break;
            case 5:
               _loc3_ = _loc4_ * 4;
               break;
            case 6:
            case 7:
            case 8:
               _loc3_ = _loc4_ * 24;
               break;
            case 9:
               _loc3_ = _loc4_ * 24;
               break;
            case 10:
               _loc3_ = _loc4_ * 36;
               break;
            case 11:
               _loc3_ = _loc4_ * 48;
               break;
            case 12:
               _loc3_ = _loc4_ * 24;
         }
         if(param2)
         {
            _loc3_ /= 2;
         }
         return _loc3_;
      }
      
      public function getResearchDesc(param1:int) : String
      {
         var _loc2_:int = getLevel(param1);
         var _loc4_:String = "";
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc4_ = Map.formatCooldown(1666.6666666666667 * (_loc2_ + 1));
               _loc3_ = 6 + (_loc2_ + 1) * 4;
               return "Blast Power Lv." + (_loc2_ + 1) + " increases damage of your Blast Command to -" + _loc3_ + "Ø" + " and cooldown by +" + "Á" + _loc4_ + ".";
            case 1:
               return "Blast Range Lv." + (_loc2_ + 1) + " increases the area of effect of your Blast Command.";
            case 2:
               _loc4_ = Map.formatCooldown(3333.3333333333335 * (_loc2_ + 1));
               return "Blast Cooldown reduces the cooldown of your Blast Command by -Á" + _loc4_ + ".";
            case 3:
               _loc3_ = 3 + (_loc2_ + 1) * 2;
               return "Zap Power Lv." + (_loc2_ + 1) + " increases damage done to enemies by your Shock Bombs and Zap Command to -" + _loc3_ + "Ø" + ".";
            case 4:
               _loc4_ = Map.formatCooldown(40000 - 240000 / 24 + 3333.3333333333335 * (_loc2_ + 1));
               return "Zap Stun Lv." + (_loc2_ + 1) + " increases the stun duration of your Zap Command to " + "Á" + _loc4_ + ".";
            case 5:
               _loc3_ = 25 + (_loc2_ + 1) * 10;
               return "Aid Power Lv." + (_loc2_ + 1) + " increases the max possible resources you can receive via Aid Command to " + _loc3_ + " " + "È" + "/" + "Â" + ".";
            case 6:
               _loc3_ = (_loc2_ + 1) * 15;
               _loc5_ = (_loc2_ + 1) * 2;
               return "Firepower Upgrade Lv." + (_loc2_ + 1) + " will increase your maximum " + "Æ" + " Firepower by " + _loc3_ + " and growth by " + _loc5_ + " per hour.";
            case 7:
               _loc3_ = (_loc2_ + 1) * 15;
               _loc5_ = (_loc2_ + 1) * 2;
               return "Techpower Upgrade Lv." + (_loc2_ + 1) + " will increase your maximum " + "Ê" + " Techpower by " + _loc3_ + " and growth by " + _loc5_ + " per hour.";
            case 8:
               _loc3_ = (_loc2_ + 1) * 15;
               _loc5_ = (_loc2_ + 1) * 2;
               return "Searchpower Upgrade Lv." + (_loc2_ + 1) + " will increase your maximum " + "Å" + " Searchpower by " + _loc3_ + " and growth by " + _loc5_ + " per hour.";
            case 9:
               _loc5_ = _loc2_ + 1;
               return "Fertilizers Lv." + (_loc2_ + 1) + " will increase " + "È" + " generated by Hydropods and Agripods by +" + _loc5_ + "È" + ".";
            case 10:
               _loc5_ = _loc2_ + 1;
               return "Charged Batteries Lv." + (_loc2_ + 1) + " will increase " + "Ë" + " generated by Generator buildings by +" + _loc5_ + "Ë" + ".";
            case 11:
               _loc5_ = _loc2_ + 1;
               return "Mining Drill Lv." + (_loc2_ + 1) + " will increase " + "Â" + " generated by Extractors by +" + _loc5_ + "Â" + ".";
            case 12:
               _loc5_ = _loc2_ + 1;
               return "Extra Housing Lv." + (_loc2_ + 1) + " will increase max " + "É" + " generated by Resthouses by +" + _loc5_ + "É" + ".";
            default:
               return "Unknown Research";
         }
      }
      
      public function getData() : Array
      {
         return levels;
      }
      
      public function setData(param1:Array) : void
      {
         levels = param1;
      }
      
      public function dispose() : void
      {
         if(levels != null)
         {
            levels.splice(0);
         }
         levels = null;
      }
   }
}

