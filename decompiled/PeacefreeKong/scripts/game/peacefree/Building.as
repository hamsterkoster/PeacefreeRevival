package game.peacefree
{
   import flash.utils.setTimeout;
   import game.library.MathLibrary;
   import game.peacefree.effects.ChargeParticleEffect;
   import game.peacefree.effects.PoisonballEffect;
   import game.peacefree.effects.SmokePuffEffect;
   import game.peacefree.effects.SparkEffect;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class Building extends Sprite
   {
      
      public static const BUILDING_CIV_1:int = 1;
      
      public static const BUILDING_CIV_2:int = 2;
      
      public static const BUILDING_CIV_3:int = 3;
      
      public static const BUILDING_CIV_4:int = 4;
      
      public static const BUILDING_CIV_5:int = 5;
      
      public static const BUILDING_CIV_6:int = 6;
      
      public static const BUILDING_CIV_PARK:int = 7;
      
      public static const BUILDING_BIOSHIPS:int = 8;
      
      public static const BUILDING_LANDING_ZONE:int = 9;
      
      public static const BUILDING_FOREST:int = 10;
      
      public static const BUILDING_MEATHOUSE:int = 11;
      
      public static const BUILDING_BLOODY_SPIRE:int = 12;
      
      public static const BUILDING_SLYTHES:int = 13;
      
      public static const BUILDING_FOREST_2:int = 14;
      
      public static const BUILDING_FOREST_3:int = 15;
      
      public static const BUILDING_FOREST_4:int = 16;
      
      public static const BUILDING_FOREST_5:int = 17;
      
      public static const BUILDING_FOREST_6:int = 18;
      
      public static const BUILDING_FOREST_7:int = 19;
      
      public static const BUILDING_FOREST_8:int = 20;
      
      public static const BUILDING_FOREST_9:int = 21;
      
      public static const BUILDING_CIV_7:int = 22;
      
      public static const BUILDING_CIV_8:int = 23;
      
      public static const BUILDING_CIV_9:int = 24;
      
      public static const BUILDING_CARS_1:int = 25;
      
      public static const BUILDING_CARS_2:int = 26;
      
      public static const BUILDING_CARS_3:int = 27;
      
      public static const BUILDING_CARS_4:int = 28;
      
      public static const BUILDING_CARS_5:int = 29;
      
      public static const BUILDING_BERRY_1:int = 30;
      
      public static const BUILDING_BERRY_2:int = 31;
      
      public static const BUILDING_MOUNTAIN_1:int = 32;
      
      public static const BUILDING_MOUNTAIN_2:int = 33;
      
      public static const BUILDING_COMMAND_CENTER:int = 100;
      
      public static const BUILDING_GENERATOR:int = 101;
      
      public static const BUILDING_HYDROPOD:int = 102;
      
      public static const BUILDING_EXTRACTOR:int = 103;
      
      public static const BUILDING_RESTHOUSE:int = 104;
      
      public static const BUILDING_WATCHTOWER:int = 105;
      
      public static const BUILDING_LAB:int = 106;
      
      public static const BUILDING_ARM_SHOP:int = 107;
      
      public static const BUILDING_PORT_SHUTTLE:int = 108;
      
      public static const BUILDING_MEDIC_STATION:int = 109;
      
      public static const BUILDING_BLASTER_CANNON:int = 110;
      
      public static const BUILDING_NOXXER_CANNON:int = 111;
      
      public static const BUILDING_VR_CENTER:int = 112;
      
      public static const BUILDING_ZAP_CANNON:int = 113;
      
      public static const BUILDING_CIV_10:int = 115;
      
      public static const BUILDING_CIV_11:int = 116;
      
      public static const BUILDING_CIV_12:int = 117;
      
      public static const BUILDING_CIV_13:int = 118;
      
      public static const BUILDING_CIV_14:int = 119;
      
      public static const BUILDING_CIV_PARK_2:int = 120;
      
      public static const BUILDING_CIV_PARK_3:int = 121;
      
      public static const BUILDING_CIV_PARK_4:int = 122;
      
      public static const BUILDING_CIV_PARK_5:int = 123;
      
      public static const BUILDING_CIV_15:int = 124;
      
      public static const BUILDING_CIV_16:int = 125;
      
      public static const BUILDING_CIV_17:int = 126;
      
      public static const BUILDING_CIV_18:int = 127;
      
      public static const BUILDING_CIV_19:int = 128;
      
      public static const BUILDING_CIV_20:int = 129;
      
      public static const BUILDING_CIV_PARK_6:int = 130;
      
      public static const BUILDING_COMMAND_CENTER_II:int = 200;
      
      public static const BUILDING_POWERHOUSE:int = 201;
      
      public static const BUILDING_AGRIPOD:int = 202;
      
      public static const BUILDING_REFINER:int = 203;
      
      public static const BUILDING_COMPLEX:int = 204;
      
      public static const BUILDING_BLASTER_SENTRY:int = 205;
      
      public static const BUILDING_GRAND_BLASTER:int = 206;
      
      public static const BUILDING_NOXXER_SENTRY:int = 207;
      
      public static const BUILDING_GRAND_NOXXER:int = 208;
      
      public static const BUILDING_ZAP_SENTRY:int = 209;
      
      public static const BUILDING_CRATER:int = 300;
      
      public static const BUILDING_COMMAND_CENTER_III:int = 301;
      
      public static const BUILDING_REACTOR:int = 302;
      
      public static const BUILDING_HIVE_NEST:int = 400;
      
      public static const BUILDING_HIVE_NEST_2:int = 401;
      
      public var tile:Tile = null;
      
      public var type:int;
      
      private var buildingImage:MovieClip;
      
      private var utilizeTimeout:int = 0;
      
      private var utilizeCounter:int = 0;
      
      private var effectCounter:int = 1250;
      
      public var bOnline:Boolean = true;
      
      private var buildingFPS:int = 12;
      
      private var offlineSprite:MovieClip = null;
      
      private var arrMobs:Array = null;
      
      public var offlineCounter:int = 0;
      
      private var maxSpawn:int = 4;
      
      private var maxSpawnRange:int = 2;
      
      private var spawnID:int;
      
      private var bAlwaysOnline:Boolean = false;
      
      private var waypoints:Array;
      
      private var cycle:Array;
      
      public function Building(param1:int, param2:Tile = null)
      {
         super();
         this.type = param1;
         this.tile = param2;
         switch(param1)
         {
            case 100:
            case 200:
            case 301:
            case 106:
               buildingFPS = 2;
               break;
            case 101:
            case 201:
            case 302:
               buildingFPS = 6;
         }
         switch(param1 - 401)
         {
            case 0:
               buildingImage = new MovieClip(Assets.getAtlas().getTextures("building_400_"),buildingFPS);
               break;
            default:
               buildingImage = new MovieClip(Assets.getAtlas().getTextures("building_" + param1 + "_"),buildingFPS);
         }
         buildingImage.touchable = false;
         buildingImage.loop = true;
         buildingImage.play();
         buildingImage.y = 125 - buildingImage.height;
         Starling.juggler.add(buildingImage);
         addChild(buildingImage);
         switch(param1)
         {
            case 102:
            case 202:
               buildingImage.setFrameDuration(0,5);
         }
         if(param2 != null)
         {
            param2.setBuilding(this);
            if(param2.bSecured)
            {
               gain();
            }
         }
         init();
         updateFPS();
      }
      
      public static function isBuildable(param1:Tile, param2:int) : Boolean
      {
         switch(param2)
         {
            case 102:
               if(param1.type == 2 || param1.type == 3 || param1.type == 4 || param1.type == 5 || param1.type == 6 || param1.type == 7 || param1.type == 8 || param1.type == 9 || param1.type == 10 || param1.type == 11 || param1.type == 12 || param1.type == 13 || param1.type == 14 || param1.type == 32)
               {
                  return true;
               }
               return false;
               break;
            case 103:
               if(param1.type == 30 || param1.type == 35)
               {
                  return true;
               }
               return false;
               break;
            case 110:
            case 111:
            case 113:
            case 200:
               break;
            case 202:
            case 201:
            case 302:
               return param1.map.bUnlockedV2;
            default:
               return true;
         }
         return param1.map.bHasTechLab;
      }
      
      public static function getBuildingName(param1:int) : String
      {
         var _loc2_:String = "Unknown";
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 22:
            case 23:
            case 24:
               _loc2_ = "Civilian Building";
               break;
            case 7:
               _loc2_ = "Park";
               break;
            case 8:
               _loc2_ = "Virpuris Bioships";
               break;
            case 9:
               _loc2_ = "Landing Zone";
               break;
            case 10:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
               _loc2_ = "Forest";
               break;
            case 11:
               _loc2_ = "Meathouse";
               break;
            case 12:
               _loc2_ = "Bloody Spire";
               break;
            case 100:
               _loc2_ = "Command Center";
               break;
            case 200:
               _loc2_ = "C. Center II";
               break;
            case 301:
               _loc2_ = "C. Center III";
               break;
            case 101:
               _loc2_ = "Generator";
               break;
            case 201:
               _loc2_ = "Powerhouse";
               break;
            case 302:
               _loc2_ = "Reactor";
               break;
            case 102:
               _loc2_ = "Hydropod";
               break;
            case 202:
               _loc2_ = "Agripod";
               break;
            case 103:
               _loc2_ = "Extractor";
               break;
            case 203:
               _loc2_ = "Refiner";
               break;
            case 104:
               _loc2_ = "Resthouse";
               break;
            case 204:
               _loc2_ = "Complex";
               break;
            case 105:
               _loc2_ = "Watchtower";
               break;
            case 106:
               _loc2_ = "Tech Lab";
               break;
            case 107:
               _loc2_ = "Arm Shop";
               break;
            case 108:
               _loc2_ = "Port Shuttle";
               break;
            case 109:
               _loc2_ = "Medic Station";
               break;
            case 110:
               _loc2_ = "Blaster Cannon";
               break;
            case 205:
               _loc2_ = "Blaster Sentry";
               break;
            case 206:
               _loc2_ = "Grand Blaster";
               break;
            case 111:
               _loc2_ = "Noxxer Cannon";
               break;
            case 207:
               _loc2_ = "Noxxer Sentry";
               break;
            case 112:
               _loc2_ = "V.R. Center";
               break;
            case 113:
               _loc2_ = "Zap Cannon";
               break;
            case 209:
               _loc2_ = "Zap Sentry";
               break;
            case 300:
               _loc2_ = "Crater";
               break;
            case 13:
               _loc2_ = "Virpuris Slythes";
               break;
            case 25:
            case 26:
            case 27:
            case 28:
               _loc2_ = "Civilian Vehicles";
               break;
            case 29:
               _loc2_ = "Car Wreckage";
               break;
            case 30:
            case 31:
               _loc2_ = "Berry Bush";
               break;
            case 32:
               _loc2_ = "Rocky Mountain";
               break;
            case 33:
               _loc2_ = "Rocky Cave";
               break;
            case 400:
            case 401:
               _loc2_ = "Hive Nest";
               break;
            case 115:
            case 116:
            case 117:
            case 118:
            case 119:
               _loc2_ = "Parking Lot";
               break;
            case 120:
            case 121:
            case 122:
            case 123:
            case 130:
               _loc2_ = "Park Plaza";
               break;
            case 124:
            case 125:
            case 126:
            case 127:
               _loc2_ = "Warehouse Goods";
               break;
            case 128:
            case 129:
               _loc2_ = "Warehouse";
         }
         return _loc2_;
      }
      
      public static function getBuildingDescription(param1:int, param2:Map, param3:Boolean = true) : String
      {
         var _loc4_:String = "Unknown";
         var _loc5_:int = 0;
         switch(param1)
         {
            case 1:
            case 2:
               _loc4_ = "A non-military public property. Can be used to provide housing for É2.";
               break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 22:
            case 23:
            case 24:
               _loc4_ = "A non-military public property. Can be used to provide housing for É1.";
               break;
            case 7:
               _loc4_ = "A once peaceful green park, now empty and abandoned.";
               break;
            case 8:
               _loc4_ = "A squadron of elite Virpuris Tusks. You can recycle the ships for Âminerals.";
               break;
            case 9:
               _loc4_ = "A typical civilian landing zone. Increases max possible resources received from Aid by +5È/Â.";
               break;
            case 10:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
               _loc4_ = "A lush, green forest filled with flora and fauna. You can harvest lumber to trade for Âminerals.";
               break;
            case 11:
               _loc4_ = "This Meathouse uses the fastest way to harvest meat from its victims, by simply ripping off their flesh while still alive.";
               _loc4_ = _loc4_ + "\n\nThe building\'s blood-stained walls reek a foul stench reaching several miles away.";
               break;
            case 12:
               _loc4_ = "The Virpuris find the grotesque view of bodies skewered atop gigantic spikes appetizing. Other species perceive it only as a symbol of despair.";
               break;
            case 100:
               _loc4_ = "Provides Ë2, +1È every Á2:00, and increases army size by É8. Needs Tech Lab to upgrade.";
               break;
            case 200:
               _loc4_ = "Provides Ë4, +2È every Á2:00, increases army size by É16, and unlocks new buildings and the HyPEL command.";
               break;
            case 301:
               _loc4_ = "Fully upgraded Command Center. Make sure to protect it at all costs.";
               _loc4_ = _loc4_ + "\n\nGenerates 8&b, 16&0 and +2&9 every &21:00. Unlocks Lv3 research.";
               break;
            case 101:
               _loc5_ = param2.research.getLevel(11);
               if(param3)
               {
                  _loc4_ = "This structure generates Ë3" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " to your entire base as long as you keep it safe. Needs C. Center V2 to upgrade.";
               }
               else
               {
                  _loc4_ = "Generates Ë3" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " to entire base.";
               }
               break;
            case 201:
               _loc5_ = param2.research.getLevel(11);
               if(param3)
               {
                  _loc4_ = "This structure generates Ë6" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " to your entire base as long as you keep it safe. Needs C. Center V2 to upgrade.";
               }
               else
               {
                  _loc4_ = "Generates Ë6" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " to entire base.";
               }
               break;
            case 302:
               _loc5_ = param2.research.getLevel(11);
               if(param3)
               {
                  _loc4_ = "This structure generates Ë9" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " to your entire base as long as you keep it safe.";
               }
               else
               {
                  _loc4_ = "Generates Ë9" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " to entire base.";
               }
               break;
            case 102:
               _loc5_ = param2.research.getLevel(10);
               if(param3)
               {
                  _loc4_ = "Allows cultivating crops at a rapid rate. Generates +1È" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " every " + "Á" + "4:00. Needs " + "Ë" + getEnergyCost(102) + " to operate and C. Center V2 to upgrade.";
               }
               else
               {
                  _loc4_ = "Generates +1È" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " per " + "Á" + "4:00. Needs " + "Ë" + getEnergyCost(102) + ".";
               }
               break;
            case 202:
               _loc5_ = param2.research.getLevel(10);
               if(param3)
               {
                  _loc4_ = "Allows cultivating crops at a much more rapid rate. Generates +2È" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " every " + "Á" + "4:00. Needs " + "Ë" + getEnergyCost(202) + " to operate.";
               }
               else
               {
                  _loc4_ = "Generates +2È" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " per " + "Á" + "4:00. Needs " + "Ë" + getEnergyCost(202) + ".";
               }
               break;
            case 103:
               _loc5_ = param2.research.getLevel(12);
               if(param3)
               {
                  _loc4_ = "This Extractor mines Âminerals deep underground. Generates +2Â" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " every " + "Á" + "2:00. Needs " + "Ë" + getEnergyCost(103) + " to operate.";
               }
               else
               {
                  _loc4_ = "Generates +2Â" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + " per " + "Á" + "3:00. Needs " + getEnergyCost(103) + "Ë" + ".";
               }
               break;
            case 203:
               _loc5_ = param2.research.getLevel(12);
               _loc4_ = "Even louder than the Extractor, this Refiner uses laser-edge technology to cut rocks, yielding faster mining speeds.";
               _loc4_ = _loc4_ + "\n\nThis generates +1&3 every &21:00.";
               break;
            case 104:
               _loc5_ = param2.research.getLevel(13);
               if(param3)
               {
                  _loc4_ = "Provides housing for your troops. Increases max army size by É4" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + ". Needs " + "Ë" + getEnergyCost(104) + " to operate.";
               }
               else
               {
                  _loc4_ = "Provides housing and increases max É by 4" + (_loc5_ > 0 ? " (+" + _loc5_ + ")" : "") + ". Needs " + "Ë" + getEnergyCost(104) + ".";
               }
               break;
            case 204:
               _loc5_ = param2.research.getLevel(13);
               _loc4_ = "A far more comfortable resting quarters, filled with a shared kitchen and a private bedroom for each individual.";
               _loc4_ = _loc4_ + " It\'s not home, but it beats living in a Resthouse.\n\nEach Complex provides additional housing for 10&0.";
               break;
            case 105:
               if(param3)
               {
                  _loc4_ = "Blasts enemies within 2 tiles. Deals -2Ø every Á1:00. Needs Ë" + getEnergyCost(105) + " to operate, and Tech Lab to upgrade.";
               }
               else
               {
                  _loc4_ = "Blasts nearby enemies. Needs Ë" + getEnergyCost(105) + ".";
               }
               break;
            case 106:
               if(param3)
               {
                  _loc4_ = "The Tech Lab lets you upgrade buildings and research new technology.";
               }
               else
               {
                  _loc4_ = "Unlocks building upgrades and allows research.";
               }
               break;
            case 107:
               _loc4_ = "The Arm Shop gives you access to new contruction options.";
               break;
            case 108:
               if(param3)
               {
                  _loc4_ = "Allows you to trade Èfood and Âminerals. Also increases max Aid resources by +3È/Â. Needs Ë1.";
               }
               else
               {
                  _loc4_ = "Allows exchanging of È and Â. Needs Ë1.";
               }
               break;
            case 109:
               _loc4_ = "A building with advanced medical facilities.";
               _loc4_ = _loc4_ + "\n\nYou can cleanse troopers that have been infected with &z here.";
               break;
            case 110:
               if(param3)
               {
                  _loc4_ = "Blasts enemies within 2 tiles. Deals -4Ø every Á1:00. Needs Ë" + getEnergyCost(110) + " to operate.";
               }
               else
               {
                  _loc4_ = "Stronger than Watchtower. Needs Ë" + getEnergyCost(110) + ".";
               }
               break;
            case 205:
               if(param3)
               {
                  _loc4_ = "Blasts enemies within 3 tiles. Deals -6Ø every Á1:00. Needs Ë" + getEnergyCost(205) + " to operate.";
               }
               else
               {
                  _loc4_ = "Has farther reach than Blaster Cannon. Needs Ë" + getEnergyCost(205) + ".";
               }
               break;
            case 206:
               _loc4_ = "The final version of a Blaster Cannon.";
               _loc4_ = _loc4_ + "\n\nIt can reach enemies 3 tiles away.";
               break;
            case 111:
               if(param3)
               {
                  _loc4_ = "Slows enemy movement within 2 tiles by 30%. Deals -1Ø every Á2:00. Needs Ë" + getEnergyCost(111) + " to operate.";
               }
               else
               {
                  _loc4_ = "Slows nearby enemies. Needs Ë" + getEnergyCost(111) + ".";
               }
               break;
            case 207:
               if(param3)
               {
                  _loc4_ = "Slows enemy movement within 2 tiles by 50%. Deals -1Ø every Á2:00. Needs Ë" + getEnergyCost(111) + " to operate.";
               }
               else
               {
                  _loc4_ = "Increases slowdown effect. Needs Ë" + getEnergyCost(111) + ".";
               }
               break;
            case 112:
               _loc4_ = "A virtual reality simulator used to train troops.";
               _loc4_ = _loc4_ + "\n\nTroops can increase each skill up to 6.";
               break;
            case 113:
               if(param3)
               {
                  _loc4_ = "30% Chance to stun enemies within 2 tiles. Deals -1Ø every Á1:00. Needs Ë" + getEnergyCost(113) + " to operate.";
               }
               else
               {
                  _loc4_ = "Can stun nearby enemies. Needs Ë" + getEnergyCost(113) + ".";
               }
               break;
            case 209:
               if(param3)
               {
                  _loc4_ = "60% Chance to stun enemies within 2 tiles. Deals -1Ø every Á1:00. Needs Ë" + getEnergyCost(113) + " to operate.";
               }
               else
               {
                  _loc4_ = "Better stun chance. Needs Ë" + getEnergyCost(113) + ".";
               }
               break;
            case 300:
               _loc4_ = "A large crater made by a powerful explosion. You need to remove this hole first to allow building construction.";
               break;
            case 13:
               _loc4_ = "A squadron of elite Virpuris Slythes. You can recycle the ships for Âminerals.";
               break;
            case 25:
            case 26:
            case 27:
            case 28:
               _loc4_ = "Civilian vehicles that have been abandoned due to recent events.";
               break;
            case 29:
               _loc4_ = "An accident site. Maybe you can find some survivors within the wreckage.";
               break;
            case 30:
            case 31:
               _loc4_ = "A patch of edible, nutritious berries. You can harvest them for additional Èfood.";
               break;
            case 32:
               _loc4_ = "Rock-solid mountains. You can\'t build structures on this terrain until you remove them.";
               break;
            case 33:
               _loc4_ = "There is a cave at the base of the mountain. Do you dare explore inside?";
               break;
            case 400:
            case 401:
               _loc4_ = "You can hear loud ominous buzzing noises from the inside. Demolish it before it spawns more Giant Hornets.";
               break;
            case 115:
            case 116:
            case 117:
            case 118:
            case 119:
               _loc4_ = "An empty parking lot. Nothing much out of the ordinary to see here really.";
               break;
            case 120:
            case 121:
            case 122:
            case 123:
            case 130:
               _loc4_ = "Small shrubbery decorate this area of the park. This park has been abandoned due to recent events.";
               break;
            case 124:
            case 125:
            case 126:
            case 127:
               _loc4_ = "Various items and materials. You should probably clear this area and recycle the goods for minerals.";
               break;
            case 128:
            case 129:
               _loc4_ = "A storage facilty housing all sorts of warehouse goods.";
         }
         return _loc4_;
      }
      
      public static function getBuildCost(param1:int, param2:Boolean) : int
      {
         var _loc3_:int = getBuildTech(param1);
         if(param2)
         {
            _loc3_ *= 2;
         }
         return _loc3_;
      }
      
      public static function getBuildTime(param1:int, param2:Boolean) : int
      {
         var _loc3_:int = getBuildDuration(param1);
         if(param2)
         {
            _loc3_ = Math.max(1,Math.floor(_loc3_ / 2));
         }
         return _loc3_;
      }
      
      public static function getDemolishCost(param1:Boolean) : int
      {
         var _loc2_:int = 10;
         if(param1)
         {
            _loc2_ *= 2;
         }
         return _loc2_;
      }
      
      public static function getDemolishTime(param1:Boolean) : int
      {
         var _loc2_:int = 6;
         if(param1)
         {
            _loc2_ = 2;
         }
         return _loc2_;
      }
      
      public static function getMineralCost(param1:int, param2:Boolean = false) : int
      {
         var _loc3_:int = 0;
         switch(param1)
         {
            case 1:
            case 2:
               _loc3_ = 100;
               break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 22:
            case 23:
            case 24:
               _loc3_ = 80;
               break;
            case 7:
               _loc3_ = 110;
               break;
            case 9:
               _loc3_ = 50;
               break;
            case 11:
               _loc3_ = 200;
               break;
            case 12:
               _loc3_ = 100;
               break;
            case 101:
               _loc3_ = 30;
               break;
            case 102:
               _loc3_ = 40;
               break;
            case 103:
               _loc3_ = 70;
               break;
            case 104:
               _loc3_ = 50;
               break;
            case 105:
               _loc3_ = 50;
               break;
            case 106:
               _loc3_ = 150;
               break;
            case 107:
               _loc3_ = 180;
               break;
            case 108:
               _loc3_ = 120;
               break;
            case 109:
               _loc3_ = 170;
               break;
            case 200:
               _loc3_ = 300;
               break;
            case 201:
               _loc3_ = 25;
               break;
            case 202:
               _loc3_ = 50;
               break;
            case 203:
               _loc3_ = 125;
               break;
            case 204:
               _loc3_ = 80;
               break;
            case 110:
               _loc3_ = 40;
               break;
            case 205:
               _loc3_ = 50;
               break;
            case 206:
               _loc3_ = 300;
               break;
            case 111:
               _loc3_ = 50;
               break;
            case 207:
               _loc3_ = 60;
               break;
            case 112:
               _loc3_ = 200;
               break;
            case 113:
               _loc3_ = 45;
               break;
            case 209:
               _loc3_ = 55;
               break;
            case 301:
               _loc3_ = 300;
               break;
            case 302:
               _loc3_ = 15;
               break;
            case 400:
               _loc3_ = 50;
               break;
            case 401:
               _loc3_ = 50;
               break;
            case 300:
               _loc3_ = 0;
               break;
            case 32:
               _loc3_ = 70;
               break;
            case 33:
               _loc3_ = 70;
               break;
            default:
               _loc3_ = 50;
         }
         if(param2)
         {
            _loc3_ = Math.round(_loc3_ / 2);
         }
         return _loc3_;
      }
      
      public static function getEnergyCost(param1:int) : int
      {
         switch(param1)
         {
            case 102:
               return 1;
            case 202:
               return 2;
            case 104:
               return 1;
            case 204:
               return 2;
            case 103:
               return 2;
            case 203:
               return 3;
            case 105:
               return 2;
            case 106:
               return 0;
            case 107:
               return 2;
            case 109:
               return 4;
            case 110:
               return 2;
            case 205:
               return 3;
            case 206:
               return 4;
            case 111:
               return 2;
            case 207:
               return 3;
            case 113:
               return 2;
            case 108:
               return 1;
            default:
               return 0;
         }
      }
      
      public static function getBuildTech(param1:int) : int
      {
         switch(param1)
         {
            case 100:
               return 100;
            case 200:
               return 150;
            case 301:
               return 150;
            case 101:
               return 20;
            case 201:
               return 30;
            case 302:
               return 40;
            case 102:
               return 30;
            case 202:
               return 40;
            case 103:
               return 50;
            case 203:
               return 60;
            case 104:
               return 30;
            case 204:
               return 40;
            case 105:
               return 20;
            case 106:
               return 60;
            case 107:
               return 120;
            case 108:
               return 60;
            case 109:
               return 150;
            case 110:
               return 30;
            case 205:
               return 60;
            case 206:
               return 120;
            case 111:
               return 40;
            case 207:
               return 70;
            case 112:
               return 100;
            case 113:
               return 35;
            case 209:
               return 65;
            default:
               return 0;
         }
      }
      
      public static function getBuildDuration(param1:int) : int
      {
         switch(param1)
         {
            case 100:
               return 24;
            case 200:
               return 48;
            case 301:
               return 72;
            case 101:
               return 6;
            case 201:
               return 24;
            case 302:
               return 36;
            case 102:
               return 8;
            case 202:
               return 16;
            case 103:
               return 12;
            case 203:
               return 24;
            case 104:
               return 6;
            case 204:
               return 24;
            case 105:
               return 12;
            case 106:
               return 24;
            case 107:
               return 36;
            case 108:
               return 12;
            case 109:
               return 36;
            case 110:
               return 12;
            case 205:
               return 18;
            case 206:
               return 36;
            case 111:
               return 12;
            case 207:
               return 18;
            case 112:
               return 12;
            case 113:
               return 12;
            case 209:
               return 18;
            default:
               return 0;
         }
      }
      
      public function gain() : void
      {
         switch(type)
         {
            case 1:
            case 2:
               tile.map.player.maxRecruits += 2;
               break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 22:
            case 23:
            case 24:
               tile.map.player.maxRecruits += 1;
               break;
            case 100:
               tile.map.player.maxEnergy += 2;
               tile.map.player.maxRecruits += 8;
               tile.map.player.foodGrowth += 12;
               break;
            case 200:
               tile.map.player.maxEnergy += 4;
               tile.map.player.maxRecruits += 16;
               tile.map.player.foodGrowth += 24;
               break;
            case 301:
               tile.map.player.maxEnergy += 8;
               tile.map.player.maxRecruits += 24;
               break;
            case 101:
               tile.map.player.maxEnergy += 3 + tile.map.research.getLevel(11);
               break;
            case 201:
               tile.map.player.maxEnergy += 6 + tile.map.research.getLevel(11);
               break;
            case 302:
               tile.map.player.maxEnergy += 9 + tile.map.research.getLevel(11);
               break;
            case 104:
               tile.map.player.maxRecruits += 4 + tile.map.research.getLevel(13);
               break;
            case 204:
               tile.map.player.maxRecruits += 10 + tile.map.research.getLevel(13);
               break;
            case 105:
               break;
            case 9:
               tile.map.mapHUD.commandInterfacer.extraAidPower += 5;
               break;
            case 108:
               tile.map.mapHUD.commandInterfacer.extraAidPower += 3;
               break;
            case 103:
               tile.map.player.mineralGrowth += 24 + tile.map.research.getLevel(12) * 12;
               break;
            case 102:
               tile.map.player.foodGrowth += 6 + tile.map.research.getLevel(10) * 6;
               break;
            case 202:
               tile.map.player.foodGrowth += 12 + tile.map.research.getLevel(10) * 6;
         }
      }
      
      public function lose() : void
      {
         switch(type)
         {
            case 1:
            case 2:
               tile.map.player.maxRecruits -= 2;
               break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 22:
            case 23:
            case 24:
               tile.map.player.maxRecruits -= 1;
               break;
            case 100:
               tile.map.player.maxEnergy -= 2;
               tile.map.player.maxRecruits -= 8;
               tile.map.player.foodGrowth -= 12;
               break;
            case 200:
               tile.map.player.maxEnergy -= 4;
               tile.map.player.maxRecruits -= 8;
               tile.map.player.foodGrowth -= 24;
               break;
            case 301:
               tile.map.player.maxEnergy -= 8;
               tile.map.player.maxRecruits -= 16;
               break;
            case 101:
               tile.map.player.maxEnergy -= 3 + tile.map.research.getLevel(11);
               break;
            case 201:
               tile.map.player.maxEnergy -= 6 + tile.map.research.getLevel(11);
               break;
            case 302:
               tile.map.player.maxEnergy -= 9 + tile.map.research.getLevel(11);
               break;
            case 104:
               tile.map.player.maxRecruits -= 4 - tile.map.research.getLevel(13);
               break;
            case 204:
               tile.map.player.maxRecruits -= 10 - tile.map.research.getLevel(13);
               break;
            case 105:
               break;
            case 9:
               tile.map.mapHUD.commandInterfacer.extraAidPower -= 5;
               break;
            case 108:
               tile.map.mapHUD.commandInterfacer.extraAidPower -= 3;
               break;
            case 103:
               tile.map.player.mineralGrowth -= 24 + tile.map.research.getLevel(12) * 12;
               break;
            case 102:
               tile.map.player.foodGrowth -= 6 + tile.map.research.getLevel(10) * 6;
               break;
            case 202:
               tile.map.player.foodGrowth -= 12 + tile.map.research.getLevel(10) * 6;
         }
      }
      
      public function updateFPS() : void
      {
         if(tile.map.timeMultiplier == 0)
         {
            buildingImage.pause();
         }
         else
         {
            if(!buildingImage.isPlaying)
            {
               buildingImage.play();
            }
            switch(tile.map.timeMultiplier - 1)
            {
               case 0:
                  buildingImage.fps = buildingFPS * 1;
                  break;
               case 3:
                  buildingImage.fps = buildingFPS * 2;
                  break;
               case 7:
                  buildingImage.fps = buildingFPS * 4;
            }
         }
      }
      
      public function isOnline() : Boolean
      {
         if(bAlwaysOnline)
         {
            return true;
         }
         if(!tile.bSecured)
         {
            return false;
         }
         return bOnline;
      }
      
      public function utilize() : void
      {
         var blastDamage:int;
         var blastRange:int;
         var i:int;
         var j:int;
         var mob:Mob;
         var noxDamage:int;
         var noxRange:int;
         var noxSlowdown:Number;
         var noxDuration:int;
         var zapDamage:int;
         var zapDuration:int;
         var zapStunRate:int;
         var splashTile:Tile;
         var sparkTile:Tile;
         var spawnMob:Mob;
         if(!isOnline())
         {
            return;
         }
         blastDamage = 2;
         blastRange = 2;
         i = 0;
         j = 0;
         noxDamage = 1;
         noxRange = 2;
         noxSlowdown = 0.3;
         noxDuration = 20000;
         zapDamage = 1;
         zapDuration = 10000;
         zapStunRate = 30;
         switch(type)
         {
            case 100:
               tile.map.player.food += 1;
               if(isOnScreen())
               {
                  tile.map.addFloatText("+1È",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 200:
               tile.map.player.food += 2;
               if(isOnScreen())
               {
                  tile.map.addFloatText("+2È",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 301:
               tile.map.player.food += 4;
               if(isOnScreen())
               {
                  tile.map.addFloatText("+4È",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 101:
            case 11:
               if(isOnScreen())
               {
                  tile.map.effectSprite.addChild(new SmokePuffEffect(tile.map,tile.getCanvasX() + 43,tile.getCanvasY() - 5));
               }
               break;
            case 201:
               if(isOnScreen())
               {
                  tile.map.effectSprite.addChild(new SmokePuffEffect(tile.map,tile.getCanvasX() + 30,tile.getCanvasY() - 7));
                  tile.map.effectSprite.addChild(new SmokePuffEffect(tile.map,tile.getCanvasX() + 62,tile.getCanvasY() - 17,1000));
               }
               break;
            case 302:
               if(isOnScreen())
               {
                  tile.map.effectSprite.addChild(new SmokePuffEffect(tile.map,tile.getCanvasX() + 32,tile.getCanvasY() - 20,0));
                  tile.map.effectSprite.addChild(new SmokePuffEffect(tile.map,tile.getCanvasX() + 50,tile.getCanvasY() - 9,2000));
                  tile.map.effectSprite.addChild(new SmokePuffEffect(tile.map,tile.getCanvasX() + 60,tile.getCanvasY() - 20,1000));
               }
               break;
            case 102:
               tile.map.player.food += 1 + tile.map.research.getLevel(10);
               if(isOnScreen())
               {
                  tile.map.addFloatText("+" + (1 + tile.map.research.getLevel(10)) + "È",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 202:
               tile.map.player.food += 2 + tile.map.research.getLevel(10);
               if(isOnScreen())
               {
                  tile.map.addFloatText("+" + (1 + tile.map.research.getLevel(10)) + "È",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 103:
               tile.map.player.minerals += 2 + tile.map.research.getLevel(12);
               if(isOnScreen())
               {
                  tile.map.addFloatText("+" + (2 + tile.map.research.getLevel(12)) + "Â",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 203:
               tile.map.player.minerals += 2 + tile.map.research.getLevel(12);
               if(isOnScreen())
               {
                  tile.map.addFloatText("+" + (2 + tile.map.research.getLevel(12)) + "Â",tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 3);
               }
               break;
            case 206:
               blastRange += 1;
               blastDamage += 2;
            case 205:
               blastRange += 1;
               blastDamage += 2;
            case 110:
               blastDamage += 2;
            case 105:
               if(arrMobs == null)
               {
                  arrMobs = [];
               }
               else
               {
                  arrMobs.splice(0);
               }
               i = 0;
               while(i < 1 + 2 * blastRange)
               {
                  j = 0;
                  while(j < 1 + 2 * blastRange)
                  {
                     mob = checkMobAt(tile.mapX - blastRange + i,tile.mapY - blastRange + j);
                     if(mob != null)
                     {
                        arrMobs.push(mob);
                     }
                     j = j + 1;
                  }
                  i = i + 1;
               }
               if(arrMobs.length > 0)
               {
                  tile.map.fireball(tile,Mob(arrMobs[MathLibrary.randomize(0,arrMobs.length - 1)]).getTileAt(),blastDamage);
               }
               break;
            case 208:
               noxRange += 1;
               noxDamage += 1;
               noxSlowdown += 0.2;
            case 207:
               noxDamage += 1;
               noxSlowdown += 0.2;
            case 111:
               if(arrMobs == null)
               {
                  arrMobs = [];
               }
               else
               {
                  arrMobs.splice(0);
               }
               i = 0;
               while(i < 1 + 2 * noxRange)
               {
                  j = 0;
                  while(j < 1 + 2 * noxRange)
                  {
                     mob = checkMobAt(tile.mapX - noxRange + i,tile.mapY - noxRange + j);
                     if(mob != null)
                     {
                        arrMobs.push(mob);
                     }
                     j = j + 1;
                  }
                  i = i + 1;
               }
               if(arrMobs.length > 0)
               {
                  splashTile = Mob(arrMobs[MathLibrary.randomize(0,arrMobs.length - 1)]).getTileAt();
                  tile.map.effectSprite.addChild(new PoisonballEffect(tile.map,tile.getCanvasX(),tile.getCanvasY(),splashTile.getCanvasX(),splashTile.getCanvasY(),0));
                  setTimeout(function():void
                  {
                     tile.map.nox(tile.map.getTile(splashTile.mapX - 1,splashTile.mapY),noxDamage,noxDuration,noxSlowdown);
                     tile.map.nox(tile.map.getTile(splashTile.mapX + 1,splashTile.mapY),noxDamage,noxDuration,noxSlowdown);
                     tile.map.nox(tile.map.getTile(splashTile.mapX,splashTile.mapY - 1),noxDamage,noxDuration,noxSlowdown);
                     tile.map.nox(tile.map.getTile(splashTile.mapX,splashTile.mapY + 1),noxDamage,noxDuration,noxSlowdown);
                     tile.map.nox(tile.map.getTile(splashTile.mapX,splashTile.mapY),noxDamage,noxDuration,noxSlowdown);
                  },300 * i / Math.max(1,tile.map.timeMultiplier));
               }
               break;
            case 209:
               zapStunRate = 60;
            case 113:
               if(arrMobs == null)
               {
                  arrMobs = [];
               }
               else
               {
                  arrMobs.splice(0);
               }
               i = 0;
               while(i < 1 + 2 * blastRange)
               {
                  j = 0;
                  while(j < 1 + 2 * blastRange)
                  {
                     mob = checkMobAt(tile.mapX - blastRange + i,tile.mapY - blastRange + j);
                     if(mob != null)
                     {
                        arrMobs.push(mob);
                     }
                     j = j + 1;
                  }
                  i = i + 1;
               }
               if(arrMobs.length > 0)
               {
                  sparkTile = Mob(arrMobs[MathLibrary.randomize(0,arrMobs.length - 1)]).getTileAt();
                  if(sparkTile != tile)
                  {
                     tile.map.effectSprite.addChild(new SparkEffect(tile.map,tile.getCanvasX(),tile.getCanvasY()));
                  }
                  tile.map.zap(sparkTile,zapDamage,zapDuration,zapStunRate);
               }
               break;
            case 400:
            case 401:
               if(!tile.bSecured)
               {
                  if(tile.mob != null)
                  {
                     utilizeCounter = 240000 / 24;
                     break;
                  }
                  if(arrMobs == null)
                  {
                     arrMobs = [];
                  }
                  else
                  {
                     arrMobs.splice(0);
                  }
                  i = 0;
                  while(i < 1 + 2 * maxSpawnRange)
                  {
                     j = 0;
                     while(j < 1 + 2 * maxSpawnRange)
                     {
                        mob = checkMobAt(tile.mapX - maxSpawnRange + i,tile.mapY - maxSpawnRange + j);
                        if(mob != null)
                        {
                           arrMobs.push(mob);
                        }
                        j = j + 1;
                     }
                     i = i + 1;
                  }
                  if(arrMobs.length < maxSpawn)
                  {
                     spawnMob = new Mob(tile,spawnID);
                     spawnMob.waypoints = waypoints;
                     spawnMob.cycle = cycle;
                     tile.map.addMob(spawnMob);
                  }
               }
         }
      }
      
      private function checkMobAt(param1:int, param2:int) : Mob
      {
         var _loc3_:Map = tile.map;
         if(param1 >= 0 && param1 < _loc3_.mapWidth && param2 >= 0 && param2 < _loc3_.mapHeight)
         {
            if(_loc3_.tiles[param1 + param2 * _loc3_.mapWidth] != null && _loc3_.tiles[param1 + param2 * _loc3_.mapWidth].mob != null)
            {
               return _loc3_.tiles[param1 + param2 * _loc3_.mapWidth].mob;
            }
         }
         return null;
      }
      
      public function isOnScreen() : Boolean
      {
         return tile.map.isOnScreen(tile.getCanvasX(),tile.getCanvasY());
      }
      
      public function maintain() : void
      {
         var _loc1_:int = getEnergyCost(type);
         if(offlineCounter > 0)
         {
            setIsOnline(false);
            return;
         }
         if(_loc1_ > 0)
         {
            tile.map.player.curEnergy += _loc1_;
            if(tile.map.player.curEnergy > tile.map.player.maxEnergy)
            {
               setIsOnline(false);
            }
            else
            {
               setIsOnline(true);
            }
         }
         else
         {
            setIsOnline(true);
         }
         if(isOnline())
         {
            switch(type)
            {
               case 106:
                  tile.map.bHasTechLab = true;
                  break;
               case 200:
                  tile.map.bUnlockedV2 = true;
            }
         }
      }
      
      public function progress(param1:int) : void
      {
         if(tile.bSecured)
         {
            maintain();
         }
         if(offlineCounter > 0)
         {
            offlineCounter -= param1;
         }
         if(utilizeTimeout > 0)
         {
            utilizeCounter -= param1;
            if(utilizeCounter < 1)
            {
               utilize();
               utilizeCounter += utilizeTimeout;
            }
            generateEffects(param1);
         }
      }
      
      public function generateEffects(param1:int) : void
      {
         if(!isOnScreen())
         {
            return;
         }
         switch(type - 400)
         {
            case 0:
               if(!tile.bSecured)
               {
                  effectCounter -= param1;
                  if(effectCounter < 1)
                  {
                     effectCounter += 1250 / tile.map.timeMultiplier;
                     if(tile.isVisible() && utilizeCounter < 240000 / 6)
                     {
                        tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 2,12776192));
                     }
                  }
               }
               break;
            case 1:
               if(!tile.bSecured)
               {
                  effectCounter -= param1;
                  if(effectCounter < 1)
                  {
                     effectCounter += 1250 / tile.map.timeMultiplier;
                     if(tile.isVisible() && utilizeCounter < 240000 / 6)
                     {
                        tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY() + 112 / 2,27231));
                     }
                  }
               }
         }
      }
      
      public function refreshColors() : void
      {
         if(tile.bHighlighted)
         {
            buildingImage.color = 4293759265;
         }
         else if(tile.bSecured)
         {
            if(isOnline())
            {
               buildingImage.color = 16777215;
               buildingImage.play();
               if(!Starling.juggler.contains(buildingImage))
               {
                  Starling.juggler.add(buildingImage);
               }
            }
            else
            {
               buildingImage.color = 8947848;
               buildingImage.stop();
               if(Starling.juggler.contains(buildingImage))
               {
                  Starling.juggler.remove(buildingImage);
               }
            }
         }
         else if(tile.bScouted)
         {
            buildingImage.color = 8947848;
            buildingImage.stop();
            if(Starling.juggler.contains(buildingImage))
            {
               Starling.juggler.remove(buildingImage);
            }
         }
         else if(tile.bScoutedNearby)
         {
            buildingImage.color = 3355443;
            buildingImage.stop();
            if(Starling.juggler.contains(buildingImage))
            {
               Starling.juggler.remove(buildingImage);
            }
         }
         else if(tile.isVisible())
         {
            buildingImage.color = 1118481;
            buildingImage.stop();
            if(Starling.juggler.contains(buildingImage))
            {
               Starling.juggler.remove(buildingImage);
            }
         }
         else
         {
            buildingImage.color = 0;
            buildingImage.stop();
            if(Starling.juggler.contains(buildingImage))
            {
               Starling.juggler.remove(buildingImage);
            }
         }
      }
      
      public function updateBuildingImageColor(param1:Image) : void
      {
         if(tile.bSecured)
         {
            param1.color = 16777215;
         }
         else if(tile.bScouted)
         {
            param1.color = 8947848;
         }
         else if(tile.bScoutedNearby)
         {
            param1.color = 3355443;
         }
         else if(tile.isVisible())
         {
            param1.color = 1118481;
         }
         else
         {
            param1.color = 0;
         }
      }
      
      public function setIsOnline(param1:Boolean) : void
      {
         if(this.bOnline != param1)
         {
            if(param1)
            {
               gain();
            }
            else
            {
               lose();
            }
            this.bOnline = param1;
            refreshColors();
         }
         if(param1)
         {
            if(offlineSprite != null)
            {
               offlineSprite.stop();
               Starling.juggler.remove(offlineSprite);
               removeChild(offlineSprite,true);
               offlineSprite = null;
            }
         }
         else if(offlineSprite == null)
         {
            offlineSprite = new MovieClip(Assets.getAtlas().getTextures("offline"),1);
            offlineSprite.x = 40;
            offlineSprite.y = 35;
            offlineSprite.touchable = false;
            offlineSprite.loop = true;
            offlineSprite.play();
            Starling.juggler.add(offlineSprite);
            addChild(offlineSprite);
         }
      }
      
      public function init() : void
      {
         switch(type)
         {
            case 11:
               utilizeTimeout = 240000 / 96;
               break;
            case 100:
               utilizeTimeout = 240000 / 12;
               break;
            case 200:
               utilizeTimeout = 240000 / 12;
               break;
            case 301:
               utilizeTimeout = 240000 / 12;
               break;
            case 101:
               utilizeTimeout = 240000 / 96;
               break;
            case 201:
               utilizeTimeout = 240000 / 96;
               break;
            case 302:
               utilizeTimeout = 240000 / 96;
               break;
            case 102:
               utilizeTimeout = 240000 / 6;
               break;
            case 202:
               utilizeTimeout = 240000 / 6;
               break;
            case 103:
               utilizeTimeout = 240000 / 12;
               break;
            case 203:
               utilizeTimeout = 240000 / 24;
               break;
            case 104:
               break;
            case 105:
               utilizeTimeout = 240000 / 24;
               break;
            case 106:
            case 107:
            case 108:
            case 109:
               break;
            case 110:
               utilizeTimeout = 240000 / 24;
               break;
            case 205:
               utilizeTimeout = 240000 / 24;
               break;
            case 206:
               utilizeTimeout = 240000 / 48;
               break;
            case 111:
               utilizeTimeout = 240000 / 12;
               break;
            case 207:
               utilizeTimeout = 240000 / 12;
               break;
            case 112:
               break;
            case 113:
               utilizeTimeout = 240000 / 24;
               break;
            case 209:
               utilizeTimeout = 240000 / 24;
               break;
            case 300:
            case 13:
               break;
            case 400:
               utilizeTimeout = 240000;
               maxSpawn = 3;
               maxSpawnRange = 2;
               spawnID = 17;
               bAlwaysOnline = true;
               cycle = new Array(6,6,6,6,7);
               waypoints = generateWaypoints();
               break;
            case 401:
               utilizeTimeout = 240000;
               maxSpawn = 3;
               maxSpawnRange = 2;
               spawnID = 18;
               bAlwaysOnline = true;
               cycle = new Array(6,6,6,6,7);
               waypoints = generateWaypoints();
         }
         utilizeCounter = MathLibrary.randomize(0,utilizeTimeout);
      }
      
      private function generateWaypoints() : Array
      {
         var _loc2_:Array = [];
         _loc2_.push(tile.mapX + tile.mapY * tile.map.mapWidth);
         var _loc1_:int = tile.mapX + MathLibrary.randomize(0,maxSpawnRange);
         if(_loc1_ < tile.map.mapWidth)
         {
            _loc2_.push(_loc1_ + tile.mapY * tile.map.mapWidth);
         }
         _loc1_ = tile.mapX - MathLibrary.randomize(0,maxSpawnRange);
         if(_loc1_ >= 0)
         {
            _loc2_.push(_loc1_ + tile.mapY * tile.map.mapWidth);
         }
         _loc1_ = tile.mapY + MathLibrary.randomize(0,maxSpawnRange);
         if(_loc1_ < tile.map.mapHeight)
         {
            _loc2_.push(tile.mapX + _loc1_ * tile.map.mapWidth);
         }
         _loc1_ = tile.mapY - MathLibrary.randomize(0,maxSpawnRange);
         if(_loc1_ >= 0)
         {
            _loc2_.push(tile.mapX + _loc1_ * tile.map.mapWidth);
         }
         _loc2_.push(-3);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(buildingImage != null)
         {
            Starling.juggler.remove(buildingImage);
         }
         if(offlineSprite != null)
         {
            Starling.juggler.remove(offlineSprite);
         }
         if(arrMobs != null)
         {
            arrMobs.splice(0);
         }
         if(waypoints != null)
         {
            waypoints.splice(0);
         }
         if(cycle != null)
         {
            cycle.splice(0);
         }
         tile = null;
         buildingImage = null;
         offlineSprite = null;
         arrMobs = null;
         waypoints = null;
         cycle = null;
         super.dispose();
      }
   }
}

