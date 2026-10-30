package game.acts
{
   import flash.utils.ByteArray;
   import game.library.MapLibrary;
   import game.peacefree.Achievement;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import game.peacefree.MobGenerator;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.StorySequence;
   
   public class Act10 extends Act
   {
      
      public static const MapInfo:Class = exmission8_txt;
      
      private var mobGenSE1:MobGenerator = null;
      
      private var mobGenSE2:MobGenerator = null;
      
      private var mobGenSE3:MobGenerator = null;
      
      private var mobGenSW1:MobGenerator = null;
      
      private var mobGenSW2:MobGenerator = null;
      
      private var mobGenSW3:MobGenerator = null;
      
      private var mobGenNE1:MobGenerator = null;
      
      private var mobGenNE2:MobGenerator = null;
      
      private var mobGenNE3:MobGenerator = null;
      
      private var mobGenNW1:MobGenerator = null;
      
      private var mobGenNW2:MobGenerator = null;
      
      private var mobGenNW3:MobGenerator = null;
      
      public function Act10()
      {
         super();
      }
      
      override public function init(param1:Map, param2:Boolean = true) : void
      {
         var actNumber:int;
         var txt:ByteArray;
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
         map.setStartTile(12,12);
         map.bgList = new Array("act_2_0","act_2_1");
         while(map.player.totalRecruits < 8)
         {
            map.player.addTroop(1);
         }
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Defend your base from all directions!";
         sequence.tile = map.tiles[12 + map.mapWidth * 12];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[12 + 12 * map.mapWidth]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSE1 = new MobGenerator(map.tiles[24 + 11 * map.mapWidth],13,10000,12);
            map.addMobGenerator(mobGenSE1);
            mobGenSE2 = new MobGenerator(map.tiles[24 + 12 * map.mapWidth],1,10000,8);
            map.addMobGenerator(mobGenSE2);
            mobGenSE3 = new MobGenerator(map.tiles[24 + 13 * map.mapWidth],13,10000,12);
            map.addMobGenerator(mobGenSE3);
            map.addMobGenerator(new MobGenerator(map.tiles[23 + 12 * map.mapWidth],1,240000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSW1 = new MobGenerator(map.tiles[11 + 24 * map.mapWidth],13,10000,12);
            map.addMobGenerator(mobGenSW1);
            mobGenSW2 = new MobGenerator(map.tiles[12 + 24 * map.mapWidth],1,10000,8);
            map.addMobGenerator(mobGenSW2);
            mobGenSW3 = new MobGenerator(map.tiles[13 + 24 * map.mapWidth],13,10000,12);
            map.addMobGenerator(mobGenSW3);
            map.addMobGenerator(new MobGenerator(map.tiles[12 + 23 * map.mapWidth],3,240000,0,-240000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenNW1 = new MobGenerator(map.tiles[0 + 11 * map.mapWidth],13,10000,6);
            map.addMobGenerator(mobGenNW1);
            mobGenNW2 = new MobGenerator(map.tiles[0 + 12 * map.mapWidth],12,10000,8);
            map.addMobGenerator(mobGenNW2);
            mobGenNW3 = new MobGenerator(map.tiles[0 + 13 * map.mapWidth],13,10000,6);
            map.addMobGenerator(mobGenNW3);
            map.addMobGenerator(new MobGenerator(map.tiles[1 + 12 * map.mapWidth],3,240000,0,-240000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenNE1 = new MobGenerator(map.tiles[11 + 0 * map.mapWidth],13,10000,6);
            map.addMobGenerator(mobGenNE1);
            mobGenNE2 = new MobGenerator(map.tiles[12 + 0 * map.mapWidth],12,10000,10);
            map.addMobGenerator(mobGenNE2);
            mobGenNE3 = new MobGenerator(map.tiles[13 + 0 * map.mapWidth],13,10000,6);
            map.addMobGenerator(mobGenNE3);
            map.addMobGenerator(new MobGenerator(map.tiles[12 + 1 * map.mapWidth],3,240000,0,-240000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSE1 = new MobGenerator(map.tiles[24 + 11 * map.mapWidth],1,10000,5);
            map.addMobGenerator(mobGenSE1);
            mobGenSE2 = new MobGenerator(map.tiles[24 + 12 * map.mapWidth],12,10000,6);
            map.addMobGenerator(mobGenSE2);
            mobGenSE3 = new MobGenerator(map.tiles[24 + 13 * map.mapWidth],1,10000,5);
            map.addMobGenerator(mobGenSE3);
            map.addMobGenerator(new MobGenerator(map.tiles[23 + 11 * map.mapWidth],3,240000,0,-240000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSW1 = new MobGenerator(map.tiles[11 + 24 * map.mapWidth],12,10000,6);
            map.addMobGenerator(mobGenSW1);
            mobGenSW2 = new MobGenerator(map.tiles[12 + 24 * map.mapWidth],3,10000,5);
            map.addMobGenerator(mobGenSW2);
            mobGenSW3 = new MobGenerator(map.tiles[13 + 24 * map.mapWidth],12,10000,6);
            map.addMobGenerator(mobGenSW3);
            map.addMobGenerator(new MobGenerator(map.tiles[11 + 23 * map.mapWidth],3,240000,0,-240000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenNW1 = new MobGenerator(map.tiles[0 + 11 * map.mapWidth],1,10000,8);
            map.addMobGenerator(mobGenNW1);
            mobGenNW2 = new MobGenerator(map.tiles[0 + 12 * map.mapWidth],2,10000,1);
            map.addMobGenerator(mobGenNW2);
            mobGenNW3 = new MobGenerator(map.tiles[0 + 13 * map.mapWidth],12,10000,8);
            map.addMobGenerator(mobGenNW3);
            map.addMobGenerator(new MobGenerator(map.tiles[1 + 11 * map.mapWidth],2,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenNE1 = new MobGenerator(map.tiles[11 + 0 * map.mapWidth],2,10000,1);
            map.addMobGenerator(mobGenNE1);
            mobGenNE2 = new MobGenerator(map.tiles[12 + 0 * map.mapWidth],3,10000,6);
            map.addMobGenerator(mobGenNE2);
            mobGenNE3 = new MobGenerator(map.tiles[13 + 0 * map.mapWidth],2,10000,1);
            map.addMobGenerator(mobGenNE3);
            map.addMobGenerator(new MobGenerator(map.tiles[11 + 1 * map.mapWidth],2,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSE1 = new MobGenerator(map.tiles[24 + 11 * map.mapWidth],12,10000,6);
            map.addMobGenerator(mobGenSE1);
            mobGenSE2 = new MobGenerator(map.tiles[24 + 12 * map.mapWidth],2,10000,3);
            map.addMobGenerator(mobGenSE2);
            mobGenSE3 = new MobGenerator(map.tiles[24 + 13 * map.mapWidth],12,10000,6);
            map.addMobGenerator(mobGenSE3);
            map.addMobGenerator(new MobGenerator(map.tiles[23 + 13 * map.mapWidth],2,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSW1 = new MobGenerator(map.tiles[11 + 24 * map.mapWidth],12,10000,8);
            map.addMobGenerator(mobGenSW1);
            mobGenSW2 = new MobGenerator(map.tiles[12 + 24 * map.mapWidth],11,10000,1);
            map.addMobGenerator(mobGenSW2);
            mobGenSW3 = new MobGenerator(map.tiles[13 + 24 * map.mapWidth],2,10000,2);
            map.addMobGenerator(mobGenSW3);
            map.addMobGenerator(new MobGenerator(map.tiles[13 + 23 * map.mapWidth],11,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenNW1 = new MobGenerator(map.tiles[0 + 11 * map.mapWidth],1,10000,8);
            map.addMobGenerator(mobGenNW1);
            mobGenNW2 = new MobGenerator(map.tiles[0 + 12 * map.mapWidth],11,10000,1);
            map.addMobGenerator(mobGenNW2);
            mobGenNW3 = new MobGenerator(map.tiles[0 + 13 * map.mapWidth],2,10000,2);
            map.addMobGenerator(mobGenNW3);
            map.addMobGenerator(new MobGenerator(map.tiles[1 + 13 * map.mapWidth],11,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenNE1 = new MobGenerator(map.tiles[11 + 0 * map.mapWidth],3,10000,8);
            map.addMobGenerator(mobGenNE1);
            mobGenNE2 = new MobGenerator(map.tiles[12 + 0 * map.mapWidth],11,10000,1);
            map.addMobGenerator(mobGenNE2);
            mobGenNE3 = new MobGenerator(map.tiles[13 + 0 * map.mapWidth],2,10000,1);
            map.addMobGenerator(mobGenNE3);
            map.addMobGenerator(new MobGenerator(map.tiles[13 + 1 * map.mapWidth],11,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSE1 = new MobGenerator(map.tiles[24 + 11 * map.mapWidth],3,10000,8);
            map.addMobGenerator(mobGenSE1);
            mobGenSE2 = new MobGenerator(map.tiles[24 + 12 * map.mapWidth],11,10000,1);
            map.addMobGenerator(mobGenSE2);
            mobGenSE3 = new MobGenerator(map.tiles[24 + 13 * map.mapWidth],2,10000,1);
            map.addMobGenerator(mobGenSE3);
            map.addMobGenerator(new MobGenerator(map.tiles[23 + 10 * map.mapWidth],11,240000 * 2,0,-480000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),11,2,200);
         m.data = "1";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         sequence.tile = m.getTileAt();
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            mobGenSW1 = new MobGenerator(map.tiles[11 + 24 * map.mapWidth],12,10000,8);
            map.addMobGenerator(mobGenSW1);
            mobGenSW2 = new MobGenerator(map.tiles[12 + 24 * map.mapWidth],11,10000,1);
            map.addMobGenerator(mobGenSW2);
            mobGenSW3 = new MobGenerator(map.tiles[13 + 24 * map.mapWidth],2,10000,1);
            map.addMobGenerator(mobGenSW3);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,115,12,2,200);
         m.data = "29";
         m.displayLabel = "Survive Until Day 30.";
         m.bNoShowMarker = true;
         m.onComplete = function():void
         {
            win("Mission Success!");
         };
         sequence.addObjective(m);
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "Moon Base Under Attack";
      }
      
      override public function getActDescription() : String
      {
         return "A fertile moon base is being attacked by the enemy from all sides. You need to survive against wave after wave of enemy bioships.";
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
         return 10;
      }
      
      override public function initAchievements() : void
      {
         var pgame:PeacefreeGame;
         var ach1:Achievement;
         var ach2:Achievement;
         var ach3:Achievement;
         if(achievements == null)
         {
            achievements = [];
         }
         else
         {
            achievements.splice(0);
         }
         pgame = PeacefreeGame.getInstance();
         ach1 = new Achievement(pgame,126,"Completion Award","Complete Act 10 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,127,"Hard Achievement","Complete Act 10 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,128,"Heroic Achievement","Complete Act 10 in Heroic difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 3;
         });
         achievements.push(ach3);
      }
   }
}

