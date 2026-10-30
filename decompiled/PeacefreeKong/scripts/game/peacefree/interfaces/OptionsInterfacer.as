package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.library.SoundLibrary;
   import game.peacefree.PeacefreeGame;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class OptionsInterfacer extends Sprite
   {
      
      private var pgame:PeacefreeGame;
      
      private var diffValueLabel:TextField;
      
      private var bgmOnButton:GenericScreenButton;
      
      private var bgmOffButton:GenericScreenButton;
      
      private var sfxOnButton:GenericScreenButton;
      
      private var sfxOffButton:GenericScreenButton;
      
      public function OptionsInterfacer(param1:PeacefreeGame)
      {
         var blackFilmQuad:Quad;
         var bgmLabel:TextField;
         var sfxLabel:TextField;
         var diffLabel:TextField;
         var closeButton:GenericScreenButton;
         var blackFilmQuad2:Quad;
         var confirmPopup:ConfirmPopup;
         var quitGameButton:GenericScreenButton;
         var resumeButton:GenericScreenButton;
         var pgame:PeacefreeGame = param1;
         super();
         this.pgame = pgame;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         bgmOnButton = new GenericScreenButton(80,40,"ON");
         bgmOnButton.bChangeAlpha = false;
         bgmOnButton.x = GameConfig.GAME_WIDTH / 2 - 40;
         bgmOnButton.y = GameConfig.GAME_HEIGHT / 2 - 200;
         bgmOnButton.pressedCallback = function():void
         {
            pgame.bEnabledBGM = true;
            if(pgame.map != null)
            {
               pgame.map.setEnableBGM(true);
               pgame.map.mapHUD.toggleBGM(false);
            }
            refresh();
         };
         addChild(bgmOnButton);
         bgmOffButton = new GenericScreenButton(80,40,"OFF");
         bgmOffButton.bChangeAlpha = false;
         bgmOffButton.x = bgmOnButton.x + bgmOnButton.width + 20;
         bgmOffButton.y = bgmOnButton.y;
         bgmOffButton.pressedCallback = function():void
         {
            pgame.bEnabledBGM = false;
            if(pgame.map != null)
            {
               pgame.map.setEnableBGM(false);
               pgame.map.mapHUD.toggleBGM(false);
            }
            refresh();
         };
         addChild(bgmOffButton);
         bgmLabel = new TextField(200,40,"Music Volume",Fonts.getDefaultFont().fontName,24,16777215,true);
         bgmLabel.x = bgmOnButton.x - 225;
         bgmLabel.y = bgmOnButton.y;
         bgmLabel.vAlign = "center";
         bgmLabel.hAlign = "right";
         bgmLabel.touchable = false;
         bgmLabel.autoScale = true;
         addChild(bgmLabel);
         sfxOnButton = new GenericScreenButton(80,40,"ON");
         sfxOnButton.bChangeAlpha = false;
         sfxOnButton.x = GameConfig.GAME_WIDTH / 2 - 40;
         sfxOnButton.y = GameConfig.GAME_HEIGHT / 2 - 140;
         sfxOnButton.pressedCallback = function():void
         {
            SoundLibrary.ENABLE_SFX = true;
            if(pgame.map != null)
            {
               pgame.map.mapHUD.toggleSFX(false);
            }
            refresh();
         };
         addChild(sfxOnButton);
         sfxOffButton = new GenericScreenButton(80,40,"OFF");
         sfxOffButton.bChangeAlpha = false;
         sfxOffButton.x = sfxOnButton.x + sfxOnButton.width + 20;
         sfxOffButton.y = sfxOnButton.y;
         sfxOffButton.pressedCallback = function():void
         {
            SoundLibrary.ENABLE_SFX = false;
            if(pgame.map != null)
            {
               pgame.map.mapHUD.toggleSFX(false);
            }
            refresh();
         };
         addChild(sfxOffButton);
         sfxLabel = new TextField(200,40,"SFX Volume",Fonts.getDefaultFont().fontName,24,16777215,true);
         sfxLabel.x = sfxOnButton.x - 225;
         sfxLabel.y = sfxOnButton.y;
         sfxLabel.vAlign = "center";
         sfxLabel.hAlign = "right";
         sfxLabel.touchable = false;
         sfxLabel.autoScale = true;
         addChild(sfxLabel);
         diffValueLabel = new TextField(180,40,"NORMAL",Fonts.getDefaultFont().fontName,24,4293759265,true);
         diffValueLabel.x = GameConfig.GAME_WIDTH / 2 - 40;
         diffValueLabel.y = GameConfig.GAME_HEIGHT / 2 - 80;
         diffValueLabel.vAlign = "center";
         diffValueLabel.hAlign = "center";
         addChild(diffValueLabel);
         diffLabel = new TextField(200,40,"Difficulty",Fonts.getDefaultFont().fontName,24,16777215,true);
         diffLabel.x = diffValueLabel.x - 225;
         diffLabel.y = diffValueLabel.y;
         diffLabel.vAlign = "center";
         diffLabel.hAlign = "right";
         diffLabel.touchable = false;
         diffLabel.autoScale = true;
         addChild(diffLabel);
         closeButton = new GenericScreenButton(45,40,"X",24,2003173376);
         closeButton.x = GameConfig.GAME_WIDTH / 2 + 325;
         closeButton.y = GameConfig.GAME_HEIGHT / 2 - 250;
         closeButton.pressedCallback = function():void
         {
            pgame.map.hideOptionsInterface();
         };
         addChild(closeButton);
         blackFilmQuad2 = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad2.alpha = 0.9;
         blackFilmQuad2.visible = false;
         confirmPopup = new ConfirmPopup(300,120,"Really Exit Game?","You will lose any unsaved data.",function():void
         {
            pgame.goToCampaignScreen();
         },function():void
         {
            blackFilmQuad2.visible = false;
            confirmPopup.visible = false;
         });
         confirmPopup.x = GameConfig.GAME_WIDTH / 2 - confirmPopup.width / 2;
         confirmPopup.y = GameConfig.GAME_HEIGHT / 2;
         confirmPopup.visible = false;
         quitGameButton = new GenericScreenButton(200,50,"Exit Game",24);
         quitGameButton.x = GameConfig.GAME_WIDTH / 2 - quitGameButton.width / 2;
         quitGameButton.y = GameConfig.GAME_HEIGHT / 2;
         quitGameButton.pressedCallback = function():void
         {
            blackFilmQuad2.visible = true;
            confirmPopup.visible = true;
         };
         addChild(quitGameButton);
         resumeButton = new GenericScreenButton(300,60,"Back to Game",28);
         resumeButton.x = GameConfig.GAME_WIDTH / 2 - resumeButton.width / 2;
         resumeButton.y = GameConfig.GAME_HEIGHT / 2 + 100;
         resumeButton.pressedCallback = function():void
         {
            pgame.map.hideOptionsInterface();
         };
         addChild(resumeButton);
         addChild(blackFilmQuad2);
         addChild(confirmPopup);
      }
      
      public function refresh() : void
      {
         if(pgame.map == null)
         {
            return;
         }
         switch(pgame.map.difficulty)
         {
            case 0:
               diffValueLabel.text = "EASY";
               break;
            case 1:
               diffValueLabel.text = "NORMAL";
               break;
            case 2:
               diffValueLabel.text = "HARD";
               break;
            case 3:
               diffValueLabel.text = "HEROIC";
         }
         if(pgame.map.bEnableBGM)
         {
            bgmOnButton.alpha = 1;
            bgmOffButton.alpha = 0.25;
         }
         else
         {
            bgmOnButton.alpha = 0.25;
            bgmOffButton.alpha = 1;
         }
         if(SoundLibrary.ENABLE_SFX)
         {
            sfxOnButton.alpha = 1;
            sfxOffButton.alpha = 0.25;
         }
         else
         {
            sfxOnButton.alpha = 0.25;
            sfxOffButton.alpha = 1;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         pgame = null;
         diffValueLabel = null;
         bgmOnButton = null;
         bgmOffButton = null;
         sfxOnButton = null;
         sfxOffButton = null;
         super.dispose();
      }
   }
}

