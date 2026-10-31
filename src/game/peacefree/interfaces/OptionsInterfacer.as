package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.library.SoundLibrary;
   import game.peacefree.CampaignSelectorScreen;
   import game.peacefree.PeacefreeGame;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.text.TextField;

   public class OptionsInterfacer extends Sprite
   {

      private var pgame:PeacefreeGame;

      private var diffValueLabel:TextField;

      // PeacefreeRevival: the volume sliders replace the rows' ON/OFF buttons (to-do 6): a bar
      // SLIDER_WIDTH wide, 0-100% in VOLUME_STEP steps.
      private static const SLIDER_WIDTH:int = 200;

      private static const KNOB_WIDTH:int = 14;

      private static const VOLUME_STEP:int = 5;

      private var musicSlider:Sprite;

      private var sfxSlider:Sprite;

      // PeacefreeRevival: skips to the mission's next song (to-do 7).
      private var nextButton:GenericScreenButton;

      // PeacefreeRevival: the campaign's acts are 1 to LAST_ACT; act 1 is always open.
      private static const LAST_ACT:int = 11;

      private var unlockActsButton:GenericScreenButton;

      // PeacefreeRevival: null in a mission (Map makes the panel with pgame only). Outside a
      // mission (title and campaign screens) the screen's function that updates its sound icons
      // and music after a change; it also marks the panel as outside a mission (inMission), which
      // hides the mission-only rows. Not pgame.map != null: the title screen puts its background
      // demo map there.
      private var onSoundChange:Function;

      public function OptionsInterfacer(param1:PeacefreeGame, param2:Function = null)
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
         this.onSoundChange = param2;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         // PeacefreeRevival: dragging a muted slider unmutes it, as the row's ON button did.
         musicSlider = makeSlider(GameConfig.GAME_HEIGHT / 2 - 200,function(param1:int):void
         {
            SoundLibrary.setMusicVolume(param1);
            if(!isMusicOn())
            {
               pgame.bEnabledBGM = true;
               if(onSoundChange != null)
               {
                  onSoundChange();
               }
               else if(pgame.map != null)
               {
                  pgame.map.setEnableBGM(true);
                  pgame.map.mapHUD.toggleBGM(false);
               }
            }
            refresh();
         });
         bgmLabel = new TextField(200,40,"Music Volume",Fonts.getDefaultFont().fontName,24,16777215,true);
         bgmLabel.x = musicSlider.x - 225;
         bgmLabel.y = musicSlider.y;
         bgmLabel.vAlign = "center";
         bgmLabel.hAlign = "right";
         bgmLabel.touchable = false;
         bgmLabel.autoScale = true;
         addChild(bgmLabel);
         // PeacefreeRevival: Next, right of the music readout: missions only (the menus have one
         // song); dimmed and doing nothing while the music is muted (refresh).
         nextButton = new GenericScreenButton(70,40,"Next",20);
         nextButton.bChangeAlpha = false;
         nextButton.x = musicSlider.x + SLIDER_WIDTH + 100;
         nextButton.y = musicSlider.y;
         nextButton.pressedCallback = function():void
         {
            if(isMusicOn())
            {
               pgame.map.nextBGM();
            }
         };
         nextButton.visible = inMission();
         addChild(nextButton);
         // PeacefreeRevival: letting go plays a click at the new volume: outside a mission no
         // other sound effect plays to hear it by.
         sfxSlider = makeSlider(GameConfig.GAME_HEIGHT / 2 - 140,function(param1:int):void
         {
            SoundLibrary.setSFXVolume(param1);
            if(!SoundLibrary.ENABLE_SFX)
            {
               SoundLibrary.ENABLE_SFX = true;
               if(onSoundChange != null)
               {
                  onSoundChange();
               }
               else if(pgame.map != null)
               {
                  pgame.map.mapHUD.toggleSFX(false);
               }
            }
            refresh();
         },function():void
         {
            SoundLibrary.playSFX("click");
         });
         sfxLabel = new TextField(200,40,"SFX Volume",Fonts.getDefaultFont().fontName,24,16777215,true);
         sfxLabel.x = sfxSlider.x - 225;
         sfxLabel.y = sfxSlider.y;
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
            close();
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
            close();
         };
         addChild(resumeButton);
         // PeacefreeRevival: outside a mission there's no difficulty to show and no game to exit;
         // Back moves up into the space they leave.
         if(!inMission())
         {
            diffValueLabel.visible = false;
            diffLabel.visible = false;
            quitGameButton.visible = false;
            resumeButton.textField.text = "Back";
            resumeButton.y = GameConfig.GAME_HEIGHT / 2 - 40;
         }
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
         // PeacefreeRevival: the campaign screen decides which act buttons show when it's made,
         // so it's made again (the game's own fade) to show the new acts.
         if(parent is CampaignSelectorScreen)
         {
            pgame.goToCampaignScreen();
         }
      }
      
      // PeacefreeRevival: Map makes the panel without a callback; the screens outside a mission
      // pass one (onSoundChange).
      private function inMission() : Boolean
      {
         return onSoundChange == null;
      }

      // PeacefreeRevival: in a mission the map's copy of the music setting, as before.
      private function isMusicOn() : Boolean
      {
         return inMission() ? pgame.map.bEnableBGM : pgame.bEnabledBGM;
      }

      // PeacefreeRevival: a volume slider in the row at y = param1, added to the panel (Starling
      // 1.4.1 has none, and build.py can't add a class): a bar, its fill, a knob and a readout.
      // Pressing or dragging calls param2 with the volume under the pointer; letting go saves
      // both volumes and calls param3. The pointer may leave the bar while dragging: Starling
      // keeps sending that touch to the slider.
      private function makeSlider(param1:Number, param2:Function, param3:Function = null) : Sprite
      {
         var slider:Sprite = new Sprite();
         var hitQuad:Quad;
         var barQuad:Quad;
         var fillQuad:Quad;
         var knobQuad:Quad;
         var readout:TextField;
         var onRelease:Function = param3;
         var onDrag:Function = param2;
         slider.x = GameConfig.GAME_WIDTH / 2 - 40;
         slider.y = param1;
         hitQuad = new Quad(SLIDER_WIDTH + KNOB_WIDTH,40,0);
         hitQuad.x = -KNOB_WIDTH / 2;
         hitQuad.alpha = 0;
         slider.addChild(hitQuad);
         barQuad = new Quad(SLIDER_WIDTH,8,6710886);
         barQuad.y = 16;
         barQuad.touchable = false;
         slider.addChild(barQuad);
         fillQuad = new Quad(SLIDER_WIDTH,8,15569185);
         fillQuad.y = 16;
         fillQuad.name = "fill";
         fillQuad.touchable = false;
         slider.addChild(fillQuad);
         knobQuad = new Quad(KNOB_WIDTH,30,16777215);
         knobQuad.y = 5;
         knobQuad.name = "knob";
         knobQuad.touchable = false;
         slider.addChild(knobQuad);
         readout = new TextField(80,40,"",Fonts.getDefaultFont().fontName,24,16777215,true);
         readout.x = SLIDER_WIDTH + 20;
         readout.name = "readout";
         readout.vAlign = "center";
         readout.hAlign = "left";
         readout.touchable = false;
         slider.addChild(readout);
         slider.addEventListener("touch",function(param1:TouchEvent):void
         {
            var _loc2_:Touch = param1.getTouch(slider);
            if(_loc2_ == null || _loc2_.phase == "hover" || _loc2_.phase == "stationary")
            {
               return;
            }
            onDrag(volumeAt(_loc2_.getLocation(slider).x));
            if(_loc2_.phase == "ended")
            {
               SoundLibrary.saveVolumes();
               if(onRelease != null)
               {
                  onRelease();
               }
            }
         });
         addChild(slider);
         return slider;
      }

      // PeacefreeRevival: the volume at x on a slider, rounded to VOLUME_STEP, 0 to 100.
      private static function volumeAt(param1:Number) : int
      {
         var _loc2_:Number = Math.max(0,Math.min(1,param1 / SLIDER_WIDTH));
         return Math.round(_loc2_ * 100 / VOLUME_STEP) * VOLUME_STEP;
      }

      // PeacefreeRevival: shows volume param2 on slider param1; a muted one (param3 false) is
      // dimmed and says "Off".
      private static function showSlider(param1:Sprite, param2:int, param3:Boolean) : void
      {
         var _loc4_:DisplayObject = param1.getChildByName("fill");
         var _loc5_:DisplayObject = param1.getChildByName("knob");
         _loc4_.scaleX = param2 / 100;
         _loc5_.x = SLIDER_WIDTH * param2 / 100 - KNOB_WIDTH / 2;
         _loc4_.alpha = param3 ? 1 : 0.35;
         _loc5_.alpha = _loc4_.alpha;
         TextField(param1.getChildByName("readout")).text = param3 ? param2 + "%" : "Off";
      }

      // PeacefreeRevival: shows the panel on a screen outside a mission (title, campaign),
      // fading in like the mission's.
      public function showOn(param1:Sprite) : void
      {
         refresh();
         alpha = 0;
         param1.addChild(this);
         Starling.juggler.removeTweens(this);
         Starling.juggler.tween(this,0.5,{"alpha":1});
      }

      // PeacefreeRevival: X and Back. In a mission the map hides the panel, as before;
      // elsewhere it fades out and leaves the screen, which keeps it for the next time.
      private function close() : void
      {
         // PeacefreeRevival: the sliders save when let go; this also covers a drag that never
         // ended on the slider.
         SoundLibrary.saveVolumes();
         if(inMission())
         {
            pgame.map.hideOptionsInterface();
            return;
         }
         Starling.juggler.removeTweens(this);
         Starling.juggler.tween(this,0.5,{
            "alpha":0,
            "onComplete":function():void
            {
               removeFromParent();
            }
         });
      }

      public function refresh() : void
      {
         // PeacefreeRevival: the button is dimmed once every act is open.
         if(allActsUnlocked())
         {
            unlockActsButton.textField.text = "All Acts Unlocked";
            unlockActsButton.alpha = 0.25;
         }
         // PeacefreeRevival: the difficulty only in a mission; outside one, pgame.map is null or
         // the title's demo map.
         if(inMission())
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
         }
         showSlider(musicSlider,SoundLibrary.getMusicVolume(),isMusicOn());
         showSlider(sfxSlider,SoundLibrary.getSFXVolume(),SoundLibrary.ENABLE_SFX);
         nextButton.alpha = isMusicOn() ? 1 : 0.35;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         pgame = null;
         diffValueLabel = null;
         musicSlider = null;
         sfxSlider = null;
         nextButton = null;
         unlockActsButton = null;
         onSoundChange = null;
         super.dispose();
      }
   }
}

