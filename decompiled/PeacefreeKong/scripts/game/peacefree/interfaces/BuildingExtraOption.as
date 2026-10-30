package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import game.peacefree.Map;
   import game.peacefree.Research;
   import game.peacefree.Tile;
   import starling.display.Image;
   import starling.text.TextField;
   
   public class BuildingExtraOption extends Clickable
   {
      
      public var buildType:int;
      
      public var researchID:int;
      
      public var hint:String;
      
      public var image:Image;
      
      public var hintTextField:TextField = null;
      
      public function BuildingExtraOption(param1:int, param2:int, param3:String)
      {
         super(Assets.getAtlas().getTexture("button_gloss"));
         this.buildType = param1;
         this.researchID = param2;
         this.hint = param3;
         image = new Image(Assets.getAtlas().getTexture("building_" + param1 + "_01"));
         image.scaleX = 0.4;
         image.scaleY = 0.4;
         image.x = 2;
         image.y = 52 - image.height;
         image.color = 65290;
         addChild(image);
         hintTextField = new TextField(width,height,param3,Fonts.getDefaultFont().fontName,20,16777215,true);
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
         var _loc3_:int = param1.research.getLevel(researchID) + 1;
         if(_loc3_ > Research.getResearchMaxLevel(researchID))
         {
            setIsEnabled(false);
         }
         if(param1.research.isLocked(researchID))
         {
            visible = false;
         }
         else
         {
            visible = true;
         }
         if(_loc3_ > 1)
         {
            hintTextField.text = "+" + _loc3_ + hint;
         }
         else
         {
            hintTextField.text = "+" + hint;
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

