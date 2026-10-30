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
   
   public class Act3 extends Act
   {
      
      public static const MapInfo:Class = exmission12_txt;
      
      public function Act3()
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
         map.setStartTile(12,16);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new Mob(map.tiles[12 + map.mapWidth * 8],2);
            _loc1_.missionObjID = 101;
            _loc1_.waypoints = new Array(10 + map.mapWidth * 9,10 + map.mapWidth * 7,15 + map.mapWidth * 7,15 + map.mapWidth * 9,-3);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[10 + map.mapWidth * 12],3);
            _loc1_.cycle = new Array(2,2,3,3,0,0,1,1);
            map.addMob(_loc1_);
            _loc1_ = new Mob(map.tiles[14 + map.mapWidth * 12],3);
            _loc1_.cycle = new Array(2,3,3,0,0,1,1,2);
            map.addMob(_loc1_);
            map.addMobGenerator(new MobGenerator(map.tiles[11 + map.mapWidth * 5],13,240000,0,240000 * -1));
            map.addMobGenerator(new MobGenerator(map.tiles[14 + map.mapWidth * 5],13,240000,0,240000 * -1));
            map.addMobGenerator(new MobGenerator(map.tiles[12 + map.mapWidth * 5],1,240000,0,240000 * -2));
            map.addMobGenerator(new MobGenerator(map.tiles[13 + map.mapWidth * 5],1,240000,0,240000 * -4));
            map.addMobGenerator(new MobGenerator(map.tiles[10 + map.mapWidth * 5],3,240000,0,240000 * -7));
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[11 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[12 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[11 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[12 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[10 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[11 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[12 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[13 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[14 + map.mapWidth * 9]);
            map.makeVisibleTile(map.tiles[15 + map.mapWidth * 9]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "That boss enemy bioship is terrorizing this area!";
         sequence.tile = map.tiles[12 + map.mapWidth * 8];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We don\'t have a mineral field, but we can use Port Shuttles to trade È to Â!";
         sequence.tile = map.tiles[13 + map.mapWidth * 16];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[12 + 16 * map.mapWidth]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),9,0,320);
         m.bNoShowMarker = true;
         m.displayLabel = "Use Port Shuttles to trade È to Â.";
         m.setTargetTile(map.tiles[12 + 16 * map.mapWidth]);
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),2,2,250);
         m.targetMobID = 101;
         m.displayLabel = "Defeat the Boss Hiveship.";
         sequence.addObjective(m);
         story.push(sequence);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            win("You defeated the Boss Hiveship!");
         };
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "Duel with a Hiveship";
      }
      
      override public function getActDescription() : String
      {
         return "A large enemy bioship called a Hiveship has been spotted looming over the city. Destory it before it calls for more reinforcements to the area.";
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
         return 3;
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
         ach1 = new Achievement(pgame,105,"Completion Award","Complete Act 3 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,106,"Hard Achievement","Complete Act 3 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,107,"Heroic Achievement","Complete Act 3 in Heroic difficulty.",function():Boolean
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

