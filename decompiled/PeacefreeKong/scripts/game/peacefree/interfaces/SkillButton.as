package game.peacefree.interfaces
{
   import game.peacefree.AchievementManager;
   import game.peacefree.PeacefreeGame;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class SkillButton extends Sprite
   {
      
      private var skillID:int;
      
      private var pgame:PeacefreeGame;
      
      private var descText:TextField;
      
      private var skillName:TextField;
      
      private var skillLevel:TextField;
      
      private var upgradeButton:GenericScreenButton;
      
      public function SkillButton(param1:PeacefreeGame, param2:int)
      {
         var boxWidth:int;
         var boxHeight:int;
         var bgQuad:Quad;
         var quad1:Quad;
         var quad2:Quad;
         var quad3:Quad;
         var quad4:Quad;
         var quad5:Quad;
         var pgame:PeacefreeGame = param1;
         var skillID:int = param2;
         super();
         this.pgame = pgame;
         this.skillID = skillID;
         boxWidth = 220;
         boxHeight = 130;
         bgQuad = new Quad(boxWidth,boxHeight,1118481);
         bgQuad.alpha = 0.75;
         addChild(bgQuad);
         quad1 = new Quad(boxWidth + 2,2,3355443);
         quad1.x = 0;
         quad1.y = 0;
         quad1.alpha = 0.75;
         quad2 = new Quad(boxWidth + 2,2,3355443);
         quad2.x = 0;
         quad2.y = boxHeight;
         quad2.alpha = 0.75;
         quad3 = new Quad(2,boxHeight,3355443);
         quad3.x = 0;
         quad3.y = 0;
         quad3.alpha = 0.75;
         quad4 = new Quad(2,boxHeight,3355443);
         quad4.x = boxWidth;
         quad4.y = 0;
         quad4.alpha = 0.75;
         addChild(quad1);
         addChild(quad2);
         addChild(quad3);
         addChild(quad4);
         quad5 = new Quad(boxWidth - 20,1,4293759265);
         quad5.x = 10;
         quad5.y = 36;
         addChild(quad5);
         skillName = new TextField(boxWidth - 20,30,AchievementManager.getSkillName(skillID),Fonts.getDefaultFont().fontName,18,4293759265,true);
         skillName.x = 10;
         skillName.y = 10;
         skillName.vAlign = "top";
         skillName.hAlign = "left";
         skillName.touchable = false;
         skillName.autoScale = true;
         addChild(skillName);
         skillLevel = new TextField(boxWidth - 20,30,"Lv. 1",Fonts.getDefaultFont().fontName,18,3355443,true);
         skillLevel.x = 10;
         skillLevel.y = 10;
         skillLevel.vAlign = "top";
         skillLevel.hAlign = "right";
         skillLevel.touchable = false;
         skillLevel.autoScale = true;
         addChild(skillLevel);
         descText = new TextField(boxWidth - 20,50,"Start with È5 extra.",Fonts.getDefaultFont().fontName,18,16777215,true);
         descText.x = 10;
         descText.y = 40;
         descText.vAlign = "top";
         descText.hAlign = "left";
         descText.touchable = false;
         descText.autoScale = true;
         addChild(descText);
         upgradeButton = new GenericScreenButton(120,30,"Ú" + 1,20);
         upgradeButton.x = boxWidth - 130;
         upgradeButton.y = 90;
         upgradeButton.pressedCallback = function():void
         {
            pgame.achievementManager.addSkill(skillID);
            pgame.skillsInterfacer.refresh();
         };
         addChild(upgradeButton);
      }
      
      public function refresh() : void
      {
         if(pgame.achievementManager.usedTechPoints + pgame.achievementManager.getSkillCost(skillID) <= pgame.achievementManager.maxTechPoints)
         {
            upgradeButton.alpha = 1;
            upgradeButton.bChangeAlpha = true;
            upgradeButton.bEnabled = true;
         }
         else
         {
            upgradeButton.alpha = 0.25;
            upgradeButton.bChangeAlpha = false;
            upgradeButton.bEnabled = false;
         }
         if(pgame.achievementManager.getSkillLevel(skillID) < 1)
         {
            skillLevel.color = 3355443;
         }
         else
         {
            skillLevel.color = 65280;
         }
         skillLevel.text = "Lv. " + pgame.achievementManager.getSkillLevel(skillID);
         descText.text = pgame.achievementManager.getSkillDesc(skillID);
         upgradeButton.textField.text = pgame.achievementManager.getSkillCost(skillID) + "Ú";
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         pgame = null;
         skillName = null;
         skillLevel = null;
         descText = null;
         upgradeButton = null;
         super.dispose();
      }
   }
}

