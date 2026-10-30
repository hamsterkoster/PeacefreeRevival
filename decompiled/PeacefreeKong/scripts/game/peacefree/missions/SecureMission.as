package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   
   public class SecureMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 4;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      public var killsPerHour:int;
      
      public var maxDanger:int;
      
      public function SecureMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(4,param1);
         this.bMaximize = param2;
         cost = param1.getSecureCost(param2);
         timeLeft = maxTime = param1.getSecureTime(param2);
         maxDanger = param1.danger;
         killsPerHour = Math.max(1,Math.floor(param1.danger / timeLeft));
         timeLeftTextField.text = "Ì" + timeLeft;
         param1.addInvadeEffect();
         if(!param3)
         {
            param1.map.deductFP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         tile.danger -= killsPerHour;
         if(tile.danger < 0)
         {
            tile.danger = 0;
         }
         timeLeftTextField.text = "Ì" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addFP(Math.ceil(timeLeft / maxTime * cost));
         tile.removeInvadeEffect();
      }
      
      override public function complete() : void
      {
         var _loc2_:String = null;
         super.complete();
         if(tile.danger > 0)
         {
            tile.danger = 0;
         }
         var _loc3_:int = tile.map.player.maxRecruits - tile.map.player.totalRecruits;
         var _loc1_:int = Math.max(0,Math.min(_loc3_,tile.recruits));
         var _loc5_:int = tile.recruits - _loc1_;
         tile.map.player.addTroop(_loc1_);
         var _loc4_:int = _loc5_ * 10;
         if(tile.map.difficulty == 3)
         {
            _loc4_ = _loc5_ * 5;
         }
         tile.map.player.food += _loc4_;
         tile.map.player.minerals += _loc4_;
         if(_loc1_ != tile.recruits)
         {
            _loc2_ = "+" + _loc4_ + "È" + " +" + _loc4_ + "Â";
            if(_loc1_ > 0)
            {
               _loc2_ = "+" + _loc1_ + "É" + "\n" + _loc2_;
            }
            tile.addFloatText(_loc2_);
         }
         else if(_loc1_ > 0)
         {
            tile.addFloatText("+" + _loc1_ + "É");
         }
         tile.recruits = 0;
         tile.bRescued = true;
         if(_loc1_ > 0)
         {
            tile.map.mapHUD.logInterfacer.addLogEntry(tile,"É " + _loc1_ + " rescued and recruited.");
         }
         if(_loc5_ > 0)
         {
            tile.map.mapHUD.logInterfacer.addLogEntry(tile,"É " + _loc5_ + " can\'t join. Army maxed.");
            tile.map.mapHUD.showArmySizeWarning();
         }
         if(tile.map.act.cache.rescue == undefined)
         {
            tile.map.act.cache.rescue = 0;
         }
         tile.map.act.cache.rescue += _loc1_ + _loc5_;
         tile.map.updateTotalRescues();
         tile.map.secureTile(tile);
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ì Secure complete.");
         tile.removeInvadeEffect();
         tile.map.mapHUD.bUpdateMiniMap = true;
         tile.map.bMapChanged = true;
      }
      
      override public function getMissionTitle() : String
      {
         return "Secure Mission";
      }
      
      override public function getMissionDescription() : String
      {
         return "Our troops are fighting the enemy in order to secure this area.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         killsPerHour = int(_loc2_[5]);
         maxDanger = int(_loc2_[6]);
         timeLeftTextField.text = "Ì" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + maxTime + "#" + killsPerHour + "#" + maxDanger;
      }
   }
}

