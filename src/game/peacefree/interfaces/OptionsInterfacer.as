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

      // PeacefreeRevival: the campaign's acts are 1 to LAST_ACT; act 1 is always open.
      private static const LAST_ACT:int = 11;

      private var unlockActsButton:GenericScreenButton;

      public function OptionsInterfacer(param1:PeacefreeGame)
      {
         var unlockActsPopup:ConfirmPopup;
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
         // PeacefreeRevival: a button that opens every act on the campaign screen, as if each
         // earlier act was won, and saves that. It can't be undone, hence the confirm popup.
         unlockActsPopup = new ConfirmPopup(300,120,"Unlock All Acts?","Every act opens on the campaign screen.",function():void
         {
            unlockAllActs();
            blackFilmQuad2.visible = false;
            unlockActsPopup.visible = false;
            refresh();
         },function():void
         {
            blackFilmQuad2.visible = false;
            unlockActsPopup.visible = false;
         });
         unlockActsPopup.x = GameConfig.GAME_WIDTH / 2 - unlockActsPopup.width / 2;
         unlockActsPopup.y = GameConfig.GAME_HEIGHT / 2;
         unlockActsPopup.visible = false;
         unlockActsButton = new GenericScreenButton(200,40,"Unlock All Acts",20);
         unlockActsButton.bChangeAlpha = false;
         unlockActsButton.x = GameConfig.GAME_WIDTH / 2 - unlockActsButton.width / 2;
         unlockActsButton.y = resumeButton.y + resumeButton.height + 20;
         unlockActsButton.pressedCallback = function():void
         {
            if(!allActsUnlocked())
            {
               blackFilmQuad2.visible = true;
               unlockActsPopup.visible = true;
            }
         };
         addChild(unlockActsButton);
         addChild(blackFilmQuad2);
         addChild(confirmPopup);
         addChild(unlockActsPopup);
      }

      // PeacefreeRevival: true when acts 2 to LAST_ACT are all in the save's unlocked acts.
      private function allActsUnlocked() : Boolean
      {
         var _loc1_:int = 2;
         while(_loc1_ <= LAST_ACT)
         {
            if(!isActUnlocked(_loc1_))
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }

      // PeacefreeRevival: the same test as the game's act buttons (CampaignActButton).
      private function isActUnlocked(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < pgame.unlockedActs.length)
         {
            if(pgame.unlockedActs[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }

      // PeacefreeRevival: adds the missing acts, the way winning an act adds the next one
      // (Act1.as and the others), and saves.
      private function unlockAllActs() : void
      {
         var _loc1_:int = 2;
         while(_loc1_ <= LAST_ACT)
         {
            if(!isActUnlocked(_loc1_))
            {
               pgame.unlockedActs.push(_loc1_);
            }
            _loc1_++;
         }
         pgame.saveGameData();
      }
      
      public function refresh() : void
      {
         // PeacefreeRevival: the button is dimmed once every act is open.
         if(allActsUnlocked())
         {
            unlockActsButton.textField.text = "All Acts Unlocked";
            unlockActsButton.alpha = 0.25;
         }
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
         unlockActsButton = null;
         super.dispose();
      }
   }
}

