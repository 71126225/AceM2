unit Magic;

interface
uses
  Windows, Classes, Grobal2, ObjBase, SysUtils, ObjPlay, Math;
type
  TMagicManager = class
private
public
  constructor     Create();
  destructor      Destroy; override;
  function        MagMakePrivateTransparent                 (BaseObject: TBaseObject; nHTime:Integer): Boolean;
  function        DoSpell                                   (PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX,nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  function        MagBigHealing                             (PlayObject: TBaseObject; nPower, nX, nY, nMagID: Integer):Boolean;
  function        MagPushArround                            (PlayObject: TBaseObject; nMagID, nPushLevel: Integer):Integer;
  function        MagTurnUndead                             (BaseObject, TargeTBaseObject: TBaseObject; nTargetX,nTargetY: Integer; nLevel: Integer): Boolean;
  function        MagMakeHolyCurtain                        (BaseObject: TBaseObject; nPower: Integer; nX,nY: Integer): Integer;
  function        MagMakeGroupTransparent                   (BaseObject: TBaseObject; nX, nY: Integer;nHTime, nMagID: Integer): Boolean;
  function        MagTamming                                (BaseObject, TargeTBaseObject: TBaseObject; nTargetX,nTargetY: Integer; nMagicLevel: Integer): Boolean;
  function        MagSaceMove                               (BaseObject: TBaseObject; nLevel: Integer): Boolean;
  function        MagMakeFireCross                          (PlayObject: TPlayObject; nDamage, nHTime, nX, nY:Integer): Integer;
  function        MagMakePoisonCloud                        (PlayObject: TPlayObject; nDamage, nHTime, nX, nY:Integer; UserMagic: pTUserMagic): Integer;
  function        MagMakePoisonField                        (PlayObject: TPlayObject; UserMagic: pTUserMagic; nX, nY:Integer): Integer;
  function        MagMassRangeDamage                        (user_object: TBaseObject; damage_of_effect, cursor_x, cursor_y, type_of_effect: Integer; user_magic: pTUserMagic): Boolean;
  function        MagBigExplosionTime                       (BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage, nMagID: Integer): Boolean;
  function        MagBigExplosionAndMakePoisonByWarr        (BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer; var boMove: Boolean): Boolean;
  function        MagBigExplosionAndMakePoison              (BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
  function        MagBigExplosionAndMakePoisonEx            (BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
  function        MagDoubleBigExplosion                     (BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean;
  function        MagDoubleBigExplosionEx                   (PlayObject: TPlayObject; nPower, nX, nY, nRage: Integer; UserMagic: pTUserMagic; boDecMP: Boolean): Boolean;
  function        MagUltimateEnhance                        (PlayObject: TPlayObject; TargetBaseObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
  function        MagMassDamageAroundUser                   (user_object: TBaseObject; damage_of_effect, magic_id, type_of_effect: Integer): Boolean;
  function        MabMabe                                   (BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,nTargetX, nTargetY, nMagID: Integer): Boolean;
  function        MagMakeSlave                              (PlayObject: TPlayObject; UserMagic: pTUserMagic):Boolean;
  function        MagMakeSelf                               (BaseObject, TargeTBaseObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
  function        MagMakeSinSuSlave                         (PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
  function        MagMakeMoonSlave                          (PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
  function        MagWindTebo                               (PlayObject: TPlayObject; UserMagic: pTUserMagic):Boolean;
  function        MagGroupLightening                        (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire:Boolean): Boolean;
  function        MagGroupAmyounsul                         (PlayObject: TPlayObject;UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject:TBaseObject): Boolean;
  function        MagGroupDeDing                            (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  function        MagGroupMb                                (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  function        MagHbFireBall                             (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY, nPower: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagWideAttack                             (PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
  function        MagReturn                                 (BaseObject, TargeTBaseObject: TBaseObject; nTargetX,nTargetY, nMagicLevel: Integer): Boolean;
  function        MagLightening                             (PlayObject: TPlayObject;UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject:TBaseObject): Boolean;
  function        MagMakeSuperFireCross                     (PlayObject: TPlayObject; nDamage, nHTime, nX,nY: Integer; nCount: Integer): Integer;
  function        MagMakeFireball                           (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeCBOBase                            (PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeHealing                            (PlayObject: TPlayObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeHellFire                           (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeQuickLighting                      (PlayObject: TPlayObject; UserMagic:pTUserMagic; var nTargetX, nTargetY: Integer; TargeTBaseObject:TBaseObject): Boolean;
  function        MagMakeLighting                           (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeFireCharm                          (PlayObject: TBaseObject;UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject:TBaseObject; boMove: Boolean): Boolean;
  function        MagMakeFireCharmEx                        (PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer;var TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeUnTreatment                        (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeLivePlayObject                     (PlayObject: TPlayObject; UserMagic:pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
  function        MagChangePosition                         (PlayObject: TPlayObject; nTargetX, nTargetY:Integer; TargeTBaseObject: TBaseObject): Boolean;
  function        MagMakeFireDay                            (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagVampire                                (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  function        MagGroupFengPo                            (PlayObject: TPlayObject; UserMagic: pTUserMagic;nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  function        MagTamming2                               (BaseObject, TargeTBaseObject: TBaseObject; nTargetX,nTargetY, nMagicLevel: Integer): Boolean;
  function        MagEntrapment                             (PlayObject:TPlayObject;TargeTBaseObject:TBaseObject;UserMagic:pTUserMagic): Boolean;
  function        MagEnergyShield                           (user_object: TPlayObject; duration_of_effect: Integer; type_of_effect: Byte; user_magic: pTUserMagic; target_object: TBaseObject): Boolean;
  function        MagHaste                                  (PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
  function        MagLightBody                              (PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
  function        MagHeavenlySword                          (PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
  function        MagTrap                                   (PlayObject: TPlayObject; TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nPower: Integer): Boolean;
  end;
  function        MPow                                      (UserMagic: pTUserMagic): Integer;
  function        GetPower                                  (nPower: Integer; UserMagic: pTUserMagic): Integer;
  function        GetPower13                                (nInt: Integer; UserMagic: pTUserMagic): Integer;
  function        GetRPow                                   (wInt: Integer): Word;
  function        CheckAmulet                               (PlayObject: TBaseObject; nCount: Integer; nType: Integer): Boolean;
  procedure       UseAmulet                                 (PlayObject: TBaseObject; nCount: Integer; nType: Integer);
  function        GetAmuletType                             (PlayObject: TBaseObject): Byte;

implementation

uses HUtil32, M2Share, Event, Envir{$IFDEF PLUGOPEN}, PlugOfEngine{$ENDIF};

function MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;

function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
    Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
end;

function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
var
  d10: Double;
  d18: Double;
begin
  d10 := nInt / 3.0;
  d18 := nInt - d10;
  Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 +
  (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
end;

function GetRPow(wInt: Integer): Word;
begin
  if HiWord(wInt) > LoWord(wInt) then begin
    Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
  end else
    Result := LoWord(wInt);
end;

function GetAmuletType(PlayObject: TBaseObject): Byte;
var
  AmuletStdItem: pTStdItem;
begin
  Result := 0;
  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = tm_Amulet) then begin
      Result := AmuletStdItem.Shape;
    end;
  end;
end;

function CheckAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer): Boolean;
var
  AmuletStdItem: pTStdItem;
begin
  Result := False;
  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = tm_Amulet) then begin
      case nType of
        1: begin
          if (AmuletStdItem.Shape = 5) and (PlayObject.m_UseItems[U_BUJUK].Dura >= nCount) then begin
            Result := True;
            Exit;
          end;
        end;
        2: begin
          if (AmuletStdItem.Shape <= 2) and (PlayObject.m_UseItems[U_BUJUK].Dura >= nCount) then begin
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure UseAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer);
begin
  if PlayObject.m_UseItems[U_BUJUK].Dura > nCount then begin
    Dec(PlayObject.m_UseItems[U_BUJUK].Dura, nCount);
    PlayObject.DuraChange(U_BUJUK, PlayObject.m_UseItems[U_BUJUK].Dura, PlayObject.m_UseItems[U_BUJUK].DuraMax);
  end else begin
    PlayObject.m_UseItems[U_BUJUK].Dura := 0;
    if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
      TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_BUJUK]);
    PlayObject.m_UseItems[U_BUJUK].wIndex := 0;
  end;
end;

function TMagicManager.DoSpell(PlayObject: TPlayObject;UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;TargeTBaseObject: TBaseObject): Boolean;
var
  boTrain: Boolean;
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  btAmuletType: Byte;
  boMove: Boolean;
  nPower: Integer;
  nDelayTime: Integer;
  MapFlag: TWalkFlagArr;
  nTime, nCounterMin, nCounterSec: Integer;
  
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;

  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) +
      (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;

  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  end;

  function GetRPow(wInt: Integer): Word; //取伤害中间随机值
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;

  procedure sub_4934B4(PlayObject: TPlayObject);
  begin
    if PlayObject.m_UseItems[U_BUJUK].Dura < 1 then begin
      PlayObject.m_UseItems[U_BUJUK].Dura := 0;
      PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BUJUK]);
      PlayObject.m_UseItems[U_BUJUK].wIndex := 0;
    end;
  end;
begin
  Result := False;
  boMove := False;

  if (TargeTBaseObject <> nil) and ((abs(PlayObject.m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or
    (abs(PlayObject.m_nCurrY - nTargetY) > g_Config.nMagicAttackRage)) then begin
    Exit;
  end;

  PlayObject.MagicQuest(nil, UserMagic.wMagIdx, mfs_Self);
  if not ((UserMagic.wMagIdx = SKILL_POISONING) or (UserMagic.wMagIdx = SKILL_MASSPOISONING)) then
    PlayObject.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY,
      UserMagic.MagicInfo.wMagicId, '');

  if (TargeTBaseObject <> nil) and TargeTBaseObject.m_boDeath and (UserMagic.MagicInfo.wMagicId <> SKILL_RESURRECTION) then
    TargeTBaseObject := nil;

  if TargeTBaseObject <> nil then begin
    if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
      PlayObject.MagicQuest(TargeTBaseObject, UserMagic.wMagIdx, mfs_Tag);
    end else begin
      PlayObject.MagicQuest(TargeTBaseObject, UserMagic.wMagIdx, mfs_Mon);
    end;
  end;

  boTrain := False;
  boSpellFail := False;
  boSpellFire := True;

  case UserMagic.MagicInfo.wMagicId of

    SKILL_FIREBALL,
    SKILL_FIREBALL2: begin
      if MagMakeFireball(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
        boTrain := True;
    end;

    SKILL_HEALLING: begin
      if MagMakeHealing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
        boTrain := True;
    end;

    SKILL_ULTIMATEENHANCER: begin
      if MagUltimateEnhance(PlayObject, TargetBaseObject, UserMagic) then
        boTrain := True;
    end;

    SKILL_POISONING: begin
      btAmuletType := GetAmuletType(PlayObject);
      boSpellFire := False;

      if btAmuletType = 2 then
        btAmuletType := MAGICEX_AMYOUNSUL
      else
        btAmuletType := 4;

      PlayObject.SendRefMsg(RM_SPELL, btAmuletType, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
      if MagLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then begin
        boTrain := True;
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, btAmuletType), MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
      end else
        boSpellFail := True;
    end;

    SKILL_REPULSION: begin
      if MagPushArround(PlayObject, UserMagic.wMagIdx, UserMagic.btLevel) > 0 then
        boTrain := True;
    end;

    SKILL_HELLFIRE: begin
      if MagMakeHellFire(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
        boTrain := True;
    end;

    SKILL_LIGHTNING: begin
      if MagMakeQuickLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
        boTrain := True;
    end;

    SKILL_THUNDERBOLT: begin
      if MagMakeLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
        boTrain := True;
    end;

    SKILL_SOULFIREBALL,
    SKILL_SOULSHIELD,
    SKILL_BLESSEDARMOUR,
    SKILL_TRAPHEXAGON,
    SKILL_SUMMONSKELETON,
    SKILL_HIDING,
    SKILL_MASSHIDING,
    SKILL_CURSE,
    SKILL_PLAGUE,
    SKILL_HALLUCINATION,
    SKILL_MASSSOULFIREBALL: begin
      boSpellFail := True;
      if CheckAmulet(PlayObject, 1, 1) then begin
        UseAmulet(PlayObject, 1, 1);
        case UserMagic.MagicInfo.wMagicId of

          SKILL_SOULFIREBALL: begin
            if MagMakeFireCharm(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, False) then
              boTrain := True;
            end;

          SKILL_MASSSOULFIREBALL: begin
            if MagMakeFireCharm(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, True) then
              boTrain := True;
            end;

            SKILL_SOULSHIELD: begin
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10,
                  SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, UserMagic.wMagIdx, 1, True) > 0 then
                  boTrain := True;
            end;
            SKILL_BLESSEDARMOUR: begin
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10,
                  SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, UserMagic.wMagIdx, 0, True) > 0 then
                  boTrain := True;
            end;
            SKILL_TRAPHEXAGON: begin
                if MagMakeHolyCurtain(PlayObject, GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 3, nTargetX, nTargetY) > 0 then
                  boTrain := True;
            end;
            SKILL_SUMMONSKELETON: begin
                if MagMakeSlave(PlayObject, UserMagic) then begin
                  boTrain := True;
                end;
            end;
            SKILL_HIDING: begin
                if MagMakePrivateTransparent(PlayObject, GetPower13(30) +
                  GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
            end;
            SKILL_MASSHIDING: begin
                if MagMakeGroupTransparent(PlayObject, nTargetX, nTargetY,
                  GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3, UserMagic.wMagIdx) then
                  boTrain := True;
            end;
            SKILL_CURSE: begin
                nTime := (2 * (UserMagic.btLevel + 1)) + Round(HiWord(PlayObject.m_WAbil.SC + 1) div (UserMagic.MagicInfo.btDefPower + 1));
                //nTime := (((UserMagic.btLevel + 1)* 4 ) + HiWord(PlayObject.m_WAbil.SC) + PlayObject.m_WAbil.Level) div 2 ;
                nPower := Round(HiWord(PlayObject.m_WAbil.SC + 1) div (UserMagic.MagicInfo.wPower + 1));
                //nPower := Round(nPower * 2.5);
                if PlayObject. MagDebuffArea(nTargetX, nTargetY, 3, nTime, nPower, UserMagic.btLevel, 0) > 0 then
                  boTrain := True;
              end;
            SKILL_HALLUCINATION: begin
              if (Random(5 - (UserMagic.btLevel + 1)) = 0) and (TargetBaseObject <> nil) then begin
                if (not TargetBaseObject.m_boHallucinationMode) and
                  (TargetBaseObject.m_Master = nil) and
                  (not TargetBaseObject.m_boStoneMode) and
                  (TargeTBaseObject.m_Abil.Level < PlayObject.m_abil.Level) then begin
                  nPower:= PlayObject.GetAttackPower (GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2, SmallInt(HiWord(PlayObject.m_WAbil.SC)-LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
                  nPower := Random(nPower);
                  TargetBaseObject.OpenHallucinationMode(nPower);
                  boTrain := true;
                end;
              end;
            end;
            SKILL_PLAGUE: begin
                nTime := (((UserMagic.btLevel + 1)* 24 ) + HiWord(PlayObject.m_WAbil.SC) + PlayObject.m_WAbil.Level) div 2 ;
                nPower := Round(HiWord(PlayObject.m_WAbil.DC) div 10);
                nPower := Round(nPower * 2.5);
                if PlayObject.MagDebuffArea(nTargetX, nTargetY, 3, nTime, nPower, UserMagic.btLevel, 1) > 0 then
                  boTrain := True;
            end;
          end;
          boSpellFail := False;
          //sub_4934B4(PlayObject);
        end;
      end;
    SKILL_ELECTRICSHOCK: begin
        if (TargeTBaseObject <> nil) and PlayObject.IsProperTarget(TargeTBaseObject) then begin
          if MagTamming(PlayObject, TargeTBaseObject, nTargetX, nTargetY,
            UserMagic.btLevel) then
            boTrain := True;
        end;
    end;
    SKILL_TELEPORT: begin
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
          MakeWord(UserMagic.MagicInfo.btEffectType,
          UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY),
          Integer(TargeTBaseObject), '');
        boSpellFire := False;
        if MagSaceMove(PlayObject, UserMagic.btLevel) then
          boTrain := True;
    end;
    SKILL_FIREWALL: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1, False);
        nDelayTime := GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1);

        nPower := ROUND(nPower * (g_Config.nFirePowerRate / 100));
        nDelayTime := ROUND(nDelayTime * (g_Config.nFireDelayTimeRate / 100));

        if MagMakeFireCross(PlayObject, nPower, nDelayTime, nTargetX, nTargetY) > 0 then
          boTrain := True;
    end;
    SKILL_FIREBANG: begin
        if MagMassRangeDamage(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          0, UserMagic) then
          boTrain := True;
    end;
    SKILL_THUNDERSTORM: begin
        if MagMassDamageAroundUser(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
          LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) -
          LoWord(PlayObject.m_WAbil.MC)) + 1), UserMagic.wMagIdx, 0) then
          boTrain := True;
    end;
    SKILL_REVELATION: begin
        if (TargeTBaseObject <> nil) and not TargeTBaseObject.m_boShowHP then begin
          if Random(6) <= (UserMagic.btLevel + 3) then begin
            TargeTBaseObject.m_dwShowHPTick := GetTickCount();
            TargeTBaseObject.m_dwShowHPInterval := GetPower13(GetRPow(PlayObject.m_WAbil.SC) * 2 + 30) * 1000;

            if not (TargetBaseObject.m_btRaceServer = 76) then //check for evilmir body parts.
              TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 1500);
            TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
            boTrain := True;
          end;
        end;
      end;
    SKILL_MASSHEALING: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
        if MagBigHealing(PlayObject, nPower, nTargetX, nTargetY, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_SUMMONSHINSU: begin
        boSpellFail := True;
        if CheckAmulet(PlayObject, 5, 1) then begin
          UseAmulet(PlayObject, 5, 1);
          if MagMakeSinSuSlave(PlayObject, UserMagic) then begin
            boTrain := True;
          end;
          sub_4934B4(PlayObject);
          boSpellFail := False;
        end;
      end;
    SKILL_MAGICSHIELD: begin
        boSpellFail := True;
        if PlayObject.m_wStatusTimeArr[STATE_BUBBLEDEFENCEUPEX] = 0 then begin
          boSpellFail := False;
          if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15), STATE_BUBBLEDEFENCEUP) then
            boTrain := True;
        end;
    end;
    SKILL_ENERGYSHIELD: begin
        boSpellFail := True;
        if PlayObject.m_wStatusTimeArr[STATE_ENERGYSHIELD] = 0 then begin
          boSpellFail := False;
          if MagEnergyShield(PlayObject, GetPower(GetRPow(PlayObject.m_WAbil.SC) + 15), STATE_ENERGYSHIELD, UserMagic, TargetBaseObject) then
            boTrain := True;
        end;
    end;
    SKILL_TURNUNDEAD: begin
        if TargeTBaseObject <> nil then begin
          if PlayObject.IsProperTarget(TargeTBaseObject) then begin
            if MagTurnUndead(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
              boTrain := True;
          end;
        end;
      end;
    SKILL_ICESTORM: begin
        if MagMassRangeDamage(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY, 1, UserMagic) then
          boTrain := True;
      end;
    SKILL_PURIFICATION: begin
        if MagMakeUnTreatment(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_MABE: begin
        with PlayObject do begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC),
            SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
        end;
        if MabMabe(PlayObject, TargeTBaseObject, nPower, UserMagic.btLevel, nTargetX, nTargetY, UserMagic.wMagIdx) then
          boTrain := True;
      end;
    SKILL_GROUPLIGHTENING: begin
        if MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY,
          TargeTBaseObject, boSpellFire) then
          boTrain := True;
      end;
    SKILL_MASSPOISONING: begin
        //btAmuletType := GetAmuletType(PlayObject);
        boSpellFire := False;
//        if btAmuletType = 2 then
//          btAmuletType := MAGICEX_AMYOUNSULGROUP
//        else
          btAmuletType := 47;
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1, False);
        //nPower := Round((nPower / 4) * 3);   
        PlayObject.SendRefMsg(RM_SPELL, btAmuletType, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
        if MagMakePoisonCloud(PlayObject, nPower, 5 + (UserMagic.btLevel * 2), nTargetX, nTargetY, UserMagic) > 0 then //MagMakePoisonField(PlayObject, UserMagic, nTargetX, nTargetY) > 0 then
          boTrain := True;

        PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
            MakeWord(UserMagic.MagicInfo.btEffectType, btAmuletType),
            MakeLong(nTargetX, nTargetY),
            Integer(TargeTBaseObject),
            '');
      end;
    SKILL_GROUPDEDING: begin
       if MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_LIONSROAR: begin
        if MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_BLADEAVALANCHE: begin
        if MagWideAttack(PlayObject, UserMagic) then
          boTrain := True;
      end;
    SKILL_FROSTCRUNCH: begin
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_SAMFROST: begin
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_FLAMEDISRUPTOR: begin
        if MagMakeFireDay(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_MIRRORING: begin
          if MagMakeSelf(PlayObject, TargeTBaseObject, UserMagic) then
            boTrain := True;
      end;
    SKILL_FLAMEFIELD: begin
        if MagMassDamageAroundUser(PlayObject, PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1), UserMagic.wMagIdx, 1) then
          boTrain := True
        else boTrain := False
      end;
    SKILL_ENERGYREPULSION: begin
        if MagPushArround(PlayObject, UserMagic.wMagIdx, UserMagic.btLevel) > 0 then
          boTrain := True;
      end;
    SKILL_51: begin
        if MagGroupFengPo(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_VAMPIRISM: begin
        if MagVampire(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_54: begin
        if PlayObject.IsProperTargetSKILL_54(TargeTBaseObject) then begin
          if MagTamming2(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_ENTRAPMENT: begin
      if MagEntrapment(PlayObject,TargetBaseObject,UserMagic) then begin
        boTrain:=True;
      end else
        TargetBaseObject:=nil;
      end;
    SKILL_METEORSTRIKE: begin
        if MagMassRangeDamage(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          3, UserMagic) then
          boTrain := True;
      end;
    SKILL_58: begin
        boSpellFail := True;
        if PlayObject.m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0 then begin
          boSpellFail := False;
          if PlayObject.MagShieldDefenceUp(UserMagic.btLevel,
            GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15), STATE_BUBBLEDEFENCEUPEX) then
            boTrain := True;
        end;
      end;
    SKILL_RESURRECTION: begin
        if (TargeTBaseObject <> nil) and
          TargeTBaseObject.m_boDeath and
          PlayObject.IsProperFriend(TargeTBaseObject) and
          (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) and
          (not TPlayObject(TargeTBaseObject).m_boAliveing) and
          (not TPlayObject(TargeTBaseObject).m_boDoctorAlive) then begin
          UserEngine.CryCry(RM_CRY, PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, 50, PlayObject.m_sCharName + ' is attempting to revive ' + TargetBaseObject.m_sCharName);
          nTime := Round(20 - (5 * UserMagic.btLevel));
          PlayObject.m_CastingDelayTick := GetTickCount() + nTime * 1000;
          PlayObject.m_ResurrectionTarget := TargetBaseObject;
          PlayObject.SendDefMessage(SM_SHOWBAR, 4, 0, CM_ALIVE, nTime, 'Attempting to cast ' + UserMagic.MagicInfo.sMagicName);
          PlayObject.m_boTryResurrect := True;
          TBaseObject(PlayObject).m_boBeginCasting := True;
          boTrain := True;
        end;
      end;
    SKILL_62: begin
        if PlayObject.m_PEnvir.GetEvent(nTargetX, nTargetY) = nil then begin
          g_EventManager.AddEvent(TFireBurnEvent.Create(PlayObject, nTargetX, nTargetY, ET_INCHP, 10 * 1000, 100));
          boTrain := True;
        end;
      end;
    SKILL_GEOMANIPULATION: begin
        MapFlag := [];
        if g_Config.boSkill63RunHum then MapFlag := MapFlag + [wf_Hum];
        if g_Config.boSkill63RunMon then MapFlag := MapFlag + [wf_Mon];
        if g_Config.boSkill63RunNpc then MapFlag := MapFlag + [wf_Npc];
        if g_Config.boSkill63RunGuard then MapFlag := MapFlag + [wf_Guard];
        if g_Config.boSkill63WarDisHumRun then MapFlag := MapFlag + [wf_War];
        if PlayObject.m_PEnvir.CanWalkEx(nTargetX, nTargetY, MapFlag) then begin
          if Random(4) < _MAX(1, UserMagic.btLevel) then begin
            with PlayObject do begin
              if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, PlayObject, nTargetX, nTargetY, True) > 0 then begin
                m_nCurrX := nTargetX;
                m_nCurrY := nTargetY;
                GetStartType();
                boMove := True;
                boTrain := True;
              end;
            end;
          end;
        end;
      end;
    SKILL_65: begin
        if MagMakeMoonSlave(PlayObject, UserMagic) then begin
            boTrain := True;
          end;
      end;
    SKILL_BLIZZARD: begin
        if MagMassRangeDamage(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          4, UserMagic) then
          boTrain := True;
      end;
    SKILL_RAGE: begin
      nPower := 12 + UserMagic.btLevel * 3;
      nPower := Round((HiWord(PlayObject.m_WAbil.DC) / 100) * nPower);
      nTime := 12 + (6 * UserMagic.btLevel);
      if PlayObject.MagChangeAbility(nPower, nTime, 10, UserMagic) then
        boTrain:=True;

      PlayObject.m_MagicArr[SKILL_RAGE].dwInterval := GetTickCount + (nTime * 1000);
    end;
    SKILL_COUNTERATTACK: begin
      nTime := 6 + (1 * UserMagic.btLevel);

      nCounterMin := nTime div 60;
      nCounterSec := nTime mod 60;

      if not PlayObject.m_boCounterAttackPending then begin
        PlayObject.m_nCounterAttackTimer := GetTickCount + 20 * 1000;
        PlayObject.m_boCounterAttackPending := true;
        PlayObject.SysMsg('A chance of a counter attack is enabled for ' + inttostr(nCounterMin) + ' minutes and ' + inttostr(nCounterSec) + ' seconds.',c_Green,t_Hint);
        boTrain := true;
      end else begin
        PlayObject.SysMsg('Counter attack is already enabled.',c_Green,t_Hint);
      end;

      PlayObject.m_MagicArr[SKILL_COUNTERATTACK].dwInterval := GetTickCount + (nTime * 1000);
    end;
    SKILL_PROTECTIONFIELD: begin
      nPower := 20 + UserMagic.btLevel * 3;
      nPower := Round((HiWord(PlayObject.m_WAbil.AC) / 100) * nPower);

      nTime := 30 + (15 * UserMagic.btLevel);
      if PlayObject.MagChangeAbility(nPower, nTime, 13, UserMagic) then
        boTrain := True;

      PlayObject.m_MagicArr[SKILL_PROTECTIONFIELD].dwInterval := GetTickCount + (nTime * 1000);
    end;
    SKILL_70: begin
        if MagBigExplosionAndMakePoisonByWarr(PlayObject, UserMagic,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.DC),
          SmallInt(HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC)) + 1),
          nTargetX,
          nTargetY,
          3,
          boMove) then
          boTrain := True;
      end;
    SKILL_71: begin
        if MagBigExplosionAndMakePoisonEx(PlayObject, UserMagic,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          3) then
          boTrain := True;
      end;
    SKILL_72: begin
        if MagBigExplosionAndMakePoison(PlayObject, UserMagic,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1),
          nTargetX,
          nTargetY,
          3) then
          boTrain := True;
      end;
    SKILL_MAGICBOOSTER: begin
      nPower := 6 * UserMagic.btLevel;
      if PlayObject.MagChangeAbility(nPower, 20, 11, UserMagic) then
        boTrain := True;
    end;
    SKILL_114: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill114PowerRate / 100));
        if MagMakeCBOBase(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_115: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill115PowerRate / 100));
        if MagMakeCBOBase(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_116: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill116PowerRate / 100));
        if MagMakeCBOBase(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_ICETHRUST: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill117PowerRate / 100));
        if MagMassRangeDamage(PlayObject,
          nPower,
          nTargetX,
          nTargetY,
          2, UserMagic) then
          boTrain := True;
      end;
    SKILL_118: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill118PowerRate / 100));
        if MagMakeFireCharmEx(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_119: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill119PowerRate / 100));
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_120: begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

        nPower := ROUND(nPower * (g_Config.nSkill120PowerRate / 100));
        if MagMakeFireCharmEx(PlayObject,
          UserMagic,
          nTargetX,
          nTargetY,
          nPower,
          TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_121: begin
        if TargeTBaseObject <> nil then begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
            SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

          nPower := ROUND(nPower * (g_Config.nSkill121PowerRate / 100));
          if MagBigExplosionTime(PlayObject,
            nPower,
            TargeTBaseObject.m_nCurrX,
            TargeTBaseObject.m_nCurrY,
            2, UserMagic.wMagIdx) then
            boTrain := True;
        end;
      end;
    SKILL_123: begin //怒气爆发

      end;
    SKILL_124: begin //倚天辟地
        nPower := 0;
        nTargetX := PlayObject.m_nCurrX;
        nTargetY := PlayObject.m_nCurrY;
        if PlayObject.m_btJob = 0 then
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.DC), SmallInt(HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC)) + 1);
        if PlayObject.m_btJob = 1 then
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        if PlayObject.m_btJob = 2 then
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC), SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);

        nPower := Round(g_Config.nEtenPowerRate / 100 * nPower);
        if MagBigExplosionTime(PlayObject,
            nPower,
            PlayObject.m_nCurrX,
            PlayObject.m_nCurrY,
            g_Config.nEtenMagicSize, UserMagic.wMagIdx) then
            boTrain := True;
      end;
    SKILL_HASTE: begin
      if MagHaste(PlayObject, UserMagic) then
        boTrain := True;
    end;
    SKILL_LIGHTBODY: begin
      if MagLightBody(PlayObject, UserMagic) then
        boTrain := True;
    end;
    SKILL_HEAVENLYSWORD: begin
      if MagHeavenlySword(PlayObject, UserMagic) then
        boTrain := True;
    end;
    SKILL_FIREBURST: begin
        if MagPushArround(PlayObject, UserMagic.wMagIdx, UserMagic.btLevel) > 0 then
          boTrain := True;
    end;
    SKILL_TRAP: begin
        if MagTrap(PlayObject, TargeTBaseObject, nTargetX, nTargetY, GetPower13(40) + GetRPow(PlayObject.m_WAbil.DC) * 3) then begin
          boTrain := True;
        end;
    end;
  else begin
      //boTrain := True;
        {if Assigned(zPlugOfEngine.SetHookDoSpell) then begin
          try
            boTrain := zPlugOfEngine.SetHookDoSpell(Self, PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFail, boSpellFire);
          except
          end;
        end;  }
    end;
  end;
  if boSpellFail then
    Exit;
  if boSpellFire then begin
    PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
      MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
      MakeLong(nTargetX, nTargetY),
      Integer(TargeTBaseObject),
      '');
  end;
  if (UserMagic.btLevel < 3) and (boTrain) then begin
    if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level then begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);
      if not PlayObject.CheckMagicLevelup(UserMagic) then begin
        PlayObject.SendDelayDefMsg(PlayObject, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
          UserMagic.btLevel, LoWord(UserMagic.nTranPoint),
          HiWord(UserMagic.nTranPoint), '', 1000);
      end;
    end;
  end;
  if (UserMagic.MagicInfo.wMagicId = SKILL_70) and boMove then begin
    PlayObject.SendRefMsg(RM_MAGICMOVE, PlayObject.m_btDirection, PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0, '');
  end else
  if (UserMagic.MagicInfo.wMagicId = SKILL_GEOMANIPULATION) and boMove then begin
    PlayObject.SendRefMsg(RM_MAGICFIR, PlayObject.m_btDirection, PlayObject.m_nCurrX, PlayObject.m_nCurrY, 2, '');
  end;
  Result := True;
end;

function TMagicManager.MagPushArround(PlayObject: TBaseObject; nMagID, nPushLevel:
  Integer): Integer; //00492204
var
  i, nDir, levelgap, push: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for i := 0 to PlayObject.m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors[i]).BaseObject);
    if (abs(PlayObject.m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(PlayObject.m_nCurrY - BaseObject.m_nCurrY) <= 1) then begin
      if (not BaseObject.m_boDeath) and (BaseObject <> PlayObject) then begin
        if (PlayObject.m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
          levelgap := PlayObject.m_Abil.Level - BaseObject.m_Abil.Level;
          if (Random(20) < 6 + nPushLevel * 3 + levelgap) then begin
            if PlayObject.IsProperTarget(BaseObject) then begin
              push := 1 + _MAX(0, nPushLevel - 1) + Random(2);
              nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
              BaseObject.CharPushed(nDir, push);
              BaseObject.MagicQuest(PlayObject, nMagID, mfs_TagEx);
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY, nMagID:
  Integer): Boolean; //00492E50
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList[i]);
    if PlayObject.IsProperFriend(BaseObject) then begin
      if BaseObject.m_WAbil.HP < BaseObject.m_WAbil.MaxHP then begin
        BaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
        //BaseObject.SendMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '');
        BaseObject.MagicQuest(PlayObject, nMagID, mfs_TagEx);
        Result := True;
      end;
      if (BaseObject.m_Master <> nil) then begin
        if BaseObject.m_Master = PlayObject then begin
          BaseObject.m_dwShowHPTick := GetTickCount();
          BaseObject.m_dwShowHPInterval := 2 * 1000;
          BaseObject.SendDelayMsg(BaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 100);
        end;
      end;
      if PlayObject.m_boAbilSeeHealGauge then
        PlayObject.SendDefMsg(PlayObject, SM_INSTANCEHEALGUAGE,
          Integer(BaseObject),
          BaseObject.m_WAbil.HP,
          BaseObject.m_WAbil.MaxHP,
          0, '');
    end;
  end;
  BaseObjectList.Free;
end;

constructor TMagicManager.Create;
begin

end;

destructor TMagicManager.Destroy;
begin

  inherited;
end;

function TMagicManager.MagMakeCBOBase(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer; var TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if TargeTBaseObject = nil then exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(g_Config.nMagicResistanceRate)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
          MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '',
          400 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
        TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
          Result := True;
      end
      else
        TargeTBaseObject := nil;
    end;
    //else
      //TargeTBaseObject := nil;
  end
  else
    TargeTBaseObject := nil;
end;

{火球}

function TMagicManager.MagMakeFireball(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(g_Config.nMagicResistanceRate)) and
        (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        with PlayObject do begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
            SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        end;
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
          MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '',
          400 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
        //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
        TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
          Result := True;
      end
      else
        TargeTBaseObject := nil;
    end;
    //else
      //TargeTBaseObject := nil;
  end
  else
    TargeTBaseObject := nil;
end;

{治愈术}

function TMagicManager.MagMakeHealing(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTBaseObject = nil then begin
    TargeTBaseObject := PlayObject;
    nTargetX := PlayObject.m_nCurrX;
    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend(TargeTBaseObject) then begin
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
      LoWord(PlayObject.m_WAbil.SC) * 2,
      SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
    if TargeTBaseObject.m_WAbil.HP < TargeTBaseObject.m_WAbil.MaxHP then begin
      TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //TargeTBaseObject.SendMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '');
      Result := True;
    end;

    //open health bar on pets.
    if (TargetBaseObject.m_Master <> nil) then begin
      if TargetBaseObject.m_Master = PlayObject then begin
        TargeTBaseObject.m_dwShowHPTick := GetTickCount();
        TargeTBaseObject.m_dwShowHPInterval := 2 * 1000;
        TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 100);
      end;
    end;

    if PlayObject.m_boAbilSeeHealGauge then
      PlayObject.SendDefMsg(PlayObject, SM_INSTANCEHEALGUAGE,
        Integer(TargeTBaseObject),
        TargeTBaseObject.m_WAbil.HP,
        TargeTBaseObject.m_WAbil.MaxHP,
        0, '');
  end;
end;

{地域火}

function TMagicManager.MagMakeHellFire(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  n1C: Integer;
  n14, n18: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 5, nTargetX, nTargetY);
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
      SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, UserMagic.wMagIdx, False) > 0 then
      Result := True;
  end;
end;

{疾光电影}

function TMagicManager.MagMakeQuickLighting(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  n1C: Integer;
  n14, n18: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX,
    PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 8, nTargetX, nTargetY);
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
      SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, UserMagic.wMagIdx, 
      True) > 0 then
      Result := True;
  end;
end;

{雷电术}

function TMagicManager.MagMakeLighting(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(g_Config.nMagicResistanceRate) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := ROUND(nPower * 1.5);
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '',
        600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
      //if PlayObject.m_btRaceServer = RC_PLAYMOSTER then Result := True
      //else
      if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end
    else
      TargeTBaseObject := nil
  end
  else
    TargeTBaseObject := nil;
end;

{灵魂火符}

function TMagicManager.MagMakeFireCharm(PlayObject: TBaseObject;
  {修改 TBaseObject}
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject; boMove: Boolean): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
  function GetAroundObject(Targe: TBaseObject): TBaseObject;
  var
    BaseObjectList: TList;
    TargeBase: TBaseObject;
    I: Integer;
  begin
    Result := nil;
    BaseObjectList := TList.Create;
    Try
      Targe.GetMapBaseObjects(Targe.m_PEnvir, Targe.m_nCurrX, Targe.m_nCurrY, 3, BaseObjectList);
      for I := BaseObjectList.Count - 1 downto 0 do begin
        TargeBase := TBaseObject(BaseObjectList[I]);
        if (not PlayObject.IsProperTarget(TargeBase)) or (Targe = TargeBase) or (PlayObject = TargeBase) or
          (not Targe.MagCanHitTarget(Targe.m_nCurrX, Targe.m_nCurrY, TargeBase)) then begin
          BaseObjectList.Delete(I);
        end;
      end;
      if BaseObjectList.Count > 0 then
        Result := TBaseObject(BaseObjectList[Random(BaseObjectList.Count)]);
    Finally
      BaseObjectList.Free;
    End;
  end;
var
  I: Integer;
  AroundBase, TargeBase: TBaseObject;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      if Random(g_Config.nMagicResistanceRate) >= TargeTBaseObject.m_nAntiMagic then begin
        if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
          (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) +
            LoWord(PlayObject.m_WAbil.SC),
            SmallInt(HiWord(PlayObject.m_WAbil.SC) -
            LoWord(PlayObject.m_WAbil.SC)) + 1);
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 400);
          TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
          if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;

          if boMove then begin
            if UserMagic.btLevel > 0 then begin
              TargeBase := TargeTBaseObject;
              for I := 2 to (_MIN(UserMagic.btLevel, 3) + 1) do begin
                AroundBase := GetAroundObject(TargeBase);
                if AroundBase = nil then break;
                PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(AroundBase.m_nCurrX, AroundBase.m_nCurrY), 2, Integer(AroundBase), '', I * 400);
                AroundBase.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
                AroundBase.SendRefMsg(RM_10205, 0, LoWord(Integer(TargeBase)), HiWord(Integer(TargeBase)), 30, '', 400 * I);
                TargeBase := AroundBase;
              end;
            end;
          end;
        end;
      end;
    end;
  end
  else
    TargeTBaseObject := nil;
end;

function TMagicManager.MagMakeFireCharmEx(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      if Random(g_Config.nMagicResistanceRate) >= TargeTBaseObject.m_nAntiMagic then begin
        if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2,
            Integer(TargeTBaseObject), '',
            400 + (abs(PlayObject.m_nCurrX - nTargetX) + abs(PlayObject.m_nCurrY - nTargetY)) div 2 * 20);
          TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
          if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
        end;
      end;
    end;
  end
  else
    TargeTBaseObject := nil;
end;

{噬血术      }

function TMagicManager.MagVampire(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;

  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) +
      (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(g_Config.nMagicResistanceRate) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC2, nPower,
        MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //PlayObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
      Result := True;
      {if g_Config.boPlayObjectReduceMP then
        TargeTBaseObject.DamageSpell(nPower div 2);  }
    end;
  end;
end;

{灭天火}

function TMagicManager.MagMakeFireDay(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower
      - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(g_Config.nMagicResistanceRate) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if TargeTBaseObject.m_btLifeAttrib <> LA_UNDEAD then begin
        if TargetBaseObject.m_btRaceServer > RC_PLAYOBJECT then
          nPower := nPower + ROUND(nPower * 0.4)
        else
          nPower := nPower + ROUND(nPower * 0.15);
      end;
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
        MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      if g_Config.boPlayObjectReduceMP then
        TargeTBaseObject.DamageSpell(nPower div 2);
      if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end
    else
      TargeTBaseObject := nil
  end
  else
    TargeTBaseObject := nil;
end;

{解毒术}

function TMagicManager.MagMakeUnTreatment(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
var TargeTBaseObject: TBaseObject): Boolean;
var
  nSuccessRate: Integer;
begin
  Result := False;
  if TargeTBaseObject = nil then begin
    TargeTBaseObject := PlayObject;
    //    nTargetX := PlayObject.m_nCurrX;
    //    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend {0FFF3}(TargeTBaseObject) then begin
    nSuccessRate := (Random(5) - (UserMagic.btLevel + 1));
    if nSuccessRate < 0 then begin
      if TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_SLOWDOWN] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_SLOWDOWN] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_FREEZE] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_FREEZE] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_STUN] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_STUN] := 1;
        Result := True;
      end;
      {curse}
      if TargeTBaseObject.m_dwStatusArrTimeOutTick[9] <> 0 then begin
        TargeTBaseObject.m_dwStatusArrTimeOutTick[9] := 1;
        Result := True;
      end;
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
    end;
  end;
end;

{复活术}

function TMagicManager.MagMakeLivePlayObject(PlayObject: TPlayObject; UserMagic:
  pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if PlayObject.IsProperTargetSKILL_57(TargeTBaseObject) then begin
    if (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) >= 8 then begin
      TPlayObject(TargeTBaseObject).ReAlive;
      TPlayObject(TargeTBaseObject).m_WAbil.HP :=
        TPlayObject(TargeTBaseObject).m_WAbil.MaxHP;
      TPlayObject(TargeTBaseObject).SendAbility;
      Result := True;
    end;
  end;
end;

function  TMagicManager.MagEntrapment (PlayObject:TPlayObject;TargeTBaseObject:TBaseObject;UserMagic:pTUserMagic): Boolean;
  procedure GetFirstCoord(Envir:TEnvirnoment;nSourceX,nSourceY,nDestX,nDestY:integer; var nCoordx,nCoordy:integer);
  var
    nDistx,nDisty:integer;
    nDir:integer;
  begin
    nDistx:=nDestX - nSourceX;
    nDistY:=nDestY - nSourceY;
    if (nDistx = -1) or (nDistX = 1) then begin //if there's 1 row off on the x range
      nCoordX:= nSourcex + nDistx;
      if nDistY > 0 then
        nCoordY:= nSourcey + 1
      else
        nCoordY:= nSourceY - 1;
      exit;
    end;
    if (nDisty = -1) or (nDistY = 1) then begin //if there's 1 row off on the y range
      if nDistX > 0 then
        nCoordX:= nSourcex + 1
      else
        nCoordX:= nSourceX - 1;
      nCoordY:= nSourcey + nDistY;
      exit;
    end;
    nDir:= GetNextDirection(nSourceX,nSourceY,nDestX,nDestY);
    Envir.GetNextPosition(nSourceX,nSourceY,nDir, 1,nCoordX,nCoordY);
  end;
var
  nSucces:integer;
  I,II:integer;
  sX,sY:integer;
  EntrapDist,EntrapDir,nDir:integer;
  nTotalObjects:integer;
  BaseObject:TBaseObject;
  BaseObjectList:TList;
  nDistx,nDisty:integer;
  nFirstx,nFirstY:integer;//coords to which we should drag if there's nothing in the way
  nDragX,nDragy:integer; //coords to which we should drag if somethings blocking the path
begin
  Result:=False;
  //succes rate
  nSucces := Random(5) - (UserMagic.btLevel + 1);
  if nSucces > 0 then
    exit;
  //checking if the target is valid and if its in range
  if TargetBaseObject is TPlayObject then exit;
  if TargetBaseObject = nil then exit;
  if NOT(PlayObject.IsProperTarget(TargetBaseObject)) or TargetBaseObject.m_boStickMode then exit;
  if TargetBaseObject.m_Abil.Level > PlayObject.m_Abil.level + 8 then exit; 
  nDistx:=ABS(TargeTBaseObject.m_nCurrX-PlayObject.m_nCurrX);
  nDisty:=ABS(TargeTBaseObject.m_nCurrY-PlayObject.m_nCurrY);
  if (nDistx <> nDisty) and NOT((nDistx <= 1) or (nDisty <= 1)) then exit;
  if _Max(nDistx,nDisty) < 2 then exit;
  nTotalObjects:=0;

  //get the coord the mob should end up at
  GetFirstCoord(PlayObject.m_PEnvir,PlayObject.m_nCurrX,PlayObject.m_nCurrY, TargetBaseObject.m_nCurrX,TargetBaseObject.m_nCurrY,nFirstx, nFirstY);
  nDragX:=nFirstX;
  nDragY:=nFirstY;

  //getthe drag distance, the direction we going to check and the direction we going to drag (entrap)
  EntrapDist:=Max(nDistx,nDisty)-1;
  nDir:= GetNextDirection(nFirstX,nFirstY,TargetBaseObject.m_nCurrX,TargetBaseObject.m_nCurrY);
  EntrapDir:=GetNextDirection(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,nFirstX,nFirstY);

  //now test if the path is clear (if there's no high lvl blocking the path)
  if NOT PlayObject.m_PEnvir.CanWalk(nFirstX,nFirstY,True) then exit;
  BaseObjectList:=TList.Create;
  PlayObject.m_PEnvir.GeTBaseObjects(nFirstx,nFirstY,True,BaseObjectList);
  for II := 0 to BaseObjectList.Count - 1 do begin
    BaseObject:=TBaseObject(BaseObjectList.Items[II]);
    If not PlayObject.IsProperTarget(BaseObject) or BaseObject.m_boStickMode or
      (BaseObject is TPlayObject) or (BaseObject.m_Abil.Level > PlayObject.m_abil.Level+8) then begin
      BaseObject.m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,nDir, 1,nDragX,nDragY);
    end;
  end;
  BaseObjectList.Free;

  for i := 1 to EntrapDist do begin
    PlayObject.m_PEnvir.GetNextPosition(nFirstX,nFirstY,nDir, i,sx,sy);
    if not PlayObject.m_PEnvir.CanWalk(sX,sY,True) then exit;
    BaseObjectList:=TList.Create;
    PlayObject.m_PEnvir.GeTBaseObjects(sX,sY,True,BaseObjectList);
    for II := 0 to BaseObjectList.Count - 1 do begin
      BaseObject:=TBaseObject(BaseObjectList.Items[II]);
      If not PlayObject.IsProperTarget(BaseObject) or BaseObject.m_boStickMode or
        (BaseObject is TPlayObject) or (BaseObject.m_Abil.Level > PlayObject.m_abil.Level+8) then begin
        BaseObject.m_PEnvir.GetNextPosition(BaseObject.m_nCurrX,BaseObject.m_nCurrY,nDir, 1,nDragX,nDragY);
      end;
    end;
    BaseObjectList.Free;
  end;
  //now drag everything towards us and para
  nDistx:=ABS(TargeTBaseObject.m_nCurrX-nDragX);
  nDisty:=ABS(TargeTBaseObject.m_nCurrY-nDragY);
  EntrapDist:=Max(nDistx,nDisty);
  if EntrapDist = 0 then exit;

  for i:= 0 to EntrapDist do begin
    PlayObject.m_PEnvir.GetNextPosition(nDragX,nDragY,nDir, i,sx,sy);
    BaseObjectList:=TList.Create;
    PlayObject.m_PEnvir.GeTBaseObjects(sX,sY,True,BaseObjectList);
    if BaseObjectList.Count > 0 then
      inc(nTotalObjects); //count how many times we dragged
    if i = 0 then begin //first time there's no dragging just checking if someones there
      BaseObjectList.Free;
      continue;
    end;
    for II := 0 to BaseObjectList.Count - 1 do begin
      BaseObject:=TBaseObject(BaseObjectList.Items[II]);
      If PlayObject.IsProperTarget(BaseObject) and NOT BaseObject.m_boStickMode and
        (((BaseObject is TPlayObject) and (BaseObject.m_Abil.Level <= PlayObject.m_Abil.Level)) or
        (Not(BaseObject is TPlayObject) and (BaseObject.m_Abil.Level <= PlayObject.m_abil.Level+8))) then begin
        BaseObject.CharPushed(EntrapDir,I- nTotalObjects + 1);
        if Random(7-(UserMagic.btLevel * 2)) = 0 then
          BaseObject.MakePosion(POISON_STONE,UserMagic.btLevel + 3,0);
        PlayObject.SetTargetCreat(BaseObject);
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          TPlayObject(BaseObject).SetPKFlag(PlayObject);
          BaseObject.SetLastHiter(PlayObject);
        end;
      end;
    end;
    BaseObjectList.Free;
  end;
  if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then Result:=True;
end;

function TMagicManager.MagChangePosition(PlayObject: TPlayObject; nTargetX,
  nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
//var
//  i, nX, nY, olddir, oldx, oldy, nBackDir{, nDir}: Integer;
  //n01: Integer;
begin
  Result := False;
  //  n01 := 0;
  if not PlayObject.m_boOnHorse then begin
    if PlayObject.IsProperTargetSKILL_SLASHINGBURST(TargeTBaseObject, nTargetX, nTargetY) then begin
      //      nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
      PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      PlayObject.SpaceMove(PlayObject.m_PEnvir, nTargetX, nTargetY, 0);
      Result := True;
    end;
  end;
end;

function TMagicManager.MagMakePrivateTransparent(BaseObject: TBaseObject;
  nHTime: Integer): Boolean; //004930E8
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] > 0 then
    Exit; //4930FE
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX,
    BaseObject.m_nCurrY, 9, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
      (TargeTBaseObject.m_TargetCret = BaseObject) then begin
      if (abs(TargeTBaseObject.m_nCurrX - BaseObject.m_nCurrX) > 1) or
        (abs(TargeTBaseObject.m_nCurrY - BaseObject.m_nCurrY) > 1) or
        (Random(2) = 0) then begin
        TargeTBaseObject.m_TargetCret := nil;
      end;
    end;
  end;
  BaseObjectList.Free;
  BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := nHTime; //004931D2
  BaseObject.m_dwStatusArrTick[STATE_TRANSPARENT {0x70}] := GetTickCount; //004931D2
  BaseObject.m_nCharStatus := BaseObject.GetCharStatus();
  BaseObject.StatusChanged();
  BaseObject.m_boHideMode := True;
  BaseObject.m_boTransparent := True;
  BaseObject.ChangeStatusMode(STATUS_HIDEMODE, True);
  Result := True;
end;

function TMagicManager.MagReturn(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean; //00492368
begin
  //  Result := False;
  TargeTBaseObject.ReAlive;
  TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.MaxHP;
  TargeTBaseObject.SendAbility;
  Result := True;
end;

function TMagicManager.MagTamming2(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
//var
//  n14: Integer;
begin
  Result := False;
  if (TargeTBaseObject = nil) or (TargeTBaseObject.m_btRaceServer < RC_ANIMAL) then
    exit;
  if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4 - nMagicLevel) = 0)) then begin
    TargeTBaseObject.m_TargetCret := nil;
    if Random(2) = 0 then begin
      if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
        if Random(3) = 0 then begin
          if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) >
            (TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then begin
            if {not (TargeTBaseObject.bo2C1) and  }
              (TargeTBaseObject.m_btLifeAttrib = 0) and
              (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50})
              and
              (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount{(nMagicLevel + 2)}) then begin
              TargeTBaseObject.m_Master := BaseObject;
              TargeTBaseObject.m_btWuXin := 0;
              TargeTBaseObject.m_dwMasterRoyaltyTick :=
                LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2)
                * 5 + 20) * 60 * 1000) + GetTickCount;
              TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
              if TargeTBaseObject.m_dwMasterTick = 0 then
                TargeTBaseObject.m_dwMasterTick := GetTickCount();
              TargeTBaseObject.BreakHolySeizeMode();
              if LongWord(1500 - nMagicLevel * 200) <
                LongWord(TargeTBaseObject.m_nWalkSpeed) then begin
                TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
              end;
              if LongWord(2000 - nMagicLevel * 200) <
                LongWord(TargeTBaseObject.m_nNextHitTime) then begin
                TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
              end;
              TargeTBaseObject.ReAlive;
              TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.MaxHP;
              TargeTBaseObject.SendAbility;
              TargeTBaseObject.RefShowName();
              BaseObject.m_SlaveList.Add(TargeTBaseObject);
            end;
          end;
        end
        else begin
          if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) =
            0) then
            TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
        end;
      end
      else begin
        if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
          TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //变红
      end;
    end;
  end;
  Result := True;
end;

function TMagicManager.MagTamming(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
var
  n14: Integer;
  nCount: Integer;
  i: integer;
begin
  Result := False;
  if (TargeTBaseObject = nil) or (TargeTBaseObject.m_btRaceServer < RC_ANIMAL) then
    exit;
  //core failure rate based on skill level
  if ((Random(4 - nMagicLevel) > 0)) then begin
    if Random(2) = 0 then
      Result := True;
    exit;
  end;
  if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) then
    exit;
  {$region 'check if we havent already got a limited pet'}
  nCount:=0;
  if g_Config.nMagTammingCount > BaseObject.m_SlaveList.Count then
    nCount := g_Config.nMagTammingCount - BaseObject.m_SlaveList.Count;
  for i := 0 to BaseObject.m_SlaveList.Count-1 do begin
    if (TBaseObject(BaseObject.m_SlaveList[i]).m_btTameValue > 0) and (TargetBaseObject.m_btTameValue > 0) then
      nCount := 0;    
  end;
  {$endregion}
  {$region 'quick retame'}
  TargeTBaseObject.m_TargetCret := nil;
  if (TargetBaseObject.chance_to_retame) then begin
    if TargetBaseObject.previous_slave_owner = BaseObject then begin
      if ((Random(6) - nMagicLevel) = 0) and (ncount >= 0) then begin
        TargeTBaseObject.BreakCrazyMode();
        TargeTBaseObject.m_Master := BaseObject;
        TargeTBaseObject.m_btWuXin := 0;
        TargeTBaseObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + 20) * 60 * 1000) + GetTickCount;
        if TargeTBaseObject.m_dwMasterTick = 0 then TargeTBaseObject.m_dwMasterTick := GetTickCount();
        TargeTBaseObject.BreakHolySeizeMode();
        if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nWalkSpeed) then begin
          TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
        end;
        if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nNextHitTime) then begin
          TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
        end;
        TargeTBaseObject.RefShowName();
        TargetBaseObject.chance_to_retame := False;
        BaseObject.m_SlaveList.Add(TargeTBaseObject);
        Result:=True;
        exit;
      end;
    end;
  end;
  {$endregion}

  {$region 'eshocking our own pet'}
  if TargeTBaseObject.m_Master = BaseObject then begin
    TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
    Result := True;
    exit;
  end;
  {$endregion}
  if Random(2) > 0 then begin //chance to just go brown/red ?
    TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
    Result := True;
    exit; //basic fail rate
  end;

  if (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then exit;//after this dont allow undead mobs to slip through

  Result := True; //after this point you always get points for your eshock
  //check if we are the right lvl to even tame it
  if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
    if Random(3) > 0 then
      TargeTBaseObject.OpenCrazyMode(Random(20) + 10)
    else begin
      if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) > ((TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) - (BaseObject.m_nLuck * g_Config.effect_rate_of_luck_on_spells)) then begin
         if (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
           (nCount  > 0) then begin
           n14 := TargeTBaseObject.m_WAbil.HP div g_Config.nMagTammingHPRate {100};{should be max hp but i dont like it}
           if n14 <= 2 then
             n14 := 2
           else
             Inc(n14, n14);
           if (Random(n14) = 0) then begin //shock worked yay
             TargeTBaseObject.BreakCrazyMode();
             if TargeTBaseObject.m_Master <> nil then  //taming a pet of someone else lowers it hp bigtime
               TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.HP div 10;
             TargeTBaseObject.m_Master := BaseObject;
             TargeTBaseObject.m_btWuXin := 0;
             TargeTBaseObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + g_Config.nMagTammingMinimumLength) * 60 * 1000) + GetTickCount;
             TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
             if TargeTBaseObject.m_dwMasterTick = 0 then TargeTBaseObject.m_dwMasterTick := GetTickCount();
             TargeTBaseObject.BreakHolySeizeMode();
             if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nWalkSpeed) then
               TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
             if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nNextHitTime) then
               TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
             TargeTBaseObject.RefShowName();
             BaseObject.m_SlaveList.Add(TargeTBaseObject);
           end else begin
             if Random(14) = 0 then //1 in 14 chance of killing it (ontop of all the other randoms)
               TargeTBaseObject.m_WAbil.HP := 0;
           end;
         end;
      end else begin
        if (Random(20) = 0) then
          TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
      end;
    end;
  end;
end;

function TMagicManager.MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nLevel: Integer): Boolean; //004926D4
var
  n14: Integer;
begin
  Result := False;
  if TargeTBaseObject.m_boSuperMan or not (TargeTBaseObject.m_btLifeAttrib =
    LA_UNDEAD) or not (TargeTBaseObject.m_btNoTurnUndead = 0) then
    Exit;
  TAnimalObject(TargeTBaseObject).Struck {FFEC}(BaseObject);
  if TargeTBaseObject.m_TargetCret = nil then begin
    TAnimalObject(TargeTBaseObject).m_boRunAwayMode := True;
    TAnimalObject(TargeTBaseObject).m_dwRunAwayStart := GetTickCount();
    TAnimalObject(TargeTBaseObject).m_dwRunAwayTime := 10 * 1000;
  end;
  BaseObject.SetTargetCreat(TargeTBaseObject);
  if (Random(4) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then begin
    if TargeTBaseObject.m_Abil.Level < g_Config.nMagTurnUndeadLevel then begin
      n14 := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
      if Random(100) < ((nLevel shl 3) - nLevel + 15 + n14 + (BaseObject.m_nLuck * g_config.effect_rate_of_luck_on_spells)) then begin
        TargeTBaseObject.SetLastHiter(BaseObject);
        TargeTBaseObject.m_WAbil.HP := 0;
        Result := True;
      end
    end;
  end;
end;

function TMagicManager.MagWindTebo(PlayObject: TPlayObject;
  UserMagic: pTUserMagic): Boolean;
var
  PoseBaseObject: TBaseObject;
begin
  Result := False;
  PoseBaseObject := PlayObject.GetPoseCreate;
  if (PoseBaseObject <> nil) and
    (PoseBaseObject <> PlayObject) and
    (not PoseBaseObject.m_boDeath) and
    (not PoseBaseObject.m_boGhost) and
    (PlayObject.IsProperTarget(PoseBaseObject)) and
    (not PoseBaseObject.m_boStickMode) then begin
    if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
      (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
      (PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) then begin
      if Random(20) < UserMagic.btLevel * 6 + 6 + (PlayObject.m_Abil.Level - PoseBaseObject.m_Abil.Level) then begin
        PoseBaseObject.CharPushed(GetNextDirection(PlayObject.m_nCurrX,
          PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY),
          _MAX(0, UserMagic.btLevel - 1) + 1);
        Result := True;
      end;
    end;
  end;
end;

function TMagicManager.MagSaceMove(BaseObject: TBaseObject;
  nLevel: Integer): Boolean;
var
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := False;
  if Random(11) < nLevel * 2 + 4 then begin
    BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE2, 0, 0, 0, 0, '');
    if BaseObject is TPlayObject then begin
      Envir := BaseObject.m_PEnvir;
      BaseObject.MapRandomMove(BaseObject.m_sHomeMap, 1);
      if (Envir <> BaseObject.m_PEnvir) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        PlayObject := TPlayObject(BaseObject);
        PlayObject.m_boTimeRecall := False;
      end;
    end;
    Result := True;
  end;
end;

function TMagicManager.MagGroupFengPo(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.SC),
        SmallInt((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))));
      {if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin
        nPower := 0;
      end;}
      if nPower > 0 then begin
        nPower := BaseObject.GetStunDamage(PlayObject, nPower);
        nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
      end;
      if nPower > 0 then begin
        BaseObject.StruckDamage(nPower, PlayObject);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
          MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1,
          Integer(BaseObject), '', 200);
      end;
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupAmyounsul(PlayObject: TPlayObject
  { 修改 TBaseObject};
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
  {procedure sub_4934B4;
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 1 then begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;   }
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if CheckAmulet(PlayObject, 1, 2) then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
        if StdItem <> nil then begin
          UseAmulet(PlayObject, 1, 2);
          //if Random(BaseObject.m_btAntiPoison + 7) <= 6 then begin
          case StdItem.Shape of
            1: begin
                nPower := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH
                  {中毒类型 - 绿毒}, nPower + Random(PlayObject.m_nPoisonAttack), Integer(PlayObject),
                  ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
              end;
//            2: begin
//                nPower := GetPower13(30, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
//                BaseObject.SendDelayMsg(PlayObject, RM_POISON,
//                  POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower,
//                  Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower /
//                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
//                BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
//              end;
          end;
          if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
          BaseObject.SetLastHiter(PlayObject);
          PlayObject.SetTargetCreat(BaseObject);
          //end;
          //sub_4934B4;
        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupDeDing(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower, nDamage: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.DC), SmallInt((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC))));
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
    if (not g_Config.boDedingAllowPK) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then Continue;
    if (not g_Config.boDedingAllowPK) and (BaseObject.m_Master <> nil) and (BaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if not (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin
        if nPower > 0 then begin
          nPower := BaseObject.GetStunDamage(PlayObject, nPower);
          nDamage := BaseObject.GetHitStruckDamage(PlayObject, nPower);
          if nDamage > 0 then begin
            nDamage := ROUND(nDamage * (g_Config.nDidingPowerRate / 100));
            if nDamage > 0 then begin
              PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), _MAX(1, UserMagic.btLevel), Integer(BaseObject), '', 200);
              BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
            end;
          end;
        end;
        PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 1, '', 200);
      end;
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupLightening(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  nRate: Integer;
begin
  Result := False;
  boSpellFire := True;
  BaseObjectList := TList.Create;
  nRate := _MAX(1, UserMagic.btLevel); 
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, nRate, BaseObjectList);
  {PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
    MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
    MakeLong(nTargetX, nTargetY),
    Integer(TargeTBaseObject),
    '');      }

  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      //if (Random(10) >= BaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if BaseObject.m_btLifeAttrib = LA_UNDEAD then
        nPower := ROUND(nPower * 1.5);

      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower,
        MakeLong(nTargetX, nTargetY), nRate, Integer(BaseObject), '', 500);
      BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '');
      //if PlayObject.m_btRaceServer = RC_PLAYMOSTER then Result := True
      //else
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
      //end;
      //if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
        //PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
    end;
  end;
  PlayObject.SendRefMsg(RM_10205, 0, nTargetX, nTargetY, MakeWord(1, nRate), '', 400);
  BaseObjectList.Free;
end;

function TMagicManager.MagLightening(PlayObject: TPlayObject {修改 TBaseObject};
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  //boSpellFail: Boolean;
  nPower: Integer;
  StdItem: pTStdItem;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;

begin
  Result := False;
  //boSpellFail := True;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if CheckAmulet(PlayObject, 1, 2) then begin
      StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
      if StdItem <> nil then begin
        UseAmulet(PlayObject, 1, 2);
        if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then begin
          case StdItem.Shape of
            1: begin
                nPower := (GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2) + Random(PlayObject.m_nPoisonAttack);
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                  POISON_DECHEALTH , nPower + Random(PlayObject.m_nPoisonAttack), Integer(PlayObject),
                  ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 800);
                TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
              end;
            2: begin
                nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON,
                  POISON_DAMAGEARMOR, nPower,
                  Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower /
                  g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 800);
                TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
              end;
          end;
          if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or
            (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
        end;
        PlayObject.SetTargetCreat(TargeTBaseObject);
        //boSpellFail := False;
      end;
    end;
  end;
end;

function TMagicManager.MagWideAttack(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  BaseObjectList: TList;
  nTargetX, nTargetY: Integer;
  I, nPower: Integer;
  TargeBaseObject: TBaseObject;
begin
  Result := False;
  PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PlayObject.m_btDirection, 2, nTargetX, nTargetY);
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, 1, BaseObjectList);
  with PlayObject do
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
  if nPower > 0 then begin
    nPower := Round(nPower * (0.34 * _MAX(1, UserMagic.btLevel)));
    for I := 0 to BaseObjectList.Count - 1 do begin
      TargeBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if PlayObject.IsProperTarget(TargeBaseObject) then begin
        TargeBaseObject.SendDelayMsg(PlayObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '', 200);
        TargeBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        Result := True;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagHbFireBall(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY, nPower: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  //nPower: Integer;
  nDir, nRaceBasedChance, nLevelBasedChance, nActualSlowChance: Integer;
  levelgap: Integer;
  push: Integer;
  nSec, nChance: Integer;
begin
  nSec := Round(2 + 2 * UserMagic.btLevel) + Random(PlayObject.m_nFreezingAttack);
  nChance := Round(Random(10) + 3 * UserMagic.btLevel); // Better chance at slow for the higher the lvl the skill..

  Result := False;
  if not PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  if not PlayObject.IsProperTarget(TargeTBaseObject) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  if (TargeTBaseObject.m_nAntiMagic > Random(g_Config.nMagicResistanceRate)) or (abs(TargeTBaseObject.m_nCurrX - nTargetX) > 1) or (abs(TargeTBaseObject.m_nCurrY - nTargetY) > 1) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  with PlayObject do begin
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      Integer(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
  end;

  PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
  if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;

  if (TargeTBaseObject.m_wStatusTimeArr[POISON_SLOWDOWN] = 0) and (TargeTBaseObject.m_wStatusTimeArr[POISON_FREEZE] = 0) then begin
    if (usermagic.wMagIdx = 79) then begin    //ignore this, this is sam's special fc for testing mobs
      TargeTBaseObject.MakePosion(POISON_SLOWDOWN, (nSec * 10), 0);
      exit;
    end;

    //actual FC calculation

    //Half the chance of freeze pois if you are a player.
    nRaceBasedChance := 1;
    if TargetBaseObject.m_btRaceServer = RC_PLAYOBJECT then
      nRaceBasedChance := 2;

    //Lower levels than you are easier to pois
    nLevelBasedChance := TargetBaseObject.m_Abil.Level - PlayObject.m_Abil.Level;
    if nLevelBasedChance > 10 then
      nLevelBasedChance := 10;
    if nLevelBasedChance < -10 then
      nLevelBasedChance := -10;

    //Takes into account monster's slow resistance.
    nActualSlowChance := Round(20 + (UserMagic.btLevel - nLevelBasedChance) div nRaceBasedChance);
    nActualSlowChance := nActualSlowChance - Round((nActualSlowChance / 100) * TargetBaseObject.m_btSlowResist);
    if Random(100) < nActualSlowChance then begin
      if (nRaceBasedChance = 1) and (Random(10) = 0) then
        TargeTBaseObject.MakePosion(POISON_FREEZE, nSec, 0)
      else if (nRaceBasedChance = 2) and (Random(100) = 0) then
        TargeTBaseObject.MakePosion(POISON_FREEZE, nSec, 0)
      else
        TargeTBaseObject.MakePosion(POISON_SLOWDOWN, nSec + 1, 0)
    end;
  end;
end;

//产生任意形状的火

function TMagicManager.MagMakeSuperFireCross(PlayObject: TPlayObject; nDamage,
  nHTime, nX, nY: Integer; nCount: Integer): Integer;
  function MagMakeSuperFireCrossOfDir(btDir: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    i, {ii,} x, y: Integer;
    nTime: Integer;
    //    x1, x2, y1, y2: string;
  begin
    //    Result := 0;
    nTime := 1;
    case btDir of
      DR_UP: begin
          for y := PlayObject.m_nCurrY downto PlayObject.m_nCurrY - 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject,
              PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_UPRIGHT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX + i;
            y := PlayObject.m_nCurrY - i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_RIGHT: begin
          for x := PlayObject.m_nCurrX to PlayObject.m_nCurrX + 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime,
              nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWNRIGHT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX + i;
            y := PlayObject.m_nCurrY + i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWN: begin
          for y := PlayObject.m_nCurrY to PlayObject.m_nCurrY + 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject,
              PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWNLEFT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX - i;
            y := PlayObject.m_nCurrY + i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_LEFT: begin
          for x := PlayObject.m_nCurrX downto PlayObject.m_nCurrX - 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x,
              PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_UPLEFT: begin
          for i := 0 to 6 do begin
            x := PlayObject.m_nCurrX - i;
            y := PlayObject.m_nCurrY - i;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE,
              nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
    end;
    Result := 1;
  end;
var
  i: Integer;
begin
  Result := 0;
  case nCount of
    1: begin
        Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
      end;
    3: begin
        case PlayObject.m_btDirection of
          DR_UP: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_RIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
            end;
          DR_DOWN: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNLEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
            end;
          DR_LEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPLEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
            end;
        end;
      end;
    4: begin
        {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
        {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
        {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
        Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
      end;
    5: begin
        case PlayObject.m_btDirection of
          DR_UP, DR_UPLEFT, DR_UPRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_LEFT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
            end;
          DR_RIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_UP);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              {Result := }MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWN, DR_DOWNLEFT, DR_DOWNRIGHT: begin
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWN);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              {Result := }MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
        end;
      end;
    8: begin
        for i := DR_UP to DR_UPLEFT do
          Result := MagMakeSuperFireCrossOfDir(i);
      end;
  end;
end;

//火墙

function TMagicManager.MagMakeFireCross(PlayObject: TPlayObject; nDamage,
  nHTime, nX, nY: Integer): Integer; //00492C9C
var
  FireBurnEvent: TFireBurnEvent;
resourcestring
  sDisableInSafeZoneFireCross = 'Can not use in safe zone...';
  sDisableInSafeZoneFireCross1 = 'Can not use in this map...';
begin
  Result := 0;
  if g_Config.boDisableInSafeZoneFireCross and
    PlayObject.InSafeZone(PlayObject.m_PEnvir, nX, nY) then begin
    PlayObject.SysMsg(sDisableInSafeZoneFireCross, c_Red, t_Notice);
    Exit;
  end;

  if PlayObject.m_PEnvir.m_boUnAllowFireMagic then begin
    PlayObject.SysMsg(sDisableInSafeZoneFireCross1, c_Red, t_Notice);
    Exit;
  end;

  if ((PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil) or (TPoisonCloudEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil) or (TPoisonCloudEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if ((PlayObject.m_PEnvir.GetEvent(nX, nY) = nil) or (TPoisonCloudEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime *
      1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil) or (TPoisonCloudEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if ((PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil) or (TPoisonCloudEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE,
      nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
  Result := 1;
end;

function TMagicManager.MagMakePoisonCloud(PlayObject: TPlayObject; nDamage,
  nHTime, nX, nY: Integer; UserMagic: pTUserMagic): Integer; //00492C9C
var
  PoisonCloudEvent: TPoisonCloudEvent;
  StdItem: pTStdItem;
begin
  Result := 0;

  if CheckAmulet(PlayObject, 1, 2) then begin
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if StdItem <> nil then begin
      if StdItem.Shape = 1 then begin
        UseAmulet(PlayObject, 1, 2);
        if ((PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY - 1, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //0492CFC   x
        if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX - 1, nY)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX - 1, nY, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //0492D4D
        if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY - 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX - 1, nY - 1)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX - 1, nY - 1, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //0492CFC   x
        if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY + 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX - 1, nY + 1)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX - 1, nY + 1, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //0492D4D
        if ((PlayObject.m_PEnvir.GetEvent(nX, nY) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY, ET_POISONCLOUD, nHTime *
            1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //00492D9C
        if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX + 1, nY)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX + 1, nY, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //00492DED
        if ((PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY + 1)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY + 1, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //00492E3E
        if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY - 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX + 1, nY - 1)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX + 1, nY - 1, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //00492DED
        if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY + 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX + 1, nY + 1)) <> nil)) then begin
          PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX + 1, nY + 1, 0,
            nHTime * 1000, nDamage, UserMagic);
          g_EventManager.AddEvent(PoisonCloudEvent);
        end; //00492E3E
        Result := 1;
      end; 
    end;
  end;
end;

function TMagicManager.MagMakePoisonField(PlayObject: TPlayObject; UserMagic: pTUserMagic; nX, nY: Integer): Integer; //00492C9C
const
  sPoisonXY:array[0..9,0..1] of Integer =
   ((-2, -1), (-1, -1), (0, -1), (+1, -1),
   (-1, 0), (0, 0), (+1, 0),
   (-1, +1), (0, +1), (+1, +1));
var
  PoisonCloudEvent: TPoisonCloudEvent;
  nCastTime, nHTime, nDamage, nXOffset, nYOffset, i, nEventType, nDuration: Integer;
  StdItem: pTStdItem;

  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) *
      (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower +
      Random(UserMagic.MagicInfo.btDefMaxPower -
      UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;
begin
  Result := 0;

  if CheckAmulet(PlayObject, 5, 2) then begin
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if StdItem <> nil then begin
      UseAmulet(PlayObject, 5, 2);

      nDamage := ((GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2) div 3) + (Random(7) * UserMagic.btLevel);
      nHTime := ROUND(UserMagic.btLevel / 3 * (nDamage / g_Config.nAmyOunsulPoint));
      nEventType := 0;
      nDuration := 5 + (UserMagic.btLevel);

//      if ((PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY - 1, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY + 1)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY + 1, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY - 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY - 1)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY - 1, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY + 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY + 1)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY + 1, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX, nY) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX, nY)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX, nY, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX - 1, nY)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX - 1, nY, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX + 1, nY)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX + 1, nY, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY - 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX - 1, nY)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX - 1, nY, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
//      if ((PlayObject.m_PEnvir.GetEvent(nX + 1, nY + 1) = nil) or (TFireBurnEvent(PlayObject.m_PEnvir.GetEvent(nX + 1, nY)) <> nil)) then begin
//        PoisonCloudEvent := TPoisonCloudEvent.Create(PlayObject, nX + 1, nY, ET_POISONCLOUD,
//        nHTime, nDamage, nDuration);
//        g_EventManager.AddEvent(PoisonCloudEvent);
//      end;
    end;
  end;
  Result := 1;
end;

function TMagicManager.MagBigExplosionAndMakePoisonByWarr(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer; var boMove: Boolean): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  PlayObject: TPlayObject;
  nPowerPoint: Integer;
  nTime: Integer;
  MakePoisonInfo: pTMakePoisonInfo;
begin
  Result := False;
  boMove := False;
  if BaseObject.MagCanMoveTarget(nX, nY) then begin
    boMove := True;
    nX := BaseObject.m_nCurrX;
    nY := BaseObject.m_nCurrY;
    nPowerPoint := Round(g_Config.nSkill70PowerRate / 100 * nPower);
    nTime := 3 * UserMagic.btLevel + Random(2 * UserMagic.btLevel);
    if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then Exit;
    PlayObject := TPlayObject(BaseObject);
    BaseObjectList := TList.Create;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
    for i := 0 to BaseObjectList.Count - 1 do begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if BaseObject.IsProperTarget(TargeTBaseObject) then begin
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerPoint, MakeLong(nX, nY), 3, Integer(TargeTBaseObject), '', 600);
        TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        if PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level then begin
          if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
            if g_Config.boSkill70MbAttackHuman then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill70MbFastParalysis;
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {中毒类型 - 麻痹}, nTime, Integer(MakePoisonInfo), 0, '', 600);
             end;
          end else begin
            if (TargeTBaseObject.m_Master <> nil) and (TargeTBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
              if g_Config.boSkill70MbAttackSlave then begin
                New(MakePoisonInfo);
                MakePoisonInfo.BaseObject := PlayObject;
                MakePoisonInfo.nX := nX;
                MakePoisonInfo.nY := nY;
                MakePoisonInfo.nRate := 3;
                MakePoisonInfo.boFastParalysis := g_Config.boSkill70MbFastParalysis;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {中毒类型 - 麻痹}, nTime, Integer(MakePoisonInfo), 0, '', 600);
              end;
            end else begin
              if g_Config.boSkill70MbAttackMon then begin
                New(MakePoisonInfo);
                MakePoisonInfo.BaseObject := PlayObject;
                MakePoisonInfo.nX := nX;
                MakePoisonInfo.nY := nY;
                MakePoisonInfo.nRate := 3;
                MakePoisonInfo.boFastParalysis := g_Config.boSkill70MbFastParalysis;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_STONE {中毒类型 - 麻痹}, nTime, Integer(MakePoisonInfo), 0, '', 600);
              end;
            end;
          end;
        end;
        Result := True;
      end;
    end;
    BaseObjectList.Free;
  end;
end;

function TMagicManager.MagBigExplosionAndMakePoisonEx(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  PlayObject: TPlayObject;
  nPowerPoint: Integer;
  nTime: Integer;
  MakePoisonInfo: pTMakePoisonInfo;
begin
  Result := False;
  nPowerPoint := Round(g_Config.nSkill71PowerRate / 100 * nPower);
  nTime := 3 * UserMagic.btLevel + Random(2 * UserMagic.btLevel);
  nTime := nTime + Random(PlayObject.m_nFreezingAttack);
  if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then Exit;
  PlayObject := TPlayObject(BaseObject);
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerPoint, MakeLong(nX, nY), 3, Integer(TargeTBaseObject), '', 600);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      if PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level then begin
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_Config.boSkill71MbAttackHuman then begin
            New(MakePoisonInfo);
            MakePoisonInfo.BaseObject := PlayObject;
            MakePoisonInfo.nX := nX;
            MakePoisonInfo.nY := nY;
            MakePoisonInfo.nRate := 3;
            MakePoisonInfo.boFastParalysis := g_Config.boSkill71MbFastParalysis;
            if Random(1) = 0 then
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_SLOWDOWN, nTime, Integer(MakePoisonInfo), 0, '', 600)
            else
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_FREEZE, nTime, Integer(MakePoisonInfo), 0, '', 600);
           end;
        end else begin
          if (TargeTBaseObject.m_Master <> nil) and (TargeTBaseObject.m_Master.m_btRaceServer = RC_PLAYOBJECT) then begin
            if g_Config.boSkill71MbAttackSlave then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill71MbFastParalysis;
              if Random(1) = 0 then
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_SLOWDOWN, nTime, Integer(MakePoisonInfo), 0, '', 600)
            else
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_FREEZE, nTime, Integer(MakePoisonInfo), 0, '', 600);
            end;
          end else begin
            if g_Config.boSkill71MbAttackMon then begin
              New(MakePoisonInfo);
              MakePoisonInfo.BaseObject := PlayObject;
              MakePoisonInfo.nX := nX;
              MakePoisonInfo.nY := nY;
              MakePoisonInfo.nRate := 3;
              MakePoisonInfo.boFastParalysis := g_Config.boSkill71MbFastParalysis;
              if Random(1) = 0 then
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_SLOWDOWN, nTime, Integer(MakePoisonInfo), 0, '', 600)
              else
              TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAKEPOISON, POISON_FREEZE, nTime, Integer(MakePoisonInfo), 0, '', 600);
            end;
          end;
        end;
      end;

      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagBigExplosionAndMakePoison(BaseObject: TBaseObject; UserMagic: pTUserMagic; nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  PlayObject: TPlayObject;
  nPowerPoint: Integer;
  nTime: Integer;
begin
  Result := False;
  nPowerPoint := nPower;
  PlayObject := TPlayObject(BaseObject);
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPowerPoint, MakeLong(nX, nY), 3, Integer(TargeTBaseObject), '', 1200);
      TargeTBaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
      if TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT then begin //If not human perform hallcuination
        if PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level then begin
          if (not TargetBaseObject.m_boHallucinationMode) and (not TargetBaseObject.m_boStoneMode) and (TargetBaseObject.m_Master = nil) then begin
            nTime := (1 + Random(3)) + (4 * UserMagic.btLevel); //If max level skill then spell can last about 12 seconds + Random1-4 seconds more
            TargetBaseObject.OpenHallucinationMode(nTime);
          end;
        end;
      end;
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagMassRangeDamage(user_object: TBaseObject; damage_of_effect, cursor_x, cursor_y, type_of_effect: Integer; user_magic: pTUserMagic): Boolean;
var
  i, j, amount_of_attacks, range_of_effect, duration_of_poison, incremental_increase_of_delay,
  chance_of_additional_hits: Integer;
  target_object_list: TList;
  target_object: TBaseObject;
  slow_effect: boolean;
  nActualSlowChance: Integer;
begin
  Result := False;
  incremental_increase_of_delay := 0;
  chance_of_additional_hits := 0;
  amount_of_attacks := 1;
  slow_effect := False;
  target_object_list := TList.Create;
  case type_of_effect of
    0: begin //fire bang
      range_of_effect := g_Config.nFireBoomRage;
    end;
    1: begin // ice storm
      range_of_effect := g_Config.nSnowWindRange;
    end;
    2: begin // ice thrust range
      range_of_effect := g_Config.ice_thrust_range;
      slow_effect := True;
      duration_of_poison := Round(2 + 2 * user_magic.btLevel);
    end;
    3: begin //meteor strike
      range_of_effect := g_Config.meteor_strike_range;
      amount_of_attacks := 2;
      chance_of_additional_hits := 25 - (user_object.m_nLuck * g_config.effect_rate_of_luck_on_spells);
      if chance_of_additional_hits <= 0 then
        chance_of_additional_hits := 5;
      if(Random(chance_of_additional_hits)  = 0) then
        amount_of_attacks := amount_of_attacks + 1;
      if(Random((chance_of_additional_hits * 2)) = 0) then
        amount_of_attacks := amount_of_attacks + 1;
    end;
    4: begin //blizzard
      range_of_effect := 2;
      amount_of_attacks := 2;
      slow_effect := True;
      duration_of_poison := Round(2 + 2 * user_magic.btLevel);
    end;
  end;

  user_object.GetMapBaseObjects(user_object.m_PEnvir, cursor_x, cursor_y, range_of_effect, target_object_list);

  for i := 0 to target_object_list.Count - 1 do begin
    target_object := TBaseObject(target_object_list.Items[i]);
    if user_object.IsProperTarget(target_object) then begin
      user_object.SetTargetCreat(target_object);

      for j := 0 to amount_of_attacks - 1 do begin
        user_object.SendDelayMsg(user_object, RM_DELAYMAGIC, damage_of_effect, MakeLong(target_object.m_nCurrX, target_object.m_nCurrY), 2, Integer(target_object), '', incremental_increase_of_delay);
        Inc(incremental_increase_of_delay, 400);
      end;

      if slow_effect then begin
        if (target_object.m_wStatusTimeArr[POISON_SLOWDOWN] = 0) then begin
          nActualSlowChance := user_magic.btLevel * 5;
          nActualSlowChance := nActualSlowChance - Round((nActualSlowChance / 100) * target_object.m_btSlowResist);

          if Random(20) < nActualSlowChance then
            target_object.MakePosion(POISON_SLOWDOWN, duration_of_poison + Random(User_object.m_nFreezingAttack), 0)
        end;
      end;

      target_object.MagicQuest(user_object, user_magic.wMagIdx, mfs_TagEx);
      Result := True;
    end;
  end;
  target_object_list.Free;
end;

function TMagicManager.MagBigExplosionTime(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage, nMagID: Integer): Boolean;
var
  i, nTime: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  nTime := 400 + (abs(BaseObject.m_nCurrX - nX) + abs(BaseObject.m_nCurrY - nY)) div 2 * 20;
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      BaseObject.SetTargetCreat(TargeTBaseObject);
      BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nX, nY), nRage, Integer(TargeTBaseObject), '', nTime);
      TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
      //TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagDoubleBigExplosionEx(PlayObject: TPlayObject; nPower, nX, nY, nRage: Integer; UserMagic: pTUserMagic; boDecMP: Boolean): Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  for I := 0 to PlayObject.m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors.Items[i]).BaseObject);
    if (BaseObject = nil) or (BaseObject.m_boGhost) or BaseObject.m_boDeath then Continue;
    if (BaseObject.m_PEnvir = PlayObject.m_PEnvir) and (abs(BaseObject.m_nCurrX - nX) <= 6) and
      (abs(BaseObject.m_nCurrY - nY) <= 6) then begin
      if PlayObject.IsProperTarget(BaseObject) then begin
        BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        if boDecMP and g_Config.boSkill66ReduceMP then BaseObject.DamageSpell(nPower div 2);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nX, nY), 2, Integer(BaseObject), '', 1380);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nX, nY), 2, Integer(BaseObject), '', 2000);
        if Round(Random(20 - (UserMagic.btLevel * 5))) <= 0 then
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nX, nY), 2, Integer(BaseObject), '', 2000);
        if Round(Random(60 - (UserMagic.btLevel * 5))) <= 0 then
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nX, nY), 2, Integer(BaseObject), '', 2000);
        Result := True;
      end;
    end;
  end;
end;

function TMagicManager.MagUltimateEnhance(PlayObject: TPlayObject; TargetBaseObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
var
  nPower, nTime: Integer;
begin
  Result := False;

  if TargetBaseObject = nil then begin
    TargetBaseObject := PlayObject;
  end;

  if PlayObject.IsProperFriend(TargetBaseObject) then begin
    nPower := Round(HiWord(PlayObject.m_WAbil.SC) div 8) - 1;
    if nPower <= 0 then
      nPower := 1;
    if nPower > 8 then
      nPower := 8;

    nTime := 30 + (30 * UserMagic.btLevel);

    //if TargetBaseObject.m_wStatusTimeArr[TargetBaseObject.m_btJob] = 0 then begin
    if TargetBaseObject.m_wStatusArrValue[12] = 0 then begin
      PlayObject.MagChangeAbility(nPower, nTime, 12, UserMagic, TargetBaseObject);
      Result := True;
    end else begin
      PlayObject.MagChangeAbility(TargetBaseObject.m_wStatusArrValue[12], nTime, 12, UserMagic, TargetBaseObject);
      Result := True;
    end;

  end;
end;

function TMagicManager.MagHaste(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  nPower, nTime: Integer;
begin
  Result := False;

  nPower := 2 + (2 * UserMagic.btLevel);
  nTime := 25 + (15 * UserMagic.btLevel);

  if PlayObject <> nil then begin
    PlayObject.ASpeedUp(nPower, nTime);
    Result := True;
  end;
end;

function TMagicManager.MagLightBody(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  nPower, nTime: Integer;
begin
  Result := False;

  nPower := (1 * UserMagic.btLevel + 1);
  nTime := 30 + ( (15 + Random(5)) * UserMagic.btLevel) + Round(HiWord(PlayObject.m_WAbil.DC) / 5 );

  if PlayObject <> nil then begin
    PlayObject.AgilityUp(nPower, nTime);
    Result := True;
  end;
end;

function TMagicManager.MagDoubleBigExplosion(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperTarget(TargeTBaseObject) then begin
      BaseObject.SetTargetCreat(TargeTBaseObject);
      TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
      BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower,
        MakeLong(nX, nY), nRage, Integer(TargeTBaseObject), '', 1400);
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagMassDamageAroundUser(user_object: TBaseObject; damage_of_effect, magic_id, type_of_effect: Integer): Boolean;
var
  i: Integer;
  target_object_list: TList;
  target_object: TBaseObject;
  ndamage: integer;
begin
  Result := False;
  target_object_list := TList.Create;

  case type_of_effect of
    0: begin //thunderstorm
      user_object.GetMapBaseObjects(user_object.m_PEnvir, user_object.m_nCurrX, user_object.m_nCurrY, g_Config.nElecBlizzardRange, target_object_list);
    end;
    1: begin //flamefield
      user_object.GetMapBaseObjects(user_object.m_PEnvir, user_object.m_nCurrX, user_object.m_nCurrY, g_Config.nElecBlizzardRange, target_object_list);
    end;
  end;

  for i := 0 to target_object_list.Count - 1 do begin
    target_object := TBaseObject(target_object_list.Items[i]);
    ndamage:= damage_of_effect;
    if (type_of_effect = 0) and (target_object.m_btLifeAttrib <> LA_UNDEAD) then
      ndamage := damage_of_effect div 10; //Cut damage for any living target

    {else if (type_of_effect = 1) and (target_object.m_btLifeAttrib <> LA_UNDEAD) then
      ndamage := Round(ndamage * 1.2); }//multiply damage by 1.2 for living targets.

    {disabled since none of the fire magics have it (weird)
    if (type_of_effect = 1) and (target_object.m_btLifeAttrib <> LA_UNDEAD) then
      ndamage := Round(damage_of_effect * 1.5);} // fire skills have bonus dmg vs normal mobs

    if user_object.IsProperTarget(target_object) then begin
      target_object.SendMsg(user_object, RM_MAGSTRUCK, 0, ndamage, 0, 0, '');
      target_object.MagicQuest(user_object, magic_id, mfs_TagEx);
      Result := True;
    end;
  end;
  target_object_list.Free;
end;

function TMagicManager.MagMakeHolyCurtain(BaseObject: TBaseObject; nPower:
  Integer; nX, nY: Integer): Integer; //004928C0
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  MagicEvent: pTMagicEvent;
  HolyCurtainEvent: THolyCurtainEvent;
begin
  Result := 0;
  if BaseObject.m_PEnvir.CanWalk(nX, nY, True) then begin
    BaseObjectList := TList.Create;
    MagicEvent := nil;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
    for i := 0 to BaseObjectList.Count - 1 do begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
        ((Random(4) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level) and
        (TargeTBaseObject.m_Master = nil) then begin
        TargeTBaseObject.OpenHolySeizeMode(nPower * 1000);
        if MagicEvent = nil then begin
          New(MagicEvent);
          SafeFillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
          MagicEvent.BaseObjectList := TList.Create;
          MagicEvent.dwStartTick := GetTickCount();
          MagicEvent.dwTime := nPower * 1000;
        end;
        MagicEvent.BaseObjectList.Add(TargeTBaseObject);
        Inc(Result);
      end
      else begin //00492A02
        Result := 0;
      end;
    end;
    BaseObjectList.Free;
    if (Result > 0) and (MagicEvent <> nil) then begin
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[0] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[1] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[2] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[3] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[4] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[5] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[6] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[7] := HolyCurtainEvent;
      UserEngine.m_MagicEventList.Add(MagicEvent);
    end
    else begin
      if MagicEvent <> nil then begin
        MagicEvent.BaseObjectList.Free;
        DisPose(MagicEvent);
      end;
    end;
  end;
end;

function TMagicManager.MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY,
  nHTime, nMagID: Integer): Boolean; //0049320C
var
  i: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.IsProperFriend(TargeTBaseObject) then begin
      if TargeTBaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0 then begin //00493287
        TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_TRANSPARENT, 0,
          nHTime, 0, 0, '', 800);
        TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
        //TargeTBaseObject.SendMsg(TargeTBaseObject, RM_TRANSPARENT, 0, nHTime, 0, 0, '');
        Result := True;
      end;
    end
  end;
  BaseObjectList.Free;
end;
//=====================================================================================
//名称：
//功能：
//参数：
//     BaseObject       魔法发起人
//     TargeTBaseObject 受攻击角色
//     nPower           魔法力大小
//     nLevel           技能修炼等级
//     nTargetX         目标座标X
//     nTargetY         目标座标Y
//返回值：
//=====================================================================================

function TMagicManager.MabMabe(BaseObject, TargeTBaseObject: TBaseObject;
  nPower, nLevel,
  nTargetX, nTargetY, nMagID: Integer): Boolean;
var
  nLv: Integer;
begin
  Result := False;
  if TargeTBaseObject = nil then
    exit;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTBaseObject) then begin
    if BaseObject.IsProperTarget(TargeTBaseObject) and (BaseObject <> TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(g_Config.nMagicResistanceRate)) and
        (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and
        (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3,
          MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
        TargeTBaseObject.MagicQuest(BaseObject, nMagID, mfs_TagEx);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) >
          TargeTBaseObject.m_Abil.Level then begin
          nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) <
            _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv))
            {or (Random(abs(nLv))}then begin
            // if (Random(100) < ((nLevel shl 3) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (g_Config.nMabMabeHitSucessRate > 0) and (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTBaseObject);
              end;
              TargeTBaseObject.SetLastHiter(BaseObject);
              nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject, nPower);
              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower,
                MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '',
                600);
              //BaseObject.SendMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
              if not TargeTBaseObject.m_boUnParalysis then
                TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE
                  {中毒类型 - 麻痹}, nPower div g_Config.nMabMabeHitMabeTimeRate
                  {20}+ Random(nLevel), Integer(BaseObject), nLevel, '', 650);
              //TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {中毒类型 - 麻痹}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 10);
            end;
            Result := True;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagMakeMoonSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  i: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel, nX, nY: Integer;
  nCount: Integer;
  nTotalCount: Integer;
  dwRoyaltySec: LongWord;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMonName := g_Config.sMoonSpirit;
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;
  nCount := g_Config.nMoonSpiritCount;
  nTotalCount:= g_Config.nTotalTaoPetCount;
  dwRoyaltySec := 10 * 24 * 60 * 60;
  for i := Low(g_Config.MoonSpiritArray) to High(g_Config.MoonSpiritArray) do begin
    if not (g_Config.MoonSpiritArray[i].sMonName = '') and (nMakeLevel = i) then begin
      sMonName := g_Config.MoonSpiritArray[i].sMonName;
    end;
  end;
  for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
    if nCount <= 0 then break;
    if nTotalCount <= 0 then break;

    BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
      if (BaseObject.m_nSlaveMagIndex in [SKILL_65]) then Dec(nCount);
      if (BaseObject.m_nSlaveMagIndex in [SKILL_SUMMONSKELETON, SKILL_SUMMONSHINSU,SKILL_65]) then Dec(nTotalCount);
    end else
      PlayObject.m_SlaveList.Delete(I);
  end;
  if (nCount > 0) and (nTotalCount > 0) then begin
    if (PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, SKILL_65, dwRoyaltySec) <> nil) then
      Result := True;
  end else begin
    for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
      if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        if BaseObject.m_nSlaveMagIndex = SKILL_65 then begin
          PlayObject.GetBackPosition(nX, nY);
          BaseObject.SpaceMove(PlayObject.m_PEnvir, nX, nY, 1);
        end;
      end else
        PlayObject.m_SlaveList.Delete(I);
    end;
  end;
end;

function TMagicManager.MagMakeSinSuSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  i: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel, nX, nY: Integer;
  nCount: Integer;
  nTotalCount: Integer;
  dwRoyaltySec: LongWord;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMonName := g_Config.sDogz;
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;
  nCount := g_Config.nDogzCount;
  nTotalCount := g_Config.nTotalTaoPetCount;
  dwRoyaltySec := 10 * 24 * 60 * 60;
  for i := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    if not (g_Config.DogzArray[i].sMonName = '') and (nMakeLevel = i) then begin
      sMonName := g_Config.DogzArray[i].sMonName;
    end;
  end;

  for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
    if nCount <= 0 then break;
    if nTotalCount <= 0 then break;
    
    BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
      if (BaseObject.m_nSlaveMagIndex  in [SKILL_SUMMONSHINSU]) then Dec(nCount);
            if (BaseObject.m_nSlaveMagIndex in [SKILL_SUMMONSKELETON, SKILL_SUMMONSHINSU,SKILL_65]) then Dec(nTotalCount);
    end else
      PlayObject.m_SlaveList.Delete(I);
  end;
  if (nCount > 0) and (nTotalCount > 0) then begin
    if (PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, SKILL_SUMMONSHINSU, dwRoyaltySec) <> nil) then
      Result := True;
  end else begin
    for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
      if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        if BaseObject.m_nSlaveMagIndex = SKILL_SUMMONSHINSU then begin
          PlayObject.GetBackPosition(nX, nY);
          BaseObject.SpaceMove(PlayObject.m_PEnvir, nX, nY, 1);
        end;
      end else
        PlayObject.m_SlaveList.Delete(I);
    end;
  end;
end;

function TMagicManager.MagMakeSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  i: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel, nX, nY: Integer;
  nCount: Integer;
  nTotalCount: Integer;
  dwRoyaltySec: LongWord;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMonName := g_Config.sBoneFamm;
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;
  nCount := g_Config.nBoneFammCount;
  nTotalCount := g_Config.nTotalTaoPetCount;
  dwRoyaltySec := 10 * 24 * 60 * 60;

  for i := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    if not (g_Config.BoneFammArray[i].sMonName = '') and (nMakeLevel = i) then begin
      sMonName := g_Config.BoneFammArray[i].sMonName;
    end;
  end;

  for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
    if nCount <= 0 then break;
    if nTotalCount <= 0 then break;
    
    BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
    if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
      if (BaseObject.m_nSlaveMagIndex in [SKILL_SUMMONSKELETON]) then Dec(nCount);
            if (BaseObject.m_nSlaveMagIndex in [SKILL_SUMMONSKELETON, SKILL_SUMMONSHINSU,SKILL_65]) then Dec(nTotalCount);
    end else
      PlayObject.m_SlaveList.Delete(I);
  end;
  if (nCount > 0) and (nTotalCount > 0) then begin
    if (PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, 100, SKILL_SUMMONSKELETON, dwRoyaltySec) <> nil) then
      Result := True;
  end else begin
    for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList[I]);
      if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) then begin
        if BaseObject.m_nSlaveMagIndex = SKILL_SUMMONSKELETON then begin
          PlayObject.GetBackPosition(nX, nY);
          BaseObject.SpaceMove(PlayObject.m_PEnvir, nX, nY, 1);
        end;
      end else
        PlayObject.m_SlaveList.Delete(I);
    end;
  end;
end;


function TMagicManager.MagGroupMb(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nTime: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  nTime := UserMagic.btLevel + 1;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, 4,
    BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not g_Config.boGroupMbAttackPlayObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then begin
      if not BaseObject.m_boUnParalysis and (Random(BaseObject.m_btAntiPoison) = 0) then begin
        if (BaseObject.m_Abil.Level < PlayObject.m_Abil.Level) or (Random(PlayObject.m_Abil.Level - BaseObject.m_Abil.Level) = 0)
          then begin
          BaseObject.MakePosion(POISON_STONE, nTime, 0);
          BaseObject.m_boFastParalysis := True;
          BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);
        end;
      end;
    end;
    if BaseObject.m_btRaceServer >= RC_ANIMAL then
      Result := True;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagMakeSelf(BaseObject, TargeTBaseObject: TBaseObject; UserMagic: pTUserMagic):Boolean;
var
  sMonName:String;
  nMakeLevel,nExpLevel:Integer;
  dwRoyaltySec:LongWord;
  nMpLoss:Integer;
  nSpellPoint:Integer;
begin
  Result:=False;
  //if not BaseObject.sub_4DD704 then begin
    sMonName:='WizClone';
    nMakeLevel:=UserMagic.btLevel;
    nExpLevel:=UserMagic.btLevel;
    dwRoyaltySec:=10 * 24 * 60 * 60;
    nMpLoss:= UserMagic.MagicInfo.wPower;
    if ((BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount) and (BaseObject.MakeClone(sMonName,nMakeLevel,nExpLevel,dwRoyaltySec,nMpLoss) <> nil)) then
      Result:=True
    else begin
      BaseObject.KillClone(sMonName);
      exit;
    end;
  //end;
end;

function TMagicManager.MagEnergyShield(user_object: TPlayObject; duration_of_effect: Integer; type_of_effect: Byte; user_magic: pTUserMagic; target_object: TBaseObject): Boolean;
var
  nPower, old_user_status: Integer;
  base_user_object: TBaseObject;
begin
  Result := False;
  if target_object = nil then begin
    target_object := user_object;
  end;
              mainoutmessage(target_object.m_sCharName);
  if user_object.IsProperFriend(target_object) then begin
    mainoutmessage('is proper mate');
    if target_object.MagBubbleDefenceUp(user_magic.btLevel, duration_of_effect, type_of_effect) then
      Result := true;
  end;
end;

function TMagicManager.MagHeavenlySword(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  BaseObject: TBaseObject;
  nX, nY: Integer;
  I, nPower, nDamage: Integer;
begin
  Result := False;
  nDamage := 0;
  nPower := 0;

  with PlayObject do begin
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1);
    //mainoutmessage('nPower = ' + intToStr(nPower));
    for I := 1 to 3 do begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);

        if IsProperTarget(BaseObject) then begin
          nDamage := nPower;
          if I >= 2 then
            nDamage := round( nDamage / ( 1 + (0.35 * I) ) );

          //mainoutmessage('nDamage spot ' + intToStr(i) + ' = ' + intToStr(nDamage));

          if nDamage > 0 then begin
            BaseObject.SendMsg(PlayObject, RM_MAGSTRUCK, 0, nDamage, 0, 0, '');
            BaseObject.MagicQuest(PlayObject, UserMagic.wMagIdx, mfs_TagEx);

            Result := True;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagTrap(PlayObject: TPlayObject; TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nPower: Integer): Boolean;
var
  i: Integer;
  MagicEvent: pTMagicEvent;
  HolyCurtainEvent: THolyCurtainEvent;
begin
  Result := False;

  if PlayObject.m_PEnvir.CanWalk(nTargetX, nTargetY, True) then begin
    MagicEvent := nil;
    //MainOutMessage('Part 1 worked');

    if (TargeTBaseObject <> nil) and
    (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
    (PlayObject.m_Abil.Level >= TargeTBaseObject.m_Abil.Level) and
    (TargeTBaseObject.m_Master = nil) then begin

      TargeTBaseObject.OpenHolySeizeMode(nPower * 1000);
      //MainOutMessage('Part 2 worked');

      if MagicEvent = nil then begin
        New(MagicEvent);
        SafeFillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
        MagicEvent.BaseObjectList := TList.Create;
        MagicEvent.dwStartTick := GetTickCount();
        MagicEvent.dwTime := nPower * 1000;

        //MainOutMessage('Part 3 worked');
      end;

      MagicEvent.BaseObjectList.Add(TargeTBaseObject);
      Result := True;
      //MainOutMessage('Part 4 worked');
    end
    else begin

      Result := False;
      //MainOutMessage('Part 5 oh no');
    end;
  end;

  if Result and (MagicEvent <> nil) then begin
    HolyCurtainEvent := THolyCurtainEvent.Create(PlayObject.m_PEnvir, nTargetX, nTargetY, ET_TRAP, nPower * 1000);
    g_EventManager.AddEvent(HolyCurtainEvent);
    MagicEvent.Events[0] := HolyCurtainEvent;
    UserEngine.m_MagicEventList.Add(MagicEvent);
    //MainOutMessage('Part 6');
  end
  else begin

    if MagicEvent <> nil then begin
      DisPose(MagicEvent);
      //MainOutMessage('Part 7 fail');
    end;
  end;
end;

end.

