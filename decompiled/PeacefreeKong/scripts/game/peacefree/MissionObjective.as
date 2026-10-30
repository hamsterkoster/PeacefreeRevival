package game.peacefree
{
   import game.library.SortObject;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class MissionObjective extends SortObject
   {
      
      public static const MISSION_SECURE_AREA:int = 1;
      
      public static const MISSION_DEFEAT_ENEMY:int = 2;
      
      public static const MISSION_SCOUT_AREA:int = 3;
      
      public static const MISSION_RESCUE_AREA:int = 4;
      
      public static const MISSION_SALVAGE_AREA:int = 5;
      
      public static const MISSION_BUILD_STRUCTURE:int = 6;
      
      public static const MISSION_HARVEST_LUMBER:int = 7;
      
      public static const MISSION_DISCOVER_AREA:int = 8;
      
      public static const MISSION_PROTECT_AREA:int = 9;
      
      public static const MISSION_DEMOLISH_AREA:int = 10;
      
      public static const MISSION_SURVIVE:int = 11;
      
      public static const MISSION_TIMER:int = 12;
      
      public static const MISSION_PROTECT_BUILDING:int = 13;
      
      public static const MISSION_CUSTOM:int = 100;
      
      public static const PRIORITY_DISPLAY:int = 0;
      
      public static const PRIORITY_GAME:int = 1;
      
      public static const PRIORITY_MAIN:int = 2;
      
      public static const PRIORITY_OPTIONAL:int = 3;
      
      public static const PRIORITY_EVENT:int = 4;
      
      public var missionType:int;
      
      public var priorityType:int;
      
      public var data:String = null;
      
      public var displayLabel:String = null;
      
      public var id:int;
      
      public var bNoShowMarker:Boolean = false;
      
      public var expireDay:int = -1;
      
      public var boxWidth:int = 250;
      
      public var checkComplete:Function = null;
      
      public var onComplete:Function = null;
      
      public var tile:Tile = null;
      
      public var mob:Mob = null;
      
      private var icon:String = "&w";
      
      private var bTrash:Boolean = false;
      
      private var map:Map;
      
      public var textSprite:Sprite;
      
      public var markerSprite:MovieClip;
      
      private var tween_pulseArrow:Tween;
      
      public var mobGenerator:MobGenerator = null;
      
      private var daysCounter:int;
      
      public var getDynamicDisplay:Function = null;
      
      public var onFail:Function = null;
      
      public var targetMobID:int = -1;
      
      public function MissionObjective(param1:Map, param2:int, param3:int, param4:int, param5:int = 240)
      {
         super();
         this.map = param1;
         this.id = param2;
         this.missionType = param3;
         this.boxWidth = param5;
         this.priorityType = param4;
         switch(param4)
         {
            case 0:
            case 1:
               markerSprite = new MovieClip(Assets.getAtlas().getTextures("marker_1_"));
               icon = "Þ";
               break;
            case 2:
               markerSprite = new MovieClip(Assets.getAtlas().getTextures("marker_2_"));
               icon = "Ü";
               break;
            case 3:
               markerSprite = new MovieClip(Assets.getAtlas().getTextures("marker_3_"));
               icon = "Þ";
         }
         markerSprite.setFrameDuration(0,1);
      }
      
      public function startPulseArrow() : void
      {
         if(tween_pulseArrow != null)
         {
            Starling.juggler.remove(tween_pulseArrow);
         }
         if(isTrash())
         {
            return;
         }
         try
         {
            tween_pulseArrow = new Tween(markerSprite,0.5);
            if(markerSprite.y > getCanvasY())
            {
               tween_pulseArrow.moveTo(getCanvasX(),getCanvasY());
            }
            else
            {
               tween_pulseArrow.moveTo(getCanvasX(),getCanvasY() + 20);
            }
            tween_pulseArrow.onComplete = startPulseArrow;
            Starling.juggler.add(tween_pulseArrow);
         }
         catch(error:Error)
         {
         }
      }
      
      public function getCanvasX() : int
      {
         if(mob != null)
         {
            return mob.getCanvasX() + 112 / 2 - markerSprite.width / 2;
         }
         if(tile != null)
         {
            return tile.getCanvasX() + 112 / 2 - markerSprite.width / 2;
         }
         return -1000;
      }
      
      public function getCanvasY() : int
      {
         if(mob != null)
         {
            return mob.getCanvasY() + mob.getMarkerFloat();
         }
         if(tile != null)
         {
            return tile.getCanvasY();
         }
         return -1000;
      }
      
      public function setTargetTile(param1:Tile) : void
      {
         this.tile = param1;
         if(bNoShowMarker)
         {
            return;
         }
         markerSprite.x = param1.getCanvasX() + 112 / 2 - markerSprite.width / 2;
         markerSprite.y = param1.getCanvasY() + 20;
         startPulseArrow();
      }
      
      public function setTargetMob(param1:Mob) : void
      {
         this.mob = param1;
         if(bNoShowMarker || param1 == null)
         {
            return;
         }
         markerSprite.x = param1.getCanvasX() + param1.width / 2 - markerSprite.width / 2;
         markerSprite.y = param1.getCanvasY() + 20;
         startPulseArrow();
      }
      
      public function isComplete() : Boolean
      {
         switch(missionType)
         {
            case 1:
               if(tile.bSecured)
               {
                  return true;
               }
               break;
            case 3:
               if(tile.bScouted)
               {
                  return true;
               }
               break;
            case 5:
               if(tile.food == 0 && tile.minerals == 0)
               {
                  return true;
               }
               break;
            case 8:
               if(tile.bScoutedNearby)
               {
                  return true;
               }
               break;
            case 9:
               if(!tile.bSecured)
               {
                  return true;
               }
               break;
            case 4:
               if(tile.bRescued)
               {
                  return true;
               }
               break;
            case 6:
               if(tile.building != null && tile.building.type == int(data))
               {
                  return true;
               }
               break;
            case 10:
               if(tile.building == null || tile.building.type != int(data))
               {
                  return true;
               }
               break;
            case 11:
               if(daysCounter < int(map.days))
               {
                  return true;
               }
               break;
            case 12:
               if(daysCounter < int(map.days))
               {
                  return true;
               }
               break;
            case 100:
               return checkComplete();
            case 2:
               if(mob == null && targetMobID != -1)
               {
                  setTargetMob(map.findMob(targetMobID));
               }
               return mob == null || mob.isTrash();
         }
         return false;
      }
      
      public function complete() : void
      {
         if(onComplete != null)
         {
            onComplete();
         }
         map.act.completeMission(id);
         trash();
         if(markerSprite != null)
         {
            markerSprite.removeFromParent(true);
         }
      }
      
      public function getTitle() : String
      {
         var _loc1_:String = null;
         if(displayLabel != null)
         {
            return icon + " " + displayLabel;
         }
         if(getDynamicDisplay != null)
         {
            return getDynamicDisplay();
         }
         switch(missionType - 1)
         {
            case 0:
               if(tile.building != null)
               {
                  _loc1_ = Building.getBuildingName(tile.building.type);
               }
               else
               {
                  _loc1_ = tile.tileName;
               }
               return icon + " Secure " + _loc1_ + ".";
            case 2:
               if(tile.building != null)
               {
                  _loc1_ = Building.getBuildingName(tile.building.type);
               }
               else
               {
                  _loc1_ = tile.tileName;
               }
               return icon + " Scout " + _loc1_ + ".";
            case 3:
               return icon + " Rescue prisoners.";
            case 4:
               return icon + " Salvage resources.";
            case 5:
               return icon + " Build " + Building.getBuildingName(int(data)) + ".";
            case 6:
               return icon + " Harvest lumber.";
            case 7:
               return icon + " " + data;
            case 8:
            case 12:
               if(tile.building != null)
               {
                  _loc1_ = Building.getBuildingName(tile.building.type);
               }
               else
               {
                  _loc1_ = tile.tileName;
               }
               return icon + " Protect " + _loc1_ + ".";
            case 9:
               if(tile.building != null)
               {
                  _loc1_ = Building.getBuildingName(tile.building.type);
               }
               else
               {
                  _loc1_ = tile.tileName;
               }
               return icon + " Demolish " + _loc1_ + ".";
            case 10:
               return icon + " Survive Day " + daysCounter + ".";
            case 11:
               return icon + " Wait until day #" + data + ".";
            default:
               return "";
         }
      }
      
      public function progress(param1:int) : void
      {
         if(isTrash())
         {
            return;
         }
         if(expireDay != -1 && expireDay < map.days)
         {
            if(onFail != null)
            {
               onFail();
            }
            trash();
            return;
         }
      }
      
      public function init() : void
      {
         if(missionType == 11)
         {
            daysCounter = int(data) + map.days;
         }
         else if(missionType == 12)
         {
            daysCounter = int(data);
         }
         if(mobGenerator != null)
         {
            mobGenerator.missionID = id;
         }
         if(targetMobID != -1)
         {
            setTargetMob(map.findMob(targetMobID));
         }
      }
      
      public function getTileAt() : Tile
      {
         var _loc1_:Tile = null;
         switch(missionType)
         {
            case 1:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 100:
               _loc1_ = tile;
               break;
            case 2:
               _loc1_ = mob.tile;
         }
         return _loc1_;
      }
      
      override public function getSortValue(param1:int, param2:SortObject) : Number
      {
         var _loc3_:MissionObjective = MissionObjective(param2);
         return priorityType > _loc3_.priorityType ? 1 : 0;
      }
      
      public function isTrash() : Boolean
      {
         return bTrash;
      }
      
      public function trash() : void
      {
         bTrash = true;
         markerSprite.removeFromParent(true);
         Starling.juggler.remove(tween_pulseArrow);
         if(mobGenerator != null)
         {
            mobGenerator.trash();
         }
      }
      
      public function dispose() : void
      {
         if(textSprite != null)
         {
            textSprite.removeFromParent(true);
         }
         if(markerSprite != null)
         {
            Starling.juggler.remove(markerSprite);
            markerSprite.removeFromParent(true);
         }
         if(tween_pulseArrow != null)
         {
            Starling.juggler.remove(tween_pulseArrow);
         }
         if(mobGenerator != null)
         {
            mobGenerator.dispose();
         }
         data = null;
         displayLabel = null;
         checkComplete = null;
         onComplete = null;
         tile = null;
         mob = null;
         icon = null;
         map = null;
         textSprite = null;
         markerSprite = null;
         tween_pulseArrow = null;
         mobGenerator = null;
         getDynamicDisplay = null;
         onFail = null;
      }
   }
}

