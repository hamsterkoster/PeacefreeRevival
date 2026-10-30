package game.peacefree.interfaces
{
   import game.interfaces.Clickable;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import starling.events.TouchEvent;
   import starling.filters.BlurFilter;
   import starling.text.TextField;
   import starling.textures.Texture;
   
   public class MissionObjectiveEntry extends Clickable
   {
      
      public var emptyQuad:Texture = null;
      
      public var highlightQuad:Texture = null;
      
      private var objectiveTextField:TextField;
      
      public var missionObjective:MissionObjective;
      
      private var bHidden:Boolean = false;
      
      private var map:Map;
      
      public function MissionObjectiveEntry(param1:Map, param2:MissionObjective)
      {
         emptyQuad = Texture.fromColor(param2.boxWidth,28,0);
         highlightQuad = Texture.fromColor(param2.boxWidth,28,1996625430);
         super(emptyQuad);
         this.map = param1;
         this.missionObjective = param2;
         hoverCallback = onHovered;
         releaseCallback = onPressed;
         exitCallback = onMouseOut;
         objectiveTextField = new TextField(param2.boxWidth,30,param2.getTitle(),Fonts.getDefaultFont().fontName,20,16777215,true);
         objectiveTextField.x = 5;
         objectiveTextField.vAlign = "center";
         objectiveTextField.hAlign = "left";
         objectiveTextField.touchable = false;
         objectiveTextField.autoScale = true;
         objectiveTextField.filter = BlurFilter.createDropShadow(5,0.785,0,0.5,0.5,0.5);
         addChild(objectiveTextField);
         width = objectiveTextField.width;
      }
      
      public function progress(param1:int) : void
      {
         missionObjective.progress(param1);
         if(missionObjective.isTrash())
         {
            return;
         }
         objectiveTextField.text = missionObjective.getTitle();
         if(missionObjective.isComplete())
         {
            missionObjective.complete();
         }
      }
      
      public function isComplete() : Boolean
      {
         return missionObjective.isComplete() || missionObjective.isTrash();
      }
      
      public function onHovered(param1:TouchEvent) : void
      {
         upState = highlightQuad;
      }
      
      public function onMouseOut() : void
      {
         upState = emptyQuad;
      }
      
      public function onPressed() : void
      {
         map.goToTile(missionObjective.getTileAt());
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         emptyQuad = null;
         highlightQuad = null;
         objectiveTextField = null;
         missionObjective = null;
         map = null;
         super.dispose();
      }
   }
}

