package game.peacefree
{
   import game.library.MathLibrary;
   
   public class RandomMapGenerator
   {
      
      public function RandomMapGenerator()
      {
         super();
      }
      
      public static function generate() : String
      {
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc23_:int = 0;
         var _loc27_:int = 0;
         var _loc19_:String = null;
         var _loc34_:Array = null;
         var _loc26_:int = 0;
         var _loc15_:Array = null;
         var _loc29_:Array = null;
         var _loc41_:* = 0;
         var _loc39_:* = 0;
         var _loc22_:int = 0;
         var _loc16_:int = 0;
         var _loc38_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc28_:int = 0;
         var _loc14_:int = 0;
         var _loc30_:int = 0;
         var _loc32_:int = 0;
         _loc41_ = 0;
         _loc39_ = 0;
         _loc22_ = 0;
         _loc16_ = 0;
         _loc38_ = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc28_ = 0;
         _loc14_ = 0;
         _loc30_ = 0;
         _loc32_ = 0;
         _loc41_ = 0;
         _loc39_ = 0;
         _loc22_ = 0;
         var _loc17_:String = null;
         var _loc31_:int = 0;
         var _loc37_:int = 0;
         var _loc21_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:Array = [];
         _loc8_[0] = "29,7,7,7,29;29,7,7,7,29;7,7,7,7,7;7,7,7,7,7;7,7,7,7,7;";
         _loc8_[1] = "29,7,7,7,29;7,7,7,7,7;7,7,7,7,7;7,7,7,7,7;29,7,7,7,29;";
         _loc8_[2] = "29,29,29,29,29;7,7,7,29,29;7,7,7,7,29;7,7,7,7,29;7,7,7,29,29;";
         _loc8_[3] = "29,7,7,7,7;29,7,7,7,7;7,7,7,7,7;7,7,7,7,7;7,7,7,29,29;";
         _loc8_[4] = "7,7,7,29,29;7,7,7,29,29;7,7,7,7,29;7,7,7,7,29;29,7,7,7,29;";
         _loc8_[5] = "29,29,29,29,29;29,29,7,7,7;29,7,7,7,7;29,7,7,7,7;29,7,7,7,7;";
         _loc8_[6] = "29,29,29,29,29;29,15,15,15,29;29,15,30,15,29;29,15,15,15,29;29,29,29,29,29;";
         _loc8_[7] = "7,7,7,29,29;7,7,7,29,29;7,7,29,29,29;7,7,29,35,29;29,29,29,29,29;";
         var _loc7_:int = 20;
         var _loc33_:int = 20;
         var _loc12_:int = 3;
         var _loc40_:int = 2;
         var _loc6_:int = 10;
         var _loc20_:int = 10;
         var _loc18_:int = 10;
         var _loc1_:int = 3;
         var _loc5_:int = 3;
         var _loc10_:int = 2;
         var _loc4_:int = 2;
         var _loc36_:Array = [];
         _loc27_ = 0;
         while(_loc27_ < 25)
         {
            _loc36_[_loc27_] = "";
            _loc27_++;
         }
         _loc27_ = 0;
         while(_loc27_ < 5)
         {
            _loc23_ = 0;
            while(_loc23_ < 5)
            {
               _loc19_ = _loc8_[MathLibrary.randomize(0,_loc8_.length - 1)];
               _loc34_ = _loc19_.split(";");
               _loc24_ = 0;
               while(_loc24_ < 5)
               {
                  _loc26_ = _loc27_ * 5 + _loc24_;
                  _loc15_ = _loc34_[_loc24_].split(",");
                  _loc25_ = 0;
                  while(_loc25_ < _loc15_.length)
                  {
                     var _loc42_:* = _loc26_;
                     var _loc43_:* = _loc36_[_loc42_] + (_loc15_[_loc25_] + ",");
                     _loc36_[_loc42_] = _loc43_;
                     _loc25_++;
                  }
                  _loc24_++;
               }
               _loc23_++;
            }
            _loc27_++;
         }
         var _loc11_:Array = [];
         var _loc13_:Array = [];
         _loc27_ = 0;
         while(_loc27_ < _loc36_.length)
         {
            _loc29_ = _loc36_[_loc27_].split(",");
            _loc24_ = 0;
            while(_loc24_ < _loc29_.length)
            {
               _loc11_[_loc27_ * 25 + _loc24_] = parseInt(_loc29_[_loc24_]);
               _loc24_++;
            }
            _loc27_++;
         }
         _loc27_ = 0;
         while(_loc27_ < 25)
         {
            _loc24_ = 0;
            while(_loc24_ < 25)
            {
               _loc41_ = _loc24_;
               _loc39_ = _loc27_;
               _loc22_ = int(_loc11_[_loc27_ * 25 + _loc24_]);
               if(_loc22_ == 7)
               {
                  _loc16_ = -1;
                  _loc38_ = -1;
                  _loc2_ = -1;
                  _loc3_ = -1;
                  _loc28_ = -1;
                  _loc14_ = -1;
                  _loc30_ = -1;
                  _loc32_ = -1;
                  if(_loc41_ > 0)
                  {
                     _loc3_ = int(_loc11_[_loc41_ - 1 + _loc39_ * 25]);
                  }
                  if(_loc39_ > 0)
                  {
                     _loc16_ = int(_loc11_[_loc41_ + (_loc39_ - 1) * 25]);
                     if(_loc41_ > 0)
                     {
                        _loc28_ = int(_loc11_[_loc41_ - 1 + (_loc39_ - 1) * 25]);
                     }
                     if(_loc41_ < 24)
                     {
                        _loc14_ = int(_loc11_[_loc41_ + 1 + (_loc39_ - 1) * 25]);
                     }
                  }
                  if(_loc41_ < 24)
                  {
                     _loc2_ = int(_loc11_[_loc41_ + 1 + _loc39_ * 25]);
                  }
                  if(_loc39_ < 24)
                  {
                     _loc38_ = int(_loc11_[_loc41_ + (_loc39_ + 1) * 25]);
                     if(_loc41_ > 0)
                     {
                        _loc30_ = int(_loc11_[_loc41_ - 1 + (_loc39_ + 1) * 25]);
                     }
                     if(_loc41_ < 24)
                     {
                        _loc32_ = int(_loc11_[_loc41_ + 1 + (_loc39_ + 1) * 25]);
                     }
                  }
                  if(!isGrassTile(_loc16_) && !isGrassTile(_loc3_) && isGrassTile(_loc2_) && isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 2;
                  }
                  else if(!isGrassTile(_loc16_) && isGrassTile(_loc3_) && isGrassTile(_loc2_) && isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 3;
                  }
                  else if(!isGrassTile(_loc16_) && isGrassTile(_loc3_) && !isGrassTile(_loc2_) && isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 4;
                  }
                  else if(isGrassTile(_loc16_) && !isGrassTile(_loc3_) && isGrassTile(_loc2_) && isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 5;
                  }
                  else if(isGrassTile(_loc16_) && isGrassTile(_loc3_) && isGrassTile(_loc2_) && isGrassTile(_loc38_))
                  {
                     if(!isGrassTile(_loc32_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 11;
                     }
                     else if(!isGrassTile(_loc14_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 12;
                     }
                     else if(!isGrassTile(_loc28_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 13;
                     }
                     else if(!isGrassTile(_loc30_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 14;
                     }
                     else
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 6;
                     }
                  }
                  else if(isGrassTile(_loc16_) && isGrassTile(_loc3_) && !isGrassTile(_loc2_) && isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 7;
                  }
                  else if(isGrassTile(_loc16_) && !isGrassTile(_loc3_) && isGrassTile(_loc2_) && !isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 8;
                  }
                  else if(isGrassTile(_loc16_) && isGrassTile(_loc3_) && isGrassTile(_loc2_) && !isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 9;
                  }
                  else if(isGrassTile(_loc16_) && isGrassTile(_loc3_) && !isGrassTile(_loc2_) && !isGrassTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 10;
                  }
                  else if(isGrassTile(_loc11_[_loc41_ + _loc39_ * 25]))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 32;
                  }
                  if(MathLibrary.randomize(0,100) < _loc7_)
                  {
                     switch(_loc11_[_loc41_ + _loc39_ * 25])
                     {
                        case 2:
                           _loc13_[_loc41_ + _loc39_ * 25] = 14;
                           break;
                        case 3:
                           _loc13_[_loc41_ + _loc39_ * 25] = 21;
                           break;
                        case 4:
                           _loc13_[_loc41_ + _loc39_ * 25] = 20;
                           break;
                        case 5:
                           _loc13_[_loc41_ + _loc39_ * 25] = 15;
                           break;
                        case 6:
                           _loc13_[_loc41_ + _loc39_ * 25] = 10;
                           break;
                        case 7:
                           _loc13_[_loc41_ + _loc39_ * 25] = 19;
                           break;
                        case 8:
                           _loc13_[_loc41_ + _loc39_ * 25] = 16;
                           break;
                        case 9:
                           _loc13_[_loc41_ + _loc39_ * 25] = 17;
                           break;
                        case 10:
                           _loc13_[_loc41_ + _loc39_ * 25] = 18;
                           break;
                        default:
                           _loc13_[_loc41_ + _loc39_ * 25] = 10;
                     }
                  }
                  else if(MathLibrary.randomize(0,100) < _loc33_)
                  {
                     switch(_loc11_[_loc41_ + _loc39_ * 25])
                     {
                        case 6:
                           if(MathLibrary.randomize(0,100) > 50)
                           {
                              _loc13_[_loc41_ + _loc39_ * 25] = 30;
                           }
                           else
                           {
                              _loc13_[_loc41_ + _loc39_ * 25] = 31;
                           }
                           break;
                        case 11:
                        case 12:
                        case 13:
                        case 14:
                           _loc13_[_loc41_ + _loc39_ * 25] = 31;
                     }
                  }
                  else if(MathLibrary.randomize(0,100) < _loc6_)
                  {
                     _loc43_ = _loc11_[_loc41_ + _loc39_ * 25];
                     if(6 === _loc43_)
                     {
                        _loc13_[_loc41_ + _loc39_ * 25] = 102;
                     }
                  }
                  else if(MathLibrary.randomize(0,100) < _loc20_)
                  {
                     _loc42_ = _loc11_[_loc41_ + _loc39_ * 25];
                     if(6 === _loc42_)
                     {
                        _loc13_[_loc41_ + _loc39_ * 25] = 24;
                     }
                  }
                  else if(MathLibrary.randomize(0,100) < _loc18_)
                  {
                     _loc43_ = _loc11_[_loc41_ + _loc39_ * 25];
                     if(6 === _loc43_)
                     {
                        _loc13_[_loc41_ + _loc39_ * 25] = 104;
                     }
                  }
                  else if(MathLibrary.randomize(0,100) < _loc12_)
                  {
                     _loc13_[_loc41_ + _loc39_ * 25] = 400;
                  }
                  else if(MathLibrary.randomize(0,100) < _loc40_)
                  {
                     _loc13_[_loc41_ + _loc39_ * 25] = 401;
                  }
               }
               _loc24_++;
            }
            _loc27_++;
         }
         _loc27_ = 0;
         while(_loc27_ < 25)
         {
            _loc24_ = 0;
            while(_loc24_ < 25)
            {
               _loc41_ = _loc24_;
               _loc39_ = _loc27_;
               _loc22_ = int(_loc11_[_loc27_ * 25 + _loc24_]);
               if(_loc22_ == 15)
               {
                  _loc16_ = -1;
                  _loc38_ = -1;
                  _loc2_ = -1;
                  _loc3_ = -1;
                  _loc28_ = -1;
                  _loc14_ = -1;
                  _loc30_ = -1;
                  _loc32_ = -1;
                  if(_loc41_ > 0)
                  {
                     _loc3_ = int(_loc11_[_loc41_ - 1 + _loc39_ * 25]);
                  }
                  if(_loc39_ > 0)
                  {
                     _loc16_ = int(_loc11_[_loc41_ + (_loc39_ - 1) * 25]);
                     if(_loc41_ > 0)
                     {
                        _loc28_ = int(_loc11_[_loc41_ - 1 + (_loc39_ - 1) * 25]);
                     }
                     if(_loc41_ < 24)
                     {
                        _loc14_ = int(_loc11_[_loc41_ + 1 + (_loc39_ - 1) * 25]);
                     }
                  }
                  if(_loc41_ < 24)
                  {
                     _loc2_ = int(_loc11_[_loc41_ + 1 + _loc39_ * 25]);
                  }
                  if(_loc39_ < 24)
                  {
                     _loc38_ = int(_loc11_[_loc41_ + (_loc39_ + 1) * 25]);
                     if(_loc41_ > 0)
                     {
                        _loc30_ = int(_loc11_[_loc41_ - 1 + (_loc39_ + 1) * 25]);
                     }
                     if(_loc41_ < 24)
                     {
                        _loc32_ = int(_loc11_[_loc41_ + 1 + (_loc39_ + 1) * 25]);
                     }
                  }
                  if(!isSandyWasteTile(_loc16_) && !isSandyWasteTile(_loc3_) && isSandyWasteTile(_loc2_) && isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 15;
                  }
                  else if(!isSandyWasteTile(_loc16_) && isSandyWasteTile(_loc3_) && isSandyWasteTile(_loc2_) && isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 16;
                  }
                  else if(!isSandyWasteTile(_loc16_) && isSandyWasteTile(_loc3_) && !isSandyWasteTile(_loc2_) && isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 17;
                  }
                  else if(isSandyWasteTile(_loc16_) && !isSandyWasteTile(_loc3_) && isSandyWasteTile(_loc2_) && isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 18;
                  }
                  else if(isSandyWasteTile(_loc16_) && isSandyWasteTile(_loc3_) && isSandyWasteTile(_loc2_) && isSandyWasteTile(_loc38_))
                  {
                     if(!isSandyWasteTile(_loc32_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 24;
                     }
                     else if(!isSandyWasteTile(_loc14_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 25;
                     }
                     else if(!isSandyWasteTile(_loc28_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 26;
                     }
                     else if(!isSandyWasteTile(_loc30_))
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 27;
                     }
                     else
                     {
                        _loc11_[_loc41_ + _loc39_ * 25] = 19;
                     }
                  }
                  else if(isSandyWasteTile(_loc16_) && isSandyWasteTile(_loc3_) && !isSandyWasteTile(_loc2_) && isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 20;
                  }
                  else if(isSandyWasteTile(_loc16_) && !isSandyWasteTile(_loc3_) && isSandyWasteTile(_loc2_) && !isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 21;
                  }
                  else if(isSandyWasteTile(_loc16_) && isSandyWasteTile(_loc3_) && isSandyWasteTile(_loc2_) && !isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 22;
                  }
                  else if(isSandyWasteTile(_loc16_) && isSandyWasteTile(_loc3_) && !isSandyWasteTile(_loc2_) && !isSandyWasteTile(_loc38_))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 23;
                  }
                  else if(isSandyWasteTile(_loc11_[_loc41_ + _loc39_ * 25]))
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 28;
                  }
               }
               _loc24_++;
            }
            _loc27_++;
         }
         _loc27_ = 0;
         while(_loc27_ < 25)
         {
            _loc24_ = 0;
            while(_loc24_ < 25)
            {
               _loc41_ = _loc24_;
               _loc39_ = _loc27_;
               _loc22_ = int(_loc11_[_loc27_ * 25 + _loc24_]);
               if(_loc22_ == 29)
               {
                  if(MathLibrary.randomize(0,100) < 50)
                  {
                     _loc11_[_loc41_ + _loc39_ * 25] = 28;
                  }
                  if(MathLibrary.randomize(0,100) < _loc5_)
                  {
                     if(MathLibrary.randomize(0,100) < 50)
                     {
                        _loc13_[_loc41_ + _loc39_ * 25] = 32;
                     }
                     else
                     {
                        _loc13_[_loc41_ + _loc39_ * 25] = 33;
                     }
                  }
                  else if(MathLibrary.randomize(0,100) < _loc1_)
                  {
                     _loc13_[_loc41_ + _loc39_ * 25] = 101;
                  }
                  else if(MathLibrary.randomize(0,100) < _loc10_)
                  {
                     _loc13_[_loc41_ + _loc39_ * 25] = 29;
                  }
                  else if(MathLibrary.randomize(0,100) < _loc4_)
                  {
                     _loc13_[_loc41_ + _loc39_ * 25] = 105;
                  }
               }
               _loc24_++;
            }
            _loc27_++;
         }
         var _loc35_:String = "";
         _loc27_ = 0;
         while(_loc27_ < 25)
         {
            if(_loc27_ > 0)
            {
               _loc35_ += "\n";
            }
            _loc24_ = 0;
            while(_loc24_ < 25)
            {
               _loc17_ = "";
               if(_loc13_[_loc24_ + _loc27_ * 25] != undefined)
               {
                  _loc17_ = _loc13_[_loc24_ + _loc27_ * 25];
               }
               _loc31_ = 0;
               _loc37_ = 0;
               _loc21_ = 0;
               _loc9_ = MathLibrary.randomize(5,30);
               if(_loc17_ == "")
               {
                  if(isGrassTile(_loc11_[_loc24_ + _loc27_ * 25]))
                  {
                     _loc31_ = MathLibrary.randomize(15,25);
                     _loc37_ = MathLibrary.randomize(5,15);
                  }
                  else if(isSandyWasteTile(_loc11_[_loc24_ + _loc27_ * 25]))
                  {
                     _loc31_ = MathLibrary.randomize(5,15);
                     _loc37_ = MathLibrary.randomize(15,25);
                  }
                  else
                  {
                     _loc31_ = MathLibrary.randomize(5,20);
                     _loc37_ = MathLibrary.randomize(5,20);
                  }
               }
               if(MathLibrary.randomize(0,100) < 60)
               {
                  _loc21_ = MathLibrary.randomize(1,4);
               }
               _loc35_ += _loc11_[_loc24_ + _loc27_ * 25] + ":" + _loc17_ + "::" + _loc9_ + ":" + _loc31_ + ":" + _loc37_ + ":" + _loc21_ + ":0:0:0:0:0;";
               _loc24_++;
            }
            _loc27_++;
         }
         return _loc35_;
      }
      
      public static function isGrassTile(param1:int) : Boolean
      {
         return param1 == -1 || param1 == 2 || param1 == 3 || param1 == 4 || param1 == 5 || param1 == 6 || param1 == 7 || param1 == 8 || param1 == 9 || param1 == 10 || param1 == 11 || param1 == 12 || param1 == 13 || param1 == 14 || param1 == 32;
      }
      
      public static function isSandyWasteTile(param1:int) : Boolean
      {
         return param1 == -1 || param1 == 15 || param1 == 16 || param1 == 17 || param1 == 18 || param1 == 19 || param1 == 20 || param1 == 21 || param1 == 22 || param1 == 23 || param1 == 24 || param1 == 25 || param1 == 26 || param1 == 27 || param1 == 28 || param1 == 30;
      }
   }
}

