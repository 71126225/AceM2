unit ObjMon3;

interface
uses
  Windows, Classes, Grobal2, ObjPlay, ObjBase, ObjMon, HUtil32, SysUtils;

type
  TCriticalMon = class(TMonster) //±ê×¼Ë«ÖØ¹¥»÷¹ÖÎï
  private

  public
    constructor Create(); override;
    procedure CriticalAttack(AttackTarget: TBaseObject; nDir: Integer); virtual;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TElectronicScolpionMon = class(TATMonster)
  private
    m_boUseMagic: Boolean;
    attack_length: Integer;
    m_boHalfLifeAttack: Boolean;
    m_nChanceOfLightning: Integer;
    procedure LightingAttack(nDir: Integer);
  public
    constructor Create(); override;
    procedure Run; override;
  end;

  TMagicZumaKing = class(TScultureKingMonster)
    m_dwSpellTick: LongWord;
    private
      procedure MagicAttack(nDir:Integer);
      procedure FlameAttack(nDir:Integer);
    public
      constructor Create(); override;
      procedure Run; override;
  end;

  TCrystalSpider = class(TElectronicScolpionMon) //ºçÄ§Ð«ÎÀ
  private
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override;
  end;

  TDarkDevil = class(TElectronicScolpionMon)
    constructor Create(); override;
  end;

  TFiredrakeBodyguardMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TLeiyanAraneidMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TGreenAraneidMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TSnowfieldWarriorMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TSnowfieldForceMon = class(TATMonster)
  public
    function AttackTarget(): Boolean; override; //FFEB
  end;

  TPakNewMon = class(TDoubleATKMonster)
    m_dwCheckRageTick: LongWord;
    m_boDeliriaOK: Boolean;
    m_boCanDeliria: Boolean;
    m_boIsFirst: Boolean; //0x558
  private
    function CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
    function WideAttack(nSX, nSY:Integer; nRate: Byte; boMagic: Boolean): Boolean;
    function AttackBy506(nDir: Integer): Boolean;
    function AttackByMagic(nDir, nMagId: Integer): Boolean;
    function AttackBy512(nDir: Integer): Boolean;
    function AttackBy515(nDir: Integer): Boolean;
    function AttackBy516(nDir: Integer): Boolean;
    function AttackBy526(nDir: Integer): Boolean;
    function AttackBy527(nDir: Integer): Boolean;
    function AttackBy534(nDir: Integer): Boolean;
    function AttackBy535(nDir: Integer): Boolean;
    function AttackBy542(nDir: Integer): Boolean;
    function AttackBy543(nDir: Integer): Boolean;
    function AttackBy544(nDir: Integer): Boolean;
    function AttackBy545(nDir: Integer): Boolean;
    function AttackBy546(nDir: Integer): Boolean;
    function AttackBy547(nDir: Integer): Boolean;
    function AttackBy548(nDir: Integer): Boolean;
    function AttackBy555(nDir: Integer): Boolean;
    function AttackBy557(nDir: Integer): Boolean;
    function AttackBy560(nDir: Integer): Boolean;
    function AttackBy563(nDir: Integer): Boolean;
    function AttackBy564(nDir: Integer): Boolean;
    function AttackBy568(nDir: Integer): Boolean;
    function AttackBy255(nDir: Integer): Boolean;
    function AttackBy243(nDir: Integer): Boolean;
    function AttackBy244(nDir: Integer): Boolean;
    function BaseDoubleAttack(nDir: Integer): Boolean;
    function BaseDoubleMagAttack(nDir, nMID1, nMID2: Integer): Boolean;
    function BaseAttackTarget(nCmd: Integer = SM_HIT): Boolean;
    function BaseLongAttackTarget(btDir, btRate: Byte; nCmd: Integer = SM_HIT): Boolean;
    function BaseLongMsgTarget(btDir, btRate: Byte; nCmd: Integer = SM_HIT): Boolean;
    function GetCircumambienceMonCount(btRate: Byte = 2): Integer;
//    procedure FirstEffect();
  public
    constructor Create(); override;
    procedure Run; override;
    procedure Initialize(); override;
    procedure Die(); override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure BeginDeliria; override;
    procedure EndDeliria; override;
  end;

  TPillarMonster = class(TAnimalObject)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Initialize(); override;
  end;

  TCloneObject = class(TMonster)
    m_nDieReason:integer;
  public
    constructor Create();override;
    procedure Die;override;
    function GetShowName(): string; override;
    function GetFeature(BaseObject: TBaseObject): Integer; override;
    function GetCharColor(BaseObject: TBaseObject): Byte; virtual;
    procedure Run;override;
    procedure FindTarget();virtual;
  end;

  TWizClone = class(TCloneObject)
    m_dwThinkTick   : LongWord;
    m_dwMpLossTick  : LongWord;
    nMpLoss         : Integer;
    m_boNextTurnDie : Boolean;
    m_Owner         : TBaseObject;
    PlayObject      : TPlayObject;
  private
    function MPow(UserMagic:pTUserMagic):Integer;
    function GetPower(nPower:Integer;UserMagic:pTUserMagic):Integer;
    procedure MagicAttack();
  public
    constructor Create();override;
    procedure SetMpLoss(nMpReduction:Integer);
    destructor Destroy; override;
    procedure Run;override;
    procedure Die;override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject); override;
    procedure FindTarget();override;
  end;

  TFrostTiger = class(TMonster)
    m_dwSpellTick:LongWord;
    m_dwLastWalkTick:LongWord;
  private
    procedure FrostAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TKhazard = class(TMonster)
    m_dwDragTick  :LongWord;
  private
    procedure Drag();
  public
  function AttackTarget():boolean;override;
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TThunderTypeWT = class(TCowKingMonster)
  private
  public
    procedure Run; override;
    procedure MagicAttack(attack_direction: Integer);
  end;

  TYimoogi = class(TMonster)
    m_boActive     : boolean; //if this is true then someone hit it and it's on the offence if not it's on the defence
    m_dwSpellTick  : LongWord;
    m_dwPoisonTick : LongWord;
    m_dwThinkTick  : LongWord;
    m_counterpart  : TBaseObject;
    m_dwLastRecall : LongWord;
  private
    procedure MagicAttack();
    procedure PoisonAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    procedure Die();override;
    procedure CloneDied();
  end;

  TYimoogiMaster = class(TYimoogi)
    m_dwCloneSpawn : LongWord;
    m_boEscaped    : boolean;
  private
    function FindYimoogi(sname: String):TBaseObject;
    procedure CallGuard;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    function GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;override;

  end;

  TBoneLord = class(TMonster)
  private
    m_nDangerLevel       :Integer;
    m_SlaveObjectList  :TList;
    m_dwCallTick  :LongWord;
    m_dwDangerTick  :LongWord;

    procedure MagicAttack(nDir:integer);
    procedure CallSlave(nAttackDir: Integer);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer);override;
    procedure Run;override;
  end;

  TMinoGuard = class(TMonster)
  private
   procedure MagicAttack(nDir:Integer);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TMinotaurKing = class(TATMonster)
    m_dwCheckRageTick: Integer;
  private
    procedure RedCircle(nDir:Integer);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;

  TNodeMonster = class(TAnimalObject)
    hitcount : integer;
  private
    procedure search();
    procedure castshield(BaseObject: TBaseObject);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TOmaKing = class(TAnimalObject)
  private
    ldistx:Integer;
    ldisty:Integer;
    m_dwSpellTick  :LongWord;
    function AttackTarget():boolean;
    procedure RepulseCircle();
    procedure BlueCircle();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  {TOmaKingSpirit = class(TMonster)
    m_dwSpellTick  :LongWord;
    m_dwRecruitTick :LongWord;
  private
    procedure MagicAttack();
    function AttackTarget():boolean;
  public
    constructor Create();override;
    procedure Run; override;
  end;}

  TEventMob1 = class(TMonster)
  private
    function AttackTarget():boolean;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject); override;
  end;

  TDragonStatue = class(TAnimalObject)
  private
    procedure MeltStone; //
    procedure MeltStoneAll;
    procedure FireBang();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Initialize(); override;
  end;

  TEvilMir = class(TAnimalObject)
    m_dwSpellTick  :LongWord;
    m_SlaveObjectList  :TList;
    boSpawn:Boolean;
    m_boInactive: Boolean;
    m_ndropcount: integer;
    m_nhitcount : integer;
    m_dwLastDrop : integer;
    m_boKillSlaves: Boolean;
    m_nEvilMirKillCount: Integer;
    m_dwEvilMirKillTime: Integer;
    m_dwInactiveTime: LongWord;
  private
    procedure FlameCircle(nDir: Integer);
    procedure MassThunder();
    procedure CallSlaves();
    procedure KillSlaves(boDrop: Boolean);
  public
    constructor Create();override;
    destructor Destroy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;
    procedure Run;override;
    procedure Die; override;
  end;

  TDragonPart = class(TAnimalObject)
    m_Owner   : TEvilMir;
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    function  GetMagStruckDamage(BaseObject:TBaseObject;nDamage:Integer):Integer;override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject); override;
    procedure Run;override;
  end;

  TBlackFoxMan = class (TMonster)
  private
    procedure ThrustAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TRangedMon = class (TMonster)
    m_dwLastMove:longword;
  public
    procedure Run;override;
  end;

  TRedFoxMan = class (TRangedMon)
  private
    procedure ThunderAttack();
    procedure FlameAttack();
    procedure RandomMove();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    function Operate(ProcessMsg:pTProcessMessage):boolean;override;
  end;

  TWhiteFoxMan = class (TRangedMon)
  private
    procedure summonshinsu();
    procedure soulfireball();
    procedure curse();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TElement=class(TMonster)
    ncloudrange : integer;
    m_dwSpellTick:LongWord;
    m_boUsePoison:boolean;
    m_nPushCount : integer;
    m_boNextTurnDie:boolean;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Thunderstorm();
	  procedure Run; override;
    function  CharPushed(nDir,nPushCount:Integer): Integer;override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);override;
  end;

  TBigElement=class(TElement)
  public
    constructor Create();override;
    destructor Destroy; override;
  end;

  TBigNonPsnElement=class(TElement)
  public
    constructor Create();override;
    destructor Destroy; override;
  end;

  TTrapPart = class (TAnimalObject)
    m_MasterRock : TBaseObject;
    m_LockTarget:TBaseObject;
    m_boNextRoundDie:boolean;
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);override;
    procedure AllComeOut(m_LockTarget2:TBaseObject);
  end;

  TTrapRock = class (TTrapPart)
    m_LockTarget: TBaseObject;
    m_SlaveObjectList: TList;
    m_FirstHit: Boolean;
  private
    function CanTrap():TBaseObject;
    procedure TrapObject(LockTarget: TBaseObject);
    procedure ComeOut(LockTarget: TBaseObject);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject); override;
    procedure Run;override;
    procedure Die; override;
    procedure Paralyse(target_object: TBaseObject);
  end;

  TGuardianRock = class (TAnimalObject)
    boActive:boolean;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure SearchTarget(); override;
    procedure Run;override;
    procedure StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);override;
    procedure Die;override;
    procedure Drag;
  end;

  TOrbSpirit = class (TAnimalObject)
    nLevel : Integer;
    nOldLevel: Integer;
    boGuards: boolean;
    m_dwMassAttack: longword;
    m_nMassAttacks : integer;
  Const
    sMonXY:array[0..3,0..1] of Integer = ((44,32),(34,24),(34,40),(24,32));
    m_sGuardName: String = 'GuardianRock';
  private
    procedure MassAttack();
    procedure SingleAttack();
    procedure Recall();
    procedure ActivateGuards();
    procedure DeActivateGuards();
    procedure MassPoison();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    procedure Die;override;
    function GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;override;
  end;

  TOmaGuardElite = class (TMonster)
  HitCount: integer;
  m_dwRecruitTick: LongWord;
  private
    procedure DoubleAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

implementation

uses
  UsrEngn, M2Share, Event, Envir, Math;

{ TCriticalMon }

procedure TCriticalMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  if TargeTBaseObject = nil then Exit;
  CriticalAttack(TargeTBaseObject, nDir);
  if m_boDeliria then
    SendRefMsg(RM_LIGHTING, nDir, 0 {msgid}, 0 {Ô¤Áô}, Integer(TargeTBaseObject), '')
  else
    //SendRefMsg(RM_HIT, nDir, m_nCurrX, m_nCurrY, 0, '');
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

constructor TCriticalMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

procedure TCriticalMon.CriticalAttack(AttackTarget: TBaseObject; nDir: Integer);
var
  nPower, n20: Integer;
begin
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if IsProperTarget(AttackTarget) then begin
    if (Random(AttackTarget.m_btSpeedPoint) >= m_btHitPoint) then begin
      nPower := 0;
    end;
  end
  else
    nPower := 0;
  if nPower > 0 then begin
    nPower := AttackTarget.GetStunDamage(Self, nPower);
    nPower := AttackTarget.GetHitStruckDamage(Self, nPower);
    //nWeaponDamage := (Random(5) + 2) - m_AddAbil.btWeaponStrong;
  end;
  if nPower > 0 then begin
    AttackTarget.StruckDamage(nPower, Self);
    AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK),
      RM_10101, nPower,
      AttackTarget.m_WAbil.HP,
      AttackTarget.m_WAbil.MaxHP,
      Integer(Self), '', 200);

    if not AttackTarget.m_boUnParalysis and
      m_boParalysis and
      (Random(AttackTarget.m_btAntiPoison + g_Config.nAttackPosionRate {5}) = 0)
        then begin
      AttackTarget.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);
    end;
    //ºçÄ§£¬ÎüÑª
    if m_nHongMoSuite > 0 then begin
      m_db3B0 := nPower / 1.E2 * m_nHongMoSuite;
      if m_db3B0 >= 2.0 then begin
        n20 := Trunc(m_db3B0);
        m_db3B0 := n20;
        DamageHealth(-n20);
      end;
    end;
  end;
  if (AttackTarget <> nil) and (AttackTarget.m_btRaceServer <> RC_PLAYOBJECT) then
    AttackTarget.SendMsg(AttackTarget,
      RM_STRUCK, nPower,
      AttackTarget.m_WAbil.HP,
      AttackTarget.m_WAbil.MaxHP, Integer(Self), '');
end;

procedure TCriticalMon.Run;
begin
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil))
        then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;

    //ÑªÁ¿µÍÓÚÒ»°ëÊ±¿ªÊ¼·¢¿ñ¹¥»÷
    if m_WAbil.HP < m_WAbil.MaxHP div 2 then
      m_boDeliria := True
    else
      m_boDeliria := False;

  end;
  inherited;
end;

{ TElectronicScolpionMon }
constructor TElectronicScolpionMon.Create;
begin
  inherited;
  m_nViewRange := 11;
  m_boUseMagic := False;
  attack_length := 2;
  m_boHalfLifeAttack := True;
  m_nChanceOfLightning := 0;
end;

procedure TElectronicScolpionMon.Run;
  function CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
  begin
    Result := False;
    if (Targe <> nil) and (abs(m_nCurrX - Targe.m_nCurrX) <= nViewRange) and (abs(m_nCurrY - Targe.m_nCurrY) <= nViewRange) then
      Result := True;
  end;
var
  attack_direction, target_x, target_y, target_distance_x, target_distance_y, i, nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  if ((GetTickCount - m_dwSearchEnemyTick) > 2500) and (m_TargetCret = nil) then begin
    m_dwSearchEnemyTick:=GetTickCount();
    SearchTarget();
  end;

  if (CanPerformActions) then begin
    if (m_boHalfLifeAttack) and (m_WAbil.HP < (m_WAbil.MaxHP div 2)) then
      m_boUseMagic:=True
    else
      m_boUseMagic:=False;

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;

    if (m_TargetCret <> nil) and IsProperTarget(m_TargetCret) then begin
      if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin //check if we should walk closer or not and do it :p
        target_distance_x:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
        target_distance_y := abs(m_nCurrY - m_TargetCret.m_nCurrY);
        if (((target_distance_x > attack_length) or (target_distance_y > attack_length)) and ((target_distance_x < 12) and (target_distance_y < 12))) or (MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret) = false) then begin //restrict the maximum pursuit distance to 12 coords away
          m_dwWalkTick:=GetTickCount();
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          GotoTargetXY
        end;
      end;

      target_x:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
      target_y:=abs(m_nCurrY - m_TargetCret.m_nCurrY);

      if CheckViewRange(m_TargetCret, m_nViewRange) or m_boUseMagic then begin
        if MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret) then begin
          if (target_x <= (attack_length)) and (target_y <= (attack_length)) then begin
            if m_boUseMagic or ((target_x > 1) or (target_y > 1)) or ((not m_boHalfLifeAttack) and (Random(m_nChanceOfLightning) = 0)) then begin
              if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
                m_dwHitTick:=GetTickCount;
                m_btDirection := GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                for i := 0 to attack_length do begin
                  if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
                    BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
                      if BaseObject = m_TargetCret then begin
                        LightingAttack(m_btDirection);
                      end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end else begin
        if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
      end
      else begin
        DelTargetCreat();
      end;
      end;
    end;
  end;
  inherited Run;
end;

procedure TElectronicScolpionMon.LightingAttack(nDir: Integer);
var
  power_of_attack, damage_of_attack, get_back_hp, target_x, target_y, temp_x, temp_y: Integer;
begin
  m_btDirection := nDir;
  SendRefMsg(RM_LIGHTING, m_btDirection, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 1, temp_x, temp_y) then begin
    m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, attack_length, target_x, target_y);
    power_of_attack := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
    MagPassThroughMagic(temp_x, temp_y, target_x, target_y, nDir, power_of_attack, -1, True);
  end;
  BreakHolySeizeMode();
end;

{TMagicZumaKing}

constructor TMagicZumaKing.Create;
begin
  inherited;
  m_dwSpellTick := GetTickCount();
end;

procedure TMagicZumaKing.Run;
var
  attack_direction, target_distance_x, target_distance_y: Integer;
begin
  if (CanPerformActions) then begin
    if (m_TargetCret <> nil) then begin
      target_distance_x:= abs(m_nCurrX - m_TargetCret.m_nCurrX);
      target_distance_y:=abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if ( (Random(15) = 0) or
      (_Max(target_distance_x,target_distance_y) > 2) and (_max(target_distance_x,target_distance_y) < 10) ) and
      (Integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime * 3) then begin
        m_dwHitTick:=GetTickCount();
        m_dwSpellTick:=GetTickCount();

        attack_direction:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
        FlameAttack(attack_direction);
        MagicAttack(attack_direction); //leave a fwall where his fbang was
      end;
    end;
  end;
  inherited Run;
end;

procedure TMagicZumaKing.MagicAttack(nDir:Integer);
var
  Target: TBaseObject;
  magpwr:Integer;
  FireBurnEvent:TFireBurnEvent;
begin
  if m_TargetCret = nil then exit;
  Target:=m_TargetCret;

  if m_TargetCret <> nil then begin
    if Random(g_Config.nMagicResistanceRate + 30) >= target.m_nAntiMagic then begin
      magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      if m_PEnvir.GetEvent(Target.m_nCurrX, Target.m_nCurrY - 1) = nil then begin
        FireBurnEvent := TFireBurnEvent.Create(self, Target.m_nCurrX, Target.m_nCurrY - 1, ET_FIRE, 50 * 1000 div (m_nDangerLevel + 1), magpwr);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
      if m_PEnvir.GetEvent(Target.m_nCurrX - 1, Target.m_nCurrY) = nil then begin
        FireBurnEvent := TFireBurnEvent.Create(self, Target.m_nCurrX - 1, Target.m_nCurrY, ET_FIRE, 50 * 1000 div (m_nDangerLevel + 1), magpwr);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
      if m_PEnvir.GetEvent(Target.m_nCurrX, Target.m_nCurrY) = nil then begin
        FireBurnEvent := TFireBurnEvent.Create(self, Target.m_nCurrX, Target.m_nCurrY, ET_FIRE, 50 * 1000 div (m_nDangerLevel + 1), magpwr);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
      if m_PEnvir.GetEvent(Target.m_nCurrX + 1, Target.m_nCurrY) = nil then begin
        FireBurnEvent := TFireBurnEvent.Create(self, Target.m_nCurrX + 1, Target.m_nCurrY, ET_FIRE, 50 * 1000 div (m_nDangerLevel + 1), magpwr);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
      if m_PEnvir.GetEvent(Target.m_nCurrX, Target.m_nCurrY + 1) = nil then begin
        FireBurnEvent := TFireBurnEvent.Create(self, Target.m_nCurrX, Target.m_nCurrY + 1, ET_FIRE, 50 * 1000 div (m_nDangerLevel + 1), magpwr);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
  end;
end;

procedure TMagicZumaKing.FlameAttack(nDir: Integer);
var
  I:Integer;
  magpwr:Integer;
  BaseObject:TBaseObject;
begin
 m_btDirection:=nDir;

 SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  for i:=0 to m_TargetCret.m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseOBject (pTVisibleBaseObject(m_TargetCret.m_VisibleActors[i]).BaseObject);
    if (abs(m_TargetCret.m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(m_TargetCret.m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin
      if BaseObject <> nil then begin
        if IsProperTarget (BaseObject) then begin
          if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
            magpwr:=(HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
          end;
        end;
      end;
     end;
  end;
end;

{TCrystalSpider}
constructor TCrystalSpider.Create;
begin
  inherited;
  m_nViewRange := 11;
  m_boUseMagic := False;
  attack_length := 3;
  m_nChanceOfLightning := 3;
  m_boHalfLifeAttack := False;
end;

function TCrystalSpider.AttackTarget: Boolean;
begin
  Result := False;
  if (Random(m_TargetCret.m_btAntiPoison + 20) = 0) then
    m_TargetCret.MakePosion(POISON_DECHEALTH,30,1);
  Result := inherited AttackTarget;
end;

{TDarkDevil}
constructor TDarkDevil.Create;
begin
  inherited;
  m_nViewRange := 11;
  m_boUseMagic := False;
  attack_length := 2;
  m_nChanceOfLightning := 6;
  m_boHalfLifeAttack := False;
end;

{ TFiredrakeBodyguardMon }

procedure TFiredrakeBodyguardMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
const
  WideAttack: array[0..4] of Byte = (0, 1, 2, 6, 7);
var
  nPower: Integer;
  nC, n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    nC := 0;
    while (True) do begin
      n10 := (m_btDirection + WideAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          SetTargetCreat(BaseObject);
          if (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
            nPower := BaseObject.GetStunDamage(Self, nPower);
            nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
            if nDamage > 0 then begin
              BaseObject.StruckDamage(nDamage, Self);
              BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
            end;
          end;
        end;
      end;
      Inc(nC);
      if nC >= 5 then begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
          BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
          if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
            SetTargetCreat(BaseObject);
            if (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
              nPower := BaseObject.GetStunDamage(Self, nPower);
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
              end;
            end;
          end;
        end;
        break;
      end;
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TFiredrakeBodyguardMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

{ TLeiyanAraneidMon }

procedure TLeiyanAraneidMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower: Integer;
  n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    n10 := 1;
    while (True) do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n10, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          SetTargetCreat(BaseObject);
          nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
          end;
        end;
      end;
      if n10 >= 3 then break;
      Inc(n10);
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TLeiyanAraneidMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 3) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

{ TGreenAraneidMon }

procedure TGreenAraneidMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower: Integer;
  n10: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    n10 := 1;
    while (True) do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n10, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          SetTargetCreat(BaseObject);
          nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage, Self);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
          end;
        end;
      end;
      if n10 >= 4 then break;
      Inc(n10);
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TGreenAraneidMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

{ TSnowfieldWarriorMon }

procedure TSnowfieldWarriorMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  nPower: Integer;
  nX, nY, aX, aY: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  I: Integer;
begin
  m_btDirection := nDir;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
  if nPower > 0 then begin
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, aX, aY) then begin
      for nX := aX - 1 to aX + 1 do begin
        for nY := aY - 1 to aY + 1 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if ((BaseObject <> nil) and (not BaseObject.m_boGhost) and (BaseObject.bo2B9)) and
                  (not BaseObject.m_boDeath) and IsProperTarget(BaseObject) then begin
                  SetTargetCreat(BaseObject);
                  nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                  if nDamage > 0 then begin
                    BaseObject.StruckDamage(nDamage, Self);
                    BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                      BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
end;

function TSnowfieldWarriorMon.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 3) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY));
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

{ TSnowfieldForceMon }

function TSnowfieldForceMon.AttackTarget: Boolean;
var
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  nDamage: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  nPower: Integer;
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        if Random(10) = 0 then begin
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
          m_btDirection := bt06;
          if nPower > 0 then begin
            for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
              for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
                if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
                  for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                    OSObject := MapCellInfo.ObjList.Items[I];
                    if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                      BaseObject := TBaseObject(OSObject.CellObj);
                      if ((BaseObject <> nil) and (not BaseObject.m_boGhost) and (BaseObject.bo2B9)) and
                        (not BaseObject.m_boDeath) and IsProperTarget(BaseObject) then begin
                        SetTargetCreat(BaseObject);
                        nPower := BaseObject.GetStunDamage(Self, nPower);
                        nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                        if nDamage > 0 then begin
                          BaseObject.StruckDamage(nDamage, Self);
                          BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP,
                            BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                        end;
                        if (Random(BaseObject.m_btAntiPoison + 20) = 0) then
                          BaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime, g_Config.nAttackPosionTime);
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
        end else
          Attack(m_TargetCret, bt06);
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

{ TPakNewMon }

procedure TPakNewMon.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  inherited;

end;

function TPakNewMon.AttackBy243(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 5, Integer(m_TargetCret), '',
            1000 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          SendRefMsg(RM_MONMAGIC, 7, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy244(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 5, Integer(m_TargetCret), '',
            1000 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          SendRefMsg(RM_MONMAGIC, 8, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy255(nDir: Integer): Boolean;
var
  btAttackMode, bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    btAttackMode := 0;
    if (Random(10) = 0) and (GetCircumambienceMonCount > 1) then begin
      btAttackMode := 1;
    end else
    if GetAttackDir(m_TargetCret, bt06) then begin
      nDir := bt06;
      btAttackMode := 2;
    end{ else
    if CheckViewRange(m_TargetCret, 7) then begin
      btAttackMode := 3;
    end};  
    if btAttackMode > 0 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        case btAttackMode of
          1: begin
              SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
              WideAttack(m_nCurrX, m_nCurrY, 3, False);
            end;
          3: begin
              SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
              //FlyWideAttack(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
              //SendRefMsg(RM_MONMAGIC, 6, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
            end;
          2: Attack(m_TargetCret, nDir);
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
    end;
    if not Result then begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.AttackBy506(nDir: Integer): Boolean;
var
  nPower, nX, nY: Integer;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetTickCount > m_dwCheckRageTick then begin
      m_dwCheckRageTick := GetTickCount + 2000;
      if Random(10) < 3 then begin
        if m_PEnvir.GetXYHuman(m_nCurrX, m_nCurrY, 1) > 0 then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_SPACEMOVE_FIRE3, 0, 0, 0, 0, '');
          nX := m_nCurrX + (Random(16) - 8);
          nY := m_nCurrY + (Random(16) - 8);
          SpaceMove(m_PEnvir, nX, nY, 2);
          Result := True;
          Exit;
        end;
      end;
    end;
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        //self.m_PEnvir.GetXYHuman()
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for nX := m_TargetCret.m_nCurrX - 1 to m_TargetCret.m_nCurrX + 1 do begin
          for nY := m_TargetCret.m_nCurrY - 1 to m_TargetCret.m_nCurrY + 1 do begin
            if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                  BaseObject := TBaseObject(OSObject.CellObj);
                  if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                    IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                  begin
                      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 3, Integer(BaseObject), '', 500);
                  end;
                end;
              end;
            end;
          end;
        end;
        SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 12, '', 360);
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

function TPakNewMon.AttackBy512(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseLongAttackTarget(nDir, 4) then begin
      if CheckViewRange(m_TargetCret, m_nViewRange) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 3, Integer(m_TargetCret), '', 400);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 14, '', 300);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy515(nDir: Integer): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (not m_boDeliriaOK) and m_boDeliria then begin
      m_boDeliriaOK := True;
      m_btDirection := nDir;
      m_dwHitTick := GetTickCount() + LongWord(m_nNextHitTime);
      m_dwTargetFocusTick := GetTickCount() + LongWord(m_nNextHitTime);
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 2;
      for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
        for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                  IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                begin
                  nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                  if nDamage > 0 then begin
                    BaseObject.StruckDamage(nDamage, Self);
                    BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                      BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 3);
  end;
end;

function TPakNewMon.AttackBy516(nDir: Integer): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, 7) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount() + LongWord(m_nNextHitTime);
        m_dwTargetFocusTick := GetTickCount() + LongWord(m_nNextHitTime);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if m_boDeliria then begin
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          for i := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
            if BaseObject = nil then Continue;
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
            begin
              SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 16, '', 100);
              nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                  BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
              end;
              if BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <= 0 then begin
                BaseObject.SendDelayMsg(Self, RM_POISON, POISON_DECHEALTH, nPower, Integer(Self),
                  ROUND(nPower / g_Config.nAmyOunsulPoint), '', 400);
              end;
            end;
          end;
        end else begin
          SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 15, '', 100);
          for nX := m_TargetCret.m_nCurrX - 1 to m_TargetCret.m_nCurrX + 1 do begin
            for nY := m_TargetCret.m_nCurrY - 1 to m_TargetCret.m_nCurrY + 1 do begin
              if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
                for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                  OSObject := MapCellInfo.ObjList.Items[I];
                  if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                    BaseObject := TBaseObject(OSObject.CellObj);
                    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                      IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                    begin
                      nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                      if nDamage > 0 then begin
                        BaseObject.StruckDamage(nDamage, Self);
                        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                          BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
 { Result := False;
  if m_TargetCret <> nil then begin
    if (not m_boDeliriaOK) and m_boDeliria then begin
      m_boDeliriaOK := True;
      m_btDirection := nDir;
      m_dwHitTick := GetTickCount() + LongWord(m_nNextHitTime);
      m_dwTargetFocusTick := GetTickCount() + LongWord(m_nNextHitTime);
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 2;
      for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
        for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                  IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then
                begin
                  nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                  if nDamage > 0 then begin
                    BaseObject.StruckDamage(nDamage, Self);
                    BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                      BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 3);
  end;}
end;

function TPakNewMon.AttackBy526(nDir: Integer): Boolean;
var
  nPower, nX, nY: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetTickCount > m_dwCheckRageTick then begin
      m_dwCheckRageTick := GetTickCount + 2000;
      if Random(10) < 3 then begin
        if m_PEnvir.GetXYHuman(m_nCurrX, m_nCurrY, 1) > 0 then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_SPACEMOVE_FIRE3, 0, 0, 0, 0, '');
          nX := m_nCurrX + (Random(16) - 8);
          nY := m_nCurrY + (Random(16) - 8);
          SpaceMove(m_PEnvir, nX, nY, 2);
          Result := True;
          Exit;
        end;
      end;
    end;
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 3, Integer(m_TargetCret), '', 400);

        SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 21, '', 360);
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

function TPakNewMon.AttackBy527(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (not m_boDeliriaOK) then begin
      m_boDeliriaOK := True;
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    if not BaseAttackTarget() then begin
      if m_boDeliria and CheckViewRange(m_TargetCret, m_nViewRange) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 3, Integer(m_TargetCret), '', 400);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 22, '', 360);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy534(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 5, Integer(m_TargetCret), '',
            1000 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          SendRefMsg(RM_MONMAGIC, 1, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy535(nDir: Integer): Boolean;
var
  nPower: Integer;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria then begin
      if CheckViewRange(m_TargetCret, 7) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_4, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          for i := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
            begin
              SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 5, Integer(BaseObject), '', 700);
              SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 24, '', 600);
            end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
        Exit;
      end;
    end;
    if not BaseLongAttackTarget(nDir, 4) then begin
      if CheckViewRange(m_TargetCret, 6) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 5, Integer(m_TargetCret), '', 700);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 23, '', 600);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy542(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 5, Integer(m_TargetCret), '',
          800 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
        SendRefMsg(RM_MONMAGIC, 2, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
    end
    else begin
      DelTargetCreat(); {0FFF1h}
    end;
  end;
end;

function TPakNewMon.AttackBy543(nDir: Integer): Boolean;
var
  nPower, n14: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 5, Integer(m_TargetCret), '',
          800 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
        SendRefMsg(RM_MONMAGIC, 3, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) then begin
        n14 := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
        m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
        SetTargetXY(m_nTargetX, m_nTargetY);
      end else
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end
    else begin
      DelTargetCreat(); {0FFF1h}
    end;
  end;
end;

function TPakNewMon.AttackBy544(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (not m_boDeliriaOK) then begin
      m_boDeliriaOK := True;
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
      for nX := m_nCurrX - 3 to m_nCurrX + 3 do begin
        for nY := m_nCurrY - 3 to m_nCurrY + 3 do begin
          if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := MapCellInfo.ObjList.Items[I];
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                  IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                begin
                  nPower := BaseObject.GetStunDamage(Self, nPower);
                  nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                  if nDamage > 0 then begin
                    BaseObject.StruckDamage(nDamage, Self);
                    BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                      BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 4);
  end;
end;

function TPakNewMon.AttackBy545(nDir: Integer): Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    Result := BaseLongAttackTarget(nDir, 2);
    if not Result then Result := BaseLongMsgTarget(nDir, 5, SM_LIGHTING);
  end;
end;

function TPakNewMon.AttackBy546(nDir: Integer): Boolean;
var
  nPower: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseLongAttackTarget(nDir, 2) then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendRefMsg(RM_MONMAGIC, 4, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
          for nX := m_TargetCret.m_nCurrX - 2 to m_TargetCret.m_nCurrX + 2 do begin
            for nY := m_TargetCret.m_nCurrY - 2 to m_TargetCret.m_nCurrY + 2 do begin
              if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
                for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                  OSObject := MapCellInfo.ObjList.Items[I];
                  if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                    BaseObject := TBaseObject(OSObject.CellObj);
                    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                      IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                    begin
                      SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 3, Integer(BaseObject), '',
                        800 + (abs(BaseObject.m_nCurrX - m_nCurrX) + abs(BaseObject.m_nCurrY - m_nCurrY)) div 2 * 20);
                    end;
                  end;
                end;
              end;
            end;
          end;
          BreakHolySeizeMode();
        end;
        Result := True;
        Exit;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy547(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetCircumambienceMonCount > 1 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
          for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
            if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                  BaseObject := TBaseObject(OSObject.CellObj);
                  if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                    IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                  begin
                    nPower := BaseObject.GetStunDamage(Self, nPower);
                    nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                    if nDamage > 0 then begin
                      BaseObject.StruckDamage(nDamage, Self);
                      BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                        BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 500);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 2);
  end;
end;

function TPakNewMon.AttackBy548(nDir: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseLongAttackTarget(nDir, 2) then begin
      if CheckViewRange(m_TargetCret, 7) and MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendRefMsg(RM_MONMAGIC, 5, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 400);
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 3, Integer(m_TargetCret), '',
            800 + (abs(m_TargetCret.m_nCurrX - m_nCurrX) + abs(m_TargetCret.m_nCurrY - m_nCurrY)) div 2 * 20);
          BreakHolySeizeMode();
        end;
        Result := True;
        Exit;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy555(nDir: Integer): Boolean;
const
  WideAttack: array[0..2] of Byte = (7, 0, 1);
var
  nC, n10, nCount, nPower, nDamage: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := bt06;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nC := 0;
        nCount := 0;
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        while (True) do begin
          n10 := (m_btDirection + WideAttack[nC]) mod 8;
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              Inc(nCount);
              nPower := BaseObject.GetStunDamage(Self, nPower);
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), '', 400);
              end;
            end;
          end;
          Inc(nC);
          if nC >= 3 then break;
        end;
        if nCount > 1 then SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '')
        else SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.AttackBy557(nDir: Integer): Boolean;
var
  bt06: Byte;
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if m_boDeliria and (not m_boDeliriaOK) then begin
      m_btDirection := nDir;
      m_boDeliriaOK := True;
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
      BreakHolySeizeMode();
      Result := True;
      Exit;
    end else
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        nPower := m_TargetCret.GetStunDamage(self,nPower);
        if m_boDeliria then nPower := Round(m_TargetCret.GetHitStruckDamage(Self, nPower) * 2);
        if nPower > 0 then begin
          m_TargetCret.StruckDamage(nPower, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
            m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 200);
        end;
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.AttackBy560(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetCircumambienceMonCount > 1 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
        nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
        for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
          for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
            if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                  BaseObject := TBaseObject(OSObject.CellObj);
                  if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                    IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                  begin
                    nPower := BaseObject.GetStunDamage(Self, nPower);
                    nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                    if nDamage > 0 then begin
                      BaseObject.StruckDamage(nDamage, Self);
                      BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                        BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 400);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    Result := BaseLongAttackTarget(nDir, 2);
  end;
end;

function TPakNewMon.AttackBy563(nDir: Integer): Boolean;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      Result := BaseLongAttackTarget(nDir, 3, RM_LIGHTING);
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackBy564(nDir: Integer): Boolean;
var
  nPower, nDamage: Integer;
  nX, nY, I: Integer;
  BaseObject: TBaseObject;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetCircumambienceMonCount > 1 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
          for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
            if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                  BaseObject := TBaseObject(OSObject.CellObj);
                  if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                    IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
                  begin
                    nPower := BaseObject.GetStunDamage(Self, nPower);
                    nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
                    if nDamage > 0 then begin
                      BaseObject.StruckDamage(nDamage, Self);
                      BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                        BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 600);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
      Exit;
    end;
    if m_boDeliriaOK then Result := BaseAttackTarget()
    else Result := BaseAttackTarget(RM_LIGHTING);

  end;
end;

function TPakNewMon.AttackBy568(nDir: Integer): Boolean;
var
  nX, nY, i, nDamage: Integer;
  btDir: Byte;
  PoseCreate: TBaseObject;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      if (GetCircumambienceMonCount > 1) and GetAttackDir(m_TargetCret, btDir) then begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, 2, nX, nY) then begin
          if m_PEnvir.GetMovingObject(nX, nY, True) = nil then begin
            m_btDirection := btDir;
            for i := 0 to 2 do begin
              PoseCreate := GetPoseCreate();
              if PoseCreate <> nil then begin
                if PoseCreate.CharPushed(m_btDirection, 1) <> 1 then break;
                GetFrontPosition(nX, nY);
                if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
                  m_nCurrX := nX;
                  m_nCurrY := nY;
                  GetStartType();
                  SendRefMsg(RM_RUSH, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
                  Result := True;
                end else break;
              end;
            end;
          end;
        end;
      end;
      if Result then begin
        m_btDirection := nDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nDamage := m_TargetCret.GetHitStruckDamage(Self, GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)))) div 2;
        nDamage := m_TargetCret.GetStunDamage(Self, nDamage);
        if nDamage > 0 then begin
          m_TargetCret.StruckDamage(nDamage, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
            m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 800);
        end;
        BreakHolySeizeMode();
        Exit;
      end;
    end;
    Result := BaseAttackTarget();
  end;
end;

function TPakNewMon.AttackByMagic(nDir, nMagId: Integer): Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if not BaseAttackTarget() then begin
      if CheckViewRange(m_TargetCret, m_nViewRange) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_btDirection := nDir;
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_LIGHTING, nDir, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 3, Integer(m_TargetCret), '', 400);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nMagId, '', 360);
          BreakHolySeizeMode();
        end;
        Result := True;
      end;
    end else
      Result := True;
  end;
end;

function TPakNewMon.AttackTarget: Boolean;
var
  nAttackDir: byte;
begin
  Result := False;
  if (m_TargetCret = nil) or (not IsProperTarget(m_TargetCret)) then Exit;
  nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  case m_wAppr of
    243: Result := AttackBy243(nAttackDir);
    255: Result := AttackBy255(nAttackDir);
    331, 332: Result := AttackBy244(nAttackDir);
    501: Result := AttackByMagic(nAttackDir, 9);
    504: Result := AttackByMagic(nAttackDir, 10);
    505: Result := AttackByMagic(nAttackDir, 11);
    506: Result := AttackBy506(nAttackDir);
    510: Result := AttackByMagic(nAttackDir, 13);
    512: Result := AttackBy512(nAttackDir);
    513: Result := BaseLongAttackTarget(nAttackDir, 4);
    515: Result := AttackBy515(nAttackDir);
    516: Result := AttackBy516(nAttackDir);
    518: Result := BaseDoubleAttack(nAttackDir);
    525, 320: Result := BaseLongAttackTarget(nAttackDir, 3);
    526, 321: Result := AttackBy526(nAttackDir);
    527, 322: Result := AttackBy527(nAttackDir);
    534, 280: Result := AttackBy534(nAttackDir);
    535: Result := AttackBy535(nAttackDir);
    542: Result := AttackBy542(nAttackDir);
    543: Result := AttackBy543(nAttackDir);
    544: Result := AttackBy544(nAttackDir);
    545: Result := AttackBy545(nAttackDir);
    546: Result := AttackBy546(nAttackDir);
    547: Result := AttackBy547(nAttackDir);
    548: Result := AttackBy548(nAttackDir);
    555: Result := AttackBy555(nAttackDir);
    556: Result := BaseDoubleMagAttack(nAttackDir, 27, 28);
    557: Result := AttackBy557(nAttackDir);
    558: Result := BaseLongAttackTarget(nAttackDir, 2, RM_LIGHTING);
    560: Result := AttackBy560(nAttackDir);
    563: Result := AttackBy563(nAttackDir);
    564: Result := AttackBy564(nAttackDir);
    565, 566, 567: Result := BaseDoubleAttack(nAttackDir);
    568: Result := AttackBy568(nAttackDir);
    else Result := inherited AttackTarget;
  end;
end;

function TPakNewMon.BaseAttackTarget(nCmd: Integer): Boolean;
var
  bt06: Byte;
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        if nCmd = RM_LIGHTING then begin
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
          nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
          nPower := m_TargetCret.GetStunDamage(Self, nPower);
          nPower := Round(m_TargetCret.GetHitStruckDamage(Self, nPower) * 1.5);
          if nPower > 0 then begin
            m_TargetCret.StruckDamage(nPower, Self);
            m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
              m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 200);
          end;
        end else
          Attack(m_TargetCret, bt06); //FFED
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

function TPakNewMon.BaseDoubleAttack(nDir: Integer): Boolean;
var
  bt06: Byte;
  nPower, nDamage: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret, bt06) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        m_btDirection := bt06;
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if not m_boDeliriaOK then nPower := nPower * 2;
        nPower := m_TargetCret.GetStunDamage(Self, nPower);
        nDamage := m_TargetCret.GetHitStruckDamage(Self, nPower);
        if nDamage > 0 then begin
          m_TargetCret.StruckDamage(nDamage, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP,
            m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 200);
        end;
        if not m_boDeliriaOK then SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '')
        else SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

function TPakNewMon.BaseDoubleMagAttack(nDir, nMID1, nMID2: Integer): Boolean;
var
  nPower, nDamage: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        m_btDirection := nDir;
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        if not m_boDeliriaOK then nPower := nPower * 2;
        nDamage := m_TargetCret.GetMagStruckDamage(Self, nPower);
        if nDamage > 0 then begin
          m_TargetCret.StruckDamage(nDamage, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP,
            m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 500);
        end;
        if not m_boDeliriaOK then begin
          SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nMID2, '', 400);
        end
        else begin
          SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
          SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nMID1, '', 400);
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.BaseLongAttackTarget(btDir, btRate: Byte; nCmd: Integer = SM_HIT): Boolean;
var
  I, nX, nY, nPower, nDamage: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;

  if m_TargetCret <> nil then begin
    if (m_PEnvir = m_TargetCret.m_PEnvir) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= btRate) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= btRate) and CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := btDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for I := 1 to btRate do begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              nPower := m_TargetCret.GetStunDamage(Self, nPower);
              nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
              end;
            end;
          end;
        end;
        if nCmd = RM_LIGHTING then SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '')
        else SendAttackMsg(RM_HIT, nCmd, m_btDirection, m_nCurrX, m_nCurrY);
        //Attack(m_TargetCret, btDir); //FFED
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

function TPakNewMon.BaseLongMsgTarget(btDir, btRate: Byte; nCmd: Integer): Boolean;
var
  I, nX, nY, nPower, nDamage: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;

  if m_TargetCret <> nil then begin
    if (m_PEnvir = m_TargetCret.m_PEnvir) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= btRate) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= btRate) and CheckBeeline(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_btDirection := btDir;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        SendRefMsg(RM_LIGHTING, btDir, 0, 0, Integer(m_TargetCret), '');
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
        for I := 1 to btRate do begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), '', 500);
              end;
            end;
          end;
        end;
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TPakNewMon.BeginDeliria;
begin
  if m_boCanDeliria then begin
    m_nNextHitTime := 700;
    m_nWalkSpeed := 400;
  end;
  m_boDeliriaOK := False;
end;

function TPakNewMon.CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
begin
  Result := False;
  if (Targe <> nil) and (abs(m_nCurrX - Targe.m_nCurrX) <= nViewRange) and (abs(m_nCurrY - Targe.m_nCurrY) <= nViewRange) then
    Result := True;
end;

constructor TPakNewMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_dwCheckRageTick := GetTickCount;
  m_boDeliriaOK := True;
  m_boCanDeliria := False;
  m_boIsFirst := True;
  {if m_wAppr = 558 then begin
    m_boFixedHideMode := True;
    m_boNoAttackMode := True;
  end;   }
end;

procedure TPakNewMon.Die;
var
  I, nPower, nX, nY, nDamage: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  if (m_wAppr = 561) then begin
    SendRefMsg(RM_LIGHTING, m_btDirection, 0, 0, Integer(m_TargetCret), '');
    nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
    for nX := m_nCurrX - 2 to m_nCurrX + 2 do begin
      for nY := m_nCurrY - 2 to m_nCurrY + 2 do begin
        if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
              begin
                nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                if nDamage > 0 then begin
                  BaseObject.StruckDamage(nDamage, Self);
                  BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                    BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 1200);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end else
  if (m_wAppr = 560) then begin
    nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
    for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
      for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
        if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
              begin
                BaseObject.SendDelayMsg(Self, RM_POISON, POISON_DECHEALTH, nPower, Integer(Self), ROUND(nPower / g_Config.nAmyOunsulPoint), '', 600);
              end;
            end;
          end;
        end;
      end;
    end;
  end else
  if (m_wAppr = 526) then begin
    nPower := Round(GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))) * 1.5);
    for nX := m_nCurrX - 1 to m_nCurrX + 1 do begin
      for nY := m_nCurrY - 1 to m_nCurrY + 1 do begin
        if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
                IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
              begin
                nDamage := BaseObject.GetMagStruckDamage(Self, nPower);
                if nDamage > 0 then begin
                  BaseObject.StruckDamage(nDamage, Self);
                  BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                    BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  inherited Die;
end;

procedure TPakNewMon.EndDeliria;
begin
  if m_boCanDeliria then begin
    m_nNextHitTime := m_dwNextHitTime;
    m_nWalkSpeed := m_nWalkSpeed;
  end;
  m_boDeliriaOK := True;
end;
     {
procedure TPakNewMon.FirstEffect;
begin
  if m_wAppr = 558 then begin
    SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
  end;
end;         }

function TPakNewMon.GetCircumambienceMonCount(btRate: Byte): Integer;
var
  i: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
      (BaseObject.m_PEnvir = m_PEnvir) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= btRate) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= btRate) then begin
      if (not BaseObject.IsHidden or m_boCoolEye) and IsProperTarget(BaseObject) then
        Inc(Result);
    end;
  end;
end;

procedure TPakNewMon.Initialize;
begin
  inherited Initialize;
  if (m_wAppr = 512) or (m_wAppr = 535) then m_nViewRange := 7;
  if (m_wAppr = 515) or (m_wAppr = 516) or (m_wAppr = 535) then begin
    m_boRandomMove := True;
    m_boCanDeliria := True;
  end;
  if (m_wAppr = 527) or (m_wAppr = 322) or (m_wAppr = 544) or (m_wAppr = 557) then begin
    m_boCanDeliria := True;
  end;
end;

procedure TPakNewMon.Run;
begin
  if (not m_boDeath) and (not bo554) and (not m_boGhost) and CanWork then begin
    {if m_boIsFirst then begin
      m_boIsFirst := False;
      m_boFixedHideMode := False;
      FirstEffect();
    end;   }
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

function TPakNewMon.WideAttack(nSX, nSY: Integer; nRate: Byte; boMagic: Boolean): Boolean;
var
  nPower, nX, nY, nDamage: Integer;
  BaseObject: TBaseObject;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
  for nX := nSX - nRate to nSX + nRate do begin
    for nY := nSY - nRate to nSY + nRate do begin
      if m_PEnvir.GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and
              IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then
            begin
              if boMagic then begin
                nDamage := BaseObject.GetMagStruckDamage(Self, nPower)
              end else begin
                nPower := m_TargetCret.GetStunDamage(Self, nPower);
                nDamage := BaseObject.GetHitStruckDamage(Self, nPower);
              end;
              if nDamage > 0 then begin
                BaseObject.StruckDamage(nDamage, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
                  BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 450);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{ TPillarMonster }

constructor TPillarMonster.Create;
begin
  inherited;
  m_nViewRange := 2;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
end;

destructor TPillarMonster.Destroy;
begin

  inherited;
end;

procedure TPillarMonster.Initialize;
begin
  inherited;
  m_Abil.Level := High(Word);
end;

procedure TPillarMonster.Run;
var
  i: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
  WAbil: pTAbility;
  nDamage, nPower: Integer;
begin
  TargeTBaseObject := nil;
  m_TargetCret := nil;
  if not m_boGhost and not m_boDeath and not m_boFixedHideMode and not m_boStoneMode and CanWork then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      WAbil := @m_WAbil;
      nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
      if nDamage > 0 then begin
        for i := 0 to m_VisibleActors.Count - 1 do begin
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
          if BaseObject.m_boDeath then Continue;
          if IsProperTarget(BaseObject) and ((not BaseObject.IsHidden) or m_boCoolEye) then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) < 3) and (abs(m_nCurrY - BaseObject.m_nCurrY) < 3) and (m_PEnvir = BaseObject.m_PEnvir) then begin
              TargeTBaseObject := BaseObject;
              nPower := BaseObject.GetMagStruckDamage(Self, nDamage);
              if nPower > 0 then begin
                BaseObject.StruckDamage(nPower, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 100);
              end;
            end;
          end;
        end;
      end;
      if TargeTBaseObject <> nil then
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
      BreakHolySeizeMode();
    end;
  end;
  inherited;
end;

constructor TCloneObject.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boNOITEM:=TRUE;
  m_nDieReason:=0;
end;

procedure TCloneObject.Die;
begin
  //if not m_btRaceServer = 185 then begin
  if m_Master <> nil then
    case m_nDieReason of
      0:  m_Master.SysMsg('Your clone has been killed',c_Red,t_Hint);
      1:  m_Master.SysMsg('Your clone is destroyed due to lack of MP',c_Red,t_Hint);
    end;
  //  if not m_btRaceServer = 185 then begin
  SendRefMsg(RM_10205,0,m_nCurrX,m_nCurrY,3,'');
  SendDelayMsg(self, RM_DISAPPEAR, 0, 0, 0, 0, '', 600);
  m_boObMode:=True;
  //end;
  //end;
  inherited;
end;

function TCloneObject.GetShowName: string;
var
  sShowName: string;
begin
  Result := FilterShowName('Clone');
  if (m_Master <> nil) and (m_Master.m_sCharName <> '') then begin
//   Result := m_Master.m_sCharName;
    Result := m_Master.GetShowName();
  end;
end;

function TCloneObject.GetCharColor(BaseObject: TBaseObject): Byte;
begin
  if (m_Master <> nil) and (m_Master.m_sCharName <> '') then begin
    Result := m_Master.getCharColor(BaseObject);
  end else
    Result := Inherited GetCharColor(BaseObject);
end;


function TCloneObject.GetFeature(BaseObject: TBaseObject): Integer;
var
  nDress, nWeapon, nHair: Integer;
  StdItem: pTStdItem;
begin
  nDress := 0;
  StdItem := UserEngine.GetStdItem(m_UseItems[U_DRESS].wIndex);
  if StdItem <> nil then begin
    nDress := StdItem.Shape * 2;
  end;
  Inc(nDress, m_btGender);

  nWeapon := 0;
  StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
  if StdItem <> nil then begin
    nWeapon := StdItem.Shape * 2;
  end;
  Inc(nWeapon, m_btGender);

  nHair := m_btHair * 2 + m_btGender;
  Result := MakeHumanFeature(0, nDress, nWeapon, nHair);
end;

procedure TCloneObject.Run;
begin
  if not m_boDeath and (m_Master <> nil) and (m_Master.m_boDeath or m_Master.m_boGhost) then
    die();
  if not m_boGhost and
     not m_boDeath and
     not m_boFixedHideMode and
     not m_boStoneMode and
    (m_wStatusTimeArr[POISON_STONE] = 0) then begin
    if (GetTickCount - m_dwThinkTick) > 1000 then begin
      m_dwThinkTick:=GetTickCount();
      if m_Master <> nil then
        FindTarget();
    end;
  end;
  inherited;
end;

procedure TCloneObject.FindTarget();
begin
  if m_TargetCret <> nil then begin //check if our old target is still valid
    if (m_TargetCret.m_PEnvir <> m_PEnvir) or (m_TargetCret.m_boDeath) or (m_TargetCret.m_boGhost) then
      m_TargetCret := nil;
  end;

  if (m_LastHiter <> nil) and (m_LastHiter.m_PEnvir = m_PEnvir) and (m_TargetCret = nil) and (ispropertarget(m_LastHiter)) then begin //if we get attacked
    SetTargetCreat(m_LastHiter);
  end;

  if (m_Master <> nil) and (m_Master.m_TargetCret <> nil) then begin // if our master has a target
    if (m_Master.m_TargetCret.m_PEnvir = m_PEnvir) and (ispropertarget(m_Master.m_TargetCret)) then //if the target is on same map as us
      SetTargetCreat(m_Master.m_TargetCret);
  end;
  if (m_Master <> nil) and (m_Master.m_LastHiter <> nil) then begin  //if someone hit our master
    if (m_Master.m_LastHiter.m_PEnvir = m_PEnvir) and (ispropertarget(m_Master.m_LastHiter)) then // if whoever hit our master is also on same map as us
     SetTargetCreat(m_Master.m_LastHiter);
  end;
end;

constructor TWizClone.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwMpLossTick:= GetTickCount();
  m_boApproach:=False;
  m_boNoAttackMode := True;
  m_boNextTurnDie:=False;
  m_Owner:=nil;
end;

destructor TWizClone.Destroy;
begin
  inherited;
end;

procedure TWizClone.Die;
begin
  //delay death by 1 turn so server has time to send the msg to make clone disappear
  if m_boNextTurnDie then begin
    inherited;
    m_boNextTurnDie := False;
  end else
    m_boNextTurnDie := True;
end;

procedure TWizClone.SetMpLoss(nMpReduction:Integer);
begin
  nMpLoss:=nMpReduction;
end;

procedure TWizClone.Run;
var
  nx,ny: Integer;
  nStatus:integer;
begin
nStatus:=0;
try
  if m_boNextTurnDie and not m_boGhost and not m_boDeath then begin
    die();
    inherited;
    exit;
  end;
  if not m_boDeath then
    m_WAbil.Hp := m_WAbil.MaxHp;
  if (m_Master = nil) or (m_Master.m_boGhost) or not (m_Master is TBaseObject) then begin
      nStatus:=1;
      m_boNextTurnDie := True;
      m_Owner:=nil;
      inherited;
      exit;
    end else
      m_Owner:=m_Master;

  if not m_boGhost and
     not m_boDeath and
     not m_boFixedHideMode and
     not m_boStoneMode and
    (m_wStatusTimeArr[POISON_STONE] = 0) then begin
    nStatus:=2;

    if (m_Owner <> nil) and (m_Owner.m_WAbil.MP < (m_Owner.m_WAbil.MaxMP div 10)) then begin  //if our master has to little mp die :p
      nStatus:=4;
      TCloneObject(self).m_nDieReason:=1;
      m_boNextTurnDie := True;
      inherited;
      exit;
    end;

    //some 'mobs' get locked after x steps i guess we could leave this part in :p
    if m_boWalkWaitLocked then begin    //this unlocks the 'walkwaitlock' after it's been locked
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked:=False;
      end;
    end;

    //if we are walkwaitlocked then just exit :p
    if m_boWalkWaitLocked then begin
      nStatus:=6;
      inherited;
      exit;
    end;
    nStatus:=12;
    if m_Owner <> nil then begin
      m_Owner.GetBackPosition(nX,nY);
      if (abs(m_nTargetX - nX) > 0) or (abs(m_nTargetY - nY) > 0) then begin
        m_nTargetX:=nX;
        m_nTargetY:=nY;
        if (abs(m_nCurrX - nX) <= 1) and (abs(m_nCurrY - nY) <= 1) then begin
          if m_PEnvir.GetMovingObject(nX,nY,True) <> nil then begin  //if there is already an 'object' behind our master then dont try to go to him
            m_nTargetX:=m_nCurrX;
            m_nTargetY:=m_nCurrY;
          end
        end;
      end;
      if (not m_Owner.m_boSlaveRelax) and
             ((m_PEnvir <> m_Owner.m_PEnvir) or
             (abs(m_nCurrX-m_Owner.m_nCurrX) > 20) or
             (abs(m_nCurrY-m_Owner.m_nCurrY) > 20)) then begin //if slave isnt set to rest and the master is out of our normal walking range teleport to him
             nStatus:=7;
        SpaceMove(m_Owner.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
      end;
      if m_Owner.m_boSlaveRelax then begin
        //if we have a master and he set petmode to rest then the pet should do absolutely nothing
        nStatus:=8;
        inherited ;
        exit;
      end;
    end;

    if m_nTargetX <> -1 then begin // if we have targetcoords to go towards then go there (or stay there if coords are same as where you are atm)
        // this locks the walkwaitlock after m_nwalkstep  amount of steps
      if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
        nStatus:=9;
        m_dwWalkTick:=GetTickCount();
        GotoTargetXY();
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then begin
          m_nWalkCount:=0;
          m_boWalkWaitLocked:=True;
          m_dwWalkWaitTick:=GetTickCount();
        end;
      end;

    end else begin //if there's no targetcoords and no real target to attack then walk arround @ random
      nStatus:=10;
      if m_TargetCret = nil then Wondering();
    end;

    if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
        nStatus:=11;
        m_dwHitTick:=GetTickCount();
        MagicAttack();
      end;
    end;

  end;
except
  MainOutMessage('Error with Mirroring Clone');
end;
try
  inherited;
except
  MainOutMessage('WizClone process Error -1');
end;
end;

procedure TWizClone.MagicAttack();
var
  nPower:Integer;
  MirrorMagic   :pTUserMagic;
  SpellPoint    :Integer;
  UserMagic     :pTUserMagic;
  ThunderMagic  :pTUserMagic;
  FlameMagic    :pTUserMagic;
begin
  nPower:=0;
  if (m_Master <> nil) and (m_TargetCret <> nil) then begin
    if IsProperTarget (m_TargetCret) then begin
      PlayObject := TPlayObject(m_Owner);
      MirrorMagic := PlayObject.GetMagicInfo(SKILL_MIRRORING);
      ThunderMagic := PlayObject.GetMagicInfo(SKILL_THUNDERBOLT);
      FlameMagic := PlayObject.GetMagicInfo(SKILL_FLAMEDISRUPTOR);
      if (UserMagic = nil) or (MirrorMagic = nil) then exit;
      nPower := ((LoWord(m_Master.m_WAbil.MC)) + Random(HiWord(m_Master.m_WAbil.MC))) div 2;

      //Will perform ThunderBolt if target is Undead.
      if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then begin
        if ThunderMagic <> nil then begin
          UserMagic := ThunderMagic;
          nPower:= nPower + GetPower(Mpow(UserMagic),UserMagic);
          nPower:=ROUND(nPower * 1.5);
        end;
      end;
      //Will perform FlameDisruptor if target is living
      if m_TargetCret.m_btLifeAttrib <> LA_UNDEAD then begin
        if FlameMagic <> nil then begin
          UserMagic := FlameMagic;
          nPower:= nPower + GetPower(Mpow(UserMagic),UserMagic);
          if m_TargetCret.m_btRaceServer > RC_PLAYOBJECT then
            nPower := nPower + ROUND(nPower * 0.4)
          else
            nPower := nPower + ROUND(nPower * 0.15);
        end;
      end;

      if UserMagic <> nil then begin
        //We take MP if we can continue
        SpellPoint := GetSpellPoint(UserMagic);
        m_Owner.DamageSpell(SpellPoint);
        m_Owner.HealthSpellChanged();
        //Spell images cast
        SendRefMsg(RM_SPELL,UserMagic.MagicInfo.btEffect,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,UserMagic.MagicInfo.wMagicId,'');
        //Send MagicFireImages
        SendRefMsg(RM_MAGICFIRE,0,MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect), MakeLong(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY),Integer(m_TargetCret),'');
        //Check AMC/ETC of target
        nPower := m_TargetCret.GetMagStruckDamage(Self, nPower);
        if nPower > 0 then
          m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 600);
      end;
    end;
  end;
end;

function TWizClone.MPow(UserMagic:pTUserMagic):Integer;
begin
  Result:=UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;

function TWizClone.GetPower(nPower:Integer;UserMagic:pTUserMagic):Integer;
var
nCPower:Integer;
begin
  Result:=0;
  //Safe check so you don't have any negitive one hit kills.
  nCPower:=ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  if nCPower > 0 then Result:=nCPower;
end;

procedure TWizClone.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  if m_Master <> nil then begin
    if (m_Master.m_WAbil.MaxHP < nDamage) or (m_Master.m_WAbil.MP < nDamage) then begin
      //m_WAbil.HP := 0;
      //m_boNextTurnDie:=True;
      die();
      exit;
    end;
    m_Master.DamageSpell(nDamage);
    m_Master.HealthSpellChanged();
  end;
end;

procedure TWizClone.FindTarget();
begin
  if m_TargetCret <> nil then begin //check if our old target is still valid
    if (m_TargetCret.m_PEnvir <> m_PEnvir) or (m_TargetCret.m_boDeath) or (m_TargetCret.m_boGhost) then
      m_TargetCret := nil;
  end;

  if (m_LastHiter <> nil) and (m_LastHiter.m_PEnvir = m_PEnvir) and (m_TargetCret = nil) and (ispropertarget(m_LastHiter)) then begin //if we get attacked
    SetTargetCreat(m_LastHiter);
  end;

  if (m_Owner <> nil) and (m_Owner.m_TargetCret <> nil) then begin // if our master has a target
    if (m_Owner.m_TargetCret.m_PEnvir = m_PEnvir) and (ispropertarget(m_Owner.m_TargetCret)) then //if the target is on same map as us
      SetTargetCreat(m_Owner.m_TargetCret);
  end;
  if (m_Owner <> nil) and (m_Owner.m_LastHiter <> nil) then begin  //if someone hit our master
    if (m_Owner.m_LastHiter.m_PEnvir = m_PEnvir) and (ispropertarget(m_Owner.m_LastHiter)) then // if whoever hit our master is also on same map as us
      SetTargetCreat(m_Owner.m_LastHiter);
  end;
end;

constructor TFrostTiger.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwSpellTick:=GetTickCount();
  m_dwLastWalkTick:=GetTickCount();
  m_boApproach:=FALSE;
end;

destructor TFrostTiger.Destroy;
begin
  inherited;
end;

procedure TFrostTiger.Run;//004A9720
var
  nAttackDir, nX, nY: Integer;
begin
  if (CanPerformActions) then begin
    if m_TargetCret = nil then begin  //if theres no target stay transparent

      if not m_boHideMode then begin
        if (gettickcount - m_dwLastWalkTick > 2000) then begin
          m_dwLastWalkTick := GetTickCount();
          MagicManager.MagMakePrivateTransparent(Self,180);
          //SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
        end;
      end else
        m_dwLastWalkTick := GetTickCount();
    end else begin
    //there is a target so take of transparency
      if not m_TargetCret.m_boDeath then begin
        if m_boHideMode then begin
          m_wStatusTimeArr[STATE_TRANSPARENT{0x70}]:=1;
          //SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
        end;
      end else
        m_TargetCret := nil;

      if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwLastWalkTick) > m_nWalkSpeed) then begin //check if we should walk closer or not and do it :p
        m_dwLastWalkTick:=GetTickCount();
        m_nTargetX:=m_TargetCret.m_nCurrX;
        m_nTargetY:=m_TargetCret.m_nCurry;
        GotoTargetXY();
      end;
    end;

    if ((GetTickCount - m_dwSpellTick) > 3000) and (m_TargetCret <> nil) then begin
      if (abs(m_TargetCret.m_nCurrX-m_nCurrX) >= 2) or (abs(m_TargetCret.m_nCurrY-m_nCurry) >= 2) then begin
        m_dwSpellTick:=GetTickCount();
        FrostAttack();
      end;
    end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      if m_Master <> nil then begin
        SearchTarget();
      end;
    end;
  end;
  inherited;
end;

procedure TFrostTiger.FrostAttack();
var
Target:TBaseObject;
magpwr:Integer;
nAttackDir, nActualSlowChance: Integer;
begin
 if m_TargetCret = nil then exit;
 Target:=m_TargetCret;
 nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
 m_btDirection := nAttackDir;
 SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(Target),'');

  if IsProperTarget (Target) then begin
 //   if Random(g_config.nMagicResistanceRate) >= Target.m_nAntiMagic then begin
      magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      Target.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
      nActualSlowChance := 5;
      nActualSlowChance := nActualSlowChance - Round((nActualSlowChance / 100) * Target.m_btSlowResist);

      if (Random(20) < nActualSlowChance) then begin //and (Random(Target.m_btAntiPoison) = g_config.nPoisonResistanceRate) then begin
        if (Random(40) <= 3) then
          Target.MakePosion(POISON_FREEZE,5,0)
        else
          Target.MakePosion(POISON_SLOWDOWN,6,0);
      end;
  end;
end;

constructor TKhazard.Create;
begin
  inherited;
  m_dwThinkTick:=GetTickCount();
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TKhazard.Destroy;
begin

  inherited;
end;

procedure TKhazard.Run;
var
  time1 : integer;
begin
  if (CanPerformActions) then begin
    time1:=random(2);
    if m_TargetCret <> nil then begin

    //attack code
      if IsProperTarget(m_TargetCret) then begin
        m_nTargetX:=m_TargetCret.m_nCurrX;
        m_nTargetY:=m_TargetCret.m_nCurrY;
        if (abs(m_nTargetX-m_nCurrX) = 2) or (abs(m_nTargety-m_nCurry)=2) then begin
          if (GetTickCount - m_dwThinkTick) > 1000 then begin //do drag back on random
            m_dwThinkTick:=GetTickCount();
            if time1 < 2 then
              drag();
          end else
            AttackTarget();
        end;
      end;
    end;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

procedure TKhazard.Drag();
var
  nx,ny: Integer;
  nAttackDir: Integer;
begin
  nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
  m_btDirection := nAttackDir;
  GetFrontPosition(nx,ny);
  SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  nAttackDir:=GetNextDirection(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,m_nCurrX,m_nCurrY);
  m_TargetCret.CharPushed(nAttackDir,1);
  if (Random(1) = 0) then begin{and (Random(m_TargetCret.m_btAntiPoison + 7) <= g_config.nPoisonResistanceRate) then begin    }
    m_TargetCret.SendMsg(self,RM_POISON,POISON_DECHEALTH,35,Integer(self),2,'');
    exit;
  end;
end;

function TKhazard.AttackTarget():Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime  then begin
        m_dwHitTick:=GetTickCount();
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);  //FFED
        if (Random(1) = 0) then begin{and (Random(m_TargetCret.m_btAntiPoison + 7) <= 6 + g_config.nPoisonResistanceRate) then begin}
            m_TargetCret.SendMsg(self,RM_POISON,POISON_DECHEALTH,35,Integer(self),2,'');;
            exit;
        end;
      end;
      Result:=True;
    end;
  end;
end;

procedure TThunderTypeWT.Run; //004AA294
var
 target_distance_x, target_distance_y, nAttackDir: Integer;
begin
  inherited;
  if (CanPerformActions) then begin
    if (m_TargetCret <> nil) then begin
      target_distance_x := abs(m_nCurrX - m_TargetCret.m_nCurrX);
      target_distance_y := abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if (_Max(target_distance_x,target_distance_y) > 2) and (_max(target_distance_x,target_distance_y) < 10) and (Integer(GetTickCount - m_dwHitTick) > 2200) then begin
        nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
        MagicAttack(nAttackDir);
        m_dwHitTick:=GetTickCount();
      end;
    end;
  end;
end;

procedure TThunderTypeWT.MagicAttack(attack_direction: Integer);
var
  Target: TBaseObject;
  magpwr:Integer;
begin
  if m_TargetCret = nil then
    exit;

  Target:=m_TargetCret;

  SendRefMsg(RM_LIGHTING,attack_direction,m_nCurrX,m_nCurrY,Integer(Target),'');

  if Random(g_Config.nMagicResistanceRate + 30) >= target.m_nAntiMagic then begin
    magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
    Target.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
  end;
end;

constructor TYimoogi.Create;
begin
  m_boFixedHideMode := True;
  inherited;
  m_boAnimal:=FALSE;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_dwThinkTick:=GetTickCount();
  m_dwSpellTick:=GetTickCount();
  m_dwPoisonTick:=GetTickCount();
  m_nViewRange := 15;
  m_boApproach:=FALSE;
  m_boActive:=False;
  m_boNoAttackMode := True;
end;

destructor TYimoogi.Destroy;
begin
  inherited;
  if m_CounterPart <> nil then begin
    if (m_CounterPart is TYimoogi) or (m_CounterPart is TYimoogiMaster) then begin
      TYimoogi(m_CounterPart).m_counterpart := nil;
    end;
  end;
end;

procedure TYimoogi.Die();
begin
  inherited;
  if m_CounterPart = nil then exit;
  if m_CounterPart is TYimoogiMaster then begin
    TYimoogiMaster(m_CounterPart).CallGuard;
    TYimoogiMaster(m_CounterPart).CloneDied;
  end else if m_CounterPart is TYimoogi then begin
    TYimoogiMaster(self).CallGuard;
    m_CounterPart.m_WAbil.HP := 0;
  end;
  TYimoogi(m_CounterPart).m_counterpart := nil;
  m_CounterPart := nil;
end;

procedure TYimoogi.Run;
var
  dist: integer;
begin
  if (CanPerformActions) then begin
    if  m_TargetCret <> nil then
      m_boActive := True;
    if m_CounterPart <> nil then begin //check if our counterpart is under attack
      if m_CounterPart.m_TargetCret <> nil then
        m_boActive := True;
    end;
    if m_boActive  then begin//if we are on active mode then we go hunting
      if (GetTickCount - m_dwThinkTick) > 5000 then begin
        m_dwThinkTick:=GetTickCount();
        SearchTarget;
        if m_TargetCret = nil then //if we hunted and there's still no target then go inactive
          m_boActive := False;
      end;
    end;
    if m_TargetCret <> nil then begin //if we have a target we walk, we kill it
{walking part}
      dist := 0;
      dist:=_Max(Abs(m_nCurrx - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
      if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin //check if we should walk closer or not and do it
        m_dwWalkTick:=GetTickCount();
        if dist > 6 then begin
          m_nTargetX:=m_TargetCret.m_nCurrX;
          m_nTargetY:=m_TargetCret.m_nCurrY;
          GotoTargetXY;
        end;
      end;
      m_btDirection := GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
{regular attack part}
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) and (dist <= 1) then begin
        //m_dwHitTick:=GetTickCount();
        attacktarget();
      end;
{ranged attack part}
      if (Integer(GetTickCount - m_dwHitTick) > (m_nNextHitTime * 2)) and (dist > 1) then begin
        m_dwHitTick:=GetTickCount();
        MagicAttack();
      end;
{red poison part} //random between 4 and 10 seconds
      if ((GetTickCount - m_dwPoisonTick) > (random(6)+4)*1000) then begin
        m_dwPoisonTick:=GetTickCount();
        m_dwHitTick:=GetTickCount();
        PoisonAttack;
        if (m_CounterPart <> nil) and (m_CounterPart is TYimoogi) then begin
          TYimoogi(m_CounterPart).m_dwPoisonTick := GetTickCount();
        end;
      end;
    end;
  end;
  inherited;
end;

procedure TYimoogi.MagicAttack();
var
magpwr:Integer;
begin
  SendAttackMsg(RM_HIT,SM_HIT,m_btDirection,m_nCurrX,m_nCurrY);
  if IsProperTarget (m_TargetCret) then begin
    m_TargetCret.SendDelayMsg(m_TargetCret,RM_10205,0,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,37{type},'',100);
    if Random(g_Config.nMagicResistanceRate) >= m_TargetCret.m_nAntiMagic then begin
      magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
    end;
  end;
end;

procedure TYimoogi.PoisonAttack();
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  i:Integer;
begin
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,15,xTargetList);
	if (xTargetList.Count>0) then begin
    SendRefMsg(RM_FLYAXE,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if IsProperTarget(BaseObject) then begin
        if Random(BaseObject.m_btAntiPoison + 5) <= 6 + 10 then
          BaseObject.SendDelayMsg(self,RM_POISON,POISON_DAMAGEARMOR,20,Integer(self),3,'',1000);
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;

constructor TYimoogiMaster.Create;
begin
  inherited;
  m_dwLastRecall := GetTickCount();
  m_dwCloneSpawn := 0;
  m_boEscaped := False;
end;

destructor TYimoogiMaster.Destroy;
begin
  inherited;
  m_dwLastRecall := GetTickCount();
end;

procedure TYimoogiMaster.Run;
var
  dist: integer;
  nx,ny: integer;
begin
  if (CanPerformActions) and
      (m_TargetCret <> nil) then begin
     if (m_dwCloneSpawn <> 0) and (GetTickCount - m_dwCloneSpawn > 500) then begin
      GetFrontPosition(nX,nY);
      m_CounterPart := UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,FilterShowName(m_sCharName) + '1');
      m_dwCloneSpawn := 0;
      if (m_CounterPart <> nil) AND (m_CounterPart is TYimoogi) then begin
        TYimoogi(m_CounterPart).m_counterpart := self;
        m_CounterPart.SetTargetCreat(m_TargetCret);
      end else
          //something wrong here cant spawn second yimoogi
     end;
     if (m_CounterPart = nil) and (GetTickCount - m_dwLastRecall > 10000) then begin
      m_dwLastRecall:= GetTickCount();
      //find the fake yimoogi on this map or spawn a new one
      m_CounterPart := FindYimoogi(FilterShowName(m_sCharName) + '1');
      if m_CounterPart = nil then begin //didnt find one on map so we're spawning one instead
        SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
        m_dwCloneSpawn:=GetTickCount;
      end;
    end;
  end;
  if not m_boFixedHideMode and
     not m_boStoneMode and
     (not m_boDeath) and (not m_boGhost) and
     (m_wStatusTimeArr[POISON_STONE] = 0) then begin
    if (not m_boEscaped) and (Round(m_WAbil.MaxHP div 20) > m_WAbil.Hp) then begin
      m_boEscaped := True;
      CallGuard;
      if (m_CounterPart <> nil) and (m_CounterPart is TYimoogi) and (m_CounterPart.m_WAbil.HP > 0) then
        TYimoogi(m_CounterPart).CloneDied;
      CloneDied;
    end;
    if m_boEscaped and (Round(m_WAbil.MaxHP div 10) < m_WAbil.Hp) then begin
      m_boEscaped := False;
    end;
    if  m_TargetCret <> nil then begin
      if m_CounterPart <> nil then begin
        dist := 0;
        dist:=_Max(Abs(m_nCurrx - m_CounterPart.m_nCurrX),Abs(m_nCurrY - m_CounterPart.m_nCurrY));
        GetFrontPosition(nX,nY);
        if (dist > 12) and (GetTickCount - m_dwLastRecall > 1000) then begin
          m_dwLastRecall:= GetTickCount();
          //somehow tell our other half that it needs to come to us
          m_CounterPart.SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
          m_CounterPart.SpaceMove(m_sMapName,nX,nY,0);
        end;
      end;
    end;
  end;
  inherited;
end;

function TYimoogiMaster.FindYimoogi(sname: String):TBaseObject;
var
  MonList:TList;
  I: integer;
  BaseObject:TBaseObject;
begin
  result:= nil;
  MonList:=TList.Create;
  UserEngine.GetMapMonster(m_PEnvir,MonList);
  for I := 0 to MonList.Count - 1 do begin
    BaseObject:=TBaseObject(MonList.Items[I]);
    if BaseObject.m_sCharName = sname then begin
      result:= BaseObject;
      break;
    end;
  end;
  MonList.Free;
end;

function TYimoogiMaster.GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;
var
  Envir:TEnvirnoment;
begin
  Envir:=m_PEnvir;
  nX:=m_nCurrX;
  nY:=m_nCurrY;
  case m_btDirection of    //
    DR_UP: begin
      if nY > 0 then Dec(nY,2);
    end;
    DR_UPRIGHT: begin
      if (nX < (Envir.m_nWidth -2)) and (nY > 0) then begin
       Inc(nX,2);
       Dec(nY,2);
      end;
    end;
    DR_RIGHT: begin
     if nX < (Envir.m_nWidth -2) then Inc(nX,2);
    end;
    DR_DOWNRIGHT: begin
      if (nX < (Envir.m_nWidth -2)) and (nY < (Envir.m_nHeight -2)) then begin
       Inc(nX,2);
       Inc(nY,2);
      end;
    end;
    DR_DOWN: begin
     if nY < (Envir.m_nHeight -2) then Inc(nY,2);
    end;
    DR_DOWNLEFT: begin
      if (nX > 0) and (nY < (Envir.m_nHeight -2)) then begin
       Dec(nX,2);
       Inc(nY,2);
      end;
    end;
    DR_LEFT: begin
      if nX > 0 then Dec(nX,2);
    end;
    DR_UPLEFT: begin
      if (nX > 0) and (nY > 0) then begin
        Dec(nX,2);
        Dec(nY,2);
      end;
    end;
  end;
  Result:=True;
end;

procedure TYimoogiMaster.CallGuard;
const
  sMonName:String = 'GuardianViper';
var
  n10,n14:Integer;
  BaseObject:TBaseObject;
begin
  GetFrontPosition(n10,n14);
  BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,n10,n14,sMonName);
  GetBackPosition(n10,n14);
  BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,n10,n14,sMonName);
end;

procedure TYimoogi.CloneDied();
begin
  m_TargetCret := nil;
  m_boActive := False;
  m_dwLastRecall := GetTickCount();
  SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
  MapRandomMove(m_sMapName,0);
end;

constructor TBoneLord.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_nViewRange:=8;
  m_btDirection:=5;
  m_nDangerLevel:=5;
  m_SlaveObjectList:=TList.Create;
  m_dwCallTick:=GetTickCount();
  m_dwDangerTick:=GetTickCount();
end;

destructor TBoneLord.Destroy;
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure TBoneLord.MagicAttack(nDir:Integer);
var
Target:TBaseObject;
magpwr:Integer;
begin
  if m_TargetCret =  nil then exit;
  Target:=m_TargetCret;
    sendrefmsg(RM_FLYAXE,nDir,m_nCurrx,m_nCurry,Integer(Target),'');

  {hit first target}
  if IsProperTarget(Target) then begin
    if Random(g_Config.nMagicResistanceRate) >= Target.m_nantiMagic then begin
      magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      Target.SendDelayMsg(self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
    end;
  end;
end;

procedure TBoneLord.CallSlave(nAttackDir: Integer);
const
  sMonName:array[0..3] of String = ('BoneCaptain', 'BoneArcher', 'BoneSpearman', 'BoneBladeMan');
var
  I: Integer;
  nC:Integer;
  n10,n14:Integer;
  BaseObject:TBaseObject;
begin
  nC:=Random(6) + 6;
  GetFrontPosition(n10,n14);

  m_btDirection := nAttackDir;
  Sendrefmsg(RM_LIGHTING,m_btDirection,m_nCurrx,m_nCurry,integer(self),''); //make him raise his staff

  for I := m_SlaveObjectList.Count - 1 downto 0 do begin
    BaseObject:=TBaseObject(m_SlaveObjectList.Items[I]);
    if (abs(m_nCurrX - BaseObject.m_nCurrX) > 14) or (abs(m_nCurrY - BaseObject.m_nCurrY) > 14) then //if our slaves are far summon them
      BaseObject.SpaceMove(m_PEnvir, n10, n14, 1);
  end;

  if m_SlaveObjectList.Count <= 30 then //gotta make sure he has room for extra slaves before he raises his staff lol
  for I := 1 to nC do begin
    if m_SlaveObjectList.Count >= 30 then break;
    BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,n10,n14,sMonName[Random(4)]);
    BaseObject.m_boCoolEye := True; //Summoned mobs have see through..
    if BaseObject <> nil then begin
      m_SlaveObjectList.Add(BaseObject);
    end;
  end;    // for
end;

procedure TBoneLord.Attack(TargeTBaseObject: TBaseObject;nDir: Integer);
var
  WAbil:pTAbility;
  nPower:Integer;
begin
  WAbil:=@m_WAbil;
  nPower:=GetAttackPower(LoWord(WAbil.DC),SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject,0,nPower,True);
end;

procedure TBoneLord.Run;
var
  I: Integer;
  BaseObject:TBaseObject;
  nAttackDir:Integer;
  ndist:integer;
  nError : integer;
begin
  nError := 0;
try

  //Stay vigilant on dead slaves, and remove if need to.
  for I := m_SlaveObjectList.Count - 1 downto 0 do begin
    BaseObject:=TBaseObject(m_SlaveObjectList.Items[I]);
    if (BaseObject = nil) or BaseObject.m_boDeath or BaseObject.m_boGhost or (BaseObject.m_PEnvir <> m_PEnvir){precaution} then
      m_SlaveObjectList.Delete(I);
  end;
  nError := 1;
  if (CanPerformActions) {and (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) //Why is this needed?} then begin
    nError := 2;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
    (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
    nError := 3;
    if (m_TargetCret <> nil) then begin
      nError := 4;
      GetMapFollowObject(15); //mobs will follow from 15 places aways.
      nError := 5;
      if IsProperTarget(m_TargetCret) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime * 3) then begin
        nDist:=_Max(abs(m_nCurrX - m_TargetCret.m_nCurrx),abs(m_nCurry - m_TargetCret.m_nCurry));
        if (nDist > 1) {and MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret)} then begin //No longer constrained by walls :P
          nAttackDir:=GetNextDirection(m_nCurrx,m_nCurry,m_TargetCret.m_nCurrx,m_TargetCret.m_nCurry);
          m_dwHitTick:=GetTickCount();
          nError := 6;
          MagicAttack(nAttackDir);
        end;
      end;
      nError := 7;
      if IsProperTarget(m_TargetCret) and
        (Integer(GetTickCount - m_dwCallTick) > 15000) then begin
        if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then begin
          m_dwCallTick:=GetTickCount();
          m_dwHitTick:=GetTickCount();
          Dec(m_nDangerLevel);
          nError := 8;
          nAttackDir:=GetNextDirection(m_nCurrx,m_nCurry,m_TargetCret.m_nCurrx,m_TargetCret.m_nCurry);
          CallSlave(nAttackDir);
        end;
      end;
      nError := 8;
      //If target is over 2 spaces away then we decide if we should follow
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 2) or (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 2) then begin
        //Hes still under my range so we dont need to walk..
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 10) then begin
          if (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
            m_dwWalkTick := GetTickCount();
            m_nTargetX := m_nCurrX;
            m_nTargetY := m_nCurrY;
          end;
        end;
      end;

    end; //Target End
    nError := 9;
    //If he has Max HP then hes dangerous. :P
    if m_WAbil.HP = m_WAbil.MaxHP then
      m_nDangerLevel:=5;

    //When hes below Danger Level 3 start increasing Danger Level again, more danger and lower hp = more mob spawns.
    if (Integer(GetTickCount - m_dwDangerTick) >= (60000 * 4)) and (m_nDangerLevel < 3) then begin
     Inc(m_nDangerLevel,1);
     m_dwDangerTick := GetTickCount();
    end;
    nError := 10;
  end;
  nError := 11;
  inherited;
except
  MainOutMessage('BoneLord Error code: ' + inttostr(nError));

end;
end;

constructor TMinoGuard.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwHitTick:=GetTickCount();
  m_nViewRange   := 13;
end;

destructor TMinoGuard.Destroy;
begin
  inherited;
end;

procedure TMinoGuard.MagicAttack(nDir:Integer);
var
Target:TBaseObject;
magpwr:Integer;
begin
  if m_TargetCret = nil then exit;
  Target:=m_TargetCret;

  SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(Target),'');

  if m_btRaceImg = 117 then begin //Rabbit Carrot
    SendRefMsg(RM_MONMAGIC, 8, Integer(m_TargetCret), m_nCurrX, m_nCurrY, '', 600);
  end;

  {Hit first Target}
  if IsProperTarget (Target) then begin
   if Random(g_Config.nMagicResistanceRate) >= Target.m_nAntiMagic then begin
     magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
     Target.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
     if m_btRaceImg = 131 then begin//stone griffin para
       if Random(20) = 0 then
         Target.MakePosion(POISON_STONE,5,0);
     end;
     if m_btRaceImg = 139 then begin//iceguardian freeze
       if Random(20) = 0 then
         Target.MakePosion(POISON_FREEZE,5,0);
     end;
   end;
  end;
end;

procedure TMinoGuard.Run;
var
nAttackDir:integer;
nDistx,nDisty:integer;
begin
  if (CanPerformActions) then begin

    if (m_TargetCret <> nil) then begin
      nDistx:= abs(m_nCurrX - m_TargetCret.m_nCurrX);
      nDisty:=abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if (_Max(nDistx,nDistY) > 2) and (_max(nDistx,nDisty) < 10) and
       (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        if (MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret)) or (m_btRaceImg <> 70) then begin //make sure the 'line' in wich magic will go isnt blocked
          m_dwHitTick:=GetTickCount();
          nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
          MagicAttack(nAttackDir);
        end;
       end;
     end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;


function TMinotaurKing.AttackTarget: Boolean;
  function CheckViewRange(Targe: TBaseObject; nViewRange: Integer): Boolean;
  begin
    Result := False;
    if (Targe <> nil) and (abs(m_nCurrX - Targe.m_nCurrX) <= nViewRange) and (abs(m_nCurrY - Targe.m_nCurrY) <= nViewRange) then
      Result := True;
  end;
var
  nPower, nX, nY, nDir, target_distance_x, target_distance_y: Integer;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    if CheckViewRange(m_TargetCret, m_nViewRange) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        target_distance_x := abs(m_nCurrX - m_TargetCret.m_nCurrX);
        target_distance_y := abs(m_nCurrY - m_TargetCret.m_nCurrY);
        m_btDirection := nDir;
        if (_Max(target_distance_x, target_distance_y) = 1) then begin
          nPower := (HiWord(m_WAbil.DC) div 2) + Random(HiWord(m_WAbil.DC) div 2);
          if nPower > 0 then begin
            SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
            m_TargetCret.StruckDamage(nPower, Self);
            m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 100);
          end;
        end else begin
          RedCircle(nDir);
        end;
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        BreakHolySeizeMode();
      end;
      Result := True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
      end
      else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

constructor TMinotaurKing.Create;
begin
  inherited;
  m_nViewRange := 8;
end;

destructor TMinotaurKing.Destroy;
begin

  inherited;
end;

procedure TMinotaurKing.RecalcAbilitys;
begin
  inherited;
end;

procedure TMinotaurKing.Run;
begin
  inherited;
end;

procedure TMinotaurKing.RedCircle(nDir:Integer);
var
  I:Integer;
  magpwr:Integer;
  BaseObject:TBaseObject;
begin
 m_btDirection:=nDir;

 SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  for i:=0 to m_TargetCret.m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseOBject (pTVisibleBaseObject(m_TargetCret.m_VisibleActors[i]).BaseObject);
    if (abs(m_TargetCret.m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(m_TargetCret.m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin
      if BaseObject <> nil then begin
        if IsProperTarget (BaseObject) then begin
          if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
            magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
          end;
        end;
      end;
     end;
  end;
end;

constructor TNodeMonster.Create;
begin
  inherited;
  m_boAnimal:=False;
  m_boStickMode := True;
end;

destructor TNodeMonster.Destroy;
begin
  inherited;
end;

procedure TNodeMonster.Run;
begin
  if (not m_boDeath) and (not m_boGhost) then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 18000) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      Search();
    end;
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick:=GetTickCount();
      SendRefMsg(RM_TURN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    end;
  end;
  inherited;
end;

procedure TNodeMonster.Search(); //find all the 'allies' (aka other mobs) nearby
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  i:Integer;
begin
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,12,xTargetList);
	if (xTargetList.Count>0) then begin
    SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);
      if (BaseObject<>nil) then begin
        if not BaseObject.m_boGhost and not BaseObject.m_boDeath and (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) then begin //basicaly if it's not a player then we shield it (even if it's an npc :p)
          CastShield(BaseObject)
        end;
      end;
      xTargetList.Delete(i);
    end;
	end;
  xTargetList.Free;
end;

procedure TNodeMonster.CastShield(BaseObject: TBaseObject);//give our friend his shield
var
  nSec:integer;
begin
  nSec:=20;//set it to 20 seconds 'shield' since the search is only done every 18seconds this means the shield lasts forever technicaly (provided mob stays in range)
  if m_btRaceImg = 75 then begin  //red one: give dc
    BaseObject.AttPowerUp(m_WAbil.MC,nsec)
  end else begin           //blue one: give ac+amc
    BaseObject.DefenceUp(nSec);
    BaseObject.MagDefenceUp(nSec);
  end;
end;

constructor TOmaKing.Create;
begin
  inherited;
  ldistx:=0;
  ldisty:=0;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwSpellTick:=GetTickCount();
  m_boAnimal:=False;
  m_nViewRange := 11;
end;

destructor TOmaKing.Destroy;
begin
  inherited;
end;

procedure TOmaKing.Run;
var
  distx,disty:integer;
begin
  if not m_boFixedHideMode and
     (CanPerformActions) then begin
//walk codes next (since ok doesnt go near players like other mobs do this is hopefully a correct code)
  if (m_TargetCret <> nil) then begin
    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin //check if we should walk closer or not and do it :p
      m_dwWalkTick:=GetTickCount();
      distx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
      disty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if (distx > ldistx) or (disty > ldisty) or (distx > 5) or (disty > 5) then begin //if the last distance from us is further then the current (aka if they running)
        if ((distx > 2) or (disty > 2)) and ((distx < 12) and (disty < 12)) then begin //restrict the maximum pursuit distance to 12 coords away
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          GotoTargetXY;
          ldistx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
          ldisty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
          exit;
        end;
      end;

      ldistx :=distx;
      ldisty :=disty;
    end;
  end;
//regular attack code
  if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) and
   (Integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime) and
   (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2)
     and ((abs(m_nCurrY - m_TargetCret.m_nCurrY) + abs(m_nCurrX - m_TargetCret.m_nCurrX)) <= 3) then begin
    m_dwHitTick:=GetTickCount();
    if( Random(8) = 0) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1)and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin //10% chance he just attacks)
      attacktarget(); //no point trying to hit something that isnt close enough :p
    end else //does repulse
      RepulseCircle();
  end;

//magic attack code
  if (m_TargetCret <> nil) and
       (Integer(GetTickCount - m_dwSpellTick) > 6400) then begin
        m_dwSpellTick:=GetTickCount();
        BlueCircle();
     end;

//search for targets nearbye
  if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
  end;
  end;
  inherited;
end;

procedure TOmaKing.BlueCircle();
var
  I:Integer;
  magpwr:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
  nDir:integer;
begin
//target selected
 Target := m_TargetCret;
 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  m_btDirection:=nDir;

  if m_VisibleActors.Count > 0 then
    SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(self),'');

 for i:=0 to m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
   if (abs(m_nCurrX-BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= m_nViewRange) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
          WAbil:=@m_WAbil;
          magpwr:=(baseobject.m_WAbil.MaxHP * HiWord(WAbil.MC)) div 100;
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
          if Random(7) = 0 then
            BaseObject.MakePosion(POISON_STONE,5,0);
        end;
      end;
    end;
   end;
  end;
end;


procedure TOmaKing.RepulseCircle();
var
  I:Integer;
  BaseObject:TBaseObject;
  nDir:Byte;
  push:integer;
begin

 {do spell effect}

 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
 m_btDirection:=nDir;
 SendAttackMsg(RM_hit,SM_HIT,nDir,m_nCurrX,m_nCurrY);


 {do repule radius around 'ourself'}
 for i:=0 to m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
   if (abs(m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= 2)
    and ((abs(m_nCurrY - m_TargetCret.m_nCurrY) + abs(m_nCurrX - m_TargetCret.m_nCurrX)) <= 3) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
          push := 1 + Random(3);
          nDir:= GetNextDirection (m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
          BaseObject.CharPushed (nDir, push);
        end;
      end;
    end;
   end;
  end;
end;

function TOmaKing.AttackTarget():Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime  then begin
        m_dwHitTick:=GetTickCount();
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);  //FFED
      end;
      Result:=True;
    end;
  end;
end;

{TOMAKINGSPIRIT}

{constructor TOmaKingSpirit.Create();
begin
  inherited;
  m_dwSpellTick:=GetTickCount();
  m_dwRecruitTick:=GetTickCount();
  m_nViewRange := 12;
end;

procedure TOmaKingSpirit.Run;
begin
  //Search for enemys
  if ((GetTickCount - m_dwSearchEnemyTick) > 10000) or
     (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
    m_dwSearchEnemyTick:=GetTickCount();
    SearchTarget();
  end;

  if ((GetTickCount - m_dwRecruitTick) > 60 * 1000) then begin
    m_dwRecruitTick := GetTickCount();
    GetMapFollowObject(20); //mobs will follow from 20 places aways.
  end;

  if not m_boFixedHideMode and
    (CanPerformActions) then begin

    //Attacks
    if (m_TargetCret <> nil) and IsProperTarget(m_TargetCret) then begin
      if (integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime * 3) and
        (integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_dwSpellTick := GetTickCount();
        m_dwHitTick := GetTickCount();
        m_dwWalkTick := GetTickCount();

        MagicAttack();  //MagicAttack
      end else begin
        AttackTarget(); //Normal Attack
      end;
    end;

  end;
  inherited;
end;

procedure TOmaKingSpirit.MagicAttack();
var
  I:Integer;
  magpwr:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
  nDir:integer;
begin
//target selected
  Target := m_TargetCret;
  nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  m_btDirection:=nDir;

  if m_VisibleActors.Count > 0 then
    SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(self),'');

  for i:=0 to m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
      if (abs(m_nCurrX-BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= m_nViewRange) then begin

      if BaseObject <> nil then begin
        if IsProperTarget (BaseObject) then begin
          if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
            WAbil:=@m_WAbil;
            magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
            //if target is firther away then do more damage.
            if (abs(m_nCurrX-BaseObject.m_nCurrX) >= 3) and (abs(m_nCurrY-BaseObject.m_nCurrY) >= 3) then
              magpwr := round(magpwr * 1.3);

            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
          end;
        end;
      end;
    end;
  end;
end;

function TOmaKingSpirit.AttackTarget():Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime  then begin
        m_dwHitTick:=GetTickCount();
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);  //FFED
        if Random(5) = 0 then begin
          m_TargetCret.MakePosion(POISON_STUN, 7, 0);
          m_TargetCret.SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 34, '');
        end;
      end;
      Result:=True;
    end;
  end;
end;}

procedure TDragonStatue.Initialize;
begin
  if (m_PEnvir <> nil) and m_PEnvir.m_boFB then begin
    m_boStoneMode := False;
    m_nCharStatusEx := 0;
    m_nCharStatus := GetCharStatus();
  end;
  inherited;
end;

constructor TDragonStatue.Create;
begin
  inherited;
  m_nViewRange:=20;
  m_boAnimal:=False;
  m_boStoneMode := True;
  m_boStickMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
end;

destructor TDragonStatue.Destroy;
begin

  inherited;
end;

procedure TDragonStatue.MeltStone;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
end;

procedure TDragonStatue.MeltStoneAll;
var
  I: Integer;
  List10: TList;
  BaseObject: TBaseObject;
begin
  MeltStone();
  List10 := TList.Create;
  GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 7, List10);
  for I := 0 to List10.Count - 1 do begin
    BaseObject := TBaseObject(List10.Items[I]);
    if BaseObject <> nil then begin
      if BaseObject.m_boStoneMode then begin
        if BaseObject is TScultureMonster then begin
          TDragonStatue(BaseObject).MeltStone
        end;
      end;
    end;
  end; // for
  List10.Free;
end;

procedure TDragonStatue.Run;
var
  i: Integer;
  BaseObject: TBaseObject;
begin
try
  if (not m_boGhost) and (not m_boDeath) and
    (m_wStatusTimeArr[POISON_STONE] = 0) and
    (m_wStatusTimeArr[POISON_FREEZE] = 0) then begin

    if m_boStoneMode then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.IsHidden or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 4) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 4) then begin
              MeltStoneAll();
              break;
            end;
          end;
        end;
      end;
    end else begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;

      if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 12) then begin
        m_dwHitTick:=GetTickCount();
        FireBang();
      end;
    end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('DragonStatue process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TDragonStatue.FireBang();
var
  I:Integer;
  magpwr:Integer;
  BaseObject:TBaseObject;
  Target:TBaseObject;
begin
 Target := m_TargetCret;

 SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(Target),'');

 for i:=0 to Target.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
          magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
        end;
      end;
    end;
   end;
  end;
end;

constructor TEvilMir.Create;
begin
  inherited;
  m_dwSpellTick:=GetTickCount();
  m_boAnimal:=False;
  m_SlaveObjectList:=TList.Create;
  boSpawn:=False;
  m_nViewRange:=25;
  m_boInvincable := true;
  m_boKillSlaves := False;
  m_nEvilMirKillCount := 0;
  m_dwEvilMirKillTime := GetTickCount();
  m_boInactive := False;
  m_dwInactiveTime := GetTickCount();
  m_boStickMode := True;
 // m_dwRespawnTime := 180; //default incase you @mob evilmir
end;

destructor TEvilMir.Destroy;
begin
  inherited;
end;

procedure TEvilMir.Run;
var
  nDir:Byte;
begin
try
  if boSpawn = FALSE then begin //if we dont have slaves already make them
    boSpawn:= TRUE;
    callslaves();
  end;

  if (m_boKillSlaves) then begin
    if (m_TargetCret <> nil) and (CanPerformActions) then
      MassThunder();
    KillSlaves(True);
  end;

  if m_boInactive then
    m_WAbil.HP := m_WAbil.MaxHP;

  if (Integer(GetTickCount - m_dwInactiveTime) >= m_dwRespawnTime) then begin
    if m_boInactive then begin //respawn code
      m_dwInactiveTime := GetTickCount;
      m_boInactive := False;
      m_nEvilMirKillCount := 0;
      KillSlaves(False);
    end;
  end;

  if not m_boInactive then
    m_dwInactiveTime := GetTickCount;

  if (CanPerformActions) and not m_boInactive and
  not m_boFixedHideMode then begin
     //delevel code
    if (m_TargetCret = nil) and (Integer(GetTickCount - m_dwEvilMirKillTime) >= 18000) and (m_nEvilMirKillCount > 0) then begin
      m_dwEvilMirKillTime := GetTickCount;
      SearchTarget();
      if m_TargetCret = nil then begin
        Dec(m_nEvilMirKillCount);
        KillSlaves(False);
      end;
    end else if (m_nEvilMirKillCount = 0) then
      m_dwEvilMirKillTime := GetTickCount;

    if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > 3500) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 15) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 15) then begin
      m_dwHitTick:=GetTickCount();
      nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      FlameCircle(nDir);
    end;
    if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwSpellTick) > (90000 - _Min(70000, 10000 * m_nEvilMirKillCount))) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      MassThunder;
    end;
    //search for targets nearby
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
   end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('Evilmir process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TEvilMir.CallSlaves();
const
  sMonXY:array[0..41,0..1] of Integer =
   ((0, -5), (1, -5), (-1, -4), (0, -4),
  (1, -4), (2, -4), (-2, -3), (-1, -3),
  (0, -3), (1, -3), (2, -3),  (-3, -2),
  (-2, -2),(-1, -3),(0, -2),  (1, -2),
  (2, -2), (-3, -1),(-2, -1), (-1, -1),
  (0, -1), (1, -1), (2, -1),  (-3, 0),
  (-2, 0), (-1, 0), (0, 0),   (1, 0),
  (2, 0),  (3, 0),  (-2, 1),  (-1, 1),
  (0, 1),  (1, 1),  (2, 1),   (3, 1),
  (-1, 2), (0, 2),  (1, 2),   (2, 2),
  (0, 3),  (1, 3)
  );
var
  I: Integer;
  nxOffset,nyOffset, slave_level:Integer;
  BaseObject:TBaseObject;
  nerror:integer;
begin
  nerror:=0;
try
  nxOffset:=0;
  nyOffset:=0;
  for I := 1 to Length(sMonxy) do begin
    nerror:=1;
    nxOffset:= sMonxy[i,0];
    nyOffset:= sMonxy[i,1];
    if (nxOffset = 0) and (nyOffset = 0) then continue;
    nerror:=2;

    BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,(m_nCurrX + nxoffset) ,(m_nCurrY + nyOffset),m_sCharName + '(' + '1' + ')');//sMonName[slave_level]);//_Min(nEMKills div nmultiplyer,(Length(sMonName) -1))]);
    nerror:=3;
    if (BaseObject <> nil) and (BaseObject is TDragonPart) then begin
      nerror:=4;
      TDragonPart(BaseObject).m_Owner:=self;
      m_SlaveObjectList.Add(BaseObject);
      nerror:=5;
    end;
  end;
except
  on e: Exception do begin
    MainOutMessage('Evilmir callslaves Error: ' + inttostr(nerror));
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TEvilMir.KillSlaves(boDrop: Boolean);
const
  sMonName:array[0..5] of String = ('1', '2', '3', '4', '5', '6');//basicaly by adding to this you can make new 'slaves' that drop better
var
  i: integer;
  slave_object: TBaseObject;
  slave_level: Integer;
begin
  for i := m_SlaveObjectList.Count - 1 downto 0 do begin
    if m_SlaveObjectList.Count <= 0 then
      break;
    slave_object := TBaseObject(m_SlaveObjectList[i]);

    //If we killed EvilMir through the slaves and not the main mob then make slave killer EvilMirs killer..
    //This makes sure we get a drop at least.
    if (m_exphitter = nil) and (slave_object.m_exphitter <> nil) then
      m_exphitter := slave_object.m_exphitter;

    if (slave_object.m_CanDropItemList <> nil) and (boDrop) then begin
      UserEngine.MonGetRandomItems(slave_object, slave_object.m_CanDropItemList);
      if (m_exphitter <> nil)  then begin

        slave_object.m_nMoveDropX := 5;
        slave_object.m_nMoveDropY := 6;
        slave_object.ScatterBagItems(m_exphitter);
      end;
    end;

    slave_level := m_nEvilMirKillCount;
    if slave_level >= Length(sMonName) - 1 then
      slave_level := Length(sMonName) - 1;

    slave_object.m_sCharName := m_sCharName + '(' + sMonName[slave_level] + ')';
    slave_object.m_CanDropItemList := UserEngine.MonInitialize(slave_object, slave_object.m_sCharName);
    m_boKillSlaves := False;
  end;
end;

procedure TEvilMir.FlameCircle(nDir:Integer);
var
  I:Integer;
  magpwr:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
begin
 Target := m_TargetCret;

 m_btDirection := nDir;

 SendRefMsg(RM_LIGHTING, m_btDirection, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');

 for i:=0 to Target.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 2) then begin

    if (BaseObject <> nil) and not (BaseObject is TDragonPart) then begin
      if IsProperTarget (BaseObject) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        WAbil:=@m_WAbil;
        magpwr:=Random((HiWord(WAbil.MC) div 5) * m_nEvilMirKillCount) +  Random(HiWord(WAbil.MC));
        BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
      end;
    end;
   end;
  end;
end;

procedure TEvilMir.MassThunder();
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  WAbil:pTAbility;
  magpwr:Integer;
  i:Integer;
begin
  m_dwSpellTick:=GetTickCount();
  SendAttackMsg(RM_hit, SM_HIT,0,m_nCurrX,m_nCurrY);//make client show random tbolting;
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,14,xTargetList);

	if (xTargetList.Count>0) then begin
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if IsProperTarget(BaseObject) then begin
         WAbil:=@m_WAbil;
          magpwr:=Random((HiWord(WAbil.SC) div 5) * m_nEvilMirKillCount) + Random(HiWord(WAbil.SC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;

function TEvilMir.Operate(ProcessMsg:pTProcessMessage):boolean;
begin
  if (ProcessMsg.wIdent = RM_POISON) then begin
    massthunder();
  end;
  Result:=inherited Operate(ProcessMsg);
end;

procedure TEvilMir.Die;
begin
  if m_nEvilMirKillCount < 6 then
    inc(m_nEvilMirKillCount);
  if m_nEvilMirKillCount >= 6 then
    m_boInactive := True;
  m_WAbil.Hp := m_WAbil.MaxHp;
  m_boKillSlaves := True;
  inherited;
end;

constructor TDragonPart.Create;
begin
  inherited;
  m_boAnimal:=FALSE;
  m_dwHitTick:=0;
  m_nViewRange:=15;
  m_boStickMode := True;
end;

destructor TDragonPart.Destroy;
begin
  inherited;
end;

procedure TDragonPart.Run();
begin
  if (m_Owner <> nil) and not m_boDeath and not m_Owner.m_boDeath then
    m_WAbil.Hp := m_WAbil.MaxHp;
  inherited;
end;

procedure TDragonPart.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  nDamage := 1;
  if m_Owner <> nil then
    if not m_Owner.m_boInactive then
      m_Owner.StruckDamage(nDamage, AttackBase);
  exit;
end;

function  TDragonPart.GetMagStruckDamage(BaseObject:TBaseObject;nDamage:Integer):Integer;
begin
  nDamage := 1;
  if m_Owner <> nil then
    if not m_Owner.m_boInactive then begin
      m_Owner.GetMagStruckDamage(BaseObject, nDamage);
      nDamage := 0;
    end;
  result:=nDamage;
end;

constructor TBlackFoxMan.Create;
begin
  inherited;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
end;

destructor TBlackFoxMan.Destroy;
begin
  inherited;
end;

procedure TBlackFoxMan.Run();
var
  boThrust : boolean;
  nX,nY    : integer;
  BaseObject: TBaseobject;
begin
try
  boThrust := False;
  if not m_boFixedHideMode and
     CanPerformActions then begin
      if m_TargetCret <> nil then begin
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime - 50) then begin
        //only check if we need to thrust after we nearly ready to do next hit
          m_btDirection := GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,2,nX,nY) then begin
            BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
            if BaseObject <> nil then begin
              if IsProperTarget(BaseObject) then begin
                boThrust := True; //if there's a target (doesnt matter if it's our main one or not 2 spots away hit it with thrust)
              end;
            end;
          end;
          if not BoThrust and (Random(5) = 1) and (Abs(m_TargetCret.m_nCurrX - m_nCurrX) in [0,1] ) and  (Abs(m_TargetCret.m_nCurrY - m_nCurrY) In [0,1]) then
            boThrust := True;
          if boThrust then begin //do thrust attack instead of regular
            m_dwHitTick:=GetTickCount();
            ThrustAttack();
          end;
        end;
      end;
      //search for targets nearbye
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('BlackFoxMan process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TBlackFoxMan.ThrustAttack();
var
  nhitmode:word;
begin
  nhitmode := 4;
  _Attack(nhitmode,m_TargetCret);
  SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
end;

procedure TRangedmon.Run();
var
  dist:integer;
  nDir:byte;
begin
try
  if not m_boFixedHideMode and
     CanPerformActions and (m_TargetCret <> nil) then begin
     if m_boWalkWaitLocked then begin
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked:=False;
      end;
    end;
    if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
      m_dwWalkTick:=GetTickCount();
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then begin
        m_nWalkCount:=0;
        m_boWalkWaitLocked:=True;
        m_dwWalkWaitTick:=GetTickCount();
      end;
      dist:=_Max(Abs(m_nCurrX - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
      if dist > 10 then begin //if we are to far: go closer
        m_nTargetX:=m_TargetCret.m_nCurrX;
        m_nTargetY:=m_TargetCret.m_nCurrY;
        GotoTargetXY;
      end else if dist < 9 then begin //if we are to close: go further
        if Random(5) = 0 then begin
          nDir:=GetNextDirection(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,m_nCurrX,m_nCurrY);
          m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDir,5,m_nTargetX,m_nTargetY);
          GotoTargetXY;
        end;
      end;
    end;
  end;
  if not m_boFixedHideMode and
     CanPerformActions then begin
    //search for targets nearbye
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('Ranged Mon process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

constructor TRedFoxMan.Create;
begin
  inherited;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_dwLastMove:=GetTickCount();
  m_boApproach:=FALSE;
  m_boNoAttackMode := TRUE;
  m_nViewRange := 14;
end;

destructor TRedFoxMan.Destroy;
begin
  inherited;
end;

procedure TRedFoxMan.Run();
begin
try
  if not m_boFixedHideMode and
     CanPerformActions and (m_TargetCret <> nil) then begin
    if _Max(Abs(m_TargetCret.m_nCurrX - m_nCurrX),Abs(m_TargetCret.m_nCurrY - m_nCurrY)) < 11 then begin
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_dwHitTick := GetTickCount();
        if Random(3) > 0 then begin
          ThunderAttack();
        end else
          FlameAttack();
      end;
    end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('RedFoxMan process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

function TRedFoxMan.Operate(ProcessMsg:pTProcessMessage):boolean;
begin
  if ProcessMsg.wIdent = RM_10101 then begin
    if Random(3)=0 then
      RandomMove();
  end;
   inherited Operate(ProcessMsg);
end;

procedure TRedFoxMan.ThunderAttack();
var
  magpwr:Integer;
  WAbil:pTAbility;
begin
 m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
 {do spell effect}
 SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
 if IsProperTarget (m_TargetCret) then begin
   if Random(g_Config.nMagicResistanceRate) >= m_TargetCret.m_nAntiMagic then begin
     WAbil:=@m_WAbil;
     magpwr:=(Random(SmallInt(Max(0,HiWord(WAbil.DC) - LoWord(WAbil.DC))) + 1) + LoWord(WAbil.DC));
     m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
   end;
 end;
end;

procedure TRedFoxMan.FlameAttack();
var
  I:Integer;
  magpwr:Integer;
  BaseObject:TBaseObject;
begin
 m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
 {do spell effect}
 SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);

  for i:=0 to m_TargetCret.m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(m_TargetCret.m_VisibleActors[i]).BaseObject);
    if (abs(m_TargetCret.m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(m_TargetCret.m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin
      if BaseObject <> nil then begin
        if IsProperTarget (BaseObject) then begin
          if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
            magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
          end;
        end;
      end;
     end;
  end;
end;

procedure TRedFoxMan.RandomMove();
var
  nX,nY,count,Count2:integer;
begin
  if (GetTickCount - m_dwLastMove) < 500 then exit;
  if m_boGhost or m_boDeath then exit;
  m_dwLastMove:=GetTickCount();
  Count2 :=0;
  while not m_PEnvir.CanWalk(nX,nY,True) and (Count2 <= 10) do begin
    nX := -1;
    Count:=0;
    while ((nX < 0) or (nX > m_PEnvir.m_nWidth)) and (count <= 10) do begin
      nX:=Random(10);
      nX:= m_nCurrX - 5 + nX;
      inc(Count);
    end;
    nY := -1;
    Count:=0;
    while ((nY < 0) or (nY > m_PEnvir.m_nHeight)) and (count <= 10) do begin
      nY:=Random(10);
      nY:= m_nCurrY - 5 + nY;
      inc(Count);
    end;
    inc(Count2);
  end;

  SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
  SpaceMove(m_sMapName,nX,nY,0);
end;

constructor TWhiteFoxMan.Create;
begin
  inherited;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_dwLastMove:=GetTickCount();
  m_boApproach:=FALSE;
  m_boNoAttackMode := TRUE;
  m_nViewRange := 14;
end;

destructor TWhiteFoxMan.Destroy;
begin
  inherited;
end;

procedure TWhiteFoxMan.Run();
begin
try
  if not m_boFixedHideMode and
     CanPerformActions and (m_TargetCret <> nil) then begin
    if _Max(Abs(m_TargetCret.m_nCurrX - m_nCurrX),Abs(m_TargetCret.m_nCurrY - m_nCurrY)) < 11 then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime  then begin
        m_dwHitTick := GetTickCount();
        if random(10) = 0 then begin
          SummonShinsu();
        end else if Random(10) > 0 then begin
          SoulFireBall();
        end else
          Curse();
      end;
    end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('WhiteFoxMan process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TWhiteFoxMan.summonshinsu();
var
  dwRoyaltySec:LongWord;
  sMonName:String;
begin
  if m_SlaveList.Count > 0 then exit;
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  sMonName:=g_Config.sDogz;
  dwRoyaltySec:=10 * 24 * 60 * 60;
  MakeSlave(sMonName,4,0,1,-1,dwRoyaltySec);
end;

procedure TWhiteFoxMan.soulfireball();
var
  magpwr:Integer;
  WAbil:pTAbility;
begin
  m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
  {do spell effect}
  SendRefMsg(RM_FLYAXE,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  if (MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret)) then begin //make sure the 'line' in wich magic will go isnt blocked
    if IsProperTarget (m_targetCret) then begin
      if Random(g_Config.nMagicResistanceRate) >= m_targetCret.m_nAntiMagic then begin
       WAbil:=@m_WAbil;
       magpwr:=(Random(SmallInt(HiWord(Max(0,WAbil.DC) - LoWord(WAbil.DC))) + 1) + LoWord(WAbil.DC));
       m_targetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
      end;
    end;
  end;
end;

procedure TWhiteFoxMan.curse();
var
  magpwr:Integer;
begin
  m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
  {do spell effect}
  if IsProperTarget (m_targetCret) then begin
  SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
  self.MagDebuffArea(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3, 3, magpwr, 10, 0)
  end;
end;

constructor TElement.Create;
begin
  inherited;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_dwSpellTick:=GetTickCount();
  ncloudrange := 2;
  m_boApproach:=FALSE;
  m_boNoAttackMode := TRUE;
  m_boUsePoison := False;
  m_nPushCount := 0;
end;

destructor TElement.Destroy;
begin
  inherited;
end;

procedure TElement.Run;
begin
try
  if (m_boNextTurnDie or (m_WAbil.HP = 0)) and not m_boDeath then
    die();
  if not m_boDeath then
    m_WAbil.HP := m_WAbil.MaxHP;
  if CanPerformActions then begin
    if m_TargetCret <> nil then begin
      if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin //check if we should walk closer or not and do it :p
        m_dwWalkTick:=GetTickCount();
        m_nTargetX:=m_TargetCret.m_nCurrX;
        m_nTargetY:=m_TargetCret.m_nCurry;
        GotoTargetXY();
      end;
      if ((GetTickCount - m_dwSpellTick) > m_nNextHitTime) then begin
        if (abs(m_TargetCret.m_nCurrX-m_nCurrX) <= ncloudrange) or (abs(m_TargetCret.m_nCurrY-m_nCurry) <= ncloudrange) then begin
          m_dwSpellTick:=GetTickCount();
          ThunderStorm();
        end;
      end;
    end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('Element process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

function  TElement.CharPushed(nDir,nPushCount:Integer): Integer;
begin
  inc(m_nPushCount);
  if m_nPushCount = m_WAbil.MaxHP then m_boNextTurnDie:=True;
  inherited CharPushed(nDir,nPushCount);
end;

procedure TElement.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  nDamage:=0;
  inherited StruckDamage(nDamage,AttackBase);
end;

procedure TElement.Thunderstorm();
var
  I:Integer;
  magpwr:Integer;
  BaseObject:TBaseObject;
begin
 m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);;
 {do spell effect}
 SendRefMsg(RM_LIGHTING,0,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  for i:=0 to m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
    if (abs(m_nCurrX-BaseObject.m_nCurrX) <= ncloudrange) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= ncloudrange) then begin
      if BaseObject <> nil then begin
        if IsProperTarget (BaseObject) then begin
          if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
            magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
            if m_boUsePoison and (Random(BaseObject.m_btAntiPoison + 7) <= 6 + 0) and (BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then begin
              BaseObject.SendMsg(self,RM_POISON,POISON_DECHEALTH,30,Integer(self),1,'');
            end;
          end;
        end;
      end;
     end;
  end;
end;

constructor TBigElement.Create;
begin
  inherited;
  ncloudrange := 3;
  m_boUsePoison := True;
end;

destructor TBigElement.Destroy;
begin
  inherited;
end;

constructor TBigNonPsnElement.Create;
begin
  inherited;
  ncloudrange := 3;
  m_boUsePoison := False;
end;

destructor TBigNonPsnElement.Destroy;
begin
  inherited;
end;

constructor TTrapPart.Create;
begin
  inherited;
  m_boNoAttackMode := TRUE;
  m_boFixedHideMode:=True;
  m_MasterRock :=nil;
  m_boNextRoundDie := False;
  m_boStickMode := True;
end;

destructor TTrapPart.Destroy;
begin
  inherited;
end;

procedure TTrapPart.AllComeOut(m_LockTarget2:TBaseObject);
begin
  m_LockTarget := m_LockTarget2;
  m_boFixedHideMode:=False;
  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TTrapPart.Run;
var
  dist:integer;
begin
  if (m_boNextRoundDie) and not m_boGhost and not m_boDeath then begin
    if not (self is TTrapRock) then begin
      m_ExpHitter := nil;
      m_LastHiter := nil;
    end;
    Die();
  end;

  if not m_boStoneMode and
  (not m_boDeath) and (not m_boGhost) and
  (m_wStatusTimeArr[POISON_STONE] = 0) and
  (not m_boFixedHideMode) and
  (m_LockTarget <> nil) then begin
    if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
      m_dwHitTick := GetTickCount();

    end;
  end;
  inherited
end;

procedure TTrapPart.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  if (m_MasterRock <> nil) and (m_MasterRock is TTrapRock) then
    TTrapRock(m_MasterRock).m_FirstHit := False;

  if not (self is TTrapRock) then
    nDamage:=0;

  inherited;
end;

constructor TTrapRock.Create;
begin
  m_LockTarget := nil;
  m_boFixedHideMode:=True;
  m_SlaveObjectList := TList.Create;
  m_FirstHit := True;
  inherited;
end;

destructor TTrapRock.Destroy;
begin
  inherited;
end;

procedure TTrapRock.Run;
var
  dist, i,nRandomSlave: Integer;
  BaseObject: TBaseObject;
begin
  if not m_boStoneMode and
  (not m_boDeath) and (not m_boGhost) and
  (m_wStatusTimeArr[POISON_STONE] = 0) then begin
    if m_boFixedHideMode and (m_TargetCret = nil) then begin
      if (GetTickCount - m_dwSearchEnemyTick) > 1000 then begin
        m_dwSearchEnemyTick := GetTickCount;
        m_LockTarget := CanTrap();
        if (m_LockTarget <> nil) then
          TrapObject(m_LockTarget);
      end;
    end else begin
      if m_LockTarget <> nil then begin //check if our target it still there (should be there)
        dist:=_Max(Abs(m_nCurrX - m_LockTarget.m_nCurrX),Abs(m_nCurrY - m_LockTarget.m_nCurrY));
        if m_LockTarget.m_boDeath or m_LockTarget.m_boGhost or (m_LockTarget.m_PEnvir <> m_PEnvir) or (dist > 1) then  begin
          m_dwSearchEnemyTick := GetTickCount + 120000;
          if m_LockTarget is TPlayObject then begin
            TPlayObject(m_LockTarget).IsTrapped(False);
          end;
          m_LockTarget := nil;
           //should make the rock go down again here
          m_boFixedHideMode:=True;
          SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
          if m_SlaveObjectList.Count > 0 then begin
            for i:=0 to m_SlaveObjectList.Count -1 do begin
              if (TTrapPart(m_SlaveObjectList[i]) is TTrapRock) then begin
                m_SlaveObjectList.Delete(i);
                Continue;
              end;
              BaseObject := m_SlaveObjectList.items[i];
              BaseObject.m_boObMode := True;
              if (BaseObject <> nil) and (BaseObject is TTrapPart) then begin
                TTrapPart(BaseObject).m_boNextRoundDie:=True;
              end;
            end;
          m_SlaveObjectList.Free;
          m_SlaveObjectList := TList.Create;
          end;
        end;
      end;
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_dwHitTick := GetTickCount();
        Paralyse(m_LockTarget);
      end;
    end;
  end;
inherited;
end;

procedure TTrapRock.TrapObject(LockTarget: TBaseObject);
var
  nX,nY:integer;
  RealPosition,i,Position:byte;
  BaseObject:TBaseObject;
begin
  if LockTarget is TPlayObject then begin
    TPlayObject(m_LockTarget).IsTrapped(True);
  end;
  RealPosition:=Random(3) * 2;
  if m_PEnvir.GetNextPosition(LockTarget.m_nCurrX,LockTarget.m_nCurrY,RealPosition,1,nX,nY) = False then begin
    LockTarget := nil;
    exit;
  end;
  SpaceMove(self.m_sMapName,nX,nY,0);
  for i := 0 to 3 do begin
    Position:=i*2;
    if Position = RealPosition then continue;
    if m_PEnvir.GetNextPosition(LockTarget.m_nCurrX,LockTarget.m_nCurrY,Position,1,nX,nY) = False then begin
      LockTarget := nil;
      exit;
    end;
    BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,nX ,nY,m_sCharName + '1');
    if BaseObject <> nil then begin
      m_SlaveObjectList.Add(BaseObject);
      if BaseObject is TTrapPart then begin
        TTrapPart(BaseObject).m_MasterRock := self;
      end;
    end;
  end;
  m_SlaveObjectList.Add(self);
  ComeOut(LockTarget);
end;

function TTrapRock.CanTrap():TBaseObject;
var
  I:Integer;
  BaseObject:TBaseObject;
  nx,ny:integer;
begin
  Result := nil;
  SearchObjectViewRange();
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject.m_boDeath or BaseObject.m_boGhost or BaseObject.m_boFixedHideMode then Continue;
    if (BaseObject is TPlayObject) and IsProperTarget(BaseObject) then begin
      if not BaseObject.IsHidden or m_boCoolEye then begin
        //top spot = free
        if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,0,1,nX,nY) and m_PEnvir.CanWalk(nX,nY,True) then begin
          //right spot = free
          if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,2,1,nX,nY) and m_PEnvir.CanWalk(nX,nY,True) then begin
            //bottom spot = free
            if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,4,1,nX,nY) and m_PEnvir.CanWalk(nX,nY,True) then begin
              //left spot = free
              if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,6,1,nX,nY) and m_PEnvir.CanWalk(nX,nY,True) then begin
                if TPlayObject(BaseObject).m_boCanWalk then begin
                  Result := BaseObject;
                  break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TTrapRock.ComeOut(LockTarget: TBaseObject);
var
  i: Integer;
begin
  for i := 0 to m_SlaveObjectList.Count - 1 do begin
    TTrapPart(m_SlaveObjectList[i]).AllComeOut(LockTarget);
  end;
end;

procedure TTrapRock.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  if not m_boFixedHideMode then begin
    if m_FirstHit then
      m_wAbil.HP := 0;
  end else
    nDamage := 0;
  inherited;
end;

procedure TTrapRock.Die();
var
  i: Integer;
begin
  if m_LockTarget <> nil then begin
    if m_LockTarget is TPlayObject then begin
      with TPlayObject(m_LockTarget) do begin
        IsTrapped(False);
      end;
    end;
    m_LockTarget := nil;
  end;
  for i := 0 to m_SlaveObjectList.Count - 1 do begin
    TTrapPart(m_SlaveObjectList[i]).m_boNextRoundDie := True;
  end;
  if m_SlaveObjectList.Count > 0 then
    m_SlaveObjectList.Free;
  inherited;
end;

procedure TTrapRock.Paralyse(target_object: TBaseObject);
var
  i, nPower: Integer;
  nRandomSlaveNumber: Integer;
  nRandomSlave: TTrapPart;
begin
  if (target_object = nil) or (target_object.m_boGhost) or (target_object.m_boDeath) or (target_object.m_PEnvir <> m_PEnvir) then
    Exit;

  if m_SlaveObjectList.Count > 0 then begin
    nRandomSlaveNumber := Random(m_SlaveObjectList.Count);
    nRandomSlave := m_SlaveObjectList[nRandomSlaveNumber];
    nRandomSlave.SendRefMsg(RM_LIGHTING, 1, nRandomSlave.m_nCurrX, nRandomSlave.m_nCurrY, Integer(m_LockTarget), '');
  end;

  if IsProperTarget(target_object) then begin
    nPower := (HiWord(m_wAbil.MC) div 2) + Random(HiWord(m_wAbil.MC) div 2);
    target_object.SendDelayMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 600);
    if (Random(10) <= 1) then
      target_object.MakePosion(POISON_STONE, 5, 0)
  end;
end;

constructor TGuardianRock.Create;
begin
  inherited;
  m_boNoAttackMode := TRUE;
  boActive := False;
  m_nViewRange := 13;
  m_boStickMode := True;
end;

destructor TGuardianRock.Destroy;
begin
  inherited;
end;

procedure TGuardianRock.SearchTarget;
var
  BaseObject, BaseObject18: TBaseObject;
  i, nC, n10: Integer;
begin
  BaseObject18 := nil;
  n10 := 999;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if BaseObject <> nil then begin
      if (not BaseObject.m_boDeath) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if IsProperTarget(BaseObject) and (not BaseObject.IsHidden or m_boCoolEye) then begin
          nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
          if nC < n10 then begin
            n10 := nC;
            BaseObject18 := BaseObject;
          end;
        end;
      end;
    end;
  end;

  if BaseObject18 <> nil then
    SetTargetCreat(BaseObject18);
end;

procedure TGuardianRock.Run;
begin
try
  if not m_boDeath then
    m_WAbil.HP := m_WAbil.MaxHP;
  if not m_boFixedHideMode and
     CanPerformActions then begin
     if (m_TargetCret <> nil) and (boActive) then begin
       if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
         m_dwHitTick := GetTickCount();
         Drag();
       end;
     end;
     //search for targets nearbye
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('Guardianrock process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TGuardianRock.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  nDamage:=0;
  inherited StruckDamage(nDamage,AttackBase);
end;

procedure TGuardianRock.Drag();
var
  nx, ny: Integer;
  nAttackDir: Integer;
begin  
  if not(m_TargetCret is TPlayObject) then exit;
  if random(11) < m_TargetCret.m_nAntiMagic then exit;  //fairly ok chance not to get moved arround non stop 

  nAttackDir:=GetNextDirection(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,m_nCurrX,m_nCurrY); //technicaly this is the dir the target would be facing if he was hitting us
  GetFrontPosition(nx,ny);
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
  m_TargetCret.CharPushed(nAttackDir,1);

//  for i:=0 to m_TargetCret.m_VisibleActors.Count-1 do begin    push from center of fly mass attack
//    BaseObject:= TBaseObject (pTVisibleBaseObject(m_TargetCret.m_VisibleActors[i]).BaseObject);
//    if (abs(m_TargetCret.m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY-BaseObject.m_nCurrY) <= 2) then begin
//      if BaseObject <> nil then begin
//        if IsProperTarget (BaseObject) then begin
//          nRandomDirection := Random(5);
//          if ((nRandomDirection mod 2) > 0) then
//            Inc(nRandomDirection, 1);
//          if m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,nRandom,1,nX,nY) and m_PEnvir.CanWalk(nX,nY,True) then begin
//            GetFrontPosition(nx,ny);
//            BaseObject.CharPushed(nRandomDirection,2);
//          end;
//        end;
//      end;
//     end;
//  end;
end;

procedure TGuardianRock.Die;
begin
  SendDelayMsg(self, RM_DISAPPEAR, 0, 0, 0, 0, '', 600);
  m_boObMode:=True;//hopefully switching to observer also makes us invisible to others when we die :p;
  inherited;
end;

constructor TOrbSpirit.Create;
begin
  inherited;
  m_boNoAttackMode := TRUE;
  nLevel := -1;
  nOldLevel := 0;
  boGuards:= False;
  m_boFixedHideMode:=True;
  m_nViewRange := 13;
  m_dwMassAttack:= 0;
  m_nMassAttacks :=0;
  m_boStickMode := True;
  m_btDirection := 0;
end;

destructor TOrbSpirit.Destroy;
begin
  inherited;
end;

procedure TOrbSpirit.Run();
var
  HpDiff, dist: integer;
begin
try
  if m_boFixedHideMode then begin
    SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    m_boFixedHideMode := False;
  end;

  if not boGuards then begin
    boGuards := True;
    ActivateGuards();
  end;
  
  if CanPerformActions then begin
    if (m_WAbil.HP >= m_WAbil.MaxHP * 4 div 5) then begin
      nOldLevel := nLevel;
      nLevel := 0;
    end else if (m_WAbil.HP >= m_WAbil.MaxHP * 3 div 5) then begin
      nOldLevel := nLevel;
      nLevel := 1;
    end else if (m_WAbil.HP >= m_WAbil.MaxHP * 2 div 5) then begin
      nOldLevel := nLevel;
      nLevel := 2;
    end else if (m_WAbil.HP >= m_WAbil.MaxHP * 1 div 5) then begin
      nOldLevel := nLevel;
      nLevel := 3;
    end else begin
      nOldLevel := nLevel;
      nLevel := 4;
    end;

    if (nLevel <> nOldLevel) then begin
      m_btDirection := nLevel;
      SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;

    if m_TargetCret <> nil then begin
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_dwHitTick := GetTickCount();
        dist:=_Max(Abs(m_nCurrX - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
        if dist <= m_nViewRange then begin
          if (Random(10) = 0) and (dist >= 3) then
            Recall()
          else if (Random(100) < 40) and (dist <=3) then
            MassPoison()
          else if (Random(10) < 4) then
            SingleAttack()
          else
            MassAttack();
        end;
      end;
    end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
except
  on e: Exception do begin
    MainOutMessage('OrbSpirit process Error');
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TOrbSpirit.MassPoison();
var
  BaseObject:TBaseObject;
  i:integer;
begin
  SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
  for i:=0 to m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(10) < 2 then begin
          if Random(2 + BaseObject.m_btAntiPoison) = 0 then
            BaseObject.MakePosion(POISON_STONE,5,0);
        end else begin
          if Random(2 + BaseObject.m_btAntiPoison) = 0 then
            BaseObject.MakePosion(POISON_SLOWDOWN,5,0);
        end;
      end;
    end;
  end;
end;

procedure TOrbSpirit.MassAttack();
var
  BaseObject:TBaseObject;
  magpwr:integer;
  i:integer;
begin
  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  for i:=0 to m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if (Random(5) > 2) and (Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic) then begin
          magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
          magpwr := magpwr + (nLevel * LoWord(m_WAbil.DC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 200);
          BaseObject.SendDelayMsg(BaseObject,RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,39{type},'',200);
        end;
      end;
    end;
  end;
end;

procedure TOrbSpirit.SingleAttack();
var
  magpwr:integer;
begin
  if m_TargetCret <> nil then begin
  SendRefMsg(RM_FLYAXE,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
    if IsProperTarget (m_TargetCret) then begin
      if Random(g_Config.nMagicResistanceRate) >= m_TargetCret.m_nAntiMagic then begin
        magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
        magpwr := magpwr + (nLevel * LoWord(m_WAbil.DC));
        m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
      end;
    end;
  end;
end;

procedure TOrbSpirit.Recall();
var
  nX,nY,i:integer;
  BaseObject:TBaseObject;
  dist:integer;
begin
  GetFrontPosition(nX,nY);
  for i:=0 to m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) and (Random(m_VisibleActors.Count) = 0) then begin
        BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
        BaseObject.SpaceMove(m_sMapName,nX,nY,0);
      end;
    end;
  end;
end;

procedure TOrbSpirit.ActivateGuards();
var
  BaseObject:TBaseObject;
  II,I:integer;
  BaseObjectList:TList;
  boFound:boolean;
begin
  for II := 0 to Length(sMonxy) -1 do begin
    boFound := False;
    BaseObjectList:=TList.Create;
    m_PEnvir.GeTBaseObjects    (sMonXY[II,0],sMonXY[II,1],False,BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject:=TBaseObject(BaseObjectList.Items[I]);
      if (BaseObject.m_sCharName = m_sGuardName) and (BaseObject is TGuardianRock) then begin
        TGuardianRock(BaseObject).boActive := True;
        boFound := True;
        break;
      end;
    end;
    BaseObjectList.Free;
    if not boFound then begin
      BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,sMonXY[II,0],sMonXY[II,1],m_sGuardName);
      if (BaseObject <> nil) and (BaseObject is TGuardianRock) then begin
        TGuardianRock(BaseObject).boActive := True;
      end;
    end;
  end;
end;

procedure TOrbSpirit.DeActivateGuards();
var
  BaseObject:TBaseObject;
  II,I:integer;
  BaseObjectList:TList;
begin
  for II := 0 to Length(sMonxy) -1 do begin
    BaseObjectList:=TList.Create;
    m_PEnvir.GeTBaseObjects(sMonXY[II,0],sMonXY[II,1],False,BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject:=TBaseObject(BaseObjectList.Items[I]);
      if (BaseObject.m_sCharName = m_sGuardName) and (BaseObject is TGuardianRock) then begin
        TGuardianRock(BaseObject).boActive := False;
        break;
      end;
    end;
    BaseObjectList.Free;
  end;
end;

procedure TOrbSpirit.Die;
begin
  DeActivateGuards();
  inherited;
end;

function TOrbSpirit.GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;
var
  Envir:TEnvirnoment;
begin
  Envir:=m_PEnvir;
  nX:=m_nCurrX;
  nY:=m_nCurrY;
  case m_btDirection of    //
    DR_UP: begin
      if nY > 0 then Dec(nY,2);
    end;
    DR_UPRIGHT: begin
      if (nX < (Envir.m_nWidth -2)) and (nY > 0) then begin
       Inc(nX,2);
       Dec(nY,2);
      end;
    end;
    DR_RIGHT: begin
     if nX < (Envir.m_nWidth -2) then Inc(nX,2);
    end;
    DR_DOWNRIGHT: begin
      if (nX < (Envir.m_nWidth -2)) and (nY < (Envir.m_nHeight -2)) then begin
       Inc(nX,2);
       Inc(nY,2);
      end;
    end;
    DR_DOWN: begin
     if nY < (Envir.m_nHeight -2) then Inc(nY,2);
    end;
    DR_DOWNLEFT: begin
      if (nX > 0) and (nY < (Envir.m_nHeight -2)) then begin
       Dec(nX,2);
       Inc(nY,2);
      end;
    end;
    DR_LEFT: begin
      if nX > 0 then Dec(nX,2);
    end;
    DR_UPLEFT: begin
      if (nX > 0) and (nY > 0) then begin
        Dec(nX,2);
        Dec(nY,2);
      end;
    end;
  end;
  Result:=True;
end;

constructor TEventMob1.Create;
begin
  inherited;
end;

destructor TEventMob1.Destroy;
begin
  inherited;
end;

procedure TEventMob1.Run;
begin
  if not m_boFixedHideMode and
    (CanPerformActions) then begin
    if (m_TargetCret <> nil) and IsProperTarget(m_TargetCret) then begin
      GetMapFollowObject(12); //mobs will follow from 12 places aways.
      attacktarget();
    end;
  end;
  inherited;
end;

function TEventMob1.AttackTarget():Boolean;
var
  btDir:Byte;
  nPower: Integer;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime  then begin
        SendAttackMsg(RM_hit,SM_HIT,btDir,m_nCurrX,m_nCurrY);
        m_dwHitTick:=GetTickCount();
        m_dwTargetFocusTick:=GetTickCount();

        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
        nPower :=(m_TargetCret.m_WAbil.MaxHP * nPower) div 100;
        //Doesnt matter what ammount of AC/MAC/SPEEDPOINTS you have this mob will always hit you :P
        m_TargetCret.StruckDamage(nPower, Self);
        m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, m_WAbil.HP, m_WAbil.MaxHP, Integer(Self), '', 300);
      end;
      Result:=True;
    end;
  end;
end;

procedure TEventMob1.StruckDamage(var nDamage: Integer; AttackBase: TBaseObject);
begin
  nDamage := (HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
  inherited;
end;

constructor TOmaGuardElite.Create;
begin
  inherited;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_dwRecruitTick:=GetTickCount();
  HitCount := 1;
end;

destructor TOmaGuardElite.Destroy;
begin
  inherited;
end;

procedure TOmaGuardElite.Run();
begin
try
  if not m_boFixedHideMode and
     CanPerformActions then begin
      if m_TargetCret <> nil then begin
        if GetAttackDir(m_TargetCret,m_btDirection) then begin
          if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime div HitCount) then begin
            m_dwHitTick:=GetTickCount();
            DoubleAttack();
          end;
        end;
      end;
  end;
  //search for targets nearbye
  if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
    m_dwSearchEnemyTick:=GetTickCount();
    SearchTarget();
  end;
  //search for recruits to follow
  if not m_boFixedHideMode and
    CanPerformActions then begin
    if ((GetTickCount - m_dwRecruitTick) > 10000) then begin
      m_dwRecruitTick:=GetTickCount();
      GetMapFollowObject(30); //mobs will follow from 30 places aways.
    end;
  end;
  inherited;
  except
    on e: Exception do begin
      MainOutMessage('OmaGuardElite process Error');
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TOmaGuardElite.DoubleAttack();
var
  i: Integer;
  wHitMode: Word;
begin
  wHitMode:=0;
  m_btDirection := GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);

  SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
  _Attack(wHitMode,m_TargetCret);

  //Follows through his last attack with a faster hit
  if HitCount >= 2 then
    HitCount := 1
  else
    HitCount := 2;

end;

end.
