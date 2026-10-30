package
{
   import flash.media.Sound;
   import game.library.SoundLibrary;
   
   public class SoundAssets
   {
      
      public static var poof:Class = poof_mp3;
      
      public static var click:Class = click_mp3$159ac1dbcdf6925f6bb1e8b78687f9b7656112553;
      
      public static var powerup:Class = powerup_mp3$ed337927ffabb8ea23d2223cdeb1e3921374468945;
      
      public static var zap:Class = zap_mp3$86c363d208a24b9aebd32f9d7e34b7c3716557576;
      
      public static var aid:Class = aid_mp3$89be087682fb9d0e2a7a99067ad51ede137867133;
      
      public static var alarm:Class = alarm_mp3;
      
      public static var charging:Class = charging_mp3$80630e7d33e9fc7a0a042ba427eeed0072448916;
      
      public static var fireshell:Class = fireshell_mp3;
      
      public static var act_2_0:Class = act_2_0_lo_mp3$7aa5976187d1056c7f360b07506101441376114129;
      
      public static var act_2_1:Class = act_2_1_lo_mp3;
      
      public static var danger:Class = danger_lo_mp3$7eb60fa78821ff7ed76ecefbbf5d6b5d54289054;
      
      public static var main_menu:Class = main_menu_lo_mp3$6d94c7db1844dfce1d14a63cf477b52c380216352;
      
      public static var airlock:Class = airlock_mp3$3256a57de2a9c1f7e88789ad7a102909283715524;
      
      public function SoundAssets()
      {
         super();
      }
      
      public static function init() : void
      {
         SoundLibrary.getInstance().save("poof",Sound(new poof()));
         SoundLibrary.getInstance().save("click",Sound(new click()));
         SoundLibrary.getInstance().save("powerup",Sound(new powerup()));
         SoundLibrary.getInstance().save("zap",Sound(new zap()));
         SoundLibrary.getInstance().save("aid",Sound(new aid()));
         SoundLibrary.getInstance().save("alarm",Sound(new alarm()));
         SoundLibrary.getInstance().save("charging",Sound(new charging()));
         SoundLibrary.getInstance().save("fireshell",Sound(new fireshell()));
         SoundLibrary.getInstance().save("act_2_0",Sound(new act_2_0()));
         SoundLibrary.getInstance().save("act_2_1",Sound(new act_2_1()));
         SoundLibrary.getInstance().save("main_menu",Sound(new main_menu()));
         SoundLibrary.getInstance().save("danger",Sound(new danger()));
         SoundLibrary.getInstance().save("airlock",Sound(new airlock()));
      }
   }
}

