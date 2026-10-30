package game.peacefree.mobs
{
   import game.library.SoundLibrary;
   import game.peacefree.Map;
   import game.peacefree.Mob;
   import game.peacefree.Tile;
   import game.peacefree.effects.ChargeParticleEffect;
   import game.peacefree.effects.ExplosionEffect;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class NilHelios extends Mob
   {
      
      private var tweenHover:Tween;
      
      public function NilHelios(param1:Tile, param2:Boolean = false)
      {
         super(param1,11,param2);
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         sprites = new Array(4);
         sprites[0] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type));
         sprites[1] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type));
         sprites[2] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type));
         sprites[3] = new MovieClip(Assets.getAtlas().getTextures("mob_" + type));
         shadowSprite = new Image(Assets.getAtlas().getTexture("effect_shadow"));
         shadowSprite.alpha = 0.3;
         addChild(shadowSprite);
         health = getHealth(tile.map,type);
         x = tile.getCanvasX();
         y = tile.getCanvasY();
         position.x = x;
         position.y = y;
         shipSprite = new Sprite();
         addChild(shipSprite);
         tile.mob = this;
         _loc1_ = 0;
         while(_loc1_ < sprites.length)
         {
            sprites[_loc1_].x = 112 / 2 - sprites[_loc1_].width / 2;
            sprites[_loc1_].y = getFloat();
            _loc1_++;
         }
         shipSprite.addChild(sprites[direction]);
         mobFPS = 6;
         updateFPS();
         cycle = new Array(6,6,6,7);
      }
      
      override protected function performAction() : void
      {
         var _loc1_:Map = tile.map;
         var _loc2_:Tile = tile;
         _loc1_.effectSprite.addChild(new ExplosionEffect(_loc1_,_loc2_));
         if(_loc1_.getTile(tile.mapX - 1,tile.mapY) != null)
         {
            _loc2_ = _loc1_.getTile(tile.mapX - 1,tile.mapY);
            _loc1_.effectSprite.addChild(new ExplosionEffect(_loc1_,_loc2_,500 / tile.map.timeMultiplier));
         }
         if(_loc1_.getTile(tile.mapX + 1,tile.mapY) != null)
         {
            _loc2_ = _loc1_.getTile(tile.mapX + 1,tile.mapY);
            _loc1_.effectSprite.addChild(new ExplosionEffect(_loc1_,_loc2_,1000 / tile.map.timeMultiplier));
         }
         if(_loc1_.getTile(tile.mapX,tile.mapY - 1) != null)
         {
            _loc2_ = _loc1_.getTile(tile.mapX,tile.mapY - 1);
            _loc1_.effectSprite.addChild(new ExplosionEffect(_loc1_,_loc2_,1500 / tile.map.timeMultiplier));
         }
         if(_loc1_.getTile(tile.mapX,tile.mapY + 1) != null)
         {
            _loc2_ = _loc1_.getTile(tile.mapX,tile.mapY + 1);
            _loc1_.effectSprite.addChild(new ExplosionEffect(_loc1_,_loc2_,2000 / tile.map.timeMultiplier));
         }
      }
      
      override public function makeChargeParticle() : void
      {
         tile.map.effectSprite.addChild(new ChargeParticleEffect(tile.map,tile.getCanvasX() + 112 / 2,tile.getCanvasY(),8399875));
         SoundLibrary.playSFX("charging");
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(tweenHover != null)
         {
            Starling.juggler.remove(tweenHover);
         }
         tweenHover = null;
         super.dispose();
      }
   }
}

