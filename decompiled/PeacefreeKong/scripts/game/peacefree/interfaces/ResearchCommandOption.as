package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import game.peacefree.Map;
   import game.peacefree.Research;
   import game.peacefree.Tile;
   import starling.display.Image;
   import starling.text.TextField;
   
   public class ResearchCommandOption extends Clickable
   {
      
      public var image:Image;
      
      public var researchID:int;
      
      public var hintTextField:TextField = null;
      
      public var hint:String = null;
      
      public function ResearchCommandOption(param1:String, param2:int, param3:String, param4:Number = 1)
      {
         super(Assets.getAtlas().getTexture("button_gloss"));
         this.researchID = param2;
         this.hint = param3;
         image = new Image(Assets.getAtlas().getTexture(param1));
         image.scaleX = param4;
         image.scaleY = param4;
         image.color = 65290;
         addChild(image);
         hintTextField = new TextField(width,height,param3,Fonts.getDefaultFont().fontName,16,16777215,true);
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
         if(param2.building != null && param2.building.isOnline())
         {
            setIsEnabled(true);
         }
         else
         {
            setIsEnabled(false);
         }
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
            hintTextField.text = hint + " " + _loc3_;
         }
         else
         {
            hintTextField.text = hint;
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
         hint = null;
         super.dispose();
      }
   }
}

