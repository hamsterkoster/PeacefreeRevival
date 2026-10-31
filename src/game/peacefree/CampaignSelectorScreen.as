package game.peacefree
{
   import game.container.GameConfig;
   import game.interfaces.Clickable;
   import game.library.SoundLibrary;
   import game.peacefree.interfaces.CampaignActButton;
   import game.peacefree.interfaces.GenericScreenButton;
   import game.peacefree.interfaces.OptionsInterfacer;
   import game.peacefree.interfaces.Tooltip;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.TouchEvent;
   import starling.extensions.PDParticleSystem;
   import starling.text.TextField;
   
   public class CampaignSelectorScreen extends Sprite
   {
      
      private var campaignButton:GenericScreenButton;
      
      private var sandboxButton:GenericScreenButton;
      
      private var upgradesButton:GenericScreenButton;
      
      private var loadFileButton:GenericScreenButton;
      
      private var shopButton:Clickable;
      
      private var premiumButton:Clickable;
      
      private var skillsButton:Clickable;
      
      private var mainMenuButton:GenericScreenButton;
      
      private var easyDiffButton:GenericScreenButton;
      
      private var normalDiffButton:GenericScreenButton;
      
      private var hardDiffButton:GenericScreenButton;
      
      private var heroicDiffButton:GenericScreenButton;
      
      private var startButton:GenericScreenButton;
      
      private var actButtons:Array;
      
      private var actNumber:TextField;
      
      private var actTitle:TextField;
      
      private var actDesc:TextField;
      
      public var pgame:PeacefreeGame;
      
      public var actSelected:int = 1;
      
      private var bgImage1:Image;
      
      private var actDetailsSprite:Sprite;
      
      private var bTransitioning:Boolean = false;
      
      private var lastActButtonSelected:CampaignActButton = null;
      
      private var lastDiffButtonSelected:GenericScreenButton = null;
      
      private var difficulty:int = 1;
      
      public var sfxButton:Clickable;
      
      public var bgmButton:Clickable;
      
      // PeacefreeRevival: the Settings button and the options panel it opens, made on first use.
      private var settingsButton:GenericScreenButton;
      
      private var optionsInterfacer:OptionsInterfacer;
      
      private var versionTextField:TextField;
      
      private var difficultyLabel:TextField;
      
      private var medalBust:Image;
      
      private var medal3:Image;
      
      private var medal2:Image;
      
      private var medal1:Image;
      
      private var achievementParticle:PDParticleSystem;
      
      public function CampaignSelectorScreen(param1:PeacefreeGame)
      {
         var statusQuad:Quad;
         var statusQuad2:Quad;
         var i:int;
         var statusQuad3:Quad;
         var statusQuad5:Quad;
         var highestAct:int;
         var easyDiffTooltip:Tooltip;
         var hardDiffTooltip:Tooltip;
         var heroicDiffTooltip:Tooltip;
         var pgame:PeacefreeGame = param1;
         super();
         this.pgame = pgame;
         bgImage1 = new Image(Assets.getAtlas().getTexture("campaignbg_01"));
         bgImage1.width = GameConfig.GAME_WIDTH;
         bgImage1.height = GameConfig.GAME_HEIGHT;
         addChild(bgImage1);
         statusQuad = new Quad(GameConfig.GAME_WIDTH,50,1118481);
         statusQuad.x = 0;
         statusQuad.y = 0;
         statusQuad.alpha = 0.25;
         addChild(statusQuad);
         statusQuad2 = new Quad(GameConfig.GAME_WIDTH,2,6710886);
         statusQuad2.x = 0;
         statusQuad2.y = 50;
         statusQuad2.alpha = 0.25;
         addChild(statusQuad2);
         shopButton = new Clickable(Assets.getAtlas().getTexture("weaponsbutton"));
         shopButton.x = GameConfig.GAME_WIDTH - 310 - 130;
         shopButton.y = -2;
         shopButton.pressedCallback = function():void
         {
            pgame.showShopInterface();
         };
         if(pgame.isPremiumPlayer())
         {
            addChild(shopButton);
         }
         if(!pgame.isPremiumPlayer())
         {
            premiumButton = new Clickable(Assets.getAtlas().getTexture("goldbutton"));
            premiumButton.x = GameConfig.GAME_WIDTH - 310 - 130;
            premiumButton.y = -2;
            premiumButton.pressedCallback = function():void
            {
               pgame.showPremiumInterface();
            };
            addChild(premiumButton);
         }
         skillsButton = new GenericScreenButton(95,40,"Tech");
         skillsButton.x = GameConfig.GAME_WIDTH - 310;
         skillsButton.y = -2;
         skillsButton.pressedCallback = function():void
         {
            pgame.showSkillsInterface();
         };
         addChild(skillsButton);
         loadFileButton = new GenericScreenButton(95,40,"Load");
         loadFileButton.x = GameConfig.GAME_WIDTH - 205;
         loadFileButton.y = -2;
         loadFileButton.pressedCallback = function():void
         {
            pgame.showSaveFileInterface();
         };
         addChild(loadFileButton);
         mainMenuButton = new GenericScreenButton(85,40,"Back");
         mainMenuButton.x = GameConfig.GAME_WIDTH - 100;
         mainMenuButton.y = -2;
         mainMenuButton.pressedCallback = function():void
         {
            pgame.goToTitleScreen();
         };
         addChild(mainMenuButton);
         actButtons = [];
         i = 0;
         while(i < 11)
         {
            actButtons[i] = new CampaignActButton(this,i + 1);
            actButtons[i].x = -2 + (actButtons[i].width + 25) * Math.floor(i / 13);
            actButtons[i].y = 60 + (actButtons[i].height + 3) * (i % 13);
            addChild(actButtons[i]);
            i = i + 1;
         }
         actDetailsSprite = new Sprite();
         actDetailsSprite.alpha = 0;
         addChild(actDetailsSprite);
         statusQuad3 = new Quad(GameConfig.GAME_WIDTH - 200,GameConfig.GAME_HEIGHT - 52,4278190080);
         statusQuad3.x = 180;
         statusQuad3.y = 52;
         statusQuad3.alpha = 0.75;
         actDetailsSprite.addChild(statusQuad3);
         difficultyLabel = new TextField(300,40,"Select Difficulty:",Fonts.getDefaultFont().fontName,20,6710886,true);
         difficultyLabel.x = 220;
         difficultyLabel.y = GameConfig.GAME_HEIGHT - 70;
         difficultyLabel.vAlign = "top";
         difficultyLabel.hAlign = "left";
         difficultyLabel.touchable = false;
         difficultyLabel.autoScale = true;
         actDetailsSprite.addChild(difficultyLabel);
         easyDiffButton = new GenericScreenButton(80,42,"Easy");
         easyDiffButton.x = 220;
         easyDiffButton.y = GameConfig.GAME_HEIGHT - 40;
         easyDiffButton.pressedCallback = function():void
         {
            setDifficulty(0);
         };
         actDetailsSprite.addChild(easyDiffButton);
         normalDiffButton = new GenericScreenButton(80,42,"Normal");
         normalDiffButton.x = 310;
         normalDiffButton.y = GameConfig.GAME_HEIGHT - 40;
         normalDiffButton.pressedCallback = function():void
         {
            setDifficulty(1);
         };
         actDetailsSprite.addChild(normalDiffButton);
         hardDiffButton = new GenericScreenButton(80,42,"Hard");
         hardDiffButton.x = 400;
         hardDiffButton.y = GameConfig.GAME_HEIGHT - 40;
         hardDiffButton.pressedCallback = function():void
         {
            setDifficulty(2);
         };
         actDetailsSprite.addChild(hardDiffButton);
         heroicDiffButton = new GenericScreenButton(80,42,"Heroic");
         heroicDiffButton.x = 490;
         heroicDiffButton.y = GameConfig.GAME_HEIGHT - 40;
         heroicDiffButton.pressedCallback = function():void
         {
            setDifficulty(3);
         };
         actDetailsSprite.addChild(heroicDiffButton);
         setDifficulty(1);
         startButton = new GenericScreenButton(140,72,"Start",36);
         startButton.x = GameConfig.GAME_WIDTH - 200;
         startButton.y = GameConfig.GAME_HEIGHT - 70;
         startButton.pressedCallback = startAct;
         actDetailsSprite.addChild(startButton);
         actNumber = new TextField(GameConfig.GAME_WIDTH - 200 - 20 - 60,40,"Act 1",Fonts.getDefaultFont().fontName,32,4293759265,true);
         actNumber.x = 220;
         actNumber.y = 65;
         actNumber.vAlign = "top";
         actNumber.hAlign = "left";
         actNumber.touchable = false;
         actNumber.autoScale = true;
         actDetailsSprite.addChild(actNumber);
         actTitle = new TextField(GameConfig.GAME_WIDTH - 200 - 20 - 60,40,"The Taltana Harbor Incident",Fonts.getDefaultFont().fontName,32,6710886,true);
         actTitle.x = 220;
         actTitle.y = 65;
         actTitle.vAlign = "top";
         actTitle.hAlign = "right";
         actTitle.touchable = false;
         actTitle.autoScale = true;
         actDetailsSprite.addChild(actTitle);
         statusQuad5 = new Quad(GameConfig.GAME_WIDTH - 200 - 20 - 60,1,4293759265);
         statusQuad5.x = 220;
         statusQuad5.y = 100;
         actDetailsSprite.addChild(statusQuad5);
         actDesc = new TextField(GameConfig.GAME_WIDTH - 200 - 20 - 60,400,"The spaceport Taltana Harbor is under attack from Hiveships by the evil Virpuris. Peacefree HQ quickly dispatches you and your team to rescue the city.",Fonts.getDefaultFont().fontName,22,16777215,true);
         actDesc.x = 220;
         actDesc.y = 110;
         actDesc.vAlign = "top";
         actDesc.hAlign = "left";
         actDesc.touchable = false;
         actDesc.autoScale = true;
         actDetailsSprite.addChild(actDesc);
         medalBust = new Image(Assets.getAtlas().getTexture("medal_bust"));
         medalBust.x = GameConfig.GAME_WIDTH - 300;
         medalBust.y = GameConfig.GAME_HEIGHT - 150;
         actDetailsSprite.addChild(medalBust);
         medal3 = new Image(Assets.getAtlas().getTexture("gold_medal"));
         medal3.x = GameConfig.GAME_WIDTH - 295;
         medal3.y = GameConfig.GAME_HEIGHT - 220 - 20;
         actDetailsSprite.addChild(medal3);
         medal2 = new Image(Assets.getAtlas().getTexture("gold_medal"));
         medal2.x = GameConfig.GAME_WIDTH - 195;
         medal2.y = GameConfig.GAME_HEIGHT - 220 - 20;
         actDetailsSprite.addChild(medal2);
         medal1 = new Image(Assets.getAtlas().getTexture("gold_medal"));
         medal1.x = GameConfig.GAME_WIDTH - 245;
         medal1.y = GameConfig.GAME_HEIGHT - 220 - 10;
         actDetailsSprite.addChild(medal1);
         achievementParticle = new PDParticleSystem(XML(new ParticleAssets.ParticleGoldXML()),Assets.getAtlas().getTexture("particle"));
         Starling.juggler.add(achievementParticle);
         achievementParticle.start();
         achievementParticle.x = medal1.x + medal1.width / 2;
         achievementParticle.y = medal1.y + medal1.height / 2 + 20;
         sfxButton = new Clickable(Assets.getAtlas().getTexture("button_fx"));
         sfxButton.x = 20;
         sfxButton.y = 5;
         sfxButton.bChangeAlpha = false;
         sfxButton.releaseCallback = function():void
         {
            toggleSFX();
         };
         addChild(sfxButton);
         bgmButton = new Clickable(Assets.getAtlas().getTexture("button_bgm"));
         bgmButton.x = sfxButton.x + sfxButton.width + 20;
         bgmButton.y = 5;
         bgmButton.bChangeAlpha = false;
         bgmButton.releaseCallback = function():void
         {
            toggleBGM();
         };
         addChild(bgmButton);
         settingsButton = new GenericScreenButton(95,40,"Settings");
         // PeacefreeRevival: Settings goes first, top left, and the two sound icons move to its right.
         settingsButton.x = sfxButton.x;
         settingsButton.y = -2;
         sfxButton.x = settingsButton.x + settingsButton.width + 20;
         bgmButton.x = sfxButton.x + sfxButton.width + 20;
         settingsButton.pressedCallback = function():void
         {
            showOptionsInterface();
         };
         addChild(settingsButton);
         toggleSFX(false);
         toggleBGM(false);
         highestAct = 1;
         i = 0;
         while(i < pgame.unlockedActs.length)
         {
            if(highestAct < pgame.unlockedActs[i])
            {
               highestAct = int(pgame.unlockedActs[i]);
            }
            i = i + 1;
         }
         if(!pgame.isPremiumPlayer() && highestAct == 11)
         {
            highestAct = 10;
         }
         setAct(highestAct);
         versionTextField = new TextField(200,50,"Ver.1.08",Fonts.getDefaultFont().fontName,16,3355443,true);
         versionTextField.x = 5;
         versionTextField.y = GameConfig.GAME_HEIGHT - versionTextField.height - 5;
         versionTextField.vAlign = "bottom";
         versionTextField.hAlign = "left";
         versionTextField.touchable = false;
         versionTextField.autoScale = true;
         addChild(versionTextField);
         easyDiffTooltip = new Tooltip(340,75,"Easy Difficulty","Enemies are weaker, cheaper Â build costs, and more starting ÈÂËÉ resources.");
         easyDiffTooltip.x = easyDiffButton.x;
         easyDiffTooltip.y = easyDiffButton.y - 10 - easyDiffTooltip.height;
         easyDiffButton.tooltip = easyDiffTooltip;
         addChild(easyDiffTooltip);
         hardDiffTooltip = new Tooltip(340,75,"Hard Difficulty","Enemies have 25% more Ø health, and tiles have 50% more Ä.");
         hardDiffTooltip.x = easyDiffButton.x;
         hardDiffTooltip.y = easyDiffButton.y - 10 - hardDiffTooltip.height;
         hardDiffButton.tooltip = hardDiffTooltip;
         addChild(hardDiffTooltip);
         heroicDiffTooltip = new Tooltip(340,75,"Heroic Difficulty","Enemies have 100% more Ø health, tiles have 100% more Ä that grow over time.");
         heroicDiffTooltip.x = easyDiffButton.x;
         heroicDiffTooltip.y = easyDiffButton.y - 10 - heroicDiffTooltip.height;
         heroicDiffButton.tooltip = heroicDiffTooltip;
         addChild(heroicDiffTooltip);
      }
      
      public function toggleBGM(param1:Boolean = true) : void
      {
         if(param1)
         {
            pgame.bEnabledBGM = !pgame.bEnabledBGM;
         }
         // PeacefreeRevival: mute pauses the song and unmute continues it (to-do 7); with none
         // paused, unmute starts the menu music as before.
         if(pgame.bEnabledBGM)
         {
            bgmButton.alpha = 1;
            SoundLibrary.resumeBGM();
            pgame.playBGM();
         }
         else
         {
            bgmButton.alpha = 0.35;
            SoundLibrary.pauseBGM();
         }
         pgame.saveGameData();
      }
      
      public function toggleSFX(param1:Boolean = true) : void
      {
         if(param1)
         {
            SoundLibrary.ENABLE_SFX = !SoundLibrary.ENABLE_SFX;
         }
         if(SoundLibrary.ENABLE_SFX)
         {
            sfxButton.alpha = 1;
         }
         else
         {
            sfxButton.alpha = 0.35;
         }
         pgame.saveGameData();
      }
      
      public function setDifficulty(param1:int) : void
      {
         this.difficulty = param1;
         if(lastDiffButtonSelected != null)
         {
            lastDiffButtonSelected.bgQuad.color = 136726;
         }
         switch(param1)
         {
            case 0:
               lastDiffButtonSelected = easyDiffButton;
               break;
            case 1:
               lastDiffButtonSelected = normalDiffButton;
               break;
            case 2:
               lastDiffButtonSelected = hardDiffButton;
               break;
            case 3:
               lastDiffButtonSelected = heroicDiffButton;
         }
         lastDiffButtonSelected.bgQuad.color = 408379;
      }
      
      public function setAct(param1:int) : void
      {
         var actDetailsTween:Tween;
         var actSelected:int = param1;
         if(bTransitioning)
         {
            return;
         }
         bTransitioning = true;
         this.actSelected = actSelected;
         if(lastActButtonSelected != null)
         {
            lastActButtonSelected.setIsSelected(false);
         }
         lastActButtonSelected = actButtons[actSelected - 1];
         lastActButtonSelected.setIsSelected(true);
         actDetailsTween = new Tween(actDetailsSprite,0.25);
         actDetailsTween.fadeTo(0);
         actDetailsTween.onComplete = function():void
         {
            var awards:int;
            var act:Act = Act.getAct(actSelected);
            actTitle.text = act.getActTitle();
            actDesc.text = act.getActDescription();
            awards = act.getTotalAchievements();
            medalBust.visible = false;
            medal1.visible = false;
            medal2.visible = false;
            medal3.visible = false;
            actDetailsSprite.removeChild(achievementParticle);
            switch(awards)
            {
               case 0:
                  break;
               case 2:
                  medal2.visible = true;
                  break;
               case 3:
                  medal3.visible = true;
                  break;
               case 1:
                  medal1.visible = true;
                  medalBust.visible = true;
                  actDetailsSprite.addChild(achievementParticle);
            }
            if(actSelected == 11)
            {
               actNumber.text = "Boss Run";
            }
            else
            {
               actNumber.text = "Act " + actSelected;
            }
            if(actSelected == 1)
            {
               difficultyLabel.visible = false;
               easyDiffButton.visible = false;
               normalDiffButton.visible = false;
               hardDiffButton.visible = false;
               heroicDiffButton.visible = false;
            }
            else
            {
               difficultyLabel.visible = true;
               easyDiffButton.visible = true;
               normalDiffButton.visible = true;
               hardDiffButton.visible = true;
               heroicDiffButton.visible = true;
            }
            actDetailsTween = new Tween(actDetailsSprite,0.25);
            actDetailsTween.fadeTo(1);
            actDetailsTween.onComplete = function():void
            {
               bTransitioning = false;
            };
            Starling.juggler.add(actDetailsTween);
         };
         Starling.juggler.add(actDetailsTween);
      }
      
      public function startAct(param1:TouchEvent) : void
      {
         var _loc2_:Map = null;
         if(pgame.viewState != 1)
         {
            return;
         }
         var _loc3_:Act = Act.getAct(actSelected);
         _loc2_ = new Map(pgame,_loc3_,true,difficulty);
         pgame.loadMap(_loc2_);
      }
      
      // PeacefreeRevival: the options panel without its mission-only rows; a sound change there
      // updates the icons and starts or stops the music, as the icons do.
      public function showOptionsInterface() : void
      {
         if(optionsInterfacer == null)
         {
            optionsInterfacer = new OptionsInterfacer(pgame,function():void
            {
               toggleBGM(false);
               toggleSFX(false);
            });
         }
         optionsInterfacer.showOn(this);
      }
      
      public function load() : void
      {
         pgame.fadeIn();
      }
      
      override public function dispose() : void
      {
         // PeacefreeRevival: the panel isn't a child once closed, so the loop below can miss it.
         if(optionsInterfacer != null)
         {
            optionsInterfacer.removeFromParent(true);
            optionsInterfacer = null;
         }
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(achievementParticle != null)
         {
            achievementParticle.stop();
            Starling.juggler.remove(achievementParticle);
         }
         actButtons.splice(0);
         campaignButton = null;
         sandboxButton = null;
         upgradesButton = null;
         loadFileButton = null;
         mainMenuButton = null;
         easyDiffButton = null;
         normalDiffButton = null;
         hardDiffButton = null;
         heroicDiffButton = null;
         startButton = null;
         actButtons = null;
         actNumber = null;
         actTitle = null;
         actDesc = null;
         pgame = null;
         bgImage1 = null;
         actDetailsSprite = null;
         lastActButtonSelected = null;
         lastDiffButtonSelected = null;
         sfxButton = null;
         bgmButton = null;
         settingsButton = null;
         versionTextField = null;
         difficultyLabel = null;
         shopButton = null;
         premiumButton = null;
         medalBust = null;
         medal3 = null;
         medal2 = null;
         medal1 = null;
         achievementParticle = null;
         super.dispose();
      }
   }
}

