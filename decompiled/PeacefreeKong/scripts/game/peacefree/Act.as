package game.peacefree
{
   import game.acts.Act1;
   import game.acts.Act10;
   import game.acts.Act11;
   import game.acts.Act2;
   import game.acts.Act3;
   import game.acts.Act4;
   import game.acts.Act5;
   import game.acts.Act6;
   import game.acts.Act7;
   import game.acts.Act8;
   import game.acts.Act9;
   
   public class Act
   {
      
      public var map:Map;
      
      public var story:Array = [];
      
      public var achievements:Array = [];
      
      public var cache:Object = {};
      
      private var storyIDCounter:int = 0;
      
      private var missionIDCounter:int = 0;
      
      private var currentSequence:StorySequence = null;
      
      public var sequence:int = -1;
      
      public var completedMissions:Array = [];
      
      public function Act()
      {
         super();
      }
      
      public static function getAct(param1:int) : Act
      {
         var _loc2_:Act = null;
         switch(param1 - 2)
         {
            case 0:
               _loc2_ = new Act2();
               break;
            case 1:
               _loc2_ = new Act3();
               break;
            case 2:
               _loc2_ = new Act4();
               break;
            case 3:
               _loc2_ = new Act5();
               break;
            case 4:
               _loc2_ = new Act6();
               break;
            case 5:
               _loc2_ = new Act7();
               break;
            case 6:
               _loc2_ = new Act8();
               break;
            case 7:
               _loc2_ = new Act9();
               break;
            case 8:
               _loc2_ = new Act10();
               break;
            case 9:
               _loc2_ = new Act11();
               break;
            default:
               _loc2_ = new Act1();
         }
         try
         {
            _loc2_.initAchievements();
         }
         catch(error:Error)
         {
         }
         return _loc2_;
      }
      
      public function init(param1:Map, param2:Boolean = true) : void
      {
         this.map = param1;
      }
      
      public function initAchievements() : void
      {
      }
      
      public function getAchievements() : Array
      {
         return achievements;
      }
      
      public function getTotalAchievements() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < achievements.length)
         {
            if(achievements[_loc2_].isUnlocked())
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getNextStoryID() : int
      {
         return storyIDCounter++;
      }
      
      public function getNextMissionID() : int
      {
         return missionIDCounter++;
      }
      
      public function next() : void
      {
         if(currentSequence == null || currentSequence.isComplete())
         {
            sequence = sequence + 1;
            if(sequence < story.length)
            {
               currentSequence = story[sequence];
               currentSequence.update();
               map.mapHUD.setSequence(currentSequence);
               map.updateMap();
            }
         }
      }
      
      public function fastForwardTo(param1:int) : void
      {
         var _loc2_:int = 0;
         while(sequence < param1)
         {
            sequence = sequence + 1;
            currentSequence = story[sequence];
            currentSequence.update(true);
            if(story[sequence].type == 2)
            {
               _loc2_ = 0;
               while(_loc2_ < story[sequence].objectives.length)
               {
                  if(story[sequence].objectives[_loc2_].priorityType == 1)
                  {
                     map.mapHUD.addObjective(story[sequence].objectives[_loc2_]);
                  }
                  _loc2_++;
               }
            }
         }
         map.mapHUD.setSequence(currentSequence);
         map.updateMap();
         map.dialogueInterfacer.hide();
      }
      
      public function completeMission(param1:int) : void
      {
         completedMissions.push(param1);
      }
      
      public function getActTitle() : String
      {
         return "The Taltana Harbor Incident";
      }
      
      public function getActDescription() : String
      {
         return "The spaceport Taltana Harbor is under attack from Hiveships by the evil Virpuris. Peacefree HQ quickly dispatches you and your team to rescue the city.";
      }
      
      public function getData() : Object
      {
         var _loc1_:Object = {};
         _loc1_.actNumber = getActNumber();
         _loc1_.sequence = sequence;
         _loc1_.completedMissions = completedMissions;
         _loc1_.cache = cache;
         return _loc1_;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(story != null)
         {
            _loc1_ = 0;
            while(_loc1_ < story.length)
            {
               story[_loc1_].dispose();
               _loc1_++;
            }
            story.splice(0);
         }
         if(achievements != null)
         {
            _loc1_ = 0;
            while(_loc1_ < achievements.length)
            {
               achievements[_loc1_].dispose();
               _loc1_++;
            }
            achievements.splice(0);
         }
         if(completedMissions != null)
         {
            completedMissions.splice(0);
         }
         if(currentSequence != null)
         {
            currentSequence.dispose();
         }
         map = null;
         story = null;
         achievements = null;
         cache = null;
         currentSequence = null;
         completedMissions = null;
      }
      
      public function onEscaped() : void
      {
      }
      
      public function onNewDay() : void
      {
      }
      
      public function onNewSpawn(param1:Mob) : void
      {
      }
      
      public function getActNumber() : int
      {
         return -1;
      }
   }
}

