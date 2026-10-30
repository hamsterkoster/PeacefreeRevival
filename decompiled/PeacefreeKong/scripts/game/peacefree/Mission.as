package game.peacefree
{
   import starling.core.Starling;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class Mission extends Sprite
   {
      
      public var tile:Tile;
      
      public var type:int;
      
      public var timeLeft:int;
      
      public var rushTimeLeft:int = 0;
      
      public var bStarted:Boolean = false;
      
      public var bComplete:Boolean = false;
      
      protected var updateTimeout:int = 0;
      
      protected var updateCounter:int = 0;
      
      protected var spriteImage:MovieClip;
      
      protected var timeLeftTextField:TextField;
      
      public function Mission(param1:int, param2:Tile)
      {
         super();
         this.type = param1;
         setTile(param2);
         spriteImage = new MovieClip(Assets.getAtlas().getTextures(getTextureName()),4);
         spriteImage.touchable = false;
         spriteImage.alpha = 0.25;
         Starling.juggler.add(spriteImage);
         addChild(spriteImage);
         updateTimeout = 240000 / 24;
         updateCounter = updateTimeout;
         timeLeft = 10;
         timeLeftTextField = new TextField(112,125,"" + timeLeft,Fonts.getDefaultFont().fontName,22,16777215,true);
         timeLeftTextField.x = 1;
         timeLeftTextField.y = 6;
         timeLeftTextField.vAlign = "center";
         timeLeftTextField.hAlign = "center";
         timeLeftTextField.touchable = false;
         timeLeftTextField.autoScale = true;
         addChild(timeLeftTextField);
         updateFPS();
      }
      
      public function getTextureName() : String
      {
         return "mission_build";
      }
      
      public function pause() : void
      {
         spriteImage.pause();
      }
      
      public function resume() : void
      {
         spriteImage.play();
      }
      
      public function start() : void
      {
         tile.setMission(this);
         bStarted = true;
         deductCosts();
      }
      
      public function isRushable() : Boolean
      {
         return true;
      }
      
      public function isRushed() : Boolean
      {
         return rushTimeLeft > 0;
      }
      
      public function complete() : void
      {
         bComplete = true;
         tile.removeMission();
      }
      
      public function cancel() : void
      {
         tile.setMission(null);
      }
      
      public function isComplete() : Boolean
      {
         return bComplete;
      }
      
      public function deductCosts() : void
      {
      }
      
      public function update() : void
      {
         timeLeft = timeLeft - 1;
         if(timeLeft <= 0)
         {
            complete();
            removeFromParent(true);
            return;
         }
         timeLeftTextField.text = "" + timeLeft;
      }
      
      public function setTile(param1:Tile) : void
      {
         this.tile = param1;
      }
      
      public function updateFPS() : void
      {
         if(tile.map.timeMultiplier == 0)
         {
            spriteImage.pause();
         }
         else
         {
            if(!spriteImage.isPlaying)
            {
               spriteImage.play();
            }
            switch(tile.map.timeMultiplier - 1)
            {
               case 0:
                  if(isRushed())
                  {
                     spriteImage.fps = 20;
                  }
                  else
                  {
                     spriteImage.fps = 10;
                  }
                  break;
               case 3:
                  if(isRushed())
                  {
                     spriteImage.fps = 40;
                  }
                  else
                  {
                     spriteImage.fps = 20;
                  }
                  break;
               case 7:
                  if(isRushed())
                  {
                     spriteImage.fps = 80;
                     break;
                  }
                  spriteImage.fps = 40;
            }
         }
      }
      
      public function rush(param1:int) : void
      {
         rushTimeLeft = param1;
         timeLeftTextField.color = 41727;
         updateFPS();
      }
      
      public function recompute() : void
      {
      }
      
      public function progress(param1:int) : void
      {
         var _loc2_:int = 0;
         if(rushTimeLeft > 0)
         {
            _loc2_ = Math.min(rushTimeLeft,param1);
            param1 = param1 - _loc2_ + _loc2_ * 2;
            rushTimeLeft -= _loc2_;
            if(rushTimeLeft <= 0)
            {
               timeLeftTextField.color = 16777215;
               updateFPS();
            }
         }
         updateCounter -= param1;
         if(updateCounter < 1)
         {
            try
            {
               update();
            }
            catch(error:Error)
            {
            }
            updateCounter += updateTimeout;
         }
      }
      
      public function getMissionTitle() : String
      {
         return "";
      }
      
      public function getMissionDescription() : String
      {
         return "";
      }
      
      public function getCounter() : String
      {
         return "0";
      }
      
      public function setCounter(param1:String) : void
      {
      }
      
      public function getData() : String
      {
         var _loc1_:String = "" + type;
         _loc1_ += ":" + tile.mapX;
         _loc1_ += ":" + tile.mapY;
         _loc1_ += ":" + getCounter();
         _loc1_ += ":" + rushTimeLeft;
         return _loc1_ + (":" + timeLeft);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(spriteImage != null)
         {
            Starling.juggler.remove(spriteImage);
         }
         spriteImage = null;
         timeLeftTextField = null;
         super.dispose();
      }
   }
}

