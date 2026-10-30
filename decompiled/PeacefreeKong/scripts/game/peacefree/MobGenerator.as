package game.peacefree
{
   import game.peacefree.mobs.GiasRobo;
   import game.peacefree.mobs.GiasRoboHand;
   import game.peacefree.mobs.Jenygrin;
   import game.peacefree.mobs.NilHelios;
   import game.peacefree.mobs.RougeEmpress;
   
   public class MobGenerator
   {
      
      public var tile:Tile;
      
      public var mobType:int;
      
      public var currentMob:Mob = null;
      
      public var cycle:Array = null;
      
      public var waypoints:Array = null;
      
      public var missionID:int = -1;
      
      private var bTrash:Boolean = false;
      
      private var timeout:int;
      
      private var counter:int = 0;
      
      private var totalSpawn:int = 0;
      
      private var maxSpawn:int = -1;
      
      public function MobGenerator(param1:Tile, param2:int, param3:int = 240000, param4:int = 0, param5:int = -1)
      {
         super();
         this.tile = param1;
         this.mobType = param2;
         this.timeout = param3;
         this.maxSpawn = param4;
         if(param5 == -1)
         {
            counter = param3;
         }
         else
         {
            counter = param5;
         }
      }
      
      public static function generate(param1:Map, param2:String) : MobGenerator
      {
         var _loc5_:Array = param2.split(":");
         var _loc3_:Tile = param1.tiles[int(_loc5_[0]) + int(_loc5_[1]) * param1.mapWidth];
         var _loc4_:MobGenerator = new MobGenerator(_loc3_,int(_loc5_[2]));
         if(int(_loc5_[3]) != -1)
         {
            _loc4_.currentMob = param1.tiles[int(_loc5_[3]) + int(_loc5_[4]) * param1.mapWidth].mob;
         }
         if(_loc5_[5] != "-1")
         {
            _loc4_.cycle = _loc5_[5].split(",");
         }
         if(_loc5_[6] != "-1")
         {
            _loc4_.waypoints = _loc5_[6].split(",");
         }
         _loc4_.timeout = int(_loc5_[7]);
         _loc4_.counter = int(_loc5_[8]);
         _loc4_.totalSpawn = int(_loc5_[9]);
         _loc4_.maxSpawn = int(_loc5_[10]);
         _loc4_.missionID = int(_loc5_[11]);
         return _loc4_;
      }
      
      public function reset() : void
      {
         counter = 0;
      }
      
      public function progress(param1:int) : void
      {
         if(maxSpawn > 0 && totalSpawn >= maxSpawn)
         {
            trash();
            return;
         }
         if(tile.bSecured)
         {
            trash();
            return;
         }
         if(counter < timeout)
         {
            counter += param1;
         }
         if(counter >= timeout)
         {
            if(!tile.bSecured && tile.mob == null)
            {
               spawn();
               counter = 0;
            }
         }
      }
      
      private function spawn() : void
      {
         switch(mobType - 11)
         {
            case 0:
               currentMob = new NilHelios(tile);
               break;
            case 10:
               currentMob = new RougeEmpress(tile);
               break;
            case 11:
               currentMob = new Jenygrin(tile,2);
               break;
            case 12:
               currentMob = new GiasRobo(tile);
               break;
            case 13:
               currentMob = new GiasRoboHand(tile,24);
               break;
            case 14:
               currentMob = new GiasRoboHand(tile,25);
               break;
            default:
               currentMob = new Mob(tile,mobType);
         }
         if(cycle != null)
         {
            currentMob.cycle = cycle.concat();
         }
         if(waypoints != null)
         {
            currentMob.waypoints = waypoints.concat();
         }
         tile.map.addMob(currentMob);
         totalSpawn = totalSpawn + 1;
      }
      
      public function trash() : void
      {
         bTrash = true;
      }
      
      public function isTrash() : Boolean
      {
         return bTrash;
      }
      
      public function getData() : String
      {
         var _loc1_:String = "";
         _loc1_ += tile.mapX + ":" + tile.mapY;
         _loc1_ += ":" + mobType;
         if(currentMob != null && !currentMob.isTrash())
         {
            _loc1_ += ":" + currentMob.tile.mapX + ":" + currentMob.tile.mapY;
         }
         else
         {
            _loc1_ += ":-1:-1";
         }
         if(cycle != null)
         {
            _loc1_ += ":" + cycle.toString();
         }
         else
         {
            _loc1_ += ":-1";
         }
         if(waypoints != null)
         {
            _loc1_ += ":" + waypoints.toString();
         }
         else
         {
            _loc1_ += ":-1";
         }
         _loc1_ += ":" + timeout;
         _loc1_ += ":" + counter;
         _loc1_ += ":" + totalSpawn;
         _loc1_ += ":" + maxSpawn;
         return _loc1_ + (":" + missionID);
      }
      
      public function dispose() : void
      {
         if(cycle != null)
         {
            cycle.splice(0);
         }
         if(waypoints != null)
         {
            waypoints.splice(0);
         }
         tile = null;
         currentMob = null;
         cycle = null;
         waypoints = null;
      }
   }
}

