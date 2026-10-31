package game.peacefree
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.setTimeout;
   import game.acts.DemoMap;
   import game.container.GameConfig;
   import game.interfaces.Clickable;
   import game.library.KongregateAPI;
   import game.library.SoundLibrary;
   import game.peacefree.interfaces.GenericScreenButton;
   import game.peacefree.interfaces.MessagePopup;
   import game.peacefree.interfaces.OptionsInterfacer;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class TitleScreen extends starling.display.Sprite
   {
      
      public static var FSBUTTON:Bitmap = null;
      
      // PeacefreeRevival: this project's release version, shown on the title (to-do 11).
      public static const REVIVAL_VERSION:String = "Revival 1.0";

      public static var TWITTERBUTTON:Bitmap = null;

      public static var FBBUTTON:Bitmap = null;
      
      public var pgame:PeacefreeGame;
      
      private var title_logo:Image;
      
      private var title_text:Image;
      
      private var subtitle_text:Image;
      
      private var title_bg:Image;
      
      private var blackQuadTop:Quad;
      
      private var blackQuadBot:Quad;
      
      private var playGameButton:GenericScreenButton;
      
      private var creditsButton:GenericScreenButton;
      
      public var sfxButton:Clickable;
      
      public var bgmButton:Clickable;
      
      // PeacefreeRevival: the Settings button and the options panel it opens, made on first use.
      private var settingsButton:GenericScreenButton;
      
      private var optionsInterfacer:OptionsInterfacer;
      
      public var creditsInterfacer:CreditsScreen;
      
      private var versionTextField:TextField;
      
      public var notLoggedInKongText:TextField;
      
      public var loginKongButton:GenericScreenButton;
      
      public function TitleScreen(param1:PeacefreeGame)
      {
         var demo:Act;
         var map:Map;
         var sprite:flash.display.Sprite;
         var fbSprite:flash.display.Sprite;
         var twitterSprite:flash.display.Sprite;
         var pgame:PeacefreeGame = param1;
         super();
         this.pgame = pgame;
         creditsInterfacer = new CreditsScreen(this);
         demo = new DemoMap();
         map = new Map(pgame,demo);
         map.bLoaded = true;
         map.goToTile(map.tiles[7 + 13 * map.mapWidth]);
         pgame.map = map;
         addChild(map);
         blackQuadTop = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT / 2,0);
         blackQuadTop.x = 0;
         blackQuadTop.y = 0;
         addChild(blackQuadTop);
         blackQuadBot = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT / 2,0);
         blackQuadBot.x = 0;
         blackQuadBot.y = GameConfig.GAME_HEIGHT / 2;
         addChild(blackQuadBot);
         title_bg = new Image(Assets.getAtlas().getTexture("title_bg"));
         title_bg.x = -title_bg.width;
         title_bg.y = 60;
         title_logo = new Image(Assets.getAtlas().getTexture("title_logo"));
         title_logo.x = GameConfig.GAME_WIDTH / 2 - title_logo.width / 2 - 180;
         title_logo.y = -title_logo.height;
         title_text = new Image(Assets.getAtlas().getTexture("title_text"));
         title_text.x = GameConfig.GAME_WIDTH;
         title_text.y = 80;
         subtitle_text = new Image(Assets.getAtlas().getTexture("galaxyofmiroda"));
         subtitle_text.x = GameConfig.GAME_WIDTH / 2 - subtitle_text.width / 2 + 47;
         subtitle_text.y = 195;
         subtitle_text.alpha = 0;
         addChild(title_bg);
         addChild(title_logo);
         addChild(title_text);
         addChild(subtitle_text);
         playGameButton = new GenericScreenButton(180,50,"Play",22);
         playGameButton.x = -playGameButton.width;
         playGameButton.y = GameConfig.GAME_HEIGHT - 100;
         playGameButton.pressedCallback = function():void
         {
            pgame.goToCampaignScreen();
         };
         addChild(playGameButton);
         creditsButton = new GenericScreenButton(180,50,"Credits",22);
         creditsButton.x = GameConfig.GAME_WIDTH + creditsButton.width;
         creditsButton.y = GameConfig.GAME_HEIGHT - 100;
         creditsButton.pressedCallback = function():void
         {
            showCreditsInterface();
         };
         addChild(creditsButton);
         if(GameConfig.KONG_VERSION && KongregateAPI.isGuest())
         {
            notLoggedInKongText = new TextField(220,20,"Sign in to save your high scores:",Fonts.getDefaultFont().fontName,16,6710886,true);
            notLoggedInKongText.x = GameConfig.GAME_WIDTH / 2 - notLoggedInKongText.width / 2 - 62;
            notLoggedInKongText.y = creditsButton.y + creditsButton.height + 10;
            notLoggedInKongText.vAlign = "center";
            notLoggedInKongText.hAlign = "right";
            notLoggedInKongText.touchable = false;
            notLoggedInKongText.autoScale = true;
            notLoggedInKongText.visible = false;
            addChild(notLoggedInKongText);
            loginKongButton = new GenericScreenButton(120,22,"Sign in or Register",16,0,0);
            loginKongButton.bgQuad.visible = false;
            loginKongButton.textField.color = 4293759265;
            loginKongButton.x = notLoggedInKongText.x + notLoggedInKongText.width + 5;
            loginKongButton.y = notLoggedInKongText.y;
            loginKongButton.pressedCallback = function():void
            {
               KongregateAPI.showSignUpLogin();
            };
            loginKongButton.visible = false;
            addChild(loginKongButton);
         }
         sfxButton = new Clickable(Assets.getAtlas().getTexture("button_fx"));
         sfxButton.x = 20;
         sfxButton.y = 5;
         sfxButton.bChangeAlpha = false;
         sfxButton.releaseCallback = function():void
         {
            toggleSFX();
         };
         sfxButton.visible = false;
         addChild(sfxButton);
         bgmButton = new Clickable(Assets.getAtlas().getTexture("button_bgm"));
         bgmButton.x = sfxButton.x + sfxButton.width + 20;
         bgmButton.y = 5;
         bgmButton.bChangeAlpha = false;
         bgmButton.releaseCallback = function():void
         {
            toggleBGM();
         };
         bgmButton.visible = false;
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
         settingsButton.visible = false;
         addChild(settingsButton);
         if(false && FSBUTTON == null)
         {
            sprite = new flash.display.Sprite();
            FSBUTTON = new Assets.fsbutton();
            FSBUTTON.x = 5;
            FSBUTTON.y = 5;
            sprite.addChild(FSBUTTON);
            sprite.addEventListener("click",function():void
            {
               pgame.toggleFullScreen();
            });
            GameConfig.STAGE.addChild(sprite);
         }
         // PeacefreeRevival: the Facebook and Twitter buttons (Flash pictures over the game, shown by
         // the Tech screen) go on Starling's native overlay instead of the stage: Starling moves
         // and scales the overlay with the game when it fits the window (to-do 8).
         if(FBBUTTON == null)
         {
            fbSprite = new flash.display.Sprite();
            FBBUTTON = new Assets.visit_fb();
            FBBUTTON.x = GameConfig.GAME_WIDTH / 2 - 185;
            FBBUTTON.y = GameConfig.GAME_HEIGHT / 2 - 30;
            FBBUTTON.visible = false;
            fbSprite.addChild(FBBUTTON);
            fbSprite.addEventListener("click",function():void
            {
               navigateToURL(new URLRequest("https://www.facebook.com/pages/Adventure-Cat/100915646702440"),"_blank");
               pgame.bLikedFB = true;
               pgame.saveGameData();
               FBBUTTON.alpha = 0.25;
               SoundLibrary.playSFX("aid");
            });
            Starling.current.nativeOverlay.addChild(fbSprite);
         }
         if(TWITTERBUTTON == null)
         {
            twitterSprite = new flash.display.Sprite();
            TWITTERBUTTON = new Assets.visit_twitter();
            TWITTERBUTTON.x = GameConfig.GAME_WIDTH / 2 + 45;
            TWITTERBUTTON.y = GameConfig.GAME_HEIGHT / 2 - 30;
            TWITTERBUTTON.visible = false;
            twitterSprite.addChild(TWITTERBUTTON);
            twitterSprite.addEventListener("click",function():void
            {
               navigateToURL(new URLRequest("http://twitter.com/_AdventureCat_"),"_blank");
               pgame.bTwittered = true;
               pgame.saveGameData();
               TWITTERBUTTON.alpha = 0.25;
               SoundLibrary.playSFX("aid");
            });
            Starling.current.nativeOverlay.addChild(twitterSprite);
         }
         toggleSFX(false);
         toggleBGM(false);
         // PeacefreeRevival: the release version next to the game's own, so bug reports name the
         // build, and that it's a fan patch (to-do 11). The game's Credits screen credits its makers.
         versionTextField = new TextField(400,50,"Ver.1.08 - " + REVIVAL_VERSION + ", unofficial fan patch",Fonts.getDefaultFont().fontName,16,3355443,true);
         versionTextField.x = 5;
         versionTextField.y = GameConfig.GAME_HEIGHT - versionTextField.height - 5;
         versionTextField.vAlign = "bottom";
         versionTextField.hAlign = "left";
         versionTextField.visible = false;
         versionTextField.touchable = false;
         versionTextField.autoScale = true;
         addChild(versionTextField);
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
         pgame.fadeIn(function():void
         {
            animate();
         });
      }
      
      public function animate() : void
      {
         var tween_titleLogo:Tween = new Tween(title_logo,0.25);
         tween_titleLogo.moveTo(GameConfig.GAME_WIDTH / 2 - title_logo.width / 2 - 180,10);
         Starling.juggler.add(tween_titleLogo);
         setTimeout(function():void
         {
            var _loc1_:Tween = new Tween(title_bg,0.35);
            _loc1_.moveTo(GameConfig.GAME_WIDTH / 2 - title_bg.width / 2,60);
            Starling.juggler.add(_loc1_);
         },250);
         setTimeout(function():void
         {
            var _loc1_:Tween = new Tween(title_text,0.35);
            _loc1_.moveTo(GameConfig.GAME_WIDTH / 2 - title_text.width / 2 + 50,80);
            Starling.juggler.add(_loc1_);
         },250);
         setTimeout(function():void
         {
            var _loc1_:Tween = new Tween(playGameButton,0.35);
            _loc1_.moveTo(GameConfig.GAME_WIDTH / 2 - playGameButton.width - 20,GameConfig.GAME_HEIGHT - 100);
            Starling.juggler.add(_loc1_);
         },450);
         setTimeout(function():void
         {
            var _loc1_:Tween = new Tween(creditsButton,0.35);
            _loc1_.moveTo(GameConfig.GAME_WIDTH / 2 + 20,GameConfig.GAME_HEIGHT - 100);
            Starling.juggler.add(_loc1_);
         },450);
         setTimeout(function():void
         {
            var tween_blackQuadBot:Tween;
            var tween_blackQuadTop:Tween = new Tween(blackQuadTop,0.35);
            tween_blackQuadTop.moveTo(0,-GameConfig.GAME_HEIGHT / 2 + 180);
            tween_blackQuadTop.fadeTo(0.8);
            Starling.juggler.add(tween_blackQuadTop);
            tween_blackQuadBot = new Tween(blackQuadBot,0.35);
            tween_blackQuadBot.moveTo(0,GameConfig.GAME_HEIGHT - 120);
            tween_blackQuadBot.fadeTo(0.8);
            tween_blackQuadBot.onComplete = function():void
            {
               var _loc1_:Tween = new Tween(subtitle_text,1);
               _loc1_.fadeTo(1);
               Starling.juggler.add(_loc1_);
               sfxButton.visible = true;
               bgmButton.visible = true;
               settingsButton.visible = true;
               versionTextField.visible = true;
               if(notLoggedInKongText != null)
               {
                  notLoggedInKongText.visible = true;
                  loginKongButton.visible = true;
               }
            };
            Starling.juggler.add(tween_blackQuadBot);
         },600);
      }
      
      public function showCreditsInterface() : void
      {
         var tween_credits:Tween;
         creditsInterfacer.alpha = 0;
         addChild(creditsInterfacer);
         tween_credits = new Tween(creditsInterfacer,0.5);
         tween_credits.fadeTo(1);
         tween_credits.onComplete = function():void
         {
            Starling.juggler.remove(tween_credits);
         };
         Starling.juggler.add(tween_credits);
      }
      
      public function hideCreditsInterface() : void
      {
         var tween_credits:Tween = new Tween(creditsInterfacer,0.5);
         tween_credits.fadeTo(0);
         tween_credits.onComplete = function():void
         {
            Starling.juggler.remove(tween_credits);
            removeChild(creditsInterfacer);
         };
         Starling.juggler.add(tween_credits);
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
         pgame = null;
         title_logo = null;
         title_text = null;
         title_bg = null;
         blackQuadTop = null;
         blackQuadBot = null;
         playGameButton = null;
         creditsButton = null;
         sfxButton = null;
         bgmButton = null;
         settingsButton = null;
         versionTextField = null;
         notLoggedInKongText = null;
         loginKongButton = null;
         super.dispose();
      }
      
      public function showPremiumFeaturesNotice() : void
      {
         var thankYouPopup:MessagePopup;
         var blackFilmQuad2:Quad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad2.alpha = 0.9;
         thankYouPopup = new MessagePopup(400,250,"Premium Features Unlocked!","\nThe developer team would like to thank you very much for your support!\n\nAll Premium Features are now unlocked!",function():void
         {
            blackFilmQuad2.visible = false;
            thankYouPopup.visible = false;
         });
         thankYouPopup.x = GameConfig.GAME_WIDTH / 2 - thankYouPopup.width / 2;
         thankYouPopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
         addChild(blackFilmQuad2);
         addChild(thankYouPopup);
      }
      
      public function refresh() : void
      {
         if(GameConfig.KONG_VERSION)
         {
            if(!KongregateAPI.isGuest())
            {
               if(notLoggedInKongText != null)
               {
                  notLoggedInKongText.removeFromParent(true);
                  notLoggedInKongText = null;
               }
               if(loginKongButton != null)
               {
                  loginKongButton.removeFromParent(true);
                  loginKongButton = null;
               }
            }
         }
      }
   }
}

