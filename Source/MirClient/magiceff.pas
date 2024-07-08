unit magiceff;

interface

uses
  Windows, SysUtils, HGE, Classes,
  Grobal2, HGETextures, CliUtil, ClFunc, HUtil32, WIl;

const
  MG_READY = 10;
  MG_FLY = 6;
  MG_EXPLOSION = 10;
  READYTIME = 120;
  EXPLOSIONTIME = 100;
  FLYBASE = 10;
  EXPLOSIONBASE = 170;
  //EFFECTFRAME = 260;
  MAXMAGIC = 10;
  FLYOMAAXEBASE = 447;
  THORNBASE = 2967;
  ARCHERBASE = 2607;
  ARCHERBASE2 = 272; //2609;

  FLYFORSEC = 500;
  FIREGUNFRAME = 6;

  MAXEFFECT = 67;
  {
  EffectBase: array[0..MAXEFFECT-1] of integer = (
     0,             //0  È­¿°Àå
     200,           //1  È¸º¹¼ú
     400,           //2  ±Ý°­È­¿°Àå
     600,           //3  ¾Ï¿¬¼ú
     0,             //4  °Ë±¤
     900,           //5  È­¿°Ç³
     920,           //6  È­¿°¹æ»ç
     940,           //7  ·ÚÀÎÀå //½ÃÀüÈ¿°ú¾øÀ½
     20,            //8  °­°Ý,  Magic2
     940,           //9  Æø»ì°è //½ÃÀüÈ¿°ú¾øÀ½
     940,           //10 ´ëÁö¿øÈ£ //½ÃÀüÈ¿°ú¾øÀ½
     940,           //11 ´ëÁö¿øÈ£¸¶ //½ÃÀüÈ¿°ú¾øÀ½
     0,             //12 ¾î°Ë¼ú
     1380,          //13 °á°è
     1500,          //14 ¹é°ñÅõÀÚ¼ÒÈ¯, ¼ÒÈ¯¼ú
     1520,          //15 Àº½Å¼ú
     940,           //16 ´ëÀº½Å
     1560,          //17 Àü±âÃæ°Ý
     1590,          //18 ¼ø°£ÀÌµ¿
     1620,          //19 Áö¿­Àå
     1650,          //20 È­¿°Æø¹ß
     1680,          //21 ´ëÀºÇÏ(Àü±âÆÛÁü)
     0,           //22 ¹Ý¿ù°Ë¹ý
     0,           //23 ¿°È­°á
     0,           //24 ¹«ÅÂº¸
     3960,          //25 Å½±âÆÄ¿¬
     1790,          //26 ´ëÈ¸º¹¼ú
     0,            //27 ½Å¼ö¼ÒÈ¯  Magic2
     3880,          //28 ÁÖ¼úÀÇ¸·
     3920,          //29 »çÀÚÀ±È¸
     3840,          //30 ºù¼³Ç³
     1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
  );
  }
  EffectBase: array[0..MAXEFFECT - 1] of integer = (
    0, {1}
    200, {2}
    400, {3}
    568, {4}
    0, {5}
    900, {6}
    920, {7}
    940, {8}
    20, {9}
    120, {10}
    36, {11}
    36, {12}
    0, {13}
    1380, {14}
    1500, {15}
    1520, {16}
    940, {17}
    1560, {18}
    1590, {19}
    640, {20 1620}
    1650, {21}
    1680, {22}
    0, {23}
    0, {24}
    0, {25}
    3960, {26}
    1790, {27 1790}
    0, {28}
    0, {29}
    3920, {30}
    3840, {31}
    0, {32}
    0{40}, {33}
    130, {34}
    160, {35}
    190, {36}
    0, {37}
    210, {38}
    400, {39}
    600, {40}
    1500, {41}
    650, {42}
    710, {43}
    740, {44}
    910, {45}
    940, {46}
    568{990}, {47}
    1040, {48}
    630, {49}
    0, {50} //±§ÔÂµ¶·¨
    790, {51} //¿ñ·çÕ¶
    840, {52} //ÆÆ¿Õ½£
    810, {53}
    870, {54}
    1010, {55}
    740, {56}
    650, {57}
    360, {58}
    588, {59}
    0, {60}
    870, {61}
    880, {62}
    1050, {63}
    1092 {64},
    1126, {65}
    180, {66}
    1020 {67});
  MAXHITEFFECT = 10 {11};
  {
  HitEffectBase: array[0..MAXHITEFFECT-1] of integer = (
     800,           //0, ¾î°Ë¼ú
     1410,          //1 ¾î°Ë¼ú
     1700,          //2 ¹Ý¿ù°Ë¹ý
     3480,          //3 ¿°È­°á, ½ÃÀÛ
     3390,          //4 ¿°È­°á ¹ÝÂ¦ÀÓ
     1,2,3
  );
  }
  HitEffectBase: array[0..MAXHITEFFECT - 1] of integer = (
    800,
    1410,
    1700,
    0,
    3390,
    40,
    660,
    740,
    510,
    220
    );
  MAXMAGICTYPE = 16;

type
  TMagicType = (mtReady, mtFly, mtExplosion,
    mtFlyAxe, mtFireWind, mtFireGun,
    mtLightingThunder, mtThunder, mtExploBujauk,
    mtBujaukGroundEffect, mtKyulKai, mtFlyArrow,
    mt12, mt13, mt14,
    mt15, mt16
    );

  TUseMagicInfo = record
    ServerMagicCode: integer;
    MagicSerial: integer;
    Target: integer; //recogcode
    EffectType: TMagicType;
    EffectNumber: integer;
    TargX: integer;
    TargY: integer;
    Recusion: Boolean;
    AniTime: integer;
//    nFrame: Integer;
  end;
  PTUseMagicInfo = ^TUseMagicInfo;

  TMagicEff = class //Size 0xC8
    m_boActive: Boolean; //0x04
    ServerMagicId: integer; //0x08
    MagicId: Integer;
    MagOwner: TObject; //0x0C
    TargetActor: TObject; //0x10
    ImgLib: TWMImages; //0x14
    EffectBase: integer; //0x18
    MagExplosionBase: integer; //0x1C
    MagExplosionDir: Boolean;
    px, py: integer; //0x20 0x24
    RX, RY: integer; //0x28 0x2C
    Dir16, OldDir16: byte; //0x30  0x31
    TargetX, TargetY: integer; //0x34 0x38
    TargetRx, TargetRy: integer; //0x3C 0x40
    FlyX, FlyY, OldFlyX, OldFlyY: integer; //0x44 0x48 0x4C 0x50
    FlyXf, FlyYf: Real; //0x54 0x5C
    Repetition: Boolean; //0x64
    FixedEffect: Boolean; //0x65
    NotFixed: Boolean;
    MagicType: integer; //0x68
    NextEffect: TMagicEff; //0x6C
    ExplosionFrame: integer; //0x70
    NextFrameTime: integer; //0x74
    Light: integer; //0x78
    n7C: integer;
    bt80: byte;
    bt81: byte;
    start: integer; //0x84
    curframe: integer; //0x88
    frame: integer; //0x8C
    m_nFlyParameter: Integer;
    m_boFlyBlend: Boolean;
    m_boExplosionBlend: Boolean;
    Colour: String;
    nMaxTime: Integer;
    direction_of_attack: byte;
    user_x: Integer;
    user_y: Integer;
    SpecialFly1, SpecialFly2: Boolean;
  private

    m_dwFrameTime: longword; //0x90
    m_dwStartTime: longword; //0x94
    repeattime: longword; //0x98 ¹Ýº¹ ¾Ö´Ï¸ÞÀÌ¼Ç ½Ã°£ (-1: °è¼Ó)
    steptime: longword; //0x9C
    fireX, fireY: integer; //0xA0 0xA4
    firedisX, firedisY: integer; //0xA8 0xAC
    newfiredisX, newfiredisY: integer; //0xB0 0xB4
    FireMyselfX, FireMyselfY: integer; //0xB8 0xBC
    prevdisx, prevdisy: integer; //0xC0 0xC4
    level_of_light, density_of_darkness: Integer;
  protected
    procedure GetFlyXY(ms: integer; var fx, fy: integer);
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; AniTime: integer);
    destructor Destroy; override;
    function Run: Boolean; dynamic; //false:³¡³µÀ½.
    function Shift: Boolean; dynamic;
    procedure DrawEff(surface: TDirectDrawSurface); dynamic;
    procedure DrawLightEff(surface_for_light: TDirectDrawSurface); dynamic;
  end;

  TDelayMagicEff = class(TMagicEff)
    nDelayTime: LongWord;
    boRun: Boolean;
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; AniTime: integer);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlameIceMagicEff = class(TMagicEff)
  public
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TTigerMagicEff = class(TMagicEff)
    btDir: Byte;
  public
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlyingAxe = class(TMagicEff)
    FlyImageBase: integer;
    ReadyFrame: integer;
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean; AniTime: integer);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlyingBug = class(TMagicEff) //Size 0xD0
    FlyImageBase: integer; //0xC8
    ReadyFrame: integer; //0xCC
  public
    constructor Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType;
      Recusion: Boolean; AniTime: integer);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TFlyingArrow = class(TFlyingAxe)
  public
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;
  TFlyingFireBall = class(TFlyingAxe) //0xD0
  public
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;
  TCharEffect = class(TMagicEff)
    m_boBlend: Boolean;
  public
    constructor Create(effbase, effframe: integer; Target: TObject; boBlend: Boolean = True);
    function Run: Boolean; override; //false:³¡³µÀ½.
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TMapEffect = class(TMagicEff)
  public
    RepeatCount: integer;
    constructor Create(effbase, effframe: integer; x, y: integer);
    function Run: Boolean; override; //false:³¡³µÀ½.
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TScrollHideEffect = class(TMapEffect)
  public
    constructor Create(effbase, effframe: integer; x, y: integer; Target: TObject);
    function Run: Boolean; override;
  end;

  TLightingEffect = class(TMagicEff)
  public
    constructor Create(effbase, effframe: integer; x, y: integer);
    function Run: Boolean; override;
  end;

  TFireNode = record
    x: integer;
    y: integer;
    firenumber: integer;
  end;

  TFireGunEffect = class(TMagicEff)
  public
    OutofOil: Boolean;
    firetime: longword;
    FireNodes: array[0..FIREGUNFRAME - 1] of TFireNode;
    constructor Create(effbase, sx, sy, tx, ty: integer);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
    procedure DrawLightEff(surface: TDirectDrawSurface);
  end;

  TThuderEffect = class(TMagicEff)
  public
    density_of_darkness: Integer;
    level_of_light: Integer;
    constructor Create(effbase, tx, ty: integer; Target: TObject);
    procedure DrawEff(surface: TDirectDrawSurface); override;
    procedure DrawLightEff(surface: TDirectDrawSurface);
  end;

  TLightingThunder = class(TMagicEff)
  public
    constructor Create(effbase, sx, sy, tx, ty: integer; Target: TObject);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TExploBujaukEffect = class(TMagicEff)
    MagicNumber: integer;
    MagicBlend: Boolean;
  public
    constructor Create(effbase, sx, sy, tx, ty: integer; Target: TObject);
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TBujaukGroundEffect = class(TMagicEff) //Size  0xD0
  public
    MagicNumber: integer; //0xC8
    BoGroundEffect: Boolean; //0xCC
    constructor Create(effbase, magicnumb, sx, sy, tx, ty: integer);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TNormalDrawEffect = class(TMagicEff) //Size 0xCC
    boC8: Boolean;
  public
    constructor Create(XX, YY: integer; WmImage: TWMImages; effbase, nX:
      integer; frmTime: longword; boFlag: Boolean);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TDrawEffectOnObject = class(TMagicEff) //mirroing?
    ObjectID:     TObject;
    boC8:         Boolean;
    amount_to_increase: Integer;
    decrease_frames:  Integer;
  public
    constructor   Create(ObjectiD2:TObject; WmImage:TWMImages; effbase, nX: Integer; frmTime: LongWord; boFlag: Boolean);
    function      Run: Boolean; override;
    procedure     DrawEff (Surface: TDirectDrawSurface); override;
    procedure     DrawLightEff (surface: TDirectDrawSurface);
  end;

  TDrawTimedEffect = class (TMagicEff)
     ObjectID: TObject;
     boC8: Boolean;
   public
     constructor Create(ObjectiD2:TObject; WmImage:TWMImages; effbase, nX, endFrame: Integer; frmTime: LongWord; boFlag: Boolean);
     Function  Run: Boolean; override;
     procedure DrawEff (Surface: TDirectDrawSurface); override;
   end;

  TDelayNormalDrawEffect = class(TNormalDrawEffect)
    dwDelayTick: LongWord;
    boRun: Boolean;
    SoundID: Integer;
  public
    constructor Create(XX, YY: integer; WmImage: TWMImages; effbase, nX:
      integer; frmTime: longword; boFlag: Boolean; nDelayTime: LongWord);
    function Run: Boolean; override;
    procedure DrawEff(surface: TDirectDrawSurface); override;
  end;

  TThreeNodeDrawEffect = class(TDelayNormalDrawEffect)
    size_of_node: Integer;
    increment_loops: Integer;
    constructor Create(XX, YY: integer; WmImage: TWMImages; effbase, nX:
      integer; frmTime: longword; boFlag: Boolean; nDelayTime: LongWord);
    procedure DrawLightEff(surface: TDirectDrawSurface);
  end;

  TStraightNodeDrawEffect = class(TDelayNormalDrawEffect)
    space_between_light_nodes: Integer;
    constructor Create(XX, YY: integer; WmImage: TWMImages; effbase, nX: integer; frmTime: longword; boFlag: Boolean; nDelayTime: LongWord);
    procedure DrawLightEff(surface: TDirectDrawSurface);
  end;
procedure GetEffectBase(mag, mtype: integer; var wimg: TWMImages; var idx: integer);

implementation

uses
  ClMain, Actor, SoundUtil, MShare, WMFile, HGEBase, PlayScn;

//Get the gallery where the magic effect is located

procedure GetEffectBase(mag, mtype: integer; var wimg: TWMImages; var idx:
  integer);
begin
  wimg := nil;
  idx := 0;
  case mtype of
    0: begin
        case mag of
          27, 34..35, 37..39, 41..42, 43, 44, 47, 54, 55, 56: begin
              wimg := g_WMagic2Images;
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          60..63, 66: begin   //Samuel
            wimg := g_wMagic99Images;
            idx := EffectBase[mag];
          end;
          8: begin
                wimg := g_WMagic2Images;
                if mag in [0..MAXEFFECT - 1] then
                  idx := EffectBase[mag];
            end;
          57: begin
              wimg := g_WMagic10Images;
              idx := 360;
            end;
          48: begin
              wimg := g_WMagic6Images;
              idx := 630;
            end;
          33: begin
              wimg := g_WMagic6Images;
              idx := 80;
            end;
          31: begin
              wimg := g_WMons[21];
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          36: begin
              wimg := g_WMons[22];
              if mag in [0..MAXEFFECT - 1] then
                idx := EffectBase[mag];
            end;
          89: begin
              wimg := g_WDragonImages;
              idx := 350;
            end;
          (MAGICEX_AMYOUNSUL - 1): begin
              wimg := g_WMagic99Images;
              idx := 588;
            end;
          (MAGICEX_AMYOUNSULGROUP - 1): begin
              wimg := g_WMagic99Images;
              idx := 588;
            end;
          28, 10..11, 3, 19, 46, 50..53: begin
            wimg := g_WMagic99Images;
            idx := EffectBase[mag];
          end;
          9, 58: begin
              wimg := g_WMagic6Images;
              idx := EffectBase[9];
            end;
          49: begin
              wimg := g_WcboEffectImages;
              idx := 3990;
            end;
          69: begin
              wimg := g_WMagic10Images;
              idx := 200;
            end;
          70: begin
              wimg := g_WMagic10Images;
              idx := 60;
            end;
          71: begin
              wimg := g_WMagic10Images;
              idx := 0;
            end;
          81..88: begin
              wimg := g_WMagicKiller;
              case mag of
                82: idx := 200; //83 Haste
                84: idx := 530; //85 LightBody
                85: idx := 1430; //86 HeavenlySword
                86: idx := 380; //87 FireBurst
                87: idx := 400; //88 Trap
              end;
            end;
          113: begin
              wimg := g_WcboEffectImages;
              idx := 1040;
            end;
          114: begin
              wimg := g_WcboEffectImages;
              idx := 640;
            end;
          115: begin
              wimg := g_WcboEffectImages;
              idx := 1280;
            end;
          116: begin
              wimg := g_WcboEffectImages;
              idx := 800;
            end;
          117: begin
              wimg := g_WcboEffectImages;
              idx := 1200;
            end;
          118: begin
              wimg := g_WcboEffectImages;
              idx := 1440;
            end;
          119: begin
              wimg := g_WcboEffectImages;
              idx := 1600;
            end;
          120: begin
              wimg := g_WcboEffectImages;
              idx := 1760;
            end;
          122: begin
              wimg := g_WcboEffectImages;
              idx := 720;
            end;
          123: begin
              wimg := g_WMagic2Images;
              idx := 1370;
            end;
          129: begin
              wimg := g_wMons[32];
              idx := 4130;
          end
        else begin
            wimg := g_WMagicImages;
            if mag in [0..MAXEFFECT - 1] then
              idx := EffectBase[mag];
          end;
        end;
      end;
    1: begin
        if mag in [0..MAXHITEFFECT - 1] then begin
          idx := HitEffectBase[mag];
        end;
        case mag of
          1: begin
              {if g_WMagic7Images.boInitialize then begin
                wimg := g_WMagic7Images;
                idx := 140;
              end else begin   }
                wimg := g_WMagicImages;
              //end;
            end;
          2: begin
              {if g_WMagic7Images.boInitialize then begin
                wimg := g_WMagic7Images;
                idx := 310;
              end else begin   }
                wimg := g_WMagicImages;
              //end;
            end;
          3: wimg := g_WMagic6Images;
          6: wimg := g_WMagic99Images;
          5: wimg := g_WMagic2Images;
          7, 9,13..15, 19: wimg := g_WMagic2Images;
          8: wimg := g_WMagic6Images;
          10..11: begin
              wimg := g_WMagicKiller;
              case mag of
                10: idx := 930; //DoubleSlash
                11: idx := 550; //PoisonSword
              end;
          end;
          16: begin
              wimg := g_WMagic5Images;
              idx := 470;
            end;
          17: begin
              wimg := g_WMagic5Images;
              idx := 630;
            end;
          18: begin
              wimg := g_WMain99Images;
              idx := 1530;
            end;
          //10: begin
           // DScreen.AddSysMsg('tdb', $00ff00);
           // wimg := g_wMagic2Images;
            //idx := 220;
          //end
          else
            wimg := g_WMagicImages;
        end;
      end;
    2: begin
      wimg := g_WcboEffectImages;
      case mag of
        0: idx := 160;
        1: idx := 80;
        2: idx := 316;
        3: idx := 560;
        4: idx := 0;
        8: begin
          //wimg := g_WMagic6Images;
          //idx := 510;
        end;
      end;
    end;
  end;
end;

constructor TMagicEff.Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean;
  AniTime: integer);
var
  tax, tay: integer;
begin
  m_nFlyParameter := 900;
  ImgLib := g_WMagicImages; //±âº»
  NotFixed := False;
  MagExplosionDir := False;
  m_boFlyBlend := True;
  m_boExplosionBlend := True;
  MagicId := 0;
  SpecialFly1 := False;
  SpecialFly2 := False;

  case mtype of
    mtFly, mtBujaukGroundEffect, mtExploBujauk: begin
        start := 0;
        frame := 6;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 10;
        if id = 38 then
          frame := 10;
        if id = 39 then begin
          frame := 4;
          ExplosionFrame := 8;
        end;
        {if id = 130 then begin
          frame := 3;
          ExplosionFrame := 5;
        end;}
        if (id - 81 - 3) < 0 then begin
          bt80 := 1;
          Repetition := True;
          if id = 81 then begin
            if g_Myself.m_nCurrX >= 84 then begin
              EffectBase := 130;
            end
            else begin
              EffectBase := 140;
            end;
            bt81 := 1;
          end;
          if id = 82 then begin
            if (g_Myself.m_nCurrX >= 78) and (g_Myself.m_nCurrY >= 48) then begin
              EffectBase := 150;
            end
            else begin
              EffectBase := 160;
            end;
            bt81 := 2;
          end;
          if id = 83 then begin
            EffectBase := 180;
            bt81 := 3;
          end;
          start := 0;
          frame := 10;
          MagExplosionBase := 190;
          ExplosionFrame := 10;
        end;
      end;
    mt12: begin
        start := 0;
        frame := 6;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 1;
      end;
    mt13: begin
        start := 0;
        frame := 20;
        curframe := start;
        FixedEffect := True;
        Repetition := False;
        ExplosionFrame := 20;
        ImgLib := g_WMons[21];
      end;
    mtExplosion, mtThunder, mtLightingThunder: begin
        start := 0;
        frame := -1;
        ExplosionFrame := 10;
        curframe := start;
        FixedEffect := True;
        Repetition := False;
        if id = 80 then begin
          bt80 := 2;
          case Random(6) of
            0: begin
                EffectBase := 230;
              end;
            1: begin
                EffectBase := 240;
              end;
            2: begin
                EffectBase := 250;
              end;
            3: begin
                EffectBase := 230;
              end;
            4: begin
                EffectBase := 240;
              end;
            5: begin
                EffectBase := 250;
              end;
          end;
          Light := 4;
          ExplosionFrame := 5;
        end;
        if id = 70 then begin
          bt80 := 3;
          case Random(3) of
            0: begin
                EffectBase := 400;
              end;
            1: begin
                EffectBase := 410;
              end;
            2: begin
                EffectBase := 420;
              end;
          end;
          Light := 4;
          ExplosionFrame := 5;
        end;
        if id = 71 then begin
          bt80 := 3;
          ExplosionFrame := 20;
        end;
        if id = 72 then begin
          bt80 := 3;
          Light := 3;
          ExplosionFrame := 10;
        end;
        if id = 73 then begin
          bt80 := 3;
          Light := 5;
          ExplosionFrame := 20;
        end;
        if id = 74 then begin
          bt80 := 3;
          Light := 4;
          ExplosionFrame := 35;
        end;
        if id = 90 then begin
          EffectBase := 350;
          MagExplosionBase := 350;
          ExplosionFrame := 30;
        end;
      end;
    mt14: begin
        start := 0;
        frame := -1;
        curframe := start;
        FixedEffect := True;
        Repetition := False;
        ImgLib := g_WMagic2Images;
      end;
    mtFlyAxe: begin
        start := 0;
        frame := 3;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 3;
      end;
    mtFlyArrow: begin
        start := 0;
        frame := 1;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 1;
      end;
    mt15: begin
        start := 0;
        frame := 6;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 2;
      end;
    mt16: begin
        start := 0;
        frame := 1;
        curframe := start;
        FixedEffect := False;
        Repetition := Recusion;
        ExplosionFrame := 1;
      end;
  end;
  n7C := 0;
  ServerMagicId := id; //¼­¹öÀÇ ID
  EffectBase := effnum; //MagicDB - Effect
  TargetX := tx; // "   target x
  TargetY := ty; // "   target y

  if bt80 = 1 then begin
    if id = 81 then begin
      dec(sx, 14);
      inc(sy, 20);
    end;
    if id = 81 then begin
      dec(sx, 70);
      dec(sy, 10);
    end;
    if id = 83 then begin
      dec(sx, 60);
      dec(sy, 70);
    end;
    PlaySound(8208);
  end;
  fireX := sx; //
  fireY := sy; //
  FlyX := sx; //
  FlyY := sy;
  OldFlyX := sx;
  OldFlyY := sy;
  FlyXf := sx;
  FlyYf := sy;
  FireMyselfX := g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX;
  FireMyselfY := g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY;
  if bt80 = 0 then begin
    MagExplosionBase := EffectBase + EXPLOSIONBASE;
  end;

  Light := 1;

  if fireX <> TargetX then
    tax := abs(TargetX - fireX)
  else
    tax := 1;
  if fireY <> TargetY then
    tay := abs(TargetY - fireY)
  else
    tay := 1;
  if abs(fireX - TargetX) > abs(fireY - TargetY) then begin
    firedisX := Round((TargetX - fireX) * (500 / tax));
    firedisY := Round((TargetY - fireY) * (500 / tax));
  end
  else begin
    firedisX := Round((TargetX - fireX) * (500 / tay));
    firedisY := Round((TargetY - fireY) * (500 / tay));
  end;

  NextFrameTime := 50;
  m_dwFrameTime := FrmMain.m_CurrentTick;
  m_dwStartTime := FrmMain.m_CurrentTick;
  steptime := FrmMain.m_CurrentTick;
  repeattime := AniTime;
  Dir16 := GetFlyDirection16(sx, sy, tx, ty);
  OldDir16 := Dir16;
  NextEffect := nil;
  m_boActive := True;
  prevdisx := 99999;
  prevdisy := 99999;
  level_of_light := 0;
  density_of_darkness := 0;
  Colour := '255,255,255';
  user_x := 0;
  user_y := 0;
end;

destructor TMagicEff.Destroy;
begin
  inherited Destroy;
end;

function TMagicEff.Shift: Boolean;
  function OverThrough(olddir, newdir: integer): Boolean;
  begin
    Result := False;
    if abs(olddir - newdir) >= 2 then begin
      Result := True;
      if ((olddir = 0) and (newdir = 15)) or ((olddir = 15) and (newdir = 0)) then
        Result := False;
    end;
  end;
var
  ms, stepx, stepy: integer;
  tax, tay, shx, shy, passdir16: integer;
  crash: Boolean;
  stepxf, stepyf: Real;
begin
  Result := True;
  if Repetition then begin
    if FrmMain.m_CurrentTick - steptime > longword(NextFrameTime) then begin
      steptime := FrmMain.m_CurrentTick;
      inc(curframe);
      if curframe > start + frame - 1 then
        curframe := start;
    end;
  end
  else begin
    if (frame > 0) and (FrmMain.m_CurrentTick - steptime > longword(NextFrameTime)) then begin
      steptime := FrmMain.m_CurrentTick;
      inc(curframe);
      if curframe > start + frame - 1 then begin
        curframe := start + frame - 1;
        Result := False;
        exit;
      end;
    end;
  end;

  if (not FixedEffect) then begin

    crash := False;
    if TargetActor <> nil then begin
      ms := FrmMain.m_CurrentTick - m_dwFrameTime;
        //ÀÌÀü È¿°ú¸¦ ±×¸°ÈÄ ¾ó¸¶³ª ½Ã°£ÀÌ Èê·¶´ÂÁö?
      m_dwFrameTime := FrmMain.m_CurrentTick;
      //TargetX, TargetY Àç¼³Á¤
      PlayScene.ScreenXYfromMCXY(TActor(TargetActor).m_nRx,
        TActor(TargetActor).m_nRy,                  
        TargetX,
        TargetY);
      shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
      shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;
      TargetX := TargetX + shx;
      TargetY := TargetY + shy;

      //»õ·Î¿î Å¸°ÙÀ» ÁÂÇ¥¸¦ »õ·Î ¼³Á¤ÇÑ´Ù.
      if FlyX <> TargetX then
        tax := abs(TargetX - FlyX)
      else
        tax := 1;
      if FlyY <> TargetY then
        tay := abs(TargetY - FlyY)
      else
        tay := 1;
      if abs(FlyX - TargetX) > abs(FlyY - TargetY) then begin
        newfiredisX := Round((TargetX - FlyX) * (500 / tax));
        newfiredisY := Round((TargetY - FlyY) * (500 / tax));
      end
      else begin
        newfiredisX := Round((TargetX - FlyX) * (500 / tay));
        newfiredisY := Round((TargetY - FlyY) * (500 / tay));
      end;

      if firedisX < newfiredisX then
        firedisX := firedisX + _MAX(1, (newfiredisX - firedisX) div 10);
      if firedisX > newfiredisX then
        firedisX := firedisX - _MAX(1, (firedisX - newfiredisX) div 10);
      if firedisY < newfiredisY then
        firedisY := firedisY + _MAX(1, (newfiredisY - firedisY) div 10);
      if firedisY > newfiredisY then
        firedisY := firedisY - _MAX(1, (firedisY - newfiredisY) div 10);

      stepxf := (firedisX / (m_nFlyParameter - 200)) * ms;
      stepyf := (firedisY / (m_nFlyParameter - 200)) * ms;
      FlyXf := FlyXf + stepxf;
      FlyYf := FlyYf + stepyf;
      FlyX := Round(FlyXf);
      FlyY := Round(FlyYf);

      //¹æÇâ Àç¼³Á¤
    //  Dir16 := GetFlyDirection16 (OldFlyX, OldFlyY, FlyX, FlyY);
      OldFlyX := FlyX;
      OldFlyY := FlyY;
      //Åë°ú¿©ºÎ¸¦ È®ÀÎÇÏ±â À§ÇÏ¿©
      passdir16 := GetFlyDirection16(FlyX, FlyY, TargetX, TargetY);

      {DebugOutStr(IntToStr(prevdisx) + ' ' + IntToStr(prevdisy) + ' / ' +
        IntToStr(abs(TargetX - FlyX)) + ' ' + IntToStr(abs(TargetY - FlyY)) + '   '
        +
        IntToStr(firedisX) + '.' + IntToStr(firedisY) + ' ' +
        IntToStr(FlyX) + '.' + IntToStr(FlyY) + ' ' +
        IntToStr(TargetX) + '.' + IntToStr(TargetY));   }
      if ((abs(TargetX - FlyX) <= 15) and (abs(TargetY - FlyY) <= 15)) or
        ((abs(TargetX - FlyX) >= prevdisx) and (abs(TargetY - FlyY) >= prevdisy)) or
        OverThrough(OldDir16, passdir16) then
      begin
        crash := True;
      end
      else begin
        prevdisx := abs(TargetX - FlyX);
        prevdisy := abs(TargetY - FlyY);
        //if (prevdisx <= 5) and (prevdisy <= 5) then crash := TRUE;
      end;
      OldDir16 := passdir16;

    end
    else begin
      ms := FrmMain.m_CurrentTick - m_dwFrameTime; //È¿°úÀÇ ½ÃÀÛÈÄ ¾ó¸¶³ª ½Ã°£ÀÌ Èê·¶´ÂÁö?

      //      rrx := TargetX - fireX;
      //      rry := TargetY - fireY;

      stepx := Round((firedisX / m_nFlyParameter) * ms);
      stepy := Round((firedisY / m_nFlyParameter) * ms);
      FlyX := fireX + stepx;
      FlyY := fireY + stepy;
    end;

    PlayScene.CXYfromMouseXY(FlyX, FlyY, RX, RY);

    if crash and (TargetActor <> nil) then begin
      FixedEffect := True; //Æø¹ß
      start := 0;
      frame := ExplosionFrame;
      curframe := start;
      Repetition := False;

      //ÅÍÁö´Â »ç¿îµå
      if MagOwner <> nil then
        PlaySound(TActor(MagOwner).m_nMagicExplosionSound);

    end;
    //if not Map.CanFly (Rx, Ry) then
    //   Result := FALSE;
  end;
  if FixedEffect then begin
    if frame = -1 then
      frame := ExplosionFrame;
    if TargetActor = nil then begin
      FlyX := TargetX - ((g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX);
      FlyY := TargetY - ((g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY);
      PlayScene.CXYfromMouseXY(FlyX, FlyY, RX, RY);
    end
    else begin
      RX := TActor(TargetActor).m_nRx;
      RY := TActor(TargetActor).m_nRy;
      PlayScene.ScreenXYfromMCXY(RX, RY, FlyX, FlyY);
      FlyX := FlyX + TActor(TargetActor).m_nShiftX;
      FlyY := FlyY + TActor(TargetActor).m_nShiftY;
    end;
  end;
end;

procedure TMagicEff.GetFlyXY(ms: integer; var fx, fy: integer);
var
  stepx, stepy: integer;
begin
  //  rrx := TargetX - fireX;
  //  rry := TargetY - fireY;

  stepx := Round((firedisX / 900) * ms);
  stepy := Round((firedisY / 900) * ms);
  fx := fireX + stepx;
  fy := fireY + stepy;
end;

function TMagicEff.Run: Boolean;
begin
  Result := Shift;
  if Result then
    if FrmMain.m_CurrentTick - m_dwStartTime > 10000 then //2000 then
      Result := False
    else
      Result := True;
end;

procedure TMagicEff.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;    //samuel
begin
  if m_boActive and ((abs(FlyX - fireX) > 15) or (abs(FlyY - fireY) > 15) or FixedEffect) then begin

    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //³¯¾Æ°¡´Â°Å
      if NotFixed then img := EffectBase
      else img := EffectBase + FLYBASE + Dir16 * 10;
      if SpecialFly1 then //Orc Sorcerers Spirit Ball Attack
        img := EffectBase + Dir16 * 5;

      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        if m_boFlyBlend then begin
          DrawBlend(surface, FlyX + px - UNITX div 2 - shx, FlyY + py - UNITY div 2 - shy, d, 1);
        end else begin
          Surface.Draw(FlyX + px - UNITX div 2 - shx, FlyY + py - UNITY div 2 - shy, d, True);
        end;
      end;
    end
    else begin
      //ÅÍÁö´Â°Å
      if MagExplosionDir then img := MagExplosionBase + curframe + Dir16 * 10
      else img := MagExplosionBase + curframe; //EXPLOSIONBASE;
      d := ImgLib.GetCachedImage(img, px, py);
      if (MagicId = 66) and (curframe < 20) then begin
        Dec(py, 225);
        Inc(px, 25);
      end;
      if d <> nil then begin
        if m_boExplosionBlend then begin
          DrawBlend(surface, FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d, 1);
        end else begin
         Surface.Draw(FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d, True);
        end;
      end;
    end;
  end;
end;

procedure TMagicEff.DrawLightEff(surface_for_light: TDirectDrawSurface);   //Samuel magic blending for dark.
var
  nPx, nPy: integer;
  image_to_draw: TDirectDrawSurface;
  temp_rectangle: TRect;
  top_left_position, bottom_right_position: TPoint;
  left_position, top_position, right_position, bottom_position, i, incremental_increase_of_light,
  actual_size_of_light: integer;
  colour_of_dark: RGBColourArray;
  density_for_fly_object: integer;
  user_position_x, user_position_y, testx, testy: integer;
  can_draw_light: Boolean;
begin
  image_to_draw := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));

  left_position := 25;
  top_position := 35;
  right_position := 110;
  bottom_position := 65;
  incremental_increase_of_light := 0;
  can_draw_light := False;

  case Light of
    1: actual_size_of_light := 15;  //fireball
    2: actual_size_of_light := 40;  //firebang
    3: actual_size_of_light := 60;  //meteor strike
    4: actual_size_of_light := 90; //flamefield;
  end;

  if FixedEffect then begin
    Inc(level_of_light, 1);
    if (frame div 2) > curframe - 1 then
      Inc(density_of_darkness, 2)
    else
      Dec(density_of_darkness, 2);
    density_for_fly_object := density_of_darkness;
  end else begin
    density_for_fly_object := 0;
    density_of_darkness := 100;
    if not (FlyX <> user_x) and not (FlyY <> user_y) then
      Exit;
  end;

  if density_for_fly_object < 0 then
    density_for_fly_object := 0;

  colour_of_dark := GetHGEColour(Colour, density_for_fly_object);

  if (m_boExplosionBlend) and (Light > 0) then begin
    for i := 0 to 3 do begin
      top_left_position.X := (FlyX + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
      top_left_position.Y := (FlyY + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
      bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
      bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
      temp_rectangle.TopLeft := top_left_position;
      temp_rectangle.BottomRight := bottom_right_position;
      if (image_to_draw <> nil) then
        surface_for_light.StretchDraw(temp_rectangle, image_to_draw.ClientRect, image_to_draw, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);
      Inc(incremental_increase_of_light, 25);
    end;
  end;
end;

{------------------------------------------------------------}

//      TFlyingAxe : ³¯¾Æ°¡´Â µµ³¢

{------------------------------------------------------------}

constructor TFlyingAxe.Create(id, effnum, sx, sy, tx, ty: integer; mtype:
  TMagicType; Recusion: Boolean; AniTime: integer);
begin
  inherited Create(id, effnum, sx, sy, tx, ty, mtype, Recusion, AniTime);
  FlyImageBase := FLYOMAAXEBASE;
  ReadyFrame := 65;
end;

procedure TFlyingAxe.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  if m_boActive and ((abs(FlyX - fireX) > ReadyFrame) or (abs(FlyY - fireY) >
    ReadyFrame)) then begin

    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //
      img := FlyImageBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        //¾ËÆÄºí·©µùÇÏÁö ¾ÊÀ½
        surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end
    else begin
      {//Á¤Áö, µµ³¢¿¡ ÂïÈù ¸ð½À.
      img := FlyImageBase + Dir16 * 10;
      d := ImgLib.GetCachedImage (img, px, py);
      if d <> nil then begin
         //¾ËÆÄºí·©µùÇÏÁö ¾ÊÀ½
         surface.Draw (FlyX + px - UNITX div 2,
                       FlyY + py - UNITY div 2,
                       d.ClientRect, d, TRUE);
      end;  }
    end;
  end;
end;

{------------------------------------------------------------}

//      TFlyingArrow : ³¯¾Æ°¡´Â È­»ì

{------------------------------------------------------------}

procedure TFlyingArrow.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
  FlyXPos, FlyYPos: Integer;
begin
  FlyXPos := abs(FlyX - fireX);
  FlyYPos := abs(FlyY - fireY);
  if m_boActive and ((FlyXPos > 40) or (FlyYPos > 40)) then
    begin
    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //If were not a fixed effect then we draw arrow attack
      img := FlyImageBase + Dir16; // * 10{check for x frames};
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if SpecialFly2 then //for Orc Spear or Orc Knife then we need to reposition the image down a bit.
        py := py + 30;
      if d <> nil then begin
        //If image is present then draw
        surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy - 46,
          d.ClientRect, d, True);
      end;
    end;
  end;
end;

{--------------------------------------------------------}

constructor TCharEffect.Create(effbase, effframe: integer; Target: TObject; boBlend: Boolean);
begin
  inherited Create(111, effbase,
    TActor(Target).m_nCurrX, TActor(Target).m_nCurrY,
    TActor(Target).m_nCurrX, TActor(Target).m_nCurrY,
    mtExplosion,
    False,
    0);
  TargetActor := Target;
  frame := effframe;
  NextFrameTime := 30;
  m_boBlend := boBlend;

end;

function TCharEffect.Run: Boolean;
begin
  Result := True;
  if FrmMain.m_CurrentTick - steptime > longword(NextFrameTime) then begin
    steptime := FrmMain.m_CurrentTick;
    inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      Result := False;
    end;
  end;
end;

procedure TCharEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if TargetActor <> nil then begin
    RX := TActor(TargetActor).m_nRx;
    RY := TActor(TargetActor).m_nRy;
    PlayScene.ScreenXYfromMCXY(RX, RY, FlyX, FlyY);
    FlyX := FlyX + TActor(TargetActor).m_nShiftX;
    FlyY := FlyY + TActor(TargetActor).m_nShiftY;
    d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
    if d <> nil then begin
      if m_boBlend then DrawBlend(surface, FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d, 1)
      else surface.Draw(FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d.ClientRect, d, fxBlend);
    end;
  end;
end;

{--------------------------------------------------------}

constructor TMapEffect.Create(effbase, effframe: integer; x, y: integer);
begin
  inherited Create(111, effbase, x, y, x, y, mtExplosion, False, 0);
  TargetActor := nil;
  frame := effframe;
  NextFrameTime := 30;
  RepeatCount := 0;
end;

function TMapEffect.Run: Boolean;
begin
  Result := True;
  if FrmMain.m_CurrentTick - steptime > longword(NextFrameTime) then begin
    steptime := FrmMain.m_CurrentTick;
    inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start + frame - 1;
      if RepeatCount > 0 then begin
        dec(RepeatCount);
        curframe := start;
      end
      else
        Result := False;
    end;
  end;
end;

procedure TMapEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  RX := TargetX;
  RY := TargetY;
  PlayScene.ScreenXYfromMCXY(RX, RY, FlyX, FlyY);
  d := ImgLib.GetCachedImage(EffectBase + curframe, px, py);
  if d <> nil then begin
    DrawBlend(surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d, 1);
  end;
end;

{--------------------------------------------------------}

constructor TScrollHideEffect.Create(effbase, effframe: integer; x, y: integer; Target: TObject);
begin
  inherited Create(effbase, effframe, x, y);
  //TargetCret := TActor(target);//ÔÚ³öÏÖÓÐÈËÓÃËæ»úÖ®ÀàÊ±£¬½«ÉèÖÃÄ¿±ê
end;

function TScrollHideEffect.Run: Boolean;
begin
  Result := inherited Run;
  if frame = 7 then
    if g_TargetCret <> nil then
      PlayScene.DeleteActor(g_TargetCret.m_nRecogId);
end;

{--------------------------------------------------------}

constructor TLightingEffect.Create(effbase, effframe: integer; x, y: integer);
begin

end;

function TLightingEffect.Run: Boolean;
begin
  Result := False; //Jacky
end;

{--------------------------------------------------------}

constructor TFireGunEffect.Create(effbase, sx, sy, tx, ty: integer);
begin
  inherited Create(111, effbase,
    sx, sy,
    tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtFireGun,
    True,
    0);
  NextFrameTime := 50;
  SafeFillChar(FireNodes, sizeof(TFireNode) * FIREGUNFRAME, #0);
  OutofOil := False;
  firetime := FrmMain.m_CurrentTick;
end;

function TFireGunEffect.Run: Boolean;
var
  i: integer;
  allgone: Boolean;
begin
  Result := True;
  if FrmMain.m_CurrentTick - steptime > longword(NextFrameTime) then begin
    Shift;
    steptime := FrmMain.m_CurrentTick;
    //if not FixedEffect then begin  //¸ñÇ¥¿¡ ¸ÂÁö ¾Ê¾ÒÀ¸¸é
    if (not OutofOil) and (MagOwner <> nil) then begin
      if (abs(RX - TActor(MagOwner).m_nRx) >= 5) or (abs(RY -
        TActor(MagOwner).m_nRy) >= 5) or (FrmMain.m_CurrentTick - firetime > 800) then
        OutofOil := True;
      for i := FIREGUNFRAME - 2 downto 0 do begin
        FireNodes[i].firenumber := FireNodes[i].firenumber + 1;
        FireNodes[i + 1] := FireNodes[i];
      end;
      FireNodes[0].firenumber := 1;
      FireNodes[0].x := FlyX;
      FireNodes[0].y := FlyY;
    end
    else begin
      allgone := True;
      for i := FIREGUNFRAME - 2 downto 0 do begin
        if FireNodes[i].firenumber <= FIREGUNFRAME then begin
          FireNodes[i].firenumber := FireNodes[i].firenumber + 1;
          FireNodes[i + 1] := FireNodes[i];
          allgone := False;
        end;
      end;
      if allgone then
        Result := False;
    end;
  end;
end;

procedure TFireGunEffect.DrawEff(surface: TDirectDrawSurface);
var
  i, {num, } shx, shy, fireX, fireY, prx, pry, img: integer;
  d: TDirectDrawSurface;
begin
  prx := -1;
  pry := -1;
  for i := 0 to FIREGUNFRAME - 1 do begin
    if (FireNodes[i].firenumber <= FIREGUNFRAME) and (FireNodes[i].firenumber >
      0) then begin
      shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
      shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

      img := EffectBase + (FireNodes[i].firenumber - 1);
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        fireX := FireNodes[i].x + px - UNITX div 2 - shx;
        fireY := FireNodes[i].y + py - UNITY div 2 - shy;
        if (fireX <> prx) or (fireY <> pry) then begin
          prx := fireX;
          pry := fireY;
          DrawBlend(surface, fireX, fireY, d, 1);
        end;
      end;
    end;
  end;
end;

procedure TFireGunEffect.DrawLightEff(surface: TDirectDrawSurface);
var
  i, j: integer;
  d: TDirectDrawSurface;
  nPx, nPy: Integer;
  t: TRect;
  topPoint, bottomPoint: TPoint;
  colour_of_dark: RGBColourArray;
  left_position, top_position, right_position, bottom_position: Integer;
begin
  left_position := 40;
  top_position := 50;
  right_position := 125;
  bottom_position := 80;

  d := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));

  Inc(level_of_light, 1);
  if 30 > level_of_light then
    Inc(density_of_darkness, 2)
  else
    Dec(density_of_darkness, 2);

  colour_of_dark := GetHGEColour(Colour, density_of_darkness);

  for i := 0 to FIREGUNFRAME - 1 do begin
    if not ( FireNodes[i].x <> user_x) and not (FireNodes[i].y <> user_y) then
      Exit;

    if d <> nil then begin
      topPoint.X := FireNodes[i].x + nPx - UNITX div 2 - left_position;
      topPoint.Y := FireNodes[i].y + nPy - UNITY div 2 - top_position;
      bottomPoint.X := topPoint.X + right_position;
      bottomPoint.Y := topPoint.Y + bottom_position;
      t.TopLeft := topPoint;
      t.BottomRight := bottomPoint;
      if topPoint.X > 0 then begin
        Surface.StretchDraw(t, d.ClientRect,d,ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]),Blend_SrcAlphaAdd);
      end;
      topPoint.X := FireNodes[i].x + nPx - UNITX div 2 - left_position - 25;
      topPoint.Y := FireNodes[i].y + nPy - UNITY div 2 - top_position - 25;
      bottomPoint.X := topPoint.X + right_position + (25 * 2);
      bottomPoint.Y := topPoint.Y + bottom_position + (25 * 2);
      t.TopLeft := topPoint;
      t.BottomRight := bottomPoint;
      if topPoint.X > 0 then begin
        Surface.StretchDraw(t, d.ClientRect,d,ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]),Blend_SrcAlphaAdd);
      end;
      topPoint.X := FireNodes[i].x + nPx - UNITX div 2 - left_position - 50;
      topPoint.Y := FireNodes[i].y + nPy - UNITY div 2 - top_position - 50;
      bottomPoint.X := topPoint.X + right_position + (50 * 2);
      bottomPoint.Y := topPoint.Y + bottom_position + (50 * 2);
      t.TopLeft := topPoint;
      t.BottomRight := bottomPoint;
      if topPoint.X > 0 then begin
        Surface.StretchDraw(t, d.ClientRect,d,ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]),Blend_SrcAlphaAdd);
      end;
      topPoint.X := FireNodes[i].x + nPx - UNITX div 2 - left_position - 75;
      topPoint.Y := FireNodes[i].y + nPy - UNITY div 2 - top_position - 75;
      bottomPoint.X := topPoint.X + right_position + (75 * 2);
      bottomPoint.Y := topPoint.Y + bottom_position + (75 * 2);
      t.TopLeft := topPoint;
      t.BottomRight := bottomPoint;
      if topPoint.X > 0 then begin
        Surface.StretchDraw(t, d.ClientRect,d,ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]),Blend_SrcAlphaAdd);
      end;
    end;
  end;
end;

{--------------------------------------------------------}

constructor TThuderEffect.Create(effbase, tx, ty: integer; Target: TObject);
begin
  inherited Create(111, effbase,
    tx, ty,
    tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtThunder,
    False,
    0);
  TargetActor := Target;
  density_of_darkness := 0;
  level_of_light := 0;
end;

procedure TThuderEffect.DrawEff(surface: TDirectDrawSurface);
var
  img, px, py: integer;
  d: TDirectDrawSurface;
begin
  img := EffectBase;
  d := ImgLib.GetCachedImage(img + curframe, px, py);
  if d <> nil then begin
    DrawBlend(surface,
      FlyX + px - UNITX div 2,
      FlyY + py - UNITY div 2,
      d, 1);
  end;
end;

procedure TThuderEffect.DrawLightEff(surface: TDirectDrawSurface);
var
  dd: TDirectDrawSurface;
  t: TRect;
  topPoint, bottomPoint: TPoint;
  nPx, nPy, left_position, top_position, right_position, bottom_position, incremental_increase_of_light,
  i, actual_size_of_light: Integer;
  colour_of_dark: RGBColourArray;
begin
  left_position := 25;
  top_position := 35;
  right_position := 110;
  bottom_position := 65;
  incremental_increase_of_light := 0;
  actual_size_of_light := 0;

  case Light of
    1: actual_size_of_light := 70; //tbolt
    2: actual_size_of_light := 15; //flamedis
  end;

  if((frame div 2) > curframe -1) then
    Inc(density_of_darkness, 3)
  else
    Dec(density_of_darkness, 3);
  colour_of_dark := GetHGEColour(Colour, density_of_darkness);

  dd := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));

  for i := 0 to 3 do begin
    topPoint.X := (FlyX + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    topPoint.Y := (FlyY + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottomPoint.X := topPoint.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottomPoint.Y := topPoint.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    t.TopLeft := topPoint;
    t.BottomRight := bottomPoint;
    if dd <> nil then
      Surface.StretchDraw(t, dd.ClientRect,dd,ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]),Blend_SrcAlphaAdd);
    Inc(incremental_increase_of_light, 50);
  end;
end;


{--------------------------------------------------------}

constructor TLightingThunder.Create(effbase, sx, sy, tx, ty: integer; Target: TObject);
begin
  inherited Create(111, effbase,
    sx, sy,
    tx, ty, //TActor(target).XX, TActor(target).m_nCurrY,
    mtLightingThunder,
    False,
    0);
  TargetActor := Target;
  //ImgLib := g_WMagic99Images;
end;

procedure TLightingThunder.DrawEff(surface: TDirectDrawSurface);
var
  img, sx, sy, px, py: integer;
  nPx, nPy: Integer;
  d, dd: TDirectDrawSurface;
begin
  img := EffectBase + Dir16 * 10;
  if curframe < 6 then begin
    d := ImgLib.GetCachedImage(img + curframe, px, py);
    dd := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));
    if (d <> nil) and (MagOwner <> nil) then begin
      PlayScene.ScreenXYfromMCXY(TActor(MagOwner).m_nRx,
        TActor(MagOwner).m_nRy,
        sx,
        sy); 
      DrawBlend(surface,
        sx + px - UNITX div 2,
        sy + py - UNITY div 2,
        d, 1);
    end;
  end;
end;

{--------------------------------------------------------}

constructor TExploBujaukEffect.Create(effbase, sx, sy, tx, ty: integer; Target:
  TObject);
begin
  inherited Create(111, effbase,
    sx, sy,
    tx, ty,
    mtExploBujauk,
    True,
    0);
  frame := 8;
  TargetActor := Target;
  NextFrameTime := 50;
  MagicNumber := 0;
  MagicBlend := False;
end;

procedure TExploBujaukEffect.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
  //  meff: TMapEffect;
begin
  if m_boActive and ((abs(FlyX - fireX) > 30) or (abs(FlyY - fireY) > 30) or FixedEffect) then begin

    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      img := EffectBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        if MagicBlend then
          DrawBlend(surface,
            FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d, 1)
        else
          surface.Draw(FlyX + px - UNITX div 2 - shx,
            FlyY + py - UNITY div 2 - shy,
            d.ClientRect, d, True);
      end;
    end
    else begin
      img := MagExplosionBase + curframe;
      if MagicNumber = 11 then
        imglib := g_wMons[75];
      if MagicNumber = 17 then d := g_WMagicImages.GetCachedImage(img, px, py)
      else d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d, 1);
      end;
    end;
  end;
end;

{--------------------------------------------------------}

constructor TBujaukGroundEffect.Create(effbase, magicnumb, sx, sy, tx, ty:
  integer);
begin
  inherited Create(111, effbase,
    sx, sy,
    tx, ty,
    mtBujaukGroundEffect,
    True,
    0);
  frame := 3;
  MagicNumber := magicnumb;
  BoGroundEffect := False;
  NextFrameTime := 50;
  //ImgLib := g_WMagic99Images;
end;

function TBujaukGroundEffect.Run: Boolean;
begin
  Result := inherited Run;
  if not FixedEffect then begin
    if ((abs(TargetX - FlyX) <= 15) and (abs(TargetY - FlyY) <= 15)) or
      ((abs(TargetX - FlyX) >= prevdisx) and (abs(TargetY - FlyY) >= prevdisy))
        then begin
      FixedEffect := True; //Æø¹ß
      start := 0;
      frame := ExplosionFrame;
      curframe := start;
      Repetition := False;
      //ÅÍÁö´Â »ç¿îµå
      if MagOwner <> nil then
        PlaySound(TActor(MagOwner).m_nMagicExplosionSound);

      Result := True;
    end
    else begin
      prevdisx := abs(TargetX - FlyX);
      prevdisy := abs(TargetY - FlyY);
    end;
  end;
end;

procedure TBujaukGroundEffect.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  nPx, nPy: Integer;
  d,dd: TDirectDrawSurface;
  shx, shy: integer;
  //  meff: TMapEffect;
begin
  if m_boActive and ((abs(FlyX - fireX) > 30) or (abs(FlyY - fireY) > 30) or
    FixedEffect) then begin

    dd := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));

    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //³¯¾Æ°¡´Â°Å
      img := EffectBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end
    else begin
      //Æø¹ß
      if MagicNumber = 11 then begin
        img := 534 + curframe;
        ImgLib := g_WMagic99Images;
      end else
      if MagicNumber = 12 then begin
        img := 510 + curframe;
        ImgLib := g_WMagic99Images;
      end else
      if MagicNumber = 46 then begin
        GetEffectBase(MagicNumber - 1, 0, ImgLib, img);
        img := img + 10 + curframe;
        ImgLib := g_WMagic2Images;
      end;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2, // - shx,
          FlyY + py - UNITY div 2, // - shy,
          d, 1);
      end;
    end;
  end;
end;

{ TNormalDrawEffect }

constructor TNormalDrawEffect.Create(XX, YY: integer; WmImage: TWMImages;
  effbase, nX: integer; frmTime: longword; boFlag: Boolean);
begin
  inherited Create(111, effbase, XX, YY, XX, YY, mtReady, True, 0);
  ImgLib := WmImage;
  EffectBase := effbase;
  start := 0;
  curframe := 0;
  frame := nX;
  NextFrameTime := frmTime;
  boC8 := boFlag;
end;

procedure TNormalDrawEffect.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  nRx, nRy, nPx, nPy: integer;
begin
  d := ImgLib.GetCachedImage(EffectBase + curframe, nPx, nPy);
  if d <> nil then begin
    if MagOwner <> nil then PlayScene.ScreenXYfromMCXY(TActor(MagOwner).m_nRX, TActor(MagOwner).m_nRY, nRx, nRy)
    else PlayScene.ScreenXYfromMCXY(FlyX, FlyY, nRx, nRy);
    if boC8 then begin
      DrawBlend(surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d, 1);
    end
    else begin
      surface.Draw(nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d.ClientRect, d, True);
    end;
  end;
end;

function TNormalDrawEffect.Run: Boolean;
begin
  Result := True;
  if m_boActive and (FrmMain.m_CurrentTick - steptime > longword(NextFrameTime)) then
    begin
    steptime := FrmMain.m_CurrentTick;
    inc(curframe);
    if curframe > start + frame - 1 then begin
      curframe := start;
      Result := False;
    end;
  end;
end;

constructor TDrawEffectOnObject.Create(ObjectID2:TObject;WmImage:TWMImages;effbase,nX:Integer;frmTime:LongWord;boFlag:Boolean);
begin
  inherited Create (111,effbase, 0, 0, 0, 0,mtReady,TRUE,0);
  ImgLib:=WmImage;
  EffectBase:=effbase;
  start:=0;
  curframe:=0;
  frame:=nX;
  NextFrameTime:=frmTime;
  boC8:=boFlag;
  ObjectID:=ObjectID2;
  amount_to_increase := 2;
  decrease_frames := 0;
end;

procedure TDrawEffectOnObject.DrawEff(surface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   Rx,Ry,nRx,nRy,nPx,nPy,shx,shy:integer;
begin
  d := ImgLib.GetCachedImage (EffectBase + curframe, nPx, nPy);
   if (d <> nil) and (ObjectID <> nil) then begin
      Rx := TActor(ObjectID).m_nRx;
      Ry := TActor(ObjectID).m_nRy;
     PlayScene.ScreenXYfromMCXY (Rx, Ry, nRx, nRy);
      nRx := nRx + TActor(ObjectID).m_nShiftX;
      nRy := nRy + TActor(ObjectID).m_nShiftY;
     if boC8 then begin
              DrawBlend(Surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d, 1);
     end else begin
       surface.Draw (nRx + nPx - UNITX div 2,nRy + nPy - UNITY div 2,d.ClientRect, d, TRUE);
     end;
   end;
end;

procedure TDrawEffectOnObject.DrawLightEff(surface: TDirectDrawSurface);
var
   image_to_draw: TDirectDrawSurface;
   temp_rectangle: TRect;
   top_left_position, bottom_right_position: TPoint;
   colour_of_dark: RGBColourArray;
   actual_size_of_light, Rx, Ry, nRx, nRy, nPx, nPy, left_position, top_position, right_position,
   bottom_position, incremental_increase_of_light, i: Integer;
begin
  left_position := 25;
  top_position := 35;
  right_position := 110;
  bottom_position := 65;
  actual_size_of_light := 0;
  incremental_increase_of_light := 0;

  case Light of
    1: actual_size_of_light := 15;
    2: actual_size_of_light := 50;
    3: actual_size_of_light := 100;
    4: actual_size_of_light := 200;
  end;

  if ((frame / 2) - decrease_frames ) > curframe - 1 then
    Inc(density_of_darkness, amount_to_increase)
  else
    Dec(density_of_darkness, amount_to_increase);

  if density_of_darkness < 0 then
    density_of_darkness := density_of_darkness;

  colour_of_dark := GetHGEColour(colour, density_of_darkness);

  image_to_draw := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));

  if (ObjectID <> nil) then begin
    Rx := TActor(ObjectID).m_nRx;
    Ry := TActor(ObjectID).m_nRy;
    PlayScene.ScreenXYfromMCXY (Rx, Ry, nRx, nRy);
    nRx := nRx + TActor(ObjectID).m_nShiftX;
    nRy := nRy + TActor(ObjectID).m_nShiftY;
    if boC8 then begin
      for i := 0 to 3 do begin
        top_left_position.X := (nRx + nPx - UNITX div 2) - left_position - actual_size_of_light - incremental_increase_of_light;
        top_left_position.Y := (nRy + nPy - UNITY div 2) - top_position - actual_size_of_light - incremental_increase_of_light;
        bottom_right_position.X := top_left_position.X + right_position + (actual_size_of_light * 2) + (incremental_increase_of_light * 2);
        bottom_right_position.Y := top_left_position.Y + bottom_position + (actual_size_of_light * 2) + (incremental_increase_of_light * 2);
        temp_rectangle.TopLeft := top_left_position;
        temp_rectangle.BottomRight := bottom_right_position;
        if image_to_draw <> nil then
          Surface.StretchDraw(temp_rectangle, image_to_draw.ClientRect, image_to_draw, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]),Blend_SrcAlphaAdd);
        Inc(incremental_increase_of_light, 25);
      end;
    end;
  end;
end;

function TDrawEffectOnObject.Run: Boolean;
begin
   Result := TRUE;
   if m_boActive and (FrmMain.m_CurrentTick - steptime > longword(NextFrameTime)) then begin
      steptime := FrmMain.m_CurrentTick;
      Inc (curframe);
      if curframe > start+frame-1 then begin
         curframe := start;
         Result := FALSE;
      end;
   end;
end;

{ TFlyingBug }

constructor TFlyingBug.Create(id, effnum, sx, sy, tx, ty: integer;
  mtype: TMagicType; Recusion: Boolean; AniTime: integer);
begin
  inherited Create(id, effnum, sx, sy, tx, ty, mtype, Recusion, AniTime);
  FlyImageBase := FLYOMAAXEBASE;
  ReadyFrame := 65;
end;

procedure TFlyingBug.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  if m_boActive and ((abs(FlyX - fireX) > ReadyFrame) or (abs(FlyY - fireY) >
    ReadyFrame)) then begin
    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      img := FlyImageBase + (Dir16 div 2) * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        surface.Draw(FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d.ClientRect, d, True);
      end;
    end
    else begin
      img := curframe + MagExplosionBase;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        surface.Draw(FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d.ClientRect, d, True);
      end;
    end;
  end;
end;

{ TFlyingFireBall }

procedure TFlyingFireBall.DrawEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if m_boActive and ((abs(FlyX - fireX) > ReadyFrame) or (abs(FlyY - fireY) >
    ReadyFrame)) then begin
    d := ImgLib.GetCachedImage(FlyImageBase + (GetFlyDirection(FlyX, FlyY,
      TargetX, TargetY) * 10) + curframe, px, py);
    if d <> nil then
      DrawBlend(surface,
        FlyX + px - UNITX div 2,
        FlyY + py - UNITY div 2,
        d, 1);
  end;
end;

constructor TDrawTimedEffect.Create(ObjectID2:TObject;WmImage:TWMImages;effbase,nX,endFrame:Integer;frmTime:LongWord;boFlag:Boolean);
begin
  inherited Create (111,effbase, 0, 0, 0, 0,mtExplosion,false,0);
  ImgLib:=WmImage;
  EffectBase:=effbase;
  start:=0;
  curframe:=0;
  frame:=endFrame;
  NextFrameTime:=frmTime;
  boC8:=boFlag;
  ObjectID:=ObjectID2;
  nMaxTime := nX;
end;

procedure TDrawTimedEffect.DrawEff(surface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   Rx,Ry,nRx,nRy,nPx,nPy,shx,shy:integer;
begin
  d := ImgLib.GetCachedImage (EffectBase + curframe, nPx, nPy);
   if (d <> nil) and (ObjectID <> nil) then begin
      Rx := TActor(ObjectID).m_nRx;
      Ry := TActor(ObjectID).m_nRy;
     PlayScene.ScreenXYfromMCXY (Rx, Ry, nRx, nRy);
      nRx := nRx + TActor(ObjectID).m_nShiftX;
      nRy := nRy + TActor(ObjectID).m_nShiftY;
     if boC8 then begin
              DrawBlend(Surface, nRx + nPx - UNITX div 2, nRy + nPy - UNITY div 2, d,1);
     end else begin
       surface.Draw (nRx + nPx - UNITX div 2,nRy + nPy - UNITY div 2,d.ClientRect, d, TRUE);
    end;
   end;
end;

Function TDrawTimedEffect.Run: Boolean;
begin
  if Result then
    if FrmMain.m_CurrentTick - m_dwStartTime > nMaxTime then
      Result := False
    else
    Result := True;
    //DScreen.AddChatBoardString(inttostr(FrmMain.m_CurrentTick - m_dwStartTime), clRed, clBlue);
    if curframe > start+frame-1 then begin
      curframe := start;
    end else if (FrmMain.m_CurrentTick - m_dwFrameTime > 100) then begin
      m_dwFrameTime := FrmMain.m_CurrentTick;
      inc(curframe);
    end;
end;

{ TDelayNormalDrawEffect }

constructor TDelayNormalDrawEffect.Create(XX, YY: integer; WmImage: TWMImages; effbase, nX: integer; frmTime: longword;
  boFlag: Boolean; nDelayTime: LongWord);
begin
  inherited Create(xx, yy, WmImage, effbase, nx, frmTime, boFlag);
  dwDelayTick := FrmMain.m_CurrentTick + nDelayTime;
  boRun := False;
  SoundID := -1;
end;

procedure TDelayNormalDrawEffect.DrawEff(surface: TDirectDrawSurface);
begin
  if boRun then
    inherited;
end;

constructor TThreeNodeDrawEffect.Create(XX, YY: integer; WmImage: TWMImages; effbase, nX: integer; frmTime: longword;
  boFlag: Boolean; nDelayTime: LongWord);
begin
  inherited Create(XX, YY, WmImage, effbase, nX, frmTime, boFlag, nDelayTime);
  size_of_node := 0;
  increment_loops := 0;
end;

procedure TThreeNodeDrawEffect.DrawLightEff(surface: TDirectDrawSurface);
var
  node_one_x, node_one_y, node_two_x, node_two_y, node_three_x, node_three_y,
  nPx, nPy, actual_size_of_light, user_object_rx, user_object_ry: Integer;
  d: TDirectDrawSurface;
  top_left_position, bottom_right_position: TPoint;
  left_position, top_position, right_position, bottom_position, i, incremental_increase_of_light, amount_of_loops: Integer;
  temp_rectangle: TRect;
  colour_of_dark: RGBColourArray;
  user_object: TActor;
begin
  if boRun then begin

  left_position := 40;
  top_position := 50;
  right_position := 125;
  bottom_position := 80;
  incremental_increase_of_light := 0;
  actual_size_of_light := 0;
  amount_of_loops := 3;

  if size_of_node > 0 then
    actual_size_of_light := size_of_node;
  if increment_loops > 0 then
    amount_of_loops := increment_loops;

  d := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));
  if (d <> nil) and (MagOwner <> nil) then begin
    user_object := TActor(MagOwner);
    user_object_rx := user_x;
    user_object_ry := user_y;
    PlayScene.ScreenXYfromMCXY(user_object_rx, user_object_ry, node_one_x, node_one_y);
  end;

  case direction_of_attack of
    DR_UP: begin
      node_one_y := node_one_y - 100;
      node_two_y := node_one_y + 25;
      node_two_x := node_one_x - 75;
      node_three_y := node_one_y + 25;
      node_three_x := node_one_x + 75;
    end;
    DR_UPRIGHT: begin
      node_one_y := node_one_y - 75;
      node_one_x := node_one_x + 125;
      node_two_y := node_one_y + 75;
      node_two_x := node_one_x + 25;
      node_three_y := node_one_y - 25;
      node_three_x := node_one_x - 75;
    end;
    DR_RIGHT: begin
      node_one_x := node_one_x + 200;
      node_two_y := node_one_y - 75;
      node_two_x := node_one_x - 25;
      node_three_y := node_one_y + 75;
      node_three_x := node_one_x - 25;
    end;
    DR_DOWNRIGHT: begin
      node_one_y := node_one_y + 115;
      node_one_x := node_one_x + 125;
      node_two_y := node_one_y - 75;
      node_two_x := node_one_x + 25;
      node_three_y := node_one_y + 25;
      node_three_x := node_one_x - 75;
    end;
    DR_DOWN: begin
      node_one_y := node_one_y + 150;
      node_two_y := node_one_y - 25;
      node_two_x := node_one_x + 75;
      node_three_y := node_one_y - 25;
      node_three_x := node_one_x - 75;
    end;
    DR_DOWNLEFT: begin
      node_one_y := node_one_y + 115;
      node_one_x := node_one_x - 125;
      node_two_y := node_one_y - 75;
      node_two_x := node_one_x - 25;
      node_three_y := node_one_y + 25;
      node_three_x := node_one_x + 75;
    end;
    DR_LEFT: begin
      node_one_x := node_one_x - 200;
      node_two_y := node_one_y - 75;
      node_two_x := node_one_x + 25;
      node_three_y := node_one_y + 75;
      node_three_x := node_one_x + 25;
    end;
    DR_UPLEFT: begin
      node_one_y := node_one_y - 75;
      node_one_x := node_one_x - 125;
      node_two_y := node_one_y + 75;
      node_two_x := node_one_x - 25;
      node_three_y := node_one_y - 25;
      node_three_x := node_one_x + 75;
    end;
  end;

  if (frame / 2) > curframe - 1 then
    Inc(density_of_darkness, 2)
  else
    Dec(density_of_darkness, 2);

  colour_of_dark := GetHGEColour(colour, depth_of_darkness);

  for i := 0 to amount_of_loops do begin
    top_left_position.X := (node_one_x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    top_left_position.Y := (node_one_y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if d <> nil then
      surface.StretchDraw(temp_rectangle, d.ClientRect, d, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);

    top_left_position.X := (node_two_x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    top_left_position.Y := (node_two_y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if d <> nil then
      surface.StretchDraw(temp_rectangle, d.ClientRect, d, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);

    top_left_position.X := (node_three_x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    top_left_position.Y := (node_three_y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if d <> nil then
      surface.StretchDraw(temp_rectangle, d.ClientRect, d, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);


    Inc(incremental_increase_of_light, 20);
   end;
  end;
end;

constructor TStraightNodeDrawEffect.Create(XX, YY: integer; WmImage: TWMImages; effbase, nX: integer; frmTime: longword;
  boFlag: Boolean; nDelayTime: LongWord);
begin
  inherited Create(xx, yy, WmImage, effbase, nx, frmTime, boFlag, nDelayTime);
  space_between_light_nodes := 0;
end;

procedure TStraightNodeDrawEffect.DrawLightEff(surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  left_position, top_position, right_position, bottom_position, incremental_increase_of_light,
  actual_size_of_light, nPx, nPy, i, node_one_x, node_one_y, node_two_x, node_two_y, node_three_x,
  node_three_y : Integer;
  top_left_position, bottom_right_position: TPoint;
  temp_rectangle: TRect;
  colour_of_dark: RGBColourArray;
begin
  if boRun then begin
  left_position := 40;
  top_position := 50;
  right_position := 125;
  bottom_position := 80;
  incremental_increase_of_light := 0;
  actual_size_of_light := 0;

  d := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));
  PlayScene.ScreenXYfromMCXY(user_x, user_y, node_one_x, node_one_y);


  case direction_of_attack of
    DR_UP: begin
      node_one_y := node_one_y - 25;
      node_two_y := node_one_y - space_between_light_nodes;
      node_three_y := node_two_y - space_between_light_nodes;
      node_two_x := node_one_x;
      node_three_x := node_one_x;
    end;
    DR_UPRIGHT: begin
      node_one_x := node_one_x + 50;
      node_one_y := node_one_y - 50;
      node_two_x := node_one_x + space_between_light_nodes;
      node_two_y := node_one_y - space_between_light_nodes + 15;
      node_three_x := node_two_x + space_between_light_nodes;
      node_three_y := node_two_y - space_between_light_nodes + 15;
    end;
    DR_RIGHT: begin
      node_two_y := node_one_y;
      node_three_y := node_one_y;
      node_one_x := node_one_x + 50;
      node_two_x := node_one_x + space_between_light_nodes;
      node_three_x := node_two_x + space_between_light_nodes;
    end;
    DR_DOWNRIGHT: begin
      node_one_x := node_one_x + 50;
      node_one_y := node_one_y + 50;
      node_two_x := node_one_x + space_between_light_nodes;
      node_two_y := node_one_y + space_between_light_nodes - 15;
      node_three_x := node_two_x + space_between_light_nodes;
      node_three_y := node_two_y + space_between_light_nodes - 15;
    end;
    DR_DOWN: begin
      node_one_y := node_one_y + 50;
      node_two_y := node_one_y + space_between_light_nodes;
      node_three_y := node_two_y + space_between_light_nodes;
      node_two_x := node_one_x;
      node_three_x := node_one_x;
    end;
    DR_DOWNLEFT: begin
      node_one_x := node_one_x - 50;
      node_one_y := node_one_y + 50;
      node_two_x := node_one_x - space_between_light_nodes;
      node_two_y := node_one_y + space_between_light_nodes - 15;
      node_three_x := node_two_x - space_between_light_nodes;
      node_three_y := node_two_y + space_between_light_nodes - 15;
    end;
    DR_LEFT: begin
      node_two_y := node_one_y;
      node_three_y := node_one_y;
      node_one_x := node_one_x - 50;
      node_two_x := node_one_x - space_between_light_nodes;
      node_three_x := node_two_x - space_between_light_nodes;
    end;
    DR_UPLEFT: begin
      node_one_x := node_one_x - 50;
      node_one_y := node_one_y - 50;
      node_two_x := node_one_x - space_between_light_nodes;
      node_two_y := node_one_y - space_between_light_nodes + 15;
      node_three_x := node_two_x - space_between_light_nodes;
      node_three_y := node_two_y - space_between_light_nodes + 15;
    end;
  end;

  if (frame / 2) > curframe - 1 then
    Inc(density_of_darkness, 2)
  else
    Dec(density_of_darkness, 2);

  colour_of_dark := GetHGEColour(colour, depth_of_darkness);

  for i := 0 to 5 do begin
    top_left_position.X := (node_one_x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    top_left_position.Y := (node_one_y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if d <> nil then
      surface.StretchDraw(temp_rectangle, d.ClientRect, d, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);

    top_left_position.X := (node_two_x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    top_left_position.Y := (node_two_y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if d <> nil then
      surface.StretchDraw(temp_rectangle, d.ClientRect, d, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);

    top_left_position.X := (node_three_x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
    top_left_position.Y := (node_three_y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if d <> nil then
      surface.StretchDraw(temp_rectangle, d.ClientRect, d, ARGB(density_of_darkness, colour_of_dark[1], colour_of_dark[2], colour_of_dark[3]), Blend_SrcAlphaAdd);

    Inc(incremental_increase_of_light, 20);
   end;
  end;
end;

function TDelayNormalDrawEffect.Run: Boolean;
begin
  Result := True;
  if boRun then begin
    Result := inherited Run;
  end else begin
    if FrmMain.m_CurrentTick > dwDelayTick then begin
      //10522
      if SoundID > 0 then
        PlaySound(SoundID); //Damian
      boRun := True;
    end;
  end;
end;

{ TTigerMagicEff }

procedure TTigerMagicEff.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  if m_boActive and ((abs(FlyX - fireX) > 15) or (abs(FlyY - fireY) > 15) or FixedEffect) then begin
    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //³¯¾Æ°¡´Â°Å
      img := EffectBase + btDir * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        surface.Draw(FlyX + px - UNITX div 2 - shx, FlyY + py - UNITY div 2 - shy, d.ClientRect, d, True);
      end;
      d := ImgLib.GetCachedImage(img + curframe + 80, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d, 1);
      end;
    end
    else begin
      //ÅÍÁö´Â°Å
      img := MagExplosionBase + curframe + btDir * 10;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        surface.Draw(FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d.ClientRect, d, True);
      end;
      d := ImgLib.GetCachedImage(img + 80, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d, 1);
      end;
      d := ImgLib.GetCachedImage(img + 160, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d, 1);
      end;
    end;
  end;
end;

{ TDelayMagicEff }

constructor TDelayMagicEff.Create(id, effnum, sx, sy, tx, ty: integer; mtype: TMagicType; Recusion: Boolean;
  AniTime: integer);
begin
  inherited;
  boRun := False;
end;

procedure TDelayMagicEff.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  if not boRun then exit;
  if m_boActive and ((abs(FlyX - fireX) > 15) or (abs(FlyY - fireY) > 15) or FixedEffect) then begin

    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      img := EffectBase + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe + 160, px, py);
      if d <> nil then begin
        surface.Draw(FlyX + px - UNITX div 2 - shx, FlyY + py - UNITY div 2 - shy, d.ClientRect, d, True);
      end;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2 - shx,
          FlyY + py - UNITY div 2 - shy,
          d, 1);
      end;
    end
    else begin
      img := MagExplosionBase + curframe; //EXPLOSIONBASE;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(surface,
          FlyX + px - UNITX div 2,
          FlyY + py - UNITY div 2,
          d, 1);
      end;
    end;
  end;
end;

function TDelayMagicEff.Run: Boolean;
begin
  Result := True;
  if (not boRun) then begin
    if FrmMain.m_CurrentTick > nDelayTime then begin
      boRun := True;
      m_dwFrameTime := FrmMain.m_CurrentTick;
      m_dwStartTime := FrmMain.m_CurrentTick;
      steptime := FrmMain.m_CurrentTick;
      Result := inherited Run;
    end;
  end else
    Result := inherited Run;
end;

{ TFlameIceMagicEff }

procedure TFlameIceMagicEff.DrawEff(surface: TDirectDrawSurface);
var
  img: integer;
  d: TDirectDrawSurface;
  shx, shy: integer;
begin
  if m_boActive and ((abs(FlyX - fireX) > 15) or (abs(FlyY - fireY) > 15) or FixedEffect) then begin

    shx := (g_Myself.m_nRx * UNITX + g_Myself.m_nShiftX) - FireMyselfX;
    shy := (g_Myself.m_nRy * UNITY + g_Myself.m_nShiftY) - FireMyselfY;

    if not FixedEffect then begin
      //³¯¾Æ°¡´Â°Å
      img := EffectBase + FLYBASE + Dir16 * 10;
      d := ImgLib.GetCachedImage(img + curframe, px, py);
      if d <> nil then begin
        DrawBlend(surface, FlyX + px - UNITX div 2 - shx, FlyY + py - UNITY div 2 - shy, d, 1);
      end;

      img := 400 + FLYBASE + Dir16 * 10;
      d := g_WMagic2Images.GetCachedImage(img + (curframe mod 4), px, py);
      if d <> nil then begin
        DrawBlend(surface, FlyX + px - UNITX div 2 - shx, FlyY + py - UNITY div 2 - shy, d, 1);
      end;
    end
    else begin
      //ÅÍÁö´Â°Å
      img := MagExplosionBase + curframe; //EXPLOSIONBASE;
      d := ImgLib.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(surface, FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d, 1)
      end;

      img := 570 + curframe; //EXPLOSIONBASE;
      d := g_WMagic2Images.GetCachedImage(img, px, py);
      if d <> nil then begin
        DrawBlend(surface, FlyX + px - UNITX div 2, FlyY + py - UNITY div 2, d, 1)
      end;
    end;
  end;
end;
end.
