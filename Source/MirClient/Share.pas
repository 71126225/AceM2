unit Share;

interface

uses Grobal2;

var
  CLIENTUPDATETIME: string = '2013.01.19';

const
  RUNLOGINCODE = 0; //进入游戏状态码,默认为0 测试为 9

  STDCLIENT = 0;
  RMCLIENT = 99;
  CLIENTTYPE = 0; //普通的为0 ,99 为管理客户端

  DEFFONTNAME = 'MS Sans Serif'; //宋体
  DEFFONTSIZE = 9;

  DEBUG = 0;
  {SWH800 = 0;
  SWH1024 = 1;
  SWH = SWH800;  }

  MAXLEFT2 = 12;
  MAXTOP2 = 12;
  MAXTOP3 = -16;

  BGSURFACECOLOR = 8;
  DEFSCREENWIDTH = 800;
  DEFSCREENHEIGHT = 600;
  DEFWIDESCREENWIDTH = 1024;
  DEFWIDESCREENHEIGHT = 600;
  DEFMAXSCREENWIDTH = 1024;
  DEFMAXSCREENHEIGHT = 768;

  OPERATEHINTWIDTH = 425;
  OPERATEHINTHEIGHT = 32;
  OPERATEHINTX = 335;
  OPERATEHINTY = 474;

  MISSIONHINTWIDTH = 220 + 18;
  MISSIONHINTHEIGHT = 337;
  MISSIONHINTX = 10;
  MISSIONHINTY = 250;

  //MAPSURFACEWIDTH = g_FScreenWidth;
  //MAPSURFACEHEIGHT = g_FScreenHeight;
  //MAPSURFACEHEIGHT = g_FScreenHeight - 150;

  ADDSAYHEIGHT = 16;
  //ADDSAYWHDTH = g_FScreenWidth - 600 - 5;
  ADDSAYCOUNT = 10;

  WINLEFT = 60;
  WINTOP = 60;
  //WINRIGHT = g_FScreenWidth - 60;
  //BOTTOMEDGE = g_FScreenHeight - 60; // Bottom WINBOTTOM

  //MAPDIR = 'Map\'; //地图文件所在目录
  CONFIGFILE = 'Config\%s.ini';

  MAXX = 52;
  MAXY = 40;

 // MAXX = g_FScreenWidth div 20;
 // MAXY = g_FScreenWidth div 20;

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR = 1; //图形光标

  USECURSOR = IMAGECURSOR; //使用什么类型的光标

  {  MAXBAGITEMCL = 52;}
  MAXFONT = 8;
  ENEMYCOLOR = 69;
  ALLYCOLOR = 180;

  crMyNone = 1;
  crMyAttack = 2;
  crMyDialog = 3;
  crMyBuy = 4;
  crMySell = 5;
  crMyRepair = 6;
  crMySelItem = 7;
  crMyDeal = 8;
  crOpenBox = 9;
  crSrepair = 10;

//var
  g_FScreenMode: Byte = DEFSCREENMODE;
  g_FScreenWidth: Integer = DEFSCREENWIDTH;
  g_FScreenHeight: Integer = DEFSCREENHEIGHT;

Type
  TCursorMode = (cr_None, cr_Buy, cr_Sell, cr_Repair, cr_SelItem, cr_Deal, cr_Srepair);

var
  g_CursorMode: TCursorMode = cr_None;
  TestTick2: LongWord;
  g_CanTab: Boolean = True;

function GetStrengthenText(nMasterLevel, nLevel: Integer): string;

implementation

uses
SysUtils;

function GetStrengthenText(nMasterLevel, nLevel: Integer): string;
begin
  Result := '';
  case nMasterLevel of
    3: begin
      case nLevel of
        0..2: Result := Format('Accuracy +%d', [nLevel + 1]);
        3..7: Result := Format('Health +%d', [(nLevel - 2) * 10]);
        8..12: Result := Format('Mana +%d', [(nLevel - 7) * 10]);
        13..15: Result := Format('Agility +%d', [nLevel - 12]);
      end;
    end;
    6: begin
      case nLevel of
        0..4: Result := Format('Elements Defence +%d', [nLevel + 1]) + '%';
        5..14: Result := Format('Additional Experience +%d', [nLevel - 4]) + '%';
        15..19: Result := Format('Elements Damage +%d', [nLevel - 14]) + '%';
      end;
    end;
    9: begin
      case nLevel of
        0..2:   Result := Format('AC +%d', [nLevel + 1]) + '%';
        3..5:   Result := Format('MAC +%d', [nLevel - 2]) + '%';
        6..10:  Result := Format('DC +%d', [nLevel - 5]);
        11..15: Result := Format('MC +%d', [nLevel - 10]);
        16..20: Result := Format('SC +%d', [nLevel - 15]);
      end;
    end;
    12: begin
      case nLevel of
        0..2: Result := Format('Damage Bonus +%d', [nLevel + 1]) + '%';
        3..11: Result := Format('Life Magic Cap +%d', [nLevel - 1]) + '%';
        12..14: Result := Format('Damage Absorb +%d', [nLevel - 11]) + '%';
      end;
    end;
    15: begin
      case nLevel of
        0..2: Result := Format('Critical Damage +%d', [nLevel + 1]) + '%';
        3..23: Result := Format('DC, MC, SC +%d points', [nLevel + 7]);
      end;
    end;
    18: begin
      case nLevel of
        0..5: Result := Format('Reduce drop probability %d0', [nLevel + 4]) + '%';
      end;
    end;
  end;
end;

end.


