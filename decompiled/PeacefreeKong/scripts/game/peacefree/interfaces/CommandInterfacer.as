package game.peacefree.interfaces
{
   import game.container.GameConfig;
   import game.library.GloebitAPI;
   import game.library.KongregateAPI;
   import game.library.MathLibrary;
   import game.library.SoundLibrary;
   import game.peacefree.Map;
   import game.peacefree.Tile;
   import game.peacefree.TitleScreen;
   import game.peacefree.effects.RushEffect;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class CommandInterfacer extends Sprite
   {
      
      public static const MIN_RUSH_TIMEOUT:int = 20000;
      
      public static const MIN_AID_TIMEOUT:int = 60000;
      
      public static const MIN_BLAST_TIMEOUT:int = 40000;
      
      public static const MIN_ZAP_TIMEOUT:int = 40000;
      
      public static const MIN_HYPEL_TIMEOUT:int = 120000;
      
      public var blastCommand:CommandButton;
      
      public var rushCommand:CommandButton;
      
      public var aidCommand:CommandButton;
      
      public var zapCommand:CommandButton;
      
      public var hypelCommand:CommandButton;
      
      public var shockCommand:CommandButton;
      
      public var noxCommand:CommandButton;
      
      public var blastTimeoutOffset:int = 0;
      
      public var rushTimeoutOffset:int = 0;
      
      public var aidTimeoutOffset:int = 0;
      
      public var zapTimeoutOffset:int = 0;
      
      public var hypelTimeoutOffset:int = 0;
      
      public var rushDuration:int = 20000;
      
      public var bBlastSelected:Boolean = false;
      
      public var bRushSelected:Boolean = false;
      
      public var bZapSelected:Boolean = false;
      
      public var bHypelSelected:Boolean = false;
      
      public var commandIcon:Image;
      
      public var map:Map;
      
      public var aidPower:int = 0;
      
      public var extraAidPower:int = 0;
      
      public var blastDamage:int = 6;
      
      public var zapDamage:int = 3;
      
      public var zapDuration:int = 40000;
      
      public var hypelDamage:int = 25;
      
      public var shockDamage:int = 15;
      
      public var noxDamage:int = 15;
      
      public var noxBombDuration:int = 80000;
      
      private var rushCommandTooltip:Tooltip;
      
      private var aidCommandTooltip:Tooltip;
      
      private var blastCommandTooltip:Tooltip;
      
      private var zapCommandTooltip:Tooltip;
      
      private var hypelCommandTooltip:Tooltip;
      
      private var shockCommandTooltip:Tooltip;
      
      private var noxCommandTooltip:Tooltip;
      
      public function CommandInterfacer(param1:Map)
      {
         var map:Map = param1;
         super();
         this.map = map;
         commandIcon = new Image(Assets.getAtlas().getTexture("command_rush"));
         rushCommand = new CommandButton("command_rush",20000);
         rushCommand.x = 0;
         rushCommand.y = 0;
         rushCommand.releaseCallback = function():void
         {
            if(!rushCommand.visible)
            {
               return;
            }
            if(bRushSelected)
            {
               bRushSelected = false;
            }
            else if(rushCommand.isReady())
            {
               commandIcon.texture = Assets.getAtlas().getTexture("command_rush");
               bRushSelected = true;
            }
            bBlastSelected = false;
            bZapSelected = false;
            bHypelSelected = false;
         };
         addChild(rushCommand);
         aidCommand = new CommandButton("command_aid",60000);
         aidCommand.x = 42;
         aidCommand.y = 0;
         aidCommand.releaseCallback = function():void
         {
            if(!aidCommand.visible)
            {
               return;
            }
            if(aidCommand.isReady())
            {
               aid();
            }
            bRushSelected = false;
            bBlastSelected = false;
            bZapSelected = false;
            bHypelSelected = false;
         };
         addChild(aidCommand);
         blastCommand = new CommandButton("command_blast",40000);
         blastCommand.x = 84;
         blastCommand.y = 0;
         blastCommand.releaseCallback = function():void
         {
            if(!blastCommand.visible)
            {
               return;
            }
            if(bBlastSelected)
            {
               bBlastSelected = false;
            }
            else if(blastCommand.isReady())
            {
               commandIcon.texture = Assets.getAtlas().getTexture("command_blast");
               bBlastSelected = true;
            }
            bRushSelected = false;
            bZapSelected = false;
            bHypelSelected = false;
         };
         addChild(blastCommand);
         zapCommand = new CommandButton("command_zap",40000);
         zapCommand.x = 126;
         zapCommand.y = 0;
         zapCommand.releaseCallback = function():void
         {
            if(!zapCommand.visible)
            {
               return;
            }
            if(bZapSelected)
            {
               bZapSelected = false;
            }
            else if(zapCommand.isReady())
            {
               commandIcon.texture = Assets.getAtlas().getTexture("command_zap");
               bZapSelected = true;
            }
            bRushSelected = false;
            bBlastSelected = false;
            bHypelSelected = false;
         };
         addChild(zapCommand);
         hypelCommand = new CommandButton("command_hypel",120000);
         hypelCommand.x = 168;
         hypelCommand.y = 0;
         hypelCommand.visible = false;
         hypelCommand.releaseCallback = function():void
         {
            if(!hypelCommand.visible)
            {
               return;
            }
            if(bHypelSelected)
            {
               bHypelSelected = false;
            }
            else if(hypelCommand.isReady())
            {
               commandIcon.texture = Assets.getAtlas().getTexture("command_hypel");
               bHypelSelected = true;
            }
            bRushSelected = false;
            bBlastSelected = false;
            bZapSelected = false;
         };
         addChild(hypelCommand);
         shockCommand = new CommandButton("command_shock",40000,"x0");
         shockCommand.x = 262;
         shockCommand.y = 0;
         shockCommand.releaseCallback = function():void
         {
            if(!shockCommand.visible)
            {
               return;
            }
            if(shockCommand.isReady())
            {
               shock();
            }
         };
         shockCommand.alpha = 0.5;
         shockCommand.extraCheck = function():Boolean
         {
            return map.mobs.length > 0 && map.pgame.shockLeft > 0;
         };
         if(map.pgame.isPremiumPlayer())
         {
            addChild(shockCommand);
         }
         noxCommand = new CommandButton("command_nox",40000,"x0");
         noxCommand.x = 304;
         noxCommand.y = 0;
         noxCommand.releaseCallback = function():void
         {
            if(!noxCommand.visible)
            {
               return;
            }
            if(noxCommand.isReady())
            {
               nox();
            }
         };
         noxCommand.alpha = 0.5;
         noxCommand.extraCheck = function():Boolean
         {
            return map.mobs.length > 0 && map.pgame.noxLeft > 0;
         };
         if(map.pgame.isPremiumPlayer())
         {
            addChild(noxCommand);
         }
         rushCommandTooltip = new Tooltip(200,135,"Rush Command [Q]","Use on a tile to speed up ongoing missions.");
         rushCommandTooltip.x = rushCommand.x;
         rushCommandTooltip.y = rushCommand.y - rushCommandTooltip.height + 15;
         rushCommand.tooltip = rushCommandTooltip;
         addChild(rushCommandTooltip);
         aidCommandTooltip = new Tooltip(200,135,"Aid Command [F]","Requests HQ to send free resources.");
         aidCommandTooltip.x = aidCommand.x;
         aidCommandTooltip.y = aidCommand.y - aidCommandTooltip.height + 15;
         aidCommand.tooltip = aidCommandTooltip;
         addChild(aidCommandTooltip);
         blastCommandTooltip = new Tooltip(200,135,"Blast Command [E]","Use on a tile to damage enemies.");
         blastCommandTooltip.x = blastCommand.x;
         blastCommandTooltip.y = blastCommand.y - blastCommandTooltip.height + 15;
         blastCommand.tooltip = blastCommandTooltip;
         addChild(blastCommandTooltip);
         zapCommandTooltip = new Tooltip(200,135,"Zap Command [R]","Use on a tile to stun enemies.");
         zapCommandTooltip.x = zapCommand.x;
         zapCommandTooltip.y = zapCommand.y - zapCommandTooltip.height + 15;
         zapCommand.tooltip = zapCommandTooltip;
         addChild(zapCommandTooltip);
         hypelCommandTooltip = new Tooltip(200,135,"HyPEL Command [T]","Call 6 waves of devastation, each dealing -25Ø per hit.");
         hypelCommandTooltip.x = hypelCommand.x;
         hypelCommandTooltip.y = hypelCommand.y - hypelCommandTooltip.height + 15;
         hypelCommand.tooltip = hypelCommandTooltip;
         addChild(hypelCommandTooltip);
         shockCommandTooltip = new Tooltip(200,135,"Shock Bomb","Consumable. Stuns all enemies in the map.");
         shockCommandTooltip.x = shockCommand.x;
         shockCommandTooltip.y = shockCommand.y - shockCommandTooltip.height + 15;
         shockCommand.tooltip = shockCommandTooltip;
         addChild(shockCommandTooltip);
         noxCommandTooltip = new Tooltip(200,150,"Nox Bomb","Consumable. Slows all enemy movement in the map.");
         noxCommandTooltip.x = noxCommand.x;
         noxCommandTooltip.y = noxCommand.y - noxCommandTooltip.height + 15;
         noxCommand.tooltip = noxCommandTooltip;
         addChild(noxCommandTooltip);
      }
      
      public function progress(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         hypelCommand.visible = map.bUnlockedV2;
         aidPower = 10 + map.research.getLevel(6) * 5 + extraAidPower;
         blastDamage = 6 + map.research.getLevel(1) * 4 + 2 * map.pgame.achievementManager.getSkillLevel(4);
         blastTimeoutOffset = Math.floor(1666.6666666666667 * map.research.getLevel(1) - 3333.3333333333335 * map.research.getLevel(3));
         zapDamage = 3 + map.research.getLevel(4) * 2 + 2 * map.pgame.achievementManager.getSkillLevel(3);
         zapDuration = 40000 - 240000 / 24 + 3333.3333333333335 * map.research.getLevel(5);
         shockDamage = 15;
         noxDamage = 15;
         noxBombDuration = 240000 / 3;
         rushCommand.setTimeout(Math.max(0,20000 + rushTimeoutOffset));
         aidCommand.setTimeout(Math.max(0,60000 + aidTimeoutOffset));
         blastCommand.setTimeout(Math.max(0,40000 + blastTimeoutOffset));
         zapCommand.setTimeout(Math.max(0,40000 + zapTimeoutOffset));
         hypelCommand.setTimeout(Math.max(0,120000 + hypelTimeoutOffset));
         shockCommand.setTimeout(Math.max(0,40000 + zapTimeoutOffset));
         rushCommand.progress(param1);
         aidCommand.progress(param1);
         blastCommand.progress(param1);
         zapCommand.progress(param1);
         hypelCommand.progress(param1);
         shockCommand.progress(param1);
         noxCommand.progress(param1);
         if(bRushSelected)
         {
            if(rushCommand.highlightQuadBg.color == 136726)
            {
               rushCommand.highlightQuadBg.color = 547418;
            }
         }
         else if(rushCommand.highlightQuadBg.color != 136726)
         {
            rushCommand.highlightQuadBg.color = 136726;
         }
         if(bBlastSelected)
         {
            if(blastCommand.highlightQuadBg.color == 136726)
            {
               blastCommand.highlightQuadBg.color = 547418;
            }
         }
         else if(blastCommand.highlightQuadBg.color != 136726)
         {
            blastCommand.highlightQuadBg.color = 136726;
         }
         if(bZapSelected)
         {
            if(zapCommand.highlightQuadBg.color == 136726)
            {
               zapCommand.highlightQuadBg.color = 547418;
            }
         }
         else if(zapCommand.highlightQuadBg.color != 136726)
         {
            zapCommand.highlightQuadBg.color = 136726;
         }
         if(bHypelSelected)
         {
            if(hypelCommand.highlightQuadBg.color == 136726)
            {
               hypelCommand.highlightQuadBg.color = 547418;
            }
         }
         else if(hypelCommand.highlightQuadBg.color != 136726)
         {
            hypelCommand.highlightQuadBg.color = 136726;
         }
         commandIcon.x = GameConfig.STAGE.mouseX + 10;
         commandIcon.y = GameConfig.STAGE.mouseY + 10;
         if(isCommandSelected())
         {
            if(!map.contains(commandIcon))
            {
               map.addChild(commandIcon);
            }
         }
         else if(map.contains(commandIcon))
         {
            map.removeChild(commandIcon);
         }
         _loc3_ = "Á" + Map.formatCooldown(rushCommand.commandTimeout);
         if(rushCommand.isReady())
         {
            rushCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nUse on a tile to speed up ongoing missions.\n\nReady to use.";
         }
         else
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,rushCommand.commandTimeout - rushCommand.commandCounter));
            rushCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nUse on a tile to speed up ongoing missions.\n\nCooling down: " + _loc4_;
         }
         _loc3_ = "Á" + Map.formatCooldown(aidCommand.commandTimeout);
         if(aidCommand.isReady())
         {
            aidCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nRequests HQ to send free resources (Max +" + aidPower + "È" + "/" + "Â" + ").\n\nReady to use.";
         }
         else
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,aidCommand.commandTimeout - aidCommand.commandCounter));
            aidCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nRequests HQ to send free resources (Max +" + aidPower + "È" + "/" + "Â" + ").\n\nCooling down: " + _loc4_;
         }
         _loc3_ = "Á" + Map.formatCooldown(blastCommand.commandTimeout);
         if(blastCommand.isReady())
         {
            blastCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + blastDamage + "Ø" + " to an enemy in a small area.\n\nReady to use.";
         }
         else
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,blastCommand.commandTimeout - blastCommand.commandCounter));
            blastCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + blastDamage + "Ø" + " to an enemy in a small area.\n\nCooling down: " + _loc4_;
         }
         _loc2_ = "Á" + Map.formatCooldown(zapDuration);
         _loc3_ = "Á" + Map.formatCooldown(zapCommand.commandTimeout);
         if(zapCommand.isReady())
         {
            zapCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + zapDamage + "Ø" + " and stuns an enemy for " + _loc2_ + ".\n\nReady to use.";
         }
         else
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,zapCommand.commandTimeout - zapCommand.commandCounter));
            zapCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + zapDamage + "Ø" + " and stuns an enemy for " + _loc2_ + ".\n\nCooling down: " + _loc4_;
         }
         _loc3_ = "Á" + Map.formatCooldown(hypelCommand.commandTimeout);
         if(hypelCommand.isReady())
         {
            hypelCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nCall 6 waves of devastation, each dealing -" + hypelDamage + "Ø" + " per hit.\n\nReady to use.";
         }
         else
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,hypelCommand.commandTimeout - hypelCommand.commandCounter));
            hypelCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nCall 6 waves of devastation, each dealing -" + hypelDamage + "Ø" + " per hit.\n\nCooling down: " + _loc4_;
         }
         _loc2_ = "Á" + Map.formatCooldown(zapDuration);
         _loc3_ = "Á" + Map.formatCooldown(shockCommand.commandTimeout);
         shockCommand.hintTextField.text = "x" + map.pgame.shockLeft;
         shockCommandTooltip.titleTextField.text = "Shock Bomb x " + map.pgame.shockLeft;
         if(shockCommand.isReady())
         {
            shockCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + shockDamage + "Ø" + " and stuns all enemies for " + _loc2_ + ".\n\n" + map.pgame.shockLeft + " x Ready to Use.";
         }
         else if(map.mobs.length < 1)
         {
            shockCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + shockDamage + "Ø" + " and stuns all enemies for " + _loc2_ + ".\n\nNo Enemies Found.";
         }
         else if(map.pgame.shockLeft > 0)
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,shockCommand.commandTimeout - shockCommand.commandCounter));
            shockCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + shockDamage + "Ø" + " and stuns all enemies for " + _loc2_ + ".\n\nCooling down: " + _loc4_;
         }
         else
         {
            shockCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + shockDamage + "Ø" + " and stuns all enemies for " + _loc2_ + ".\n\nBuy Bombs at Shop.";
         }
         _loc2_ = "Á" + Map.formatCooldown(noxBombDuration);
         _loc3_ = "Á" + Map.formatCooldown(noxCommand.commandTimeout);
         noxCommand.hintTextField.text = "x" + map.pgame.noxLeft;
         noxCommandTooltip.titleTextField.text = "Nox Bomb x " + map.pgame.noxLeft;
         if(noxCommand.isReady())
         {
            noxCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + noxDamage + "Ø" + " and slows all enemy movement by 75% for " + _loc2_ + ".\n\n" + map.pgame.noxLeft + " x Ready to Use.";
         }
         else if(map.mobs.length < 1)
         {
            noxCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + noxDamage + "Ø" + " and stuns all enemy movement by 75% for " + _loc2_ + ".\n\nNo Enemies Found.";
         }
         else if(map.pgame.shockLeft > 0)
         {
            _loc4_ = "Á" + Map.formatCooldown(Math.max(0,noxCommand.commandTimeout - noxCommand.commandCounter));
            noxCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + noxDamage + "Ø" + " and slows all enemy movement by 75% for " + _loc2_ + ".\n\nCooling down: " + _loc4_;
         }
         else
         {
            noxCommandTooltip.bodyTextField.text = "Cooldown is " + _loc3_ + ".\nDeals -" + noxDamage + "Ø" + " and stuns all enemy movement by 75% for " + _loc2_ + ".\n\nBuy Bombs at Shop.";
         }
      }
      
      public function isCommandSelected() : Boolean
      {
         return bRushSelected || bBlastSelected || bZapSelected || bHypelSelected;
      }
      
      public function performCommand(param1:Tile) : void
      {
         if(bRushSelected)
         {
            if(param1.mission != null && param1.mission.isRushable())
            {
               SoundLibrary.playSFX("powerup");
               param1.mission.rush(rushDuration);
               map.effectSprite.addChild(new RushEffect(map,param1.getCanvasX(),param1.getCanvasY()));
               rushCommand.commandCounter = 0;
            }
            bRushSelected = false;
         }
         else if(bBlastSelected)
         {
            blastCommand.commandCounter = 0;
            switch(map.research.getLevel(2) - 1)
            {
               case 1:
                  if(map.getTile(param1.mapX - 1,param1.mapY - 1) != null)
                  {
                     map.blast(map.getTile(param1.mapX - 1,param1.mapY - 1),blastDamage);
                  }
                  if(map.getTile(param1.mapX + 1,param1.mapY - 1) != null)
                  {
                     map.blast(map.getTile(param1.mapX + 1,param1.mapY - 1),blastDamage);
                  }
                  if(map.getTile(param1.mapX - 1,param1.mapY + 1) != null)
                  {
                     map.blast(map.getTile(param1.mapX - 1,param1.mapY + 1),blastDamage);
                  }
                  if(map.getTile(param1.mapX + 1,param1.mapY + 1) != null)
                  {
                     map.blast(map.getTile(param1.mapX + 1,param1.mapY + 1),blastDamage);
                  }
                  break;
               case 0:
                  if(map.getTile(param1.mapX - 1,param1.mapY) != null)
                  {
                     map.blast(map.getTile(param1.mapX - 1,param1.mapY),blastDamage);
                  }
                  if(map.getTile(param1.mapX + 1,param1.mapY) != null)
                  {
                     map.blast(map.getTile(param1.mapX + 1,param1.mapY),blastDamage);
                  }
                  if(map.getTile(param1.mapX,param1.mapY + 1) != null)
                  {
                     map.blast(map.getTile(param1.mapX,param1.mapY + 1),blastDamage);
                  }
                  if(map.getTile(param1.mapX,param1.mapY - 1) != null)
                  {
                     map.blast(map.getTile(param1.mapX,param1.mapY - 1),blastDamage);
                  }
            }
            map.blast(param1,blastDamage);
            bBlastSelected = false;
         }
         else if(bZapSelected)
         {
            zapCommand.commandCounter = 0;
            map.zap(param1,zapDamage,zapDuration);
            bZapSelected = false;
            if(map.pgame.isPremiumPlayer())
            {
               if(map.getTile(param1.mapX - 1,param1.mapY) != null)
               {
                  map.zap(map.getTile(param1.mapX - 1,param1.mapY),zapDamage,zapDuration);
               }
               if(map.getTile(param1.mapX + 1,param1.mapY) != null)
               {
                  map.zap(map.getTile(param1.mapX + 1,param1.mapY),zapDamage,zapDuration);
               }
               if(map.getTile(param1.mapX,param1.mapY + 1) != null)
               {
                  map.zap(map.getTile(param1.mapX,param1.mapY + 1),zapDamage,zapDuration);
               }
               if(map.getTile(param1.mapX,param1.mapY - 1) != null)
               {
                  map.zap(map.getTile(param1.mapX,param1.mapY - 1),zapDamage,zapDuration);
               }
            }
         }
         else if(bHypelSelected)
         {
            hypelCommand.commandCounter = 0;
            map.hypel(param1,hypelDamage);
            bHypelSelected = false;
         }
      }
      
      public function shock() : void
      {
         shockCommand.commandCounter = 0;
         map.shock(shockDamage,zapDuration);
         if(GameConfig.GLOEBIT_VERSION)
         {
            if(map.pgame.bLoggedInToGloebits)
            {
               GloebitAPI.useShock(function():void
               {
               },function():void
               {
               });
            }
         }
         else if(GameConfig.KONG_VERSION)
         {
            KongregateAPI.consumeItem(map.pgame.lastKongregateShockBombID,function():void
            {
               map.pgame.getKongregateItems();
            });
         }
      }
      
      public function nox() : void
      {
         noxCommand.commandCounter = 0;
         map.noxBomb(15,240000 / 2,0.75);
         if(GameConfig.GLOEBIT_VERSION)
         {
            if(map.pgame.bLoggedInToGloebits)
            {
               GloebitAPI.useNox(function():void
               {
               },function():void
               {
               });
            }
         }
         else if(GameConfig.KONG_VERSION)
         {
            KongregateAPI.consumeItem(map.pgame.lastKongregateNoxBombID,function():void
            {
               map.pgame.getKongregateItems();
            });
         }
      }
      
      public function aid() : void
      {
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc2_:* = null;
         SoundLibrary.playSFX("aid");
         aidCommand.commandCounter = 0;
         switch(MathLibrary.randomize(0,4))
         {
            case 0:
               _loc3_ = "Ñ HQ is busy.";
               break;
            case 1:
               _loc1_ = MathLibrary.randomize(5,aidPower);
               _loc3_ = "Ç HQ sent È" + _loc1_ + ".";
               map.addFood(_loc1_);
               break;
            case 2:
               _loc1_ = MathLibrary.randomize(5,aidPower);
               _loc3_ = "Ç HQ sent Â" + _loc1_ + ".";
               map.addMinerals(_loc1_);
               break;
            case 3:
               if(map.player.totalRecruits < map.player.maxRecruits)
               {
                  _loc3_ = "Ç HQ sent É1.";
                  map.player.addTroop(1);
                  break;
               }
            case 4:
               _loc1_ = MathLibrary.randomize(5,aidPower);
               map.addFood(_loc1_);
               _loc3_ = "Ç HQ sent È" + _loc1_;
               _loc1_ = MathLibrary.randomize(5,aidPower);
               map.addMinerals(_loc1_);
               _loc3_ += " and Â" + _loc1_;
         }
         map.mapHUD.logInterfacer.addLogEntry(null,_loc3_);
      }
      
      public function getData() : Object
      {
         var _loc1_:Object = {};
         _loc1_.blast = blastCommand.commandCounter;
         _loc1_.rush = rushCommand.commandCounter;
         _loc1_.aid = aidCommand.commandCounter;
         _loc1_.zap = zapCommand.commandCounter;
         _loc1_.hypel = hypelCommand.commandCounter;
         _loc1_.shock = shockCommand.commandCounter;
         _loc1_.nox = noxCommand.commandCounter;
         return _loc1_;
      }
      
      public function setData(param1:Object) : void
      {
         blastCommand.commandCounter = param1.blast;
         rushCommand.commandCounter = param1.rush;
         aidCommand.commandCounter = param1.aid;
         zapCommand.commandCounter = param1.zap;
         hypelCommand.commandCounter = param1.hypel;
         shockCommand.commandCounter = param1.shock;
         noxCommand.commandCounter = param1.nox;
         blastCommand.refreshColors();
         rushCommand.refreshColors();
         aidCommand.refreshColors();
         zapCommand.refreshColors();
         hypelCommand.refreshColors();
         shockCommand.refreshColors();
         noxCommand.refreshColors();
      }
      
      override public function dispose() : void
      {
         while(numChildren > 0)
         {
            getChildAt(0).removeFromParent(true);
         }
         blastCommand = null;
         rushCommand = null;
         aidCommand = null;
         zapCommand = null;
         hypelCommand = null;
         shockCommand = null;
         noxCommand = null;
         commandIcon = null;
         map = null;
         rushCommandTooltip = null;
         aidCommandTooltip = null;
         blastCommandTooltip = null;
         zapCommandTooltip = null;
         shockCommandTooltip = null;
         noxCommandTooltip = null;
         super.dispose();
      }
   }
}

