package game.acts
{
   import flash.utils.ByteArray;
   import game.library.MapLibrary;
   import game.peacefree.Achievement;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import game.peacefree.Mob;
   import game.peacefree.MobGenerator;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.StorySequence;
   
   public class Act5 extends Act
   {
      
      public static const MapInfo:Class = exmission14_txt;
      
      public function Act5()
      {
         super();
      }
      
      override public function init(param1:Map, param2:Boolean = true) : void
      {
         var actNumber:int;
         var txt:ByteArray;
         var generator1:MobGenerator;
         var generator2:MobGenerator;
         var generator3:MobGenerator;
         var sequence:StorySequence;
         var m:MissionObjective;
         var map:Map = param1;
         var bLoadMap:Boolean = param2;
         super.init(map);
         actNumber = getActNumber();
         if(bLoadMap)
         {
            txt = new MapInfo() as ByteArray;
            map.loadMap(MapLibrary.parseMapData(txt.toString()));
         }
         map.setStartTile(11,16);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Looks like the enemy bioships are using the Giant Hornets against us. We need to fortify our base!";
         sequence.tile = map.tiles[11 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),12,2,190);
         m.setTargetTile(map.tiles[11 + 16 * map.mapWidth]);
         m.data = "3";
         m.displayLabel = "3 Day Preparation.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Here they come!";
         sequence.tile = map.tiles[13 + 5 * map.mapWidth];
         sequence.onUpdate = function():void
         {
            map.makeVisibleTile(map.tiles[7 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[9 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[7 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[9 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[11 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[12 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[13 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[11 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[12 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[13 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[15 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[16 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 5 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[15 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[16 + 6 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 6 * map.mapWidth]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[11 + 16 * map.mapWidth]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),11,2,160);
         m.setTargetTile(map.tiles[12 + 5 * map.mapWidth]);
         m.data = "1";
         m.displayLabel = "Survive Wave 1";
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            generator1 = new MobGenerator(map.tiles[8 + 4 * map.mapWidth],17,25000,4);
            map.addMobGenerator(generator1);
            generator2 = new MobGenerator(map.tiles[12 + 4 * map.mapWidth],17,25000,4);
            map.addMobGenerator(generator2);
            generator3 = new MobGenerator(map.tiles[16 + 5 * map.mapWidth],17,25000,4);
            map.addMobGenerator(generator3);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,160);
         m.setTargetTile(map.tiles[12 + 5 * map.mapWidth]);
         m.data = "1";
         m.displayLabel = "Survive Wave 2";
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            generator1 = new MobGenerator(map.tiles[8 + 4 * map.mapWidth],17,25000,6);
            map.addMobGenerator(generator1);
            generator2 = new MobGenerator(map.tiles[12 + 4 * map.mapWidth],18,25000,4);
            map.addMobGenerator(generator2);
            generator3 = new MobGenerator(map.tiles[16 + 5 * map.mapWidth],17,25000,6);
            map.addMobGenerator(generator3);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,160);
         m.setTargetTile(map.tiles[12 + 5 * map.mapWidth]);
         m.data = "1";
         m.displayLabel = "Survive Wave 3";
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            generator1 = new MobGenerator(map.tiles[8 + 4 * map.mapWidth],1,25000,4);
            map.addMobGenerator(generator1);
            generator2 = new MobGenerator(map.tiles[12 + 4 * map.mapWidth],18,25000,8);
            map.addMobGenerator(generator2);
            generator3 = new MobGenerator(map.tiles[16 + 5 * map.mapWidth],1,25000,4);
            map.addMobGenerator(generator3);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,160);
         m.setTargetTile(map.tiles[12 + 5 * map.mapWidth]);
         m.data = "1";
         m.displayLabel = "Survive Wave 4";
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            generator1 = new MobGenerator(map.tiles[8 + 4 * map.mapWidth],12,25000,6);
            map.addMobGenerator(generator1);
            generator2 = new MobGenerator(map.tiles[12 + 4 * map.mapWidth],3,25000,4);
            map.addMobGenerator(generator2);
            generator3 = new MobGenerator(map.tiles[16 + 5 * map.mapWidth],12,25000,6);
            map.addMobGenerator(generator3);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),100,2,190);
         m.setTargetTile(map.tiles[12 + 5 * map.mapWidth]);
         m.checkComplete = function():Boolean
         {
            return map.mobs.length == 0;
         };
         m.displayLabel = "Survive Last Wave";
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            generator1 = new MobGenerator(map.tiles[8 + 4 * map.mapWidth],18,25000,10);
            map.addMobGenerator(generator1);
            generator3 = new MobGenerator(map.tiles[16 + 5 * map.mapWidth],18,25000,10);
            map.addMobGenerator(generator3);
            map.addMob(new Mob(map.tiles[11 + 4 * map.mapWidth],2));
            map.addMob(new Mob(map.tiles[13 + 4 * map.mapWidth],2));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            map.pauseBGM();
            map.stopBGM();
            map.bgList = new Array("act_2_0","act_2_1");
            map.unpauseBGM();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            win("Mission Success!");
         };
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "S.O.S. Assault";
      }
      
      override public function getActDescription() : String
      {
         return "You received an S.O.S. in the middle of nowhere, only to realize it was a trap. Defend against several waves of powerful enemies.";
      }
      
      public function win(param1:String) : void
      {
         var _loc2_:int = 0;
         map.showGameOver(true,param1);
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < map.pgame.unlockedActs.length)
         {
            if(map.pgame.unlockedActs[_loc2_] == getActNumber() + 1)
            {
               _loc3_ = true;
               break;
            }
            _loc2_++;
         }
         if(!_loc3_)
         {
            map.pgame.unlockedActs.push(getActNumber() + 1);
         }
         _loc2_ = 0;
         while(_loc2_ < achievements.length)
         {
            if(!achievements[_loc2_].isUnlocked() && achievements[_loc2_].check())
            {
               achievements[_loc2_].unlock();
            }
            _loc2_++;
         }
      }
      
      override public function getActNumber() : int
      {
         return 5;
      }
      
      override public function initAchievements() : void
      {
         var pgame:PeacefreeGame;
         var ach1:Achievement;
         var ach2:Achievement;
         var ach3:Achievement;
         var bCompleted:Boolean;
         var i:int;
         if(achievements == null)
         {
            achievements = [];
         }
         else
         {
            achievements.splice(0);
         }
         pgame = PeacefreeGame.getInstance();
         ach1 = new Achievement(pgame,111,"Completion Award","Complete Act 5 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,112,"Hard Achievement","Complete Act 5 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,113,"Heroic Achievement","Complete Act 5 in Heroic difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 3;
         });
         achievements.push(ach3);
         bCompleted = false;
         i = 0;
         while(i < pgame.unlockedActs.length)
         {
            if(pgame.unlockedActs[i] == getActNumber() + 1)
            {
               bCompleted = true;
               break;
            }
            i = i + 1;
         }
         if(bCompleted && !ach1.isUnlocked())
         {
            ach1.unlock();
         }
      }
   }
}

