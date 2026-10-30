package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.TitleScreen;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.extensions.PDParticleSystem;
   import starling.text.TextField;
   
   public class SkillsInterfacer extends Sprite
   {
      
      private var pgame:PeacefreeGame;
      
      private var medalBust:Image;
      
      private var medal3:Image;
      
      private var medal2:Image;
      
      private var medal1:Image;
      
      private var achievementParticle:PDParticleSystem;
      
      private var medalsLeft:TextField;
      
      private var resetButton:GenericScreenButton;
      
      private var skillButtons:Array;
      
      public function SkillsInterfacer(param1:PeacefreeGame)
      {
         var blackFilmQuad:Quad;
         var instructionsText:TextField;
         var wantFreeMedals:GenericScreenButton;
         var closeButton:GenericScreenButton;
         var i:int;
         var skillButton:SkillButton;
         var blackFilmQuad2:Quad;
         var visitUs:TextField;
         var closeButton2:GenericScreenButton;
         var pgame:PeacefreeGame = param1;
         skillButtons = [];
         super();
         this.pgame = pgame;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         medalBust = new Image(Assets.getAtlas().getTexture("medal_bust"));
         medalBust.x = GameConfig.GAME_WIDTH / 2 - 370;
         medalBust.y = GameConfig.GAME_HEIGHT / 2 - 130;
         addChild(medalBust);
         medal3 = new Image(Assets.getAtlas().getTexture("gold_medal"));
         medal3.x = medalBust.x + 5;
         medal3.y = medalBust.y - 90;
         addChild(medal3);
         medal2 = new Image(Assets.getAtlas().getTexture("gold_medal"));
         medal2.x = medalBust.x + 105;
         medal2.y = medalBust.y - 90;
         addChild(medal2);
         medal1 = new Image(Assets.getAtlas().getTexture("gold_medal"));
         medal1.x = medalBust.x + 55;
         medal1.y = medalBust.y - 80;
         addChild(medal1);
         medalsLeft = new TextField(medalBust.width,medalBust.height,"31 / 31",Fonts.getDefaultFont().fontName,30,16777215,true);
         medalsLeft.x = medalBust.x + 10;
         medalsLeft.y = medalBust.y + 10;
         medalsLeft.vAlign = "bottom";
         medalsLeft.hAlign = "right";
         medalsLeft.touchable = false;
         medalsLeft.autoScale = true;
         addChild(medalsLeft);
         achievementParticle = new PDParticleSystem(XML(new ParticleAssets.ParticleGoldXML()),Assets.getAtlas().getTexture("particle"));
         Starling.juggler.add(achievementParticle);
         achievementParticle.start();
         achievementParticle.x = medal1.x + medal1.width / 2;
         achievementParticle.y = medal1.y + medal1.height / 2 + 20;
         addChild(achievementParticle);
         instructionsText = new TextField(250,50,"Spend Ú Medals on upgrades.",Fonts.getDefaultFont().fontName,20,16777215,true);
         instructionsText.x = GameConfig.GAME_WIDTH / 2 - 100;
         instructionsText.y = GameConfig.GAME_HEIGHT / 2 - 230;
         instructionsText.vAlign = "top";
         instructionsText.hAlign = "left";
         instructionsText.touchable = false;
         instructionsText.autoScale = true;
         addChild(instructionsText);
         wantFreeMedals = new GenericScreenButton(150,24,"Want Free Medals?",20,0,0);
         wantFreeMedals.bgQuad.visible = false;
         wantFreeMedals.textField.color = 4293759265;
         wantFreeMedals.x = instructionsText.x + instructionsText.width + 5;
         wantFreeMedals.y = instructionsText.y;
         wantFreeMedals.pressedCallback = function():void
         {
            blackFilmQuad2.visible = true;
            TitleScreen.FBBUTTON.visible = true;
            TitleScreen.TWITTERBUTTON.visible = true;
            closeButton2.visible = true;
            visitUs.visible = true;
         };
         addChild(wantFreeMedals);
         closeButton = new GenericScreenButton(45,40,"X",24,2003173376);
         closeButton.x = GameConfig.GAME_WIDTH / 2 + 325;
         closeButton.y = GameConfig.GAME_HEIGHT / 2 - 250;
         closeButton.pressedCallback = function():void
         {
            pgame.hideSkillsInterfacer();
         };
         addChild(closeButton);
         resetButton = new GenericScreenButton(100,30,"Reset");
         resetButton.x = medalBust.x;
         resetButton.y = medalBust.y + 35;
         resetButton.pressedCallback = function():void
         {
            pgame.achievementManager.resetSkills();
            refresh();
         };
         addChild(resetButton);
         i = 1;
         while(i < 9)
         {
            skillButton = new SkillButton(pgame,i);
            skillButton.x = GameConfig.GAME_WIDTH / 2 - skillButton.width * 1.5 - 10 + (skillButton.width + 20) * (i % 3);
            skillButton.y = GameConfig.GAME_HEIGHT / 2 - 180 + (20 + skillButton.height) * Math.floor(i / 3);
            skillButton.refresh();
            addChild(skillButton);
            skillButtons.push(skillButton);
            i = i + 1;
         }
         blackFilmQuad2 = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad2.alpha = 0.9;
         blackFilmQuad2.visible = false;
         addChild(blackFilmQuad2);
         visitUs = new TextField(300,100,"Visit our Website to receive\nFree Ú Gold Medals.",Fonts.getDefaultFont().fontName,24,16777215,true);
         visitUs.x = GameConfig.GAME_WIDTH / 2 - visitUs.width / 2;
         visitUs.y = GameConfig.GAME_HEIGHT / 2 - 160;
         visitUs.vAlign = "top";
         visitUs.hAlign = "center";
         visitUs.visible = false;
         visitUs.touchable = false;
         visitUs.autoScale = true;
         addChild(visitUs);
         closeButton2 = new GenericScreenButton(200,50,"Close");
         closeButton2.x = GameConfig.GAME_WIDTH / 2 - closeButton2.width / 2;
         closeButton2.y = GameConfig.GAME_HEIGHT / 2 + 180;
         closeButton2.visible = false;
         closeButton2.pressedCallback = function():void
         {
            blackFilmQuad2.visible = false;
            TitleScreen.FBBUTTON.visible = false;
            TitleScreen.TWITTERBUTTON.visible = false;
            closeButton2.visible = false;
            visitUs.visible = false;
            refresh();
         };
         addChild(closeButton2);
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         pgame.checkShareAchievements();
         if(TitleScreen.FBBUTTON != null)
         {
            if(pgame.bLikedFB)
            {
               TitleScreen.FBBUTTON.alpha = 0.25;
            }
            if(pgame.bTwittered)
            {
               TitleScreen.TWITTERBUTTON.alpha = 0.25;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < skillButtons.length)
         {
            skillButtons[_loc1_].refresh();
            _loc1_++;
         }
         medalsLeft.text = pgame.achievementManager.maxTechPoints - pgame.achievementManager.usedTechPoints + " / " + pgame.achievementManager.maxTechPoints;
         if(pgame.achievementManager.usedTechPoints > 0)
         {
            resetButton.visible = true;
         }
         else
         {
            resetButton.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         skillButtons.splice(0);
         pgame = null;
         resetButton = null;
         skillButtons = null;
         super.dispose();
      }
   }
}

