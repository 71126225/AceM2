unit AxeMon3;

interface
uses
  Windows, Classes,
  Grobal2, HGETextures, CliUtil, ClFunc, magiceff, Actor, AxeMon, AxeMon2, ClEvent, sysutils;

type
  TMagicMonSpider = class(TActor) //Size:25C
  private
    m_nEffectFrame: Integer;
    m_nEffectEnd: Integer;
    m_nEffectStart: Integer;
  protected
    EffectSurface: TDirectDrawSurface; //0x240
    ax: Integer; //0x244
    ay: integer; //0x248
  public
    constructor Create; override;
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    function Run: Boolean; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean; boFlag: Boolean); override;
  end;

  TManEaterWorm = class(TSkeletonOma)
  boCasted: Boolean;
  public
    procedure CalcActorFrame; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean; boFlag: Boolean); override;
    function Run(): Boolean; override;
    procedure LoadSurface; override;
    constructor Create(); override;
  end;

  TOrcObject = class(TSkeletonOma)
    m_nCurBubbleStruck: Integer;
    boCasted: Boolean;
  public
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    constructor Create; override;
    function Run: Boolean; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean; boFlag: Boolean); override;
   end;

  TOrcGiant = class(TOrcObject)
  public
    constructor Create; override;
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    function Run: Boolean; override;
  end;

  TOrcWarlord = class(TOrcObject)
  public
    constructor Create; override;
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    function Run: Boolean; override;
  end;

   TIceObject = class(TCatMon)
   protected
   public
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
    procedure DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean; boFlag: Boolean); override;
   end;

   TIceNode = class(TCatMon)
   protected
   public
    procedure CalcActorFrame; override;
    procedure LoadSurface; override;
   end;

implementation

uses
  ClMain, SoundUtil, WIL, MShare, WMFile;

{ TMagicMonSpider }

procedure TMagicMonSpider.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_boReverseFrame := FALSE;
  m_boUseEffect := FALSE;
  m_nEffectFrame := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_TURN: begin
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_WALK, SM_BACKSTEP: begin
        m_nStartFrame := pm.ActWalk.start + m_btDir * (pm.ActWalk.frame + pm.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
        m_dwFrameTime := pm.ActWalk.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_nMaxTick := pm.ActWalk.UseTick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        if m_nCurrentAction = SM_WALK then
          Shift(m_btDir, m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1)
        else
          Shift(GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame - m_nStartFrame + 1);
      end;
    SM_HIT: begin
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        case m_wAppearance of
          223, 231: begin
              m_boUseEffect := True;
              m_nEffectStart := m_nStartFrame + 80;
              m_nEffectEnd := m_nEffectStart + 10;
            end;
        end;
      end;
    SM_LIGHTING: begin
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
      end;
    SM_STRUCK: begin
        m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame + pm.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
        m_dwFrameTime := pm.ActStruck.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_DEATH: begin
        m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_nStartFrame := m_nEndFrame; //
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_NOWDEATH: begin
        m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
        m_dwFrameTime := pm.ActDie.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_SKELETON: begin
        m_nStartFrame := pm.ActDeath.start;
        m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
        m_dwFrameTime := pm.ActDeath.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
    SM_ALIVE: begin
        m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
        m_dwFrameTime := pm.ActDeath.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
      end;
  end;
end;

constructor TMagicMonSpider.Create;
begin
  inherited;
  EffectSurface := nil;
  m_nEffectFrame := 0;
  m_nEffectEnd := 0;
  m_nEffectStart := 0;
  m_boUseEffect := FALSE;
end;

procedure TMagicMonSpider.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
  if not (m_btDir in [0..7]) then exit;
  if FrmMain.m_CurrentTick - m_dwLoadSurfaceTime > 60 * 1000 then begin
    m_dwLoadSurfaceTime := FrmMain.m_CurrentTick;
    LoadSurface;
  end;

  ceff := GetDrawEffectValue(boFlag);

  if m_BodySurface <> nil then begin
    DrawEffSurface(dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
  end;

  if m_boUseEffect then
    if EffectSurface <> nil then begin
      DrawBlend(dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, EffectSurface, 1);
    end;
end;

procedure TMagicMonSpider.LoadSurface;
begin
  inherited;
  if m_boUseEffect then begin
    if (m_WMImages <> nil) then begin
      EffectSurface := m_WMImages.GetCachedImage(m_nBodyOffset + m_nEffectStart + m_nEffectFrame, ax, ay);
    end;
  end;
end;

function TMagicMonSpider.Run: Boolean;
var
  prv: integer;
  m_dwFrameTimetime: longword;
begin
  Result := False;
  if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or
    (m_nCurrentAction = SM_RUN) or (m_nCurrentAction = SM_HORSERUN) then
    exit;

  m_boMsgMuch := FALSE;
  if m_MsgList.Count >= 2 then
    m_boMsgMuch := TRUE;

  RunActSound(m_nCurrentFrame - m_nStartFrame);
  RunFrameAction(m_nCurrentFrame - m_nStartFrame);

  prv := m_nCurrentFrame;
  if m_nCurrentAction <> 0 then begin
    if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
      m_nCurrentFrame := m_nStartFrame;

    if m_boMsgMuch then
      m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
    else
      m_dwFrameTimetime := m_dwFrameTime;

    if FrmMain.m_CurrentTick - m_dwStartTime > m_dwFrameTimetime then begin
      if m_nCurrentFrame < m_nEndFrame then begin
        Inc(m_nCurrentFrame);
        Inc(m_nEffectFrame);
        m_dwStartTime := FrmMain.m_CurrentTick;
      end
      else begin
        if m_boUseEffect then begin
          if (m_nEffectStart + m_nEffectFrame) < m_nEffectEnd then begin
            Inc(m_nEffectFrame);
            prv := 0;
            m_dwStartTime := FrmMain.m_CurrentTick;
          end else begin
            m_nCurrentAction := 0;
            m_boUseEffect := FALSE;
          end;
        end else begin
          m_nCurrentAction := 0;
          m_boUseEffect := FALSE;
        end;
      end;
    end;
    m_nCurrentDefFrame := 0;
    m_dwDefFrameTime := FrmMain.m_CurrentTick;
  end
  else begin
    if FrmMain.m_CurrentTick - m_dwSmoothMoveTime > 200 then begin
      if FrmMain.m_CurrentTick - m_dwDefFrameTime > 500 then begin
        m_dwDefFrameTime := FrmMain.m_CurrentTick;
        Inc(m_nCurrentDefFrame);
        if m_nCurrentDefFrame >= m_nDefFrameCount then
          m_nCurrentDefFrame := 0;
      end;
      DefaultMotion;
    end;
  end;

  if prv <> m_nCurrentFrame then begin
    m_dwLoadSurfaceTime := FrmMain.m_CurrentTick;
    LoadSurface;
    Result := True;
  end;
end;

constructor TManEaterWorm.Create;
begin
  inherited;
  boCasted := False;
end;

function TManEaterWorm.Run: Boolean;
var
  meff: TFlyingBug;
begin
  if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame - m_nStartFrame = 3) and (not boCasted) then begin
    boCasted := True;
    meff := TFlyingBug(PlayScene.NewFlyObject(self,
      m_nCurrX,
      m_nCurrY,
      m_nTargetX,
      m_nTargetY,
      m_nTargetRecog,
      mt15));
    if meff <> nil then begin
      meff.ImgLib := g_WMons[22];
      meff.NextFrameTime := 50;
      meff.FlyImageBase := 350;
      meff.MagExplosionBase := 430;
    end;
  end;
  Result := inherited Run;
end;

procedure TManEaterWorm.DrawChr(dsurface: TDXTexture; dx: Integer; dy: Integer; blend: Boolean; boFlag: Boolean);
var
DeathImg, diex, diey: Integer;
DeathSurface: TDirectDrawSurface;
begin
  Inherited;
    if m_boDeath and (m_nCurrentFrame = m_nEndFrame) then begin
      case m_btDir of
        0: DeathImg := 539;
        1: DeathImg := 529;
        2: DeathImg := 589;
        3: DeathImg := 579;
        4: DeathImg := 569;
        5: DeathImg := 559;
        6: DeathImg := 549;
        7: DeathImg := 539;
      end;
      DeathSurface := g_WMons[32].GetCachedImage(DeathImg{ +
      m_nCurrentFrame - m_nStartFrame}, diex, diey);
      if DeathSurface <> nil then
        DrawBlend(dSurface, dx + diex + m_nShiftX, dy + diey + m_nShiftY, DeathSurface, 1);
    end;
end;

procedure TManEaterWorm.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  inherited;

  m_nCurrentFrame := -1;
  m_boReverseFrame := FALSE;
  m_boUseEffect := FALSE;
  m_boDelActionAfterFinished := FALSE;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_DIGUP: begin
        m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
        m_dwFrameTime := pm.ActDeath.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        //WarMode := TRUE;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        m_nMaxTick := pm.ActDeath.UseTick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        Shift(m_btDir, 0, 0, 1);
        m_boUseEffect := True;
      end;
    SM_FLYAXE: begin
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        boCasted := False;
    end;

    SM_HIT, SM_NOWDEATH: begin
        m_boUseEffect := True;
    end;
  end;
end;

procedure TManEaterWorm.LoadSurface;
var
DeathImg: Integer;
begin
  inherited;

  case m_nCurrentAction of
    SM_DIGUP: begin
      EffectSurface := g_WMons[32].GetCachedImage(80 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
      m_boUseEffect := True;
    end;
    SM_HIT: begin
      EffectSurface := g_WMons[32].GetCachedImage(430 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
      m_boUseEffect := True;
    end;
    SM_NOWDEATH: begin
      case m_btDir of
        0: DeathImg := 530;
        1: DeathImg := 520;
        2: DeathImg := 580;
        3: DeathImg := 570;
        4: DeathImg := 560;
        5: DeathImg := 550;
        6: DeathImg := 540;
        7: DeathImg := 530;
      end;
      EffectSurface := g_WMons[32].GetCachedImage(DeathImg +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
      m_boUseEffect := True;
    end;
  end;
end;

constructor TOrcObject.Create;
begin
  inherited;
  boCasted := False;
end;

procedure TOrcObject.DrawChr(dsurface: TDXTexture; dx: Integer; dy: Integer; blend: Boolean; boFlag: Boolean);
var
  idx: Integer;
  d: TDirectDrawSurface;
  esX, esY: Integer; //Energy Shield X, Y
  DeathImg, diex, diey: Integer;
begin
  d := nil;
  if m_wAppearance = 316 then begin
    if m_boDeath and (m_nCurrentFrame = m_nEndFrame) then begin
      case m_btDir of
        0: DeathImg := 3119;//530;
        1: DeathImg := 3109;
        2: DeathImg := 3099;//580;
        3: DeathImg := 3169;//570;
        4: DeathImg := 3159;//560;
        5: DeathImg := 3149;//550;
        6: DeathImg := 3139;//540;
        7: DeathImg := 3129;//530;
      end;
      d := g_WMons[32].GetCachedImage(DeathImg{ +
      m_nCurrentFrame - m_nStartFrame}, diex, diey);
      if d <> nil then
        DrawBlend(dSurface, dx + diex + m_nShiftX, dy + diey + m_nShiftY, d, 1);
    end;
  end;
  inherited;
  if (m_nState and $00080000 <> 0) then begin //EnergyShield
    if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
      idx := MAGENERGYSHIELDSTRUCKBASE + m_nCurBubbleStruck
    else
      idx := MAGENERGYSHIELDBASE + (m_nGenAniCount mod 3);
    d := g_WMagic99Images.GetCachedImage(idx, esX, esY);
    if d <> nil then
      DrawBlend(dsurface,
        dx + esX + m_nShiftX,
        dy + esY + m_nShiftY,
        d, 1);
  end;
end;

function TOrcObject.Run;
var
  meff: TFlyingAxe;
  nRangeBase: Integer;
begin
  nRangeBase := 0;
  if FrmMain.m_CurrentTick - m_dwGenAnicountTime > 120 then begin
    m_dwGenAnicountTime := FrmMain.m_CurrentTick;
    Inc(m_nGenAniCount);
    if m_nGenAniCount > 100000 then
      m_nGenAniCount := 0;
    Inc(m_nCurBubbleStruck);
  end;

  if (m_nCurrentFrame - m_nStartFrame = 4) and
  (m_nCurrentAction = SM_HIT_2) and
  (m_wAppearance = 315) and
  (not boCasted) then begin //Thrust
    PlaySound(3439);
    boCasted := True;
  end;


  if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame - m_nStartFrame = 4) and (not boCasted) then begin //did svn change this?
    boCasted := True;
    meff := TFlyingArrow(PlayScene.NewFlyObject(self,
      m_nCurrX,
      m_nCurrY,
      m_nTargetX,
      m_nTargetY,
      m_nTargetRecog,
      mtFlyArrow));

    if meff <> nil then begin
      if ((m_wAppearance = 312) or (m_wAppearance = 314)) then begin
        meff.ImgLib := g_WMons[32];
        case m_wAppearance of
          312: begin
            nRangeBase := 1390;
            PlaySound(52);
          end;
          314: begin
            nRangeBase := 2200;
            PlaySound(56);
          end;
        end;
      end;
      if nRangeBase <> 0 then
        meff.FlyImageBase := nRangeBase;
        meff.SpecialFly2 := True;
    end;
  end;
  Result := inherited Run;
end;

procedure TOrcObject.LoadSurface;
var
HitNumber: Integer;
DeathImg: Integer;
bo11: Boolean;

begin
  inherited;

  m_boUseEffect := False;
  EffectSurface := nil;
  HitNumber := 0;
  DeathImg := 0;

  case m_nCurrentAction of
    SM_HIT: begin //Act.Attack
      case m_wAppearance of
        313: HitNumber := 1760;
        316: HitNumber := 3010;
        317: HitNumber := 3530;
        320: HitNumber := 5090;
        321: HitNumber := 5690;
      end;
      if HitNumber <> 0 then begin
        m_boUseEffect := True;
        EffectSurface := g_WMons[32].GetCachedImage(HitNumber + (m_btDir * 10) +
        m_nCurrentFrame - m_nStartFrame, ax, ay);
      end;
    end;
    SM_HIT_2: begin //Act.Attack
      case m_wAppearance of
        315: HitNumber := 2570;
      end;
      if HitNumber <> 0 then begin
        m_boUseEffect := True;
        EffectSurface := g_WMons[32].GetCachedImage(HitNumber + (m_btDir * 10) +
        m_nCurrentFrame - m_nStartFrame, ax, ay);
      end;
    end;

    SM_HIT_3: begin //Act.Critical
      case m_wAppearance of
        321: HitNumber := 5770;
      end;
      if HitNumber <> 0 then begin
        m_boUseEffect := True;
        EffectSurface := g_WMons[32].GetCachedImage(HitNumber + (m_btDir * 10) +
        m_nCurrentFrame - m_nStartFrame, ax, ay);
      end;
    end;
    SM_NOWDEATH: begin
      if m_wAppearance = 316 then begin
        case m_btDir of
          0: DeathImg := 3110;//530;
          1: DeathImg := 3100;
          2: DeathImg := 3090;//580;
          3: DeathImg := 3160;//570;
          4: DeathImg := 3150;//560;
          5: DeathImg := 3140;//550;
          6: DeathImg := 3130;//540;
          7: DeathImg := 3120;//530;
        end;
        EffectSurface := g_WMons[32].GetCachedImage(DeathImg +
        m_nCurrentFrame - m_nStartFrame, ax, ay);
        m_boUseEffect := True;
      end;
    end;
  end;
end;

procedure TOrcObject.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  inherited;
  m_nCurrentFrame := -1;
  m_boUseEffect := FALSE;
  m_boUseMagic := False;
  m_nEffectFrame := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_NOWDEATH: begin
      m_boUseEffect := True;
    end;
    SM_HIT_2: begin
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        if (m_wAppearance = 315) then
         boCasted := False;
    end;
    SM_HIT_3: begin
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
    end;
    SM_STRUCK: begin
        m_nCurBubbleStruck := 0;
    end;

    SM_FLYAXE: begin
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        boCasted := False;
    end;

    SM_SPELL: begin
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_boWarMode := TRUE;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        m_dwWaitMagicRequest := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        m_nCurEffFrame := 0;
        m_boUseMagic := TRUE;
        m_nSpellFrame := DEFSPELLFRAME;
    end;
  end;
end;

constructor TOrcGiant.Create;
begin
  inherited;
end;

function TOrcGiant.Run;
var
nX, nY: Integer;
begin
  if (m_nCurrentFrame - m_nStartFrame) = 6 then begin

    if (m_nCurrentAction = SM_HIT) and (not boCasted) then begin
      boCasted := True;
      GetFrontPosition(m_nCurrX, m_nCurrY, m_btDir, nX, nY);
      GetFrontPosition(nX, nY, m_btDir, nX, nY);
      GetFrontPosition(nX, nY, m_btDir, nX, nY);
      PlayScene.NewMagic(Self, 11, 38, m_nCurrX, m_nCurrY, nX, nY, Integer(MakeLong(nX,nY)), mt13, False, 30, m_boUseEffect);
    end;

    if (m_nCurrentAction = SM_HIT_4) and (not boCasted) then begin
      boCasted := True;
      PlayScene.NewMagic(Self, 12, 39, m_nCurrX, m_nCurrY, m_nCurrX, m_nCurrY, Integer(Self), mt13, False, 30, m_boUseEffect);
      PlayScene.NewMagic(Self, 13, 40, m_nCurrX, m_nCurrY, m_nCurrX, m_nCurrY, Integer(Self), mt13, False, 30, m_boUseEffect);
    end;

  end;
  Result := inherited Run;
end;

procedure TOrcGiant.LoadSurface;
var
  bo11: Boolean;
begin
  inherited;
  m_boUseEffect := False;
  EffectSurface := nil;

  case m_nCurrentAction of
    {SM_HIT: begin //Act.Attack
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(6528 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;}
    {SM_HIT_2: begin //Act.Attack2
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(6530 +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;}
    SM_HIT_3: begin //Act.Attack3
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(6550 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;
    SM_NOWDEATH: begin
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(6650 +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;
  end;

end;

procedure TOrcGiant.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  inherited;
  m_nCurrentFrame := -1;
  m_boReverseFrame := FALSE;
  m_boUseEffect := FALSE;
  m_boUseMagic := False;
  m_nEffectFrame := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_HIT: begin
        boCasted := False;
    end;
    SM_HIT_2: begin
        m_nStartFrame := pm.ActAttack2.start + m_btDir * (pm.ActAttack2.frame + pm.ActAttack2.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack2.frame - 1;
        m_dwFrameTime := pm.ActAttack2.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        boCasted := False;
    end;
    SM_HIT_3: begin
        m_nStartFrame := pm.ActAttack3.start + m_btDir * (pm.ActAttack3.frame + pm.ActAttack3.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack3.frame - 1;
        m_dwFrameTime := pm.ActAttack3.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
    end;
    SM_HIT_4: begin
        m_nStartFrame := pm.ActAttack4.start + m_btDir * (pm.ActAttack4.frame + pm.ActAttack4.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack4.frame - 1;
        m_dwFrameTime := pm.ActAttack4.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        boCasted := False;
    end;
  end;
end;

constructor TOrcWarLord.Create;
begin
  inherited;
end;

function TOrcWarLord.Run;
var
nX, nY: Integer;
begin
  if (m_nCurrentFrame - m_nStartFrame) = 7 then begin

    if (m_nCurrentAction = SM_HIT_3) and (not boCasted) then begin
      boCasted := True;
      GetFrontPosition(m_nCurrX, m_nCurrY, m_btDir, nX, nY);
      GetFrontPosition(nX, nY, m_btDir, nX, nY);
      PlayScene.NewMagic(Self, 14, 41, m_nCurrX, m_nCurrY, nX, nY, Integer(MakeLong(nX,nY)), mt13, False, 30, m_boUseEffect);
    end;
  end;
  Result := inherited Run;
end;

procedure TOrcWarLord.LoadSurface;
var
  bo11: Boolean;
begin
  inherited;
  m_boUseEffect := False;
  EffectSurface := nil;

  case m_nCurrentAction of
    SM_HIT, SM_HIT_2: begin //Act.Attack
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(7340 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;
    SM_HIT_3: begin //Act.Attack2
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(7430 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;
    SM_HIT_4: begin //Act.Attack3
      m_boUseEffect := True;
      EffectSurface := g_WMons[32].GetCachedImage(7530 + (m_btDir * 10) +
      m_nCurrentFrame - m_nStartFrame, ax, ay);
    end;
  end;

end;

procedure TOrcWarLord.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  inherited;
  m_nCurrentFrame := -1;
  m_boReverseFrame := FALSE;
  m_boUseEffect := FALSE;
  m_boUseMagic := False;
  m_nEffectFrame := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_HIT, SM_HIT_2: begin
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
    end;
    SM_HIT_3: begin
        m_nStartFrame := pm.ActAttack2.start + m_btDir * (pm.ActAttack2.frame + pm.ActAttack2.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack2.frame - 1;
        m_dwFrameTime := pm.ActAttack2.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
        boCasted := False;
    end;
    SM_HIT_4: begin
        m_nStartFrame := pm.ActAttack3.start + m_btDir * (pm.ActAttack3.frame + pm.ActAttack3.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack3.frame - 1;
        m_dwFrameTime := pm.ActAttack3.ftime;
        m_dwStartTime := FrmMain.m_CurrentTick;
        m_dwWarModeTime := FrmMain.m_CurrentTick;
        Shift(m_btDir, 0, 0, 1);
    end;
  end;
end;

procedure TIceObject.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;

  individual_level_of_light := 0;
  individual_depth_of_dark := 0;
  individual_incremental_increase_of_light := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  case m_nCurrentAction of
    SM_HIT_2: begin
      m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
      m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
      m_dwFrameTime := pm.ActCritical.ftime;
      if m_btRaceServer in [197, 199] then begin
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
      end;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      Shift(m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
    end;
    SM_HIT_3: begin
      m_nStartFrame := pm.ActAttack2.start + m_btDir * (pm.ActAttack2.frame + pm.ActAttack2.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack2.frame - 1;
      m_dwFrameTime := pm.ActAttack2.ftime;
      if m_btRaceServer in [198, 199] then begin
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
      end;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      Shift(m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
    end;
    SM_FLYAXE,
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      m_boUseEffect := TRUE;
      Shift(m_btDir, 0, 0, 1);
    end;
    SM_NOWDEATH: begin
      inherited;
      m_boUseEffect := FALSE;
    end
    else begin
      inherited;
    end;
  end;
end;

procedure TIceObject.LoadSurface;
var
  meff: TMagicEff;
  colour_ice_blue: String;
  nFrontX, nFrontY, i: Integer;
begin
  colour_ice_blue := '153,217,234';
  inherited;
  if m_boUseEffect then begin
    case m_nCurrentAction of
      SM_HIT_2: begin
        case self.m_btRaceServer of
          195: begin
            if (m_nCurrentFrame - m_nStartFrame) = 4 then begin
              meff := TStraightNodeDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMons[26],420 + (m_btDir * 10),10,100,TRUE,0);
              meff.Light := 3;
              meff.Colour := colour_ice_blue;
              TStraightNodeDrawEffect(meff).space_between_light_nodes := 60;
              meff.MagOwner := self;
              meff.user_x := self.m_nRx;
              meff.user_y := self.m_nRy;
              meff.direction_of_attack := self.m_btDir;
              PlayScene.m_EffectList.Add (meff);
              PlaySound(11170);
            end;
          end;
          196: begin
            if (m_nCurrentFrame - m_nStartFrame) = 4 then begin
              meff := TStraightNodeDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMons[26],930 + (m_btDir * 10),6,100,TRUE,0);
              meff.Light := 1;
              meff.Colour := colour_ice_blue;
              TStraightNodeDrawEffect(meff).space_between_light_nodes := 60;
              meff.MagOwner := self;
              meff.user_x := self.m_nRx;
              meff.user_y := self.m_nRy;
              meff.direction_of_attack := self.m_btDir;
              PlayScene.m_EffectList.Add (meff);
              PlaySoundEx('wav\cboZs7_start.wav');
            end;
          end;
          197, 199: begin
            if (m_nCurrentFrame - m_nStartFrame) = 0 then begin
              meff := TDrawEffectOnObject.Create(self,g_WMagic2Images,400,10,100,TRUE);
              meff.Light := 3;
              meff.Colour := colour_ice_blue;
              PlayScene.m_EffectList.Add (meff);
              PlaySound(10011);
            end;
          end;
          200: begin
            if (m_nCurrentFrame - m_nStartFrame) = 4 then begin
              meff := TDrawEffectOnObject.Create(self,g_WMons[26],2573 + (m_btDir * 10),4,100,TRUE);
              meff.Light := 3;
              meff.Colour := colour_ice_blue;
              PlayScene.m_EffectList.Add (meff);
              PlaySoundEx('wav\002141.wav');
            end;
          end;
          201: begin
            if (m_nCurrentFrame - m_nStartFrame) = 5 then begin
              nFrontX := m_nCurrX;
              nFrontY := m_nCurrY;
              case self.m_btDir of
                DR_UP: nFrontY := m_nCurrY - 3;
                DR_RIGHT: nFrontX := m_nCurrX + 3;
                DR_DOWN: nFrontY := m_nCurrY + 3;
                DR_LEFT: nFrontX := m_nCurrX - 3;
                DR_UPRIGHT: begin
                  nFrontX := m_nCurrX + 3;
                  nFrontY := m_nCurrY - 3;
                end;
                DR_DOWNRIGHT: begin
                  nFrontX := m_nCurrX + 3;
                  nFrontY := m_nCurrY + 3;
                end;
                DR_DOWNLEFT: begin
                  nFrontX := m_nCurrX - 3;
                  nFrontY := m_nCurrY + 3;
                end;
                DR_UPLEFT: begin
                  nFrontX := m_nCurrX - 3;
                  nFrontY := m_nCurrY - 3;
                end;
              end;

              meff := TStraightNodeDrawEffect.Create(nFrontX,nFrontY,g_WMons[26],3670 + (m_btDir * 10),10,80,TRUE,0);
              meff.Light := 3;
              meff.Colour := colour_ice_blue;
              TStraightNodeDrawEffect(meff).space_between_light_nodes := 60;
              meff.user_x := self.m_nRx;
              meff.user_y := self.m_nRy;
              meff.direction_of_attack := self.m_btDir;
              PlayScene.m_EffectList.Add (meff);
              PlaySoundEx('wav\002166.wav');
            end;
          end;
        end;
      end;
      SM_FLYAXE: begin
        if ((m_nCurrentFrame - m_nStartFrame) = 4) then begin
          PlayScene.NewMagic (Self,111,39,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,False,8,m_boUseEffect);
        end;
      end;
      SM_LIGHTING: begin
        if ((m_nCurrentFrame - m_nStartFrame) = 4) then begin
          PlayScene.NewMagic (Self,111,31,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,False,8,m_boUseEffect);
        end;
      end;
      SM_HIT_3: begin
        case self.m_btRaceServer of
          200: begin
            if ((m_nCurrentFrame - m_nStartFrame) = 3) then begin
              meff := TDrawEffectOnObject.Create(self,g_WMons[26],2652 + (m_btDir * 10),4,100,TRUE);
              meff.Light := 4;
              meff.Colour := colour_ice_blue;
              PlayScene.m_EffectList.Add (meff);
              PlaySoundEx('wav\002157.wav');
            end;
          end;
          201: begin
            if ((m_nCurrentFrame - m_nStartFrame) = 0) then begin
              meff := TDrawEffectOnObject.Create(self,g_WMons[26],3750,10,80,TRUE);
              meff.Light := 4;
              meff.Colour := colour_ice_blue;
              PlayScene.m_EffectList.Add (meff);
              PlaySoundEx('wav\002167.wav');
            end;
          end;
          198, 199: begin
            if (m_nCurrentFrame - m_nStartFrame) = 0 then begin
              meff := TDrawEffectOnObject.Create(self,g_WMagicImages,3840,10,100,TRUE);
              meff.Light := 3;
              meff.Colour := colour_ice_blue;
              PlayScene.m_EffectList.Add (meff);
              PlaySound(10332);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TIceObject.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer; blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
  inherited;
  ceff := GetDrawEffectValue(boFlag);
  if (m_btRaceServer = 201) then begin
    EffectSurface := g_WMons[26].GetCachedImage(m_nBodyOffset + 500 + m_nCurrentFrame, ax, ay);
    if (EffectSurface <> nil) and not (m_nCurrentAction = SM_HIT_3) then
      DrawBlend(dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, EffectSurface, 2);
  end;
end;

procedure TIceNode.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;

  individual_level_of_light := 0;
  individual_depth_of_dark := 0;
  individual_incremental_increase_of_light := 0;

  m_nBodyOffset := GetOffset(m_wAppearance);
  pm := GetRaceByPM(m_btRace, m_wAppearance);
  if pm = nil then
    exit;

  m_btDir := 0;

  case m_nCurrentAction of
    SM_HIT_2: begin
      m_nStartFrame := pm.ActStand.start;
      m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
      m_dwFrameTime := pm.ActStand.ftime;
      m_dwStartTime := FrmMain.m_CurrentTick;
      m_dwWarModeTime := FrmMain.m_CurrentTick;
      Shift(m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
    end;
    else begin
      inherited;
    end;
  end;
end;

procedure TIceNode.LoadSurface;
var
  meff: TMagicEff;
  colour_ice_blue: String;
  nFrontX, nFrontY, i: Integer;
begin
  colour_ice_blue := '153,217,234';
  inherited;
  case m_nCurrentAction of
    SM_HIT_3: begin
      meff := TDrawEffectOnObject.Create(self,g_WMons[27],2470 ,6,100,TRUE);
      meff.Light := 3;
      PlayScene.m_EffectList.Add (meff);
    end;
  end;
end;

end.

