package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.peacefree.Map;
   import game.peacefree.interfaces.tileoptionlists.QuickConfirmMissionOptionList;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class QuickMissionInterfacer extends Sprite
   {
      
      public var map:Map;
      
      public var quickOptionPaneSprite:Sprite;
      
      public var mainOptionListPane:Sprite;
      
      public var mainOptionList:QuickMissionOptionList;
      
      public var quickMissionOptionListPane:Sprite;
      
      public var quickMissionOptionList:QuickConfirmMissionOptionList;
      
      public var tileNameTextField:TextField;
      
      public var tileDescTextField:TextField;
      
      public var bQuickMissionsEnabled:Boolean = false;
      
      public function QuickMissionInterfacer(param1:Map)
      {
         var statusQuad29:Quad;
         var statusQuad25:Quad;
         var statusQuad26:Quad;
         var statusQuad27:Quad;
         var statusQuad28:Quad;
         var statusQuad14:Quad;
         var statusQuad15:Quad;
         var statusQuad16:Quad;
         var statusQuad23:Quad;
         var openQuickMenuTileOption:TileOption;
         var statusQuad8:Quad;
         var statusQuad9:Quad;
         var statusQuad10:Quad;
         var statusQuad20:Quad;
         var statusQuad5:Quad;
         var statusQuad6:Quad;
         var statusQuad7:Quad;
         var statusQuad21:Quad;
         var statusQuad22:Quad;
         var openQuickMenuTooltip:Tooltip;
         var map:Map = param1;
         super();
         this.map = map;
         mainOptionListPane = new Sprite();
         mainOptionListPane.x = GameConfig.GAME_WIDTH - 180;
         mainOptionListPane.y = 110;
         mainOptionListPane.visible = false;
         addChild(mainOptionListPane);
         statusQuad29 = new Quad(250,190,1118481);
         statusQuad29.x = -10;
         statusQuad29.y = -10;
         statusQuad29.alpha = 0.75;
         mainOptionListPane.addChild(statusQuad29);
         statusQuad25 = new Quad(2,192,6710886);
         statusQuad25.x = -12;
         statusQuad25.y = -12;
         statusQuad25.alpha = 0.75;
         mainOptionListPane.addChild(statusQuad25);
         statusQuad26 = new Quad(250,2,6710886);
         statusQuad26.x = -10;
         statusQuad26.y = -12;
         statusQuad26.alpha = 0.75;
         mainOptionListPane.addChild(statusQuad26);
         statusQuad27 = new Quad(2,192,6710886);
         statusQuad27.x = 240;
         statusQuad27.y = -12;
         statusQuad27.alpha = 0.75;
         mainOptionListPane.addChild(statusQuad27);
         statusQuad28 = new Quad(254,2,6710886);
         statusQuad28.x = -12;
         statusQuad28.y = 180;
         statusQuad28.alpha = 0.75;
         mainOptionListPane.addChild(statusQuad28);
         mainOptionList = new QuickMissionOptionList(map);
         mainOptionListPane.addChild(mainOptionList);
         quickOptionPaneSprite = new Sprite();
         quickOptionPaneSprite.x = GameConfig.GAME_WIDTH - 60;
         quickOptionPaneSprite.y = 110;
         addChild(quickOptionPaneSprite);
         statusQuad14 = new Quad(70,70,1118481);
         statusQuad14.x = -10;
         statusQuad14.y = -10;
         statusQuad14.alpha = 0.75;
         quickOptionPaneSprite.addChild(statusQuad14);
         statusQuad15 = new Quad(2,72,6710886);
         statusQuad15.x = -12;
         statusQuad15.y = -12;
         statusQuad15.alpha = 0.75;
         quickOptionPaneSprite.addChild(statusQuad15);
         statusQuad16 = new Quad(70,2,6710886);
         statusQuad16.x = -10;
         statusQuad16.y = -12;
         statusQuad16.alpha = 0.75;
         quickOptionPaneSprite.addChild(statusQuad16);
         statusQuad23 = new Quad(72,2,6710886);
         statusQuad23.x = -12;
         statusQuad23.y = 60;
         statusQuad23.alpha = 0.75;
         quickOptionPaneSprite.addChild(statusQuad23);
         openQuickMenuTileOption = new TileOption("button_quick");
         openQuickMenuTileOption.releaseCallback = function():void
         {
            show();
         };
         quickOptionPaneSprite.addChild(openQuickMenuTileOption);
         quickMissionOptionListPane = new Sprite();
         quickMissionOptionListPane.x = GameConfig.GAME_WIDTH - 220;
         quickMissionOptionListPane.y = 110;
         quickMissionOptionListPane.visible = false;
         addChild(quickMissionOptionListPane);
         statusQuad8 = new Quad(240,270,136726);
         statusQuad8.x = -20;
         statusQuad8.y = -10;
         statusQuad8.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad8);
         statusQuad9 = new Quad(2,270,6710886);
         statusQuad9.x = -22;
         statusQuad9.y = -10;
         statusQuad9.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad9);
         statusQuad10 = new Quad(242,2,6710886);
         statusQuad10.x = -22;
         statusQuad10.y = -12;
         statusQuad10.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad10);
         statusQuad20 = new Quad(242,2,6710886);
         statusQuad20.x = -22;
         statusQuad20.y = 260;
         statusQuad20.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad20);
         tileNameTextField = new TextField(200,24,"Quick Scout Mission",Fonts.getDefaultFont().fontName,24,4293759265,true);
         tileNameTextField.x = 0;
         tileNameTextField.y = 5;
         tileNameTextField.vAlign = "center";
         tileNameTextField.hAlign = "center";
         tileNameTextField.touchable = false;
         tileNameTextField.autoScale = true;
         quickMissionOptionListPane.addChild(tileNameTextField);
         tileDescTextField = new TextField(200,80,"Select which tiles to scout. Use more Å to reduce required time.",Fonts.getDefaultFont().fontName,18,16777215,true);
         tileDescTextField.x = 5;
         tileDescTextField.y = 35;
         tileDescTextField.vAlign = "top";
         tileDescTextField.hAlign = "left";
         tileDescTextField.touchable = false;
         tileDescTextField.autoScale = true;
         quickMissionOptionListPane.addChild(tileDescTextField);
         statusQuad5 = new Quad(190,130,1118481);
         statusQuad5.x = 10;
         statusQuad5.y = 120;
         statusQuad5.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad5);
         statusQuad6 = new Quad(2,132,2236962);
         statusQuad6.x = 8;
         statusQuad6.y = 120;
         statusQuad6.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad6);
         statusQuad7 = new Quad(190,2,2236962);
         statusQuad7.x = 10;
         statusQuad7.y = 120;
         statusQuad7.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad7);
         statusQuad21 = new Quad(2,132,2236962);
         statusQuad21.x = 200;
         statusQuad21.y = 120;
         statusQuad21.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad21);
         statusQuad22 = new Quad(194,2,2236962);
         statusQuad22.x = 8;
         statusQuad22.y = 250;
         statusQuad22.alpha = 0.75;
         quickMissionOptionListPane.addChild(statusQuad22);
         quickMissionOptionList = new QuickConfirmMissionOptionList(map);
         quickMissionOptionList.x = 20;
         quickMissionOptionList.y = 130;
         quickMissionOptionListPane.addChild(quickMissionOptionList);
         openQuickMenuTooltip = new Tooltip(150,60,"Quick Menu","Use [G] as hotkey.");
         openQuickMenuTooltip.x = quickOptionPaneSprite.x - 112 - openQuickMenuTileOption.width;
         openQuickMenuTooltip.y = quickOptionPaneSprite.y - 5;
         openQuickMenuTileOption.tooltip = openQuickMenuTooltip;
         addChild(openQuickMenuTooltip);
      }
      
      public function hide() : void
      {
         bQuickMissionsEnabled = false;
         mainOptionListPane.visible = false;
         quickOptionPaneSprite.visible = true;
         quickMissionOptionListPane.visible = false;
         quickMissionOptionList.setMissionType(0);
         map.mapHUD.clearNumCallbacks();
      }
      
      public function show() : void
      {
         bQuickMissionsEnabled = false;
         quickOptionPaneSprite.visible = false;
         mainOptionListPane.visible = true;
         quickMissionOptionListPane.visible = false;
         mainOptionList.setNumCallbacks();
      }
      
      public function showMissionType(param1:int) : void
      {
         bQuickMissionsEnabled = true;
         quickOptionPaneSprite.visible = false;
         mainOptionListPane.visible = false;
         quickMissionOptionList.setMissionType(param1);
         quickMissionOptionListPane.visible = true;
         map.mapHUD.clearNumCallbacks();
         map.mapHUD.num9Callback = quickMissionOptionList.cancelOption;
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         map = null;
         quickOptionPaneSprite = null;
         mainOptionListPane = null;
         mainOptionList = null;
         quickMissionOptionListPane = null;
         quickMissionOptionList = null;
         tileNameTextField = null;
         tileDescTextField = null;
         super.dispose();
      }
   }
}

