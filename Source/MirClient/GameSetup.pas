unit GameSetup;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Graphics, Grobal2;

const
  HELP_IMAGE_FORM = 660;
  HELP_IMAGE_ARMING = 661;
  
  OS_SHOWNAME = 0; //��ʾ��������
  OS_DURAHINT = 1; //�־þ���
  OS_SHOWMAPHINT = 2; //��ʾ��ͼ��ʶ
  OS_SHOWITEMNAME = 3; //Ctrl��ʾ��Ʒ����
  OS_AUTOPICKUPITEM = 4; //�Զ�����
  OS_EXEMPTSHIFT = 5; //��Shift��
  OS_GETEXPFILTRATE = 6; //�;���ֵ��ȡ����
  OS_MOVEHPSHOW = 7; //�ƶ�ƮѪ��ʾ
  OS_HPPROTECT = 8; //Ѫ������
  OS_MPPROTECT = 9; //ħ��ֵ����
  OS_HPPROTECT2 = 10;
  OS_MPPROTECT2 = 11;
  OS_HPPROTECT3 = 12;
  OS_HIDEAROUNDHUM = 13; //������Χ����
  OS_HIDEALLYHUM = 14; //������������
  OS_HIDEMAGICBEGIN = 15; //���ؼ��ܳ���Ч��
  OS_HIDEMAGICEND = 16; //���ؼ��ܹ���Ч��
  OS_AUTOLONGHIT = 17; //������ɱ
  OS_AUTOWIDEHIT = 18; //����Բ��
  OS_AUTOFIREHIT = 19; //�Զ��һ�
  OS_AUTOSHIELD = 20; //�Զ�����
  OS_AUTOCLOAK = 21; //�Զ�����
  OS_SHOWNAMEALL = 22;
  OS_SHOWNAMEMON = 23;
  OS_SNOWWINDLOCK = 24;
  OS_LONGWIND = 25;
  OS_AUTOLONGICEHIT = 26;
  OS_FIERYDRAGONLOCK = 27;
  
//  OS_HIDEHELMET = 22; //����ͷ����ʾ

  OS_ISSETUP = 31;

  DK_CHANGEMINMAP = 0;
  DK_CHANGEATTACKMODE = 1;
  DK_SLAVEREST = 2;
  DK_PRINTSCREEN = 3;
  DK_APPLOGOUT = 4;
  DK_APPEXIT = 5;
  DK_CREATEGROUP = 6;
  DK_DELGROUPMEMBER = 7;
  DK_ADDTOUSERLIST = 8;
  DK_PICKUP = 9;
  DK_OPENITEMBAG = 10;
  DK_OPENMYSTATUS0 = 11;
  DK_OPENMYSTATUS3 = 12;
  DK_OPENGAMESETUP = 13;
  DK_ONHORSE = 14;
  DK_OPENGROUP = 15;
  DK_OPENGUILD = 16;
  DK_OPENQUEST = 17;
  DK_OPENMAIL = 18;
  DK_STARTTRADE = 19;
  DK_AUTORUN = 20;
  DK_OPTIONDROP = 21;
  DK_OPENLOVER = 22;
  DK_OPENFRIENDS = 23;
  DK_OPENHORSE = 24;
  DK_OPENBIGMAP = 25;
  DK_SKILL1 = 26;
  DK_SKILL2 = 27;
  DK_SKILL3 = 28;
  DK_SKILL4 = 29;
  DK_SKILL5 = 30;
  DK_SKILL6 = 31;
  DK_SKILL7 = 32;
  DK_SKILL8 = 33;
  DK_SKILL9 = 34;
  DK_SKILL10 = 35;
  DK_SKILL11 = 36;
  DK_SKILL12 = 37;
  DK_SKILL13 = 38;
  DK_SKILL14 = 39;
  DK_SKILL15 = 40;
  DK_SKILL16 = 41;
  DK_OPENITEMBAG2 = 42;
  DK_OPENMYSTATUS02 = 43;
  DK_OPENSKILLPAGE = 44;
  //commented these but figured someone might wanna add them i dunno if we should
  //DK_SHOWSKILLBAR = 24;
  //DK_SWITCHSKILLBAR = 25;
  //DK_SWITCHBELT = 26:
  //DK_SHOWBELT = 27;
  //DK_SWITCHFONT = 28;

  DK_MAXHOOKKEYCOUNT =44;


  DG_SAVEDIR = '.\Config\';
  DG_FORMATSTR = '%s\%s\%s\';
  //DG_FILTERITEMNAME = 'Filter.dat';
  //FriendListFile = 'FriendList.txt';
  BagItemsFile = '%s_BagItems.dat';
  BlackListFile = 'BlackList.txt';
  NotepaperFile = 'Notepaper.txt';
  CustomKeyFile = 'CustomKey.ini';
  ItemRuleFile = 'ItemsRule.txt';
  ShiftName = 'ShiftState';
  KeyName = 'Key';

type
  TKeyInfo = record
    Shift: TShiftState;
    Key: Word;
  end;
  pTKeyInfo = ^TKeyInfo;

  TDefKeyInfo = record
    DefKey: TKeyInfo;
    CustomKey: TKeyInfo;
    boLoginGame: Boolean;
    boDuringChat: Boolean;
    KeyHint: string;
  end;
  pTDefKeyInfo = ^TDefKeyInfo;

  TSetupInfo = packed record
    boCustomKey: Boolean; //�����Զ����ݼ�
    //boShowHelmet: Boolean; //�Ƿ���ʾͷ��
    boShowName: Boolean; //��ʾ��������
    boShowNameAll: Boolean;  //ȫ����ʾ
    boShowNameMon: Boolean;  //��������
    boDuraHint: Boolean; //�־þ���
    boShowMapHint: Boolean; //��ʾ��ͼ��ʶ
    boShowItemName: Boolean; //Ctrl��ʾ��Ʒ����
    boAutoPickUpItem: Boolean; //�Զ�����
    boExemptShift: Boolean; //��Shift��
    boGetExpFiltrate: Boolean; //�;���ֵ��ȡ����
    nExpFiltrateCount: Word; //�����������
    boMoveHpShow: Boolean; //�ƶ�ƮѪ��ʾ
    boHpProtect: Boolean; //Ѫ������
    nHpProtectCount: Word;
    dwHpProtectTime: Byte;
    boMpProtect: Boolean; //ħ��ֵ����
    nMpProtectCount: Word;
    dwMpProtectTime: Byte;
    boHpProtect2: Boolean; //����ҩƷ����
    nHpProtectCount2: Word;
    dwHpProtectTime2: Byte;
    boMpProtect2: Boolean; //����ҩƷħ��ֵ����
    nMpProtectCount2: Word;
    dwMpProtectTime2: Byte;
    boHpProtect3: Boolean; //���ᱣ��
    nHpProtectCount3: Word;
    dwHpProtectTime3: Byte;
    btHpProtectIdx: Byte;
    boHideAroundHum: Boolean; //������Χ����
    boHideAllyHum: Boolean; //������������
    boHideMagicBegin: Boolean; //���ؼ��ܳ���Ч��
    boHideMagicEnd: Boolean; //���ؼ��ܹ���Ч��
    boSwitchPoison: Boolean;
  (*boAutoLongHit: Boolean; //������ɱ
    boAutoWideHit: Boolean; //����Բ��
    boAutoFireHit: Boolean; //�Զ��һ�
    boAutoLongIceHit: Boolean; //�Զ�����ն
    boAutoShield: Boolean; //�Զ�����
    boAutoCloak: Boolean; //�Զ�����
    boSnowWindLock: Boolean; //����������
    boFieryDragonLock: Boolean; //������������

    boAutoMagic: Boolean; //�Զ�����
    dwAutoMagicTick: LongWord;
    nAutoMagicIndex: Integer;
    boAutoLongWide: Boolean;     *)

    {boNotDeal: Boolean;
    boNotGroup: Boolean;
    boNotFriend: Boolean;
    boNotGuild: Boolean;  }
  end;

var
  g_btMP3Volume: Byte = 70;
  g_btSoundVolume: Byte = 70;
  g_boBGSound: Boolean = True;
  g_boSound: Boolean = True;

  g_nGameSetupData: LongWord;
  g_boCanSound: Boolean = True;
  g_boChangeWindow: Boolean = False;
  g_boSaveIDInfo: Boolean = False;
  g_dwDefTime: LongWord;
  g_boSaveUserInfo: Boolean = False;
  g_boBagItemsRead: Boolean = False;
  g_boCtrlDown: Boolean = False;
  g_boLeapDown: Boolean = False;
  g_boShiftOpen: Boolean = False;
  g_boShiftUp: Boolean = True;
  g_boWgVisible: Boolean = False;
  g_BagCheckTick: LongWord = 0;
  g_CustomKey: array[0..DK_MAXHOOKKEYCOUNT] of TDefKeyInfo;
  g_ClientConf: TClientConf;
  g_MyBlacklist: TStringList;
  g_MyWhisperList: TStringList;
  g_FBTime: Integer = -1;
  g_FBExitTime: Integer = -1;
  g_FBFailTime: Integer = -1;
  g_sFBTime: string;
  g_sFBExitTime: string;
  g_sFBFailTime: string;
  //g_ItemFiltrateList: TList;
  g_boQueryExit: Boolean = False;
  g_WayTag: array[0..7] of string[2] = ('��', '�J', '��', '�K', '��',
    '�L', '��', '�I');

  g_dwDropItemFlashTime: LongWord = 3 * 1000; //������Ʒ��ʱ����

  g_dwAutoPickupTick: LongWord = 0; //�Զ�������ʱ��
  g_dwAutoPickupTime: LongWord = 500; //�Զ�������

  g_dwDuraAlertTick: LongWord = 0; //�־þ�����ʱ��
  g_dwDuraAlertTime: LongWord = 60 * 1000; //�־þ�����ʱ��
  g_dwHpProtectTime3: LongWord = 0; //�سǱ���ʱ��
  g_dwHpProtectTime2: LongWord = 0; //����ҩƷ����ʱ��
  g_dwHpProtectTime: LongWord = 0; //HP����
  g_dwMpProtectTime2: LongWord = 0; //MP����
  g_dwMpProtectTime: LongWord = 0; //MP����
  g_dwAutoMagicTime: LongWord = 0; //�Զ�����

  g_dwHpProtectTick3: LongWord = 0;
  g_dwHpProtectTick2: LongWord = 0;
  g_dwHpProtectTick: LongWord = 0;
  g_dwMpProtectTick2: LongWord = 0;
  g_dwMpProtectTick: LongWord = 0;
  g_sOpenItemName: string = '';
  g_boShowFormImage: Boolean = False;
  g_boShowFormIndex: Integer;

  g_SetupInfo: TSetupInfo;

function InBlacklist(sName: string): Boolean;
procedure LoadIDInfo();
procedure SaveIDInfo();
procedure LoadHumInfo(UserName: string);
procedure SaveHumInfo(UserName: string);
procedure SetDefKeyInfo();
function OpenKeyInfo(KeyIndex: Integer): Boolean;
procedure SetDefaultSetupInfo;
procedure SendGameSetupInfo;
procedure GetGameSetupInfo(Msg: pTDefaultMessage; sBody: string);
procedure ShowInterface(boShow: Boolean);
procedure ShowArmingHint(boShow: Boolean);
//procedure ClearItemRule();
function GetHookKeyStr(DefKeyInfo: pTDefKeyInfo): string;
function RefHookKeyStr(FShiftState: TShiftState; FKey: Word): string;
function CheckBlockListSys(Ident: Integer; sMsg: string; var UserName: string): Boolean;
function ExecuteScript(sScript: string): Boolean;

implementation
uses
  MShare, ClMain, FState, FState2, FState3, IniFiles, HUtil32, EDcodeEx, MNShare, LShare, Share;


procedure ShowInterface(boShow: Boolean);
begin
  g_boShowFormImage := boShow;
  g_boShowFormIndex := HELP_IMAGE_FORM;
end;

procedure ShowArmingHint(boShow: Boolean);
begin
  g_boShowFormImage := boShow;
  g_boShowFormIndex := HELP_IMAGE_ARMING;
end;

procedure LoadHumInfo(UserName: string);
  procedure LoadBagItems(sFileName: string);
  var
    FileStream: TFileStream;
  begin
    SafeFillChar(g_TempItemArr, SizeOf(g_TempItemArr), #0);
    if FileExists(sFileName) then begin
      FileStream := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
      try
        if FileStream.Size = SizeOf(g_TempItemArr) then
          FileStream.Read(g_TempItemArr, SizeOf(g_TempItemArr));
      finally
        FileStream.Free;
      end;
    end;
  end;

var
  sDirname: string;
begin
  if g_boSaveUserInfo then
    Exit;
  g_boSaveUserInfo := True;
  g_MyShopTitle := UserName + ' Stall';
  sDirname := Format(DG_FORMATSTR, [DG_SAVEDIR, g_ServerInfo[g_ServerChoice].sName, LoginScene.m_sLoginId]);
  LoadBagItems(sDirname + Format(BagItemsFile, [UserName]));
end;

procedure SaveHumInfo(UserName: string);
  procedure SaveBagItems(sFileName: string);
  var
    FileStream: TFileStream;
  begin
    if g_boBagItemsRead then begin
      DeleteFile(sFileName);
      FileStream := TFileStream.Create(sFileName, fmCreate);
      try
        FileStream.Write(g_ItemArr, SizeOf(g_ItemArr));
      finally
        FileStream.Free;
      end;
    end;
  end;
var
  sDirname: string;
begin
  if not g_boSaveUserInfo then
    Exit;
  g_boSaveUserInfo := False;
  if not DirectoryExists(DG_SAVEDIR) then
    CreateDir(DG_SAVEDIR);
  sDirname := DG_SAVEDIR + g_ServerInfo[g_ServerChoice].sName + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);
  sDirname := sDirname + LoginScene.m_sLoginId + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);

  SaveBagItems(sDirname + Format(BagItemsFile, [UserName]));
end;

//����������Ϣ

procedure SaveIDInfo();

  procedure SaveKeyInfo(sFileName: string);
  var
    i: Integer;
    Ini: TINIfile;
  begin
    Ini := TIniFile.Create(sFileName);
    try
      for i := Low(g_CustomKey) to High(g_CustomKey) do begin
        if g_CustomKey[i].CustomKey.Key > 0 then begin //if we already have a custom key assigned save it
          Ini.WriteInteger(ShiftName, g_CustomKey[i].KeyHint,
            Byte(g_CustomKey[i].CustomKey.Shift));
          Ini.WriteInteger(KeyName, g_CustomKey[i].KeyHint,
            g_CustomKey[i].CustomKey.Key);
        end else begin //if we dont have a custom key yet: save the defaults as custom (so ppl know what values go where)
          Ini.WriteInteger(ShiftName, g_CustomKey[i].KeyHint,
            Byte(g_CustomKey[i].DefKey.Shift));
          Ini.WriteInteger(KeyName, g_CustomKey[i].KeyHint,
            g_CustomKey[i].DefKey.Key);
        end;
      end;
    finally
      Ini.Free;
    end;
  end;

  procedure SaveItemRule(sFileName: string);
  var
    i: Integer;
    ClientStdItem: pTClientStditem;
    SaveList: TStringList;
    str: string;
  begin
    SaveList := TStringList.Create;
    for i := 0 to g_StditemList.Count - 1 do begin
      ClientStdItem := g_StditemList[i];
      if ClientStdItem.Filtrate.boChange then begin
        str := ClientStdItem.StdItem.Name + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boShow)) + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boPickUp)) + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boColor)) + #9;
        str := str + IntToStr(Integer(ClientStdItem.Filtrate.boHint)) + #9;
        SaveList.Add(str);
      end;
    end;
    SaveList.SaveToFile(sFileName);
    SaveList.Free;
  end;

var
  sDirname, sFileName: string;
begin
  if not g_boSaveIDInfo then
    Exit;
  g_boSaveIDInfo := False;
  if not DirectoryExists(DG_SAVEDIR) then
    CreateDir(DG_SAVEDIR);
  sDirname := DG_SAVEDIR + g_ServerInfo[g_ServerChoice].sName + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);
  sDirname := sDirname + LoginScene.m_sLoginId + '\';
  if not DirectoryExists(sDirname) then
    CreateDir(sDirname);

  //sFileName := sDirname + FriendListFile;
  //g_MyFriendList.SaveToFile(sFileName);
  sFileName := sDirname + BlackListFile;
  g_MyBlacklist.SaveToFile(sFileName);
  sFileName := sDirname + NotepaperFile;
  //FrmDlg.DMemoNotepaper.Lines.SaveToFile(sFileName);

  SaveKeyInfo(sDirname + CustomKeyFile); //save custom keymaps
  //SaveItemRule(sDirname + ItemRuleFile); //������Ʒ������Ϣ

  //ClearItemRule();
end;

//����������Ϣ

procedure LoadIDInfo();
  procedure LoadKeyInfo(sFileName: string);
  var
    i: Integer;
    Ini: TINIfile;
  begin
    if FileExists(sFileName) then begin
      Ini := TIniFile.Create(sFileName);
      try
        for i := Low(g_CustomKey) to High(g_CustomKey) do begin
          g_CustomKey[i].CustomKey.Shift :=
            TShiftState(Byte(Ini.ReadInteger(ShiftName, g_CustomKey[i].KeyHint,
            0)));
          g_CustomKey[i].CustomKey.Key := Ini.ReadInteger(KeyName,
            g_CustomKey[i].KeyHint, 0);
        end;
      finally
        Ini.Free;
      end;
    end;
  end;

  procedure LoadItemRule(sFileName: string);
  var
    SaveList: TStringList;
    i: Integer;
    str: string;
    sShow: string;
    sPickUp: string;
    sColor: string;
    sHint: string;
    sname: string;
    Filtrate: TClientItemFiltrate;
  begin
    if FileExists(sFileName) then begin
      SaveList := TStringList.Create;
      try
        SaveList.LoadFromFile(sFileName);
        for i := 0 to SaveList.Count - 1 do begin
          str := SaveList[i];
          str := GetValidStr3(str, sname, [' ', #9]);
          str := GetValidStr3(str, sShow, [' ', #9]);
          str := GetValidStr3(str, sPickUp, [' ', #9]);
          str := GetValidStr3(str, sColor, [' ', #9]);
          str := GetValidStr3(str, sHint, [' ', #9]);
          Filtrate.boShow := sShow = '1';
          Filtrate.boPickUp := sPickUp = '1';
          Filtrate.boColor := sColor = '1';
          Filtrate.boHint := sHint = '1';
          Filtrate.boChange := True;
          SetStditemFiltrate(sname, @Filtrate);
        end;
      finally
        SaveList.Free;
      end;
    end;
  end;

var
  sDirname, sFileName: string;
begin
  if g_boSaveIDInfo then
    exit;
  g_boSaveIDInfo := True;
  sDirname := Format(DG_FORMATSTR, [DG_SAVEDIR, g_ServerInfo[g_ServerChoice].sName, LoginScene.m_sLoginId]);

  (* g_SetupInfo.boAutoMagic := False;  *)
  SetDefKeyInfo(); //load default key mapping
  LoadKeyInfo(sDirname + CustomKeyFile); //load custom key mapping
  //ClearItemRule();
  //sFileName := sDirname + FriendListFile;
  //if FileExists(sFileName) then g_MyFriendList.LoadFromFile(sFileName);
  sFileName := sDirname + blackListFile;
  if FileExists(sFileName) then
    g_MyBlacklist.LoadFromFile(sFileName);
  sFileName := sDirname + NotepaperFile;
  //if FileExists(sFileName) then
    //FrmDlg.DMemoNotepaper.Lines.LoadFromFile(sFileName);
  //LoadItemRule(sDirname + ItemRuleFile); //������Ʒ������Ϣ
end;
{
procedure ClearItemRule();
var
i: Integer;
begin
for i := 0 to g_ItemFiltrateList.Count - 1 do
 Dispose(pTClientItemFiltrate(g_ItemFiltrateList[i]));
g_ItemFiltrateList.Clear;
end;       }

function InBlacklist(sName: string): Boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to g_MyBlacklist.Count - 1 do begin
    if CompareText(sName, g_MyBlacklist[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

function OpenKeyInfo(KeyIndex: Integer): Boolean;
var
  idx: Integer;
  GroupMember: pTGroupMember;
begin
  Result := True;
  case KeyIndex of
    DK_CHANGEMINMAP: begin
        FrmDlg.DBotMiniMapClick(FrmDlg.DBotMiniMap, 0, 0);
      end;
    DK_CHANGEATTACKMODE: begin
        frmMain.SendSay('@AttackMode');
      end;
    DK_SLAVEREST: begin
        frmMain.SendSay('@Rest');
      end;
    DK_PRINTSCREEN: begin
        frmMain.PrintScreenNow();
      end;
    DK_APPLOGOUT: begin
        if (FrmMain.m_CurrentTick - g_dwLatestStruckTick > 10000) and (FrmMain.m_CurrentTick - g_dwLatestMagicTick > 10000) and
            (FrmMain.m_CurrentTick - g_dwLatestHitTick > 10000) and (FrmMain.m_CurrentTick - g_dwLastAttackTick > 10000) or (g_MySelf.m_boDeath) then
        begin
          frmMain.AppLogout;
        end else
          DScreen.AddSysMsg('You cannot Logout the Game during Battle!', clRed);
      end;
    DK_APPEXIT: begin
        if (FrmMain.m_CurrentTick - g_dwLatestStruckTick > 10000) and (FrmMain.m_CurrentTick - g_dwLatestMagicTick > 10000) and
            (FrmMain.m_CurrentTick - g_dwLatestHitTick > 10000) and (FrmMain.m_CurrentTick - g_dwLastAttackTick > 10000) or (g_MySelf.m_boDeath) then
        begin
          frmMain.AppExit;
        end else
          DScreen.AddSysMsg('You cannot Exit the Game during Battle!', clRed);
      end;
    DK_CREATEGROUP: begin
        if (g_FocusCret <> nil) and (g_FocusCret <> g_MySelf) and
          (g_FocusCret.m_btRace = 0) then begin
          g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000;
          if g_GroupMembers.Count <= 0 then begin
            frmMain.SendCreateGroup(Integer(g_GroupItemMode), g_FocusCret.m_UserName);
          end
          else begin
            GroupMember := g_GroupMembers[0];
            if GroupMember.ClientGroup.UserName = g_MySelf.m_UserName then begin
              frmMain.SendAddGroupMember(g_FocusCret.m_UserName);
            end;
          end;
        end;
      end;
    DK_DELGROUPMEMBER: begin
        if (g_FocusCret <> nil) and (g_FocusCret <> g_MySelf) and
          (g_FocusCret.m_btRace = 0) then begin
          g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000;
          if g_GroupMembers.Count > 0 then begin
            GroupMember := g_GroupMembers[0];
            if GroupMember.ClientGroup.UserName = g_MySelf.m_UserName then begin
              frmMain.SendDelGroupMember(g_FocusCret.m_UserName);
            end;
          end;
        end;
      end;
    DK_ADDTOUSERLIST: begin
        if (g_FocusCret <> nil) and (g_FocusCret <> g_MySelf) and
          (g_FocusCret.m_btRace = 0) then begin
          idx := g_MyBlacklist.IndexOf(g_FocusCret.m_UserName);
          if idx = -1 then begin
            g_MyBlacklist.Add(g_FocusCret.m_UserName);
            DScreen.AddSysMsg(g_FocusCret.m_UserName + ' Blacklist', clWhite);
          end else begin
            g_MyBlacklist.Delete(idx);
            DScreen.AddSysMsg(g_FocusCret.m_UserName + ' Removed from Blacklist', clWhite);
          end;
        end;
      end;
    DK_PICKUP: begin
        FrmMain.AutoPickUpItem(False);
      end;
    DK_OPENITEMBAG, DK_OPENITEMBAG2: begin
        FrmDlg.OpenItemBag;
      end;
    DK_OPENMYSTATUS0, DK_OPENMYSTATUS02: begin
        FrmDlg.StatePage := 0;
        FrmDlg.OpenMyStatus;
      end;
    DK_OPENMYSTATUS3, DK_OPENSKILLPAGE: begin
        FrmDlg.StatePage := 2;
        FrmDlg.OpenMyStatus;
      end;
    DK_OPENGAMESETUP: begin
        FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
      end;
    DK_ONHORSE: begin
        with FrmDlg.DBTTakeHorse do begin
          if FrmMain.m_CurrentTick < AppendTick then
            exit;
          AppendTick := FrmMain.m_CurrentTick + 2000;
          if g_MySelf.m_btHorse = 0 then begin
            frmMain.SendSay(g_Cmd_TakeOnHorse);
          end
          else begin
            frmMain.SendSay(g_Cmd_TakeOffHorse);
          end;
        end;
      end;
    DK_OPENGROUP: begin
      FrmDlg.DGroupDlg.Visible := not FrmDlg.DGroupDlg.Visible;
    end;
    DK_OPENGUILD: begin
      FrmDlg.DBotGuildClick(FrmDlg.DBotGuild, 0, 0);
    end;
    DK_OPENQUEST: begin
      FrmDlg3.dwndMission.Visible := not FrmDlg3.dwndMission.Visible;
    end;
    DK_OPENMAIL: begin
      FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
    end;
    DK_STARTTRADE: begin
      g_CursorMode := cr_Deal;
      FrmMain.Cursor := crMyDeal;
    end;
    DK_AUTORUN: begin
      FrmMain.ToggleAutoRun;
    end;
    DK_OPTIONDROP: begin
      g_SetupInfo.boShowItemName := not g_SetupInfo.boShowItemName;
    end;
    DK_OPENLOVER: begin

    end;
    DK_OPENFRIENDS: begin
      FrmDlg2.DWinFriend.Visible := not FrmDlg2.DWinFriend.Visible;
    end;
    DK_OPENHORSE: begin
      FrmDlg.StatePage := 4;
      FrmDlg.OpenMyStatus;
    end;
    DK_OPENBIGMAP: begin
      //not fully implemented in this interface :(
    end;
    DK_SKILL1: begin
      FrmMain.ActionKey := -9;
    end;
    DK_SKILL2: begin
      FrmMain.ActionKey := -10;
    end;
    DK_SKILL3: begin
      FrmMain.ActionKey := -11;
    end;
    DK_SKILL4: begin
      FrmMain.ActionKey := -12;
    end;
    DK_SKILL5: begin
      FrmMain.ActionKey := -13;
    end;
    DK_SKILL6: begin
      FrmMain.ActionKey := -14;
    end;
    DK_SKILL7: begin
      FrmMain.ActionKey := -15;
    end;
    DK_SKILL8: begin
      FrmMain.ActionKey := -16;
    end;
    DK_SKILL9: begin
      FrmMain.ActionKey := -1;
    end;
    DK_SKILL10: begin
      FrmMain.ActionKey := -2;
    end;
    DK_SKILL11: begin
      FrmMain.ActionKey := -3;
    end;
    DK_SKILL12: begin
      FrmMain.ActionKey := -4;
    end;
    DK_SKILL13: begin
      FrmMain.ActionKey := -5;
    end;
    DK_SKILL14: begin
      FrmMain.ActionKey := -6;
    end;
    DK_SKILL15: begin
      FrmMain.ActionKey := -7;
    end;
    DK_SKILL16: begin
      FrmMain.ActionKey := -8;
    end;
    else Result := False;
  end;
end;

procedure SetDefKeyInfo();
begin
  SafeFillChar(g_CustomKey, SizeOf(g_CustomKey), #0);

  g_CustomKey[DK_CHANGEMINMAP].DefKey.Shift := [];
  g_CustomKey[DK_CHANGEMINMAP].DefKey.Key := Word('V');
  g_CustomKey[DK_CHANGEMINMAP].boLoginGame := True;
  g_CustomKey[DK_CHANGEMINMAP].boDuringChat := False;
  g_CustomKey[DK_CHANGEMINMAP].KeyHint := 'Open miniMap';

  g_CustomKey[DK_CHANGEATTACKMODE].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_CHANGEATTACKMODE].DefKey.Key := Word('H');
  g_CustomKey[DK_CHANGEATTACKMODE].boLoginGame := True;
  g_CustomKey[DK_CHANGEATTACKMODE].boDuringChat := False;
  g_CustomKey[DK_CHANGEATTACKMODE].KeyHint := 'Switch Attack Mode';

  g_CustomKey[DK_SLAVEREST].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SLAVEREST].DefKey.Key := Word('A');
  g_CustomKey[DK_SLAVEREST].boLoginGame := True;
  g_CustomKey[DK_SLAVEREST].boDuringChat := False;
  g_CustomKey[DK_SLAVEREST].KeyHint := 'Change Pet Mode';


  g_CustomKey[DK_PRINTSCREEN].DefKey.Shift := [];
  g_CustomKey[DK_PRINTSCREEN].DefKey.Key := VK_PAUSE;
  g_CustomKey[DK_PRINTSCREEN].boLoginGame := False;
  g_CustomKey[DK_PRINTSCREEN].boDuringChat := True;
  g_CustomKey[DK_PRINTSCREEN].KeyHint := 'Screenshot';

  g_CustomKey[DK_APPLOGOUT].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_APPLOGOUT].DefKey.Key := Word('X');
  g_CustomKey[DK_APPLOGOUT].boLoginGame := True;
  g_CustomKey[DK_APPLOGOUT].boDuringChat := True;
  g_CustomKey[DK_APPLOGOUT].KeyHint := 'Log Out';

  g_CustomKey[DK_APPEXIT].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_APPEXIT].DefKey.Key := Word('Q');
  g_CustomKey[DK_APPEXIT].boLoginGame := True;
  g_CustomKey[DK_APPEXIT].boDuringChat := True;
  g_CustomKey[DK_APPEXIT].KeyHint := 'Quit Game';

  g_CustomKey[DK_CREATEGROUP].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_CREATEGROUP].DefKey.Key := Word('G');
  g_CustomKey[DK_CREATEGROUP].boLoginGame := True;
  g_CustomKey[DK_CREATEGROUP].boDuringChat := False;
  g_CustomKey[DK_CREATEGROUP].KeyHint := 'Create Group';

  g_CustomKey[DK_DELGROUPMEMBER].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_DELGROUPMEMBER].DefKey.Key := Word('G');
  g_CustomKey[DK_DELGROUPMEMBER].boLoginGame := True;
  g_CustomKey[DK_DELGROUPMEMBER].boDuringChat := False;
  g_CustomKey[DK_DELGROUPMEMBER].KeyHint := 'Remove Player from Group';

  g_CustomKey[DK_ADDTOUSERLIST].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_ADDTOUSERLIST].DefKey.Key := Word('z');
  g_CustomKey[DK_ADDTOUSERLIST].boLoginGame := True;
  g_CustomKey[DK_ADDTOUSERLIST].boDuringChat := False;
  g_CustomKey[DK_ADDTOUSERLIST].KeyHint := 'Add/Remove from blacklist';

  g_CustomKey[DK_PICKUP].DefKey.Shift := [];
  g_CustomKey[DK_PICKUP].DefKey.Key := VK_TAB;
  g_CustomKey[DK_PICKUP].boLoginGame := True;
  g_CustomKey[DK_PICKUP].boDuringChat := True;
  g_CustomKey[DK_PICKUP].KeyHint := 'Pick up item beneath you';

  g_CustomKey[DK_OPENITEMBAG].DefKey.Shift := [];
  g_CustomKey[DK_OPENITEMBAG].DefKey.Key := VK_F9;
  g_CustomKey[DK_OPENITEMBAG].boLoginGame := True;
  g_CustomKey[DK_OPENITEMBAG].boDuringChat := True;
  g_CustomKey[DK_OPENITEMBAG].KeyHint := 'Character Bag2';

  g_CustomKey[DK_OPENITEMBAG2].DefKey.Shift := [];
  g_CustomKey[DK_OPENITEMBAG2].DefKey.Key := Word('I');
  g_CustomKey[DK_OPENITEMBAG2].boLoginGame := True;
  g_CustomKey[DK_OPENITEMBAG2].boDuringChat := False;
  g_CustomKey[DK_OPENITEMBAG2].KeyHint := 'Character Bag';

  g_CustomKey[DK_OPENMYSTATUS0].DefKey.Shift := [];
  g_CustomKey[DK_OPENMYSTATUS0].DefKey.Key := VK_F10;
  g_CustomKey[DK_OPENMYSTATUS0].boLoginGame := True;
  g_CustomKey[DK_OPENMYSTATUS0].boDuringChat := True;
  g_CustomKey[DK_OPENMYSTATUS0].KeyHint := 'Character State2';

  g_CustomKey[DK_OPENMYSTATUS02].DefKey.Shift := [];
  g_CustomKey[DK_OPENMYSTATUS02].DefKey.Key := Word('C');
  g_CustomKey[DK_OPENMYSTATUS02].boLoginGame := True;
  g_CustomKey[DK_OPENMYSTATUS02].boDuringChat := False;
  g_CustomKey[DK_OPENMYSTATUS02].KeyHint := 'Character State';

  g_CustomKey[DK_OPENMYSTATUS3].DefKey.Shift := [];
  g_CustomKey[DK_OPENMYSTATUS3].DefKey.Key := VK_F11;
  g_CustomKey[DK_OPENMYSTATUS3].boLoginGame := True;
  g_CustomKey[DK_OPENMYSTATUS3].boDuringChat := True;
  g_CustomKey[DK_OPENMYSTATUS3].KeyHint := 'Character Skills2';

  g_CustomKey[DK_OPENSKILLPAGE].DefKey.Shift := [];
  g_CustomKey[DK_OPENSKILLPAGE].DefKey.Key := Word('S');
  g_CustomKey[DK_OPENSKILLPAGE].boLoginGame := True;
  g_CustomKey[DK_OPENSKILLPAGE].boDuringChat := False;
  g_CustomKey[DK_OPENSKILLPAGE].KeyHint := 'Character Skills';

  g_CustomKey[DK_OPENGAMESETUP].DefKey.Shift := [];
  g_CustomKey[DK_OPENGAMESETUP].DefKey.Key := VK_F12;
  g_CustomKey[DK_OPENGAMESETUP].boLoginGame := True;
  g_CustomKey[DK_OPENGAMESETUP].boDuringChat := True;
  g_CustomKey[DK_OPENGAMESETUP].KeyHint := 'Game Config';

  g_CustomKey[DK_ONHORSE].DefKey.Shift := [];
  g_CustomKey[DK_ONHORSE].DefKey.Key := Word('M');
  g_CustomKey[DK_ONHORSE].boLoginGame := True;
  g_CustomKey[DK_ONHORSE].boDuringChat := False;
  g_CustomKey[DK_ONHORSE].KeyHint := 'Toggle Mount On/Off';

  g_CustomKey[DK_OPENGROUP].DefKey.Shift := [];
  g_CustomKey[DK_OPENGROUP].DefKey.Key := Word('P');
  g_CustomKey[DK_OPENGROUP].boLoginGame := True;
  g_CustomKey[DK_OPENGROUP].boDuringChat := False;
  g_CustomKey[DK_OPENGROUP].KeyHint := 'Group Window';

  g_CustomKey[DK_OPENGUILD].DefKey.Shift := [];
  g_CustomKey[DK_OPENGUILD].DefKey.Key := Word('G');
  g_CustomKey[DK_OPENGUILD].boLoginGame := True;
  g_CustomKey[DK_OPENGUILD].boDuringChat := False;
  g_CustomKey[DK_OPENGUILD].KeyHint := 'Guild Window';

  g_CustomKey[DK_OPENQUEST].DefKey.Shift := [];
  g_CustomKey[DK_OPENQUEST].DefKey.Key := Word('Q');
  g_CustomKey[DK_OPENQUEST].boLoginGame := True;
  g_CustomKey[DK_OPENQUEST].boDuringChat := False;
  g_CustomKey[DK_OPENQUEST].KeyHint := 'Quest Window';

  g_CustomKey[DK_OPENMAIL].DefKey.Shift := [];
  g_CustomKey[DK_OPENMAIL].DefKey.Key := Word('E');
  g_CustomKey[DK_OPENMAIL].boLoginGame := True;
  g_CustomKey[DK_OPENMAIL].boDuringChat := False;
  g_CustomKey[DK_OPENMAIL].KeyHint := 'Mail Window';

  g_CustomKey[DK_STARTTRADE].DefKey.Shift := [];
  g_CustomKey[DK_STARTTRADE].DefKey.Key := Word('T');
  g_CustomKey[DK_STARTTRADE].boLoginGame := True;
  g_CustomKey[DK_STARTTRADE].boDuringChat := False;
  g_CustomKey[DK_STARTTRADE].KeyHint := 'Start Trade';

  g_CustomKey[DK_AUTORUN].DefKey.Shift := [];
  g_CustomKey[DK_AUTORUN].DefKey.Key := Word('D');
  g_CustomKey[DK_AUTORUN].boLoginGame := True;
  g_CustomKey[DK_AUTORUN].boDuringChat := False;
  g_CustomKey[DK_AUTORUN].KeyHint := 'Autorun';

  g_CustomKey[DK_OPTIONDROP].DefKey.Shift := [];
  g_CustomKey[DK_OPTIONDROP].DefKey.Key := Word('N');
  g_CustomKey[DK_OPTIONDROP].boLoginGame := True;
  g_CustomKey[DK_OPTIONDROP].boDuringChat := False;
  g_CustomKey[DK_OPTIONDROP].KeyHint := 'Show Drops';

  g_CustomKey[DK_OPENLOVER].DefKey.Shift := [];
  g_CustomKey[DK_OPENLOVER].DefKey.Key := Word('L');
  g_CustomKey[DK_OPENLOVER].boLoginGame := True;
  g_CustomKey[DK_OPENLOVER].boDuringChat := False;
  g_CustomKey[DK_OPENLOVER].KeyHint := 'Love Window';

  g_CustomKey[DK_OPENFRIENDS].DefKey.Shift := [];
  g_CustomKey[DK_OPENFRIENDS].DefKey.Key := Word('W');
  g_CustomKey[DK_OPENFRIENDS].boLoginGame := True;
  g_CustomKey[DK_OPENFRIENDS].boDuringChat := False;
  g_CustomKey[DK_OPENFRIENDS].KeyHint := 'Friends Window';

  g_CustomKey[DK_OPENHORSE].DefKey.Shift := [ssAlt];
  g_CustomKey[DK_OPENHORSE].DefKey.Key := Word('M');
  g_CustomKey[DK_OPENHORSE].boLoginGame := True;
  g_CustomKey[DK_OPENHORSE].boDuringChat := False;
  g_CustomKey[DK_OPENHORSE].KeyHint := 'Horse Window';

  g_CustomKey[DK_OPENBIGMAP].DefKey.Shift := [];
  g_CustomKey[DK_OPENBIGMAP].DefKey.Key := Word('B');
  g_CustomKey[DK_OPENBIGMAP].boLoginGame := True;
  g_CustomKey[DK_OPENBIGMAP].boDuringChat := False;
  g_CustomKey[DK_OPENBIGMAP].KeyHint := 'Big Map Window';

  g_CustomKey[DK_SKILL1].DefKey.Shift := [];
  g_CustomKey[DK_SKILL1].DefKey.Key := VK_F1;
  g_CustomKey[DK_SKILL1].boLoginGame := True;
  g_CustomKey[DK_SKILL1].boDuringChat := True;
  g_CustomKey[DK_SKILL1].KeyHint := 'Skill button 1';

  g_CustomKey[DK_SKILL2].DefKey.Shift := [];
  g_CustomKey[DK_SKILL2].DefKey.Key := VK_F2;
  g_CustomKey[DK_SKILL2].boLoginGame := True;
  g_CustomKey[DK_SKILL2].boDuringChat := True;
  g_CustomKey[DK_SKILL2].KeyHint := 'Skill button 2';

  g_CustomKey[DK_SKILL3].DefKey.Shift := [];
  g_CustomKey[DK_SKILL3].DefKey.Key := VK_F3;
  g_CustomKey[DK_SKILL3].boLoginGame := True;
  g_CustomKey[DK_SKILL3].boDuringChat := True;
  g_CustomKey[DK_SKILL3].KeyHint := 'Skill button 3';

  g_CustomKey[DK_SKILL4].DefKey.Shift := [];
  g_CustomKey[DK_SKILL4].DefKey.Key := VK_F4;
  g_CustomKey[DK_SKILL4].boLoginGame := True;
  g_CustomKey[DK_SKILL4].boDuringChat := True;
  g_CustomKey[DK_SKILL4].KeyHint := 'Skill button 4';

  g_CustomKey[DK_SKILL5].DefKey.Shift := [];
  g_CustomKey[DK_SKILL5].DefKey.Key := VK_F5;
  g_CustomKey[DK_SKILL5].boLoginGame := True;
  g_CustomKey[DK_SKILL5].boDuringChat := True;
  g_CustomKey[DK_SKILL5].KeyHint := 'Skill button 5';

  g_CustomKey[DK_SKILL6].DefKey.Shift := [];
  g_CustomKey[DK_SKILL6].DefKey.Key := VK_F6;
  g_CustomKey[DK_SKILL6].boLoginGame := True;
  g_CustomKey[DK_SKILL6].boDuringChat := True;
  g_CustomKey[DK_SKILL6].KeyHint := 'Skill button 6';

  g_CustomKey[DK_SKILL7].DefKey.Shift := [];
  g_CustomKey[DK_SKILL7].DefKey.Key := VK_F7;
  g_CustomKey[DK_SKILL7].boLoginGame := True;
  g_CustomKey[DK_SKILL7].boDuringChat := True;
  g_CustomKey[DK_SKILL7].KeyHint := 'Skill button 7';

  g_CustomKey[DK_SKILL8].DefKey.Shift := [];
  g_CustomKey[DK_SKILL8].DefKey.Key := VK_F8;
  g_CustomKey[DK_SKILL8].boLoginGame := True;
  g_CustomKey[DK_SKILL8].boDuringChat := True;
  g_CustomKey[DK_SKILL8].KeyHint := 'Skill button 8';

  g_CustomKey[DK_SKILL9].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL9].DefKey.Key := VK_F1;
  g_CustomKey[DK_SKILL9].boLoginGame := True;
  g_CustomKey[DK_SKILL9].boDuringChat := True;
  g_CustomKey[DK_SKILL9].KeyHint := 'Skill button 9';

  g_CustomKey[DK_SKILL10].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL10].DefKey.Key := VK_F2;
  g_CustomKey[DK_SKILL10].boLoginGame := True;
  g_CustomKey[DK_SKILL10].boDuringChat := True;
  g_CustomKey[DK_SKILL10].KeyHint := 'Skill button 10';

  g_CustomKey[DK_SKILL11].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL11].DefKey.Key := VK_F3;
  g_CustomKey[DK_SKILL11].boLoginGame := True;
  g_CustomKey[DK_SKILL11].boDuringChat := True;
  g_CustomKey[DK_SKILL11].KeyHint := 'Skill button 11';

  g_CustomKey[DK_SKILL12].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL12].DefKey.Key := VK_F4;
  g_CustomKey[DK_SKILL12].boLoginGame := True;
  g_CustomKey[DK_SKILL12].boDuringChat := True;
  g_CustomKey[DK_SKILL12].KeyHint := 'Skill button 12';

  g_CustomKey[DK_SKILL13].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL13].DefKey.Key := VK_F5;
  g_CustomKey[DK_SKILL13].boLoginGame := True;
  g_CustomKey[DK_SKILL13].boDuringChat := True;
  g_CustomKey[DK_SKILL13].KeyHint := 'Skill button 13';

  g_CustomKey[DK_SKILL14].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL14].DefKey.Key := VK_F6;
  g_CustomKey[DK_SKILL14].boLoginGame := True;
  g_CustomKey[DK_SKILL14].boDuringChat := True;
  g_CustomKey[DK_SKILL14].KeyHint := 'Skill button 14';

  g_CustomKey[DK_SKILL15].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL15].DefKey.Key := VK_F7;
  g_CustomKey[DK_SKILL15].boLoginGame := True;
  g_CustomKey[DK_SKILL15].boDuringChat := True;
  g_CustomKey[DK_SKILL15].KeyHint := 'Skill button 15';

  g_CustomKey[DK_SKILL16].DefKey.Shift := [ssCtrl];
  g_CustomKey[DK_SKILL16].DefKey.Key := VK_F8;
  g_CustomKey[DK_SKILL16].boLoginGame := True;
  g_CustomKey[DK_SKILL16].boDuringChat := True;
  g_CustomKey[DK_SKILL16].KeyHint := 'Skill button 16';
end;

function GetHookKeyStr(DefKeyInfo: pTDefKeyInfo): string;
begin
  if (not g_SetupInfo.boCustomKey) or ((DefKeyInfo.CustomKey.Shift = []) and
    (DefKeyInfo.CustomKey.Key = 0)) then begin
    Result := RefHookKeyStr(DefKeyInfo.DefKey.Shift, DefKeyInfo.DefKey.Key);
  end
  else
    Result := RefHookKeyStr(DefKeyInfo.CustomKey.Shift,
      DefKeyInfo.CustomKey.Key);
end;

function RefHookKeyStr(FShiftState: TShiftState; FKey: Word): string;
var
  ShowStr: string;
begin
  ShowStr := '';
  if ssCtrl in FShiftState then
    ShowStr := 'Ctrl';

  if ssAlt in FShiftState then
    if ShowStr <> '' then
      ShowStr := ShowStr + '+Alt'
    else
      ShowStr := 'Alt';

  if ssShift in FShiftState then
    if ShowStr <> '' then
      ShowStr := ShowStr + '+Shift'
    else
      ShowStr := 'Shift';

  case FKey of
    VK_F1: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F1'
        else
          ShowStr := 'F1';
      end;
    VK_F2: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F2'
        else
          ShowStr := 'F2';
      end;
    VK_F3: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F3'
        else
          ShowStr := 'F3';
      end;
    VK_F4: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F4'
        else
          ShowStr := 'F4';
      end;
    VK_F5: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F5'
        else
          ShowStr := 'F5';
      end;
    VK_F6: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F6'
        else
          ShowStr := 'F6';
      end;
    VK_F7: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F7'
        else
          ShowStr := 'F7';
      end;
    VK_F8: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F8'
        else
          ShowStr := 'F8';
      end;
    VK_F9: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F9'
        else
          ShowStr := 'F9';
      end;
    VK_F10: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F10'
        else
          ShowStr := 'F10';
      end;
    VK_F11: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F11'
        else
          ShowStr := 'F11';
      end;
    VK_F12: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+F12'
        else
          ShowStr := 'F12';
      end;
    VK_TAB: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Tab'
        else
          ShowStr := 'Tab';
      end;
    VK_PAUSE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Pause'
        else
          ShowStr := 'Pause';
      end;
    VK_HOME: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Home'
        else
          ShowStr := 'Home';
      end;
    VK_LEFT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Left'
        else
          ShowStr := 'Left';
      end;
    VK_UP: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Up'
        else
          ShowStr := 'Up';
      end;
    VK_RIGHT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Right'
        else
          ShowStr := 'Right';
      end;
    VK_DOWN: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Down'
        else
          ShowStr := 'Down';
      end;
    VK_SPACE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Space'
        else
          ShowStr := 'Space';
      end;
    VK_CAPITAL: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+CapsLock'
        else
          ShowStr := 'CapsLock';
      end;
    VK_ESCAPE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Esc'
        else
          ShowStr := 'Esc';
      end;
    VK_BACK: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Back'
        else
          ShowStr := 'Back';
      end;
    VK_PRIOR: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Prior'
        else
          ShowStr := 'Prior';
      end;
    VK_NEXT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Next'
        else
          ShowStr := 'Next';
      end;
    VK_END: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+End'
        else
          ShowStr := 'End';
      end;
    VK_SELECT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Select'
        else
          ShowStr := 'Select';
      end;
    VK_PRINT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Print'
        else
          ShowStr := 'Print';
      end;
    VK_EXECUTE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Execute'
        else
          ShowStr := 'Execute';
      end;
    VK_SNAPSHOT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Snapshot'
        else
          ShowStr := 'Snapshot';
      end;
    VK_INSERT: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Insert'
        else
          ShowStr := 'Insert';
      end;
    VK_DELETE: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Delete'
        else
          ShowStr := 'Delete';
      end;
    VK_HELP: begin
        if ShowStr <> '' then
          ShowStr := ShowStr + '+Help'
        else
          ShowStr := 'Help';
      end;
    VK_SHIFT,
      VK_CONTROL,
      VK_MENU: begin

      end
  else begin
      if ShowStr <> '' then
        ShowStr := ShowStr + '+' + Char(FKey)
      else
        ShowStr := Char(FKey);
    end;
  end;

  Result := ShowStr;
end;

function CheckBlockListSys(Ident: Integer; sMsg: string; var UserName: string):
  Boolean;
begin
  Result := True;
  UserName := '';
  case Ident of
    SM_HEAR,
      SM_GROUPMESSAGE,
      SM_GUILDMESSAGE: begin
        GetValidStr3(sMsg, UserName, [':']);
      end;
    SM_CRY: begin
        GetValidStr3(sMsg, UserName, [':']);
        UserName := RightStr(UserName, Length(UserName) - 3);
      end;
    SM_WHISPER: GetValidStr3(sMsg, UserName, ['=']);
  end;
  if UserName <> '' then begin
    if (g_MyBlacklist.IndexOf(UserName) > -1) then
      Result := False;
  end;
end;

procedure SendGameSetupInfo;
var
  UserOptionSetup: TUserOptionSetup;
  UserItemsSetup: TUserItemsSetup;
  ClientStditem: pTClientStditem;
  ClientItemFiltrate: pTClientItemFiltrate;
  I: Integer;
  nChangeCount: Integer;
begin
  SafeFillChar(UserOptionSetup, SizeOf(UserOptionSetup), #0);
  SafeFillChar(UserItemsSetup, SizeOf(UserItemsSetup), #0);

  SetIntStatus(UserOptionSetup.nOptionSetup, OS_ISSETUP, True);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAME, g_SetupInfo.boShowName);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEALL, g_SetupInfo.boShowNameAll);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEMON, g_SetupInfo.boShowNameMon);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_DURAHINT, g_SetupInfo.boDuraHint);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWMAPHINT, g_SetupInfo.boShowMapHint);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWITEMNAME, g_SetupInfo.boShowItemName);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOPICKUPITEM, g_SetupInfo.boAutoPickUpItem);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_EXEMPTSHIFT, g_SetupInfo.boExemptShift);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_GETEXPFILTRATE, g_SetupInfo.boGetExpFiltrate);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_MOVEHPSHOW, g_SetupInfo.boMoveHpShow);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT, g_SetupInfo.boHpProtect);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT, g_SetupInfo.boMpProtect);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT2, g_SetupInfo.boHpProtect2);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT2, g_SetupInfo.boMpProtect2);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT3, g_SetupInfo.boHpProtect3);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEAROUNDHUM, g_SetupInfo.boHideAroundHum);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEALLYHUM, g_SetupInfo.boHideAllyHum);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICBEGIN, g_SetupInfo.boHideMagicBegin);
  (*SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICEND, g_SetupInfo.boHideMagicEnd);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGHIT, g_SetupInfo.boAutoLongHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOWIDEHIT, g_SetupInfo.boAutoWideHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOFIREHIT, g_SetupInfo.boAutoFireHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOSHIELD, g_SetupInfo.boAutoShield);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOCLOAK, g_SetupInfo.boAutoCloak);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_SNOWWINDLOCK, g_SetupInfo.boSnowWindLock);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_LONGWIND, g_SetupInfo.boAutoLongWide);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGICEHIT, g_SetupInfo.boAutoLongIceHit);
  SetIntStatus(UserOptionSetup.nOptionSetup, OS_FIERYDRAGONLOCK, g_SetupInfo.boFieryDragonLock);    *)


  //SetIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEHELMET, not g_SetupInfo.boShowHelmet);


  UserOptionSetup.nExpFiltrateCount := g_SetupInfo.nExpFiltrateCount;
  UserOptionSetup.nHpProtectCount := g_SetupInfo.nHpProtectCount;
  UserOptionSetup.dwHpProtectTime := g_SetupInfo.dwHpProtectTime;
  UserOptionSetup.nMpProtectCount := g_SetupInfo.nMpProtectCount;
  UserOptionSetup.dwMpProtectTime := g_SetupInfo.dwMpProtectTime;
  UserOptionSetup.nHpProtectCount2 := g_SetupInfo.nHpProtectCount2;
  UserOptionSetup.dwHpProtectTime2 := g_SetupInfo.dwHpProtectTime2;
  UserOptionSetup.nMpProtectCount2 := g_SetupInfo.nMpProtectCount2;
  UserOptionSetup.dwMpProtectTime2 := g_SetupInfo.dwMpProtectTime2;
  UserOptionSetup.nHpProtectCount3 := g_SetupInfo.nHpProtectCount3;
  UserOptionSetup.dwHpProtectTime3 := g_SetupInfo.dwHpProtectTime3;
  UserOptionSetup.btHpProtectIdx := g_SetupInfo.btHpProtectIdx;
  FrmMain.SendClientSocket(CM_GAMESETUPINFO, 0, 0, 0, 1, EncodeBuffer(@UserOptionSetup, SizeOf(UserOptionSetup)));

  nChangeCount := 0;
  for I := 0 to g_StditemList.Count - 1 do begin
    ClientStditem := g_StditemList[I];
    ClientItemFiltrate := pTClientItemFiltrate(g_StditemFiltrateList[I]);
    if ClientStditem.isShow then begin
      if (ClientStditem.Filtrate.boShow <> ClientItemFiltrate.boShow) or
        (ClientStditem.Filtrate.boColor <> ClientItemFiltrate.boColor) or
        (ClientStditem.Filtrate.boPickUp <> ClientItemFiltrate.boPickUp) then begin
        UserItemsSetup[nChangeCount] := ClientStditem.StdItem.Idx + 1;
        if ClientStditem.Filtrate.boShow then
          UserItemsSetup[nChangeCount] := UserItemsSetup[nChangeCount] or $2000;
        if ClientStditem.Filtrate.boColor then
          UserItemsSetup[nChangeCount] := UserItemsSetup[nChangeCount] or $4000;
        if ClientStditem.Filtrate.boPickUp then
          UserItemsSetup[nChangeCount] := UserItemsSetup[nChangeCount] or $8000;
        Inc(nChangeCount);
        if nChangeCount > MAXITEMSSETUPCOUNT then
          break;
      end;
    end;
  end;
  if nChangeCount > 0 then
    FrmMain.SendClientSocket(CM_GAMESETUPINFO, nChangeCount, 0, 0, 2,
      EncodeBuffer(@UserItemsSetup[0], SizeOf(Word) * nChangeCount))
  else
    FrmMain.SendClientSocket(CM_GAMESETUPINFO, 0, 0, 0, 2, '');
end;

procedure GetGameSetupInfo(Msg: pTDefaultMessage; sBody: string);
var
  UserOptionSetup: TUserOptionSetup;
  UserItemsSetup: TUserItemsSetup;
  ClientStditem: pTClientStditem;
  I: Integer;
begin
  if Msg.Series = 1 then begin
    DecodeBuffer(sBody, @UserOptionSetup, SizeOf(UserOptionSetup));
    g_SetupInfo.boShowName := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAME);
    g_SetupInfo.boShowNameAll := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEALL);
    g_SetupInfo.boShowNameMon := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWNAMEMON);
    g_SetupInfo.boDuraHint := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_DURAHINT);
    g_SetupInfo.boShowMapHint := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWMAPHINT);
    g_SetupInfo.boShowItemName := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SHOWITEMNAME);
    g_SetupInfo.boAutoPickUpItem := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOPICKUPITEM);
    {g_SetupInfo.boExemptShift := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_EXEMPTSHIFT);
    if g_boEasyNotShift and g_SetupInfo.boExemptShift then g_boShiftOpen := True; }
    g_SetupInfo.boGetExpFiltrate := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_GETEXPFILTRATE);
    g_SetupInfo.boMoveHpShow := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_MOVEHPSHOW);
    g_SetupInfo.boHpProtect := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT);
    g_SetupInfo.boMpProtect := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT);
    g_SetupInfo.boHpProtect2 := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT2);
    g_SetupInfo.boMpProtect2 := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_MPPROTECT2);
    g_SetupInfo.boHpProtect3 := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HPPROTECT3);
    g_SetupInfo.boHideAroundHum := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEAROUNDHUM);
    g_SetupInfo.boHideAllyHum := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEALLYHUM);
    g_SetupInfo.boHideMagicBegin := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICBEGIN);
    g_SetupInfo.boHideMagicEnd := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEMAGICEND);
    (*g_SetupInfo.boAutoLongHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGHIT);
    g_SetupInfo.boAutoWideHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOWIDEHIT);
    g_SetupInfo.boAutoFireHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOFIREHIT);
    g_SetupInfo.boAutoShield := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOSHIELD);
    g_SetupInfo.boAutoCloak := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOCLOAK);
    g_SetupInfo.boSnowWindLock := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_SNOWWINDLOCK);
    g_SetupInfo.boAutoLongWide := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_LONGWIND);
    g_SetupInfo.boAutoLongIceHit := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_AUTOLONGICEHIT);
    g_SetupInfo.boFieryDragonLock := CheckIntStatus(UserOptionSetup.nOptionSetup, OS_FIERYDRAGONLOCK);  *)

    //g_SetupInfo.boShowHelmet := not CheckIntStatus(UserOptionSetup.nOptionSetup, OS_HIDEHELMET);
    g_SetupInfo.nExpFiltrateCount := UserOptionSetup.nExpFiltrateCount;
    g_SetupInfo.nHpProtectCount := UserOptionSetup.nHpProtectCount;
    g_SetupInfo.dwHpProtectTime := UserOptionSetup.dwHpProtectTime;
    g_SetupInfo.nMpProtectCount := UserOptionSetup.nMpProtectCount;
    g_SetupInfo.dwMpProtectTime := UserOptionSetup.dwMpProtectTime;
    g_SetupInfo.nHpProtectCount2 := UserOptionSetup.nHpProtectCount2;
    g_SetupInfo.dwHpProtectTime2 := UserOptionSetup.dwHpProtectTime2;
    g_SetupInfo.nMpProtectCount2 := UserOptionSetup.nMpProtectCount2;
    g_SetupInfo.dwMpProtectTime2 := UserOptionSetup.dwMpProtectTime2;
    g_SetupInfo.nHpProtectCount3 := UserOptionSetup.nHpProtectCount3;
    g_SetupInfo.dwHpProtectTime3 := UserOptionSetup.dwHpProtectTime3;
    g_SetupInfo.btHpProtectIdx := UserOptionSetup.btHpProtectIdx;
  end
  else if Msg.Series = 2 then begin
    DecodeBuffer(sBody, @UserItemsSetup[0], SizeOf(Word) * Msg.Recog);
    for I := 0 to Msg.Recog - 1 do begin
      ClientStditem := GetClientStditem(UserItemsSetup[I] and $1FFF);
      if ClientStditem <> nil then begin
        ClientStditem.Filtrate.boShow := (UserItemsSetup[I] and $2000) = $2000;
        ClientStditem.Filtrate.boColor := (UserItemsSetup[I] and $4000) = $4000;
        ClientStditem.Filtrate.boPickUp := (UserItemsSetup[I] and $8000) = $8000;
      end;
    end;
  end;
end;

function ExecuteScript(sScript: string): Boolean;
begin
  Result := True;
  if Length(sScript) >= 2 then begin
    if CompareText(sScript, '~@image_interface') = 0 then begin
      ShowInterface(True);
    end else
    if CompareText(sScript, '~@image_arming') = 0 then begin
      ShowArmingHint(True);
    end else
    if CompareText(sScript, '~@quest_list') = 0 then begin
      FrmDlg3.dbtnMissionAcceptClick(FrmDlg3.dbtnMissionAccept, 0, 0);
    end else
    if CompareLStr(sScript, '@Move(', Length('@Move('))then begin
      ScriptGoto(sScript);
    end else
      Result := False;
  end else
    Result := False;
end;

procedure SetDefaultSetupInfo;
var
  ClientStditem: pTClientStditem;
  ClientItemFiltrate: pTClientItemFiltrate;
  I: Integer;
begin
  with g_SetupInfo do begin
    boCustomKey := True; //�����Զ����ݼ�
    //boShowHelmet := True; //�Ƿ���ʾͷ��
    boShowName := False; //��ʾ��������
    boShowNameAll := False; //��ʾ��������
    boShowNameMon := False; //��ʾ��������
    boDuraHint := True; //�־þ���
    boShowMapHint := True; //��ʾ��ͼ��ʶ
    boShowItemName := False; //Ctrl��ʾ��Ʒ����
    boAutoPickUpItem := False; //�Զ�����
    boExemptShift := False; //��Shift��
    boGetExpFiltrate := False; //�;���ֵ��ȡ����
    nExpFiltrateCount := 20000; //�����������
    boMoveHpShow := True; //�ƶ�ƮѪ��ʾ
    boHpProtect := False; //Ѫ������
    nHpProtectCount := 0;
    dwHpProtectTime := 4;
    boMpProtect := False; //ħ��ֵ����
    nMpProtectCount := 0;
    dwMpProtectTime := 4;
    boHpProtect2 := False; //����ҩƷ����
    nHpProtectCount2 := 0;
    dwHpProtectTime2 := 4;
    boMpProtect2 := False; //����ҩƷħ��ֵ����
    nMpProtectCount2 := 0;
    dwMpProtectTime2 := 4;
    boHpProtect3 := False; //���ᱣ��
    nHpProtectCount3 := 0;
    dwHpProtectTime3 := 4;
    btHpProtectIdx := 0;
    boHideAroundHum := False; //������Χ����
    boHideAllyHum := False; //������������
    boHideMagicBegin := False; //���ؼ��ܳ���Ч��
    boHideMagicEnd := False; //���ؼ��ܹ���Ч��
  (*boAutoLongHit := False; //������ɱ
    boAutoWideHit := False; //����Բ��
    boAutoFireHit := False; //�Զ��һ�
    boAutoShield := False; //�Զ�����
    boAutoCloak := False; //�Զ�����
    boAutoLongIceHit := False;
    boSnowWindLock := False;
    boFieryDragonLock := False;

    boAutoMagic := False; //�Զ�����
    dwAutoMagicTick := 10000;
    nAutoMagicIndex := -1;
    boAutoLongWide := False;  *)

    {boNotDeal := False;
    boNotGroup := False;
    boNotFriend := False;
    boNotGuild := False;  }
  end;

  for I := 0 to g_StditemList.Count - 1 do begin
    ClientStditem := g_StditemList[I];
    ClientItemFiltrate := pTClientItemFiltrate(g_StditemFiltrateList[I]);
    ClientStditem.Filtrate.boPickUp := ClientItemFiltrate.boPickUp;
    ClientStditem.Filtrate.boColor := ClientItemFiltrate.boColor;
    ClientStditem.Filtrate.boShow := ClientItemFiltrate.boShow;
  end;
end;

end.

