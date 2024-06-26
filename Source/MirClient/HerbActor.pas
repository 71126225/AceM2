unit HerbActor;

interface

uses
  Windows,
  Grobal2, HGETextures, CliUtil, Actor, WIl, magiceff, ClFunc, sysutils, SoundUtil;

const
  BEEQUEENBASE = 600;
  DOORDEATHEFFECTBASE = 120;
  WALLLEFTBROKENEFFECTBASE = 224;
  WALLRIGHTBROKENEFFECTBASE = 240;

type
  TDoorState = (dsOpen, dsClose, dsBroken);

  TKillingHerb = class(TActor) //Size 0x250
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure CalcActorFrame; override;
    function GetDefaultFrame(wmode: Boolean): integer; override;
  end;

  TMineMon = class(TKillingHerb)
  private
  public
    constructor Create; override;
    procedure CalcActorFrame; override;
    //function  GetDefaultFrame (wmode: Boolean): integer; override;
  end;

  TBeeQueen = class(TActor)
  private
  public
    procedure CalcActorFrame; override;
    function GetDefaultFrame(wmode: Boolean): integer; override;
  end;

  TCentipedeKingMon = class(TKillingHerb) //Size 0x260
  private
    AttackEffectSurface: TDirectDrawSurface; //0x250
    BoUseDieEffect: Boolean; //0x254
    ax: integer; //0x258
    ay: integer; //0x25C

  public
    procedure LoadEffect();
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    procedure DrawEff(dsurface: TDirectDrawSurface; dx, dy: integer); override;
    function Run: Boolean; override;
  end;
  TBigHeartMon = class(TKillingHerb) //Size 0x260
  private
  public
    procedure CalcActorFrame; override;
  end;
  TSpiderHouseMon = class(TKillingHerb)
  private
  public
    procedure CalcActorFrame; override;
  end;
  TCastleDoor = class(TActor)
  private
    EffectSurface: TDirectDrawSurface;
    ax, ay: integer;
    oldunitx, oldunity: integer;
    procedure ApplyDoorState(dstate: TDoorState);
  public
    BoDoorOpen: Boolean;
    constructor Create; override;
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    function GetDefaultFrame(wmode: Boolean): integer; override;
    procedure ActionEnded; override;
    function Run: Boolean; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend:
      Boolean; boFlag: Boolean); override;
  end;

  TWallStructure = class(TActor) //0x62
  private
    EffectSurface: TDirectDrawSurface;
    BrokenSurface: TDirectDrawSurface;
    ax, ay, bx, by: integer;
    deathframe: integer;
    bomarkpos: Boolean; //못가게 막고 있는지
  public
    constructor Create; override;
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    function GetDefaultFrame(wmode: Boolean): integer; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend:
      Boolean; boFlag: Boolean); override;
    function Run: Boolean; override;
  end;

  TSoccerBall = class(TActor) //0x9
  private
  public
  end;

  TDragonBody = class(TKillingHerb) //0x5a
  private
    procedure AttackEff;
  public
    procedure DrawEff(dsurface: TDirectDrawSurface; dx, dy: integer); override;
    procedure CalcActorFrame(); override;
    procedure LoadSurface(); override;
  end;

  TElement = class (TBeeQueen)
     EffectSurface :TDirectDrawSurface;
     ax,ay:Integer;
   public
     constructor Create; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   TTrapRock = class (TBeeQueen)
   public
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
   end;

   TGuardianRock = class (TBeeQueen)
     EffectSurface :TDirectDrawSurface;
     ax,ay:Integer;
   public
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   TOrbSpirit = class (TBeeQueen)
     nlevel:byte;
     EffectSurface :TDirectDrawSurface;
     ax,ay:Integer;
   private
     procedure AttackEff;
   public
     constructor Create; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
     //function  Run:boolean; override;
     function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;

implementation

uses
  ClMain, MShare, WMFile;

{============================== TKillingHerb =============================}

//        식인초

{--------------------------}

constructor TKillingHerb.Create;
begin
  inherited Create;
end;

destructor TKillingHerb.Destroy;
begin
  inherited Destroy;
end;

procedure TKillingHerb.CalcActorFrame;
var
  pm: PTMonsterAction;
  //   haircount: integer;
begin
  m_boUseMagic := FALSE;
  m_nCurrentFrame := -1;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_TURN: {//} begin
        m_nStartFrame := pm.ActStand.start;
          // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_DIGUP: {//, SM_DIGUP, .} begin
        m_nStartFrame := pm.ActWalk.start;
          // + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
        m_dwFrameTime := pm.ActWalk.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nMaxTick := pm.ActWalk.UseTick;
        m_nCurTick := 0;
        //WarMode := FALSE;
        m_nMoveStep := 1;
        Shift(m_btDir, 0, 0, 1); //m_nMoveStep, 0, m_nEndFrame-startframe+1);
      end;
    SM_HIT: begin
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame +
          pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        //WarMode := TRUE;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_STRUCK: begin
        m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame +
          pm.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
        m_dwFrameTime := pm.ActStruck.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_DEATH: begin
        m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame +
          pm.ActDie.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_nStartFrame := m_nEndFrame; //
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_NOWDEATH: begin
        m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame +
          pm.ActDie.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_DIGDOWN: begin
        m_nStartFrame := pm.ActDeath.start;
        m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
        m_dwFrameTime := pm.ActDeath.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_boDelActionAfterFinished := TRUE;
      end;
  end;
end;

function TKillingHerb.GetDefaultFrame(wmode: Boolean): integer;
var
  cf: integer;
  pm: PTMonsterAction;
begin
  Result := 0; //jacky
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;
  m_dwDefFrameTick := pm.ActStand.ftime;
  if m_boDeath then begin
    if m_boSkeleton then
      Result := pm.ActDeath.start
    else
      Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) +
        (pm.ActDie.frame - 1);
  end
  else begin
    m_nDefFrameCount := pm.ActStand.frame;
    if m_nCurrentDefFrame < 0 then
      cf := 0
    else if m_nCurrentDefFrame >= pm.ActStand.frame then
      cf := 0
    else
      cf := m_nCurrentDefFrame;
    Result := pm.ActStand.start + cf; //방향이 없음..
  end;
end;

{----------------------------------------------------------------------}
//비막원충

procedure TBeeQueen.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_boUseMagic := FALSE;
  m_nCurrentFrame := -1;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_TURN: {//방향이 없음...} begin
        m_nStartFrame := pm.ActStand.start;
          // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_HIT: begin
        m_nStartFrame := pm.ActAttack.start;
          // + Dir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        //WarMode := TRUE;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_STRUCK: begin
        m_nStartFrame := pm.ActStruck.start;
          // + Dir * (pm.ActStruck.frame + pm.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
        m_dwFrameTime := pm.ActStruck.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_DEATH: begin
        m_nStartFrame := pm.ActDie.start;
          // + Dir * (pm.ActDie.frame + pm.ActDie.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_nStartFrame := m_nEndFrame; //
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_NOWDEATH: begin
        m_nStartFrame := pm.ActDie.start;
          // + Dir * (pm.ActDie.frame + pm.ActDie.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
  end;
end;

function TBeeQueen.GetDefaultFrame(wmode: Boolean): integer;
var
  pm: PTMonsterAction;
  cf: integer;
begin
  Result := 0; //jacky
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;
  m_dwDefFrameTick := pm.ActStand.ftime;
  if m_boDeath then begin
    Result := pm.ActDie.start + (pm.ActDie.frame - 1);
  end
  else begin
    m_nDefFrameCount := pm.ActStand.frame;
    if m_nCurrentDefFrame < 0 then
      cf := 0
    else if m_nCurrentDefFrame >= pm.ActStand.frame then
      cf := 0
    else
      cf := m_nCurrentDefFrame;
    Result := pm.ActStand.start + cf; //방향이 없음..
  end;
end;

{----------------------------------------------------------------------}
//지네왕

procedure TCentipedeKingMon.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_boUseMagic := FALSE;
  m_nCurrentFrame := -1;

  individual_level_of_light := 0;
  individual_depth_of_dark := 0;
  individual_incremental_increase_of_light := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_TURN: {//} begin
        m_btDir := 0;
        inherited CalcActorFrame;
      end;
    SM_HIT: begin
        m_btDir := 0;
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        BoUseDieEffect := True;
        m_nEffectFrame := 0;
        m_nEffectStart := 0;
        m_nEffectEnd := m_nEffectStart + 9;
        m_dwEffectFrameTime := 62;
        //            BoUseEffect:=True;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_DIGDOWN: begin
        inherited CalcActorFrame;
      end;
  else begin
      m_btDir := 0;
      inherited CalcActorFrame;
    end;
  end;
end;

{----------------------------------------------------------------------}
//성벽, 성문

constructor TCastleDoor.Create;
begin
  inherited Create;
  m_btDir := 0;
  EffectSurface := nil;
  m_nDownDrawLevel := 1;
    //1셀 먼저 그림. (사람 머리가 성문 밑으로 들어가는 것을 막음)
end;

procedure TCastleDoor.ApplyDoorState(dstate: TDoorState);
var
  bowalk: Boolean;
begin
  Map.MarkCanWalk(m_nCurrX, m_nCurrY - 2, TRUE);
  Map.MarkCanWalk(m_nCurrX + 1, m_nCurrY - 1, TRUE);
  Map.MarkCanWalk(m_nCurrX + 1, m_nCurrY - 2, TRUE);
  if dstate = dsClose then
    bowalk := FALSE
  else
    bowalk := TRUE;

  Map.MarkCanWalk(m_nCurrX, m_nCurrY, bowalk);
  Map.MarkCanWalk(m_nCurrX, m_nCurrY - 1, bowalk);
  Map.MarkCanWalk(m_nCurrX, m_nCurrY - 2, bowalk);
  Map.MarkCanWalk(m_nCurrX + 1, m_nCurrY - 1, bowalk);
  Map.MarkCanWalk(m_nCurrX + 1, m_nCurrY - 2, bowalk);
  Map.MarkCanWalk(m_nCurrX - 1, m_nCurrY - 1, bowalk);
  Map.MarkCanWalk(m_nCurrX - 1, m_nCurrY, bowalk);
  Map.MarkCanWalk(m_nCurrX - 1, m_nCurrY + 1, bowalk);
  Map.MarkCanWalk(m_nCurrX - 2, m_nCurrY, bowalk);

  if dstate = dsOpen then begin
    Map.MarkCanWalk(m_nCurrX, m_nCurrY - 2, FALSE);
    Map.MarkCanWalk(m_nCurrX + 1, m_nCurrY - 1, FALSE);
    Map.MarkCanWalk(m_nCurrX + 1, m_nCurrY - 2, FALSE);
  end;
end;

procedure TCastleDoor.LoadSurface;
var
  mimg: TWMImages;
begin
  inherited LoadSurface;
  mimg := GetMonImg(m_wAppearance);
  if m_boUseEffect then
    EffectSurface := mimg.GetCachedImage(DOORDEATHEFFECTBASE + (m_nCurrentFrame
      - m_nStartFrame), ax, ay);
end;

procedure TCastleDoor.CalcActorFrame;
var
  pm: PTMonsterAction;
  //   haircount: integer;
begin
  m_boUseEffect := FALSE;
  m_nCurrentFrame := -1;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;
  m_UserName := ' ';
  SetUsername('', -1, True);

  case m_nCurrentAction of
    SM_NOWDEATH: begin
        m_nStartFrame := pm.ActDie.start;
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        m_boUseEffect := TRUE;
        ApplyDoorState(dsBroken); //움직일 수 있게
      end;
    SM_STRUCK: begin
        m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame +
          pm.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_DIGUP: {//문 열림} begin
        m_nStartFrame := pm.ActAttack.start;
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        ApplyDoorState(dsOpen); //움직일 수 있게
      end;
    SM_DIGDOWN: {//문 닫힘} begin
        m_nStartFrame := pm.ActCritical.start;
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        BoDoorOpen := FALSE;
        m_boHoldPlace := TRUE;
        ApplyDoorState(dsClose); //못움직임
      end;
    SM_DEATH: begin
        m_nStartFrame := pm.ActDie.start + pm.ActDie.frame - 1;
        m_nEndFrame := m_nStartFrame;
        m_nDefFrameCount := 0;
        ApplyDoorState(dsBroken); //움직일 수 있게
      end;
  else {//방향이 없음...} begin
      if m_btDir < 3 then begin
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame +
          pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame; // + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nDefFrameCount := 0; //pm.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
        BoDoorOpen := FALSE;
        m_boHoldPlace := TRUE;
        ApplyDoorState(dsClose); //못움직이게
      end
      else begin
        m_nStartFrame := pm.ActCritical.start; //열려있는 상태
        m_nEndFrame := m_nStartFrame;
        m_nDefFrameCount := 0;

        BoDoorOpen := TRUE;
        m_boHoldPlace := FALSE;
        ApplyDoorState(dsOpen); //걸을 수 있음
      end;
    end;
  end;
end;

function TCastleDoor.GetDefaultFrame(wmode: Boolean): integer;
var
  pm: PTMonsterAction;
begin
  Result := 0; //jacky
  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;
  m_dwDefFrameTick := pm.ActStand.ftime;
  if m_boDeath then begin
    Result := pm.ActDie.start + pm.ActDie.frame - 1;
    m_nDownDrawLevel := 2;
  end
  else begin
    if BoDoorOpen then begin
      m_nDownDrawLevel := 2;
      Result := pm.ActCritical.start;
        // + Dir * (pm.ActStand.frame + pm.ActStand.skip);
    end
    else begin
      m_nDownDrawLevel := 1;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame +
        pm.ActStand.skip);
    end;
  end;
end;

procedure TCastleDoor.ActionEnded;
begin
  if m_nCurrentAction = SM_DIGUP then begin //문열림
    BoDoorOpen := TRUE;
    m_boHoldPlace := FALSE;
  end;
  //   if CurrentAction = SM_DIGDOWN then
  //      DefaultMotion;
end;

function TCastleDoor.Run: Boolean;
begin
//  Result := False;
  if (Map.m_nCurUnitX <> oldunitx) or (Map.m_nCurUnitY <> oldunity) then begin
    if m_boDeath then
      ApplyDoorState(dsBroken)
    else if BoDoorOpen then
      ApplyDoorState(dsOpen)
    else
      ApplyDoorState(dsClose);
  end;
  oldunitx := Map.m_nCurUnitX;
  oldunity := Map.m_nCurUnitY;
  Result := inherited Run;
end;

procedure TCastleDoor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend: Boolean; boFlag: Boolean);
begin
  inherited DrawChr(dsurface, dx, dy, blend, False);
  if m_boUseEffect and not blend then
    if EffectSurface <> nil then begin
      DrawBlend(dsurface,
        dx + ax + m_nShiftX,
        dy + ay + m_nShiftY,
        EffectSurface, 1);
    end;
end;

{----------------------------------------------------------------------}
//성벽

constructor TWallStructure.Create;
begin
  inherited Create;
  m_btDir := 0;
  EffectSurface := nil;
  BrokenSurface := nil;
  bomarkpos := FALSE;
  //DownDrawLevel := 1;
end;

procedure TWallStructure.CalcActorFrame;
var
  pm: PTMonsterAction;
  //   haircount: integer;
begin
  m_boUseEffect := FALSE;
  m_nCurrentFrame := -1;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;
  m_UserName := ' ';
  SetUsername('', -1, True);
  deathframe := 0;
  m_boUseEffect := FALSE;

  case m_nCurrentAction of
    SM_NOWDEATH: begin
        m_nStartFrame := pm.ActDie.start;
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        deathframe := pm.ActStand.start + m_btDir;
        Shift(m_btDir, 0, 0, 1);
        m_boUseEffect := TRUE;
      end;
    SM_DEATH: begin
        m_nStartFrame := pm.ActDie.start + pm.ActDie.frame - 1;
        m_nEndFrame := m_nStartFrame;
        m_nDefFrameCount := 0;
      end;
    SM_DIGUP: {//모습이 변경될때 마다} begin
        m_nStartFrame := pm.ActDie.start;
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        deathframe := pm.ActStand.start + m_btDir;
        m_boUseEffect := TRUE;
      end;
  else {//방향이 없음...} begin
      m_nStartFrame := pm.ActStand.start + m_btDir;
        // * (pm.ActStand.frame + pm.ActStand.skip);
      m_nEndFrame := m_nStartFrame; // + pm.ActStand.frame - 1;
      m_dwFrameTime := pm.ActStand.ftime;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_nDefFrameCount := 0; //pm.ActStand.frame;
      Shift(m_btDir, 0, 0, 1);
      m_boHoldPlace := TRUE;
    end;
  end;
end;

procedure TWallStructure.LoadSurface;
var
  mimg: TWMImages;
begin
  mimg := GetMonImg(m_wAppearance);
  if deathframe > 0 then begin //(CurrentAction = SM_NOWDEATH) or (CurrentAction = SM_DEATH) then begin
    m_BodySurface := mimg.GetCachedImage(GetOffset(m_wAppearance) + deathframe, m_nPx, m_nPy);
  end
  else begin
    inherited LoadSurface;
  end;
  {if m_wAppearance = 906 then
    Dec(m_nPx);
  if m_wAppearance = 905 then begin
    Dec(m_nPx, 4);
    Inc(m_nPy, 9);
  end; }

  if m_wAppearance > 903 then
    BrokenSurface := g_WEffectImages.GetCachedImage(GetOffset(m_wAppearance - 3) + 8 + m_btDir, bx, by)
  else
    BrokenSurface := g_WEffectImages.GetCachedImage(GetOffset(m_wAppearance) + 8 + m_btDir, bx, by);

  if m_boUseEffect then begin
    if m_wAppearance = 901 then
      EffectSurface := g_WEffectImages.GetCachedImage(WALLLEFTBROKENEFFECTBASE + (m_nCurrentFrame - m_nStartFrame), ax, ay)
    else
      EffectSurface := g_WEffectImages.GetCachedImage(WALLRIGHTBROKENEFFECTBASE +(m_nCurrentFrame - m_nStartFrame), ax, ay);
  end;
end;

function TWallStructure.GetDefaultFrame(wmode: Boolean): integer;
var
  pm: PTMonsterAction;
begin
  Result := 0; //jacky
  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then exit;
  Result := pm.ActStand.start + m_btDir;
    // * (pm.ActStand.frame + pm.ActStand.skip);
end;

procedure TWallStructure.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend: Boolean; boFlag: Boolean);
begin
  inherited DrawChr(dsurface, dx, dy, blend, boFlag);
  if (BrokenSurface <> nil) and (not blend) then begin
    dsurface.Draw(dx + bx + m_nShiftX,
      dy + by + m_nShiftY,
      BrokenSurface.ClientRect,
      BrokenSurface, TRUE);
  end;
  if m_boUseEffect and (not blend) then begin
    if EffectSurface <> nil then begin
      DrawBlend(dsurface,
        dx + ax + m_nShiftX,
        dy + ay + m_nShiftY,
        EffectSurface, 1);
    end;
  end;
end;

function TWallStructure.Run: Boolean;
begin
  if m_boDeath then begin
    if bomarkpos then begin
      Map.MarkCanWalk(m_nCurrX, m_nCurrY, TRUE);
      bomarkpos := FALSE;
    end;
  end
  else begin
    if not bomarkpos then begin
      Map.MarkCanWalk(m_nCurrX, m_nCurrY, FALSE);
      bomarkpos := TRUE;
    end;
  end;
  PlayScene.SetActorDrawLevel(self, 0);
  Result := inherited Run;
end;

{ TMineMon }

procedure TMineMon.CalcActorFrame;
begin
  inherited;

end;

constructor TMineMon.Create;
begin
  inherited;

end;

procedure TCentipedeKingMon.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  if m_boUseEffect then
    if AttackEffectSurface <> nil then
      DrawBlend(dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, AttackEffectSurface, 1);

end;

procedure TCentipedeKingMon.LoadEffect;
begin
  if m_boUseEffect then
    AttackEffectSurface := g_WMons[15].GetCachedImage(100 + m_nEffectFrame - m_nEffectStart, ax, ay);
end;

procedure TCentipedeKingMon.LoadSurface;
var
  meff: TMagicEff;
begin
  inherited LoadSurface;
  LoadEffect();
end;

{function TMineMon.GetDefaultFrame(wmode: Boolean): integer;
begin
  //Result
end;     }

{ TBigHeartMon }

procedure TBigHeartMon.CalcActorFrame;
begin
  m_btDir := 0;
  inherited CalcActorFrame;
end;

{ TSpiderHouseMon }

procedure TSpiderHouseMon.CalcActorFrame;
begin
  m_btDir := 0;
  inherited CalcActorFrame;
end;

function TCentipedeKingMon.Run: Boolean;
begin
  Result := False;
  if (m_nCurrentAction = SM_WALK) or
    (m_nCurrentAction = SM_BACKSTEP) or
    (m_nCurrentAction = SM_HORSERUN) or
    (m_nCurrentAction = SM_RUN) then
    exit;
  if BoUseDieEffect then begin
    if (m_nCurrentFrame - m_nStartFrame) >= 5 then begin
      BoUseDieEffect := False;
      m_boUseEffect := True;
      m_dwEffectStartTime := FrmMain.m_CurrentTick;
      m_nEffectFrame := 0;
      LoadEffect();
      Result := True;
    end;
  end;
  if m_boUseEffect then begin
    if (FrmMain.m_CurrentTick - m_dwEffectStartTime) > m_dwEffectFrameTime then begin
      m_dwEffectStartTime := FrmMain.m_CurrentTick;
      if m_nEffectFrame < m_nEffectEnd then begin
        Inc(m_nEffectFrame);
        LoadEffect();
        Result := True;
      end
      else
        m_boUseEffect := False;
    end;
  end;
  Result := (inherited Run) or Result;
end;

{ TDragonBody }

procedure TDragonBody.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_btDir:=0;
  m_boUseMagic:=False;
  m_nCurrentFrame:= -1;
  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;
  case m_nCurrentAction of
    SM_DIGUP: begin
      m_nMaxTick:=pm.ActWalk.ftime;
      m_nCurTick:=0;
      m_nMoveStep:=1;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_HIT: begin
      AttackEff
    end;
  end;
  m_nStartFrame:=0;
  m_nEndFrame:=1;
  m_dwFrameTime:=400;
  m_dwStartTime:=FrmMain.m_CurrentTick;
end;

procedure TDragonBody.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
//0x0046C3C0
begin
   if not (m_btDir in [0..7]) then exit;
   if FrmMain.m_CurrentTick - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := FrmMain.m_CurrentTick;
      LoadSurface;
   end;
    if m_BodySurface <> nil then
//      DrawBlend (dsurface,dx + m_nPx + m_nShiftX,dy + m_nPy + m_nShiftY,m_BodySurface, 1);

end;

procedure TDragonBody.LoadSurface;
begin
  m_BodySurface := nil;
//  m_BodySurface := FrmMain.WDragonImg.GetCachedImage(GetOffset(m_wAppearance),m_nPx,m_nHpy);
end;

procedure TDragonBody.AttackEff;
var
  n8,nC,n10,n14,n18:integer;
  bo11:Boolean;
  i,iCount:integer;
begin
    n8:=m_nCurrX;
    nC:=m_nCurrY;
//    PlayScene.NewMagic (Self,80,80,XX,YY,n8 - 3,nC + 3,0,mtThunder,False,30,bo11);
//    PlayScene.NewMagic (Self,80,80,XX,YY,n8 - 3,nC + 3,0,mtThunder,False,30,bo11);
    iCount:=Random(5);
    for i:=0 to iCount do begin
    n10:=Random(4);
    n14:=Random(8);
    n18:=Random(8);
    case n10 of
      0: begin
        PlayScene.NewMagic (Self,75,75,m_nCurrX,m_nCurrY,n8 - n14 - 2,nC + n18 + 1,0,mtThunder,False,30,bo11);
      end;
      1: begin
        PlayScene.NewMagic (Self,75,75,m_nCurrX,m_nCurrY,n8 - n14,nC + n18,0,mtThunder,False,30,bo11);
      end;
      2: begin
        PlayScene.NewMagic (Self,75,75,m_nCurrX,m_nCurrY,n8 - n14,nC + n18 + 1,0,mtThunder,False,30,bo11);
      end;
      3: begin
        PlayScene.NewMagic (Self,75,75,m_nCurrX,m_nCurrY,n8 - n14 - 2,nC + n18,0,mtThunder,False,30,bo11);
      end;
    end;
    end;
end;

constructor TElement.Create;
begin
  inherited;
  m_boUseEffect := True;
  EffectSurface := nil;
end;

procedure TElement.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;

  individual_level_of_light := 0;
  individual_depth_of_dark := 0;
  individual_incremental_increase_of_light := 0;

  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_LIGHTING: begin
      m_btDir := 0;
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_WALK, SM_BACKSTEP:
      begin
        m_nStartFrame := pm.ActWalk.start;
        m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
        m_dwFrameTime := pm.ActWalk.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nMaxTick := pm.ActWalk.UseTick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        if m_nCurrentAction = SM_WALK then
          Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
        else  //sm_backstep
          Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
    end;
    SM_DEATH: begin
      inherited;
      m_boUseEffect := False;
    end;
    SM_HIT: begin
    end;
    else begin
      m_btDir := 0;
      inherited CalcActorFrame;;
    end;
  end;
end;

procedure TElement.LoadSurface;
var
  mimg: TWMImages;
begin
  inherited;
  mimg := GetMonImg (m_wAppearance);
  EffectSurface := mimg.GetCachedImage (
                                m_nBodyOffset + 50 + m_nCurrentFrame,
                                ax,
                                ay);
  if (m_nCurrentAction = SM_NOWDEATH) and (m_nCurrentFrame = 49) then
    m_boUseEffect := False;
end;

procedure TElement.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
var
   idx: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
begin

  if (EffectSurface <> nil) and m_boUseEffect then begin
    DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    EffectSurface, 1);

  end;
end;

procedure TTrapRock.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_LIGHTING: begin
      m_btDir := 0;
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_DIGUP: //, SM_DIGUP, .
      begin
        m_nStartFrame := pm.ActWalk.start; // + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
        m_dwFrameTime := pm.ActWalk.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nMoveStep := 1;
        Shift (m_btDir, 0, 0, 1); //m_nMoveStep, 0, m_nEndFrame-startframe+1);
      end;
    else begin
      m_btDir := 0;
      inherited CalcActorFrame;;
    end;
  end;
end;

procedure TTrapRock.LoadSurface;
var
  Meff:TMagicEff;
  target_object: TActor;
begin
  inherited;
  case m_nCurrentAction of
    SM_LIGHTING: begin
      target_object := PlayScene.FindActor(m_nTargetRecog);
      if (m_nCurrentFrame-m_nStartFrame = 1) then begin
        meff := TDrawEffectOnObject.Create(PlayScene.FindActor(m_nTargetRecog),g_WMons[75],1410,10,100,TRUE);
        PlayScene.m_EffectList.Add (meff);
      end;
    end;
  end;
end;

procedure TGuardianRock.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
  if (EffectSurface <> nil) and m_boUseEffect then begin
    DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    EffectSurface, 1);
  end;
end;

procedure TGuardianRock.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_LIGHTING: begin
      m_btDir := 0;
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := True;
    end;
    else begin
      inherited;
    end;
  end;
end;

procedure TGuardianRock.LoadSurface;
var
  mimg: TWMImages;
  img: integer;
  Meff:TMagicEff;
begin
  inherited;
  EffectSurface := nil;
  if not m_boUseEffect then exit;
  case m_nCurrentAction of
    SM_LIGHTING: begin
      if (m_nCurrentFrame-m_nStartFrame = 3) then begin
        meff := TDrawEffectOnObject.Create(self,g_WMons[75],1440,10,100,TRUE);
        meff.Light := 3;
        PlayScene.m_EffectList.Add (meff);
      end;
    end;
  end;
  mimg := GetMonImg (m_wAppearance);
  img:= m_nBodyOffset + 5 + m_nCurrentFrame;
  EffectSurface := mimg.GetCachedImage (
                                img,
                                ax,
                                ay);
  if m_nCurrentFrame = 13 then
    m_boUseEffect := False;
end;

constructor TOrbSpirit.Create;
begin
  inherited;
  m_boUseEffect := True;
  EffectSurface := nil;
  nlevel := 0;
end;

procedure TOrbSpirit.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
  if (EffectSurface <> nil) and m_boUseEffect then begin
    DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    EffectSurface, 1);
  end;
end;

procedure TOrbSpirit.CalcActorFrame;
var
   pm: PTMonsterAction;
   target_object: TActor;
begin
  m_nCurrentFrame := -1;

  individual_level_of_light := 0;
  individual_depth_of_dark := 0;
  individual_incremental_increase_of_light := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  nLevel := m_btDir;

  case m_nCurrentAction of
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActStand.start;
      m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
      m_dwFrameTime := pm.ActStand.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := True;
    end;
    SM_NOWDEATH: begin
      nlevel := 4;
      m_nCurrentFrame := -1;
      inherited;
    end;
    SM_HIT: begin
      AttackEff();
      inherited;
    end;
    else begin
      inherited;
    end;
  end;
end;

procedure TOrbSpirit.LoadSurface;
var
  mimg: TWMImages;
  img: integer;
  Meff:TMagicEff;
begin
  inherited;
  EffectSurface := nil;
  if not m_boUseEffect then exit;
  mimg := GetMonImg (m_wAppearance);
  if mimg <> nil then
    m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame + nLevel * 80, m_nPx, m_nPy);

  img:= m_nBodyOffset + 40 + m_nCurrentFrame + nLevel * 80;

  case m_nCurrentAction of
    SM_LIGHTING: begin
      img:= 2140 + m_nCurrentFrame;
    end;
    SM_NOWDEATH: begin
      img := 2010 + m_nCurrentFrame;
      if m_nCurrentFrame = 97 then
        m_boUseEffect := False;
    end;
    SM_FLYAXE: begin
      if (m_nCurrentFrame - m_nStartFrame) = 4 then begin
        meff := TDrawEffectOnObject.Create(PlayScene.FindActor(m_nTargetRecog),g_WMons[75],2120,20,100,TRUE);
        PlaySoundEx(3477);
        PlayScene.m_EffectList.Add (meff);
      end;
    end;
  end;
  EffectSurface := mimg.GetCachedImage(img, ax, ay);
end;

//constructor TOrbSpirit.Create;
//begin
//  inherited;
//  m_boUseEffect := True;
//  EffectSurface := nil;
//  nlevel := 0;
//end;
//
//procedure TOrbSpirit.LoadSurface;
//var
//  mimg: TWMImages;
//  img: integer;
//begin
//  //inherited;
//  mimg := GetMonImg (m_wAppearance);
//  if mimg <> nil then begin
//         m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame + nlevel * 80, m_nPx, m_nPy)
//  end;
//  img:= m_nBodyOffset + 40 + m_nCurrentFrame + nlevel * 80;
//  if m_nCurrentAction = SM_LIGHTING then begin
//    img:= 2140 + m_nCurrentFrame; //mass attack
//  end;
//  if m_nCurrentAction = SM_NOWDEATH then
//    img := 2010 + m_nCurrentFrame;
//  EffectSurface := mimg.GetCachedImage (
//                                img,
//                                ax,
//                                ay);
//  if (m_nCurrentAction = SM_NOWDEATH) and (m_nCurrentFrame = 97) then
//    m_boUseEffect := False;
//end;
//
//procedure TOrbSpirit.CalcActorFrame;
//var
//   pm: PTMonsterAction;
//   Meff:TMagicEff;
//begin
//  m_nBodyOffset := GetOffset(m_wAppearance);
//  pm := GetRaceByPM (m_btRace,m_wAppearance);
//  if pm = nil then exit;
//
//  case m_nCurrentAction of
//    SM_LIGHTING: begin
//      m_nCurrentFrame := -1;
//      m_btDir := 0;
//      m_nStartFrame := pm.ActStand.start;
//      m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
//      m_dwFrameTime := pm.ActStand.ftime;
//      m_dwStartTime := FrmMain.m_CurrentTick;
//      m_dwWarModeTime := FrmMain.m_CurrentTick;
//      Shift (m_btDir, 0, 0, 1);
////      PlaySound(2578);
//    end;
//    SM_FLYAXE: begin
//      m_btDir := 0;
//      meff := TDrawEffectOnObject.Create(PlayScene.FindActor(m_nTargetRecog),g_WMons[75],2120,20,100,TRUE);
//      PlayScene.m_EffectList.Add (meff);
////      PlaySound(2579);
//    end;
//    SM_HIT_2: begin
//      AttackEff();
////      PlaySound(2576);
//    end;
//    SM_HIT_3: begin
//      meff := TDrawEffectOnObject.Create(PlayScene.FindActor(m_nTargetRecog),g_WMons[75],2250,15,120,TRUE);
//      PlayScene.m_EffectList.Add(meff);
//    end;
//    SM_TURN: begin
//      nlevel:=m_btDir;
//      m_nCurrentFrame := -1;
//      inherited;
//    end;
//    SM_NOWDEATH: begin
//      nlevel := 4;
//      m_nCurrentFrame := -1;
//      inherited;
//    end;
//    SM_DEATH: begin
//      nlevel := 4;
//      m_nCurrentFrame := -1;
//      inherited;
//      m_boUseEffect := False;
//    end;
//    SM_HIT: begin
//      nlevel:=m_btDir;
//    end;
//    else begin
//      m_btDir := 0;
//      m_nCurrentFrame := -1;
//      inherited CalcActorFrame;;
//    end;
//  end;
//end;
//
//procedure TOrbSpirit.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
//begin
//
//  if (EffectSurface <> nil) and m_boUseEffect then begin
//    DrawBlend (dsurface,
//                    dx + ax + m_nShiftX,
//                    dy + ay + m_nShiftY,
//                    EffectSurface, 1);
//
//  end;
//end;
//
procedure TOrbSpirit.AttackEff;
var
  n8,nC,n10,n14,n18:integer;
  bo11:Boolean;
  i,iCount:integer;
  Meff:TMagicEff;
  nDelay:integer;
begin
    n8:=m_nCurrX;
    nC:=m_nCurrY;
    iCount:=Random(10)+8;
    nDelay:=200;
    for i:=0 to iCount do begin
      n10:=Random(4);
      n14:=Random(15);
      n18:=Random(15);
      case n10 of
        0: begin
          meff:=TNormalDrawEffect.Create(n8 + n14 - 7,nC + n18 - 7,g_WMons[75],2160,20,ndelay,TRUE);
        end;
        1: begin
          meff:=TNormalDrawEffect.Create(n8 + n14 - 7,nC + n18 - 7,g_WMons[75],2180,20,ndelay,TRUE);
        end;
        2: begin
          meff:=TNormalDrawEffect.Create(n8 + n14 - 7,nC + n18 - 7,g_WMons[75],2200,20,ndelay,TRUE);
        end;
        3: begin
          meff:=TNormalDrawEffect.Create(n8 + n14 - 7,nC + n18 - 7,g_WMons[75],2220,20,ndelay,TRUE);
        end;
        4: begin
          meff:=TNormalDrawEffect.Create(n8 + n14 - 7,nC + n18 - 7,g_WMons[75],2240,20,ndelay,TRUE);
        end;
      end;
      if Random(3) = 0 then
        PlaySoundEx(3479);
      PlayScene.m_EffectList.Add (meff);
    end;
end;
//
//function TOrbSpirit.Run:boolean;
//var
//   prv: integer;
//   m_dwFrameTimetime: longword;
//   bofly: Boolean;
//begin
//   if (m_nCurrentAction = SM_WALK) or
//      (m_nCurrentAction = SM_BACKSTEP) or
//      (m_nCurrentAction = SM_RUN) or
//      (m_nCurrentAction = SM_HORSERUN) or
//
//      (m_nCurrentAction = SM_RUSH) or
//      (m_nCurrentAction = SM_RUSHKUNG)
//   then exit;
//
//   m_boMsgMuch := FALSE;
//   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
//
//   RunActSound (m_nCurrentFrame - m_nStartFrame);
//   RunFrameAction (m_nCurrentFrame - m_nStartFrame);
//
//   prv := m_nCurrentFrame;
//   if m_nCurrentAction <> 0 then begin
//      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
//         m_nCurrentFrame := m_nStartFrame;
//
//      if (m_boUseMagic) then begin
//         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
//      end else begin
//         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
//         else m_dwFrameTimetime := m_dwFrameTime;
//      end;
//
//      if FrmMain.m_CurrentTick - m_dwStartTime > m_dwFrameTimetime then begin
//         if m_nCurrentFrame < m_nEndFrame then begin
//           Inc (m_nCurrentFrame);
//            m_dwStartTime := FrmMain.m_CurrentTick;
//         end else begin
//            if m_boDelActionAfterFinished then begin
//               m_boDelActor := TRUE;
//            end;
//            ActionEnded;
//             m_nCurrentAction := 0;
//             m_boUseMagic := FALSE;
//         end;
//      end;
//      m_nCurrentDefFrame := 0;
//      m_dwDefFrameTime := FrmMain.m_CurrentTick;
//   end else begin
//      if FrmMain.m_CurrentTick - m_dwSmoothMoveTime > 100 then begin
//         if FrmMain.m_CurrentTick - m_dwDefFrameTime > 100 then begin
//            m_dwDefFrameTime := FrmMain.m_CurrentTick;
//            Inc (m_nCurrentDefFrame);
//            if m_nCurrentDefFrame >= m_nDefFrameCount then
//               m_nCurrentDefFrame := 0;
//         end;
//         DefaultMotion;
//      end;
//   end;
//
//   if prv <> m_nCurrentFrame then begin
//      m_dwLoadSurfaceTime := FrmMain.m_CurrentTick;
//      LoadSurface;
//   end;
//   result := inherited run;
//end;
//
function  TOrbSpirit.GetDefaultFrame (wmode: Boolean): integer;
//var
//   pm: PTMonsterAction;
//   cf: integer;
begin
   Result:=0;//jacky
//   pm := GetRaceByPM (m_btRace,m_wAppearance);
//   if pm = nil then exit;
//
   if m_boDeath then begin
      Result := 417;
   end else
     result:= inherited GetDefaultFrame(wmode);
//   end else begin
//      m_nDefFrameCount := pm.ActStand.frame;
//      if m_nCurrentDefFrame < 0 then cf := 0
//      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
//      else cf := m_nCurrentDefFrame;
//      Result := pm.ActStand.start + cf;
//   end;
end;

end.
