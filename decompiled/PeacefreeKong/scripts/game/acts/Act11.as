package game.acts
{
   import game.library.MapLibrary;
   import game.library.MathLibrary;
   import game.peacefree.Achievement;
   import game.peacefree.Act;
   import game.peacefree.Building;
   import game.peacefree.Map;
   import game.peacefree.MissionObjective;
   import game.peacefree.Mob;
   import game.peacefree.PeacefreeGame;
   import game.peacefree.RandomMapGenerator;
   import game.peacefree.StorySequence;
   import game.peacefree.mobs.GiasRobo;
   import game.peacefree.mobs.Jenygrin;
   import game.peacefree.mobs.NilHelios;
   import game.peacefree.mobs.RougeEmpress;
   
   public class Act11 extends Act
   {
      
      private var spawnAreas:Array = new Array(0,150,300,450,600,24,174,324,474,624,6,12,18,606,612,618);
      
      public function Act11()
      {
         super();
      }
      
      override public function init(param1:Map, param2:Boolean = true) : void
      {
         var actNumber:int;
         var mapData:String;
         var startPoint:int;
         var sequence:StorySequence;
         var m:MissionObjective;
         var map:Map = param1;
         var bLoadMap:Boolean = param2;
         super.init(map);
         actNumber = getActNumber();
         if(bLoadMap)
         {
            mapData = RandomMapGenerator.generate();
            map.loadMap(MapLibrary.parseMapData(mapData));
            startPoint = 12 + 12 * map.mapWidth;
            map.tiles[startPoint].setBuilding(new Building(100,map.tiles[startPoint]));
         }
         map.setStartTile(12,12);
         map.bgList = new Array("act_2_0","act_2_1");
         sequence = new StorySequence(map,getNextStoryID(),1);
         sequence.portrait = null;
         sequence.dialogue = "Defend your base for as long as you can!";
         sequence.tile = map.tiles[map.startPoint];
         story.push(sequence);
         sequence = new StorySequence(map,getNextStoryID(),2);
         m = new MissionObjective(map,getNextMissionID(),9,2,320);
         m.setTargetTile(map.tiles[map.startPoint]);
         m.displayLabel = "Protect your Command Center.";
         m.onComplete = function():void
         {
            var _loc1_:int = 0;
            if(map.days >= 100)
            {
               map.showGameOver(false,"You survived at least 100 days.");
               _loc1_ = 0;
               while(_loc1_ < achievements.length)
               {
                  if(!achievements[_loc1_].isUnlocked() && achievements[_loc1_].check())
                  {
                     achievements[_loc1_].unlock();
                  }
                  _loc1_++;
               }
            }
            else
            {
               map.showGameOver(false,"You did not survive 100 days.");
            }
         };
         sequence.addObjective(m);
         story.push(sequence);
      }
      
      override public function getActTitle() : String
      {
         return "For Freedom and Justice";
      }
      
      override public function getActDescription() : String
      {
         return "Put your skills to the test! Enemy bosses will apprear randomly on the edge of the map. See how long you can last against endless boss battles. Survive for at least 100 days to unlock achievements!!";
      }
      
      override public function onNewDay() : void
      {
         var _loc2_:int = 0;
         if(map.days < 10 && map.days % 2 == 1)
         {
            return;
         }
         var _loc1_:int = int(spawnAreas[MathLibrary.randomize(0,spawnAreas.length - 1)]);
         if(map.days < 10)
         {
            switch(MathLibrary.randomize(0,3))
            {
               case 0:
                  _loc2_ = 0;
                  while(_loc2_ < 4 + map.days * 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],13));
                     _loc2_++;
                  }
                  break;
               case 1:
                  _loc2_ = 0;
                  while(_loc2_ < 1 + map.days / 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],12));
                     _loc2_++;
                  }
                  break;
               case 2:
                  _loc2_ = 0;
                  while(_loc2_ < 1 + map.days / 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],1));
                     _loc2_++;
                  }
                  break;
               case 3:
                  _loc2_ = 0;
                  while(_loc2_ < 1 + map.days / 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],17));
                     _loc2_++;
                  }
            }
         }
         else if(map.days < 20)
         {
            switch(MathLibrary.randomize(0,6))
            {
               case 0:
                  _loc2_ = 0;
                  while(_loc2_ < 10 + map.days * 3)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],13));
                     _loc2_++;
                  }
                  break;
               case 1:
                  _loc2_ = 0;
                  while(_loc2_ < map.days * 1.5)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],12));
                     _loc2_++;
                  }
                  break;
               case 2:
                  _loc2_ = 0;
                  while(_loc2_ < map.days * 1.5)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],1));
                     _loc2_++;
                  }
                  break;
               case 3:
                  _loc2_ = 0;
                  while(_loc2_ < map.days * 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],17));
                     _loc2_++;
                  }
                  break;
               case 4:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 3)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],3));
                     _loc2_++;
                  }
                  break;
               case 5:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 10)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],2));
                     _loc2_++;
                  }
                  break;
               case 6:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],18));
                     _loc2_++;
                  }
            }
         }
         else
         {
            switch(MathLibrary.randomize(0,12))
            {
               case 0:
                  _loc2_ = 0;
                  while(_loc2_ < 10 + map.days * 4)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],13));
                     _loc2_++;
                  }
                  break;
               case 1:
                  _loc2_ = 0;
                  while(_loc2_ < 10 + map.days * 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],12));
                     _loc2_++;
                  }
                  break;
               case 2:
                  _loc2_ = 0;
                  while(_loc2_ < 10 + map.days * 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],1));
                     _loc2_++;
                  }
                  break;
               case 3:
                  _loc2_ = 0;
                  while(_loc2_ < 20 + map.days * 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],17));
                     _loc2_++;
                  }
                  break;
               case 4:
                  _loc2_ = 0;
                  while(_loc2_ < 10 + map.days / 2)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],3));
                     _loc2_++;
                  }
                  break;
               case 5:
                  _loc2_ = 0;
                  while(_loc2_ < 5 + map.days / 5)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],2));
                     _loc2_++;
                  }
                  break;
               case 6:
                  _loc2_ = 0;
                  while(_loc2_ < map.days)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],18));
                     _loc2_++;
                  }
                  break;
               case 7:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 10)
                  {
                     map.addMob(new GiasRobo(map.tiles[_loc1_]));
                     _loc2_++;
                  }
                  break;
               case 8:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 10)
                  {
                     map.addMob(new RougeEmpress(map.tiles[_loc1_]));
                     _loc2_++;
                  }
                  break;
               case 9:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 10)
                  {
                     map.addMob(new Jenygrin(map.tiles[_loc1_],2));
                     _loc2_++;
                  }
                  break;
               case 10:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 10)
                  {
                     map.addMob(new NilHelios(map.tiles[_loc1_]));
                     _loc2_++;
                  }
                  break;
               case 11:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 4)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],19));
                     _loc2_++;
                  }
                  break;
               case 12:
                  _loc2_ = 0;
                  while(_loc2_ < map.days / 4)
                  {
                     map.addMob(new Mob(map.tiles[_loc1_],20));
                     _loc2_++;
                  }
            }
         }
      }
      
      override public function dispose() : void
      {
         if(spawnAreas != null)
         {
            spawnAreas.splice(0);
         }
         spawnAreas = null;
         super.dispose();
      }
      
      override public function getActNumber() : int
      {
         return 11;
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
         ach1 = new Achievement(pgame,129,"Survival Award","Survive 100 days in any difficulty.",function():Boolean
         {
            return map.days >= 100;
         });
         achievements.push(ach1);
         ach2 = new Achievement(pgame,130,"Hard Achievement","Survive 100 days in Hard difficulty.",function():Boolean
         {
            return map.days >= 100 && map.difficulty >= 2;
         });
         achievements.push(ach2);
         ach3 = new Achievement(pgame,131,"Heroic Achievement","Survive 100 days in Heroic difficulty.",function():Boolean
         {
            return map.days >= 100 && map.difficulty >= 3;
         });
         achievements.push(ach3);
      }
   }
}

