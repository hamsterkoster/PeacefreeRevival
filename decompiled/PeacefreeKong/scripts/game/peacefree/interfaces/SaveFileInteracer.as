package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.peacefree.PeacefreeGame;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class SaveFileInteracer extends Sprite
   {
      
      private var bShowSaveFile:Boolean = true;
      
      private var pgame:PeacefreeGame;
      
      private var saveFileButtons:Array;
      
      public function SaveFileInteracer(param1:PeacefreeGame, param2:Boolean = true)
      {
         var blackFilmQuad:Quad;
         var i:int;
         var j:int;
         var saveFileButton:SaveFile;
         var closeButton:GenericScreenButton;
         var pgame:PeacefreeGame = param1;
         var bShowSaveFile:Boolean = param2;
         super();
         this.pgame = pgame;
         this.bShowSaveFile = bShowSaveFile;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         saveFileButtons = [];
         i = 0;
         while(i < 2)
         {
            j = 0;
            while(j < 3)
            {
               saveFileButton = new SaveFile(pgame,i * 3 + j,bShowSaveFile);
               if(i < 1)
               {
                  saveFileButton.x = GameConfig.GAME_WIDTH / 2 - saveFileButton.width - 5;
               }
               else
               {
                  saveFileButton.x = GameConfig.GAME_WIDTH / 2 + 5;
               }
               switch(j)
               {
                  case 0:
                     saveFileButton.y = GameConfig.GAME_HEIGHT / 2 - (saveFileButton.height * 1.5 + 10);
                     break;
                  case 1:
                     saveFileButton.y = GameConfig.GAME_HEIGHT / 2 - saveFileButton.height * 0.5;
                     break;
                  case 2:
                     saveFileButton.y = GameConfig.GAME_HEIGHT / 2 + (saveFileButton.height * 0.5 + 10);
               }
               saveFileButtons.push(saveFileButton);
               addChild(saveFileButton);
               j = j + 1;
            }
            i = i + 1;
         }
         closeButton = new GenericScreenButton(45,40,"X",24,2003173376);
         closeButton.x = GameConfig.GAME_WIDTH / 2 + 325;
         closeButton.y = GameConfig.GAME_HEIGHT / 2 - 250;
         closeButton.pressedCallback = function():void
         {
            pgame.hideSaveFileInterfacer();
         };
         addChild(closeButton);
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < saveFileButtons.length)
         {
            saveFileButtons[_loc1_].previewData();
            saveFileButtons[_loc1_].showSave(pgame.viewState == 2);
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         if(saveFileButtons != null)
         {
            saveFileButtons.splice(0);
         }
         pgame = null;
         saveFileButtons = null;
         super.dispose();
      }
   }
}

