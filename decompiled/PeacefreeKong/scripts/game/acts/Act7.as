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
   import game.peacefree.mobs.GiasRobo;
   
   public class Act7 extends Act
   {
      
      public static const MapInfo:Class = exmission17_txt;
      
      public function Act7()
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
         map.setStartTile(14,10);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc2_:GiasRobo = new GiasRobo(map.tiles[6 + 7 * map.mapWidth]);
            _loc2_.missionObjID = 101;
            _loc2_.cycle = new Array(6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7);
            _loc2_.waypoints = new Array(8 + 9 * map.mapWidth,4 + 9 * map.mapWidth,4 + 5 * map.mapWidth,8 + 5 * map.mapWidth,-3);
            map.addMob(_loc2_);
            var _loc1_:Mob = new Mob(map.tiles[12 + map.mapWidth * 5],3);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[12 + map.mapWidth * 5],3);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[4 + map.mapWidth * 14],1);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[16 + map.mapWidth * 7],1);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[16 + map.mapWidth * 18],13);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[5 + map.mapWidth * 16],2);
            _loc1_.waypoints = new Array(9 + map.mapWidth * 16,5 + map.mapWidth * 16,-3);
            map.addMob(_loc1_);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 5]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 5]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 5]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 5]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 5]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[4 + map.mapWidth * 20]);
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 20]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 20]);
            map.updateMap();
            map.addMobGenerator(new MobGenerator(map.tiles[2 + 4 * map.mapWidth],13,240000));
            map.addMobGenerator(new MobGenerator(map.tiles[2 + 6 * map.mapWidth],13,240000,0,-480000));
            map.addMobGenerator(new MobGenerator(map.tiles[6 + 2 * map.mapWidth],1,240000,0,-720000));
            map.addMobGenerator(new MobGenerator(map.tiles[3 + 2 * map.mapWidth],1,240000,0,-960000));
            map.addMobGenerator(new MobGenerator(map.tiles[2 + 5 * map.mapWidth],3,240000,0,-1200000));
            map.addMobGenerator(new MobGenerator(map.tiles[2 + 3 * map.mapWidth],12,240000,0,-1440000));
            map.addMobGenerator(new MobGenerator(map.tiles[4 + 2 * map.mapWidth],12,240000 / 2,0,-1680000));
            map.addMobGenerator(new MobGenerator(map.tiles[5 + 2 * map.mapWidth],2,240000,0,-2400000));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "This robot has a bomb attached to it!";
         sequence.tile = map.tiles[6 + map.mapWidth * 7];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We need to lure it here and capture it, before more enemies arrive!";
         sequence.tile = map.tiles[5 + map.mapWidth * 19];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[14 + map.mapWidth * 10]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),100,0,375);
         m.bNoShowMarker = true;
         m.displayLabel = "Gias Robo will attack nearby secured tiles.";
         m.setTargetTile(map.tiles[6 + map.mapWidth * 7]);
         m.checkComplete = function():Boolean
         {
            return map.tiles[5 + map.mapWidth * 19].mob != null && map.tiles[5 + map.mapWidth * 19].mob.type == 23;
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),2,2,250);
         m.displayLabel = "Do not destroy Gias Robo.";
         m.targetMobID = 101;
         m.onComplete = function():void
         {
            map.showGameOver(false,"You failed to capture the Gias Robo!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),100,2,240);
         m.displayLabel = "Lure Gias Robo into Trap.";
         m.setTargetTile(map.tiles[5 + map.mapWidth * 19]);
         m.checkComplete = function():Boolean
         {
            return map.tiles[5 + map.mapWidth * 19].mob != null && map.tiles[5 + map.mapWidth * 19].mob.type == 23;
         };
         m.onComplete = function():void
         {
            map.tiles[5 + map.mapWidth * 19].mob.zap(300000);
            win("You captured the Gias Robo!");
         };
         sequence.addObjective(m);
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "Capture the Gias Robo";
      }
      
      override public function getActDescription() : String
      {
         return "A UFO code-named Gias Robo is wandering aimlessly near the city. It seems to have a bomb attached to it, so we need to capture it in order to defuse the bomb.";
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
         return 7;
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
         ach1 = new Achievement(pgame,117,"Completion Award","Complete Act 7 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,118,"Hard Achievement","Complete Act 7 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,119,"Heroic Achievement","Complete Act 7 in Heroic difficulty.",function():Boolean
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

