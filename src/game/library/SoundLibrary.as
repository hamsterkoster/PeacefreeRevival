package game.library
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import game.container.GameConfig;
   
   public class SoundLibrary extends EventDispatcher
   {
      
      public static var ENABLE_SFX:Boolean = true;
      
      public static var TOTAL_PLAYING_SFX:int = 0;
      
      private static const DEBUG_MODE:Boolean = false;
      
      private static const EVENT_UPDATE:String = "SoundLoadUpdate";
      
      private static const EVENT_ERROR:String = "SoundLoadError";
      
      private static var INSTANCE:SoundLibrary;

      // PeacefreeRevival: music and SFX volume in % (0-100), from the settings save; music
      // starts at the game's own 35%, SFX at full volume.
      private static var musicVolume:int = savedVolume("music",35);

      private static var sfxVolume:int = savedVolume("sfx",100);

      public static var BGM_VOLUME:SoundTransform = new SoundTransform(musicVolume / 100);

      public static var SFX_VOLUME:SoundTransform = new SoundTransform(sfxVolume / 100);
      
      private var cache:Dictionary = new Dictionary();
      
      private var links:Dictionary = new Dictionary();
      
      private var onComplete:Function;
      
      private var onUpdate:Function;
      
      private var onError:Function;
      
      private var numOfResources:int;
      
      private var numOfResourcesLoaded:int;
      
      private var host:String = null;
      
      private var parsedData:Array = null;
      
      private var currentBGMChannel:SoundChannel = null;

      // PeacefreeRevival: the song in currentBGMChannel, or the one pauseBGM stopped, and the
      // function its playBGM call gave for when it ends (to-do 7).
      private var currentBGM:String = null;

      private var currentBGMEnd:Function = null;

      // PeacefreeRevival: where pauseBGM stopped currentBGM, in ms; -1 when no song is paused.
      private var pausedPosition:Number = -1;

      private var bBuffering:Boolean = false;
      
      private var delayed:Array = [];
      
      public function SoundLibrary()
      {
         super();
      }
      
      public static function setInstance(param1:SoundLibrary) : void
      {
         INSTANCE = param1;
      }
      
      public static function getInstance() : SoundLibrary
      {
         if(INSTANCE == null)
         {
            INSTANCE = new SoundLibrary();
         }
         return INSTANCE;
      }
      
      public static function getBGMVolume() : SoundTransform
      {
         return BGM_VOLUME;
      }
      
      // PeacefreeRevival: stops for good: also forgets a paused song.
      public static function stopBGM() : void
      {
         if(INSTANCE == null)
         {
            return;
         }
         if(INSTANCE.currentBGMChannel != null)
         {
            INSTANCE.currentBGMChannel.stop();
         }
         INSTANCE.currentBGMChannel = null;
         INSTANCE.currentBGM = null;
         INSTANCE.currentBGMEnd = null;
         INSTANCE.pausedPosition = -1;
      }

      // PeacefreeRevival: mute (to-do 7). Stops the song but remembers it and where it was, for
      // resumeBGM; with nothing playing (or already paused) nothing changes.
      public static function pauseBGM() : void
      {
         if(INSTANCE == null || INSTANCE.currentBGMChannel == null)
         {
            return;
         }
         INSTANCE.pausedPosition = INSTANCE.currentBGMChannel.position;
         INSTANCE.currentBGMChannel.stop();
         INSTANCE.currentBGMChannel = null;
      }

      // PeacefreeRevival: unmute (to-do 7). Continues the paused song from where it was, at the
      // current volume; paused at its very end, what its end does instead (the next song). False
      // when no song is paused.
      public static function resumeBGM() : Boolean
      {
         var _loc1_:Sound = null;
         var _loc2_:Number = NaN;
         if(INSTANCE == null || INSTANCE.pausedPosition < 0)
         {
            return false;
         }
         _loc1_ = INSTANCE.retrieve(INSTANCE.currentBGM);
         _loc2_ = INSTANCE.pausedPosition;
         INSTANCE.pausedPosition = -1;
         if(_loc1_ == null)
         {
            return false;
         }
         if(_loc2_ >= _loc1_.length)
         {
            INSTANCE.currentBGMEnd();
            return true;
         }
         startBGM(_loc1_,_loc2_);
         return true;
      }

      // PeacefreeRevival: a paused song counts as playing, so the callers that start music when
      // none plays (PeacefreeGame.playBGM, Map.playBGM) don't call playBGM, which would forget
      // it. The title's background demo map calls it every frame while nothing plays (for
      // "act_1", a song the game doesn't have, so it plays nothing).
      public static function isBGMPlaying() : Boolean
      {
         if(INSTANCE == null)
         {
            return false;
         }
         return INSTANCE.isBuffering() || INSTANCE.currentBGMChannel != null || INSTANCE.pausedPosition >= 0;
      }

      public static function playBGM(param1:String, param2:Function, param3:Boolean = true) : void
      {
         var sound:Sound;
         var soundID:String = param1;
         var onPlayEnd:Function = param2;
         var bBuffer:Boolean = param3;
         // PeacefreeRevival: a new song replaces a paused one.
         INSTANCE.pausedPosition = -1;
         if(INSTANCE.currentBGMChannel != null)
         {
            INSTANCE.currentBGMChannel.stop();
         }
         sound = SoundLibrary.getInstance().retrieve(soundID);
         if(sound == null)
         {
            if(bBuffer && INSTANCE.links[soundID] != null)
            {
               INSTANCE.bBuffering = true;
               INSTANCE.addSound(soundID,INSTANCE.links[soundID],function():void
               {
                  INSTANCE.bBuffering = false;
                  playBGM(soundID,onPlayEnd);
               });
            }
            return;
         }
         INSTANCE.currentBGM = soundID;
         INSTANCE.currentBGMEnd = onPlayEnd;
         startBGM(sound,0);
      }

      // PeacefreeRevival: plays currentBGM's sound param1 from param2 ms (0 for a new song, more
      // when resumed); at its end, its playBGM call's function. Moved out of playBGM. Flash gives
      // no channel when none is free; then nothing plays, as if the song had stopped.
      private static function startBGM(param1:Sound, param2:Number) : void
      {
         var onPlayEnd:Function = INSTANCE.currentBGMEnd;
         INSTANCE.currentBGMChannel = param1.play(param2);
         if(INSTANCE.currentBGMChannel == null)
         {
            return;
         }
         INSTANCE.currentBGMChannel.soundTransform = SoundLibrary.getBGMVolume();
         INSTANCE.currentBGMChannel.addEventListener("soundComplete",function():void
         {
            INSTANCE.currentBGMChannel = null;
            onPlayEnd();
         });
      }
      
      public static function playSFX(param1:String, param2:Boolean = true) : void
      {
         var sound:Sound;
         var soundChannel:SoundChannel;
         var soundID:String = param1;
         var bBuffer:Boolean = param2;
         // PeacefreeRevival: at 0% nothing plays, as when muted, instead of filling the 16 slots
         // with silent sounds.
         if(ENABLE_SFX && sfxVolume > 0 && TOTAL_PLAYING_SFX < 16)
         {
            sound = SoundLibrary.getInstance().retrieve(soundID);
            if(sound == null)
            {
               if(bBuffer && INSTANCE.links[soundID] != null)
               {
                  INSTANCE.addSound(soundID,INSTANCE.links[soundID],function():void
                  {
                     playSFX(soundID);
                  });
               }
               return;
            }
            soundChannel = sound.play(0,0,SFX_VOLUME);
            soundChannel.addEventListener("soundComplete",function():void
            {
               SoundLibrary.TOTAL_PLAYING_SFX--;
            });
            SoundLibrary.TOTAL_PLAYING_SFX++;
         }
      }
      
      public static function setEnableSFX(param1:Boolean) : void
      {
         ENABLE_SFX = param1;
      }

      public static function getMusicVolume() : int
      {
         return musicVolume;
      }

      // PeacefreeRevival: also changes the music that's playing; a channel keeps a copy of the
      // SoundTransform it was given, not the object.
      public static function setMusicVolume(param1:int) : void
      {
         musicVolume = param1;
         BGM_VOLUME = new SoundTransform(param1 / 100);
         if(INSTANCE != null && INSTANCE.currentBGMChannel != null)
         {
            INSTANCE.currentBGMChannel.soundTransform = BGM_VOLUME;
         }
      }

      public static function getSFXVolume() : int
      {
         return sfxVolume;
      }

      public static function setSFXVolume(param1:int) : void
      {
         sfxVolume = param1;
         SFX_VOLUME = new SoundTransform(param1 / 100);
      }

      // PeacefreeRevival: both volumes in their own save, shared by all builds like the game's
      // (FileLibrary); the mute flags stay in the game's save.
      public static function saveVolumes() : void
      {
         FileLibrary.saveData("settings",{
            "music":musicVolume,
            "sfx":sfxVolume
         });
      }

      // PeacefreeRevival: a volume from the settings save, or param2 when it's missing or not 0-100.
      private static function savedVolume(param1:String, param2:int) : int
      {
         var _loc3_:* = FileLibrary.getData("settings")[param1];
         if(_loc3_ is Number && _loc3_ >= 0 && _loc3_ <= 100)
         {
            return int(_loc3_);
         }
         return param2;
      }
      
      public function loadLibrary(param1:String, param2:Function, param3:Function = null, param4:Function = null, param5:String = null) : void
      {
         var loader:URLLoader;
         var url:String = param1;
         var onComplete:Function = param2;
         var onUpdate:Function = param3;
         var onError:Function = param4;
         var host:String = param5;
         this.onComplete = onComplete;
         this.onUpdate = onUpdate;
         this.onError = onError;
         this.addEventListener("SoundLoadUpdate",update);
         if(host == null)
         {
            host = GameConfig.GAME_HOST;
         }
         this.host = host;
         loader = new URLLoader();
         loader.addEventListener("complete",loadSounds);
         loader.addEventListener("ioError",function(param1:Event):void
         {
            onComplete();
         });
         loader.load(new URLRequest(host + url));
         if(INSTANCE == null)
         {
            INSTANCE = this;
         }
      }
      
      private function update(param1:Event = null) : void
      {
         numOfResourcesLoaded = numOfResourcesLoaded + 1;
         if(onUpdate != null)
         {
            onUpdate(100 * numOfResourcesLoaded / numOfResources);
         }
         if(numOfResourcesLoaded == numOfResources)
         {
            removeEventListener("SoundLoadUpdate",update);
            onComplete();
            loadNextDelayed();
         }
         else
         {
            loadNextSound();
         }
      }
      
      private function loadNextDelayed(param1:Event = null) : void
      {
         var _loc2_:Array = null;
         if(delayed.length > 0)
         {
            _loc2_ = delayed.pop();
            addSound(StringUtils.trim(_loc2_[0]),StringUtils.trim(_loc2_[1]),loadNextDelayed);
         }
      }
      
      private function loadSounds(param1:Event) : void
      {
         parsedData = param1.target.data.split("\n");
         numOfResources = parsedData.length;
         numOfResourcesLoaded = 0;
         loadNextSound();
      }
      
      private function loadNextSound() : void
      {
         var _loc1_:Array = null;
         if(numOfResourcesLoaded < numOfResources)
         {
            _loc1_ = parsedData[numOfResourcesLoaded].split(";");
            if(_loc1_[2] != undefined)
            {
               if(parseInt(_loc1_[2]) == 1)
               {
                  if(links[StringUtils.trim(_loc1_[0])] == null)
                  {
                     links[StringUtils.trim(_loc1_[0])] = this.host + StringUtils.trim(_loc1_[1]);
                  }
               }
               else
               {
                  _loc1_[1] = this.host + StringUtils.trim(_loc1_[1]);
                  delayed.push(_loc1_);
               }
               update();
            }
            else
            {
               addSound(StringUtils.trim(_loc1_[0]),this.host + StringUtils.trim(_loc1_[1]));
            }
         }
      }
      
      public function addSound(param1:String, param2:String, param3:Function = null) : void
      {
         var onFinish:Function;
         var sound:Sound;
         var key:String = param1;
         var url:String = param2;
         var callback:Function = param3;
         if(cache[key] != null)
         {
            dispatchEvent(new Event("SoundLoadUpdate"));
            if(callback != null)
            {
               callback();
            }
            return;
         }
         onFinish = null;
         if(callback == null)
         {
            onFinish = function(param1:Event):void
            {
               cache[key] = sound;
               dispatchEvent(new Event("SoundLoadUpdate"));
            };
         }
         else
         {
            onFinish = function(param1:Event):void
            {
               cache[key] = sound;
               callback();
            };
         }
         sound = new Sound();
         sound.addEventListener("complete",onFinish);
         sound.addEventListener("ioError",function(param1:Event):void
         {
            delete cache[key];
            dispatchEvent(new Event("SoundLoadUpdate"));
            if(onError != null)
            {
               onError("Failed to load sound: " + key);
            }
            param1.stopPropagation();
         });
         sound.load(new URLRequest(url));
      }
      
      public function retrieve(param1:String) : Sound
      {
         return cache[param1];
      }
      
      public function save(param1:String, param2:Sound) : void
      {
         cache[param1] = param2;
      }
      
      public function clearCache() : void
      {
         cache = new Dictionary();
         links = new Dictionary();
      }
      
      public function isBuffering() : Boolean
      {
         return bBuffering;
      }
   }
}

