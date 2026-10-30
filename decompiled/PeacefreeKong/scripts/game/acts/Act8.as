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
   import game.peacefree.mobs.NilHelios;
   
   public class Act8 extends Act
   {
      
      public static const MapInfo:Class = exmission7_txt;
      
      public function Act8()
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
         map.setStartTile(4,21);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Our mission today is to rescue several scientists abducted by the enemy!";
         sequence.tile = map.tiles[4 + map.mapWidth * 21];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            map.addMobGenerator(new MobGenerator(map.tiles[5 + map.mapWidth * 0],17,240000));
            map.makeVisibleTile(map.tiles[5 + map.mapWidth * 17]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Our scanners indicate they are somewhere in this area...";
         sequence.tile = map.tiles[5 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),4,0,420);
         m.bNoShowMarker = true;
         m.setTargetTile(map.tiles[5 + map.mapWidth * 17]);
         m.displayLabel = "Scout far away tiles to allow è Rescuing them.";
         m.expireDay = 5;
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[4 + map.mapWidth * 21]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),4,2,315);
         m.setTargetTile(map.tiles[5 + map.mapWidth * 17]);
         m.displayLabel = "Send è Rescue Team before Day 6.";
         m.expireDay = 5;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Hmm... Looks like the hornets have taken some of them elsewhere...";
         sequence.tile = map.tiles[5 + map.mapWidth * 17];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            map.addMobGenerator(new MobGenerator(map.tiles[21 + map.mapWidth * 0],18,240000));
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 17]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "I think we\'re picking up a faint distress call here!";
         sequence.tile = map.tiles[14 + map.mapWidth * 17];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.displayLabel = "Send è Rescue Team before Day 13.";
         m.setTargetTile(map.tiles[14 + map.mapWidth * 17]);
         m.expireDay = 12;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Hmm... Looks like some scientists have been taken to different places. We need to find them fast...";
         sequence.tile = map.tiles[14 + map.mapWidth * 17];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            map.addMobGenerator(new MobGenerator(map.tiles[12 + map.mapWidth * 0],17,240000 / 3));
            map.addMobGenerator(new MobGenerator(map.tiles[13 + map.mapWidth * 0],18,240000));
            map.makeVisibleTile(map.tiles[18 + map.mapWidth * 12]);
            map.makeVisibleTile(map.tiles[22 + map.mapWidth * 17]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Crud, a Nil Helios! They\'re far more dangerous than Hiveships... And when there\'s one of them, there\'s bound to be more!";
         sequence.tile = map.tiles[18 + map.mapWidth * 16];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new NilHelios(map.tiles[18 + map.mapWidth * 16]);
            _loc1_.cycle = new Array(7,5,5,5);
            _loc1_.waypoints = new Array(18 + map.mapWidth * 18,19 + map.mapWidth * 24);
            map.addMob(_loc1_);
            map.makeVisibleTile(map.tiles[17 + 15 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[18 + 15 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[19 + 15 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 16 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[18 + 16 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[19 + 16 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 17 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[18 + 17 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[19 + 17 * map.mapWidth]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "This one looks like it\'s going away... But we should fortify our defenses - just in case it comes back...";
         sequence.tile = map.tiles[18 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[18 + map.mapWidth * 12]);
         m.displayLabel = "Send è Rescue Team before Day 18.";
         m.expireDay = 17;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[22 + map.mapWidth * 17]);
         m.displayLabel = "Send è Rescue Team before Day 18.";
         m.expireDay = 17;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Only a few more people to rescue! However, I\'m detecting several ships headed our way...";
         sequence.tile = map.tiles[18 + map.mapWidth * 12];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            map.addMobGenerator(new MobGenerator(map.tiles[9 + map.mapWidth * 0],19,240000));
            map.addMobGenerator(new MobGenerator(map.tiles[24 + map.mapWidth * 11],12,240000 / 2));
            map.addMobGenerator(new MobGenerator(map.tiles[24 + map.mapWidth * 13],1,240000 / 3));
            map.makeVisibleTile(map.tiles[17 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[20 + map.mapWidth * 3]);
            map.makeVisibleTile(map.tiles[18 + map.mapWidth * 5]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[17 + map.mapWidth * 7]);
         m.displayLabel = "Send è Rescue Team before Day 25.";
         m.expireDay = 24;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[20 + map.mapWidth * 3]);
         m.displayLabel = "Send è Rescue Team before Day 25.";
         m.expireDay = 24;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[18 + map.mapWidth * 5]);
         m.displayLabel = "Send è Rescue Team before Day 25.";
         m.expireDay = 24;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We\'re almost done! Let\'s rescue the last scientists and get out of this place!";
         sequence.tile = map.tiles[18 + map.mapWidth * 5];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            map.addMobGenerator(new MobGenerator(map.tiles[5 + map.mapWidth * 0],3,240000 / 2));
            map.addMobGenerator(new MobGenerator(map.tiles[13 + map.mapWidth * 0],3,240000 / 2));
            map.makeVisibleTile(map.tiles[3 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 3]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 7]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[3 + map.mapWidth * 6]);
         m.displayLabel = "Send è Rescue Team before Day 32.";
         m.expireDay = 31;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[10 + map.mapWidth * 3]);
         m.displayLabel = "Send è Rescue Team before Day 32.";
         m.expireDay = 31;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),4,2,330);
         m.setTargetTile(map.tiles[8 + map.mapWidth * 7]);
         m.displayLabel = "Send è Rescue Team before Day 32.";
         m.expireDay = 31;
         m.onFail = function():void
         {
            map.showGameOver(false,"You ran out of time!");
         };
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = "obj_vurnax_listening";
         sequence.dialogue = "Oh, thank you for rescuing all of us!";
         sequence.tile = map.tiles[3 + map.mapWidth * 6];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new NilHelios(map.tiles[1 + 1 * map.mapWidth]);
            _loc1_.missionObjID = 101;
            _loc1_.cycle = new Array(1,3,2,0);
            map.addMob(_loc1_);
            _loc1_ = new NilHelios(map.tiles[9 + 1 * map.mapWidth]);
            _loc1_.missionObjID = 102;
            _loc1_.cycle = new Array(3,2,0,1);
            map.addMob(_loc1_);
            _loc1_ = new NilHelios(map.tiles[17 + 1 * map.mapWidth]);
            _loc1_.missionObjID = 103;
            _loc1_.cycle = new Array(2,0,1,3);
            map.addMob(_loc1_);
            _loc1_ = new NilHelios(map.tiles[23 + 9 * map.mapWidth]);
            _loc1_.missionObjID = 104;
            _loc1_.cycle = new Array(3,2,0,1);
            map.addMob(_loc1_);
            _loc1_ = new NilHelios(map.tiles[23 + 14 * map.mapWidth]);
            _loc1_.missionObjID = 105;
            _loc1_.cycle = new Array(1,3,2,0);
            map.addMob(_loc1_);
            _loc1_ = new NilHelios(map.tiles[23 + 21 * map.mapWidth]);
            _loc1_.missionObjID = 106;
            _loc1_.cycle = new Array(2,0,1,3);
            map.addMob(_loc1_);
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "You\'re welcome, but I don\'t think we\'re out of the woods just yet!";
         sequence.tile = map.tiles[1 + map.mapWidth * 1];
         sequence.onUpdate = function():void
         {
            map.makeVisibleTile(map.tiles[0 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[0 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[0 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[1 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[1 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[1 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[2 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[2 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[2 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[16 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[16 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[16 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[17 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[18 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[18 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[18 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[8 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[9 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[9 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[9 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[10 + 0 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[10 + 1 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[10 + 2 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 8 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 9 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 10 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 8 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 9 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 10 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 8 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 9 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 10 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 13 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 14 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 15 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 13 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 14 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 15 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 13 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 14 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 15 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 20 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 21 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[22 + 22 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 20 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 21 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[23 + 22 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 20 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 21 * map.mapWidth]);
            map.makeVisibleTile(map.tiles[24 + 22 * map.mapWidth]);
            map.updateMap();
            map.pauseBGM();
            map.stopBGM();
            map.bgList = new Array("danger");
            map.unpauseBGM();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Looks like they\'re still searching for the scientists! We need to fortify our base before they come after us!";
         sequence.tile = map.tiles[1 + 1 * map.mapWidth];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),100,3,345);
         m.expireDay = 34;
         m.checkComplete = function():Boolean
         {
            return map.tiles[map.startPoint].building != null && (map.tiles[map.startPoint].building.type == 200 || map.tiles[map.startPoint].building.type == 301);
         };
         m.displayLabel = "Upgrade C. Center to unlock [T] HyPEL.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),100,3,180);
         m.expireDay = 34;
         m.onComplete = function():void
         {
            win("You rescued the Scientists!");
         };
         m.checkComplete = function():Boolean
         {
            var _loc3_:int = 0;
            var _loc2_:Boolean = true;
            var _loc1_:int = int(map.mobs.length);
            while(_loc3_ < _loc1_)
            {
               if(map.mobs[_loc3_] is NilHelios)
               {
                  _loc2_ = false;
               }
               _loc3_++;
            }
            return _loc2_;
         };
         m.displayLabel = "Fortify Your Base.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),12,2,250);
         m.data = "34";
         m.displayLabel = "Nil Helios Attack on Day 35.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Heads up! The invasion fleet is heading our way! We need to destroy all 6 of their Nil Helioses!";
         sequence.tile = map.tiles[1 + 1 * map.mapWidth];
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = map.findMob(101);
            if(_loc1_ != null)
            {
               _loc1_.cycle = new Array(6,6,6,7);
            }
            _loc1_ = map.findMob(102);
            if(_loc1_ != null)
            {
               _loc1_.cycle = new Array(6,6,6,7);
            }
            _loc1_ = map.findMob(103);
            if(_loc1_ != null)
            {
               _loc1_.cycle = new Array(6,6,6,7);
            }
            _loc1_ = map.findMob(104);
            if(_loc1_ != null)
            {
               _loc1_.cycle = new Array(6,6,6,7);
            }
            _loc1_ = map.findMob(105);
            if(_loc1_ != null)
            {
               _loc1_.cycle = new Array(6,6,6,7);
            }
            _loc1_ = map.findMob(106);
            if(_loc1_ != null)
            {
               _loc1_.cycle = new Array(6,6,6,7);
            }
            if(map.difficulty == 2 || map.difficulty == 3)
            {
               map.addMobGenerator(new MobGenerator(map.tiles[24 + map.mapWidth * 18],2,240000));
               map.addMobGenerator(new MobGenerator(map.tiles[24 + map.mapWidth * 3],2,240000));
            }
            map.addMobGenerator(new MobGenerator(map.tiles[8 + map.mapWidth * 0],2,240000));
            map.addMobGenerator(new MobGenerator(map.tiles[24 + map.mapWidth * 15],12,240000 / 2));
            map.addMobGenerator(new MobGenerator(map.tiles[19 + map.mapWidth * 0],12,240000 / 2));
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,101,2,2,260);
         m.targetMobID = 101;
         m.displayLabel = "Destroy the Nil Helios #1.";
         sequence.addObjective(m);
         m = new MissionObjective(map,102,2,2,260);
         m.targetMobID = 102;
         m.displayLabel = "Destroy the Nil Helios #2.";
         sequence.addObjective(m);
         m = new MissionObjective(map,103,2,2,260);
         m.targetMobID = 103;
         m.displayLabel = "Destroy the Nil Helios #3.";
         sequence.addObjective(m);
         m = new MissionObjective(map,104,2,2,260);
         m.targetMobID = 104;
         m.displayLabel = "Destroy the Nil Helios #4.";
         sequence.addObjective(m);
         m = new MissionObjective(map,105,2,2,260);
         m.targetMobID = 105;
         m.displayLabel = "Destroy the Nil Helios #5.";
         sequence.addObjective(m);
         m = new MissionObjective(map,106,2,2,260);
         m.targetMobID = 106;
         m.displayLabel = "Destroy the Nil Helios #6.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "It was a tough battle, but that\'ll show them not to mess with you, Commander!";
         sequence.tile = map.tiles[map.startPoint];
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
            win("You rescued the Scientists!");
         };
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "Kidnapped Scientists";
      }
      
      override public function getActDescription() : String
      {
         return "The enemy used the Giant Hornets to kidnap several scientists. We need to follow their trail and rescue them before it\'s too late.";
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
         return 8;
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
         ach1 = new Achievement(pgame,120,"Completion Award","Complete Act 8 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,121,"Hard Achievement","Complete Act 8 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,122,"Heroic Achievement","Complete Act 8 in Heroic difficulty.",function():Boolean
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

