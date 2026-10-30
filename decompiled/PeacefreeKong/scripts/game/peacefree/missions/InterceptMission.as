package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   
   public class InterceptMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 13;
      
      public var mob:Mob;
      
      private var bMaximize:Boolean = false;
      
      private var healthDamage:int = 0;
      
      public function InterceptMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(13,param1);
         this.mob = param1.mob;
         this.bMaximize = param2;
         if(!param3)
         {
            param1.map.deductFP(mob.getInterceptCost(param2));
         }
         timeLeft = mob.getInterceptTime(param2);
         timeLeftTextField.text = "Æ" + timeLeft;
         if(param2)
         {
            healthDamage = 10;
         }
         else
         {
            healthDamage = 5;
         }
         param1.addInvadeEffect();
         mob.bIntercepted = true;
      }
      
      override public function update() : void
      {
         if(mob.isTrash())
         {
            tile.setMission(null);
         }
         mob.health -= healthDamage;
         recompute();
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.removeInvadeEffect();
         mob.bIntercepted = false;
      }
      
      override public function complete() : void
      {
         super.complete();
         mob.health -= mob.health;
         tile.map.mapHUD.bUpdateMiniMap = true;
         tile.removeInvadeEffect();
         mob.bIntercepted = false;
      }
      
      override public function recompute() : void
      {
         timeLeft = mob.getInterceptTime(bMaximize);
         timeLeftTextField.text = "Æ" + timeLeft;
      }
      
      override public function getMissionTitle() : String
      {
         return "Intercepting Enemy";
      }
      
      override public function getMissionDescription() : String
      {
         return "You sent a team to defend this area. Let\'s hope they can handle this " + Mob.getName(mob.type) + " with " + mob.health + "Ø" + ".";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         healthDamage = int(_loc2_[3]);
         recompute();
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + healthDamage;
      }
   }
}

