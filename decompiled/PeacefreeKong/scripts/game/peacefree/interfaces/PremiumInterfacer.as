package game.peacefree.interfaces
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.container.GameConfig;
   import game.interfaces.Clickable;
   import game.library.KongregateAPI;
   import game.peacefree.PeacefreeGame;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class PremiumInterfacer extends Sprite
   {
      
      public static const USE_NEW_TAB:Boolean = false;
      
      private var pgame:PeacefreeGame;
      
      private var gloebitsTextField:TextField;
      
      public var errorPopup:MessagePopup;
      
      public function PremiumInterfacer(param1:PeacefreeGame)
      {
         var blackFilmQuad:Quad;
         var closeButton:GenericScreenButton;
         var premiumTextField:TextField;
         var lineQuad:Quad;
         var helpTextField:TextField;
         var bombTextField:TextField;
         var zapImage:Image;
         var noxBombImage:Image;
         var shockBombImage:Image;
         var bombHintTextField:TextField;
         var towerTextField:TextField;
         var blasterSentryImage:Image;
         var noxxerSentryImage:Image;
         var zapSentryImage:Image;
         var extraMapsTextField:TextField;
         var extraMapsImage:Image;
         var bonusResources:TextField;
         var blackFilmQuad2:Quad;
         var confirmPopup:ConfirmPopup;
         var confirmPurchasePopup:ConfirmPopup;
         var notEnoughGloebitsPopup:ConfirmPopup;
         var continuePopup:MessagePopup;
         var buyButton:Clickable;
         var unlockTextField:TextField;
         var continueKongPopup:MessagePopup;
         var confirmKongPurchasePopup:ConfirmPopup;
         var buyKongButton:Clickable;
         var unlockKongTextField:TextField;
         var pgame:PeacefreeGame = param1;
         super();
         this.pgame = pgame;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         closeButton = new GenericScreenButton(45,40,"X",24,2003173376);
         closeButton.x = GameConfig.GAME_WIDTH / 2 + 325;
         closeButton.y = GameConfig.GAME_HEIGHT / 2 - 250;
         closeButton.pressedCallback = function():void
         {
            pgame.hidePremiumInterfacer();
         };
         addChild(closeButton);
         premiumTextField = new TextField(600,50,"Premium Features",Fonts.getDefaultFont().fontName,36,16765496,true);
         premiumTextField.x = GameConfig.GAME_WIDTH / 2 - 300;
         premiumTextField.y = GameConfig.GAME_HEIGHT / 2 - 210;
         premiumTextField.vAlign = "top";
         premiumTextField.hAlign = "center";
         premiumTextField.touchable = false;
         premiumTextField.autoScale = true;
         addChild(premiumTextField);
         lineQuad = new Quad(650,1,4293759265);
         lineQuad.x = GameConfig.GAME_WIDTH / 2 - 325;
         lineQuad.y = GameConfig.GAME_HEIGHT / 2 - 160;
         lineQuad.alpha = 0.75;
         addChild(lineQuad);
         helpTextField = new TextField(650,200,"It\'s not easy being indie! If you want to support the game developer,\nplease consider getting these awesome premium contents:",Fonts.getDefaultFont().fontName,20,16777215,true);
         helpTextField.x = GameConfig.GAME_WIDTH / 2 - 325;
         helpTextField.y = GameConfig.GAME_HEIGHT / 2 - 150;
         helpTextField.vAlign = "top";
         helpTextField.hAlign = "center";
         helpTextField.touchable = false;
         helpTextField.autoScale = true;
         addChild(helpTextField);
         bombTextField = new TextField(200,100,"Unlock Cross Zap & Special Bombs",Fonts.getDefaultFont().fontName,20,4293759265,true);
         bombTextField.x = GameConfig.GAME_WIDTH / 2 - 350;
         bombTextField.y = GameConfig.GAME_HEIGHT / 2 - 55;
         bombTextField.vAlign = "top";
         bombTextField.hAlign = "center";
         bombTextField.touchable = false;
         bombTextField.autoScale = true;
         addChild(bombTextField);
         zapImage = new Image(Assets.getAtlas().getTexture("effect_shock_05"));
         zapImage.x = GameConfig.GAME_WIDTH / 2 - 380;
         zapImage.y = GameConfig.GAME_HEIGHT / 2;
         zapImage.scaleX = 1.5;
         zapImage.scaleY = 1.5;
         addChild(zapImage);
         noxBombImage = new Image(Assets.getAtlas().getTexture("command_nox"));
         noxBombImage.x = GameConfig.GAME_WIDTH / 2 - 250;
         noxBombImage.y = GameConfig.GAME_HEIGHT / 2;
         noxBombImage.scaleX = 4;
         noxBombImage.scaleY = 4;
         addChild(noxBombImage);
         shockBombImage = new Image(Assets.getAtlas().getTexture("command_shock"));
         shockBombImage.x = GameConfig.GAME_WIDTH / 2 - 300;
         shockBombImage.y = GameConfig.GAME_HEIGHT / 2 + 20;
         shockBombImage.scaleX = 4;
         shockBombImage.scaleY = 4;
         addChild(shockBombImage);
         if(GameConfig.GLOEBIT_VERSION)
         {
            bombHintTextField = new TextField(50,50,"x 10",Fonts.getDefaultFont().fontName,30,16777215,true);
            bombHintTextField.x = noxBombImage.x + 65;
            bombHintTextField.y = noxBombImage.y + 60;
            bombHintTextField.vAlign = "bottom";
            bombHintTextField.hAlign = "right";
            bombHintTextField.touchable = false;
            bombHintTextField.autoScale = true;
            addChild(bombHintTextField);
         }
         towerTextField = new TextField(200,100,"Extra Watchtower Upgrades",Fonts.getDefaultFont().fontName,20,4293759265,true);
         towerTextField.x = GameConfig.GAME_WIDTH / 2 + 150;
         towerTextField.y = GameConfig.GAME_HEIGHT / 2 - 55;
         towerTextField.vAlign = "top";
         towerTextField.hAlign = "center";
         towerTextField.touchable = false;
         towerTextField.autoScale = true;
         addChild(towerTextField);
         blasterSentryImage = new Image(Assets.getAtlas().getTexture("building_205_01"));
         blasterSentryImage.x = GameConfig.GAME_WIDTH / 2 + 120;
         blasterSentryImage.y = GameConfig.GAME_HEIGHT / 2;
         addChild(blasterSentryImage);
         noxxerSentryImage = new Image(Assets.getAtlas().getTexture("building_207_01"));
         noxxerSentryImage.x = blasterSentryImage.x + 80;
         noxxerSentryImage.y = blasterSentryImage.y;
         addChild(noxxerSentryImage);
         zapSentryImage = new Image(Assets.getAtlas().getTexture("building_209_01"));
         zapSentryImage.x = noxxerSentryImage.x + 80;
         zapSentryImage.y = noxxerSentryImage.y;
         addChild(zapSentryImage);
         extraMapsTextField = new TextField(300,100,"Bonus Resources &\nEndless Boss Run Map",Fonts.getDefaultFont().fontName,20,4293759265,true);
         extraMapsTextField.x = GameConfig.GAME_WIDTH / 2 - 150;
         extraMapsTextField.y = GameConfig.GAME_HEIGHT / 2 - 55;
         extraMapsTextField.vAlign = "top";
         extraMapsTextField.hAlign = "center";
         extraMapsTextField.touchable = false;
         extraMapsTextField.autoScale = true;
         addChild(extraMapsTextField);
         extraMapsImage = new Image(Assets.getAtlas().getTexture("extramaps"));
         extraMapsImage.x = GameConfig.GAME_WIDTH / 2 - extraMapsImage.width / 2;
         extraMapsImage.y = GameConfig.GAME_HEIGHT / 2 + 10;
         addChild(extraMapsImage);
         bonusResources = new TextField(230,100,"+200È\n+200Â\n+4É +4Ú",Fonts.getDefaultFont().fontName,22,16777215,true);
         bonusResources.x = extraMapsImage.x + 20;
         bonusResources.y = extraMapsImage.y + 40;
         bonusResources.vAlign = "top";
         bonusResources.hAlign = "center";
         bonusResources.touchable = false;
         bonusResources.autoScale = true;
         addChild(bonusResources);
         blackFilmQuad2 = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad2.alpha = 0.9;
         blackFilmQuad2.visible = false;
         if(GameConfig.GLOEBIT_VERSION)
         {
            confirmPopup = new ConfirmPopup(400,220,"Login to Gloebit!","\nWe use Gloebit to handle purchases so we\ndon\'t forget things you\'ve bought.\n\nLogin or signup in Gloebit\'s website?",function():void
            {
               var _loc1_:URLRequest = new URLRequest("http://www.peacefree.adventurecat.us/gloebit.php?type=pass");
               navigateToURL(_loc1_,"_parent");
               confirmPopup.visible = false;
               continuePopup.visible = true;
            },function():void
            {
               blackFilmQuad2.visible = false;
               confirmPopup.visible = false;
            });
            confirmPopup.x = GameConfig.GAME_WIDTH / 2 - confirmPopup.width / 2;
            confirmPopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            confirmPopup.visible = false;
            confirmPurchasePopup = new ConfirmPopup(400,250,"Confirm Premium Purchase?","\nYou can access these features anytime with the same Gloebit account.\n\nAre you sure you want to unlock all\nPremium Features for 100 Gloebits?",function():void
            {
               confirmPopup.visible = false;
               confirmPurchasePopup.visible = false;
               pgame.buyPremiumViaGloebit();
            },function():void
            {
               blackFilmQuad2.visible = false;
               confirmPurchasePopup.visible = false;
            });
            confirmPurchasePopup.x = GameConfig.GAME_WIDTH / 2 - confirmPopup.width / 2;
            confirmPurchasePopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            confirmPurchasePopup.visible = false;
            errorPopup = new MessagePopup(400,250,"Error Encountered","\nUh-oh! Looks like we\'re having problems linking to your Gloebit account.\n\nWe\'re terribly sorry, but maybe can you please try again?",function():void
            {
               blackFilmQuad2.visible = false;
               errorPopup.visible = false;
            });
            errorPopup.x = GameConfig.GAME_WIDTH / 2 - confirmPopup.width / 2;
            errorPopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            errorPopup.visible = false;
            notEnoughGloebitsPopup = new ConfirmPopup(400,220,"Not Enough Gloebits","\nYou need 100 Gloebits to make\nthis purchase.\n\nWould you like to get more Gloebits?",function():void
            {
               var _loc1_:URLRequest = new URLRequest("http://www.peacefree.adventurecat.us/gloebit.php?type=gloebits");
               navigateToURL(_loc1_,"_parent");
               blackFilmQuad2.visible = false;
               notEnoughGloebitsPopup.visible = false;
            },function():void
            {
               blackFilmQuad2.visible = false;
               notEnoughGloebitsPopup.visible = false;
            });
            notEnoughGloebitsPopup.x = GameConfig.GAME_WIDTH / 2 - confirmPopup.width / 2;
            notEnoughGloebitsPopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            notEnoughGloebitsPopup.visible = false;
            continuePopup = new MessagePopup(400,220,"Login to Gloebit!","\nRedirecting you to Gloebit...",function():void
            {
               blackFilmQuad2.visible = false;
               continuePopup.visible = false;
               pgame.getGloebitBalance(function():void
               {
                  if(pgame.bLoggedInToGloebits)
                  {
                     if(pgame.isPremiumPlayer())
                     {
                        pgame.goToTitleScreen();
                     }
                     else
                     {
                        buyButton.pressedCallback();
                     }
                  }
                  else
                  {
                     errorPopup.visible = true;
                     blackFilmQuad2.visible = true;
                  }
               });
            });
            continuePopup.x = GameConfig.GAME_WIDTH / 2 - confirmPopup.width / 2;
            continuePopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            continuePopup.visible = false;
            buyButton = new Clickable(Assets.getAtlas().getTexture("buybutton2"));
            buyButton.x = GameConfig.GAME_WIDTH / 2 - buyButton.width / 2;
            buyButton.y = GameConfig.GAME_HEIGHT / 2 + 150;
            buyButton.pressedCallback = function():void
            {
               if(pgame.bLoggedInToGloebits)
               {
                  if(pgame.gloebits < 100)
                  {
                     blackFilmQuad2.visible = true;
                     notEnoughGloebitsPopup.visible = true;
                  }
                  else
                  {
                     blackFilmQuad2.visible = true;
                     confirmPurchasePopup.visible = true;
                  }
               }
               else
               {
                  blackFilmQuad2.visible = true;
                  confirmPopup.visible = true;
               }
            };
            addChild(buyButton);
            unlockTextField = new TextField(buyButton.width,buyButton.height,"Unlock with\n100 Gloebits",Fonts.getDefaultFont().fontName,22,16777215,true);
            unlockTextField.x = buyButton.x;
            unlockTextField.y = buyButton.y;
            unlockTextField.vAlign = "center";
            unlockTextField.hAlign = "center";
            unlockTextField.touchable = false;
            unlockTextField.autoScale = true;
            addChild(unlockTextField);
            gloebitsTextField = new TextField(200,100,"You have\n" + pgame.gloebits + " Gloebits",Fonts.getDefaultFont().fontName,22,10066329,true);
            gloebitsTextField.x = unlockTextField.x - 220;
            gloebitsTextField.y = unlockTextField.y + 20;
            gloebitsTextField.vAlign = "top";
            gloebitsTextField.hAlign = "center";
            gloebitsTextField.touchable = false;
            gloebitsTextField.autoScale = true;
            gloebitsTextField.visible = false;
            addChild(gloebitsTextField);
            addChild(blackFilmQuad2);
            addChild(confirmPopup);
            addChild(confirmPurchasePopup);
            addChild(continuePopup);
            addChild(errorPopup);
            addChild(notEnoughGloebitsPopup);
         }
         else if(GameConfig.KONG_VERSION)
         {
            continueKongPopup = new MessagePopup(400,220,"Sign In to Kongregate!","\nThis feature is only available to\nKongregate players who are signed in.\n\nPlease sign in or register your account.",function():void
            {
               blackFilmQuad2.visible = false;
               continueKongPopup.visible = false;
               KongregateAPI.showSignUpLogin();
            });
            continueKongPopup.x = GameConfig.GAME_WIDTH / 2 - continueKongPopup.width / 2;
            continueKongPopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            continueKongPopup.visible = false;
            continueKongPopup.okayButton.textField.text = "Sign In Now";
            confirmKongPurchasePopup = new ConfirmPopup(400,250,"Confirm Premium Purchase?","\nYou can access these features anytime with the same Kongregate account.\n\nAre you sure you want to unlock all\nPremium Features for 10 Kreds?",function():void
            {
               blackFilmQuad2.visible = false;
               confirmKongPurchasePopup.visible = false;
               pgame.buyPremiumViaKongregate();
            },function():void
            {
               blackFilmQuad2.visible = false;
               confirmKongPurchasePopup.visible = false;
            });
            confirmKongPurchasePopup.x = GameConfig.GAME_WIDTH / 2 - confirmKongPurchasePopup.width / 2;
            confirmKongPurchasePopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
            confirmKongPurchasePopup.visible = false;
            buyKongButton = new Clickable(Assets.getAtlas().getTexture("buybutton2"));
            buyKongButton.x = GameConfig.GAME_WIDTH / 2 - buyKongButton.width / 2;
            buyKongButton.y = GameConfig.GAME_HEIGHT / 2 + 150;
            buyKongButton.pressedCallback = function():void
            {
               if(KongregateAPI.isGuest())
               {
                  blackFilmQuad2.visible = true;
                  continueKongPopup.visible = true;
               }
               else if(!pgame.isPremiumPlayer())
               {
                  blackFilmQuad2.visible = true;
                  confirmKongPurchasePopup.visible = true;
               }
            };
            addChild(buyKongButton);
            unlockKongTextField = new TextField(buyKongButton.width,buyKongButton.height,"Unlock with\n10 Kreds",Fonts.getDefaultFont().fontName,22,16777215,true);
            unlockKongTextField.x = buyKongButton.x;
            unlockKongTextField.y = buyKongButton.y;
            unlockKongTextField.vAlign = "center";
            unlockKongTextField.hAlign = "center";
            unlockKongTextField.touchable = false;
            unlockKongTextField.autoScale = true;
            addChild(unlockKongTextField);
            addChild(blackFilmQuad2);
            addChild(continueKongPopup);
            addChild(confirmKongPurchasePopup);
         }
      }
      
      public function refresh() : void
      {
         if(GameConfig.GLOEBIT_VERSION)
         {
            if(pgame.bLoggedInToGloebits)
            {
               gloebitsTextField.text = "You have\n" + pgame.gloebits + " Gloebits";
               gloebitsTextField.visible = true;
            }
            else
            {
               gloebitsTextField.text = "You have\n0 Gloebits";
               gloebitsTextField.visible = true;
            }
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         pgame = null;
         gloebitsTextField = null;
         errorPopup = null;
         super.dispose();
      }
   }
}

