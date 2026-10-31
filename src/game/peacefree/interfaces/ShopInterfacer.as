package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.interfaces.Clickable;
   import game.peacefree.PeacefreeGame;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class ShopInterfacer extends Sprite
   {
      
      private var pgame:PeacefreeGame;
      
      private var gloebitsTextField:TextField;
      
      private var shockBombHintTextField:TextField;
      
      private var noxBombHintTextField:TextField;
      
      public var processingTextField:TextField;
      
      public var blackFilmQuad2:Quad;
      
      public function ShopInterfacer(param1:PeacefreeGame)
      {
         var blackFilmQuad:Quad;
         var closeButton:GenericScreenButton;
         var confirmNoxPurchasePopup:ConfirmPopup;
         var confirmShockPurchasePopup:ConfirmPopup;
         var helpTextField:TextField;
         var shockBombImage:Image;
         var bgQuad:Quad;
         var quad1:Quad;
         var quad2:Quad;
         var quad3:Quad;
         var quad4:Quad;
         var shockBombTitleTextField:TextField;
         var lineQuad:Quad;
         var shockBombDescTextField:TextField;
         var buyShockBombButton:Clickable;
         var shockBombBuyForText:TextField;
         var noxBombImage:Image;
         var bgQuad2:Quad;
         var quad11:Quad;
         var quad12:Quad;
         var quad13:Quad;
         var quad14:Quad;
         var noxBombTitleTextField:TextField;
         var lineQuad2:Quad;
         var noxBombDescTextField:TextField;
         var buyNoxBombButton:Clickable;
         var noxBombBuyForText:TextField;
         var pgame:PeacefreeGame = param1;
         super();
         this.pgame = pgame;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         closeButton = new GenericScreenButton(45,40,"X",24,2003173376);
         closeButton.x = GameConfig.GAME_WIDTH / 2 + 325;
         closeButton.y = GameConfig.GAME_HEIGHT / 2 - 250;
         closeButton.pressedCallback = function():void
         {
            pgame.hideShopInterfacer();
         };
         addChild(closeButton);
         blackFilmQuad2 = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad2.alpha = 0.9;
         blackFilmQuad2.visible = false;
         confirmNoxPurchasePopup = new ConfirmPopup(400,180,"Confirm Nox Bomb Purchase?","\nAre you sure you want to buy\n10 Nox Bombs for 50 Gloebits?",function():void
         {
            confirmNoxPurchasePopup.visible = false;
            processingTextField.visible = true;
            if(GameConfig.GLOEBIT_VERSION)
            {
               pgame.buyNoxBombsViaGloebit();
            }
            else if(GameConfig.KONG_VERSION)
            {
               pgame.buyNoxBombsViaKongregate();
            }
         },function():void
         {
            blackFilmQuad2.visible = false;
            confirmNoxPurchasePopup.visible = false;
         });
         confirmNoxPurchasePopup.x = GameConfig.GAME_WIDTH / 2 - confirmNoxPurchasePopup.width / 2;
         confirmNoxPurchasePopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
         confirmNoxPurchasePopup.visible = false;
         if(GameConfig.KONG_VERSION)
         {
            // PeacefreeRevival: the bombs are free (to-do 3), so the Kongregate texts say so instead
            // of promising a price in Kreds (to-do 11).
            confirmNoxPurchasePopup.titleTextField.text = "Get Nox Bombs?";
            confirmNoxPurchasePopup.bodyTextField.text = "\nGet 10 Nox Bombs\nfor free?";
         }
         confirmShockPurchasePopup = new ConfirmPopup(400,180,"Confirm Shock Bomb Purchase?","\nAre you sure you want to buy\n10 Shock Bombs for 50 Gloebits?",function():void
         {
            confirmShockPurchasePopup.visible = false;
            processingTextField.visible = true;
            if(GameConfig.GLOEBIT_VERSION)
            {
               pgame.buyShockBombsViaGloebit();
            }
            else if(GameConfig.KONG_VERSION)
            {
               pgame.buyShockBombsViaKongregate();
            }
         },function():void
         {
            blackFilmQuad2.visible = false;
            confirmShockPurchasePopup.visible = false;
         });
         confirmShockPurchasePopup.x = GameConfig.GAME_WIDTH / 2 - confirmNoxPurchasePopup.width / 2;
         confirmShockPurchasePopup.y = GameConfig.GAME_HEIGHT / 2 - 100;
         confirmShockPurchasePopup.visible = false;
         if(GameConfig.KONG_VERSION)
         {
            // PeacefreeRevival: free, as for Nox Bombs above.
            confirmShockPurchasePopup.titleTextField.text = "Get Shock Bombs?";
            confirmShockPurchasePopup.bodyTextField.text = "\nGet 10 Shock Bombs\nfor free?";
         }
         processingTextField = new TextField(400,30,"Processing payment...",Fonts.getDefaultFont().fontName,24,16777215,true);
         processingTextField.x = GameConfig.GAME_WIDTH / 2 - processingTextField.width / 2;
         processingTextField.y = GameConfig.GAME_HEIGHT / 2 - processingTextField.height / 2;
         processingTextField.vAlign = "center";
         processingTextField.hAlign = "center";
         processingTextField.touchable = false;
         processingTextField.autoScale = true;
         processingTextField.visible = false;
         addChild(processingTextField);
         helpTextField = new TextField(650,30,"Buy powerful weapons that will help you in the battlefield.",Fonts.getDefaultFont().fontName,20,10066329,true);
         helpTextField.x = GameConfig.GAME_WIDTH / 2 - 325;
         helpTextField.y = GameConfig.GAME_HEIGHT / 2 - 190;
         helpTextField.vAlign = "center";
         helpTextField.hAlign = "center";
         helpTextField.touchable = false;
         helpTextField.autoScale = true;
         addChild(helpTextField);
         shockBombImage = new Image(Assets.getAtlas().getTexture("command_shock"));
         shockBombImage.x = GameConfig.GAME_WIDTH / 2 - 325;
         shockBombImage.y = GameConfig.GAME_HEIGHT / 2 - 130;
         shockBombImage.scaleX = 5;
         shockBombImage.scaleY = 5;
         bgQuad = new Quad(650,130,1118481);
         bgQuad.x = GameConfig.GAME_WIDTH / 2 - 325;
         bgQuad.y = GameConfig.GAME_HEIGHT / 2 - 130;
         bgQuad.alpha = 0.75;
         quad1 = new Quad(652,2,3355443);
         quad1.x = bgQuad.x;
         quad1.y = bgQuad.y;
         quad1.alpha = 0.75;
         quad2 = new Quad(652,2,3355443);
         quad2.x = bgQuad.x;
         quad2.y = bgQuad.y + 130;
         quad2.alpha = 0.75;
         quad3 = new Quad(2,130,3355443);
         quad3.x = bgQuad.x;
         quad3.y = bgQuad.y;
         quad3.alpha = 0.75;
         quad4 = new Quad(2,130,3355443);
         quad4.x = bgQuad.x + 650;
         quad4.y = bgQuad.y;
         quad4.alpha = 0.75;
         addChild(bgQuad);
         addChild(quad1);
         addChild(quad2);
         addChild(quad3);
         addChild(quad4);
         addChild(shockBombImage);
         shockBombHintTextField = new TextField(shockBombImage.width,shockBombImage.height,"x 10",Fonts.getDefaultFont().fontName,30,16777215,true);
         shockBombHintTextField.x = shockBombImage.x;
         shockBombHintTextField.y = shockBombImage.y;
         shockBombHintTextField.vAlign = "bottom";
         shockBombHintTextField.hAlign = "right";
         shockBombHintTextField.touchable = false;
         shockBombHintTextField.autoScale = true;
         addChild(shockBombHintTextField);
         shockBombTitleTextField = new TextField(350,30,"Shock Bombs",Fonts.getDefaultFont().fontName,24,4293759265,true);
         shockBombTitleTextField.x = shockBombImage.x + shockBombImage.width + 15;
         shockBombTitleTextField.y = shockBombImage.y + 4;
         shockBombTitleTextField.vAlign = "center";
         shockBombTitleTextField.hAlign = "left";
         shockBombTitleTextField.touchable = false;
         shockBombTitleTextField.autoScale = true;
         addChild(shockBombTitleTextField);
         lineQuad = new Quad(shockBombTitleTextField.width,1,4293759265);
         lineQuad.x = shockBombTitleTextField.x;
         lineQuad.y = shockBombTitleTextField.y + 30;
         lineQuad.alpha = 0.75;
         addChild(lineQuad);
         shockBombDescTextField = new TextField(shockBombTitleTextField.width,100,"A consumable weapon. Deals a powerful attack that damages and stuns all enemies in the map.",Fonts.getDefaultFont().fontName,20,16777215,true);
         shockBombDescTextField.x = shockBombTitleTextField.x;
         shockBombDescTextField.y = lineQuad.y + 5;
         shockBombDescTextField.vAlign = "top";
         shockBombDescTextField.hAlign = "left";
         shockBombDescTextField.touchable = false;
         shockBombDescTextField.autoScale = true;
         addChild(shockBombDescTextField);
         buyShockBombButton = new Clickable(Assets.getAtlas().getTexture("buybutton"));
         buyShockBombButton.x = shockBombTitleTextField.x + shockBombTitleTextField.width + 7;
         buyShockBombButton.y = shockBombTitleTextField.y + 8;
         buyShockBombButton.pressedCallback = function():void
         {
            blackFilmQuad2.visible = true;
            confirmShockPurchasePopup.visible = true;
         };
         addChild(buyShockBombButton);
         shockBombBuyForText = new TextField(buyShockBombButton.width,buyShockBombButton.height,"Buy 10 for\n50\nGloebits",Fonts.getDefaultFont().fontName,22,16777215,true);
         shockBombBuyForText.x = buyShockBombButton.x;
         shockBombBuyForText.y = buyShockBombButton.y;
         shockBombBuyForText.vAlign = "center";
         shockBombBuyForText.hAlign = "center";
         shockBombBuyForText.touchable = false;
         shockBombBuyForText.autoScale = true;
         addChild(shockBombBuyForText);
         if(GameConfig.KONG_VERSION)
         {
            shockBombBuyForText.text = "Get 10\nfor free"; // PeacefreeRevival: free (to-do 11)
         }
         noxBombImage = new Image(Assets.getAtlas().getTexture("command_nox"));
         noxBombImage.x = GameConfig.GAME_WIDTH / 2 - 325;
         noxBombImage.y = GameConfig.GAME_HEIGHT / 2 + 20;
         noxBombImage.scaleX = 5;
         noxBombImage.scaleY = 5;
         bgQuad2 = new Quad(650,130,1118481);
         bgQuad2.x = GameConfig.GAME_WIDTH / 2 - 325;
         bgQuad2.y = GameConfig.GAME_HEIGHT / 2 + 20;
         bgQuad2.alpha = 0.75;
         quad11 = new Quad(652,2,3355443);
         quad11.x = bgQuad2.x;
         quad11.y = bgQuad2.y;
         quad11.alpha = 0.75;
         quad12 = new Quad(652,2,3355443);
         quad12.x = bgQuad2.x;
         quad12.y = bgQuad2.y + 130;
         quad12.alpha = 0.75;
         quad13 = new Quad(2,130,3355443);
         quad13.x = bgQuad2.x;
         quad13.y = bgQuad2.y;
         quad13.alpha = 0.75;
         quad14 = new Quad(2,130,3355443);
         quad14.x = bgQuad2.x + 650;
         quad14.y = bgQuad2.y;
         quad14.alpha = 0.75;
         addChild(bgQuad2);
         addChild(quad11);
         addChild(quad12);
         addChild(quad13);
         addChild(quad14);
         addChild(noxBombImage);
         noxBombHintTextField = new TextField(noxBombImage.width,noxBombImage.height,"x 10",Fonts.getDefaultFont().fontName,30,16777215,true);
         noxBombHintTextField.x = noxBombImage.x;
         noxBombHintTextField.y = noxBombImage.y;
         noxBombHintTextField.vAlign = "bottom";
         noxBombHintTextField.hAlign = "right";
         noxBombHintTextField.touchable = false;
         noxBombHintTextField.autoScale = true;
         addChild(noxBombHintTextField);
         noxBombTitleTextField = new TextField(350,30,"Nox Bombs",Fonts.getDefaultFont().fontName,24,4293759265,true);
         noxBombTitleTextField.x = noxBombImage.x + noxBombImage.width + 15;
         noxBombTitleTextField.y = noxBombImage.y + 4;
         noxBombTitleTextField.vAlign = "center";
         noxBombTitleTextField.hAlign = "left";
         noxBombTitleTextField.touchable = false;
         noxBombTitleTextField.autoScale = true;
         addChild(noxBombTitleTextField);
         lineQuad2 = new Quad(noxBombTitleTextField.width,1,4293759265);
         lineQuad2.x = noxBombTitleTextField.x;
         lineQuad2.y = noxBombTitleTextField.y + 30;
         lineQuad2.alpha = 0.75;
         addChild(lineQuad2);
         noxBombDescTextField = new TextField(noxBombTitleTextField.width,100,"A consumable weapon. Damages and cripples movement of all enemies in the battlefield.",Fonts.getDefaultFont().fontName,20,16777215,true);
         noxBombDescTextField.x = noxBombTitleTextField.x;
         noxBombDescTextField.y = lineQuad2.y + 5;
         noxBombDescTextField.vAlign = "top";
         noxBombDescTextField.hAlign = "left";
         noxBombDescTextField.touchable = false;
         noxBombDescTextField.autoScale = true;
         addChild(noxBombDescTextField);
         buyNoxBombButton = new Clickable(Assets.getAtlas().getTexture("buybutton"));
         buyNoxBombButton.x = noxBombTitleTextField.x + noxBombTitleTextField.width + 7;
         buyNoxBombButton.y = noxBombTitleTextField.y + 8;
         buyNoxBombButton.pressedCallback = function():void
         {
            blackFilmQuad2.visible = true;
            confirmNoxPurchasePopup.visible = true;
         };
         addChild(buyNoxBombButton);
         noxBombBuyForText = new TextField(buyNoxBombButton.width,buyNoxBombButton.height,"Buy 10 for\n50\nGloebits",Fonts.getDefaultFont().fontName,22,16777215,true);
         noxBombBuyForText.x = buyNoxBombButton.x;
         noxBombBuyForText.y = buyNoxBombButton.y;
         noxBombBuyForText.vAlign = "center";
         noxBombBuyForText.hAlign = "center";
         noxBombBuyForText.touchable = false;
         noxBombBuyForText.autoScale = true;
         addChild(noxBombBuyForText);
         if(GameConfig.KONG_VERSION)
         {
            noxBombBuyForText.text = "Get 10\nfor free"; // PeacefreeRevival: free (to-do 11)
         }
         if(GameConfig.GLOEBIT_VERSION)
         {
            gloebitsTextField = new TextField(400,100,"You have " + pgame.gloebits + " Gloebits",Fonts.getDefaultFont().fontName,24,16777215,true);
            gloebitsTextField.x = GameConfig.GAME_WIDTH / 2 - gloebitsTextField.width / 2;
            gloebitsTextField.y = noxBombBuyForText.y + 130;
            gloebitsTextField.vAlign = "center";
            gloebitsTextField.hAlign = "center";
            gloebitsTextField.touchable = false;
            gloebitsTextField.autoScale = true;
            gloebitsTextField.visible = false;
            addChild(gloebitsTextField);
         }
         addChild(blackFilmQuad2);
         addChild(confirmNoxPurchasePopup);
         addChild(confirmShockPurchasePopup);
         addChild(processingTextField);
      }
      
      public function refresh() : void
      {
         if(GameConfig.GLOEBIT_VERSION)
         {
            if(pgame.bLoggedInToGloebits)
            {
               gloebitsTextField.text = "You have " + pgame.gloebits + " Gloebits";
               gloebitsTextField.visible = true;
            }
            else
            {
               gloebitsTextField.text = "You have 0 Gloebits";
               gloebitsTextField.visible = true;
            }
         }
         shockBombHintTextField.text = "x " + pgame.shockLeft;
         noxBombHintTextField.text = "x " + pgame.noxLeft;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         pgame = null;
         gloebitsTextField = null;
         shockBombHintTextField = null;
         noxBombHintTextField = null;
         processingTextField = null;
         blackFilmQuad2 = null;
         super.dispose();
      }
   }
}

