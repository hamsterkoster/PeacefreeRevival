package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   
   public class RescueMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 5;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      public function RescueMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(5,param1);
         this.bMaximize = param2;
         cost = param1.getRescueCost(param2);
         timeLeft = maxTime = param1.getRescueTime(param2);
         timeLeftTextField.text = "É" + timeLeft;
         if(!param3)
         {
            param1.map.deductFP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         timeLeftTextField.text = "É" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addFP(Math.ceil(timeLeft / maxTime * cost));
      }
      
      override public function complete() : void
      {
         var _loc2_:String = null;
         super.complete();
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
         else
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
      }
      
      override public function getMissionTitle() : String
      {
         return "Rescue Mission";
      }
      
      override public function getMissionDescription() : String
      {
         return "Our troops are currently rescuing " + tile.recruits + "É" + " prisoner" + (tile.recruits > 1 ? "s" : "") + " found in this area.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         timeLeftTextField.text = "É" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + maxTime;
      }
   }
}

