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
   import game.peacefree.mobs.RougeEmpress;
   
   public class Act6 extends Act
   {
      
      public static const MapInfo:Class = exmission16_txt;
      
      public function Act6()
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
         map.setStartTile(15,11);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.bUpdateOnFastForward = false;
         sequence.onUpdate = function():void
         {
            var _loc1_:Mob = new RougeEmpress(map.tiles[6 + map.mapWidth * 7]);
            _loc1_.missionObjID = 101;
            _loc1_.waypoints = new Array(8 + 8 * map.mapWidth,6 + 6 * map.mapWidth,-3);
            _loc1_.cycle = new Array(6,6,6,6,6,6,7);
            map.addMob(_loc1_);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 6]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 7]);
            map.makeVisibleTile(map.tiles[6 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[7 + map.mapWidth * 8]);
            map.makeVisibleTile(map.tiles[8 + map.mapWidth * 8]);
            map.updateMap();
         };
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "The enemy is using that thing to make more Giant Hornets!";
         sequence.tile = map.tiles[7 + map.mapWidth * 7];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "We need to destroy it before it overwhelms us!";
         sequence.tile = map.tiles[15 + map.mapWidth * 11];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),100,3,345);
         m.checkComplete = function():Boolean
         {
            return map.tiles[map.startPoint].building != null && (map.tiles[map.startPoint].building.type == 200 || map.tiles[map.startPoint].building.type == 301);
         };
         m.displayLabel = "Upgrade C. Center to unlock [T] HyPEL.";
         m.bNoShowMarker = true;
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),9,1,280);
         m.setTargetTile(map.tiles[15 + map.mapWidth * 11]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            map.showGameOver(false,"You lost your Command Center.");
         };
         sequence.addObjective(m);
         m = new MissionObjective(map,getNextMissionID(),2,2,255);
         m.targetMobID = 101;
         m.displayLabel = "Defeat the Rouge Empress.";
         sequence.addObjective(m);
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),3);
         sequence.onUpdate = function():void
         {
            win("You defeated the Rouge Empress!");
         };
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "The Rouge Empress";
      }
      
      override public function getActDescription() : String
      {
         return "The enemy is using a new bioweapon called the Rouge Empress to spawn more Giant Hornets to bolster their armies. Stop them at all costs.";
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
         return 6;
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
         ach1 = new Achievement(pgame,114,"Completion Award","Complete Act 6 in any difficulty.",function():Boolean
         {
            return map.bVictory;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,115,"Hard Achievement","Complete Act 6 in Hard difficulty.",function():Boolean
         {
            return map.bVictory && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,116,"Heroic Achievement","Complete Act 6 in Heroic difficulty.",function():Boolean
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

