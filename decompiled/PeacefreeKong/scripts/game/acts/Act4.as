package game.acts
{
   import flash.utils.ByteArray;
   import game.library.MapLibrary;
   import game.peacefree.Achievement;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import game.peacefree.Mob;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.StorySequence;
   
   public class Act4 extends Act
   {
      
      public static const MapInfo:Class = exmission13_txt;
      
      public function Act4()
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
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new Mob(map.tiles[12 + map.mapWidth * 14],17);
            _loc1_.waypoints = new Array(12 + map.mapWidth * 14,9 + map.mapWidth * 12,12 + map.mapWidth * 8,16 + map.mapWidth * 12,-3);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[12 + map.mapWidth * 10],18);
            _loc1_.waypoints = new Array(16 + map.mapWidth * 12,12 + map.mapWidth * 14,9 + map.mapWidth * 12,12 + map.mapWidth * 8,-3);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[8 + map.mapWidth * 10],19);
            _loc1_.waypoints = new Array(11 + map.mapWidth * 8,8 + map.mapWidth * 11,-3);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[10 + map.mapWidth * 16],19);
            _loc1_.waypoints = new Array(8 + map.mapWidth * 13,11 + map.mapWidth * 16,-3);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[14 + map.mapWidth * 15],19);
            _loc1_.waypoints = new Array(13 + map.mapWidth * 16,15 + map.mapWidth * 14,-3);
            map.addMob(_loc1_);
            map.makeVisibleTile(map.tiles[16 + 14 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 16 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 8 * map.mapWidth]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Giant Hornets have become hostile in this area...";
         sequence.tile = map.tiles[12 + map.mapWidth * 12];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We need to demolish those Hive Nests to stop them from spawning more!";
         sequence.tile = map.tiles[8 + 16 * map.mapWidth];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[map.startPoint]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),10,2,215);
         m.displayLabel = "Demolish Hive Nest #1";
         m.data = "400";
         m.setTargetTile(map.tiles[16 + 14 * map.mapWidth]);
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),10,2,215);
         m.displayLabel = "Demolish Hive Nest #2";
         m.data = "401";
         m.setTargetTile(map.tiles[8 + 16 * map.mapWidth]);
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),10,2,215);
         m.displayLabel = "Demolish Hive Nest #3";
         m.data = "400";
         m.setTargetTile(map.tiles[8 + 8 * map.mapWidth]);
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            win("You defeated the Giant Hornets!");
         };
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "Giant Hornets!!";
      }
      
      override public function getActDescription() : String
      {
         return "Hives of Giant Hornets have suddenly started appearing in the wilderness. They are not natural inhabitants of the forest, and you know very well the enemy is behind all of this.";
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
         return 4;
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
         ach1 = new Achievement(pgame,108,"Completion Award","Complete Act 4 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,109,"Hard Achievement","Complete Act 4 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,110,"Heroic Achievement","Complete Act 4 in Heroic difficulty.",function():Boolean
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

