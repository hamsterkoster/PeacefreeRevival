package starling.display
{
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   import starling.textures.Texture;
   import starling.utils.HAlign;
   import starling.utils.VAlign;
   
   public class Button extends DisplayObjectContainer
   {
      
      private static const MAX_DRAG_DIST:Number = 50;
      
      private var mUpState:Texture;
      
      private var mDownState:Texture;
      
      private var mContents:Sprite;
      
      private var mBackground:Image;
      
      private var mTextField:TextField;
      
      private var mTextBounds:Rectangle;
      
      private var mScaleWhenDown:Number;
      
      private var mAlphaWhenDisabled:Number;
      
      private var mEnabled:Boolean;
      
      private var mIsDown:Boolean;
      
      private var mUseHandCursor:Boolean;
      
      public function Button(param1:Texture, param2:String = "", param3:Texture = null)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         this.mUpState = param1;
         this.mDownState = param3 ? param3 : param1;
         this.mBackground = new Image(param1);
         this.mScaleWhenDown = param3 ? 1 : 0.9;
         this.mAlphaWhenDisabled = 0.5;
         this.mEnabled = true;
         this.mIsDown = false;
         this.mUseHandCursor = true;
         this.mTextBounds = new Rectangle(0,0,param1.width,param1.height);
         this.mContents = new Sprite();
         this.mContents.addChild(this.mBackground);
         addChild(this.mContents);
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         this.text = param2;
      }
      
      private function resetContents() : void
      {
         this.mIsDown = false;
         this.mBackground.texture = this.mUpState;
         this.mContents.x = this.mContents.y = 0;
         this.mContents.scaleX = this.mContents.scaleY = 1;
      }
      
      private function createTextField() : void
      {
         if(this.mTextField == null)
         {
            this.mTextField = new TextField(this.mTextBounds.width,this.mTextBounds.height,"");
            this.mTextField.vAlign = VAlign.CENTER;
            this.mTextField.hAlign = HAlign.CENTER;
            this.mTextField.touchable = false;
            this.mTextField.autoScale = true;
            this.mTextField.batchable = true;
         }
         this.mTextField.width = this.mTextBounds.width;
         this.mTextField.height = this.mTextBounds.height;
         this.mTextField.x = this.mTextBounds.x;
         this.mTextField.y = this.mTextBounds.y;
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc3_:Rectangle = null;
         Mouse.cursor = this.mUseHandCursor && this.mEnabled && param1.interactsWith(this) ? MouseCursor.BUTTON : MouseCursor.AUTO;
         var _loc2_:Touch = param1.getTouch(this);
         if(!this.mEnabled || _loc2_ == null)
         {
            return;
         }
         if(_loc2_.phase == TouchPhase.BEGAN && !this.mIsDown)
         {
            this.mBackground.texture = this.mDownState;
            this.mContents.scaleX = this.mContents.scaleY = this.mScaleWhenDown;
            this.mContents.x = (1 - this.mScaleWhenDown) / 2 * this.mBackground.width;
            this.mContents.y = (1 - this.mScaleWhenDown) / 2 * this.mBackground.height;
            this.mIsDown = true;
         }
         else if(_loc2_.phase == TouchPhase.MOVED && this.mIsDown)
         {
            _loc3_ = getBounds(stage);
            if(_loc2_.globalX < _loc3_.x - MAX_DRAG_DIST || _loc2_.globalY < _loc3_.y - MAX_DRAG_DIST || _loc2_.globalX > _loc3_.x + _loc3_.width + MAX_DRAG_DIST || _loc2_.globalY > _loc3_.y + _loc3_.height + MAX_DRAG_DIST)
            {
               this.resetContents();
            }
         }
         else if(_loc2_.phase == TouchPhase.ENDED && this.mIsDown)
         {
            this.resetContents();
            dispatchEventWith(Event.TRIGGERED,true);
         }
      }
      
      public function get scaleWhenDown() : Number
      {
         return this.mScaleWhenDown;
      }
      
      public function set scaleWhenDown(param1:Number) : void
      {
         this.mScaleWhenDown = param1;
      }
      
      public function get alphaWhenDisabled() : Number
      {
         return this.mAlphaWhenDisabled;
      }
      
      public function set alphaWhenDisabled(param1:Number) : void
      {
         this.mAlphaWhenDisabled = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this.mEnabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(this.mEnabled != param1)
         {
            this.mEnabled = param1;
            this.mContents.alpha = param1 ? 1 : this.mAlphaWhenDisabled;
            this.resetContents();
         }
      }
      
      public function get text() : String
      {
         return this.mTextField ? this.mTextField.text : "";
      }
      
      public function set text(param1:String) : void
      {
         if(param1.length == 0)
         {
            if(this.mTextField)
            {
               this.mTextField.text = param1;
               this.mTextField.removeFromParent();
            }
         }
         else
         {
            this.createTextField();
            this.mTextField.text = param1;
            if(this.mTextField.parent == null)
            {
               this.mContents.addChild(this.mTextField);
            }
         }
      }
      
      public function get fontName() : String
      {
         return this.mTextField ? this.mTextField.fontName : "Verdana";
      }
      
      public function set fontName(param1:String) : void
      {
         this.createTextField();
         this.mTextField.fontName = param1;
      }
      
      public function get fontSize() : Number
      {
         return this.mTextField ? this.mTextField.fontSize : 12;
      }
      
      public function set fontSize(param1:Number) : void
      {
         this.createTextField();
         this.mTextField.fontSize = param1;
      }
      
      public function get fontColor() : uint
      {
         return this.mTextField ? this.mTextField.color : 0;
      }
      
      public function set fontColor(param1:uint) : void
      {
         this.createTextField();
         this.mTextField.color = param1;
      }
      
      public function get fontBold() : Boolean
      {
         return this.mTextField ? this.mTextField.bold : false;
      }
      
      public function set fontBold(param1:Boolean) : void
      {
         this.createTextField();
         this.mTextField.bold = param1;
      }
      
      public function get upState() : Texture
      {
         return this.mUpState;
      }
      
      public function set upState(param1:Texture) : void
      {
         if(this.mUpState != param1)
         {
            this.mUpState = param1;
            if(!this.mIsDown)
            {
               this.mBackground.texture = param1;
            }
         }
      }
      
      public function get downState() : Texture
      {
         return this.mDownState;
      }
      
      public function set downState(param1:Texture) : void
      {
         if(this.mDownState != param1)
         {
            this.mDownState = param1;
            if(this.mIsDown)
            {
               this.mBackground.texture = param1;
            }
         }
      }
      
      public function get textVAlign() : String
      {
         return this.mTextField.vAlign;
      }
      
      public function set textVAlign(param1:String) : void
      {
         this.createTextField();
         this.mTextField.vAlign = param1;
      }
      
      public function get textHAlign() : String
      {
         return this.mTextField.hAlign;
      }
      
      public function set textHAlign(param1:String) : void
      {
         this.createTextField();
         this.mTextField.hAlign = param1;
      }
      
      public function get textBounds() : Rectangle
      {
         return this.mTextBounds.clone();
      }
      
      public function set textBounds(param1:Rectangle) : void
      {
         this.mTextBounds = param1.clone();
         this.createTextField();
      }
      
      override public function get useHandCursor() : Boolean
      {
         return this.mUseHandCursor;
      }
      
      override public function set useHandCursor(param1:Boolean) : void
      {
         this.mUseHandCursor = param1;
      }
   }
}

