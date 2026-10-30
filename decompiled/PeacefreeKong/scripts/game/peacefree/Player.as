package game.peacefree
{
   import game.library.MathLibrary;
   
   public class Player
   {
      
      public static const POWER_PER_TROOP:Number = 0.3;
      
      public static const POWER_MAX_PER_TROOP:int = 4;
      
      public var food:int = 100;
      
      public var minerals:int = 100;
      
      public var curFirepower:int = 20;
      
      public var curTechpower:int = 20;
      
      public var curSearchpower:int = 20;
      
      public var maxFirepower:int = 0;
      
      public var maxTechpower:int = 0;
      
      public var maxSearchpower:int = 0;
      
      public var baseFirepowerGrowth:int = 2;
      
      public var baseTechpowerGrowth:int = 2;
      
      public var baseSearchpowerGrowth:int = 2;
      
      public var firepowerGrowth:int = 1;
      
      public var techpowerGrowth:int = 1;
      
      public var searchpowerGrowth:int = 1;
      
      public var foodConsume:int = 0;
      
      public var totalRecruits:int = 0;
      
      public var maxRecruits:int = 0;
      
      public var bConsumeFood:Boolean = true;
      
      public var mineralGrowth:int = 0;
      
      public var foodGrowth:int = 0;
      
      public var curEnergy:int = 0;
      
      public var maxEnergy:int = 0;
      
      public var map:Map;
      
      public function Player(param1:Map)
      {
         super();
         this.map = param1;
      }
      
      public function generate() : void
      {
         curFirepower += firepowerGrowth;
         curTechpower += techpowerGrowth;
         curSearchpower += searchpowerGrowth;
         if(curFirepower > maxFirepower)
         {
            curFirepower = maxFirepower;
         }
         if(curTechpower > maxTechpower)
         {
            curTechpower = maxTechpower;
         }
         if(curSearchpower > maxSearchpower)
         {
            curSearchpower = maxSearchpower;
         }
      }
      
      public function init() : void
      {
         totalRecruits = 0;
         addTroop(4);
         if(map != null && map.pgame != null)
         {
            if(map.pgame.isPremiumPlayer())
            {
               maxRecruits = 4;
               food = 200;
               minerals = 200;
               addTroop(4);
            }
            addTroop(map.pgame.achievementManager.getSkillLevel(5));
            food += map.pgame.achievementManager.getSkillLevel(1) * 20;
            minerals += map.pgame.achievementManager.getSkillLevel(2) * 20;
         }
         if(map != null && map.difficulty == 0)
         {
            food += 200;
            minerals += 200;
            maxRecruits += 22;
            maxEnergy += 28;
            addTroop(4);
         }
         curFirepower = maxFirepower;
         curTechpower = maxTechpower;
         curSearchpower = maxSearchpower;
      }
      
      public function deductFood() : void
      {
         var _loc1_:int = 0;
         if(!bConsumeFood)
         {
            return;
         }
         if(map.difficulty == 0)
         {
            map.deductFood(Math.ceil(foodConsume / 2));
         }
         else
         {
            map.deductFood(foodConsume);
         }
         if(food < 0)
         {
            _loc1_ = Math.min(totalRecruits,MathLibrary.randomize(1,4));
            food = 0;
            if(totalRecruits > 5)
            {
               if(map.difficulty == 0 && totalRecruits > 24)
               {
                  map.mapHUD.logInterfacer.addLogEntry(null,"× " + _loc1_ + " Troopers starved to death.");
                  addTroop(-_loc1_);
               }
               else
               {
                  map.mapHUD.logInterfacer.addLogEntry(null,"× " + _loc1_ + " Troopers starved to death.");
                  addTroop(-_loc1_);
               }
            }
         }
         if(food < 75)
         {
            map.mapHUD.showFoodWarning();
         }
      }
      
      public function addTroop(param1:int) : void
      {
         totalRecruits += param1;
         if(totalRecruits < 0)
         {
            totalRecruits = 0;
         }
         updateStats();
      }
      
      public function updateStats() : void
      {
         firepowerGrowth = baseFirepowerGrowth;
         techpowerGrowth = baseTechpowerGrowth;
         searchpowerGrowth = baseSearchpowerGrowth;
         foodConsume = totalRecruits * 2;
         firepowerGrowth += Math.ceil(0.3 * totalRecruits);
         techpowerGrowth += Math.ceil(0.3 * totalRecruits);
         searchpowerGrowth += Math.ceil(0.3 * totalRecruits);
         if(map != null)
         {
            firepowerGrowth += 2 * map.research.getLevel(7);
            techpowerGrowth += 2 * map.research.getLevel(8);
            searchpowerGrowth += 2 * map.research.getLevel(9);
            maxFirepower = Math.ceil(25 + 4 * totalRecruits) + 15 * map.research.getLevel(7) + 8 * map.pgame.achievementManager.getSkillLevel(7);
            maxTechpower = Math.ceil(25 + 4 * totalRecruits) + 15 * map.research.getLevel(8) + 8 * map.pgame.achievementManager.getSkillLevel(8);
            maxSearchpower = Math.ceil(25 + 4 * totalRecruits) + 15 * map.research.getLevel(9) + 8 * map.pgame.achievementManager.getSkillLevel(6);
         }
      }
      
      public function resetBuildingGrowths() : void
      {
         maxRecruits = 0;
         mineralGrowth = 0;
         foodGrowth = 0;
         maxEnergy = 0;
         if(map != null && map.pgame != null && map.pgame.isPremiumPlayer())
         {
            maxRecruits = 4;
         }
         if(map != null && map.difficulty == 0)
         {
            maxRecruits += 22;
            maxEnergy += 28;
         }
      }
      
      public function getData() : Object
      {
         var _loc1_:Object = {};
         _loc1_.food = food;
         _loc1_.minerals = minerals;
         _loc1_.totalRecruits = totalRecruits;
         _loc1_.baseFirepowerGrowth = baseFirepowerGrowth;
         _loc1_.baseTechpowerGrowth = baseTechpowerGrowth;
         _loc1_.baseSearchpowerGrowth = baseSearchpowerGrowth;
         _loc1_.curFirepower = curFirepower;
         _loc1_.curTechpower = curTechpower;
         _loc1_.curSearchpower = curSearchpower;
         return _loc1_;
      }
      
      public function setData(param1:Object) : void
      {
         food = param1.food;
         minerals = param1.minerals;
         totalRecruits = param1.totalRecruits;
         baseFirepowerGrowth = param1.baseFirepowerGrowth;
         baseTechpowerGrowth = param1.baseTechpowerGrowth;
         baseSearchpowerGrowth = param1.baseSearchpowerGrowth;
         curFirepower = param1.curFirepower;
         curTechpower = param1.curTechpower;
         curSearchpower = param1.curSearchpower;
         updateStats();
      }
      
      public function dispose() : void
      {
         map = null;
      }
   }
}

