package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.interfaces.clickables.HiddenClickable;
   import game.peacefree.Map;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.TouchEvent;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class DialogueInterfacer extends HiddenClickable
   {
      
      private var blackQuadTop:Quad;
      
      private var blackQuadBot:Quad;
      
      private var popupSprite:Sprite;
      
      private var portrait:Image;
      
      private var portraitText:TextField;
      
      private var nextTextField:TextField;
      
      private var tween_popupSprite:Tween;
      
      private var tween_blackQuadBot:Tween;
      
      private var tween_mapHUD:Tween;
      
      private var tween_blackQuadTop:Tween;
      
      private var bExited:Boolean = true;
      
      public var map:Map;
      
      public var bCanClickNow:Boolean = true;
      
      public function DialogueInterfacer(param1:Map)
      {
         super(Texture.fromColor(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0));
         pressedCallback = onPressed;
         this.map = param1;
         blackQuadTop = new Quad(GameConfig.GAME_WIDTH,100,0);
         blackQuadTop.x = 0;
         blackQuadTop.y = -100;
         addChild(blackQuadTop);
         blackQuadBot = new Quad(GameConfig.GAME_WIDTH,120,0);
         blackQuadBot.x = 0;
         blackQuadBot.y = GameConfig.GAME_HEIGHT;
         addChild(blackQuadBot);
         popupSprite = new Sprite();
         popupSprite.alpha = 0;
         addChild(popupSprite);
         var _loc3_:Quad = new Quad(GameConfig.GAME_WIDTH / 2 + 150,120,3355443);
         _loc3_.x = 50;
         _loc3_.y = GameConfig.GAME_HEIGHT - 125;
         _loc3_.alpha = 0.5;
         popupSprite.addChild(_loc3_);
         var _loc2_:Quad = new Quad(GameConfig.GAME_WIDTH / 2 + 140,110,136726);
         _loc2_.x = 55;
         _loc2_.y = GameConfig.GAME_HEIGHT - 120;
         _loc2_.alpha = 0.85;
         popupSprite.addChild(_loc2_);
         portrait = new Image(Assets.getAtlas().getTexture("obj_lineus_hand_out"));
         portrait.scaleX = 3;
         portrait.scaleY = 3;
         portrait.x = 55;
         portrait.y = GameConfig.GAME_HEIGHT - 5 - portrait.height;
         popupSprite.addChild(portrait);
         portraitText = new TextField(GameConfig.GAME_WIDTH / 2 - 50,90,"Taltana City\'s under attack!\nWe need an army so we can fight back!",Fonts.getDefaultFont().fontName,22,16777215,true);
         portraitText.x = 240;
         portraitText.y = GameConfig.GAME_HEIGHT - 115;
         portraitText.vAlign = "top";
         portraitText.hAlign = "left";
         portraitText.touchable = false;
         portraitText.autoScale = true;
         popupSprite.addChild(portraitText);
         nextTextField = new TextField(GameConfig.GAME_WIDTH / 2 - 55,80,"Click Anywhere to Continue",Fonts.getDefaultFont().fontName,20,4293759265,true);
         nextTextField.x = 240;
         nextTextField.y = GameConfig.GAME_HEIGHT - 35;
         nextTextField.vAlign = "top";
         nextTextField.hAlign = "right";
         nextTextField.touchable = false;
         nextTextField.autoScale = true;
         popupSprite.addChild(nextTextField);
      }
      
      public function onPressed(param1:TouchEvent) : void
      {
         if(bCanClickNow)
         {
            map.next();
         }
      }
      
      public function show(param1:String, param2:String = "obj_lineus_hand_out") : void
      {
         var text:String = param1;
         var portraitSprite:String = param2;
         if(portraitSprite == null)
         {
            portraitSprite = "obj_lineus_hand_out";
         }
         if(tween_popupSprite != null)
         {
            Starling.juggler.remove(tween_popupSprite);
         }
         if(tween_mapHUD != null)
         {
            Starling.juggler.remove(tween_mapHUD);
         }
         if(tween_blackQuadBot != null)
         {
            Starling.juggler.remove(tween_blackQuadBot);
         }
         bCanClickNow = false;
         if(bExited)
         {
            map.addChild(this);
            bExited = false;
            tween_mapHUD = new Tween(map.mapHUD,0.5);
            tween_mapHUD.fadeTo(0);
            Starling.juggler.add(tween_mapHUD);
            tween_blackQuadTop = new Tween(blackQuadTop,0.5);
            tween_blackQuadTop.moveTo(0,0);
            Starling.juggler.add(tween_blackQuadTop);
            tween_blackQuadBot = new Tween(blackQuadBot,0.5);
            tween_blackQuadBot.moveTo(0,GameConfig.GAME_HEIGHT - 120);
            tween_blackQuadBot.onComplete = function():void
            {
               setDialogue(text,portraitSprite);
               map.mapHUD.pause();
            };
            Starling.juggler.add(tween_blackQuadBot);
         }
         else
         {
            setDialogue(text,portraitSprite);
         }
      }
      
      public function hide() : void
      {
         if(tween_blackQuadBot != null)
         {
            Starling.juggler.remove(tween_blackQuadBot);
         }
         if(bExited)
         {
            map.mapHUD.unpause();
            removeFromParent();
            return;
         }
         bExited = true;
         bCanClickNow = false;
         tween_popupSprite = new Tween(popupSprite,0.5);
         tween_popupSprite.fadeTo(0);
         Starling.juggler.add(tween_popupSprite);
         tween_mapHUD = new Tween(map.mapHUD,0.5);
         tween_mapHUD.fadeTo(1);
         Starling.juggler.add(tween_mapHUD);
         tween_blackQuadTop = new Tween(blackQuadTop,0.5);
         tween_blackQuadTop.moveTo(0,-100);
         Starling.juggler.add(tween_blackQuadTop);
         tween_blackQuadBot = new Tween(blackQuadBot,0.5);
         tween_blackQuadBot.moveTo(0,GameConfig.GAME_HEIGHT);
         tween_blackQuadBot.onComplete = function():void
         {
            map.mapHUD.unpause();
            removeFromParent();
         };
         Starling.juggler.add(tween_blackQuadBot);
         map.recallPosition();
      }
      
      private function setDialogue(param1:String, param2:String = "obj_lineus_hand_out") : void
      {
         var text:String = param1;
         var portraitSprite:String = param2;
         if(tween_popupSprite != null)
         {
            Starling.juggler.remove(tween_popupSprite);
         }
         bCanClickNow = false;
         if(popupSprite.alpha > 0)
         {
            tween_popupSprite = new Tween(popupSprite,0.25);
            tween_popupSprite.fadeTo(0);
            tween_popupSprite.onComplete = function():void
            {
               portrait.texture = Assets.getAtlas().getTexture(portraitSprite);
               portraitText.text = text;
               Starling.juggler.remove(tween_popupSprite);
               tween_popupSprite = new Tween(popupSprite,0.25);
               tween_popupSprite.fadeTo(1);
               tween_popupSprite.onComplete = function():void
               {
                  bCanClickNow = true;
                  Starling.juggler.remove(tween_popupSprite);
               };
               Starling.juggler.add(tween_popupSprite);
            };
            Starling.juggler.add(tween_popupSprite);
         }
         else
         {
            portrait.texture = Assets.getAtlas().getTexture(portraitSprite);
            portraitText.text = text;
            tween_popupSprite = new Tween(popupSprite,0.5);
            tween_popupSprite.fadeTo(1);
            tween_popupSprite.onComplete = function():void
            {
               bCanClickNow = true;
               Starling.juggler.remove(tween_popupSprite);
            };
            Starling.juggler.add(tween_popupSprite);
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         blackQuadTop = null;
         blackQuadBot = null;
         popupSprite = null;
         portrait = null;
         portraitText = null;
         nextTextField = null;
         tween_popupSprite = null;
         tween_blackQuadBot = null;
         tween_mapHUD = null;
         tween_blackQuadTop = null;
         map = null;
         super.dispose();
      }
   }
}

