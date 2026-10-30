package game.peacefree.interfaces
{
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class MessagePopup extends Sprite
   {
      
      public var titleTextField:TextField;
      
      public var bodyTextField:TextField;
      
      public var okayButton:GenericScreenButton;
      
      public function MessagePopup(param1:int, param2:int, param3:String, param4:String, param5:Function = null)
      {
         var toolTipQuad:Quad;
         var quad1:Quad;
         var quad2:Quad;
         var quad3:Quad;
         var quad4:Quad;
         var tooltipWidth:int = param1;
         var tooltipHeight:int = param2;
         var title:String = param3;
         var text:String = param4;
         var okayCallback:Function = param5;
         super();
         toolTipQuad = new Quad(tooltipWidth,tooltipHeight,136726);
         toolTipQuad.x = 0;
         toolTipQuad.y = 0;
         toolTipQuad.alpha = 0.95;
         addChild(toolTipQuad);
         quad1 = new Quad(tooltipWidth + 1,1,6710886);
         quad1.x = 0;
         quad1.y = 0;
         addChild(quad1);
         quad2 = new Quad(tooltipWidth + 1,1,6710886);
         quad2.x = 0;
         quad2.y = 0 + tooltipHeight;
         addChild(quad2);
         quad3 = new Quad(1,tooltipHeight,6710886);
         quad3.x = 0;
         quad3.y = 0;
         addChild(quad3);
         quad4 = new Quad(1,tooltipHeight,6710886);
         quad4.x = 0 + tooltipWidth;
         quad4.y = 0;
         addChild(quad4);
         titleTextField = new TextField(tooltipWidth - 15,tooltipHeight,title,Fonts.getDefaultFont().fontName,24,4293759265,true);
         titleTextField.x = 10;
         titleTextField.y = 5;
         titleTextField.vAlign = "top";
         titleTextField.hAlign = "center";
         titleTextField.touchable = false;
         titleTextField.autoScale = true;
         addChild(titleTextField);
         bodyTextField = new TextField(tooltipWidth - 15,tooltipHeight,text,Fonts.getDefaultFont().fontName,20,16777215,true);
         bodyTextField.x = 10;
         bodyTextField.y = 30;
         bodyTextField.vAlign = "top";
         bodyTextField.hAlign = "center";
         bodyTextField.touchable = false;
         bodyTextField.autoScale = true;
         addChild(bodyTextField);
         if(okayCallback == null)
         {
            okayCallback = function():void
            {
               visible = false;
            };
         }
         okayButton = new GenericScreenButton(200,30,"Okay",24);
         okayButton.x = tooltipWidth / 2 - okayButton.width / 2;
         okayButton.y = tooltipHeight - okayButton.height - 10;
         okayButton.releaseCallback = okayCallback;
         addChild(okayButton);
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         titleTextField = null;
         bodyTextField = null;
         okayButton = null;
         super.dispose();
      }
   }
}

