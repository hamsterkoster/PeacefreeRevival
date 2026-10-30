package game.peacefree
{
   import game.container.GameConfig;
   import game.peacefree.interfaces.GenericScreenButton;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class CreditsScreen extends Sprite
   {
      
      public var tscreen:TitleScreen;
      
      public function CreditsScreen(param1:TitleScreen)
      {
         var blackFilmQuad:Quad;
         var closeButton:GenericScreenButton;
         var creditsText:TextField;
         var gameByText:TextField;
         var logo:Image;
         var programByText:TextField;
         var programByNameText:TextField;
         var programByLinkText:TextField;
         var musicByText:TextField;
         var musicByNameText:TextField;
         var musicByLinkText:TextField;
         var thanksToText:TextField;
         var thanksToNameText:TextField;
         var tscreen:TitleScreen = param1;
         super();
         this.tscreen = tscreen;
         blackFilmQuad = new Quad(GameConfig.GAME_WIDTH,GameConfig.GAME_HEIGHT,0);
         blackFilmQuad.alpha = 0.9;
         addChild(blackFilmQuad);
         closeButton = new GenericScreenButton(45,40,"X",24,2003173376);
         closeButton.x = GameConfig.GAME_WIDTH / 2 + 325;
         closeButton.y = GameConfig.GAME_HEIGHT / 2 - 250;
         closeButton.pressedCallback = function():void
         {
            tscreen.hideCreditsInterface();
         };
         addChild(closeButton);
         creditsText = new TextField(500,50,"Copyright © 2014 Adventure Cat, LLC. All Rights Reserved.",Fonts.getDefaultFont().fontName,16,6710886,true);
         creditsText.x = GameConfig.GAME_WIDTH / 2 - creditsText.width / 2;
         creditsText.y = GameConfig.GAME_HEIGHT - 70;
         creditsText.vAlign = "center";
         creditsText.hAlign = "center";
         creditsText.touchable = false;
         creditsText.autoScale = true;
         addChild(creditsText);
         gameByText = new TextField(500,50,"A Game By:",Fonts.getDefaultFont().fontName,20,4293759265,true);
         gameByText.x = GameConfig.GAME_WIDTH / 2 - gameByText.width / 2;
         gameByText.y = GameConfig.GAME_HEIGHT / 2 - 190;
         gameByText.vAlign = "center";
         gameByText.hAlign = "center";
         gameByText.touchable = false;
         gameByText.autoScale = true;
         addChild(gameByText);
         logo = new Image(Assets.getAtlas().getTexture("adventurecat"));
         logo.x = GameConfig.GAME_WIDTH / 2 - logo.width / 2;
         logo.y = gameByText.y + 30;
         addChild(logo);
         programByText = new TextField(200,50,"Program & Art By:",Fonts.getDefaultFont().fontName,20,4293759265,true);
         programByText.x = GameConfig.GAME_WIDTH / 2 - programByText.width - 100;
         programByText.y = GameConfig.GAME_HEIGHT / 2 - 30;
         programByText.vAlign = "center";
         programByText.hAlign = "center";
         programByText.touchable = false;
         programByText.autoScale = true;
         addChild(programByText);
         programByNameText = new TextField(programByText.width,50,"Daniel John Pua",Fonts.getDefaultFont().fontName,30,16777215,true);
         programByNameText.x = programByText.x;
         programByNameText.y = programByText.y + 25;
         programByNameText.vAlign = "center";
         programByNameText.hAlign = "center";
         programByNameText.touchable = false;
         programByNameText.autoScale = true;
         addChild(programByNameText);
         programByLinkText = new TextField(programByText.width,50,"www.adventurecat.us",Fonts.getDefaultFont().fontName,18,16777215,true);
         programByLinkText.x = programByText.x;
         programByLinkText.y = programByText.y + 50;
         programByLinkText.vAlign = "center";
         programByLinkText.hAlign = "center";
         programByLinkText.touchable = false;
         programByLinkText.autoScale = true;
         addChild(programByLinkText);
         musicByText = new TextField(200,50,"Music By:",Fonts.getDefaultFont().fontName,20,4293759265,true);
         musicByText.x = GameConfig.GAME_WIDTH / 2 + 100;
         musicByText.y = GameConfig.GAME_HEIGHT / 2 - 30;
         musicByText.vAlign = "center";
         musicByText.hAlign = "center";
         musicByText.touchable = false;
         musicByText.autoScale = true;
         addChild(musicByText);
         musicByNameText = new TextField(musicByText.width,50,"Audionautix",Fonts.getDefaultFont().fontName,30,16777215,true);
         musicByNameText.x = musicByText.x;
         musicByNameText.y = musicByText.y + 25;
         musicByNameText.vAlign = "center";
         musicByNameText.hAlign = "center";
         musicByNameText.touchable = false;
         musicByNameText.autoScale = true;
         addChild(musicByNameText);
         musicByLinkText = new TextField(musicByText.width,50,"audionautix.com",Fonts.getDefaultFont().fontName,18,16777215,true);
         musicByLinkText.x = musicByText.x;
         musicByLinkText.y = musicByText.y + 50;
         musicByLinkText.vAlign = "center";
         musicByLinkText.hAlign = "center";
         musicByLinkText.touchable = false;
         musicByLinkText.autoScale = true;
         addChild(musicByLinkText);
         thanksToText = new TextField(400,50,"Special Thanks To:",Fonts.getDefaultFont().fontName,20,4293759265,true);
         thanksToText.x = GameConfig.GAME_WIDTH / 2 - thanksToText.width / 2;
         thanksToText.y = GameConfig.GAME_HEIGHT / 2 + 80;
         thanksToText.vAlign = "center";
         thanksToText.hAlign = "center";
         thanksToText.touchable = false;
         thanksToText.autoScale = true;
         addChild(thanksToText);
         thanksToNameText = new TextField(thanksToText.width,50,"Daisy Joan Pua and Renaldi Taniran",Fonts.getDefaultFont().fontName,30,16777215,true);
         thanksToNameText.x = GameConfig.GAME_WIDTH / 2 - thanksToNameText.width / 2;
         thanksToNameText.y = thanksToText.y + 25;
         thanksToNameText.vAlign = "center";
         thanksToNameText.hAlign = "center";
         thanksToNameText.touchable = false;
         thanksToNameText.autoScale = true;
         addChild(thanksToNameText);
      }
   }
}

