package game.peacefree
{
   import flash.utils.setTimeout;
   import game.acts.DemoMap;
   import game.container.GameConfig;
   import game.interfaces.Clickable;
   import game.interfaces.clickables.HiddenClickable;
   import game.library.SoundLibrary;
   import game.peacefree.interfaces.CommandInterfacer;
   import game.peacefree.interfaces.LogInterfacer;
   import game.peacefree.interfaces.MiniMap;
   import game.peacefree.interfaces.PopupMessage;
   import game.peacefree.interfaces.QuickMissionInterfacer;
   import game.peacefree.interfaces.QuickMissionOptionList;
   import game.peacefree.interfaces.TileOptionList;
   import game.peacefree.interfaces.Tooltip;
   import game.peacefree.interfaces.tileoptionlists.BuildOptionList;
   import game.peacefree.interfaces.tileoptionlists.ConfirmMissionOptionList;
   import game.peacefree.interfaces.tileoptionlists.MissionDetailsOptionList;
   import game.peacefree.interfaces.tileoptionlists.ResearchBuildingExtrasOptionList;
   import game.peacefree.interfaces.tileoptionlists.ResearchCommandsOptionList;
   import game.peacefree.interfaces.tileoptionlists.ResearchTroopPowersOptionList;
   import game.peacefree.interfaces.tileoptionlists.SecuredTileOptionList;
   import game.peacefree.interfaces.tileoptionlists.TradeOptionList;
   import game.peacefree.interfaces.tileoptionlists.UnsecuredTileOptionList;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class MapHUD extends Sprite
   {
      
      public var map:Map;
      
      public var miniMap:MiniMap;
      
      public var statusInterfacer:Sprite;
      
      public var timeTextField:TextField;
      
      public var dayTimeTextField:TextField;
      
      public var tileInfoSprite:Sprite;
      
      public var tileNameTextField:TextField;
      
      public var tileStatsTextField:TextField;
      
      public var tileDescTextField:TextField;
      
      public var foodTextField:TextField;
      
      public var mineralTextField:TextField;
      
      public var powerTextField:TextField;
      
      public var recruitsTextField:TextField;
      
      public var firepowerTextField:TextField;
      
      public var techpowerTextField:TextField;
      
      public var searchpowerTextField:TextField;
      
      public var mainOptionList:QuickMissionOptionList;
      
      public var unsecuredTileOptions:UnsecuredTileOptionList;
      
      public var securedTileOptions:SecuredTileOptionList;
      
      public var confirmMissionOptionList:ConfirmMissionOptionList;
      
      public var buildOptionList:BuildOptionList;
      
      public var researchCommandsOptionList:ResearchCommandsOptionList;
      
      public var researchTroopPowersOptionList:ResearchTroopPowersOptionList;
      
      public var researchBuildingExtrasOptionList:ResearchBuildingExtrasOptionList;
      
      public var tradeOptionList:TradeOptionList;
      
      public var optionPaneSprite:Sprite;
      
      public var optionListSprite:Sprite;
      
      public var logInterfacer:LogInterfacer;
      
      public var mainOptionListPane:Sprite;
      
      public var quickMissionInterfacer:QuickMissionInterfacer;
      
      public var missionDetailsOptionList:MissionDetailsOptionList;
      
      public var commandInterfacer:CommandInterfacer;
      
      public var timeControlsSprite:Sprite;
      
      public var logButton:Clickable;
      
      public var saveButton:Clickable;
      
      public var sfxButton:Clickable;
      
      public var bgmButton:Clickable;
      
      public var menuButton:Clickable;
      
      public var pauseButton:Clickable;
      
      public var normalSpeedButton:Clickable;
      
      public var fastSpeedButton:Clickable;
      
      public var superFastSpeedButton:Clickable;
      
      private var lastTimeMultiplier:int = 1;
      
      public var lastTile:Tile = null;
      
      public var bUpdateMiniMap:Boolean = false;
      
      public var missionObjectivesInterfacer:MissionObjectivesInterfacer;
      
      private var bShowingWarning:Boolean = false;
      
      private var bShowFoodWarning:Boolean = false;
      
      private var bShowEnergyWarning:Boolean = false;
      
      private var bShowArmySizeWarning:Boolean = false;
      
      private var lastTimeFoodWarning:int = -1;
      
      private var lastTimeEnergyWarning:int = -1;
      
      private var lastTimeArmySizeWarning:int = -1;
      
      public var tutorialSprite:Sprite;
      
      public var upperBarSprite:Sprite;
      
      public var bottomBarSprite:Sprite;
      
      public var searchpowerTooltip:Tooltip;
      
      public var firepowerTooltip:Tooltip;
      
      public var techpowerTooltip:Tooltip;
      
      public var powerTooltip:Tooltip;
      
      public var mineralTooltip:Tooltip;
      
      public var foodTooltip:Tooltip;
      
      public var recruitsTooltip:Tooltip;
      
      public var num1Callback:Clickable = null;
      
      public var num2Callback:Clickable = null;
      
      public var num3Callback:Clickable = null;
      
      public var num4Callback:Clickable = null;
      
      public var num5Callback:Clickable = null;
      
      public var num6Callback:Clickable = null;
      
      public var num7Callback:Clickable = null;
      
      public var num8Callback:Clickable = null;
      
      public var num9Callback:Clickable = null;
      
      public function MapHUD(param1:Map)
      {
         var statusQuad:Quad;
         var statusQuad2:Quad;
         var bottomControlsSprite:Sprite;
         var statusQuad8:Quad;
         var statusQuad9:Quad;
         var statusQuad10:Quad;
         var statusQuad20:Quad;
         var statusQuad5:Quad;
         var statusQuad6:Quad;
         var statusQuad7:Quad;
         var statusQuad21:Quad;
         var statusQuad22:Quad;
         var statusQuad3:Quad;
         var statusQuad4:Quad;
         var statusQuad4a:Quad;
         var searchpowerTextFieldHotspot:HiddenClickable;
         var firepowerTextFieldHotspot:HiddenClickable;
         var techpowerTextFieldHotspot:HiddenClickable;
         var powerTextFieldHotspot:HiddenClickable;
         var mineralTextFieldHotspot:HiddenClickable;
         var foodTextFieldHotspot:HiddenClickable;
         var recruitsTextFieldHotspot:HiddenClickable;
         var timeControlsTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         tutorialSprite = new Sprite();
         addChild(tutorialSprite);
         statusInterfacer = new Sprite();
         upperBarSprite = new Sprite();
         addChild(upperBarSprite);
         statusQuad = new Quad(GameConfig.GAME_WIDTH,45,1118481);
         statusQuad.x = 0;
         statusQuad.y = 0;
         statusQuad.alpha = 0.75;
         upperBarSprite.addChild(statusQuad);
         statusQuad2 = new Quad(GameConfig.GAME_WIDTH,2,6710886);
         statusQuad2.x = 0;
         statusQuad2.y = 45;
         statusQuad2.alpha = 0.75;
         upperBarSprite.addChild(statusQuad2);
         timeTextField = new TextField(110,40,"Á 00:00",Fonts.getDefaultFont().fontName,30,16777215,true);
         timeTextField.x = GameConfig.GAME_WIDTH - 100 - 10;
         timeTextField.y = 5;
         timeTextField.vAlign = "center";
         timeTextField.hAlign = "left";
         timeTextField.touchable = false;
         timeTextField.autoScale = true;
         upperBarSprite.addChild(timeTextField);
         dayTimeTextField = new TextField(110,40,"Day 1,",Fonts.getDefaultFont().fontName,30,16777215,true);
         dayTimeTextField.x = timeTextField.x - 110 - 10;
         dayTimeTextField.y = 5;
         dayTimeTextField.vAlign = "center";
         dayTimeTextField.hAlign = "right";
         dayTimeTextField.touchable = false;
         dayTimeTextField.autoScale = true;
         upperBarSprite.addChild(dayTimeTextField);
         mineralTextField = new TextField(90,40,"Â0",Fonts.getDefaultFont().fontName,30,16777215,true);
         mineralTextField.x = 10;
         mineralTextField.y = 5;
         mineralTextField.vAlign = "center";
         mineralTextField.hAlign = "left";
         mineralTextField.touchable = false;
         mineralTextField.autoScale = true;
         upperBarSprite.addChild(mineralTextField);
         foodTextField = new TextField(90,40,"È0",Fonts.getDefaultFont().fontName,30,16777215,true);
         foodTextField.x = mineralTextField.x + mineralTextField.width + 5;
         foodTextField.y = 5;
         foodTextField.vAlign = "center";
         foodTextField.hAlign = "left";
         foodTextField.touchable = false;
         foodTextField.autoScale = true;
         upperBarSprite.addChild(foodTextField);
         recruitsTextField = new TextField(150,40,"É0/0",Fonts.getDefaultFont().fontName,30,16777215,true);
         recruitsTextField.x = foodTextField.x + foodTextField.width + 5;
         recruitsTextField.y = 5;
         recruitsTextField.vAlign = "center";
         recruitsTextField.hAlign = "left";
         recruitsTextField.touchable = false;
         recruitsTextField.autoScale = true;
         upperBarSprite.addChild(recruitsTextField);
         powerTextField = new TextField(100,40,"Ë0/0",Fonts.getDefaultFont().fontName,30,16777215,true);
         powerTextField.x = recruitsTextField.x + recruitsTextField.width + 5;
         powerTextField.y = 5;
         powerTextField.vAlign = "center";
         powerTextField.hAlign = "left";
         powerTextField.touchable = false;
         powerTextField.autoScale = true;
         upperBarSprite.addChild(powerTextField);
         bottomControlsSprite = new Sprite();
         bottomControlsSprite.x = GameConfig.GAME_WIDTH - 250;
         bottomControlsSprite.y = GameConfig.GAME_HEIGHT - 30;
         addChild(bottomControlsSprite);
         logButton = new Clickable(Assets.getAtlas().getTexture("button_log"));
         logButton.alpha = 0.35;
         logButton.bChangeAlpha = false;
         logButton.releaseCallback = function():void
         {
            if(logButton.alpha == 0.35)
            {
               logButton.alpha = 1;
               logInterfacer.setShowAllLogs(true);
            }
            else
            {
               logButton.alpha = 0.35;
               logInterfacer.setShowAllLogs(false);
            }
         };
         bottomControlsSprite.addChild(logButton);
         sfxButton = new Clickable(Assets.getAtlas().getTexture("button_fx"));
         sfxButton.x = logButton.x + logButton.width + 20;
         sfxButton.bChangeAlpha = false;
         sfxButton.releaseCallback = function():void
         {
            toggleSFX();
         };
         bottomControlsSprite.addChild(sfxButton);
         bgmButton = new Clickable(Assets.getAtlas().getTexture("button_bgm"));
         bgmButton.x = sfxButton.x + sfxButton.width + 20;
         bgmButton.bChangeAlpha = false;
         bgmButton.releaseCallback = function():void
         {
            toggleBGM();
         };
         bottomControlsSprite.addChild(bgmButton);
         saveButton = new Clickable(Assets.getAtlas().getTexture("button_save"));
         saveButton.x = bgmButton.x + bgmButton.width + 20;
         saveButton.releaseCallback = function():void
         {
            map.pgame.showSaveFileInterface();
         };
         bottomControlsSprite.addChild(saveButton);
         menuButton = new Clickable(Assets.getAtlas().getTexture("button_menu"));
         menuButton.x = saveButton.x + saveButton.width + 20;
         menuButton.releaseCallback = function():void
         {
            map.optionsInterfacer.refresh();
            map.showOptionsInterface();
         };
         bottomControlsSprite.addChild(menuButton);
         timeControlsSprite = new Sprite();
         timeControlsSprite.x = GameConfig.GAME_WIDTH - 160;
         timeControlsSprite.y = 50;
         addChild(timeControlsSprite);
         pauseButton = new Clickable(Assets.getAtlas().getTexture("button_pause"));
         pauseButton.bChangeAlpha = false;
         pauseButton.alpha = 0.35;
         pauseButton.releaseCallback = pause;
         timeControlsSprite.addChild(pauseButton);
         normalSpeedButton = new Clickable(Assets.getAtlas().getTexture("button_play"));
         normalSpeedButton.x = pauseButton.x + pauseButton.width + 10;
         normalSpeedButton.bChangeAlpha = false;
         normalSpeedButton.alpha = 1;
         normalSpeedButton.releaseCallback = function():void
         {
            changeSpeed(1);
         };
         timeControlsSprite.addChild(normalSpeedButton);
         fastSpeedButton = new Clickable(Assets.getAtlas().getTexture("button_ff"));
         fastSpeedButton.x = normalSpeedButton.x + normalSpeedButton.width + 10;
         fastSpeedButton.bChangeAlpha = false;
         fastSpeedButton.alpha = 0.35;
         fastSpeedButton.releaseCallback = function():void
         {
            changeSpeed(4);
         };
         timeControlsSprite.addChild(fastSpeedButton);
         superFastSpeedButton = new Clickable(Assets.getAtlas().getTexture("button_fff"));
         superFastSpeedButton.x = fastSpeedButton.x + fastSpeedButton.width + 10;
         superFastSpeedButton.bChangeAlpha = false;
         superFastSpeedButton.alpha = 0.35;
         superFastSpeedButton.releaseCallback = function():void
         {
            changeSpeed(8);
         };
         timeControlsSprite.addChild(superFastSpeedButton);
         tileInfoSprite = new Sprite();
         tileInfoSprite.x = GameConfig.GAME_WIDTH - 290;
         tileInfoSprite.y = 100;
         tileInfoSprite.visible = false;
         addChild(tileInfoSprite);
         statusQuad8 = new Quad(290,280,136726);
         statusQuad8.x = 0;
         statusQuad8.y = 0;
         statusQuad8.alpha = 0.75;
         tileInfoSprite.addChild(statusQuad8);
         statusQuad9 = new Quad(2,280,6710886);
         statusQuad9.x = -2;
         statusQuad9.y = 0;
         statusQuad9.alpha = 0.75;
         tileInfoSprite.addChild(statusQuad9);
         statusQuad10 = new Quad(292,2,6710886);
         statusQuad10.x = -2;
         statusQuad10.y = -2;
         statusQuad10.alpha = 0.75;
         tileInfoSprite.addChild(statusQuad10);
         statusQuad20 = new Quad(292,2,6710886);
         statusQuad20.x = -2;
         statusQuad20.y = 280;
         statusQuad20.alpha = 0.75;
         tileInfoSprite.addChild(statusQuad20);
         tileNameTextField = new TextField(290,24,"Resthouse",Fonts.getDefaultFont().fontName,24,4293759265,true);
         tileNameTextField.x = 0;
         tileNameTextField.y = 5;
         tileNameTextField.vAlign = "center";
         tileNameTextField.hAlign = "center";
         tileNameTextField.touchable = false;
         tileNameTextField.autoScale = true;
         tileInfoSprite.addChild(tileNameTextField);
         tileStatsTextField = new TextField(290,30,"È 99 È 99 È 99 È 99",Fonts.getDefaultFont().fontName,18,16777215,true);
         tileStatsTextField.x = 0;
         tileStatsTextField.y = 110;
         tileStatsTextField.vAlign = "center";
         tileStatsTextField.hAlign = "center";
         tileStatsTextField.touchable = false;
         tileStatsTextField.autoScale = true;
         tileInfoSprite.addChild(tileStatsTextField);
         tileDescTextField = new TextField(260,100,"This Port Shuttle increases transferring resources from one planet to another.\n\nAllows you to trade food and minerals.",Fonts.getDefaultFont().fontName,18,16777215,true);
         tileDescTextField.x = 15;
         tileDescTextField.y = 30;
         tileDescTextField.vAlign = "top";
         tileDescTextField.hAlign = "left";
         tileDescTextField.touchable = false;
         tileDescTextField.autoScale = true;
         tileInfoSprite.addChild(tileDescTextField);
         optionPaneSprite = new Sprite();
         optionPaneSprite.x = GameConfig.GAME_WIDTH - 260;
         optionPaneSprite.y = 250;
         optionPaneSprite.visible = false;
         addChild(optionPaneSprite);
         statusQuad5 = new Quad(250,130,1118481);
         statusQuad5.x = -10;
         statusQuad5.y = -10;
         statusQuad5.alpha = 0.75;
         optionPaneSprite.addChild(statusQuad5);
         statusQuad6 = new Quad(2,132,2236962);
         statusQuad6.x = -12;
         statusQuad6.y = -12;
         statusQuad6.alpha = 0.75;
         optionPaneSprite.addChild(statusQuad6);
         statusQuad7 = new Quad(250,2,2236962);
         statusQuad7.x = -10;
         statusQuad7.y = -12;
         statusQuad7.alpha = 0.75;
         optionPaneSprite.addChild(statusQuad7);
         statusQuad21 = new Quad(2,132,2236962);
         statusQuad21.x = 240;
         statusQuad21.y = -12;
         statusQuad21.alpha = 0.75;
         optionPaneSprite.addChild(statusQuad21);
         statusQuad22 = new Quad(254,2,2236962);
         statusQuad22.x = -12;
         statusQuad22.y = 120;
         statusQuad22.alpha = 0.75;
         optionPaneSprite.addChild(statusQuad22);
         optionListSprite = new Sprite();
         optionPaneSprite.addChild(optionListSprite);
         unsecuredTileOptions = new UnsecuredTileOptionList(map);
         securedTileOptions = new SecuredTileOptionList(map);
         confirmMissionOptionList = new ConfirmMissionOptionList(map);
         buildOptionList = new BuildOptionList(map);
         researchCommandsOptionList = new ResearchCommandsOptionList(map);
         researchTroopPowersOptionList = new ResearchTroopPowersOptionList(map);
         researchBuildingExtrasOptionList = new ResearchBuildingExtrasOptionList(map);
         tradeOptionList = new TradeOptionList(map);
         missionDetailsOptionList = new MissionDetailsOptionList(map);
         logInterfacer = new LogInterfacer(map);
         logInterfacer.x = GameConfig.GAME_WIDTH - 250;
         logInterfacer.y = GameConfig.GAME_HEIGHT - 55;
         addChild(logInterfacer);
         quickMissionInterfacer = new QuickMissionInterfacer(map);
         addChild(quickMissionInterfacer);
         setOptionList(null);
         commandInterfacer = new CommandInterfacer(map);
         commandInterfacer.x = 170;
         commandInterfacer.y = GameConfig.GAME_HEIGHT - 85;
         addChild(commandInterfacer);
         missionObjectivesInterfacer = new MissionObjectivesInterfacer(map);
         missionObjectivesInterfacer.x = 10;
         missionObjectivesInterfacer.y = 60;
         addChild(missionObjectivesInterfacer);
         bottomBarSprite = new Sprite();
         addChild(bottomBarSprite);
         statusQuad3 = new Quad(510,40,1118481);
         statusQuad3.x = 0;
         statusQuad3.y = GameConfig.GAME_HEIGHT - 40;
         statusQuad3.alpha = 0.75;
         bottomBarSprite.addChild(statusQuad3);
         statusQuad4 = new Quad(510,2,6710886);
         statusQuad4.x = 0;
         statusQuad4.y = GameConfig.GAME_HEIGHT - 42;
         statusQuad4.alpha = 0.75;
         bottomBarSprite.addChild(statusQuad4);
         statusQuad4a = new Quad(2,42,6710886);
         statusQuad4a.x = 510;
         statusQuad4a.y = GameConfig.GAME_HEIGHT - 42;
         statusQuad4a.alpha = 0.75;
         bottomBarSprite.addChild(statusQuad4a);
         miniMap = new MiniMap();
         miniMap.x = 5;
         miniMap.y = GameConfig.GAME_HEIGHT - 165;
         bottomBarSprite.addChild(miniMap);
         searchpowerTextField = new TextField(105,40,"Å 0",Fonts.getDefaultFont().fontName,24,16777215,true);
         searchpowerTextField.x = miniMap.x + miniMap.width + 10;
         searchpowerTextField.y = GameConfig.GAME_HEIGHT - 40;
         searchpowerTextField.vAlign = "center";
         searchpowerTextField.hAlign = "left";
         searchpowerTextField.touchable = false;
         searchpowerTextField.autoScale = true;
         bottomBarSprite.addChild(searchpowerTextField);
         firepowerTextField = new TextField(105,40,"Æ 0",Fonts.getDefaultFont().fontName,24,16777215,true);
         firepowerTextField.x = searchpowerTextField.x + searchpowerTextField.width + 5;
         firepowerTextField.y = GameConfig.GAME_HEIGHT - 40;
         firepowerTextField.vAlign = "center";
         firepowerTextField.hAlign = "left";
         firepowerTextField.touchable = false;
         firepowerTextField.autoScale = true;
         bottomBarSprite.addChild(firepowerTextField);
         techpowerTextField = new TextField(105,40,"Ê 0",Fonts.getDefaultFont().fontName,24,16777215,true);
         techpowerTextField.x = firepowerTextField.x + firepowerTextField.width + 5;
         techpowerTextField.y = GameConfig.GAME_HEIGHT - 40;
         techpowerTextField.vAlign = "center";
         techpowerTextField.hAlign = "left";
         techpowerTextField.touchable = false;
         techpowerTextField.autoScale = true;
         bottomBarSprite.addChild(techpowerTextField);
         searchpowerTextFieldHotspot = new HiddenClickable(Texture.fromColor(searchpowerTextField.width,searchpowerTextField.height,0));
         searchpowerTextFieldHotspot.x = searchpowerTextField.x;
         searchpowerTextFieldHotspot.y = searchpowerTextField.y;
         bottomBarSprite.addChild(searchpowerTextFieldHotspot);
         searchpowerTooltip = new Tooltip(250,80,"Å Searchpower","Your army has a max of Å" + map.player.maxSearchpower + " and gain +" + map.player.searchpowerGrowth + "Å" + " per hour.");
         searchpowerTooltip.x = searchpowerTextField.x;
         searchpowerTooltip.y = searchpowerTextField.y - searchpowerTooltip.height + 15;
         searchpowerTextFieldHotspot.tooltip = searchpowerTooltip;
         addChild(searchpowerTooltip);
         firepowerTextFieldHotspot = new HiddenClickable(Texture.fromColor(firepowerTextField.width,firepowerTextField.height,0));
         firepowerTextFieldHotspot.x = firepowerTextField.x;
         firepowerTextFieldHotspot.y = firepowerTextField.y;
         bottomBarSprite.addChild(firepowerTextFieldHotspot);
         firepowerTooltip = new Tooltip(250,80,"Æ Firepower","Your army has a max of Æ" + map.player.maxFirepower + " and gain +" + map.player.firepowerGrowth + "Æ" + " per hour.");
         firepowerTooltip.x = firepowerTextField.x;
         firepowerTooltip.y = firepowerTextField.y - firepowerTooltip.height + 15;
         firepowerTextFieldHotspot.tooltip = firepowerTooltip;
         addChild(firepowerTooltip);
         techpowerTextFieldHotspot = new HiddenClickable(Texture.fromColor(techpowerTextField.width,techpowerTextField.height,0));
         techpowerTextFieldHotspot.x = techpowerTextField.x;
         techpowerTextFieldHotspot.y = techpowerTextField.y;
         bottomBarSprite.addChild(techpowerTextFieldHotspot);
         techpowerTooltip = new Tooltip(250,80,"Ê Techpower","Your army has a max of Ê" + map.player.maxTechpower + " and gain +" + map.player.techpowerGrowth + "Ê" + " per hour.");
         techpowerTooltip.x = techpowerTextField.x;
         techpowerTooltip.y = techpowerTextField.y - techpowerTooltip.height + 15;
         techpowerTextFieldHotspot.tooltip = techpowerTooltip;
         addChild(techpowerTooltip);
         powerTextFieldHotspot = new HiddenClickable(Texture.fromColor(powerTextField.width,powerTextField.height,0));
         powerTextFieldHotspot.x = powerTextField.x;
         powerTextFieldHotspot.y = powerTextField.y;
         upperBarSprite.addChild(powerTextFieldHotspot);
         powerTooltip = new Tooltip(250,80,"Ë Energy","Your base requires Ë" + map.player.curEnergy + " and produces " + "Ë" + map.player.maxEnergy + ".");
         powerTooltip.x = powerTextField.x;
         powerTooltip.y = powerTextField.y + 50;
         powerTextFieldHotspot.tooltip = powerTooltip;
         addChild(powerTooltip);
         mineralTextFieldHotspot = new HiddenClickable(Texture.fromColor(mineralTextField.width,mineralTextField.height,0));
         mineralTextFieldHotspot.x = mineralTextField.x;
         mineralTextFieldHotspot.y = mineralTextField.y;
         upperBarSprite.addChild(mineralTextFieldHotspot);
         mineralTooltip = new Tooltip(250,80,"Â Minerals","Your base produces roughly +" + map.player.mineralGrowth + "Â" + " minerals per day.");
         mineralTooltip.x = mineralTextField.x;
         mineralTooltip.y = mineralTextField.y + 50;
         mineralTextFieldHotspot.tooltip = mineralTooltip;
         addChild(mineralTooltip);
         foodTextFieldHotspot = new HiddenClickable(Texture.fromColor(foodTextField.width,foodTextField.height,0));
         foodTextFieldHotspot.x = foodTextField.x;
         foodTextFieldHotspot.y = foodTextField.y;
         upperBarSprite.addChild(foodTextFieldHotspot);
         foodTooltip = new Tooltip(250,80,"È Food","Your base produces roughly +" + map.player.foodGrowth + "È" + " per day.");
         foodTooltip.x = foodTextField.x;
         foodTooltip.y = foodTextField.y + 50;
         foodTextFieldHotspot.tooltip = foodTooltip;
         addChild(foodTooltip);
         recruitsTextFieldHotspot = new HiddenClickable(Texture.fromColor(recruitsTextField.width,recruitsTextField.height,0));
         recruitsTextFieldHotspot.x = recruitsTextField.x;
         recruitsTextFieldHotspot.y = recruitsTextField.y;
         upperBarSprite.addChild(recruitsTextFieldHotspot);
         recruitsTooltip = new Tooltip(250,80,"É Troopers","É" + map.player.totalRecruits + " are producing " + "Å" + "Æ" + "Ê" + " per hour. Your base can house up to " + "É" + map.player.maxRecruits + ".");
         recruitsTooltip.x = recruitsTextField.x;
         recruitsTooltip.y = recruitsTextField.y + 50;
         recruitsTextFieldHotspot.tooltip = recruitsTooltip;
         addChild(recruitsTooltip);
         timeControlsTooltip = new Tooltip(400,30,"[Space] to pause/unpause. [C]/[X] to speed up/slow down.","");
         timeControlsTooltip.titleTextField.fontSize = 16;
         timeControlsTooltip.titleTextField.hAlign = "center";
         timeControlsTooltip.titleTextField.color = 16777215;
         timeControlsTooltip.x = timeControlsSprite.x - 415;
         timeControlsTooltip.y = timeControlsSprite.y + 5;
         pauseButton.tooltip = timeControlsTooltip;
         normalSpeedButton.tooltip = timeControlsTooltip;
         fastSpeedButton.tooltip = timeControlsTooltip;
         superFastSpeedButton.tooltip = timeControlsTooltip;
         addChild(timeControlsTooltip);
      }
      
      public function changeSpeed(param1:int) : void
      {
         map.timeMultiplier = param1;
         pauseButton.alpha = 0.35;
         normalSpeedButton.alpha = 0.35;
         fastSpeedButton.alpha = 0.35;
         superFastSpeedButton.alpha = 0.35;
         switch(param1 - 1)
         {
            case 3:
               fastSpeedButton.alpha = 1;
               break;
            case 7:
               superFastSpeedButton.alpha = 1;
               break;
            default:
               normalSpeedButton.alpha = 1;
         }
         map.bUpdateFPS = true;
      }
      
      public function pause() : void
      {
         if(map.timeMultiplier > 0)
         {
            lastTimeMultiplier = map.timeMultiplier;
            map.timeMultiplier = 0;
            pauseButton.alpha = 1;
         }
         else
         {
            map.timeMultiplier = lastTimeMultiplier;
            pauseButton.alpha = 0.35;
         }
         map.bUpdateFPS = true;
      }
      
      public function unpause() : void
      {
         if(map.timeMultiplier > 0)
         {
            return;
         }
         map.timeMultiplier = lastTimeMultiplier;
         pauseButton.alpha = 0.35;
         map.bUpdateFPS = true;
      }
      
      public function setDayTime(param1:int, param2:String) : void
      {
         timeTextField.text = "Á " + param2;
         dayTimeTextField.text = "Day " + param1 + ",";
      }
      
      public function setOptionList(param1:Sprite) : void
      {
         while(optionListSprite.numChildren > 0)
         {
            optionListSprite.removeChildAt(0);
         }
         if(param1 != null)
         {
            optionListSprite.addChild(param1);
            tileInfoSprite.visible = true;
            optionPaneSprite.visible = true;
            quickMissionInterfacer.hide();
            quickMissionInterfacer.visible = false;
         }
         else
         {
            optionPaneSprite.visible = false;
            quickMissionInterfacer.visible = true;
         }
      }
      
      public function isViewingOptionList(param1:Sprite) : Boolean
      {
         return optionListSprite.numChildren > 0 && optionListSprite.getChildAt(0) == param1;
      }
      
      public function clearNumCallbacks() : void
      {
         num1Callback = null;
         num2Callback = null;
         num3Callback = null;
         num4Callback = null;
         num5Callback = null;
         num6Callback = null;
         num7Callback = null;
         num8Callback = null;
      }
      
      public function setSelectedTile(param1:Tile, param2:Boolean = false) : void
      {
         clearNumCallbacks();
         if(param1 == null)
         {
            lastTile = null;
            if(quickMissionInterfacer.visible)
            {
               return;
            }
            tileInfoSprite.visible = false;
            if(param2 || !isViewingOptionList(mainOptionList))
            {
               setOptionList(null);
            }
         }
         else if(commandInterfacer.isCommandSelected())
         {
            commandInterfacer.performCommand(param1);
         }
         else if(quickMissionInterfacer.bQuickMissionsEnabled)
         {
            quickMissionInterfacer.quickMissionOptionList.startQuickMission(param1);
         }
         else if(param1.mission != null)
         {
            lastTile = param1;
            if(param1.bScouted)
            {
               tileStatsTextField.text = "È " + param1.food + " " + "Â" + " " + param1.minerals + " " + "É" + " " + param1.recruits + " " + "Ä" + " " + param1.danger;
            }
            else
            {
               tileStatsTextField.text = "È ?? Â ?? É ?? Ä ??";
            }
            tileNameTextField.text = param1.mission.getMissionTitle();
            tileDescTextField.text = param1.mission.getMissionDescription();
            missionDetailsOptionList.setTile(param1);
            setOptionList(missionDetailsOptionList);
         }
         else
         {
            lastTile = param1;
            if(param1.bScouted)
            {
               tileStatsTextField.text = "È " + param1.food + " " + "Â" + " " + param1.minerals + " " + "É" + " " + param1.recruits + " " + "Ä" + " " + param1.danger;
               if(param1.building == null)
               {
                  tileNameTextField.text = param1.tileName;
                  tileDescTextField.text = param1.tileDesc;
                  if(param1.bSecured)
                  {
                     tileStatsTextField.visible = false;
                  }
                  else
                  {
                     tileStatsTextField.visible = true;
                  }
               }
               else
               {
                  tileNameTextField.text = Building.getBuildingName(param1.building.type);
                  tileDescTextField.text = Building.getBuildingDescription(param1.building.type,map);
                  tileStatsTextField.visible = true;
               }
            }
            else
            {
               tileNameTextField.text = "Unscouted Area";
               tileStatsTextField.text = "È ?? Â ?? É ?? Ä ??";
               tileDescTextField.text = "You need to scout this area to gain more information.";
            }
            if(param1.bSecured)
            {
               securedTileOptions.setTile(param1);
               setOptionList(securedTileOptions);
            }
            else
            {
               unsecuredTileOptions.setTile(param1);
               setOptionList(unsecuredTileOptions);
            }
         }
      }
      
      public function update() : void
      {
         setDayTime(map.days,map.getTime());
         firepowerTextField.text = "Æ " + map.player.curFirepower + "/" + map.player.maxFirepower;
         techpowerTextField.text = "Ê " + map.player.curTechpower + "/" + map.player.maxTechpower;
         searchpowerTextField.text = "Å " + map.player.curSearchpower + "/" + map.player.maxSearchpower;
         foodTextField.text = "È" + map.player.food;
         mineralTextField.text = "Â" + map.player.minerals;
         powerTextField.text = "Ë" + map.player.curEnergy + "/" + map.player.maxEnergy;
         recruitsTextField.text = "É" + map.player.totalRecruits + "/" + map.player.maxRecruits;
         if(map.player.curEnergy > map.player.maxEnergy)
         {
            showEnergyWarning();
         }
         if(lastTile != null)
         {
            if(!lastTile.bSecured || lastTile.building == null)
            {
               tileStatsTextField.visible = true;
               if(lastTile.bScouted)
               {
                  tileStatsTextField.text = "È " + lastTile.food + " " + "Â" + " " + lastTile.minerals + " " + "É" + " " + lastTile.recruits + " " + "Ä" + " " + lastTile.danger;
               }
            }
            else
            {
               tileStatsTextField.visible = false;
            }
         }
      }
      
      public function progress(param1:int) : void
      {
         if(map == null || map.act is DemoMap)
         {
            return;
         }
         logInterfacer.progress(param1);
         missionObjectivesInterfacer.progress(param1);
         if(quickMissionInterfacer.bQuickMissionsEnabled)
         {
            quickMissionInterfacer.quickMissionOptionList.refresh();
         }
         if(optionListSprite.numChildren > 0)
         {
            TileOptionList(optionListSprite.getChildAt(0)).refresh();
         }
         commandInterfacer.progress(param1 * map.timeMultiplier);
         miniMap.progress(param1);
         if(bUpdateMiniMap)
         {
            bUpdateMiniMap = false;
            miniMap.update();
         }
         if(lastTimeFoodWarning > 0)
         {
            lastTimeFoodWarning -= param1;
         }
         if(lastTimeEnergyWarning > 0)
         {
            lastTimeEnergyWarning -= param1;
         }
         if(lastTimeArmySizeWarning > 0)
         {
            lastTimeArmySizeWarning -= param1;
         }
         if(bShowFoodWarning)
         {
            showFoodWarning();
         }
         if(bShowEnergyWarning)
         {
            showEnergyWarning();
         }
         if(bShowArmySizeWarning)
         {
            showArmySizeWarning();
         }
         searchpowerTooltip.bodyTextField.text = "Your army has a max of Å" + map.player.maxSearchpower + " and gain +" + map.player.searchpowerGrowth + "Å" + " per hour.";
         firepowerTooltip.bodyTextField.text = "Your army has a max of Æ" + map.player.maxFirepower + " and gain +" + map.player.firepowerGrowth + "Æ" + " per hour.";
         techpowerTooltip.bodyTextField.text = "Your army has a max of Ê" + map.player.maxTechpower + " and gain +" + map.player.techpowerGrowth + "Ê" + " per hour.";
         if(map.player.curEnergy > map.player.maxEnergy)
         {
            powerTooltip.bodyTextField.text = "Some buildings are offline. You need Ë" + map.player.curEnergy + " but only produce " + "Ë" + map.player.maxEnergy + ".";
         }
         else
         {
            powerTooltip.bodyTextField.text = "Your buildings are utilizing Ë" + map.player.curEnergy + " of the " + "Ë" + map.player.maxEnergy + " you generate.";
         }
         mineralTooltip.bodyTextField.text = "Your base produces roughly +" + map.player.mineralGrowth + "Â" + " minerals per day.";
         if(map.difficulty == 0)
         {
            foodTooltip.bodyTextField.text = "Your base produces roughly +" + map.player.foodGrowth + "È" + " and consume -" + (map.player.bConsumeFood ? map.player.foodConsume : 0) + "È" + " per day.";
         }
         else
         {
            foodTooltip.bodyTextField.text = "Your base produces roughly +" + map.player.foodGrowth + "È" + " and consume -" + (map.player.bConsumeFood ? map.player.foodConsume * 2 : 0) + "È" + " per day.";
         }
         recruitsTooltip.bodyTextField.text = "É" + map.player.totalRecruits + " are producing " + "Å" + "Æ" + "Ê" + " per hour. Your base can house up to " + "É" + map.player.maxRecruits + ".";
      }
      
      public function setSequence(param1:StorySequence) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MissionObjective = null;
         if(param1.objectives == null)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.objectives.length)
         {
            _loc2_ = param1.objectives[_loc3_];
            addObjective(_loc2_);
            _loc3_++;
         }
      }
      
      public function addObjective(param1:MissionObjective) : void
      {
         if(missionObjectivesInterfacer.hasEntry(param1))
         {
            return;
         }
         param1.init();
         if(!param1.bNoShowMarker)
         {
            param1.markerSprite.play();
            Starling.juggler.add(param1.markerSprite);
            map.effectSprite.addChild(param1.markerSprite);
            miniMap.addMissionObjective(param1);
         }
         if(param1.mobGenerator != null)
         {
            map.addMobGenerator(param1.mobGenerator);
         }
         missionObjectivesInterfacer.addEntry(param1);
      }
      
      public function getData() : Object
      {
         var _loc1_:Object = {};
         _loc1_.command = commandInterfacer.getData();
         return _loc1_;
      }
      
      public function setData(param1:Object) : void
      {
         commandInterfacer.setData(param1.command);
      }
      
      public function toggleBGM(param1:Boolean = true) : void
      {
         if(param1)
         {
            map.setEnableBGM(!map.bEnableBGM);
         }
         if(map.bEnableBGM)
         {
            bgmButton.alpha = 1;
         }
         else
         {
            bgmButton.alpha = 0.35;
         }
         map.pgame.saveGameData();
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
         map.pgame.saveGameData();
      }
      
      public function showFoodWarning() : void
      {
         var popup:PopupMessage;
         var tween_popup:Tween;
         bShowFoodWarning = true;
         if(bShowingWarning)
         {
            return;
         }
         bShowFoodWarning = false;
         if(lastTimeFoodWarning > 0)
         {
            return;
         }
         bShowingWarning = true;
         lastTimeFoodWarning = 120000;
         popup = new PopupMessage(240,80,"Ã Food Is Low!","Gather more È or build more Hydropods.","building_102_01");
         popup.x = -popup.width;
         popup.y = GameConfig.GAME_HEIGHT - 150 - popup.height;
         popup.alpha = 0;
         addChild(popup);
         tween_popup = new Tween(popup,0.5);
         tween_popup.fadeTo(1);
         tween_popup.moveTo(-2,GameConfig.GAME_HEIGHT - 150 - popup.height);
         tween_popup.onComplete = function():void
         {
            setTimeout(function():void
            {
               tween_popup = new Tween(popup,0.5);
               tween_popup.moveTo(-popup.width,GameConfig.GAME_HEIGHT - 150 - popup.height);
               tween_popup.fadeTo(0);
               tween_popup.onComplete = function():void
               {
                  popup.removeFromParent(true);
                  bShowingWarning = false;
               };
               Starling.juggler.add(tween_popup);
            },8000);
         };
         Starling.juggler.add(tween_popup);
      }
      
      public function showEnergyWarning() : void
      {
         var popup:PopupMessage;
         var tween_popup:Tween;
         bShowEnergyWarning = true;
         if(bShowingWarning)
         {
            return;
         }
         bShowEnergyWarning = false;
         if(lastTimeEnergyWarning > 0)
         {
            return;
         }
         bShowingWarning = true;
         lastTimeEnergyWarning = 120000;
         popup = new PopupMessage(240,80,"Ã Need More Energy!","Build more Generators to generate more Ë.","building_101_01");
         popup.x = -popup.width;
         popup.y = GameConfig.GAME_HEIGHT - 150 - popup.height;
         popup.alpha = 0;
         addChild(popup);
         tween_popup = new Tween(popup,0.5);
         tween_popup.fadeTo(1);
         tween_popup.moveTo(-2,GameConfig.GAME_HEIGHT - 150 - popup.height);
         tween_popup.onComplete = function():void
         {
            setTimeout(function():void
            {
               tween_popup = new Tween(popup,0.5);
               tween_popup.moveTo(-popup.width,GameConfig.GAME_HEIGHT - 150 - popup.height);
               tween_popup.fadeTo(0);
               tween_popup.onComplete = function():void
               {
                  popup.removeFromParent(true);
                  bShowingWarning = false;
               };
               Starling.juggler.add(tween_popup);
            },8000);
         };
         Starling.juggler.add(tween_popup);
      }
      
      public function showArmySizeWarning() : void
      {
         var popup:PopupMessage;
         var tween_popup:Tween;
         bShowArmySizeWarning = true;
         if(bShowingWarning)
         {
            return;
         }
         bShowArmySizeWarning = false;
         if(lastTimeArmySizeWarning > 0)
         {
            return;
         }
         bShowingWarning = true;
         lastTimeArmySizeWarning = 120000;
         popup = new PopupMessage(240,80,"Ã Max É Reached!","Build more Resthouses to recruit more É.","building_104_01");
         popup.x = -popup.width;
         popup.y = GameConfig.GAME_HEIGHT - 150 - popup.height;
         popup.alpha = 0;
         addChild(popup);
         tween_popup = new Tween(popup,0.5);
         tween_popup.fadeTo(1);
         tween_popup.moveTo(-2,GameConfig.GAME_HEIGHT - 150 - popup.height);
         tween_popup.onComplete = function():void
         {
            setTimeout(function():void
            {
               tween_popup = new Tween(popup,0.5);
               tween_popup.moveTo(-popup.width,GameConfig.GAME_HEIGHT - 150 - popup.height);
               tween_popup.fadeTo(0);
               tween_popup.onComplete = function():void
               {
                  popup.removeFromParent(true);
                  bShowingWarning = false;
               };
               Starling.juggler.add(tween_popup);
            },8000);
         };
         Starling.juggler.add(tween_popup);
      }
      
      public function clearTutorialSprite() : void
      {
         while(tutorialSprite.numChildren > 0)
         {
            tutorialSprite.getChildAt(0).removeFromParent(true);
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         miniMap = null;
         statusInterfacer = null;
         timeTextField = null;
         dayTimeTextField = null;
         tileInfoSprite = null;
         tileNameTextField = null;
         tileStatsTextField = null;
         tileDescTextField = null;
         foodTextField = null;
         mineralTextField = null;
         powerTextField = null;
         recruitsTextField = null;
         firepowerTextField = null;
         techpowerTextField = null;
         searchpowerTextField = null;
         mainOptionList = null;
         unsecuredTileOptions = null;
         securedTileOptions = null;
         confirmMissionOptionList = null;
         buildOptionList = null;
         researchCommandsOptionList = null;
         researchTroopPowersOptionList = null;
         tradeOptionList = null;
         optionPaneSprite = null;
         optionListSprite = null;
         logInterfacer = null;
         mainOptionListPane = null;
         quickMissionInterfacer = null;
         missionDetailsOptionList = null;
         commandInterfacer = null;
         timeControlsSprite = null;
         logButton = null;
         saveButton = null;
         sfxButton = null;
         bgmButton = null;
         menuButton = null;
         pauseButton = null;
         normalSpeedButton = null;
         fastSpeedButton = null;
         superFastSpeedButton = null;
         lastTile = null;
         missionObjectivesInterfacer = null;
         tutorialSprite = null;
         searchpowerTooltip = null;
         firepowerTooltip = null;
         techpowerTooltip = null;
         powerTooltip = null;
         mineralTooltip = null;
         foodTooltip = null;
         recruitsTooltip = null;
         super.dispose();
      }
   }
}

