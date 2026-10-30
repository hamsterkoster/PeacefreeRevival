package game.peacefree.missions
{
   import game.peacefree.Mission;
   import game.peacefree.Tile;
   
   public class SalvageMission extends Mission
   {
      
      public static const MISSION_TYPE:int = 1;
      
      public var bMaximize:Boolean;
      
      public var cost:int;
      
      public var maxTime:int;
      
      public var collectPerHour:int;
      
      public function SalvageMission(param1:Tile, param2:Boolean, param3:Boolean = false)
      {
         super(1,param1);
         this.bMaximize = param2;
         cost = param1.getSalvageCost(param2);
         timeLeft = maxTime = param1.getSalvageTime(param2);
         timeLeftTextField.text = "Ï" + timeLeft;
         var _loc4_:int = Math.max(param1.food,param1.minerals);
         collectPerHour = Math.max(1,Math.ceil(_loc4_ / timeLeft));
         if(!param3)
         {
            param1.map.deductSP(cost);
         }
      }
      
      override public function update() : void
      {
         super.update();
         var _loc2_:int = Math.min(tile.food,collectPerHour);
         var _loc3_:int = Math.min(tile.minerals,collectPerHour);
         var _loc1_:String = "";
         if(_loc2_ > 0)
         {
            _loc1_ += "+" + _loc2_ + "È" + " ";
            tile.map.player.food += _loc2_;
            tile.food -= _loc2_;
         }
         if(_loc3_ > 0)
         {
            _loc1_ += "+" + _loc3_ + "Â" + " ";
            tile.map.player.minerals += _loc3_;
            tile.minerals -= _loc3_;
         }
         tile.addFloatText(_loc1_);
         timeLeftTextField.text = "Ï" + timeLeft;
      }
      
      override public function cancel() : void
      {
         super.cancel();
         tile.map.addSP(Math.ceil(timeLeft / maxTime * cost));
      }
      
      override public function complete() : void
      {
         var _loc1_:String = null;
         super.complete();
         if(tile.food < 0)
         {
            tile.food = 0;
         }
         if(tile.minerals < 0)
         {
            tile.minerals = 0;
         }
         var _loc2_:int = tile.food;
         var _loc3_:int = tile.minerals;
         if(_loc2_ + _loc3_ > 0)
         {
            _loc1_ = "";
            if(_loc2_ > 0)
            {
               _loc1_ += "+" + _loc2_ + "È" + " ";
               tile.map.player.food += _loc2_;
               tile.food = 0;
            }
            if(_loc3_ > 0)
            {
               _loc1_ += "+" + _loc3_ + "Â" + " ";
               tile.map.player.minerals += _loc3_;
               tile.minerals = 0;
            }
            tile.addFloatText(_loc1_);
         }
         tile.map.mapHUD.logInterfacer.addLogEntry(tile,"Ï Salvage complete.");
      }
      
      override public function getMissionTitle() : String
      {
         return "Salvage Mission";
      }
      
      override public function getMissionDescription() : String
      {
         return "Our troops are salvaging whatever materials they can find in this area.";
      }
      
      override public function setCounter(param1:String) : void
      {
         var _loc2_:Array = param1.split("#");
         timeLeft = int(_loc2_[0]);
         rushTimeLeft = int(_loc2_[1]);
         bMaximize = _loc2_[2] == "true";
         cost = int(_loc2_[3]);
         maxTime = int(_loc2_[4]);
         collectPerHour = int(_loc2_[5]);
         timeLeftTextField.text = "Ï" + timeLeft;
         if(rushTimeLeft > 0)
         {
            rush(rushTimeLeft);
         }
      }
      
      override public function getCounter() : String
      {
         return timeLeft + "#" + rushTimeLeft + "#" + bMaximize + "#" + cost + "#" + maxTime + "#" + collectPerHour;
      }
   }
}

