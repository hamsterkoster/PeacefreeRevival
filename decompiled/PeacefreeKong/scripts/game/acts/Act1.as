package game.acts
{
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import game.container.GameConfig;
   import game.library.MapLibrary;
   import game.peacefree.Achievement;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import game.peacefree.Mob;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.StorySequence;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.text.TextField;
   
   public class Act1 extends Act
   {
      
      public static const MapInfo:Class = exmission18_txt;
      
      private var tween_pulseExclam:Tween;
      
      private var tween_pulseExclam2:Tween;
      
      private var tween_pulseExclam3:Tween;
      
      private var exclamImage:Image;
      
      private var exclamImage2:Image;
      
      private var exclamImage3:Image;
      
      public function Act1()
      {
         super();
      }
      
      override public function init(param1:Map, param2:Boolean = true) : void
      {
         var actNumber:int;
         var txt:ByteArray;
         var popupSprite:Sprite;
         var popupSprite2:Sprite;
         var popupSprite3:Sprite;
         var blackFilmQuad:Quad;
         var sequence:StorySequence;
         var m:MissionObjective;
         var bFound:Boolean;
         var i:int;
         var map:Map = param1;
         var bLoadMap:Boolean = param2;
         super.init(map);
         actNumber = getActNumber();
         if(bLoadMap)
         {
            txt = new MapInfo() as ByteArray;
            map.loadMap(MapLibrary.parseMapData(txt.toString()));
         }
         map.startPoint = 8 + 16 * map.mapWidth;
         map.secureTile(map.tiles[map.startPoint]);
         map.goToTile(map.tiles[map.startPoint]);
         map.mapHUD.logInterfacer.visible = false;
         map.mapHUD.logButton.visible = false;
         map.mapHUD.buildOptionList.buildResthouseOption.visible = false;
         map.mapHUD.buildOptionList.buildGeneratorOption.visible = false;
         map.mapHUD.buildOptionList.buildHydropodOption.visible = false;
         map.mapHUD.buildOptionList.buildExtractorOption.visible = false;
         map.mapHUD.buildOptionList.buildWatchtowerOption.visible = false;
         map.mapHUD.buildOptionList.buildTechlabOption.visible = false;
         map.mapHUD.buildOptionList.buildPortShuttleOption.visible = false;
         map.mapHUD.commandInterfacer.rushCommand.visible = false;
         map.mapHUD.commandInterfacer.aidCommand.visible = false;
         map.mapHUD.commandInterfacer.blastCommand.visible = false;
         map.mapHUD.commandInterfacer.zapCommand.visible = false;
         map.mapHUD.removeChild(map.mapHUD.quickMissionInterfacer);
         map.mapHUD.unsecuredTileOptions.bEnableSecure = false;
         map.mapHUD.securedTileOptions.bEnableSalvage = false;
         map.mapHUD.securedTileOptions.bEnableAbandon = false;
         map.mapHUD.miniMap.cursor.visible = false;
         map.mapHUD.miniMap.bEnableMovement = false;
         map.mapHUD.miniMap.removeChild(map.mapHUD.miniMap.northHotkey);
         map.mapHUD.miniMap.removeChild(map.mapHUD.miniMap.eastHotkey);
         map.mapHUD.miniMap.removeChild(map.mapHUD.miniMap.westHotkey);
         map.mapHUD.miniMap.removeChild(map.mapHUD.miniMap.southHotkey);
         map.mapHUD.missionObjectivesInterfacer.visible = false;
         map.mapHUD.foodTextField.visible = false;
         map.mapHUD.mineralTextField.visible = false;
         map.mapHUD.powerTextField.visible = false;
         map.mapHUD.recruitsTextField.visible = false;
         map.mapHUD.firepowerTextField.visible = false;
         map.mapHUD.techpowerTextField.visible = false;
         map.mapHUD.removeChild(map.mapHUD.firepowerTooltip);
         map.mapHUD.removeChild(map.mapHUD.techpowerTooltip);
         map.mapHUD.removeChild(map.mapHUD.powerTooltip);
         map.mapHUD.removeChild(map.mapHUD.mineralTooltip);
         map.mapHUD.removeChild(map.mapHUD.foodTooltip);
         map.mapHUD.removeChild(map.mapHUD.recruitsTooltip);
         map.mapHUD.saveButton.visible = false;
         map.player.bConsumeFood = false;
         map.mapHUD.unsecuredTileOptions.rescueOption.visible = false;
         map.mapHUD.unsecuredTileOptions.secureOption.visible = false;
         map.mapHUD.unsecuredTileOptions.interceptOption.visible = false;
         map.mapHUD.securedTileOptions.removeChild(map.mapHUD.securedTileOptions.abandonOption);
         map.mapHUD.securedTileOptions.salvageOption.visible = false;
         map.mapHUD.securedTileOptions.interceptOption.visible = false;
         map.mapHUD.timeControlsSprite.visible = false;
         if(map.act is Act1)
         {
            if(map.mapHUD.commandInterfacer.shockCommand.visible)
            {
               map.mapHUD.commandInterfacer.shockCommand.visible = false;
            }
            if(map.mapHUD.commandInterfacer.noxCommand.visible)
            {
               map.mapHUD.commandInterfacer.noxCommand.visible = false;
            }
         }
         map.bgList = new Array("act_2_0","act_2_1");
         popupSprite = new Sprite();
         popupSprite2 = new Sprite();
         popupSprite3 = new Sprite();
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.75;
         exclamImage = new Image(Assets.getAtlas().getTexture("exclam"));
         exclamImage2 = new Image(Assets.getAtlas().getTexture("exclam"));
         exclamImage3 = new Image(Assets.getAtlas().getTexture("exclam"));
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "There you are, Commander! We need to build an army so we can defend against invading alien ships.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "But first things first, we need to scout the permimeter for enemies!";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "By the way, you can skip this tutorial anytime by clicking on the gear icon in the lower right corner.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            map.player.minerals = 100;
            map.targetTiles = new Array(map.tiles[8 + map.mapWidth * 17]);
            popupSprite.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite.y = -250;
            map.mapHUD.optionPaneSprite.addChild(popupSprite);
            blackFilmQuad.x = 290 - GameConfig.GAME_WIDTH;
            blackFilmQuad.y = -100;
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            var _loc1_:TextField = new TextField(200,200,"#1. Click on the tile with the Ü Red Marker.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = 100;
            _loc1_.y = 150;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            exclamImage.x = _loc1_.x - 28;
            exclamImage.y = _loc1_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc5_:TextField = new TextField(300,200,"#2. You have 41 Å Searchpower to use.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc5_.x = map.mapHUD.searchpowerTextField.x + 35;
            _loc5_.y = map.mapHUD.searchpowerTextField.y - 120;
            _loc5_.vAlign = "top";
            _loc5_.hAlign = "left";
            _loc5_.touchable = false;
            _loc5_.autoScale = true;
            popupSprite.addChild(_loc5_);
            var _loc4_:Quad = new Quad(2,90,16777215);
            _loc4_.x = _loc5_.x + 10;
            _loc4_.y = _loc5_.y + 30;
            _loc4_.alpha = 0.25;
            popupSprite.addChild(_loc4_);
            exclamImage2.x = _loc5_.x - 28;
            exclamImage2.y = _loc5_.y - 2;
            popupSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc3_:TextField = new TextField(270,400,"#3. Click æ to spend 3 Å to Scout the Area. You recover Å per Á hour.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = GameConfig.GAME_WIDTH - _loc3_.width - 300 + 10;
            _loc3_.y = _loc5_.y + 50;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            popupSprite.addChild(_loc3_);
            var _loc6_:Quad = new Quad(40,2,16777215);
            _loc6_.x = _loc3_.x + _loc3_.width + 10;
            _loc6_.y = _loc3_.y + 30;
            _loc6_.alpha = 0.25;
            popupSprite.addChild(_loc6_);
            var _loc2_:Quad = new Quad(2,160,16777215);
            _loc2_.x = _loc6_.x + _loc6_.width;
            _loc2_.y = _loc6_.y - _loc2_.height + 1;
            _loc2_.alpha = 0.25;
            popupSprite.addChild(_loc2_);
         };
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 17]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Good job! After you scout a tile, you can see the tiles adjacent to it.";
         sequence.tile = map.tiles[8 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "You can also send multiple Scouting Missions simultaneously if you have enough Å Searchpower.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Let\'s scout more tiles so we can see more of the map.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 15],map.tiles[8 + map.mapWidth * 15],map.tiles[9 + map.mapWidth * 15],map.tiles[7 + map.mapWidth * 16],map.tiles[9 + map.mapWidth * 16],map.tiles[7 + map.mapWidth * 17],map.tiles[9 + map.mapWidth * 17]);
            map.mapHUD.optionPaneSprite.removeChild(popupSprite);
            map.mapHUD.optionPaneSprite.removeChild(blackFilmQuad);
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc1_:TextField = new TextField(150,200,"#1. Start multiple æ Scout Missions at the same time.\n\n#2. Missions in far away tiles need more Á hours to complete.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = 90;
            _loc1_.y = 150;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            exclamImage.x = _loc1_.x - 28;
            exclamImage.y = _loc1_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
         };
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 15]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 15]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 15]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 16]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 16]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 17]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),3,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 17]);
         m.displayLabel = "Scout Nearby Tile.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.onUpdate = function():void
         {
            map.mapHUD.clearTutorialSprite();
         };
         sequence.portrait = null;
         sequence.dialogue = "Now that we\'ve scouted the area, we can see how many Ä enemies there are in each tile.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We can claim this nearby tile by getting rid of the Ä enemies and securing the area.";
         sequence.tile = map.tiles[8 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.mapHUD.unsecuredTileOptions.bEnableSecure = true;
            map.mapHUD.firepowerTextField.visible = true;
            map.mapHUD.addChild(map.mapHUD.firepowerTooltip);
            map.mapHUD.unsecuredTileOptions.secureOption.visible = true;
            map.targetTiles = new Array(map.tiles[8 + map.mapWidth * 17]);
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            popupSprite.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite.y = -250;
            map.mapHUD.optionPaneSprite.addChild(popupSprite);
            blackFilmQuad.x = 290 - GameConfig.GAME_WIDTH;
            blackFilmQuad.y = -100;
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            var _loc2_:TextField = new TextField(200,200,"#1. Click on the tile with the Ü Red Marker.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = 90;
            _loc2_.y = 150;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            map.mapHUD.tutorialSprite.addChild(_loc2_);
            exclamImage.x = _loc2_.x - 28;
            exclamImage.y = _loc2_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc1_:TextField = new TextField(300,200,"#2. You have 41 Æ Firepower to use.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = map.mapHUD.searchpowerTextField.x + 50;
            _loc1_.y = map.mapHUD.firepowerTextField.y - 150;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            popupSprite.addChild(_loc1_);
            var _loc5_:Quad = new Quad(2,120,16777215);
            _loc5_.x = map.mapHUD.firepowerTextField.x + 20 + 10;
            _loc5_.y = _loc1_.y + 30;
            _loc5_.alpha = 0.25;
            popupSprite.addChild(_loc5_);
            exclamImage2.x = _loc1_.x - 28;
            exclamImage2.y = _loc1_.y - 2;
            popupSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc4_:TextField = new TextField(300,200,"#3. The more Ä enemies there are, the more Æ and Á hours you\'ll need to Secure the Area. This tile has Ä 2.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc4_.x = map.mapHUD.firepowerTextField.x + 20 + 50;
            _loc4_.y = _loc1_.y + 50;
            _loc4_.vAlign = "top";
            _loc4_.hAlign = "left";
            _loc4_.touchable = false;
            _loc4_.autoScale = true;
            popupSprite.addChild(_loc4_);
            var _loc6_:Quad = new Quad(10,2,16777215);
            _loc6_.x = _loc4_.x + _loc4_.width + 10;
            _loc6_.y = _loc4_.y + 10;
            _loc6_.alpha = 0.25;
            popupSprite.addChild(_loc6_);
            var _loc3_:Quad = new Quad(2,110,16777215);
            _loc3_.x = _loc6_.x + _loc6_.width;
            _loc3_.y = _loc6_.y - _loc3_.height + 1;
            _loc3_.alpha = 0.25;
            popupSprite.addChild(_loc3_);
         };
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 17]);
         m.displayLabel = "Secure the Area.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Wonderful! Let\'s expand our base even more by securing the other tiles around us.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 15],map.tiles[8 + map.mapWidth * 15],map.tiles[9 + map.mapWidth * 15],map.tiles[7 + map.mapWidth * 16],map.tiles[9 + map.mapWidth * 16],map.tiles[7 + map.mapWidth * 17],map.tiles[9 + map.mapWidth * 17]);
            map.mapHUD.clearTutorialSprite();
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc1_:TextField = new TextField(150,200,"#1. ç Secure more tiles.\n\n#2. You can only secure tiles adjacent to other secured tiles.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = 90;
            _loc1_.y = 150;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            exclamImage.x = _loc1_.x - 28;
            exclamImage.y = _loc1_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
         };
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 15]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[7 + map.mapWidth * 15])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 15]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[8 + map.mapWidth * 15])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 15]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[9 + map.mapWidth * 15])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 16]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[7 + map.mapWidth * 16])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 16]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[9 + map.mapWidth * 16])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 17]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[7 + map.mapWidth * 17])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),1,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 17]);
         m.displayLabel = "Secure Nearby Tile.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            _loc1_ = 0;
            while(_loc1_ < map.targetTiles.length)
            {
               if(map.targetTiles[_loc1_] == map.tiles[9 + map.mapWidth * 17])
               {
                  map.targetTiles[_loc1_] = map.tiles[0];
               }
               _loc1_++;
            }
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Nice going! Now it\'s time to build a Resthouse to house our É Troops.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.mapHUD.mineralTextField.visible = true;
            map.mapHUD.addChild(map.mapHUD.mineralTooltip);
            map.mapHUD.buildOptionList.buildResthouseOption.visible = true;
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.mapHUD.clearTutorialSprite();
            map.mapHUD.techpowerTextField.visible = true;
            map.mapHUD.addChild(map.mapHUD.techpowerTooltip);
            map.targetTiles = new Array(map.tiles[8 + map.mapWidth * 17]);
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            popupSprite.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite.y = -250;
            map.mapHUD.optionPaneSprite.addChild(popupSprite);
            blackFilmQuad.x = 290 - GameConfig.GAME_WIDTH;
            blackFilmQuad.y = -100;
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            var _loc3_:TextField = new TextField(200,200,"#1. Click on the tile with the Ü Red Marker.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 100;
            _loc3_.y = 150;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc10_:TextField = new TextField(400,200,"#2. You have 100 Â Minerals to use.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc10_.x = map.mapHUD.mineralTextField.x + 20;
            _loc10_.y = map.mapHUD.mineralTextField.y + GameConfig.GAME_HEIGHT / 2;
            _loc10_.vAlign = "top";
            _loc10_.hAlign = "left";
            _loc10_.touchable = false;
            _loc10_.autoScale = true;
            popupSprite.addChild(_loc10_);
            var _loc8_:Quad = new Quad(2,GameConfig.GAME_HEIGHT / 2 - 60,16777215);
            _loc8_.x = _loc10_.x + 10;
            _loc8_.y = _loc10_.y - _loc8_.height - 10;
            _loc8_.alpha = 0.25;
            popupSprite.addChild(_loc8_);
            var _loc2_:TextField = new TextField(300,200,"#3. Use Ê Techpower for building.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = map.mapHUD.searchpowerTextField.x + 40;
            _loc2_.y = map.mapHUD.firepowerTextField.y - 130;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            popupSprite.addChild(_loc2_);
            var _loc9_:Quad = new Quad(2,110,16777215);
            _loc9_.x = map.mapHUD.techpowerTextField.x + 20 + 10;
            _loc9_.y = _loc2_.y + 30;
            _loc9_.alpha = 0.25;
            popupSprite.addChild(_loc9_);
            var _loc7_:TextField = new TextField(220,200,"#4. Click ä on the right tab to view your build options.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc7_.x = _loc2_.x;
            _loc7_.y = _loc2_.y + 70;
            _loc7_.vAlign = "top";
            _loc7_.hAlign = "left";
            _loc7_.touchable = false;
            _loc7_.autoScale = true;
            popupSprite.addChild(_loc7_);
            popupSprite2 = new Sprite();
            popupSprite2.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite2.y = -250;
            map.mapHUD.buildOptionList.addChild(popupSprite2);
            var _loc6_:TextField = new TextField(200,200,"#5. Click this to use 50 Â to build a Resthouse.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc6_.x = GameConfig.GAME_WIDTH - _loc6_.width - 70;
            _loc6_.y = _loc2_.y + 80;
            _loc6_.vAlign = "top";
            _loc6_.hAlign = "left";
            _loc6_.touchable = false;
            _loc6_.autoScale = true;
            popupSprite2.addChild(_loc6_);
            exclamImage2.x = _loc6_.x - 28;
            exclamImage2.y = _loc6_.y - 2;
            popupSprite2.addChild(exclamImage2);
            startPulseExclam2();
            var _loc11_:Quad = new Quad(5,2,16777215);
            _loc11_.x = _loc6_.x + _loc6_.width + 5;
            _loc11_.y = _loc6_.y + 10;
            _loc11_.alpha = 0.25;
            popupSprite2.addChild(_loc11_);
            var _loc5_:Quad = new Quad(2,150,16777215);
            _loc5_.x = _loc11_.x + _loc11_.width;
            _loc5_.y = _loc11_.y - _loc5_.height + 1;
            _loc5_.alpha = 0.25;
            popupSprite2.addChild(_loc5_);
            popupSprite3 = new Sprite();
            popupSprite3.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite3.y = -250;
            map.mapHUD.confirmMissionOptionList.addChild(popupSprite3);
            var _loc4_:TextField = new TextField(250,200,"#6. Pick this to use 30 Ê and finish after Á 6 hours.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc4_.x = map.mapHUD.firepowerTextField.x + 200;
            _loc4_.y = _loc2_.y + 80;
            _loc4_.vAlign = "top";
            _loc4_.hAlign = "left";
            _loc4_.touchable = false;
            _loc4_.autoScale = true;
            popupSprite3.addChild(_loc4_);
            exclamImage3.x = _loc4_.x - 28;
            exclamImage3.y = _loc4_.y - 2;
            popupSprite3.addChild(exclamImage3);
            startPulseExclam3();
            var _loc1_:Quad = new Quad(2,140,16777215);
            _loc1_.x = _loc4_.x + 70;
            _loc1_.y = _loc4_.y - _loc1_.height - 10;
            _loc1_.alpha = 0.25;
            popupSprite3.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),6,2,300);
         m.data = "104";
         m.setTargetTile(map.tiles[8 + map.mapWidth * 17]);
         m.displayLabel = "Build a Resthouse.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Good! Now let\'s look for civilians to rescue and recruit!";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.action = 1;
         sequence.tile = map.tiles[12 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = "obj_gram_talking";
         sequence.dialogue = "Mayday, mayday! The enemies have us surrounded! I could really use some help here!";
         sequence.tile = map.tiles[12 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Quick! We need to send a è Rescue Team to help them out!";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            stopPulseExclam3();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.mapHUD.unsecuredTileOptions.rescueOption.visible = true;
            map.mapHUD.miniMap.addChild(map.mapHUD.miniMap.northHotkey);
            map.mapHUD.miniMap.addChild(map.mapHUD.miniMap.eastHotkey);
            map.mapHUD.miniMap.addChild(map.mapHUD.miniMap.westHotkey);
            map.mapHUD.miniMap.addChild(map.mapHUD.miniMap.southHotkey);
            map.mapHUD.clearTutorialSprite();
            map.targetTiles = new Array(map.tiles[12 + map.mapWidth * 17]);
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            while(popupSprite2.numChildren > 0)
            {
               popupSprite2.removeChildAt(0,true);
            }
            while(popupSprite3.numChildren > 0)
            {
               popupSprite3.removeChildAt(0,true);
            }
            popupSprite.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite.y = -250;
            map.mapHUD.optionPaneSprite.addChild(popupSprite);
            blackFilmQuad.x = 290 - GameConfig.GAME_WIDTH;
            blackFilmQuad.y = -100;
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            map.mapHUD.miniMap.cursor.visible = true;
            map.mapHUD.miniMap.bEnableMovement = true;
            var _loc3_:TextField = new TextField(250,400,"#1. Use [W][A][S][D] or click and drag the map to move around.\n\n#2. Look for the Car Wreckage southeast from your base.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = 150;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc2_:TextField = new TextField(270,200,"#3. Spend Æ to rescue new É Recruits. Farther tiles need more Á hours to complete.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = map.mapHUD.firepowerTextField.x + 20 + 50 - 100;
            _loc2_.y = map.mapHUD.firepowerTextField.y - 150 + 50;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            popupSprite.addChild(_loc2_);
            exclamImage2.x = _loc2_.x - 28;
            exclamImage2.y = _loc2_.y - 2;
            popupSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc4_:Quad = new Quad(80,2,16777215);
            _loc4_.x = _loc2_.x + _loc2_.width + 10;
            _loc4_.y = _loc2_.y + 10;
            _loc4_.alpha = 0.25;
            popupSprite.addChild(_loc4_);
            var _loc1_:Quad = new Quad(2,110,16777215);
            _loc1_.x = _loc4_.x + _loc4_.width;
            _loc1_.y = _loc4_.y - _loc1_.height + 1;
            _loc1_.alpha = 0.25;
            popupSprite.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),100,2,300);
         m.checkComplete = function():Boolean
         {
            return map.tiles[12 + map.mapWidth * 17].mission != null;
         };
         m.setTargetTile(map.tiles[12 + map.mapWidth * 17]);
         m.displayLabel = "Rescue Civilians.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            var spendSPText:TextField;
            var lineQuad:Quad;
            stopPulseExclam();
            stopPulseExclam2();
            stopPulseExclam3();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.mapHUD.clearTutorialSprite();
            map.targetTiles = new Array(map.tiles[12 + map.mapWidth * 17]);
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            while(popupSprite2.numChildren > 0)
            {
               popupSprite2.removeChildAt(0,true);
            }
            while(popupSprite3.numChildren > 0)
            {
               popupSprite3.removeChildAt(0,true);
            }
            setTimeout(function():void
            {
               map.timeMultiplier = 0;
               map.bUpdateFPS = true;
            },100);
            map.mapHUD.commandInterfacer.rushCommand.visible = true;
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 15],map.tiles[8 + map.mapWidth * 15],map.tiles[9 + map.mapWidth * 15],map.tiles[7 + map.mapWidth * 16],map.tiles[9 + map.mapWidth * 16],map.tiles[9 + map.mapWidth * 17]);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            spendSPText = new TextField(220,200,"#1. Use [Q] Rush on tile to speed up rescue.",Fonts.getDefaultFont().fontName,18,16777215,true);
            spendSPText.x = map.mapHUD.commandInterfacer.x + map.mapHUD.commandInterfacer.rushCommand.x + 10 + 15;
            spendSPText.y = map.mapHUD.commandInterfacer.y + map.mapHUD.commandInterfacer.rushCommand.y - 100;
            spendSPText.vAlign = "top";
            spendSPText.hAlign = "left";
            spendSPText.touchable = false;
            spendSPText.autoScale = true;
            spendSPText.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(spendSPText);
            exclamImage2.x = spendSPText.x - 28;
            exclamImage2.y = spendSPText.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage2);
            startPulseExclam2();
            lineQuad = new Quad(1,40,16777215);
            lineQuad.x = map.mapHUD.commandInterfacer.x + map.mapHUD.commandInterfacer.rushCommand.x + 10 + 10;
            lineQuad.y = spendSPText.y + 50;
            lineQuad.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(lineQuad);
         };
         m = new MissionObjective(map,getNextMissionID(),100,2,300);
         m.checkComplete = function():Boolean
         {
            return map.tiles[12 + map.mapWidth * 17].mission.rushTimeLeft > 0;
         };
         m.setTargetTile(map.tiles[12 + map.mapWidth * 17]);
         m.displayLabel = "Rush mission.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            map.timeMultiplier = 4;
            map.bUpdateFPS = true;
         };
         m = new MissionObjective(map,getNextMissionID(),4,2,300);
         m.setTargetTile(map.tiles[12 + map.mapWidth * 17]);
         m.displayLabel = "Rescue Civilians.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.onUpdate = function():void
         {
            map.mapHUD.clearTutorialSprite();
         };
         sequence.portrait = "obj_gram_smirk";
         sequence.dialogue = "Thanks for saving me. I\'ll join your army to show you my gratitude!";
         sequence.tile = map.tiles[12 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Wonderful! Each new É Recruit increases your max ÆÊÅ and your recovery rate per hour.";
         sequence.tile = map.tiles[12 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We need to build more Resthouses to house our growing É army! But we need more Â minerals for that.";
         sequence.tile = map.tiles[7 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Looks like the tiles around us have È food and Â minerals we can salvage...";
         sequence.tile = map.tiles[7 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            map.moveToTile(map.tiles[7 + map.mapWidth * 17]);
            map.player.food = 100;
            map.mapHUD.foodTextField.visible = true;
            map.mapHUD.addChild(map.mapHUD.foodTooltip);
            map.mapHUD.securedTileOptions.bEnableSalvage = true;
            map.mapHUD.securedTileOptions.bEnableBuild = false;
            map.mapHUD.securedTileOptions.salvageOption.visible = true;
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 17]);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            blackFilmQuad.x = 290 - GameConfig.GAME_WIDTH;
            blackFilmQuad.y = -100;
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            map.mapHUD.optionPaneSprite.addChild(popupSprite);
            var _loc3_:TextField = new TextField(180,200,"#1. Find and å Salvage the tile with the Ü Red Marker.\n\n#2. You can only salvage È and Â in secured tiles.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = 150;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc2_:TextField = new TextField(250,200,"#3. Use Å to salvage. This tile has È16 and Â25.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = map.mapHUD.firepowerTextField.x - 50;
            _loc2_.y = map.mapHUD.firepowerTextField.y - 100;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            popupSprite.addChild(_loc2_);
            exclamImage2.x = _loc2_.x - 28;
            exclamImage2.y = _loc2_.y - 2;
            popupSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc4_:Quad = new Quad(50,2,16777215);
            _loc4_.x = _loc2_.x + _loc2_.width + 10;
            _loc4_.y = _loc2_.y + 10;
            _loc4_.alpha = 0.25;
            popupSprite.addChild(_loc4_);
            var _loc1_:Quad = new Quad(2,110,16777215);
            _loc1_.x = _loc4_.x + _loc4_.width;
            _loc1_.y = _loc4_.y - _loc1_.height + 1;
            _loc1_.alpha = 0.25;
            popupSprite.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 17]);
         m.displayLabel = "Salvage Resources.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Looks like you\'re getting good at this! Let\'s salvage more resources from the other tiles.";
         sequence.tile = map.tiles[7 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 15],map.tiles[8 + map.mapWidth * 15],map.tiles[9 + map.mapWidth * 15],map.tiles[7 + map.mapWidth * 16],map.tiles[9 + map.mapWidth * 16],map.tiles[9 + map.mapWidth * 17]);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc1_:TextField = new TextField(200,400,"#1. å Salvage more tiles to gain more È and Â resources.\n\n#2. Use [Q] Rush on tiles you are salvaging to speed it up.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = map.mapHUD.mineralTextField.x + 20;
            _loc1_.y = 150;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            _loc1_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            exclamImage.x = _loc1_.x - 28;
            exclamImage.y = _loc1_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
         };
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 15]);
         m.displayLabel = "Salvage Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 15]);
         m.displayLabel = "Salvage Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 15]);
         m.displayLabel = "Salvage Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[7 + map.mapWidth * 16]);
         m.displayLabel = "Salvage Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 16]);
         m.displayLabel = "Salvage Nearby Tile.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),5,2,300);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 17]);
         m.displayLabel = "Salvage Nearby Tile.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Good going! Now that we have more Â, we can build more Resthouses.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.mapHUD.recruitsTextField.visible = true;
            map.mapHUD.securedTileOptions.bEnableBuild = true;
            map.selectTile(null);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 16],map.tiles[7 + map.mapWidth * 17]);
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc3_:TextField = new TextField(400,200,"#1. This is your É army size.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = map.mapHUD.mineralTextField.y + 100;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc1_:Quad = new Quad(2,40,16777215);
            _loc1_.x = map.mapHUD.recruitsTextField.x + 10;
            _loc1_.y = _loc3_.y - 45;
            _loc1_.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            var _loc2_:TextField = new TextField(250,200,"#2. Build 2 Resthouses to increase your max É army size.\n\n#3. More É recruits equals more ÅÆÊ you can use.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = 50;
            _loc2_.y = 150;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            _loc2_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc2_);
         };
         m = new MissionObjective(map,getNextMissionID(),6,2,300);
         m.data = "104";
         m.setTargetTile(map.tiles[7 + map.mapWidth * 16]);
         m.displayLabel = "Build 2nd Resthouse.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),6,2,300);
         m.data = "104";
         m.setTargetTile(map.tiles[7 + map.mapWidth * 17]);
         m.displayLabel = "Build 3rd Resthouse.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Uh-oh! Looks like we lack more Ë Energy to keep our buildings online.";
         sequence.tile = map.tiles[7 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Let\'s build a Generator here, so we can produce more Ë Energy.";
         sequence.tile = map.tiles[7 + map.mapWidth * 15];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.mapHUD.powerTextField.visible = true;
            map.mapHUD.addChild(map.mapHUD.powerTooltip);
            map.mapHUD.buildOptionList.buildGeneratorOption.visible = true;
            map.mapHUD.buildOptionList.bEnableResthouse = false;
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[7 + map.mapWidth * 15]);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc3_:TextField = new TextField(400,200,"#1. Some buildings need Ë energy in order to work.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = map.mapHUD.powerTextField.y + 100;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc1_:Quad = new Quad(2,40,16777215);
            _loc1_.x = map.mapHUD.powerTextField.x + 10;
            _loc1_.y = _loc3_.y - 45;
            _loc1_.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            var _loc2_:TextField = new TextField(250,200,"#2. Build a Generator to increase your max Ë capacity.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = 50;
            _loc2_.y = 150;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            _loc2_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc2_);
         };
         m = new MissionObjective(map,getNextMissionID(),6,2,300);
         m.data = "101";
         m.setTargetTile(map.tiles[7 + map.mapWidth * 15]);
         m.displayLabel = "Build a Generator.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Good! Now we need to build a Hydropod so we can produce È feed our army.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "You can only build Hydropods in green grassy patches like this one.";
         sequence.tile = map.tiles[9 + map.mapWidth * 15];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.player.bConsumeFood = true;
            map.mapHUD.buildOptionList.buildHydropodOption.visible = true;
            map.mapHUD.buildOptionList.bEnableGenerator = false;
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[9 + map.mapWidth * 15]);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc2_:TextField = new TextField(200,200,"#1. É Troopers eat È every day. If you don\'t have food, they\'ll starve to death.\n\n#2. Build a Hydropod on the green grassland tile with the Ü Red Marker.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = 50;
            _loc2_.y = map.mapHUD.foodTextField.y + 100;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            _loc2_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc2_);
            exclamImage.x = _loc2_.x - 28;
            exclamImage.y = _loc2_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc1_:Quad = new Quad(2,40,16777215);
            _loc1_.x = map.mapHUD.foodTextField.x + 10;
            _loc1_.y = _loc2_.y - 45;
            _loc1_.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),6,2,300);
         m.data = "102";
         m.setTargetTile(map.tiles[9 + map.mapWidth * 15]);
         m.displayLabel = "Build a Hydropod.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Crud! Looks like an enemy ship has wandered near our area.";
         sequence.tile = map.tiles[8 + map.mapWidth * 14];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new Mob(map.tiles[8 + map.mapWidth * 14],13);
            _loc1_.cycle = new Array(8,8);
            _loc1_.missionObjID = 101;
            map.addMob(_loc1_);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We need to destroy it before it calls for reinforcements!";
         sequence.tile = map.tiles[8 + map.mapWidth * 14];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = new Array(map.tiles[8 + map.mapWidth * 14]);
            map.mapHUD.unsecuredTileOptions.interceptOption.visible = true;
            map.mapHUD.securedTileOptions.interceptOption.visible = true;
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            var _loc3_:TextField = new TextField(200,400,"#1. Find and click on the enemy ship.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = 150;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            popupSprite.x = 260 - GameConfig.GAME_WIDTH;
            popupSprite.y = -250;
            map.mapHUD.optionPaneSprite.addChild(popupSprite);
            blackFilmQuad.x = 290 - GameConfig.GAME_WIDTH;
            blackFilmQuad.y = -100;
            map.mapHUD.tileInfoSprite.addChildAt(blackFilmQuad,0);
            var _loc2_:TextField = new TextField(250,200,"#2. Use Æ to intercept an enemy. The more Ø health it has, the more Æ and Á hours are needed.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = map.mapHUD.firepowerTextField.x + 20;
            _loc2_.y = map.mapHUD.firepowerTextField.y - 100;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            popupSprite.addChild(_loc2_);
            exclamImage2.x = _loc2_.x - 28;
            exclamImage2.y = _loc2_.y - 2;
            popupSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc4_:Quad = new Quad(5,2,16777215);
            _loc4_.x = _loc2_.x + _loc2_.width + 10;
            _loc4_.y = _loc2_.y + 10;
            _loc4_.alpha = 0.25;
            popupSprite.addChild(_loc4_);
            var _loc1_:Quad = new Quad(2,55,16777215);
            _loc1_.x = _loc4_.x + _loc4_.width;
            _loc1_.y = _loc4_.y - _loc1_.height + 1;
            _loc1_.alpha = 0.25;
            popupSprite.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),2,2,300);
         m.displayLabel = "Destroy Xkrill.";
         m.targetMobID = 101;
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Crud! There\'s more of them down by the southeast! Let\'s blast them out of the sky!";
         sequence.tile = map.tiles[10 + map.mapWidth * 16];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new Mob(map.tiles[10 + map.mapWidth * 15],13);
            _loc1_.cycle = new Array(8,8);
            _loc1_.missionObjID = 102;
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[10 + map.mapWidth * 17],13);
            _loc1_.cycle = new Array(8,8);
            _loc1_.missionObjID = 103;
            map.addMob(_loc1_);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.mapHUD.unsecuredTileOptions.bEnableIntercept = false;
            map.mapHUD.commandInterfacer.blastCommand.visible = true;
            map.mapHUD.commandInterfacer.zapCommand.visible = true;
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            map.targetTiles = null;
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc3_:TextField = new TextField(250,200,"#1. Use [E] Blast to reduce an enemy\'s Ø health.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = map.mapHUD.commandInterfacer.x + map.mapHUD.commandInterfacer.blastCommand.x - 40;
            _loc3_.y = map.mapHUD.commandInterfacer.y + map.mapHUD.commandInterfacer.blastCommand.y - 100;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage2.x = _loc3_.x - 28;
            exclamImage2.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc2_:Quad = new Quad(1,40,16777215);
            _loc2_.x = map.mapHUD.commandInterfacer.x + map.mapHUD.commandInterfacer.blastCommand.x + 10 + 10;
            _loc2_.y = _loc3_.y + 50;
            _loc2_.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(_loc2_);
            var _loc1_:TextField = new TextField(160,200,"#2. Or use [R] Zap to stun them.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = map.mapHUD.commandInterfacer.x + map.mapHUD.commandInterfacer.zapCommand.x + 10;
            _loc1_.y = map.mapHUD.commandInterfacer.y + map.mapHUD.commandInterfacer.zapCommand.y - 50;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            _loc1_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),2,2,300);
         m.displayLabel = "Destroy Xkrill.";
         m.targetMobID = 102;
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),2,2,300);
         m.displayLabel = "Destroy Xkrill.";
         m.targetMobID = 103;
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Now that the enemy knows where we are, we need to build a Watchtower to defend our base.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "But looks like we\'re low on Â minerals. Let\'s secure the tiles around us so we can salvage more resources.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            map.mapHUD.unsecuredTileOptions.bEnableIntercept = true;
            map.mapHUD.commandInterfacer.aidCommand.visible = true;
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc3_:TextField = new TextField(200,200,"#1. æ Scout dark tiles to find ÈÂ. Then, ç Secure and å Salvage them to gain more Â.\n\n#2. You need Â 100.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = map.mapHUD.mineralTextField.y + 100;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc2_:TextField = new TextField(160,200,"#3. Use [F] Aid to get free È & Â.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = map.mapHUD.commandInterfacer.x + map.mapHUD.commandInterfacer.aidCommand.x + 10;
            _loc2_.y = map.mapHUD.commandInterfacer.y + map.mapHUD.commandInterfacer.aidCommand.y - 100;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            _loc2_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc2_);
            exclamImage2.x = _loc2_.x - 28;
            exclamImage2.y = _loc2_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage2);
            startPulseExclam2();
            var _loc1_:Quad = new Quad(1,40,16777215);
            _loc1_.x = _loc2_.x + 10;
            _loc1_.y = _loc2_.y + 50;
            _loc1_.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(_loc1_);
         };
         m = new MissionObjective(map,getNextMissionID(),100,2,300);
         m.bNoShowMarker = true;
         m.checkComplete = function():Boolean
         {
            return map.player.minerals >= 100;
         };
         m.setTargetTile(map.tiles[map.startPoint]);
         m.displayLabel = "Gather 100 Minerals.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Great! We have enough Â minerals now. Let\'s build a Watchtower.";
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.mapHUD.buildOptionList.buildWatchtowerOption.visible = true;
            map.mapHUD.recruitsTextField.visible = true;
            map.mapHUD.addChild(map.mapHUD.recruitsTooltip);
            map.mapHUD.logInterfacer.visible = true;
            map.mapHUD.logButton.visible = true;
            map.selectTile(null);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc1_:TextField = new TextField(250,200,"#1. Build a Watchtower in the Ü Red Marker tile.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc1_.x = 50;
            _loc1_.y = map.mapHUD.mineralTextField.y + 100;
            _loc1_.vAlign = "top";
            _loc1_.hAlign = "left";
            _loc1_.touchable = false;
            _loc1_.autoScale = true;
            _loc1_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc1_);
            exclamImage.x = _loc1_.x - 28;
            exclamImage.y = _loc1_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
         };
         m = new MissionObjective(map,getNextMissionID(),6,2,300);
         m.data = "105";
         m.setTargetTile(map.tiles[9 + map.mapWidth * 14]);
         m.displayLabel = "Build a Watchtower.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Awesome! The Watchtower is complete. Now let\'s find a stable source of Â minerals.";
         sequence.tile = map.tiles[9 + map.mapWidth * 16];
         sequence.onUpdate = function():void
         {
            map.mapHUD.buildOptionList.bEnableResthouse = true;
            map.mapHUD.buildOptionList.bEnableGenerator = true;
            map.unlock(1);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 13]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "This building called an Extractor can generate Â minerals for us. Let\'s secure it.";
         sequence.tile = map.tiles[13 + map.mapWidth * 13];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            map.mapHUD.missionObjectivesInterfacer.visible = true;
            map.mapHUD.addChild(map.mapHUD.quickMissionInterfacer);
            map.unlock(2);
            map.unlock(3);
            map.unlock(4);
            map.unlock(5);
            var _loc1_:Mob = new Mob(map.tiles[12 + map.mapWidth * 13],1);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc3_:TextField = new TextField(200,200,"#1. Click text above to find your main objective.\n\n#2. æ Scout and ç Secure nearby tiles to get near the Extractor.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc3_.x = 50;
            _loc3_.y = map.mapHUD.powerTextField.y + 130;
            _loc3_.vAlign = "top";
            _loc3_.hAlign = "left";
            _loc3_.touchable = false;
            _loc3_.autoScale = true;
            _loc3_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.tutorialSprite.addChild(_loc3_);
            exclamImage.x = _loc3_.x - 28;
            exclamImage.y = _loc3_.y - 2;
            map.mapHUD.tutorialSprite.addChild(exclamImage);
            startPulseExclam();
            var _loc2_:Quad = new Quad(2,30,16777215);
            _loc2_.x = _loc3_.x + 10;
            _loc2_.y = _loc3_.y - 40;
            _loc2_.alpha = 0.25;
            map.mapHUD.tutorialSprite.addChild(_loc2_);
         };
         m = new MissionObjective(map,getNextMissionID(),1,2,210);
         m.setTargetTile(map.tiles[13 + map.mapWidth * 13]);
         m.displayLabel = "Secure the Extractor.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.action = 3;
         sequence.data = "4";
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Good! We can only build Extractors on mineral fields like this one. Let\'s try building another.";
         sequence.tile = map.tiles[14 + map.mapWidth * 14];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         sequence.onUpdate = function():void
         {
            map.mapHUD.buildOptionList.buildExtractorOption.visible = true;
            map.mapHUD.timeControlsSprite.visible = true;
            stopPulseExclam();
            stopPulseExclam2();
            map.selectTile(null);
            if(map.targetTiles != null)
            {
               map.targetTiles.splice(0);
            }
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
         };
         m = new MissionObjective(map,getNextMissionID(),6,2,195);
         m.data = "103";
         m.setTargetTile(map.tiles[14 + map.mapWidth * 14]);
         m.displayLabel = "Build an Extractor.";
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),6,0,255);
         m.data = "103";
         m.bNoShowMarker = true;
         m.setTargetTile(map.tiles[14 + map.mapWidth * 14]);
         m.displayLabel = "Ensure you have enough Ë.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            stopPulseExclam();
            stopPulseExclam2();
            var _loc1_:Mob = new Mob(map.tiles[6 + map.mapWidth * 8],13);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[6 + map.mapWidth * 8],13);
            map.addMob(_loc1_);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 9]);
            map.updateMap();
            popupSprite.removeFromParent();
            blackFilmQuad.removeFromParent();
            map.mapHUD.clearTutorialSprite();
            while(popupSprite.numChildren > 0)
            {
               popupSprite.removeChildAt(0,true);
            }
            var _loc2_:TextField = new TextField(150,200,"#1. Try starting missions using [G] Quick Menu.",Fonts.getDefaultFont().fontName,18,16777215,true);
            _loc2_.x = -_loc2_.width - 10;
            _loc2_.y = 0;
            _loc2_.vAlign = "top";
            _loc2_.hAlign = "left";
            _loc2_.touchable = false;
            _loc2_.autoScale = true;
            _loc2_.filter = BlurFilter.createDropShadow(5,0.785,0,1,1,1);
            map.mapHUD.quickMissionInterfacer.quickOptionPaneSprite.addChild(_loc2_);
            exclamImage.x = _loc2_.x - 28;
            exclamImage.y = _loc2_.y - 2;
            map.mapHUD.quickMissionInterfacer.quickOptionPaneSprite.addChild(exclamImage);
            startPulseExclam();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Uh-oh! I\'m detecting multiple enemy ships coming from the north! Looks like they want the Extractor!";
         sequence.tile = map.tiles[6 + map.mapWidth * 5];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc2_:Array = new Array(13 + map.mapWidth * 13,13 + map.mapWidth * 13,-3);
            var _loc1_:Mob = new Mob(map.tiles[4 + 7 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[5 + 4 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[6 + 4 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + 6 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[5 + 4 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[6 + 4 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + 6 * map.mapWidth],13);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + 5 * map.mapWidth],1);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + 5 * map.mapWidth],1);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + 5 * map.mapWidth],1);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + 5 * map.mapWidth],1);
            _loc1_.waypoints = _loc2_.concat();
            map.addMob(_loc1_);
            map.pauseBGM();
            map.stopBGM();
            map.bgList = new Array("danger");
            map.unpauseBGM();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 16]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),100,2,290);
         m.bNoShowMarker = true;
         m.getDynamicDisplay = function():String
         {
            return "Þ Build Watchtowers for defense.";
         };
         m.checkComplete = function():Boolean
         {
            return map.mobs.length < 1;
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),100,2,220);
         m.bNoShowMarker = true;
         m.getDynamicDisplay = function():String
         {
            return "Ü Destroy all enemies: " + map.mobs.length;
         };
         m.checkComplete = function():Boolean
         {
            return map.mobs.length < 1;
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "You did great, Commander! Victory is ours!";
         sequence.onUpdate = function():void
         {
            map.pauseBGM();
            map.stopBGM();
            map.bgList = new Array("act_2_0","act_2_1");
            map.unpauseBGM();
         };
         sequence.tile = map.tiles[8 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            win("Mission Success!");
         };
         story.push(sequence);
         bFound = false;
         i = 0;
         while(i < map.pgame.unlockedActs.length)
         {
            if(map.pgame.unlockedActs[i] == actNumber + 1)
            {
               bFound = true;
               break;
            }
            i = i + 1;
         }
         if(!bFound)
         {
            map.pgame.unlockedActs.push(actNumber + 1);
         }
         i = 0;
         while(i < achievements.length)
         {
            if(!achievements[i].isUnlocked() && achievements[i].check())
            {
               achievements[i].unlock();
            }
            i = i + 1;
         }
      }
      
      override public function getActTitle() : String
      {
         return "Tutorial Map";
      }
      
      override public function getActDescription() : String
      {
         return "Build your own army from scrap and learn the basic gameplay, all the while saving the planet from hordes of enemy bioships.";
      }
      
      public function win(param1:String) : void
      {
         map.showGameOver(true,param1);
      }
      
      override public function dispose() : void
      {
         stopPulseExclam();
         stopPulseExclam2();
         stopPulseExclam3();
         tween_pulseExclam = null;
         tween_pulseExclam2 = null;
         tween_pulseExclam3 = null;
         exclamImage = null;
         exclamImage2 = null;
         exclamImage3 = null;
         super.dispose();
      }
      
      public function startPulseExclam() : void
      {
         if(tween_pulseExclam != null)
         {
            Starling.juggler.remove(tween_pulseExclam);
         }
         exclamImage.visible = true;
         tween_pulseExclam = new Tween(exclamImage,0.25);
         if(exclamImage.alpha > 0.2)
         {
            tween_pulseExclam.fadeTo(0.2);
            tween_pulseExclam.scaleTo(0.75);
         }
         else
         {
            tween_pulseExclam.fadeTo(0.5);
            tween_pulseExclam.scaleTo(1);
         }
         tween_pulseExclam.onComplete = startPulseExclam;
         Starling.juggler.add(tween_pulseExclam);
      }
      
      public function stopPulseExclam() : void
      {
         if(tween_pulseExclam != null)
         {
            Starling.juggler.remove(tween_pulseExclam);
         }
      }
      
      public function startPulseExclam2() : void
      {
         if(tween_pulseExclam2 != null)
         {
            Starling.juggler.remove(tween_pulseExclam2);
         }
         exclamImage2.visible = true;
         tween_pulseExclam2 = new Tween(exclamImage2,0.25);
         if(exclamImage2.alpha > 0.2)
         {
            tween_pulseExclam2.fadeTo(0.2);
            tween_pulseExclam2.scaleTo(0.75);
         }
         else
         {
            tween_pulseExclam2.fadeTo(0.5);
            tween_pulseExclam2.scaleTo(1);
         }
         tween_pulseExclam2.onComplete = startPulseExclam2;
         Starling.juggler.add(tween_pulseExclam2);
      }
      
      public function stopPulseExclam2() : void
      {
         if(tween_pulseExclam2 != null)
         {
            Starling.juggler.remove(tween_pulseExclam2);
         }
      }
      
      public function startPulseExclam3() : void
      {
         if(tween_pulseExclam3 != null)
         {
            Starling.juggler.remove(tween_pulseExclam3);
         }
         exclamImage3.visible = true;
         tween_pulseExclam3 = new Tween(exclamImage3,0.25);
         if(exclamImage3.alpha > 0.2)
         {
            tween_pulseExclam3.fadeTo(0.2);
            tween_pulseExclam3.scaleTo(0.75);
         }
         else
         {
            tween_pulseExclam3.fadeTo(0.5);
            tween_pulseExclam3.scaleTo(1);
         }
         tween_pulseExclam3.onComplete = startPulseExclam3;
         Starling.juggler.add(tween_pulseExclam3);
      }
      
      public function stopPulseExclam3() : void
      {
         if(tween_pulseExclam3 != null)
         {
            Starling.juggler.remove(tween_pulseExclam3);
         }
      }
      
      override public function getActNumber() : int
      {
         return 1;
      }
      
      override public function initAchievements() : void
      {
         var pgame:PeacefreeGame;
         var ach1:Achievement;
         var bCompleted:Boolean;
         var i:int;
         if(achievements == null)
         {
            achievements = [];
         }
         else
         {
            achievements.splice(0);
         }
         pgame = PeacefreeGame.getInstance();
         ach1 = new Achievement(pgame,101,"Completion Award","Complete Act 1 in any difficulty.",function():Boolean
         {
            return true;
         });
         achievements.push(ach1);
         bCompleted = false;
         i = 0;
         while(i < pgame.unlockedActs.length)
         {
            if(pgame.unlockedActs[i] == getActNumber() + 1)
            {
               bCompleted = true;
               break;
            }
            i = i + 1;
         }
         if(bCompleted && !ach1.isUnlocked())
         {
            ach1.unlock();
         }
      }
   }
}

