unit ObjMon4;

interface
uses
  Windows, Classes, Grobal2, ObjPlay, ObjBase, ObjMon, ObjMon2, HUtil32, SysUtils;

type

  TManEaterWorm = class(TAnimalObject)
  m_dwUnhideTick: LongWord;
  private
    procedure FlyAttack();
  public
    constructor Create(); override;
    procedure Run(); override;
    function AttackTarget(): Boolean;
    procedure SearchTarget();override;
  end;

  TOrcObject = class(TMonster)
  PriorityLevel: Integer;
  OrcDangerLevel: Integer;
  m_dwStratergyTick: LongWord;
  SCCheck: Integer;
  MCCheck: Integer;
  private
    procedure OrcStratergy(); virtual;
    procedure RangedWalkMode();
    function SurroundCount(BaseObject: TBaseObject; Distance: Integer; Friend: Boolean = False): Integer;
  public
    constructor Create(); override;
    procedure Run(); override;

  end;

  TOrcRanger = class(TOrcObject)
  private
    procedure OrcStratergy(); override;
  public
    constructor Create(); override;
    function AttackTarget(): Boolean; override;
    procedure Run(); override;
  end;

  TOrcFighter = class(TOrcObject)
  m_boSpecialAttackMode1 : Boolean;
  m_dwDualAttackTick: LongWord;
  m_boAvoidMode: Boolean;
  m_boForcedApproach : Boolean;
  private
    procedure SmashAttack(AttackPos, AttackDistance: Integer);
    procedure ThrustAttack(HighDistance: Integer;  Target: TBaseObject = nil);
    procedure HalfMoonAttack();
    function  CanThrust(LowDistance, HighDistance: Integer; ThrustTarg: TBaseObject = nil): Boolean;
    function  CanHalfMoon(NeedCount: Integer): Boolean;
    procedure OrcStratergy(); override;
    procedure WalkAvoidMode();
  public
    constructor Create(); override;
    procedure Run(); override;
    function AttackTarget(): Boolean; override;
  end;

  TOrcSorcerer = class(TOrcObject)
  m_dwHealingTick: LongWord;
  m_dwDelayTick: LongWord;
  private
    procedure OrcStratergy(); override;
    function CanPerform(AttackType: Integer; BaseObject: TBaseObject): Boolean;
    procedure EnergyShield(Target: TBaseObject);
    procedure Healing(Target: TBaseObject);
    procedure Purify(Target: TBaseObject);
    procedure SingleAttack();
    procedure MassAttack(AttackType, Distance: Integer; BaseObject: TBaseObject);
    procedure HealingAttacks();
    Function GetPriorityHealingObject(): TBaseObject;
  public
    constructor Create(); override;
    procedure Run(); override;
    function AttackTarget(): Boolean; override;
  end;

  TOrcGiant = class(TOrcFighter)
    m_dwAttackTick:array[1..3] of LongWord;
  private
    procedure ExplosionAttack(Distance: Integer);
    procedure PlagueWind(Distance: Integer);
    procedure StunStomp();
    function CanPlagueWind(Distance, NeedCount: Integer): Boolean;
  public
    constructor Create(); override;
    procedure Run(); override;
  const
    Line2XY:array[0..7, 0..1] of Integer =
    ( {dir 0} {line2}(-1, 0),
      {dir 1} {line2}(-1,-1),
      {dir 2} {line2}( 0,-1),
      {dir 3} {line2}(+1,-1),
      {dir 4} {line2}(-1, 0),
      {dir 5} {line2}(-1,-1),
      {dir 6} {line2}( 0,-1),
      {dir 7} {line2}(-1,+1));

    Line3XY:array[0..7, 0..1] of Integer =
    ( {dir 0} {line3}(+1, 0),
      {dir 1} {line3}(+1,+1),
      {dir 2} {line3}( 0,+1),
      {dir 3} {line3}(+1,-1),
      {dir 4} {line3}(+1, 0),
      {dir 5} {line3}(+1,+1),
      {dir 6} {line3}( 0,+1),
      {dir 7} {line3}(-1,+1));
  end;

  TOrcWarLord = class(TOrcFighter)
    m_dwAttackTick:array[1..2] of LongWord;
  public
    constructor Create(); override;
    procedure Run(); override;
  end;

  TIceObject = class(TATMonster)
  private
    procedure IceLightning(nDistance: Integer);
    procedure IceShards(nRange: Integer);
    procedure IcePassThroughMagic(sX, sY, tx, ty, nDir, magpwr, distance: Integer; boPushBack: Boolean);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure IceStrategy; virtual;
    procedure Run; override;
  end;

  TIceDemon = class(TIceObject)
  private
    procedure IceThrust();
  public
    procedure IceStrategy; override;
  end;

  TIceDemon2 = class(TIceObject)
  private
  public
    procedure IceStrategy; override;
  end;

  TIceCommander = class(TIceObject)
  private
    procedure Repulse();
  public
    procedure IceStrategy; override;
  end;

  TIceGeneral = class(TIceObject)
  private
  public
    procedure IceStrategy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;
  end;

  TIceSorcererObject = class(TMonster)
  private
    procedure FrostCrunch();
    procedure IceStorm();
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure IceStrategy(); virtual;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
  end;

  TFrostCrunchSorcerer = class(TIceSorcererObject)
    private
    public
      procedure IceStrategy(); override;
  end;

  TIceStormSorcerer = class(TIceSorcererObject)
    private
    public
      procedure IceStrategy(); override;
  end;

  TFCISSorcerer = class(TIceSorcererObject)
    private
    public
      procedure IceStrategy(); override;
  end;

  TIceNode = class(TIceObject)
  private
  public
    procedure Run;override;
  end;

implementation

uses
  UsrEngn, M2Share, Event, Envir, Math;

{$REGION 'Orc Monsters' }

  {$REGION 'Monster: ManEaterWorm' }

  { TManEaterWorm }

  constructor TManEaterWorm.Create; //004A51C0
  begin
    inherited;
    m_nViewRange := 13;
    m_boFixedHideMode := True;
    m_boStickMode := True;
    m_dwUnhideTick := GetTickCount();
    m_nRunTime := 300;
    //m_boAnimal := True;
  end;

  procedure TManEaterWorm.Run;

    function TargetInLongAttackRange(nX, nY : Integer): Boolean;
    begin
      Result := False;
      if ( (nX <= m_nViewRange) and (nY <= m_nViewRange) ) then
        Result := True;
    end;

    function TargetInRange(nX, nY : Integer): Boolean;
    begin
      Result := False;
      if ( (nX <= 3) and (nY <= 3) ) then
        Result := True;
    end;

  var
  TargetX, TargetY: Integer;
  m_nOldCurrX, m_nOldCurrY: Integer;
  begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;

    if (CanPerformActions) then begin
      if (m_TargetCret <> nil) then begin
        if m_boFixedHideMode then
          m_WAbil.HP := m_WAbil.MaxHP; //keep hp full if hiding!

        TargetX:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
        TargetY:=abs(m_nCurrY - m_TargetCret.m_nCurrY);
        if (not m_boFixedHideMode) then begin
          if (integer(GetTickCount - m_dwUnhideTick) > 3000)
          and (integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
            if TargetInRange(TargetX,TargetY) then begin
              AttackTarget();
            end else
            if TargetInLongAttackRange(TargetX,TargetY) then begin
              FlyAttack()
            end;
            m_dwHitTick := GetTickCount();
          end;
        end;
        if m_boFixedHideMode and
        (TargetInRange(TargetX,TargetY)) and
        (integer(GetTickCount - m_dwUnhideTick) > 5000) then begin
          m_boFixedHideMode := False;
          m_dwUnhideTick := GetTickCount();
          SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          m_dwHitTick := GetTickCount() + (m_nNextHitTime * 3);
        end;
        if (not TargetInRange(TargetX,TargetY) ) then begin
          m_Targetcret := nil;
          DelTargetCreat();
        end;

      end; //target
    end;
    inherited;
  end;

  procedure TManEaterWorm.SearchTarget;
  var
    BaseObject, BaseObject18: TBaseObject;
    i, nC, n10: Integer;
  begin
    BaseObject18 := nil;
    n10 := m_nViewRange;
    for i := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
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

  function TManEaterWorm.AttackTarget: Boolean;
  var
    i: Integer;
    nX, nY: Integer;
    BaseObject: TBaseObject;
    wHitMode: Word;
  begin
    Result := False;
    wHitMode := 0;
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        for I := 1 to 3 do begin //If anything is in our line of sight we do damage
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if BaseObject <> m_targetcret then //dont hit our target k?
              _Attack(wHitMode, BaseObject); //We dont want to hit our Target twice if hes in the line of sight.
          end;
        end;
      _Attack(wHitMode, m_TargetCret); //Attack our target
      Result := True;
      end;
    end;
  end;

  procedure TManEaterWorm.FlyAttack;
  Var
  nPower: Integer;
  begin
    nPower := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');

      nPower := m_TargetCret.GetStunDamage(Self, nPower);
      nPower := m_TargetCret.GetHitStruckDamage(Self, nPower);
      if nPower > 0 then begin
        m_TargetCret.StruckDamage(nPower, Self);

        m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower,
        m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - m_TargetCret.m_nCurrX), abs(m_nCurrY - m_TargetCret.m_nCurrY)) * 50 + 600);
      end;
    end;
  end;

  {$ENDREGION} //ManEaterWorm

  {$REGION 'Monster: OrcObject' }

  { TOrcObject }

  constructor TOrcObject.Create; //004A51C0
  begin
    inherited;
    PriorityLevel := 0;
    OrcDangerLevel := 0;
    m_dwStratergyTick := GetTickCount();
    SCCHeck := 0;
    MCCheck := 0;
  end;

  procedure TOrcObject.Run;
  begin
    if (CanPerformActions) then begin
      if (integer(GetTickCount - m_dwStratergyTick) > 3000) then begin
        m_dwStratergyTick := GetTickCount();
        OrcStratergy();
      end;

      if ((GetTickCount - m_dwSearchEnemyTick) > 4000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;
    end;
    inherited;
  end;

  procedure TOrcObject.RangedWalkMode;
  var
  distance: integer;
  nDirection: Integer;
  begin
    if CanPerformActions and (m_TargetCret <> nil) then begin
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
        distance:=_Max(Abs(m_nCurrX - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
        if distance > 8 then begin //if we are to far: go closer
          m_nTargetX:=m_TargetCret.m_nCurrX;
          m_nTargetY:=m_TargetCret.m_nCurrY;
          GotoTargetXY;
        end else
        if distance < 9 then begin //if we are to close: go further
          if Random(7 - OrcDangerLevel) = 0 then begin
            nDirection:=GetNextDirection(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,m_nCurrX,m_nCurrY);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDirection,5,m_nTargetX,m_nTargetY);
            GotoTargetXY;
          end;
        end;
      end;
    end;
  end;

  Procedure TOrcObject.OrcStratergy;
  var
  DangerList: TList;
  OrcList: TList;
  I: Integer;
  BaseObject: TBaseObject;
  begin
    SCCheck := HiWord(m_wAbil.SC);
    MCCHeck := HiWord(m_wAbil.MC);
    OrcDangerLevel := 0;
    DangerList := TList.Create;
    GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 10, DangerList);

    if DangerList.Count > 0 then begin
      for I := 0 to DangerList.Count - 1 do begin
        BaseObject := TBaseObject(DangerList.Items[i]);
        if (OrcDangerLevel < 5) then begin
          if IsProperTarget(BaseObject) and (BaseObject <> self) then begin
            inc(OrcDangerLevel, 1);
          end;
        end else break;
      end;
    end;
    DangerList.Free;
  end;

  function TOrcObject.SurroundCount(BaseObject: TBaseObject; Distance: Integer; Friend: Boolean = False): Integer;
  var
  ActorList: TList;
  ActorCount: Integer;
  I: Integer;
  ActorObject: TBaseObject;
  begin
    ActorCount := 0;
    ActorList := TList.Create;
    GetMapBaseObjects(m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, Distance, ActorList);
    if ActorList.Count > 0 then begin
      for I := 0 to ActorList.Count - 1 do begin
        ActorObject := TBaseObject(ActorList.Items[i]);
        if IsProperTarget(ActorObject) and not
        (ActorObject.m_boDeath) and not
        (ActorObject.m_boGhost) then
          Inc(ActorCount);
      end;
    end;
    ActorList.Free;
    Result := ActorCount;
  end;

  {$ENDREGION}

  {$REGION 'Monster: OrcRanger'}

  { TOrcRanger }

  constructor TOrcRanger.Create;
  begin
    inherited;
    PriorityLevel := 1;
    m_boApproach := False;
    m_nViewRange := 7;
  end;

  procedure TOrcRanger.Run;
  begin
    if (CanPerformActions) then begin
      if (m_TargetCret <> nil) then begin
        if (not AttackTarget) then
          if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
            RangedWalkMode();
          end;
      end;
    end;
    inherited;
  end;

  function TOrcRanger.AttackTarget(): Boolean;
  var
    WAbil: pTAbility;
    nDamage: Integer;
    nPoisonDamage, nPoisonTime: Integer;
  begin
    Result := False;
    nPoisonDamage := 0;
    if m_TargetCret <> nil then begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
        if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
          m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          WAbil := @m_WAbil;
          nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
          if nDamage > 0 then begin
            nDamage := m_TargetCret.GetStunDamage(Self, nDamage);
            nDamage := m_TargetCret.GetHitStruckDamage(Self, nDamage);
          end;
          if nDamage > 0 then begin
            m_TargetCret.StruckDamage(nDamage, Self);
            m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage,
              m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '',
              _MAX(abs(m_nCurrX - m_TargetCret.m_nCurrX), abs(m_nCurrY - m_TargetCret.m_nCurrY)) * 50 + 600);
            if SCCheck > 0 then begin
              nPoisonDamage := (HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
              nPoisonTime := (m_Abil.Level div 2) + Random(m_Abil.Level div 2);
              if Random(7 - OrcDangerLevel) = 0 then
                m_TargetCret.MakePosion(POISON_DECHEALTH, nPoisonTime, nPoisonDamage);
            end;
            if MCCheck > 0 then begin
              nPoisonTime := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
              if Random(7 - OrcDangerLevel) = 0 then
                m_TargetCret.MakePosion(POISON_DAMAGEARMOR, nPoisonTime, 0);
            end;
          end;
          m_dwHitTick := GetTickCount();
          m_dwWalkTick := GetTickCount() + round(m_nWalkSpeed div 2);
          m_dwTargetFocusTick := GetTickCount();
          SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');

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
  end;

 Procedure TOrcRanger.OrcStratergy;
  var
  HelpList: TList;
  BaseObject: TBaseObject;
  I: Integer;
  begin
    inherited;

    {//Keep our current coords if theres no target, stops us walking around
    if m_TargetCret = nil then begin
      m_nTargetX := m_nCurrX;
      m_nTargetY := m_nCurrY;
    end;}

  end;

  {$ENDREGION}

  {$REGION 'Monster: OrcFighter'}

  { TOrcFighter }
  //RACE 189 = Normal Attacker, 190 = ThrustAttacker, 191 = StunBlade Attacker, 192 = HalfMoon Attacker

  constructor TOrcFighter.Create;
  begin
    inherited;
    PriorityLevel := 2;
    m_boApproach := True;
    m_boAvoidMode := False;
    m_boForcedApproach := False;
    m_boSpecialAttackMode1 := False;
    m_dwDualAttackTick := GetTickCount();
    m_nViewRange := 8;
  end;

  procedure TOrcFighter.Run;
  var
  TX, TY : Integer;
  I: Integer;
  OrcList: TList;
  BaseObject: TBaseObject;
  begin
    if (CanPerformActions) then begin

      {$REGION 'Normal Fighter + Stunner' }

      if (m_btRaceServer = 189) or (m_btRaceServer = 191)  then begin //Normal Fighter  / Stunner
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
          AttackTarget();
        end;
      end;

      {$ENDREGION}

      {$REGION 'Thrust Fighter' }
      if m_btRaceServer = 190 then begin //Thrust Fighter
        if (m_TargetCret <> nil) and (IsProperTarget(m_TargetCret)) then begin
          //Dual Attack Modes with other orc thrusters.
          if (Integer(GetTickCount - m_dwDualAttackTick) > m_nNextHitTime * 3) and
          CanThrust(1,6, m_TargetCret) and
          (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
            OrcList := TList.Create;
            GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 7, OrcList);
            if OrcList.Count > 0 then begin
              for I := 0 to OrcList.Count - 1 do begin
                BaseObject := TBaseObject(OrcList.Items[i]);

                if (BaseObject.CanPerformActions) and //CanAct
                (BaseObject <> self) and //Not Self
                (BaseObject.m_TargetCret <> m_TargetCret) and //no point if there target is already ours..
                (BaseObject.m_btRaceServer = 190) and  //Our Race
                (BaseObject.IsProperTarget(m_TargetCret)) and //Target is proper
                TOrcFighter(BaseObject).CanThrust(1,6,m_TargetCret) and //Thrust can reach
                (integer(GetTickCount - TOrcFighter(BaseObject).m_dwHitTick) > //HitTick
                TOrcFighter(BaseObject).m_nNextHitTime) then begin

                  TOrcFighter(BaseObject).ThrustAttack(6,m_TargetCret);
                  ThrustAttack(6,m_TargetCret);
                  m_dwDualAttackTick := GetTickCount();
                  TOrcFighter(BaseObject).m_dwDualAttackTick := GetTickCount();
                  if Random(3) = 0 then begin
                    TOrcFighter(BaseObject).m_TargetCret := m_TargetCret;
                    TOrcFighter(BaseObject).m_dwSearchEnemyTick:=GetTickCount();
                  end;
                  //MainOutMessage('Success');
                  break;
                end;
              end;
            end;
            OrcList.Free;
          end;
        end;

        //Normal Thrust Attack
        if (m_TargetCret <> nil) and (IsProperTarget(m_TargetCret)) then begin
          if (CanThrust(2,6))
          or ((CanThrust(1,6)) and (m_boSpecialAttackMode1)) then begin
            ThrustAttack(6);
            if (Integer(GetTickCount - m_dwDualAttackTick) > m_nNextHitTime) then
              m_dwDualAttackTick := GetTickCount();
          end else begin
            AttackTarget();
          end;
        end;
      end; //Thrust Fighter End

      {$ENDREGION} //ThrustFighter

      {$REGION 'HalfMoon Fighter'}

      if m_btRaceServer = 192 then begin
        if (m_TargetCret <> nil) then begin
          if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
            if (CanHalfMoon(2)) or ( (CanHalfMoon(1)) and (Random(7 - OrcDangerLevel) = 0) ) then begin
              HalfMoonAttack();
              m_dwHitTick := GetTickCount();
            end else AttackTarget();
          end;
        end;
      end;
      {$ENDREGION}

      //189,190,191,192
      if (m_TargetCret <> nil) and (IsProperTarget(m_TargetCret)) then begin
        //When Stun or Random, try to avoid as much damage as we can from Warrior/Assassin objects.
        if (m_boAvoidMode) then begin
          WalkAvoidMode(); //Begin Walk Avoidance Mode
        end;
      end;
    end;

    inherited;
  end;

  procedure TOrcFighter.WalkAvoidMode();
  var
  AreaList: TList;
  I: Integer;
  BaseObject: TBaseObject;
  RunObject: TBaseObject;
  RunX,RunY: Integer;
  RunDir: Integer;
  begin

    BaseObject := nil;
    RunObject := nil;
    AreaList := TList.Create;
    GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 2, AreaList);
    if AreaList.Count > 0 then begin
      for I := 0 to AreaList.Count - 1 do begin
        BaseObject := TBaseObject(AreaList.Items[i]);
        if (IsProperTarget(BaseObject)) and
        (BaseObject <> Self) and
        (not BaseObject.m_boGhost) and
        (not BaseObject.m_boDeath) then begin
          if ((BaseObject.m_btJob = 0) or (BaseObject.m_btJob = 3)) and
          (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
            RunObject := BaseObject;
            break;
          end;
        end;
      end;
    end;
    AreaList.Free;

    if (RunObject <> nil) and (m_TargetCret <> nil) then begin
      RunX:=abs(m_nCurrX - RunObject.m_nCurrX);
      RunY:=abs(m_nCurrY - RunObject.m_nCurrY);

      if ( (RunX < 3) and (RunY < 3) ) then begin
        if (RunObject = m_TargetCret) and (not m_boSpecialAttackMode1) then begin
          m_nTargetX := RunObject.m_nCurrX;
          m_nTargetY := RunObject.m_nCurrY;
        end else begin
          RunDir := GetNextDirection(RunObject.m_nCurrX, RunObject.m_nCurrY, m_nCurrX, m_nCurrY);
          m_PEnvir.GetNextPosition(RunObject.m_nCurrX, RunObject.m_nCurrY, RunDir, 6, m_nTargetX,  m_nTargetY);
        end;

        if m_boWalkWaitLocked then begin
          if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
            m_boWalkWaitLocked := False;
          end;
        end;
        if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
          m_dwWalkTick := GetTickCount();
          Inc(m_nWalkCount);
          if m_nWalkCount > m_nWalkStep then begin
            m_nWalkCount := 0;
            m_boWalkWaitLocked := True;
            m_dwWalkWaitTick := GetTickCount();
          end;
          GotoTargetXY();
        end;
      end;
    end;
  end;


  function TOrcFighter.CanThrust(LowDistance, HighDistance: Integer; ThrustTarg: TBaseobject = nil): Boolean;
  var
  I: Integer;
  nX, nY: Integer;
  AllowThrust: Boolean;
  BaseObject: TBaseObject;
  Dir : Integer;
  AttackTarget : TBaseObject;
  begin
    AllowThrust := False;
    if (ThrustTarg <> nil) then
      AttackTarget := ThrustTarg
    else
    if m_TargetCret <> nil then
      AttackTarget := m_TargetCret;

    if (AttackTarget <> nil) then begin
      Dir := GetNextDirection(m_nCurrX, m_nCurrY, AttackTarget.m_nCurrX, AttackTarget.m_nCurrY);

      for I := LowDistance to HighDistance do begin
        if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, Dir, I, nX, nY) then begin
          BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
          if (ThrustTarg <> nil) then begin //If were checking if a specific target is in line of sight
            if IsProperTarget(BaseObject) and (BaseObject = AttackTarget) then begin
              AllowThrust := True;
              break;
            end;
          end else //Normal check if a non specified target in sight
            if IsProperTarget(BaseObject) and (BaseObject <> nil) then begin
              AllowThrust := True;
              break;
            end;
        end;
      end;
    end;
    Result := AllowThrust;
  end;

  function TOrcFighter.CanHalfmoon(NeedCount: Integer): Boolean;
  var
  nC, n10: Integer;
  nX, nY: Integer;
  AllowHalfMoon: Boolean;
  BaseObject: TBaseObject;
  Dir : Integer;
  Count: Integer;
  I: Integer;
  begin
    AllowHalfMoon := False;
    Count := 0;
    nC := 0;
    if (m_TargetCret <> nil) then begin
      Dir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      while (True) do begin
        n10 := (Dir + g_Config.OrcWideAttack[nC]) mod 8;
        for I := 1 to 2 do begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then
              Inc(Count, 1);
          end;
        end;
        Inc(nC);
        if nC >= 5 then
          break;
      end;
      if Count >= NeedCount then
        AllowHalfMoon := True;
    end;
    Result := AllowHalfMoon;
  end;

  procedure TOrcFighter.ThrustAttack(HighDistance: Integer; Target: TBaseObject = nil);
  var
    i: Integer;
    nX, nY: Integer;
    BaseObject: TBaseObject;
    wHitMode: Word;
    nPower, nFinalPower: Integer;
    AttackTarget: TBaseObject;
  begin
    wHitMode := 0;
    nPower := 0;
    AttackTarget := nil;

    if (Target <> nil) then
      AttackTarget := Target
    else
    if m_TargetCret <> nil then
      AttackTarget := m_TargetCret;

    if AttackTarget <> nil then begin
      if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, AttackTarget.m_nCurrX, AttackTarget.m_nCurrY);
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        if m_btRaceServer = 187 then begin
          SendAttackMsg(RM_HIT, SM_HIT_4, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := (HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
        end else begin
          SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
          nPower := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
        end;
        for I := 1 to HighDistance do begin //If anything is in our line of sight we do damage
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if IsProperTarget(BaseObject) then begin
              if nPower > 0 then
                nFinalPower := BaseObject.GetStunDamage(Self, nPower);
                if I = 1 then //Objects in space 1 will have there AC checked.
                  nFinalPower := BaseObject.GetHitStruckDamage(Self, nFinalPower);

              if nFinalPower > 0 then begin
                BaseObject.StruckDamage(nFinalPower, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nFinalPower, BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP, Integer(Self), '', I * 200);
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  procedure TOrcFighter.SmashAttack(AttackPos, AttackDistance: Integer);
  var
  BaseObject: TBaseObject;
  ObjectList: TList;
  I: Integer;
  nX, nY: Integer;
  nPower, nFinalPower: Integer;
  begin
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);

      if m_btRaceServer = 187 then begin
        SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      end else begin
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
      end;

      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, AttackPos, nX, nY) then begin
        ObjectList := TList.Create;
        GetMapBaseObjects(m_PEnvir, nX, nY, AttackDistance, ObjectList);
        if (ObjectList.Count > 0) then begin
          for I := 0 to ObjectList.Count - 1 do begin
            BaseObject := TBaseObject(ObjectList.Items[i]);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin

              if (BaseObject.m_nCurrX = nX) and (BaseObject.m_nCurrY = nY) then begin //If the object is in the proper hitting spot
                nFinalPower := BaseObject.GetStunDamage(self,nPower);
                nFinalPower := BaseObject.GetHitStruckDamage(self,nFinalPower);
                if nFinalPower > 0 then begin
                  BaseObject.StruckDamage(nFinalPower, Self);
                  BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nFinalPower, BaseObject.m_WAbil.HP,
                  BaseObject.m_WAbil.MaxHP, Integer(Self), '', 600);
                end;
              end else begin //else if the object is in the MagicRange instead
                if Random(g_Config.nMagicResistanceRate + 30) >= BaseObject.m_nAntiMagic then begin
                  SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 800);
                end;
              end;
            end;
          end;
        end;
        ObjectList.Free
      end;
    end;
  end;

  procedure TOrcFighter.HalfMoonAttack();
  var
    nC, n10: Integer;
    nX, nY: Integer;
    BaseObject: TBaseObject;
    nPower: integer;
    nFinalPower: Integer;
    I: Integer;
  begin
    nC := 0;
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);

      if m_btRaceServer = 187 then begin
        SendAttackMsg(RM_HIT, SM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
      end else begin
        SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
        nPower := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      end;

      while (True) do begin
        n10 := (m_btDirection + g_Config.OrcWideAttack[nC]) mod 8;
        for I := 1 to 2 do begin //Attack the first two positions ahead.
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, I, nX, nY) then begin
            BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              nFinalPower := BaseObject.GetStunDamage(self,nPower);
              nFinalPower := BaseObject.GetHitStruckDamage(self,nFinalPower);
              if nFinalPower > 0 then begin
                BaseObject.StruckDamage(nFinalPower, Self);
                BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nFinalPower, BaseObject.m_WAbil.HP,
                BaseObject.m_WAbil.MaxHP, Integer(Self), '', nC * 100);
              end;
            end;
          end;
        end;
        Inc(nC);
        if nC >= 5 then
          break;
      end;
    end;
  end;

  function TOrcFighter.AttackTarget(): Boolean;
  var
    bt06: Byte;
  begin
    Result := False;
    if m_TargetCret <> nil then begin
      if GetAttackDir(m_TargetCret, bt06) then begin
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          Attack(m_TargetCret, bt06);
          BreakHolySeizeMode();
          if m_btRaceServer = 191 then begin
            if (Random(7 - OrcDangerLevel) = 0) then begin
              m_TargetCret.MakePosion(POISON_STUN, 2 + OrcDangerLevel, 0);
              m_TargetCret.SendRefMsg(RM_10205, 0, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 34, '');
            end;
          end;
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

 Procedure TOrcFighter.OrcStratergy;
  var
  HelpList: TList;
  BaseObject: TBaseObject;
  I: Integer;
  begin
    inherited;
    if ( m_btRaceServer in [187, 190, 192] ) then begin
      if ( (m_wStatusTimeArr[POISON_STUN] <> 0) ) then begin
        m_boAvoidMode := True;
        if (not m_boForcedApproach) then
          m_boApproach := False;
      end else begin
        if (not m_boForcedApproach) then
          m_boApproach := True;
        if Random(7 - OrcDangerLevel) = 0 then
          m_boAvoidMode := True
        else
          m_boAvoidMode := False;
      end;
    end;

    {$REGION 'OrcWarLord, ThrustFighter' }
    if (m_btRaceServer = 187) or (m_btRaceServer = 190) then begin
      //ThrustFighter seeking help if hp low
      if (m_wAbil.HP / m_wAbil.MaxHP * 5 <= 2) and (m_TargetCret <> nil) then begin
        HelpList := TList.Create;
        if (m_btRaceServer = 190) then
          GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 15, HelpList)
        else
          GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 7, HelpList);

        if HelpList.Count > 0 then begin
          for I := 0 to HelpList.Count - 1 do begin
            BaseObject := TBaseObject(HelpList.Items[i]);
            if (BaseObject <> self) and //Not Self
            (BaseObject.m_TargetCret <> m_TargetCret) and //no point if there target is already ours..
            (BaseObject.IsProperTarget(m_TargetCret)) and (BaseObject.m_btRaceServer in [188..194]) then begin //Target is proper
              if Random(2) = 0 then //Sometimes skip an object.
                Continue;
              BaseObject.m_TargetCret := m_TargetCret;
              BaseObject.m_dwSearchEnemyTick := GetTickCount();
              TOrcObject(BaseObject).m_nTargetX := m_nCurrX;
              TOrcObject(BaseObject).m_nTargetY := m_nCurrY;
              TOrcObject(BaseObject).GotoTargetXY;
            end;
          end;
        end;
        HelpList.Free;
      end;

      //ThrustFighter Special Attack
      if (Random(7 - OrcDangerLevel) = 0) //If our danger level is getting higher more chance to use.
      or ( (m_boAvoidMode) and (Random(3) = 0) ) then //If in avoidmode then high chance to use.
        m_boSpecialAttackMode1 := True
      else
        m_boSpecialAttackMode1 := False;
    end;
    {$ENDREGION}
  end;

  {$ENDREGION}

  {$REGION 'Monster: OrcSorcerer'}

  constructor TOrcSorcerer.Create;
  begin
    inherited;
    PriorityLevel := 3;
    m_dwHealingTick := GetTickCount();
    m_dwDelayTick := GetTickCount();
    m_boApproach := False;
    m_nViewRange := 7 + Random(2);
  end;

  procedure TOrcSorcerer.Run;
  begin
    if (CanPerformActions) then begin
      if (SCCheck > 0) then HealingAttacks();
      if (m_TargetCret <> nil) then begin
        if (not AttackTarget) then
          if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
            RangedWalkMode();
          end;
      end;
    end;
    inherited;
  end;

  function TOrcSorcerer.AttackTarget(): Boolean;
  var
    bt06: Byte;
    Dir: Integer;
    Casted: Boolean;
    Delay: Integer;
    Distance: Integer;
  begin
    Result := False;
    Casted := False;
    Delay := 0;
    if (m_TargetCret <> nil) then begin
      distance:=_Max(Abs(m_nCurrX - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
        if (Distance <= 12) then begin
        Dir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          if (MCCheck > 0) then begin
            if (not Casted) and CanPerform(3,Self) and
            (integer(GetTickCount - m_dwDelayTick) > m_nNextHitTime) then begin //FlameField
              MassAttack(0,3,Self); //Attack,Distance,ObjectDistance check.
              Delay := 0; //No Delay
              Casted := True;
            end;
            if Random(7 - OrcDangerLevel) = 0 then begin
              if (not Casted) and (CanPerform(4,m_TargetCret) or (Random(7 - OrcDangerLevel) = 0)) and
              (integer(GetTickCount - m_dwDelayTick) > m_nNextHitTime) then begin //Blizzard
                MassAttack(2,2,m_TargetCret); //Attack,Distance,ObjectDistance check.
                Delay := m_nNextHitTime * 5; //6 Attacks Delay Wait
                Casted := True;
              end;
            end else
              if (not Casted) and (CanPerform(4,m_TargetCret) or (Random(7 - OrcDangerLevel) = 0)) and
              (integer(GetTickCount - m_dwDelayTick) > m_nNextHitTime) then begin //MeteorStrike
                MassAttack(1,2,m_TargetCret); //Attack,Distance,ObjectDistance check.
                Delay := m_nNextHitTime * 4; //5 Attacks Delay Wait
                Casted := True;
              end;
          end; //McCheck
          if Casted then begin
            m_dwDelayTick := GetTickCount + Delay;
            m_dwHitTick := GetTickCount;
            m_dwTargetFocusTick := GetTickCount();
            Result := True;
          end else begin
            SingleAttack();
            m_dwHitTick := GetTickCount;
            m_dwTargetFocusTick := GetTickCount();
            Result := True;
          end;
        end;
      end;
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

  function TOrcSorcerer.CanPerform(AttackType: Integer; BaseObject: TBaseObject): Boolean;
  var
  boAttack: Boolean;
  begin
    boAttack := False;
    case AttackType of
      1: if (BaseObject.m_wAbil.HP / BaseObject.m_wAbil.MaxHP * 5 <= 3) then boAttack := True; //Healing
      2: begin //Purification
        if (BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0)
        or (BaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0)
        or (BaseObject.m_wStatusTimeArr[POISON_STONE] <> 0)
        or (BaseObject.m_wStatusTimeArr[POISON_SLOWDOWN] <> 0)
        or (BaseObject.m_wStatusTimeArr[POISON_FREEZE] <> 0)
        or (BaseObject.m_wStatusTimeArr[POISON_STUN] <> 0)
        or (BaseObject.m_dwStatusArrTimeOutTick[9] <> 0) then boAttack := True;
      end;
      3: begin //FlameField
        if (SurroundCount(BaseObject,3) >= 3) then boAttack := True;
      end;
      4: begin //MeteorStrike, Blizzard
        if (SurroundCount(BaseObject,2) >= 3) then boAttack := True;
      end;
      5: begin //EnergyShield
        if (BaseObject.m_btRaceServer in [187..194]) then begin
          if (BaseObject.m_wStatusTimeArr[STATE_ENERGYSHIELD] = 0) and
          ((BaseObject.m_wAbil.HP / BaseObject.m_wAbil.MaxHP * 5 <= 1) or
          ((TOrcObject(BaseObject).OrcDangerLevel >= 2) and
          (BaseObject.m_wAbil.HP / BaseObject.m_wAbil.MaxHP * 5 <= 2))) then boAttack := True;
        end;
      end;

    end;
    Result := boAttack;
  end;

  procedure TOrcSorcerer.Healing(Target: TBaseObject);
  var
  nPower: Integer;
  begin
    if Target <> nil then begin
      nPower := (HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
      //Send Magic
      if nPower > 0 then begin
        SendRefMsg(RM_SPELL,2,Target.m_nCurrX,Target.m_nCurrY,2,'');
        Target.SendDelayMsg(self, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
        SendRefMsg(RM_MAGICFIRE,0,MakeWord(2,2), MakeLong(Target.m_nCurrX,Target.m_nCurrY),Integer(Target),'');
      end;
    end;
  end;

  function TOrcSorcerer.GetPriorityHealingObject;
  var
  BaseObject: TBaseObject;
  I, II: Integer;
  ObjectList: TList;
  PriorityObject: TBaseObject;
  PriorityLevel2: Integer;
  LastPriorityLevel2: Integer;
  Distance: Integer;
  begin
    LastPriorityLevel2 := 0;
    PriorityObject := nil;

    ObjectList := TList.Create;
    GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 12, ObjectList);
    if ObjectList.Count > 0 then begin
      for I := 0 to ObjectList.Count - 1 do begin
        BaseObject := TBaseObject(ObjectList.Items[i]);
        distance:=_Max(Abs(m_nCurrX - BaseObject.m_nCurrX),Abs(m_nCurrY - BaseObject.m_nCurrY));
        PriorityLevel2 := 0;

        if (BaseObject <> nil) and not(BaseObject.m_boDeath) and not(BaseObject.m_boGhost) and
        (Distance <= 12) and
        (((BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (m_Master = nil) and (BaseObject.m_Master = nil))
        or ((m_Master <> nil) and ((m_Master = BaseObject) or (m_Master = BaseObject.m_Master)))) then begin
          if Random(5) = 0 then Continue; // Sometimes we wont bother with this object

          if (m_Master <> nil) then begin //if we have a master
            if (BaseObject = Self) then PriorityLevel2 := 4;
            if (BaseObject = m_Master) then PriorityLevel2 := 3;
            if (m_Master = BaseObject.m_Master) then PriorityLevel2 := 2;
          end else begin //if there was no master
            if BaseObject.m_btRaceServer in [187..194] then
              PriorityLevel2 := TOrcObject(BaseObject).PriorityLevel
              else
                PriorityLevel2 := 0;
          end; //objectslevels

          if CanPerform(1, BaseObject)
          or CanPerform(2, BaseObject)
          //or CanPerform(5, BaseObject) // temp removed energy shield
          then begin //if we can perform any of these on the object then begin
            if PriorityObject = nil then begin //if we had no priority object before.
              PriorityObject := BaseObject; //set target
              LastPriorityLevel2 := PriorityLevel2; //set there priority level to last one.
            end else begin //if we have a current priority object then start.
              if PriorityLevel2 > LastPriorityLevel2 then begin //if its over the last level.
              PriorityObject := BaseObject; //set target
              LastPriorityLevel2 := PriorityLevel2; //set there priority level to last one.
              end;
            end;
          end;
        end; //validobject
      end; //for
      ObjectList.Free;
    end; //count
    Result := PriorityObject;
  end;

  procedure TOrcSorcerer.HealingAttacks;
  var
  BaseObject: TBaseObject;
  begin
    if ((Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) and
    (Integer(GetTickCount - m_dwHealingTick) > m_nNextHitTime * 5))
    //Heal targets faster if we have no target..
    or ((m_TargetCret = nil) and
    (Integer(GetTickCount - m_dwHealingTick) > m_nNextHitTime * 2) and
    (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) ) then begin

      BaseObject := GetPriorityHealingObject; //Get our most prioritised object.
      if BaseObject <> nil then begin
        //Energy shield(currently cripples there range of attacks to use if performed)
        {if CanPerform(5, BaseObject) then begin //temp removed energy shield
          EnergyShield(BaseObject);
          m_dwHitTick := GetTickCount();
          m_dwHealingTick := GetTickCount + m_nNextHitTime * 9; //Next healing attacks in 10 moves
          m_dwDelayTick := GetTickCount + m_nNextHitTime * 9; //Next Magic Attacks in 10 moves
          exit;
        end;}
        if CanPerform(2, BaseObject) then begin
          Purify(BaseObject);
          m_dwHitTick := GetTickCount();
          m_dwHealingTick := GetTickCount();
          exit;
        end;
        if CanPerform(1, BaseObject) then begin
          Healing(BaseObject);
          m_dwHitTick := GetTickCount();
          m_dwHealingTick := GetTickCount();
          exit;
        end;
      end;
    end;
  end;

  procedure TOrcSorcerer.Purify(Target: TBaseObject);
  var
  nPower: Integer;
  begin
    if Target <> nil then begin
      SendRefMsg(RM_SPELL,40,Target.m_nCurrX,Target.m_nCurrY,34,'');
      if (Target.m_wStatusTimeArr[POISON_DECHEALTH] <> 0) then
        Target.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
      if (Target.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0) then
        Target.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
      if (Target.m_wStatusTimeArr[POISON_STONE] <> 0) then
        Target.m_wStatusTimeArr[POISON_STONE] := 1;
      if (Target.m_wStatusTimeArr[POISON_SLOWDOWN] <> 0) then
        Target.m_wStatusTimeArr[POISON_SLOWDOWN] := 1;
      if (Target.m_wStatusTimeArr[POISON_FREEZE] <> 0) then
        Target.m_wStatusTimeArr[POISON_FREEZE] := 1;
      if (Target.m_wStatusTimeArr[POISON_STUN] <> 0) then
        Target.m_wStatusTimeArr[POISON_STUN] := 1;
      if (Target.m_dwStatusArrTimeOutTick[9] <> 0) then
        Target.m_dwStatusArrTimeOutTick[9] := 1;

      SendRefMsg(RM_MAGICFIRE,0,MakeWord(2,40), MakeLong(Target.m_nCurrX,Target.m_nCurrY),Integer(Target),'');
    end;
  end;

  procedure TOrcSorcerer.EnergyShield(Target: TBaseObject);
  var
  nPower: Integer;
  SpellLevel: Integer;
  begin
    if Target <> nil then begin
      SpellLevel := 0;
      nPower := (HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
      if nPower > 0 then begin
        if OrcDangerLevel >= 2 then
          SpellLevel := OrcDangerLevel - 2
        else
          SpellLevel := 0;

        SendRefMsg(RM_SPELL,67,Target.m_nCurrX,Target.m_nCurrY,78,'');
        SendRefMsg(RM_MAGICFIRE,0,MakeWord(4,67), MakeLong(Target.m_nCurrX,Target.m_nCurrY),Integer(Target),'');
        Target.MagBubbleDefenceUp(SpellLevel, nPower, STATE_ENERGYSHIELD);
      end;
    end;
  end;

  procedure TOrcSorcerer.SingleAttack;
  var
  nPower: Integer;
  begin
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendRefMsg(RM_SPELL,130,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,44,'');
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
      if nPower > 0 then begin
        if Random(g_Config.nMagicResistanceRate + 30) >= m_TargetCret.m_nAntiMagic then begin
          SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY), 2, Integer(m_TargetCret), '', 600);
        end;
      end;
      SendRefMsg(RM_MAGICFIRE,0,MakeWord(1,130), MakeLong(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY),Integer(m_TargetCret),'');
    end;
  end;

  procedure TOrcSorcerer.MassAttack(AttackType, Distance: Integer; BaseObject: TBaseObject);
  var
  I, II: Integer;
  nPower: Integer;
  FlameObject: TBaseObject;
  FlameList: TList;
  Effect, EffectType, EffectID, AttackAmmount: Integer;
  nActualSlowChance: Integer;
  begin
    case AttackType of
      0: begin
        EffectID := 47;
        Effect := 45;
        EffectType := 2;
        AttackAmmount := 1;
      end;
      1: begin
        EffectID := 57;
        Effect := 49;
        EffectType := 2;
        AttackAmmount := 1 + Random(4);
      end;
      2: begin
        EffectID := 66;
        Effect := 58;
        EffectType := 2;
        AttackAmmount := 1 + Random(4);
      end;
    end;;
    if m_TargetCret <> nil then begin
      nPower := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      FlameList := TList.Create;
      GetMapBaseObjects(m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, Distance, FlameList);
      SendRefMsg(RM_SPELL,Effect,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,EffectID,'');
      if (FlameList.Count > 0) then begin
        for I := 0 to FlameList.Count - 1 do begin
          FlameObject := TBaseObject(FlameList.Items[i]);
          if (IsProperTarget(FlameObject)) and not
          (FlameObject.m_boDeath) and not
          (FlameObject.m_boGhost) then begin
            if nPower > 0 then
            for II := 1 to AttackAmmount do begin
              SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(FlameObject.m_nCurrX, FlameObject.m_nCurrY), 2, Integer(FlameObject), '', 400 * II);
              if AttackType = 2 then
                if (FlameObject.m_wStatusTimeArr[POISON_SLOWDOWN] = 0) then begin
                  nActualSlowChance := Round((m_Abil.Level / 10) * 3);
                  nActualSlowChance := nActualSlowChance - Round((nActualSlowChance / 100) * FlameObject.m_btSlowResist);
                  if Random(20) < nActualSlowChance then
                    FlameObject.MakePosion(POISON_SLOWDOWN, 3 + Random(4), 0)
                end;
            end;
          end;
        end;
      end;
      FlameList.Free;
      //Send MagicFireImages
      SendRefMsg(RM_MAGICFIRE,0,MakeWord(EffectType,Effect), MakeLong(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY),Integer(m_TargetCret),'');
    end;
  end;

  procedure TOrcSorcerer.OrcStratergy;
  begin
    inherited;
  end;

  {$ENDREGION}

  {$REGION 'Monster: OrcGiant' }

  constructor TOrcGiant.Create;
  begin
    inherited;
    PriorityLevel := 4;
    m_dwAttackTick[1] := GetTickCount();
    m_dwAttackTick[2] := GetTickCount();
    m_dwAttackTick[3] := GetTickCount();
    m_nViewRange := 12;
  end;

  procedure TOrcGiant.Run;
  var
  boCasted: Boolean;
  Distance: Integer;
  begin
    boCasted := False;
    if (CanPerformActions) then begin
      if (m_TargetCret <> nil) then begin
        distance:=_Max(Abs(m_nCurrX - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
          if ((SurroundCount(Self, 5) >= 3) and (Random(10 - OrcDangerLevel) = 0))
          or ((SurroundCount(Self, 5) >= 1) and (Integer(GetTickCount - m_dwAttackTick[3]) > m_nNextHitTime * 5)) then begin
            ExplosionAttack(5);
            m_dwAttackTick[3] := GetTickCount();
          end else
          if (CanPlagueWind(8,1) and (Random(10 - OrcDangerLevel) = 0))
          or (CanPlagueWind(8,2) and (Integer(GetTickCount - m_dwAttackTick[1]) > m_nNextHitTime * 3)) then begin
            PlagueWind(8);
            m_dwAttackTick[1] := GetTickCount();
          end else
          if GetAttackDir(m_targetCret, m_btDirection) and
          (Integer(GetTickCount - m_dwAttackTick[2]) > m_nNextHitTime * 3) then begin
            StunStomp();
            m_dwAttackTick[2] := GetTickCount();
          end else begin
            if (Distance <= 6) then begin
              SmashAttack(3,3);
            end;
          end;
          m_dwHitTick := GetTickCount();
        end;
      end;
    end;
    inherited;
  end;

  procedure TOrcGiant.StunStomp;
  var
  ObjectList: TList;
  I: Integer;
  BaseObject: TBaseObject;
  nPower, nFinalPower: Integer;
  begin
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));

      ObjectList := TList.Create;
      GetMapBaseObjects(m_PEnvir,m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 1, ObjectList);
      if ObjectList.Count > 0 then begin
        for I := 0 to ObjectList.Count - 1 do begin
          BaseObject := TBaseObject(ObjectList.Items[i]);
          if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
            nFinalPower := BaseObject.GetStunDamage(self,nPower);
            nFinalPower := BaseObject.GetHitStruckDamage(self,nFinalPower);
            if nFinalPower > 0 then begin
              BaseObject.StruckDamage(nFinalPower, Self);
              BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nFinalPower, BaseObject.m_WAbil.HP,
              BaseObject.m_WAbil.MaxHP, Integer(Self), '', 600);
              if (Random(6 - OrcDangerLevel) = 0) then begin //Chance to stun/stone
                BaseObject.MakePosion(POISON_STUN, 3 + OrcDangerLevel, 0); //Stun
                BaseObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 34, '');

                if (Random(10 - OrcDangerLevel) = 0) then //Stone
                  BaseObject.MakePosion(POISON_STONE, 3 + OrcDangerLevel, 0);
              end;
            end;
          end;
        end;
      end;
      ObjectList.Free;
    end;
  end;

  function TOrcGiant.CanPlagueWind(Distance, NeedCount: Integer): Boolean;
  var
    I, II: Integer;
    nX, nY: Integer;
    Count: Integer;
    BaseObject: TBaseObject;
    CanPlagueWind: Boolean;
  begin
    try
      Count := 0;
      CanPlagueWind := False;
      if m_TargetCret <> nil then begin
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        for II := 1 to Distance do begin
          for I := 0 to 2 do begin
            if I = 0 then begin //Line 1
              if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, II, nX, nY) then
                BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            end;
            if I = 1 then begin //Line 2
              if m_PEnvir.GetNextPosition(m_nCurrX +
              Line2XY[m_btDirection,0], m_nCurrY +
              Line2XY[m_btDirection,1], m_btDirection, II, nX, nY) then
                BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            end;
            if I = 2 then begin //Line 3
              if m_PEnvir.GetNextPosition(m_nCurrX +
              Line3XY[m_btDirection,0], m_nCurrY +
              Line3XY[m_btDirection,1], m_btDirection, II, nX, nY) then
                BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            end;
            if (BaseObject <> nil) and
            IsProperTarget(BaseObject) and
            (BaseObject <> Self) then
              inc(Count,1);
          end;
        end;
      end;
    if Count >= NeedCount then
      CanPlagueWind := True;

    Result := CanPlagueWind;
    except
      on e: Exception do
      MainOutMessage('[TOrcGiant.CanPlagueWind] ' + e.Message);
    end;
  end;

  procedure TOrcGiant.PlagueWind(Distance: Integer);
  var
    I, II: Integer;
    nX, nY: Integer;
    nPower: Integer;
    DragDirection: Integer;
    BaseObjectDistance: Integer;
    BaseObject: TBaseObject;
  begin
    try
      nPower := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      if m_TargetCret <> nil then begin
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        DragDirection := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
        SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
        for II := 1 to Distance do begin
          for I := 0 to 2 do begin
            if I = 0 then begin //Line 1
              if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, II, nX, nY) then
                BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            end;
            if I = 1 then begin //Line 2
              if m_PEnvir.GetNextPosition(m_nCurrX +
              Line2XY[m_btDirection,0], m_nCurrY +
              Line2XY[m_btDirection,1], m_btDirection, II, nX, nY) then
                BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            end;
            if I = 2 then begin //Line 3
              if m_PEnvir.GetNextPosition(m_nCurrX +
              Line3XY[m_btDirection,0], m_nCurrY +
              Line3XY[m_btDirection,1], m_btDirection, II, nX, nY) then
                BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
            end;
            if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
              if nPower > 0 then begin
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 1000);

                //Dragging
                BaseObjectDistance:=_Max(Abs(m_nCurrX - BaseObject.m_nCurrX),Abs(m_nCurrY - BaseObject.m_nCurrY));
                if Random(2) = 0 then
                  BaseObject.CharPushed(DragDirection,1 + Random(BaseObjectDistance));

                //Poisons
                if (Random(50) > BaseObject.m_btAntiPoison) and (Random(3) = 0) then BaseObject.MakePosion(POISON_SLOWDOWN, 1 + Round((nPower div 100) * 5), 0);
                if (Random(50) > BaseObject.m_btAntiPoison) and (Random(2) = 0) then BaseObject.MakePosion(POISON_DECHEALTH, Round((nPower div 10) * 5), Round((nPower div 20) * 5));
                if (Random(50) > BaseObject.m_btAntiPoison) and (Random(2) = 0) then BaseObject.MakePosion(POISON_DAMAGEARMOR, Round((nPower div 10) * 5), 0);
                if (Random(50) > BaseObject.m_btAntiPoison) and (Random(5) = 0) then BaseObject.MakePosion(POISON_STONE, 1 + Round((nPower div 100) * 5), 0);
              end;
            end;
          end;
        end;
      end;
    except
      on e: Exception do
      MainOutMessage('[TOrcGiant.PlagueWind] ' + e.Message);
    end;
  end;

  procedure TOrcGiant.ExplosionAttack(Distance: Integer);
  var
  ObjectList: TList;
  I: Integer;
  BaseObject: TBaseObject;
  nPower, nFinalPower: Integer;
  begin
    if m_TargetCret <> nil then begin
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendAttackMsg(RM_HIT, SM_HIT_4, m_btDirection, m_nCurrX, m_nCurrY);
      nPower := (HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);

      ObjectList := TList.Create;
      GetMapBaseObjects(m_PEnvir,m_nCurrX, m_nCurrY, Distance, ObjectList);
      if ObjectList.Count > 0 then begin
        for I := 0 to ObjectList.Count - 1 do begin
          BaseObject := TBaseObject(ObjectList.Items[i]);
          if (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
            if nPower > 0 then
              SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 1000);
          end;
        end;
      end;
      ObjectList.Free;
    end;
  end;

  {$ENDREGION} //OrcGiant

  {$REGION 'OrcWarLord'}

  constructor TOrcWarLord.Create;
  begin
    inherited;
    PriorityLevel := 5;
    m_dwAttackTick[1] := GetTickCount();
    m_dwAttackTick[2] := GetTickCount();
    m_nViewRange := 15;
  end;

  procedure TOrcWarLord.Run;
  var
  boCasted: Boolean;
  Distance: Integer;
  begin
    boCasted := False;
    if (CanPerformActions) then begin
      if (m_TargetCret <> nil) then begin
        distance:=_Max(Abs(m_nCurrX - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin

          if (Distance <= 8) //Explosion
          and ((Integer(GetTickCount - m_dwAttackTick[1]) > m_nNextHitTime * 5)
          or (Random(13 - OrcDangerLevel) = 0)) then begin
            m_dwAttackTick[1] := GetTickCount();
            SmashAttack(2, 6);
          end else //Thrusting
          if (CanThrust(2,7) and (Integer(GetTickCount - m_dwAttackTick[2]) > m_nNextHitTime * 3 + Random(2)))
          or ((CanThrust(1,7)) and ((Random(10 - OrcDangerLevel) = 0) or (m_boSpecialAttackMode1))) then begin
            m_dwAttackTick[2] := GetTickCount();
            ThrustAttack(7);
          end else //HalfMoon
          if (CanHalfMoon(1)) then begin
            HalfMoonAttack();
          end;
          m_dwHitTick := GetTickCount();
        end;
      end;
    end;
    inherited;
  end;

  {$ENDREGION}
{$ENDREGION} //Orc Monsters Region

{$REGION 'Ice Monsters' }

{$REGION 'IceObject' }

  constructor TIceObject.Create;
  begin
    inherited;
    m_boAnimal := False;
  end;

  destructor TIceObject.Destroy;
  begin
    inherited;
  end;

  procedure TIceObject.Run;
  var
    nBackX, nBackY, nDir: Integer;
  begin
  try
    if (CanPerformActions) then begin
      if (m_TargetCret <> nil) then begin
        nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
          IceStrategy();
          m_dwHitTick := GetTickCount;
        end;
      end;
    end;
    inherited;
  except
    on e: Exception do
      MainOutMessage('[TIceObject.Run] ' + e.Message);
  end;
  end;

  procedure TIceObject.IceStrategy;
  begin
    AttackTarget();
  end;

  procedure TIceObject.IcePassThroughMagic(sX, sY, tx, ty, nDir, magpwr, distance: Integer; boPushBack: Boolean);
  var
    i, nPosCount, nDistance: Integer;
    BaseObject: TBaseObject;
  begin
  try
    nPosCount := distance;
    for i := 0 to 12 do begin
      BaseObject := TBaseObject(m_PEnvir.GetMovingObject(sX, sY, True));
      if BaseObject <> nil then begin
        if IsProperTarget(BaseObject) then begin
          if Random(g_Config.nMagicResistanceRate) >= BaseObject.m_nAntiMagic then begin
            BaseObject.SendDelayMsg(Self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
            if (Random(40) < 5) then begin
              if (Random(40) <= 3) then
                BaseObject.MakePosion(POISON_FREEZE,5,0)
              else
                BaseObject.MakePosion(POISON_SLOWDOWN,6,0);
            end;
            if boPushBack then begin
              nDistance := distance - nPosCount;
              if BaseObject.m_WAbil.Level <= (m_WAbil.Level - 2) then
                BaseObject.CharPushed(m_btDirection, nDistance);
            end;
          end;
        end;
      end;
      if not ((abs(sX - tx) <= 0) and (abs(sY - ty) <= 0)) then begin
        nDir := GetNextDirection(sX, sY, tx, ty);
        if not m_PEnvir.GetNextPosition(sX, sY, nDir, 1, sX, sY) then
          break;
      end else
        break;
      Dec(nPosCount);
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceObject.IcePassThroughMagic] ' + e.Message);
  end;
  end;

  procedure TIceObject.IceLightning(nDistance: Integer);
  var
    nAttackDir, i, nBackDir, nStartX, nStartY, nEndX, nEndY, magpwr: Integer;
    BaseObject: TBaseObject;
  begin
  try
    if m_TargetCret = nil then exit;
    nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    m_btDirection := nAttackDir;
    SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
    if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 1, nStartX, nStartY) then begin
      magpwr :=  (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
      magpwr := magpwr + Random(magpwr);
      m_PEnvir.GetNextPosition(nStartX, nStartY, m_btDirection, nDistance, nEndX, nEndY);
      IcePassThroughMagic(nEndX, nEndY, nStartX, nStartY, m_btDirection, magpwr, nDistance, True);
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceObject.IceLightning] ' + e.Message);
  end;
  end;

  procedure TIceObject.IceShards(nRange: Integer);
  var
    nAttackDir, i, magpwr: Integer;
    BaseObject: TBaseObject;
    xTargetList: TList;
  begin
  try
    if m_TargetCret = nil then exit;
    nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    m_btDirection := nAttackDir;
    SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
    xTargetList := TList.Create;
    GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,nRange,xTargetList);

    if (xTargetList.Count>0) then begin
      for i:=xTargetList.Count-1 downto 0 do begin
        BaseObject := TBaseObject(xTargetList.Items[i]);
        if BaseObject <> nil then begin
          if IsProperTarget (BaseObject) then begin
            magpwr:=(HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
            if (Random(40) < 5) then begin
              if (Random(40) <= 3) then
                BaseObject.MakePosion(POISON_FREEZE,5,0)
              else
                BaseObject.MakePosion(POISON_SLOWDOWN,6,0);
            end;
          end;
          xTargetList.Delete(i);
        end;
      end;
    end;
    xTargetList.Free;
  except
    on e: Exception do
      MainOutMessage('[TIceObject.IceShards] ' + e.Message);
  end;
  end;

{$ENDREGION}

{$REGION 'IceDemon' }

  procedure TIceDemon.IceStrategy;
  begin
  try
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
      if Random(5) = 0 then
        IceThrust()
      else
        AttackTarget();
    end else begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 5) then
        IceThrust()
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceDemon.IceStrategy] ' + e.Message);
  end;
  end;

  procedure TIceDemon.IceThrust();
  var
    magpwr, nStartX, nStartY, nEndX, nEndY, nAttackDir: Integer;
    procedure DoDamage(nCurrX, nCurrY: Integer);
    begin
      if m_PEnvir.GetNextPosition(nCurrX, nCurrY, m_btDirection, 1, nStartX, nStartY) then begin
        magpwr := (HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
        m_PEnvir.GetNextPosition(nStartX, nStartY, m_btDirection, 4, nEndX, nEndY);
        IcePassThroughMagic(nStartX, nStartY, nEndX, nEndY, m_btDirection, magpwr, 4, False);
      end;
    end;
  begin
  try
    if m_TargetCret = nil then exit;
    nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    m_btDirection := nAttackDir;
    SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
    DoDamage(m_nCurrX, m_nCurrY);
    case m_btDirection of
      DR_UP, DR_DOWN: begin
        DoDamage(m_nCurrX + 1, m_nCurrY);
        DoDamage(m_nCurrX - 1, m_nCurrY);
      end;
      DR_UPRIGHT: begin
        DoDamage(m_nCurrX, m_nCurrY - 1);
        DoDamage(m_nCurrX + 1, m_nCurrY);
      end;
      DR_RIGHT, DR_LEFT: begin
        DoDamage(m_nCurrX, m_nCurrY + 1);
        DoDamage(m_nCurrX, m_nCurrY - 1);
      end;
      DR_DOWNRIGHT: begin
        DoDamage(m_nCurrX, m_nCurrY + 1);
        DoDamage(m_nCurrX + 1, m_nCurrY);
      end;
      DR_DOWNLEFT: begin
        DoDamage(m_nCurrX, m_nCurrY + 1);
        DoDamage(m_nCurrX - 1, m_nCurrY);
      end;
      DR_UPLEFT: begin
        DoDamage(m_nCurrX, m_nCurrY - 1);
        DoDamage(m_nCurrX - 1, m_nCurrY);
      end;
    end;
    BreakHolySeizeMode();
  except
    on e: Exception do
      MainOutMessage('[TIceObject.IceThrust] ' + e.Message);
  end;
  end;

{$ENDREGION}

{$REGION 'IceDemon2' }

  procedure TIceDemon2.IceStrategy;
  begin
  try
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
      if Random(5) = 0 then
        IceLightning(3)
      else
        AttackTarget();
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceDemon2.IceStrategy] ' + e.Message);
  end;
  end;

{$ENDREGION}

{$REGION 'IceCommander' }

  procedure TIceCommander.IceStrategy;
  begin
  try
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
      if Random(4) = 0 then
        Repulse()
      else if Random(8) = 0 then
        IceShards(4)
      else
        AttackTarget();
    end else begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then begin
        if Random(2) = 0 then
          IceShards(4)
      end;
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceCommander.IceStrategy] ' + e.Message);
  end;
  end;

  procedure TIceCommander.Repulse();
  var
    nAttackDir, i, nBackDir: Integer;
    BaseObject: TBaseObject;
  begin
  try
    if m_TargetCret = nil then exit;
    nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    m_btDirection := nAttackDir;
    SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);

    for i:=0 to m_TargetCret.m_VisibleActors.Count-1 do begin
      BaseObject:= TBaseOBject (pTVisibleBaseObject(m_TargetCret.m_VisibleActors[i]).BaseObject);
      if (abs(m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin
        if BaseObject <> nil then begin
          if IsProperTarget (BaseObject) then begin
            nBackDir := GetNextDirection(m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
            if BaseObject.m_WAbil.Level <= (m_WAbil.Level - 2) then
              BaseObject.CharPushed(nBackDir, 3);
          end;
        end;
      end;
    end;
    if Random(2) = 0 then
      IceShards(4);
  except
    on e: Exception do
      MainOutMessage('[TIceObject.Repulse] ' + e.Message);
  end;
  end;

{$ENDREGION}

{$REGION 'IceGeneral' }

  procedure TIceGeneral.IceStrategy;
  var
    nSecPwr: Integer;
  begin
  try
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin
      if Random(4) = 0 then
        IceLightning(8)
      else if Random(8) = 0 then
        IceShards(12)
      else begin
        AttackTarget();
        nSecPwr := GetAttackPower(LoWord(m_WAbil.DC), SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
        nSecPwr := m_TargetCret.GetStunDamage(Self, nSecPwr);
        nSecPwr := m_TargetCret.GetHitStruckDamage(Self, nSecPwr, True);
        if (isProperTarget(m_TargetCret)) and (nSecPwr > 0) then begin
          m_TargetCret.StruckDamage(nSecPwr, Self);
          m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nSecPwr, m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 500);
        end;
      end;
    end else begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 7) then begin
        if Random(12) = 0 then
        IceLightning(8)
      end;
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceGeneral.IceStrategy] ' + e.Message);
  end;
  end;

  function TIceGeneral.Operate(ProcessMsg:pTProcessMessage):boolean;
  begin
    if (ProcessMsg.wIdent = RM_POISON) then begin
      IceShards(12);
    end;
    Result:=inherited Operate(ProcessMsg);
  end;

{$ENDREGION}

{$REGION 'IceSorcererObject' }

  constructor TIceSorcererObject.Create;
  begin
    inherited;
  end;

  destructor TIceSorcererObject.Destroy;
  begin
    inherited;
  end;

  procedure TIceSorcererObject.IceStrategy;
  begin
    inherited AttackTarget;
  end;

  function TIceSorcererObject.AttackTarget: Boolean; //00459B14
  begin
  try
    if m_TargetCret = nil then exit;
    if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
      m_dwHitTick := GetTickCount;
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 12) then begin
        IceStrategy();
      end;
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceSorcererObject.AttackTarget] ' + e.Message);
  end;
  end;

  procedure TIceSorcererObject.FrostCrunch();
  var
    magpwr:Integer;
    nAttackDir: Integer;
  begin
  try
    if m_TargetCret = nil then exit;
    nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    m_btDirection := nAttackDir;
    SendAttackMsg(RM_HIT, SM_HIT_2, m_btDirection, m_nCurrX, m_nCurrY);
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');

    if IsProperTarget (m_TargetCret) then begin
      magpwr:=(HiWord(m_WAbil.SC) div 2) + Random(HiWord(m_WAbil.SC) div 2);
      m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);

      if (Random(40) < 5) then begin
        if (Random(40) <= 3) then
          m_TargetCret.MakePosion(POISON_FREEZE,5,0)
        else
          m_TargetCret.MakePosion(POISON_SLOWDOWN,6,0);
      end;
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceSorcererObject.FrostCrunch] ' + e.Message);
  end;
  end;

  procedure TIceSorcererObject.IceStorm();
  var
    I, nAttackDir:Integer;
    magpwr:Integer;
    BaseObject:TBaseObject;
  begin
  try
    if m_TargetCret = nil then exit;
    nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    m_btDirection := nAttackDir;
    SendAttackMsg(RM_HIT, SM_HIT_3, m_btDirection, m_nCurrX, m_nCurrY);
    SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

    for i:=0 to m_TargetCret.m_VisibleActors.Count-1 do begin
      BaseObject:= TBaseOBject (pTVisibleBaseObject(m_TargetCret.m_VisibleActors[i]).BaseObject);
      if (abs(m_TargetCret.m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(m_TargetCret.m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin
        if BaseObject <> nil then begin
          if IsProperTarget (BaseObject) then begin
            magpwr:=(HiWord(m_WAbil.MC) div 2) + Random(HiWord(m_WAbil.MC) div 2);
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
          end;
        end;
      end;
    end;
  except
    on e: Exception do
      MainOutMessage('[TIceSorcererObject.IceStorm] ' + e.Message);
  end;
  end;

  procedure TIceSorcererObject.Run;
  var
    nDir: Integer;
  begin
  try
    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;

    if (CanPerformActions) then begin
      if m_TargetCret <> nil then begin
        if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) then begin
            m_dwWalkTick := GetTickCount();
            nDir := GetNextDirection(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_nCurrX, m_nCurrY);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nDir, 3, m_nTargetX, m_nTargetY);
            GotoTargetXY;
          end;
        end;
      end;
    end;
    inherited;
  except
    on e: Exception do
      MainOutMessage('[TIceSorcererObject.Run] ' + e.Message);
  end;
  end;

{$ENDREGION}

{$REGION 'FrostCrunchSorcerer' }

procedure TFrostCrunchSorcerer.IceStrategy;
begin
  FrostCrunch;
end;

{$ENDREGION}

{$REGION 'IceStormSorcerer' }

procedure TIceStormSorcerer.IceStrategy;
begin
  IceStorm;
end;

{$ENDREGION}

{$REGION 'IceStormSorcerer' }

procedure TFCISSorcerer.IceStrategy;
begin
  if Random(2) = 0 then
    IceStorm
  else
    FrostCrunch;
end;

{$ENDREGION}

{$REGION 'IceNodeObject' }

procedure TIceNode.Run;
begin
  if (not m_boDeath) and (not m_boGhost) then begin
    if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
      m_dwHitTick:=GetTickCount();
      if m_btRaceServer = 202 then
        IceShards(2);
    end;
    if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
      m_dwWalkTick:=GetTickCount();
    end;
  end;
  inherited;
end;

{$ENDREGION}

 {$ENDREGION}

end.
