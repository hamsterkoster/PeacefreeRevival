package game.peacefree.interfaces
{
   import game.library.FileLibrary;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.Player;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class SaveFile extends Sprite
   {
      
      private var fileNumber:int;
      
      private var bSave:Boolean;
      
      private var dateTimeText:TextField;
      
      private var mapNameText:TextField;
      
      private var statsText:TextField;
      
      private var pgame:PeacefreeGame;
      
      private var saveButton:GenericScreenButton;
      
      private var loadButton:GenericScreenButton;
      
      public function SaveFile(param1:PeacefreeGame, param2:int, param3:Boolean = true)
      {
         var boxWidth:int;
         var boxHeight:int;
         var bgQuad:Quad;
         var quad1:Quad;
         var quad2:Quad;
         var quad3:Quad;
         var quad4:Quad;
         var quad5:Quad;
         var slotNumber:TextField;
         var pgame:PeacefreeGame = param1;
         var fileNumber:int = param2;
         var bSave:Boolean = param3;
         super();
         this.pgame = pgame;
         this.fileNumber = fileNumber;
         this.bSave = bSave;
         boxWidth = 310;
         boxHeight = 150;
         bgQuad = new Quad(boxWidth,boxHeight,1118481);
         bgQuad.alpha = 0.75;
         addChild(bgQuad);
         quad1 = new Quad(boxWidth + 2,2,3355443);
         quad1.x = 0;
         quad1.y = 0;
         quad1.alpha = 0.75;
         quad2 = new Quad(boxWidth + 2,2,3355443);
         quad2.x = 0;
         quad2.y = boxHeight;
         quad2.alpha = 0.75;
         quad3 = new Quad(2,boxHeight,3355443);
         quad3.x = 0;
         quad3.y = 0;
         quad3.alpha = 0.75;
         quad4 = new Quad(2,boxHeight,3355443);
         quad4.x = boxWidth;
         quad4.y = 0;
         quad4.alpha = 0.75;
         addChild(quad1);
         addChild(quad2);
         addChild(quad3);
         addChild(quad4);
         quad5 = new Quad(boxWidth - 20,1,4293759265);
         quad5.x = 10;
         quad5.y = 36;
         addChild(quad5);
         slotNumber = new TextField(100,30,"Slot " + fileNumber,Fonts.getDefaultFont().fontName,20,4293759265,true);
         slotNumber.x = 10;
         slotNumber.y = 10;
         slotNumber.vAlign = "top";
         slotNumber.hAlign = "left";
         slotNumber.touchable = false;
         slotNumber.autoScale = true;
         addChild(slotNumber);
         if(fileNumber == 0)
         {
            slotNumber.text = "Autosave";
         }
         dateTimeText = new TextField(230,30,"Day 100, Á01:20",Fonts.getDefaultFont().fontName,20,10066329,true);
         dateTimeText.x = boxWidth - dateTimeText.width - 10;
         dateTimeText.y = 10;
         dateTimeText.vAlign = "top";
         dateTimeText.hAlign = "right";
         dateTimeText.touchable = false;
         dateTimeText.autoScale = true;
         addChild(dateTimeText);
         mapNameText = new TextField(boxWidth,30,"Map 1 - The Taltana Harbor Incident",Fonts.getDefaultFont().fontName,20,16777215,true);
         mapNameText.x = 10;
         mapNameText.y = 40;
         mapNameText.vAlign = "top";
         mapNameText.hAlign = "left";
         mapNameText.touchable = false;
         mapNameText.autoScale = true;
         addChild(mapNameText);
         statsText = new TextField(boxWidth,30,"È100 Â100 É100 - Hard",Fonts.getDefaultFont().fontName,18,16777215,true);
         statsText.x = 10;
         statsText.y = 70;
         statsText.vAlign = "top";
         statsText.hAlign = "left";
         statsText.touchable = false;
         statsText.autoScale = true;
         addChild(statsText);
         loadButton = new GenericScreenButton(120,35,"Load",24);
         loadButton.x = boxWidth - 130;
         loadButton.y = 105;
         loadButton.pressedCallback = function():void
         {
            load();
         };
         addChild(loadButton);
         saveButton = new GenericScreenButton(120,35,"Save",24);
         saveButton.x = loadButton.x - saveButton.width - 10;
         saveButton.y = 105;
         saveButton.pressedCallback = function():void
         {
            save();
         };
         addChild(saveButton);
         previewData();
      }
      
      public function save() : void
      {
         pgame.map.saveData("save-" + fileNumber);
         previewData();
      }
      
      public function load() : void
      {
         var _loc1_:Map = Map.loadData(pgame,"save-" + fileNumber);
         if(_loc1_ == null)
         {
            return;
         }
         pgame.loadMap(_loc1_);
         pgame.hideSaveFileInterfacer();
      }
      
      public function previewData() : void
      {
         var _loc2_:Object = FileLibrary.getData("save-" + fileNumber);
         if(_loc2_ == null || _loc2_.data == null || _loc2_.data.gameData == null)
         {
            dateTimeText.text = "";
            mapNameText.text = "- Empty Slot -";
            statsText.text = "";
            loadButton.textField.color = 3355443;
            return;
         }
         loadButton.textField.color = 16777215;
         var _loc1_:Object = JSON.parse(_loc2_.data.gameData);
         var _loc3_:Object = _loc1_.act;
         var _loc5_:Act = Act.getAct(_loc3_.actNumber);
         if(_loc3_.actNumber == 11)
         {
            mapNameText.text = "Boss Run - " + _loc5_.getActTitle();
         }
         else
         {
            mapNameText.text = "Act " + _loc3_.actNumber + " - " + _loc5_.getActTitle();
         }
         var _loc4_:Player = new Player(null);
         _loc4_.setData(_loc1_.player);
         statsText.text = "È" + _loc4_.food + " " + "Â" + _loc4_.minerals + " " + "É" + _loc4_.totalRecruits + " - ";
         switch(_loc1_.difficulty)
         {
            case 0:
               statsText.text += "Easy";
               break;
            case 2:
               statsText.text += "Hard";
               break;
            case 3:
               statsText.text += "Heroic";
               break;
            default:
               statsText.text += "Normal";
         }
         dateTimeText.text = "[Day " + _loc1_.days + ", " + "Á" + Map.formatTime(Map.getHour(_loc1_.hours),Map.getMinutes(_loc1_.timerCounter)) + "]";
      }
      
      public function showSave(param1:Boolean) : void
      {
         this.bSave = param1;
         saveButton.visible = param1;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         dateTimeText = null;
         mapNameText = null;
         statsText = null;
         pgame = null;
         saveButton = null;
         loadButton = null;
         super.dispose();
      }
   }
}

