package game.peacefree.interfaces
{
   import game.peacefree.Act;
   import game.peacefree.CampaignSelectorScreen;
   import starling.events.TouchEvent;
   
   public class CampaignActButton extends GenericScreenButton
   {
      
      public var actNumber:int;
      
      public var cscreen:CampaignSelectorScreen;
      
      public function CampaignActButton(param1:CampaignSelectorScreen, param2:int)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         var _loc7_:int = 0;
         super(150,38,"Act " + param2);
         if(param2 == 11)
         {
            textField.text = "Boss Run";
         }
         var _loc6_:Act = Act.getAct(param2);
         try
         {
            _loc4_ = _loc6_.getTotalAchievements();
            if(_loc4_ > 0)
            {
               textField.text += " ";
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  textField.text += "Ú";
                  _loc5_++;
               }
            }
         }
         catch(error:Error)
         {
         }
         this.cscreen = param1;
         this.actNumber = param2;
         pressedCallback = onPressedCallback;
         if(param2 > 1)
         {
            _loc3_ = false;
            _loc7_ = 0;
            while(_loc7_ < param1.pgame.unlockedActs.length)
            {
               if(param1.pgame.unlockedActs[_loc7_] == param2)
               {
                  _loc3_ = true;
                  break;
               }
               _loc7_++;
            }
            if(!_loc3_)
            {
               visible = false;
            }
         }
         if(param2 == 11)
         {
            if(!param1.pgame.isPremiumPlayer())
            {
               visible = false;
            }
            else
            {
               visible = true;
            }
         }
      }
      
      public function onPressedCallback(param1:TouchEvent) : void
      {
         cscreen.setAct(actNumber);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         cscreen = null;
         super.dispose();
      }
      
      public function setIsSelected(param1:Boolean) : void
      {
         if(param1)
         {
            bgQuad.color = 408379;
         }
         else
         {
            bgQuad.color = 136726;
         }
      }
   }
}

