unit ObjPlayCmd;

interface
uses
  Windows, Classes, SysUtils, Forms, StrUtils, Math, Grobal2, Envir, Common, DateUtils, ObjBase, SDK, ObjPlay;

procedure ProcessUserCmdMsg(PlayObject: TPlayObject; sData: string);

//用户普通命令
procedure CmdChangeAttackMode(PlayObject: TPlayObject; nMode: Integer);
procedure CmdChangeSalveStatus(PlayObject: TPlayObject);
procedure CmdPrvMsg(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sHumanName: string);
procedure CmdEndGuild(PlayObject: TPlayObject);
procedure CmdUserMoveXY(PlayObject: TPlayObject; sCmd, sX, sY: string; boTopShow: Boolean);
procedure CmdSearchHuman(PlayObject: TPlayObject; sCmd, sHumanName: string);
procedure CmdAllowGroupReCall(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdGroupRecall(PlayObject: TPlayObject; sCmd: string);
procedure CmdGuildRecall(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdSearchDear(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdDearRecall(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdSearchMaster(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdMasterRecall(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdTakeOnHorse(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdTakeOffHorse(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdAllSysMsg(PlayObject: TPlayObject; sParam: string);
procedure CmdMemberFunction(PlayObject: TPlayObject; sCmd, sParam: string);
procedure CmdMemberFunctionEx(PlayObject: TPlayObject; sCmd, sParam: string);

//调试命令
procedure CmdShowHumanFlag(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sHumanName, sFlag: string);
procedure CmdMobNpc(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1, sParam2, sParam3,
  sParam4: string);
procedure CmdDelNpc(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
procedure CmdLotteryTicket(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
procedure CmdReLoadAdmin(PlayObject: TPlayObject; sCmd: string);
procedure CmdReloadNpc(PlayObject: TPlayObject; sParam: string);
procedure CmdReloadManage(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam: string);
procedure CmdReloadRobotManage(PlayObject: TPlayObject);
procedure CmdReloadRobot(PlayObject: TPlayObject);
procedure CmdReloadMonItems(PlayObject: TPlayObject);
procedure CmdReloadGuild(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
procedure CmdReloadLineNotice(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
procedure CmdReloadBannedApps(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
procedure CmdBackStep(PlayObject: TPlayObject; sCmd: string; nType, nCount: Integer);
procedure CmdChangeUserFull(PlayObject: TPlayObject; sCmd, sUserCount: string);
procedure CmdChangeZenFastStep(PlayObject: TPlayObject; sCmd, sFastStep: string);
procedure CmdFireBurn(PlayObject: TPlayObject; nInt, nTime, nN: Integer);
procedure CmdTestFire(PlayObject: TPlayObject; sCmd: string; nRange, nType, nTime, nPoint: Integer);
procedure CmdTestStatus(PlayObject: TPlayObject; sCmd: string; nType, nTime: Integer);
procedure CmdShowMap(PlayObject: TPlayObject; sMAP, sX, sY: string);
procedure CmdClearBagItem(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdShowEffect(PlayObject: TPlayObject; Cmd: pTGameCmd; nEffectID: Integer);
procedure CmdOpenBox(PlayObject: TPlayObject; Cmd: pTGameCmd; nEffectID: Integer);

//管理员命令
procedure CmdChangeAdminMode(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string;
  boFlag: Boolean);
procedure CmdChangeObMode(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1:
  string; boFlag: Boolean);
procedure CmdChangeSuperManMode(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1:
  string; boFlag: Boolean);
procedure CmdMakeItem(PlayObject: TPlayObject; Cmd: pTGameCmd; sItemName: string; nCount: Integer);
procedure CmdSmakeItem(PlayObject: TPlayObject; Cmd: pTGameCmd; nWhere, nValueType, nValue: Integer);
procedure CmdMapMove(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName: string);
procedure CmdPositionMove(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName, sX, sY: string);
procedure CmdRecallHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdReGotoHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdTing(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdSuperTing(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sRange: string);
procedure CmdMapMoveHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sSrcMap, sDenMap: string);
procedure CmdHumanInfo(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdHumanLocal(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdViewWhisper(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sParam2: string);
procedure CmdMobLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; Param: string);
procedure CmdMobCount(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName: string);
procedure CmdHumanCount(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName: string);
procedure CmdShowMapInfo(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
procedure CmdChangeLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
procedure CmdKickHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumName: string);
procedure CmdReAlive(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdKill(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdChangeJob(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sJobName: string);
procedure CmdFreePenalty(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdPKpoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdIncPkPoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; nPoint: Integer);
procedure CmdChangeGender(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSex: string);
procedure CmdHair(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; nHair: Integer);
procedure CmdSetPermission(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sPermission: string);
procedure CmdReNewLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sLevel: string);
procedure CmdDelGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumName: string; nCount: Integer; sBind: string);
procedure CmdAddGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumName: string; nCount: Integer; sBind: string);
procedure CmdGameGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sCtr: string; nPoint: Integer);
procedure CmdCreditPoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sCtr: string; nPoint: Integer);
procedure CmdAdjuestLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; nLevel: Integer);
procedure CmdAdjuestExp(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sExp: string);
procedure CmdChangeDearName(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sDearName: string);
procedure CmdChangeMasterName(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string;
  sMasterName, sIsMaster: string);
procedure CmdRecallMob(PlayObject: TPlayObject; Cmd: pTGameCmd; sMonName: string; nCount, nLevel, nAutoChangeColor,
  nFixColor: Integer);
procedure CmdTrainingSkill(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSkillName: string; nLevel: Integer);
procedure CmdTrainingMagic(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSkillName: string; nLevel: Integer);
procedure CmdDelSkill(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSkillName: string);
procedure CmdDeleteItem(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sItemName: string; nCount: Integer);
procedure CmdClearMission(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdAddGuild(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName, sGuildChief: string);
procedure CmdDelGuild(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName: string);
procedure CmdChangeSabukLord(PlayObject: TPlayObject; Cmd: pTGameCmd; sCASTLENAME, sGuildName: string;
  boFlag: Boolean);
procedure CmdForcedWallconquestWar(PlayObject: TPlayObject; Cmd: pTGameCmd; sCASTLENAME: string);
procedure CmdContestPoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName: string);
procedure CmdStartContest(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
procedure CmdEndContest(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
procedure CmdAnnouncement(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName: string);
procedure CmdMob(PlayObject: TPlayObject; Cmd: pTGameCmd; sMonName: string; nCount, nLevel, nWuXin: Integer);
procedure CmdMission(PlayObject: TPlayObject; Cmd: pTGameCmd; sX, sY: string);
procedure CmdMobPlace(PlayObject: TPlayObject; Cmd: pTGameCmd; sX, sY, sMonName, sCount: string);
procedure CmdClearMapMonster(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName, sMonName, sItems: string);
procedure CmdDisableSendMsg(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdEnableSendMsg(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
procedure CmdDisableSendMsgList(PlayObject: TPlayObject; Cmd: pTGameCmd);
procedure CmdShutup(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sTime: string);
procedure CmdShutupRelease(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; boAll: Boolean);
procedure CmdShutupList(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
procedure CmdShowSbkGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sCASTLENAME, sCtr, sGold: string);
procedure CmdStartQuest(PlayObject: TPlayObject; Cmd: pTGameCmd; sQuestName: string);
procedure CmdDenyIPaddrLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sIPaddr, sFixDeny: string);
procedure CmdDelDenyIPaddrLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sIPaddr, sFixDeny: string);
procedure CmdShowDenyIPaddrLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sIPaddr, sFixDeny: string);
procedure CmdDenyAccountLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sAccount, sFixDeny: string);
procedure CmdDelDenyAccountLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sAccount, sFixDeny: string);
procedure CmdShowDenyAccountLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sAccount, sFixDeny: string);
procedure CmdDenyCharNameLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sFixDeny: string);
procedure CmdDelDenyCharNameLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sFixDeny: string);
procedure CmdShowDenyCharNameLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sFixDeny: string);
procedure CmdSetMapMode(PlayObject: TPlayObject; sCmd: string; sMapName, sMapMode, sParam1, sParam2: string);
procedure CmdShowMapMode(PlayObject: TPlayObject; sCmd: string; sMapName: string);
procedure CmdSpirtStart(PlayObject: TPlayObject; sCmd: string; sParam1: string);
procedure CmdSpirtStop(PlayObject: TPlayObject; sCmd: string; sParam1: string);

procedure CmdWhosOnline(PlayObject: TPlayObject);
procedure CmdGetApps(PlayObject: TPlayObject; sCharName: string);

implementation

uses M2Share, Guild, HUtil32, EDcodeEx, ObjNpc, IdSrvClient, ItmUnit, Event,
  ObjMon, LocalDB, Castle, svMain{$IFDEF PLUGOPEN}, PlugOfEngine{$ENDIF};

procedure ProcessUserCmdMsg(PlayObject: TPlayObject; sData: string);
var
  SC, sAllParam, sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6, sParam7, sParam: string;
  TempPlayObject: TPlayObject;
  nFlag, nValue: Integer;
  boResult: Boolean;
  ProcessMsg: TProcessMessage;
  I, nIndex, k: Integer;
begin
  SC := Copy(sData, 2, Length(sData) - 1);
  SC := GetValidStr3(SC, sCmd, [' ', ':', ',', #9]);
  sAllParam := SC;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam1, [' ', ':', ',', #9]);
  end;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam2, [' ', ':', ',', #9]);
  end;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam3, [' ', ':', ',', #9]);
  end;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam4, [' ', ':', ',', #9]);
  end;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam5, [' ', ':', ',', #9]);
  end;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam6, [' ', ':', ',', #9]);
  end;
  if SC <> '' then begin
    SC := GetValidStr3(SC, sParam7, [' ', ':', ',', #9]);
  end;
  {$IFDEF PLUGOPEN}
  try
    if Assigned(zPlugOfEngine.HookUserCmd) then begin
      if zPlugOfEngine.HookUserCmd(PlayObject,
        PChar(sCmd),
        PChar(sParam1),
        PChar(sParam2),
        PChar(sParam3),
        PChar(sParam4),
        PChar(sParam5),
        PChar(sParam6),
        PChar(sParam7)) then
        Exit;
    end;
  except
  end;
  {$ENDIF}
  g_UserCmdList.Lock;
  Try
    for I := 0 to g_UserCmdList.Count - 1 do begin
      if CompareText(sCMD, g_UserCmdList[I]) = 0 then begin
        nIndex := Integer(g_UserCmdList.Objects[I]);
        if nIndex in [Low(g_FunctionNPC.FUserCmd)..High(g_FunctionNPC.FUserCmd)] then begin
          sAllParam := AnsiReplaceText(sAllParam, '(', '#40');
          sAllParam := AnsiReplaceText(sAllParam, ')', '#41');
          sParam := SUSERCMD + IntToStr(nIndex) + '(' + sAllParam + ')';
          for k := Low(g_FunctionNPC.m_GotoValue) to High(g_FunctionNPC.m_GotoValue) do
            g_FunctionNPC.m_GotoValue[I] := '';
          PlayObject.NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FUserCmd[Integer(g_UserCmdList.Objects[I])], False, sParam);
        end;
        Exit;
      end;
    end;
  Finally
    g_UserCmdList.UnLock;
  End;


  //用户普通命令
  if CompareText(sCMD, g_GameCommand.ATTACKMODE.sCmd) = 0 then begin
    CmdChangeAttackMode(PlayObject, StrToIntDef(sParam1, -1));
    exit;
  end;
  if CompareText(sCMD, g_GameCommand.REST.sCmd) = 0 then begin
    CmdChangeSalveStatus(PlayObject);
    exit;
  end;

  if CompareText(sCmd, g_GameCommand.Data.sCmd) = 0 then begin
    PlayObject.SysMsg(g_sNowCurrDateTime + FormatDateTime('dddddd,dddd,hh:mm:ss', Now), c_Blue, t_Hint);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.PRVMSG.sCmd) = 0 then begin
    CmdPrvMsg(PlayObject, g_GameCommand.PRVMSG.sCmd, g_GameCommand.PRVMSG.nPermissionMin, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ALLOWMSG.sCmd) = 0 then begin
    PlayObject.m_boHearWhisper := not PlayObject.m_boHearWhisper;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYWHISPER, not PlayObject.m_boHearWhisper);
    if PlayObject.m_boHearWhisper then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableHearWhisper {'[允许私聊]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableHearWhisper {'[禁止私聊]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.LETSHOUT.sCmd) = 0 then begin
    PlayObject.m_boBanShout := not PlayObject.m_boBanShout;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYCRY, not PlayObject.m_boBanShout);
    if PlayObject.m_boBanShout then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableShoutMsg {'[允许群聊]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableShoutMsg {'[禁止群聊]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.LETTRADE.sCmd) = 0 then begin
    PlayObject.m_boAllowDeal := not PlayObject.m_boAllowDeal;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTDEAL, not PlayObject.m_boAllowDeal);
    if PlayObject.m_boAllowDeal then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableDealMsg {'[允许交易]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableDealMsg {'[禁止交易]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.LETGUILD.sCmd) = 0 then begin
    PlayObject.m_boAllowGuild := not PlayObject.m_boAllowGuild;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTGUILD, not PlayObject.m_boAllowGuild);
    if PlayObject.m_boAllowGuild then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableJoinGuild {'[允许加入行会]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableJoinGuild {'[禁止加入行会]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ENDGUILD.sCmd) = 0 then begin
    CmdEndGuild(PlayObject);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.BANGUILDCHAT.sCmd) = 0 then begin
    PlayObject.m_boBanGuildChat := not PlayObject.m_boBanGuildChat;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTSAYGUILD, not PlayObject.m_boBanGuildChat);
    if PlayObject.m_boBanGuildChat then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableGuildChat {'[允许行会聊天]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableGuildChat {'[禁止行会聊天]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.AUTHALLY.sCmd) = 0 then begin
    if PlayObject.IsGuildMaster then begin
      TGuild(PlayObject.m_MyGuild).m_boEnableAuthAlly := not TGuild(PlayObject.m_MyGuild).m_boEnableAuthAlly;
      if TGuild(PlayObject.m_MyGuild).m_boEnableAuthAlly then
        PlayObject.SysMsg(g_sEnableAuthAllyGuild {'[允许行会联盟]'}, c_Green, t_Hint)
      else
        PlayObject.SysMsg(g_sDisableAuthAllyGuild {'[禁止行会联盟]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ALLOWFIREND.sCmd) = 0 then begin
    PlayObject.m_boAllowFrieng := not PlayObject.m_boAllowFrieng;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_NOTFRIENG, not PlayObject.m_boAllowFrieng);
    if PlayObject.m_boAllowFrieng then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableAddFriend {'[允许加为好友]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableAddFriend {'[禁止加为好友]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.AUTH.sCmd) = 0 then begin
    if PlayObject.IsGuildMaster then
      PlayObject.ClientGuildAlly(nil, boResult);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.AUTHCANCEL.sCmd) = 0 then begin
    if PlayObject.IsGuildMaster then begin
      ProcessMsg.sMsg := sParam1;
      PlayObject.ClientGuildBreakAlly(@ProcessMsg, boResult);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.USERMOVE.sCmd) = 0 then begin
    CmdUserMoveXY(PlayObject, g_GameCommand.USERMOVE.sCmd, sParam1, sParam2, sParam3 = 'TOPHINT');
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SEARCHING.sCmd) = 0 then begin
    CmdSearchHuman(PlayObject, g_GameCommand.SEARCHING.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ALLOWGROUPCALL.sCmd) = 0 then begin
    CmdAllowGroupReCall(PlayObject, sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.GROUPRECALLL.sCmd) = 0 then begin
    CmdGroupRecall(PlayObject, g_GameCommand.GROUPRECALLL.sCmd);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ALLOWGUILDRECALL.sCmd) = 0 then begin
    PlayObject.m_boAllowGuildReCall := not PlayObject.m_boAllowGuildReCall;
    SetIntStatus(PlayObject.m_nAllowSetup, GSP_GUILDRECALL, PlayObject.m_boAllowGuildReCall);
    if PlayObject.m_boAllowGuildReCall then begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sEnableGuildRecall {'[允许行会合一]'}, c_Green, t_Hint);
    end else begin
      PlayObject.SendDefMessage(SM_GROUPMODECHANGED, Integer(PlayObject.m_nAllowSetup), 0, 0, 0, '');
      PlayObject.SysMsg(g_sDisableGuildRecall {'[禁止行会合一]'}, c_Green, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.GUILDRECALLL.sCmd) = 0 then begin
    CmdGuildRecall(PlayObject, g_GameCommand.GUILDRECALLL.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DEAR.sCmd) = 0 then begin
    CmdSearchDear(PlayObject, g_GameCommand.DEAR.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ALLOWDEARRCALL.sCmd) = 0 then begin
    PlayObject.m_boCanDearRecall := not PlayObject.m_boCanDearRecall;
    if PlayObject.m_boCanDearRecall then begin
      PlayObject.SysMsg(g_sEnableDearRecall {'允许夫妻传送.'}, c_Blue, t_Hint);
    end
    else begin
      PlayObject.SysMsg(g_sDisableDearRecall {'禁止夫妻传送.'}, c_Blue, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DEARRECALL.sCmd) = 0 then begin
    CmdDearRecall(PlayObject, g_GameCommand.DEARRECALL.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MASTER.sCmd) = 0 then begin
    CmdSearchMaster(PlayObject, g_GameCommand.MASTER.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ALLOWMASTERRECALL.sCmd) = 0 then begin
    PlayObject.m_boCanMasterRecall := not PlayObject.m_boCanMasterRecall;
    if PlayObject.m_boCanMasterRecall then begin
      PlayObject.SysMsg(g_sEnableMasterRecall {'允许师徒传送.'}, c_Blue, t_Hint);
    end
    else begin
      PlayObject.SysMsg(g_sDisableMasterRecall {'禁止师徒传送.'}, c_Blue, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MASTERECALL.sCmd) = 0 then begin
    CmdMasterRecall(PlayObject, g_GameCommand.MASTERECALL.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TAKEONHORSE.sCmd) = 0 then begin
    CmdTakeOnHorse(PlayObject, sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TAKEOFHORSE.sCmd) = 0 then begin
    CmdTakeOffHorse(PlayObject, sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCMD, g_GameCommand.AllSysMsg.sCmd) = 0 then begin
    CmdAllSysMsg(PlayObject, sAllParam);
    exit;
  end;
  if CompareText(sCmd, g_GameCommand.MEMBERFUNCTION.sCmd) = 0 then begin
    CmdMemberFunction(PlayObject, g_GameCommand.MEMBERFUNCTION.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MEMBERFUNCTIONEX.sCmd) = 0 then begin
    CmdMemberFunctionEx(PlayObject, g_GameCommand.MEMBERFUNCTIONEX.sCmd, sParam1);
    Exit;
  end;

  if CompareText(sCmd, g_GameCommand.WHO.sCmd) = 0 then begin
    if PlayObject.m_btPermission >= g_GameCommand.WHO.nPermissionMin then
      PlayObject.SysMsg(format(g_sOnlineCountMsg, [UserEngine.OnlinePlayCount,
        UserEngine.OffLinePlayCount,
        UserEngine.PlayObjectCount]), c_Red, t_Hint);
    Exit;
  end;

  if CompareText(sCmd, g_GameCommand.TOTAL.sCmd) = 0 then begin
    if PlayObject.m_btPermission >= g_GameCommand.TOTAL.nPermissionMin then
      PlayObject.SysMsg(format(g_sTotalOnlineCountMsg, [UserEngine.OnlinePlayCount,
        UserEngine.OffLinePlayCount,
        UserEngine.PlayObjectCount]), c_Red, t_Hint);
    Exit;
  end;

  //管理员命令
  if (PlayObject.m_btPermission >= 2) and (Length(sData) > 2) and (sData[2] = g_GMRedMsgCmd) then begin
    if (GetTickCount - PlayObject.m_dwSayMsgTick) > 2000 then begin
      PlayObject.m_dwSayMsgTick := GetTickCount();
      sData := Copy(sData, 3, Length(sData) - 2);
      if Length(sData) > g_Config.nSayRedMsgMaxLen then begin
        sData := Copy(sData, 1, g_Config.nSayRedMsgMaxLen);
      end;

      if g_Config.boShutRedMsgShowGMName then
        SC := PlayObject.m_sCharName + ': ' + sData
      else
        SC := sData;
      UserEngine.SendBroadCastMsg(SC, t_GM);
    end;
    Exit;
  end;

  //管理员命令
  if PlayObject.m_btPermission < 4 then begin
    PlayObject.SysMsg('@' + sCmd + ' Command not correct.', c_Red, t_Hint);
    exit;
  end;

  if CompareText(sCmd, g_GameCommand.GAMEMASTER.sCmd) = 0 then begin
    CmdChangeAdminMode(PlayObject, g_GameCommand.GAMEMASTER.sCmd,
      g_GameCommand.GAMEMASTER.nPermissionMin, sParam1, not PlayObject.m_boAdminMode);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.OBSERVER.sCmd) = 0 then begin
    CmdChangeObMode(PlayObject, g_GameCommand.OBSERVER.sCmd,
      g_GameCommand.OBSERVER.nPermissionMin, sParam1, not PlayObject.m_boObMode);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SUEPRMAN.sCmd) = 0 then begin
    CmdChangeSuperManMode(PlayObject, g_GameCommand.OBSERVER.sCmd,
      g_GameCommand.OBSERVER.nPermissionMin, sParam1, not PlayObject.m_boSuperMan);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MAKE.sCmd) = 0 then begin
    CmdMakeItem(PlayObject, @g_GameCommand.MAKE, sParam1, StrToIntDef(sParam2, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SMAKE.sCmd) = 0 then begin
    CmdSmakeItem(PlayObject, @g_GameCommand.SMAKE, StrToIntDef(sParam1, 0),
      StrToIntDef(sParam2, 0), StrToIntDef(sParam3, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.Move.sCmd) = 0 then begin
    CmdMapMove(PlayObject, @g_GameCommand.Move, sParam1);
    Exit;
  end; //004D2CD0
  if CompareText(sCmd, g_GameCommand.POSITIONMOVE.sCmd) = 0 then begin
    CmdPositionMove(PlayObject, @g_GameCommand.POSITIONMOVE, sParam1, sParam2, sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RECALL.sCmd) = 0 then begin
    CmdRecallHuman(PlayObject, @g_GameCommand.RECALL, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.REGOTO.sCmd) = 0 then begin
    CmdReGotoHuman(PlayObject, @g_GameCommand.REGOTO, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TING.sCmd) = 0 then begin
    CmdTing(PlayObject, @g_GameCommand.TING, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SUPERTING.sCmd) = 0 then begin
    CmdSuperTing(PlayObject, @g_GameCommand.SUPERTING, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MAPMOVE.sCmd) = 0 then begin
    CmdMapMoveHuman(PlayObject, @g_GameCommand.MAPMOVE, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.INFO.sCmd) = 0 then begin
    CmdHumanInfo(PlayObject, @g_GameCommand.INFO, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.HUMANLOCAL.sCmd) = 0 then begin
    CmdHumanLocal(PlayObject, @g_GameCommand.HUMANLOCAL, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.VIEWWHISPER.sCmd) = 0 then begin
    CmdViewWhisper(PlayObject, @g_GameCommand.VIEWWHISPER, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MOBLEVEL.sCmd) = 0 then begin
    CmdMobLevel(PlayObject, @g_GameCommand.MOBLEVEL, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MOBCOUNT.sCmd) = 0 then begin
    CmdMobCount(PlayObject, @g_GameCommand.MOBCOUNT, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.HUMANCOUNT.sCmd) = 0 then begin
    CmdHumanCount(PlayObject, @g_GameCommand.HUMANCOUNT, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.Map.sCmd) = 0 then begin
    CmdShowMapInfo(PlayObject, @g_GameCommand.Map, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.Level.sCmd) = 0 then begin
    CmdChangeLevel(PlayObject, @g_GameCommand.Level, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.KICK.sCmd) = 0 then begin
    CmdKickHuman(PlayObject, @g_GameCommand.KICK, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ReAlive.sCmd) = 0 then begin
    CmdReAlive(PlayObject, @g_GameCommand.ReAlive, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.KILL.sCmd) = 0 then begin
    CmdKill(PlayObject, @g_GameCommand.KILL, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CHANGEJOB.sCmd) = 0 then begin
    CmdChangeJob(PlayObject, @g_GameCommand.CHANGEJOB, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.FREEPENALTY.sCmd) = 0 then begin
    CmdFreePenalty(PlayObject, @g_GameCommand.FREEPENALTY, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.PKPOINT.sCmd) = 0 then begin
    CmdPKpoint(PlayObject, @g_GameCommand.PKPOINT, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.IncPkPoint.sCmd) = 0 then begin
    CmdIncPkPoint(PlayObject, @g_GameCommand.IncPkPoint, sParam1, StrToIntDef(sParam2, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CHANGEGENDER.sCmd) = 0 then begin
    CmdChangeGender(PlayObject, @g_GameCommand.CHANGEGENDER, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.HAIR.sCmd) = 0 then begin
    CmdHair(PlayObject, @g_GameCommand.HAIR, sParam1, StrToIntDef(sParam2, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SETPERMISSION.sCmd) = 0 then begin
    CmdSetPermission(PlayObject, @g_GameCommand.SETPERMISSION, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RENEWLEVEL.sCmd) = 0 then begin
    CmdReNewLevel(PlayObject, @g_GameCommand.RENEWLEVEL, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELGOLD.sCmd) = 0 then begin
    CmdDelGold(PlayObject, @g_GameCommand.DELGOLD, sParam1, StrToIntDef(sParam2, 0), sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ADDGOLD.sCmd) = 0 then begin
    CmdAddGold(PlayObject, @g_GameCommand.ADDGOLD, sParam1, StrToIntDef(sParam2, 0), sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.GAMEGOLD.sCmd) = 0 then begin
    CmdGameGold(PlayObject, @g_GameCommand.GAMEGOLD, sParam1, sParam2, StrToIntDef(sParam3, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CREDITPOINT.sCmd) = 0 then begin
    CmdCreditPoint(PlayObject, @g_GameCommand.CREDITPOINT, sParam1, sParam2, StrToIntDef(sParam3, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ADJUESTLEVEL.sCmd) = 0 then begin
    CmdAdjuestLevel(PlayObject, @g_GameCommand.ADJUESTLEVEL, sParam1, StrToIntDef(sParam2, 1));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ADJUESTEXP.sCmd) = 0 then begin
    CmdAdjuestExp(PlayObject, @g_GameCommand.ADJUESTEXP, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CHANGEDEARNAME.sCmd) = 0 then begin
    CmdChangeDearName(PlayObject, @g_GameCommand.CHANGEDEARNAME, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CHANGEMASTERNAME.sCmd) = 0 then begin
    CmdChangeMasterName(PlayObject, @g_GameCommand.CHANGEMASTERNAME, sParam1, sParam2, sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RECALLMOB.sCmd) = 0 then begin
    CmdRecallMob(PlayObject, @g_GameCommand.RECALLMOB, sParam1, StrToIntDef(sParam2, 0),
      StrToIntDef(sParam3, 0), StrToIntDef(sParam4, 0), StrToIntDef(sParam5, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TRAINING.sCmd) = 0 then begin
    CmdTrainingSkill(PlayObject, @g_GameCommand.TRAINING, sParam1, sParam2, StrToIntDef(sParam3, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TRAININGSKILL.sCmd) = 0 then begin
    CmdTrainingMagic(PlayObject, @g_GameCommand.TRAININGSKILL, sParam1, sParam2, StrToIntDef(sParam3, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELETESKILL.sCmd) = 0 then begin
    CmdDelSkill(PlayObject, @g_GameCommand.DELETESKILL, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELETEITEM.sCmd) = 0 then begin
    CmdDeleteItem(PlayObject, @g_GameCommand.DELETEITEM, sParam1, sParam2, StrToIntDef(sParam3, 1));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CLEARMISSION.sCmd) = 0 then begin
    CmdClearMission(PlayObject, @g_GameCommand.CLEARMISSION, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.AddGuild.sCmd) = 0 then begin
    CmdAddGuild(PlayObject, @g_GameCommand.AddGuild, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELGUILD.sCmd) = 0 then begin
    CmdDelGuild(PlayObject, @g_GameCommand.DELGUILD, sParam1);
    Exit;
  end;
  if (CompareText(sCmd, g_GameCommand.CHANGESABUKLORD.sCmd) = 0) then begin
    CmdChangeSabukLord(PlayObject, @g_GameCommand.CHANGESABUKLORD, sParam1, sParam2,
      True);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.FORCEDWALLCONQUESTWAR.sCmd) = 0 then begin
    CmdForcedWallconquestWar(PlayObject, @g_GameCommand.FORCEDWALLCONQUESTWAR, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CONTESTPOINT.sCmd) = 0 then begin
    CmdContestPoint(PlayObject, @g_GameCommand.CONTESTPOINT, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.STARTCONTEST.sCmd) = 0 then begin
    CmdStartContest(PlayObject, @g_GameCommand.STARTCONTEST, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ENDCONTEST.sCmd) = 0 then begin
    CmdEndContest(PlayObject, @g_GameCommand.ENDCONTEST, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ANNOUNCEMENT.sCmd) = 0 then begin
    CmdAnnouncement(PlayObject, @g_GameCommand.ANNOUNCEMENT, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MOB.sCmd) = 0 then begin
    CmdMob(PlayObject, @g_GameCommand.MOB, sParam1, StrToIntDef(sParam2, 0), StrToIntDef(sParam3, 0), StrToIntDef(sParam4, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.Mission.sCmd) = 0 then begin
    CmdMission(PlayObject, @g_GameCommand.Mission, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MobPlace.sCmd) = 0 then begin
    CmdMobPlace(PlayObject, @g_GameCommand.MobPlace, sParam1, sParam2, sParam3, sParam4);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CLEARMON.sCmd) = 0 then begin
    CmdClearMapMonster(PlayObject, @g_GameCommand.CLEARMON, sParam1, sParam2, sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DISABLESENDMSG.sCmd) = 0 then begin
    CmdDisableSendMsg(PlayObject, @g_GameCommand.DISABLESENDMSG, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ENABLESENDMSG.sCmd) = 0 then begin
    CmdEnableSendMsg(PlayObject, @g_GameCommand.ENABLESENDMSG, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DISABLESENDMSGLIST.sCmd) = 0 then begin
    CmdDisableSendMsgList(PlayObject, @g_GameCommand.DISABLESENDMSGLIST);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHUTUP.sCmd) = 0 then begin
    CmdShutup(PlayObject, @g_GameCommand.SHUTUP, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELEASESHUTUP.sCmd) = 0 then begin
    CmdShutupRelease(PlayObject, @g_GameCommand.RELEASESHUTUP, sParam1, True);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHUTUPLIST.sCmd) = 0 then begin
    CmdShutupList(PlayObject, @g_GameCommand.SHUTUPLIST, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SABUKWALLGOLD.sCmd) = 0 then begin
    CmdShowSbkGold(PlayObject, @g_GameCommand.SABUKWALLGOLD, sParam1, sParam2, sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.STARTQUEST.sCmd) = 0 then begin
    CmdStartQuest(PlayObject, @g_GameCommand.STARTQUEST, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DENYIPLOGON.sCmd) = 0 then begin
    CmdDenyIPaddrLogon(PlayObject, @g_GameCommand.DENYIPLOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELDENYIPLOGON.sCmd) = 0 then begin
    CmdDelDenyIPaddrLogon(PlayObject, @g_GameCommand.DELDENYIPLOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHOWDENYIPLOGON.sCmd) = 0 then begin
    CmdShowDenyIPaddrLogon(PlayObject, @g_GameCommand.SHOWDENYIPLOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DENYACCOUNTLOGON.sCmd) = 0 then begin
    CmdDenyAccountLogon(PlayObject, @g_GameCommand.DENYACCOUNTLOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELDENYACCOUNTLOGON.sCmd) = 0 then begin
    CmdDelDenyAccountLogon(PlayObject, @g_GameCommand.DELDENYACCOUNTLOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHOWDENYACCOUNTLOGON.sCmd) = 0 then begin
    CmdShowDenyAccountLogon(PlayObject, @g_GameCommand.SHOWDENYACCOUNTLOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DENYCHARNAMELOGON.sCmd) = 0 then begin
    CmdDenyCharNameLogon(PlayObject, @g_GameCommand.DENYCHARNAMELOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELDENYCHARNAMELOGON.sCmd) = 0 then begin
    CmdDelDenyCharNameLogon(PlayObject, @g_GameCommand.DELDENYCHARNAMELOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHOWDENYCHARNAMELOGON.sCmd) = 0 then begin
    CmdShowDenyCharNameLogon(PlayObject, @g_GameCommand.SHOWDENYCHARNAMELOGON, sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SETMAPMODE.sCmd) = 0 then begin
    CmdSetMapMode(PlayObject, g_GameCommand.SETMAPMODE.sCmd, sParam1, sParam2, sParam3, sParam4);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHOWMAPMODE.sCmd) = 0 then begin
    CmdShowMapMode(PlayObject, g_GameCommand.SHOWMAPMODE.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SPIRIT.sCmd) = 0 then begin
    CmdSpirtStart(PlayObject, g_GameCommand.SPIRIT.sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SPIRITSTOP.sCmd) = 0 then begin
    CmdSpirtStop(PlayObject, g_GameCommand.SPIRITSTOP.sCmd, sParam1);
    Exit;
  end;

  //调试命令
  if PlayObject.m_btPermission < 6 then begin
    exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHOWFLAG.sCmd) = 0 then begin
    CmdShowHumanFlag(PlayObject, g_GameCommand.SHOWFLAG.sCmd, g_GameCommand.SHOWFLAG.nPermissionMin,
      sParam1, sParam2);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SETFLAG.sCmd) = 0 then begin //004D3BDD
    TempPlayObject := UserEngine.GetPlayObject(sParam1);
    if TempPlayObject <> nil then begin
      nFlag := StrToIntDef(sParam2, 0);
      nValue := StrToIntDef(sParam3, 0);
      TempPlayObject.SetQuestFlagStatus(nFlag, nValue);
      if TempPlayObject.GetQuestFlagStatus(nFlag) = 1 then begin
        PlayObject.SysMsg(TempPlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = ON', c_Green, t_Hint);
      end
      else begin
        PlayObject.SysMsg(TempPlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = OFF', c_Green, t_Hint);
      end;
    end
    else begin
      PlayObject.SysMsg('@' + g_GameCommand.SETFLAG.sCmd + ' <Char Name> <Flag> <digit(0 - 1)>', c_Red, t_Hint);
    end;
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MOBNPC.sCmd) = 0 then begin
    CmdMobNpc(PlayObject, g_GameCommand.MOBNPC.sCmd, g_GameCommand.MOBNPC.nPermissionMin,
      sParam1, sParam2, sParam3, sParam4);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.DELNPC.sCmd) = 0 then begin
    CmdDelNpc(PlayObject, g_GameCommand.DELNPC.sCmd, g_GameCommand.DELNPC.nPermissionMin, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.LOTTERYTICKET.sCmd) = 0 then begin
    CmdLotteryTicket(PlayObject, g_GameCommand.LOTTERYTICKET.sCmd, g_GameCommand.LOTTERYTICKET.nPermissionMin,
      sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADADMIN.sCmd) = 0 then begin
    CmdReLoadAdmin(PlayObject, g_GameCommand.RELOADADMIN.sCmd);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.ReLoadNpc.sCmd) = 0 then begin
    CmdReloadNpc(PlayObject, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADMANAGE.sCmd) = 0 then begin
    CmdReloadManage(PlayObject, @g_GameCommand.RELOADMANAGE, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADROBOTMANAGE.sCmd) = 0 then begin
    CmdReloadRobotManage(PlayObject);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADROBOT.sCmd) = 0 then begin
    CmdReloadRobot(PlayObject);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADMONITEMS.sCmd) = 0 then begin
    CmdReloadMonItems(PlayObject);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADITEMDB.sCmd) = 0 then begin
    FrmDB.LoadItemsDB();
    PlayObject.SysMsg('Item Database Reloaded', c_Green, t_Hint);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADMAGICDB.sCmd) = 0 then begin
    FrmDB.LoadMagicDB();
    PlayObject.SysMsg('Magic Database Reloaded', c_Green, t_Hint);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADMONSTERDB.sCmd) = 0 then begin
    FrmDB.LoadMonsterDB();
    PlayObject.SysMsg('Monster Database Reloaded', c_Green, t_Hint);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADMINMAP.sCmd) = 0 then begin
    FrmDB.LoadMinMap();
    g_MapManager.ReSetMinMap();
    PlayObject.SysMsg('MiniMap Reloaded', c_Green, t_Hint);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADGUILD.sCmd) = 0 then begin
    CmdReloadGuild(PlayObject, g_GameCommand.RELOADGUILD.sCmd,
      g_GameCommand.RELOADGUILD.nPermissionMin, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADLINENOTICE.sCmd) = 0 then begin
    CmdReloadLineNotice(PlayObject, g_GameCommand.RELOADLINENOTICE.sCmd,
      g_GameCommand.RELOADLINENOTICE.nPermissionMin, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.RELOADBANNEDAPPS.sCmd) = 0 then begin
    CmdReloadBannedApps(PlayObject, g_GameCommand.RELOADBANNEDAPPS.sCmd,
      g_GameCommand.RELOADBANNEDAPPS.nPermissionMin, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.BACKSTEP.sCmd) = 0 then begin
    CmdBackStep(PlayObject, sCmd, StrToIntDef(sParam1, 0), StrToIntDef(sParam2, 1));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CHGUSERFULL.sCmd) = 0 then begin
    CmdChangeUserFull(PlayObject, sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CHGZENFASTSTEP.sCmd) = 0 then begin
    CmdChangeZenFastStep(PlayObject, sCmd, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.FIREBURN.sCmd) = 0 then begin
    CmdFireBurn(PlayObject, StrToIntDef(sParam1, 0), StrToIntDef(sParam2, 0),
      StrToIntDef(sParam3, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TESTFIRE.sCmd) = 0 then begin
    CmdTestFire(PlayObject, sCmd, StrToIntDef(sParam1, 0), StrToIntDef(sParam2, 0),
      StrToIntDef(sParam3, 0), StrToIntDef(sParam4, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.TESTSTATUS.sCmd) = 0 then begin
    CmdTestStatus(PlayObject, sCmd, StrToIntDef(sParam1, -1), StrToIntDef(sParam2, 0));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.MAPINFO.sCmd) = 0 then begin
    CmdShowMap(PlayObject, sParam1, sParam2, sParam3);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.CLEARBAG.sCmd) = 0 then begin
    CmdClearBagItem(PlayObject, @g_GameCommand.CLEARBAG, sParam1);
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.SHOWEFFECT.sCmd) = 0 then begin
    CmdShowEffect(PlayObject, @g_GameCommand.SHOWEFFECT, StrToIntDef(sParam1, -1));
    Exit;
  end;
  if CompareText(sCmd, g_GameCommand.OPENBOX.sCmd) = 0 then begin
    CmdOpenBox(PlayObject, @g_GameCommand.OPENBOX, StrToIntDef(sParam1, -1));
    Exit;
  end;
  if CompareText(sCmd, 'whosonline') = 0 then begin
    CmdWhosonline(PlayObject);
    exit;
  end;
  if (CompareText(sCmd, 'getapps') = 0) and (PlayObject.m_btPermission = 10) then begin
    CmdGetApps(PlayObject,sParam1);
  end;
  PlayObject.SysMsg('@' + sCmd + ' Command is not correct', c_Red, t_Hint);
end;

//管理员命令
procedure CmdWhosOnline(PlayObject: TPlayObject);
var
  i: integer;
  output: string;
begin
  if (PlayObject.m_btPermission < 10) then
      Exit;
  output:='';
  for i := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
    if UserEngine.m_PlayObjectList.Objects[i] <> nil then
      output := output + TPlayObject(UserEngine.m_PlayObjectList.Objects[i]).m_sCharName + ',';
  end;
  PlayObject.SysMsg(output, c_Red, t_Hint);
end;

procedure CmdGetApps(PlayObject: TPlayObject; sCharName: string);
var
  Target: TPlayObject;
begin
  if (PlayObject.m_btPermission < 10) then
      Exit;
  if sCharName = '' then exit;

  Target := UserEngine.GetPlayObject(sCharName);
  if (Target = nil) or (Target.m_boGhost) or (Target.m_boSafeOffLine) then exit;
  Target.SendDefMessage(SM_RECONNECT,1,0,0,0,'');
end;

procedure CmdSpirtStop(PlayObject: TPlayObject; sCmd: string; sParam1: string);
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (sParam1 <> '') and (sParam1[1] = '?') then begin
      SysMsg('This command is used to stop all pets from revolting', c_Red, t_Hint);
      Exit;
    end;
    g_dwSpiritMutinyTick := 0;
    SysMsg('Pet revolts have stopped.', c_Green, t_Hint);
  end;
end;

procedure CmdSpirtStart(PlayObject: TPlayObject; sCmd: string; sParam1: string);
var
  nTime: Integer;
  dwTime: LongWord;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (sParam1 <> '') and (sParam1[1] = '?') then begin
      SysMsg('This command is used to start a pet revolt', c_Red, t_Hint);
      Exit;
    end;
    nTime := StrToIntDef(sParam1, -1);
    if nTime > 0 then begin
      dwTime := LongWord(nTime) * 1000;
    end
    else begin
      dwTime := g_Config.dwSpiritMutinyTime;
    end;
    g_dwSpiritMutinyTick := GetTickCount + dwTime;
    SysMsg('Pet revolt has begun. Duration ' + IntToStr(dwTime div 1000) + ' Seconds', c_Green, t_Hint);
  end;
end;

procedure CmdShowMapMode(PlayObject: TPlayObject; sCmd: string; sMapName: string);
var
  Envir: TEnvirnoment;
  sMsg: string;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (sMapName = '') then begin
      SysMsg('Command: @' + sCmd + ' Map', c_Red, t_Hint);
      Exit;
    end;
    Envir := g_MapManager.FindMap(sMapName);
    if (Envir = nil) then begin
      SysMsg(sMapName + ' Does not exist.', c_Red, t_Hint);
      Exit;
    end;
    sMsg := 'Map Mode: ' + Envir.GetEnvirInfo;
    SysMsg(sMsg, c_Blue, t_Hint);
  end;
end;

procedure CmdSetMapMode(PlayObject: TPlayObject; sCmd: string; sMapName, sMapMode, sParam1, sParam2: string);
var
  Envir: TEnvirnoment;
  sMsg: string;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (sMapName = '') or (sMapMode = '') then begin
      SysMsg('Command: @' + sCmd + ' Map Mode', c_Red, t_Hint);
      Exit;
    end;
    Envir := g_MapManager.FindMap(sMapName);
    if (Envir = nil) then begin
      SysMsg(sMapName + ' Does not exist.', c_Red, t_Hint);
      Exit;
    end;
    if CompareText(sMapMode, 'SAFE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boSAFE := True;
      end
      else begin
        Envir.m_boSAFE := False;
      end;
    end
    else if CompareText(sMapMode, 'DARK') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boDARK := True;
      end
      else begin
        Envir.m_boDARK := False;
      end;
    end
//    else if CompareText(sMapMode, 'DARK') = 0 then begin
//      if (sParam1 <> '') then begin
//        Envir.m_boDARK := True;
//      end
//      else begin                           Don't know why it has two
//        Envir.m_boDARK := False;
//      end;
//    end
    else if CompareText(sMapMode, 'FIGHT') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boFightZone := True;
      end
      else begin
        Envir.m_boFightZone := False;
      end;
    end
    else if CompareText(sMapMode, 'FIGHT3') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boFight3Zone := True;
      end
      else begin
        Envir.m_boFight3Zone := False;
      end;
    end
    else if CompareText(sMapMode, 'DAY') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boDAY := True;
      end
      else begin
        Envir.m_boDAY := False;
      end;
    end
    else if CompareText(sMapMode, 'QUIZ') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boQUIZ := True;
      end
      else begin
        Envir.m_boQUIZ := False;
      end;
    end
    else if CompareText(sMapMode, 'NORECONNECT') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNORECONNECT := True;
        Envir.sNoReconnectMap := sParam1;
      end
      else begin
        Envir.m_boNORECONNECT := False;
      end;
    end
    else if CompareText(sMapMode, 'MUSIC') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boMUSIC := True;
        Envir.m_nMUSICID := StrToIntDef(sParam1, -1);
      end
      else begin
        Envir.m_boMUSIC := False;
      end;
    end
    else if CompareText(sMapMode, 'EXPRATE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boEXPRATE := True;
        Envir.m_nEXPRATE := StrToIntDef(sParam1, -1);
      end
      else begin
        Envir.m_boEXPRATE := False;
      end;
    end
    else if CompareText(sMapMode, 'PKWINLEVEL') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boPKWINLEVEL := True;
        Envir.m_nPKWINLEVEL := StrToIntDef(sParam1, -1);
      end
      else begin
        Envir.m_boPKWINLEVEL := False;
      end;
    end
    else if CompareText(sMapMode, 'PKWINEXP') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boPKWINEXP := True;
        Envir.m_nPKWINEXP := StrToIntDef(sParam1, -1);
      end
      else begin
        Envir.m_boPKWINEXP := False;
      end;
    end
    else if CompareText(sMapMode, 'PKLOSTLEVEL') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boPKLOSTLEVEL := True;
        Envir.m_nPKLOSTLEVEL := StrToIntDef(sParam1, -1);
      end
      else begin
        Envir.m_boPKLOSTLEVEL := False;
      end;
    end
    else if CompareText(sMapMode, 'PKLOSTEXP') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boPKLOSTEXP := True;
        Envir.m_nPKLOSTEXP := StrToIntDef(sParam1, -1);
      end
      else begin
        Envir.m_boPKLOSTEXP := False;
      end;
    end
    else if CompareText(sMapMode, 'DECHP') = 0 then begin
      if (sParam1 <> '') and (sParam2 <> '') then begin
        Envir.m_boDECHP := True;
        Envir.m_nDECHPTIME := StrToIntDef(sParam1, -1);
        Envir.m_nDECHPPOINT := StrToIntDef(sParam2, -1);
      end
      else begin
        Envir.m_boDECHP := False;
      end;
    end
    else if CompareText(sMapMode, 'DECGAMEGOLD') = 0 then begin
      if (sParam1 <> '') and (sParam2 <> '') then begin
        Envir.m_boDecGameGold := True;
        Envir.m_nDECGAMEGOLDTIME := StrToIntDef(sParam1, -1);
        Envir.m_nDecGameGold := StrToIntDef(sParam2, -1);
      end
      else begin
        Envir.m_boDecGameGold := False;
      end;
    end
    else if CompareText(sMapMode, 'INCGAMEGOLD') = 0 then begin
      if (sParam1 <> '') and (sParam2 <> '') then begin
        Envir.m_boIncGameGold := True;
        Envir.m_nINCGAMEGOLDTIME := StrToIntDef(sParam1, -1);
        Envir.m_nIncGameGold := StrToIntDef(sParam2, -1);
      end
      else begin
        Envir.m_boIncGameGold := False;
      end;
    end
    else if CompareText(sMapMode, 'INCGAMEPOINT') = 0 then begin
      if (sParam1 <> '') and (sParam2 <> '') then begin
        Envir.m_boINCGAMEPOINT := True;
        Envir.m_nINCGAMEPOINTTIME := StrToIntDef(sParam1, -1);
        Envir.m_nINCGAMEPOINT := StrToIntDef(sParam2, -1);
      end
      else begin
        Envir.m_boIncGameGold := False;
      end;
    end
    else if CompareText(sMapMode, 'RUNHUMAN') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boRUNHUMAN := True;
      end
      else begin
        Envir.m_boRUNHUMAN := False;
      end;
    end
    else if CompareText(sMapMode, 'RUNMON') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boRUNMON := True;
      end
      else begin
        Envir.m_boRUNMON := False;
      end;
    end
    else if CompareText(sMapMode, 'NEEDHOLE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNEEDHOLE := True;
      end
      else begin
        Envir.m_boNEEDHOLE := False;
      end;
    end
    else if CompareText(sMapMode, 'NORECALL') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNORECALL := True;
      end
      else begin
        Envir.m_boNORECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NOGUILDRECALL') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNOGUILDRECALL := True;
      end
      else begin
        Envir.m_boNOGUILDRECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NODEARRECALL') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNODEARRECALL := True;
      end
      else begin
        Envir.m_boNODEARRECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NOMASTERRECALL') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNOMASTERRECALL := True;
      end
      else begin
        Envir.m_boNOMASTERRECALL := False;
      end;
    end
    else if CompareText(sMapMode, 'NORANDOMMOVE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNORANDOMMOVE := True;
      end
      else begin
        Envir.m_boNORANDOMMOVE := False;
      end;
    end
    else if CompareText(sMapMode, 'NODRUG') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNODRUG := True;
      end
      else begin
        Envir.m_boNODRUG := False;
      end;
    end
    else if CompareText(sMapMode, 'MINE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boMINE := True;
      end
      else begin
        Envir.m_boMINE := False;
      end;
    end
    else if CompareText(sMapMode, 'AFKMINE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boAFKMINE := True;
      end
      else begin
        Envir.m_boAFKMINE := False;
      end;
    end
    else if CompareText(sMapMode, 'NOPOSITIONMOVE') = 0 then begin
      if (sParam1 <> '') then begin
        Envir.m_boNOPOSITIONMOVE := True;
      end
      else begin
        Envir.m_boNOPOSITIONMOVE := False;
      end;
    end;
    sMsg := 'Map Mode: ' + Envir.GetEnvirInfo;
    SysMsg(sMsg, c_Blue, t_Hint);
  end;
end;

procedure CmdShowDenyCharNameLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sFixDeny: string);
var
  i: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    g_DenyChrNameList.Lock;
    try
      if g_DenyChrNameList.Count <= 0 then begin
        SysMsg('Prohibited charname list is empty', c_Green, t_Hint);
        Exit;
      end;
      for i := 0 to g_DenyChrNameList.Count - 1 do begin
        SysMsg(g_DenyChrNameList.Strings[i], c_Green, t_Hint);
      end;
    finally
      g_DenyChrNameList.UnLock;
    end;
  end;
end;

procedure CmdDelDenyCharNameLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sFixDeny: string);
var
  i: Integer;
  boDelete: Boolean;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sCharName = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' username', c_Red, t_Hint);
      Exit;
    end;
    boDelete := False;
    g_DenyChrNameList.Lock;
    try
      for i := 0 to g_DenyChrNameList.Count - 1 do begin
        if CompareText(sCharName, g_DenyChrNameList.Strings[i]) = 0 then begin
          if Integer(g_DenyChrNameList.Objects[i]) <> 0 then
            SaveDenyChrNameList;
          g_DenyChrNameList.Delete(i);
          SysMsg(sCharName + 'Remove from the list of people against Login', c_Green, t_Hint);
          boDelete := True;
          break;
        end;
      end;
    finally
      g_DenyChrNameList.UnLock;
    end;
    if not boDelete then
      SysMsg(sCharName + 'Is not prohibited Login', c_Green, t_Hint);
  end;
end;

procedure CmdDenyCharNameLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sFixDeny: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sCharName = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' username Permanently sealed(0,1)', c_Red, t_Hint);
      Exit;
    end;
    g_DenyChrNameList.Lock;
    try
      if (sFixDeny <> '') and (sFixDeny[1] = '1') then begin
        g_DenyChrNameList.AddObject(sCharName, TObject(1));
        SaveDenyChrNameList();
        SysMsg(sCharName + 'Has joined the list of prohibited characters', c_Green, t_Hint);
      end
      else begin
        g_DenyChrNameList.AddObject(sCharName, TObject(0));
        SysMsg(sCharName + 'Added a temporary restraining character list', c_Green, t_Hint);
      end;
    finally
      g_DenyChrNameList.UnLock;
    end;
  end;
end;

procedure CmdShowDenyAccountLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sAccount, sFixDeny: string);
var
  i: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    g_DenyAccountList.Lock;
    try
      if g_DenyAccountList.Count <= 0 then begin
        SysMsg('Prohibited login account list is empty', c_Green, t_Hint);
        Exit;
      end;
      for i := 0 to g_DenyAccountList.Count - 1 do begin
        SysMsg(g_DenyAccountList.Strings[i], c_Green, t_Hint);
      end;
    finally
      g_DenyAccountList.UnLock;
    end;
  end;
end;

procedure CmdDelDenyAccountLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sAccount, sFixDeny: string);
var
  i: Integer;
  boDelete: Boolean;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sAccount = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Login Username', c_Red, t_Hint);
      Exit;
    end;
    boDelete := False;
    g_DenyAccountList.Lock;
    try
      for i := 0 to g_DenyAccountList.Count - 1 do begin
        if CompareText(sAccount, g_DenyAccountList.Strings[i]) = 0 then begin
          if Integer(g_DenyAccountList.Objects[i]) <> 0 then
            SaveDenyAccountList;
          g_DenyAccountList.Delete(i);
          SysMsg(sAccount + 'Deleted from the prohibited list of login account', c_Green, t_Hint);
          boDelete := True;
          break;
        end;
      end;
    finally
      g_DenyAccountList.UnLock;
    end;
    if not boDelete then
      SysMsg(sAccount + 'Is not prohibited Login', c_Green, t_Hint);
  end;
end;

procedure CmdDenyAccountLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sAccount, sFixDeny: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sAccount = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Login account whether permanent ban(0 = no, 1 = yes)', c_Red, t_Hint);
      Exit;
    end;
    g_DenyAccountList.Lock;
    try
      if (sFixDeny <> '') and (sFixDeny[1] = '1') then begin
        g_DenyAccountList.AddObject(sAccount, TObject(1));
        SaveDenyAccountList();
        SysMsg(sAccount + 'Added list of ban login account', c_Green, t_Hint);
      end
      else begin
        g_DenyAccountList.AddObject(sAccount, TObject(0));
        SysMsg(sAccount + 'Added a temporary ban login account list', c_Green, t_Hint);
      end;
    finally
      g_DenyAccountList.UnLock;
    end;
  end;
end;

procedure CmdShowDenyIPaddrLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sIPaddr, sFixDeny: string);
var
  i: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    g_DenyIPAddrList.Lock;
    try
      if g_DenyIPAddrList.Count <= 0 then begin
        SysMsg('Prohibited login IP list is empty。', c_Green, t_Hint);
        Exit;
      end;
      for i := 0 to g_DenyIPAddrList.Count - 1 do begin
        SysMsg(g_DenyIPAddrList.Strings[i], c_Green, t_Hint);
      end;
    finally
      g_DenyIPAddrList.UnLock;
    end;
  end;
end;

procedure CmdDelDenyIPaddrLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sIPaddr, sFixDeny: string);
var
  i: Integer;
  boDelete: Boolean;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sIPaddr = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' IP addresses', c_Red, t_Hint);
      Exit;
    end;
    boDelete := False;
    g_DenyIPAddrList.Lock;
    try
      for i := g_DenyIPAddrList.Count - 1 downto 0 do begin
        if g_DenyIPAddrList.Count <= 0 then
          break;
        if CompareText(sIPaddr, g_DenyIPAddrList.Strings[i]) = 0 then begin
          if Integer(g_DenyIPAddrList.Objects[i]) <> 0 then
            SaveDenyIPAddrList;
          g_DenyIPAddrList.Delete(i);
          SysMsg(sIPaddr + 'Deleted from the Login IP Ban list', c_Green, t_Hint);
          boDelete := True;
          break;
        end;
      end;
    finally
      g_DenyIPAddrList.UnLock;
    end;
    if not boDelete then
      SysMsg(sIPaddr + 'Is not prohibited Login', c_Green, t_Hint);
  end;
end;

procedure CmdDenyIPaddrLogon(PlayObject: TPlayObject; Cmd: pTGameCmd; sIPaddr, sFixDeny: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sIPaddr = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' IP ban(0 = no, 1 = yes)', c_Red, t_Hint);
      Exit;
    end;
    g_DenyIPAddrList.Lock;
    try
      if (sFixDeny <> '') and (sFixDeny[1] = '1') then begin
        g_DenyIPAddrList.AddObject(sIPaddr, TObject(1));
        SaveDenyIPAddrList();
        SysMsg(sIPaddr + 'Added Login IP Ban List', c_Green, t_Hint);
      end
      else begin
        g_DenyIPAddrList.AddObject(sIPaddr, TObject(0));
        SysMsg(sIPaddr + 'The temporary ban Added login IP list', c_Green, t_Hint);
      end;
    finally
      g_DenyIPAddrList.UnLock;
    end;
  end;
end;

procedure CmdStartQuest(PlayObject: TPlayObject; Cmd: pTGameCmd; sQuestName: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sQuestName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' QuestName', c_Red, t_Hint);
      Exit;
    end;
    UserEngine.SendQuestMsg(sQuestName);
  end;
end;

procedure CmdShowSbkGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sCASTLENAME, sCtr, sGold: string);
var
  i: Integer;
  Ctr: Char;
  nGold: Integer;
  Castle: TUserCastle;
  List: TStringList;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sCASTLENAME <> '') and (sCASTLENAME[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    if sCASTLENAME = '' then begin
      List := TStringList.Create;
      g_CastleManager.GetCastleGoldInfo(List);
      for i := 0 to List.Count - 1 do begin
        SysMsg(List.Strings[i], c_Green, t_Hint);
      end;
      List.Free;
      Exit;
    end;
    Castle := g_CastleManager.Find(sCASTLENAME);
    if Castle = nil then begin
      SysMsg(format(g_sGameCommandSbkGoldCastleNotFoundMsg, [sCASTLENAME]), c_Red, t_Hint);
      Exit;
    end;

    Ctr := sCtr[1];
    nGold := StrToIntDef(sGold, -1);
    if not (Ctr in ['=', '-', '+']) or (nGold < 0) or (nGold > 100000000) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandSbkGoldHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    case Ctr of
      '=': Castle.m_nTotalGold := nGold;
      '-': Dec(Castle.m_nTotalGold);
      '+': Inc(Castle.m_nTotalGold, nGold);
    end;
    if Castle.m_nTotalGold < 0 then
      Castle.m_nTotalGold := 0;
  end;
end;

procedure CmdShutupList(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
var
  i: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, '']), c_Red, t_Hint);
      Exit;
    end;

    g_DenySayMsgList.Lock;
    try
      if g_DenySayMsgList.Count <= 0 then begin
        SysMsg(g_sGameCommandShutupListIsNullMsg, c_Green, t_Hint);
        Exit;
      end;
      for i := 0 to g_DenySayMsgList.Count - 1 do begin
        SysMsg(g_DenySayMsgList.Strings[i] + ' ' +
          IntToStr((LongWord(g_DenySayMsgList.Objects[i]) - GetTickCount) div 60000), c_Green, t_Hint);
      end;
    finally
      g_DenySayMsgList.UnLock;
    end;
  end;
end;

procedure CmdShutupRelease(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; boAll: Boolean);
var
  i: Integer;
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandShutupReleaseHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    g_DenySayMsgList.Lock;
    try
      i := g_DenySayMsgList.GetIndex(sHumanName);
      if i >= 0 then begin
        g_DenySayMsgList.Delete(i);
        TempPlayObject := UserEngine.GetPlayObject(sHumanName);
        if TempPlayObject <> nil then begin
          TempPlayObject.SysMsg(g_sGameCommandShutupReleaseCanSendMsg, c_Red, t_Hint);
        end;
        SysMsg(format(g_sGameCommandShutupReleaseHumanCanSendMsg, [sHumanName]), c_Green, t_Hint);
      end;
    finally
      g_DenySayMsgList.UnLock;
    end;
  end;
end;

procedure CmdShutup(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sTime: string);
var
  dwTime: LongWord;
  nIndex: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sTime = '') or (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandShutupHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    dwTime := StrToIntDef(sTime, 5);
    g_DenySayMsgList.Lock;
    try
      nIndex := g_DenySayMsgList.GetIndex(sHumanName);
      if nIndex >= 0 then begin
        g_DenySayMsgList.Objects[nIndex] := TObject(GetTickCount + dwTime * 60 * 1000);
      end
      else begin
        g_DenySayMsgList.AddRecord(sHumanName, GetTickCount + dwTime * 60 * 1000);
      end;
    finally
      g_DenySayMsgList.UnLock;
    end;
    SysMsg(format(g_sGameCommandShutupHumanMsg, [sHumanName, dwTime]), c_Red, t_Hint);
  end;
end;

procedure CmdDisableSendMsgList(PlayObject: TPlayObject; Cmd: pTGameCmd);
var
  i: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if g_DisableSendMsgList.Count <= 0 then begin
      SysMsg('The silence list is empty.', c_Red, t_Hint);
      Exit;
    end;

    SysMsg('Silence list:', c_Blue, t_Hint);
    for i := 0 to g_DisableSendMsgList.Count - 1 do begin
      SysMsg(g_DisableSendMsgList.Strings[i], c_Green, t_Hint);
    end;
  end;
end;

procedure CmdEnableSendMsg(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  i: Integer;
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sHumanName = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' username', c_Red, t_Hint);
      Exit;
    end;
    for i := g_DisableSendMsgList.Count - 1 downto 0 do begin
      if g_DisableSendMsgList.Count <= 0 then
        break;
      if CompareText(sHumanName, g_DisableSendMsgList.Strings[i]) = 0 then begin
        TempPlayObject := UserEngine.GetPlayObject(sHumanName);
        if TempPlayObject <> nil then begin
          TempPlayObject.m_boFilterSendMsg := False;
        end;
        g_DisableSendMsgList.Delete(i);
        SaveDisableSendMsgList();
        SysMsg(sHumanName + ' has been remove from silence list.', c_Green, t_Hint);
        Exit;
      end;
    end;
    SysMsg(sHumanName + ' was not silenced.', c_Red, t_Hint);
  end;
end;

procedure CmdDisableSendMsg(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sHumanName = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' username', c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      TempPlayObject.m_boFilterSendMsg := True;
    end;
    g_DisableSendMsgList.Add(sHumanName);
    SaveDisableSendMsgList();
    SysMsg(sHumanName + ' Added gag list', c_Green, t_Hint);
  end;
end;

procedure CmdClearMapMonster(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName, sMonName, sItems: string);
var
  i, ii: Integer;
  MonList: TList;
  Envir: TEnvirnoment;
  nMonCount: Integer;
  boKillAll: Boolean;
  boKillAllMap: Boolean;
  boNotItem: Boolean;
  BaseObject: TBaseObject;
begin
  with Playobject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sMapName = '') or (sMonName = '') or (sItems = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Map#(* For all) MobName(* For All) Drops(0 for no, 1 for yes)', c_Red,
        t_Hint);
      Exit;
    end;
    boKillAll := False;
    boKillAllMap := False;
    boNotItem := True;
    nMonCount := 0;
    Envir := nil;
    if sMonName = '*' then
      boKillAll := True;
    if sMapName = '*' then
      boKillAllMap := True;
    if sItems = '1' then
      boNotItem := False;

    MonList := TList.Create;
    for i := 0 to g_MapManager.Count - 1 do begin
      Envir := TEnvirnoment(g_MapManager.Items[i]);
      if (Envir <> nil) and (boKillAllMap or (CompareText(Envir.sMapName, sMapName) = 0)) then begin
        UserEngine.GetMapMonster(Envir, MonList);
        for ii := 0 to MonList.Count - 1 do begin
          BaseObject := TBaseObject(MonList.Items[ii]);
          if boKillAll or (CompareText(sMonName, BaseObject.m_sCharName) = 0) then begin
            BaseObject.m_boNoItem := boNotItem;
            BaseObject.m_WAbil.HP := 0;
            Inc(nMonCount);
          end;
        end;
      end;
    end;
    MonList.Free;
    if Envir = nil then begin
      SysMsg('Map does not exist.', c_Red, t_Hint);
      Exit;
    end;
    SysMsg('Amount of monsters cleared: ' + IntToStr(nMonCount), c_Red, t_Hint);
  end;
end;

procedure CmdMobPlace(PlayObject: TPlayObject; Cmd: pTGameCmd; sX, sY, sMonName, sCount: string);
var
  i: Integer;
  nCount, nX, nY: Integer;
  MEnvir: TEnvirnoment;
  mon: TBaseObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    nCount := _MIN(500, StrToIntDef(sCount, 0));
    nX := StrToIntDef(sX, 0);
    nY := StrToIntDef(sY, 0);
    MEnvir := g_MapManager.FindMap(g_sMissionMap);
    if (nX <= 0) or (nY <= 0) or (sMonName = '') or (nCount <= 0) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' X  Y MobName Amount', c_Red, t_Hint);
      Exit;
    end;
    if not g_boMission or (MEnvir = nil) then begin
      SysMsg('No destination set.', c_Red, t_Hint);
      SysMsg('Please use this command' + g_GameCommand.Mission.sCmd + 'to set the destionation.', c_Red, t_Hint);
      Exit;
    end;

    for i := 0 to nCount - 1 do begin
      mon := UserEngine.RegenMonsterByName(g_sMissionMap, nX, nY, sMonName);
      if mon <> nil then begin
        mon.m_boMission := True;
        mon.m_nMissionX := g_nMissionX;
        mon.m_nMissionY := g_nMissionY;
      end
      else
        break;
    end;
    SysMsg(IntToStr(nCount) + ' Only ' + sMonName + ' on this map ' + g_sMissionMap + ' ' + IntToStr(g_nMissionX)
      +
      ':' + IntToStr(g_nMissionY) + ' focus.', c_Green, t_Hint);
  end;
end;

procedure CmdMission(PlayObject: TPlayObject; Cmd: pTGameCmd; sX, sY: string);
var
  nX, nY: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sX = '') or (sY = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' X  Y', c_Red, t_Hint);
      Exit;
    end;
    nX := StrToIntDef(sX, 0);
    nY := StrToIntDef(sY, 0);
    g_boMission := True;
    g_sMissionMap := m_sMapName;
    g_nMissionX := nX;
    g_nMissionY := nY;
    SysMsg('The destination has been set: ' + m_sMapName + '(' + IntToStr(g_nMissionX) + ':' + IntToStr(g_nMissionY) +
      ')',
      c_Green, t_Hint);
  end;
end;

procedure CmdMob(PlayObject: TPlayObject; Cmd: pTGameCmd; sMonName: string; nCount, nLevel, nWuXin: Integer);
var
  i: Integer;
  nX, nY: Integer;
  Monster: TBaseObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sMonName = '') or ((sMonName <> '') and (sMonName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd,
        g_sGameCommandMobHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    if nCount <= 0 then
      nCount := 1;
    if not (nLevel in [0..10]) then
      nLevel := 0;

    nCount := _MIN(64, nCount);
    GetFrontPosition(nX, nY);
    for i := 0 to nCount - 1 do begin
      Monster := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, nX, nY, sMonName);
      if Monster <> nil then begin
        Monster.m_btSlaveMakeLevel := nLevel;
        Monster.m_btSlaveExpLevel := nLevel;
        if nWuXin in [1..5] then Monster.m_btWuXin := nWuXin;
        Monster.RecalcAbilitys;
        Monster.RefNameColor;
      end
      else begin
        SysMsg(g_sGameCommandMobMsg, c_Red, t_Hint);
        break;
      end;
    end;
  end;
end;

procedure CmdAnnouncement(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName: string);
var
  i: Integer;
  Guild: TGuild;
  //  PlayObject: TPlayObject;
  sHumanName: string;
  nPoint: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sGuildName = '') or ((sGuildName <> '') and (sGuildName[1] = '?')) then begin
      SysMsg('View guild Championship Results', c_Red, t_Hint);
      SysMsg(format('Usage: @%s guildname', [Cmd.sCmd]), c_Red, t_Hint);
      Exit;
    end;

    if not m_PEnvir.m_boFight3Zone then begin
      SysMsg('This command can not be used in the current map.', c_Red, t_Hint);
      Exit;
    end;
    Guild := g_GuildManager.FindGuild(sGuildName);
    if Guild <> nil then begin
      UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 1000, format(' - %s Guild Competition Results: ', [Guild.m_sGuildName]));
      for i := 0 to Guild.m_TeamFightDeadList.Count - 1 do begin
        nPoint := Integer(Guild.m_TeamFightDeadList.Objects[i]);
        sHumanName := Guild.m_TeamFightDeadList.Strings[i];
        UserEngine.CryCry(RM_CRY,
          m_PEnvir,
          m_nCurrX,
          m_nCurrY,
          1000,
          format(' - %s  : %d 分/dead %d Secondary. ', [sHumanName, HiWord(nPoint),
          LoWord(nPoint)]));
      end;
    end;
    UserEngine.CryCry(RM_CRY,
      m_PEnvir,
      m_nCurrX,
      m_nCurrY,
      1000,
      format(' - [%s] : %d Minutes', [Guild.m_sGuildName, Guild.m_nContestPoint]));
    UserEngine.CryCry(RM_CRY,
      m_PEnvir,
      m_nCurrX,
      m_nCurrY,
      1000,
      '------------------------------------');
  end;
end;

procedure CmdEndContest(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
var
  i, ii: Integer;
  List10, List14: TList;
  TempPlayObject, TempPlayObjectA: TPlayObject;
  bo19: Boolean;
  Guild: TGuild;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg('End guild Championship', c_Red, t_Hint);
      SysMsg(format('Usage: @%s', [Cmd.sCmd]), c_Red, t_Hint);
      Exit;
    end;

    if not m_PEnvir.m_boFight3Zone then begin
      SysMsg('This command can not be used in the current map.', c_Red, t_Hint);
      Exit;
    end;
    List10 := TList.Create;
    List14 := TList.Create;
    UserEngine.GetMapRageHuman(m_PEnvir, m_nCurrX, m_nCurrY, 1000, List10);
    for i := 0 to List10.Count - 1 do begin
      TempPlayObject := TPlayObject(List10.Items[i]);
      if not TempPlayObject.m_boObMode or not TempPlayObject.m_boAdminMode then begin
        if TempPlayObject.m_MyGuild = nil then
          Continue;
        bo19 := False;
        for ii := 0 to List14.Count - 1 do begin
          TempPlayObjectA := TPlayObject(List14.Items[ii]);
          if TempPlayObject.m_MyGuild = TempPlayObjectA.m_MyGuild then
            bo19 := True;
        end;
        if not bo19 then begin
          List14.Add(TempPlayObject.m_MyGuild);
        end;
      end;
    end;
    for i := 0 to List14.Count - 1 do begin
      Guild := TGuild(List14.Items[i]);
      Guild.EndTeamFight();
      UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 1000, format(' - %s The guild Championship ended.', [Guild.m_sGuildName]));
    end;
    List10.Free;
    List14.Free;
  end;
end;

procedure CmdStartContest(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
var
  i, ii: Integer;
  List10, List14: TList;
  TempPlayObject, TempPlayObjectA: TPlayObject;
  bo19: Boolean;
  s20: string;
  Guild: TGuild;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg('Start guild Championship', c_Red, t_Hint);
      SysMsg(format('Usage: @%s', [Cmd.sCmd]), c_Red, t_Hint);
      Exit;
    end;

    if not m_PEnvir.m_boFight3Zone then begin
      SysMsg('This command can not be used in the current map.', c_Red, t_Hint);
      Exit;
    end;
    List10 := TList.Create;
    List14 := TList.Create;
    UserEngine.GetMapRageHuman(m_PEnvir, m_nCurrX, m_nCurrY, 1000, List10);
    for i := 0 to List10.Count - 1 do begin
      TempPlayObject := TPlayObject(List10.Items[i]);
      if not TempPlayObject.m_boObMode or not TempPlayObject.m_boAdminMode then begin
        TempPlayObject.m_nFightZoneDieCount := 0;
        if TempPlayObject.m_MyGuild = nil then
          Continue;
        bo19 := False;
        for ii := 0 to List14.Count - 1 do begin
          TempPlayObjectA := TPlayObject(List14.Items[ii]);
          if TempPlayObject.m_MyGuild = TempPlayObjectA.m_MyGuild then
            bo19 := True;
        end;
        if not bo19 then begin
          List14.Add(TempPlayObject.m_MyGuild);
        end;
      end;
    end;
    SysMsg('The guild Championship has begun', c_Green, t_Hint);
    UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 1000, '- Guild war broke out');
    s20 := '';
    for i := 0 to List14.Count - 1 do begin
      Guild := TGuild(List14.Items[i]);
      Guild.StartTeamFight();
      for ii := 0 to List10.Count - 1 do begin
        TempPlayObject := TPlayObject(List10.Items[i]);
        if TempPlayObject.m_MyGuild = Guild then begin
          Guild.AddTeamFightMember(TempPlayObject.m_sCharName);
        end;
      end;
      s20 := s20 + Guild.m_sGuildName + ' ';
    end;
    UserEngine.CryCry(RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 1000, '- Participate in battle:' + s20);
    List10.Free;
    List14.Free;
  end;
end;

procedure CmdContestPoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName: string);
var
  Guild: TGuild;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sGuildName = '') or ((sGuildName <> '') and (sGuildName[1] = '?')) then begin
      SysMsg('View line of battle was scores', c_Red, t_Hint);
      SysMsg(format('Usage: @%s guildname', [Cmd.sCmd]), c_Red, t_Hint);
      Exit;
    end;
    Guild := g_GuildManager.FindGuild(sGuildName);
    if Guild <> nil then begin
      SysMsg(format('%s A score of: %d', [sGuildName, Guild.m_nContestPoint]), c_Green, t_Hint);
    end
    else begin
      SysMsg(format('Guild: %s does not exist.', [sGuildName]), c_Green, t_Hint);
    end;
  end;
end;

procedure CmdForcedWallconquestWar(PlayObject: TPlayObject; Cmd: pTGameCmd; sCASTLENAME: string);
var
  Castle: TUserCastle;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;

    if sCASTLENAME = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' CastleName', c_Red, t_Hint);
      Exit;
    end;

    Castle := g_CastleManager.Find(sCASTLENAME);
    if Castle <> nil then begin
      Castle.m_boUnderWar := not Castle.m_boUnderWar;
      if Castle.m_boUnderWar then begin
        {Castle.m_dwStartCastleWarTick := GetTickCount();
        Castle.StartWallconquestWar();
        s20 := format('[%s 攻城战已经开始]', [sCASTLENAME]);
        UserEngine.SendBroadCastMsg(s20, t_System);
        Castle.MainDoorControl(True);   }
        Castle.StartWallconquestWarEx();
      end
      else begin
        Castle.StopWallconquestWar();
      end;
    end
    else begin
      SysMsg(format(g_sGameCommandSbkGoldCastleNotFoundMsg, [sCASTLENAME]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdChangeSabukLord(PlayObject: TPlayObject; Cmd: pTGameCmd; sCASTLENAME, sGuildName: string;
  boFlag: Boolean);
var
  Guild: TGuild;
  Castle: TUserCastle;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;

    if (sCASTLENAME = '') or (sGuildName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' CastleName GuildName', c_Red, t_Hint);
      Exit;
    end;
    Castle := g_CastleManager.Find(sCASTLENAME);
    if Castle = nil then begin
      SysMsg(format(g_sGameCommandSbkGoldCastleNotFoundMsg, [sCASTLENAME]), c_Red, t_Hint);
      Exit;
    end;

    Guild := g_GuildManager.FindGuild(sGuildName);
    if Guild <> nil then begin
      Castle.GetCastle(Guild);
      SysMsg(Castle.m_sName + ' now being held by ' + sGuildName, c_Green, t_Hint);
    end
    else begin
      SysMsg('Guild ' + sGuildName + 'does not exist.', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdDelGuild(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sGuildName = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' GuildName', c_Red, t_Hint);
      Exit;
    end;
    if not g_GuildManager.DelGuild(sGuildName) then begin
      SysMsg('Could not find' + sGuildName, c_Red, t_Hint);
    end;
  end;
end;

procedure CmdAddGuild(PlayObject: TPlayObject; Cmd: pTGameCmd; sGuildName, sGuildChief: string);
var
  Human: TPlayObject;
  sSendMsg: string;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if nServerIndex <> 0 then begin
      SysMsg('You can only create guilds on the master server!', c_Red, t_Hint);
      Exit;
    end;
    if nServerIndex <> 0 then begin
      SysMsg('You can only make guilds on the master server', c_Red, t_Hint);
      Exit;
    end;
    if (sGuildName = '') or (sGuildChief = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' GuildName GuildLeader', c_Red, t_Hint);
      Exit;
    end;

    Human := UserEngine.GetPlayObject(sGuildChief);
    if Human = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sGuildChief]), c_Red, t_Hint);
      Exit;
    end;
    if Human.m_nWaitIndex <> 0 then begin
      SysMsg('This player is bussy, try again later...', c_Red, t_Hint);
      Exit;
    end;
    if Human.m_MyGuild = nil then begin
      Human.m_nWaitIndex := GetWaitMsgID;
      sSendMsg := IntToStr(Human.m_nWaitIndex) + '/';
      sSendMsg := sSendMsg + IntToStr(Human.m_nDBIndex) + '/';
      sSendMsg := sSendMsg + IntToStr(RM_CREATENEWGUILD) + '/';
      sSendMsg := sSendMsg + sGuildName;
      FrmIDSoc.SendCreateGuildMsg(sSendMsg);
    end;
  end;
end;

procedure CmdClearMission(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName)', c_Red, t_Hint);
      Exit;
    end;
    if sHumanName[1] = '?' then begin
      SysMsg('This command is use to clear flags', c_Blue, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format('%s is not online!', [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    SafeFillChar(TempPlayObject.m_QuestFlag, SizeOf(TQuestFlag), #0);
    SysMsg(format('%s Flags have been cleared.', [sHumanName]), c_Green, t_Hint);
  end;
end;

procedure CmdDeleteItem(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sItemName: string; nCount: Integer);
var
  i: Integer;
  TempPlayObject: TPlayObject;
  nItemCount: Integer;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (sItemName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName ItemName Amount)', c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    nItemCount := 0;
    for i := TempPlayObject.m_ItemList.Count - 1 downto 0 do begin
      if TempPlayObject.m_ItemList.Count <= 0 then
        break;
      UserItem := TempPlayObject.m_ItemList.Items[i];
      if UserItem = nil then
        Continue;
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (CompareText(sItemName, StdItem.Name) = 0) then begin
        TempPlayObject.SendDelItems(UserItem);
        DisPose(UserItem);
        TempPlayObject.m_ItemList.Delete(i);
        Inc(nItemCount);
        if nItemCount >= nCount then
          break;
      end;
    end;
  end;
end;

procedure CmdDelSkill(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSkillName: string);
var
  i: Integer;
  TempPlayObject: TPlayObject;
  boDelAll: Boolean;
  UserMagic: pTUserMagic;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (sSkillName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName SkillName(All to remove all))', c_Red, t_Hint);
      Exit;
    end;
    if CompareText(sSkillName, 'All') = 0 then
      boDelAll := True
    else
      boDelAll := False;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;

    for i := TempPlayObject.m_MagicList.Count - 1 downto 0 do begin
      if TempPlayObject.m_MagicList.Count <= 0 then
        break;
      UserMagic := TempPlayObject.m_MagicList.Items[i];
      if UserMagic <> nil then begin
        if boDelAll then begin
          DisPose(UserMagic);
          TempPlayObject.m_MagicList.Delete(i);
        end
        else begin
          if CompareText(UserMagic.MagicInfo.sMagicName, sSkillName) = 0 then begin
            TempPlayObject.SendDelMagic(UserMagic);
            DisPose(UserMagic);
            TempPlayObject.m_MagicList.Delete(i);
            TempPlayObject.SysMsg(format('%s has been deleted!', [sSkillName]), c_Green, t_Hint);
            SysMsg(format('%s Skills of %s has been deleted', [sHumanName, sSkillName]), c_Green, t_Hint);
            break;
          end;
        end;
      end;
    end;
    TempPlayObject.RecalcAbilitys;
  end;
end;

procedure CmdTrainingMagic(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSkillName: string; nLevel: Integer);
var
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sHumanName <> '') and (sHumanName[1] = '?')) or (sHumanName = '') or
      (sSkillName = '') or (nLevel < 0) or not (nLevel in [0..3]) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName  SkillName Level(0-3)', c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    Magic := UserEngine.FindMagic(sSkillName);
    if Magic = nil then begin
      SysMsg(format('%s Skill does not exist.', [sSkillName]), c_Red, t_Hint);
      Exit;
    end;

    if TempPlayObject.IsTrainingSkill(Magic.wMagicId) then begin
      SysMsg(format('%s Skills have already been learned.', [sSkillName]), c_Red, t_Hint);
      Exit;
    end;
    if nLevel <= 0 then nLevel := 1;
    New(UserMagic);
    UserMagic.MagicInfo := Magic;
    UserMagic.wMagIdx := Magic.wMagicId;
    UserMagic.btLevel := nLevel;
    UserMagic.nTranPoint := 0;
    UserMagic.dwInterval := 0;
    UserMagic.btKey := 0;
    TempPlayObject.m_MagicList.Add(UserMagic);
    TempPlayObject.SendAddMagic(UserMagic);
    TempPlayObject.RecalcAbilitys;
    SysMsg(format('%s of %s trained successfully.', [sHumanName, Magic.sMagicName]), c_Green, t_Hint);
  end;
end;

procedure CmdTrainingSkill(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSkillName: string; nLevel: Integer);
var
  i: Integer;
  UserMagic: pTUserMagic;
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (sSkillName = '') or (nLevel <= 0) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName  SkillName Level(0-3)', c_Red, t_Hint);
      Exit;
    end;
    nLevel := _MIN(3, nLevel);
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format('%s not online!', [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    for i := 0 to TempPlayObject.m_MagicList.Count - 1 do begin
      UserMagic := TempPlayObject.m_MagicList.Items[i];
      if CompareText(UserMagic.MagicInfo.sMagicName, sSkillName) = 0 then begin
        UserMagic.btLevel := nLevel;
        TempPlayObject.SendDefMsg(TempPlayObject, SM_MAGIC_LVEXP, UserMagic.MagicInfo.wMagicId,
          UserMagic.btLevel,
          LoWord(UserMagic.nTranPoint),
          HiWord(UserMagic.nTranPoint), '');
        TempPlayObject.SysMsg(format('%s Level has been adjusted %d', [sSkillName, nLevel]), c_Green, t_Hint);
        SysMsg(format('%s Skill level %s has been changed %d', [sHumanName, sSkillName, nLevel]), c_Green, t_Hint);
        break;
      end;
    end;
  end;
end;

procedure CmdRecallMob(PlayObject: TPlayObject; Cmd: pTGameCmd; sMonName: string; nCount, nLevel, nAutoChangeColor,
  nFixColor: Integer);
var
  i: Integer;
  n10, n14: Integer;
  mon: TBaseObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sMonName = '') or ((sMonName <> '') and (sMonName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandRecallMobHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    if nLevel >= 10 then
      nLevel := 0;
    if nCount <= 0 then
      nCount := 1;
    for i := 0 to nCount - 1 do begin
      if m_SlaveList.Count >= 20 then
        break;
      GetFrontPosition(n10, n14);
      mon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, n10, n14, sMonName);
      if mon <> nil then begin
        mon.m_Master := PlayObject;
        mon.m_btWuXin := 0;
        mon.m_dwMasterRoyaltyTick := GetTickCount + 24 * 60 * 60 * 1000;
        mon.m_btSlaveMakeLevel := 3;
        mon.m_btSlaveExpLevel := nLevel;
        if nAutoChangeColor = 1 then begin
          mon.m_boAutoChangeColor := True;
        end
        else if nFixColor > 0 then begin
          mon.m_boFixColor := True;
          mon.m_nFixColorIdx := nFixColor - 1;
        end;

        mon.RecalcAbilitys();
        mon.RefNameColor();
        m_SlaveList.Add(mon);
      end;
    end;
  end;
end;

procedure CmdChangeMasterName(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sMasterName, sIsMaster: string);
//var
//  TempPlayObject: TPlayObject;
begin
  with Playobject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (sMasterName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName MasterName(No will clear the name)', c_Red, t_Hint);
      Exit;
    end;
    SysMsg('has been changed！', c_Red, t_Hint);

{    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      if CompareText(sMasterName, 'No') = 0 then begin
        TempPlayObject.m_sMasterName := '';
        TempPlayObject.RefShowName;
        TempPlayObject.m_boMaster := False;
        SysMsg(sHumanName + ' Mentor/Master name has been cleared.', c_Green, t_Hint);
      end
      else begin
        TempPlayObject.m_sMasterName := sMasterName;
        if (sIsMaster <> '') and (sIsMaster[1] = '1') then
          TempPlayObject.m_boMaster := True
        else
          TempPlayObject.m_boMaster := False;
        TempPlayObject.RefShowName;
        SysMsg(sHumanName + ' Mentor/Master name has been changed.', c_Green, t_Hint);
      end;
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;}
  end;
end;

procedure CmdChangeDearName(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sDearName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (sDearName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Username SpouseName(No will clear the name)', c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      if CompareText(sDearName, 'No') = 0 then begin
        TempPlayObject.m_sDearName := '';
        TempPlayObject.RefShowName;
        SysMsg(sHumanName + ' Spouse name has been cleared', c_Green, t_Hint);
      end
      else begin
        TempPlayObject.m_sDearName := sDearName;
        TempPlayObject.RefShowName;
        SysMsg(sHumanName + ' Spouse name has been changed.', c_Green, t_Hint);
      end;
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdAdjuestExp(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sExp: string);
var
  TempPlayObject: TPlayObject;
  dwExp: LongWord;
  dwOExp: LongWord;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName Amount', c_Red, t_Hint);
      Exit;
    end;
    dwExp := StrToIntDef(sExp, 0);

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      dwOExp := TempPlayObject.m_Abil.Exp;
      TempPlayObject.m_Abil.Exp := dwExp;
      TempPlayObject.HasLevelUp(1);
      SysMsg(sHumanName + ' Experience adjusted.', c_Green, t_Hint);
      if g_Config.boShowMakeItemMsg then
        MainOutMessage('[Experience adjusted!] ' + m_sCharName + '(' + TempPlayObject.m_sCharName + ' ' + IntToStr(dwOExp) +
          ' -> ' + IntToStr(TempPlayObject.m_Abil.Exp) + ')');
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdAdjuestLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; nLevel: Integer);
var
  TempPlayObject: TPlayObject;
  nOLevel: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sHumanName = '' then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Username Level', c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      nOLevel := TempPlayObject.m_Abil.Level;
      TempPlayObject.m_Abil.Level := _MAX(1, _MIN(MAXUPLEVEL, nLevel));
      TempPlayObject.HasLevelUp(1);
      SysMsg(sHumanName + ' Level adjusted.', c_Green, t_Hint);
      if g_Config.boShowMakeItemMsg then
        MainOutMessage('[Level gained!] ' + m_sCharName + '(' + TempPlayObject.m_sCharName + ' ' + IntToStr(nOLevel) +
          ' -> ' + IntToStr(TempPlayObject.m_Abil.Level) + ')');
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdCreditPoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sCtr: string; nPoint: Integer);
var
  TempPlayObject: TPlayObject;
  Ctr: Char;
begin
  with PlayObject do begin
    Ctr := '1';
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sCtr <> '') then begin
      Ctr := sCtr[1];
    end;

    if (sHumanName = '') or not (Ctr in ['=', '+', '-']) or (nPoint < 0) or (nPoint > MAXINTCOUNT) or
      ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandCreditPointHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    case sCtr[1] of
      '=': begin
          IntegerChange(TempPlayObject.m_nCreditPoint, nPoint, INT_SET);
        end;
      '+': begin
          IntegerChange(TempPlayObject.m_nCreditPoint, nPoint, INT_ADD);
        end;
      '-': begin
          IntegerChange(TempPlayObject.m_nCreditPoint, nPoint, INT_DEL);
        end;
    end;
    if g_boGameLogCreditPoint then begin
      AddGameLog(TempPlayObject, LOG_CREDITPOINT, sSTRING_CREDITPOINT, 0, TempPlayObject.m_nCreditPoint, m_sCharName,
        sCtr[1], IntToStr(nPoint), 'Command', nil);
    end;
    TempPlayObject.DiamondChanged;
    TempPlayObject.SysMsg(format(g_sGameCommandCreditPointHumanMsg, [nPoint, TempPlayObject.m_nCreditPoint]), c_Green, t_Hint);
    SysMsg(format(g_sGameCommandCreditPointGMMsg, [sHumanName, nPoint, TempPlayObject.m_nCreditPoint]), c_Green, t_Hint);
  end;
end;

procedure CmdGameGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; sCtr: string; nPoint: Integer);
var
  TempPlayObject: TPlayObject;
  Ctr: Char;
begin
  with PlayObject do begin
    Ctr := '1';
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sCtr <> '') then begin
      Ctr := sCtr[1];
    end;

    if (sHumanName = '') or not (Ctr in ['=', '+', '-']) or (nPoint < 0) or (nPoint > MAXINTCOUNT) or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandGamePointHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    case sCtr[1] of
      '=': IntegerChange(TempPlayObject.m_nGameGold, nPoint, INT_SET);
      '+': IntegerChange(TempPlayObject.m_nGameGold, nPoint, INT_ADD);
      '-': IntegerChange(TempPlayObject.m_nGameGold, nPoint, INT_DEL);
    end;
    if g_boGameLogGameGold then begin
      AddGameLog(TempPlayObject, LOG_GAMEGOLDCHANGED, sSTRING_GAMEGOLD, 0, TempPlayObject.m_nGameGold, m_sCharName, sCtr[1], IntToStr(nPoint), '命令', nil);
    end;
    TempPlayObject.GameGoldChanged();
    TempPlayObject.SysMsg(format(g_sGameCommandGameGoldHumanMsg, [g_Config.sGameGoldName, nPoint, TempPlayObject.m_nGameGold, g_Config.sGameGoldName]), c_Green, t_Hint);
    SysMsg(format(g_sGameCommandGameGoldGMMsg, [sHumanName, g_Config.sGameGoldName, nPoint, TempPlayObject.m_nGameGold, g_Config.sGameGoldName]), c_Green, t_Hint);
  end;
end;

procedure CmdAddGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumName: string; nCount: Integer; sBind: string);
var
  TempPlayObject: TPlayObject;
//  nServerIndex: Integer;
  pGold: PInteger;
  boBind: Boolean;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (sHumName = '') or (nCount <= 0) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Username  Amount BIND(Whether tied to gold)', c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumName);
    if TempPlayObject <> nil then begin
      boBind := CompareText(sBind, 'BIND') = 0;
      if boBind then pGold := @TempPlayObject.m_nBindGold
      else pGold := @TempPlayObject.m_nGold;
      if (pGold^ + nCount) < TempPlayObject.m_nGoldMax then begin
        Inc(pGold^, nCount);
      end
      else begin
        nCount := TempPlayObject.m_nGoldMax - pGold^;
        pGold^ := TempPlayObject.m_nGoldMax;
      end;
      TempPlayObject.GoldChanged();

      //004CD6F6
      if boBind then begin
        SysMsg(sHumName + 'Bound gold has increased' + IntToStr(nCount) + '.', c_Green, t_Hint);
        if g_boGameLogBindGold then
          AddGameLog(TempPlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, pGold^, m_sCharName,
            '+', IntToStr(nCount), 'Command', nil);
      end else begin
        SysMsg(sHumName + 'of gold has increased by' + IntToStr(nCount) + '.', c_Green, t_Hint);
        if g_boGameLogGold then
          AddGameLog(TempPlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, pGold^, m_sCharName,
              '+', IntToStr(nCount), 'Command', nil);
      end;
    end;
    {else begin
      if UserEngine.FindOtherServerUser(sHumName, nServerIndex) then begin
        SysMsg(sHumName + ' 现在' + IntToStr(nServerIndex) + '号服务器上', c_Green, t_Hint);
      end;
    end;  }
  end;
end;

procedure CmdDelGold(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumName: string; nCount: Integer; sBind: string);
var
  TempPlayObject: TPlayObject;
//  nServerIndex: Integer;
  pGold: PInteger;
  boBind: Boolean;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumName = '') or (nCount <= 0) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Username  Amount BIND(Whether tied to gold)', c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumName);
    if TempPlayObject <> nil then begin
      boBind := CompareText(sBind, 'BIND') = 0;
      if boBind then pGold := @TempPlayObject.m_nBindGold
      else pGold := @TempPlayObject.m_nGold;
      if pGold^ > nCount then begin
        Dec(pGold^, nCount);
      end
      else begin
        nCount := pGold^;
        pGold^ := 0;
      end;
      TempPlayObject.GoldChanged();

      if boBind then begin
        SysMsg(sHumName + 'Bound gold has been reduced' + IntToStr(nCount) + '.', c_Green, t_Hint);
        if g_boGameLogBindGold then
          AddGameLog(TempPlayObject, LOG_BINDGOLDCHANGED, sSTRING_BINDGOLDNAME, 0, pGold^, m_sCharName,
            '-', IntToStr(nCount), 'Command', nil);
      end else begin
        SysMsg(sHumName + 'The gold coins have been reduced by' + IntToStr(nCount) + '.', c_Green, t_Hint);
        if g_boGameLogGold then
          AddGameLog(TempPlayObject, LOG_GOLDCHANGED, sSTRING_GOLDNAME, 0, pGold^, m_sCharName,
            '-', IntToStr(nCount), 'Command', nil);
      end;
    end;
  end;
end;

procedure CmdReNewLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sLevel: string);
var
  TempPlayObject: TPlayObject;
  nLevel: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Username RebirthLevel', c_Red, t_Hint);
      Exit;
    end;
    nLevel := StrToIntDef(sLevel, -1);
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      if (nLevel >= 0) and (nLevel <= 255) then begin
        TempPlayObject.m_btReLevel := nLevel;
        TempPlayObject.RefShowName();
      end;
      SysMsg(sHumanName + ' Renewlevel is now ' + IntToStr(TempPlayObject.m_btReLevel), c_Green, t_Hint);
    end
    else begin
      SysMsg(sHumanName + ' Not online!', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdSetPermission(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sPermission: string);
var
  nPerission: Integer;
  TempPlayObject: TPlayObject;
resourcestring
  sOutFormatMsg = '[Permission to adjust] %s (%s %d -> %d)';
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    nPerission := StrToIntDef(sPermission, 0);
    if (sHumanName = '') or not (nPerission in [0..10]) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' Username permissionLevel(0 - 10)', c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    if g_Config.boShowMakeItemMsg then
      MainOutMessage(format(sOutFormatMsg, [m_sCharName, TempPlayObject.m_sCharName, TempPlayObject.m_btPermission,
        nPerission]));
    TempPlayObject.m_btPermission := nPerission;
    SysMsg(sHumanName + ' Current permission level: ' + IntToStr(TempPlayObject.m_btPermission), c_Red, t_Hint);
  end;
end;

procedure CmdHair(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; nHair: Integer);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (nHair < 0) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName Number', c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      TempPlayObject.m_btHair := nHair;
      TempPlayObject.FeatureChanged();
      SysMsg(sHumanName + ' hair has been changed.', c_Green, t_Hint);
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdChangeGender(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sSex: string);
var
  TempPlayObject: TPlayObject;
  nSex: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    nSex := -1;
    if (sSex = 'Man') or (sSex = 'Male') or (sSex = '0') then begin
      nSex := 0;
    end;
    if (sSex = 'WoMan') or (sSex = 'Female') or (sSex = '1') then begin
      nSex := 1;
    end;
    if (sHumanName = '') or (nSex = -1) then begin
      SysMsg('Usage: @' + Cmd.sCmd + ' UserName Gender(Male、Female)', c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      if TempPlayObject.m_btGender <> nSex then begin
        TempPlayObject.m_btGender := nSex;
        TempPlayObject.FeatureChanged();
        SysMsg(TempPlayObject.m_sCharName + ' Gender has been changed.', c_Green, t_Hint);
      end
      else begin
        SysMsg(TempPlayObject.m_sCharName + ' Gender change failure.', c_Red, t_Hint);
      end;
    end
    else begin
      SysMsg(sHumanName + 'Not online!', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdIncPkPoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string; nPoint: Integer);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandIncPkPointHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    WordChange(TempPlayObject.m_nPkPoint, nPoint, INT_ADD);
    TempPlayObject.RefNameColor();
    TempPlayObject.DiamondChanged;
    if nPoint > 0 then
      SysMsg(format(g_sGameCommandIncPkPointAddPointMsg, [sHumanName, nPoint]), c_Green, t_Hint)
    else
      SysMsg(format(g_sGameCommandIncPkPointDecPointMsg, [sHumanName, -nPoint]), c_Green, t_Hint);
  end;
end;

procedure CmdPKpoint(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandPKPointHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;

    SysMsg(format(g_sGameCommandPKPointMsg, [sHumanName, TempPlayObject.m_nPkPoint]), c_Green, t_Hint);
  end;
end;

procedure CmdFreePenalty(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandFreePKHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject.m_nPkPoint := 0;
    TempPlayObject.RefNameColor();
    TempPlayObject.DiamondChanged;
    TempPlayObject.SysMsg(g_sGameCommandFreePKHumanMsg, c_Green, t_Hint);
    SysMsg(format(g_sGameCommandFreePKMsg, [sHumanName]), c_Green, t_Hint);
  end;
end;

procedure CmdChangeJob(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sJobName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or (sJobName = '') then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandChangeJobHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      if CompareText(sJobName, 'Warrior') = 0 then
        TempPlayObject.m_btJob := 0;
      if CompareText(sJobName, 'Wizard') = 0 then
        TempPlayObject.m_btJob := 1;
      if CompareText(sJobName, 'Taoist') = 0 then
        TempPlayObject.m_btJob := 2;
      if CompareText(sJobName, 'Assassin') = 0 then
        TempPlayObject.m_btJob := 3;
      if CompareText(sJobName, 'Archer') = 0 then
        TempPlayObject.m_btJob := 4;
      TempPlayObject.HasLevelUp(1);
      TempPlayObject.SysMsg(g_sGameCommandChangeJobHumanMsg, c_Green, t_Hint);
      SysMsg(format(g_sGameCommandChangeJobMsg, [sHumanName]), c_Green, t_Hint);
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdKill(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  BaseObject: TBaseObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if sHumanName <> '' then begin
      BaseObject := UserEngine.GetPlayObject(sHumanName);
      if BaseObject = nil then begin
        SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
        Exit;
      end;
    end
    else begin
      BaseObject := GetPoseCreate();
      if BaseObject = nil then begin
        SysMsg('You must face the target to use this command.', c_Red, t_Hint);
        Exit;
      end;
    end;
    BaseObject.Die;
  end;
end;

procedure CmdReAlive(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandReAliveHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject.ReAlive;
    TempPlayObject.m_WAbil.HP := TempPlayObject.m_WAbil.MaxHP;
    TempPlayObject.SendAbility;

    SysMsg(format(g_sGameCommandReAliveMsg, [sHumanName]), c_Green, t_Hint);
    SysMsg(sHumanName + ' has been revived!', c_Green, t_Hint);
  end;
end;

procedure CmdKickHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumName = '') or ((sHumName <> '') and (sHumName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandKickHumanHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumName);
    if TempPlayObject <> nil then begin
      TempPlayObject.m_boKickFlag := True;
      TempPlayObject.m_boEmergencyClose := True;
      TempPlayObject.m_boPlayOffLine := False;
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdChangeLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
var
  nOLevel: Integer;
  nLevel: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    nLevel := StrToIntDef(sParam1, 1);
    nOLevel := m_Abil.Level;
    m_Abil.Level := _MIN(MAXUPLEVEL, nLevel);
    HasLevelUp(1);
    if g_Config.boShowMakeItemMsg then begin
      MainOutMessage(format(g_sGameCommandLevelConsoleMsg, [m_sCharName, nOLevel, m_Abil.Level]));
    end;
  end;
end;

procedure CmdShowMapInfo(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam1: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    SysMsg(format(g_sGameCommandMapInfoMsg, [m_PEnvir.sMapName, m_PEnvir.sMapDesc]), c_Green, t_Hint);
    SysMsg(format(g_sGameCommandMapInfoSizeMsg, [m_PEnvir.m_nWidth, m_PEnvir.m_nHeight]), c_Green, t_Hint);
    SysMsg(format(g_sGameCommandMapInfoCountMsg, [g_MapObjectCount[m_PEnvir.m_nMapIndex]]), c_Green, t_Hint);
  end;
end;

procedure CmdHumanCount(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName: string);
var
  Envir: TEnvirnoment;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sMapName = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandHumanCountHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then begin
      SysMsg(g_sGameCommandMobCountMapNotFound, c_Red, t_Hint);
      Exit;
    end;
    SysMsg(format(g_sGameCommandMobCountMonsterCount, [UserEngine.GetMapHuman(sMapName)]), c_Green, t_Hint);
  end;
end;

procedure CmdMobCount(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName: string);
var
  Envir: TEnvirnoment;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sMapName = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandMobCountHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    Envir := g_MapManager.FindMap(sMapName);
    if Envir = nil then begin
      SysMsg(g_sGameCommandMobCountMapNotFound, c_Red, t_Hint);
      Exit;
    end;
    SysMsg(format(g_sGameCommandMobCountMonsterCount, [UserEngine.GetMapMonster(Envir, nil)]), c_Green, t_Hint);
  end;
end;

procedure CmdMobLevel(PlayObject: TPlayObject; Cmd: pTGameCmd; Param: string);
var
  i: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((Param <> '') and (Param[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, '']), c_Red, t_Hint);
      Exit;
    end;

    BaseObjectList := TList.Create;
    m_PEnvir.GetRangeBaseObject(m_nCurrX, m_nCurrY, 2, True, BaseObjectList);
    for i := 0 to BaseObjectList.Count - 1 do begin
      BaseObject := TBaseObject(BaseObjectList.Items[i]);
      SysMsg(BaseObject.GeTBaseObjectInfo(), c_Green, t_Hint);
    end;
    BaseObjectList.Free;
  end;
end;

procedure CmdViewWhisper(PlayObject: TPlayObject; Cmd: pTGameCmd; sCharName, sParam2: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sCharName = '') or ((sCharName <> '') and (sCharName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandViewWhisperHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sCharName);
    if TempPlayObject <> nil then begin
      if TempPlayObject.m_GetWhisperHuman = PlayObject then begin
        TempPlayObject.m_GetWhisperHuman := nil;
        SysMsg(format(g_sGameCommandViewWhisperMsg1, [sCharName]), c_Green, t_Hint);
      end
      else begin
        TempPlayObject.m_GetWhisperHuman := PlayObject;
        SysMsg(format(g_sGameCommandViewWhisperMsg2, [sCharName]), c_Green, t_Hint);
      end;
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sCharName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdHumanLocal(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandHumanLocalHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    SysMsg(format(g_sGameCommandHumanLocalMsg, [sHumanName, TempPlayObject.m_sIPLocal]), c_Green, t_Hint);
  end;
end;

procedure CmdHumanInfo(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandInfoHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    SysMsg(TempPlayObject.GeTBaseObjectInfo(), c_Green, t_Hint);
  end;
end;

procedure CmdMapMoveHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sSrcMap, sDenMap: string);
var
  SrcEnvir, DenEnvir: TEnvirnoment;
  HumanList: TList;
  i: Integer;
  MoveHuman: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sDenMap = '') or (sSrcMap = '') or ((sSrcMap <> '') and (sSrcMap[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd,
        g_sGameCommandMapMoveHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    SrcEnvir := g_MapManager.FindMap(sSrcMap);
    DenEnvir := g_MapManager.FindMap(sDenMap);
    if (SrcEnvir = nil) then begin
      SysMsg(format(g_sGameCommandMapMoveMapNotFound, [sSrcMap]), c_Red, t_Hint);
      Exit;
    end;
    if (DenEnvir = nil) then begin
      SysMsg(format(g_sGameCommandMapMoveMapNotFound, [sDenMap]), c_Red, t_Hint);
      Exit;
    end;
    HumanList := TList.Create;
    UserEngine.GetMapRageHuman(SrcEnvir, SrcEnvir.m_nWidth div 2,
      SrcEnvir.m_nHeight div 2, 1000, HumanList);
    for i := 0 to HumanList.Count - 1 do begin
      MoveHuman := TPlayObject(HumanList.Items[i]);
      if MoveHuman <> PlayObject then
        MoveHuman.MapRandomMove(sDenMap, 0);
    end;
    HumanList.Free;
  end;
end;

procedure CmdSuperTing(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName, sRange: string);
var
  i: Integer;
  TempPlayObject: TPlayObject;
  MoveHuman: TPlayObject;
  nRange: Integer;
  HumanList: TList;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sRange = '') or (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandSuperTingHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    nRange := _MAX(10, StrToIntDef(sRange, 2));
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      HumanList := TList.Create;
      UserEngine.GetMapRageHuman(TempPlayObject.m_PEnvir, TempPlayObject.m_nCurrX, TempPlayObject.m_nCurrY, nRange,
        HumanList);
      for i := 0 to HumanList.Count - 1 do begin
        MoveHuman := TPlayObject(HumanList.Items[i]);
        if MoveHuman <> PlayObject then
          MoveHuman.MapRandomMove(MoveHuman.m_sHomeMap, 0);
      end;
      HumanList.Free;
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdTing(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandTingHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject <> nil then begin
      TempPlayObject.MapRandomMove(m_sHomeMap, 0);
    end
    else begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdReGotoHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  TempPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandReGotoHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    SpaceMove(TempPlayObject.m_PEnvir, TempPlayObject.m_nCurrX, TempPlayObject.m_nCurrY, 0);
  end;
end;

procedure CmdRecallHuman(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandRecallHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    RecallHuman(sHumanName);
  end;
end;

procedure CmdPositionMove(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName, sX, sY: string);
var
  Envir: TEnvirnoment;
  nX, nY: Integer;
begin
  try
    with PlayObject do begin
      if (m_btPermission < Cmd.nPermissionMin) then begin
        SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
        Exit;
      end;
      if (sMapName = '') or (sX = '') or (sY = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
        SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandPositionMoveHelpMsg]), c_Red, t_Hint);
        Exit;
      end;
      Envir := g_MapManager.FindMap(sMapName);
      if (m_btPermission >= Cmd.nPermissionMax) {or CanMoveMap(sMapName)} then begin
        if Envir <> nil then begin
          nX := StrToIntDef(sX, 0);
          nY := StrToIntDef(sY, 0);
          if Envir.CanWalk(nX, nY, True) then begin
            SpaceMove(Envir, nX, nY, 0);
          end
          else begin
            SysMsg(format(g_sGameCommandPositionMoveCanotMoveToMap, [sMapName, sX, sY]), c_Green, t_Hint);
          end;
        end;
      end
      else begin
        SysMsg(format(g_sTheMapDisableMove, [sMapName, Envir.sMapDesc]), c_Red, t_Hint);
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('[Exceptioin] TPlayObject.CmdPositionMove');
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure CmdMapMove(PlayObject: TPlayObject; Cmd: pTGameCmd; sMapName: string);
var
  Envir: TEnvirnoment;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sMapName = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGameCommandMoveHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    Envir := g_MapManager.FindMap(sMapName);
    if (Envir = nil) then begin
      SysMsg(format(g_sTheMapNotFound, [sMapName]) { + ' 此地图号不存在.'}, c_Red, t_Hint);
      Exit;
    end;
    if (m_btPermission >= Cmd.nPermissionMax) {or CanMoveMap(sMapName)} then begin
      SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      MapRandomMove(Envir, 0);
    end
    else begin
      SysMsg(format(g_sTheMapDisableMove, [sMapName, Envir.sMapDesc]), c_Red, t_Hint);
    end;
  end;
end;

procedure CmdSmakeItem(PlayObject: TPlayObject; Cmd: pTGameCmd; nWhere, nValueType, nValue: Integer);
var
  sShowMsg: string;
  StdItem: pTStdItem;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (nWhere in [0..MAXUSEITEMS - 1]) and (nValueType in [0..tb_Count - 1]) and
      (nValue >= 0) and (nValue <= 65535) then begin
      if m_UseItems[nWhere].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[nWhere].wIndex);
        if StdItem = nil then
          Exit;
        m_UseItems[nWhere].Value.btValue[nValueType] := nValue;
        RecalcAbilitys();
        SendUpdateItem(@m_UseItems[nWhere]);
        SysMsg(sShowMsg, c_Blue, t_Hint);
        if g_Config.boShowMakeItemMsg then
          MainOutMessage('[Item to adjust] ' + m_sCharName + '(' + StdItem.Name + ' -> ' + sShowMsg + ')');
      end
      else begin
        SysMsg(g_sGamecommandSuperMakeHelpMsg, c_Red, t_Hint);
      end;
    end;
  end;
end;

procedure CmdMakeItem(PlayObject: TPlayObject; Cmd: pTGameCmd; sItemName: string; nCount: Integer);
var
  i: Integer;
  UserItem, AddUserItem: pTUserItem;
  StdItem: pTStdItem;
  nBack: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sItemName = '') then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, g_sGamecommandMakeHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    if (nCount <= 0) then
      nCount := 1;
    if (nCount > 10) then
      nCount := 10;
    if (m_btPermission < Cmd.nPermissionMax) then begin
      {if not CanMakeItem(sItemName) then begin
        SysMsg(g_sGamecommandMakeItemNameOrPerMissionNot, c_Red, t_Hint);
        Exit;
      end;    }
      if g_CastleManager.InCastleWarArea(PlayObject) <> nil then begin
        SysMsg(g_sGamecommandMakeInCastleWarRange, c_Red, t_Hint);
        Exit;
      end;
      if not InSafeZone then begin
        SysMsg(g_sGamecommandMakeInSafeZoneRange, c_Red, t_Hint);
        Exit;
      end;
      nCount := 1;
    end;
    for i := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromNameEx(sItemName, UserItem, True) then begin
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        UserItem.Dura := UserItem.DuraMax;
        nBack := AddItemToBag(UserItem, StdItem, False, '', '', AddUserItem);
        if nBack <> -1 then begin
          if (sm_HorseArm in UserEngine.GetStdItemModeEx(UserItem.wIndex)) or (sm_ArmingStrong in UserEngine.GetStdItemModeEx(UserItem.wIndex)) then begin
            if Random(g_Config.nMakeRandomAddValue {10}) = 0 then begin
              SetByteStatus(UserItem.btBindMode2, Ib2_Unknown, True);
              if g_Config.boMakeRandomIsOpenShow then
                ItemUnit.RandomUpgradeItem(UserItem, DefUnsealItem);
            end;
          end;
          UserItem.MakeIndex := GetItemNumberEx();
          SendAddItem(UserItem);

          //if g_Config.boShowMakeItemMsg and (m_btPermission >= 6) then
          MainOutMessage('[@Make] ' + m_sCharName + ' ' + sItemName + '(' + IntToStr(UserItem.MakeIndex) + ')');
          if Stditem.NeedIdentify = 1 then
            AddGameLog(PlayObject, LOG_ADDITEM, Stditem.Name, Useritem.MakeIndex, Useritem.Dura, '0',
              '0', '0', 'Made', Useritem);
        end
        else begin
          DisPose(UserItem);
          break;
        end;
      end
      else begin //004CD114
        DisPose(UserItem);
        SysMsg(format(g_sGamecommandMakeItemNameNotFound, [sItemName]), c_Red, t_Hint);
        break;
      end;
    end;
  end;
end;

procedure CmdChangeSuperManMode(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1:
  string; boFlag: Boolean);
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    m_boSuperMan := boFlag;
    if m_boSuperMan then
      SysMsg(sSupermanMode, c_Green, t_Hint)
    else
      SysMsg(sReleaseSupermanMode, c_Green, t_Hint);
  end;
end;

procedure CmdChangeObMode(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1:
  string; boFlag: Boolean);
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    if boFlag then begin
      SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
      //01/21 强行发送刷新数据到客户端，解决GM登录隐身有影子问题
    end;
    m_boObMode := boFlag;
    if m_boObMode then begin
      SysMsg(sObserverMode, c_Green, t_Hint);
    end
    else
      SysMsg(g_sReleaseObserverMode, c_Green, t_Hint);
  end;
end;

procedure CmdChangeAdminMode(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string;
  boFlag: Boolean);
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    m_boAdminMode := boFlag;
    if m_boAdminMode then
      SysMsg(sGameMasterMode, c_Green, t_Hint)
    else
      SysMsg(sReleaseGameMasterMode, c_Green, t_Hint);
  end;
end;

//调试命令

procedure CmdClearBagItem(PlayObject: TPlayObject; Cmd: pTGameCmd; sHumanName: string);
var
  i: Integer;
  TempPlayObject: TPlayObject;
  UserItem: pTUserItem;
  DelList: TStringList;
  StdItem: pTStdItem;
begin
  with PlayObject do begin
    DelList := nil;
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, 'UserName']), c_Red, t_Hint);
      Exit;
    end;

    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;

    for i := 0 to TempPlayObject.m_ItemList.Count - 1 do begin
      UserItem := TempPlayObject.m_ItemList.Items[i];
      if DelList = nil then
        DelList := TStringList.Create;
      DelList.AddObject(IntToStr(UserItem.wIndex), TObject(UserItem.MakeIndex));
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (Stditem.NeedIdentify = 1) then
        AddGameLog(PlayObject, LOG_DELITEM, Stditem.Name, Useritem.MakeIndex, Useritem.Dura, '0',
          'ClearBag', '0', 'Command', Useritem);
      DisPose(UserItem);
    end;
    TempPlayObject.m_ItemList.Clear;
    if DelList <> nil then begin
      TempPlayObject.SendMsg(TempPlayObject, RM_SENDDELITEMLIST, 0, Integer(DelList), 0, 0, '');
    end;
  end;
end;

procedure CmdShowEffect(PlayObject: TPlayObject; Cmd: pTGameCmd; nEffectID: Integer);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if nEffectID <= 0 then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, 'Effect#']), c_Red, t_Hint);
      Exit;
    end;
    SendRefMsg(RM_SHOWEFFECT, nEffectID, Integer(PlayObject), m_nCurrX, m_nCurrY, '');
  end;
end;

procedure CmdOpenBox(PlayObject: TPlayObject; Cmd: pTGameCmd; nEffectID: Integer);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if nEffectID < 0 then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, 'ChestID']), c_Red, t_Hint);
      Exit;
    end;
    PlayObject.OpenBox(nEffectID, False);
  end;
end;

procedure CmdShowMap(PlayObject: TPlayObject; sMAP, sX, sY: string);
var
  Map: TEnvirnoment;
  nX, nY: Integer;
  MapCellInfo: pTMapCellinfo;
begin
  with PlayObject do begin
    nX := StrToIntDef(sX, 0);
    nY := StrToIntDef(sY, 0);
    if (sMAP <> '') and (nX >= 0) and (nY >= 0) then begin
      Map := g_MapManager.FindMap(sMAP);
      if Map <> nil then begin
        if Map.GetMapCellInfo(nX, nY, MapCellInfo) then begin
          SysMsg('Mark: ' + IntToStr(MapCellInfo.chFlag), c_Green, t_Hint);
          if MapCellInfo.ObjList <> nil then begin
            SysMsg('# Of Objects: ' + IntToStr(MapCellInfo.ObjList.Count), c_Green, t_Hint);
          end;
        end
        else begin
          SysMsg('Failed to fetch map objects: ' + sMAP, c_Red, t_Hint);
        end;
      end;
    end
    else begin
      SysMsg('Enter it in the correct format: ' + g_GameCommand.MAPINFO.sCmd + ' Map# X Y', c_Green, t_Hint);
    end;
  end;
end;

procedure CmdTestStatus(PlayObject: TPlayObject; sCmd: string; nType, nTime: Integer);
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (not (nType in [Low(TStatusTime)..High(TStatusTime)])) or (nTime < 0) then begin
      SysMsg('Usage: @' + sCmd + ' Type(0..11) time', c_Red, t_Hint);
      Exit;
    end;
    m_wStatusTimeArr[nType] := nTime;
    m_dwStatusArrTick[nType] := GetTickCount();
    m_nCharStatus := GetCharStatus();
    StatusChanged();
    SysMsg(format('status change type:%d total time: %d seconds', [nType, nTime]), c_Green, t_Hint);
  end;
end;

procedure CmdTestFire(PlayObject: TPlayObject; sCmd: string; nRange, nType, nTime, nPoint: Integer);
var
  nX, nY: Integer;
  FireBurnEvent: TFireBurnEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
begin
  with PlayObject do begin
    nMinX := m_nCurrX - nRange;
    nMaxX := m_nCurrX + nRange;
    nMinY := m_nCurrY - nRange;
    nMaxY := m_nCurrY + nRange;
    for nX := nMinX to nMaxX do begin
      for nY := nMinY to nMaxY do begin
        if ((nX < nMaxX) and (nY = nMinY)) or
          ((nY < nMaxY) and (nX = nMinX)) or
          (nX = nMaxX) or (nY = nMaxY) then begin
          FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
          g_EventManager.AddEvent(FireBurnEvent);
        end;
      end;
    end;
  end;
end;

procedure CmdFireBurn(PlayObject: TPlayObject; nInt, nTime, nN: Integer);
var
  FireBurnEvent: TFireBurnEvent;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if (nInt = 0) or (nTime = 0) or (nN = 0) then begin
      SysMsg('Usage: @' + g_GameCommand.FIREBURN.sCmd + ' type time damage', c_Red, t_Hint);
      Exit;
    end;
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, m_nCurrX, m_nCurrY, nInt, nTime, nN);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
end;

procedure CmdChangeZenFastStep(PlayObject: TPlayObject; sCmd, sFastStep: string);
var
  nFastStep: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    nFastStep := StrToIntDef(sFastStep, -1);
    if (sFastStep = '') or (nFastStep < 1) or ((sFastStep <> '') and (sFastStep[1] = '?')) then begin
      SysMsg('Usage: @' + sCmd + ' Speed', c_Red, t_Hint);
      Exit;
    end;
    g_Config.nZenFastStep := nFastStep;
    SysMsg(format('Monster run speed: %d', [nFastStep]), c_Green, t_Hint);
  end;
end;

procedure CmdChangeUserFull(PlayObject: TPlayObject; sCmd, sUserCount: string);
var
  nCount: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    nCount := StrToIntDef(sUserCount, -1);
    if (sUserCount = '') or (nCount < 1) or ((sUserCount <> '') and (sUserCount[1] = '?')) then begin
      SysMsg('usage: @' + sCmd + ' count', c_Red, t_Hint);
      Exit;
    end;
    g_Config.nUserFull := nCount;
    SysMsg(format('maximum usercount changed to: %d', [nCount]), c_Green, t_Hint);
  end;
end;

procedure CmdBackStep(PlayObject: TPlayObject; sCmd: string; nType, nCount: Integer);
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    nType := _MIN(nType, 8);
    if nType = 0 then begin
      CharPushed(GetBackDir(m_btDirection), nCount);
    end
    else begin
      CharPushed(Random(nType), nCount);
    end;
  end;
end;

procedure CmdReloadLineNotice(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    if LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then begin
      SysMsg(g_sGameCommandReloadLineNoticeSuccessMsg, c_Green, t_Hint);
    end
    else begin
      SysMsg(g_sGameCommandReloadLineNoticeFailMsg, c_Red, t_Hint);
    end;
    if LoadLineHint(g_Config.sNoticeDir + 'LineHint.txt') then begin
      SysMsg('Reloaded line notice...', c_Green, t_Hint);
    end
    else begin
      SysMsg('Line notice reload failure.', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdReloadBannedApps(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    if LoadBannedAppList(g_Config.sEnvirDir + 'BannedApps.txt') then begin
      SysMsg(g_sGameCommandReloadBannedAppsSuccessMsg, c_Green, t_Hint);
    end
    else begin
      SysMsg(g_sGameCommandReloadBannedAppsFailMsg, c_Red, t_Hint);
    end;
  end;
end;

procedure CmdReloadGuild(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
var
  Guild: TGUild;
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sParam1 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd,
        g_sGameCommandReloadGuildHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    if nServerIndex <> 0 then begin
      SysMsg(g_sGameCommandReloadGuildOnMasterserver, c_Red, t_Hint);
      Exit;
    end;
    Guild := g_GuildManager.FindGuild(sParam1);
    if Guild = nil then begin
      SysMsg(format(g_sGameCommandReloadGuildNotFoundGuildMsg, [sParam1]), c_Red,
        t_Hint);
      Exit;
    end;
    Guild.LoadGuild();
    Guild.initialize;
    SysMsg(format(g_sGameCommandReloadGuildSuccessMsg, [sParam1]), c_Red, t_Hint);
  end; 
end;

procedure CmdReloadMonItems(PlayObject: TPlayObject);
var
  i: Integer;
  Monster: pTMonInfo;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    try
      for i := 0 to UserEngine.MonsterList.Count - 1 do begin
        Monster := UserEngine.MonsterList.Items[i];
        Monster.ItemList := nil;
        FrmDB.LoadMonitems(Monster.sName, Monster.ItemList);
      end;
      SysMsg('Reloaded mob items....', c_Green, t_Hint);
      //SysMsg('请勿频繁使用该命令，会造成内存增长.', c_Green, t_Hint);
    except
      SysMsg('Monster items reload failure！', c_Green, t_Hint);
    end;
  end;
end;

procedure CmdReloadRobot(PlayObject: TPlayObject);
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    RobotManage.RELOADROBOT();
    SysMsg('Robot reloaded...', c_Green, t_Hint);
  end;
end;

procedure CmdReloadRobotManage(PlayObject: TPlayObject);
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if g_RobotNPC <> nil then begin
      g_RobotNPC.ClearScript();
      g_RobotNPC.LoadNpcScript();
      RobotManage.RELOADROBOT();
      SysMsg('Robot Manage reloaded...', c_Green, t_Hint);
    end
    else begin
      SysMsg('Failed to reload Robot Manage...', c_Green, t_Hint);
    end;
  end;
end;

procedure CmdReloadManage(PlayObject: TPlayObject; Cmd: pTGameCmd; sParam: string);
begin
  with PlayObject do begin
    if (m_btPermission < Cmd.nPermissionMin) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam <> '') and (sParam[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [Cmd.sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    if sParam = '' then begin
      if g_ManageNPC <> nil then begin
        g_ManageNPC.ClearScript();
        g_ManageNPC.LoadNpcScript();
        SysMsg('QManage Reloaded...', c_Green, t_Hint);
      end
      else begin
        SysMsg('QManage Error please check QManage.txt...', c_Green, t_Hint);
      end;
    end
    else begin
      if g_FunctionNPC <> nil then begin
        g_FunctionNPC.ClearScript();
        g_FunctionNPC.LoadNpcScript();
        SysMsg('QFunction reloaded...', c_Green, t_Hint);
      end
      else begin
        SysMsg('QFunction Error please check QFunction.txt...', c_Green, t_Hint);
      end;
    end;
  end;
end;

procedure CmdReloadNpc(PlayObject: TPlayObject; sParam: string);
var
  i: Integer;
  TmpList: TList;
  Merchant: TMerchant;
  NPC: TNormNpc;
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    if CompareText('all', sParam) = 0 then begin
      FrmDB.ReLoadMerchants();
      UserEngine.ReloadMerchantList();
      UserEngine.ReloadNpcList();
      SysMsg('NPCs reloaded..', c_Red, t_Hint);
      Exit;
    end;
    TmpList := TList.Create;
    if UserEngine.GetMerchantList(m_PEnvir, m_nCurrX, m_nCurrY, 9, TmpList) > 0 then begin
      for i := 0 to TmpList.Count - 1 do begin
        Merchant := TMerchant(TmpList.Items[i]);
        Merchant.ClearScript;
        Merchant.LoadNpcScript;
        SysMsg(Merchant.m_sCharName + 'Reload successfull...', c_Green, t_Hint);
      end; // for
    end
    else begin
      SysMsg('No nearby NPCs.', c_Red, t_Hint);
    end;
    TmpList.Clear;
    if UserEngine.GetNpcList(m_PEnvir, m_nCurrX, m_nCurrY, 9, TmpList) > 0 then begin
      for i := 0 to TmpList.Count - 1 do begin
        NPC := TNormNpc(TmpList.Items[i]);
        NPC.ClearScript;
        NPC.LoadNpcScript;
        SysMsg(NPC.m_sCharName + 'Reload succsessfull...', c_Green, t_Hint);
      end; // for
    end
    else begin
      SysMsg('No nearby NPCs.', c_Red, t_Hint);
    end;
    TmpList.Free;
  end;
end;

procedure CmdReLoadAdmin(PlayObject: TPlayObject; sCmd: string);
begin
  with PlayObject do begin
    if (m_btPermission < 6) then
      Exit;
    FrmDB.LoadAdminList();
    SysMsg('Admin list reloaded...', c_Green, t_Hint);
  end;
end;

procedure CmdLotteryTicket(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sParam1 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    SysMsg(format(g_sGameCommandLotteryTicketMsg, [g_Config.nWinLotteryCount,
      g_Config.nNoWinLotteryCount,
        g_Config.nWinLotteryLevel1,
        g_Config.nWinLotteryLevel2,
        g_Config.nWinLotteryLevel3,
        g_Config.nWinLotteryLevel4,
        g_Config.nWinLotteryLevel5,
        g_Config.nWinLotteryLevel6]), c_Green, t_Hint);
  end;
end;

procedure CmdDelNpc(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1: string);
var
  BaseObject: TBaseObject;
  i: Integer;
resourcestring
  sDelOK = 'NPC Deleted...';
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, '']), c_Red, t_Hint);
      Exit;
    end;
    BaseObject := GetPoseCreate();
    if BaseObject <> nil then begin
      for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
        if TBaseObject(UserEngine.m_MerchantList.Items[i]) = BaseObject then begin
          BaseObject.MakeGhost;
          SysMsg(sDelOK, c_Red, t_Hint);
          Exit;
        end;
      end;
      for i := 0 to UserEngine.QuestNPCList.Count - 1 do begin
        if TBaseObject(UserEngine.QuestNPCList.Items[i]) = BaseObject then begin
          BaseObject.MakeGhost;
          SysMsg(sDelOK, c_Red, t_Hint);
          Exit;
        end;
      end;
    end;
    SysMsg(g_sGameCommandDelNpcMsg, c_Red, t_Hint);
  end;
end;

procedure CmdMobNpc(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sParam1, sParam2, sParam3,
  sParam4: string);
var
  nAppr: Integer;
  boIsCastle: Boolean;
  Merchant: TMerchant;
  nX, nY: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sParam1 = '') or (sParam2 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, g_sGameCommandMobNpcHelpMsg]), c_Red, t_Hint);
      Exit;
    end;

    nAppr := StrToIntDef(sParam3, 0);
    boIsCastle := (StrToIntDef(sParam4, 0) = 1);
    if sParam1 = '' then begin
      SysMsg('Usage: @' + sCmd + ' Name ScriptName Shape(Appr) Case Shacheng(0,1)', c_Red, t_Hint);
      Exit;
    end;
    Merchant := TMerchant.Create;
    Merchant.m_sCharName := sParam1;
    Merchant.m_sMapName := m_sMapName;
    Merchant.m_PEnvir := m_PEnvir;
    Merchant.m_wAppr := nAppr;
    Merchant.m_nFlag := 0;
    Merchant.m_boCastle := boIsCastle;
    Merchant.m_sScript := sParam2;
    GetFrontPosition(nX, nY);
    Merchant.m_nCurrX := nX;
    Merchant.m_nCurrY := nY;
    Merchant.Initialize();
    UserEngine.AddMerchant(Merchant);
  end;
end;

procedure CmdShowHumanFlag(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sHumanName, sFlag: string);
var
  TempPlayObject: TPlayObject;
  nFlag: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd, g_sGameCommandShowHumanFlagHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    TempPlayObject := UserEngine.GetPlayObject(sHumanName);
    if TempPlayObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer, [sHumanName]), c_Red, t_Hint);
      Exit;
    end;
    nFlag := StrToIntDef(sFlag, 0);
    m_boTestSpeedMode := True;
    if TempPlayObject.GetQuestFlagStatus(nFlag) = 1 then begin
      SysMsg(format(g_sGameCommandShowHumanFlagONMsg, [TempPlayObject.m_sCharName, nFlag]), c_Green, t_Hint);
    end
    else begin
      SysMsg(format(g_sGameCommandShowHumanFlagOFFMsg, [TempPlayObject.m_sCharName, nFlag]), c_Green, t_Hint);
    end;
  end;
end;

//用户普通命令

procedure CmdMemberFunctionEx(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Open the help function window.', c_Red, t_Hint);
      Exit;
    end;
    NpcGotoLable(g_FunctionNPC, g_FunctionNPC.FGotoLable[nMember], False);
  end;
end;

procedure CmdMemberFunction(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Open member function window.', c_Red, t_Hint);
      Exit;
    end;
    NpcGotoLable(g_ManageNPC, g_ManageNPC.FGotoLable[nMember], False);
  end;
end;

procedure CmdAllSysMsg(PlayObject: TPlayObject; sParam: string);
var
  AmuletStdItem: pTStdItem;
begin
  try
    with PlayObject do begin
      if (m_UseItems[U_CIMELIA].wIndex > 0) and (m_UseItems[U_CIMELIA].Dura > 0) then begin
        AmuletStdItem := UserEngine.GetStdItem(m_UseItems[U_CIMELIA].wIndex);
        if (AmuletStdItem.StdMode = tm_Cowry) and (AmuletStdItem.Shape = 0) then begin
          if m_UseItems[U_CIMELIA].Dura > 1000 then begin
            Dec(m_UseItems[U_CIMELIA].Dura, 1000);
            DuraChange(U_CIMELIA, m_UseItems[U_CIMELIA].Dura,
              m_UseItems[U_CIMELIA].DuraMax);
          end
          else begin
            m_UseItems[U_CIMELIA].Dura := 0;
            SendDelItems(@m_UseItems[U_CIMELIA]);
            m_UseItems[U_CIMELIA].wIndex := 0;
          end;
          if sParam <> '' then
            UserEngine.SendBroadBugleMsg(m_sCharName + #9 + GetItemInfo(sParam));
        end;
      end;
    end;
  except
    MainOutMessage('[Exception] TPlayObject.CmdAllSysMsg');
  end;
end;

procedure CmdTakeOffHorse(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Mount is unavailable.', c_Red, t_Hint);
      SysMsg(format('Remaining time until available: @%s', [sCmd]), c_Red, t_Hint);
      Exit;
    end;
    if not m_boOnHorse then
      Exit;
    ChangeHorseState(False);
  end;
end;

procedure CmdTakeOnHorse(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Mount is unavailable.', c_Red, t_Hint);
      SysMsg(format('Remaining time until available: @%s', [sCmd]), c_Red, t_Hint);
      Exit;
    end;
    if m_boOnHorse then
      Exit;
    if m_boShoping then begin
      SysMsg('Close your stall before riding mount.', c_Red, t_Hint);
      Exit;
    end;
    if (m_btHorseType = 0) then begin
      SysMsg('Please equip a mount first.', c_Red, t_Hint);
      Exit;
    end;
    ChangeHorseState(True);
  end;
end;

procedure CmdMasterRecall(PlayObject: TPlayObject; sCmd, sParam: string);
var
  i: Integer;
  Human: TPlayObject;
  boSend: Boolean;
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Usage: @' + sCmd + ' (StudentName)', c_Green, t_Hint);
      Exit;
    end;
    if m_MasterList.Count <= 0 then begin
      SysMsg('No students found..', c_Red, t_Hint);
      Exit;
    end;
    if not m_boMaster then begin
      SysMsg('This command is only available to Masters..', c_Red, t_Hint);
      Exit;
    end;
    if m_PEnvir.m_boNOMASTERRECALL then begin
      SysMsg('Can not use this command on this map.', c_Red, t_Hint);
      Exit;
    end;
    if GetTickCount - m_dwMasterRecallTick < 10000 then begin
      SysMsg('Recall is cooling down, please wait.', c_Red, t_Hint);
      Exit;
    end;
    m_dwMasterRecallTick := GetTickCount;
    boSend := False;
    for i := 0 to m_MasterList.Count - 1 do begin
      Human := TPlayObject(m_MasterList.Objects[I]);
      if Human = nil then Continue;
      boSend := True;
      if Human.m_boGhost or Human.m_boDeath or (not Human.m_boMapApoise) then begin
        SysMsg('Student ' + m_MasterList[0] + ' not avilable for recall.', c_Red, t_Hint);
        Exit;
      end;
      if Human.m_boCanMasterRecall then RecallHuman(Human)
      else SysMsg('Cannot recall ' + Human.m_sCharName, c_Red, t_Hint);
    end;
    if not boSend then
      SysMsg('Recall failed!', c_Red, t_Hint);
  end;
end;

procedure CmdSearchMaster(PlayObject: TPlayObject; sCmd, sParam: string);
var
  i: Integer;
  Human: TPlayObject;
  boSend: Boolean;
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Not Available', c_Red, t_Hint);
      Exit;
    end;
    if m_MasterList.Count <= 0 then begin
      SysMsg(g_sYouAreNotMasterMsg, c_Red, t_Hint);
      Exit;
    end;
    if m_boMaster then begin
      boSend := False;
      for I := 0 to m_MasterList.Count - 1 do begin
        Human := TPlayObject(m_MasterList.Objects[I]);
        if Human = nil then break;
        SysMsg(AnsiReplaceText(g_sYourMasterListNowLocateMsg, '%d', m_MasterList[I]) , c_Green, t_Hint);
        SysMsg(Human.m_PEnvir.sMapDesc + '(' + IntToStr(Human.m_nCurrX) + ',' + IntToStr(Human.m_nCurrY) + ')', c_Green, t_Hint);
        Human.SysMsg(AnsiReplaceText(g_sYourMasterSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
        Human.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);
        boSend := True;
      end;
      if not boSend then
        SysMsg(g_sYourMasterListNotOnlineMsg, c_Red, t_Hint);
    end else begin
      if m_MasterList.Objects[0] = nil then begin
        SysMsg(g_sYourMasterNotOnlineMsg, c_Red, t_Hint);
        Exit;
      end;
      Human := TPlayObject(m_MasterList.Objects[0]);
      SysMsg(AnsiReplaceText(g_sYourMasterNowLocateMsg, '%d', m_MasterList[0]) , c_Green, t_Hint);
      SysMsg(Human.m_PEnvir.sMapDesc + '(' + IntToStr(Human.m_nCurrX) + ',' + IntToStr(Human.m_nCurrY) + ')', c_Green, t_Hint);
      Human.SysMsg(AnsiReplaceText(g_sYourMasterListSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
      Human.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);
    end;
    (*if m_boMaster then begin

    end else begin
      if m_MasterName[0] = '' then begin
        SysMsg(g_sYouAreNotMasterMsg, c_Red, t_Hint);
        Exit;
      end;
      if m_MasterHuman = nil then begin
        SysMsg(g_sYourMasterNotOnlineMsg, c_Red, t_Hint);
        Exit;
      end;
      SysMsg(AnsiReplaceText(g_sYourMasterNowLocateMsg, '%d', m_MasterName[0]) , c_Green, t_Hint);
      SysMsg(m_MasterHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_MasterHuman.m_nCurrX) + ',' + IntToStr(m_MasterHuman.m_nCurrY) + ')', c_Green, t_Hint);
      m_MasterHuman.SysMsg(AnsiReplaceText(g_sYourMasterListSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
      m_MasterHuman.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);
    end;         *)
    (*if m_MasterName[0] = '' then begin
      SysMsg(g_sYouAreNotMasterMsg, c_Red, t_Hint);
      Exit;
    end;
    if m_MasterHuman = nil then begin
      if m_boMaster then SysMsg(g_sYourMasterListNotOnlineMsg, c_Red, t_Hint)
      else SysMsg(g_sYourMasterNotOnlineMsg, c_Red, t_Hint);
      Exit;
    end;
    if m_boMaster then begin
      SysMsg(AnsiReplaceText(g_sYourMasterListNowLocateMsg, '%d', m_sMasterName) , c_Green, t_Hint);
      SysMsg(m_MasterHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_MasterHuman.m_nCurrX) + ',' + IntToStr(m_MasterHuman.m_nCurrY) + ')', c_Green, t_Hint);
      m_MasterHuman.SysMsg(AnsiReplaceText(g_sYourMasterSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
      m_MasterHuman.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);

    end else begin
      SysMsg(AnsiReplaceText(g_sYourMasterNowLocateMsg, '%d', m_MasterName[0]) , c_Green, t_Hint);
      SysMsg(m_MasterHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_MasterHuman.m_nCurrX) + ',' + IntToStr(m_MasterHuman.m_nCurrY) + ')', c_Green, t_Hint);
      m_MasterHuman.SysMsg(AnsiReplaceText(g_sYourMasterListSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
      m_MasterHuman.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);

    end; *)
  end;
end;

procedure CmdDearRecall(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Usage: @' + sCmd + ' (recalls your spouse to you)', c_Green, t_Hint);
      Exit;
    end;
    if m_sDearName = '' then begin
      SysMsg(g_sYouAreNotMarryedMsg, c_Red, t_Hint);
      Exit;
    end;
    if m_PEnvir.m_boNODEARRECALL then begin
      SysMsg('Cannot recall to this map.', c_Red, t_Hint);
      Exit;
    end;

    if m_DearHuman = nil then begin
      if m_btGender = 0 then begin
        SysMsg(g_sYourWifeNotOnlineMsg, c_Red, t_Hint);
      end
      else begin
        SysMsg(g_sYourHusbandNotOnlineMsg, c_Red, t_Hint);
      end;
      Exit;
    end;
    if m_DearHuman.m_boGhost or m_DearHuman.m_boDeath or (not m_DearHuman.m_boMapApoise) then begin
      if m_btGender = 0 then begin
        SysMsg('Your wife is not ready.', c_Red, t_Hint);
      end
      else begin
        SysMsg('Your husband is not ready.', c_Red, t_Hint);
      end;
      Exit;
    end;
    if GetTickCount - m_dwDearRecallTick < 10000 then begin
      SysMsg('recall not ready, wait longer.', c_Red, t_Hint);
      Exit;
    end;
    m_dwDearRecallTick := GetTickCount();
    if m_DearHuman.m_boCanDearRecall then begin
      RecallHuman(m_DearHuman);
    end
    else begin
      SysMsg(m_DearHuman.m_sCharName + ' does not allow recall.', c_Red, t_Hint);
      Exit;
    end;
  end;
end;

procedure CmdSearchDear(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('helps you find your spouse''s location', c_Red, t_Hint);
      Exit;
    end;
    if m_sDearName = '' then begin
      SysMsg(g_sYouAreNotMarryedMsg {'你都没结婚查什么？'}, c_Red, t_Hint);
      Exit;
    end;
    if m_DearHuman = nil then begin
      if m_btGender = 0 then begin
        SysMsg(g_sYourWifeNotOnlineMsg {'你的老婆还没有上线.'}, c_Red, t_Hint);
      end
      else begin
        SysMsg(g_sYourHusbandNotOnlineMsg {'你的老公还没有上线.'}, c_Red, t_Hint);
      end;
      Exit;
    end;

    if m_btGender = 0 then begin
      SysMsg(AnsiReplaceText(g_sYourWifeNowLocateMsg, '%d', m_DearHuman.m_sCharName) {'你的老婆现在位于:'}, c_Green, t_Hint);
      SysMsg(m_DearHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_DearHuman.m_nCurrX) + ',' + IntToStr(m_DearHuman.m_nCurrY) + ')', c_Green, t_Hint);
      m_DearHuman.SysMsg(AnsiReplaceText(g_sYourHusbandSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
      m_DearHuman.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);
    end
    else begin
      SysMsg(AnsiReplaceText(g_sYourHusbandNowLocateMsg, '%d', m_DearHuman.m_sCharName), c_Green, t_Hint);
      SysMsg(m_DearHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_DearHuman.m_nCurrX) + ',' + IntToStr(m_DearHuman.m_nCurrY) + ')', c_Green, t_Hint);
      m_DearHuman.SysMsg(AnsiReplaceText(g_sYourWifeSearchLocateMsg, '%s', m_sCharName), c_Green, t_Hint);
      m_DearHuman.SysMsg(m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ',' + IntToStr(m_nCurrY) + ')', c_Green, t_Hint);
    end;
  end;
end;

procedure CmdGuildRecall(PlayObject: TPlayObject; sCmd, sParam: string);
var
  i, ii: Integer;
  dwValue: LongWord;
  RecallPlayObject: TPlayObject;
  GuildRank: pTGuildRank;
  nRecallCount, nNoRecallCount: Integer;
  Castle: TUserCastle;
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('Usage: recalls your guild to you', c_Red, t_Hint);
      Exit;
    end;

    if not m_boGuildMove and (m_btPermission < 6) then begin
      SysMsg('Not allowed to use this command.', c_Red, t_Hint);
      Exit;
    end;
    if not IsGuildMaster then begin
      SysMsg('Only guild masters can recall.', c_Red, t_Hint);
      Exit;
    end;
    if m_PEnvir.m_boNOGUILDRECALL then begin
      SysMsg('Cannot recall guild on this map.', c_Red, t_Hint);
      Exit;
    end;
    Castle := g_CastleManager.InCastleWarArea(PlayObject);

    if (Castle <> nil) and Castle.m_boUnderWar then begin
      SysMsg('Cannot recall to castle during war periods.', c_Red, t_Hint);
      Exit;
    end;
    nRecallCount := 0;
    nNoRecallCount := 0;
    dwValue := (GetTickCount - m_dwGroupRcallTick) div 1000;
    m_dwGroupRcallTick := m_dwGroupRcallTick + dwValue * 1000;
    if m_btPermission >= 6 then
      m_wGroupRcallTime := 0;
    if m_wGroupRcallTime > dwValue then begin
      Dec(m_wGroupRcallTime, dwValue);
    end
    else
      m_wGroupRcallTime := 0;

    if m_wGroupRcallTime > 0 then begin
      SysMsg(format('%d seconds left till next recall.', [m_wGroupRcallTime]), c_Red, t_Hint);
      Exit;
    end;

    for i := 0 to TGuild(m_MyGuild).m_RankList.Count - 1 do begin
      GuildRank := TGuild(m_MyGuild).m_RankList.Items[i];
      if GuildRank = nil then Continue;
      for ii := 0 to GuildRank.MembersList.Count - 1 do begin
        RecallPlayObject := TPlayObject(pTGuildUserInfo(GuildRank.MembersList.Objects[ii]).PlayObject);
        if RecallPlayObject <> nil then begin
          if RecallPlayObject = PlayObject then begin
            Continue;
          end;
          if RecallPlayObject.m_boAllowGuildReCall then begin
            if RecallPlayObject.m_boGhost or RecallPlayObject.m_boDeath or (not RecallPlayObject.m_boMapApoise) then begin
              SysMsg(format('#7%s#7 is not available for recall.', [RecallPlayObject.m_sCharName]), c_Red, t_Hint);
            end else
            if RecallPlayObject.m_PEnvir.m_boNORECALL then begin
              SysMsg(format('#7%s#7 cannot be recalled from his map', [RecallPlayObject.m_sCharName]), c_Red, t_Hint);
            end
            else begin
              RecallHuman(RecallPlayObject);
              Inc(nRecallCount);
            end;
          end
          else begin
            Inc(nNoRecallCount);
            SysMsg(format('#7%s#7 has disabled guild recall.', [RecallPlayObject.m_sCharName]), c_Red, t_Hint);
          end;
        end;
      end;
    end;
    SysMsg(format('recalled %d members, failed to recall %d members', [nRecallCount, nNoRecallCount]), c_Green, t_Hint);
    m_dwGroupRcallTick := GetTickCount();
    m_wGroupRcallTime := g_Config.nGuildRecallTime;
  end;
end;

procedure CmdGroupRecall(PlayObject: TPlayObject; sCmd: string);
var
  i: Integer;
  dwValue: LongWord;
  RecallPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if m_boRecallSuite{ or (m_btPermission >= 6)} then begin
      if not m_PEnvir.m_boNORECALL then begin
        dwValue := (GetTickCount - m_dwGroupRcallTick) div 1000;
        m_dwGroupRcallTick := m_dwGroupRcallTick + dwValue * 1000;
        //if m_btPermission >= 6 then
          //m_wGroupRcallTime := 0;

        if m_wGroupRcallTime > dwValue then begin
          Dec(m_wGroupRcallTime, dwValue);
        end
        else
          m_wGroupRcallTime := 0;
        if m_wGroupRcallTime = 0 then begin
          if m_GroupOwner = PlayObject then begin
            for i := 1 to m_GroupMembers.Count - 1 do begin
              RecallPlayObject := TPlayObject(m_GroupMembers.Objects[i]);
              if RecallPlayObject.m_boAllowGroupReCall then begin
                if RecallPlayObject.m_boGhost or RecallPlayObject.m_boDeath or (not RecallPlayObject.m_boMapApoise) then begin
                  SysMsg(format('#7%s#7 is not available for recall.', [RecallPlayObject.m_sCharName]), c_Red, t_Hint);
                end else
                if RecallPlayObject.m_PEnvir.m_boNORECALL then begin
                  SysMsg(format('#7%s#7 cannot be recalled from his map.', [RecallPlayObject.m_sCharName]), c_Red, t_Hint);
                end
                else begin
                  RecallHuman(RecallPlayObject.m_sCharName);
                end;
              end
              else begin
                SysMsg(format('#7%s#7 has disabled group recall.', [RecallPlayObject.m_sCharName]), c_Red, t_Hint);
              end;
            end;
            m_dwGroupRcallTick := GetTickCount();
            m_wGroupRcallTime := g_Config.nGroupRecallTime;
          end else
            SysMsg('Only group leaders can recall.', c_Red, t_Hint);
        end
        else begin
          SysMsg(format('%d seconds left till next recall.', [m_wGroupRcallTime]), c_Red, t_Hint);
        end;
      end
      else begin
        SysMsg('Cannot recall to this map.', c_Red, t_Hint);
      end;
    end
    else begin
      SysMsg('Missing recallset.', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdAllowGroupReCall(PlayObject: TPlayObject; sCmd, sParam: string);
begin
  with PlayObject do begin
    if (sParam <> '') and (sParam[1] = '?') then begin
      SysMsg('enables/disables group recall', c_Red, t_Hint);
      Exit;
    end;
    m_boAllowGroupReCall := not m_boAllowGroupReCall;
    SetIntStatus(PlayObject.m_nAllowSetup, GPS_GROUPRECALL, m_boAllowGroupReCall);
    if m_boAllowGroupReCall then
      //SendDefMessage(SM_GROUPMODECHANGED, Integer(m_nAllowSetup), 0, 0, 0, g_sEnableGroupRecall)
      SysMsg(g_sEnableGroupRecall {'[允许天地合一]'}, c_Green, t_Hint)
    else
      //SendDefMessage(SM_GROUPMODECHANGED, Integer(m_nAllowSetup), 0, 0, 0, g_sDisableGroupRecall);
      SysMsg(g_sDisableGroupRecall {'[禁止天地合一]'}, c_Green, t_Hint);
  end;
end;

procedure CmdSearchHuman(PlayObject: TPlayObject; sCmd, sHumanName: string);
var
  SearchPlayObject: TPlayObject;
begin
  with PlayObject do begin
    if m_boProbeNecklace or (m_btPermission >= 6) then begin
      if (sHumanName = '') then begin
        SysMsg('Usage: @' + sCmd + ' Username', c_Red, t_Hint);
        Exit;
      end;
      if ((GetTickCount - m_dwProbeTick) > 10000) or (m_btPermission >= 3) then begin
        m_dwProbeTick := GetTickCount();
        SearchPlayObject := UserEngine.GetPlayObject(sHumanName);
        if SearchPlayObject <> nil then begin
          SysMsg(sHumanName + ' is located at ' + SearchPlayObject.m_PEnvir.sMapDesc + ' ' +
            IntToStr(SearchPlayObject.m_nCurrX) + ':' + IntToStr(SearchPlayObject.m_nCurrY), c_Blue, t_Hint);
        end
        else begin
          SysMsg(sHumanName + ' is not online.', c_Red, t_Hint);
        end;
      end
      else begin
        SysMsg(IntToStr((GetTickCount - m_dwProbeTick) div 1000 - 10) + ' seconds before you can search again.', c_Red, t_Hint);
      end;
    end
    else begin
      SysMsg('You cannot use this.', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdUserMoveXY(PlayObject: TPlayObject; sCmd, sX, sY: string; boTopShow: Boolean);
var
  nX, nY: Integer;
begin
  with PlayObject do begin
    if m_boTeleport or m_boTeleportEx then begin
      nX := StrToIntDef(sX, -1);
      nY := StrToIntDef(sY, -1);
      if not m_PEnvir.m_boNOPOSITIONMOVE then begin
        if m_PEnvir.CanWalkOfItem(nX, nY, g_Config.boUserMoveCanDupObj, g_Config.boUserMoveCanOnItem) then begin
          if (GetTickCount - m_dwTeleportTick) > g_Config.dwUserMoveTime * 1000 then begin
            m_dwTeleportTick := GetTickCount();
            if (not m_boTeleport) and (m_UseItems[U_BUJUK].wIndex > 0) and (m_UseItems[U_BUJUK].Dura > 0) then begin //增加传送符功能
              if m_UseItems[U_BUJUK].Dura > 1 then begin
                Dec(m_UseItems[U_BUJUK].Dura, 1);
              end
              else begin
                m_UseItems[U_BUJUK].Dura := 0;
              end;
              DuraChange(U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax);
              //SendMsg(Self, RM_aDURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
              SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
              SpaceMove(m_PEnvir, nX, nY, 0);
              Exit;
            end;
            SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            //BaseObjectMove('',sX,sY);
            SpaceMove(m_PEnvir, nX, nY, 0);
          end
          else begin
            if boTopShow then
              SysHintMsg(IntToStr(g_Config.dwUserMoveTime - (GetTickCount - m_dwTeleportTick) div 1000) + ' seconds till next teleport.', c_Red)
            else
              SysMsg(IntToStr(g_Config.dwUserMoveTime - (GetTickCount - m_dwTeleportTick) div 1000) + ' seconds till next teleport.', c_Red, t_Hint);
          end;
        end
        else begin
          if boTopShow then
            SysHintMsg(format('Cannot move to X:%s Y:%s', [sX, sY]), c_Green)
          else
            SysMsg(format('Cannot move to X:%s Y:%s', [sX, sY]), c_Green, t_Hint);
        end;
      end
      else begin
        if boTopShow then
          SysHintMsg('Cannot use on this map.', c_Red)
        else
          SysMsg('Cannot use on this map.', c_Red, t_Hint);
      end;
    end
    else begin
      if boTopShow then
        SysHintMsg('You cannot use this.', c_Red)
      else
        SysMsg('You cannot use this.', c_Red, t_Hint);
    end;
  end;
end;

procedure CmdEndGuild(PlayObject: TPlayObject);
var
 nError : integer;
begin
 nError := 0;
try
  with PlayObject do begin
    nError := 1;
    if (m_MyGuild <> nil) then begin
      nError := 2;
      if (m_nGuildRankNo > 1) then begin
        nError := 3;
        if TGuild(m_MyGuild).IsMember(m_sCharName) and TGuild(m_MyGuild).DelMember(m_sCharName, 1) then begin
          nError := 4;
          m_MyGuild := nil;
          m_sGuildName := '';
          nError := 5;
          RefRankInfo(0, '');
          nError := 6;
          RefShowName(); //10/31
          nError := 7;
          SysMsg('You just left the guild.', c_Green, t_Hint);
        end;
      end
      else begin
        nError := 8;
        SysMsg('Guild leaders cannot leave a guild.', c_Red, t_Hint);
      end;
    end
    else begin
      SysMsg('You are not in a guild.', c_Red, t_Hint);
    end;
  end;
except
  MainOutMessage('EndGuild Error code: ' + inttostr(nError));
end;
end;

procedure CmdPrvMsg(PlayObject: TPlayObject; sCmd: string; nPermission: Integer; sHumanName: string);
var
  i: Integer;
begin
  with PlayObject do begin
    if (m_btPermission < nPermission) then begin
      SysMsg(g_sGameCommandPermissionTooLow, c_Red, t_Hint);
      Exit;
    end;
    if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
      SysMsg(format(g_sGameCommandParamUnKnow, [sCmd,
        g_sGameCommandPrvMsgHelpMsg]), c_Red, t_Hint);
      Exit;
    end;
    for i := m_BlockWhisperList.Count - 1 downto 0 do begin
      if m_BlockWhisperList.Count <= 0 then
        break;
      if CompareText(m_BlockWhisperList.Strings[i], sHumanName) = 0 then begin
        m_BlockWhisperList.Delete(i);
        SysMsg(format(g_sGameCommandPrvMsgUnLimitMsg, [sHumanName]), c_Green, t_Hint);
        Exit;
      end;
    end;
    m_BlockWhisperList.Add(sHumanName);
    SysMsg(format(g_sGameCommandPrvMsgLimitMsg, [sHumanName]), c_Green, t_Hint);
  end;
end;

procedure CmdChangeSalveStatus(PlayObject: TPlayObject);
begin
  with PlayObject do begin
    if m_SlaveList.Count > 0 then begin
      m_boSlaveRelax := not m_boSlaveRelax;
      if m_boSlaveRelax then
        SysMsg(sPetRest, c_Green, t_Hint)
      else
        SysMsg(sPetAttack, c_Green, t_Hint)
    end;
  end;
end;

procedure CmdChangeAttackMode(PlayObject: TPlayObject; nMode: Integer);
begin
  with PlayObject do begin
    if (nMode >= HAM_ALL) and (nMode <= HAM_PKATTACK) then
      m_btAttatckMode := nMode
    else begin
      if m_btAttatckMode < HAM_PKATTACK then
        Inc(m_btAttatckMode)
      else
        m_btAttatckMode := HAM_ALL;
    end;
    case m_btAttatckMode of
      HAM_ALL: SysMsg(sAttackModeOfAll, c_Green, t_Hint); //[攻击模式: 全体攻击]
      HAM_PEACE: SysMsg(sAttackModeOfPeaceful, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_DEAR: SysMsg(sAttackModeOfDear, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_MASTER: SysMsg(sAttackModeOfMaster, c_Green, t_Hint); //[攻击模式: 和平攻击]
      HAM_GROUP: SysMsg(sAttackModeOfGroup, c_Green, t_Hint); //[攻击模式: 编组攻击]
      HAM_GUILD: SysMsg(sAttackModeOfGuild, c_Green, t_Hint); //[攻击模式: 行会攻击]
      HAM_PKATTACK: SysMsg(sAttackModeOfRedWhite, c_Green, t_Hint); //[攻击模式: 红名攻击]
    end;
  end;
end;

end.


