package game.acts
{
   import flash.utils.ByteArray;
   import game.library.MapLibrary;
   import game.library.MathLibrary;
   import game.peacefree.Achievement;
   import game.peacefree.Act;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import game.peacefree.Mob;
   import game.peacefree.MobGenerator;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.StorySequence;
   import game.peacefree.mobs.Jenygrin;
   
   public class Act9 extends Act
   {
      
      public static const MapInfo:Class = exmission9_txt;
      
      public function Act9()
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
         map.altStartPoints = new Array(20 + 16 * map.mapWidth,4 + 7 * map.mapWidth);
         map.setStartTile(20,16);
         map.setStartTile(4,7);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Crud! What are Jenygrins doing here?!";
         sequence.tile = map.tiles[15 + map.mapWidth * 9];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 10]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 11]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 10]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 11]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 10]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 11]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 10]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 11]);
            map.makeVisibleTile(map.tiles[17 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[17 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[17 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[17 + map.mapWidth * 10]);
            map.makeVisibleTile(map.tiles[17 + map.mapWidth * 11]);
            map.addMob(new Jenygrin(map.tiles[15 + map.mapWidth * 9],2));
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 17]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 17]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 17]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 17]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 19]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 17]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 18]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 19]);
            map.addMob(new Jenygrin(map.tiles[8 + map.mapWidth * 17],2));
            map.addMobGenerator(new MobGenerator(map.tiles[9 + map.mapWidth * 23],13,240000));
            map.addMobGenerator(new MobGenerator(map.tiles[7 + map.mapWidth * 23],13,240000,0,-480000));
            map.addMobGenerator(new MobGenerator(map.tiles[8 + map.mapWidth * 23],1,240000,0,-720000));
            map.addMobGenerator(new MobGenerator(map.tiles[10 + map.mapWidth * 23],12,240000 / 2,0,-960000));
            map.addMobGenerator(new MobGenerator(map.tiles[11 + map.mapWidth * 23],3,240000,0,-1440000));
            map.addMobGenerator(new MobGenerator(map.tiles[12 + map.mapWidth * 23],2,240000,0,-2880000));
            map.addMobGenerator(new MobGenerator(map.tiles[13 + map.mapWidth * 23],11,240000,0,-3600000));
            var _loc3_:Array = new Array(20 + 16 * map.mapWidth,-1);
            var _loc2_:Array = new Array(5,5);
            var _loc1_:MobGenerator = new MobGenerator(map.tiles[17 + map.mapWidth * 1],13,240000,0,-960000);
            _loc1_.waypoints = _loc3_.concat();
            _loc1_.cycle = _loc2_.concat();
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[18 + map.mapWidth * 1],12,240000 / 2,0,-1440000);
            _loc1_.waypoints = _loc3_.concat();
            _loc1_.cycle = _loc2_.concat();
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[20 + map.mapWidth * 1],1,240000,0,-1680000);
            _loc1_.waypoints = _loc3_.concat();
            _loc1_.cycle = _loc2_.concat();
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[19 + map.mapWidth * 1],3,240000,0,-2400000);
            _loc1_.waypoints = _loc3_.concat();
            _loc1_.cycle = _loc2_.concat();
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[16 + map.mapWidth * 1],2,240000,0,-3120000);
            _loc1_.waypoints = _loc3_.concat();
            _loc1_.cycle = _loc2_.concat();
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[15 + map.mapWidth * 1],11,240000,0,-3600000);
            _loc1_.waypoints = _loc3_.concat();
            _loc1_.cycle = _loc2_.concat();
            map.addMobGenerator(_loc1_);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "They looks harmless now, but they multiply rapidly, so we need to destroy them before more enemies arrive...";
         sequence.tile = map.tiles[8 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,260);
         m.setTargetTile(map.tiles[20 + map.mapWidth * 16]);
         m.displayLabel = "Protect Command Center A.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost Command Center A.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),9,1,260);
         m.setTargetTile(map.tiles[4 + map.mapWidth * 7]);
         m.displayLabel = "Protect Command Center B.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost Command Center B.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),100,2,250);
         m.bNoShowMarker = true;
         m.getDynamicDisplay = function():String
         {
            var _loc2_:int = 0;
            var _loc1_:int = 0;
            _loc2_ = 0;
            while(_loc2_ < map.mobs.length)
            {
               if(map.mobs[_loc2_] is Jenygrin)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
            return "Ü Hunt All Jenygrins: " + _loc1_ + " left.";
         };
         m.checkComplete = function():Boolean
         {
            var _loc2_:int = 0;
            var _loc1_:int = 0;
            _loc2_ = 0;
            while(_loc2_ < map.mobs.length)
            {
               if(map.mobs[_loc2_] is Jenygrin)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
            return _loc1_ < 1;
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Finally wiped them all out... What else could the enemy be up to?";
         sequence.tile = map.tiles[3 + map.mapWidth * 6];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            win("You defeated the Jenygrins");
         };
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "Deathmatch With Jenygrins";
      }
      
      override public function getActDescription() : String
      {
         return "Deadly creatures called Jenygrins have started appearing near the outskirts of the city. You must destroy them before they outnumber you.";
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
      
      override public function onNewSpawn(param1:Mob) : void
      {
         var _loc2_:Array = null;
         if(param1 is Jenygrin && map.mobs.length >= 20 && MathLibrary.randomize(0,100) < 50)
         {
            _loc2_ = [];
            _loc2_.push(20 + map.mapWidth * 16,-3);
            param1.waypoints = _loc2_;
         }
      }
      
      override public function getActNumber() : int
      {
         return 9;
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
         ach1 = new Achievement(pgame,123,"Completion Award","Complete Act 9 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,124,"Hard Achievement","Complete Act 9 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,125,"Heroic Achievement","Complete Act 9 in Heroic difficulty.",function():Boolean
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

