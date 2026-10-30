package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import game.peacefree.Building;
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import starling.display.Image;
   import starling.text.TextField;
   
   public class BuildOption extends Clickable
   {
      
      public var buildType:int;
      
      public var image:Image;
      
      public var hintTextField:TextField = null;
      
      public function BuildOption(param1:int)
      {
         super(Assets.getAtlas().getTexture("button_gloss"));
         this.buildType = param1;
         image = new Image(Assets.getAtlas().getTexture("building_" + param1 + "_01"));
         image.scaleX = 0.4;
         image.scaleY = 0.4;
         image.x = 2;
         image.y = 52 - image.height;
         image.color = 65290;
         addChild(image);
         hintTextField = new TextField(width,55,Building.getMineralCost(param1) + "Â",Fonts.getDefaultFont().fontName,18,16777215,true);
         hintTextField.x = 0;
         hintTextField.y = 5;
         hintTextField.vAlign = "bottom";
         hintTextField.hAlign = "right";
         hintTextField.touchable = false;
         hintTextField.autoScale = true;
         addChild(hintTextField);
      }
      
      public function setIsEnabled(param1:Boolean) : void
      {
         this.bEnabled = param1;
         if(param1)
         {
            image.color = 65290;
            if(hintTextField != null)
            {
               hintTextField.color = 16777215;
            }
         }
         else
         {
            image.color = 19715;
            if(hintTextField != null)
            {
               hintTextField.color = 3355443;
            }
         }
      }
      
      public function check(param1:Map, param2:Tile) : void
      {
         hintTextField.text = Building.getMineralCost(buildType,param2.map.difficulty == 0) + "Â";
         if(param1.player.minerals >= Building.getMineralCost(buildType) && Building.isBuildable(param2,buildType))
         {
            setIsEnabled(true);
         }
         else
         {
            setIsEnabled(false);
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         image = null;
         hintTextField = null;
         super.dispose();
      }
   }
}

