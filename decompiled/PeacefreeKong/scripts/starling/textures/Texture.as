package starling.textures
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import starling.core.Starling;
   import starling.errors.AbstractClassError;
   import starling.errors.MissingContextError;
   import starling.utils.Color;
   import starling.utils.VertexData;
   import starling.utils.getNextPowerOfTwo;
   
   public class Texture
   {
      
      private var mFrame:Rectangle;
      
      private var mRepeat:Boolean;
      
      public function Texture()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.textures::Texture")
         {
            throw new AbstractClassError();
         }
         this.mRepeat = false;
      }
      
      public static function fromEmbeddedAsset(param1:Class, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra") : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         var assetClass:Class = param1;
         var mipMapping:Boolean = param2;
         var optimizeForRenderToTexture:Boolean = param3;
         var scale:Number = param4;
         var format:String = param5;
         var asset:Object = new assetClass();
         if(asset is Bitmap)
         {
            texture = starling.textures.Texture.fromBitmap(asset as Bitmap,mipMapping,false,scale,format);
            texture.root.onRestore = function():void
            {
               texture.root.uploadBitmap(new assetClass());
            };
         }
         else
         {
            if(!(asset is ByteArray))
            {
               throw new ArgumentError("Invalid asset type: " + getQualifiedClassName(asset));
            }
            texture = starling.textures.Texture.fromAtfData(asset as ByteArray,scale,mipMapping);
            texture.root.onRestore = function():void
            {
               texture.root.uploadAtfData(new assetClass());
            };
         }
         asset = null;
         return texture;
      }
      
      public static function fromBitmap(param1:Bitmap, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra") : starling.textures.Texture
      {
         return fromBitmapData(param1.bitmapData,param2,param3,param4,param5);
      }
      
      public static function fromBitmapData(param1:BitmapData, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra") : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         var data:BitmapData = param1;
         var generateMipMaps:Boolean = param2;
         var optimizeForRenderToTexture:Boolean = param3;
         var scale:Number = param4;
         var format:String = param5;
         texture = starling.textures.Texture.empty(data.width / scale,data.height / scale,true,generateMipMaps,optimizeForRenderToTexture,scale,format);
         texture.root.uploadBitmapData(data);
         texture.root.onRestore = function():void
         {
            texture.root.uploadBitmapData(data);
         };
         return texture;
      }
      
      public static function fromAtfData(param1:ByteArray, param2:Number = 1, param3:Boolean = true, param4:Function = null) : starling.textures.Texture
      {
         var atfData:AtfData;
         var nativeTexture:flash.display3D.textures.Texture;
         var concreteTexture:ConcreteTexture = null;
         var data:ByteArray = param1;
         var scale:Number = param2;
         var useMipMaps:Boolean = param3;
         var async:Function = param4;
         var context:Context3D = Starling.context;
         if(context == null)
         {
            throw new MissingContextError();
         }
         atfData = new AtfData(data);
         nativeTexture = context.createTexture(atfData.width,atfData.height,atfData.format,false);
         concreteTexture = new ConcreteTexture(nativeTexture,atfData.format,atfData.width,atfData.height,useMipMaps && atfData.numTextures > 1,false,false,scale);
         concreteTexture.uploadAtfData(data,0,async);
         concreteTexture.onRestore = function():void
         {
            concreteTexture.uploadAtfData(data,0);
         };
         return concreteTexture;
      }
      
      public static function fromColor(param1:Number, param2:Number, param3:uint = 4294967295, param4:Boolean = false, param5:Number = -1, param6:String = "bgra") : starling.textures.Texture
      {
         var texture:starling.textures.Texture = null;
         var width:Number = param1;
         var height:Number = param2;
         var color:uint = param3;
         var optimizeForRenderToTexture:Boolean = param4;
         var scale:Number = param5;
         var format:String = param6;
         texture = starling.textures.Texture.empty(width,height,true,false,optimizeForRenderToTexture,scale,format);
         texture.root.clear(color,Color.getAlpha(color) / 255);
         texture.root.onRestore = function():void
         {
            texture.root.clear(color,Color.getAlpha(color) / 255);
         };
         return texture;
      }
      
      public static function empty(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false, param6:Number = -1, param7:String = "bgra") : starling.textures.Texture
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TextureBase = null;
         if(param6 <= 0)
         {
            param6 = Starling.contentScaleFactor;
         }
         var _loc11_:Context3D = Starling.context;
         if(_loc11_ == null)
         {
            throw new MissingContextError();
         }
         var _loc12_:int = param1 * param6;
         var _loc13_:int = param2 * param6;
         var _loc14_:int = getNextPowerOfTwo(_loc12_);
         var _loc15_:int = getNextPowerOfTwo(_loc13_);
         var _loc16_:Boolean = _loc12_ == _loc14_ && _loc13_ == _loc15_;
         var _loc17_:Boolean = !_loc16_ && !param4 && Starling.current.profile != "baselineConstrained" && "createRectangleTexture" in _loc11_ && param7.indexOf("compressed") == -1;
         if(_loc17_)
         {
            _loc8_ = _loc12_;
            _loc9_ = _loc13_;
            _loc10_ = _loc11_["createRectangleTexture"](_loc8_,_loc9_,param7,param5);
         }
         else
         {
            _loc8_ = _loc14_;
            _loc9_ = _loc15_;
            _loc10_ = _loc11_.createTexture(_loc8_,_loc9_,param7,param5);
         }
         var _loc18_:ConcreteTexture = new ConcreteTexture(_loc10_,param7,_loc8_,_loc9_,param4,param3,param5,param6);
         _loc18_.onRestore = _loc18_.clear;
         if(_loc16_ || _loc17_)
         {
            return _loc18_;
         }
         return new SubTexture(_loc18_,new Rectangle(0,0,param1,param2),true);
      }
      
      public static function fromTexture(param1:starling.textures.Texture, param2:Rectangle = null, param3:Rectangle = null) : starling.textures.Texture
      {
         var _loc4_:starling.textures.Texture = new SubTexture(param1,param2);
         _loc4_.mFrame = param3;
         return _loc4_;
      }
      
      public function dispose() : void
      {
      }
      
      public function adjustVertexData(param1:VertexData, param2:int, param3:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.mFrame)
         {
            if(param3 != 4)
            {
               throw new ArgumentError("Textures with a frame can only be used on quads");
            }
            _loc4_ = this.mFrame.width + this.mFrame.x - this.width;
            _loc5_ = this.mFrame.height + this.mFrame.y - this.height;
            param1.translateVertex(param2,-this.mFrame.x,-this.mFrame.y);
            param1.translateVertex(param2 + 1,-_loc4_,-this.mFrame.y);
            param1.translateVertex(param2 + 2,-this.mFrame.x,-_loc5_);
            param1.translateVertex(param2 + 3,-_loc4_,-_loc5_);
         }
      }
      
      public function adjustTexCoords(param1:Vector.<Number>, param2:int = 0, param3:int = 0, param4:int = -1) : void
      {
      }
      
      public function get frame() : Rectangle
      {
         return this.mFrame ? this.mFrame.clone() : new Rectangle(0,0,this.width,this.height);
      }
      
      public function get repeat() : Boolean
      {
         return this.mRepeat;
      }
      
      public function set repeat(param1:Boolean) : void
      {
         this.mRepeat = param1;
      }
      
      public function get width() : Number
      {
         return 0;
      }
      
      public function get height() : Number
      {
         return 0;
      }
      
      public function get nativeWidth() : Number
      {
         return 0;
      }
      
      public function get nativeHeight() : Number
      {
         return 0;
      }
      
      public function get scale() : Number
      {
         return 1;
      }
      
      public function get base() : TextureBase
      {
         return null;
      }
      
      public function get root() : ConcreteTexture
      {
         return null;
      }
      
      public function get format() : String
      {
         return Context3DTextureFormat.BGRA;
      }
      
      public function get mipMapping() : Boolean
      {
         return false;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return false;
      }
   }
}

