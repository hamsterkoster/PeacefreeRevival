package game.peacefree
{
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import game.container.GameConfig;
   import game.container.Tracer;
   import game.library.FileLibrary;
   import game.library.GloebitAPI;
   import game.library.KongregateAPI;
   import game.library.SoundLibrary;
   import game.peacefree.interfaces.PremiumInterfacer;
   import game.peacefree.interfaces.SaveFileInteracer;
   import game.peacefree.interfaces.ShopInterfacer;
   import game.peacefree.interfaces.SkillsInterfacer;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.KeyboardEvent;
   import starling.events.Touch;
   import starling.text.TextField;
   import starling.utils.deg2rad;
   
   public class PeacefreeGame extends Sprite
   {
      
      public static const CAMPAIGN_SELECT_SCREEN:int = 1;
      
      public static const MAP_SCREEN:int = 2;
      
      public static const TITLE_SCREEN:int = 3;
      
      private static var INSTANCE:PeacefreeGame = null;
      
      private var lastCheck:int;
      
      private var curTime:int;
      
      private var elapsed:int;
      
      private var touch:Touch;
      
      private var touchX:Number;
      
      private var touchY:Number;
      
      public var map:Map;
      
      private var titleScreen:TitleScreen;
      
      private var campaignSelectorScreen:CampaignSelectorScreen;
      
      private var loadingImage:Image;
      
      private var tween_loadingFilmImage:Tween;
      
      private var tween_saveFile:Tween;
      
      private var tween_skills:Tween;
      
      private var tween_shopInterfacer:Tween;
      
      private var tween_premiumInterfacer:Tween;
      
      private var loadingImageR:Image;
      
      private var tween_loadingFilmImageR:Tween;
      
      private var bTransitioning:Boolean = false;
      
      public var viewState:int = 3;
      
      private var currentView:Sprite = null;
      
      private var saveFileInterfacer:SaveFileInteracer;
      
      public var skillsInterfacer:SkillsInterfacer;
      
      private var shopInterfacer:ShopInterfacer;
      
      private var premiumInterfacer:PremiumInterfacer;
      
      private var newMap:Map;
      
      private var bShowingSaveFiles:Boolean = false;
      
      private var bShowingShop:Boolean = false;
      
      private var loadingImageRSprite:Sprite;
      
      public var bEnabledBGM:Boolean = true;
      
      public var unlockedActs:Array;
      
      private var onActivateListener:OnActivateListener;
      
      public var shockLeft:int = 0;
      
      public var noxLeft:int = 0;
      
      public var gloebits:int = -1;
      
      public var bLoggedInToGloebits:Boolean = false;
      
      public var callbackAfterGloebitBalanceUpdate:Function = null;
      
      private var bPremiumUser:Boolean = false;
      
      private var bShowPremiumNotice:Boolean = false;
      
      public var lastKongregateShockBombID:int = -1;
      
      public var lastKongregateNoxBombID:int = -1;
      
      public var longestGame:int = 1;
      
      public var mostKills:int = 0;
      
      public var mostRescues:int = 0;
      
      public var achievementManager:AchievementManager;
      
      private var premiumAchievement:Achievement;
      
      private var fbAchievement:Achievement;
      
      private var twitterAchievement:Achievement;
      
      public var bLikedFB:Boolean = false;
      
      public var bTwittered:Boolean = false;
      
      public function PeacefreeGame()
      {
         unlockedActs = [];
         super();
         INSTANCE = this;
         SoundAssets.init();
         loadingImage = new Image(Assets.getAtlas().getTexture("gate"));
         loadingImage.width = GameConfig.GAME_WIDTH * 0.6;
         loadingImage.height = GameConfig.GAME_HEIGHT;
         loadingImage.x = -loadingImage.width;
         loadingImage.y = 0;
         loadingImage.touchable = false;
         addChild(loadingImage);
         loadingImageR = new Image(Assets.getAtlas().getTexture("gate"));
         loadingImageR.width = GameConfig.GAME_WIDTH * 0.6;
         loadingImageR.height = GameConfig.GAME_HEIGHT;
         loadingImageR.touchable = false;
         loadingImageRSprite = new Sprite();
         loadingImageRSprite.x = GameConfig.GAME_WIDTH;
         loadingImageRSprite.pivotX = loadingImageR.width;
         loadingImageRSprite.pivotY = loadingImageR.height;
         loadingImageRSprite.rotation = deg2rad(180);
         loadingImageRSprite.addChild(loadingImageR);
         achievementManager = new AchievementManager(this);
         addEventListener("addedToStage",onAddedToStage);
         try
         {
            premiumAchievement = new Achievement(this,1,"Unlocked Premium Features","Bonus for unlocking premium features.",function():Boolean
            {
               return isPremiumPlayer();
            },5);
            fbAchievement = new Achievement(this,2,"Unlocked Facebook Achievement","Liked our Facebook Page.",function():Boolean
            {
               return bLikedFB;
            },1);
            twitterAchievement = new Achievement(this,3,"Unlocked Twitter Achievement","Follow us on Twitter.",function():Boolean
            {
               return bTwittered;
            },1);
         }
         catch(error:Error)
         {
         }
      }
      
      public static function getInstance() : PeacefreeGame
      {
         return INSTANCE;
      }
      
      public function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         addEventListener("enterFrame",onEnterFrame);
         addEventListener("keyDown",onKeyDown);
         addEventListener("keyUp",onKeyUp);
         var _loc2_:TextField = Tracer.getTrace();
         loadGameData();
         saveFileInterfacer = new SaveFileInteracer(this);
         skillsInterfacer = new SkillsInterfacer(this);
         shopInterfacer = new ShopInterfacer(this);
         premiumInterfacer = new PremiumInterfacer(this);
         try
         {
            campaignSelectorScreen = new CampaignSelectorScreen(this);
         }
         catch(error:Error)
         {
         }
         titleScreen = new TitleScreen(this);
         titleScreen.load();
         currentView = titleScreen;
         addChild(titleScreen);
         playBGM();
         onActivateListener = new OnActivateListener(onActivate,onDeactivate);
         if(GameConfig.GLOEBIT_VERSION)
         {
            getGloebitBalance();
         }
         else if(GameConfig.KONG_VERSION)
         {
            KongregateAPI.onLoadComplete = onKongregateLogin;
            KongregateAPI.onLogin = onKongregateLogin;
            KongregateAPI.init(getKongregateItems);
         }
         if(GameConfig.STAGE.loaderInfo.parameters["show_premium"] == "true")
         {
            goToCampaignScreen();
         }
      }
      
      public function getGloebitBalance(param1:Function = null) : void
      {
         this.callbackAfterGloebitBalanceUpdate = param1;
         GloebitAPI.getBalance(updateGloebitBalance,updateGloebitBalance);
      }
      
      public function updateGloebitBalance(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         try
         {
            _loc2_ = JSON.parse(param1);
            _loc3_ = 0;
            if(_loc2_.success == true)
            {
               gloebits = _loc2_.balance;
               bLoggedInToGloebits = true;
               getGloebitItems();
            }
            if(premiumInterfacer != null)
            {
               premiumInterfacer.refresh();
            }
            if(shopInterfacer != null)
            {
               shopInterfacer.refresh();
            }
         }
         catch(error:Error)
         {
            Tracer.trace("Failed to connect to Gloebit endpoint during balance check.");
         }
      }
      
      public function getGloebitItems() : void
      {
         GloebitAPI.getItems(updateGloebitItems,updateGloebitItems);
      }
      
      public function updateGloebitItems(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc4_:int = 0;
         var _loc3_:Object = null;
         try
         {
            _loc2_ = JSON.parse(param1);
            _loc4_ = 0;
            if(_loc2_.success == true)
            {
               _loc3_ = _loc2_.products;
               if(_loc3_.premium_features >= 1)
               {
                  bPremiumUser = true;
               }
               if(_loc3_.shock_bomb != undefined)
               {
                  shockLeft = parseInt(_loc3_.shock_bomb);
               }
               if(_loc3_.nox_bomb != undefined)
               {
                  noxLeft = parseInt(_loc3_.nox_bomb);
               }
               if(shopInterfacer != null)
               {
                  shopInterfacer.refresh();
               }
            }
            if(callbackAfterGloebitBalanceUpdate != null)
            {
               callbackAfterGloebitBalanceUpdate();
               callbackAfterGloebitBalanceUpdate = null;
            }
         }
         catch(error:Error)
         {
            Tracer.trace("Failed to connect to Gloebit endpoint during item check.");
         }
      }
      
      public function buyPremiumViaGloebit() : void
      {
         if(bPremiumUser)
         {
            return;
         }
         GloebitAPI.buyPremium(updatePremium,updatePremium);
      }
      
      public function updatePremium(param1:String) : void
      {
         var _loc2_:Object = null;
         try
         {
            _loc2_ = JSON.parse(param1);
            if(_loc2_.success == true)
            {
               bPremiumUser = true;
               bShowPremiumNotice = true;
               goToTitleScreen();
            }
            else
            {
               premiumInterfacer.errorPopup.visible = true;
            }
         }
         catch(error:Error)
         {
            Tracer.trace("Failed to connect to Gloebit endpoint during item check.");
         }
      }
      
      public function buyNoxBombsViaGloebit() : void
      {
         if(!bPremiumUser)
         {
            return;
         }
         GloebitAPI.buyNox(function(param1:String):void
         {
            shopInterfacer.processingTextField.visible = false;
            shopInterfacer.blackFilmQuad2.visible = false;
            getGloebitBalance();
         },function(param1:String):void
         {
            shopInterfacer.processingTextField.visible = false;
            shopInterfacer.blackFilmQuad2.visible = false;
            getGloebitBalance();
         });
      }
      
      public function buyShockBombsViaGloebit() : void
      {
         if(!bPremiumUser)
         {
            return;
         }
         GloebitAPI.buyShock(function(param1:String):void
         {
            shopInterfacer.processingTextField.visible = false;
            shopInterfacer.blackFilmQuad2.visible = false;
            getGloebitBalance();
         },function(param1:String):void
         {
            shopInterfacer.processingTextField.visible = false;
            shopInterfacer.blackFilmQuad2.visible = false;
            getGloebitBalance();
         });
      }
      
      public function getKongregateItems() : void
      {
         KongregateAPI.getItems(updateKongregateItems);
      }
      
      public function updateKongregateItems(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         try
         {
            if(param1.success == true)
            {
               shockLeft = 0;
               noxLeft = 0;
               lastKongregateShockBombID = -1;
               lastKongregateNoxBombID = -1;
               _loc2_ = param1.data;
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  if(_loc2_[_loc3_].identifier == "premium")
                  {
                     bPremiumUser = true;
                  }
                  else if(_loc2_[_loc3_].identifier == "shock_bomb")
                  {
                     shockLeft += _loc2_[_loc3_].remaining_uses;
                     lastKongregateShockBombID = _loc2_[_loc3_].id;
                  }
                  else if(_loc2_[_loc3_].identifier == "nox_bomb")
                  {
                     noxLeft += _loc2_[_loc3_].remaining_uses;
                     lastKongregateNoxBombID = _loc2_[_loc3_].id;
                  }
                  _loc3_++;
               }
               if(shopInterfacer != null)
               {
                  shopInterfacer.refresh();
               }
            }
         }
         catch(error:Error)
         {
            Tracer.trace("Failed to connect to Gloebit endpoint during item check.");
         }
      }
      
      public function buyPremiumViaKongregate() : void
      {
         if(bPremiumUser)
         {
            return;
         }
         KongregateAPI.purchase(["premium"],updatePremiumViaKongregate);
      }
      
      public function updatePremiumViaKongregate(param1:Boolean) : void
      {
         try
         {
            if(param1)
            {
               bPremiumUser = true;
               bShowPremiumNotice = true;
               goToTitleScreen();
            }
            else
            {
               premiumInterfacer.errorPopup.visible = true;
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function buyNoxBombsViaKongregate() : void
      {
         if(!bPremiumUser)
         {
            return;
         }
         KongregateAPI.purchase(["nox_bomb"],function(param1:Boolean):void
         {
            getKongregateItems();
            shopInterfacer.processingTextField.visible = false;
            shopInterfacer.blackFilmQuad2.visible = false;
         });
      }
      
      public function buyShockBombsViaKongregate() : void
      {
         if(!bPremiumUser)
         {
            return;
         }
         KongregateAPI.purchase(["shock_bomb"],function(param1:Boolean):void
         {
            getKongregateItems();
            shopInterfacer.processingTextField.visible = false;
            shopInterfacer.blackFilmQuad2.visible = false;
         });
      }
      
      public function onActivate() : void
      {
      }
      
      public function onDeactivate() : void
      {
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(viewState == 2 && map != null && !bShowingSaveFiles)
         {
            map.onKeyDown(param1);
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(viewState == 2 && map != null && !bShowingSaveFiles)
         {
            map.onKeyUp(param1);
         }
         var _loc2_:String = String.fromCharCode(param1.charCode);
         if(27 === _loc2_)
         {
            if(GameConfig.STAGE.displayState == "fullScreenInteractive")
            {
               toggleFullScreen();
            }
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         lastCheck = curTime;
         curTime = getTimer();
         elapsed = curTime - lastCheck;
         if(map != null && !bShowingSaveFiles)
         {
            map.progress(elapsed);
         }
      }
      
      public function fadeIn(param1:Function = null) : void
      {
         var callback:Function = param1;
         Mouse.cursor = "arrow";
         if(tween_loadingFilmImage != null)
         {
            Starling.juggler.remove(tween_loadingFilmImage);
         }
         tween_loadingFilmImage = new Tween(loadingImage,1);
         tween_loadingFilmImage.moveTo(-loadingImage.width,0);
         tween_loadingFilmImage.onComplete = function():void
         {
            Starling.juggler.remove(tween_loadingFilmImage);
            bTransitioning = false;
            if(callback != null)
            {
               callback();
            }
         };
         Starling.juggler.add(tween_loadingFilmImage);
         tween_loadingFilmImageR = new Tween(loadingImageRSprite,1);
         tween_loadingFilmImageR.moveTo(GameConfig.GAME_WIDTH,0);
         tween_loadingFilmImageR.onComplete = function():void
         {
            Starling.juggler.remove(tween_loadingFilmImageR);
         };
         Starling.juggler.add(tween_loadingFilmImageR);
      }
      
      private function fadeOut() : void
      {
         addChild(loadingImage);
         addChild(loadingImageRSprite);
         if(tween_loadingFilmImage != null)
         {
            Starling.juggler.remove(tween_loadingFilmImage);
         }
         if(tween_loadingFilmImageR != null)
         {
            Starling.juggler.remove(tween_loadingFilmImageR);
         }
         tween_loadingFilmImage = new Tween(loadingImage,0.5);
         tween_loadingFilmImage.moveTo(0,0);
         tween_loadingFilmImage.onComplete = function():void
         {
            Starling.juggler.remove(tween_loadingFilmImage);
            setTimeout(function():void
            {
               transitionView();
            },500);
         };
         Starling.juggler.add(tween_loadingFilmImage);
         tween_loadingFilmImageR = new Tween(loadingImageRSprite,0.5);
         tween_loadingFilmImageR.moveTo(GameConfig.GAME_WIDTH - loadingImageR.width,0);
         tween_loadingFilmImageR.onComplete = function():void
         {
            Starling.juggler.remove(tween_loadingFilmImageR);
         };
         Starling.juggler.add(tween_loadingFilmImageR);
         SoundLibrary.playSFX("airlock");
      }
      
      public function loadMap(param1:Map) : void
      {
         if(bTransitioning)
         {
            return;
         }
         bTransitioning = true;
         newMap = param1;
         viewState = 2;
         fadeOut();
      }
      
      public function goToCampaignScreen() : void
      {
         if(bTransitioning)
         {
            return;
         }
         bTransitioning = true;
         viewState = 1;
         fadeOut();
         if(!premiumAchievement.isUnlocked() && premiumAchievement.check())
         {
            premiumAchievement.unlock();
         }
      }
      
      public function goToTitleScreen() : void
      {
         if(bTransitioning)
         {
            return;
         }
         bTransitioning = true;
         viewState = 3;
         fadeOut();
      }
      
      private function transitionView() : void
      {
         if(currentView != null)
         {
            removeChild(currentView);
            currentView.dispose();
         }
         if(map != null)
         {
            if(!(currentView is TitleScreen))
            {
               map.stopBGM();
               playBGM();
            }
            map.removeFromParent(true);
            map = null;
         }
         hidePremiumInterfacer();
         hideSaveFileInterfacer();
         hideShopInterfacer();
         switch(viewState - 1)
         {
            case 0:
               saveGameData();
               campaignSelectorScreen = new CampaignSelectorScreen(this);
               currentView = campaignSelectorScreen;
               addChild(campaignSelectorScreen);
               campaignSelectorScreen.load();
               if(GameConfig.STAGE.loaderInfo.parameters["show_premium"] == "true")
               {
                  showPremiumInterface();
               }
               break;
            case 1:
               stopBGM();
               map = newMap;
               currentView = map;
               addChildAt(map,0);
               map.load();
               break;
            case 2:
               titleScreen = new TitleScreen(this);
               currentView = titleScreen;
               addChild(titleScreen);
               titleScreen.load();
               if(bShowPremiumNotice)
               {
                  titleScreen.showPremiumFeaturesNotice();
                  bShowPremiumNotice = false;
               }
         }
         addChild(loadingImage);
         addChild(loadingImageRSprite);
      }
      
      public function playBGM() : void
      {
         if(bEnabledBGM && !SoundLibrary.isBGMPlaying())
         {
            SoundLibrary.playBGM("main_menu",playBGM);
         }
      }
      
      public function stopBGM() : void
      {
         SoundLibrary.stopBGM();
      }
      
      public function showSaveFileInterface() : void
      {
         bShowingSaveFiles = true;
         saveFileInterfacer.alpha = 0;
         saveFileInterfacer.refresh();
         addChild(saveFileInterfacer);
         if(tween_saveFile != null)
         {
            Starling.juggler.remove(tween_saveFile);
         }
         tween_saveFile = new Tween(saveFileInterfacer,0.5);
         tween_saveFile.fadeTo(1);
         tween_saveFile.onComplete = function():void
         {
            Starling.juggler.remove(tween_saveFile);
            tween_saveFile = null;
         };
         Starling.juggler.add(tween_saveFile);
      }
      
      public function hideSaveFileInterfacer() : void
      {
         if(tween_saveFile != null)
         {
            Starling.juggler.remove(tween_saveFile);
         }
         tween_saveFile = new Tween(saveFileInterfacer,0.5);
         tween_saveFile.fadeTo(0);
         tween_saveFile.onComplete = function():void
         {
            Starling.juggler.remove(tween_saveFile);
            removeChild(saveFileInterfacer);
            bShowingSaveFiles = false;
            tween_saveFile = null;
         };
         Starling.juggler.add(tween_saveFile);
      }
      
      public function checkShareAchievements() : void
      {
         if(!fbAchievement.isUnlocked() && fbAchievement.check())
         {
            fbAchievement.unlock();
         }
         if(!twitterAchievement.isUnlocked() && twitterAchievement.check())
         {
            twitterAchievement.unlock();
         }
      }
      
      public function showSkillsInterface() : void
      {
         skillsInterfacer.alpha = 0;
         skillsInterfacer.refresh();
         addChild(skillsInterfacer);
         if(tween_skills != null)
         {
            Starling.juggler.remove(tween_skills);
         }
         tween_skills = new Tween(skillsInterfacer,0.5);
         tween_skills.fadeTo(1);
         tween_skills.onComplete = function():void
         {
            Starling.juggler.remove(tween_skills);
            tween_skills = null;
         };
         Starling.juggler.add(tween_skills);
      }
      
      public function hideSkillsInterfacer() : void
      {
         if(tween_skills != null)
         {
            Starling.juggler.remove(tween_skills);
         }
         tween_skills = new Tween(skillsInterfacer,0.5);
         tween_skills.fadeTo(0);
         tween_skills.onComplete = function():void
         {
            Starling.juggler.remove(tween_skills);
            removeChild(skillsInterfacer);
            tween_skills = null;
         };
         Starling.juggler.add(tween_skills);
      }
      
      public function showShopInterface() : void
      {
         bShowingShop = true;
         shopInterfacer.alpha = 0;
         shopInterfacer.refresh();
         addChild(shopInterfacer);
         if(tween_shopInterfacer != null)
         {
            Starling.juggler.remove(tween_shopInterfacer);
         }
         tween_shopInterfacer = new Tween(shopInterfacer,0.5);
         tween_shopInterfacer.fadeTo(1);
         tween_shopInterfacer.onComplete = function():void
         {
            Starling.juggler.remove(tween_shopInterfacer);
            tween_shopInterfacer = null;
         };
         Starling.juggler.add(tween_shopInterfacer);
      }
      
      public function hideShopInterfacer() : void
      {
         if(GameConfig.GLOEBIT_VERSION)
         {
            getGloebitBalance();
         }
         else if(GameConfig.KONG_VERSION)
         {
            getKongregateItems();
         }
         if(tween_shopInterfacer != null)
         {
            Starling.juggler.remove(tween_shopInterfacer);
         }
         tween_shopInterfacer = new Tween(shopInterfacer,0.5);
         tween_shopInterfacer.fadeTo(0);
         tween_shopInterfacer.onComplete = function():void
         {
            Starling.juggler.remove(tween_shopInterfacer);
            removeChild(shopInterfacer);
            bShowingShop = false;
            tween_shopInterfacer = null;
         };
         Starling.juggler.add(tween_shopInterfacer);
      }
      
      public function showPremiumInterface() : void
      {
         premiumInterfacer.alpha = 0;
         premiumInterfacer.refresh();
         addChild(premiumInterfacer);
         if(tween_premiumInterfacer != null)
         {
            Starling.juggler.remove(tween_premiumInterfacer);
         }
         tween_premiumInterfacer = new Tween(premiumInterfacer,0.5);
         tween_premiumInterfacer.fadeTo(1);
         tween_premiumInterfacer.onComplete = function():void
         {
            Starling.juggler.remove(tween_premiumInterfacer);
            tween_premiumInterfacer = null;
         };
         Starling.juggler.add(tween_premiumInterfacer);
      }
      
      public function hidePremiumInterfacer() : void
      {
         if(GameConfig.GLOEBIT_VERSION)
         {
            getGloebitBalance();
         }
         else if(GameConfig.KONG_VERSION)
         {
            getKongregateItems();
         }
         if(tween_premiumInterfacer != null)
         {
            Starling.juggler.remove(tween_premiumInterfacer);
         }
         tween_premiumInterfacer = new Tween(premiumInterfacer,0.5);
         tween_premiumInterfacer.fadeTo(0);
         tween_premiumInterfacer.onComplete = function():void
         {
            Starling.juggler.remove(tween_premiumInterfacer);
            removeChild(premiumInterfacer);
            bShowingShop = false;
            tween_premiumInterfacer = null;
         };
         Starling.juggler.add(tween_premiumInterfacer);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(tween_loadingFilmImage != null)
         {
            Starling.juggler.remove(tween_loadingFilmImage);
         }
         if(tween_saveFile != null)
         {
            Starling.juggler.remove(tween_saveFile);
         }
         if(tween_loadingFilmImageR != null)
         {
            Starling.juggler.remove(tween_loadingFilmImageR);
         }
         if(unlockedActs != null)
         {
            unlockedActs.splice(0);
         }
         map = null;
         titleScreen = null;
         campaignSelectorScreen = null;
         loadingImage = null;
         tween_loadingFilmImage = null;
         tween_saveFile = null;
         tween_shopInterfacer = null;
         tween_premiumInterfacer = null;
         loadingImageR = null;
         tween_loadingFilmImageR = null;
         currentView = null;
         saveFileInterfacer = null;
         shopInterfacer = null;
         premiumInterfacer = null;
         newMap = null;
         loadingImageRSprite = null;
         unlockedActs = null;
         onActivateListener = null;
         callbackAfterGloebitBalanceUpdate = null;
         super.dispose();
      }
      
      public function saveGameData() : void
      {
         var _loc1_:Object = {};
         _loc1_.data = {};
         _loc1_.data.unlockedActs = unlockedActs;
         _loc1_.data.bEnableFX = SoundLibrary.ENABLE_SFX;
         _loc1_.data.bEnabledBGM = bEnabledBGM;
         _loc1_.data.longestGame = longestGame;
         _loc1_.data.mostKills = mostKills;
         _loc1_.data.mostRescues = mostRescues;
         try
         {
            _loc1_.data.achievementData = achievementManager.getData();
            _loc1_.data.bLikedFB = bLikedFB;
            _loc1_.data.bTwittered = bTwittered;
         }
         catch(error:Error)
         {
         }
         FileLibrary.saveData("game",_loc1_);
      }
      
      public function loadGameData() : void
      {
         var _loc1_:Object = null;
         try
         {
            _loc1_ = FileLibrary.getData("game");
            if(_loc1_ == null || _loc1_.data == undefined || _loc1_.data == null)
            {
               return;
            }
            unlockedActs = _loc1_.data.unlockedActs;
            SoundLibrary.ENABLE_SFX = _loc1_.data.bEnableFX;
            bEnabledBGM = _loc1_.data.bEnabledBGM;
            longestGame = _loc1_.data.longestGame;
            mostKills = _loc1_.data.mostKills;
            mostRescues = _loc1_.data.mostRescues;
            if(_loc1_.data.achievementData != null)
            {
               achievementManager.setData(_loc1_.data.achievementData);
            }
            if(_loc1_.data.bLikedFB != null)
            {
               bLikedFB = _loc1_.data.bLikedFB;
            }
            if(_loc1_.data.bTwittered != null)
            {
               bTwittered = _loc1_.data.bTwittered;
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function updateLongestGame(param1:int) : void
      {
         if(param1 > longestGame)
         {
            longestGame = param1;
            saveGameData();
            if(GameConfig.KONG_VERSION)
            {
               try
               {
                  if(param1 > 1)
                  {
                     KongregateAPI.addStats("LongestGame",param1);
                  }
               }
               catch(error:Error)
               {
               }
            }
         }
      }
      
      public function updateMostKills(param1:int) : void
      {
         if(param1 > mostKills)
         {
            mostKills = param1;
            saveGameData();
            if(GameConfig.KONG_VERSION)
            {
               try
               {
                  if(mostKills > 0)
                  {
                     KongregateAPI.addStats("Kills",mostKills);
                  }
               }
               catch(error:Error)
               {
               }
            }
         }
      }
      
      public function updateMostRescues(param1:int) : void
      {
         if(param1 > mostRescues)
         {
            mostRescues = param1;
            saveGameData();
            if(GameConfig.KONG_VERSION)
            {
               try
               {
                  if(mostRescues > 0)
                  {
                     KongregateAPI.addStats("CiviliansRescued",mostRescues);
                  }
               }
               catch(error:Error)
               {
               }
            }
         }
      }
      
      public function toggleFullScreen() : void
      {
         if(GameConfig.STAGE.displayState == "normal")
         {
            GameConfig.STAGE.displayState = "fullScreenInteractive";
            StarlingPreloader.INSTANCE.resizeStage(null);
         }
         else
         {
            GameConfig.STAGE.displayState = "normal";
            StarlingPreloader.INSTANCE.resizeBack();
         }
         if(TitleScreen.FSBUTTON != null)
         {
            if(GameConfig.STAGE.displayState == "normal")
            {
               TitleScreen.FSBUTTON.scaleX = 1;
               TitleScreen.FSBUTTON.scaleY = 1;
               TitleScreen.FSBUTTON.x = 5;
               TitleScreen.FSBUTTON.y = 5;
            }
            else
            {
               TitleScreen.FSBUTTON.scaleX = GameConfig.STAGE.fullScreenWidth / GameConfig.GAME_WIDTH;
               TitleScreen.FSBUTTON.scaleY = GameConfig.STAGE.fullScreenHeight / GameConfig.GAME_HEIGHT;
               TitleScreen.FSBUTTON.x = 5 * TitleScreen.FSBUTTON.scaleX;
               TitleScreen.FSBUTTON.y = 5 * TitleScreen.FSBUTTON.scaleY;
            }
         }
         if(TitleScreen.FBBUTTON != null)
         {
            if(GameConfig.STAGE.displayState == "normal")
            {
               TitleScreen.FBBUTTON.scaleX = 1;
               TitleScreen.FBBUTTON.scaleY = 1;
               TitleScreen.FBBUTTON.x = GameConfig.GAME_WIDTH / 2 - 185;
               TitleScreen.FBBUTTON.y = GameConfig.GAME_HEIGHT / 2 - 30;
            }
            else
            {
               TitleScreen.FBBUTTON.scaleX = GameConfig.STAGE.fullScreenWidth / GameConfig.GAME_WIDTH;
               TitleScreen.FBBUTTON.scaleY = GameConfig.STAGE.fullScreenHeight / GameConfig.GAME_HEIGHT;
               TitleScreen.FBBUTTON.x = (GameConfig.GAME_WIDTH / 2 - 175) * TitleScreen.FBBUTTON.scaleX;
               TitleScreen.FBBUTTON.y = (GameConfig.GAME_HEIGHT / 2 - 30) * TitleScreen.FBBUTTON.scaleY;
            }
         }
         if(TitleScreen.TWITTERBUTTON != null)
         {
            if(GameConfig.STAGE.displayState == "normal")
            {
               TitleScreen.TWITTERBUTTON.scaleX = 1;
               TitleScreen.TWITTERBUTTON.scaleY = 1;
               TitleScreen.TWITTERBUTTON.x = GameConfig.GAME_WIDTH / 2 + 45;
               TitleScreen.TWITTERBUTTON.y = GameConfig.GAME_HEIGHT / 2 - 30;
            }
            else
            {
               TitleScreen.TWITTERBUTTON.scaleX = GameConfig.STAGE.fullScreenWidth / GameConfig.GAME_WIDTH;
               TitleScreen.TWITTERBUTTON.scaleY = GameConfig.STAGE.fullScreenHeight / GameConfig.GAME_HEIGHT;
               TitleScreen.TWITTERBUTTON.x = (GameConfig.GAME_WIDTH / 2 + 45) * TitleScreen.TWITTERBUTTON.scaleX;
               TitleScreen.TWITTERBUTTON.y = (GameConfig.GAME_HEIGHT / 2 - 30) * TitleScreen.TWITTERBUTTON.scaleY;
            }
         }
      }
      
      public function isPremiumPlayer() : Boolean
      {
         return bPremiumUser;
      }
      
      public function onKongregateLogin() : void
      {
         try
         {
            if(titleScreen != null)
            {
               titleScreen.refresh();
            }
            if(viewState != 3)
            {
               goToTitleScreen();
            }
            if(!KongregateAPI.isGuest())
            {
               try
               {
                  if(longestGame > 1)
                  {
                     KongregateAPI.addStats("LongestGame",longestGame);
                  }
                  if(mostKills > 0)
                  {
                     KongregateAPI.addStats("Kills",mostKills);
                  }
                  if(mostRescues > 0)
                  {
                     KongregateAPI.addStats("CiviliansRescued",mostRescues);
                  }
               }
               catch(error:Error)
               {
               }
            }
            KongregateAPI.addStats("initialized",1);
         }
         catch(error:Error)
         {
         }
         getKongregateItems();
      }
   }
}

