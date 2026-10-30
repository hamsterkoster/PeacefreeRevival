package game.peacefree.missions
{
   import game.library.MathLibrary;
   import game.peacefree.Building;
   import game.peacefree.Mission;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   
   public class InvadeMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 12;
      
      public var mob:Mob;
      
      public var bMaximize:Boolean = false;
      
      public var bDefenseMode:Boolean = false;
      
      private var invadeTime:int = 0;
      
      private var secureTime:int = 0;
      
      private var healthDamage:int = 0;
      
      public function InvadeMission(param1:Mob, param2:Tile, param3:Boolean = false)
      {
         super(12,param2);
         if(param1 == null)
         {
            param1 = param2.mob;
         }
         if(param1 == null)
         {
            return;
         }
         this.mob = param1;
         if(param2.map.difficulty == 0)
         {
            invadeTime = timeLeft = Math.max(12,Mob.getInvadeHours(param1.type) * 2);
         }
         else
         {
            invadeTime = timeLeft = Mob.getInvadeHours(param1.type);
         }
         timeLeftTextField.text = "Ä" + timeLeft;
         timeLeftTextField.color = 16751163;
      }
      
      override public function update() : void
      {
         if(mob == null || mob.isTrash())
         {
            tile.setMission(null);
            tile.removeInvadeEffect();
         }
         if(bDefenseMode)
         {
            mob.health -= healthDamage;
            recompute();
         }
         else if(mob.zapCounter <= 0)
         {
            invadeTime = invadeTime - 1;
            timeLeft = invadeTime;
            timeLeftTextField.text = "Ä" + timeLeft;
            timeLeftTextField.color = 16751163;
         }
         if(timeLeft <= 0 || mob.isTrash())
         {
            complete();
            removeFromParent(true);
            return;
         }
      }
      
      override public function cancel() : void
      {
         bDefenseMode = false;
         tile.removeInvadeEffect();
         mob.bIntercepted = false;
      }
      
      override public function isRushable() : Boolean
      {
         return bDefenseMode;
      }
      
      override public function complete() : void
      {
         var _loc1_:int = 0;
         super.complete();
         if(bDefenseMode)
         {
            mob.health -= mob.health;
         }
         else if(!mob.isTrash())
         {
            tile.unsecure();
            tile.danger = Mob.getDanger(mob.type);
            if(tile.building == null)
            {
               tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ä " + tile.tileName + " lost.");
            }
            else
            {
               tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ä " + Building.getBuildingName(tile.building.type) + " lost.");
            }
            if(mob.type == 3 && MathLibrary.randomize(0,100) < 80 || mob.type == 15 || mob.type == 16)
            {
               _loc1_ = MathLibrary.randomize(1,4);
               tile.map.player.addTroop(-_loc1_);
               tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ù " + _loc1_ + "×" + " died by poison.");
            }
         }
         tile.map.mapHUD.bUpdateMiniMap = true;
         tile.removeInvadeEffect();
         mob.bIntercepted = false;
      }
      
      public function intercept(param1:Boolean) : void
      {
         tile.map.deductFP(mob.getInterceptCost(param1));
         secureTime = mob.getInterceptTime(param1);
         bDefenseMode = true;
         if(param1)
         {
            healthDamage = 10;
         }
         else
         {
            healthDamage = 5;
         }
         recompute();
         tile.addInvadeEffect();
         mob.bIntercepted = true;
      }
      
      override public function recompute() : void
      {
         if(bDefenseMode)
         {
            secureTime = mob.getInterceptTime(bMaximize);
            timeLeft = secureTime;
            timeLeftTextField.text = "Æ" + timeLeft;
            timeLeftTextField.color = 16777215;
         }
         else
         {
            timeLeftTextField.text = "Ä" + timeLeft;
            timeLeftTextField.color = 16751163;
         }
      }
      
      override public function getMissionTitle() : String
      {
         if(bDefenseMode)
         {
            return "Intercepting Enemy";
         }
         return "Enemy Invasion";
      }
      
      override public function getMissionDescription() : String
      {
         var _loc1_:String = null;
         if(bDefenseMode)
         {
            return "You sent a team to defend this area. Let\'s hope they can handle this " + Mob.getName(mob.type) + " with " + "Ø" + mob.health + ".";
         }
         if(tile.building != null)
         {
            _loc1_ = Building.getBuildingName(tile.building.type);
         }
         else
         {
            _loc1_ = tile.tileName;
         }
         return "A " + Mob.getName(mob.type) + " with " + "Ø" + mob.health + " is invading this area. You need to intercept asap!";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         bDefenseMode = _loc2_[3] == "true";
         invadeTime = int(_loc2_[4]);
         secureTime = int(_loc2_[5]);
         healthDamage = int(_loc2_[6]);
         recompute();
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + bDefenseMode + "#" + invadeTime + "#" + secureTime + "#" + healthDamage;
      }
   }
}

