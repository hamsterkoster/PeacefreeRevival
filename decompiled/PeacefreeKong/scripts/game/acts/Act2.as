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
   
   public class Act2 extends Act
   {
      
      public static const MapInfo:Class = exmission11_txt;
      
      public function Act2()
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
         map.setStartTile(9,7);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.action = 3;
         sequence.data = "1";
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new Mob(map.tiles[6 + map.mapWidth * 11],13);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[11 + map.mapWidth * 7],13);
            _loc1_.cycle = new Array(2,2,3,3,0,0,1,1);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[9 + map.mapWidth * 12],1);
            _loc1_.cycle = new Array(2,2,3,3,0,0,1,1);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[12 + map.mapWidth * 11],1);
            _loc1_.cycle = new Array(2,2,3,3,0,0,1,1);
            map.addMob(_loc1_);
            map.makeVisibleTile(map.tiles[12 + map.mapWidth * 6]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = "obj_dyta_sad";
         sequence.dialogue = "Help! Help! Can someone please help us?";
         sequence.tile = map.tiles[12 + map.mapWidth * 6];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Looks like someone needs help. Let\'s give them a hand!";
         sequence.tile = map.tiles[9 + map.mapWidth * 7];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),1,2,200);
         m.setTargetTile(map.tiles[12 + map.mapWidth * 6]);
         m.displayLabel = "Secure the Tech Lab.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = "obj_dyta_sad";
         sequence.dialogue = "Oh, thank you for rescuing us! As thanks, please help yourself to our Tech Lab!";
         sequence.tile = map.tiles[12 + map.mapWidth * 6];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Great! Now we can research new technologies and upgrade our Watchtowers!";
         sequence.tile = map.tiles[12 + map.mapWidth * 6];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.action = 3;
         sequence.data = "1";
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc2_:Mob = new Mob(map.tiles[7 + map.mapWidth * 15],3);
            _loc2_.cycle = new Array(2,3,3,0,0,1,1,2);
            _loc2_.missionObjID = 101;
            map.addMob(_loc2_);
            _loc2_ = new Mob(map.tiles[14 + map.mapWidth * 16],3);
            _loc2_.cycle = new Array(2,2,3,3,0,0,1,1);
            _loc2_.missionObjID = 102;
            map.addMob(_loc2_);
            var _loc1_:MobGenerator = new MobGenerator(map.tiles[7 + map.mapWidth * 18],13,240000);
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[18 + map.mapWidth * 15],13,240000,0,-120000);
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[10 + map.mapWidth * 18],1,240000,0,-480000);
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[14 + map.mapWidth * 18],1,240000,0,-480000);
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[12 + map.mapWidth * 18],1,240000,0,-960000);
            map.addMobGenerator(_loc1_);
            _loc1_ = new MobGenerator(map.tiles[18 + map.mapWidth * 14],1,240000,0,-1440000);
            map.addMobGenerator(_loc1_);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 14]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 14]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 14]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[16 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 14]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 14]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 14]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 15]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 16]);
            map.makeVisibleTile(map.tiles[9 + map.mapWidth * 16]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Looks like those two Virosaucers are calling for reinforcements!";
         sequence.tile = map.tiles[15 + map.mapWidth * 15];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Let\'s upgrade our Watchtowers and take them out before more bioships arrive!";
         sequence.tile = map.tiles[8 + map.mapWidth * 15];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[9 + map.mapWidth * 7]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),2,2,215);
         m.displayLabel = "Defeat Virosaucer #1.";
         m.targetMobID = 101;
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),2,2,215);
         m.displayLabel = "Defeat Virosaucer #2.";
         m.targetMobID = 102;
         sequence.addObjective(m);
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
         return "The City of Raggabush";
      }
      
      override public function getActDescription() : String
      {
         return "Raggabush is requesting aid against Virosaucers that have invaded their city. Destroy the Virosaucers before they cause more trouble.";
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
         return 2;
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
         ach1 = new Achievement(pgame,102,"Completion Award","Complete Act 2 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,103,"Hard Achievement","Complete Act 2 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,104,"Heroic Achievement","Complete Act 2 in Heroic difficulty.",function():Boolean
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

