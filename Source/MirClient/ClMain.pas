unit ClMain;
{$define quicksend}
interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, GMManage,
  JSocket, ExtCtrls, DrawScrn, HGEGUI, HGETextures, Imm, DES, HGE, HGESounds, DirectX,
  IntroScn, PlayScn, MapUnit, WIL, Grobal2, HGEFonts, DirectXGraphics, D3DX81mo,
  Actor, CliUtil, HUtil32, EDcodeEx, LShare,
  ClFunc, magiceff, SoundUtil, clEvent, Bass, DateUtils,
  MShare, Share, jpeg, HGECanvas, RSA, SDK, HGEImages, IniFiles, ksTimers;

const
  //  BO_FOR_TEST = FALSE;
//  EnglishVersion = True; //TRUE;

  BoNeedPatch = True;

  //NEARESTPALETTEINDEXFILE = 'Data\npal.idx';

type
  TLoginConnInfo = packed record
    sAddrs: string[30];
    wPort: Word;
  end;

  TLoginConnInfos = array[0..9] of TLoginConnInfo;

  TDirectDrawCreate = function(lpGUID: PGUID; out lplpDD: IDirectDraw; pUnkOuter: IUnknown): HRESULT; stdcall;
//  TDirectDrawCreateEx = function (lpGUID: PGUID;out lplpDD: IDirectDraw2; const iid: TGUID;pUnkOuter: IUnknown) : HResult; stdcall;

  TKornetWorld = record
    CPIPcode: string;
    SVCcode: string;
    LoginID: string;
    CheckSum: string;
  end;

  TOneClickMode = (toNone, toKornetWorld);

  TfrmMain = class(TForm)
    CSocket: TClientSocket;
    TimerSocket: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    WgTimer: TTimer;
    TimerInitialize: TTimer;
    TimerRun: TTimer;
    TimerTest: TTimer;
    PackENRSA: TRSA;
    ksTimer1: TksTimer;

    procedure DXDrawInitialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DXDrawFinalize(Sender: TObject);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure TimerSocketTimer(Sender: TObject);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DXDrawDblClick(Sender: TObject);
    procedure WaitMsgTimerTimer(Sender: TObject);
    procedure SelChrWaitTimerTimer(Sender: TObject);
    procedure DXDrawClick(Sender: TObject);
    procedure CmdTimerTimer(Sender: TObject);
    procedure MinTimerTimer(Sender: TObject);
    procedure CheckHackTimerTimer(Sender: TObject);
    procedure SendTimeTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AutoPickUpItem(boFlag: Boolean);
    procedure WgTimerTimer(Sender: TObject);
    procedure TimerRunTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure AddSystemMsg(sMsg: string; MsgColor: TColor);

    procedure FormActivate(Sender: TObject);
    procedure TimerTestTimer(Sender: TObject);
    procedure TimerInitializeTimer(Sender: TObject);
    procedure ksTimer1Timer(Sender: TObject);
  private
    SocStr, BufferStr: string;
    WarningLevel: Integer;
    TimerCmd: TTimerCommand;
    MakeNewId: string;

    ActionLockTime: LongWord;
    LastHitTick: LongWord;
    ActionFailLock: Boolean;
    ActionFailLockTime: LongWord;

    //    CursorSurface: TDirectDrawSurface;
    mousedowntime: LongWord;
    mousemovetime: LongWord;
    mousechecktime: LongWord;
    WaitingMsg: TDefaultMessage;
    WaitingStr: string;
    WhisperName: string;
    TempItemList: TList;
    FCriticalSection: TRTLCriticalSection;
    FSendSocketStr: string;
    m_boCheckAppend: Boolean;
    m_FreeTextureTick: LongWord;
    m_FreeTextureIndex: Integer;
    m_boGroupPoison: Boolean;
    //m_CheckTick: LongWord;
    procedure SocketLock;
    procedure SocketUnLock;
    procedure ProcessKeyMessages;
    procedure ProcessActionMessages;
    procedure ProcessFreeTexture;
    procedure GetAutoMovingXY();
    //procedure CheckSpeedHack(rtime: LongWord);
    procedure DecodeMessagePacket(datablock: string);
    procedure ActionFailed;
    procedure CheckUserState(UserState: Integer);
    //function GetMagicByKey(Key: byte): PTClientMagic;
    procedure UseMagicSpell(who, effnum, targetx, targety, magic_id: Integer);
    procedure UseMagicFire(who, efftype, effnum, targetx, targety, target:
      Integer);
    procedure UseMagicFireFail(who: Integer);
    procedure CloseAllWindows(boClear: boolean=True);
    procedure ClearDropItems;
    procedure ResetGameVariables;
//    procedure ChangeServerClearGameVariables;
    procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure AttackTarget(target: TActor);

    procedure InitializeMap(sMapName: string);

    function CheckDoorAction(dx, dy: Integer): Boolean;
    procedure ClientGetPasswdSuccess(body: string);
    //    procedure ClientGetSelectServer;
        //procedure ClientGetPasswordOK(Msg: TDefaultMessage; sBody: string);
    procedure ClientGetReceiveChrs(body: string);
    procedure ClientGetStartPlay(body: string);
    procedure ClientGetReconnect(body: string);
    procedure ClientGetAppend(Msg: pTDefaultMessage; sBody: string);
    procedure ClientGetServerConfig(Msg: TDefaultMessage; sBody: string);
    procedure ClientGetMissionInfo(Msg: TDefaultMessage; sBody: string);
    procedure ClientGetMapDescription(Msg: TDefaultMessage; sBody: string);
    procedure ClientGetGameGoldName(Msg: TDefaultMessage; sBody: string);
    procedure ClientGetSayItem(Msg: TDefaultMessage; sBody: string);
    //procedure ClientGetAdjustBonus(bonus: Integer; body: string);
    procedure ClientGetAddItem(Msg: TDefaultMessage; body: string; boNew:boolean= true);
    procedure ClientGetGroupAddItem(Msg: pTDefaultMessage);
    procedure ClientGetUpdateItem(body: string);
    //procedure ClientGetUpdateItemEx(Msg: TDefaultMessage);
    procedure ClientGetDelItem(sindex, nIdent: Integer);
    procedure ClientGetDelItems(body: string);
    procedure ClientGetBagItmes(body: string);
    procedure ClientGetAddBagItmes(body: string);
    procedure ClientUpdateUserItem(body: string);
    procedure ClientGetDropItemFail(sindex: Integer);
    procedure ClientGetFriendChange(Msg: pTDefaultMessage; body: string);
    procedure ClientGetEMail(Msg: pTDefaultMessage; body: string);
    procedure ClientGetShowItem(itemid, X, Y, looks: Integer; itmname: string);
    procedure ClientGetHideItem(itemid, pickup: Integer);
    procedure ClientGetSenduseItems(body: string);
    procedure ClientGetUserShopList(Msg: pTDefaultMessage; body: string);
    procedure ClientGetMyShopList(Msg: pTDefaultMessage; body: string);
    procedure ClientGetRenewHum(Msg: pTDefaultMessage; Body: string);
    //procedure ClientGetSendAddUseItems(body: string);
    procedure ClientGetAddMagic(body: string);
    procedure ClientGetDelMagic(magid: Integer);
    procedure ClientGetMyMagics(body: string);
    procedure ClientGetMagicLvExp(magid, maglv, magtrain: Integer);
    procedure ClientGetDuraChange(uidx, newdura, newduramax, nPic: Integer);
    procedure ClientGetBabDuraChange(Idx, Dura, MaxDura: integer);
    procedure ClientGetBabDuraChange2(Msg: pTDefaultMessage);
    procedure ClientGetMerchantSay(merchant, nResID, nWidth, nHeight: Integer; saying: string);
    procedure ClientGetSendGoodsList(merchant, count, nFlag, nRate: Integer; body: string);
    procedure ClientGetSubList(body: string; nindex, ncount: integer);
    procedure ClientGetAbilityMoveSet(body: string);
    procedure ClientGetCompoundInfos(body: string);
    procedure ClientGetSendMakeDrugList(Msg: pTDefaultMessage; body: string);
    procedure ClientGetHintDataList(Msg: pTDefaultMessage; body: string);
    procedure ClientSendInfo(Msg: pTDefaultMessage; bodystr: string);
    procedure ClientGetSendReturnItemList(body: string);
    //procedure ClientGetSendUserSell(merchant: Integer);
    //procedure ClientGetSendUserRepair(merchant: Integer);
//    procedure ClientGetSendUserStorage(merchant: Integer);
    procedure ClientGetSaveItemList(Msg: pTDefaultMessage; bodystr: string);
    //procedure ClientGetSendDetailGoodsList(merchant, count, topline: Integer; bodystr: string);
    procedure ClientGetSendNotice(body: string);
    procedure ClientGetDataFile(Msg: TDefaultMessage; bodystr: string);
    procedure ClientFilterInfo(Msg: TDefaultMessage; bodystr: string);
    procedure ClientGetGroupMembers(Msg: TDefaultMessage; bodystr: string);
    procedure ClientGetAddMembers(Msg: pTDefaultMessage; bodystr: string);
    procedure ClientGetDelMembers(Msg: pTDefaultMessage; bodystr: string);
    procedure ClientGetGroupInfo(Msg: TDefaultMessage; bodystr: string);
    procedure ClientGetCheckMsg(Msg: pTDefaultMessage; bodystr: string);
    procedure ClientGetOpenGuildDlg(Msg: pTDefaultMessage; bodystr: string);
    procedure ClientGetSendGuildMemberList(Msg: pTDefaultMessage; body: string);
    procedure ClientGetDealRemoteAddItem(body: string);
    procedure ClientGetDealRemoteDelItem(body: string);
    procedure ClientGetSetItems(Msg: pTDefaultMessage; body: string);
    //procedure ClientGetReadMiniMap(mapindex, mapindex2: Integer);
    //procedure ClientGetChangeGuildName(body: string);
    procedure ClientGetSendUserState(Msg: pTDefaultMessage; body: string);
    procedure DrawEffectHum(nType, nX, nY, nActor: Integer);
    procedure DrawMonMagic(Msg: pTDefaultMessage; body: string);
    procedure ClientGetNeedPassword(body: string);
    procedure ClientGetPasswordStatus(Msg: pTDefaultMessage; body: string);
    procedure ClientGetRegInfo(Msg: pTDefaultMessage; body: string);
    procedure ClientGetCenterMsg(Msg: pTDefaultMessage; body: string);
    procedure ClientGetClearCenterMsg(Msg: pTDefaultMessage; body: string);

    procedure ClientGetSetIcon(DefMsg: pTDefaultMessage; body: string);
    procedure ClientGetHumLook(DefMsg: pTDefaultMessage);

    procedure ClientOpenBox(Msg: pTDefaultMessage; body: string);
    procedure ClientGetShopItems(Msg: pTDefaultMessage; body: string);
    procedure ClientGetTaxisList(nIdx, nNowPage, nMaxPage, nClickIdx: integer; body: string);
    //    procedure ClientGetShopItems(Msg: pTDefaultMessage; body: string);
    procedure ClientGetSayMsg(Msg: TDefaultMessage; sBody: string);
    //procedure WMDisplayChange(var message: TMessage); message WM_DISPLAYCHANGE;
    procedure OnWM_INPUTLANGCHANGEREQUEST(var WMessage: TMessage); message WM_INPUTLANGCHANGEREQUEST;
    procedure OnWM_IME_COMPOSITION(var WMessage: TMessage); message WM_IME_COMPOSITION;

    //    procedure SetInputStatus();
{$IFDEF DEBUG}
    procedure CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5: string);
    procedure CmdTest(sParam1, sParam2, sParam3, sParam4,
      sParam5: string);
    procedure ShowHumanMsg(Msg: pTDefaultMessage);

{$ENDIF}
  public
    ActionKey: Integer;
    LoginID, LoginPasswd, CharName: string;

    Certification: Integer;
    ActionLock: Boolean;
    tempidx: Integer;
    boSizeMove: Boolean;
    boInFocus: Boolean;
    m_SayMsgList: TList;
    m_SayIndex: Integer;
    CheckSpeedTick: LongWord;
    boCheckSpeed: Boolean;
    boSocketClose: Boolean;
    boOpenLoginDoor: Boolean;
    m_Point: TPoint;
    CreateChrName: string;
    m_boExit: Boolean;
    FLoginConnInfos: TLoginConnInfos;
    FLoginConnIndex: Word;
    FCheckLogin: Boolean;
    FCheckCount: Integer;
    FShowHintTick: LongWord;
    FShowHintTick2: LongWord;
    FboShowLogo: Boolean;
    FnShowLogoIndex: Integer;
    FdwShowLogoTick: LongWord;
    nLastDoorTick: LongWord;
    nLastPickupTick: LongWord;
    nLastQuickSlotChange: LongWord;
    FMissionTick: LongWord;
   // FDevMode: TDeviceMode;
    FDDrawHandle: THandle;
    FIDDraw: IDirectDraw;
    FboDisplayChange: Boolean;
    FHotKeyId: Integer;
    boShowPrintMsg: Boolean;
    AutoRunTimer: TTimer;
    m_CurrentTick : longword;

    FailAction, FailDir: Integer;

    procedure CreateClientSocket(sAddrs: string; wPort: Word; nIndex: Integer);
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure DecodeItem(sMsg: string; ItemBuf: PChar);
    procedure FullScreen(boFull: Boolean);
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMEnterSizeMove(var Message: TWMMove); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TWMMove); message WM_EXITSIZEMOVE;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMSetFocus(var WMessage: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var WMessage: TMessage); message WM_KILLFOCUS;
    procedure WMTabKey(var WMessage: TMessage); message WM_USER + 1003;
    procedure WMHotKey(var Msg: Tmessage); message WM_HOTKEY;

    //procedure WMLegendMap(var WMessage: TMessage); message WM_USER + 1004;

    //procedure ProcOnIdle;
    procedure AppOnIdle(boInitialize: Boolean = False);
    procedure OnIdle(Sender: TObject; var Done: Boolean);
    procedure AppLogout;
    procedure AppExit;
    procedure PrintScreenNow;
    procedure EatItem(idx: Integer);
    procedure GetMoveHPShow(Actor: TActor; nCount: Word);
    function EatItembyName(sItemName: string): Boolean;
    function EatItemByType(nType: Integer): Boolean;

    function GetClientVersion(): Integer;
    procedure SendClientMessage(Msg, Recog, param, tag, series: Integer; pszMsg: string = '');
    procedure SendClientSocket(Msg, Recog, param, tag, series: Integer; pszMsg: string = '');
    procedure SendLogin(uid, passwd: string);
    procedure SendCardInfo(No1, No2, No3: Word);
    procedure SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendSelectServer(svname: string);
    procedure SendChgPw(id, passwd, newpasswd: string);
    procedure SendNewChr(uid, uname, shair, sjob, ssex: string);
    procedure SendAccountCreateValidation(nWindowType: Integer);
    procedure SendQueryChr;
    procedure SendDelChr(chrname: string);
    procedure SendSelChr(chrname: string);
    procedure SendViewDelHum();
    procedure SendRenewHum(chrname: string);
    procedure SendRunLogin;
    procedure SendSay(str: string);
    procedure SendQueryBagItems();
    procedure SendActMsg(ident, X, Y, dir: Integer);
    procedure SendSitDownMsg(uid, X, Y, dir: Integer);
    procedure SendSpellMsg(ident, X, Y, dir, target: Integer);
    procedure SendQueryUserName(targetid, X, Y: Integer);
    procedure SendDropItem(name: string; itemserverindex: Integer);
    procedure SendPickup;
    procedure SendTakeOnItem(where: byte; itmindex: Integer; itmname: string);
    procedure SendTakeOffItem(where: byte; itmindex: Integer; itmname: string);
    procedure SendEat(Item: pTNewClientItem);
    procedure SendButchAnimal(X, Y, dir, actorid: Integer);
    //procedure SendMagicKeyChange(magid: Integer; keych: Char);
    procedure SendMerchantDlgSelect(merchant: Integer; rstr: string);
    procedure SendCheckMsgDlgSelect(merchant, nBut: Integer);
    //procedure SendQueryPrice(merchant, itemindex: Integer; itemname: string);
   // procedure SendQueryRepairCost(merchant, itemindex: Integer; itemname: string);
    procedure SendSellItem(merchant, itemindex: Integer {; itemname: string});
    procedure SendRepairItem(merchant, itemindex: Integer; wFlag: Word);
    procedure SendStorageItem(merchant, itemindex, nIdx: Integer {; itemname: string});
    //procedure SendGetDetailItem(merchant, menuindex: Integer; itemname: string);
    procedure SendBuyItem(merchant, itemserverindex, nCount, ItemIndex: Integer; boBindGold: Boolean; sName: string = '');
    procedure SendTakeBackStorageItem(merchant, itemserverindex, nIdx: Integer);
    //procedure SendMakeDrugItem(merchant: Integer; itemname: string);
    procedure SendDropGold(dropgold: Integer);
    procedure SendGroupMode();
    procedure SendCreateGroup(ItemClass: Integer; withwho: string);
    //procedure SendWantMiniMap;
    procedure SendDealTry(nID, nX, nY: Integer); //菊俊 荤恩捞 乐绰瘤 八荤
    procedure SendGuildDlg(index: integer);
    procedure SendCancelDeal;
    procedure SendAddDealItem(ci: TNewClientItem);
    procedure SendDelDealItem(ci: TNewClientItem);
    procedure SendTakeOnAddBagItem(idx, ItemIndex: integer);
    procedure SendTakeOffAddBagItem(idx: integer);
    procedure SendChangeDealGold(gold: Integer);
    procedure SendDealEnd;
    procedure SendDealLock;
    procedure SendAddGroupMember(withwho: string);
    procedure SendDelGroupMember(withwho: string);
    procedure SendShopList(nIdent, nIndex: Integer);
    //procedure SendGuildHome;
    procedure SendGuildMemberList(index: integer);
    procedure SendGuildAddMem(who: string);
    procedure SendGuildDelMem(who: string);
    procedure SendGuildUpdateNotice(notices: string);
    procedure SendGuildUpdateGrade(rankinfo: string);
    procedure SendMakeItem(TitleItem, LevelItem, MakeStone1, MakeStone2, MakeStone3: Integer);
    procedure SendSpeedHackUser;
    procedure SendGetSayItem(nid, ItemIndex: Integer);
    //SpeedHaker 荤侩磊甫 辑滚俊 烹焊茄促.
    //procedure SendAdjustBonus(remain: Integer; babil: TNakedAbility);
    //procedure SendPassword(sPassword: string; nIdent: Integer);
    //procedure SendShopDlg(wPage: Word);
    //procedure SendBuyShopItem(sItems: string; btType: byte);

    procedure SendShopBuyItem(nIdx, ItemIndex, wIdent, btGameGold: Integer);
    procedure SendShopGetPoint(nCount: Integer);
    //procedure SendTaxis(nIdx, nJob, nPage: Integer);

    function TargetInSwordLongAttackRange(ndir: Integer): Boolean;
    function TargetInSwordWideAttackRange(ndir: Integer): Boolean;
    function TargetInSwordCrsAttackRange(ndir: Integer): Boolean;
    procedure OnProgramException(Sender: TObject; E: Exception);
    procedure SendSocket(sendstr: string);
    procedure SendSocketEx(sendstr: string);
    function ServerAcceptNextAction: Boolean;
    function CanNextAction: Boolean;
    function CanNextActionEx: Boolean;
    function CanNextHit: Boolean;
    function IsUnLockAction(Action, adir: Integer): Boolean;
    procedure ActiveCmdTimer(cmd: TTimerCommand); overload;
    procedure MyCopyDataMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    procedure MyCheckClient(var Msg: TMessage); message WM_CHECK_CLIENT;
    procedure OpenADForm(nWidth, nHeight: Integer; sUrl: string);
    procedure MyDeviceInitialize(Sender: TObject; var Success: Boolean; var ErrorMsg: string);
    procedure MyDeviceFinalize(Sender: TObject);
    procedure MyDeviceRender(Sender: TObject);
    procedure MyDeviceNotifyEvent(Sender: TObject; Msg: Cardinal);
    procedure DisplayChange(boReset: Boolean);
    procedure AutoRunTimerTimer(Sender: TObject);
    procedure ToggleAutoRun;
{$IFDEF DEBUG}
    procedure ProcessCommand(sData: string);
{$ENDIF}
    procedure UseMagic(tx, ty: Integer; pcm: PTNewClientMagic);
  end;
function IsDebug(): Boolean;
function IsDebugA(): Boolean;
//function CheckMirProgram: Boolean;
procedure PomiTextOut(dsurface: TDirectDrawSurface; X, Y: Integer; str: string);
procedure WaitAndPass(msec: LongWord);
function GetRGB(c256: byte): LongWord;
procedure DebugOutStr(Msg: string);
function KeyboardHookProc(Code: Integer; WParam: WParam; lparam: LPARAM):
  Longint; stdcall;

var
  HGE: IHGE = nil;
  boOutbugStr: Boolean = True;
  boOutMsg: Boolean = False;
  nLeft: Integer = 10;
  nTop: Integer = 10;
  //nWidth: Integer;
  //nHeight: Integer;
  g_boShowMemoLog: Boolean = FALSE;
  g_boShowRecog: Integer = 0;
  frmMain: TfrmMain;
  DScreen: TDrawScreen;
  //IntroScene: TIntroScene;
  LoginScene: TLoginScene;
  SelectChrScene: TSelectChrScene;
  PlayScene: TPlayScene;
  SelServer: TSelServer;
  HintScene: THintScene;
  //LoginNoticeScene: TLoginNotice;

  LocalLanguage: TImeMode = imSHanguel;

  //MP3: TMPEG;
  TestServerAddr: string = '127.0.0.1';
  BGMusicList: TStringList;
  //DObjList: TList;  //官蹿俊 函版等 瘤屈狼 钎泅
  EventMan: TClEventManager;
  KornetWorld: TKornetWorld;
  Map: TMap;
  //  BoOneClick: Boolean;
  OneClickMode: TOneClickMode;
  {$region 'test variables from speed testing'}
  m_runtest :longword;
  m_runtestcounter: integer;
  m_runtestcountv2 : integer;
  m_runtesthigh: integer;
  m_runtestlow: integer;
  m_runtestaverage: double;
  m_walkTick: longword;
  m_horserunTick: longword;
  m_runTick: longword;
  m_nRunWarning: integer;
  g_OrigServerDateTime: TDateTime;
  g_OrigServerDateTick: longword;
  g_OrigServerDiff : integer;
  m_ScanTick: longword;
  m_boDoForceScan: boolean;
  boRunTimer: Boolean = False;
  {$endregion}
  //  m_boPasswordIntputStatus: Boolean = FALSE;

implementation

uses
  HerbActor, GameSetup, Common, FState3, FState2, FState, FState4, FindMapPath, MudUtil, WMFile, HGEBase,
  MD5Unit, Registry, FWeb, MNShare, CheckDLL, MyCommon, UrlMon, Logo, EncryptFile, FrmAD, ShellAPI, DlgConfig, GuaJi, mmsystem;

{$R *.DFM}
{$R NewCursor.RES}
{$R ColorTable.RES}
var
{$IFDEF DEBUG}
  ShowMsgActor: TActor;
{$ENDIF}
  //g_boInitialize: Byte;
 (*
function CheckMirProgram: Boolean;
var
  pstr: array[0..255] of Char;
  mirapphandle: HWnd;
begin
  Result := FALSE;
  StrPCopy(pstr, 'legend of mir2');
  mirapphandle := FindWindow(nil, pstr);
  if (mirapphandle <> 0) and (mirapphandle <> Application.Handle) then begin
{$IFNDEF COMPILE}
    SetActiveWindow(mirapphandle);
    Result := True;
{$ENDIF}
    Exit;
  end;
end;
       *)

procedure PomiTextOut(dsurface: TDirectDrawSurface; X, Y: Integer; str: string);
var
  i, n: Integer;
  d: TDirectDrawSurface;
begin
  for i := 1 to Length(str) do begin
    n := byte(str[i]) - byte('0');
    if n in [0..9] then begin //箭磊父 凳
      d := g_WMain99Images.Images[1821 + n];
      if d <> nil then
        dsurface.Draw(X + i * 8, Y, d.ClientRect, d, True);
    end
    else begin
      if str[i] = '-' then begin
        d := g_WMain99Images.Images[1831];
        if d <> nil then
          dsurface.Draw(X + i * 8, Y, d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure WaitAndPass(msec: LongWord);
var
  start: LongWord;
begin
  start := FrmMain.m_CurrentTick;
  while FrmMain.m_CurrentTick - start < msec do begin
    Application.ProcessMessages;
  end;
end;

function GetRGB(c256: byte): LongWord;
begin
  Result := RGB(g_ColorTable[c256].rgbRed,
    g_ColorTable[c256].rgbGreen,
    g_ColorTable[c256].rgbBlue);
end;

procedure DebugOutStr(Msg: string);
var
  flname: string;
  fhandle: TextFile;
begin
  //DScreen.AddChatBoardString(msg,clWhite, clBlack);
  if not boOutbugStr then
    Exit;
  flname := '.\!debug.txt';
  if FileExists(flname) then begin
    AssignFile(fhandle, flname);
    Append(fhandle);
  end
  else begin
    AssignFile(fhandle, flname);
    Rewrite(fhandle);
  end;
  WriteLn(fhandle, DateTimeToStr(Now) + ' ' + Msg);
  CloseFile(fhandle);
end;

Type
  TNEWDISPLAY_DEVICEW = packed record
    cb: DWORD;
    DeviceName: array[0..31] of AnsiChar;
    DeviceString: array[0..127] of AnsiChar;
    StateFlags: DWORD;
    DeviceID: array[0..127] of AnsiChar;
    DeviceKey: array[0..127] of AnsiChar;
  end;

  TNewEnumDisplayDevices = function(Unused: Pointer; iDevNum: DWORD; var lpDisplayDevice: TNEWDISPLAY_DEVICEW; dwFlags: DWORD): BOOL; stdcall;
  TNewChangeDisplaySettings = function(lpDevMode: Pointer; dwFlags: DWORD): Longint; stdcall;

procedure TfrmMain.FormCreate(Sender: TObject);
  function ReadBool(Reg: TRegistry; sName: string; Default: Boolean): Boolean;
  begin
    Try
      Result := Reg.ReadBool(sName);
    Except
      Result := Default;
    End;
  end;

  function ReadInteger(Reg: TRegistry; sName: string; Default: Integer): Integer;
  begin
    Try
      Result := Reg.ReadInteger(sName);
    Except
      Result := Default;
    End;
  end;
var
  flname: string;
  I: Integer;
  Res: TResourceStream;
  Reg: TRegistry;
  dv: TNEWDISPLAY_DEVICEW;
  MODULE: HMODULE;
  NewEnumDisplayDevices: TNewEnumDisplayDevices;
  NewChangeDisplaySettings: TNewChangeDisplaySettings;
  REGPathStr: string;
  ini: TIniFile;
begin
  Res := TResourceStream.Create(Hinstance, '256RGB', 'RGB');
  try
    Res.Read(g_ColorTable, SizeOf(g_ColorTable));
  finally
    Res.Free;
  end;
  TimeBeginPeriod(1);
  m_CurrentTick := Timegettime();
  m_runtest := 0;
  m_runtesthigh := 0;
  m_runtestlow := 9999;
  m_runtestaverage := 0;
  m_runtestcounter := 0;
  m_runtestcountv2 := 0;
  m_WalkTick := FrmMain.m_CurrentTick;
  m_RunTick := FrmMain.m_CurrentTick;
  m_HorseRunTick := FrmMain.m_CurrentTick;
  m_ScanTick := 0;
  m_boDoForceScan := False;
  m_nRunWarning := 0;
  g_nCurMerRate := 100;
  {
  SetWindowPos(handle, HWND_NOTOPMOST, left, top, width, height, SWP_SHOWWINDOW);
  }
  boBITDEPTH := False;
  REGPathStr := '';

  MODULE := LoadLibrary('user32.dll');
  Reg := TRegistry.Create;

  {Try
 {   NewEnumDisplayDevices := GetProcAddress(MODULE, 'EnumDisplayDevicesA');
    NewChangeDisplaySettings := GetProcAddress(MODULE, 'ChangeDisplaySettingsA');
    if Assigned(NewEnumDisplayDevices) then begin
      dv.cb := SizeOf(dv);
      NewEnumDisplayDevices(nil, 0, dv, 0);
      REGPathStr := dv.DeviceKey;
      REGPathStr := GetValidStr3(REGPathStr, flname, ['\']);
      REGPathStr := GetValidStr3(REGPathStr, flname, ['\']);
    end;
    Try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey(REG_SETUP_OPATH, True) then begin
        boBITDEPTH := ReadBool(Reg, REG_SETUP_BITDEPTH, boBITDEPTH);
        g_FScreenMode := ReadInteger(Reg, REG_SETUP_DISPLAY, g_FScreenMode);
        g_boFullScreen := not ReadBool(Reg, REG_SETUP_WINDOWS, True);
        g_btMP3Volume := ReadInteger(Reg, REG_SETUP_MP3VOLUME, g_btMP3Volume);
        g_btSoundVolume := ReadInteger(Reg, REG_SETUP_SOUNDVOLUME, g_btSoundVolume);
        g_boBGSound := ReadBool(Reg, REG_SETUP_MP3OPEN, g_boBGSound);
        g_boSound := ReadBool(Reg, REG_SETUP_SOUNDOPEN, g_boSound);
      end;
      Reg.CloseKey;

      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey(REG_SETUP_PATH, True) then begin
        boBITDEPTH := ReadBool(Reg, REG_SETUP_BITDEPTH, boBITDEPTH);
        g_FScreenMode := ReadInteger(Reg, REG_SETUP_DISPLAY, g_FScreenMode);
        g_boFullScreen := not ReadBool(Reg, REG_SETUP_WINDOWS, not g_boFullScreen);
        g_btMP3Volume := ReadInteger(Reg, REG_SETUP_MP3VOLUME, g_btMP3Volume);
        g_btSoundVolume := ReadInteger(Reg, REG_SETUP_SOUNDVOLUME, g_btSoundVolume);
        g_boBGSound := ReadBool(Reg, REG_SETUP_MP3OPEN, g_boBGSound);
        g_boSound := ReadBool(Reg, REG_SETUP_SOUNDOPEN, g_boSound);
      end;
      Reg.CloseKey;

      if (REGPathStr <> '') and (Assigned(NewChangeDisplaySettings)) then begin
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKey(REGPathStr, True) then begin
          if ReadInteger(Reg, 'Acceleration.Level', 0) <> 0 then begin
            Reg.DeleteValue('Acceleration.Level');
            NewChangeDisplaySettings(nil, $40);
          end;
        end;
      end;

      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey('SOFTWARE\Microsoft\DirectDraw', True) then begin
        if ReadInteger(Reg, 'EmulationOnly', 0) <> 0 then Reg.WriteInteger('EmulationOnly', 0);
        if ReadInteger(Reg, 'DisableAGPSupport', 0) <> 0 then Reg.WriteInteger('DisableAGPSupport', 0);
      end;
      Reg.CloseKey;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey('SOFTWARE\Microsoft\Direct3D\Drivers', True) then begin
        if ReadInteger(Reg, 'SoftwareOnly', 0) <> 0 then Reg.WriteInteger('SoftwareOnly', 0);
      end;
      Reg.CloseKey;
    Except
    End;
  Finally
    Reg.Free;
    FreeLibrary(MODULE);
  End; }

  //showmessage(dateTimetostr(LongWordToDateTime(DateTimeToLongWord(Now))));
  //showmessage(inttostr(sizeof(TDXTexture)));
  //flname := '‐舞娘';
  //GetValidStr3(flname, flname, ['\']);
  //LoadCursorFromFile(
  FDDrawHandle := 0;
  FIDDraw := nil;
  boShowPrintMsg := True;
  //EnumDisplaySettings(nil, $FFFFFFFF, FDevMode);

  //EnumDisplayDevices(0, 0, DV, 0);
  AutoRunTimer := TTimer.Create(self);
  AutoRunTimer.OnTimer := AutoRunTimerTimer;
  AutoRunTimer.Enabled := false;
  AutoRunTimer.Interval := 50;
  FboDisplayChange := False;
  g_btMapinitializePos := 0;
  FLoginConnIndex := 0;
  FCheckLogin := False;
  g_sMainParam1 := ParamStr(1);
  g_sMainParam2 := ParamStr(2);
  g_sMainParam3 := ParamStr(3);
  g_sMainParam4 := ParamStr(4);
  g_sMainParam5 := ParamStr(5);
  g_sMainParam6 := ParamStr(6);
  FShowHintTick := 0;
  FShowHintTick2 := 0;
  nLastDoorTick := 0;
  nLastPickupTick := 0;
  nLastQuickslotChange := 0;
  FillChar(g_ServerInfo, SizeOf(g_ServerInfo), #0);
  g_Login_Handle := StrToIntDef(ParamStr(1), 0);
  g_ServerInfoCount := 0;
  FboShowLogo := False;
  FnShowLogoIndex := 0;
  FdwShowLogoTick := FrmMain.m_CurrentTick;
  FrmWeb := TFrmWeb.Create(Self);
  FrmWeb.Left := 5;
  FrmWeb.Top := 39;
  FrmWeb.ClientWidth := 790;
  FrmWeb.ClientHeight := 546;
  FrmWeb.Parent := Self;
  GetFileVersion(ParamStr(0), @g_FileVersionInfo);
  Randomize;
  InitializeCriticalSection(FCriticalSection);
  mousemovetime := FrmMain.m_CurrentTick;

  //DXDraw.AutoInitialize := True;
  Screen.Cursors[crMyDeal] := LoadCursor(HInstance, MAKEINTRESOURCE('Deal'));
  Screen.Cursors[crOpenBox] := LoadCursor(HInstance, MAKEINTRESOURCE('OpenBox'));
  Screen.Cursors[crMySell] := LoadCursor(HInstance, MAKEINTRESOURCE('SellCursor'));
  Screen.Cursors[crMyBuy] := LoadCursor(HInstance, MAKEINTRESOURCE('BuyCursor'));
  Screen.Cursors[crMyRepair] := LoadCursor(HInstance, MAKEINTRESOURCE('RepairCursor'));
  Screen.Cursors[crMySelItem] := LoadCursor(HInstance, MAKEINTRESOURCE('SelItem'));
  Screen.Cursors[crSrepair] := LoadCursor(HInstance, MAKEINTRESOURCE('Srepair'));
  HGE := HGECreate(HGE_VERSION);
  if boBITDEPTH then
    HGE.System_SetState(HGE_SCREENBPP, 32)
  else
    HGE.System_SetState(HGE_SCREENBPP, 16);

  //ChangeDisplaySettingsW(nil, CDS_RESET);
  m_FreeTextureTick := FrmMain.m_CurrentTick;
  m_FreeTextureIndex := 0;
  m_boExit := False;
  g_StditemList := TList.Create;
  g_StditemFiltrateList := TList.Create;
  boSocketClose := False;
  tempidx := 0;
  CheckSpeedTick := 0;
  TempItemList := TList.Create;
  g_SetItemsList := TList.Create;
  mousechecktime := FrmMain.m_CurrentTick;
  g_DWinMan := TDWinManager.Create(Self);

  //g_DXDraw := DXDraw;

  boSizeMove := False;
  boInFocus := True;
  g_boSendLuck := False;
  boOpenLoginDoor := False;
  g_dwDefTime := FrmMain.m_CurrentTick;
  g_EMailList := TQuickStringPointerList.Create;
  //ripman
  //g_GetSayItemList := TList.Create;        //ripman
 ini := TIniFile.Create('.\servers.ini');
  if ini <> nil then begin
	  g_ServerInfoCount := ini.ReadInteger('Options', 'ServerCount', g_ServerInfoCount);
    for I := 0 to _Max(g_ServerInfoCount,High(g_ServerInfo) + 1) - 1 do begin
      g_ServerInfo[i].sName := ini.ReadString('Server' + inttostr(i), 'ServerName', '');
      g_ServerInfo[i].sAddrs := ini.ReadString('Server' + inttostr(i), 'ServerAddr', '127.0.0.1');
      g_ServerInfo[i].nPort := ini.ReadInteger('Server' + inttostr(i), 'ServerPort', 7000);
      g_ServerInfo[i].sAddrs2 := ini.ReadString('Server' + inttostr(i), 'SelCharAddr', g_ServerInfo[i].sAddrs);
      g_ServerInfo[i].nPort2 := ini.ReadInteger('Server' + inttostr(i), 'SelCharPort', 7100);
      g_ServerInfo[i].sAddrs3 := ini.ReadString('Server' + inttostr(i), 'GameAddr', g_ServerInfo[i].sAddrs);
      g_ServerInfo[i].nPort3 := ini.ReadInteger('Server' + inttostr(i), 'GamePort', 7200);

    end;
    ini.Free;
    end;
  ini := TIniFile.Create('.\mir2.ini');
  if ini <> nil then begin
    g_boFullScreen := ini.ReadBool('Options', 'FullScreen', g_boFullScreen);
    g_nInterface := ini.ReadInteger('Options', 'InterfaceType', g_nInterface);
    g_FScreenMode := ini.ReadInteger('Options', 'ScreenMode', g_FScreenMode);
    boBITDEPTH := ini.ReadBool('Options', 'BitDepth', boBITDEPTH);
    g_btMP3Volume := ini.ReadInteger('Options', 'MP3Volume', g_btMP3Volume);
    g_btSoundVolume := ini.ReadInteger('Options', 'SoundVolume', g_btSoundVolume);
    g_boBGSound := ini.ReadBool('Options', 'BGSound', g_boBGSound);
    g_boSound := ini.ReadBool('Options', 'Sound', g_boSound);
    //Options Tab
    g_SetupInfo.boShowItemName := ini.ReadBool('Basic Settings', 'DropItemsShow', g_SetupInfo.boShowItemName);
    if ini.ReadInteger('Basic Settings', 'SwitchPoisonOrder', -1) < 0 then ini.WriteBool('Basic Settings', 'SwitchPoisonOrder', g_SetupInfo.boSwitchPoison);
    g_SetupInfo.boSwitchPoison := ini.ReadBool('Basic Settings', 'SwitchPoisonOrder', g_SetupInfo.boSwitchPoison);
    ini.Free;
  end;
  {FtpConf := TIniFile.Create('.\mir2.ini');
  if FtpConf <> nil then begin
    g_sLogoText := FtpConf.ReadString('Server', 'Server1Caption', g_sLogoText);
    FtpConf.Free;
  end; }
  if g_nInterface = 2 then g_FScreenMode := 2;
  g_nInterfaceState := g_nInterface;

  case g_FScreenMode of
    1:
      begin
        g_FScreenWidth := DEFWIDESCREENWIDTH;
        g_FScreenHeight := DEFWIDESCREENHEIGHT;
      end;
    2:
      begin
        g_FScreenWidth := DEFMAXSCREENWIDTH;
        g_FScreenHeight := DEFMAXSCREENHEIGHT;
      end;
    3:
      begin
        g_FScreenWidth := DEFSCREENWIDTH;
        g_FScreenHeight := DEFSCREENHEIGHT;
      end;
  end;

  if g_nInterface = 1 then begin
    GUIFScreenWidth := g_FScreenWidth;
    GUIFScreenHeight := g_FScreenHeight;
  end
  else if g_nInterface = 2 then begin
    GUIFScreenWidth := DEFMAXSCREENWIDTH;
    GUIFScreenHeight := DEFMAXSCREENWIDTH;
  end;

  {.$IFDEF DEBUG}
  {.$ENDIF}

  m_SayMsgList := TList.Create;
  ClientWidth := DEFSCREENWIDTH;
  ClientHeight := DEFSCREENHEIGHT;
  //g_boFullScreen := False;//thedeath, if you change this to true it forces client to go fullscreen BEFORE switching to window mode, and fucks up windows resolutions!
  if g_boFullScreen then begin
    BorderStyle := bsNone;
    //HGE.System_SetState(HGE_WINDOWED, False);
    BorderStyle := bsNone;
    BorderIcons := [];
//    g_boDisableFlip := True;
    frmMain.Left := 0;
    frmMain.Top := 0;
    //HGE.System_SetState(HGE_WINDOWED, False);

    //ClientWidth := DEFMAXSCREENWIDTH;
    //ClientHeight := DEFMAXSCREENHEIGHT;

    WindowState := wsMaximized;

    DisplayChange(False);

    m_Point := ClientOrigin;
  end
  else begin
    BorderStyle := bsSingle;
    Left := (Screen.width - ClientWidth) div 2;
    Top := (Screen.Height - ClientHeight) div 2 - 40;
  end;
  HGE.System_SetState(HGE_FScreenWidth, DEFSCREENWIDTH);
  HGE.System_SetState(HGE_FScreenHeight, DEFSCREENHEIGHT);
  HGE.System_SetState(HGE_WINDOWED, True);

  //MyDevice.Width := g_FScreenWidth;
  //MyDevice.Height := g_FScreenHeight;
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  HGE.System_SetState(HGE_HWNDPARENT, Handle);
  HGE.System_SetState(HGE_SHOWSPLASH, False);
  HGE.System_SetState(HGE_HARDWARE, True);
  HGE.System_SetState(HGE_TEXTUREFILTER, True);
  HGE.System_SetState(HGE_FPS, HGEFPS_VSYNC);
  HGE.System_SetState(HGE_INITIALIZE, MyDeviceInitialize);
  HGE.System_SetState(HGE_FINALIZE, MyDeviceFinalize);
  HGE.System_SetState(HGE_NOTIFYEVENT, MyDeviceNotifyEvent);
  //HGE.Gfx_Restore(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT, 16);
  {g_boFullScreen := True;
  //全屏   }
  if not DirectoryExists(g_sPhotoDirname) then
    CreateDir(g_sPhotoDirname);
  //end;
  Caption := g_sLogoText;
  LoadWMImagesLib(nil);

  g_WMusicImages.FileName := MUSICFILE;
  g_WMusicImages.LibType := ltFileData;
  g_WMusicImages.Initialize;

  g_WSettingImages.FileName := SETTINGFILE;
  g_WSettingImages.LibType := ltFileData;
  g_WSettingImages.Initialize;

  g_WgHintList := TStringList.Create;
  g_DControlFreeList := TList.Create;
  //g_ShowMsgDlgList := TList.Create;

  //g_ItemFiltrateList := TList.Create;
  g_MasterHDInfoList := TList.Create;
  g_QuestMsgList := TList.Create;
  g_DXSound := TDXSound.Create(Self);

  //DXDraw.Color := clBlack;
  //Label1.Left := (g_FScreenWidth - label1.Width) div 2;
  //Label1.Top :=  (g_FScreenHeight - label1.Height) div 2;
  //DXDraw.Display.Width := g_FScreenWidth;
  //DXDraw.Display.Height := g_FScreenHeight;
  try
    g_DXSound.Initialize;
    if g_DXSound.Initialized then begin
      g_Sound := TSoundEngine.Create(g_DXSound.DSound);
      g_Sound.Volume := g_btSoundVolume;
      //MP3 := TMPEG.Create(nil);
    end
    else begin
      g_Sound := nil;
      //MP3 := nil;
    end;
  except
    g_Sound := nil;
  end;
  g_ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHookProc, 0, GetCurrentThreadID);
  g_DXFont := TDXFont.Create;

  g_SoundList := TStringList.Create;
  BGMusicList := TStringList.Create;
  g_MapDescList := TList.Create;
  g_MapEffectList := TStringList.Create;
  g_ShopHintList := TStringList.Create;
  g_CompoundInfoList := TGStringList.Create;

  ZeroMemory(@g_CompoundSet, SizeOf(TCompoundSet));
  ZeroMemory(@g_AbilityMoveSet, SizeOf(TAbilityMoveSet));

  flname := '.\wav\sound.lst';
  LoadSoundList(flname);
  flname := WAVDIRNAME + 'sound.lst';
  LoadBGMusicList(flname);
  InitializeSound();
  g_boAllLoadStream := False;
  g_MissionDateStream := TMemoryStream.Create;
  g_StditemsDateStream := TMemoryStream.Create;
  g_MagicDateStream := TMemoryStream.Create;
  g_MapDescDateStream := TMemoryStream.Create;
  g_MakeMagicDateStream := TMemoryStream.Create;
  g_BannedAppsDataStream := TMemoryStream.Create;
  Try
    g_MissionDateStream.LoadFromFile(GETMISSIONDESCFILE);
  Except
  End;
  Try
    g_StditemsDateStream.LoadFromFile(GETSTDITEMSDESCFILE);
  Except
  End;
  Try
    g_MagicDateStream.LoadFromFile(GETMAGICDESCFILE);
  Except
  End;
  Try
    g_MapDescDateStream.LoadFromFile(GETMAPDESCFILE);
  Except
  End;
  Try
    g_MakeMagicDateStream.LoadFromFile(GETMAKEMAGICFILE);
  Except
  End;
  Try
    g_BannedAppsDataStream.LoadFromFile(GETBADAPPSFILE);
  Except
  End;

  for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do
    g_MakeMagicList[I] := TList.Create;

  //LoadStditemList();
  //LoadMagicList();

  LoadMapEffectList();
  //LoadShopHintList();
  //LoadMissionList();
  //LoadMasterHDInfo();
  {if FileExists('.\Data\explain2.dat') then
    g_WgHintList.LoadFromFile('.\Data\explain2.dat');}
  //if FileExists (flname) then
  //   SoundList.LoadFromFile (flname);

  DScreen := TDrawScreen.Create;
  //IntroScene := TIntroScene.Create;
  LoginScene := TLoginScene.Create;
  SelectChrScene := TSelectChrScene.Create;
  PlayScene := TPlayScene.Create;
  HintScene := THintScene.Create;
  SelServer := TSelServer.Create;
  //LoginNoticeScene := TLoginNotice.Create;
  g_FriendList := TStringList.Create;
  g_MyWhisperList := TStringList.Create;
  g_MyBlacklist := TStringList.Create;

  Map := TMap.Create;
  g_nMiniMapPath := nil;
  m_boCheckAppend := False;
  //g_LegendMap := nil;
  g_LegendMap := TLegendMap.Create;
  //g_GuaJi := TGuaJi.Create;
  g_DropedItemList := TList.Create;
  //g_MagicList := TList.Create;
  g_FreeActorList := TList.Create;
  g_FreeItemList := TList.Create;
  //DObjList := TList.Create;
  EventMan := TClEventManager.Create;
  g_ChangeFaceReadyList := TList.Create;

  g_MySelf := nil;

  SafeFillChar(g_UseItems, sizeof(g_UseItems), #0);
  //   SafeFillChar (UseItems, sizeof(TClientItem)*9, #0);
  SafeFillChar(g_ItemArr, sizeof(g_ItemArr), #0);
  SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
  SafeFillChar(g_DealRemoteItems, sizeof(g_DealRemoteItems), #0);

  SafeFillChar(g_TaxisSelf, SizeOf(g_TaxisSelf), #0);

  for I := Low(g_StorageArrList) to High(g_StorageArrList) do
    g_StorageArrList[i] := TList.Create;

  SafeFillChar(g_ShopLoading, SizeOf(g_ShopLoading), 0);

  SafeFillChar(g_MyShopSellItems, SizeOf(g_MyShopSellItems), 0);
  SafeFillChar(g_MyShopBuyItems, SizeOf(g_MyShopBuyItems), 0);

  //SafeFillChar(g_MouseShopItems,SizeOf(TShopItem),#0);
  //DXDraw.Initialize
  g_SaveItemList := TList.Create;
  g_MenuItemList := TList.Create;
  g_WaitingUseItem.Item.S.name := '';
  //馒侩芒 辑滚客 烹脚埃俊 烙矫历厘
  g_EatingItem.Item.S.name := '';

  g_nTargetX := -1;
  g_nTargetY := -1;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_FocusItem := nil;
  g_MagicTarget := nil;
  g_MagicLockTarget := nil;
  g_NPCTarget := nil;
  g_nDebugCount := 0;
  g_nDebugCount1 := 0;
  g_nDebugCount2 := 0;
  g_nTestSendCount := 0;
  g_nTestReceiveCount := 0;
  g_boServerChanging := FALSE;
  g_boAutoDig := FALSE;

  for I := Low(g_ShopList) to High(g_ShopList) do
    g_ShopList[i] := TList.Create;
  for I := Low(g_ShopGoldList) to High(g_ShopGoldList) do
    g_ShopGoldList[i] := TList.Create;
  g_ShopBuyItem := nil;
  g_dwLatestClientTime2 := 0;
  g_dwFirstClientTime := 0;
  g_dwFirstServerTime := 0;
  g_dwFirstClientTimerTime := 0;
  g_dwLatestClientTimerTime := 0;
  g_dwFirstClientGetTime := 0;
  g_dwLatestClientGetTime := 0;

  g_nTimeFakeDetectCount := 0;
  g_nTimeFakeDetectTimer := 0;
  g_nTimeFakeDetectSum := 0;

  g_dwSHGetTime := 0;
  g_dwSHTimerTime := 0;
  g_nSHFakeCount := 0;

  //g_nDayBright := 3;
  g_nAreaStateValue := 0;
  g_ConnectionStep := cnsSelServer;

  g_boSendLogin := FALSE;
  g_boServerConnected := FALSE;
  SocStr := '';
  WarningLevel := 0; //阂樊菩哦 荐脚 冉荐 (菩哦汗荤 啊瓷己 乐澜)
  ActionFailLock := FALSE;
  //g_boMapMoving := FALSE;
  g_boMapMovingWait := FALSE;
  g_boMapInitialize := False;
  g_boMapApoise := False;
  g_boCheckBadMapMode := FALSE;
  g_boCheckSpeedHackDisplay := FALSE;
  //g_boViewMiniMap := True;
  //g_boShowGreenHint := True;
  PrevVMMStyle := 1;
  g_boShowWhiteHint := True;
  FailDir := 0;
  FailAction := 0;
  g_nDupSelection := 0;

  g_dwLastAttackTick := FrmMain.m_CurrentTick;
  g_dwLastMoveTick := FrmMain.m_CurrentTick;
  g_dwLatestSpellTick := FrmMain.m_CurrentTick;
  g_boLatestSpell := False;

  g_dwAutoPickupTick := FrmMain.m_CurrentTick;
  g_boFirstTime := True;
  g_boItemMoving := FALSE;
  g_boDoFadeIn := FALSE;
  g_boDoFadeOut := FALSE;
  g_boDoFastFadeOut := FALSE;
  g_boAttackSlow := FALSE;
  g_boMoveSlow := FALSE;
  g_boNextTimePowerHit := FALSE;
  g_boCanLongHit := FALSE;
  g_boCanWideHit := FALSE;
  g_boCanCrsHit := FALSE;
  g_boCanDoubleSlash := FALSE;
  g_boCanFlashDashHit := FALSE;
  g_boCanPoisonSwordHit := FALSE;
  g_boCanTwnHit := FALSE;
  g_boCan110Hit := FALSE;
  g_boCan111Hit := FALSE;
  g_boCan112Hit := FALSE;
  g_boCan113Hit := FALSE;
  g_boCan122Hit := False;
  g_boCan56Hit := False;
  g_boCanLongIceHit := False;

  g_boNextTimeFireHit := FALSE;

  //g_boNoDarkness := FALSE;
  g_SoftClosed := FALSE;

  //g_boAllowGroup := FALSE;
  g_GroupMembers := TList.Create;
  g_ItemEffects := TList.Create;
  SetDefKeyInfo();

  MainWinHandle := Handle;
  FrmMainWinHandle := Handle;
  g_FrmMainWinHandle := Handle;

  //盔努腐, 内齿岿靛 殿..
  //BoOneClick := FALSE;
  OneClickMode := toNone;

  //g_boSound := True;
  //g_boBGSound := True;

  if g_sMainParam1 = '' then begin
    CSocket.Address := '';
    CSocket.Host := g_ServerInfo[0].sAddrs;
    CSocket.Port := g_ServerInfo[0].nPort;
  end
  else begin
    if (g_sMainParam1 <> '') and (g_sMainParam2 = '') then
      CSocket.Address := '';
      CSocket.Host := g_sMainParam1;
    if (g_sMainParam2 <> '') and (g_sMainParam3 = '') then begin
      CSocket.Address := '';
      CSocket.Host := g_sMainParam1;
      CSocket.Port := StrToIntDef(g_sMainParam2, 0);
    end;
    if (g_sMainParam3 <> '') then begin
      CSocket.Address := '';
      CSocket.Host := g_sMainParam2;
      CSocket.Port := StrToIntDef(g_sMainParam3, 0);
    end;
  end;
  
  //CSocket.Active := True;
  //MainSurface := nil;
  DebugOutStr('----------------------- started ------------------------');
  {$define thedeath} //addthe s to make it run
  {$ifdef thedeaths}
  DebugOutStr(EncodeString('am740.exe'));
  {$endif}
  {QueryPerformanceFrequency(Frequency);
  QueryPerformanceCounter(OldCounter);
  CheckSpeedTime := FrmMain.m_CurrentTick;      }
  Application.OnException := OnProgramException;
  FrmDlg := TFrmDlg.Create(nil);
  FrmDlg2 := TFrmDlg2.Create(nil);
  FrmDlg3 := TFrmDlg3.Create(nil);
  FrmDlg4 := TFrmDlg4.Create(nil);
  //Application.OnIdle := OnIdle;
end;

procedure TfrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  DebugOutStr(E.Message);
end;

procedure TfrmMain.OnWM_IME_COMPOSITION(var WMessage: TMessage);
var
  H: HIMC;
  CForm: TCompositionForm;
begin
  if (WMessage.LParam and GCS_RESULTSTR) <> 0 then begin
    H := Imm32GetContext(Handle);
    if H <> 0 then begin
      with CForm do begin
        dwStyle := CFS_POINT;
        ptCurrentPos.x := FrmIMEX + 20;
        ptCurrentPos.y := FrmIMEY;
      end;
      Imm32SetCompositionWindow(H, @CForm);
      Imm32ReleaseContext(Handle, H);
    end;
  end;
  inherited;
end;

procedure TfrmMain.OnWM_INPUTLANGCHANGEREQUEST(var WMessage: TMessage);
begin
  if FrmShowIME or ImmIsIME(GetKeyboardLayout(0)) then begin
    inherited;
  end;
end;

procedure TfrmMain.OpenADForm(nWidth, nHeight: Integer; sUrl: string);
begin
  if not g_boFullScreen then begin
    if not Assigned(FormAD) then begin
      FormAD := TFormAD.Create(Owner);
      FormAD.Open(nWidth, nHeight, sUrl);
    end;
  end;
end;

procedure TfrmMain.WMSetFocus(var WMessage: TMessage);
begin
  boInFocus := True;
  inherited;
end;

procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = SC_MINIMIZE then begin
    boSizeMove := True;
    DisplayChange(True);
  end
  else if Message.CmdType = SC_RESTORE then begin
    boSizeMove := False;
    if g_boFullScreen then DisplayChange(False);
  end;
  //DebugOutStr(inttostr(Message.CmdType));
  inherited;
end;
{
procedure TfrmMain.WMDisplayChange(var message: TMessage);
begin
if (Tag = 1) then Exit;
if (MyDevice.Initialize) and (MyDevice.Windowed) then
  MyDevice.Reset();
end;     }

procedure TfrmMain.WMEnterSizeMove(var Message: TWMMove);
begin
  //boSizeMove := True;
  inherited;
end;

procedure TfrmMain.WMExitSizeMove(var Message: TWMMove);
begin
  //boSizeMove := False;
  inherited;
end;

procedure TfrmMain.WMHotKey(var Msg: Tmessage);
begin
  if (Msg.LparamLo = MOD_ALT) and (Msg.LParamHi = VK_TAB) then begin
    PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  end;
end;

procedure TfrmMain.WMKillFocus(var WMessage: TMessage);
begin
  boInFocus := False;
  inherited;
end;

{
procedure TfrmMain.WMLegendMap(var WMessage: TMessage);
begin
  g_LegendMapRun := False;
  if g_LegendMapName <> '' then
    g_LegendMap.LoadMap;
  inherited;
end;       }

procedure TfrmMain.WMMove(var Message: TWMMove);
begin
  m_Point := ClientOrigin;
  inherited;
end;

procedure TfrmMain.WMTabKey(var WMessage: TMessage);
var
  Key: Char;
  nKey: Word;
begin
  Key := #9;
  nKey := VK_TAB;
  FormKeyDown(self, nKey, []);
  FormKeyPress(self, Key);
  FormKeyUp(self, nKey, []);
end;

function KeyboardHookProc(Code: Integer; WParam: WParam; lparam: LPARAM): Longint; stdcall;
begin
  if Code < 0 then
    Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, lparam)
  else begin
    if g_CanTab and (WParam = 9) and ((lParam and $80000000) = 0) then begin
      PostMessage(FrmMain.Handle, WM_USER + 1003, 0, 0);
      Result := 1;
    end
    else
      Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, lparam);
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i: Integer;
  II: Integer;
begin
  TimeEndPeriod(1);
  //g_boChangeWin := False;
  //ClearShowItemList();
  //g_ShowItemList.Free;
  FIDDraw := nil;
  if FDDrawHandle > 0 then
    FreeLibrary(FDDrawHandle);

  g_WMusicImages.Finalize;
  g_WMusicImages.Free;
  g_WSettingImages.Finalize;
  g_WSettingImages.Free;

  ClearMapDescList;
  ClearMapEffectList;
  ClearMasterHDInfo(g_MasterHDInfoList);
  //ClearMsgDlgList();
  //g_ShowMsgDlgList.Free;
  g_MasterHDInfoList.Free;
  m_SayMsgList.Free;
  TempItemList.Free;
  g_MapDescList.Free;
  g_MapEffectList.Free;
  for I := 0 to g_SetItemsList.Count - 1 do
    Dispose(pTSetItems(g_SetItemsList[I]));
    
  for i := 0 to g_CompoundInfoList.Count - 1 do
    Dispose(pTCompoundInfos(g_CompoundInfoList.Objects[i]));
  FreeAndNil(g_CompoundInfoList);

  g_SetItemsList.Free;
  g_ShopHintList.Free;
  ClearEMailInfo();
  g_EMailList.Free;
  for I := Low(g_StorageArrList) to High(g_StorageArrList) do
    g_StorageArrList[i].Free;
  g_DControlFreeList.Free;
  //ClearGetSayItemList();
  //g_GetSayItemList.Free;
  //FreeLibrary(Moudle);
  for I := 2 to 5 do begin
    for II := 0 to g_ShopList[i].Count - 1 do begin
      Dispose(pTShopItem(g_ShopList[i].Items[ii]));
    end;
    g_ShopList[i].Free;
  end;
  for I := Low(g_ShopGoldList) to High(g_ShopGoldList) do begin
    g_ShopGoldList[i].Free;
  end;
  for I := Low(g_MakeMagicList) to High(g_MakeMagicList) do
    g_MakeMagicList[I].Free;
  g_ShopList[0].Free;
  g_ShopList[1].Free;
  g_WgHintList.Free;
  g_ShopBuyItem := nil;
  for i := 0 to g_ItemEffects.Count - 1 do
    Dispose(pTItemEffect(g_ItemEffects[i]));
  g_ItemEffects.Free;

  //g_ShowItemList := nil;
  //g_AutoPickupList.Free;
  //g_AutoPickupList := nil;
  g_FriendList.Free;
  g_MyWhisperList.Free;
  g_MyBlacklist.Free;
  //ClearItemRule();
  //g_ItemFiltrateList.Free;
  if g_ToolMenuHook <> 0 then
    UnhookWindowsHookEx(g_ToolMenuHook);
  //SoundCloseProc;
  //DXTimer.Enabled := FALSE;
  //TimerSocket.Enabled := FALSE;
  MinTimer.Enabled := FALSE;

  //UnLoadWMImagesLib();

  DScreen.Finalize;
  HintScene.Finalize;
  PlayScene.Finalize;
  //LoginNoticeScene.Finalize;

  DScreen.Free;
  //IntroScene.Free;
  LoginScene.Free;
  SelectChrScene.Free;
  PlayScene.Free;
  HintScene.Free;
  SelServer.Free;
  //LoginNoticeScene.Free;
  g_SaveItemList.Free;
  g_MenuItemList.Free;
  g_QuestMsgList.Free;

  DebugOutStr('----------------------- closed -------------------------');
  Map.Free;
  g_DropedItemList.Free;
  //g_MagicList.Free;
  g_FreeActorList.Free;
  g_FreeItemList.Free;
  g_ChangeFaceReadyList.Free;
  //g_GuaJi.Free;
  g_LegendMap.Free;

  //if MainSurface <> nil then MainSurface.Free;

  g_Sound.Free;
  g_SoundList.Free;
  BGMusicList.Free;
  //DObjList.Free;
  EventMan.Free;

  g_DXSound.Free;
  g_DWinMan.Free;
  ClearStditemList();
  ClearMissionList();
  g_StditemList.Free;
  g_StditemFiltrateList.Free;

  DeleteCriticalSection(FCriticalSection);
  FrmDlg.Free;
  FrmDlg2.Free;
  FrmDlg3.Free;


  BASS_StreamFree(MusicHS);
  if MusicStream <> nil then
    MusicStream.Free;
  BASS_Free;
  FrmWeb.Free;
  FreeCheckDll;
  HGE.System_Shutdown;
  g_DXFont.Free;
  HGE := nil;
end;

function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
begin
  with Result do begin
    rgbRed := Src.rgbRed + ((Dest.rgbRed - Src.rgbRed) * Percent div 256);
    rgbGreen := Src.rgbGreen + ((Dest.rgbGreen - Src.rgbGreen) * Percent div 256);
    rgbBlue := Src.rgbBlue + ((Dest.rgbBlue - Src.rgbBlue) * Percent div 256);
    rgbReserved := 0;
  end;
end;

procedure TfrmMain.FullScreen(boFull: Boolean);
begin
  {HGE.Gfx_Restore(1024, 768, 16);
  ClientWidth := 1024;
  ClientHeight := 768;
  Exit;   }
  if g_boFullScreen <> boFull then begin
    TimerRun.Enabled := False;
    application.ProcessMessages;
    g_boFullScreen := boFull;
    if g_boFullScreen then begin
      DisplayChange(False);

      BorderStyle := bsNone;
      BorderIcons := [];

      ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
      ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
      WindowState := wsMaximized;



      m_Point.X := 0;
      m_Point.Y := 0;
    end else begin
      DisplayChange(True);

      BorderStyle := bsSingle;
      FormStyle := fsNormal;
      WindowState := wsNormal;
      ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
      ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
      BorderIcons := [biSystemMenu, biMinimize];
      Left := (Screen.width - ClientWidth) div 2;
      Top := (Screen.Height - ClientHeight) div 2 - 40;
      SetWindowPos(handle, HWND_NOTOPMOST, left, top, width, height, SWP_SHOWWINDOW);
    end;
    TimerRun.Enabled := True;
    Tag := 0;
  end;
  {if HGE.System_GetState(HGE_WINDOWED) <> (not boFull) then begin
    Tag := 1;
    TimerRun.Enabled := False;
    application.ProcessMessages;
    HGE.System_SetState(HGE_WINDOWED, not boFull);
    if (HGE.System_GetState(HGE_WINDOWED)) then begin
      BorderStyle := bsSingle;
      FormStyle := fsNormal;

      ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
      ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
      BorderIcons := [biSystemMenu, biMinimize];
      Left := (Screen.width - g_FScreenWidth) div 2;
      Top := (Screen.Height - g_FScreenHeight) div 2 - 40;
    end
    else begin
      BorderStyle := bsNone;
      BorderIcons := [];
      m_Point.X := 0;
      m_Point.Y := 0;
    end;
    g_boFullScreen := not HGE.System_GetState(HGE_WINDOWED);
    TimerRun.Enabled := True;
    Tag := 0;
    if not g_boFullScreen then
      SetWindowPos(handle, HWND_NOTOPMOST, left, top, width, height, SWP_SHOWWINDOW);
  end;             }
end;

procedure TfrmMain.MyDeviceNotifyEvent(Sender: TObject; Msg: Cardinal);
begin
  case Msg of
    msgDeviceLost: begin
      boSizeMove := True;
        PlayScene.Lost;
        g_DXFont.Lost;
        DScreen.ClearHint(True);
        //DebugOutStr('DeviceLost');
      end;
    msgDeviceRecovered: begin
      boSizeMove := False;
        try
          g_DXFont.Recovered;
        except

        end;
        PlayScene.Recovered;
        Map.m_OldClientRect := Rect(0, 0, 0, 0);
        DScreen.ClearHint(True);
        //DebugOutStr('DeviceRecovered');
      end;
    msgDeviceRestoreSize: begin
        ClientWidth := HGE.System_GetState(HGE_FScreenWidth);
        ClientHeight := HGE.System_GetState(HGE_FScreenHeight);
        if g_boFullScreen then begin
          if FIDDraw <> nil then begin
            if ClientWidth = DEFSCREENWIDTH then FIDDraw.SetDisplayMode(DEFSCREENWIDTH, DEFSCREENHEIGHT, 32)
            else FIDDraw.SetDisplayMode(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT, 32);
          end;
          m_Point.X := 0;
          m_Point.Y := 0;
        end else begin
          Left := (Screen.width - ClientWidth) div 2;
          Top := (Screen.Height - ClientHeight) div 2 - 40;
          SetWindowPos(handle, HWND_NOTOPMOST, left, top, width, height, SWP_SHOWWINDOW);
        end;
      end;
  end;
end;

procedure TfrmMain.DXDrawInitialize(Sender: TObject);
(* procedure RefLoginWin(Len: Integer);
 var
   d: TDirectDrawSurface;
   rc: TRect;
 begin
   if g_boChangeWindow then
     exit;
   DXDraw.Surface.Fill(0);
   d := g_WMain99Images.Images[LOGINBAGIMGINDEX];
   if d <> nil then
     DXDraw.Surface.Draw(0, 0, d.ClientRect, d, True);

   d := g_WMain99Images.Images[7];
   if d <> nil then
     DXDraw.Surface.Draw(102, 450 + 60, d.ClientRect, d, True);

   d := g_WMain99Images.Images[8];
   if d <> nil then begin
     rc := d.ClientRect;
     rc.Right := Trunc(d.Width * (len / 100));
     DXDraw.Surface.Draw(108, 457 + 60, rc, d, True);
   end;
   DxDraw.Flip;
 end;       *)
begin
  (*  if g_boFirstTime then begin
      g_boFirstTime := FALSE;

      DXDraw.SurfaceWidth := g_FScreenWidth;
      DXDraw.SurfaceHeight := g_FScreenHeight;
  {$IF USECURSOR = DEFAULTCURSOR}
      DXDraw.Cursor := crHourGlass;
  {$ELSE}
      DXDraw.Cursor := crMyNone;
  {$IFEND}

      DXDraw.Surface.Canvas.Font.Assign(frmMain.Font);

      frmMain.Font.name := DEFFONTNAME;
      frmMain.Font.Size := DEFFONTSIZE;
      frmMain.Canvas.Font.name := DEFFONTNAME;
      frmMain.Canvas.Font.Size := DEFFONTSIZE;
      DXDraw.Surface.Canvas.Font.name := DEFFONTNAME;
      DXDraw.Surface.Canvas.Font.Size := DEFFONTSIZE;
      //FrmDlg.DEditChat.Font.name := g_sCurFontName;
      Refresh; //刷新主窗口,以免全黑

      //DxDraw.Surface.Fill(0);

      if not g_boChangeWindow then
        InitWMImagesLib(DXDraw)
      else
        InitWMImagesLibEx(DXDraw);

      g_ColorTable := g_WMainImages.MainPalette;

      RefLoginWin(10);
      if not g_boChangeWindow then begin
        BuildColorLevels();
        RefLoginWin(30);
        FrmDlg.Initialize;
        RefLoginWin(40);
        FrmDlg2.Initialize;
        RefLoginWin(50);
        FrmDlg3.Initialize;
      end;
      FrmDlg.InitializeEx(DXDraw.DDraw);
      FrmDlg2.InitializeEx(DXDraw.DDraw);
      FrmDlg3.InitializeEx(DXDraw.DDraw);
      RefLoginWin(60);
      DScreen.Initialize;
      RefLoginWin(70);
      PlayScene.Initialize;
      RefLoginWin(90);
      g_ImgMixSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
      g_ImgMixSurface.SystemMemory := True;
      g_ImgMixSurface.SetSize(300, 350);

      g_MiniMapSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
      g_MiniMapSurface.SystemMemory := True;
      g_MiniMapSurface.SetSize(540, 360);

      if g_boChangeWindow then begin
        LoadActorSurface();
        LoadItemSurface();
        LoadSaySurface();
        if FrmDlg2.HDInfoDIB <> nil then begin
          FrmDlg2.HDInfoSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
          FrmDlg2.HDInfoSurface.SystemMemory := True;
          FrmDlg2.HDInfoSurface.SetSize(FrmDlg2.HDInfoDIB.Width, FrmDlg2.HDInfoDIB.Height);
          FrmDlg2.HDInfoSurface.Canvas.Draw(0, 0, FrmDlg2.HDInfoDIB);
          FrmDlg2.HDInfoSurface.Canvas.Release;
        end;
        if FrmDlg.MyHDDIB <> nil then begin
          FrmDlg.MyHDInfoSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
          FrmDlg.MyHDInfoSurface.SystemMemory := True;
          FrmDlg.MyHDInfoSurface.SetSize(FrmDlg2.DUpLoadImage.Width, FrmDlg2.DUpLoadImage.Height);
          FrmDlg.MyHDInfoSurface.Canvas.Draw(0, 0, FrmDlg.MyHDDIB);
          FrmDlg.MyHDInfoSurface.Canvas.Release;
        end;
        if FrmDlg.UserHDDIB <> nil then begin
          FrmDlg.UserHDInfoSurface := TDirectDrawSurface.Create(DXDraw.DDraw);
          FrmDlg.UserHDInfoSurface.SystemMemory := True;
          FrmDlg.UserHDInfoSurface.SetSize(FrmDlg2.DUpLoadImage.Width, FrmDlg2.DUpLoadImage.Height);
          FrmDlg.UserHDInfoSurface.Canvas.Draw(0, 0, FrmDlg.UserHDDIB);
          FrmDlg.UserHDInfoSurface.Canvas.Release;
        end;
      end;
  {$IF USECURSOR = DEFAULTCURSOR}
      DXDraw.Cursor := crDefault;
  {$IFEND}
      RefLoginWin(100);
      if not g_boChangeWindow then begin
        sleep(100);
        DScreen.ChangeScene(stSelServer);
      end;

      TimerRun.Enabled := True;
      //TimerSocket.Enabled := True;
      g_boChangeWindow := False;
    end;     *)
end;

procedure TfrmMain.DXDrawFinalize(Sender: TObject);
begin
  (* TimerRun.Enabled := False;
   if g_boChangeWindow then begin
     UnLoadWMImagesLibEx();
     g_DWinMan.CloseSurface;
     ClearActorSurface();
     ClearItemSurface();
     ClearSaySurface;
     DScreen.Finalize;
     DScreen.ClearHint(True);
     PlayScene.Finalize;
     g_ImgMixSurface.Free;
     g_ImgMixSurface := nil;
     g_MiniMapSurface.Free;
     g_MiniMapSurface := nil;
     g_nMiniMapOldX := -1;
     if FrmDlg2.HDInfoSurface <> nil then begin
       FrmDlg2.HDInfoSurface.Free;
       FrmDlg2.HDInfoSurface := nil;
     end;
     if FrmDlg.MyHDInfoSurface <> nil then begin
       FrmDlg.MyHDInfoSurface.Free;
       FrmDlg.MyHDInfoSurface := nil;
     end;
     if FrmDlg.UserHDInfoSurface <> nil then FrmDlg.UserHDInfoSurface.Free;
     FrmDlg.UserHDInfoSurface := nil;
     {if FrmDlg.m_DMsgSurface <> nil then
       FrmDlg.m_DMsgSurface.Free;
     FrmDlg.m_DMsgSurface := nil; }
     Map.m_OldClientRect := Rect(0, 0, 0, 0);
   end;   *)
end;

type
  TInt64Decompose = packed record
    case Integer of
      1: (
        nInt64: Int64;
        );
      2: (
        nInteger1: Integer;
        nInteger2: Integer;
        );
  end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  ErrorMsg: string;
  Int64Decompose: TInt64Decompose;
  MemoryStatus: TMemoryStatus;
  Reg: TRegistry;
  VersionInfo: TosversionInfo;
  DI: TD3DAdapterIdentifier8;
  D3D: IDirect3D8;
{$IFNDEF DEBUG}
  nCount: Integer;
{$ENDIF}
begin
  if g_boFirstTime then begin
    g_boFirstTime := FALSE;
    if not CheckMirDir(ExtractFilePath(Application.ExeName), True) then begin
      Application.MessageBox('Lack the required client files, can not run.', 'Message :', MB_OK + MB_ICONSTOP);
      Close;
      exit;
    end;
    g_Login_Index := 0;
{$IFNDEF DEBUG}
    //g_ServerInfoCount := 0;
    g_boSQLReg := g_sMainParam2 = '1';
    {//this code would basicaly be used if you want to have the client connect to server first and ask for the list there (rather then taking list from ini
    if g_Login_Handle <> 0 then begin

      nCount := SendMessage(g_Login_Handle, WM_GETSERVERLIST, Handle, 0);
      g_ServerInfoCount := SmallInt(LoWord(nCount));
      g_Login_Index := SmallInt(HiWord(nCount));
    end;
    if (g_ServerInfoCount <= 0) or (g_Login_Index < 0) then begin
      Close;
      exit;
    end;
    }
{$ELSE}

    g_boSQLReg := False;
{$ENDIF}
    if not BASS_Init(-1, 44100, 0, 0, nil) then
      Application.MessageBox(PCHar('Game audio initialization failed, will not be able to play background music'), 'Message :', MB_OK + MB_ICONSTOP);

    if not HGE.System_Initiate then begin
      ErrorMsg := '----------------Error Message--------------------' + #13#10;
      ErrorMsg := ErrorMsg + HGE.System_GetErrorMessage + #13#10;
      ErrorMsg := ErrorMsg + #13#10;
      ErrorMsg := ErrorMsg + '----------------System Information--------------------' + #13#10;
      VersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
      Reg := TRegistry.Create;
      if Windows.GetVersionEx(VersionInfo) then begin
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        case VersionInfo.dwPlatformId of
          VER_PLATFORM_WIN32s: begin

          end;
          VER_PLATFORM_WIN32_WINDOWS: begin
            if Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion', False) then begin
              ErrorMsg := ErrorMsg + 'Operating System:' + Reg.ReadString('ProductName') + #13#10;
            end;
            Reg.CloseKey;
          end;
          VER_PLATFORM_WIN32_NT: begin
            if Reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion', False) then begin
              ErrorMsg := ErrorMsg + 'Operating System:' + Reg.ReadString('ProductName') + #13#10;
            end;
            Reg.CloseKey;
          end;
          VER_PLATFORM_WIN32_CE: begin

          end;
        end;
        ErrorMsg := ErrorMsg + 'System Version:' + Format('%d.%d.%d', [VersionInfo.dwMajorVersion, VersionInfo.dwMinorVersion, VersionInfo.dwBuildNumber]) + #13#10;
        ErrorMsg := ErrorMsg + 'Patch Version:' + VersionInfo.szCSDVersion + #13#10;
        if Reg.OpenKey('SOFTWARE\Microsoft\DirectX', False) then begin
          ErrorMsg := ErrorMsg + 'DirectX :' + Reg.ReadString('Version') + #13#10;
        end;
        Reg.CloseKey;
      end;
      Reg.Free;

      D3D := Direct3DCreate8(D3D_SDK_VERSION);
      if D3D <> nil then begin
        Try
          D3D.GetAdapterIdentifier(D3DADAPTER_DEFAULT, D3DENUM_NO_WHQL_LEVEL, DI);
        Except
        End;
        ErrorMsg := ErrorMsg + #13#10;
        ErrorMsg := ErrorMsg + '----------------Graphics Card Information--------------------' + #13#10;
        ErrorMsg := ErrorMsg + 'Card Name:' + DI.Description + #13#10;
        ErrorMsg := ErrorMsg + 'Driver:' + DI.Driver + #13#10;
        Int64Decompose.nInteger1 := DI.DriverVersionLowPart;
        Int64Decompose.nInteger2 := DI.DriverVersionHighPart;;
        ErrorMsg := ErrorMsg + Format('Driver Version:%d.%d.%d.%d', [
          HiWord(Int64Decompose.nInteger2),
            LoWord(Int64Decompose.nInteger2),
            HiWord(Int64Decompose.nInteger1),
            LoWord(Int64Decompose.nInteger1)]) + #13#10;

        ErrorMsg := ErrorMsg + 'Available Graphics Memory:' + IntToStr(HGE.AvailableTextureMem div 1024 div 1024) + 'M' + #13#10;
        ErrorMsg := ErrorMsg + 'Texture Size:' + IntToStr(HGE.D3DCaps.MaxTextureWidth) + '*' + IntToStr(HGE.D3DCaps.MaxTextureHeight) + #13#10;
      end;
      D3D := nil;
      SafeFillChar(MemoryStatus, SizeOf(MemoryStatus), #0);
      MemoryStatus.dwLength := SizeOf(TMemoryStatus);
      GlobalMemoryStatus(MemoryStatus);
      ErrorMsg := ErrorMsg + #13#10;
      ErrorMsg := ErrorMsg + '----------------Memory Information--------------------' + #13#10;
      ErrorMsg := ErrorMsg + 'Physical Memory:' + intToStr(MemoryStatus.dwTotalPhys div 1024 div 1024) + 'M' + #13#10;
      ErrorMsg := ErrorMsg + 'Available Physical Memory:' + intToStr(MemoryStatus.dwAvailPhys div 1024 div 1024) + 'M' + #13#10;
      ErrorMsg := ErrorMsg + 'Virtual Memory:' + intToStr(MemoryStatus.dwTotalVirtual div 1024 div 1024) + 'M' + #13#10;
      ErrorMsg := ErrorMsg + 'Available Virtual Memory:' + intToStr(MemoryStatus.dwAvailVirtual div 1024 div 1024) + 'M' + #13#10;
      CopyStrToClipboard(ErrorMsg);
      ErrorMsg := ErrorMsg + #13#10;
      ErrorMsg := ErrorMsg + 'Please copy this text (Ctrl+V) and send it to the ACEM2 team';
      //Visible := False;
      Application.MessageBox(PCHar(ErrorMsg), 'Game initialization failed', MB_OK + MB_ICONSTOP);
      close;
      HGE.System_Shutdown;
      Exit;
    end;
    MinTimer.Enabled := True;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DisplayChange(True);
  if g_sExitUrl <> '' then
    ShellExecute(Handle, 'Open', PChar(g_sExitUrl), '', '', SW_SHOW);
{$IFDEF RELEASE}
  if g_Login_Handle <> 0 then
    SendMessage(g_Login_Handle, WM_CHECK_CLIENT, Handle, MakeLong(MSG_CHECK_CLIENT_EXIT, g_Login_Index));
{$ENDIF}
  SaveIDInfo();
  SaveHumInfo(CharName);
  ClearBGMEx;
  if g_boAllLoadStream then begin
    Try
      g_MissionDateStream.SaveToFile(GETMISSIONDESCFILE);
    Except
    End;
    Try
      g_StditemsDateStream.SaveToFile(GETSTDITEMSDESCFILE);
    Except
    End;
    Try
      g_MagicDateStream.SaveToFile(GETMAGICDESCFILE);
    Except
    End;
    Try
      g_MapDescDateStream.SaveToFile(GETMAPDESCFILE);
    Except
    End;
    Try
      g_MakeMagicDateStream.SaveToFile(GETMAKEMAGICFILE);
    Except
    End;
    Try
      g_BannedAppsDataStream.SaveToFile(GETBADAPPSFILE);
    Except
    End;
  end;

  //Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
  //DxTimer.Enabled := FALSE;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (not g_boQueryExit) and (g_MySelf <> nil) then begin
    CanClose := False;
    FrmDlg2.dbtnGameSetupClick(FrmDlg2.dbtnExitGame,0,0);
  end
  else begin
    TimerRun.Enabled := False;
    //HGE.System_Shutdown;
  end;
end;

{------------------------------------------------------------}
{
procedure TfrmMain.ProcOnIdle;
var
  Deon: Boolean;
begin
  AppOnIdle(Self, Deon);
  //DXTimerTimer (self, 0);
end;             }

procedure TfrmMain.OnIdle(Sender: TObject; var Done: Boolean);
begin
  Done := True;
  //Timer2.Enabled := True;
  Application.OnIdle := nil;
end;

procedure TfrmMain.MyDeviceRender(Sender: TObject);
  procedure RefInitialize(MinImage, Pointer, Len: Integer);
  var
    d: TDirectDrawSurface;
    rc: TRect;
  begin
    d := g_WMain99Images.Images[MinImage];
    if d <> nil then
      g_DXCanvas.Draw(0, 0, d.ClientRect, d, True);

    d := g_WMain99Images.Images[7];
    if d <> nil then
      g_DXCanvas.Draw(102, 450 + Pointer, d.ClientRect, d, True);

    d := g_WMain99Images.Images[8];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := Trunc(d.Width * (len / 100));
      g_DXCanvas.Draw(108, 457 + Pointer, rc, d, True);

      //RSADecodeString('bk9iZk7sqab=ZMlhJQVYmfhjgxddHaDZJcgyS7Sh9whNZ72w=y4');
    end;
  end;

  procedure LogoInitialize(MinImage: Integer);
  var
    d: TDirectDrawSurface;
  begin
    if g_LogoSurface <> nil then begin
    d := g_WMain99Images.Images[2236];
      if FnShowLogoIndex < 256 then begin
        if d <> nil then begin
          g_DXCanvas.Draw(0, 0, d.ClientRect, d, True, cColor4($FFFFFF or ((FnShowLogoIndex - 400) shl 24)));

          g_DXCanvas.Draw((DEFScreenWidth - d.Width) div 2,
            (DEFScreenHeight - d.Height) div 2,
            d.ClientRect, d, True,
            cColor4($FFFFFF or ((655 - FnShowLogoIndex) shl 24)));
        end;
      end else
      if FnShowLogoIndex < 400 then begin
        if d <> nil then begin
          g_DXCanvas.Draw(0, 0, d.ClientRect, d, True, cColor4($FFFFFF or ((FnShowLogoIndex - 400) shl 24)));

          g_DXCanvas.Draw((DEFScreenWidth - d.Width) div 2,
            (DEFScreenHeight - d.Height) div 2,
            d.ClientRect, d, True,
            cColor4($FFFFFF or ((655 - FnShowLogoIndex) shl 24)));
        end;
      end else
      if FnShowLogoIndex < 626 then begin
        if d <> nil then begin
          g_DXCanvas.Draw(0, 0, d.ClientRect, d, True, cColor4($FFFFFF or ((FnShowLogoIndex - 400) shl 24)));

          g_DXCanvas.Draw((DEFScreenWidth - d.Width) div 2,
          (DEFScreenHeight - d.Height) div 2,
            d.ClientRect, d, True,
            cColor4($FFFFFF or ((655 - FnShowLogoIndex) shl 24)));
        end;
      end else begin
        if d <> nil then
          g_DXCanvas.Draw(0, 0, d.ClientRect, d, True);
        FBoShowLogo := True;
      end;
    end else FBoShowLogo := True;
  end;
var
  d: TDirectDrawSurface;
  p: TPoint;
begin
  if not FBoShowLogo then begin
    LogoInitialize(LOGINBAGIMGINDEX);
  end else
  if g_boMapInitialize or g_boMapApoise then begin
    RefInitialize(303, 110, g_btMapinitializePos);
  end
  else if not g_boInitialize then begin
    try
      ProcessFreeTexture;
    except
      on e: Exception do
        outputdebugstring(pansichar('Free Texture: ' + e.Message));
    end;
    ProcessKeyMessages;
    ProcessActionMessages;
    if DScreen.CurrentScene = PlayScene then begin
      {if (g_MySelf <> nil) and g_MySelf.m_boDeath then
        MyDevice.Canvas.Draw(SOFFX, SOFFY, PlayScene.m_MagSurface.ClientRect, PlayScene.m_MagSurface, True, clRed4)
      else  }
      //should check if playscene.m_magsurface = nil but since it shouldnt ever happen, it's sort of a waste of cpu     
      g_DXCanvas.Draw(SOFFX, SOFFY, PlayScene.m_MagSurface.ClientRect, PlayScene.m_MagSurface, True);
      g_DXCanvas.DrawPart(PlayScene.m_LightSurface.Target.GetTexture,0,0,0,0,1042,768,$ffffffff, Blend_Multiply);
    end;
    DScreen.DrawScreen(g_DXCanvas.DrawTexture);
    if g_boCanDraw then begin
      g_DWinMan.DirectPaint(g_DXCanvas.DrawTexture);
      DScreen.DrawScreenTop(g_DXCanvas.DrawTexture);
      //if g_boCtrlDown then
       // g_DXCanvas.FillRect(0, 0, 800, 600, $FF000000);
      DScreen.DrawHint(g_DXCanvas.DrawTexture);

      if g_boItemMoving and g_boCanDraw then begin
        GetCursorPos(p);
        p.X := p.X - m_Point.X;
        p.Y := p.Y - m_Point.Y;
        if g_MovingItem.ItemType = mtBottom then begin
          case LoWord(g_MovingItem.Index2) of
            UKTYPE_ITEM: begin
                d := GetBagItemImg(g_MovingItem.Item.S.looks);
                if d <> nil then begin
                  FrmDlg.RefItemPaint(g_DXCanvas.DrawTexture, d,
                    p.X - (d.ClientRect.Right div 2),
                    p.Y - (d.ClientRect.Bottom div 2),
                    p.X - (d.ClientRect.Right div 2) + 34,
                    p.Y - (d.ClientRect.Bottom div 2) + 18,
                    @g_MovingItem.Item, False);
                end;
              end;
            UKTYPE_MAGIC: begin
                d := g_WMagIconImages.Images[g_MovingItem.Item.S.looks];
                if d <> nil then
                  g_DXCanvas.Draw(p.X - d.Width div 2, p.Y - d.Height div 2, d.ClientRect, d, True);
              end;
          end;
        end
        else if g_MovingItem.ItemType = mtStateMagic then begin
          d := g_WMagIconImages.Images[HiWord(g_MovingItem.Index2)];
          if d <> nil then begin
            g_DXCanvas.Draw(p.X - d.Width div 2, p.Y - d.Height div 2, d.ClientRect, d, True);
          end;
        end
        else if (g_MovingItem.Item.S.name <> g_sGoldName {'金币'}) then begin
          d := GetBagItemImg(g_MovingItem.Item.S.looks);
          if d <> nil then begin
            FrmDlg.RefItemPaint(g_DXCanvas.DrawTexture, d,
              p.X - (d.ClientRect.Right div 2),
              p.Y - (d.ClientRect.Bottom div 2),
              p.X - (d.ClientRect.Right div 2) + 34,
              p.Y - (d.ClientRect.Bottom div 2) + 18,
              @g_MovingItem.Item, False);
          end;
        end
        else begin
          d := GetBagItemImg(115); //金币外形
          if d <> nil then begin
            g_DXCanvas.Draw(p.X - (d.ClientRect.Right div 2),
              p.Y - (d.ClientRect.Bottom div 2),
              d.ClientRect,
              d,
              True);
          end;
        end;
      end;
      if g_boShowFormImage then begin
        d := g_WMain99Images.Images[g_boShowFormIndex];
        if d <> nil then begin
          g_DXCanvas.Draw((g_FScreenWidth - d.Width) div 2, (g_FScreenHeight - d.Height) div 2, d.ClientRect, d, True);
        end else
          g_boShowFormImage := False;
      end;
    end;
  end
  else
    RefInitialize(LOGINBAGIMGINDEX, 60, g_nInitializePer);
end;

procedure TfrmMain.AppOnIdle(boInitialize: Boolean = False);
var
  CanDraw: Boolean;
  i: Integer;
  Actor: TActor;
begin
  CanDraw := HGE.Gfx_CanBegin();
  g_boCanDraw := CanDraw and (not boSizeMove);

  if MusicHS >= BASS_ERROR_ENDED then begin
    if boInFocus and g_boCanDraw then begin
      if BASS_ChannelIsActive(MusicHS) = BASS_ACTIVE_PAUSED then begin
        ChangeBGMState(bgmPlay);
      end;
      g_boCanSound := True;
    end
    else begin
      if BASS_ChannelIsActive(MusicHS) = BASS_ACTIVE_PLAYING then begin
        ChangeBGMState(bgmPause);
      end;
      g_boCanSound := False;
      SilenceSound;
    end;
  end;
  if not FboShowLogo then begin
    if g_boCanDraw then begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear($FF222222);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end else
  if g_boMapInitialize or g_boMapApoise then begin
    if g_boCanDraw then begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear(0);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end else
  if not boInitialize then begin
    if DScreen.CurrentScene = PlayScene then begin
      PlayScene.BeginScene; //DebugOutStr('106');
      if g_boCanDraw then begin
        try
        if PlayScene.CanDrawTileMap then begin
          HGE.Gfx_BeginScene(PlayScene.m_MapSurface.Target);
          HGE.Gfx_Clear(0);
          HGE.RenderBatch;
          PlayScene.DrawTileMap(nil);
          HGE.Gfx_EndScene;
        end;
        except
          on e: Exception do begin
            OnProgramException(self,E);
            outputdebugstring(pansichar('MapSurface: ' + e.Message));
          end;
        end;
        try
        if PlayScene.m_boPlayChange then begin
          HGE.Gfx_BeginScene(PlayScene.m_ObjSurface.Target);
          HGE.Gfx_Clear(0);
          HGE.RenderBatch;
          PlayScene.PlaySurface(nil);
          HGE.Gfx_EndScene;
        end;
        except
          on e: Exception do begin
            OnProgramException(self,E);
            outputdebugstring(pansichar('MapSurface: ' + e.Message));
          end;
        end;                                                                                           
        try
        HGE.Gfx_BeginScene(PlayScene.m_MagSurface.Target);
        HGE.Gfx_Clear(0);
        HGE.RenderBatch;
        PlayScene.MagicSurface(nil);
        HGE.Gfx_EndScene;
        except
          on e: Exception do begin
            OnProgramException(self,E);
            outputdebugstring(pansichar('MapSurface: ' + e.Message));
          end;
        end;
                //draw the lights onto our black screen //thedeath

        HGE.Gfx_BeginScene(PlayScene.m_LightSurface.Target);
        //step 1
        HGE.Gfx_Clear(0);
        HGE.RenderBatch;

        if (g_target_denisty_of_dark <> g_denisty_of_dark) and (g_wait_for_dark) then begin
          if (FrmMain.m_CurrentTick - g_density_change_tick > 200) then begin
            g_density_change_tick := FrmMain.m_CurrentTick;
            if g_target_denisty_of_dark > g_denisty_of_dark then
              Inc(g_denisty_of_dark, 1)
            else
              Dec(g_denisty_of_dark, 1);
             g_colour_of_dark := GetHGEColour(g_cur_colour_of_dark, g_denisty_of_dark);
          end;
        end else begin
          g_denisty_of_dark := g_target_denisty_of_dark;
           g_colour_of_dark := GetHGEColour(g_cur_colour_of_dark, g_denisty_of_dark);
          g_wait_for_dark := False;
        end;
        HGE.Rectangle(0,0,1024,768,ARGB(g_denisty_of_dark,g_colour_of_dark[1],g_colour_of_dark[2],g_colour_of_dark[3]), True); //draw a 'full screen' rectangle with alpha 255 and black (or greyed out brightness)
        PlayScene.PlayDrawScreen;
        try
          PlayScene.LightSurface(nil);
        except
          on e: Exception do
            outputdebugstring(pansichar('Lightsurf: ' + e.Message));
        end;
        try
          PlayScene.MapLightSurface(nil);
        except
          on e: Exception do
            outputdebugstring(pansichar('MapLightSurf: ' + e.Message));
        end;
        try
          PlayScene.MagicLightSurface;
        except
        on e: Exception do
            outputdebugstring(pansichar('MagicLightSurf: ' + e.Message));
        end;
        try
          PlayScene.DrawCastingLight;

        except
          on e: Exception do
            outputdebugstring(pansichar('CastingLight: ' + e.Message));
        end;
        //step 2
        {for i := 0 to PlayScene.m_ActorList.Count - 1 do begin
          Actor := PlayScene.m_ActorList[i];
          PlayScene.LightSurface(Actor);
        end;  }
        //HGE.SetBlendMode(BLEND_COLORADD or BLEND_ALPHABLEND);
        //HGE.Gfx_RenderCircle(g_MySelf.m_nCurrX - 80, g_MySelf.m_nCurrY + 80, 100,ARGB(255,255,255,255),true,BLEND_COLORADD or BLEND_ALPHABLEND);
        //HGE.Gfx_RenderCircle(g_MySelf.m_nCurrX - 80, g_MySelf.m_nCurrY + 80, 70,$FFFFFFFF,true,Blend_Invert);

        HGE.Gfx_EndScene;
      end;
    end;
    if g_boCanDraw then begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear(0);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end else begin
    if g_boCanDraw then begin
      HGE.Gfx_BeginScene;
      HGE.Gfx_Clear(0);
      HGE.RenderBatch;
      MyDeviceRender(nil);
      HGE.Gfx_EndScene;
    end;
  end;
  if g_MySelf <> nil then begin
    if boCheckSpeed and (FrmMain.m_CurrentTick > CheckSpeedTick) then begin
      boCheckSpeed := False;
      SendSocketEx(g_ClientCheck);
    end;
  end;
end;

procedure TfrmMain.AppLogout;
begin
  if g_boQueryExit then
    exit;
  g_boQueryExit := True;
  try
    if mrOk = FrmDlg.DMessageDlg('Would you like to Log Out?', [mbOk, mbCancel]) then begin

      //SendGameSetupInfo;
      SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
      ResetGameVariables;
      FrmDlg.HintBack := stSelectChr;
      FrmDlg.sHintStr := 'Game Settings being saved, please wait..';
      FrmDlg.DBTHintClose.Caption := 'Cancel';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
      FrmDlg.DBTHintClose.Visible := False;
      g_SoftClosed := True;
      ActiveCmdTimer(tcSoftClose);
      //PlayBGM(bmg_SelChr);
    end;
  finally
    g_boQueryExit := False;
  end;
end;

procedure TfrmMain.AppExit;
begin
  if g_boQueryExit then
    exit;
  g_boQueryExit := True;
  try
    if mrOk = FrmDlg.DMessageDlg('Would you like to exit the game?', [mbOk, mbCancel]) then begin
      CloseAllWindows;
      //SendClientSocket(CM_USERKEYSETUP, 0, 0, 0, 0, EncodeBuffer(@g_UserKeySetup, SizeOf(g_UserKeySetup)));
      //SendGameSetupInfo;
      //SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
      SaveIDInfo();
      SaveHumInfo(CharName);
      FrmDlg.HintBack := stSelectChr;
      FrmDlg.sHintStr := 'Game Settings being saved, please wait..';
      FrmDlg.DBTHintClose.Caption := 'Cancel';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
      FrmDlg.DBTHintClose.Visible := False;
      m_boExit := True;
      ActiveCmdTimer(tcSoftClose);
      //PlayBGM(bmg_SelChr);
    end;
  finally
    g_boQueryExit := False;
  end;
  {if g_boQueryExit then
    exit;
  g_boQueryExit := True;
  try
    if mrOk = FrmDlg.DMessageDlg('你真的要退出游戏吗?', [mbOk, mbCancel]) then begin
      SendClientSocket(CM_USERKEYSETUP, 0, 0, 0, 0, EncodeBuffer(@g_UserKeySetup, SizeOf(g_UserKeySetup)));
      SendGameSetupInfo;
      SaveIDInfo();
      SaveHumInfo(CharName);
      frmMain.Close;
    end;
  finally
    g_boQueryExit := False;
  end;  }
end;

procedure TfrmMain.PrintScreenNow;
  procedure BitmapBoldTextOut(Canvas: TCanvas; x, y, fcolor, bcolor: integer; str: string);
  var
    nLen: Integer;
    ChrBuff: PChar;
  begin
    if str = '' then
      Exit;
    nLen := Length(str);
    GetMem(ChrBuff, nLen);
    Move(str[1], ChrBuff^, nlen);
    Canvas.Font.Color := bcolor;
    TextOut(Canvas.Handle, x, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y - 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x - 1, y + 1, ChrBuff, nlen);
    TextOut(Canvas.Handle, x + 1, y - 1, ChrBuff, nlen);
    Canvas.Font.Color := fcolor;
    TextOut(Canvas.Handle, x, y, ChrBuff, nlen);
    FreeMem(ChrBuff);
  end;
  function IntToStr2(n: Integer): string;
  begin
    if n < 10 then
      Result := '0' + IntToStr(n)
    else
      Result := IntToStr(n);
  end;
var
  //  i, n: Integer;
  flname, Dirname: string;
  //DIB: TDIB;
  //ddsd: TDDSurfaceDesc;
//  sptr, dptr: PChar;
  JPG: TJPEGImage;
  BItmap: TBitmap;
  //PrevTarget, Offscreen: IDirect3DSurface9;
//  DRect: TRect;
  Surf: IDirect3DSurface8;
  //Y,
  n: Integer;
{var
  Surf, Dest: IDirect3DSurface8;
  Desc : TD3DSurface_Desc;  }
begin
  //PlaySoundEx(bmg_Camera);
  //HGE.Target_GetTexture()
  {Surf.GetDesc(Desc);
  HGE.GetD3DDevice.GetBackBuffer(0, D3DBACKBUFFER_TYPE_MONO, Surf);
  D3DXSaveSurfaceToFile('D:\Temp.bmp', D3DXIFF_BMP, Dest, nil, nil);
  Surf := nil;
  Dest := nil;  }

  PlaySoundEx(bmg_Camera);
  if (HGE = nil) or (HGE.GetD3DDevice = nil) then
    exit;

  Dirname := GetCurrentDir;
  if Copy(Dirname, Length(Dirname), 1) <> '\' then
    Dirname := Dirname + '\';
  Dirname := Dirname + 'Screenshots\';
  if not DirectoryExists(Dirname) then
    CreateDir(Dirname);
  while True do begin
    flname := Dirname + 'Images' + IntToStr2(g_nCaptureSerial) + '.jpg';
    if not FileExists(flname) then
      break;
    Inc(g_nCaptureSerial);
  end;

  HGE.GetD3DDevice.GetBackBuffer(0, D3DBACKBUFFER_TYPE_MONO, Surf);
  D3DXSaveSurfaceToFile(PChar(flname), D3DXIFF_BMP, Surf, nil, nil);
  Bitmap := TBitmap.Create;
  JPG := TJPEGImage.Create;
  Try
    Bitmap.LoadFromFile(flname);
    Bitmap.Canvas.Font.Name := 'MS Sans Serif'; //宋体
    Bitmap.Canvas.Font.Size := 8;
    n := 0;
    SetBkMode(Bitmap.Canvas.Handle, TRANSPARENT);
    BitmapBoldTextOut(Bitmap.Canvas, 2, 2, clWhite, clBlack, 'AceM2');
    if g_MySelf <> nil then begin
      BitmapBoldTextOut(Bitmap.Canvas, 2, 14, clWhite, clBlack, g_MySelf.m_UserName);
      BitmapBoldTextOut(Bitmap.Canvas, 2, 14 + 12, clWhite, clBlack, g_ServerInfo[g_ServerChoice].sName);
      Inc(n, 2);
    end;
    BitmapBoldTextOut(Bitmap.Canvas, 2, 14 + n * 12, clWhite, clBlack, FormatDateTime('YYYY-MM-DD HH:MM:SS', Now));
    JPG.Assign(Bitmap); //FormatDateTime('YYYY-MM-DD HH:MM:SS', Now)
    Jpg.CompressionQuality := 100;
    Jpg.SaveToFile(flname);
    //Bitmap.SaveToFile(flname);
    Bitmap.Free;
    JPG.Free;
    Bitmap := nil;
    JPG := nil;
    //Bitmap.SaveToFile(flname);
    if boShowPrintMsg then
      DScreen.AddSysMsg('[Screenshot saved as: ' + flname + ']', clWhite);
  Finally
    if Bitmap <> nil then
      Bitmap.Free;
    if JPG <> nil then
      JPG.Free;
  End;

  (*try
    if not Succeeded(Direct3DDevice.CreateOffscreenPlainSurface(PresentParams.BackBufferWidth,
      PresentParams.BackBufferHeight, PresentParams.BackBufferFormat, D3DPOOL_SYSTEMMEM, PrevTarget, nil)) then
      Exit;

    DRect := Rect(0, 0, PresentParams.BackBufferWidth, PresentParams.BackBufferHeight);

    if not Succeeded(Direct3DDevice.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, Offscreen)) then
      Exit;
    if not Succeeded(Direct3DDevice.GetRenderTargetData(Offscreen, PrevTarget)) then
      Exit;

    if Succeeded(PrevTarget.LockRect(LockedRect, nil, D3DLOCK_READONLY)) then begin
      Bitmap := TBitmap.Create;
      JPG := TJPEGImage.Create;
      ImageBuffer := nil;
      try
        Dirname := GetCurrentDir;
        if Copy(Dirname, Length(Dirname), 1) <> '\' then
          Dirname := Dirname + '\';
        Dirname := Dirname + '游戏截图\';
        if not DirectoryExists(Dirname) then
          CreateDir(Dirname);
        while True do begin
          flname := Dirname + 'Images' + IntToStr2(g_nCaptureSerial) + '.jpg';
          if not FileExists(flname) then
            break;
          Inc(g_nCaptureSerial);
        end;
        Bitmap.Width := PresentParams.BackBufferWidth;
        Bitmap.Height := PresentParams.BackBufferHeight;
        Bitmap.Canvas.Font.Name := '宋体';
        Bitmap.Canvas.Font.Size := 9;
        case D3DDataSize(PresentParams.BackBufferFormat) of
          1: begin
              Bitmap.PixelFormat := pf8bit;
              SetDIBColorTable(Bitmap.Canvas.Handle, 0, 256, g_ColorTable);
              for Y := 0 to Bitmap.Height - 1 do begin
                ReadBuffer := PChar(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
                WriteBuffer := Bitmap.ScanLine[Y];
                Move(ReadBuffer^, WriteBuffer^, LockedRect.Pitch);
              end;
            end;
          2: begin
              case PresentParams.BackBufferFormat of
                D3DFMT_X1R5G5B5: Bitmap.PixelFormat := pf15bit;
                D3DFMT_R5G6B5: Bitmap.PixelFormat := pf16bit;
              else
                exit;
              end;
              for Y := 0 to Bitmap.Height - 1 do begin
                ReadBuffer := PChar(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
                WriteBuffer := Bitmap.ScanLine[Y];
                Move(ReadBuffer^, WriteBuffer^, LockedRect.Pitch);
              end;
            end;
          {3: begin
            Bitmap.PixelFormat := pf24bit;
            for Y := 0 to Bitmap.Height - 1 do begin
              RGBQuadBuffer := PRGBQuad(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
              RGBTripleBuffer := Bitmap.ScanLine[Y];
              for X := 0 to Bitmap.Width - 1 do begin
                RGBTripleBuffer.rgbtRed := RGBQuadBuffer.rgbRed;
                RGBTripleBuffer.rgbtGreen := RGBQuadBuffer.rgbGreen;
                RGBTripleBuffer.rgbtBlue := RGBQuadBuffer.rgbBlue;
                Inc(RGBQuadBuffer);
                Inc(RGBTripleBuffer);
              end;
            end;
          end; }
          3, 4: begin
              Bitmap.PixelFormat := pf32bit;
              for Y := 0 to Bitmap.Height - 1 do begin
                ReadBuffer := PChar(Integer(LockedRect.pBits) + LockedRect.Pitch * Y);
                WriteBuffer := Bitmap.ScanLine[Y];
                Move(ReadBuffer^, WriteBuffer^, LockedRect.Pitch);
              end;
            end;
        end;
      finally
        PrevTarget.UnlockRect;
        n := 0;
        SetBkMode(Bitmap.Canvas.Handle, TRANSPARENT);
        if g_MySelf <> nil then begin
          BitmapBoldTextOut(Bitmap.Canvas, 2, 2, clWhite, clBlack, g_MySelf.m_UserName);
          BitmapBoldTextOut(Bitmap.Canvas, 2, 2 + 12, clWhite, clBlack, g_sServerName);
          Inc(n, 2);
        end;
        BitmapBoldTextOut(Bitmap.Canvas, 2, 2 + n * 12, clWhite, clBlack, FormatDateTime('YYYY-MM-DD HH:MM:SS', Now));
        JPG.Assign(Bitmap); //FormatDateTime('YYYY-MM-DD HH:MM:SS', Now)
        Jpg.CompressionQuality := 100;
        Jpg.SaveToFile(flname);
        //Bitmap.SaveToFile(flname);
        Bitmap.Free;
        JPG.Free;
        //Bitmap.SaveToFile(flname);
        if ImageBuffer <> nil then
          FreeMem(ImageBuffer);
        PrevTarget := nil;
        DScreen.AddSysMsg('[截图保存位置:' + flname + ']', clWhite);
      end;
    end;
  finally
    PrevTarget := nil;
    Offscreen := nil;
  end;   *)
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcessKeyMessages;
var
  nKey: Integer;
  nMagID: Integer;
begin
  if g_MySelf = nil then
    exit;
  nKey := ActionKey - 1;
  if nKey in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin //1-xx keys to use quickslot items
    if g_UserKeySetup[nKey].btType = UKTYPE_ITEM then begin
      nMagID := GetBagItemIdx(g_UserKeySetup[nKey].wIndex);
      if nMagID <> -1 then begin
        EatItem(nMagID) //quickslots i hope
      end else begin
        if FrmMain.m_CurrentTick > FShowHintTick2 then begin
          FShowHintTick2 := FrmMain.m_CurrentTick + 2000;
          DScreen.AddSysMsg('<CO$FFFF>[' + GetStditem(g_UserKeySetup[nKey].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob).Name + '<CE>' + ' has been used..', clRed);
        end;
      end;
    end;
    ActionKey := 0;
  end else begin //f keys to activate skills
    nKey := -ActionKey;
    if (nKey > 0) and ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin

      nMagID := GetMagIDByKey(nKey);

      if nMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
        if g_MyMagicArry[nMagID].boStudy and (not g_MyMagicArry[nMagID].boNotUse) then begin
          if (FrmMain.m_CurrentTick > g_MyMagicArry[nMagID].dwInterval) then begin
            UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[nMagID]); //胶农赴 谅钎
            ActionKey := 0;
            g_nTargetX := -1;
          end else begin
            if FrmMain.m_CurrentTick > FShowHintTick then begin
              FShowHintTick := FrmMain.m_CurrentTick + 2000;
              DScreen.AddSysMsg('<CO$FFFFFF>[' + g_MagicArry[nMagID].Magic.sMagicName + ']<CE>' + ' Is Charging..', clRed);
            end;
          end;
        end;
      end;
    end;
    ActionKey := 0;
  end;
end;

//自动移动

procedure TfrmMain.GetAutoMovingXY();
var
  I: Integer;
  Actor: TActor;
  Count: Integer;
  ni: Integer;
//  boAbout: Boolean;
label
  LB_WALK, LB_STOP;
begin
  if g_MySelf = nil then exit;
  Count := 0;
  LB_WALK:
  if g_boNpcMoveing and (abs(g_MySelf.m_nCurrX - g_nScriptGotoX) <= 2) and
    (abs(g_MySelf.m_nCurrY - g_nScriptGotoY) <= 2) and
    (not PlayScene.CanWalkEx2(g_nScriptGotoX, g_nScriptGotoY)) then begin
    GotoClickNpc(g_nScriptGotoX, g_nScriptGotoY);
    g_nMiniMapPath := nil;
    g_boAutoMoveing := False;
    g_boNpcMoveing := False;
    g_nMiniMapMoseX := -1;
    g_nMiniMapMoseY := -1;
    g_nMiniMapPath := nil;
    exit;
  end;
  //g_nMiniMapPath := nil;
  if High(g_nMiniMapPath) >= 0 then begin
    for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
      if (g_MySelf.m_nCurrX = g_nMiniMapPath[i].X) and (g_MySelf.m_nCurrY = g_nMiniMapPath[i].Y) then begin
        DynArrayDelete(g_nMiniMapPath, SizeOf(TPoint), 0, I + 1);
        break;
      end;
    end;
    if High(g_nMiniMapPath) < 0 then begin
      goto LB_STOP;
    end;
    {$region 'run while mounted'}
    if g_MySelf.m_btHorse <> 0 then begin
      nI := 0;
      for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
        if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
          PlayScene.CanHorseRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
          (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) = 3) then begin
          g_ChrAction := caRun;
          g_nTargetX := g_nMiniMapPath[i].X;
          g_nTargetY := g_nMiniMapPath[i].Y;
          exit;
        end;
        Inc(nI);
        if nI >= 10 then
          break;
      end;

      if (High(g_nMiniMapPath) >= 2) and
        CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[2].X, g_nMiniMapPath[2].Y) then begin
        g_ChrAction := caRun;
        g_nTargetX := g_nMiniMapPath[2].X;
        g_nTargetY := g_nMiniMapPath[2].Y;
        if (not PlayScene.CanHorseRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY)) or
          (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY) <= 2) then begin
          g_ChrAction := caWalk;
          g_nTargetX := g_nMiniMapPath[0].X;
          g_nTargetY := g_nMiniMapPath[0].Y;
        end;
      end
      else begin
        g_ChrAction := caWalk;
        g_nTargetX := g_nMiniMapPath[0].X;
        g_nTargetY := g_nMiniMapPath[0].Y;
      end;
    end
    {$endregion}
    {$region 'run without mount'}
    else begin
      nI := 0;
      for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
        if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
          PlayScene.CanRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) and
          (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[i].X, g_nMiniMapPath[i].Y) = 2) then begin
          g_ChrAction := caRun;
          g_nTargetX := g_nMiniMapPath[i].X;
          g_nTargetY := g_nMiniMapPath[i].Y;
          exit;
        end;
        Inc(nI);
        if nI >= 10 then
          break;
      end;
      if (High(g_nMiniMapPath) >= 1) and
        CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMiniMapPath[1].X, g_nMiniMapPath[1].Y) then begin
        g_ChrAction := caRun;
        g_nTargetX := g_nMiniMapPath[1].X;
        g_nTargetY := g_nMiniMapPath[1].Y;
        if (not PlayScene.CanRunEx(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY)) or
          (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nTargetX, g_nTargetY) <= 1) then begin
          g_ChrAction := caWalk;
          g_nTargetX := g_nMiniMapPath[0].X;
          g_nTargetY := g_nMiniMapPath[0].Y;
        end;
      end
      else begin
        g_ChrAction := caWalk;
        g_nTargetX := g_nMiniMapPath[0].X;
        g_nTargetY := g_nMiniMapPath[0].Y;
      end;
    end;
    {$endregion}
    if g_ChrAction = caWalk then begin
      if not PlayScene.CanWalkEx2(g_nTargetX, g_nTargetY) then begin
        for i := PlayScene.m_ActorList.Count - 1 downto 0 do begin
          Actor := TActor(PlayScene.m_ActorList[i]);
          if not ((actor.m_boDeath or (g_boNpcMoveing and (Actor.m_nCurrX = g_nScriptGotoX) and (Actor.m_nCurrY = g_nScriptGotoY)))) then
          begin
            g_LegendMap.SetTerrainType(Actor.m_nCurrX, Actor.m_nCurrY, False);
          end;
        end;
        Try
          g_nMiniMapPath := FindPath(g_nMiniMapPath[High(g_nMiniMapPath)].X, g_nMiniMapPath[High(g_nMiniMapPath)].Y);
        Finally
          for i := PlayScene.m_ActorList.Count - 1 downto 0 do begin
            Actor := TActor(PlayScene.m_ActorList[i]);
            if not ((actor.m_boDeath or (g_boNpcMoveing and (Actor.m_nCurrX = g_nScriptGotoX) and (Actor.m_nCurrY = g_nScriptGotoY)))) then
            begin
              g_LegendMap.SetTerrainType(Actor.m_nCurrX, Actor.m_nCurrY, True);
            end;
          end;
        End;
        if High(g_nMiniMapPath) >= 0 then begin
          Inc(Count);
          if Count > 5 then begin
            if g_boNpcMoveing and (abs(g_MySelf.m_nCurrX - g_nScriptGotoX) <= 5) and
              (abs(g_MySelf.m_nCurrY - g_nScriptGotoY) <= 5) then
            begin
              GotoClickNpc(g_nScriptGotoX, g_nScriptGotoY);
              g_nMiniMapPath := nil;
              g_boAutoMoveing := False;
              g_boNpcMoveing := False;
              g_nMiniMapMoseX := -1;
              g_nMiniMapMoseY := -1;
              g_nMiniMapPath := nil;
              exit;
            end;
            //if not g_boNpcMoveing then
            DScreen.AddSysMsg('Unabled to reach Destination' + '<CO$FFFFFF>[' + IntToStr(g_nTargetX)
            + ',' + IntToStr(g_nTargetY) + ']<CE>', clRed);
            g_boAutoMoveing := False;
            g_boNpcMoveing := False;
            g_nMiniMapMoseX := -1;
            g_nMiniMapMoseY := -1;
            g_nMiniMapPath := nil;
            exit;
          end;
          goto LB_WALK
        end
        else begin
          if g_boNpcMoveing and (abs(g_MySelf.m_nCurrX - g_nScriptGotoX) <= 5) and
              (abs(g_MySelf.m_nCurrY - g_nScriptGotoY) <= 5) then
          begin
            GotoClickNpc(g_nScriptGotoX, g_nScriptGotoY);
            g_nMiniMapPath := nil;
            g_boAutoMoveing := False;
            g_boNpcMoveing := False;
            g_nMiniMapMoseX := -1;
            g_nMiniMapMoseY := -1;
            g_nMiniMapPath := nil;
            exit;
          end;
          //if not g_boNpcMoveing then
          DScreen.AddSysMsg('Unabled to reach Destination' + '<CO$FFFFFF>[' + IntToStr(g_nTargetX)
            + ',' + IntToStr(g_nTargetY) + ']<CE>', clRed);
          g_boAutoMoveing := False;
          g_boNpcMoveing := False;
          g_nMiniMapMoseX := -1;
          g_nMiniMapMoseY := -1;
          g_nMiniMapPath := nil;
          exit;
        end;
      end;
    end;
  end
  else begin
    LB_STOP:
    if (High(g_nMiniMapPath) < 0) then begin
      if not g_boNpcMoveing then
        DScreen.AddSysMsg('[Destination Reached]', clLime);
      //DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapPath := nil;
      exit;
    end;
    if (g_MySelf.m_nCurrX = g_nMiniMapPath[0].X) and (g_MySelf.m_nCurrY = g_nMiniMapPath[0].Y) then begin
      //DynArrayDelete(g_nMiniMapPath, SizeOf(TPoint), 0, 1);
      g_nMiniMapPath := nil;
    end;
    if (High(g_nMiniMapPath) < 0) then begin
      if not g_boNpcMoveing then
        DScreen.AddSysMsg('[Destination Reached]', clLime);
      //DynArrayDelete(g_nMiniMapPath,SizeOf(TPoint),0,1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapPath := nil;
      exit;
    end;
    g_ChrAction := caWalk;
    g_nTargetX := g_nMiniMapPath[0].X;
    g_nTargetY := g_nMiniMapPath[0].Y;
    if not PlayScene.CanWalkEx2(g_nTargetX, g_nTargetY) then begin
      //if not g_boNpcMoveing then
      DScreen.AddSysMsg('Unabled to reach Destination' + '<CO$FFFFFF>[' + IntToStr(g_nTargetX)
        + ',' + IntToStr(g_nTargetY) + ']<CE>', clRed);
      //DynArrayDelete(g_nMiniMapPath, SizeOf(TPoint), 0, 1);
      g_nMiniMapPath := nil;
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapPath := nil;
    end;
  end;
end;


procedure TfrmMain.ProcessActionMessages;
var
  mx, my, dx, dy, crun: Integer;
  ndir, adir, mdir: byte;
  bowalk, bostop: Boolean;
label
  LB_WALK;
begin
  if g_MySelf = nil then
    Exit;

  if g_boAutoMoveing and CanNextAction and ServerAcceptNextAction and (not g_boMapMovingWait) then
    GetAutoMovingXY();
  //Move
  if (g_nTargetX >= 0) then begin
    {DScreen.AddSysMsg('1 ' + IntToStr(FrmMain.m_CurrentTick - g_dwLastAttackTick), clWhite);
    if not CanNextAction then exit;
    DScreen.AddSysMsg('2 ' + IntToStr(FrmMain.m_CurrentTick - g_dwLastAttackTick), clWhite);  }
    if CanNextAction and ServerAcceptNextAction then begin
      if (g_nTargetX <> g_MySelf.m_nCurrX) or (g_nTargetY <> g_MySelf.m_nCurrY) then begin
        //   TTTT:
        mx := g_MySelf.m_nCurrX;
        my := g_MySelf.m_nCurrY;
        dx := g_nTargetX;
        dy := g_nTargetY;
        ndir := GetNextDirection(mx, my, dx, dy);

        if ((FrmMain.m_CurrentTick - g_dwLastStruckTick) > 30 * 1000) and (g_nRunReadyCount < 0) then
           g_nRunReadyCount := 0; //If 3 seconds have passed then change our run ready time

        case g_ChrAction of
          caWalk: begin
              LB_WALK:
              crun := g_MySelf.CanWalk;
              mx := g_MySelf.m_nCurrX;
              my := g_MySelf.m_nCurrY;
              if IsUnLockAction(CM_WALK, ndir) and (crun > 0) then begin
                GetNextPosXY(ndir, mx, my);
                //              bowalk := True;
                bostop := FALSE;
                if not PlayScene.CanWalk(mx, my) then begin
                  bowalk := FALSE;
                  adir := 0;
                  if not bowalk then begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    GetNextPosXY(ndir, mx, my);
                    if CheckDoorAction(mx, my) then
                      bostop := True;
                  end;
                  if not bostop and not PlayScene.CrashMan(mx, my) then begin
                    mx := g_MySelf.m_nCurrX;
                    my := g_MySelf.m_nCurrY;
                    adir := PrivDir(ndir);
                    GetNextPosXY(adir, mx, my);
                    if not Map.CanMove(mx, my) then begin
                      mx := g_MySelf.m_nCurrX;
                      my := g_MySelf.m_nCurrY;
                      adir := NextDir(ndir);
                      GetNextPosXY(adir, mx, my);
                      if Map.CanMove(mx, my) then
                        bowalk := True;
                    end
                    else
                      bowalk := True;
                  end;
                  if bowalk then begin
                    g_MySelf.UpdateMsg(CM_WALK, mx, my, adir, 0, 0, '', 0);
                    g_dwLastMoveTick := FrmMain.m_CurrentTick;
                  end
                  else begin
                    mdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                    if mdir <> g_MySelf.m_btDir then begin //why do i get to turn without delay
                      g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                    end;
                    g_nTargetX := -1;
                  end;
                end
                else begin
                  g_MySelf.UpdateMsg(CM_WALK, mx, my, ndir, 0, 0, '', 0);
                  g_dwLastMoveTick := FrmMain.m_CurrentTick;
                end;
              end
              else begin
                g_nTargetX := -1;
              end;
            end;
          caRun: begin
              //if (FrmMain.m_CurrentTick - g_nStruckRunTick > 2500) {and (g_boAllowStruckRun)} then begin //allow running after flinch - chili
              if g_nRunReadyCount >= 1 then begin
                crun := g_MySelf.CanRun;
                if (g_MySelf.m_btHorse <> 0) then begin
                  if (GetDistance(mx, my, dx, dy) >= 3) and (crun > 0) then begin
                    if IsUnLockAction(CM_HORSERUN, ndir) then begin
                      GetNextHorseRunXY(ndir, mx, my);
                      if PlayScene.CanHorseRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                        g_MySelf.UpdateMsg(CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                        g_dwLastMoveTick := FrmMain.m_CurrentTick;
                      end
                      else begin
                        Inc (g_nRunReadyCount);
                        goto LB_WALK;
                      end;
                    end
                    else
                    g_nTargetX := -1;
                  end
                  else begin
                  end;
                end
                else begin
                  if (GetDistance(mx, my, dx, dy) >= 2) and (crun > 0) then begin
                    if IsUnLockAction(CM_RUN, ndir) then begin
                      GetNextRunXY(ndir, mx, my);
                      if PlayScene.CanRun(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                        g_MySelf.UpdateMsg(CM_RUN, mx, my, ndir, 0, 0, '', 0);
                        g_dwLastMoveTick := FrmMain.m_CurrentTick;
                      end
                      else begin
                        Inc (g_nRunReadyCount);
                        goto LB_WALK;
                      end;
                    end
                    else
                      g_nTargetX := -1;
                  end
                  else begin
                    if g_Myself.CanWalk > 0 then
                      Inc (g_nRunReadyCount);
                    goto LB_WALK;
                  end;
                end;
              {end else begin
                Inc (g_nRunReadyCount);
                goto LB_WALK;
              end;   }
            end else begin
              if g_Myself.CanWalk > 0 then
                Inc (g_nRunReadyCount);
              goto LB_WALK;
            end;
          end;
          {//no leaping :p
          caLeap: begin
              crun := g_MySelf.CanRun;
              if (GetDistance(mx, my, dx, dy) >= 2) and (crun > 0) then begin
                if IsUnLockAction(CM_LEAP, ndir) then begin
                  GetNextRunXY(ndir, mx, my);
                  if PlayScene.CanLeap(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                    g_MySelf.UpdateMsg(CM_Leap, mx, my, ndir, 0, 0, '', 0);
                    g_dwLastMoveTick := FrmMain.m_CurrentTick;
                  end
                  else begin
                    goto LB_WALK;
                  end;
                end
                else
                  g_nTargetX := -1;
              end
              else begin
                goto LB_WALK;
              end;
            end;
            }
        end;
      end;
    end;
  end;
  //stupid question: why are these codes allowed to run without a speedcheck?
  g_nTargetX := -1;
  if g_MySelf.RealActionMsg.ident > 0 then begin
    {$ifNdef quicksend}
    FailAction := g_MySelf.RealActionMsg.ident;
    FailDir := g_MySelf.RealActionMsg.dir;
    if g_MySelf.RealActionMsg.ident = CM_SPELL then begin
      SendSpellMsg(g_MySelf.RealActionMsg.ident,
        g_MySelf.RealActionMsg.X,
        g_MySelf.RealActionMsg.Y,
        g_MySelf.RealActionMsg.dir,
        g_MySelf.RealActionMsg.State);
    end
    else if g_MySelf.RealActionMsg.ident = CM_SITDOWN then begin
      SendSitDownMsg(g_MySelf.RealActionMsg.feature,
        g_MySelf.RealActionMsg.X,
        g_MySelf.RealActionMsg.Y,
        g_MySelf.RealActionMsg.dir);
    end else begin
      SendActMsg(g_MySelf.RealActionMsg.ident,
        g_MySelf.RealActionMsg.X,
        g_MySelf.RealActionMsg.Y,
        g_MySelf.RealActionMsg.dir);
    end;
    {$endif}
    {$ifdef quicksend}
      if (g_MySelf.RealActionMsg.ident in [CM_WALK,CM_RUN,CM_HORSERUN]) then begin
        FailAction := g_MySelf.RealActionMsg.ident;
        FailDir := g_MySelf.RealActionMsg.dir;
        SendActMsg(g_MySelf.RealActionMsg.ident,
          g_MySelf.RealActionMsg.X,
          g_MySelf.RealActionMsg.Y,
          g_MySelf.RealActionMsg.dir);
      end;
    {$endif}
    g_MySelf.RealActionMsg.ident := 0;

    if g_nMDlgX <> -1 then
      if (abs(g_nMDlgX - g_MySelf.m_nCurrX) >= 8) or (abs(g_nMDlgY - g_MySelf.m_nCurrY) >= 8) then begin
        //if FrmDlg.DMerchantDlg.Visible then
        FrmDlg.CloseMDlg;
        g_boAllowAuction := False;
        g_nMDlgX := -1;
      end;
    if g_nMyReadShopDlgX <> -1 then begin
      if (abs(g_nMyReadShopDlgX - g_MySelf.m_nCurrX) >= 8) or (abs(g_nMyReadShopDlgY - g_MySelf.m_nCurrY) >= 8) then begin
        FrmDlg2.DReadUserShop.Visible := False;
        g_nMyReadShopDlgX := -1;
      end;
    end;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  //  mx, my: Integer;
//  ini: TIniFile;
  I: Integer;
  str: string;
  temp: char;
  ckey: TKeyInfo;
begin
  if g_boMapApoise then exit;
  if key = VK_ESCAPE then begin
    CloseAllWindows(False);
    exit;
  end;
  if g_boShowFormImage then begin
    if Key = 27 then ShowInterface(False);
    exit;
  end;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.KeyDown(Key, Shift);
    Exit;
  end;
  g_boCtrlDown := (ssCtrl in Shift);                              
  if g_SetupInfo.boExemptShift and g_boShiftUp and (ssShift in Shift) then begin
    g_boShiftUp := False;
   { if not g_boEasyNotShift then begin
      g_boShiftOpen := not g_boShiftOpen;
      if g_boShiftOpen then
        str := '[Auto Shift On]'
      else
        str := '[Auto Shift Off]';
      DScreen.AddSysMsg(str, cllime);
    end;  } //ripman disabled
    //DScreen.AddChatBoardString(str, clWhite, clBlue);
  end;
  if (ssAlt in Shift) and (Key = VK_RETURN) then begin
    FullScreen(not g_boFullScreen);
    exit;
  end;



  if g_DWinMan.KeyDown(Key, Shift) then Exit;
  if dscreen.CurrentScene = SelectChrScene then begin
    if not SelectChrScene.CreateChrMode then begin
      SelectChrScene.SelChrStartClick();
      exit;
    end;
  end;
  //2008-02-21 custom keybind system
  for i := Low(g_CustomKey) to High(g_CustomKey) do begin
    ckey := g_CustomKey[i].DefKey;
    if (g_SetupInfo.boCustomKey) and (g_CustomKey[i].CustomKey.Key <> 0)  then
      ckey:= g_CustomKey[i].CustomKey;
    if ((Shift * [ssCtrl,ssAlt]) = cKey.Shift) and (cKey.Key = Key) then begin
      if g_CustomKey[i].boLoginGame then begin
        if ((g_MySelf <> nil) or (DScreen.CurrentScene = PlayScene)) and
          ((g_DWinMan.InputBoxOpen =  False) or g_CustomKey[i].boDuringChat) then begin
          if OpenKeyInfo(I) then begin
            Key := 0;
            Exit;
          end;
        end;
      end
      else begin
        OpenKeyInfo(I);
      end;
      break;
    end;
  end;
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then
    Exit;
  {
  case Key of
    VK_F1..VK_F8: begin
        if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
          if ssCtrl in Shift then begin
            ActionKey := -(byte(Key) - VK_F1 + 1);
          end else begin
            ActionKey := -(byte(Key) - VK_F1 + 9);
          end;
        end;
      end;
  end;
  }
  with FrmDlg do begin
    case Key of
      VK_UP: DSayUpDown.Position := DSayUpDown.Position - 1;
      VK_DOWN: DSayUpDown.Position := FrmDlg.DSayUpDown.Position + 1;
      VK_PRIOR: DSayUpDown.Position := DSayUpDown.Position - (DWndSay.Height div SAYLISTHEIGHT - 1);
      VK_NEXT: DSayUpDown.Position := DSayUpDown.Position + (DWndSay.Height div SAYLISTHEIGHT - 1);
      VK_F10: Key := 0;
      {
      Word('R'):
        begin
          if (ssAlt in Shift) and DItemBagRef.Enabled then
            DItemBagRefClick(DItemBagRef, 0, 0);
        end;
      }
    {Word('L'):
      begin //挂机
        if ssCtrl in Shift then
          g_GuaJi.Started := not g_GuaJi.Started;
      end;   }
    end;
  end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if g_boMapApoise or g_boShowFormImage then
    exit;

  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.KeyPress(Key);
    Exit;
  end;
  //ShowMessage(IntToStr(Byte(key)));
  if g_DWinMan.KeyPress(Key) then
    Exit;
{$IFDEF DEBUG}
    {case byte(Key) of
    byte('G'), byte('g'): begin
        if not frmDlgConfig.Showing then
          frmDlgConfig.Open;
      end;

   { case byte(key) of
    byte('B'), byte('b'): begin
        GMManageShow;
      end; 
  end;     //}
{$ENDIF}

  if (DScreen.CurrentScene = PlayScene) and (g_MySelf <> nil) then begin
    case byte(Key) of
      {byte('1')..byte('6'): begin
          EatItem(byte(Key) - byte('1'));
        end;  }
      {27: {//ESC begin
        end;  }
      {//these buttons will interfere with the custom keybind setup players might have
      byte('C'), byte('c'): begin
          FrmDlg.StatePage := 0;
          FrmDlg.OpenMyStatus;
        end;
      byte('B'), byte('b'): begin
          FrmDlg.OpenItemBag;
        end;
      byte('S'), byte('s'): begin
          FrmDlg.StatePage := 2;
          FrmDlg.OpenMyStatus;
        end;

      byte('W'), byte('w'): begin
          FrmDlg.DBotGuildClick(FrmDlg.DBotGuild, 0, 0);
        end;
      byte('G'), byte('g'): begin
          FrmDlg.DGroupDlg.Visible := not FrmDlg.DGroupDlg.Visible;
        end;

      byte('F'), byte('f'): begin
          FrmDlg2.DWinFriend.Visible := not FrmDlg2.DWinFriend.Visible;
        end;
      byte('Q'), byte('q'): begin
          FrmDlg3.dwndMission.Visible := not FrmDlg3.dwndMission.Visible;
        end;
      byte('E'), byte('e'): begin
          FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
        end;
      byte('D'), byte('d'): begin
          g_CursorMode := cr_Deal;
          Cursor := crMyDeal;
        end;
      byte('H'), byte('h'): begin
          //FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
          FrmDlg.DTopHelpClick(FrmDlg.DTopHelp, 0, 0);
        end;
      byte('M'), byte('m'): begin
          FrmDlg.DMiniMapMaxClick(FrmDlg.DMiniMapMax, 0, 0);
        end;
      byte('`'): begin
          AutoPickUpItem(False);
        end;
      //}
      byte(' '), 13: begin
          FrmDlg.DBTEditClick(FrmDlg.DBTEdit, 0, 0);
        end;
      byte('@'),
      byte('~'),
        byte('!'),
        byte('/'): begin
          if not FrmDlg.DEditChat.Visible then begin
            FrmDlg.DEditChat.Visible := True;
            FrmDlg.DEditChat.SetFocus;
            FrmDlg.DEditChat.Text := Key;
          end else begin
            FrmDlg.DEditChat.SetFocus;
          end;
        end;
      $31..$36: begin // 0..9
          //if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > g_dwMagicDelayTime) then begin
          ActionKey := byte(Key) - $31 + 1;
          //end;
        end;
    end;
    Key := #0;
  end;

  { case Key of
     VK_F1..VK_F8: begin
         //if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
           ActionKey := Key - VK_F1 + 13;
         //end;
         Key := 0;
       end;
     $31..$39: begin // 0..9
       //if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
         ActionKey := Key - $31 + 1;
       //end;
       Key := 0;
     end;
     $30: begin // 0..9
       //if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
         ActionKey := 10;
       //end;
       Key := 0;
     end;
     189: begin
         //if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
           ActionKey := 11;
         //end;
       end;
     187: begin
         //if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) > (500 + g_dwMagicDelayTime)) then begin
           ActionKey := 12;
         //end;
       end;
   end;}
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;
  //ShowMessage(IntToStr(key));
  if Key = VK_CONTROL then
    g_boCtrlDown := False;
  if Key = VK_SHIFT then
    g_boShiftUp := True;
//  if Key = $56 then
//    g_boLeapDown := False;

  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.KeyUp(Key, Shift);
    Exit;
  end;
  if g_DWinMan.KeyUp(Key, Shift) then Exit;


end;

procedure TfrmMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  nX, nY: integer;

begin
  if g_boMapApoise or g_boShowFormImage then exit;
  nX := MousePos.X - ClientOrigin.X;
  nY := MousePos.Y - ClientOrigin.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then Exit;
  if (nX >= 0) and (nY >= 0) and (nX <= g_FScreenWidth) and (nY <= g_FScreenHeight) then begin
    if not g_DWinMan.MouseWheel(Shift, mw_Down, nX, nY) then
      FrmDlg.DSayUpDown.MouseWheel(Shift, mw_Down, nX, nY);
  end;
end;

procedure TfrmMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  nX, nY: integer;
begin
  if g_boMapApoise or g_boShowFormImage then exit;
  nX := MousePos.X - ClientOrigin.X;
  nY := MousePos.Y - ClientOrigin.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then Exit;
  if (nX >= 0) and (nY >= 0) and (nX <= g_FScreenWidth) and (nY <= g_FScreenHeight) then begin
    if not g_DWinMan.MouseWheel(Shift, mw_Up, nX, nY) then
      FrmDlg.DSayUpDown.MouseWheel(Shift, mw_Up, nX, nY);
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ShowWindow(application.Handle, SW_HIDE);
end;
(*
function TfrmMain.GetMagicByKey(Key: byte): PTClientMagic;
begin
  Result := nil;
  if (key < g_MagicList.count) then
    Result := PTClientMagic(g_MagicList[key]);
 // if True then

 { for i := 0 to g_MagicList.count - 1 do begin
    pm := PTClientMagic(g_MagicList[i]);
    if pm.Key = Key then begin
      Result := pm;
      break;
    end;
  end;  }
end;   *)

procedure TfrmMain.GetMoveHPShow(Actor: TActor; nCount: Word);
var
  MoveShow: pTMoveHMShow;
  str: string;
  i: integer;
  d: TDirectDrawSurface;
  boAdd: Boolean;
begin
  if (g_MySelf = nil) or (not g_SetupInfo.boMoveHpShow) or (Actor = nil) or (actor.m_btRace = 50) or (actor.m_btRace = 82) then
    exit;
  with Actor do begin
    boAdd := False;
    New(MoveShow);
    MoveShow.dwMoveHpTick := FrmMain.m_CurrentTick;
    //MoveShow.Surface := TDXImageTexture.Create(g_DXCanvas);
    //MoveShow.Surface := MakeDXImageTexture(OPERATEHINTWIDTH, OPERATEHINTHEIGHT, D3DFMT_A4R4G4B4)
    //MoveShow.Surface.Format := D3DFMT_A4R4G4B4;
    {m_UserNameSurface := TDXImageTexture.Create(g_DXCanvas);
    m_UserNameSurface.Size := Point(MAXNAMEWIDTH, MAXNAMEHEIGHT);
    m_UserNameSurface.PatternSize := Point(MAXNAMEWIDTH, MAXNAMEHEIGHT);
    m_UserNameSurface.Active := True;
    m_UserNameSurface.Clear;   }
    if nCount > 0 then begin
      str := IntToStr(nCount);
      //MoveShow.Surface.Size := Point(Length(str) * 9, 12);
      //MoveShow.Surface.PatternSize := MoveShow.Surface.Size;
      //MoveShow.Surface.Active := True;
      MoveShow.Surface := MakeDXImageTexture(Length(str) * 9, 12, WILFMT_A4R4G4B4, g_DXCanvas);
      if MoveShow.Surface = nil then Exit;
      MoveShow.Surface.Clear;
      for I := 1 to Length(str) do begin
        d := g_WMain99Images.Images[690 + StrToIntDef(Str[I], 0)];
        if d <> nil then begin
          MoveShow.Surface.CopyTexture((I - 1) * 9, 0, d);
          //MoveShow.Surface.Draw((I - 1) * 9, 0, d.ClientRect, d, False);
          boAdd := True;
        end;
      end;
    end
    else begin
      d := g_WMain99Images.Images[726];
      if d <> nil then begin
        //MoveShow.Surface.SetSize(d.Width, d.Height);
        {MoveShow.Surface.Size := Point(d.Width, d.Height);
        MoveShow.Surface.PatternSize := MoveShow.Surface.Size;
        MoveShow.Surface.Active := True; }
        MoveShow.Surface := MakeDXImageTexture(d.Width, d.Height, WILFMT_A4R4G4B4, g_DXCanvas);
        if MoveShow.Surface = nil then Exit;
        MoveShow.Surface.Clear;
        MoveShow.Surface.CopyTexture(0, 0, d);
        //MoveShow.Surface.Draw(0, 0, d.ClientRect, d, False);
        boAdd := True;
      end;
    end;
    if boAdd then begin
      m_nMoveHpList.Add(MoveShow);
    end
    else begin
      MoveShow.Surface.Free;
      Dispose(MoveShow);
    end;
  end;
end;

procedure TfrmMain.UseMagic(tx, ty: Integer; pcm: PTNewClientMagic);
  function CheckAmulet(nCount: Integer; nType: Integer): Boolean;
  begin
    Result := False;
    if (g_UseItems[U_BUJUK].s.Name <> '') and (g_UseItems[U_BUJUK].s.StdMode = tm_Amulet) then begin
      case nType of
        1: begin
            Result := (g_UseItems[U_BUJUK].s.Shape = 5) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
          end;
        2: begin
            Result := (g_UseItems[U_BUJUK].s.Shape <= 2) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
          end;
        3: begin
            Result := (g_UseItems[U_BUJUK].s.Shape = 1) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
          end;
        4: begin
            Result := (g_UseItems[U_BUJUK].s.Shape = 2) and (g_UseItems[U_BUJUK].UserItem.Dura >= nCount);
          end;
      end;
    end;
  end;
  function GetAmulet(nCount: Integer; nType: Integer; var nItemIdx: Integer): pTNewClientItem;
  var
    i: Integer;
    function CheckBasicRequirements(Item:TStdItem):boolean;
    begin
      Result := True;
      if g_Myself = nil then exit;


      if (Item.Need = 0) and (Item.NeedLevel = 0) then exit;
      if not CheckClass(Item.NeedClass,g_Myself.m_btJob) then Result := False;
      
      case Item.need of
        0: if g_Myself.m_Abil.Level < Item.NeedLevel then Result := False;
        1: if HiWord(g_Myself.m_Abil.DC) < Item.NeedLevel then Result := False;
        2: if HiWord(g_Myself.m_Abil.MC) < Item.NeedLevel then Result := False;
        3: if HiWord(g_Myself.m_Abil.SC) < Item.NeedLevel then Result := False;
      end;
    end;
  begin
    Result := nil;
    nItemIdx := -1;
    for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
      if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].s.StdMode = tm_Amulet) then begin
        case nType of
          1: begin
              if (g_ItemArr[i].s.Shape = 5) and (g_ItemArr[i].UserItem.Dura >= nCount) and CheckBasicRequirements(g_ItemArr[i].s) then begin
                Result := @g_ItemArr[i];
                nItemIdx := I;
                exit;
              end;
            end;
          2: begin
              if (g_ItemArr[i].s.Shape <= 2) and (g_ItemArr[i].UserItem.Dura >= nCount) and CheckBasicRequirements(g_ItemArr[i].s) then begin
                Result := @g_ItemArr[i];
                nItemIdx := I;
                exit;
              end;
            end;
          3: begin
              if (g_ItemArr[i].s.Shape = 1) and (g_ItemArr[i].UserItem.Dura >= nCount) and CheckBasicRequirements(g_ItemArr[i].s) then begin
                Result := @g_ItemArr[i];
                nItemIdx := I;
                exit;
              end;
            end;
          4: begin
              if (g_ItemArr[i].s.Shape = 2) and (g_ItemArr[i].UserItem.Dura >= nCount) and CheckBasicRequirements(g_ItemArr[i].s) then begin
                Result := @g_ItemArr[i];
                nItemIdx := I;
                exit;
              end;
            end;
        end;
      end;
    end;
  end;
//procedure UseAmulet(PlayObject: TBaseObject { 修改 TBaseObject}; nCount: Integer; nType: Integer);
var
  tdir, targx, targy, targid, nCount, nItemIdx: Integer;
  pmag: PTUseMagicInfo;
  item: pTNewClientItem;
begin
  if (pcm = nil) or (g_MySelf = nil) or (g_MySelf.m_boShop) or (g_MySelf.m_btHorse <> 0) then
    Exit;
  if ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) < g_dwMagicDelayTime) then exit;
  if FrmMain.m_CurrentTick < pcm.dwInterval then Exit;
  //是否可以使用魔法:需要的点数<当前点数，或者是魔法EffectType = 0
  if (GetSpellPoint(pcm) <= g_MySelf.m_Abil.MP) or (pcm.Def.Magic.btEffectType = 0) then begin
    {$region 'turn on/off type skills aka warrior like'}
    if pcm.Def.Magic.btEffectType = 0 then begin
      g_dwLatestSpellTick := FrmMain.m_CurrentTick;
      g_boLatestSpell := False;
      g_dwMagicDelayTime := 500;
      if (pcm.Def.Magic.wMagicId = 100) and (g_MySelf.m_btJob <> 0) then begin
        if g_FocusCret = nil then g_MagicTarget := g_MagicLockTarget
        else g_MagicTarget := g_FocusCret;
        g_MagicLockTarget := g_MagicTarget;
        if not PlayScene.IsValidActor(g_MagicTarget) then begin
          g_MagicTarget := nil;
          DScreen.AddSysMsg('[Target must be selected first!]', clRed);
          exit;
        end;
        if g_MagicTarget = nil then begin
          exit;
        end
        else begin
          targx := g_MagicTarget.m_nCurrX;
          targy := g_MagicTarget.m_nCurrY;
          targid := g_MagicTarget.m_nRecogId;
        end;
        SendSpellMsg(CM_SPELL, targx, targy, pcm.Def.Magic.wMagicId, targid);
      end
     { else
      if (pcm.Def.Magic.wMagicId = 70) then begin
        if g_MagicTarget = nil then begin
          PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
          targid := 0;
        end
        else begin
          targx := g_MagicTarget.m_nCurrX;
          targy := g_MagicTarget.m_nCurrY;
          targid := g_MagicTarget.m_nRecogId;
        end;
        SendSpellMsg(CM_SPELL, targx, targy, pcm.Def.Magic.wMagicId, targid);
      end    }
      else begin
        //pcm.dwInterval := FrmMain.m_CurrentTick + pcm.Def.Magic.nInterval + 500;
        SendSpellMsg(CM_SPELL, g_MySelf.m_btDir {x}, 0, pcm.Def.Magic.wMagicId, 0);
      end;
      g_CboMagicID := -1;
    end
    {$endregion}
    else begin
      tdir := GetFlyDirection(364 + ((g_FScreenWidth - DEFSCREENWIDTH) div 2), 224 + ((g_FScreenHeight - DEFSCREENHEIGHT) div 2 + 12), tx, ty);
      //     MagicTarget := FocusCret;
  //魔法锁定
      if (g_MagicLockTarget <> nil) and g_MagicLockTarget.m_boDeath then
        g_MagicLockTarget := nil;

      if (mm_MagLock in pcm.def.magic.MagicMode) then begin
        if (g_FocusCret = nil) or (g_FocusCret.m_boDeath) then
          g_MagicTarget := g_MagicLockTarget
        else
          g_MagicTarget := g_FocusCret;
          g_MagicLockTarget := g_MagicTarget;
      end else begin
        g_MagicTarget := g_FocusCret;
        if g_MagicLockTarget = nil then
          g_MagicLockTarget := g_FocusCret;
      end;

      if (g_MagicLockTarget <> nil) and (g_MagicLockTarget.m_btRace = RC_PLAYOBJECT) then
        g_MagicLockTarget := nil;

      if not PlayScene.IsValidActor(g_MagicTarget) then
        g_MagicTarget := nil;
      {$region 'auto equip amulet'}
      if (pcm.Def.Magic.wMagicId in [13..19, SKILL_SUMMONSHINSU, SKILL_CURSE, SKILL_MASSSOULFIREBALL, SKILL_PLAGUE, SKILL_HALLUCINATION]) then begin
        if pcm.Def.Magic.wMagicId = SKILL_SUMMONSHINSU then nCount := 5
        else nCount := 1;
        if not CheckAmulet(nCount, 1) then begin
          Item := GetAmulet(nCount, 1, nItemIdx);
          if Item <> nil then begin
            if (g_WaitingUseItem.Item.S.name <> '') then Exit;
            g_WaitingUseItem.Item := Item^;
            g_WaitingUseItem.ItemType := mtBagItem;
            g_WaitingUseItem.Index2 := U_BUJUK;
            frmMain.SendTakeOnItem(U_BUJUK, Item.UserItem.MakeIndex, Item.S.name);
            DelItemBagByIdx(nItemIdx);
          end else begin
            DScreen.AddSysMsg('[Amulet has been exhausted]', clRed);
            exit;
          end;
        end;
      {$endregion}
      end else                       //SKILL_GROUPAMYOUNSUL
      {$region 'poisoning, auto equip bags'}
      if (pcm.Def.Magic.wMagicId = 6) then begin
        nCount := 2;
        if g_MagicTarget <> nil then begin
          if g_SetupInfo.boSwitchPoison then begin
            if (g_MagicTarget.m_nState and $80000000 = 0) then begin
              nCount := 3;
            end;
            if (g_MagicTarget.m_nState and $40000000 = 0) then begin
              nCount := 4;
            end;
          end else begin
            if (g_MagicTarget.m_nState and $40000000 = 0) then begin
            nCount := 4;
            end;
            if (g_MagicTarget.m_nState and $80000000 = 0) then begin
              nCount := 3;
            end;
          end;
        end;
        if not CheckAmulet(1, nCount) then begin
          Item := GetAmulet(1, nCount, nItemIdx);
          if (Item = nil) and (g_UseItems[U_BUJUK].s.Name <> '') and (g_UseItems[U_BUJUK].s.StdMode = tm_Amulet) and (g_UseItems[U_BUJUK].s.Shape <= 2) then begin
            Item := @g_UseItems[U_BUJUK];
          end else begin
            if (Item = nil) and (nCount <> 2) then Item := GetAmulet(1, 2, nItemIdx);
            if Item <> nil then begin
              if (g_WaitingUseItem.Item.S.name <> '') then Exit;
              g_WaitingUseItem.Item := Item^;
              g_WaitingUseItem.ItemType := mtBagItem;
              g_WaitingUseItem.Index2 := U_BUJUK;
              frmMain.SendTakeOnItem(U_BUJUK, Item.UserItem.MakeIndex, Item.S.name);
              DelItemBagByIdx(nItemIdx);
            end else begin
              DScreen.AddSysMsg('[Poison has been exhausted..]', clRed);
              exit;
            end;
          end;
        end else begin
          Item := @g_UseItems[U_BUJUK];
        end;
        if Item.S.Shape = 1 then pcm.Def.Magic.btEffect := 4
        else pcm.Def.Magic.btEffect := MAGICEX_AMYOUNSUL;
      {$endregion}
      end else
      {$region 'mass poison, auto equip bag'}
      if (pcm.Def.Magic.wMagicId = SKILL_MASSPOISONING) then begin

        if m_boGroupPoison then
          nCount := 3
        else
          nCount := 4;

        m_boGroupPoison := not m_boGroupPoison;
        if not CheckAmulet(1, 3) then begin
          Item := GetAmulet(1, 3, nItemIdx);
          if (Item = nil) and (g_UseItems[U_BUJUK].s.Name <> '') and (g_UseItems[U_BUJUK].s.StdMode = tm_Amulet) and (g_UseItems[U_BUJUK].s.Shape <= 2) then begin
            Item := @g_UseItems[U_BUJUK];
          end else begin
            if (Item = nil) and (nCount <> 3) then Item := GetAmulet(1, 3, nItemIdx);
            if Item <> nil then begin
              if (g_WaitingUseItem.Item.S.name <> '') then Exit;
              g_WaitingUseItem.Item := Item^;
              g_WaitingUseItem.ItemType := mtBagItem;
              g_WaitingUseItem.Index2 := U_BUJUK;
              frmMain.SendTakeOnItem(U_BUJUK, Item.UserItem.MakeIndex, Item.S.name);
              DelItemBagByIdx(nItemIdx);
            end else begin
              DScreen.AddSysMsg('[Poison has been exausted]', clRed);
              exit;
            end;
          end;
        end else begin
            Item := @g_UseItems[U_BUJUK];
        end;
        if Item.S.Shape = 1 then
          pcm.Def.Magic.btEffect := 47
      end;
      {$endregion}

      if g_MagicTarget = nil then begin
        PlayScene.CXYfromMouseXY(tx, ty, targx, targy);
        targid := 0;
      end
      else begin
        targx := g_MagicTarget.m_nCurrX;
        targy := g_MagicTarget.m_nCurrY;
        targid := g_MagicTarget.m_nRecogId;
        PlayScene.ScreenXYfromMCXY(targx,targy,tx,ty);
        tdir := GetFlyDirection(364 + ((g_FScreenWidth - DEFSCREENWIDTH) div 2), 224 + ((g_FScreenHeight - DEFSCREENHEIGHT) div 2 + 12), tx, ty);
      end;
      if CanNextAction and ServerAcceptNextAction then begin
        g_dwLatestSpellTick := FrmMain.m_CurrentTick;
        g_boLatestSpell := True;
        new(pmag);
        SafeFillChar(pmag^, sizeof(TUseMagicInfo), #0);
        pmag.EffectNumber := pcm.Def.Magic.btEffect;
        pmag.MagicSerial := pcm.Def.Magic.wMagicId;
        pmag.ServerMagicCode := 0;
        //pmag.nFrame := pcm.def.magic.nSpellFrame;

        g_dwMagicDelayTime := 500 + pcm.Def.Magic.dwDelayTime;
        //g_dwMagicDelayTime := 0;

        case pmag.MagicSerial of
          2, 14, 15, 16, 17, 18, 19, 21, 12, 25, 26, 28, 29, 30, 31:;
        else
          g_dwLatestMagicTick := FrmMain.m_CurrentTick;
        end;

        //荤恩阑 傍拜窍绰 版快狼 掉饭捞
        g_dwMagicPKDelayTime := 0;
        if g_MagicTarget <> nil then
          if g_MagicTarget.m_btRace = 0 then
            g_dwMagicPKDelayTime := 300 + Random(600{1100});
        //(600+200 + MagicDelayTime div 5);
        if pmag.MagicSerial = 123 then
          tdir := g_MySelf.m_btDir;

        g_nLastMagicIdx := pcm.Def.Magic.wMagicId;
        g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
        g_CboMagicID := -1;
      end; // else
    end;
  end
  else
    DScreen.AddSysMsg('[Not enough mana to cast..]', clRed);
end;

procedure TfrmMain.UseMagicSpell(who, effnum, targetx, targety, magic_id: Integer);
var
  Actor: TActor;
  adir: Integer;
  UseMagic: PTUseMagicInfo;
begin
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then begin
    adir := GetFlyDirection(Actor.m_nCurrX, Actor.m_nCurrY, targetx, targety);
    new(UseMagic);
    SafeFillChar(UseMagic^, sizeof(TUseMagicInfo), #0);
    UseMagic.EffectNumber := effnum; //magnum;
    UseMagic.ServerMagicCode := 0; //烙矫
    UseMagic.MagicSerial := magic_id;
    //UseMagic.nFrame := GetMagicInfo(effnum).magic.nSpellFrame;
    Actor.SendMsg(SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0);
    Inc(g_nSpellCount);
  end
  else
    Inc(g_nSpellFailCount);
end;

procedure TfrmMain.UseMagicFire(who, efftype, effnum, targetx, targety, target:
  Integer);
var
  Actor: TActor;
  sound: Integer;
  //  pmag: PTUseMagicInfo;
begin
  sound := 0; //jacky
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then begin
    Actor.SendMsg(SM_MAGICFIRE, target {111magid}, efftype, effnum, targetx, targety, '', sound);
    if g_nFireCount < g_nSpellCount then
      Inc(g_nFireCount);
  end;
  g_MagicTarget := nil;
end;

procedure TfrmMain.UseMagicFireFail(who: Integer);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(who);
  if Actor <> nil then begin
    Actor.SendMsg(SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
  end;
  g_MagicTarget := nil;
end;
//吃药

procedure TfrmMain.EatItem(idx: Integer);
var
  Stditem: TStdItem;
begin
  if g_dwEatTick > FrmMain.m_CurrentTick then Exit;
  if (g_EatingItem.Item.S.name <> '') and (FrmMain.m_CurrentTick - g_dwEatTime > 30 * 1000) then begin
    g_EatingItem.Item.S.name := '';
  end;
  if g_EatingItem.Item.S.name <> '' then exit;
  if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
    if (g_ItemArr[idx].S.name <> '') then begin
      g_EatingItem.Item := g_ItemArr[idx];
      g_EatingItem.Index2 := idx;
      g_dwEatTime := FrmMain.m_CurrentTick;
      SendEat(@g_ItemArr[idx]);
      ItemUseSound(g_ItemArr[idx].S.StdMode);
    end;
  end
  else begin //basicaly if we double clicked an item and it's in 'g_movingitem' instead of  using a keyboard
    if (idx = -1) and g_boItemMoving  then begin
      g_EatingItem := g_MovingItem;
      {
      if g_MovingItem.ItemType = mtBottom then begin
        nMagID := GetBagItemIdx(g_UserKeySetup[nKey].wIndex);
        g_UserKeySetup[g_MovingItem.Origin].btType := LoWord(g_MovingItem.Index2);
        g_UserKeySetup[g_MovingItem.Origin].wIndex := HiWord(g_MovingItem.Index2);
      end else
      }

      if AddItemBag(g_EatingItem.Item, g_EatingItem.Index2) then
        ClearMovingItem()
      else begin
        if (g_EatingItem.ItemType = mtBagitem) and (g_EatingItem.Index2 in [Low(g_ItemArr)..High(g_ItemArr)]) then begin
          if g_ItemArr[g_EatingItem.Index2].S.Name <> '' then begin
            g_boItemMoving := True;
            g_MovingItem.Index2 := g_EatingItem.Index2;
            g_MovingItem.Item := g_ItemArr[g_EatingItem.Index2];
            g_MovingItem.ItemType := mtBagItem;
            DelItemBagByIdx(g_EatingItem.Index2);
            AddItemBag(g_EatingItem.Item, g_EatingItem.Index2);
          end;
        end;
      end;
      g_dwEatTime := FrmMain.m_CurrentTick;
      SendEat(@g_EatingItem.Item);
      ItemUseSound(g_EatingItem.Item.S.StdMode);
    end;
  end;
  g_sOpenItemName := '';
  if (g_EatingItem.Item.S.name <> '') and (g_EatingItem.Item.s.Reserved <> 0) then begin
    StdItem := GetStditem(g_EatingItem.Item.s.Reserved + 1, g_Myself.m_Abil.Level, g_Myself.m_btJob);
    if (StdItem.Name <> '') and (GetBagItemCountByName(g_EatingItem.Item.S.name, 2) < 2) then
      g_sOpenItemName := StdItem.Name;
  end;
end;

function TfrmMain.TargetInSwordLongAttackRange(ndir: Integer): Boolean;
var
  nX, nY: Integer;
  Actor: TActor;
begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  GetFrontPosition(nX, nY, ndir, nX, nY);
  if (abs(g_MySelf.m_nCurrX - nX) = 2) or (abs(g_MySelf.m_nCurrY - nY) = 2) then begin
    Actor := PlayScene.FindActorXY(nX, nY);
    if Actor <> nil then
      if not Actor.m_boDeath then
        Result := True;
  end;
end;

function TfrmMain.TargetInSwordWideAttackRange(ndir: Integer): Boolean;
var
  nX, nY, rx, ry, mdir: Integer;
  Actor, ractor: TActor;
  I: Integer;
begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  Actor := PlayScene.FindActorXY(nX, nY);
  if Actor = nil then exit;
  for I := 1 to 7 do begin
    //if I = 4 then Continue;
    mdir := (ndir + I) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    Ractor := PlayScene.FindActorXY(rx, ry);
    if (Ractor <> nil) and (not Ractor.m_boDeath) then begin
      Result := True;
      exit;
    end;
  end;
  {mdir := (ndir + 1) mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  if ractor = nil then begin
    mdir := (ndir + 2) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if ractor = nil then begin
    mdir := (ndir + 7) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if (Actor <> nil) and (ractor <> nil) then
    if not Actor.m_boDeath and not Ractor.m_boDeath then
      Result := True;    }
end;

function TfrmMain.TargetInSwordCrsAttackRange(ndir: Integer): Boolean;
var
  nX, nY, rx, ry, mdir: Integer;
  Actor, ractor: TActor;
begin
  Result := FALSE;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nX, nY);
  Actor := PlayScene.FindActorXY(nX, nY);

  mdir := (ndir + 1) mod 8;
  GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
  ractor := PlayScene.FindActorXY(rx, ry);
  if ractor = nil then begin
    mdir := (ndir + 2) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;
  if ractor = nil then begin
    mdir := (ndir + 7) mod 8;
    GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
    ractor := PlayScene.FindActorXY(rx, ry);
  end;

  if (Actor <> nil) and (ractor <> nil) then
    if not Actor.m_boDeath and not ractor.m_boDeath then
      Result := True;
end;

{--------------------- Mouse Interface ----------------------}

procedure TfrmMain.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
const
  itemnames: string = '';
  itemnamewidth: Integer = 0;
var
  mx, my, sel: Integer;
  target: TActor;
begin
  g_nMouseX := X;
  g_nMouseY := Y;
  DScreen.ClearHint;
  g_nMiniMapX := -1;
  g_nMiniMapMaxX := -1;
  if g_boMapApoise or g_boShowFormImage then exit;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.MouseMove(Shift, X, Y);
    Exit;
  end;
  if (Sender = Self) and g_DWinMan.MouseMove(Shift, X, Y) then begin
    if g_CursorMode = cr_None then begin
      Cursor := crMyNone;
    end;
    Exit;
  end;
  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then
    Exit;
  if FrmMain.m_CurrentTick > mousechecktime then begin
    mousechecktime := FrmMain.m_CurrentTick + 50;
    g_boSelectMyself := PlayScene.IsSelectMyself(X, Y);

    target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, FALSE);
    if g_nDupSelection <> sel then
      g_nDupSelection := 0;
    if target <> nil then begin
      if (target.m_UserName = '') and (FrmMain.m_CurrentTick - target.m_dwSendQueryUserNameTime > 10 * 1000) then begin
        target.m_dwSendQueryUserNameTime := FrmMain.m_CurrentTick;
        SendQueryUserName(target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
      end;
      g_FocusCret := target;
      if g_CursorMode = cr_None then begin
        if (target.m_btRaceServer = RC_BOX) then begin
          Cursor := crOpenBox;
        end else
        if (target.m_btRaceServer = RC_NPC) then begin
          Cursor := crMyDialog;
        end
        else if ((target.m_btRace <> RCC_USERHUMAN) and (target.m_btRaceServer <> RC_GUARD) and (pos('(', target.m_UserName) = 0))
          or (ssShift in Shift) or (target.m_OldNameColor = ENEMYCOLOR) then begin
          Cursor := crMyAttack;
        end
        else
          Cursor := crMyNone;
      end;
    end
    else begin
      g_FocusCret := nil;
      if g_CursorMode = cr_None then
        Cursor := crMyNone;
    end;

    g_FocusItem := PlayScene.GetDropItems(X, Y, itemnames, itemnamewidth);
  end;
  if g_FocusItem <> nil then begin
    PlayScene.ScreenXYfromMCXY(g_FocusItem.X, g_FocusItem.Y, mx, my);
    DScreen.ShowHint(mx - itemnamewidth div 2,
      my - 10,
      itemnames, //PTDropItem(ilist[i]).Name,
      clWhite,
      True, Integer(g_FocusItem));
  end;
  PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
  if ((ssLeft in Shift) or (ssRight in Shift)) and (FrmMain.m_CurrentTick - mousedowntime > 300) then
    _DXDrawMouseDown(Self, mbLeft, Shift, X, Y);
end;

procedure TfrmMain.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if g_boMapApoise or g_boShowFormImage then exit;
  mousedowntime := FrmMain.m_CurrentTick;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.MouseDown(Button, Shift, X, Y);
    if (Sender = Self) and g_boAllowAuction then g_DWinMan.MouseDown(Button, Shift, X, Y,true);
    Exit;
  end;
  if g_nRunReadyCount > 0 then
    g_nRunReadyCount := 0;
  _DXDrawMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TfrmMain.AttackTarget(target: TActor);
var
  tdir, dx, dy, nHitMsg, nRate: Integer;
  Shift: TShiftState;
begin
  if (g_MySelf = nil) then exit;
  //g_GuaJi.m_TargetCret := target;
  {$region 'trying to attack while on horse'}
  if (g_MySelf.m_btHorse <> 0) then begin
    if target.m_btRaceServer = RC_BOX then begin
      tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
      if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then begin
        if CanNextAction and ServerAcceptNextAction and (tdir <> g_MySelf.m_btDir) then begin
          g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end else
        if CanNextAction and ServerAcceptNextAction then begin
          g_TargetCret := nil;
          if (FrmMain.m_CurrentTick - g_dwClickNpcTick) > 2000 then begin
            g_dwClickNpcTick := FrmMain.m_CurrentTick;
            SendClientMessage(CM_CLICKBOX, target.m_nRecogId, 0, 0, 0);
          end;
        end;
      end else begin
        if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 2) and (not target.m_boDeath) then
          g_ChrAction := caWalk
        else
          g_ChrAction := caRun; //跑步砍
        GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
        g_nTargetX := dx;
        g_nTargetY := dy;
      end;
    end else begin
      if g_UseItems[U_HOUSE].s.StdMode2 = 33 then begin
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
        if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then begin
          if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
            g_MySelf.SendMsg(CM_LONGHIT, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            g_dwLatestHitTick := FrmMain.m_CurrentTick;
            g_CboMagicID := -1;
          end;
          g_dwLastAttackTick := FrmMain.m_CurrentTick;
        end else
        if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY) and
          (not target.m_boDeath) and (GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY) <= 2) then begin

          if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
            g_MySelf.SendMsg(CM_LONGHIT, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            g_dwLatestHitTick := FrmMain.m_CurrentTick;
            g_CboMagicID := -1;
          end;
          g_dwLastAttackTick := FrmMain.m_CurrentTick;
        end else begin
          if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 3) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 3) and (not target.m_boDeath) then
            g_ChrAction := caWalk
          else
            g_ChrAction := caRun; //跑步砍
          GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
          g_nTargetX := dx;
          g_nTargetY := dy;
        end;
      end;
    end;
  {$endregion}
  end else begin
    nHitMsg := CM_HIT;
    if g_UseItems[U_WEAPON].S.StdMode2 = 6 then
      nHitMsg := CM_HEAVYHIT;
    //if target.m_btRaceServer = RC_BOX then begin
    //end else begin
    tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
    if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - target.m_nCurrY) <= 1) and (not target.m_boDeath) then begin
    {$region 'trying to attack while targets next to us}
      if target.m_btRaceServer = RC_BOX then begin
        if CanNextAction and ServerAcceptNextAction and (tdir <> g_MySelf.m_btDir) then begin
          g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end else
        if CanNextAction and ServerAcceptNextAction then begin
          g_TargetCret := nil;
          if (FrmMain.m_CurrentTick - g_dwClickNpcTick) > 2000 then begin
            g_dwClickNpcTick := FrmMain.m_CurrentTick;
            SendClientMessage(CM_CLICKBOX, target.m_nRecogId, 0, 0, 0);
          end;
        end;
      end else
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
        if g_boCan110Hit then begin
          g_boCan110Hit := False;
          nHitMsg := CM_110;
          g_MyMagicArry[110].boNotUse := False;
          SetMagicUse(110);
          if g_CboMagicID = 110 then
            g_CboMagicID := -1;
        end
        else if g_boCan112Hit then begin
          g_boCan112Hit := False;
          nHitMsg := CM_112;
          g_MyMagicArry[112].boNotUse := False;
          SetMagicUse(112);
          if g_CboMagicID = 112 then
            g_CboMagicID := -1;
        end
        else if g_boCan113Hit then begin
          g_boCan113Hit := False;
          nHitMsg := CM_113;
          g_MyMagicArry[113].boNotUse := False;
          SetMagicUse(113);
          if g_CboMagicID = 113 then
            g_CboMagicID := -1;
        end
        else if g_boCan122Hit then begin
          g_boCan122Hit := False;
          nHitMsg := CM_122;
          g_MyMagicArry[122].boNotUse := False;
          SetMagicUse(122);
        end
        else if g_boCanLongIceHit then begin
          g_boCanLongIceHit := False;
          nHitMsg := CM_LONGICEHIT;
          g_MyMagicArry[43].boNotUse := False;
          SetMagicUse(43);
        end
        else if g_boCan56Hit then begin
          g_boCan56Hit := False;
          nHitMsg := CM_56;
          g_MyMagicArry[56].boNotUse := False;
          SetMagicUse(56);
        end
        else if g_boNextTimeFireHit and (g_MySelf.m_Abil.MP >= 7) then begin
          g_boNextTimeFireHit := FALSE;
          nHitMsg := CM_FIREHIT;
          g_MyMagicArry[26].boNotUse := False;
          SetMagicUse(26);
        end
        else if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
          g_boCanTwnHit := False;
          nHitMsg := CM_TWINHIT;
          g_MyMagicArry[74].boNotUse := False;
          SetMagicUse(74);
        end
        else if g_boNextTimePowerHit then begin
          g_boNextTimePowerHit := FALSE;
          nHitMsg := CM_POWERHIT;
        end
        else if g_boCanFlashDashHit and (g_MySelf.m_Abil.MP >= 12) then begin
          g_boCanFlashDashHit := False;
          nHitMsg := CM_FLASHDASHHIT;
          g_MyMagicArry[84].boNotUse := False;
          SetMagicUse(84);
        end
        else if g_boCanPoisonSwordHit and (g_MySelf.m_Abil.MP >= 14) then begin
          g_boCanPoisonSwordHit := False;
          nHitMsg := CM_POISONSWORDHIT;
          g_MyMagicArry[89].boNotUse := False;
          SetMagicUse(89);
        end
        else if (g_boCanDoubleSlash and (g_MySelf.m_Abil.MP >= 3)) then begin
          nHitMsg := CM_DOUBLESLASH;
        end
        else if (g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3)) then begin
          nHitMsg := CM_WIDEHIT;
        end
        else if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) then begin
          nHitMsg := CM_CROSSHIT;
        end
        else if (* g_SetupInfo.boAutoLongHit  or *) (g_boCanLongHit and (TargetInSwordLongAttackRange(tdir))) then begin
          nHitMsg := CM_LONGHIT;
        end;
              //g_SetupInfo.boAutoLongHit or (g_boCanLongHit and (TargetInSwordLongAttackRange(tdir)))
        g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        g_dwLatestHitTick := FrmMain.m_CurrentTick;
        g_CboMagicID := -1;
      end;
      g_dwLastAttackTick := FrmMain.m_CurrentTick;
      {$endregion}
    end
    else begin
      nHitMsg := 0;
      {$region 'trying to attack while targets away, check if we have range skills}
      if CheckBeeline(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY) and
        (not target.m_boDeath) and (target.m_btRaceServer <> RC_BOX) then begin
        nRate := GetDistance(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
        if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
          if (nRate <= 4) and g_boCanLongIceHit and g_boLongIceHitIsLong then begin
            g_boCanLongIceHit := False;
            nHitMsg := CM_LONGICEHIT;
            g_MyMagicArry[43].boNotUse := False;
            SetMagicUse(43);
          end
          else if (nRate <= 4) and g_boCan56Hit then begin
            g_boCan56Hit := False;
            nHitMsg := CM_56;
            g_MyMagicArry[56].boNotUse := False;
            SetMagicUse(56);
          end
          else if (nRate <= 3) and g_boCan112Hit then begin
            g_boCan112Hit := False;
            nHitMsg := CM_112;
            g_MyMagicArry[112].boNotUse := False;
            SetMagicUse(112);
            if g_CboMagicID = 112 then
              g_CboMagicID := -1;
          end
          else if (nRate <= 2) and g_boCanLongIceHit then begin
            g_boCanLongIceHit := False;
            nHitMsg := CM_LONGICEHIT;
            g_MyMagicArry[43].boNotUse := False;
            SetMagicUse(43);
          end;
          if nHitMsg <> 0 then begin
            g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            g_dwLatestHitTick := FrmMain.m_CurrentTick;
            g_dwLastAttackTick := FrmMain.m_CurrentTick;
          end;
        end else begin
          if (nRate <= 2) and g_boCanLongHit (* and g_SetupInfo.boAutoLongWide *) then begin
            Exit;
          end;
        end;
      end;
      {$endregion}
      if nHitMsg = 0 then begin
        g_ChrAction := caWalk;
        GetBackPosition(target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
        g_nTargetX := dx;
        g_nTargetY := dy;
      end;
    end;
  end;
end;

procedure TfrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  tdir, nX, nY, nHitMsg, sel: Integer;
  target: TActor;
begin
//if (TimerRun.Enabled = false) then exit;

  //ActionKey := 0;
  g_nMouseX := X;
  g_nMouseY := Y;
  g_boAutoDig := FALSE;
  if (Button = mbRight) and g_boItemMoving then begin
    FrmDlg.CancelItemMoving;
    Exit;
  end;
  if AutoRunTimer.Enabled and ((Button = mbLeft) or (Button = mbRight)) then
     ToggleAutoRun;//disable autorun if left/right mouse button is used
  if (Button = mbRight) and (g_CursorMode <> cr_None) then begin  //rightclcik cancels any possible FUTURE action like trades shop stuff?    (techniclay only cancels the cursors look)
    g_CursorMode := cr_None;
    Cursor := crMyNone;
    //FrmDlg.DMenuSellClick(Self, 0, 0);
    exit;
  end;

  if (Sender = Self) and g_DWinMan.MouseDown(Button, Shift, X, Y) then  //code doesnt work if your mouse is above a window
    Exit;

  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then //code only works if you're ingame
    Exit;

  if (g_CursorMode <> cr_None) and (g_CursorMode <> cr_Deal) then begin //any click cancels any FUTURE action except for shop stuff?
    g_CursorMode := cr_None;
    Cursor := crMyNone;
    //FrmDlg.DMenuSellClick(Self, 0, 0);
    exit;
  end;
  try
    if g_boAutoMoveing then begin
      g_boAutoMoveing := False;
      g_boNpcMoveing := False;
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      g_nMiniMapOldX := -1;
      DScreen.AddSysMsg('[Auto move has stopped]', clRed);
      g_nMiniMapPath := nil;
    end;

    if ssRight in Shift then begin
    //if we used right mouse button

      //first lets you cycle through different potential targets on th same spot
      if Shift = [ssRight] then //if we are ONLY right clicking (no keyboard buttons or anything
        Inc(g_nDupSelection);
      target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, FALSE);
      if g_nDupSelection <> sel then
        g_nDupSelection := 0;
      if target <> nil then begin
        if ssCtrl in Shift then begin //CTRL + right click lets you open the menu for actions like party etc
          if FrmMain.m_CurrentTick - g_dwLastMoveTick > 1000 then begin
            if (target.m_btRace = 0) and (not target.m_boDeath) then begin
              FrmDlg.OpenPlayPopupMemu(target, X, Y);
              Exit;
            end;
          end;
        end;
      end
      else
        g_nDupSelection := 0;
      //end of cycling through potential targets

      if g_MySelf.m_boShop then
        exit; //cant move, walk, turn, attack etc while your personal shop is open

      //Press the right mouse button on an empty position (no potential targets
      PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
      tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
      nX := g_MySelf.m_nCurrX;
      nY := g_MySelf.m_nCurrY;
      GetNextPosXY(tdir, nx, ny);
      checkdooraction(nx,ny);

      //check if we are facing a different direction, if we are: turn towards our new goal (only if we press right next to our char)
      if (abs(g_MySelf.m_nCurrX - g_nMouseCurrX) <= 1) and (abs(g_MySelf.m_nCurrY - g_nMouseCurrY) <= 1) then begin
        if CanNextAction and ServerAcceptNextAction and (tdir <> g_MySelf.m_btDir) then begin
          g_MySelf.SendMsg(CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end;
      end
      else begin
      //we didnt want to turn yay
        //else if FrmMain.m_CurrentTick - g_dwLastAttackTick > 300 then begin //The last attack stay a specified time in order to move the operation

        nX := g_MySelf.m_nCurrX;
        nY := g_MySelf.m_nCurrY;
        if g_MySelf.m_btHorse <> 0 then begin //if we are on a horse: try to run/move with it:p
          GetNextHorseRunXY(tdir, nX, nY);
        end
        else begin
          GetNextRunXY(tdir, nX, nY);
        end;
        g_ChrAction := caRun;
        g_nTargetX := nX;
        g_nTargetY := nY;
        Exit;
      end;
    end;
    //left mouse button
    if (ssLeft in Shift) {Button = mbLeft} and (not g_MySelf.m_boShop) then begin
      target := PlayScene.GetAttackFocusCharacter(X, Y, g_nDupSelection, sel, True); //混酒乐绰 仇父..
      if g_CursorMode = cr_Deal then begin
        if target <> nil then begin
          if (target.m_btRace = RCC_USERHUMAN) and (not Target.m_boDeath) and (FrmMain.m_CurrentTick > g_dwQueryMsgTick) then begin
            if target = g_MySelf then
              exit;
            g_dwQueryMsgTick := FrmMain.m_CurrentTick + 3000;
            frmMain.SendDealTry(target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
          end;
        end;
        exit;
      end;
      PlayScene.CXYfromMouseXY(X, Y, g_nMouseCurrX, g_nMouseCurrY);
      g_TargetCret := nil;
      //The Horse Riding state can not operation
      if (g_UseItems[U_WEAPON].S.name <> '') and (target = nil) and (g_MySelf.m_btHorse = 0) then begin
        //Mining
        if g_UseItems[U_WEAPON].S.Shape = 19 then begin //Mattock
          tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
          GetFrontPosition(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, nX, nY);
          if not Map.CanMove(nX, nY) or (ssShift in Shift) then begin //Can not move or force mining
            if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
              g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            end;
            if not Map.CanMove(nX, nY) then
              g_boAutoDig := True;
            Exit;
          end;
        end;
      end;
      //butcher code
      if (ssAlt in Shift) and (g_MySelf.m_btHorse = 0) then begin
        //make sure we're not on a horse when trying it :p
        tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
        if CanNextAction and ServerAcceptNextAction then begin
          target := PlayScene.ButchAnimal(g_nMouseCurrX, g_nMouseCurrY);
          if target <> nil then begin
            g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, target.m_nRecogId, 0, '', 0);
            //SendButchAnimal(g_nMouseCurrX, g_nMouseCurrY, tdir, target.m_nRecogId);
            //g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
            //Exit;
          end
          else
            g_MySelf.SendMsg(CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
        end;
        g_nTargetX := -1;
      end
      else begin
        if (target <> nil) or (ssShift in Shift) then begin
          g_nTargetX := -1;
          if target <> nil then begin
            if FrmMain.m_CurrentTick - g_dwLastMoveTick > 1000 then begin
              if (target.m_btRaceServer = RC_NPC) and (FrmMain.m_CurrentTick - g_dwClickNpcTick > 500) then begin
                g_dwClickNpcTick := FrmMain.m_CurrentTick;
                SendClientMessage(CM_CLICKNPC, target.m_nRecogId, 0, 0, 0);
                target.Click;
                Exit;
              end
              else if (target.m_btRace = RCC_USERHUMAN) and (target.m_boShop) and (FrmMain.m_CurrentTick - g_dwClickNpcTick > 500) then
                begin
                g_dwClickNpcTick := FrmMain.m_CurrentTick;
                SendClientMessage(CM_CLICKUSERSHOP, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
                Exit;
              end;
            end; //Horse Riding Operation not permitted
            if (not target.m_boDeath) and (not target.m_boShop) and ((g_MySelf.m_btHorse = 0) or (g_UseItems[U_HOUSE].s.StdMode2 = 33) or (target.m_btRaceServer = RC_BOX)) then begin
              g_TargetCret := target;
              if ((target.m_btRace <> RCC_USERHUMAN) and
                (target.m_btRaceServer <> RC_GUARD) and
                (target.m_btRaceServer <> RC_NPC) and
                (pos('(', target.m_UserName) = 0)) or (ssShift in Shift) or
                (target.m_OldNameColor = ENEMYCOLOR) then begin

                AttackTarget(target);
                g_dwLatestHitTick := FrmMain.m_CurrentTick;
              end;
            end;
          end
          else begin
            //骑马不允许操作
            if (g_MySelf.m_btHorse = 0) then begin
              tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
              if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                nHitMsg := CM_HIT + Random(3);

                //是否可以使用刺杀
                if (* g_SetupInfo.boAutoLongHit or *) (g_boCanLongHit and (TargetInSwordLongAttackRange(tdir))) then begin
                  nHitMsg := CM_LONGHIT;
                end;
                if (g_boCanDoubleSlash) and
                  (g_MySelf.m_Abil.MP >= 3) then begin //是否可以使用半月
                  nHitMsg := CM_DOUBLESLASH;
                end;
                if (g_boCanWideHit (* or g_SetupInfo.boAutoWideHit *) ) and
                  (g_MySelf.m_Abil.MP >= 3) and (TargetInSwordWideAttackRange(tdir)) then begin //是否可以使用半月
                  nHitMsg := CM_WIDEHIT;
                end;
                if (g_boCanCrsHit (* or g_SetupInfo.boAutoWideHit *) ) and
                  (g_MySelf.m_Abil.MP >= 6) and (TargetInSwordWideAttackRange(tdir)) then begin //是否可以使用半月
                  nHitMsg := CM_CROSSHIT;
                end;
                g_MySelf.SendMsg(nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
              end;
              g_dwLastAttackTick := FrmMain.m_CurrentTick;
            end;
          end;
        end
        else begin
          if (g_nMouseCurrX = (g_MySelf.m_nCurrX)) and (g_nMouseCurrY = (g_MySelf.m_nCurrY)) then begin
            AutoPickUpItem(False);
          end
          else if FrmMain.m_CurrentTick - g_dwLastAttackTick > 300 then begin //最后攻击操作停留指定时间才能移动
            {if ssCtrl in Shift then begin
              g_ChrAction := caRun;
            end
            else begin   }
            g_ChrAction := caWalk;
            //end;
            g_nTargetX := g_nMouseCurrX;
            g_nTargetY := g_nMouseCurrY;
          end;
        end;
      end;
    end;
    if (Button = mbMiddle) then //if it's not left and not right mouse button then check if middle and switch automove
       ToggleAutoRun;
  finally
    if (g_CursorMode <> cr_None) then begin
      g_CursorMode := cr_None;
      Cursor := crMyNone;
    end;
  end;
end;

procedure TfrmMain.DXDrawDblClick(Sender: TObject);
var
  pt: TPoint;
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;
  GetCursorPos(pt);
  pt.X := pt.X - m_Point.X;
  pt.Y := pt.Y - m_Point.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.DblClick(pt.X, pt.Y);
    Exit;
  end;
  if g_DWinMan.DblClick(pt.X, pt.Y) then
    Exit;
end;

function TfrmMain.CheckDoorAction(dx, dy: Integer): Boolean;
var
  door: Integer;
begin
  Result := FALSE;
  //if not Map.CanMove (dx, dy) then begin
     //if (Abs(dx-Myself.XX) <= 2) and (Abs(dy-Myself.m_nCurrY) <= 2) then begin
  door := Map.GetDoor(dx, dy);
  if door > 0 then begin
    if not Map.IsDoorOpen(dx, dy) then begin
      if (FrmMain.m_CurrentTick - nLastDoorTick > 50) then begin
        nLastDoorTick := FrmMain.m_CurrentTick;
        SendClientMessage(CM_OPENDOOR, door, dx, dy, 0);
      end;
      Result := True;
    end;
  end;
  //end;
//end;
end;

procedure TfrmMain.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FrmDlg.SayDlgDown := False;
  if g_boMapApoise or g_boShowFormImage then exit;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.MouseUp(Button, Shift, X, Y);
    if (Sender = Self) and g_boAllowAuction then g_DWinMan.MouseUp(Button, Shift, X, Y,true);
    Exit;
  end;
  if g_DWinMan.MouseUp(Button, Shift, X, Y) then
    Exit;
  g_nTargetX := -1;
end;

procedure TfrmMain.DXDrawClick(Sender: TObject);
var
  pt: TPoint;
begin
  if g_boMapApoise or g_boShowFormImage then
    exit;

  GetCursorPos(pt);
  pt.X := pt.X - m_Point.X;
  pt.Y := pt.Y - m_Point.Y;
  if (g_TopDWindow <> nil) and (g_TopDWindow.Visible) then begin
    g_TopDWindow.Click(pt.X, pt.Y);
    Exit;
  end;

  if g_DWinMan.Click(pt.X, pt.Y) then
    Exit;
end;

procedure TfrmMain.MouseTimerTimer(Sender: TObject);
var
  pt: TPoint;
  keyvalue: TKeyBoardState;
  Shift: TShiftState;
begin
  if g_boChangeWindow or (g_MySelf = nil) then
    exit;
  GetCursorPos(pt);
  SetCursorPos(pt.X, pt.Y);
  if g_MySelf.m_boShop then
    exit;

  if g_TargetCret <> nil then begin
    if ActionKey > 0 then begin
      ProcessKeyMessages;
    end
    else begin //(target.m_btRace <> RCC_MERCHANT)
      if PlayScene.IsValidActor(g_TargetCret) and not g_TargetCret.m_boDeath then begin
        if (g_TargetCret.m_btRace <> RCC_MERCHANT) and
          ((g_MySelf.m_btHorse = 0) or (g_UseItems[U_HOUSE].s.StdMode2 = 33) or (g_TargetCret.m_btRaceServer = RC_BOX)) and
          ((g_TargetCret.m_btRace <> RCC_USERHUMAN) or (not g_TargetCret.m_boShop)) then begin
          SafeFillChar(keyvalue, sizeof(TKeyBoardState), #0);
          if GetKeyboardState(keyvalue) then begin
            Shift := [];
            if ((keyvalue[VK_SHIFT] and $80) <> 0) then
              Shift := Shift + [ssShift];
            if ((g_TargetCret.m_btRace <> RCC_USERHUMAN) and
              (g_TargetCret.m_btRaceServer <> RC_GUARD) and
              (g_TargetCret.m_btRaceServer <> RC_NPC) and
              (pos('(', g_TargetCret.m_UserName) = 0))
              or (g_TargetCret.m_OldNameColor = ENEMYCOLOR)
              or (((ssShift in Shift) or g_boShiftOpen) and (not FrmDlg.DEditChat.Visible)) then begin
              AttackTarget(g_TargetCret);
            end;
          end;                      //  (g_UseItems[U_HOUSE].s.StdMode2 = 33)
        end;
      end
      else
        g_TargetCret := nil;
    end;
  end;
  if g_boAutoDig and (g_MySelf.m_btHorse = 0) then begin
    if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
      g_MySelf.SendMsg(CM_HIT + 1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_MySelf.m_btDir, 0, 0, '', 0);
    end;
  end;
  //g_GuaJi.Run;
end;

procedure TfrmMain.MyCheckClient(var Msg: TMessage);
var
  nMsg: Integer;
  nHandle: THandle;
begin
  nHandle := Msg.WParam;
  nMsg := Msg.LParam;
  if nHandle = g_Login_Handle then begin
    case nMsg of
      MSG_CHECK_CLIENT_TEST: Msg.Result := 1;
      MSG_CHECK_CLIENT_EXIT: ;
    end;
  end;
end;

procedure TfrmMain.MyCopyDataMessage(var MsgData: TWmCopyData);
begin
  DebugOutStr(IntToStr(MsgData.From));
  case MsgData.From of
    COPYMSG_LOGIN_SENDSERVERLIST: Move(MsgData.CopyDataStruct^.lpData^, g_ServerInfo[0], MsgData.CopyDataStruct^.cbData);
    COPYMSG_LOGIN_WEBINFO: begin
      Move(MsgData.CopyDataStruct^.lpData^, g_WebInfo, MsgData.CopyDataStruct^.cbData);
      g_DESKey := GetMD5TextOf16(g_WebInfo.g_UserList);
      g_DESKey := Copy(g_DESKey, 5, 8);
      g_PackPassword := GetMD5TextOf16(PackENRSA.EncryptStr(g_WebInfo.g_UserList));
      DebugOutStr(g_PackPassword);
      Caption := g_WebInfo.g_GameName;
      Application.Title := g_WebInfo.g_GameName;
      g_sLogoText := g_WebInfo.g_GameName;
    end;
  end;
end;

procedure TfrmMain.MyDeviceFinalize(Sender: TObject);
begin
  TimerRun.Enabled := False;
  g_DXCanvas := nil;
  UnLoadWMImagesLibEx();
  UnLoadColorLevels();
  //g_DXFont.Finalize; 
  DScreen.Finalize;
  PlayScene.Finalize;
end;

procedure TfrmMain.MyDeviceInitialize(Sender: TObject; var Success: Boolean; var ErrorMsg: string);
var
 { di: TD3DAdapter_Identifier8;
  I: Integer;     }
  nCount: Integer;
begin
  HGETextures.InitializeTexturesInfo();
  Try
//    g_LogoStr := RSADecodeString('bk9iZk7sqab=ZMlhJQVYmfhjgxddHaDZJcgyS7Sh9whNZ72w=y4');
  Except
  End;
  frmMain.Font.name := DEFFONTNAME;
  frmMain.Font.Size := DEFFONTSIZE;
  frmMain.Canvas.Font.name := DEFFONTNAME;
  frmMain.Canvas.Font.Size := DEFFONTSIZE;

  g_boInitialize := True;
  g_nInitializePer := 0;
  {HGEFont := TDXFont.Create;
  HGEFont.CreateTexture;
  HGEFont.Initialize('宋体', 9);}

  MShare.g_DXCanvas := TDXDrawCanvas.Create(g_DXFont);
  HGECanvas.g_DXCanvas := MShare.g_DXCanvas;
  g_Font := Font;

  nCount := g_DXFont.CreateTexture;
  if nCount = -1 then begin
    Success := False;
    ErrorMsg := 'Texture Size Error';
    exit;
  end;{ else
  if nCount = 2 then begin
    Direct3DCompatible := True;
  end;  }

  //if g_boFirstTime then begin
    //g_boFirstTime := FALSE;
  InitWMImagesLib(g_PackPassword);
  CreateLogoSurface();
  FboShowLogo := true;
  while not FboShowLogo do begin
    AppOnIdle();
    Sleep(1);
    Application.ProcessMessages;
    if FrmMain.m_CurrentTick > FdwShowLogoTick then begin
      FdwShowLogoTick := FrmMain.m_CurrentTick + 30;
      //if FnShowLogoIndex < 400 then

      Inc(FnShowLogoIndex, 5);
      if FnShowLogoIndex = 400 then begin
      //  InitWMImagesLib(g_PackPassword);
        break;
     end;
    end;
  end;
  //g_nInitializePer := 10;
  //AppOnIdle();
  //Refresh; //刷新主窗口,以免全黑


  g_nInitializePer := 0;
  AppOnIdle();
  FrmDlg.Initialize();
  FrmDlg.InitializeEx();
  g_nInitializePer := 30;
  AppOnIdle();
  FrmDlg2.Initialize();
  FrmDlg2.InitializeEx();
  g_nInitializePer := 40;
  AppOnIdle();
  FrmDlg3.Initialize();
  FrmDlg3.InitializeEx();
  FrmDlg4.Initialize();
  FrmDlg4.InitializeEx();
  g_nInitializePer := 50;
  AppOnIdle();
  DScreen.Initialize;
  g_nInitializePer := 60;
  AppOnIdle();
  Success := PlayScene.Initialize;
  if not Success then begin
    ErrorMsg := 'PlayScene Initialize Error';
    exit;
  end;
  g_nInitializePer := 70;
  AppOnIdle();
  Success := g_DXFont.Initialize(DEFFONTNAME, DEFFONTSIZE);
  if not Success then begin
    ErrorMsg := 'Font Initialize Error';
    exit;
  end;
  //DScreen.Initialize;
  g_nInitializePer := 100;
  Try
    AppOnIdle();
    ErrorMsg := 'Error Code = 1';
    LoadColorLevels();
    ErrorMsg := 'Error Code = 2';
  //  nCount := HGE.GetD3D.GetAdapterCount;
    ErrorMsg := 'Error Code = 3';
    FrmDlg3.DDGSDisplay.Item.Clear;
    FrmDlg3.DDGSDisplay.Item.Add('Default Display');
    ErrorMsg := 'Error Code = 9';
    {for I := 0 to nCount - 1 do begin
      HGE.GetD3D.GetAdapterIdentifier(I, 0, di);
      ErrorMsg := 'Error Code = 10';
      FrmDlg3.DDGSDisplay.Item.Add(di.Description);
    end; }
    ErrorMsg := 'Error Code = 4';
    FrmDlg3.DDGSDisplay.ItemIndex := 0;
    FrmDlg3.DDGSXY.ItemIndex := g_FScreenMode;
    FrmDlg3.DDGSBits.ItemIndex := 0;
    Sleep(100);
  {$IFDEF RELEASE}
    DLL_Encode6BitBuf := nil;
  {$ENDIF}
    ErrorMsg := 'Error Code = 5';
    DScreen.ChangeScene(stSelServer);
    ErrorMsg := 'Error Code = 6';

  {$IFDEF RELEASE}
{$IF Public_Ver <> Public_Free}
    EncryptFile_InitializationDataStream;
    DLL_Encode6BitBuf := Dll_Encrypt.FindExport(DecodeString('wxSKlhgF]kKWm{W<p<'));
    DLL_Decode6BitBuf := Dll_Encrypt.FindExport(DecodeString('whwKlhgF]kKWm{W<p<'));
{$IFEND}
  {$ENDIF}
    ErrorMsg := 'Error Code = 7';
    FBoShowLogo := True;  //ripman
    g_boInitialize := False;
    TimerRun.Enabled := True;
    ksTimer1.Enabled := True;
    ErrorMsg := 'Error Code = 8';
    if g_boFullScreen then begin
      m_Point.X := 0;
      m_Point.Y := 0;
    end;
    //this seems to be a fix for hge breaking everything on your system?
    asm
      finit;//D3D初始化引起时间错误, 重新初始化浮点单元解决问题
    end;
    ErrorMsg := 'Error Code = 9';
  Except
    Success := False;
  End;
  //end;
end;

procedure TfrmMain.AutoPickUpItem(boFlag: Boolean);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  if (m_CurrentTick - nLastPickupTick) < 100 then exit;
  nLastPickupTick := m_CurrentTick;
  if {CanNextAction and }ServerAcceptNextAction then begin
    TempItemList.Clear;
    PlayScene.GetXYDropItemsList(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, TempItemList);
    if TempItemList.Count > 0 then begin
      if boFlag and (not g_SetupInfo.boAutoPickUpItem) then begin
        for I := 0 to TempItemList.Count - 1 do begin
          DropItem := TempItemList.Items[i];
          if DropItem.Filtr.boPickUp then begin
            SendPickup;
            Break;
          end;
        end;
      end
      else
        SendPickup;
    end;
  end;
end;

procedure TfrmMain.WaitMsgTimerTimer(Sender: TObject);
begin
  if g_boChangeWindow then exit;
  if g_MySelf = nil then Exit;
  if g_MySelf.ActionFinished then begin
    
    WaitMsgTimer.Enabled := FALSE;
    //      PlayScene.MemoLog.Lines.Add('WaitingMsg: ' + IntToStr(WaitingMsg.Ident));
    case WaitingMsg.ident of
      SM_CHANGEMAP,
      SM_CHANGEMAP_OLD: begin
          if boRunTimer then outputdebugstring('running waitmsg timer while also running display update');
{$IF CHANGEMAPMODE = NEWMAPMODE}
          if WaitingMsg.ident = SM_CHANGEMAP then begin
            g_boMapInitialize := True;
            g_btMapinitializePos := 0;
            g_boMapApoise := True;
          end;
{$IFEND}
          g_boMapMovingWait := FALSE;
          Map.m_OldClientRect.Left := -1;
          if g_LegendMap.Title <> WaitingStr then begin
            ClearBGM;
            g_LegendMap.LoadFileData(GetMapDirAndName(WaitingStr));
          end;
          g_LegendMap.Title := WaitingStr;
          if g_boAutoMoveing and g_boNpcMoveing and (g_nScriptGotoStr <> '') then
            g_boNpcMoveing := True
          else
            g_boNpcMoveing := False;

          g_boAutoMoveing := False;
          g_nMiniMapPath := nil;
          if g_nMDlgX <> -1 then begin
            FrmDlg.CloseMDlg;
            g_boAllowAuction := False;
            g_nMDlgX := -1;
          end;
          if g_nMyReadShopDlgX <> -1 then begin
            FrmDlg2.DReadUserShop.Visible := False;
            g_nMyReadShopDlgX := -1;
          end;
          ClearDropItems;
          EventMan.ClearEvents;
          PlayScene.CleanObjects;
          g_sMapTitle := '';
          g_MapDesc := nil;
          g_MySelf.CleanCharMapSetting(WaitingMsg.param, WaitingMsg.tag);
          g_nTargetX := -1;
          g_TargetCret := nil;
          g_FocusCret := nil;
          g_MagicLockTarget := nil;
          g_NPCTarget := nil;
          g_MagicTarget := nil;

          PlayScene.SendMsg(SM_CHANGEMAP, 0,
            WaitingMsg.param {x},
            WaitingMsg.tag {y},
            WaitingMsg.series {darkness},
            0, 0,
            WaitingStr {mapname});
{$IF CHANGEMAPMODE = NEWMAPMODE}
          if WaitingMsg.ident = SM_CHANGEMAP then begin
            InitializeMap(WaitingStr);
          end;
{$ELSE}
          TimerInitialize.Enabled := True;
{$IFEND}
          ReleaseDCapture;
        end;
    end;
  end;
end;

function TfrmMain.EatItembyName(sItemName: string): Boolean;
var
 i: Integer;
begin
  Result := False;
  if sItemName = '' then Exit;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name = sItemName) then begin
      EatItem(i);
      Result := True;
      break;
    end;
  end;
end;

function TfrmMain.EatItemByType(nType: Integer): Boolean;
var
 i: Integer;
 function CheckItemLevel(StdItem: TStdItem): Boolean;
 begin
   Result := True;
   if g_Myself = nil then exit;
   if not CheckClass(StdItem.NeedClass,g_Myself.m_btJob) then Result := False;

   if (StdItem.Need> 0) or (StdItem.NeedLevel > 0) then begin
     case StdItem.Need of
       0: if g_Myself.m_Abil.Level < StdItem.NeedLevel then Result := False;
       2: if g_Myself.m_sGuildName = '' then Result := False;
       3: if g_Myself.m_Abil.Level >= StdItem.NeedLevel then Result := False;
     end;
   end;
 end;
begin
  Result := False;
  for i := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[i].S.Name <> '') then begin
      case nType of
        4: begin
            if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 1) and (g_ItemArr[i].s.nMAC > 0) and CheckItemLevel(g_ItemArr[i].s)  then begin
              EatItem(i);
              Result := True;
              break;
            end;
          end;
        3: begin
            if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 1) and (g_ItemArr[i].s.nAC > 0) and CheckItemLevel(g_ItemArr[i].s) then begin
              EatItem(i);
              Result := True;
              break;
            end;
          end;
        2: begin
            if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 0) and (g_ItemArr[i].s.nMAC > 0) and CheckItemLevel(g_ItemArr[i].s) then begin
              EatItem(i);
              Result := True;
              break;
            end;
          end;
        1: begin
            if (g_ItemArr[i].s.StdMode = tm_Drug) and (g_ItemArr[i].s.Shape = 0) and (g_ItemArr[i].s.nAC > 0) and CheckItemLevel(g_ItemArr[i].s) then begin
              EatItem(i);
              Result := True;
              break;
            end;
          end;
      end;
    end;
  end;
end;

procedure TfrmMain.WgTimerTimer(Sender: TObject);
const
  boIsRun: Boolean = False;
var
  i: Integer;
  ClientMissionInfo: pTClientMissionInfo;
  ClientMission: pTClientMission;
  boChange: Boolean;
  OldCount: Integer;
begin
  if boIsRun or (g_MySelf = nil) or g_boWgVisible or g_boChangeWindow or (g_MySelf.m_boDeath) then
    Exit;
  boIsRun := True;
  try
    //if (FrmMain.m_CurrentTick - g_DControlFreeTick) > 30 then
    for i := 0 to g_DControlFreeList.Count - 1 do
      TDControl(g_DControlFreeList[i]).Free;
    g_DControlFreeList.Clear;
    {g_DControlFreeList: TList;
  g_DControlFreeTick: LongWord = 0; }


    //回城物品保护
    if g_SetupInfo.boHpProtect3 and
      (g_EatingItem.Item.S.name = '') and
      (FrmMain.m_CurrentTick > g_dwEatTick) and
      (g_MySelf.m_Abil.HP <= g_SetupInfo.nHpProtectCount3) and
      (FrmMain.m_CurrentTick > g_dwHpProtectTime3) then begin
      g_dwHpProtectTime3 := FrmMain.m_CurrentTick + g_SetupInfo.dwHpProtectTime3 * 1000;
      if (g_SetupInfo.btHpProtectIdx < FrmDlg3.DDPReelItem.Item.Count) then begin
        if not EatItembyName(FrmDlg3.DDPReelItem.Item[g_SetupInfo.btHpProtectIdx]) then begin
          if FrmMain.m_CurrentTick > g_dwHpProtectTick3 then begin
            g_dwHpProtectTick3 := FrmMain.m_CurrentTick + 5000;
            DScreen.AddSysMsg('Your [<CO$FFFF>' + FrmDlg3.DDPReelItem.Item[g_SetupInfo.btHpProtectIdx] + '<CE>] has been used up', clAqua);
          end;
        end;
      end;
    end;
    //特殊金创药保护
    if g_SetupInfo.boHpProtect2 and (g_EatingItem.Item.S.name = '') and (FrmMain.m_CurrentTick > g_dwEatTick) and
      (g_MySelf.m_Abil.HP <= g_SetupInfo.nHpProtectCount2) and (FrmMain.m_CurrentTick > g_dwHpProtectTime2) then begin
      g_dwHpProtectTime2 := FrmMain.m_CurrentTick + g_SetupInfo.dwHpProtectTime2 * 1000;
      if not EatItembyType(3) then begin
        if FrmMain.m_CurrentTick > g_dwHpProtectTick2 then begin
          g_dwHpProtectTick2 := FrmMain.m_CurrentTick + 5000;
          DScreen.AddSysMsg('Your [<CO$FFFF>Effects Ointment<CE>] has been used up', clAqua);
        end;
      end;
    end;

    //HP保护
    if g_SetupInfo.boHpProtect and (g_EatingItem.Item.S.name = '') and (FrmMain.m_CurrentTick > g_dwEatTick) and
      (g_MySelf.m_Abil.HP <= g_SetupInfo.nHpProtectCount) and (FrmMain.m_CurrentTick > g_dwHpProtectTime) then begin
      g_dwHpProtectTime := FrmMain.m_CurrentTick + g_SetupInfo.dwHpProtectTime * 1000;
      if not EatItembyType(1) then begin
        if FrmMain.m_CurrentTick > g_dwHpProtectTick then begin
          g_dwHpProtectTick := FrmMain.m_CurrentTick + 5000;
          DScreen.AddSysMsg('Your [<CO$FFFF> Ointment <CE>] has been used up', clAqua);
        end;
      end;
    end;

    //特殊魔法药保护
    if g_SetupInfo.boMpProtect2 and (g_EatingItem.Item.S.name = '') and (FrmMain.m_CurrentTick > g_dwEatTick) and
      (g_MySelf.m_Abil.MP <= g_SetupInfo.nMpProtectCount2) and (FrmMain.m_CurrentTick > g_dwMpProtectTime2) then begin
      g_dwMpProtectTime2 := FrmMain.m_CurrentTick + g_SetupInfo.dwMpProtectTime2 * 1000;
      if not EatItembyType(4) then begin
        if FrmMain.m_CurrentTick > g_dwMpProtectTick2 then begin
          g_dwMpProtectTick2 := FrmMain.m_CurrentTick + 5000;
          DScreen.AddSysMsg('Your [<CO$FFFF>Magic effects ointment<CE>] has been used up', clAqua);
        end;
      end;
    end;

    //MP保护
    if g_SetupInfo.boMpProtect and (g_EatingItem.Item.S.name = '') and (FrmMain.m_CurrentTick > g_dwEatTick) and
      (g_MySelf.m_Abil.MP <= g_SetupInfo.nMpProtectCount) and (FrmMain.m_CurrentTick > g_dwMpProtectTime) then begin
      g_dwMpProtectTime := FrmMain.m_CurrentTick + g_SetupInfo.dwMpProtectTime * 1000;
      if not EatItembyType(2) then begin
        if FrmMain.m_CurrentTick > g_dwMpProtectTick then begin
          g_dwMpProtectTick := FrmMain.m_CurrentTick + 5000;
          DScreen.AddSysMsg('Your [<CO$FFFF>Magic Medicine<CE>] has been used up', clAqua);
        end;
      end;
    end;

    //自动捡取
    {
    if (FrmMain.m_CurrentTick - g_dwAutoPickupTick) > g_dwAutoPickupTime then begin
      g_dwAutoPickupTick := FrmMain.m_CurrentTick;
      AutoPickUpItem(True);
    end;
    }
    //持久警告
    if g_SetupInfo.boDuraHint and ((FrmMain.m_CurrentTick - g_dwDuraAlertTick) > g_dwDuraAlertTime) then begin
      g_dwDuraAlertTick := FrmMain.m_CurrentTick;
      for I := Low(g_UseItems) to High(g_UseItems) do begin
        if (g_UseItems[I].S.Name <> '') and (sm_Arming in g_UseItems[I].S.StdModeEx) then begin
          if (I <> U_Charm) or (g_UseItems[i].S.DuraMax > 0) then
            if (Round(g_UseItems[I].UserItem.Dura / 100) <= 1) then
              DScreen.AddSysMsg('Your equipment [<CO$FFFF>' + g_UseItems[I].S.Name + '<CE>] durability is low', clAqua);
        end;
      end;
    end;


    if g_boCanDraw then begin
(*      //自动练功
      if g_SetupInfo.boAutoMagic and (g_MySelf.m_btHorse = 0) and (not (g_SetupInfo.nAutoMagicIndex in [3, 4, 7])) and
        (g_SetupInfo.nAutoMagicIndex in [Low(g_MyMagicArry)..High(g_MyMagicArry)]) and
        ((FrmMain.m_CurrentTick() - g_dwAutoMagicTime) > g_SetupInfo.dwAutoMagicTick) and
        (not FrmDlg.DDealDlg.Visible) and
        (g_MyMagicArry[g_SetupInfo.nAutoMagicIndex].boStudy) then begin
        g_dwAutoMagicTime := FrmMain.m_CurrentTick();
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[g_SetupInfo.nAutoMagicIndex]);
      end;


      //自动开盾
      if g_SetupInfo.boAutoShield and g_MyMagicArry[SKILL_SHIELD].boStudy and (g_MySelf.m_btHorse = 0) and
        ((g_MySelf.m_nState and $00100000) = 0) and (g_CboMagicID = -1) and (not FrmDLg2.DWndBar.Visible) and
        (not FrmDlg.DDealDlg.Visible) and
        (FrmMain.m_CurrentTick > (g_MyMagicArry[SKILL_SHIELD].dwInterval + 500))  then begin
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_SHIELD]);
      end;

      //自动开天斩
      if g_SetupInfo.boAutoLongIceHit and (g_MySelf.m_btHorse = 0) and g_MyMagicArry[SKILL_LONGICEHIT].boStudy and (not FrmDLg2.DWndBar.Visible) and
        ((g_MySelf.m_nState and $00100000) = 0) and (g_CboMagicID = -1) and (not g_boNextTimeFireHit) and (not g_boCanLongIceHit) and
        (not FrmDlg.DDealDlg.Visible) and
        (FrmMain.m_CurrentTick > (g_MyMagicArry[SKILL_LONGICEHIT].dwInterval + 500))  then begin
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_LONGICEHIT]);
      end;

      //自动烈火
      if g_SetupInfo.boAutoFireHit and (g_MySelf.m_btHorse = 0) and g_MyMagicArry[SKILL_FIRESWORD].boStudy and (not FrmDLg2.DWndBar.Visible) and
        ((g_MySelf.m_nState and $00100000) = 0) and (g_CboMagicID = -1) and (not g_boNextTimeFireHit) and (not g_boCanLongIceHit) and
        (not FrmDlg.DDealDlg.Visible) and
        (FrmMain.m_CurrentTick > (g_MyMagicArry[SKILL_FIRESWORD].dwInterval + 500))  then begin
        UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_FIRESWORD]);
      end;

           *)
    end;

    //自动隐身
    {if g_SetupInfo.boAutoCloak and g_MyMagicArry[SKILL_CLOAK].boStudy and
      ((g_MySelf.m_nState and $00800000) = 0) and
      (FrmMain.m_CurrentTick > g_MyMagicArry[SKILL_CLOAK].dwInterval)  then begin
      UseMagic(g_nMouseX, g_nMouseY, @g_MyMagicArry[SKILL_CLOAK]);
    end;        }

    if FrmMain.m_CurrentTick > g_RefMissionItemTick then begin
      g_RefMissionItemTick := FrmMain.m_CurrentTick + 1500;

      for ClientMissionInfo in g_MissionInfoList do begin
        ClientMission := ClientMissionInfo.ClientMission;
        boChange := False;
        if (ClientMission.CompleteItem[0].sItemName <> '') then begin
          OldCount := ClientMissionInfo.nItemCount1;
          ClientMissionInfo.nItemCount1 := GetBagItemCountByName(ClientMission.CompleteItem[0].sItemName,
            ClientMission.CompleteItem[0].wItemCount);
          if ClientMissionInfo.nItemCount1 <> OldCount then
            boChange := True;
        end;
        if (ClientMission.CompleteItem[1].sItemName <> '') then begin
          OldCount := ClientMissionInfo.nItemCount2;
          ClientMissionInfo.nItemCount2 := GetBagItemCountByName(ClientMission.CompleteItem[1].sItemName,
            ClientMission.CompleteItem[1].wItemCount);
          if ClientMissionInfo.nItemCount2 <> OldCount then
            boChange := True;
        end;
        if (ClientMission.CompleteItem[2].sItemName <> '') then begin
          OldCount := ClientMissionInfo.nItemCount3;
          ClientMissionInfo.nItemCount3 := GetBagItemCountByName(ClientMission.CompleteItem[2].sItemName,
            ClientMission.CompleteItem[2].wItemCount);
          if ClientMissionInfo.nItemCount3 <> OldCount then
            boChange := True;
        end;
        if boChange and (ClientMission.NPC <> nil) then
          PlayScene.SetMissionInfo(ClientMission.NPC);
          
        if boChange and (FrmDlg3.DTrvwMission.Select <> nil) and
          (FrmDlg3.DTrvwMission.Select.Item = ClientMissionInfo) then
          FrmDlg3.MDlgChange := True;
        if boChange and ClientMissionInfo.MissionInfo.boTrack then
          FrmDlg2.m_boShowMissionChange := True;

      end;
    end;
    //自动喊话
    {if (g_AutoSysMsg) and ((FrmMain.m_CurrentTick - g_AutoMsgTick) > g_AutoMsgTime) then begin
      g_AutoMsgTick := FrmMain.m_CurrentTick;
      SendSay(g_AutoMsg);
    end; }
  finally
    boIsRun := False;
  end;

end;

{----------------------- Socket -----------------------}

procedure TfrmMain.SelChrWaitTimerTimer(Sender: TObject);
begin
  if g_boChangeWindow then
    exit;
  SelChrWaitTimer.Enabled := FALSE;
  SendQueryChr;
  boOpenLoginDoor := True;
end;

procedure TfrmMain.ActiveCmdTimer(cmd: TTimerCommand);
begin
  CmdTimer.Enabled := True;
  TimerCmd := cmd;
end;

procedure TfrmMain.AddSystemMsg(sMsg: string; MsgColor: TColor);
begin
  sMsg := AnsiReplaceText(sMsg, '#5', #5);
  sMsg := AnsiReplaceText(sMsg, '#6', #6);
  sMsg := AnsiReplaceText(sMsg, '#7', #7);
  DScreen.AddSayMsg(sMsg, MsgColor, clBlack, True, us_Sys);
end;

procedure TfrmMain.CmdTimerTimer(Sender: TObject);
begin
  if g_boChangeWindow then exit;
  CmdTimer.Enabled := FALSE;
  CmdTimer.Interval := 1000;
  case TimerCmd of
    tcSoftClose: begin
        CmdTimer.Enabled := FALSE;
        CSocket.Socket.Close;
      end;
    tcReSelConnect: begin
        ResetGameVariables;
        g_ConnectionStep := cnsReSelChr;
        with CSocket do begin
          Active := FALSE;
          Address := '';
          host := g_ServerInfo[g_ServerChoice].sAddrs2;
          Port := g_ServerInfo[g_ServerChoice].nPort2;
          Active := True;
        end;
      end;
    tcFastQueryChr: begin
        ResetGameVariables;
        SendQueryChr;
      end;
  end;
end;

procedure TfrmMain.CreateClientSocket(sAddrs: string; wPort: Word; nIndex: Integer);
begin
  With TClientSocket.Create(Nil) do begin
    Active := False;
    Socket.nIndex := nIndex;
    ClientType := ctNonBlocking;
    OnConnect := ClientSocketConnect;
    OnError := ClientSocketError;
    OnRead := ClientSocketRead;
    Host := sAddrs;
    Port := wPort;
    Active := True;
  end;
end;

procedure TfrmMain.CloseAllWindows(boClear: boolean=True);
begin
  FrmDlg.MDlgVisible := False;
  g_nCurMerRate := 100;
  with FrmDlg4 do begin
    DWndArmAbilityMove.Visible := False;
    DWndCompound.Visible := False;
    DTopMsg.Visible := False;
    DWndItemRemove.Visible := False;
    DWndMagicKey.Visible := False;
    if boclear then
      m_TopMsgList.Clear;
  end;
  with FrmDlg3 do begin
    DWndArmStrengthen.Visible := False;
    DWndMakeItem.Visible := False;
    DWndItemUnseal.Visible := False;
    DGuildDlg.Visible := False;
    DGameSetup.Visible := False;
    dwndMission.Visible := False;
    dwndBox.Visible := False;
    MDlgStr := '';
    ShowCanAccept := False;
    DWindowTop.Visible := False;
    if boclear then begin
      InitializeMissionTree;
      FboTopSend := False;
    end;
  end;
  with FrmDlg2 do begin
    //DWndHint.Visible := False;
    DShopWin.Visible := False;
    DWinEmail.Visible := False;
    DWinFriend.Visible := False;
    DWndEMailRead.Visible := False;
    DWndEMailNew.Visible := False;
    DWinUpLoad.Visible := False;
    DWndUserShop.Visible := False;
    DUserShopOpen.Enabled := True;
    DReadUserShop.Visible := False;
    DStorageDlg.Visible := False;
    DWndDeath.Visible := False;
    DWndBar.Visible := False;
    DWndWeb.Visible := False;
    dwndSysSetup.Visible := False;
    if boclear then
      m_boShowMissionChange := True;
  end;
  with FrmDlg do begin
    DMaxMiniMap.Visible := False;
    DItemBag.Visible := FALSE;
    DWndFace.Visible := False;
    DWudItemShow.Visible := False;
    DStateWin.Visible := False;
    DUserState.Visible := False;
    DMerchantDlg.Visible := False;
    DDealDlg.Visible := FALSE;
    DGroupDlg.Visible := False;
    DItemAppendBag1.Visible := False;
    DItemAppendBag2.Visible := False;
    DItemAppendBag3.Visible := False;
    DWndAttackModeList.Visible := False;
    dwndSayMode.Visible := False;
    dwndWhisperName.Visible := False;
    DBTCheck1.Visible := False;
    DBTCheck2.Visible := False;
    DBTCheck3.Visible := False;
    DBTCheck4.Visible := False;
    DBTCheck5.Visible := False;
    DBTCheck6.Visible := False;
    DBTCheck7.Visible := False;
    DBTCheck8.Visible := False;
    DBTCheck9.Visible := False;
    DBTCheck10.Visible := False;
    if boClear then begin
      MagicList1.Clear;
      MagicList2.Clear;
    end;
    CloseSellWindow();
    DSubShop.Visible := False;
  end;
  g_DWinMan.CloseModalShow();
  if g_nMDlgX <> -1 then begin
    FrmDlg.CloseMDlg;
    g_boAllowAuction := False;
    g_nMDlgX := -1;
  end;
  g_nMyReadShopDlgX := -1;
  if boclear then
    g_boItemMoving := FALSE
  else
    FrmDlg.CancelItemMoving();
  //g_GuaJi.Started := False;
end;

procedure TfrmMain.ClearDropItems;
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do begin
    DropItem := g_DropedItemList[i];
    {if DropItem.d <> nil then
      DropItem.d.Free;
    DropItem.d := nil; }
    Dispose(DropItem);
  end;
  g_DropedItemList.Clear;
  for i := 0 to g_FreeItemList.count - 1 do begin
    DropItem := g_FreeItemList[i];
    { if DropItem.d <> nil then
       DropItem.d.Free;
     DropItem.d := nil;  }
    Dispose(DropItem);
  end;
  g_FreeItemList.Clear;
end;

procedure TfrmMain.ResetGameVariables;
var
  i: Integer;
  ii: Integer;
  //  ClientMagic: PTClientMagic;
begin
  try
    g_CursorMode := cr_None;
    Cursor := crMyNone;
    SaveIDInfo();
    SaveHumInfo(CharName);
    CloseAllWindows;
    ClearDropItems;
    ClearEMailInfo();
    FrmDlg2.DUpLoadOk.Caption := 'Confirm Upload';
    FrmDlg.DStateInfoUpLoadPic.Enabled := True;
    FrmDlg2.DUpLoadOk.Enabled := True;
    FrmDlg.DStateInfoUpLoadPic.Enabled := True;
    //ClearShowItemList();
    for I := 2 to 5 do begin
      for II := 0 to g_ShopList[i].Count - 1 do begin
        Dispose(pTShopItem(g_ShopList[i].Items[ii]));
      end;
      g_ShopList[i].Clear;
    end;
    g_ShopList[0].Clear;
    g_ShopList[1].Clear;
    for I := Low(g_ShopGoldList) to High(g_ShopGoldList) do begin
      g_ShopGoldList[i].Clear;
    end;
    for I := 0 to g_ItemEffects.Count - 1 do
        Dispose(pTItemEffect(g_ItemEffects[i]));
    g_ItemEffects.Clear;
    for I := Low(g_StatusInfoArr) to High(g_StatusInfoArr) do
      g_StatusInfoArr[I].dwTime := 1;
    g_StatusInfoList.Clear;  
    g_ShopBuyItem := nil;
    g_boShiftOpen := False;
    {for i := Low(g_MyMagic) to High(g_MyMagic) do
      g_MyMagic[i] := nil;  }
    SafeFillChar(g_MyMagicArry, SizeOf(g_MyMagicArry), #0);

    if (FrmDlg2.HDInfoSurface <> nil) then
      FrmDlg2.HDInfoSurface.Free;
    FrmDlg2.HDInfoSurface := nil;
    if (FrmDlg2.HDSaveJpeg <> nil) then
      FrmDlg2.HDSaveJpeg.Free;
    FrmDlg2.HDSaveJpeg := nil;

    if (FrmDlg.MyHDInfoSurface <> nil) then
      FrmDlg.MyHDInfoSurface.Free;
    FrmDlg.MyHDInfoSurface := nil;
    FrmDlg.DMagicIndex := 0;
    FrmDlg.DMagicSub.Left := 185 - 8;
    {if (FrmDlg.MyHDDIB <> nil) then FrmDlg.MyHDDIB.Free;
    FrmDlg.MyHDDIB := nil;

    if FrmDlg.UserHDDIB <> nil then FrmDlg.UserHDDIB.Free;
    FrmDlg.UserHDDIB := nil;   }
    if FrmDlg.UserHDInfoSurface <> nil then
      FrmDlg.UserHDInfoSurface.Free;
    FrmDlg.UserHDInfoSurface := nil;

    //ClearGetSayItemList();
    for i := 0 to g_QuestMsgList.Count - 1 do begin
      if pTClientCheckMsg(g_QuestMsgList[i]) <> g_ClientCheckMsg then
        Dispose(pTClientCheckMsg(g_QuestMsgList[i]));
    end;

    for I := 0 to g_CenterMsgList.Count - 1 do begin
      Dispose(pTCenterMsg(g_CenterMsgList[I]));
    end;
    g_CenterMsgList.Clear;
    for I := 0 to g_SetItemsList.Count - 1 do
      Dispose(pTSetItems(g_SetItemsList[I]));

    g_SetItemsList.Clear;

    if g_ClientCheckMsg <> nil then
      Dispose(g_ClientCheckMsg);
    g_ClientCheckMsg := nil;
    g_nNakedCount := 0;
    g_nNakedBackCount := 0;
    g_FBTime := -1;
    g_FBExitTime := -1;
    g_FBFailTime := -1;
    SafeFillChar(g_ClientNakedInfo, SizeOf(g_ClientNakedInfo), #0);
    SafeFillChar(g_ClientNakedAddAbil, SizeOf(g_ClientNakedAddAbil), #0);
    SafeFillChar(g_UserKeySetup, SizeOf(g_UserKeySetup), #0);
    SafeFillChar(g_UserKeyIndex, SizeOf(g_UserKeyIndex), #0);
    SafeFillChar(g_CboMagicList, SizeOf(g_CboMagicList), #0);
    SafeFillChar(g_SendSelectItem, SizeOf(g_SendSelectItem), #0);
    SafeFillChar(g_Selectitem, SizeOf(g_Selectitem), #0);
    SafeFillChar(g_GuildIndex, SizeOf(g_GuildIndex), #0);
    SafeFillChar(g_ClientGuildInfo, SizeOf(g_ClientGuildInfo), #0);
    SetDefaultSetupInfo;
    g_CboMagicID := -1;
    g_QuestMsgList.Clear;
    g_boItemMoving := FALSE;
    g_boSendMakeMagicAdd := False;
    g_WaitingUseItem.Item.S.name := '';
    g_EatingItem.Item.S.name := '';
    g_dwEatTick := 0;
    g_MoveAddBagItem.Item.s.name := '';
    g_sOpenItemName := '';
    g_UniteUseItem.Item.s.Name := '';
    g_DealDlgItem.Item.s.Name := '';
    g_SellDlgItemSellWait.Item.s.name := '';
    g_SendRemoveStoneItem.s.name := '';
    g_MyShopItem.Item.s.Name := '';
    g_boLeapDown := False;
    g_nTargetX := -1;
    FrmDlg.dchkSayLock.Checked := True;
    g_SayUpDownLock := True;
    g_SayMode := usm_Hear;
    //g_SayShowType := us_All;
    //g_SayShowCustom := [];
    SafeFillChar(g_SayEffectIndex, SizeOf(g_SayEffectIndex), False);
    g_TargetCret := nil;
    g_FocusCret := nil;
    g_MagicTarget := nil;
    g_MagicLockTarget := nil;
    g_NPCTarget := nil;
    g_FriendList.Clear;
    ActionLock := FALSE;
    g_GuildNoticeIndex := 0;
    g_GuildMemberIndex := 0;
    g_nBindGold := 0;
    FrmDlg.ClearReturnItemList();
    FrmDlg.NpcReturn := False;
    FrmDlg3.ClearGuildMemberInfo();
    FrmDlg3.GuildNoticeList.Clear;
    FrmDlg3.DMemoGuildNotice.Lines.Clear;

    SafeFillChar(g_AddBagInfo, SizeOf(g_AddBagInfo), #0);
    g_AddBagInfo[0].nStateCount := 0;
    g_AddBagInfo[0].nItemCount := 44;

    ClearGroupMember();
    //g_sGuildRankName := '';
    //g_sGuildName := '';

    ClearMissionInfoList();
    //ClearMsgDlgList();

    //g_boMapMoving := FALSE;
    WaitMsgTimer.Enabled := FALSE;
    g_boMapMovingWait := FALSE;
    g_boMapInitialize := FALSE;
    g_boMapApoise := FALSE;
    g_boNextTimePowerHit := FALSE;
    g_boCanLongHit := FALSE;
    g_boCanWideHit := FALSE;
    g_boCanCrsHit := FALSE;
    g_boCanDoubleSlash := FALSE;
    g_boCanFlashDashHit := FALSE;
    g_boCanPoisonSwordHit := FALSE;
    g_boCanTwnHit := FALSE;
    g_boCan110Hit := FALSE;
    g_boCan111Hit := FALSE;
    g_boCan112Hit := FALSE;
    g_boCan113Hit := FALSE;
    g_boCan122Hit := FALSE;
    g_boCan56Hit := FALSE;

    g_boNextTimeFireHit := FALSE;

    SafeFillChar(g_UseItems, sizeof(g_UseItems), #0);

    SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
    SafeFillChar(g_DealRemoteItems, sizeof(g_DealRemoteItems), #0);

    SafeFillChar(g_ShopLoading, SizeOf(g_ShopLoading), 0);

    SafeFillChar(g_AddBagItems, SizeOf(g_AddBagItems), 0);
    RecalcBagCount();
    SafeFillChar(g_ArmStrengthenArr, SizeOf(g_ArmStrengthenArr), 0);
    SafeFillChar(g_MakeItemArr, SizeOf(g_MakeItemArr), 0);

    SafeFillChar(g_ItemArr, sizeof(g_ItemArr), #0);

    SafeFillChar(g_MyShopSellItems, SizeOf(g_MyShopSellItems), 0);
    SafeFillChar(g_MyShopBuyItems, SizeOf(g_MyShopBuyItems), 0);
    SafeFillChar(g_StorageArr, SizeOf(g_StorageArr), #0);
    SafeFillChar(g_boStorageRead, SizeOf(g_boStorageRead), #0);
    for I := Low(g_StorageArrList) to High(g_StorageArrList) do
      g_StorageArrList[i].Clear;

    with SelectChrScene do begin
      SafeFillChar(ChrArr, sizeof(TSelChar) * 3, #0);
    end;
    PlayScene.ClearActors;
    ClearDropItems;
    EventMan.ClearEvents;
    PlayScene.CleanObjects;
    //DxDrawRestoreSurface (self);
    g_MySelf := nil;

  except
    //  on e: Exception do
    //    PlayScene.MemoLog.Lines.Add(e.Message);
  end;
end;

procedure TfrmMain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  FSendSocketStr := '';
  boCheckSpeed := False;
  g_boServerConnected := True;
  if g_ConnectionStep = cnsLogin then begin
    ResetGameVariables;
    DScreen.ChangeScene(stLogin);
    SendSocketEx(g_CodeHead + '+' + g_CodeEnd);
  end;
  if g_ConnectionStep in [cnsSelChr] then begin
    FrmDlg.sHintStr := 'Retrieving character information';
    SelChrWaitTimer.Enabled := True;
    SendSocketEx(g_CodeHead + '+' + g_CodeEnd);
  end;
  if g_ConnectionStep = cnsReSelChr then begin
    FrmDlg.sHintStr := 'Retrieving character information';
    CmdTimer.Interval := 1;
    SendSocketEx(g_CodeHead + '+' + g_CodeEnd);
    ActiveCmdTimer(tcFastQueryChr);
  end;
  if g_ConnectionStep = cnsPlay then begin
    ClearBGM;
    FrmDlg.DBTHintClose.Visible := False;
    FrmDlg.sHintStr := 'Starting the game, please wait..';
    DScreen.ClearChatBoard;
    //ChangeServerClearGameVariables;
    SetDefaultSetupInfo;
    SendRunLogin;
    PlaySoundEx(bmg_enter);
  end;
  SocStr := '';
  BufferStr := '';
  TimerSocket.Enabled := True;
end;

procedure TfrmMain.CSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_boServerConnected := FALSE;
  boCheckSpeed := False;
  if m_boExit then begin
    g_boQueryExit := True;
    Close;
    exit;
  end else
  if g_SoftClosed then begin
    g_SoftClosed := FALSE;
    ActiveCmdTimer(tcReSelConnect);
  end
  else if not boSocketClose then begin
    if DScreen.CurrentScene = PlayScene then begin
      ResetGameVariables;
    end;
    FrmDlg.HintBack := stClose;
    FrmDlg.sHintStr := 'Disconnected from the Server';
    FrmDlg.DBTHintClose.Caption := 'Return';
    FrmDlg.boHintFocus := True;
    DScreen.ChangeScene(stHint);
  end;
  boSocketClose := False;
  TimerSocket.Enabled := False;
  FSendSocketStr := '';
end;

procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  boSocketClose := True;
  Socket.Close;
  FrmDlg.HintBack := stClose;
  FrmDlg.sHintStr := 'Failed to connect to Server..';
  FrmDlg.DBTHintClose.Caption := 'Return';
  FrmDlg.boHintFocus := True;
end;

procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  n: Integer;
  data, data2: string;
begin
  data := Socket.ReceiveText;
  //if pos('GOOD', data) > 0 then DScreen.AddSysMsg (data);

  n := pos(g_ClientCheck, data);
  if n > 0 then begin
    data2 := Copy(data, 1, n - 1);
    data := data2 + Copy(data, n + 1, Length(data));
    CheckSpeedTick := FrmMain.m_CurrentTick + 60 * 1000;
    boCheckSpeed := True;
  end;
  SocStr := SocStr + data;
end;

{-------------------------------------------------------------}

procedure TfrmMain.SendSocket(sendstr: string);
const
  Code: byte = 1;
  //var
  //  sSendText: string;
begin
  if CSocket.Socket.Connected and (not g_boSendLuck) then begin
    SendSocketEx(g_CodeHead + IntToStr(Code) + sendstr + g_CodeEnd);
    Inc(Code);
    if Code >= 10 then
      Code := 1;
  end;
end;

procedure TfrmMain.SendSocketEx(sendstr: string);
begin
  SocketLock;
  try
    if CSocket.Socket.Connected then begin
      if CSocket.Socket.SendText(FSendSocketStr + sendstr) = -1 then begin
        FSendSocketStr := FSendSocketStr + sendstr;
        if length(FSendSocketStr) > 1024 * 1024 then
          FSendSocketStr := '';
      end
      else
        FSendSocketStr := '';
    end
    else
      FSendSocketStr := '';
  finally
    SocketUnLock;
  end;
end;

procedure TfrmMain.SendClientMessage(Msg, Recog, param, tag, series: Integer; pszMsg: string);
var
  dmsg: TDefaultMessage;
begin
  dmsg := MakeDefaultMsg(Msg, Recog, param, tag, series);
  if pszMsg <> '' then
    SendSocket(EncodeMessage(dmsg) + EncodeString(pszMsg))
  else
    SendSocket(EncodeMessage(dmsg));
end;

procedure TfrmMain.SendClientSocket(Msg, Recog, param, tag, series: Integer; pszMsg: string = '');
var
  dmsg: TDefaultMessage;
begin
  dmsg := MakeDefaultMsg(Msg, Recog, param, tag, series);
  if pszMsg <> '' then
    SendSocket(EncodeMessage(dmsg) + pszMsg)
  else
    SendSocket(EncodeMessage(dmsg));
end;

procedure TfrmMain.SendLogin(uid, passwd: string);
var
  Msg: TDefaultMessage;
begin
  LoginID := uid;
  LoginPasswd := passwd;
  Msg := MakeDefaultMsg(CM_IDPASSWORD,
    g_FileVersionInfo.wBuild,
    g_FileVersionInfo.wMajor,
    g_FileVersionInfo.wMinor,
    g_FileVersionInfo.wRelease);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + passwd));
  g_boSendLogin := True; //发送登录消息
end;

procedure TfrmMain.SendCardInfo(No1, No2, No3: Word);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHECKMATRIXCARD, 0, No1, No2, No3);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendNewAccount(ue: TUserEntry; ua: TUserEntryAdd);
var
  Msg: TDefaultMessage;
begin
  MakeNewId := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
end;

procedure CheckThread(Buffer: PChar); stdcall;
var
  MaxLen: Integer;
begin
  URLDownloadToFile(nil, Buffer, '', 0, nil);
  MaxLen := PInteger(Integer(Buffer) - SizeOf(Integer))^;
  FreeMem(Pointer(Integer(Buffer) - SizeOf(Integer)), MaxLen);
end;

procedure TfrmMain.ClientSendInfo(Msg: pTDefaultMessage; bodystr: string);
var
  Buffer: PChar;
  MaxLen: Integer;
  dwThreadID: LongWord;
  sID, sUrl: string;
begin
  if g_MySelf = nil then exit;
  exit;
  { //why is client sending this data to a super encrypted string url (i had to piece together the sections in several pas files lol)
  bodystr := DecodeString(bodystr);
  GetValidStr3(bodystr, sID, ['/']);
  bodystr := HTTPEncode(GAMERSAEncodeString(GetMD5TextOf16(DateTimeToStr(Now)) + '/' + g_LoginAddr + '/' + IntToStr(g_LoginPort) + '/' + bodystr));
  sUrl := GAMERSADecodeString('ezEixdj' + 'ZvDlKYnU6' + 'IoDGmZX' + '3f3j9al=' + 'pES6ncJE' + 'pKucfQL9' + 'vUoHU5zS' + '7GDi62Pp' + 'OWpRi3nZ' + 'OKnAWOgcGRXk');
  bodystr := Format(sUrl, [sID, bodystr]);
  //DebugOutStr(bodystr);
  MaxLen := Length(bodyStr) + 1 + SizeOf(Integer);
  GetMem(Buffer, MaxLen);
  Move(MaxLen, Buffer^, SizeOf(Integer));
  Move(bodystr[1], Buffer[SizeOf(Integer)], MaxLen - SizeOf(Integer));
  CreateThread(nil, 0, @CheckThread, PChar(Integer(Buffer) + SizeOf(Integer)), 0, dwThreadID);
  }
end;

procedure TfrmMain.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  wIndex, wID: Word;
begin
  wIndex := LoWord(Socket.nIndex);
  wID := HiWord(Socket.nIndex);
  if FCheckLogin and (FLoginConnIndex = wIndex) then begin
    Socket.SendText('*');
    if wID in [Low(FLoginConnInfos)..High(FLoginConnInfos)] then begin//wtf is it doing this for :p
      g_ServerInfo[g_ServerChoice].sAddrs := FLoginConnInfos[wID].sAddrs;
      g_ServerInfo[g_ServerChoice].nPort := FLoginConnInfos[wID].wPort;
    end;
  end else
    Sender.Free;
end;

procedure TfrmMain.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var
  wIndex: Word;
begin
  wIndex := LoWord(Socket.nIndex);
  if FCheckLogin and (FLoginConnIndex = wIndex) then begin
    Dec(FCheckCount);
    if FCheckCount <= 0 then begin
      with CSocket do begin
        Active := FALSE;
        Host := g_ServerInfo[g_ServerChoice].sAddrs;
        Port := g_ServerInfo[g_ServerChoice].nPort;
        Active := True;
      end;
    end;
  end;
  ErrorCode:=0;
  Sender.Free;
end;

procedure TfrmMain.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  wIndex, wID: Word;
begin
  wIndex := LoWord(Socket.nIndex);
  wID := HiWord(Socket.nIndex);
  if FCheckLogin and (FLoginConnIndex = wIndex) then begin
    FCheckLogin := False;
    if wID in [Low(FLoginConnInfos)..High(FLoginConnInfos)] then begin
      g_ServerInfo[g_serverchoice].sAddrs := FLoginConnInfos[wID].sAddrs;
      g_ServerInfo[g_ServerChoice].nPort := FLoginConnInfos[wID].wPort;
      with CSocket do begin
        Active := FALSE;
        Host := g_ServerInfo[g_ServerChoice].sAddrs;
        Port := g_ServerInfo[g_ServerChoice].nPort;
        Active := True;
      end;
    end;
  end;
  Sender.Free;
end;

procedure TfrmMain.SendViewDelHum;
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg(CM_VIEWDELHUM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg));
end;

procedure TfrmMain.SendSelectServer(svname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SELECTSERVER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(svname));
end;

procedure TfrmMain.SendChgPw(id, passwd, newpasswd: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(id + #9 + passwd + #9 +
    newpasswd));
end;

procedure TfrmMain.SendNewChr(uid, uname, shair, sjob, ssex: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_NEWCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(uid + '/' + uname + '/' + shair + '/' + sjob + '/' + ssex));
end;

procedure TfrmMain.SendAccountCreateValidation(nWindowType: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_VALIDATECLIENTCREATION, nWindowType, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendQueryBagItems;
begin
  g_TempItemArr := g_ItemArr;
  SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
end;

procedure TfrmMain.SendQueryChr;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(LoginID + '/' + IntToStr(Certification)));
end;

procedure TfrmMain.SendDelChr(chrname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(chrname));
end;

procedure TfrmMain.SendSelChr(chrname: string);
var
  Msg: TDefaultMessage;
begin
  CharName := chrname;
  Msg := MakeDefaultMsg(CM_SELCHR, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(LoginID + '/' + chrname));
  //PlayScene.EdAccountt.Visible := FALSE; //2004/05/17
  //PlayScene.EdChrNamet.Visible := FALSE; //2004/05/17
end;

function TfrmMain.GetClientVersion(): Integer;
begin
  Result := CLIENT_VERSION_NUMBER;
end;

procedure TfrmMain.SendRunLogin;
var
  //  Msg: TDefaultMessage;
  //  str: string;
  sSendMsg: string;
  ClientVersion: Integer;
begin
  boCheckSpeed := True;
  CheckSpeedTick := FrmMain.m_CurrentTick + 100 * 1000;

  ClientVersion := GetClientVersion();

{$IFDEF DEBUG}
    sSendMsg := format('**%s/%s/%d/%d/%s/%d', [LoginID, CharName, Certification, ClientVersion, EncryStrHex(CharName, '19850506'),0]);
{$ELSE}
  {$IF (Public_Ver <> Public_Release) or (Var_Free = 1)}
    sSendMsg := format('**%s/%s/%d/%d/%d', [LoginID, CharName, Certification, ClientVersion, 0]);
  {$ELSE}
    sSendMsg := format('**%s/%s/%d/%d/%s/%d', [LoginID, CharName, Certification, ClientVersion, EncryStrHex(CharName, g_DESKey), 0]);
  {$IFEND}
{$ENDIF}
  SendSocket(EncodeString(sSendMsg));
end;

procedure TfrmMain.SendSay(str: string);
  function FormatSayStr(sMsg: string): string;
  var
    nC: Integer;
    s10: string;
    tempstr: string;
    i: integer;
    ItemIndex: Integer;
    ItemStr: string;
  begin
    nC := 0;
    tempstr := sMsg;
    Result := sMsg;
    while (True) do begin
      if TagCount(tempstr, '}') < 1 then
        break;
      tempstr := ArrestStringEx(tempstr, '{', '}', s10);
      ItemIndex := StrToIntDef(s10, -1);
      ItemStr := '';
      if ItemIndex > 0 then begin
        for I := Low(g_ItemArr) to High(g_ItemArr) do begin
          if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = ItemIndex) then begin
            ItemStr := '{0/' + IntToStr(g_ItemArr[i].UserItem.wIndex) + '/' + IntToStr(-ItemIndex) + '}';
            break;
          end;
        end;
      end;
      Result := AnsiReplaceText(Result, '{' + s10 + '}', ItemStr);
      Inc(nC);
      if nC >= 3 then
        break;
    end;
  end;
var
  Msg: TDefaultMessage;
  tempstr: string[14];
  idx: Integer;
  saystr: string;
begin
  saystr := str;
  if str <> '' then begin
    {if m_boPasswordIntputStatus then begin
      m_boPasswordIntputStatus := FALSE;
      //FrmDlg.DEditChat.PasswordChar := #0;
      FrmDlg.DEditChat.Visible := FALSE;
      //SendPassword(str, 1);
      Exit;
    end;   }
    { //the only reason why you'd want to know your own server id is to cheat and hack i think
    if CompareLstr(str, '/id', Length('/id')) and (g_MySelf <> nil) then begin
      CopyStrToClipboard(IntToStr(g_MySelf.m_nRecogId));
      Exit;
    end;
    //}
    //enable/disable the option to see every incomming chat msg (any type) in the clients debug
    if CompareLstr(str, '/outmsg', Length('/outmsg')) then begin
      boOutMsg := not boOutMsg;
      Exit;
    end;
    //enable/disable the option to show screenshot filename messages (if you want to take alot it'll stop your screen from filling with them i gess)
    if CompareLstr(str, '/ShowPrintMsg', Length('/ShowPrintMsg')) then begin
      boShowPrintMsg := not boShowPrintMsg;
      Exit;
    end;
    if str = '/time' then begin
      DScreen.AddSysMsg(DateTimeToStr(g_ServerDateTime), clWhite);
      Exit;
    end;
{$IFDEF DEBUG}
{ //most ppl and hosts get annoyed if you include these comamnds :p
    if CompareLstr(str, '/cmd', Length('/cmd')) then begin
      ProcessCommand(str);
      Exit;
    end;

    if str = '/debug' then begin
      boOutbugStr := not boOutbugStr;
      Exit;
    end;
    if str = '/debug showitemid' then begin
      g_boShowItemID := not g_boShowItemID;
      Exit;
    end;
    if str = '/debug check' then begin
      g_boShowMemoLog := not g_boShowMemoLog;
      PlayScene.MemoLog.Clear;
      PlayScene.MemoLog.Visible := g_boShowMemoLog;
      Exit;
    end;
    if str = '/debug screen' then begin
      g_boCheckBadMapMode := not g_boCheckBadMapMode;
      if g_boCheckBadMapMode then
        DScreen.AddSysMsg('On', clGreen)
      else
        DScreen.AddSysMsg('Off', clGreen);
      //是否显示相关检查地图信息(用于调试)
      Exit;
    end;
    if str = '/check speedhack' then begin
      g_boCheckSpeedHackDisplay := not g_boCheckSpeedHackDisplay;
      Exit; //是否显示机器速度
    end;
    if str = '/hungry' then begin
      Inc(g_nMyHungryState); //饥饿状态
      if g_nMyHungryState > 4 then
        g_nMyHungryState := 1;

      Exit;
    end;
    if str = '/hint screen' then begin
      g_boShowGreenHint := not g_boShowGreenHint;
      g_boShowWhiteHint := not g_boShowWhiteHint;
      Exit;
    end;
    //}
    {if str = '@password' then begin
      if FrmDlg.DEditChat.PasswordChar = #0 then
        FrmDlg.DEditChat.PasswordChar := '*'
      else
        FrmDlg.DEditChat.PasswordChar := #0;
      Exit;
    end;
    if FrmDlg.DEditChat.PasswordChar = '*' then
      FrmDlg.DEditChat.PasswordChar := #0; }
{$ELSE}
{$ENDIF}

    if CompareLStr(str, g_Cmd_AllMsg + ' ', Length(g_Cmd_AllMsg + ' ')) then begin
      if (g_UseItems[U_CIMELIA].s.Name = '') or (g_UseItems[U_CIMELIA].s.StdMode <> tm_Cowry) or
        (g_UseItems[U_CIMELIA].s.Shape <> 0) or (g_UseItems[U_CIMELIA].UserItem.Dura <= 0) then begin
        //FrmDlg.DMessageDlg('必需装备[千里传音]才能使用千里传音喊话功能！', []);
        //g_SayMode := usm_Hear;
        exit;
      end;
    end else
    if str[1] = '/' then begin
      //DScreen.AddChatBoardString(str, GetRGB(180), clWhite);
      str := GetValidStr3(Copy(str, 2, Length(str) - 1), WhisperName, [' ']);
      if CompareText(WhisperName, 'WHO') = 0 then begin
        str := '/WHO';
      end else
      if CompareText(WhisperName, 'TOTAL') = 0 then begin
        str := '/TOTAL';
      end else
      if (WhisperName <> '') {and (str <> '')} and (pos('{', WhisperName) = 0) and (pos('#', WhisperName) = 0) then begin
        tempstr := WhisperName;
        if (g_MySelf <> nil) and (tempstr <> g_MySelf.m_UserName) then begin
          idx := g_MyWhisperList.IndexOf(tempstr);
          if idx <> -1 then
            g_MyWhisperList.Delete(idx);
          g_MyWhisperList.Insert(0, tempstr);
        end;
        //str := '【私】' + #6'2450FF/8'#6'你'#5'悄悄对' + #7 + WhisperName + #7 + '说: ' + FormatSayStr(str);
        str := #7 + WhisperName + #7 + ' => ' + FormatSayStr(str);
        DScreen.AddSayMsg(str, GetRGB($B4), GetRGB($FF), False, us_Whisper);
      end
      else
        exit;
    end;
    Msg := MakeDefaultMsg(CM_SAY, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(saystr));
  end;
end;

procedure TfrmMain.SendSitDownMsg(uid, X, Y, dir: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SITDOWN, uid, x, y, dir);
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := FrmMain.m_CurrentTick;
  Inc(g_nSendCount);
end;

procedure TfrmMain.SendActMsg(ident, X, Y, dir: Integer);
var
  Msg: TDefaultMessage;
begin
  {//if you enable this it caps movement to 630ms max
  case ident of
    Cm_Run: m_RunTick:= FrmMain.m_CurrentTick();
    CM_Walk: m_WalkTick:= FrmMain.m_CurrentTick();
    Cm_HorseRun: m_HorseRunTick:= FrmMain.m_CurrentTick();
  end;
  }
  if ident = cm_run then begin
//    debugoutstr('Run Speed: ' + inttostr(FrmMain.m_CurrentTick - m_runtest) + ' orig DateTime: ' + DateTimeToStr(g_OrigServerDateTime) + ' Current DateTime: ' + DateTimeToStr(g_ServerDateTime) + ' Ticks elapsed: ' + inttostr(m_CurrentTick - g_OrigServerDateTick));
//    debugoutstr('now - original time: ' + inttostr(g_OrigServerDiff) + ' now - current datetime: ' + inttostr(Millisecondsbetween(now(), g_ServerDateTime));
    if (m_currenttick - m_runtest ) < 580  then begin
      inc(m_nRunWarning);
      if (m_nRunWarning > high(integer) - 500) then
        m_nRunWarning := 0;
//      dscreen.AddSysMsg('Running to fast',clred);
      if (m_nRunWarning mod 50 = 0) or (m_nRunWarning = 1) then begin
        Msg:= MakeDefaultMsg(CM_SPEEDCLOSE,1,(m_currenttick - m_runtest),0,0);
        SendSocket(EncodeMessage(Msg));
      end;
    end;

    m_runtest := FrmMain.m_CurrentTick;
  end;
  Msg := MakeDefaultMsg(ident, MakeLong(X, Y), 0, dir, 0);
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := FrmMain.m_CurrentTick;
  Inc(g_nSendCount);
end;

procedure TfrmMain.SendSpellMsg(ident, X, Y, dir, target: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(ident, MakeLong(X, Y), Loword(target), dir, Hiword(target));
  SendSocket(EncodeMessage(Msg));
  ActionLock := True;
  ActionLockTime := FrmMain.m_CurrentTick;
  Inc(g_nSendCount);
end;

procedure TfrmMain.SendQueryUserName(targetid, X, Y: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_QUERYUSERNAME, targetid, X, Y, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendDropItem(name: string; itemserverindex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DROPITEM, itemserverindex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(name)});
end;

procedure TfrmMain.SendPickup;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_PICKUP, 0, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendTakeOnItem(where: byte; itmindex: Integer; itmname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(itmname)});
end;
         {
procedure TfrmMain.SendTaxis(nIdx, nJob, nPage: Integer);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg(CM_TAXIS, nIdx, nJob, nPage, 0);
  SendSocket(EncodeMessage(msg));
end;
                 }
procedure TfrmMain.SendTakeOffItem(where: byte; itmindex: Integer; itmname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEOFFITEM, itmindex, where, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(itmname)});
end;

//吃东西

procedure TfrmMain.SendEat(Item: pTNewClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_EAT, Item.UserItem.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

//宰杀动物

procedure TfrmMain.SendButchAnimal(X, Y, dir, actorid: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_BUTCH, actorid, X, Y, dir);
  SendSocket(EncodeMessage(Msg));
end;
{
procedure TfrmMain.SendMagicKeyChange(magid: Integer; keych: Char);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MAGICKEYCHANGE, magid, byte(keych), 0, 0);
  SendSocket(EncodeMessage(Msg));
end;    }

procedure TfrmMain.SendCheckMsgDlgSelect(merchant, nBut: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHECKMSG, merchant, 0, 0, nBut);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendMerchantDlgSelect(merchant: Integer; rstr: string);
var
  Msg: TDefaultMessage;
  param: string;
begin
  if Length(rstr) >= 2 then begin //need at least 2 chars on a button for manual input (aka @@)
    if (rstr[1] = '~') and (rstr[2] = '@') then begin
      ExecuteScript(rstr);
      FrmDlg.LastestClickTime := 0;
      exit;
    end else
    if (rstr[1] = '@') and (rstr[2] = '@') then begin
      param := '';
      if CompareText(rstr, '@@buildguildnow') = 0 then begin
        if mrYes = FrmDlg.DMessageDlg('Please enter a guild name, length must be 3~' +intToStr(GuildNameLen)+' characters.', [mbYes, mbNo, mbAbort], GuildNameLen, deStandard) then begin
          param := Trim(FrmDlg.DlgEditText);
        end;
      end else
      if CompareText(rstr, '@@guildwar') = 0 then begin
        if mrYes = FrmDlg.DMessageDlg('Please enter the other guilds name.', [mbYes, mbNo, mbAbort], GuildNameLen, deStandard) then begin
          param := Trim(FrmDlg.DlgEditText);
        end;
      end else
      if CompareText(rstr, '@@withdrawal') = 0 then begin
        if mrYes = FrmDlg.DMessageDlg('Enter the amount you would like to withdraw.', [mbYes, mbNo, mbAbort], 8, deInteger) then begin
          param := Trim(FrmDlg.DlgEditText);
        end;
      end else
      if CompareText(rstr, '@@receipts') = 0 then begin
        if mrYes = FrmDlg.DMessageDlg('Enter the amount you would like to deposit.', [mbYes, mbNo, mbAbort], 8, deInteger) then begin
          param := Trim(FrmDlg.DlgEditText);
        end;
      end else
      if CompareLStr(rstr, '@@InputInteger', Length('@@InputInteger')) then begin
        if mrYes = FrmDlg.DMessageDlg('Please enter a value.', [mbYes, mbNo, mbAbort], 8, deInteger) then begin
          param := Trim(FrmDlg.DlgEditText);
        end;
      end else
      if mrYes = FrmDlg.DMessageDlg('Enter the information', [mbYes, mbNo, mbAbort]) then begin
        param := Trim(FrmDlg.DlgEditText);
      end;

      if param <> '' then begin
        rstr := rstr + #13 + param;
      end
      else begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        exit;
      end;
      //LastestClickTime
    end
    else if CompareText(rstr, '@exit') = 0 then begin
      FrmDlg.CloseMDlg;
      g_boAllowAuction := False;
      exit;
    end
    else if CompareText(rstr, '@close') = 0 then begin
      FrmDlg.CloseMDlg;
      g_boAllowAuction := False;
      exit;
    end
    else if CompareLStr(rstr, '@Move(', Length('@Move('))then begin
      FrmDlg.CloseMDlg;
      g_boAllowAuction := False;
      ScriptGoto(rstr);
      exit;
    end;
    Msg := MakeDefaultMsg(CM_MERCHANTDLGSELECT, merchant, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(rstr));
  end;
end;

//询问物品价格
 {
procedure TfrmMain.SendQueryPrice(merchant, itemindex: Integer; itemname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MERCHANTQUERYSELLPRICE, merchant, Loword(itemindex),
    Hiword(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;        }
//询问修理价格
{
procedure TfrmMain.SendQueryRepairCost(merchant, itemindex: Integer; itemname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MERCHANTQUERYREPAIRCOST, merchant, Loword(itemindex),
    Hiword(itemindex), 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;    }

//发送要出售的物品

procedure TfrmMain.SendSellItem(merchant, itemindex: Integer {; itemname: string});
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERSELLITEM, merchant, Loword(itemindex), Hiword(itemindex), 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(itemname)});
end;

procedure TfrmMain.SendShopBuyItem(nIdx, ItemIndex, wIdent, btGameGold: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_SHOPBUYITEMBACK, ItemIndex, wIdent, btGameGold, nIdx);
  SendSocket(EncodeMessage(DefMsg));
end;

procedure TfrmMain.SendShopList(nIdent, nIndex: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_SHOPGETLIST, nIdent, nIndex, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
end;

procedure TfrmMain.SendShopGetPoint(nCount: Integer);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(CM_SHOPGETGAMEPOINT, nCount, 0, 0, 0);
  SendSocket(EncodeMessage(DefMsg));
end;

//发送要修理的物品

procedure TfrmMain.SendRenewHum(chrname: string);
var
  msg: TDefaultMessage;
begin
  msg := MakeDefaultMsg(CM_RENEWHUM, 0, 0, 0, 0);
  SendSocket(EncodeMessage(msg) + EncodeString(chrname));
end;

procedure TfrmMain.SendRepairItem(merchant, itemindex: Integer; wFlag: Word);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERREPAIRITEM, merchant, Loword(itemindex), Hiword(itemindex), wFlag);
  SendSocket(EncodeMessage(Msg));
end;
//发送要存放的物品

procedure TfrmMain.SendStorageItem(merchant, itemindex, nIdx: Integer {; itemname:string});
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERSTORAGEITEM, merchant, Loword(itemindex), Hiword(itemindex), nIdx);
  SendSocket(EncodeMessage(Msg) {+ EncodeString(itemname)});
end;
{
procedure TfrmMain.SendGetDetailItem(merchant, menuindex: Integer; itemname:
  string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERGETDETAILITEM, merchant, menuindex, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;        }

procedure TfrmMain.SendGetSayItem(nid, ItemIndex: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETSAYITEM, ItemIndex, nid, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendBuyItem(merchant, itemserverindex, nCount, ItemIndex: Integer; boBindGold: Boolean; sName: string = '');
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERBUYITEM, ItemIndex, itemserverindex, Integer(boBindGold), nCount);
  SendSocket(EncodeMessage(Msg) + sName);
end;

procedure TfrmMain.SendTakeBackStorageItem(merchant, itemserverindex, nIdx: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERTAKEBACKSTORAGEITEM, merchant, Loword(itemserverindex), Hiword(itemserverindex), nIdx);
  SendSocket(EncodeMessage(Msg));
end;
{
procedure TfrmMain.SendMakeDrugItem(merchant: Integer; itemname: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_USERMAKEDRUGITEM, merchant, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(itemname));
end;   }

procedure TfrmMain.SendDropGold(dropgold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DROPGOLD, dropgold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGroupMode();
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GROUPMODE, Integer(g_nGameSetupData), 0, 0, 0); //off
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendCreateGroup(ItemClass: Integer; withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    Msg := MakeDefaultMsg(CM_CREATEGROUP, ItemClass, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end;

{procedure TfrmMain.SendWantMiniMap;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_WANTMINIMAP, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;}  

procedure TfrmMain.SendDealTry(nID, nX, nY: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALTRY, nID, nX, nY, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGuildDlg(index: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_OPENGUILDDLG, MakeLong(g_GuildIndex[0], g_GuildIndex[4]),
    g_GuildIndex[1], g_GuildIndex[2], g_GuildIndex[3]);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendCancelDeal;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALCANCEL, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendAddDealItem(ci: TNewClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALADDITEM, ci.UserItem.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(ci.S.name));
end;

procedure TfrmMain.SendTakeOnAddBagItem(idx, ItemIndex: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONOFFADDBAG, ItemIndex, idx, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendTakeOffAddBagItem(idx: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_TAKEONOFFADDBAG, 0, idx, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendDelDealItem(ci: TNewClientItem);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALDELITEM, ci.UserItem.MakeIndex, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) { + EncodeString(ci.S.name)});
end;

procedure TfrmMain.SendChangeDealGold(gold: Integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALCHGGOLD, gold, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendDealLock;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALEND, 1, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendDealEnd;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_DEALEND, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendAddGroupMember(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    Msg := MakeDefaultMsg(CM_ADDGROUPMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end;

procedure TfrmMain.SendDelGroupMember(withwho: string);
var
  Msg: TDefaultMessage;
begin
  if withwho <> '' then begin
    Msg := MakeDefaultMsg(CM_DELGROUPMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(withwho));
  end;
end;
{
procedure TfrmMain.SendGuildHome;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDHOME, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;     }

procedure TfrmMain.SendGuildMemberList(index: integer);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDMEMBERLIST, index, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

procedure TfrmMain.SendGuildAddMem(who: string);
var
  Msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    Msg := MakeDefaultMsg(CM_GUILDADDMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(who));
  end;
end;

procedure TfrmMain.SendGuildDelMem(who: string);
var
  Msg: TDefaultMessage;
begin
  if Trim(who) <> '' then begin
    Msg := MakeDefaultMsg(CM_GUILDDELMEMBER, 0, 0, 0, 0);
    SendSocket(EncodeMessage(Msg) + EncodeString(who));
  end;
end;

procedure TfrmMain.SendGuildUpdateNotice(notices: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDUPDATENOTICE, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(notices));
end;

procedure TfrmMain.SendGuildUpdateGrade(rankinfo: string);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GUILDUPDATERANKINFO, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeString(rankinfo));
end;

procedure TfrmMain.SendMakeItem(TitleItem, LevelItem, MakeStone1, MakeStone2, MakeStone3: Integer);
var
  Msg: TDefaultMessage;
  Msg2: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_MAKEITEM, Titleitem, LoWord(LevelItem), HiWord(LevelItem), 0);
  Msg2 := MakeDefaultMsg(LoWord(MakeStone2), MakeStone1, HiWord(MakeStone2),
    LoWord(MakeStone3), HiWord(MakeStone3));
  SendSocket(EncodeMessage(Msg) + EncodeMessage(Msg2));
end;

procedure TfrmMain.SendSpeedHackUser;
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_SPEEDHACKUSER, 0, 0, 0, 0);
  SendSocket(EncodeMessage(Msg));
end;

{procedure TfrmMain.SendAdjustBonus(remain: Integer; babil: TNakedAbility);
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_ADJUST_BONUS, remain, 0, 0, 0);
  SendSocket(EncodeMessage(Msg) + EncodeBuffer(@babil, sizeof(TNakedAbility)));
end;  }
{---------------------------------------------------------------}

function TfrmMain.ServerAcceptNextAction: Boolean;
begin
  Result := True;
  if ActionLock then begin
    if FrmMain.m_CurrentTick - ActionLockTime > 10 * 1000 then begin
      ActionLock := FALSE;
      g_boLatestSpell := False;
      //Dec (WarningLevel);
    end;
    Result := FALSE;
  end;
end;

function TfrmMain.CanNextActionEx: Boolean;
begin
  if (g_MySelf.IsIdle) and (g_MySelf.m_nState and $04000000 = 0) and (g_MySelf.m_nState and $02000000 = 0) and (g_MySelf.m_nState and $20000000 = 0) then begin
    Result := True;
  end
  else
    Result := FALSE;
end;

function TfrmMain.CanNextAction: Boolean;
begin
  if (g_MySelf.IsIdle) and (g_MySelf.m_nState and $04000000 = 0) and (g_MySelf.m_nState and $20000000 = 0) and (g_MySelf.m_nState and $02000000 = 0) and
    (FrmMain.m_CurrentTick - g_dwDizzyDelayStart > g_dwDizzyDelayTime) then begin
    Result := True;
  end
  else
    Result := FALSE;
end;

function TfrmMain.CanNextHit: Boolean;
var
  NextHitTime {, LevelFastTime}: Integer;
begin
  //LevelFastTime := _MIN(370, (g_MySelf.m_Abil.Level * 14));
  //LevelFastTime := _MIN(800, LevelFastTime + g_MySelf.m_nHitSpeed * 60);
  //LevelFastTime := GetHitInterval(g_MySelf.m_Abil.Level, g_MySelf.m_nHitSpeed);

  {if g_boAttackSlow then
    NextHitTime := 1400 - LevelFastTime + 1500
      //腕力超过时，减慢攻击速度
  else   }//取消腕力超过减速计算

  NextHitTime := 1400 - GetHitInterval(g_MySelf.m_Abil.Level, g_MySelf.m_nHitSpeed);

  if g_MySelf.m_nState and $08000000 <> 0 then
    NextHitTime := NextHitTime * 3;

  if NextHitTime < 0 then
    NextHitTime := 0;

  if (FrmMain.m_CurrentTick - LastHitTick) > LongWord(NextHitTime) then begin
    LastHitTick := FrmMain.m_CurrentTick;
    Result := True;
  end
  else
    Result := FALSE;
end;

procedure TfrmMain.ActionFailed;
begin
  g_nTargetX := -1;
  g_nTargetY := -1;
  ActionFailLock := True;
  //鞍篮 规氢栏肺 楷加捞悼角菩甫 阜扁困秦辑, FailDir苞 窃膊 荤侩
  ActionFailLockTime := FrmMain.m_CurrentTick; //Jacky
  g_MySelf.MoveFail;
  g_boLatestSpell := False;
end;

procedure TfrmMain.InitializeMap(sMapName: string);
{$IF CHANGEMAPMODE = NEWMAPMODE}
var
  i, j, nMaxCount, nCount: integer;
  sFileName: string;
  aMapFile: TFileStream;
  MapBuf: TMapInfo;
  ShowTime: LongWord;
  //nImgNumber, wunit, ani, anitick: Integer;
  dsurface: TDirectDrawSurface;
{$IFEND}
begin
{$IF CHANGEMAPMODE = NEWMAPMODE}
  TimerRun.Enabled := False;
  try
    ShowTime := FrmMain.m_CurrentTick;
    g_boLeapDown := False;
    ReleaseCapture;
    if g_LegendMap.Title = sMapName then begin
      for I := Low(g_ClientImages) to High(g_ClientImages) do begin
        //if not (I in [Images_Tiles, Images_SmTiles, Images_ObjectBegin..Images_ObjectEnd]) then begin
        if g_ClientImages[i] <> nil then begin
          g_ClientImages[i].FreeTextureByTime;
        end;
        //end;
        g_btMapinitializePos := Trunc(i / High(g_ClientImages) * 100);
        if FrmMain.m_CurrentTick > ShowTime then begin
          AppOnIdle();
          ShowTime := FrmMain.m_CurrentTick + 50;
        end;
        //Application.ProcessMessages;
      end;
    end
    else begin
      g_LegendMap.Title := sMapName;
     { sFileName := GetMapDirAndName(sMapName);

      if FileExists(sFileName) then begin
        aMapFile := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
        try
          aMapFile.Read(g_LegendMap.MapHeader, Sizeof(g_LegendMap.MapHeader));
          g_LegendMap.MapWidth := g_LegendMap.MapHeader.Width;
          g_LegendMap.MapHeight := g_LegendMap.MapHeader.Height;
          nMaxCount := g_LegendMap.MapWidth * g_LegendMap.MapHeight;
          nCount := 0;
          SetLength(g_LegendMap.MapData, g_LegendMap.MapWidth, g_LegendMap.MapHeight);
          dsurface := nil;
          for i := 0 to g_LegendMap.MapHeader.width - 1 do
            for j := 0 to g_LegendMap.MapHeader.height - 1 do begin
              aMapFile.Read(MapBuf, Sizeof(MapBuf));
              if ((MapBuf.wBkImg and $8000) + (MapBuf.wFrImg and $8000)) = 0 then
                g_LegendMap.MapData[i, j].TerrainType := True //标识为平地
              else
                g_LegendMap.MapData[i, j].TerrainType := False; //标识为障碍物

              g_btMapinitializePos := Trunc(nCount / nMaxCount * 70);

              if FrmMain.m_CurrentTick > ShowTime then begin
                AppOnIdle();
                ShowTime := FrmMain.m_CurrentTick + 100;
              end;
              //Application.ProcessMessages;
              Inc(nCount);
            end;
          if dsurface <> nil then
            g_btMapinitializePos := 100;
        finally
          aMapFile.Free;
        end;
      end;     }
      for I := Low(g_ClientImages) to High(g_ClientImages) do begin
        if g_ClientImages[i] <> nil then begin
          g_ClientImages[i].FreeTextureByTime;
        end;
        g_btMapinitializePos := 70 + Trunc(i / High(g_ClientImages) * 30);
        if FrmMain.m_CurrentTick > ShowTime then begin
          AppOnIdle();
          ShowTime := FrmMain.m_CurrentTick + 50;
        end;
        //Application.ProcessMessages;
      end;
    end;
    g_btMapinitializePos := 100;
    g_boMapInitialize := False;
    g_boMapApoise := True;
    AppOnIdle();
    SendClientMessage(CM_MAPAPOISE, 0, 0, 0, 0, '');
  finally
    TimerRun.Enabled := True;
  end;
{$IFEND}
end;

function TfrmMain.IsUnLockAction(Action, adir: Integer): Boolean;
begin
  if ActionFailLock then begin
    if FrmMain.m_CurrentTick - ActionFailLockTime > 1000 then
      ActionFailLock := FALSE;
  end;
  if ActionFailLock {or g_boMapMoving} or g_boMapMovingWait or g_boServerChanging or g_boMapInitialize or g_boMapApoise then begin
    Result := FALSE;
  end
  else
    Result := True;
{
  case Action of
    CM_WALK: begin
      if FrmMain.m_CurrentTick - m_WalkTick < 630 then
        Result := False;
    end;
    CM_RUN: begin
      if FrmMain.m_CurrentTick - m_RunTick < 630 then
        Result := False;
    end;
    CM_HORSERUN: begin
      if FrmMain.m_CurrentTick - m_HorseRunTick < 630 then
        Result := False;
    end;
  end;
}
  {
     if (ActionFailLock and (action = FailAction) and (adir = FailDir))
        or (MapMoving)
        or (BoServerChanging) then begin
        Result := FALSE;
     end else begin
        ActionFailLock := FALSE;
        Result := TRUE;
     end;
  }
end;

procedure TfrmMain.ksTimer1Timer(Sender: TObject);
begin
  m_CurrentTick := timegettime;
end;

{-------------------------------------------------------------}

procedure TfrmMain.TimerSocketTimer(Sender: TObject);
var
  data: string;
  //  mcnt: Integer;
const
  busy: Boolean = FALSE;
begin
  if busy or g_boChangeWindow then
    Exit;
  busy := True;
  try
    BufferStr := BufferStr + SocStr;
    SocStr := '';
    if BufferStr <> '' then begin
      //      mcnt := 0;
      while Length(BufferStr) >= 2 do begin
        if g_boMapMovingWait or g_boMapInitialize then
          break; // 措扁..
        if pos(g_CodeEnd, BufferStr) <= 0 then
          break;
        BufferStr := ArrestStringEx(BufferStr, g_CodeHead, g_CodeEnd, data);
        if data = '' then
          break;
        DecodeMessagePacket(data);
        if pos(g_CodeEnd, BufferStr) <= 0 then
          break;
      end;
    end;
  finally
    busy := FALSE;
  end;

  SocketLock;
  try
    if FSendSocketStr <> '' then
      SendSocketEx('');
  finally
    SocketUnLock;
  end;

  //if WarningLevel > 30 then
    //frmMain.Close;

  {if g_boQueryPrice then begin
    if FrmMain.m_CurrentTick - g_dwQueryPriceTime > 500 then begin
      g_boQueryPrice := FALSE;
      case FrmDlg.SpotDlgMode of
        dmSell: SendQueryPrice(g_nCurMerchant, g_SellDlgItem.UserItem.MakeIndex, g_SellDlgItem.S.name);
        dmRepair: SendQueryRepairCost(g_nCurMerchant, g_SellDlgItem.UserItem.MakeIndex, g_SellDlgItem.S.name);
      end;
    end;
  end;    }

end;

procedure TfrmMain.TimerTestTimer(Sender: TObject);
const
  boIsRun: Boolean = False;
var
  nMagID, targx, targy, targid, tdir: Integer;
  pmag: PTUseMagicInfo;
begin
  //designed for combo magics?
  if boIsRun or (g_MySelf = nil) or g_boWgVisible or g_boChangeWindow or (g_CboMagicID = -1) or
    (g_CboMagicID in [110, 112, 113]) then
    Exit;
  boIsRun := True;
  try
    if CanNextActionEx and ServerAcceptNextAction then begin
      nMagID := g_CboMagicID;
      g_CboMagicID := -1;
      if nMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
        if g_MyMagicArry[nMagID].boStudy and (FrmMain.m_CurrentTick > g_MyMagicArry[nMagID].dwInterval) then begin
          if nMagID = SKILL_111 then begin
            if FrmMain.m_CurrentTick < g_MyMagicArry[nMagID].dwInterval then begin
              DScreen.AddSysMsg('<CO$FFFFFF>[' + g_MagicArry[nMagID].Magic.sMagicName + ']<CE>' + ' Is Charging..', clRed);
              Exit;
            end;
            SetMagicUse(nMagID);
            g_MyMagicArry[nMagID].dwInterval := g_MyMagicArry[nMagID].dwInterval + 500;
            g_dwLatestSpellTick := FrmMain.m_CurrentTick;
            g_boLatestSpell := False;
            g_dwMagicDelayTime := 500; //g_MyMagicArry[nMagID].Def.DelayTime;
            SendSpellMsg(CM_SPELL, g_MySelf.m_btDir {x}, 0, g_MyMagicArry[nMagID].Def.Magic.wMagicId, 0);
          end
          else begin
            if (g_MyMagicArry[nMagID].Def.Magic.wSpell + g_MyMagicArry[nMagID].Def.Magic.btDefSpell > g_MySelf.m_Abil.MP) then
              begin
              DScreen.AddSysMsg('[Not enough mana to cast..]', clRed);
              exit;
            end;
            g_MagicTarget := PlayScene.FindActor(g_CboUserID);
            if g_MagicTarget = nil then begin
              DScreen.AddSysMsg('<CO$FFFFFF>Target [' + g_MagicTarget.m_UserName + ']<CE>' + ' Is out of range..', clRed);
              exit;
            end else
            if g_MagicTarget.m_boDeath then begin
              DScreen.AddSysMsg('<CO$FFFFFF>Target [' + g_MagicTarget.m_UserName + ']<CE>' + ' Is dead..', clRed);
              exit;
            end
            else begin
              targx := g_MagicTarget.m_nCurrX;
              targy := g_MagicTarget.m_nCurrY;
              targid := g_MagicTarget.m_nRecogId;
            end;
            tdir := GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, targx, targy);

            g_dwLatestSpellTick := FrmMain.m_CurrentTick;
            g_boLatestSpell := True;
            new(pmag);
            SafeFillChar(pmag^, sizeof(TUseMagicInfo), #0);
            pmag.EffectNumber := g_MyMagicArry[nMagID].Def.Magic.btEffect;
            pmag.MagicSerial := g_MyMagicArry[nMagID].Def.Magic.wMagicId;
            pmag.ServerMagicCode := 0;
            //pmag.nFrame := pcm.def.magic.nSpellFrame;

            g_dwMagicDelayTime := 700 + g_MyMagicArry[nMagID].Def.Magic.dwDelayTime;
            //g_dwMagicDelayTime := 0;

            case pmag.MagicSerial of
              2, 14, 15, 16, 17, 18, 19, 21,
                12, 25, 26, 28, 29, 30, 31: ;
            else
              g_dwLatestMagicTick := FrmMain.m_CurrentTick;
            end;

            //荤恩阑 傍拜窍绰 版快狼 掉饭捞
            g_dwMagicPKDelayTime := 0;
            if g_MagicTarget <> nil then
              if g_MagicTarget.m_btRace = 0 then
                g_dwMagicPKDelayTime := 300 + Random(1100);
            //(600+200 + MagicDelayTime div 5);
            if pmag.MagicSerial = 123 then
              tdir := g_MySelf.m_btDir;

            g_nLastMagicIdx := g_MyMagicArry[nMagID].Def.Magic.wMagicId;
            g_MySelf.SendMsg(CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
          end;
        end;
      end;
    end;
  finally
    boIsRun := False;
  end;
end;

procedure TfrmMain.TimerInitializeTimer(Sender: TObject);
begin
  TimerInitialize.Enabled := False;

end;

procedure TfrmMain.TimerRunTimer(Sender: TObject);
  {time2: LongWord = 0;
var
  time: LongWord;     }
var
  nTick, nCount: LongWord;
  nHour, nMin, nSec: Integer;
  ClientMissionInfo: pTClientMissionInfo;
  I: Integer;
  k: Integer;
  boChangeForm: Boolean;
  current: TLargeInteger;
  nu: longword;
  sAppName:string;
  outbuffer: pchar;
  outlen: integer;
begin
{
  nu := m_walktick;
  nu := timegettime;
  if (nu - m_runtest) >= 95 then begin
    inc(m_runtestcountv2);
    if m_runtestcountv2 > 6 then begin
       m_runtestcountv2 := 0;

      if (nu - m_runtick) < 730 then
        m_runtesthigh := _max(m_runtesthigh, nu - m_runtick);
      if (nu - m_runtick > 1) then
        m_runtestlow := _min(m_runtestlow, nu - m_runtick);
      if ((nu - m_runtick) < 730) and ((nu - m_runtick) > 1) then begin
       inc(m_runtestcounter);
        m_runtestaverage := (m_runtestaverage + (nu - m_runtick));
      end;
      debugoutstr(format('lowest: %d, highest: %d, average: %g',[m_runtestlow,m_runtesthigh,m_runtestaverage/m_runtestcounter]));
      m_runtick := nu;
    end;
    m_runtest := nu;

  end;
}
  if boRunTimer or g_boMapInitialize then  begin
    Exit;
  end;
  boRunTimer := True;
  try
  try
    //time := FrmMain.m_CurrentTick;
    AppOnIdle();
    nTick := FrmMain.m_CurrentTick;
    if nTick > g_ServerTimeRunTick then begin
      nCount := nTick - g_ServerTimeRunTick;

      g_ServerTimeRunTick := nTick;
      g_ServerDateTime := IncMilliSecond(g_ServerDateTime, nCount);
      if g_FBTime > 0 then Dec(g_FBTime, nCount);
      if g_FBExitTime > 0 then Dec(g_FBExitTime, nCount);
      if g_FBFailTime > 0 then Dec(g_FBFailTime, nCount);
      if g_FBTime > 0 then begin
        nHour := g_FBTime div (60 * 1000 * 60);
        nMin := g_FBTime mod (60 * 1000 * 60) div (60 * 1000);
        nSec := g_FBTime mod (60 * 1000 * 60) mod (60 * 1000) div 1000;
        g_sFBTime := Format('Remaining Instance Time.. %.2d:%.2d:%.2d', [nHour, nMin, nSec]);
      end;
      if g_FBExitTime > 0 then begin
        g_sFBExitTime := 'Will exit Instance in ' + IntToStr(g_FBExitTime div 1000) + ' seconds'
      end else
      if g_FBFailTime > 0 then begin
        g_sFBFailTime := 'Warning: Will exit instance in ' + IntToStr(g_FBFailTime div 1000) + ' Seconds, please reassign group to remain in the dungeon.';
      end;


      boChangeForm := False;
      for I := Low(g_StatusInfoArr) to High(g_StatusInfoArr) do begin
        if g_StatusInfoArr[I].dwTime > 0 then begin
          if g_StatusInfoArr[I].dwTime > nCount then begin
            Dec(g_StatusInfoArr[I].dwTime, nCount);
          end else begin
            g_StatusInfoArr[I].dwTime := 0;
            TDButton(g_StatusInfoArr[I].Button).Visible := False;
            for k := 0 to g_StatusInfoList.Count - 1 do begin
              if Integer(g_StatusInfoList[K]) = I then begin
                g_StatusInfoList.Delete(K);
                boChangeForm := True;
                Break;
              end;
            end;
          end;
        end;
      end;
      if boChangeForm then FrmDlg.RefStatusInfoForm;

      //g_sFBExitTime: string;
    end;
    if nTick > FMissionTick then begin
      FMissionTick := nTick + 60 * 1000;
      for ClientMissionInfo in g_MissionInfoList do begin
        if ClientMissionInfo.MissionInfo.wTime > 1 then begin
          Dec(ClientMissionInfo.MissionInfo.wTime);
          FrmDlg2.m_boShowMissionChange := True;
        end;
      end;
      if g_UseItems[U_HOUSE].UserItem.btAliveTime > 1 then
        Dec(g_UseItems[U_HOUSE].UserItem.btAliveTime);
    end;

    {if FrmMain.m_CurrentTick > time2 then begin
      time2 := FrmMain.m_CurrentTick + 500;
      Caption := 'FPS = ' + IntToStr(1000 div (FrmMain.m_CurrentTick - time));
    end;    }
  except
    on e: exception do
      outputdebugstring(pansichar('[Clock failed]' + e.message));
  end;
  if (m_CurrentTick - m_ScanTick) > 5*60*1000 then begin
    m_ScanTick := m_CurrentTick;
    try
      sAppName := '';
      sAppName := FindBadApps();
      if (sAppName <> '') and (g_Myself <> nil) then begin
        SendClientMessage(133,2,0,0,0,sAppName);
      end;
    except
      DebugOutStr('Warn thedeath about this crash: error 1');
    end;
  end;
  if m_boDoForceScan then begin
    m_boDoForceScan := False;
    sAppName := GetApps();
    OutLen := zipcompress(PChar(sAppName),Length(sAppName),9,OutBuffer);
    SendClientSocket(133,3,OutLen,1,2,EncodeLongBuffer(OutBuffer,OutLen));
    freemem(outbuffer);
  end;
  finally
    boRunTimer := False;
  end;
end;

procedure TfrmMain.CheckUserState(UserState: Integer);
begin
  if UserState <> -1 then begin
    if g_nAreaStateValue <> UserState then begin
      if g_nAreaStateValue = OT_SAFEAREA then
        DScreen.AddSysMsg('[Left Safe Zone]', clWhite)
      else if UserState = OT_SAFEAREA then
        DScreen.AddSysMsg('[Entered Safe Zone]', clGreen);
        
      if g_nAreaStateValue = OT_FREEPKAREA then begin
        DScreen.AddSysMsg('[Left War Zone]', clWhite);
        g_nAreaStateValue := UserState;
        PlayMapMusic(True);
      end else
      if UserState = OT_FREEPKAREA then begin
        DScreen.AddSysMsg('[Entered War Zone]', clFuchsia);
        g_nAreaStateValue := UserState;
        PlayMapMusic(True);
      end;
      g_nAreaStateValue := UserState;
      {case UserState of
        OT_SAFEAREA :begin
            DScreen.AddSysMsg('[进入安全区]', clWhite);
            //DScreen.AddChatBoardString ('[进入安全区域]',clLime , clWhite);
          end;
        OT_SAFEPK :begin
            DScreen.AddSysMsg('[进入竟技区域]', $FFFF);
            //DScreen.AddChatBoardString ('[进入竟技区域]，在该区域PK死亡不会掉落物品和增加PK值', clWhite, clBlue);
          end;
        OT_FREEPKAREA :begin
            DScreen.AddSysMsg('[进入攻城区域]', $FF00FF);
            //DScreen.AddChatBoardString ('[进入攻城区域]', clWhite, clRed);
          end;
        else begin
            DScreen.AddSysMsg('[进入危险区域]', $FF);
            //DScreen.AddChatBoardString ('[进入冒险区域]', clWhite, clRed);
        end;
      end;   }
    end;
  end;
end;

procedure TfrmMain.DecodeItem(sMsg: string; ItemBuf: PChar);
var
  nLen: Integer;
begin
  nLen := Length(Trim(sMsg));
  if nLen = GetCodeMsgSize((SizeOf(TMakeItemUserItem) - SizeOf(TUserItemValue) - SizeOf(Byte)) * 4 / 3) then begin
    DecodeBuffer(sMsg, ItemBuf, SizeOf(TMakeItemUserItem) - SizeOf(TUserItemValue));
  end else
  if nLen = GetCodeMsgSize(SizeOf(TMakeItemUserItem) * 4 / 3) then begin
    DecodeBuffer(sMsg, ItemBuf, SizeOf(TMakeItemUserItem));
  end
  else
    DecodeBuffer(sMsg, ItemBuf, Sizeof(TUserItem));
end;

procedure TfrmMain.DecodeMessagePacket(datablock: string);
var
  head, body, body2, tagstr, data, str, str1, str2: string;
  Msg: TDefaultMessage;
  //smsg: TShortMessage;
  mbw: TMessageBodyW;
  desc: TCharDesc;
  wl: TMessageBodyWL;
  //  featureEx: Word;
  i, j, n, param: Integer;
  //  tempb: Boolean;
  Actor: TActor;
  event: TClEvent;
  //  hwl: TNewCharDesc;
//  tempword: LongWord;
  Stream: TFileStream;
  Buffer: PChar;
  ClientAppendSubAbility: TClientAppendSubAbility;
  Item: TMovingItem;
  pcu: pTNewClientItem;
  UserItem: TUserItem;
  SplitDateTime: TSplitDateTime;
  k: Integer;
  DarkLevel: Integer;
  colour_of_event: Cardinal;
  //  mytemp: array[0..1023] of Char;
begin
  colour_of_event := ARGB(100, 255, 255, 255);
  if datablock[1] = '+' then begin //checkcode
    data := Copy(datablock, 2, Length(datablock) - 1);
    data := GetValidStr3(data, tagstr, ['/']);
    if tagstr = 'PWR' then begin
      g_boNextTimePowerHit := True
    end
    else if tagstr = 'DBS' then begin
      g_boCanDoubleSlash := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[82].Magic.sMagicName + ']<CE>' + ' Switched On', clGreen);
    end
    else if tagstr = 'UDBS' then begin
      g_boCanDoubleSlash := FALSE;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[82].Magic.sMagicName + ']<CE>' + ' Switched Off', clRed);
    end
    else if tagstr = 'LNG' then begin
      g_boCanLongHit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[12].Magic.sMagicName + ']<CE>' + ' Switched On', clGreen);
    end
    else if tagstr = 'ULNG' then begin
      g_boCanLongHit := FALSE;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[12].Magic.sMagicName + ']<CE>' + ' Switched Off', clRed);
    end
    else if tagstr = 'WID' then begin
      g_boCanWideHit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[25].Magic.sMagicName + ']<CE>' + ' Switched On', clGreen);
    end
    else if tagstr = 'UWID' then begin
      g_boCanWideHit := FALSE;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[25].Magic.sMagicName + ']<CE>' + ' Switched Off', clRed);
    end
    else if tagstr = 'CRS' then begin
      g_boCanCrsHit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[59].Magic.sMagicName + ']<CE>' + ' Switched On', clGreen);
    end
    else if tagstr = 'UCRS' then begin
      g_boCanCrsHit := FALSE;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[59].Magic.sMagicName + ']<CE>' + ' Switched Off', clRed);
    end
    else if tagstr = 'STN' then
      g_boCanStnHit := True
    else if tagstr = 'USTN' then
      g_boCanStnHit := FALSE
    else if tagstr = 'S110' then begin
      g_boCan110Hit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[110].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);

      g_MyMagicArry[110].boNotUse := True;
    end
    else if tagstr = 'US110' then begin
      g_boCan110Hit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[110].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      //AddSystemMsg('[' + g_MagicArry[110].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[110].boNotUse := False;
      if g_CboMagicID = 110 then begin
        g_CboMagicID := -1;
        DScreen.AddSysmsg ('Combo Disabled Due To Inactivity', clRed);
        //AddSystemMsg('[连击因超时已中断]', clGreen);
      end;
    end
    else if tagstr = 'S112' then begin
      g_boCan112Hit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[112].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      //AddSystemMsg('[' + g_MagicArry[112].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[112].boNotUse := True;
    end
    else if tagstr = 'US112' then begin
      g_boCan112Hit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[112].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      //AddSystemMsg('[' + g_MagicArry[112].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[112].boNotUse := False;
      if g_CboMagicID = 112 then begin
        g_CboMagicID := -1;
        DScreen.AddSysmsg ('Combo Disabled Due To Inactivity', clRed);
        //AddSystemMsg('[连击因超时已中断]', clGreen);
      end;
    end
    else if tagstr = 'S113' then begin
      g_boCan113Hit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[113].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      //AddSystemMsg('[' + g_MagicArry[113].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[113].boNotUse := True;
      if g_CboMagicID = 113 then begin
        g_CboMagicID := -1;
        DScreen.AddSysmsg ('Combo Disabled Due To Inactivity', clRed);
      end;
    end
    else if tagstr = 'US113' then begin
      g_boCan113Hit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[113].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      //AddSystemMsg('[' + g_MagicArry[113].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[113].boNotUse := False;
    end
    else if tagstr = 'S122' then begin
      g_boCan122Hit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[122].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      //AddSystemMsg('[' + g_MagicArry[122].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[122].boNotUse := True;
    end
    else if tagstr = 'US122' then begin
      g_boCan122Hit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[122].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      //AddSystemMsg('[' + g_MagicArry[122].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[122].boNotUse := False;
    end
    else if tagstr = 'S56' then begin
      g_boCan56Hit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[56].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      //AddSystemMsg('[' + g_MagicArry[56].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[56].boNotUse := True;
    end
    else if tagstr = 'US56' then begin
      g_boCan56Hit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[56].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      //AddSystemMsg('[' + g_MagicArry[56].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[56].boNotUse := False;
    end
    else if tagstr = 'TWN' then begin
      g_boCanTwnHit := True;
      DrawEffectHum(33 {type}, g_MySelf.m_nCurrX {x}, g_Myself.m_nCurrY {y}, g_MySelf.m_nRecogId);
      g_MyMagicArry[74].boNotUse := True;
    end
    else if tagstr = 'UTWN' then begin
      g_boCanTwnHit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[74].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      g_MyMagicArry[74].boNotUse := False;
    end
    else if tagstr = 'FDSH' then begin
      g_boCanFlashDashHit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[84].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      g_MyMagicArry[84].boNotUse := True;
    end
    else if tagstr = 'UFDSH' then begin
      g_boCanFlashDashHit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[84].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      g_MyMagicArry[84].boNotUse := False;
    end
    else if tagstr = 'PSNS' then begin
      g_boCanPoisonSwordHit := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[89].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      g_MyMagicArry[89].boNotUse := True;
    end
    else if tagstr = 'UPSNS' then begin
      g_boCanPoisonSwordHit := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[89].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      g_MyMagicArry[89].boNotUse := False;
    end
    else if tagstr = 'FIR' then begin
      g_boNextTimeFireHit := True; //打开烈火
      //g_dwLatestFireHitTick := FrmMain.m_CurrentTick;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[26].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      //AddSystemMsg('[' + g_MagicArry[26].Magic.sMagicName + '准备就绪]', clGreen);
      g_MyMagicArry[26].boNotUse := True;
    end
    else if tagstr = 'UFIR' then begin
      g_boNextTimeFireHit := FALSE; //关闭烈火  g_boCanLongIceHit
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[26].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      //AddSystemMsg('[' + g_MagicArry[26].Magic.sMagicName + '已关闭]', clRed);
      g_MyMagicArry[26].boNotUse := False;
    end
    else if tagstr = 'ICEL' then begin
      g_boCanLongIceHit := True; //打开开天斩长
      g_boLongIceHitIsLong := True;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[43].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      g_MyMagicArry[43].boNotUse := True;
    end
    else if tagstr = 'ICES' then begin
      g_boCanLongIceHit := True; //打开开天斩长
      g_boLongIceHitIsLong := False;
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[43].Magic.sMagicName + ']<CE>' + ' Charged', clGreen);
      g_MyMagicArry[43].boNotUse := True;
    end
    else if tagstr = 'UICE' then begin
      g_boCanLongIceHit := FALSE; //关闭开天斩 
      DScreen.AddSysmsg ('<CO$FFFFFF>[' + g_MagicArry[43].Magic.sMagicName + ']<CE>' + ' Lost Charge', clRed);
      g_MyMagicArry[43].boNotUse := False;
    end
    else if tagstr = 'GOOD' then begin
      ActionLock := FALSE;
      Inc(g_nReceiveCount);
      if data <> '' then
        CheckUserState(StrToIntDef(data, -1));
    end
    else if tagstr = 'FAIL' then begin
      ActionFailed;
      ActionLock := FALSE;
      Inc(g_nReceiveCount);

      if data <> '' then
        CheckUserState(StrToIntDef(data, -1));
    end;
    //DScreen.AddSysmsg (data);
   { if data <> '' then begin
      CheckUserState(StrToIntDef(data, 0));
      CheckSpeedHack(StrToIntDef(data, 0));  }
    //end;
    Exit;
  end;
  if Length(datablock) < DEFBLOCKSIZE then begin
    if datablock[1] = '=' then begin
      data := Copy(datablock, 2, Length(datablock) - 1);
      if data = 'DIG' then begin
        g_MySelf.m_boDigFragment := True;
      end;
    end;
    Exit;
  end;

  head := Copy(datablock, 1, DEFBLOCKSIZE);
  body := Copy(datablock, DEFBLOCKSIZE + 1, Length(datablock) - DEFBLOCKSIZE);
  Msg := DecodeMessage(head);

  //DScreen.AddSysMsg (IntToStr(msg.Ident));
{$IFDEF DEBUG}
  if (Msg.ident <> SM_HEALTHSPELLCHANGED) and
    (Msg.ident <> SM_HEALTHSPELLCHANGED) then begin

    if g_boShowMemoLog then begin
      ShowHumanMsg(@Msg);
      //PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(msg.Recog) + '/' + IntToStr(msg.Ident));
    end;
  end;

{$ENDIF}
  if g_MySelf = nil then begin
    case Msg.ident of
      SM_NEWID_SUCCESS: begin
          FrmDlg.HintBack := stLogin;
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          FrmDlg.sHintStr := 'Your account has been created.';
        end;
      SM_NEWID_FAIL: begin
          FrmDlg.HintBack := stLogin;
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          case Msg.Recog of
            0: begin
                FrmDlg.sHintStr := ' ';
                FrmDlg.DMessageDlg('[' + MakeNewId + '] has been taken.\Please select a new ID.!', [mbOk]);
                DScreen.ChangeScene(stLogin);
                LoginScene.NewIdRetry(FALSE); //促矫 矫档
              end;
            -2: FrmDlg.sHintStr := 'Account use has been prohibited';
          else
            FrmDlg.sHintStr := 'Account creation failed.';
          end;
        end;
      SM_CHECKMATRIXCARD: begin
          FrmDlg2.CardID[0] := Msg.Param;
          FrmDlg2.CardID[1] := Msg.tag;
          FrmDlg2.CardID[2] := Msg.Series;
          DScreen.ChangeScene(stLogin);
          LoginScene.ChangeLoginState(lsCard);

        end;
      SM_PASSWD_FAIL: begin
          FrmDlg.HintBack := stLogin;
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          case msg.Recog of
            -1: FrmDlg.sHintStr := 'Account name or password is incorrect..';
            -2: FrmDlg.sHintStr := 'The Account is locked, please try again later..';
            -3: FrmDlg.sHintStr := 'The Account may be in use, please try again later..';
            -4: FrmDlg.sHintStr := 'This account has been suspended..';
            -5: FrmDlg.sHintStr := 'This account has been suspended..';
            -6: begin
                boSocketClose := True;
                FrmMain.CSocket.Active := False;
                FrmDlg.sHintStr := 'Validation failed, please log in again..';
                FrmDlg.HintBack := stSelServer;
                FrmDlg.DBTHintClose.Caption := 'Close';
                FrmDlg.boHintFocus := True;
              end;
            -7: FrmDlg.sHintStr := 'Server exception failed, please try to log in again..';
            -8: begin
                boSocketClose := True;
                FrmMain.CSocket.Active := False;
                FrmDlg.sHintStr := 'Client version out of date, please download the latest update..';
                FrmDlg.HintBack := stClose;
                FrmDlg.DBTHintClose.Caption := 'Confirm';
                FrmDlg.boHintFocus := True;
              end;
          else
            FrmDlg.sHintStr := 'This account does not exist..';
          end;
        end;
      SM_VALIDATECLIENTCREATION: begin
        case msg.Recog of
          0: LoginScene.NewClick;
          1: begin
            SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
            ShellExecute(Handle, 'Open', PChar(DecodeString(body)), '', '', SW_SHOW);
          end;
          2: LoginScene.ChgPwClick;
          3: begin
            SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
            ShellExecute(Handle, 'Open', PChar(DecodeString(body)), '', '', SW_SHOW);
          end;
        end;
      end;
      {SM_PASSOK_SELECTSERVER: begin
          ClientGetPasswordOK(Msg, body);
        end;  }
      SM_SELECTSERVER_OK: begin
          ClientGetPasswdSuccess(body);
          g_boCreateHumIsNew := (Msg.Series = 0) or (g_WMain99Images.Images[1480] = nil);
        end;
      SM_QUERYCHR: begin
          ClientGetReceiveChrs(body);
        end;
      SM_DELHUM: begin
          ClientGetRenewHum(@msg, body);
        end;
      SM_RENEWHUM: begin
          FrmDlg.HintBack := stSelectChr;
          FrmDlg.sHintStr := 'Character recovery is successful';
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          SendQueryChr;
        end;
      SM_QUERYCHR_FAIL: begin
          g_boDoFastFadeOut := FALSE;
          g_boDoFadeIn := FALSE;
          g_boDoFadeOut := FALSE;
          FrmDlg.DMessageDlg('Server authentication failed', [mbOk]);
          Close;
        end;
      SM_NEWCHR_SUCCESS: begin
          {FrmDlg.HintBack := stSelectChr;
          FrmDlg.sHintStr := '创建成功，正在重新获取人物信息。。。';
          FrmDlg.DBTHintClose.Caption := '返回';
          FrmDlg.boHintFocus := True;    }
          FrmDlg.HintBack := stSelectChr;
          FrmDlg.sHintStr := 'Character creation successful';
          FrmDlg.DBTHintClose.Caption := 'Close';
          FrmDlg.boHintFocus := True;
          DScreen.ChangeScene(stHint);
          SendQueryChr;

          //DScreen.ChangeScene(stHint);
          //SendQueryChr;
        end;
      SM_NEWCHR_FAIL: begin
          FrmDlg.HintBack := stSelectChr;
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          case msg.Recog of
            0: FrmDlg.sHintStr := '[Failed]:The Name contains illegal characters';
            1, -1: FrmDlg.sHintStr := '[Failed]:Character Name already exists';
            2: FrmDlg.sHintStr := '[Failed]:Character slots are full';
            3: FrmDlg.sHintStr := '[Failed]:Can not re-create character';
            4: FrmDlg.sHintStr := '[Failed]:Length of character name is to large or small';
            5: FrmDlg.sHintStr := '[Failed]:Number of characters has exceeded limit';
            -2: FrmDlg.sHintStr := '[Failed]:System exception error';
          else
            FrmDlg.sHintStr := '[Failed]:Character name contains illegal characters';
          end;
        end;
      SM_CHGPASSWD_SUCCESS: begin
          FrmDlg.HintBack := stLogin;
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.sHintStr := 'Password change was successfull';
          FrmDlg.boHintFocus := True;
        end;
      SM_CHGPASSWD_FAIL: begin
          FrmDlg.HintBack := stLogin;
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          case msg.Recog of
            -1: FrmDlg.sHintStr := 'Account does not exist, or password is incorrect';
            -2: FrmDlg.sHintStr := 'This Account is locked, please try again later';
          else
            FrmDlg.sHintStr := 'Account does not exist or original password is incorrect';
          end;
        end;
      SM_DELCHR_SUCCESS: begin
          FrmDlg.HintBack := stSelectChr;
          FrmDlg.sHintStr := 'Character successfully stored';
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
          SendQueryChr;
        end;
      SM_DELCHR_FAIL: begin
          FrmDlg.HintBack := stSelectChr;
          FrmDlg.sHintStr := '[Failed]: Failed to Store Character';
          FrmDlg.DBTHintClose.Caption := 'Return';
          FrmDlg.boHintFocus := True;
        end;
      SM_STARTPLAY: begin
          FrmDlg.HintBack := stSelServer;
          FrmDlg.sHintStr := 'Connecting to game server..';
          FrmDlg.DBTHintClose.Caption := 'Cancel';
          FrmDlg.boHintFocus := False;
          DScreen.ChangeScene(stHint);
          ClientGetStartPlay(body);
          Exit;
        end;
      SM_STARTFAIL: begin
          FrmDlg.DMessageDlg('Server is full!', [mbOk]);
          FrmMain.Close;
          //ClientGetSelectServer();
          Exit;
        end;
      SM_VERSION_FAIL: begin
          FrmDlg.DMessageDlg('Game version is incorrect, please download the latest version!', [mbOk]);
          //               FrmMain.Close;
          //               frmSelMain.Close;
          Exit;
        end;
      SM_OUTOFCONNECTION,
        SM_DARK,
        SM_NEWMAP,
        SM_LOGON,
        SM_RECONNECT,
        SM_SERVERTIME,
        SM_CLIENTDATAFILE,
        SM_SENDNOTICE: ;
    else
      Exit;
    end;
  end;
  { if g_boMapMoving then begin
     if Msg.ident = SM_CHANGEMAP then begin
       WaitingMsg := Msg;
       WaitingStr := DecodeString(body);
       g_boMapMovingWait := True;
       WaitMsgTimer.Enabled := True;
     end;
     Exit;
   end;{ else
   if g_boMapApoise then begin
     exit;
   end;   }

  case Msg.ident of
    //Damian
    SM_CHANGEMAP,
    SM_CHANGEMAP_OLD: begin
        WaitingMsg := Msg;
        WaitingStr := DecodeString(body);
        g_boMapMovingWait := True;
        WaitMsgTimer.Enabled := True;
      end;
    SM_VERSION_FAIL: begin
        i := MakeLong(Msg.param, Msg.tag);
        DecodeBuffer(body, @j, sizeof(Integer));
        if (Msg.Recog <> g_nThisCRC) and
          (i <> g_nThisCRC) and
          (j <> g_nThisCRC) and (j = 1) then begin
          FrmDlg.DMessageDlg('Game version is out of date or incorrect, please download latest version.', [mbOk]);
          CSocket.Close;
          //        FrmMain.Close;
          //        frmSelMain.Close;
          Exit;
          {FrmDlg.DMessageDlg ('Wrong version. Please download latest version. (http://www.legendofmir.net)', [mbOk]);
          Close;
          exit;}
        end;
      end;
    SM_MAPAPOISE: begin
        g_boMapApoise := False;
        g_boMapMovingWait := False;
        if g_boNpcMoveing and (g_nScriptGotoStr <> '') then
          ScriptGoto(g_nScriptGotoStr);
      end;
    SM_DARK: begin
      if(msg.Recog = 0) then g_boDark := FALSE else g_boDARK := TRUE; //Sam Dark Flag
      g_target_denisty_of_dark := Round(255 - ((255 / 100) * msg.Param));
      g_cur_colour_of_dark := DecodeString(body);
      if msg.tag > 0 then
        g_wait_for_dark := True
      else
        g_wait_for_dark := False;
    end;
    SM_NEWMAP: begin
        g_sMapTitle := '';
        g_MapDesc := nil;
        str := DecodeString(body); //mapname
{$IF CHANGEMAPMODE = NEWMAPMODE}
        g_boMapInitialize := True;
        g_btMapinitializePos := 0;
        g_boMapApoise := True;
{$IFEND}
        Map.m_OldClientRect.Left := -1;
        ClearBGM;
        g_LegendMap.Title := str;
        g_LegendMap.LoadFileData(GetMapDirAndName(str));
        PlayScene.SendMsg(SM_NEWMAP, 0,
          Msg.param {x},
          Msg.tag {y},
          Msg.series {darkness},
          0, 0,
          str {mapname});
        InitializeMap(str);
      end;
    SM_CHANGELIGHT: begin
      Actor := PlayScene.FindActor(Msg.Recog);
      if Actor <> nil then begin
        Actor.m_nLightRange := Msg.Param;
      end;
    end;
    SM_LAMPCHANGEDURA: begin
      if (g_UseItems[U_RIGHTHAND].S.Name <> '') then
        g_UseItems[U_RIGHTHAND].UserItem.Dura := Msg.Recog;
    end;
    SM_LOGON: begin
        g_dwFirstServerTime := 0;
        g_dwFirstClientTime := 0;
        with Msg do begin
          DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
          PlayScene.SendMsg(SM_LOGON, Msg.Recog,
            Msg.param {x},
            Msg.tag {y},
            Msg.series {dir},
            wl.lParam1, //desc.Feature,
            wl.lParam2, //desc.Status,
            '');
          DScreen.ChangeScene(stPlayGame);

          {if Loword(wl.lTag1) = 0 then
            g_boAllowGroup := FALSE
          else
            g_boAllowGroup := True;

          if hiword(wl.lTag1) = 0 then
            g_boCheckGroup := FALSE
          else
            g_boCheckGroup := True; }
          g_nGameSetupData := LongWord(wl.lTag1);
          //g_boAllowGroup := not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
          //g_boCheckGroup := CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK);
          g_boServerChanging := FALSE;
          g_nDander := LoWord(wl.lTag2);
        end;
        LoadIDInfo();
        LoadHumInfo(CharName);
        if g_MySelf <> nil then begin
          FrmDlg.SetGroupWnd;
          FMissionTick := FrmMain.m_CurrentTick + 60 * 1000;
        end;
        g_boBagItemsRead := False;
        SendClientMessage(CM_QUERYBAGITEMS, 0, 0, 0, 0);
      end;
    SM_IMAGEMODIFICATION: begin
      FrmDlg.DMessageDlg('Light image modification detected, please resolve this now!', [mbOk]);
      CSocket.Close;
      Exit;
    end;
    SM_SERVERTIME: begin
        SplitDateTime.nInt := Msg.Recog;
        SplitDateTime.wWord := Msg.Param;
        SplitDateTime.wWord2 := Msg.tag;
        g_ServerDateTime := SplitDateTime.DateTime;
        g_ServerTimeRunTick := FrmMain.m_CurrentTick;
        g_OrigServerDateTime := g_ServerDateTime;
        g_OrigServerDateTick := m_CurrentTick;
        g_OrigServerDiff := Millisecondsbetween(now(), g_OrigServerDateTime);
      end;
    SM_NAKEDABILITY: begin
        g_nNakedCount := Msg.Recog;
        g_nNakedBackCount := MakeLong(Msg.Param, Msg.tag);
        if body <> '' then begin
          DecodeBuffer(body, @g_ClientNakedInfo, SizeOf(g_ClientNakedInfo));
          SafeFillChar(g_ClientNakedAddAbil, SizeOf(g_ClientNakedAddAbil), #0);
          GetNakedAbilitys(@g_ClientNakedAddAbil, @g_ClientNakedInfo.NakedAbil, @g_ClientNakedInfo.NakedAddInfo);
        end;
        if ((g_nNakedCount > 0) or (g_nNakedBackCount > 0)) and (g_ClientCheckMsg = nil) then begin
          FrmDlg.DBotAddAbil.Visible := True;
        end;
        FrmDlg.RefNakedWindow();
      end;
    SM_REALITYINFO: begin
        g_UserRealityInfo.boFriendSee := Msg.Recog = 1;
        g_UserRealityInfo.btOld := LoByte(Msg.Param);
        g_UserRealityInfo.btSex := HiByte(Msg.Param);
        g_UserRealityInfo.btProvince := LoByte(Msg.tag);
        g_UserRealityInfo.btCity := HiByte(Msg.tag);
        g_UserRealityInfo.btArea := LoByte(Msg.Series);
        g_UserRealityInfo.btOnlineTime := HiByte(Msg.Series);
        body := GetValidStrEx(DecodeString(body), str, ['/']);
        g_UserRealityInfo.sPhotoID := str;
        body := GetValidStrEx(body, str, ['/']);
        g_UserRealityInfo.sUserName := str;
        g_UserRealityInfo.sIdiograph := body;
        if g_UserRealityInfo.sPhotoID <> '' then begin
          if FileExists(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg') then begin
            FrmDlg.RefPhotoSurface(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', FrmDlg.MyHDInfoSurface);
          end;
        end;
        FrmDlg.RefRealityInfo();
      end;
    SM_SERVERCONFIG: ClientGetServerConfig(Msg, body);

    SM_RECONNECT: begin
      if Msg.Recog <> 0 then
        m_boDoForceScan := True
      else
        ClientGetReconnect(body);
      end;
    SM_MISSIONINFO: begin
        ClientGetMissionInfo(Msg, body);
      end;
    {SM_TIMECHECK_MSG: begin
        CheckSpeedHack(Msg.Recog);
      end;    }

    SM_AREASTATE: begin
        CheckUserState(Msg.Recog);
        //g_nAreaStateValue := Msg.Recog;
      end;

    SM_MAPDESCRIPTION: begin
        ClientGetMapDescription(Msg, body);
      end;
    SM_GAMEGOLDNAME2: begin
        if g_MySelf = nil then exit;
        g_nGameDiamond := msg.Recog;
        g_nCreditPoint := MakeLong(msg.tag, msg.Series);
        g_nPkPoint := msg.Param;
      end;
    SM_GAMEGOLDNAME: begin
        ClientGetGameGoldName(Msg, body);
      end;
    SM_MYSTATUS: begin
        g_nMyHungryState := Msg.param;
      end;

    SM_SHOWEFFECT: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.ShowEffect(Msg.Param, Msg.tag, Msg.Series);
      end;
    SM_AUTOMOVE: begin
        ScriptGoto('@move(' + DecodeString(body) + ')');
      end;
    SM_DOCTORALIVE: begin
        with FrmDlg2 do begin
          if DWndDeath.Visible = False then
            dWndDeath.Visible := True;
        end;
        g_boDoctorAlive := True;
      end;

    SM_SHOWBAR: begin
        with FrmDlg2 do begin
          BarTitle := DecodeString(body);
          BarTime := Msg.Series * 1000;
          BarTick := FrmMain.m_CurrentTick;
          BarCmd := Msg.tag;
          BarParam1 := Msg.Recog;
          BarParam2 := Msg.Param;
          DWndBar.Visible := True;
          if BarCmd = CM_ALIVE then DWndDeath.Visible := False;
        end;
      end;
    SM_CLOSEBAR: begin
        FrmDlg2.DWndBar.Visible := False;
      end;

    SM_TURN: begin
        if Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) then begin

          body2 := Copy(body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1, Length(body));
          data := DecodeString(body2); //某腐 捞抚
          str := GetValidStr3(data, data, ['/']);
          k := StrToInt(GetValidStr3(str, str, ['/'])); //the stupid value ripman wanted
          //data = 捞抚
          //str = 祸哎
        end
        else
          data := '';

        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        PlayScene.SendMsg(SM_TURN, Msg.Recog,
          Msg.param {x},
          Msg.tag {y},
          Msg.series {dir + light},
          desc.Feature,
          desc.Status,
          '', desc.btStrengthenIdx, desc.btWuXin); //捞抚
          Actor := PlayScene.FindActor(Msg.Recog);
          if Actor <> nil then begin
            Actor.m_boOpenHealth := desc.boOpenHealth;
            Actor.m_boShowHealthBarRev := desc.boOpenHealth;
            if data <> '' then begin
              Actor.GetUserName(data, StrToIntDef(str, 255));
              Actor.m_nAutoRev := k;
            {Actor.m_sDescUserName := GetValidStr3(data, str, ['\']);
            //actor.UserName := data;
            i := StrToIntDef(str, 255);
            Actor.SetUsername(str, GetRGB(i));  }
            {if Actor.m_Group <> nil then begin
              if Actor.m_Group.ClientGroup.NameColor <> i then begin
                FrmDlg2.m_boChangeGroup := True;
                Actor.m_Group.ClientGroup.NameColor := i;
              end;
            end;  }
          end;
        end;
      end;

    SM_BACKSTEP: begin
        if Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) then begin
          body2 := Copy(body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1, Length(body));
          data := DecodeString(body2); //某腐 捞抚
          str := GetValidStr3(data, data, ['/']);
          //data = 捞抚
          //str = 祸哎
        end
        else
          data := '';
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        PlayScene.SendMsg(SM_BACKSTEP, Msg.Recog,
          Msg.param {x},
          Msg.tag {y},
          Msg.series {dir + light},
          desc.Feature,
          desc.Status,
          '', desc.btStrengthenIdx, desc.btWuXin); //捞抚     }
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
          if data <> '' then begin
            Actor.GetUserName(data, StrToIntDef(str, 255));
            {Actor.m_sDescUserName := GetValidStr3(data, str, ['\']);
            //actor.UserName := data;
            i := StrToIntDef(str, 255);
            Actor.SetUsername(str, GetRGB(i));  }
            {if Actor.m_Group <> nil then begin
              if Actor.m_Group.ClientGroup.NameColor <> i then begin
                FrmDlg2.m_boChangeGroup := True;
                Actor.m_Group.ClientGroup.NameColor := i;
              end;
            end;    }
          end;
        end;
      end;

    SM_SPACEMOVE_HIDE,
      SM_SPACEMOVE_HIDE2,
      SM_SPACEMOVE_HIDE3: begin
        if Msg.Recog <> g_MySelf.m_nRecogId then begin
          PlayScene.SendMsg(Msg.ident, Msg.Recog, Msg.param {x}, Msg.tag {y}, 0,
            0, 0, '')
        end;
      end;

    SM_SPACEMOVE_SHOW,
      SM_SPACEMOVE_SHOW2,
      SM_SPACEMOVE_SHOW3: begin
        if Length(body) > GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) then begin
          body2 := Copy(body, GetCodeMsgSize(sizeof(TCharDesc) * 4 / 3) + 1, Length(body));
          data := DecodeString(body2); //某腐 捞抚
          str := GetValidStr3(data, data, ['/']);
          //data = 捞抚
          //str = 祸哎
        end else data := '';
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        if Msg.Recog <> g_MySelf.m_nRecogId then begin //促弗 某腐磐牢 版快
          Actor := PlayScene.NewActor(Msg.Recog, Msg.param, Msg.tag, LoByte(Msg.series), desc.Feature, desc.Status,
            desc.btStrengthenIdx, desc.btWuXin);
          if Actor <> nil then Actor.m_nLightRange := HiByte(Msg.Series);
        end;
        PlayScene.SendMsg(Msg.ident, Msg.Recog,
          Msg.param {x},
          Msg.tag {y},
          Msg.series {dir + light},
          desc.Feature,
          desc.Status,
          '', desc.btStrengthenIdx, desc.btWuXin); //捞抚
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
          if data <> '' then begin
            Actor.GetUserName(data, StrToIntDef(str, 255));

            {Actor.m_sDescUserName := GetValidStr3(data, str, ['\']);
            //actor.UserName := data;
            i := StrToIntDef(str, 255);
            Actor.SetUsername(str, GetRGB(i));  }
            {if Actor.m_Group <> nil then begin
              if Actor.m_Group.ClientGroup.NameColor <> i then begin
                FrmDlg2.m_boChangeGroup := True;
                Actor.m_Group.ClientGroup.NameColor := i;
              end;
            end;   }
          end;
        end;
      end;

    SM_WALK, SM_RUSH, SM_RUSHCBO, SM_RUSHKUNG, SM_MAGICMOVE, SM_MAGICFIR: begin
        //DScreen.AddSysMsg ('WALK ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        if (Msg.Recog <> g_MySelf.m_nRecogId) or (Msg.ident = SM_RUSH) or (msg.Ident = SM_RUSHCBO) or (msg.Ident = SM_MAGICMOVE) or
          (Msg.ident = SM_RUSHKUNG) or (Msg.ident = SM_MAGICFIR) then
          PlayScene.SendMsg(Msg.ident, Msg.Recog,
            Msg.param {x},
            Msg.tag {y},
            Msg.series {dir+light},
            desc.Feature,
            desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
        end;
        if (Msg.ident = SM_RUSH) or (Msg.ident = SM_RUSHCBO) then
          g_dwLatestRushRushTick := FrmMain.m_CurrentTick;
        if msg.Ident = SM_MAGICFIR then
          DrawEffectHum(HiByte(Msg.series), msg.Param, msg.tag, Msg.Recog);
      end;

    SM_RUN, SM_HORSERUN, SM_LEAP: begin
        //DScreen.AddSysMsg ('RUN ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        if Msg.Recog <> g_MySelf.m_nRecogId then
          PlayScene.SendMsg(Msg.ident, Msg.Recog,
            Msg.param {x},
            Msg.tag {y},
            Msg.series {dir+light},
            desc.Feature,
            desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
        end;
      end;

    SM_MOVEFAIL: begin
        ActionFailed;
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        PlayScene.SendMsg(SM_TURN, Msg.Recog,
          Msg.param {x},
          Msg.tag {y},
          Msg.series {dir},
          desc.Feature,
          desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
      end;
    SM_BUTCH: begin
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        if Msg.Recog <> g_MySelf.m_nRecogId then begin
          Actor := PlayScene.FindActor(Msg.Recog);
          if Actor <> nil then
            Actor.SendMsg(SM_SITDOWN,
              Msg.param {x},
              Msg.tag {y},
              Msg.series {dir},
              0, 0, '', 0);
        end;
      end;
    SM_CHANGEEFFIGYSTATE: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.SetEffigyState(MakeLong(Msg.Param, Msg.tag), Msg.Series);
      end;
    SM_SITDOWN: begin
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        if Msg.Recog <> g_MySelf.m_nRecogId then begin
          Actor := PlayScene.FindActor(Msg.Recog);
          if Actor <> nil then
            Actor.SendMsg(SM_SITDOWN,
              Msg.param {x},
              Msg.tag {y},
              Msg.series {dir},
              0, 0, '', 0);
        end;
      end;

    SM_HIT, //14
    SM_HEAVYHIT, //15
    SM_POWERHIT, //18
    SM_LONGHIT, //19
    SM_WIDEHIT, //24
    SM_BIGHIT, //16
    SM_FIREHIT, //8
    SM_CROSSHIT,
    SM_DOUBLESLASH,
      SM_110,
      SM_111,
      SM_112,
      SM_113,
      SM_122,
      SM_56,
      SM_HIT_2,
      SM_HIT_3,
      SM_HIT_4,
      SM_HIT_5,
      SM_TWINHIT,
      SM_FLASHDASHHIT,
      SM_POISONSWORDHIT,
      SM_LONGICEHIT_L,
      SM_LONGICEHIT_S: begin
        if Msg.Recog <> g_MySelf.m_nRecogId then begin
          Actor := PlayScene.FindActor(Msg.Recog);
          if Actor <> nil then begin
            Actor.SendMsg(Msg.ident,
              Msg.param {x},
              Msg.tag {y},
              Msg.series {dir},
              0, 0, '',
              0);
            if Msg.ident = SM_HEAVYHIT then begin
              if body <> '' then
                Actor.m_boDigFragment := True;
            end;
          end;
        end;
      end;
    SM_FLYAXE: begin
        DecodeBuffer(body, @mbw, sizeof(TMessageBodyW));
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.SendMsg(Msg.ident,
            Msg.param {x},
            Msg.tag {y},
            Msg.series {dir},
            0, 0, '',
            0);
          Actor.m_nTargetX := mbw.Param1; //x 带瘤绰 格钎
          Actor.m_nTargetY := mbw.Param2; //y
          Actor.m_nTargetRecog := MakeLong(mbw.Tag1, mbw.Tag2);
        end;
      end;

    SM_LIGHTING: begin
        DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
        Actor := PlayScene.FindActor(Msg.Recog);

        if Actor <> nil then begin
          Actor.SendMsg(Msg.ident,
            Msg.param {x},
            Msg.tag {y},
            Msg.series {dir},
            0, 0, '',
            0);
          Actor.m_nTargetX := wl.lParam1; //x 带瘤绰 格钎
          Actor.m_nTargetY := wl.lParam2; //y
          Actor.m_nTargetRecog := wl.lTag1;
          Actor.m_nMagicNum := wl.lTag2; //付过 锅龋
        end;
      end;

    SM_SPELL: begin
        UseMagicSpell(Msg.Recog {who}, Msg.series {effectnum}, Msg.param {tx},
          Msg.tag {y}, StrToIntDef(body, 0));
      end;
    SM_MAGICFIRE: begin
        DecodeBuffer(body, @param, sizeof(Integer));
        UseMagicFire(Msg.Recog {who}, Lobyte(Msg.series) {efftype},
          Hibyte(Msg.series) {effnum}, Msg.param {tx}, Msg.tag {y}, param);
        //Lobyte(msg.Series) = EffectType
        //Hibyte(msg.Series) = Effect
      end;
    SM_MAGICFIRE_FAIL: begin
        UseMagicFireFail(Msg.Recog {who});
      end;
    SM_MAGICFIRE_CBO: begin
        if g_MySelf <> nil then
          SetMagicUse(Msg.Recog);
      end;
    SM_FBTIME: begin
        if msg.Series = 1 then g_FBTime := Msg.Recog
        else if msg.Series = 2 then g_FBExitTime := Msg.Recog
        else g_FBFailTime := Msg.Recog;

      end;
    SM_GETTOPINFO: begin
        if Msg.Series = 1 then begin
          FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
          FrmDlg3.FboTopSend := False;
        end else begin
          FrmDlg3.FboTopSend := False;
          FrmDlg3.FnMaxTopPage := Msg.tag;
          FrmDlg3.FnMinTopPage := Msg.Param;
          if body <> '' then begin
            DecodeBuffer(Body, @FrmDlg3.FTopInfo[0], SizeOf(TClientTopInfo));
          end else begin
            FillChar(FrmDlg3.FTopInfo, SizeOf(TClientTopInfo), #0);
          end;
        end;
      end;

    SM_ITEMSTRENGTHEN: begin
        g_MySelf.m_nGold := msg.recog;
        g_nBindGold := MakeLong(msg.Param, msg.tag);
        FrmDlg3.ClientStrengthenItems(Msg.Series, body);
      end;
    SM_ITEMABILITYMOVE: begin
        g_MySelf.m_nGold := msg.recog;
        FrmDlg4.ClientAbilityMoveItems(Msg.Series, DeCodeString(body));
      end;
    SM_COMPOUNDITEM: begin
        g_MySelf.m_nGold := msg.recog;
        g_MySelf.m_nGameGold := MakeLong(msg.Param, msg.tag);
        FrmDlg4.ClientCompoundItem(Msg.Series, DeCodeString(body));
      end;
    SM_MAKEDRUG: begin
        g_MySelf.m_nGold := msg.recog;
        g_nBindGold := MakeLong(msg.Param, msg.tag);
        FrmDlg3.ClientMakeItems(Msg.Series, 1, body);
      end;
    SM_MAKEDRUG_AUTO: begin
        g_MySelf.m_nGold := msg.recog;
        g_nBindGold := MakeLong(msg.Param, msg.tag);
        FrmDlg3.ClientMakeItems(-8, Msg.Series, body);
      end;
    SM_BAGUSEITEM: begin
        g_SendSelectItem.s.name := '';
        if msg.Series = 1 then begin
          if msg.Recog > 0 then begin
            ClientGetBabDuraChange(g_SendSelectItem.UserItem.MakeIndex, msg.recog, g_SendSelectItem.UserItem.DuraMax);
          end
          else begin
            DelItemBag(g_SendSelectItem.UserItem.wIndex, g_SendSelectItem.UserItem.MakeIndex);
            DecodeItem(body, @UserItem);
            UpdateItemBagByUserItem(UserItem,True);
          end;

          FrmDlg.FShowItemEffectTick := FrmMain.m_CurrentTick + 1500;
          FrmDlg.FShowItemEffectIndex := UserItem.MakeIndex;
        end;
        if msg.Series = 2 then
          FrmDlg.DMessageDlg('Cannot apply twice on the same item',[mbOk]);
      end;
    SM_UNSEAL_OK: begin
        FrmDlg3.ClientUnSealItems(Msg.Series, body);
      end;
    SM_OUTOFCONNECTION: begin
        g_boDoFastFadeOut := FALSE;
        g_boDoFadeIn := FALSE;
        g_boDoFadeOut := FALSE;
        FrmDlg.DMessageDlg('Server connection was forcibly interrupted.\' +
          'Connection time is likely to exceed limit\' +
          'or the user requests to reconnect.', [mbOk]);
        Close;
      end;

    SM_DEATH,
      SM_NOWDEATH: begin
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
          Actor.m_btStrengthenIdx := desc.btStrengthenIdx;
          Actor.m_btWuXin := desc.btWuXin;
          Actor.SendMsg(Msg.ident,
            Msg.param {x}, Msg.tag {y}, Msg.series {damage},
            desc.Feature, desc.Status, '',
            0);
          Actor.m_Abil.HP := 0;
          if Actor.m_Group <> nil then begin
            Actor.m_Group.ClientGroup.HP := 0;
          end;
        end
        else begin
          PlayScene.SendMsg(SM_DEATH, Msg.Recog, Msg.param {x}, Msg.tag {y},
            Msg.series {damage}, desc.Feature, desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
        end;
      end;
    SM_SKELETON: begin
        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        PlayScene.SendMsg(SM_SKELETON, Msg.Recog, Msg.param {HP}, Msg.tag
          {maxHP}, Msg.series {damage}, desc.Feature, desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
        end;
      end;
    SM_USERKEYSETUP: begin
        g_boUseWuXin := (Msg.Series = 0);
        body2 := GetValidStr3(body, body, ['/']);
        DecodeBuffer(body, @g_UserKeySetup, sizeof(g_UserKeySetup));
        RefUserKeyItemInfo(nil);
        RefM2SetupInfo(Msg.Recog);

        body2 := DecodeString(body2);
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_UserMove := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_MemberFunction := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_MemberFunctionEx := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_Auth := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_AuthCancel := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_EndGuild := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_AllMsg := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_TakeOnHorse := str;
        body2 := GetValidStr3(body2, str, ['/']);
        if str <> '' then g_Cmd_TakeOffHorse := str;
      end;
    SM_ALIVE: begin

        DecodeBuffer(body, @desc, sizeof(TCharDesc));
        PlayScene.SendMsg(SM_ALIVE, Msg.Recog, Msg.param {HP}, Msg.tag {maxHP},
          Msg.series {damage}, desc.Feature, desc.Status, '', desc.btStrengthenIdx, desc.btWuXin);
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
        end;
      end;
    SM_SETITEMS: ClientGetSetItems(@msg, body); 
    SM_ABILITY: begin
        if g_MySelf <> nil then begin
          g_MySelf.m_nGold := Msg.Recog;
          g_MySelf.m_btJob := Msg.param;
          FrmDlg.RefJobMagic(Msg.param);
          g_nBindGold := MakeLong(Msg.tag, Msg.series);
          DecodeBuffer(body, @g_MySelf.m_Abil, sizeof(TAbility));
        end;
      end;

    SM_SUBABILITY: begin
        if g_MySelf <> nil then begin
          DecodeBuffer(body, @ClientAppendSubAbility, Sizeof(ClientAppendSubAbility));
          g_nMyHitPoint := Lobyte(Msg.param);
          g_nMySpeedPoint := Hibyte(Msg.param);
          g_nMyAntiPoison := Lobyte(Msg.tag);
          g_nMyPoisonRecover := Hibyte(Msg.tag);
          g_nMyHealthRecover := Lobyte(Msg.series);
          g_nMySpellRecover := Hibyte(Msg.series);
          g_nMyAntiMagic := Lobyte(LoWord(Msg.Recog));
          g_MySelf.m_btWuXin := Hibyte(LoWord(Msg.Recog));
          g_nMyAddAttack := Lobyte(HiWord(Msg.Recog));
          g_nMyDelDamage := Hibyte(HiWord(Msg.Recog));
          g_nMyAddWuXinAttack := LoByte(LoWord(ClientAppendSubAbility.nParam1));
          g_nMyDelWuXinAttack := HiByte(LoWord(ClientAppendSubAbility.nParam1));
          g_nDeadliness := LoByte(HiWord(ClientAppendSubAbility.nParam1));
          g_nGameGird := ClientAppendSubAbility.nParam2;
          g_nLiterary := ClientAppendSubAbility.nParam3;
        end;
      end;
    SM_GAMEGOLDNAME3: begin
        g_nGameGird := Msg.Recog;
        g_nLiterary := MakeLong(Msg.tag, Msg.Series);
      end;
    {SM_SUBABILITY2: begin
        if g_MySelf <> nil then begin
          g_MySelf.m_btWuXin := LoByte(msg.Param);
          g_MySelf.m_btWuXinLevel := HiByte(msg.Param);
          g_MySelf.m_dwWuXinExp := msg.Recog;
          g_MySelf.m_dwWuXinMaxExp := MakeLong(msg.tag, msg.Series);
        end;
      end; }
    //SM_AD_EXIT: g_sExitUrl := DecodeString(body);
    //SM_AD_FRAME: OpenADForm(LoWord(Msg.Recog), HiWord(Msg.Recog), DecodeString(body));

    SM_DAYCHANGING: begin
        //g_nDayBright := Msg.param;
        DarkLevel := Msg.tag;
        if DarkLevel = 0 then
          DScreen.AddSysMsg('No Dark', cllime)
        else
          DScreen.AddSysMsg('Dark', cllime);
      end;
    {SM_WUXINEXP: begin
        g_MySelf.m_dwWuXinExp := Msg.Recog;
        tempword := LongWord(MakeLong(msg.Param, msg.Tag));
        if (tempword mod 60000) = 0 then
          DScreen.AddSysMsg('获得 <CO$FFFF>' + IntToStr(tempword div 60000) + '<CE> 点五行经验', cllime)
        else
          DScreen.AddSysMsg('获得 <CO$FFFF>' + format('%.1f', [tempword / 60000]) + '<CE> 点五行经验', cllime);
      end;   }

    SM_WINEXP: begin
        if msg.Series = 2 then begin
          g_UseItems[u_House].UserItem.dwExp := Msg.recog;
          DScreen.AddSysMsg('Congratulations, your Mount has reached level <CO$FFFF>' + IntToStr(Msg.recog) + '<CE>', GetRGB(147));
        end else
        if msg.Series = 1 then begin
          g_UseItems[u_House].UserItem.dwExp := Msg.recog;
          if g_SetupInfo.boGetExpFiltrate then begin
            if LongWord(MakeLong(msg.Param, msg.Tag)) > g_SetupInfo.nExpFiltrateCount then
              DScreen.AddSysMsg('Received <CO$FFFF>' + IntToStr(LongWord(MakeLong(msg.Param, msg.Tag))) + '<CE> Mount Experience', GetRGB(147)); //$32F4
          end else
            DScreen.AddSysMsg('Received <CO$FFFF>' + IntToStr(LongWord(MakeLong(msg.Param, msg.Tag))) + '<CE> mount Experience', GetRGB(147)); //$32F4
        end else begin
          g_MySelf.m_Abil.Exp := Msg.Recog;
          if g_SetupInfo.boGetExpFiltrate then begin
            if LongWord(MakeLong(msg.Param, msg.Tag)) > g_SetupInfo.nExpFiltrateCount then
              DScreen.AddSysMsg('Received <CO$FFFF>' + IntToStr(LongWord(MakeLong(msg.Param, msg.Tag))) + '<CE> Experience', GetRGB(147)); //$32F4
          end else
            DScreen.AddSysMsg('Received <CO$FFFF>' + IntToStr(LongWord(MakeLong(msg.Param, msg.Tag))) + '<CE> Experience', GetRGB(147)); //$32F4
        end;
      end;

    SM_LEVELUP: begin
        g_nMakeMagicPoint := Msg.Series;
        if g_MySelf.m_Abil.Level <> Msg.param then begin
          g_MySelf.m_Abil.Level := Msg.param;
          DScreen.AddSysMsg('Congratulations, you have reached level <CO$FFFF>' + IntToStr(Msg.param) + '<CE> !', GetRGB(254));
          DScreen.AddSayMsg('Congratulations, you have reached level ' + IntToStr(Msg.param) + '! HP & MP have been restored.',clWhite, clPurple, False, us_Sys);
          PlayScene.RefMissionInfo;
        end;
        {if g_MySelf.m_btWuxinLevel <> Msg.tag then begin
          g_MySelf.m_btWuxinLevel := Msg.tag;
          DScreen.AddSysMsg('五行提升到了 <CO$FFFF>' + IntToStr(Msg.tag) + '<CE> 级', cllime);
        end;     }
      end;
    SM_MAKEMAGIC: begin
        g_boSendMakeMagicAdd := False;
        g_nMakeMagicPoint := Msg.Series;
        g_btMakeMagicAddPoint := LoByte(Msg.Param);
        g_btMakeMagicUsePoint := HiByte(Msg.Param);
        g_btMakeMagicAddRate := LoByte(Msg.Tag);
        g_btMakeMagicMaxLevel := HiByte(Msg.Tag);
        DecodeBuffer(body, @g_MakeMagic[0], SizeOf(TMakeMagic));
      end;

    SM_HEALTHSPELLCHANGED: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          //GetMoveHMShow(Actor, msg.Param, msg.Tag);
          Actor.m_Abil.HP := Msg.param;
          Actor.m_Abil.MP := Msg.tag;
          Actor.m_Abil.MaxHP := Msg.series;
          if Actor.m_Group <> nil then begin
            Actor.m_Group.ClientGroup.HP := msg.Param;
            Actor.m_Group.ClientGroup.MP := Msg.tag;
            Actor.m_Group.ClientGroup.MaxHP := Msg.Series;
            if Actor.m_Group.ClientGroup.MaxMP < Actor.m_Group.ClientGroup.MP then
              Actor.m_Group.ClientGroup.MaxMP := Actor.m_Group.ClientGroup.MP;
          end;
        end;
      end;

    SM_STRUCK: begin
        //wl: TMessageBodyWL;
        DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          if Actor = g_MySelf then begin
            g_nRunReadyCount:= -2; //If we have been struck then change our run steps
            g_dwLastStruckTick := FrmMain.m_CurrentTick;
            //g_boAllowStruckRun := False;
            //g_nStruckRunTick := FrmMain.m_CurrentTick();
            Actor.UpdateMsg(SM_STRUCK, LoWord(wl.lTag2), 0, Msg.series {damage}, wl.lParam1, wl.lParam2,'', wl.lTag1);
            if g_MySelf.m_OldNameColor = 249 then
              //弧盎捞绰 嘎栏搁 立加阑 给 谗绰促.
              g_dwLatestStruckTick := FrmMain.m_CurrentTick;
          end
          else begin
            if Actor.CanCancelAction then
              Actor.CancelAction;
          end;
          if Actor <> g_MySelf then begin
            if (Actor.m_btRace <> RCC_USERHUMAN) then
              begin
               if not (actor.m_nAutoRev = 0) then begin
                Actor.m_boOpenHealth := True;
                Actor.m_dwOpenHealthTime := 3 * 1000;     //ripman
                Actor.m_dwOpenHealthStart := FrmMain.m_CurrentTick;
                Actor.m_boAttack := True;
               end;
              end;
            Actor.UpdateMsg(SM_STRUCK, LoWord(wl.lTag2), 0, Msg.series {damage}, wl.lParam1, wl.lParam2, '', wl.lTag1);
          end
          else begin
            g_nDander := HiWord(wl.lTag2);
          end;
          GetMoveHPShow(Actor, msg.Series);
          Actor.m_Abil.HP := Msg.param;
          Actor.m_Abil.MaxHP := Msg.tag;

          if Actor.m_Group <> nil then begin
            Actor.m_Group.ClientGroup.HP := msg.Param;
            Actor.m_Group.ClientGroup.MaxHP := Msg.tag;
          end;

        end;
      end;
      SM_GEMRESULT: begin
        case Msg.Recog of
          -1,
          -2: FrmDlg.DMessageDlg('An error occured while upgrading your item',[mbOK]);//no idea what could be wrong since it's data error really
          -4: FrmDlg.DMessageDlg('Equipment items level is to high!', [mbOK]);
          -5: FrmDlg.DMessageDlg('Equipment item cannot be upgraded!', [mbOK]);
          -6: FrmDlg.DMessageDlg('Unable to apply upgrade to this item',[mbOK]);
          -7, -8: FrmDlg.DMessageDlg('Upgrade limit reached for this item!',[mbOK]);
          1: begin
            DecodeItem(body, @UserItem);
            UpdateItemBagByUserItem(UserItem,True);
          end;
        end;
      end;

   { SM_UNSTRUCK : begin
        g_boAllowStruckRun:= True;
    end;  } //Unused for now

    SM_GROUPINFO1,
      SM_GROUPINFO2: begin
        ClientGetGroupInfo(Msg, DecodeString(body));
      end;

    SM_CHANGEFACE: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          DecodeBuffer(body, @desc, sizeof(TCharDesc));
          Actor.m_nWaitForRecogId := MakeLong(Msg.param, Msg.tag);
          Actor.m_nWaitForFeature := desc.Feature;
          Actor.m_nWaitForStatus := desc.Status;
          Actor.m_btStrengthenIdx := desc.btStrengthenIdx;
          Actor.m_btWuXin := desc.btWuXin;
          Actor.m_boOpenHealth := desc.boOpenHealth;
          Actor.m_boShowHealthBarRev := desc.boOpenHealth;
          AddChangeFace(Actor.m_nWaitForRecogId);
        end;
      end;
    {SM_PASSWORD: begin
        //PlayScene.EdChat.PasswordChar:='*';
        SetInputStatus();
      end;   }
    SM_OPENHEALTH: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          if Actor <> g_MySelf then begin
            Actor.m_Abil.HP := Msg.param;
            Actor.m_Abil.MaxHP := Msg.tag;
          end;
          if Actor.m_Group <> nil then begin
            Actor.m_Group.ClientGroup.HP := msg.Param;
            Actor.m_Group.ClientGroup.MaxHP := Msg.tag;
          end;
          Actor.m_boOpenHealth := TRUE;
          Actor.m_boShowHealthBarRev := TRUE;
          //dscreen.addsysmsg('SM_OPENHEALTH', clRed);
        end;
      end;
    SM_CLOSEHEALTH: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boOpenHealth := FALSE;
          Actor.m_boShowHealthBarRev := FALSE;
        end;
      end;
    SM_APPEND: ClientGetAppend(@Msg, body);
    SM_INSTANCEHEALGUAGE: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if (Actor <> nil) and (actor.m_btRace <> RC_MONSTER) then begin
          //dscreen.addsysmsg('SM_INSTANCEHEALGUAGE', clRed);
          Actor.m_Abil.HP := Msg.param;
          Actor.m_Abil.MaxHP := Msg.tag;
          Actor.m_noInstanceOpenHealth := True;
          Actor.m_dwOpenHealthTime := 2 * 1000;     //ripman
          Actor.m_dwOpenHealthStart := FrmMain.m_CurrentTick;
        end;
      end;

    SM_BREAKWEAPON: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          if Actor is THumActor then
            THumActor(Actor).DoWeaponBreakEffect;
        end;
      end;
    {SM_WHISPER: begin
        str := DecodeString(body);
        CheckBlockListSys(SM_WHISPER, str, body);
        DScreen.AddChatBoardString(str, GetRGB(Lobyte(Msg.param)),
          GetRGB(Hibyte(Msg.param)));
        if (body <> '') and (g_MySelf <> nil) and (body <> g_MySelf.m_UserName) then
          if g_MyWhisperList.IndexOf(body) = -1 then
            g_MyWhisperList.Insert(0, body);
      end;  }
    SM_HEAR,
      SM_CRY, //喊话
    SM_GROUPMESSAGE, //   组队
    SM_GUILDMESSAGE, //行会
    SM_WHISPER, //私聊
    SM_SYSMESSAGE, {//系统消息}
    SM_BUGLE: {喇叭}begin
        if boOutMsg then begin
          DebugOutStr(body);
          DebugOutStr(DecodeString(body));
        end;
        ClientGetSayMsg(Msg, DecodeString(body));
      end;
    {SM_CRY,
      SM_GROUPMESSAGE,
      SM_GUILDMESSAGE,
      SM_SYSMESSAGE: begin
        if (Msg.Ident = SM_CRY) and (g_CloseCrcSys) and
          (not CheckBlockListSys(msg.Ident, DecodeString(body), body)) then
          exit;
        if (Msg.Ident = SM_WHISPER) and (g_CloseMySys) then
          exit;
        if (Msg.Ident = SM_GUILDMESSAGE) and (g_CloseGuildSys) then
          exit;
        str := DecodeString(body);
        DScreen.AddChatBoardString(str, GetRGB(Lobyte(Msg.param)),
          GetRGB(Hibyte(Msg.param)));
        if Msg.ident = SM_GUILDMESSAGE then
          FrmDlg.AddGuildChat(str);
      end;

    SM_HEAR: begin
        str := DecodeString(body);
        if (not g_CloseAllSys) then
          DScreen.AddChatBoardString(str, GetRGB(Lobyte(Msg.param)),
            GetRGB(Hibyte(Msg.param)));
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.Say(str);
      end;   }
    SM_HINTMSG: begin
        DScreen.AddSysMsg(DecodeString(body), Msg.Recog);
      end;
    SM_GETSAYITEM: begin
        ClientGetSayItem(Msg, body);
      end;

    SM_USERNAME: begin
        str := DecodeString(body);
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_btWuXin := Msg.tag;
          Actor.GetUserName(str, Msg.param);
          {Actor.m_sDescUserName := GetValidStr3(str, str, ['\']);
          //actor.UserName := str;
          i := GetRGB(Msg.param);
          Actor.SetUsername(str, i);  }
          {if Actor.m_Group <> nil then begin
            if Actor.m_Group.ClientGroup.NameColor <> Msg.param then begin
              FrmDlg2.m_boChangeGroup := True;
              Actor.m_Group.ClientGroup.NameColor := Msg.param;
            end;
          end;  }
        end;
      end;
    SM_CHANGENAMECOLOR: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          //Actor.m_nNameColor := GetRGB(Msg.param);
          Actor.SetUsername('', Msg.param);
          {if Actor.m_Group <> nil then begin
            if Actor.m_Group.ClientGroup.NameColor <> Msg.param then begin
              FrmDlg2.m_boChangeGroup := True;
              Actor.m_Group.ClientGroup.NameColor := Msg.param;
            end;
          end;     }
        end;
      end;

    SM_HIDE,
      SM_GHOST, //儡惑..
    SM_DISAPPEAR: begin
        if g_MySelf.m_nRecogId <> Msg.Recog then
          PlayScene.SendMsg(SM_HIDE, Msg.Recog, Msg.param {x}, Msg.tag {y}, 0,
            0, 0, '');
      end;

    SM_DIGUP: begin
        DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor = nil then
          Actor := PlayScene.NewActor(Msg.Recog, Msg.param, Msg.tag, Msg.series, wl.lParam1, wl.lParam2);
        Actor.m_nCurrentEvent := wl.lTag1;
        Actor.SendMsg(SM_DIGUP,
          Msg.param {x},
          Msg.tag {y},
          Msg.series {dir + light},
          wl.lParam1,
          wl.lParam2, '', 0);
      end;
    SM_DIGDOWN: begin
        PlayScene.SendMsg(SM_DIGDOWN, Msg.Recog, Msg.param {x}, Msg.tag {y}, 0, 0, 0, '');
      end;
    SM_SHOWEVENT: begin
        //DecodeBuffer(body, @smsg, sizeof(TShortMessage));
        case msg.Param of
          4: colour_of_event := ARGB(100, 66, 89, 148);
          5: colour_of_event := ARGB(100, 148, 89, 68);
        end;
        event := TClEvent.Create(Msg.Recog, Loword(Msg.tag) {x}, Msg.series {y}, Msg.param {e-type});
        event.m_nDir := 0;
        event.m_nEventParam := StrToIntDef(DecodeString(body), 0);
        event.colour_of_event := colour_of_event;
        EventMan.AddEvent(event); //clvent啊 Free瞪 荐 乐澜
      end;
    SM_HIDEEVENT: begin
        EventMan.DelEventById(Msg.Recog);
      end;

    //Item ??
    SM_ADDITEM: begin
        ClientGetAddItem(msg, body);
      end;
    SM_GROUPADDITEM: ClientGetGroupAddItem(@Msg);

    SM_BAGITEMS: begin
        ClientGetBagItmes(body);
      end;
    SM_SENDADDBAGITEMS: begin
        ClientGetAddBagItmes(body);
      end;
    SM_TAKEOFFADDBAG_OK: begin
        AddItemBag(g_MoveAddBagItem.Item);
        g_MoveAddBagItem.Item.s.Name := '';
        RecalcBagCount();
        FrmDlg.RefAddBagWindow();
        ArrangeItemBagEx();
      end;
    SM_TAKEOFFADDBAG_FAIL: begin
        if g_MoveAddBagItem.Index2 in [Low(g_AddBagItems)..High(g_AddBagItems)] then
          g_AddBagItems[g_MoveAddBagItem.Index2] := g_MoveAddBagItem.Item;
        g_MoveAddBagItem.Item.s.Name := '';
        RecalcBagCount();
        FrmDlg.RefAddBagWindow();
        FrmDlg.DMessageDlg('Failed to remove, please empty bag items in order to create space.', []);
        ArrangeItemBagEx();
      end;
    SM_UPDATEUSERITEM: begin
        ClientUpdateUserItem(body);
      end;
    SM_TAKEONADDBAG_OK: begin
        if Msg.Series in [Low(g_AddBagItems)..High(g_AddBagItems)] then
          g_AddBagItems[Msg.Series] := g_MoveAddBagItem.Item;
        g_MoveAddBagItem.Item.s.Name := '';
        RecalcBagCount();
        FrmDlg.RefAddBagWindow();
        ArrangeItemBagEx();
      end;
    SM_TAKEONADDBAG_FAIL: begin
        AddItemBag(g_MoveAddBagItem.Item, g_MoveAddBagItem.Index2);
        g_MoveAddBagItem.Item.s.Name := '';
        RecalcBagCount();
        FrmDlg.RefAddBagWindow();
        ArrangeItemBagEx();
      end;
    SM_UPDATEITEM: begin
        ClientGetUpdateItem(body);
      end;
    SM_DELITEM: begin
        //ClientGetDelItem(body);
        ClientGetDelItem(Msg.Recog, msg.Param);
      end;
    SM_DELITEMS: begin
        ClientGetDelItems(body);
      end;

    SM_DROPITEM_SUCCESS: begin
        DelDropItem(Msg.Recog);
        ArrangeItemBagEx;
      end;
    SM_DROPITEM_FAIL: begin
        ClientGetDropItemFail(Msg.Recog);
      end;

    SM_FRIEND_LOGIN: begin
        ClientGetFriendChange(@Msg, body);
      end;
    SM_EMAIL: begin
        ClientGetEMail(@Msg, body);
      end;

    SM_ITEMSHOW: ClientGetShowItem(Msg.Recog, Msg.param {x}, Msg.tag {y},
        Msg.series {looks}, DecodeString(body));
    SM_ITEMHIDE: ClientGetHideItem(Msg.Recog, Msg.Series);
    SM_OPENDOOR_OK: Map.OpenDoor(Msg.param, Msg.tag);
    SM_OPENDOOR_LOCK: DScreen.AddSysMsg('[The door is locked]', clWhite);
    SM_CLOSEDOOR: Map.CloseDoor(Msg.param, Msg.tag);

    SM_TAKEON_AUTO: begin
        g_MySelf.m_nFeature := Msg.Recog;
        DecodeBuffer(body, @g_Myself.m_Features, sizeof(TFeatures));
        g_MySelf.FeatureChanged;
        DecodeItem(AnsiMidStr(body,Sizeof(TFeatures)+1,Length(body) - SizeOf(TFeatures)-1), @g_UseItems[Msg.Series].UserItem);
        g_UseItems[Msg.Series].s := GetStditem(g_UseItems[Msg.Series].UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        //DecodeItem(body, @cu.UserItem);
      end;

    SM_TAKEON_OK: begin
        g_MySelf.m_nFeature := Msg.Recog;
        DecodeBuffer(decodestring(body), @g_Myself.m_Features, sizeof(TFeatures));
        g_MySelf.FeatureChanged;
        //            if WaitingUseItem.Index in [0..8] then
        if g_WaitingUseItem.Index2 in [0..MAXUSEITEMS - 1] then
          g_UseItems[g_WaitingUseItem.Index2] := g_WaitingUseItem.Item;
        if g_WaitingUseItem.Index2 in [16..20] then
          g_UseItems[U_HOUSE].UserItem.HorseItems[g_WaitingUseItem.Index2 - 16] := UserItemToHorseItem(@g_WaitingUseItem.Item.UserItem);
        g_WaitingUseItem.Item.S.name := '';
        ArrangeItemBagEx();
      end;
    SM_TAKEON_FAIL: begin
        AddItemBag(g_WaitingUseItem.Item);
        g_WaitingUseItem.Item.S.name := '';
        ArrangeItemBagEx();
      end;
    SM_TAKEOFF_OK: begin
        g_MySelf.m_nFeature := Msg.Recog;
        DecodeBuffer(decodestring(body), @g_Myself.m_Features, sizeof(TFeatures));
        g_MySelf.FeatureChanged;
        AddItemBag(g_WaitingUseItem.Item);
        g_WaitingUseItem.Item.S.name := '';
        ArrangeItemBagEx();
      end;
    SM_TAKEOFF_FAIL: begin
        if g_WaitingUseItem.Index2 < 0 then begin
          n := -(g_WaitingUseItem.Index2 + 1);
          if n in [0..MAXUSEITEMS - 1] then
            g_UseItems[n] := g_WaitingUseItem.Item;
          if n in [16..20] then
            g_UseItems[U_HOUSE].UserItem.HorseItems[n - 16] := UserItemToHorseItem(@g_WaitingUseItem.Item.UserItem);
        end;
        g_WaitingUseItem.Item.S.name := '';
        ArrangeItemBagEx();
      end;

    SM_OPENARMSTRENGTHENDLG: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        FrmDlg3.DWndArmStrengthen.Visible := True;
      end;

    SM_OPENARMABILITYMOVEDLG: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        FrmDlg4.DWndArmAbilityMove.Visible := True;
      end;

    SM_UNSEAL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        FrmDlg3.DWndItemUnseal.Visible := True;
      end;
    SM_REMOVESTONE: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        FrmDlg4.DWndItemRemove.Visible := True;
      end;
    SM_REMOVESTONE_BACK: begin
        case Msg.Recog of
          -1: begin
              FrmDlg.DMessageDlg('[Remove Failed]:Information submitted was wrong!', []);
              FrmDlg4.FRemoveStoneLock := False;
              g_SendRemoveStoneItem.s.name := '';
            end;
          -2: begin
              FrmDlg.DMessageDlg('[Remove Failed]:Remove the incorrect props.', []);
              FrmDlg4.FRemoveStoneLock := False;
              g_SendRemoveStoneItem.s.name := '';
            end;
          -3: begin
              FrmDlg.DMessageDlg('[Remove Failed]:Remove equiped Gem.', []);
              FrmDlg4.FRemoveStoneLock := False;
              g_SendRemoveStoneItem.s.name := '';
            end;
          1: begin
              if g_CursorMode = cr_Srepair then begin
                g_CursorMode := cr_None;
                Cursor := crMyNone;
              end;
              PlaySoundEx(bmg_Repair);
              FrmDlg4.FRemoveStoneIdx := Msg.Series;
              FrmDlg4.FRemoveStoneIndex := MakeLong(Msg.Param, Msg.tag);
              FrmDlg4.FRemoveStoneShowEffect := True;
              FrmDlg4.FRemoveStoneShowEffectIdx := 0;
              FrmDlg4.DItemRemoveItems.AppendTick := FrmMain.m_CurrentTick;
              {DelItemBag(g_SendRemoveStoneItem.UserItem.wIndex, g_SendRemoveStoneItem.UserItem.MakeIndex);
              AddNewItemToBagByIdx(FrmDlg4.FRemoveStoneItem.Item.UserItem.Value.wFlute[Msg.Series], MakeLong(Msg.Param, Msg.tag));
              FrmDlg4.FRemoveStoneItem.Item.UserItem.Value.wFlute[Msg.Series] := 0;}
            end;
        end;
        //g_SendRemoveStoneItem.s.name := '';

      end;
    SM_GETUSERSHOPLIST_OFFLINE: ClientGetMyShopList(@Msg, body);
    SM_USEROPENSHOP: begin
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then begin
          Actor.m_boShop := Msg.Series = 1;
          if Actor.m_boShop then begin
            Actor.m_sShopTitle := DecodeString(body);
            Actor.m_btShopIdx := LoByte(msg.Param) - 1;
            Actor.m_boShopLeft := HiByte(msg.Param) <> 0;
            if Actor.m_boShopLeft then
              Actor.m_btDir := 1
            else
              Actor.m_btDir := 5;
            if Msg.Recog = g_nMyReadShopDlgID then begin
              FrmDlg2.DReadUserShop.Visible := False;
              g_nMyReadShopDlgX := -1;
            end;
          end
          else begin
            if FrmDlg2.DReadUserShop.Visible and (FrmDlg2.UserShopID = msg.Recog) then
              FrmDlg2.DReadUserShop.Visible := False;
          end;

          Actor.LoadShopTitle();
        end;
      end;
    SM_GETUSERSHOPLIST: ClientGetUserShopList(@Msg, body);

    SM_BUYUSERSHOP: begin
        g_MySelf.m_nGold := Msg.Recog;
        g_MySelf.m_nGameGold := MakeLong(Msg.Param, Msg.tag);
        case Msg.Series of
          11: FrmDlg.DMessageDlg('[Sale Failed]: This Item has already been sold.', []);
          12: FrmDlg.DMessageDlg('[Sale Failed]: Amount of' + g_sGameGoldName + ' is not enough.', []);
          13: FrmDlg.DMessageDlg('[Sale Failed]: Amount of' + g_sGoldName + ' is not enough.', []);
          14: FrmDlg.DMessageDlg('[Sale Failed]: Can not carry anymore Items.', []);
          15: begin
              if body <> '' then begin
                body := DecodeString(body);
                body := GetValidStr3(body, str, ['/']);
                n := StrToIntDef(str, 0);
                j := StrToIntDef(body, 0);
                if n in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then begin
                  if j > 0 then begin
                    if (g_MyShopItem.Item.UserItem.Dura > j) then begin
                      Dec(g_MyShopItem.Item.UserItem.Dura, j);
                      AddItemBag(g_MyShopItem.Item, g_MyShopItem.Index2);
                    end;
                    if g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura > j then
                      Dec(g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura, j)
                    else
                      SafeFillChar(g_MyReadShopBuyItems[n], SizeOf(g_MyReadShopBuyItems[n]), #0);
                  end
                  else begin
                    if (sm_Superposition in g_MyReadShopBuyItems[n].ShopItem.Item.s.StdModeEx) and (g_MyReadShopBuyItems[n].ShopItem.Item.s.DuraMax > 1) then begin
                      if g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura > g_MyShopItem.Item.UserItem.Dura then
                        Dec(g_MyReadShopBuyItems[n].ShopItem.Item.UserItem.Dura, g_MyShopItem.Item.UserItem.Dura)
                      else
                        SafeFillChar(g_MyReadShopBuyItems[n], SizeOf(g_MyReadShopBuyItems[n]), #0);
                    end
                    else
                      SafeFillChar(g_MyReadShopBuyItems[n], SizeOf(g_MyReadShopBuyItems[n]), #0);
                  end;

                end;
              end;
            end;
          1: FrmDlg.DMessageDlg('[Buy Failed]: The Item you wish to purchase has already been brought.', []);
          2: FrmDlg.DMessageDlg('[Buy Failed]: Your ' + g_sGameGoldName + ' is not enough', []);
          3: FrmDlg.DMessageDlg('[Buy Failed]: Your ' + g_sGoldName + ' is not enough', []);
          4: FrmDlg.DMessageDlg('[Buy Failed]: Not enough bag space!', []);
          5: begin
              for I := Low(g_MyReadShopSellItems) to High(g_MyReadShopSellItems) do begin
                if g_MyReadShopSellItems[i].ShopItem.Item.UserItem.MakeIndex = g_MyShopItem.Item.UserItem.MakeIndex then begin
                  if body <> '' then begin
                    body := DecodeString(body);
                    body := GetValidStr3(body, str, ['/']);
                    n := StrToIntDef(str, 0);
                    j := StrToIntDef(body, 0);
                    if (J > 0) then begin
                      Dec(g_MyReadShopSellItems[i].ShopItem.Item.UserItem.Dura, j);
                    end;
                    if (n > 0) and (J > 0) then begin
                      Item := g_MyShopItem;
                      Item.Item.UserItem.MakeIndex := n;
                      Item.Item.UserItem.Dura := j;
                      AddItemBag(Item.Item);
                    end;
                  end
                  else begin
                    SafeFillChar(g_MyReadShopSellItems[i], SizeOf(g_MyReadShopSellItems[i]), #0);
                    AddItemBag(g_MyShopItem.Item);
                  end;
                  break;
                end;
              end;
            end;
        end;
        g_MyShopItem.Item.s.Name := '';
      end;

    SM_USERSHOPSAY: begin
        body := GetValidStr3(body, str, ['/']);
        FrmDlg2.AddShopMsg(FormatDateTime('[DD HH:MM:SS] ', Now) + DecodeString(str) + ': ' + DecodeString(body));
      end;



    SM_USERSHOPITEMCHANGE: begin
        if Msg.Series = 1 then begin
          for I := Low(g_MyShopSellItems) to High(g_MyShopSellItems) do begin
            if g_MyShopSellItems[i].ShopItem.Item.UserItem.MakeIndex = msg.Recog then begin
              FrmDlg2.AddShopMsg(FormatDateTime('[DD HH:MM:SS] ', Now) +
                DecodeString(body) + ' has bought Your ' + g_MyShopSellItems[i].ShopItem.Item.s.Name + ' Quantity ' +
                IntToStr(msg.tag));
              if Msg.Param > 0 then begin
                g_MyShopSellItems[i].ShopItem.Item.UserItem.Dura := Msg.Param;
              end
              else begin
                SafeFillChar(g_MyShopSellItems[i], SizeOf(g_MyShopSellItems[i]), #0);
              end;
              break;
            end;
          end;
        end
        else begin
          if msg.tag in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then begin
            FrmDlg2.AddShopMsg(FormatDateTime('[DD HH:MM:SS] ', Now) +
              DecodeString(body) + ' sold you ' + g_MyShopBuyItems[msg.Tag].ShopItem.Item.s.Name + ' Quantity ' +
              IntToStr(msg.Recog));
            if Msg.Param > 0 then begin
              Item.Item.UserItem.Dura := g_MyShopBuyItems[msg.Tag].ShopItem.Item.UserItem.Dura - msg.Param;
              g_MyShopBuyItems[msg.Tag].ShopItem.Item.UserItem.Dura := Msg.Param;
            end
            else
              SafeFillChar(g_MyShopBuyItems[msg.Tag], SizeOf(g_MyShopBuyItems[msg.Tag]), #0);
          end;
        end;
      end;

    SM_USERSHOPCHANGE: begin
        if g_MySelf <> nil then begin
          g_MySelf.m_nGold := Msg.Recog;
          g_MySelf.m_nGameGold := MakeLong(Msg.Param, Msg.tag);
          with FrmDlg2 do begin
            DUserShopOpen.Enabled := True;
            if Msg.Series > 0 then begin
              g_MySelf.m_boShop := True;
              g_MySelf.m_btShopIdx := LoByte(Msg.Series) - 1;
              g_MySelf.m_boShopLeft := HiByte(msg.Series) <> 0;
              FrmDlg2.DUserShopMemo.Lines.Clear;
              if g_MySelf.m_boShopLeft then
                g_MySelf.m_btDir := 1
              else
                g_MySelf.m_btDir := 5;
              g_MySelf.m_sShopTitle := g_MyShopTitle;
              DUserShopOpen.Caption := 'Close Stall';
              g_MySelf.LoadShopTitle();
              DWndUserShop.Visible := False;
            end
            else if Msg.Series = 0 then begin
              g_MyShopGold := 0;
              g_MyShopGameGold := 0;
              g_MySelf.m_boShop := False;
              DUserShopOpen.Caption := 'Open Stall';
              if not DWndUserShop.Visible then
                ClearShopSellItems;
              g_MySelf.LoadShopTitle();
              DWndUserShop.Visible := False;
            end;
          end;
        end;
      end;

    SM_USERSHOPGOLDCHANGE: begin
        g_MyShopGold := Msg.Recog;
        g_MyShopGameGold := MakeLong(Msg.Param, Msg.tag);
      end;
    { SM_EXCHGTAKEON_OK: ;
     SM_EXCHGTAKEON_FAIL: ;   }

    SM_SENDUSEITEMS: begin
        ClientGetSenduseItems(body);
      end;
    SM_WEIGHTCHANGED: begin
        g_MySelf.m_Abil.Weight := Msg.Recog;
        g_MySelf.m_Abil.WearWeight := Msg.param;
        g_MySelf.m_Abil.HandWeight := Msg.tag;
      end;
    SM_GOLDCHANGED: begin
        SoundUtil.PlaySound(s_money);
        if Msg.Recog > g_MySelf.m_nGold then begin
          DScreen.AddSysMsg('Received <CO$FFFF>' + g_sGoldName + ' '  + '<CE>' +
            IntToStr(Msg.Recog - g_MySelf.m_nGold), GetRGB(70));
        end;
        g_MySelf.m_nGold := Msg.Recog;
        //g_MySelf.m_nGameGold := MakeLong(Msg.param, Msg.tag);
        if MakeLong(Msg.param, Msg.tag) > g_nBindGold then begin
          DScreen.AddSysMsg('Received <CO$FFFF>' + g_sBindGoldName + ' ' + '<CE>' +
            IntToStr(MakeLong(Msg.param, Msg.tag) - g_nBindGold), GetRGB(70));
        end;
        g_nBindGold := MakeLong(Msg.param, Msg.tag);
      end;
    SM_GOLDPOINTCHANGED: begin
        SoundUtil.PlaySound(s_money);
        if Msg.Recog > g_MySelf.m_nGold then begin
          DScreen.AddSysMsg('Received <CO$FFFF>' + g_sGoldName + ' '  + '<CE>' + IntToStr(Msg.Recog - g_MySelf.m_nGold), GetRGB(70));
        end;
        g_MySelf.m_nGold := Msg.Recog;
        g_MySelf.m_nGamePoint := MakeLong(Msg.param, Msg.tag);
      end;
    SM_FEATURECHANGED: begin
        PlayScene.SendMsg(Msg.ident, Msg.Recog, 0, 0, 0, MakeLong(Msg.param,
          Msg.tag), 0, decodestring(body),0);
      end;
    SM_CHARSTATUSCHANGED: begin
        PlayScene.SendMsg(Msg.ident, Msg.Recog, 0, 0, 0, MakeLong(Msg.param,
          Msg.tag), Msg.series, '');
        {PlayScene.MemoLog.Lines.Add(IntToStr(MakeLong(Msg.param,
          Msg.tag)));  }
      end;
    {SM_CLEAROBJECTS: begin
        PlayScene.CleanObjects;
        g_boMapMoving := True; //
        //g_boMapInitialize := True;
        g_btMapinitializePos := 0;
        g_boMapApoise := True;
        PlayMp3('', False);
      end;   }

    SM_EAT_OK: begin
        if Msg.Recog > 0 then begin
          if g_EatingItem.Item.S.StdMode = tm_Drug then begin
            g_dwEatTick := FrmMain.m_CurrentTick + LongWord(Msg.Recog);
          end;
        end;

        DelItemBagByIdxEx(g_EatingItem.Index2, g_EatingItem.Item.UserItem.wIndex, g_EatingItem.Item.UserItem.MakeIndex);
        g_EatingItem.Item.S.name := '';
        //ArrangeItembag;
        ArrangeItemBagEx();
        if g_sOpenItemName <> '' then begin
          EatItembyName(g_sOpenItemName);
        end;
        g_sOpenItemName := '';
      end;
    SM_EAT_FAIL: begin
        if msg.Recog = g_EatingItem.Item.UserItem.MakeIndex then begin
          g_EatingItem.Item.UserItem.Dura := msg.Param;
          g_EatingItem.Item.UserItem.DuraMax := msg.tag;
          UpdateItemBagByIdx(g_EatingItem.Index2, g_EatingItem.Item);
          //AddItemBag(g_EatingItem.Item, g_EatingItem.Index2);
          g_EatingItem.Item.S.name := '';
        end
        else begin
          g_EatingItem.Item.S.name := '';
          //DelItemBagByIdxEx(g_EatingItem.Index2, g_EatingItem.Item.UserItem.wIndex, g_EatingItem.Item.UserItem.MakeIndex);
        end;
        ArrangeItemBagEx();
        g_sOpenItemName := '';
      end;
    SM_CHANGEITEMDURA_FAIL: begin
        if Msg.Series <> 0 then begin
          if Msg.Param > 0 then begin
            g_UniteUseItem.Item.UserItem.Dura := Msg.Param;
            ClientGetBabDuraChange(Msg.Recog, Msg.tag, Msg.tag);
          end;
          AddItemBag(g_UniteUseItem.Item, g_UniteUseItem.Index2);
        end;
        g_UniteUseItem.Item.s.Name := '';
        ArrangeItemBagEx();
      end;
    SM_CHANGEITEMDURA_OK: begin
        if Msg.Series = 0 then begin
          ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.tag);
          ClientGetAddItem(Msg, body, False);
        end
        else begin
          ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.tag);
        end;
        g_UniteUseItem.Item.s.Name := '';
        ArrangeItemBagEx();
      end;

    SM_ADDMAGIC: begin
        if body <> '' then
          ClientGetAddMagic(body);
      end;
    SM_SENDMYMAGIC: begin
        if msg.Series = 1 then begin
          g_CboMagicID := Msg.Param;
          g_CboUserID := Msg.Recog;
          if g_CboMagicID in [114..121] then
            g_TargetCret := nil;
          if g_CboMagicID = 111 then
            TimerTestTimer(TimerTest);
        end
        else begin
          g_CboMagicList.nMagicList := Msg.Recog;
          if body <> '' then
            ClientGetMyMagics(body);
        end;
      end;

    SM_DELMAGIC: begin
        ClientGetDelMagic(Msg.Recog);
      end;
    SM_MAGIC_LVEXP: begin
        ClientGetMagicLvExp(Msg.Recog {magid}, Msg.param {lv}, MakeLong(Msg.tag,
          Msg.series));
      end;
    SM_DURACHANGE: begin
        ClientGetDuraChange(Msg.Series, Msg.Param, Msg.tag, Msg.Recog);
      end;
    SM_BAG_DURACHANGE: begin
        ClientGetBabDuraChange(Msg.Recog, Msg.Param, Msg.Tag);
      end;
    SM_BAG_DURACHANGE2: begin
        ClientGetBabDuraChange2(@Msg);
      end;
    SM_MERCHANTSAY: begin
        ClientGetMerchantSay(Msg.Recog, Msg.param, Msg.tag, Msg.Series, DecodeString(body));
      end;
    SM_MERCHANTDLGCLOSE: begin
        FrmDlg.CloseMDlg;
        g_boAllowAuction := False;
      end;
    SM_SENDGOODSLIST: begin
        ClientGetSendGoodsList(Msg.Recog, Msg.Param, Msg.tag, Msg.Series, body);
      end;
    SM_UPDATESHOP: begin
      if (g_nCurMerchant = g_nCurMerchant) then begin //if the shop update isnt the one we clicked, ignore it
        if FrmDlg.DMenuDlg.Visible then
          SendMerchantDlgSelect(g_nCurMerchant,'@buy');//cheating way i know but should work :p
      end;
    end;
    SM_SENDSUBList: begin
      ClientGetSubList(body,msg.Param, msg.tag);
    end;
    SM_COMPOUNDINFOS: begin
        ClientGetCompoundInfos(DecodeString(body));
      end;
    SM_ABILITYMOVESET: begin
        ClientGetAbilityMoveSet(DecodeString(body));
      end;
    SM_SENDUSERMAKEDRUGITEMLIST: begin
        ClientGetSendMakeDrugList(@Msg, body);
      end;

    SM_HINTDATA: begin
        ClientGetHintDataList(@Msg, body);
      end;
    SM_GETRETURNITEMS: ClientGetSendReturnItemList(body);
    SM_BUYRETURNITEM_OK: begin
        g_MySelf.m_nGold := Msg.Recog;
        g_nBindGold := MakeLong(Msg.Param, Msg.tag);
        SoundUtil.PlaySound(s_money);
        if (msg.Series < FrmDlg.NpcReturnItemList.Count) then begin
          Dispose(pTNewClientItem(FrmDlg.NpcReturnItemList[msg.Series]));
          FrmDlg.NpcReturnItemList.Delete(msg.Series);
        end;
        AddItemBag(g_SellDlgItemSellWait.Item);
        g_SellDlgItemSellWait.Item.S.name := '';
      end;
    SM_BUYRETURNITEM_FAIL: begin
        g_SellDlgItemSellWait.Item.S.name := '';
        case msg.Series of
          1: FrmDlg.DMessageDlg('Failed Purchase, you do not have enough ' + g_sGoldname + ' to complete payment.', []);
          2: FrmDlg.DMessageDlg('Purchase failed, you can not carry any more items.', []);
        end;
      end;
    SM_USERSELLITEM_OK: begin
        SoundUtil.PlaySound(s_money);
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        g_MySelf.m_nGold := Msg.Recog;
        g_nBindGold := MakeLong(Msg.tag, Msg.series);
        new(pcu);
        pcu^ := g_SellDlgItemSellWait.Item;
        FrmDlg.NpcReturnItemList.Insert(0, pcu);
        if FrmDlg.NpcReturnItemList.count > 3 then begin
          Dispose(pTNewClientItem(FrmDlg.NpcReturnItemList[3]));
          FrmDlg.NpcReturnItemList.Delete(3);
        end;

        if FrmDlg.NpcReturnItemList.Count > MAXRETURNITEMSCOUNT then begin
          Dispose(pTNewClientItem(FrmDlg.NpcReturnItemList[MAXRETURNITEMSCOUNT]));
          FrmDlg.NpcReturnItemList.Delete(MAXRETURNITEMSCOUNT);
        end;
        g_SellDlgItemSellWait.Item.S.name := '';
      end;

    SM_STATUSMODE: begin
        if Msg.Series in [Low(g_StatusInfoArr)..High(g_StatusInfoArr)] then begin
          g_StatusInfoArr[Msg.Series].dwTime := Msg.Recog * 1000;
          g_StatusInfoArr[Msg.Series].nPower := MakeLong(Msg.Param, Msg.tag);
          if Msg.Recog > 0 then begin
            for I := 0 to g_StatusInfoList.Count - 1 do begin
              if Integer(g_StatusInfoList[I]) = Msg.Series then Exit;
            end;
            g_StatusInfoList.Add(Pointer(Msg.Series));
            TDButton(g_StatusInfoArr[Msg.Series].Button).Visible := True;
            FrmDlg.RefStatusInfoForm;
          end else begin
            for I := 0 to g_StatusInfoList.Count - 1 do begin
              if Integer(g_StatusInfoList[I]) = Msg.Series then begin
                TDButton(g_StatusInfoArr[Msg.Series].Button).Visible := False;
                g_StatusInfoList.Delete(I);
                FrmDlg.RefStatusInfoForm;
                Break;
              end;
            end;
          end;
        end;
      end;

    SM_USERSELLITEM_FAIL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
        g_SellDlgItemSellWait.Item.S.name := '';
        if msg.Recog = 1 then
          FrmDlg.DMessageDlg('[Error]:You can not carry any more ' + g_sGoldName + '.', [mbOk])
        else
          FrmDlg.DMessageDlg('[Error]:The items can not be sold.', [mbOk]);
      end;

    (*SM_SENDREPAIRCOST: begin
        if g_SellDlgItem.Item.S.name <> '' then begin
          if Msg.Recog >= 0 then
            g_sSellPriceStr := IntToStr(Msg.Recog) + ' ' + g_sGoldName {金币}
          else
            g_sSellPriceStr := '???? ' + g_sGoldName {金币};
        end;
      end;    *)
    SM_USERREPAIRITEM_OK: begin
        FrmDlg.CancelItemMoving;
        if g_SellDlgItemSellWait.Item.S.name <> '' then begin
          FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
          g_MySelf.m_nGold := Msg.Recog;
          g_SellDlgItemSellWait.Item.UserItem.Dura := Msg.Series;
          g_SellDlgItemSellWait.Item.UserItem.DuraMax := Msg.Series;
          g_nBindGold := MakeLong(Msg.Param, Msg.tag);
          g_boItemMoving := True;
          g_MovingItem := g_SellDlgItemSellWait;
          FrmDlg.CancelItemMoving;
          //AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
          g_SellDlgItemSellWait.Item.S.name := '';
        end;
      end;
    SM_USERREPAIRITEM_FAIL: begin
        FrmDlg.CancelItemMoving;
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        g_boItemMoving := True;
        g_MovingItem := g_SellDlgItemSellWait;
        FrmDlg.CancelItemMoving;
        //AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
        g_SellDlgItemSellWait.Item.S.name := '';
        case msg.Recog of
          1: FrmDlg.DMessageDlg('[Error]: This item can not be repaired.', [mbOk]);
          2: FrmDlg.DMessageDlg('[Error]: This Item does not need to be repaired!', [mbOk]);
          3: FrmDlg.DMessageDlg('[Error]: I cannot repair this item.', [mbOk]);
          else FrmDlg.DMessageDlg('[Error]: You do not have enough ' + g_sGoldName + ' to repair this item!', [mbOk]);
        end;
      end;
    SM_STORAGE_OK: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        AddItemStorage(@g_SellDlgItemSellWait.Item, msg.Param, msg.tag);
        g_SellDlgItemSellWait.Item.S.name := '';
      end;
    SM_STORAGE_FAIL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        AddItemBag(g_SellDlgItemSellWait.Item, g_SellDlgItemSellWait.Index2);
        g_SellDlgItemSellWait.Item.S.name := '';
      end;
    SM_SAVEITEMLIST: begin
        ClientGetSaveItemList(@Msg, body);
      end;
//    SM_SENDINFO: ClientSendInfo(@Msg, body);
    SM_TAKEBACKSTORAGEITEM_OK: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        AddItemBag(g_SellDlgItemSellWait.Item);
        g_SellDlgItemSellWait.Item.S.name := '';
      end;
    SM_TAKEBACKSTORAGEITEM_FAIL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        AddItemStorage(@g_SellDlgItemSellWait.Item, LoWord(g_SellDlgItemSellWait.Index2),
          HiWord(g_SellDlgItemSellWait.Index2));
        g_SellDlgItemSellWait.Item.S.name := '';
      end;

    SM_BUYITEM_SUCCESS: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        g_MySelf.m_nGold := Msg.Recog;
        g_nBindGold := MakeLong(Msg.tag, Msg.series);
        if g_SellDlgItemSellWait.Item.UserItem.MakeIndex <> 0 then begin
        //if we bought a specific item then it has to be removed from sublist
          FrmDlg.RemoveFromSublist(g_SellDlgItemSellWait.Item.UserItem.MakeIndex);
        end;
        g_SellDlgItemSellWait.Item.S.name := '';
      end;
    SM_BUYITEM_FAIL: begin
        g_SellDlgItemSellWait.Item.S.name := '';
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        case Msg.Recog of
          1: FrmDlg.DMessageDlg('[Error]:This item is sold.', [mbOk]); //technicaly buying an item that's not in the npc anymore
          2: FrmDlg.DMessageDlg('[Error]:You can not carry anymore items..', [mbOk]);
          3: FrmDlg.DMessageDlg('[Error]:You do not have enough ' + g_sGoldName + ' to purchase this Item.', [mbOk]);
          4: FrmDlg.DMessageDlg('[Error]:You do not have enough' + g_sBindGoldName + ' to purchase this Item.', [mbOk]);
          5: FrmDlg.DMessageDlg('[Error]:Ths item is sold out.', [mbOk]); //buying an item with stock 0
        end;
      end;

    {SM_MAKEDRUG_SUCCESS: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        g_MySelf.m_nGold := Msg.Recog;
        FrmDlg.DMessageDlg('物品成功打造', [mbOk]);
      end;
    SM_MAKEDRUG_FAIL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        case msg.Recog of
          1: FrmDlg.DMessageDlg('发生了错误.', [mbOk]);
          2: FrmDlg.DMessageDlg('没有更多的物品可以携带了.',
              [mbOk]);
          3: FrmDlg.DMessageDlg(g_sGoldName  + '不足.', [mbOk]);
          4: FrmDlg.DMessageDlg('你缺乏所必需的物品。', [mbOk]);
        end;
      end; }
    SM_716: begin
        DrawEffectHum(Msg.series {type}, Msg.param {x}, Msg.tag {y}, Msg.Recog);
      end;
    SM_MONMAGIC: begin
        DrawMonMagic(@Msg, body);
        //DrawEffectHum(Msg.series {type}, Msg.param {x}, Msg.tag {y});
      end;
    {SM_SENDDETAILGOODSLIST: begin
        ClientGetSendDetailGoodsList(Msg.Recog, Msg.param, Msg.tag, body);
      end;   }
    SM_TEST: begin
        Inc(g_nTestReceiveCount);
      end;
    SM_CLIENTDATAFILE: begin
        ClientGetDataFile(Msg, body);
      end;
    SM_FILTERINFO: begin
        ClientFilterInfo(Msg, body);
      end;
    SM_SENDNOTICE: begin
        ClientGetSendNotice(body);
      end;
    SM_GROUPMODECHANGED:  begin
        {if Msg.param > 0 then
          g_boAllowGroup := True
        else
          g_boAllowGroup := FALSE;

        if Msg.tag > 0 then
          g_boCheckGroup := True
        else
          g_boCheckGroup := FALSE; }
        g_nGameSetupData := LongWord(Msg.Recog);
        //g_boAllowGroup := not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
        //g_boCheckGroup := CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK);
        if body <> '' then begin
          DScreen.AddSysMsg(DecodeString (body), clWhite);
        end;
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
      end;
    SM_CREATEGROUP_OK: begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
        //g_boAllowGroup := True;
        SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, False);
        {GroupMembers.Add (Myself.UserName);
        GroupMembers.Add (DecodeString(body));}
      end;
    SM_CREATEGROUP_FAIL: begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
        case Msg.Recog of
          1: FrmDlg.DMessageDlg('Group invitation sent, please wait for a response!', [mbOk]);
          2: FrmDlg.DMessageDlg('[Failed]: Invitation has been sent, please do not repeat!', [mbOk]);
          -1: FrmDlg.DMessageDlg('[Failed]:You have already joined the team!', [mbOk]);
          -2: FrmDlg.DMessageDlg('[Failed]:The character invited can not be added to the group.', [mbOk]);
          -3: FrmDlg.DMessageDlg('[Failed]:The character is already in a group!', [mbOk]);
          -4: FrmDlg.DMessageDlg('[Failed]:The character does not allow grouping!', [mbOk]);
        end;
      end;
    SM_GROUPADDMEM_OK: begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
        ClientGetAddMembers(@Msg, body);
        //GroupMembers.Add (DecodeString(body));
      end;
    SM_GROUPADDMEM_FAIL: begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
        case Msg.Recog of
          -1:
            FrmDlg.DMessageDlg('[Failed]:Only the group leader can add members!', [mbOk]);
          -2:
            FrmDlg.DMessageDlg('[Failed]:These Characters can not be added to the teams!', [mbOk]);
          -3:
            FrmDlg.DMessageDlg('[Failed]:Character has already joined a team!', [mbOk]);
          -4: FrmDlg.DMessageDlg('[Failed]:Character does not allow grouping',
              [mbOk]);
          -5: FrmDlg.DMessageDlg('[Failed]:Group is full!',
              [mbOk]);
        end;
      end;
    SM_GROUPDELMEM_OK: begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
        ClientGetDelMembers(@Msg, body);
        //data := DecodeString (body);
        {for i:=0 to GroupMembers.Count-1 do begin
           if GroupMembers[i] = data then begin
              GroupMembers.Delete (i);
              break;
           end;
        end;   }
      end;
    SM_GROUPDELMEM_FAIL: begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick;
        case Msg.Recog of
          -1:
            FrmDlg.DMessageDlg('[Failed]:Only the Group Leader can remove members!', [mbOk]);
          -2:
            FrmDlg.DMessageDlg('[Failed]:The Character does not exist!', [mbOk]);
          -3:
            FrmDlg.DMessageDlg('[Failed]:Character is not in Group!', [mbOk]);
        end;
      end;
    SM_CHECKMSG: begin
        ClientGetCheckMsg(@Msg, DecodeString(body));
      end;
    SM_GROUPCANCEL: begin
        ClearGroupMember(True, Boolean(msg.Recog));
      end;
    SM_GROUPMEMBERS: begin
        //g_boAllowGroup := True;
        SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, False);
        ClientGetGroupMembers(msg, DecodeString(body));
      end;

    SM_OPENGUILDDLG: begin
        g_dwQueryMsgTick := FrmMain.m_CurrentTick;
        ClientGetOpenGuildDlg(@Msg, body);
      end;

    SM_SENDGUILDMEMBERLIST: begin
        g_dwQueryMsgTick := FrmMain.m_CurrentTick;
        ClientGetSendGuildMemberList(@msg, body);
      end;

    SM_OPENGUILDDLG_FAIL: begin
        g_dwQueryMsgTick := FrmMain.m_CurrentTick;
        FrmDlg.DMessageDlg('You are not in a Guild!', [mbOk]);
      end;

    SM_DEALTRY_FAIL: begin
        g_dwQueryMsgTick := FrmMain.m_CurrentTick;
        FrmDlg.DMessageDlg('You must be face to face to carry out a deal.', [mbOk]);
      end;
    SM_DEALMENU: begin
        g_dwQueryMsgTick := FrmMain.m_CurrentTick;
        g_sDealWho := DecodeString(body);
        FrmDlg.OpenDealDlg;
      end;
    SM_DEALCANCEL: begin
        MoveDealItemToBag;
        if g_DealDlgItem.Item.S.name <> '' then begin
          AddItemBag(g_DealDlgItem.Item); //啊规俊 眠啊
          g_DealDlgItem.Item.S.name := '';
        end;
        if g_nDealGold > 0 then begin
          g_MySelf.m_nGold := g_MySelf.m_nGold + g_nDealGold;
          g_nDealGold := 0;
        end;
        FrmDlg.CloseDealDlg;
        ArrangeItemBagEx();
      end;
    SM_DEALADDITEM_OK: begin
        g_dwDealActionTick := FrmMain.m_CurrentTick;
        if g_DealDlgItem.Item.S.name <> '' then begin
          AddDealItem(g_DealDlgItem.Item); //Deal Dlg俊 眠啊
          g_DealDlgItem.Item.S.name := '';
        end;
        ArrangeItemBagEx();
      end;
    SM_DEALADDITEM_FAIL: begin
        g_dwDealActionTick := FrmMain.m_CurrentTick;
        if g_DealDlgItem.Item.S.name <> '' then begin
          AddItemBag(g_DealDlgItem.Item, g_DealDlgItem.Index2); //啊规俊 眠啊
          g_DealDlgItem.Item.S.name := '';
        end;
        ArrangeItemBagEx();
      end;
    SM_DEALDELITEM_OK: begin
        g_dwDealActionTick := FrmMain.m_CurrentTick;
        if g_DealDlgItem.Item.S.name <> '' then begin
          AddItemBag(g_DealDlgItem.Item); //啊规俊 眠啊
          g_DealDlgItem.Item.S.name := '';
        end;
        ArrangeItemBagEx();
      end;
    SM_DEALDELITEM_FAIL: begin
        g_dwDealActionTick := FrmMain.m_CurrentTick;
        if g_DealDlgItem.Item.S.name <> '' then begin
          AddDealItem(g_DealDlgItem.Item);
          g_DealDlgItem.Item.S.name := '';
        end;
        ArrangeItemBagEx();
      end;
    SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem(body);
    SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem(body);
    SM_DEALCHGGOLD_OK: begin
        g_nDealGold := Msg.Recog;
        g_MySelf.m_nGold := MakeLong(Msg.param, Msg.tag);
        g_dwDealActionTick := FrmMain.m_CurrentTick;
      end;
    SM_DEALCHGGOLD_FAIL: begin
        g_nDealGold := Msg.Recog;
        g_MySelf.m_nGold := MakeLong(Msg.param, Msg.tag);
        g_dwDealActionTick := FrmMain.m_CurrentTick;
      end;
    SM_DEALREMOTECHGGOLD: begin
        g_nDealRemoteGold := Msg.Recog;
        SoundUtil.PlaySound(s_money);
        //惑措规捞 捣阑 函版茄 版快 家府啊 抄促.
      end;
    SM_DEALSUCCESS: begin
        case Msg.Recog of
          1: begin
              FrmDlg.DDRDealLock.Checked := True;
              FrmDlg.DDealOk.Enabled := FrmDlg.DDRDealLock.Checked and g_boDealLock;
              DScreen.AddSysMsg('[Opponent character has locked trading]', $32F4);
            end;
          2: begin
              FrmDlg.DDRDealOk.Checked := True;
              DScreen.AddSysMsg('[Opponent wants to complete trading]', $32F4);
            end;
        else begin
            FrmDlg.CloseDealDlg;
            DScreen.AddSysMsg('[Deal transaction was successfull]', $32F4);
          end;
        end;
      end;
    {SM_SENDUSERSTORAGEITEM: begin
        ClientGetSendUserStorage(Msg.Recog);
      end;  }
    SM_STORAGEGOLDCHANGE: begin
        g_nStorageGold := Msg.Recog;
        case msg.Param of
          1: FrmDlg.DMessageDlg('[Error]:You do not have enough ' + g_sGoldName + '!', []);
          2: FrmDlg.DMessageDlg('[Error]:Can not carry anymore ' + g_sGoldName + '!', []);
          3: FrmDlg.DMessageDlg('[Error]:You do not have enough ' + g_sGoldName + '!', []);
          4: FrmDlg.DMessageDlg('[Error]:Your Storage is full!', []);
        end;
      end;
    SM_STORAGEINFO: begin
        g_nStorageGold := Msg.Recog;
        g_boStorageOpen[0] := True;
        g_boStorageOpen[1] := LoByte(msg.Param) = 1;
        g_boStorageOpen[2] := HiByte(msg.Param) = 1;
        g_boStorageOpen[3] := LoByte(msg.tag) = 1;
        g_boStorageOpen[4] := HiByte(msg.tag) = 1;
        if body <> '' then
          DecodeBuffer(body, @g_dwStorageTime[1], SizeOf(TDateTime) * 4);
        FrmDlg2.DStorageDlg.Visible := True;
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
      end;
    SM_GETBACKPASSWORD: begin
        if msg.Series = 1 then begin
          if mrYes = FrmDlg.DMessageDlg('Please enter your new password!', [mbYes, mbNo, mbAbort, mbIgnore],
            msg.Param, deNone) then begin
            body := Trim(FrmDlg.DlgEditText);
            if body <> '' then begin
              if mrYes = FrmDlg.DMessageDlg('Please re-enter the new password!', [mbYes, mbNo, mbAbort, mbIgnore], msg.Param, deNone)
                then begin
                if Trim(FrmDlg.DlgEditText) = body then begin
                  SendClientMessage(msg.Recog, msg.tag, 0, 0, 0, body);
                end
                else
                  FrmDlg.DMessageDlg('The two passwords do not match!', []);
              end;
            end
            else begin
              if mrYes = FrmDlg.DMessageDlg('Are you sure you want to cancel?', [mbYes, mbNo])
                then begin
                SendClientMessage(msg.Recog, msg.tag, 0, 0, 0, '');
              end;
            end;
          end;
        end
        else begin
          if mrYes = FrmDlg.DMessageDlg(DecodeString(body), [mbYes, mbNo, mbAbort, mbIgnore], msg.Param, deNone) then begin
            body := Trim(FrmDlg.DlgEditText);
            if body <> '' then begin
              SendClientMessage(msg.Recog, msg.tag, 0, 0, 0, GetMD5Text(body + IntToStr(g_MySelf.m_nRecogId)))
            end;
          end;
        end;
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
      end;
    { SM_CHANGEGUILDNAME: begin
         ClientGetChangeGuildName(DecodeString(body));
       end; }
    SM_GUILDCHANGE: begin
        FrmDlg3.GuildChange(@msg, DecodeString(body));
      end;
    SM_SENDUSERSTATE: begin
        ClientGetSendUserState(@Msg, body);
      end;
    SM_GUILDADDMEMBER_OK: begin
        if g_MySelf <> nil then begin
          body := GetValidStrEx(DecodeString(body), str, ['/']);
          if (body <> '') and (str <> '') then begin
            FrmDlg3.AddGuildMember(Msg.Param, Msg.Recog, str, body);
          end;
        end;
      end;
    SM_GUILDADDMEMBER_FAIL: begin
        case Msg.Recog of
          -1: FrmDlg.DMessageDlg('Successfully sent Guild invitation, please wait for a response!', [mbOk]);
          -2: FrmDlg.DMessageDlg('[Failed]: Guild invitation has been sent already, please do not repeat!', [mbOk]);
          1: FrmDlg.DMessageDlg('[Failed]: You do not have the right to use this command.', [mbOk]);
          2: FrmDlg.DMessageDlg('[Failed]: Invitation has been rejected.', [mbOk]);
          3: FrmDlg.DMessageDlg('[Failed]: The Character already belongs to a Guild.', [mbOk]);
          4: FrmDlg.DMessageDlg('[Failed]: Invitation to Guild was refused.', [mbOk]);
          5: FrmDlg.DMessageDlg('[Failed]: Guild is currently full!', [mbOk]);
          6: FrmDlg.DMessageDlg('[Failed]: The Character is already in your guild!', [mbOk]);
          //4: FrmDlg.DMessageDlg('[失败]: 对方已经加入其他行会。', [mbOk]);
          //5: FrmDlg.DMessageDlg('对方不允许加入行会。', [mbOk]);
        end;
      end;
    SM_GUILDDELMEMBER_OK: begin
        if g_MySelf <> nil then begin
          FrmDlg3.DelGuildMember(DecodeString(body));
        end;
      end;
    SM_GUILDGOLDCHANGE_FAIL: begin
        g_ClientGuildInfo.nGuildMoney := Msg.Recog;
        case Msg.Series of
          1: FrmDlg.DMessageDlg('[Message] Can not use this command!', [mbOk]);
          2: FrmDlg.DMessageDlg('[Message] You do not have enough ' + g_sGoldName + '!', [mbOk]);
          3: FrmDlg.DMessageDlg('[Message] Insufficient funds..', [mbOk]);
          4: FrmDlg.DMessageDlg('[Message] Can not carry anymore ' + g_sGoldName + '!', [mbOk]);
        end;
      end;
    SM_GUILDDELMEMBER_FAIL: begin
        case Msg.Recog of
          1: FrmDlg.DMessageDlg('[Message] Can not use this command!', [mbOk]);
          2: FrmDlg.DMessageDlg('[Message] Non-Members of the bank!', [mbOk]);
          3: FrmDlg.DMessageDlg('[Message] Can not remove guild leaders!', [mbOk]);
          4: FrmDlg.DMessageDlg('[Message] Can not remove vice leaders!', [mbOk]);
        end;
      end;
    SM_GUILDRANKUPDATE_FAIL: begin
        case Msg.Recog of
          -2: FrmDlg.DMessageDlg('[Tip] Leader position can not be empty.', [mbOk]);
          -3: FrmDlg.DMessageDlg('[Message] Rank titles can not be empty.', [mbOk]);
          -4: FrmDlg.DMessageDlg('[Message] Can only have one leader.', [mbOk]);
          -5: FrmDlg.DMessageDlg('[Message] Leader position can not be empty.', [mbOk]);
          -6: FrmDlg.DMessageDlg('[Message] Can not add/remove members.', [mbOk]);
          -7: FrmDlg.DMessageDlg('[Message] Can not repeat titles.', [mbOk]);
          -8: FrmDlg.DMessageDlg('[Message] Title contains special characters.', [mbOk]);
          -9: FrmDlg.DMessageDlg('[Message] Guild can only have two deputy leaders.', [mbOk]);
          -10: FrmDlg.DMessageDlg('[Message] Guild can only have a maximun of ten Recruiters.', [mbOk]);
          -11: FrmDlg.DMessageDlg('[Message] Title number must be under 99.', [mbOk]);
          -12: FrmDlg.DMessageDlg('[Message] New leader must be online.', [mbOk]); 
        end;
        //FrmDlg.DGDEditGradeExitClick(FrmDlg.DGDEditGradeExit, 0, 0);
      end;
    SM_GUILDMAKEALLY_OK,
      SM_GUILDMAKEALLY_FAIL: begin
        case Msg.Recog of
          -1: FrmDlg.DMessageDlg('[Message] Both guild leaders must be face to face.', [mbOk]);
          -2: FrmDlg.DMessageDlg('[Message] Can not for an alliance with an enemy guild.', [mbOk]);
          -3: FrmDlg.DMessageDlg('[Message] Guild alliance can only be formed by leaders.', [mbOk]);
          -4: FrmDlg.DMessageDlg('[Message] Alliance was declined.', [mbOk]);
          -5: FrmDlg.DMessageDlg('[Message] Can not perform an alliance with Enemy Guild.', [mbOk]);
        end;
      end;
    SM_GUILDBREAKALLY_OK,
      SM_GUILDBREAKALLY_FAIL: begin
        case Msg.Recog of
          -1: FrmDlg.DMessageDlg('[Message] Alliance was broken!', [mbOk]);
          -2: FrmDlg.DMessageDlg('[Message] Will not be in your guild alliances!', [mbOk]);
          -3: FrmDlg.DMessageDlg('[Message] This guild!', [mbOk]);
        end;
      end;
    SM_BUILDGUILD_OK: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        FrmDlg.DMessageDlg('[Message] Guild creation was successful.', [mbOk]);
      end;
    SM_BUILDGUILD_FAIL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        case Msg.Recog of
          -1: FrmDlg.DMessageDlg('[Failed]: You are already in another guild.', [mbOk]);
          -2: FrmDlg.DMessageDlg('[Failed]: Do not have the correct creat costs.', [mbOk]);
          -3: FrmDlg.DMessageDlg('[Failed]: Do not have ready full article.', [mbOk]);
          -4: FrmDlg.DMessageDlg('[Failed]: Contains illegal characters.', []);
          -5: FrmDlg.DMessageDlg('[Failed]: Name of guild must be 3~'+ intToStr(GuildNameLen) +'characters length.', [mbOk]);
          -6: FrmDlg.DMessageDlg('[Failed]: Creation failed, guild name already exists.', [mbOk]);
          -7: FrmDlg.DMessageDlg('[Failed]: Can not use selected characters.', [mbOk]);
        else
          FrmDlg.DMessageDlg('[Guild creation failed...', [mbOk]);
        end;
      end;
    SM_MENU_OK: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
        if body <> '' then
          FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
      end;
    SM_UPLOADUSERPHOTO_FAIL: begin
        FrmDlg2.DUpLoadOk.Enabled := True;
        FrmDlg2.DUpLoadOk.Caption := 'Confirm Upload';
        FrmDlg.DStateInfoUpLoadPic.Enabled := True;
        FrmDlg.DMessageDlg(DecodeString(body), []);
      end;
    SM_UPLOADUSERPHOTO: begin
        case Msg.Series of
          0: begin
              FrmDlg2.DWinUpLoad.Visible := True;
              FrmDlg2.DUpLoadOk.Enabled := True;
              FrmDlg2.DUpLoadOk.Caption := 'Confirm Upload';
              FrmDlg.DStateInfoUpLoadPic.Enabled := True;
            end;
          1: begin
              FrmDlg2.DUpLoadOk.Caption := 'Confirm Upload';
              FrmDlg2.DUpLoadOk.Enabled := True;
              g_UserRealityInfo.sPhotoID := DecodeString(body);
              FrmDlg.DStateInfoUpLoadPic.Enabled := False;
              if FrmDLg2.HDSaveJpeg <> nil then begin
                FrmDlg2.HDSaveJpeg.SaveToFile(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg');
                FrmDlg2.HDSaveJpeg.Free;
                FrmDlg2.HDSaveJpeg := nil;
                FrmDlg.RefPhotoSurface(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', FrmDlg.MyHDInfoSurface);
              end;
              FrmDlg2.DWinUpLoad.Visible := False;
              FrmDlg.DMessageDlg('Photo uploaded successfully', []);
            end;
          2: begin
              if (Length(body) = GetCodeMsgSize(MSg.Recog * 4 / 3)) and (g_UserRealityInfo.sPhotoID <> '') then begin
                GetMem(Buffer, Msg.Recog);
                Stream := TFileStream.Create(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', fmCreate);
                try
                  DecodeBuffer(Body, Buffer, Msg.Recog);
                  Stream.Write(Buffer^, Msg.Recog);
                finally
                  Stream.Free;
                  FreeMem(Buffer);
                end;
                FrmDlg.RefPhotoSurface(g_sPhotoDirname + g_UserRealityInfo.sPhotoID + '.jpg', FrmDlg.MyHDInfoSurface);
              end;
            end;
          3: begin
              if (Length(body) = GetCodeMsgSize(MSg.Recog * 4 / 3)) and
                (Length(FrmDlg.UserState1.RealityInfo.sPhotoID) = (SizeOf(FrmDlg.UserState1.RealityInfo.sPhotoID) - 1)) then begin
                GetMem(Buffer, Msg.Recog);
                Stream := TFileStream.Create(g_sPhotoDirname + FrmDlg.UserState1.RealityInfo.sPhotoID + '.jpg',
                  fmCreate);
                try
                  DecodeBuffer(Body, Buffer, Msg.Recog);
                  Stream.Write(Buffer^, Msg.Recog);
                finally
                  Stream.Free;
                  FreeMem(Buffer);
                end;
                FrmDlg.RefPhotoSurface(g_sPhotoDirname + FrmDlg.UserState1.RealityInfo.sPhotoID + '.jpg',
                  FrmDlg.UserHDInfoSurface);
              end;
            end;
        end;

      end;
    SM_DLGMSG: begin
        if body <> '' then
          FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
      end;
    SM_DONATE_OK: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
      end;
    SM_DONATE_FAIL: begin
        FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
      end;

    SM_PLAYDICE: begin
        body2 := Copy(body, GetCodeMsgSize(sizeof(TMessageBodyWL) * 4 / 3) + 1, Length(body));
        DecodeBuffer(body, @wl, sizeof(TMessageBodyWL));
        data := DecodeString(body2);
        FrmDlg.m_nDiceCount := Msg.param; //QuestActionInfo.nParam1
        FrmDlg.m_Dice[0].nDicePoint := Lobyte(Loword(wl.lParam1));
        //UserHuman.m_DyVal[0]                                      人个八
        FrmDlg.m_Dice[1].nDicePoint := Hibyte(Loword(wl.lParam1));
        //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[2].nDicePoint := Lobyte(Hiword(wl.lParam1));
        //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[3].nDicePoint := Hibyte(Hiword(wl.lParam1));
        //UserHuman.m_DyVal[0]

        FrmDlg.m_Dice[4].nDicePoint := Lobyte(Loword(wl.lParam2));
        //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[5].nDicePoint := Hibyte(Loword(wl.lParam2));
        //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[6].nDicePoint := Lobyte(Hiword(wl.lParam2));
        //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[7].nDicePoint := Hibyte(Hiword(wl.lParam2));
        //UserHuman.m_DyVal[0]

        FrmDlg.m_Dice[8].nDicePoint := Lobyte(Loword(wl.lTag1));
        //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[9].nDicePoint := Hibyte(Loword(wl.lTag1));
        //UserHuman.m_DyVal[0]
        if FrmDlg.m_nDiceCount in [1..3] then
          FrmDlg.DMessageDlg('', [mbHelp]);
        FrmDlg.m_nDiceCount := 0;
        SendMerchantDlgSelect(Msg.Recog, data);
      end;
    SM_NEEDPASSWORD: begin
        ClientGetNeedPassword(body);
      end;
    SM_PASSWORDSTATUS: begin
        ClientGetPasswordStatus(@Msg, body);
      end;
    SM_TOPMSG: begin
        body := DecodeString(body);
        body := AnsiReplaceText(body, '#6', #6);
        body := AnsiReplaceText(body, '#5', #5);
        FrmDlg4.m_TopMsgList.AddObject(body, nil);
        FrmDlg4.DTopMsg.Visible := True;
      end;
    SM_CENTERMSG: ClientGetCenterMsg(@Msg, body);
    SM_CLEARCENTERMSG: ClientGetClearCenterMsg(@Msg, DeCodeString(body));
    SM_GETREGINFO: ClientGetRegInfo(@Msg, body);
    SM_GETSHOPLIST: ClientGetShopItems(@msg, body);
    SM_CLIENTBUYITEM: begin
        case Msg.Recog of
          1: FrmDlg.DMessageDlg('Transaction successful, please check your bag.', [mbOk]);
          2: FrmDlg.DMessageDlg('Gift sent.', [mbOk]);
          -1: FrmDlg.DMessageDlg('The items you wish to buy does not exist.', [mbOk]);
          -2: FrmDlg.DMessageDlg('Your ' + g_sGamePointName + ' is insufficient.', [mbOk]);
          -3: FrmDlg.DMessageDlg('Not enough bag space.', [mbOk]);
          -4: FrmDlg.DMessageDlg('Gift failed, reciever is not online.', [mbOk]);
          -5: FrmDlg.DMessageDlg('Gift failed, reciever does not have enough bag space.', [mbOk]);
          -6: begin
              i := MakeLong(Msg.Param, Msg.tag);
              FrmDlg.DMessageDlg(Format('[Success]: Gained %d%s and %d%s', [i, g_sGameGoldName, i, g_sGameDiamondName]),
                [mbOK]);
            end;
          -7: FrmDlg.DMessageDlg('[Failed]: Your ' + g_sGameGoldName + ' is insufficient.', [mbOk]);
          -8: FrmDlg.DMessageDlg('[Failed]: Your' + g_sGoldName + ' is insufficient.', [mbOk]);
          -20: FrmDlg.DMessageDlg('[System Error]: Please try again later.', [mbOk]);
        else
          FrmDlg.DMessageDlg('Failed to obtain Item information.', [mbOk]);
        end;
      end;
    SM_CLIENTBUYSHOPITEM: begin
        case Msg.Recog of
          1: begin
              FrmDlg.DMessageDlg('Transaction successful, please check your bag.', [mbOk]);
              if g_ShopBuyItem <> nil then
                g_ShopBuyItem.ClientShopItem.nCount := Msg.Series;
            end;
          -1: FrmDlg.DMessageDlg('[Failed]:The items you want to purchase does not exist, please re-select.', [mbOk]);
          -2: FrmDlg.DMessageDlg('[Failed]:Items are out of stock!', [mbOk]);
          -3: FrmDlg.DMessageDlg('[Failed]:Not enough bag space!', [mbOk]);
          -4: FrmDlg.DMessageDlg('[Failed]:Your ' + g_sGameGoldName + ' is insufficient.', [mbOk]);
          -5: FrmDlg.DMessageDlg('[Failed]:Your ' + g_sGamePointName + ' is insufficient.', [mbOk]);
          -6: FrmDlg.DMessageDlg('[Failed]:Unhandled message, please wait a moment before buying.', [mbOk]);
          -7: FrmDlg.DMessageDlg('[Failed]:System error has occured, please wait before you buy.', [mbOk]);
          -8: FrmDlg.DMessageDlg('[Failed]:Your ' + g_sGoldName + ' is insufficient.', [mbOk]);
          -9: FrmDlg.DMessageDlg('[Failed]:Can not use ' + g_sGoldName + ' to purchase.', [mbOk]);
        end;
        g_ShopBuyItem := nil;
      end;
    SM_OPENBOX: begin
        ClientOpenBox(@Msg, Body);
      end;
    SM_OPENBOXINFO: begin
        FrmDlg3.OpenGetItem := False;
        case Msg.Series of
          1: begin
              FrmDlg3.OpenBox(Msg.Param, Msg.tag);
            end;
          2: begin
              FrmDlg3.OpenGetItem := True;
              FrmDlg3.OpenBoxGold := Msg.Recog;
              FrmDlg3.OpenBoxGameGold := MakeLong(Msg.Param, Msg.tag);
              FrmDlg3.OpenBoxShowEffect := True;
              FrmDlg3.OpenBoxEffectIdx := 0;
              FrmDlg3.OpenBoxEffectTick := FrmMain.m_CurrentTick + 150;
              FrmDlg3.OpenBoxItems[FrmDlg3.OpenGetItemIndex].ItemType := bit_None;
              //FrmDlg3.OpenGetItemIndex := 0;
              //FrmDlg3.dbtnBoxNext.Caption := '继续转动轮盘';
            end;
          3: FrmDlg3.dwndBox.Visible := False;
          1000: begin
              FrmDlg.DMessageDlg('[Failed]:System Error!', [mbOk]);
              FrmDlg3.dwndBox.Visible := False;
            end;
          1001: begin
              FrmDlg.DMessageDlg('[Failed]:Sorry your ' + g_sGoldName + ' or ' + g_sGameGoldName + ' is insufficient!', [mbOk]);
              FrmDlg3.OpenBoxStop := False;
            end;
          1002: begin
              FrmDlg.DMessageDlg('[Failed]:Lack of bag space!', [mbOk]);
            end;
        end;
      end;
    SM_TAXISLIST: begin
        ClientGetTaxisList(Msg.Recog, msg.Param, Msg.Tag, msg.Series, Body);
      end;
    SM_TAXISLIST_FAIL: begin
        FrmDlg.DMessageDlg('Did not list.', [mbOK]);
      end;
    SM_GAMESETUPINFO: begin
        GetGameSetupInfo(@Msg, Body);
      end;
    SM_MAKEITEM: begin
        //frmdlg2.MakeItemBack(@msg, body);
      end;
    SM_OPENURL: begin
       if msg.Recog = 0 then begin //normal web opening
          FrmWEB.wb.UISettings.EnableScrollBars := False;
          FrmDlg2.OpenWeb(DecodeString(body), Msg.Param, Msg.tag);
        end else begin //auction just opened
          g_boAllowAuction := True;
          FrmWEB.wb.UISettings.EnableScrollBars := False;
          FrmDlg2.OpenWeb(DecodeString(body), Msg.Param, Msg.tag, True);
        end;
      end;
    SM_REFICONINFO: begin
        ClientGetSetIcon(@Msg, DeCodeString(body));
      end;
    SM_REFHUMLOOK: begin
        ClientGetHumLook(@Msg);
      end;
    SM_AUCTIONREPLY: begin
      //back: 10 < seller not found, 11 < seller = self, 12 < seller = blank, -1: item not found, 2: not enough gamegold, 3: not enough gold, 4: inventory full?, 5: all ok
      case msg.Series of
        10:FrmDlg.DmessageDlg('Seller not found.',[mbOK],70,denone,'',True);
        11:FrmDlg.DmessageDlg('Cannot buy from yourself.',[mbOK],70,denone,'',True);
        12:FrmDlg.DmessageDlg('Auction not found.',[mbOK],70,denone,'',True);
        65535:FrmDlg.DmessageDlg('Item not found.',[mbOK],70,denone,'',True);
        2:FrmDlg.DmessageDlg('Insufficient gamegold.',[mbOK],70,denone,'',True);
        3:FrmDlg.DmessageDlg('Insufficient gold.',[mbOK],70,denone,'',True);
        4:FrmDlg.DmessageDlg('Inventory full.',[mbOK],70,denone,'',True);
        5:FrmDlg.DmessageDlg('You have succesfully bought this item.',[mbOK],70,denone,'',True);
      end;
      if msg.Series < 10 then begin
        g_MySelf.m_nGold := msg.recog;
        g_MySelf.m_nGameGold := MakeLong(msg.Param, msg.tag);
      end;
    end
  else begin
      if g_MySelf = nil then
        Exit; //Jacky 在未进入游戏时不处理下面
      //Jacky
      //            DScreen.AddSysMsg (IntToStr(msg.Ident) + ' : ' + body);
      PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(Msg.ident));
      PlayScene.MemoLog.Lines.Add('Recog: ' + IntToStr(Msg.Recog));
      PlayScene.MemoLog.Lines.Add('Param: ' + IntToStr(Msg.param));
      PlayScene.MemoLog.Lines.Add('Tag: ' + IntToStr(Msg.tag));
      PlayScene.MemoLog.Lines.Add('Series: ' + IntToStr(Msg.series));
    end;
  end;

  if pos(g_CodeHead, datablock) > 0 then
    DScreen.AddSysMsg(datablock, clGreen);
end;

procedure TfrmMain.DisplayChange(boReset: Boolean);
var
  nWidth, nHeight: Integer;
  result:hresult;
begin
//thedeath
  if boReset then begin
    if FboDisplayChange then begin
      FormStyle := fsNormal;
      FIDDraw := nil;
      if FDDrawHandle > 0 then
        FreeLibrary(FDDrawHandle);
      FDDrawHandle := 0;
      FboDisplayChange := False;
      UnRegisterHotKey(Handle, FHotKeyId);
    end;
  end else begin
    if not FboDisplayChange then begin
      //FormStyle := fsStayOnTop;
      if HGE.System_GetState(HGE_FScreenWidth) = DEFSCREENWIDTH then begin
        nWidth := DEFSCREENWIDTH;
        nHeight := DEFSCREENHEIGHT;
      end
      else begin
        nWidth := DEFMAXSCREENWIDTH;
        nHeight := DEFMAXSCREENHEIGHT;
      end;

      FIDDraw := nil;
      if FDDrawHandle > 0 then
        FreeLibrary(FDDrawHandle);
      FDDrawHandle := LoadLibrary('DDraw.dll');
      frmMain.Left := 0;
      frmMain.Top := 0;
      if DD_OK = TDirectDrawCreate(GetProcAddress(FDDrawHandle, 'DirectDrawCreate'))(nil, FIDDraw{,IID_IDirectDraw7}, nil) then begin
//        result :=  FIDDraw.SetCooperativeLevel(handle,DDSCL_EXCLUSIVE or DDSCL_FULLSCREEN);
//        if DD_OK <> result then
//          debugoutstr('Error: with set coop level')
//        else begin
          result:=  FIDDraw.SetDisplayMode(nWidth, nHeight, 32);
          if result = DD_OK then begin
            FboDisplayChange := True;
            FHotKeyId := GlobalAddAtom('361ClientKey') - $C000;
            RegisterHotKey(Handle, FHotKeyId, MOD_ALT, VK_TAB);
          end;
          if result = DDERR_INVALIDMODE then begin
            debugoutstr('Error: your monitor does not support ' + inttostr(nWidth) + ':' + inttostr(nHeight) + '@32bit colors resolutions');
          end;
        //end;
      end else
        debugoutstr('Error creating directdraw');
      debugoutstr('now in fullscreen');
    end;
  end;
end;

procedure TfrmMain.ClientGetPasswdSuccess(body: string);
var
  str, runaddr, runport, certifystr: string;
begin
  str := DecodeString(body);
  str := GetValidStr3(str, runaddr, ['/']);
  str := GetValidStr3(str, runport, ['/']);
  str := GetValidStr3(str, certifystr, ['/']);
  Certification := StrToIntDef(certifystr, 0);
  FrmDlg.sHintStr := 'Connecting to Character Select..';
  boSocketClose := True;
  CSocket.Active := FALSE;
  CSocket.Host := '';
  CSocket.Port := 0;
  //FrmDlg.DSelServerDlg.Visible := FALSE;
  WaitAndPass(500);
  g_ConnectionStep := cnsSelChr;
  with CSocket do begin
    if g_ServerInfo[g_ServerChoice].sAddrs2 = '' then begin
      g_ServerInfo[g_ServerChoice].sAddrs2 := runaddr;
      g_ServerInfo[g_ServerChoice].nPort2 := StrToIntDef(runport, 0);
    end;
    address:='';
    Host := g_ServerInfo[g_ServerChoice].sAddrs2;
    Port := g_ServerInfo[g_ServerChoice].nPort2;
    Active := True;
  end;

  boSocketClose := False;
end;
(*
procedure TfrmMain.ClientGetPasswordOK(Msg: TDefaultMessage;
  sBody: string);
var
  i: Integer;
  sServerName: string;
  sServerStatus: string;
  nCount: Integer;
begin
  sBody := DecodeString(sBody);
  //  FrmDlg.DMessageDlg (sBody + '/' + IntToStr(Msg.Series), [mbOk]);
  nCount := _MIN(6, Msg.series);
  g_ServerList.Clear;
  for i := 0 to nCount - 1 do begin
    sBody := GetValidStr3(sBody, sServerName, ['/']);
    sBody := GetValidStr3(sBody, sServerStatus, ['/']);
    //g_ServerList.AddObject(sServerName, TObject(StrToIntDef(sServerStatus, 0)));
  end;
  //if g_ServerList.Count = 0 then begin
//    g_ServerList.InsertObject(0,'九月传奇',TObject(StrToIntDef(sServerStatus,0)));
//  end;

  g_wAvailIDDay := Loword(Msg.Recog);
  g_wAvailIDHour := Hiword(Msg.Recog);
  g_wAvailIPDay := Msg.param;
  g_wAvailIPHour := Msg.tag;

  if g_wAvailIDDay > 0 then begin
    if g_wAvailIDDay = 1 then
      FrmDlg.DMessageDlg('您当前ID费用到今天为止。', [mbOk])
    else if g_wAvailIDDay <= 3 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIDDay) +
        ' 天。', [mbOk]);
  end
  else if g_wAvailIPDay > 0 then begin
    if g_wAvailIPDay = 1 then
      FrmDlg.DMessageDlg('您当前IP费用到今天为止。', [mbOk])
    else if g_wAvailIPDay <= 3 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPDay) +
        ' 天。', [mbOk]);
  end
  else if g_wAvailIPHour > 0 then begin
    if g_wAvailIPHour <= 100 then
      FrmDlg.DMessageDlg('您当前IP费用还剩 ' + IntToStr(g_wAvailIPHour) +
        ' 小时。', [mbOk]);
  end
  else if g_wAvailIDHour > 0 then begin
    FrmDlg.DMessageDlg('您当前ID费用还剩 ' + IntToStr(g_wAvailIDHour) +
      ' 小时。', [mbOk]);
    ;
  end;

  //if not LoginScene.m_boUpdateAccountMode then
  ClientGetSelectServer;
end;

procedure TfrmMain.ClientGetSelectServer;
//var
//  sname: string;
begin
  LoginScene.HideLoginBox;
  if g_ServerList.Count = 1 then begin
    //g_sServerMiniName := g_ServerList[0];
    SendSelectServer(g_sServerMiniName);
    g_sServerName := g_sServerMiniName;
  end
  else
    FrmDlg.ShowSelectServerDlg;
end;   *)

procedure TfrmMain.ClientGetReceiveChrs(body: string);
var
  i, select: Integer;
  //OldDateTime, tTime: TDateTime;
  str, sID, uname, sjob, swuxin, slevel, ssex: string;
begin
  SelectChrScene.ClearChrs;
  str := DecodeString(body);
  select := 0;
  //OldDateTime := 0;
  for i := 0 to 2 do begin
    str := GetValidStr3(str, uname, ['/']);
    str := GetValidStr3(str, sjob, ['/']);
    str := GetValidStr3(str, swuxin, ['/']);
    str := GetValidStr3(str, slevel, ['/']);
    str := GetValidStr3(str, ssex, ['/']);

    if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
      if uname[1] = '*' then begin
        select := i;
        uname := Copy(uname, 2, Length(uname) - 1);
      end;
      SelectChrScene.AddChr(uname, StrToIntDef(sID, 0), StrToIntDef(sjob, 0), StrToIntDef(swuxin, 0),
        StrToIntDef(slevel, 0), StrToIntDef(ssex, 0), now);
    end;
    {str := GetValidStr3(str, sID, ['/']);
    str := GetValidStr3(str, uname, ['/']);
    str := GetValidStr3(str, sjob, ['/']);
    str := GetValidStr3(str, ssex, ['/']);
    str := GetValidStr3(str, slevel, ['/']);
    str := GetValidStr3(str, swuxin, ['/']);
    str := GetValidStr3(str, stime, ['/']);
    if (uname <> '') and (slevel <> '') and (ssex <> '') and (stime <> '') then begin
      tTime := StrToDateTimeDef(stime, now);
      if tTime > OldDateTime then begin
        select := i;
        OldDateTime := tTime;
      end;
      SelectChrScene.AddChr(uname, StrToIntDef(sID, 0), StrToIntDef(sjob, 0), StrToIntDef(swuxin, 0),
        StrToIntDef(slevel, 0), StrToIntDef(ssex, 0), tTime);
    end;  }
  end;
  with SelectChrScene do begin
    if select = 0 then begin
      ChrArr[0].Selected := True;
      ChrArr[1].Selected := FALSE;
      ChrArr[2].Selected := FALSE;
    end
    else if select = 1 then begin
      ChrArr[0].Selected := FALSE;
      ChrArr[1].Selected := True;
      ChrArr[2].Selected := FALSE;
    end
    else begin
      ChrArr[0].Selected := FALSE;
      ChrArr[1].Selected := FALSE;
      ChrArr[2].Selected := True;
    end;
  end;
  if boOpenLoginDoor then begin
    LoginScene.OpenLoginDoor;
    boOpenLoginDoor := False;
  end
  else begin
    DScreen.ChangeScene(stSelectChr);
  end;
end;

procedure TfrmMain.ClientGetStartPlay(body: string);
var
  str, sport: string;
begin
  str := DecodeString(body);
  if (g_ServerInfo[g_serverChoice].sAddrs3 = '') then begin
    sport := GetValidStr3(str, g_ServerInfo[g_ServerChoice].sAddrs3, ['/']);
    g_ServerInfo[g_ServerChoice].nPort3 := StrToIntDef(sport, 0);
  end;
  boSocketClose := True;
  CSocket.Active := FALSE;
  CSocket.Host := '';
  CSocket.Port := 0;
  WaitAndPass(500);

  g_ConnectionStep := cnsPlay;

  with CSocket do begin
    Address := '';
    Host := g_ServerInfo[g_ServerChoice].sAddrs3;
    Port := g_ServerInfo[g_ServerChoice].nPort3;
    Active := True;
  end;
  boSocketClose := False;
end;

procedure TfrmMain.ClientGetTaxisList(nIdx, nNowPage, nMaxPage, nClickIdx:
  integer;
  body: string);
begin

end;

procedure TfrmMain.ClientGetReconnect(body: string);
var
  str, addr, sport: string;
begin
  str := DecodeString(body);
  sport := GetValidStr3(str, addr, ['/']);
  SaveIDInfo();
  SaveHumInfo(CharName);

  g_boServerChanging := True;
  CSocket.Active := FALSE; //肺弊牢俊 楷搬等 家南 摧澜
  CSocket.Host := '';
  CSocket.Port := 0;

  WaitAndPass(500); //0.5檬悼救 扁促覆

  g_ConnectionStep := cnsPlay;
  with CSocket do begin
    Address := '';
    Host := addr;
    Port := StrToIntDef(sport, 0);
    Active := True;
  end;
end;

procedure TfrmMain.ClientGetMapDescription(Msg: TDefaultMessage; sBody: string);
var
  sTitle: string;
  List: TList;
  i: integer;
  MapEffect: pTClientMapEffect;
  event: TShopClEvent;
begin
  GetValidStr3(DecodeString(sBody), sTitle, [#13]);
  g_sMapTitle := sTitle;
  g_MapDesc := GetMapDescList(sTitle);
  g_nMapMusic := Msg.Recog;
  List := GetMapEffectList(sTitle);
  if List <> nil then begin
    for I := 0 to List.Count - 1 do begin
      MapEffect := List[i];
      event := TShopClEvent.Create(Integer(MapEffect), MapEffect.wX, MapEffect.wY, MapEffect.btType, MapEffect.sName);
      event.m_nDir := 0;
      event.m_boClient := True;
      event.m_dwFrameTick := 100;
      EventMan.AddEvent(event); //clvent啊 Free瞪 荐 乐澜
    end;
  end;
  PlayMapMusic(True);
  if g_boNpcMoveing and (g_nScriptGotoStr <> '') then
    ScriptGoto(g_nScriptGotoStr);
end;

procedure TfrmMain.ClientGetMissionInfo(Msg: TDefaultMessage; sBody: string);
var
  i, nIdx: Integer;
  ClientMissionInfo: pTClientMissionInfo;
  MissionInfo: TMissionInfo;
  sIdx, sMission, sMasterName, sName: string;
  ClientMission, OldClientMission: pTClientMission;
  DTreeNodes, DTreeNodes2: pTDTreeNodes;
  OldCount: Integer;

begin
  case Msg.Series of
    MISSTAG_FLAGLIST: begin
        DecodeBuffer(sBody, @g_MissionFlag[0], SizeOf(g_MissionFlag));
      end;
    MISSTAG_ARITHMOMETERLIST: begin
        DecodeBuffer(sBody, @g_MissionArithmometer[0], SizeOf(g_MissionArithmometer));
        if Msg.tag <> 0 then
          PlayScene.RefMissionInfo;
      end;
    MISSTAG_MISSIONLIST: begin
        ClearMissionInfoList();
        FrmDlg3.InitializeMissionTree;
        while True do begin
          if sBody = '' then break;
          sBody := GetValidStr3(sBody, sIdx, ['/']);
          sBody := GetValidStr3(sBody, sMission, ['/']);
          nIdx := StrToIntDef(sIdx , -1);
          if (nIdx in [Low(TMissionInfos)..High(TMissionInfos)]) and (sMission <> '') then begin
            SafeFillChar(MissionInfo, SizeOf(MissionInfo), #0);
            DecodeBuffer(sMission, @MissionInfo, SizeOf(MissionInfo));
            ClientMission := GetMissionInfo(MissionInfo.sMissionName);
            if ClientMission <> nil then begin
              New(ClientMissionInfo);
              SafeFillChar(ClientMissionInfo^, SizeOf(TClientMissionInfo), #0);
              ClientMissionInfo.MissionIdx := nIdx;
              ClientMissionInfo.MissionInfo := MissionInfo;
              ClientMissionInfo.ClientMission := ClientMission;
              ClientMissionInfo.DTreeNodes := nil;
              ClientMission.MissionInfo := ClientMissionInfo;
              g_MissionInfoList.Add(ClientMissionInfo);
              if not ClientMission.boHide then begin
                sMasterName := ClientMission.sMissionMaster;
                DTreeNodes := nil;
                while True do begin
                  sMasterName := GetValidStr3(sMasterName, sName, ['/', '\', '|']);
                  if sName = '' then break;
                  DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(DTreeNodes, sName, True);
                end;
                if DTreeNodes <> nil then begin
                  DTreeNodes2 := FrmDlg3.DTrvwMission.NewTreeNodes(ClientMission.sMissionShowName);
                  DTreeNodes2.Item := ClientMissionInfo;
                  DTreeNodes.ItemList.Add(DTreeNodes2);
                  ClientMissionInfo.DTreeNodes := DTreeNodes2;
                  if FrmDlg3.DTrvwMission.Select = nil then begin
                    FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, DTreeNodes2);
                    FrmDlg3.DTrvwMission.Select := DTreeNodes2;
                  end;
                end;
              end;
            end;
          end;
        end;
        FrmDlg3.DTrvwMission.RefHeight;
        PlayScene.RefMissionList;
        PlayScene.RefMissionInfo;
        FrmDlg2.m_boShowMissionChange := True;
        //刷新任务
      end;
    MISSTAG_FLAGCHANGE: begin
        if Msg.Recog in [Low(g_MissionFlag)..High(g_MissionFlag)] then begin
          g_MissionFlag[Msg.Recog] := Msg.Param;
          PlayScene.RefMissionInfo;
          FrmDlg3.MDlgChange := True;
          FrmDlg2.m_boShowMissionChange := True;
        end;
      end;
    MISSTAG_ADDMISSION: begin
        sMission := DecodeString(sBody);
        if (Msg.Recog in [Low(TMissionInfos)..High(TMissionInfos)]) and (sMission <> '') then begin
          SafeFillChar(MissionInfo, SizeOf(MissionInfo), #0);
          MissionInfo.wTime := Msg.tag;
          MissionInfo.sMissionName := sMission;
          ClientMission := GetMissionInfo(sMission);
          if ClientMission <> nil then begin
            New(ClientMissionInfo);
            SafeFillChar(ClientMissionInfo^, SizeOf(TClientMissionInfo), #0);
            ClientMissionInfo.MissionIdx := Msg.Recog;
            ClientMissionInfo.MissionInfo := MissionInfo;
            ClientMissionInfo.MissionInfo.boTrack := True;
            ClientMissionInfo.ClientMission := ClientMission;
            ClientMissionInfo.DTreeNodes := nil;
            ClientMission.MissionInfo := ClientMissionInfo;
            g_MissionInfoList.Add(ClientMissionInfo);
            if not ClientMission.boHide then begin
              if ClientMission.NPC <> nil then
                PlayScene.SetMissionInfo(ClientMission.NPC);

              sMasterName := ClientMission.sMissionMaster;
              DTreeNodes := nil;
              while True do begin
                sMasterName := GetValidStr3(sMasterName, sName, ['/', '\', '|']);
                if sName = '' then break;
                DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(DTreeNodes, sName, True);
              end;
              //DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(nil, ClientMission.sMissionMaster, True);
              if DTreeNodes <> nil then begin
                DTreeNodes2 := FrmDlg3.DTrvwMission.NewTreeNodes(ClientMission.sMissionShowName);
                DTreeNodes2.Item := ClientMissionInfo;
                DTreeNodes.ItemList.Add(DTreeNodes2);
                DTreeNodes.boOpen := True;
                FrmDlg3.DTrvwMission.Select := DTreeNodes2;
                ClientMissionInfo.DTreeNodes := DTreeNodes2;
                FrmDlg3.DTrvwMission.RefHeight;
                //FrmDlg3.dwndMission.Visible := True;
                FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, DTreeNodes2);
              end;
            end;
            FrmDlg2.m_boShowMissionChange := True;
          end;
        end;
      end;
    MISSTAG_DELMISSION: begin
        for I := 0 to g_MissionInfoList.Count - 1 do begin
          ClientMissionInfo := g_MissionInfoList[i];
          if ClientMissionInfo.MissionIdx = Msg.Recog then begin
            if ClientMissionInfo.DTreeNodes <> nil then begin
              if FrmDlg3.DTrvwMission.Select = ClientMissionInfo.DTreeNodes then
                FrmDlg3.ShowMissionDlg(nil);
              FrmDlg3.DTrvwMission.DelItem(ClientMissionInfo.DTreeNodes, False);
            end;
            ClientMissionInfo.ClientMission.MissionInfo := nil;
            if ClientMissionInfo.ClientMission.NPC <> nil then
              PlayScene.SetMissionInfo(ClientMissionInfo.ClientMission.NPC);
            Dispose(ClientMissionInfo);
            g_MissionInfoList.Delete(I);
            FrmDlg2.m_boShowMissionChange := True;
            break;
          end;
        end;
      end;
    MISSTAG_UPDATEMISSION: begin
        sMission := DecodeString(sBody);
        if (Msg.Recog in [Low(TMissionInfos)..High(TMissionInfos)]) and (sMission <> '') then begin
          ClientMission := GetMissionInfo(sMission);
          if ClientMission <> nil then begin
            for I := 0 to g_MissionInfoList.Count - 1 do begin
              ClientMissionInfo := g_MissionInfoList[i];
              if ClientMissionInfo.MissionIdx = Msg.Recog then begin
                OldClientMission := ClientMissionInfo.ClientMission;
                ClientMissionInfo.ClientMission.MissionInfo := nil;
                ClientMissionInfo.MissionInfo.sMissionName := sMission;
                ClientMissionInfo.MissionInfo.btKillCount1 := Msg.Param;
                ClientMissionInfo.MissionInfo.btKillCount2 := Msg.tag;
                //ClientMissionInfo.MissionInfo.boTrack := True;
                ClientMissionInfo.nItemCount1 := 0;
                ClientMissionInfo.nItemCount2 := 0;
                ClientMissionInfo.nItemCount3 := 0;
                ClientMissionInfo.ClientMission := ClientMission;
                ClientMission.MissionInfo := ClientMissionInfo;
                if ClientMission.NPC <> nil then
                  PlayScene.SetMissionInfo(ClientMission.NPC);
                if OldClientMission.NPC <> nil then
                  PlayScene.SetMissionInfo(OldClientMission.NPC);

                if ClientMissionInfo.DTreeNodes <> nil then begin
                  ClientMissionInfo.DTreeNodes.sName := ClientMission.sMissionShowName;
                  ClientMissionInfo.DTreeNodes.nNameLen := g_DXCanvas.TextWidth(ClientMission.sMissionShowName) +
                    FrmDlg3.DTrvwMission.ImageWidth;
                  if FrmDlg3.DTrvwMission.Select = ClientMissionInfo.DTreeNodes then
                    FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, ClientMissionInfo.DTreeNodes);
                end else
                if not ClientMission.boHide then begin
                  sMasterName := ClientMission.sMissionMaster;
                  DTreeNodes := nil;
                  while True do begin
                    sMasterName := GetValidStr3(sMasterName, sName, ['/', '\', '|']);
                    if sName = '' then break;
                    DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(DTreeNodes, sName, True);
                  end;
                  //DTreeNodes := FrmDlg3.DTrvwMission.GetTreeNodes(nil, ClientMission.sMissionMaster, True);
                  if DTreeNodes <> nil then begin
                    DTreeNodes2 := FrmDlg3.DTrvwMission.NewTreeNodes(ClientMission.sMissionShowName);
                    DTreeNodes2.Item := ClientMissionInfo;
                    DTreeNodes.ItemList.Add(DTreeNodes2);
                    DTreeNodes.boOpen := True;
                    FrmDlg3.DTrvwMission.Select := DTreeNodes2;
                    ClientMissionInfo.DTreeNodes := DTreeNodes2;
                    FrmDlg3.DTrvwMission.RefHeight;
                    //FrmDlg3.dwndMission.Visible := True;
                    FrmDlg3.DTrvwMissionTreeViewSelect(FrmDlg3.DTrvwMission, DTreeNodes2);
                  end;
                end;
                FrmDlg2.m_boShowMissionChange := True;
                break;
              end;
            end;
          end;
        end;
      end;
    MISSTAG_UPDATEMISSIONTIME: begin
        if (Msg.Recog in [Low(TMissionInfos)..High(TMissionInfos)]) then begin
          for I := 0 to g_MissionInfoList.Count - 1 do begin
            ClientMissionInfo := g_MissionInfoList[i];
            if ClientMissionInfo.MissionIdx = Msg.Recog then begin
               ClientMissionInfo.MissionInfo.wTime := Msg.tag;
              FrmDlg2.m_boShowMissionChange := True;
              break;
            end;
          end;
        end;
      end;
    MISSTAG_CHANGEKILLMONCOUNT: begin
        for ClientMissionInfo in g_MissionInfoList do begin
          if ClientMissionInfo.MissionIdx = Msg.Recog then begin
            if Msg.Param = 2 then begin
              if ClientMissionInfo.MissionInfo.btKillCount2 < ClientMissionInfo.ClientMission.btKillCount2 then begin
                OldCount := ClientMissionInfo.MissionInfo.btKillCount2;
                ClientMissionInfo.MissionInfo.btKillCount2 := _MIN(Msg.tag, ClientMissionInfo.ClientMission.btKillCount2);
                if ClientMissionInfo.MissionInfo.btKillCount2 >= ClientMissionInfo.ClientMission.btKillCount2 then begin
                  if ClientMissionInfo.ClientMission.NPC <> nil then
                    PlayScene.SetMissionInfo(ClientMissionInfo.ClientMission.NPC);
                end;
                if OldCount <> ClientMissionInfo.MissionInfo.btKillCount2 then begin
                  if (FrmDlg3.DTrvwMission.Select <> nil) and (FrmDlg3.DTrvwMission.Select.Item = ClientMissionInfo) then
                    FrmDlg3.MDlgChange := True;
                  if CLientMissionInfo.MissionInfo.boTrack then
                    FrmDlg2.m_boShowMissionChange := True;
                end;
              end;
            end else begin
              if ClientMissionInfo.MissionInfo.btKillCount1 < ClientMissionInfo.ClientMission.btKillCount1 then begin
                OldCount := ClientMissionInfo.MissionInfo.btKillCount1;
                ClientMissionInfo.MissionInfo.btKillCount1 := _MIN(Msg.tag, ClientMissionInfo.ClientMission.btKillCount1);
                if ClientMissionInfo.MissionInfo.btKillCount1 >= ClientMissionInfo.ClientMission.btKillCount1 then begin
                  if ClientMissionInfo.ClientMission.NPC <> nil then
                    PlayScene.SetMissionInfo(ClientMissionInfo.ClientMission.NPC);
                end;
                if OldCount <> ClientMissionInfo.MissionInfo.btKillCount1 then begin
                  if (FrmDlg3.DTrvwMission.Select <> nil) and (FrmDlg3.DTrvwMission.Select.Item = ClientMissionInfo) then
                    FrmDlg3.MDlgChange := True;
                  if CLientMissionInfo.MissionInfo.boTrack then
                    FrmDlg2.m_boShowMissionChange := True;
                end;
              end;
            end;
            break;
          end;
        end;
      end;
    MISSTAG_ARITHMOMETERCHANGE: begin
        if Msg.Recog in [Low(g_MissionArithmometer)..High(g_MissionArithmometer)] then begin
          g_MissionArithmometer[Msg.Recog] := Msg.Param;
          PlayScene.RefMissionInfo;
        end;
      end;
  end;
end;

procedure TfrmMain.ClientGetGameGoldName(Msg: TDefaultMessage; sBody: string);
begin
  {if sBody <> '' then begin
    g_sGamePointName := DecodeString(sBody);
  end;     }
  if sBody <> '' then begin
    g_sGameGoldName := DecodeString(sBody);
    FrmDlg2.DShopGetGamePoint.Caption := 'Exchange ' + g_sGameGoldName;
    FrmDlg2.DShopGamePoint.Caption := g_sGameGoldName + ' area.';
  end;
  
  if g_MySelf = nil then exit;

  g_MySelf.m_nGameGold := Msg.Recog;
  g_MySelf.m_nGamePoint := MakeLong(Msg.param, Msg.tag);
  g_nDander := msg.Series;
end;

procedure TfrmMain.ClientGetBabDuraChange2(Msg: pTDefaultMessage);
var
  I: Integer;
begin
  for I := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[I].UserItem.MakeIndex = Msg.Recog) and (g_ItemArr[I].S.Name <> '') then begin
      g_ItemArr[I].UserItem.Dura := Msg.Param;
      g_ItemArr[I].UserItem.DuraMax := Msg.Tag;
      RefUserKeyItemInfo(@g_ItemArr[I]);
      DScreen.AddSysMsg('Received <CO$FFFF>' + g_ItemArr[I].s.Name + ' ' + '<CE>' + IntToStr(MSg.Series), GetRGB(70));
      exit;
    end;
  end;
  if g_MovingItem.Item.UserItem.MakeIndex = Msg.Recog then begin
    g_MovingItem.Item.UserItem.Dura := Msg.Param;
    g_MovingItem.Item.UserItem.DuraMax := Msg.Tag;
    DScreen.AddSysMsg('Received <CO$FFFF>' + g_MovingItem.Item.s.Name + ' ' + '<CE>' + IntToStr(MSg.Series), GetRGB(70));
  end;
end;

procedure TfrmMain.ClientGetAddItem(Msg: TDefaultMessage; body: string; boNew: Boolean = true);
var
  cu: TNewClientItem;
  sCount: string;
begin
  if body <> '' then begin
    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
    sCount := '1';
    if (sm_Superposition in cu.s.StdModeEx) and (cu.s.DuraMax > 1) then begin
      sCount := IntToStr(cu.UserItem.Dura);
    end;
    AddItemBag(cu);
    if boNew then
      FillUserKeys(cu);
    RefUserKeyItemInfo(@cu);
    DScreen.AddSysMsg('Received <CO$FFFF>' + cu.S.name + ' ' + '<CE>' + sCount, GetRGB(70));
  end;
end;

procedure TfrmMain.ClientGetGroupAddItem(Msg: pTDefaultMessage);
var
  GroupMember: pTGroupMember;
  i: Integer;
  StdItem: TStdItem;
  sCount: string;
begin
  if g_GroupMembers.Count > 0 then begin
    for i := 0 to g_GroupMembers.Count - 1 do begin
      GroupMember := g_GroupMembers[i];
      if GroupMember.ClientGroup.UserID = msg.Recog then begin
        StdItem := GetStditem(msg.Param, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        if StdItem.Name <> '' then begin
          sCount := '1';
          if (sm_Superposition in StdItem.StdModeEx) and (StdItem.DuraMax > 1) then begin
            sCount := IntToStr(msg.tag);
          end;
          DScreen.AddSysMsg('<CO$FFFF00>' + GroupMember.ClientGroup.UserName +
            '<CE> Get <CO$FFFF>' + StdItem.name + ' ' + sCount + '<CE>', cllime);
        end;
        break;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetUpdateItem(body: string);
var
  i: Integer;
  cu: TNewClientItem;
begin
  if body <> '' then begin
    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
    UpdateItemBag(cu);
    for i := 0 to MAXUSEITEMS - 1 do begin
      if (g_UseItems[i].S.name = cu.S.name) and (g_UseItems[i].UserItem.MakeIndex = cu.UserItem.MakeIndex) then begin
        g_UseItems[i] := cu;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetDelItem(sindex, nIdent: Integer);
begin
  DelItemBag(nIdent, sindex);
end;

procedure TfrmMain.ClientGetDelItems(body: string);
var
  str, iname: string;
begin
  body := DecodeString(body);
  while body <> '' do begin
    body := GetValidStr3(body, iname, ['/']);
    body := GetValidStr3(body, str, ['/']);
    if (iname <> '') and (str <> '') then begin
      DelItemBag(StrToIntDef(iname, 0), StrToIntDef(str, 0));
    end
    else
      break;
  end;
end;

procedure TfrmMain.ClientGetBabDuraChange(Idx, Dura, MaxDura: integer);
var
  I: Integer;
begin
  for I := High(g_ItemArr) downto Low(g_ItemArr) do begin
    if (g_ItemArr[I].UserItem.MakeIndex = Idx) and (g_ItemArr[I].S.Name <> '') then begin
      g_ItemArr[I].UserItem.Dura := Dura;
      g_ItemArr[I].UserItem.DuraMax := MaxDura;
      RefUserKeyItemInfo(@g_ItemArr[I]);
      exit;
    end;
  end;
  if g_MovingItem.Item.UserItem.MakeIndex = Idx then begin
    g_MovingItem.Item.UserItem.Dura := Dura;
    g_MovingItem.Item.UserItem.DuraMax := MaxDura;
  end;
end;

procedure TfrmMain.ClientGetAddBagItmes(body: string);
var
  Index: Integer;
  str, data: string;
  cu: TNewClientItem;
begin
  SafeFillChar(g_AddBagItems, sizeof(g_AddBagItems), #0);
  while True do begin
    if body = '' then break;
    body := GetValidStr3(body, str, ['/']);
    body := GetValidStr3(body, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
      SafeFillChar(cu, SizeOf(TNewClientItem), #0);
      DecodeItem(data, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
      g_AddBagItems[Index] := cu;
    end;
  end;
  RecalcBagCount();
  FrmDlg.RefAddBagWindow();
end;

procedure TfrmMain.ClientUpdateUserItem(body: string);
var
  UserItem: TUserItem;
begin
  SafeFillChar(UserItem, SizeOf(TUserItem), #0);
  DecodeItem(body, @UserItem);
  UpdateItemBagByUserItem(UserItem);
end;

procedure TfrmMain.ClientGetBagItmes(body: string);
  procedure RestoreBagItemPos();
    function FindItem(nMakeIndex:integer):integer;
    var
      i: integer;
    begin
      result := -1;
      for i := 0 to Length(g_ItemArr) - 1 do begin
        if g_ItemArr[i].UserItem.MakeIndex = nMakeIndex then begin
          result := i;
          exit;
        end;
      end;
    end;
  var
    i:integer;
    temp : TNewClientItem;
    noldindex:integer;
  begin
    for I := 0 to Length(g_TempItemArr) - 1 do begin
      if g_TempItemArr[i].s.Name <> '' then begin //if the item slot is filled, find it and move the others :p
        if g_ItemArr[i].UserItem.MakeIndex <> g_TempItemArr[i].UserItem.MakeIndex then begin //if the positions arent as we left them
          temp := g_ItemArr[i];
          noldindex := FindItem(g_TempItemArr[i].UserItem.MakeIndex);
          if noldindex > -1 then begin
            g_ItemArr[i] := g_ItemArr[noldindex];
            g_ItemArr[noldindex] := temp;
          end;
        end;
      end;
    end;
  end;
var
  str: string;
  cu: TNewClientItem;
begin
  //ClearBag;
  g_boBagItemsRead := True;
  FrmDlg2.ClearShopSellItems;
  FrmDlg3.ClearStrengthenInfo;
  FrmDlg3.ClearMakeItemInfo;
  FrmDlg3.ClearUnSealInfo;
  SafeFillChar(g_ItemArr, sizeof(g_ItemArr), #0);
  while True do begin
    if body = '' then
      break;
    body := GetValidStr3(body, str, ['/']);

    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(str, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
    if not FrmDlg2.GetShopSellItems(cu) then
      AddItemBagByEx(cu);
  end;
  ArrangeItembag;
  RestoreBagItemPos();
  RefUserKeyItemInfo(nil);
  //g_boBagLoaded := True;
end;

procedure TfrmMain.ClientGetEMail(Msg: pTDefaultMessage; body: string);
var
  ClientEMailHeader: TClientEMailHeader;
  str: string;
  EMailInfo: pTEMailInfo;
  I: integer;
  nCount: Integer;
  nIndex: Integer;
begin
  case Msg.Series of
    0: begin
        nCount := 0;
        ClearEMailInfo();
        while True do begin
          if Body = '' then
            break;
          body := GetValidStr3(body, str, ['/']);
          if str = '' then
            break;
          DecodeBuffer(str, @ClientEMailHeader, Sizeof(ClientEMailHeader));
          New(EMailInfo);
          SafeFillChar(EMailInfo^, SizeOf(TEMailInfo), #0);
          EMailInfo.ClientEMail := ClientEMailHeader;
          if not EMailInfo.ClientEMail.boRead then
            Inc(nCount);

          EMailInfo.sText := '';
          g_EMailList.AddObject(Format('%d%d%.3d',
            [Integer(EMailInfo.ClientEMail.boRead),
            Integer(not EMailInfo.ClientEMail.boSystem),
              EMailInfo.ClientEMail.btTime]), TObject(EMailInfo));
        end;
        g_EMailList.SortString(0, g_EMailList.Count - 1);
        FrmDlg2.DUpDownEMail.MaxPosition := g_EMailList.Count - 5;
        FrmDlg2.DUpDownEMail.Position := 0;
        if nCount > 0 then begin
          DScreen.AddSysMsg('[You have ' + IntToStr(nCount) + ' unread messages.]', clWhite);
          try
            g_Sound.Volume := Round(g_btSoundVolume * 0.8);
            //PlaySoundEx(bmg_NewEMail);
          finally
            g_Sound.Volume := g_btSoundVolume;
          end;
        end;
      end;
    1: begin
        FrmDlg2.EMailSelectTick := 0;
        if Msg.Recog >= 0 then begin
          for I := 0 to g_EMailList.Count - 1 do begin
            EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
            if EMailInfo.ClientEMail.nIdx = Msg.Recog then begin
              body := GetValidStrEx(body, str, ['/']);
              EMailInfo.sText := DecodeString(body);
              EMailInfo.nGold := MakeLong(Msg.Param, Msg.tag);
              if str <> '' then begin
                DecodeItem(str, @EMailInfo.Item.UserItem);
                EMailInfo.Item.s := GetStditem(EMailInfo.Item.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
              end;
              EMailInfo.ClientEMail.boRead := True;
              g_EMailList[i] := Format('%d%d%.3d', [Integer(EMailInfo.ClientEMail.boRead), Integer(not
                  EMailInfo.ClientEMail.boSystem),
                EMailInfo.ClientEMail.btTime]);
              g_EMailList.SortString(0, g_EMailList.Count - 1);
              FrmDLg2.OpenReadMail(EMailInfo);
              break;
            end;
          end;
        end
        else
          FrmDlg.DMessageDlg('Failed to read message...', []);

      end;
    2: begin
        if (msg.Recog < 0) and (msg.recog <> 2) then begin
          if g_SendEMailItem.Item.s.name <> '' then
            AddItemBag(g_SendEMailItem.Item, g_SendEMailItem.Index2);
        end;
        case msg.Recog of
          -1: FrmDlg.DMessageDlg('[Failed]:Message is incomplete.', []);
          -2: FrmDlg.DMessageDlg('[Failed]:Recipient is not your friend.', []);
          -3: FrmDlg.DMessageDlg('[Failed]:Recipient messages are full, can not send.', []);
          -4: FrmDlg.DMessageDlg('[Failed]:System Error!', []);
          -5: FrmDlg.DMessageDlg('[Failed]:Your ' + g_sGoldName + ' is insufficient.', []);
          -6: FrmDlg.DMessageDlg('[Failed to Send]:Items sent through mail are restricted.', []);
          -11: FrmDlg.DMessageDlg('[Failed to Send]:Can only recieve sent items while in safe zone.', []);
          1: FrmDlg.DMessageDlg('Message successfully sent.', []);
          2: begin
              DecodeBuffer(body, @ClientEMailHeader, Sizeof(ClientEMailHeader));
              New(EMailInfo);
              SafeFillChar(EMailInfo^, SizeOf(TEMailInfo), #0);
              EMailInfo.ClientEMail := ClientEMailHeader;
              EMailInfo.sText := '';
              g_EMailList.AddString(Format('%d%d%.3d',
                [Integer(EMailInfo.ClientEMail.boRead),
                Integer(not EMailInfo.ClientEMail.boSystem),
                  EMailInfo.ClientEMail.btTime]), EMailInfo);
              FrmDlg2.DUpDownEMail.MaxPosition := g_EMailList.Count - 5;
              FrmDlg2.DUpDownEMail.Position := 0;
              DScreen.AddSysMsg('[You have a new message!]', clWhite);
              try
                g_Sound.Volume := Round(g_btSoundVolume * 0.8);
                //PlaySoundEx(bmg_NewEMail);
              finally
                g_Sound.Volume := g_btSoundVolume;
              end;
            end;
        end;
        g_SendEMailItem.Item.s.name := '';
      end;
    4: begin
        FrmDlg2.EMailSelectTick := 0;
        if (Msg.Recog >= 0) then begin
          nIndex := MakeLong(Msg.Param, Msg.tag);
          for I := 0 to g_EMailList.Count - 1 do begin
            EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
            if EMailInfo.ClientEMail.nIdx = nIndex then begin
              EMailInfo.nGold := 0;
              if FrmDlg2.ReadEMailInfo.ClientEMail.nIdx = nIndex then
                FrmDlg2.ReadEMailInfo.nGold := 0;
              break;
            end;
          end;
          if Msg.Recog > g_MySelf.m_nGold then begin
            DScreen.AddSysMsg('Received  <CO$FFFF>' + g_sGoldName + ' ' + '<CE>' + IntToStr(Msg.Recog - g_MySelf.m_nGold), GetRGB(70));
          end;
          g_MySelf.m_nGold := Msg.Recog;
          SoundUtil.PlaySound(s_money);
        end
        else begin
          FrmDlg.DMessageDlg('Receive Message ' + g_sGoldName + 'failed...', []);
        end;
      end;
    5: begin
        FrmDlg2.EMailSelectTick := 0;
        if (Msg.Recog >= 0) then begin
          nIndex := Msg.Recog;
          for I := 0 to g_EMailList.Count - 1 do begin
            EMailInfo := pTEMailInfo(g_EMailList.Objects[i]);
            if EMailInfo.ClientEMail.nIdx = nIndex then begin
              AddItemBag(EMailInfo.Item);
              SafeFillChar(EMailInfo.Item, SizeOf(EMailInfo.Item), #0);
              if FrmDlg2.ReadEMailInfo.ClientEMail.nIdx = nIndex then
                SafeFillChar(FrmDlg2.ReadEMailInfo.Item, SizeOf(FrmDlg2.ReadEMailInfo.Item), #0);
              break;
            end;
          end;
        end
        else begin
          FrmDlg.DMessageDlg('Failed to recieve Message Items...', []);
        end;
      end;
  end;
end;

procedure TfrmMain.ClientGetFriendChange(Msg: pTDefaultMessage; body: string);
var
  i: integer;
  sName, sIndex: string;
begin
  case Msg.Series of
    0: begin
        body := DecodeString(body);
        for I := 0 to g_FriendList.Count - 1 do begin
          if CompareText(g_FriendList[i], body) = 0 then begin
            g_FriendList.Objects[i] := TObject(Msg.Param);
            if msg.Param = 1 then
              DScreen.AddSysMsg('Friend [' + body + '] is online.', clWhite)
            else
              DScreen.AddSysMsg('Friend [' + body + '] is offline.', clWhite);
            break;
          end;
        end;
      end;
    1: begin
        body := DecodeString(body);
        while True do begin
          if body = '' then
            break;
          body := GetValidStr3(body, sName, ['/']);
          body := GetValidStr3(body, sIndex, ['/']);
          if (sName <> '') and (sIndex <> '') then begin
            if sIndex = '1' then
              g_FriendList.AddObject(sName, TObject(1))
            else
              g_FriendList.AddObject(sName, nil);
          end;
        end;
      end;
    2: begin
        g_FriendList.AddObject(DecodeString(body), TObject(1));
      end;
    3: begin
        body := DecodeString(body);
        for I := 0 to g_FriendList.Count - 1 do begin
          if CompareText(g_FriendList[i], body) = 0 then begin
            DScreen.AddSysMsg('[<CO$FFFF>' + body + '<CE>]has been removed from friends list.', $32F4);
            g_FriendList.Delete(i);
            break;
          end;
        end;
      end;
  end;
end;

procedure TfrmMain.ClientGetDropItemFail(sindex: Integer);
var
  pc: PTNewClientItem;
begin
  pc := GetDropItem(sindex);
  if pc <> nil then begin
    AddItemBag(pc^);
    DelDropItem(sindex);
  end;
end;

procedure TfrmMain.ClientGetShopItems(Msg: pTDefaultMessage; body: string);
var
  str, sIndex: string;
  ClientShopItem: TClientShopItem;
  cu: pTShopItem;
  i, ii, nIndex: Integer;
  ClientDateTime: TClientDateTime;
  QuickPointList: TQuickPointList;
begin
  ClientDateTime.nInteger := Msg.Recog;
  ClientDateTime.wWord1 := Msg.Param;
  ClientDateTime.wWord2 := MSg.tag;
  g_ShopDateTime := ClientDateTime.DateTime;
  g_ShopLoading[0] := Msg.Series;
  if body <> '' then begin
    for ii := 2 to 5 do begin
      for I := 0 to g_ShopList[ii].Count - 1 do begin
        Dispose(pTShopItem(g_ShopList[ii].Items[i]));
      end;
      g_ShopList[ii].Clear;
    end;
    for i := Low(g_ShopGoldList) to High(g_ShopGoldList) do begin
      g_ShopGoldList[i].Clear;
    end;
    g_ShopList[0].Clear;
    g_ShopList[1].Clear;
    g_ShopBuyItem := nil;
    QuickPointList := TQuickPointList.Create;
    try
      while True do begin
        if body = '' then
          break;
        body := GetValidStr3(body, sIndex, ['/']);
        body := GetValidStr3(body, str, ['/']);
        nIndex := StrToIntDef(sIndex, -1);
        if nIndex = -1 then
          Continue;
        DecodeBuffer(str, @ClientShopItem, sizeof(TClientShopItem));
        New(cu);
        SafeFillChar(cu^, SizeOf(TShopItem), #0);
        cu.nIndex := nIndex;
        cu.CLientItem.s := GetStditem(ClientShopItem.wIdent, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        cu.CLientItem.UserItem.Dura := cu.CLientItem.s.DuraMax;
        cu.CLientItem.UserItem.DuraMax := cu.CLientItem.s.DuraMax;
        cu.CLientItem.UserItem.btBindMode1 := ClientShopItem.btStatus;
        //SetByteStatus(cu.CLientItem.UserItem.btBindMode2, Ib2_Bind, CheckByteStatus(ClientShopItem.btStatus, Ib_NoDown));
        //SetByteStatus(cu.CLientItem.UserItem.btBindMode1, Ib_NoDown, False);
        cu.ClientShopItem := ClientShopItem;
        cu.sHint := GetShopHintList(cu.CLientItem.s.Name);
        if ClientShopItem.btIdx in [0..3] then begin
          g_ShopList[ClientShopItem.btIdx + 2].Add(cu);
          if ClientShopItem.nGoldPrict > 0 then
            g_ShopGoldList[ClientShopItem.btIdx + 2].Add(cu);
          if ClientShopItem.nCount > -1 then begin
            g_ShopList[1].Add(cu);
            if ClientShopItem.nGoldPrict > 0 then
              g_ShopGoldList[1].Add(cu);
          end;
          if ClientShopItem.nSellCount > 0 then begin
            QuickPointList.AddPointer(ClientShopItem.nSellCount, cu, True);
          end;
        end
        else
          Dispose(cu);
      end;
      for I := 0 to QuickPointList.Count - 1 do begin
        g_ShopList[0].Add(QuickPointList.GetPointer(I));
        if pTShopItem(QuickPointList.GetPointer(I)).ClientShopItem.nGoldPrict > 0 then
          g_ShopGoldList[0].Add(QuickPointList.GetPointer(I));
      end;
    finally
      QuickPointList.Free;
    end;
  end;
end;

//掉落物品

procedure TfrmMain.ClientGetShowItem(itemid, X, Y, looks: Integer; itmname: string);
resourcestring
  sTest1 = '[<CO$FFFF>%s<CE>] Appeared at coords [<CO$FFFF>%d:%d<CE>] direction <CO$FFFF>%s<CE>';
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do begin
    if pTDropItem(g_DropedItemList[i]).id = itemid then
      Exit;
  end;
  for i := 0 to g_FreeItemList.count - 1 do begin
    if pTDropItem(g_FreeItemList[i]).id = itemid then
      Exit;
  end;

  new(DropItem);
  DropItem.id := itemid;
  DropItem.X := X;
  DropItem.Y := Y;
  DropItem.looks := looks;
  if (itmName[1] = 'X') then
    DropItem.nColor := clWebGold
  else
    DropItem.nColor := GetRGB(147);
  DropItem.name := AnsiMidStr(itmname,2,999);
  DropItem.FlashTime := FrmMain.m_CurrentTick - LongWord(Random(5000));
  DropItem.BoFlash := FALSE;
  DropItem.Width := g_DXCanvas.TextWidth(DropItem.name) + 2; //
  DropItem.Height := g_DXCanvas.TextHeight(DropItem.name) + 2;
  DropItem.Filtr := GetStditemFiltrate(DropItem.name);
  if itmname = g_sGoldName then begin
    DropItem.Filtr.boPickUp := True;
    DropItem.Filtr.boShow := True;
  end;

  //DropItem.d := nil;
  {DropItem.d := TDXImageTexture.Create(g_DXCanvas);
  DropItem.d.Size := Point(DropItem.Width, DropItem.Height);
  DropItem.d.PatternSize := Point(DropItem.Width, DropItem.Height);
  DropItem.d.Format := D3DFMT_A4R4G4B4;
  DropItem.d.Active := True;
  DropItem.d.Clear;
  DropItem.d.TextOutEx(1, 1, itmname);}
  g_DropedItemList.Add(DropItem);
  {DropItem.d := TDirectDrawSurface.Create(DXDraw.DDraw);
  DropItem.d.SystemMemory := True;
  DropItem.d.SetSize(DropItem.Width, DropItem.Height);
  DropItem.d.Canvas.Font.Name := DEFFONTNAME;
  DropItem.d.Canvas.Font.Size := DEFFONTSIZE;
  DropItem.boColor := DropItem.Filtr.boColor;
  SetBkMode(DropItem.d.Canvas.Handle, TRANSPARENT);
  if DropItem.boColor then
    DropItem.d.Canvas.Font.Color := g_SetupInfo.nItemColor
  else
    DropItem.d.Canvas.Font.Color := GetRGB(147);
  BoldTextOutEx(DropItem.d, 1, 1, DropItem.d.Canvas.Font.Color, $000008, itmname);
  DropItem.d.Canvas.Release;  }

  {if DropItem.Filtr.boHint and (g_MySelf <> nil) then begin
    DScreen.AddSysMsg(Format(sTest1, [itmname, x, y,
      g_WayTag[GetNextDirection(g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, X, Y)]]), clAqua);
  end;   }
end;

procedure TfrmMain.ClientGetHideItem(itemid, pickup: Integer);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do begin
    DropItem := g_DropedItemList[i];
    if DropItem.id = itemid then begin
      DisopseDropItem(DropItem, pickup);
      g_DropedItemList.Delete(i);
      break;
    end;
  end;
end;
{procedure TfrmMain.ClientGetSendAddUseItems(body: string);
var
  Index: Integer;
  str, data: string;
  cu: TClientItem;
begin
  while True do begin
    if body = '' then break;
    body := GetValidStr3(body, str, ['/']);
    body := GetValidStr3(body, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [9..12] then begin
      DecodeBuffer(data, @cu, sizeof(TClientItem));
      g_UseItems[Index] := cu;
    end;
  end;
end;       }

procedure TfrmMain.ClientGetSenduseItems(body: string);
var
  Index: Integer;
  str, data: string;
  cu: TNewClientItem;
begin
  SafeFillChar(g_UseItems, sizeof(g_UseItems), #0);
  //   SafeFillChar (UseItems, sizeof(TClientItem)*9, #0);
  while True do begin
    if body = '' then
      break;
    body := GetValidStr3(body, str, ['/']);
    body := GetValidStr3(body, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [0..MAXUSEITEMS - 1] then begin
      SafeFillChar(cu, SizeOf(TNewClientItem), #0);
      DecodeItem(data, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
      g_UseItems[Index] := cu;
    end;
  end;
end;

procedure TfrmMain.ClientGetMyShopList(Msg: pTDefaultMessage; body: string);
var
  str: string;
  nSellLen, nBuyLen: integer;
  ClientMyShopSellItem: TClientMyShopSellItem;
  ClientMyShopBuyItem: TClientMyShopBuyItem;
begin
  body := GetValidStr3(body, str, ['/']);
  if g_MySelf <> nil then begin
    g_MySelf.m_boShop := True;
    g_MyShopTitle := DecodeString(str);
    g_MySelf.m_sShopTitle := g_MyShopTitle;
    g_MyShopGold := MakeLong(Msg.Param, Msg.tag);
    g_MyShopGameGold := Msg.Recog;
    g_MySelf.m_btShopIdx := LoByte(msg.Series) - 1;
    g_MySelf.m_boShopLeft := HiByte(msg.Series) <> 0;
    if g_MySelf.m_boShopLeft then
      g_MySelf.m_btDir := 1
    else
      g_MySelf.m_btDir := 5;

    g_MySelf.LoadShopTitle();

    SafeFillChar(g_MyReadShopSellItems, SizeOf(g_MyReadShopSellItems), #0);
    SafeFillChar(g_MyReadShopBuyItems, SizeOf(g_MyReadShopBuyItems), #0);

    nSellLen := GetCodeMsgSize(Sizeof(ClientMyShopSellItem) * 4 / 3);
    nBuyLen := GetCodeMsgSize(Sizeof(ClientMyShopBuyItem) * 4 / 3);
    while True do begin
      if body = '' then break;
      body := GetValidStr3(body, str, ['/']);
      if str = '' then break;
      if Length(str) = nSellLen then begin
        DecodeBuffer(str, @ClientMyShopSellItem, sizeof(ClientMyShopSellItem));
        if ClientMyShopSellItem.btIdx in [Low(g_MyShopSellItems)..High(g_MyShopSellItems)] then begin
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].nMoney := ClientMyShopSellItem.nMoney;
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].boGamePoint := ClientMyShopSellItem.boGameGold;
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.UserItem := ClientMyShopSellItem.UserItem;
          g_MyShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopSellItem.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        end;
      end
      else if Length(str) = nBuyLen then begin
        DecodeBuffer(str, @ClientMyShopBuyItem, sizeof(ClientMyShopBuyItem));
        if ClientMyShopBuyItem.btIdx in [Low(g_MyShopBuyItems)..High(g_MyShopBuyItems)] then begin
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].nMoney := ClientMyShopBuyItem.nMoney;
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].boGamePoint := ClientMyShopBuyItem.boGameGold;
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.wIndex := ClientMyShopBuyItem.wIdent;
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopBuyItem.wIdent, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.DuraMax :=
            g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
          if (sm_Superposition in g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.StdModeEx) and
            (g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax > 1) then begin
            g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura := ClientMyShopBuyItem.wCount;
          end
          else
            g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura :=
              g_MyShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientGetUserShopList(Msg: pTDefaultMessage; body: string);
var
  Actor: TActor;
  str: string;
  nSellLen, nBuyLen: integer;
  ClientMyShopSellItem: TClientMyShopSellItem;
  ClientMyShopBuyItem: TClientMyShopBuyItem;
begin
  SafeFillChar(g_MyReadShopSellItems, SizeOf(g_MyReadShopSellItems), #0);
  SafeFillChar(g_MyReadShopBuyItems, SizeOf(g_MyReadShopBuyItems), #0);
  Actor := Playscene.FindActor(Msg.Recog);
  if Actor <> nil then begin
    FrmDlg2.UserShopID := msg.Recog;
    g_MyReadTitle := Actor.m_UserName + ' Stall';
    nSellLen := GetCodeMsgSize(Sizeof(ClientMyShopSellItem) * 4 / 3);
    nBuyLen := GetCodeMsgSize(Sizeof(ClientMyShopBuyItem) * 4 / 3);
    while True do begin
      if body = '' then
        break;
      body := GetValidStr3(body, str, ['/']);
      if str = '' then
        break;
      if Length(str) = nSellLen then begin
        DecodeBuffer(str, @ClientMyShopSellItem, sizeof(ClientMyShopSellItem));
        if ClientMyShopSellItem.btIdx in [Low(g_MyReadShopSellItems)..High(g_MyReadShopSellItems)] then begin
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].nMoney := ClientMyShopSellItem.nMoney;
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].boGamePoint := ClientMyShopSellItem.boGameGold;
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.UserItem := ClientMyShopSellItem.UserItem;
          g_MyReadShopSellItems[ClientMyShopSellItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopSellItem.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        end;
      end
      else if Length(str) = nBuyLen then begin
        DecodeBuffer(str, @ClientMyShopBuyItem, sizeof(ClientMyShopBuyItem));
        if ClientMyShopBuyItem.btIdx in [Low(g_MyReadShopBuyItems)..High(g_MyReadShopBuyItems)] then begin
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].nMoney := ClientMyShopBuyItem.nMoney;
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].boGamePoint := ClientMyShopBuyItem.boGameGold;
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.wIndex := ClientMyShopBuyItem.wIdent;
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s := GetStditem(ClientMyShopBuyItem.wIdent, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.DuraMax :=
            g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
          if (sm_Superposition in g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.StdModeEx) and
            (g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax > 1) then begin
            g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura := ClientMyShopBuyItem.wCount;
          end
          else
            g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.UserItem.Dura :=
              g_MyReadShopBuyItems[ClientMyShopBuyItem.btIdx].ShopItem.Item.s.DuraMax;
        end;
      end;
    end;
    g_nMyReadShopDlgID := msg.Recog;
    g_nMyReadShopDlgX := Msg.Param;
    g_nMyReadShopDlgY := Msg.tag;
    FrmDlg2.DReadShopMemo.Lines.Clear;
    FrmDlg2.DReadUserShop.Visible := True;
  end;
end;

procedure TfrmMain.ClientOpenBox(Msg: pTDefaultMessage; body: string);
var
  ClientBoxInfo: TClientBoxInfo;
  I: Integer;
begin
  SafeFillChar(ClientBoxInfo, Sizeof(ClientBoxInfo), #0);
  DecodeBuffer(body, @ClientBoxInfo, sizeof(ClientBoxInfo));
  with FrmDlg3 do begin
    OpenBoxGold := Msg.Recog;
    OpenBoxGameGold := MakeLong(Msg.Param, Msg.tag);
    OpenBoxIndex := Msg.Series;
    OpenBoxSelectIndex := 0;
    OpenGetItemIndex := 0;
    OpenBoxMove := False;
    OpenGetItem := False;
    dbtnBoxNext.Caption := 'Turn';
    dbtnBoxGetItem.Caption := 'Recieve';
    OpenBoxStop := False;
    SafeFillChar(OpenBoxItems, Sizeof(OpenBoxItems), #0);
    for I := Low(ClientBoxInfo.Normal) to High(ClientBoxInfo.Normal) do begin
      OpenBoxItems[I].ItemType := ClientBoxInfo.Normal[I].ItemType;
      OpenBoxItems[I].Item.UserItem := ClientBoxInfo.Normal[I].Item;
      case OpenBoxItems[I].ItemType of
        bit_Item: begin
            OpenBoxItems[I].Item.s := GetStditem(ClientBoxInfo.Normal[I].Item.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          end; 
      end;
    end;
    for I := Low(ClientBoxInfo.Peculiar) to High(ClientBoxInfo.Peculiar) do begin
      OpenBoxItems[I + 9].ItemType := ClientBoxInfo.Peculiar[I].ItemType;
      OpenBoxItems[I + 9].Item.UserItem := ClientBoxInfo.Peculiar[I].Item;
      case OpenBoxItems[I + 9].ItemType of
        bit_Item: begin
            OpenBoxItems[I + 9].Item.s := GetStditem(ClientBoxInfo.Peculiar[I].Item.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          end; 
      end;
    end;
    dwndBox.Visible := True;
  end;
end;

procedure TfrmMain.ClientGetSetIcon(DefMsg: pTDefaultMessage; body: string);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) and (body <> '') then
  begin
    DecodeBuffer(body, @Actor.m_IconInfo[0], SizeOf(TIconInfos));
    SafeFillChar(Actor.m_IconInfoShow[0], SizeOf(TIconInfoShows), #0);
  end;
end;

procedure TfrmMain.ClientGetHumLook(DefMsg: pTDefaultMessage);
var
  Actor: TActor;
begin
  Actor := PlayScene.FindActor(DefMsg.Recog);
  if (Actor <> nil) then
    Actor.m_nWeaponEffect := LoByte(DefMsg.Param);
end;

procedure TfrmMain.ClientGetAddMagic(body: string);
var
  ClientMagic: TClientMagic;
begin
  SafeFillChar(ClientMagic, Sizeof(ClientMagic), #0);
  DecodeBuffer(body, @ClientMagic, sizeof(ClientMagic));
  if ClientMagic.btMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
    g_MyMagicArry[ClientMagic.btMagID].boStudy := True;
    g_MyMagicArry[ClientMagic.btMagID].Level := ClientMagic.Level;
    g_MyMagicArry[ClientMagic.btMagID].CurTrain := ClientMagic.CurTrain;
    g_MyMagicArry[ClientMagic.btMagID].btKey := ClientMagic.btKey;
    g_MyMagicArry[ClientMagic.btMagID].dwInterval := 0;
    g_MyMagicArry[ClientMagic.btMagID].boUse := False;
    g_MyMagicArry[ClientMagic.btMagID].Def := GetMagicInfo(ClientMagic.btMagID);
    if ClientMagic.btMagID <> 100 then begin
      if (ClientMagic.btMagID in [110..121]) then
        FrmDlg.MagicList2.AddObject(' ', TObject(ClientMagic.btMagID))
      else
        FrmDlg.MagicList1.AddObject(' ', TObject(ClientMagic.btMagID));
    end;
  end;
end;

procedure TfrmMain.ClientGetDelMagic(magid: Integer);
var
  I: integer;
begin
  if magid in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
    SafeFillChar(g_MyMagicArry[magid], SizeOf(g_MyMagicArry[magid]), #0);
  end;
    if (magid in [110..121]) then begin
      for I := FrmDlg.MagicList2.Count - 1 downto 0 do begin
        if Integer(FrmDlg.MagicList2.Objects[I]) = magid then
          FrmDlg.MagicList2.Delete(I);
      end;
    end
    else begin
      for I := FrmDlg.MagicList1.Count - 1 downto 0 do begin
        if Integer(FrmDlg.MagicList1.Objects[I]) = magid then
          FrmDlg.MagicList1.Delete(I);
      end;
    end;
end;

procedure TfrmMain.ClientGetMyMagics(body: string);
var
  data: string;
  ClientMagic: TClientMagic;
begin
  SafeFillChar(g_MyMagicArry, SizeOf(g_MyMagicArry), #0);
  FrmDlg.MagicList2.Clear;
  FrmDlg.MagicList1.Clear;
  while True do begin
    if body = '' then
      break;
    body := GetValidStr3(body, data, ['/']);
    if data <> '' then begin
      SafeFillChar(ClientMagic, Sizeof(ClientMagic), #0);
      DecodeBuffer(data, @ClientMagic, sizeof(ClientMagic));
      if ClientMagic.btMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
        g_MyMagicArry[ClientMagic.btMagID].boStudy := True;
        g_MyMagicArry[ClientMagic.btMagID].Level := ClientMagic.Level;
        g_MyMagicArry[ClientMagic.btMagID].CurTrain := ClientMagic.CurTrain;
        g_MyMagicArry[ClientMagic.btMagID].btKey := ClientMagic.btKey;
        if ClientMagic.dwInterval > 0 then begin
          SetMagicUse(ClientMagic.btMagID);
          g_MyMagicArry[ClientMagic.btMagID].dwInterval := FrmMain.m_CurrentTick + ClientMagic.dwInterval;
        end else begin
          g_MyMagicArry[ClientMagic.btMagID].dwInterval := 0;
          g_MyMagicArry[ClientMagic.btMagID].boUse := False;
        end;
        g_MyMagicArry[ClientMagic.btMagID].Def := GetMagicInfo(ClientMagic.btMagID);
        if ClientMagic.btMagID <> 100 then begin
          if (ClientMagic.btMagID in [110..121]) then
            FrmDlg.MagicList2.AddObject(' ', TObject(ClientMagic.btMagID))
          else
            FrmDlg.MagicList1.AddObject(' ', TObject(ClientMagic.btMagID));
        end;
      end;
    end
    else
      break;
  end;
  FrmDlg.MagicPage := 0;
  FrmDlg.MagicMaxPage := 0;
end;



procedure TfrmMain.ClientGetMagicLvExp(magid, maglv, magtrain: Integer);
begin
  if magid in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
    g_MyMagicArry[magid].Level := maglv;
    g_MyMagicArry[magid].CurTrain := magtrain;
  end;
end;

procedure TfrmMain.ClientGetDuraChange(uidx, newdura, newduramax, nPic:
  Integer);
begin
  if uidx in [0..MAXUSEITEMS - 1] then begin
    if g_UseItems[uidx].S.name <> '' then begin
      g_UseItems[uidx].UserItem.Dura := newdura;
      g_UseItems[uidx].UserItem.DuraMax := newduramax;
    end;
  end else
  if uidx in [16..20] then begin
    if g_UseItems[U_House].S.name <> '' then begin
      g_UseItems[U_House].UserItem.HorseItems[uidx - 16].Dura := newdura;
    end;
  end;
end;

procedure TfrmMain.ClientGetMerchantSay(merchant, nResID, nWidth, nHeight: Integer; saying:
  string);
var
  npcname: string;
begin
  g_nMDlgX := g_MySelf.m_nCurrX;
  g_nMDlgY := g_MySelf.m_nCurrY;
  if g_nCurMerchant <> merchant then begin
    g_nCurMerchant := merchant;
    FrmDlg.CloseMDlg;
    g_boAllowAuction := False;
  end;
  //   ShowMessage(saying);
  saying := GetValidStr3(saying, npcname, ['/']);
  FrmDlg.ShowMDlg(nResID, nWidth, nHeight, npcname, saying);
end;

procedure TfrmMain.ClientGetSendReturnItemList(body: string);
var
  cu: pTNewClientItem;
  TempStr: string;
begin
  with FrmDlg do begin
    ClearReturnItemList();
    while body <> '' do begin
      body := GetValidStr3(body, TempStr, ['/']);
      if TempStr = '' then
        Continue;
      New(cu);
      SafeFillChar(cu^, SizeOf(TNewClientItem), #0);
      DecodeItem(TempStr, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
      NpcReturnItemList.Add(cu);
    end;
  end;
end;

procedure TfrmMain.ClientGetSendGoodsList(merchant, count, nFlag, nRate: Integer; body: string);
var
  TempStr: string;
  pcg: PTClientGoods;
  pc: TUserGoods;
begin
  FrmDlg.ClearGoodsList;
  g_nCurMerchant := merchant;
  g_nCurMerFlag := nFlag;
  g_nCurMerRate := nRate;
  with FrmDlg do begin
    NpcBindGold := count = 1;
    while body <> '' do begin
      body := GetValidStr3(body, TempStr, ['/']);
      if TempStr = '' then
        Continue;
      new(pcg);
      SafeFillChar(pcg^, SizeOf(TClientGoods), #0);
      DecodeBuffer(TempStr, @pc, SizeOf(TUserGoods));
      pcg.btIdx := pc.btIdx;
      pcg.nItemPic := pc.nItemPic;
      pcg.nStock := pc.nStock;
      pcg.ClientItem.s := GetStditem(pc.nItemIdx, g_Myself.m_Abil.Level, g_Myself.m_btJob);
      pcg.ClientItem.UserItem.wIndex := pc.nItemIdx;
      pcg.ClientItem.UserItem.Dura := pcg.ClientItem.s.DuraMax;
      pcg.ClientItem.UserItem.DuraMax := pcg.ClientItem.s.DuraMax;
      NpcGoodsList.Add(pcg);
    end;
    RefGoodItems;
    if count in[0..4] then  //opens bag for repair?
      DMenuDlg.Visible := True;
    if not NpcReturn then begin
      NpcReturn := True;
      SendClientMessage(CM_QUERYRETURNITEMS, 0, 0, 0, 0, '');
    end;
    if DMenuDlg.Visible then begin
       DSaleDlg.Top := DMenuDlg.Top + DMenuDlg.Height + 1;
       DSaleDlg.Left := DMenuDlg.Left + DMenuDlg.Width - DSaleDlg.Width;
    end else begin
      DSaleDlg.Top := DMerchantDlg.Top + DMerchantDlg.Height + 1;
      DSaleDlg.Left := DMerchantDlg.Left + DMerchantDlg.Width - DSaleDlg.Width;
    end;
    case count of
      0, 1: DMenuSellClick(DMenuBuy, 0, 0);
      2: DMenuSellClick(DMenuSell, 0, 0);
      3: DMenuSellClick(DMenuRepair, 0, 0);
      4: DMenuSellClick(DMenuSuperRepair, 0, 0);
    end;
    RefMenuSellBtns();
  end;
end;

procedure TfrmMain.ClientGetSubList(body: string; nindex, ncount: Integer);
var
  str: string;
  cu: TNewClientItem;
  i: integer;
begin
  SetLength(FrmDlg.NpcSubItems, ncount);
  i:= 0;
  FrmDlg.nSubshopSelectionIdx := -1;
  FrmDlg.nSubShopIndex := nindex;
  while True do begin
    if body = '' then
      break;
    body := GetValidStr3(body, str, ['/']);

    SafeFillChar(cu, SizeOf(TNewClientItem), #0);
    DecodeItem(str, @cu.UserItem);
    cu.s := GetStditem(cu.UserItem.wIndex,g_Myself.m_Abil.Level, g_Myself.m_btJob);
    FrmDlg.NpcSubItems[i] := cu;
    inc(i);
    if (i > Length(FrmDlg.NpcSubItems) -1) then break;
  end;
  FrmDlg.DSubShopUpDown.Position := 0;
  FrmDlg.DSubShopUpDown.MaxPosition := (High(FrmDlg.NpcSubItems) - FrmDlg.DSubShopGrid.RowCount + 1) div FrmDlg.DSubShopGrid.ColCount;
  FrmDlg.DSubShop.Visible := true;
end;

procedure TfrmMain.ClientGetAbilityMoveSet(body: string);
begin
  DecodeBuffer(body, PAnsiChar(@g_AbilityMoveSet), SizeOf(TAbilityMoveSet));
end;

procedure TfrmMain.ClientGetCompoundInfos(body: string);
var
  i: Integer;
  sMsg, sItemName: string;
  pCompoundInfos: pTCompoundInfos;
begin
  for i := 0 to g_CompoundInfoList.Count - 1 do
    Dispose(pTCompoundInfos(g_CompoundInfoList.Objects[i]));
  g_CompoundInfoList.Clear;
  body := GetValidStr3(body, sMsg, ['/']);
  DecodeBuffer(sMsg, PAnsiChar(@g_CompoundSet), SizeOf(TCompoundSet));
  while body <> '' do begin
    body := GetValidStr3(body, sItemName, ['/']);
    body := GetValidStr3(body, sMsg, ['/']);
    sItemName := DecodeString(sItemName);
    if (sItemName = '') or (sMsg = '') then
      Continue;
    New(pCompoundInfos);
    ZeroMemory(pCompoundInfos, SizeOf(TCompoundInfos));
    DecodeBuffer(sMsg, PAnsiChar(pCompoundInfos), SizeOf(TCompoundInfos));
    g_CompoundInfoList.AddObject(sItemName, TObject(pCompoundInfos));
  end;
end;

procedure TfrmMain.ClientGetHintDataList(Msg: pTDefaultMessage; body: string);
var
  OutLen: integer;
  Buffer, OutBuffer: PChar;
begin
  if body <> '' then begin
    GetMem(Buffer, Msg.Recog);
    Try
      DecodeBuffer(body, Buffer, Msg.Recog);
      OutLen := ZIPDecompress(Buffer, Msg.Recog, 0, OutBuffer);
      if (OutLen > 0) then begin
        g_OperateHintList.Clear;
        g_OperateHintList.SetText(OutBuffer);
        g_nOperateHintIdx := Random(g_OperateHintList.Count);
        g_dwOperateHintTick := FrmMain.m_CurrentTick;
        FreeMem(OutBuffer);
      end;
    Finally
      FreeMem(Buffer);
    End;
  end;
end;

procedure TfrmMain.ClientGetSendMakeDrugList(Msg: pTDefaultMessage; body: string);
var
  sName, sItem: string;
  ClientMakeGoods: pTClientMakeGoods;
  DTreeNodes, DTreeNodes2: pTDTreeNodes;
  i, ii, OutLen: integer;
  Buffer, OutBuffer: PChar;
  NameStr: string;
  MakeItem: array of TMakeItem;
begin
  sItem := GetValidStr3(body, sName, ['/']);
  NameStr := '';
  MakeItem := nil;
  if (sName <> '') and (sItem <> '') then begin
    GetMem(Buffer, Msg.Series);
    DecodeBuffer(sName, Buffer, Msg.Series);
    OutLen := ZIPDecompress(Buffer, Msg.Series, 0, OutBuffer);
    if (OutLen > 0) then begin
      SetLength(NameStr, OutLen);
      Move(OutBuffer^, NameStr[1], OutLen);
      FreeMem(OutBuffer);
    end;
    FreeMem(Buffer);
    GetMem(Buffer, Msg.tag);
    DecodeBuffer(sItem, Buffer, Msg.tag);
    OutLen := ZIPDecompress(Buffer, Msg.tag, 0, OutBuffer);
    if (OutLen > 0) then begin
      if OutLen = (Msg.Param * SizeOf(TMakeItem)) then begin
        SetLength(MakeItem, Msg.Param);
        Move(OutBuffer^, MakeItem[0], OutLen);
      end;
      FreeMem(OutBuffer);
    end;
    FreeMem(Buffer);
  end;
  FrmDlg.LastestClickTime := FrmMain.m_CurrentTick;
  FrmDlg3.DMakeItemTreeView.ClearItem;
  if (NameStr <> '') and (MakeItem <> nil) then begin
    for II := Low(MakeItem) to High(MakeItem) do begin
      NameStr := GetValidStr3(NameStr, sName, ['/']);
      New(ClientMakeGoods);
      SafeFillChar(ClientMakeGoods^, SizeOf(TClientMakeGoods), #0);
      ClientMakeGoods.nID := MakeItem[II].wIdx;
      ClientMakeGoods.btLevel := 0;
      ClientMakeGoods.wLevel := 0;
      ClientMakeGoods.MakeItem := MakeItem[II];
      for I := 0 to 5 do begin
        ClientMakeGoods.Item[I].s := GetStditem(ClientMakeGoods.MakeItem.ItemArr[I].wIdent, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        ClientMakeGoods.Item[I].UserItem.wIndex := ClientMakeGoods.Item[I].s.Idx + 1;
        ClientMakeGoods.Item[I].UserItem.DuraMax := ClientMakeGoods.Item[I].s.DuraMax;
        if (sm_Superposition in ClientMakeGoods.Item[I].s.StdModeEx) and
          (ClientMakeGoods.Item[I].s.DuraMax > 1) then
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.MakeItem.ItemArr[I].wCount
        else if (ClientMakeGoods.Item[i].s.StdMode = tm_ore) then
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.MakeItem.ItemArr[I].wCount * 1000
        else
          ClientMakeGoods.Item[I].UserItem.Dura := ClientMakeGoods.Item[I].s.DuraMax;
        if (I = 0) and (sm_ArmingStrong in ClientMakeGoods.Item[I].s.StdModeEx) then begin
          SetByteStatus(ClientMakeGoods.Item[I].UserItem.btBindMode2, Ib2_Unknown, True);
        end;

      end;
      DTreeNodes := nil;
      with FrmDlg3 do begin
        while True do begin
          if sName = '' then break;
          sName := GetValidStrCap(sName, sItem, [' ', #9]);
          if sItem = '' then break;
          if sItem[1] = '$' then begin
            DTreeNodes := DMakeItemTreeView.GetTreeNodes(DTreeNodes, Copy(sItem, 2, length(sItem) - 1), True);
          end
          else begin
            DTreeNodes2 := DMakeItemTreeView.NewTreeNodes(sitem);
            DTreeNodes2.Item := ClientMakeGoods;
            DTreeNodes.ItemList.Add(DTreeNodes2);
            ClientMakeGoods := nil;
            break;
          end;
        end;
      end;
      if ClientMakeGoods <> nil then
        Dispose(ClientMakeGoods);
    end;
    FrmDlg3.FMakeMagicShow := False;
    FrmDlg3.DMakeItemTreeView.RefHeight;
    FrmDlg3.DWndMakeItem.Visible := True;
  end;
end;

procedure TfrmMain.ClientGetRegInfo(Msg: pTDefaultMessage; body: string);
begin
  //DecodeBuffer(body, @g_RegInfo, sizeof(TRegInfo));
end;

procedure TfrmMain.ClientGetRenewHum(Msg: pTDefaultMessage; Body: string);
var
  I: integer;
  {sID, }str, uname, sjob, { shair, } slevel, ssex, swuxin {, swuxinlevel}: string;
begin
  if Msg.Recog > 0 then begin
    with SelectChrScene do begin
      SafeFillChar(RenewChr, SizeOf(RenewChr), #0);
      str := DecodeString(body);
      for I := 0 to Msg.Recog - 1 do begin
        if I >= High(RenewChr) then
          break;
        //str := GetValidStr3(str, sID, ['/']);
        str := GetValidStr3(str, uname, ['/']);
        str := GetValidStr3(str, sjob, ['/']);
        str := GetValidStr3(str, slevel, ['/']);
        str := GetValidStr3(str, ssex, ['/']);
        //str := GetValidStr3(str, shair, ['/']);
        str := GetValidStr3(str, swuxin, ['/']);
        //str := GetValidStr3(str, swuxinlevel, ['/']);
        if (uname <> '') and (slevel <> '') and (swuxin <> '') then begin
          //RenewChr[I].ID := StrToIntDef(sID, 0);
          RenewChr[I].Name := uname;
          RenewChr[I].Job := StrToIntDef(sJob, 0);
          //RenewChr[I].Hair := StrToIntDef(shair, 0);
          RenewChr[I].Level := StrToIntDef(sLevel, 0);
          RenewChr[I].Sex := StrToIntDef(ssex, 0);
          RenewChr[i].WuXin := StrToIntDef(swuxin, 0);
          //RenewChr[i].WuXinLevel := StrToIntDef(swuxinlevel, 0);
        end;
        //FrmDlg.DRenewChr.Left := 30;
        //FrmDlg.DRenewChr.Top := 0;
        //FrmDlg.DRenewChr.Visible := True;
        DScreen.ChangeScene(stSelectChr);
        SelectChrScene.ChangeSelectChrState(scRenewChr);
      end;
    end;
  end
  else begin
    FrmDlg.HintBack := stSelectChr;
    FrmDlg.sHintStr := 'Not found deleted character...';
    FrmDlg.DBTHintClose.Caption := 'Return';
    FrmDlg.boHintFocus := True;
  end;
  //FrmDlg.DMessageDlg('[失败] 没有找到被删除的角色。', [mbOK]);
end;

procedure TfrmMain.ClientGetSaveItemList(Msg: pTDefaultMessage; bodystr: string);
var
  data, sidx: string;
  cu: TNewClientItem;
begin
  if msg.Recog in [Low(g_StorageArr)..High(g_StorageArr)] then begin
    g_boStorageRead[msg.Recog] := True;
    g_StorageArrList[msg.Recog].Clear;
    SafeFillChar(g_StorageArr[msg.Recog][0], SizeOf(g_StorageArr[msg.Recog]), #0);
    while True do begin
      if bodystr = '' then
        break;
      bodystr := GetValidStr3(bodystr, sidx, ['/']);
      bodystr := GetValidStr3(bodystr, data, ['/']);
      if data = '' then break;
      SafeFillChar(cu, SizeOf(cu), #0);
      DecodeItem(data, @cu.UserItem);
      cu.s := GetStditem(cu.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
      AddItemStorage(@cu, msg.Recog, StrToIntDef(sidx, -1));
    end;
    if g_StorageArrList[msg.Recog].Count <> msg.Series then begin
      g_boStorageRead[msg.Recog] := False;
      g_StorageArrList[msg.Recog].Clear;
      SafeFillChar(g_StorageArr[msg.Recog][0], SizeOf(g_StorageArr[msg.Recog]), #0);
    end;
    FrmDlg2.DStorageDlg.AppendTick := 0;
  end;
end;

procedure TfrmMain.ClientGetSayItem(Msg: TDefaultMessage; sBody: string);
var
  pc: TNewClientItem;
  i, II: integer;
  ClickItem: pTClickItem;
  pMessage: pTSayMessage;
begin
  {for I := 0 to g_GetSayItemList.Count - 1 do begin
    if Msg.Recog = pTNewClientItem(g_GetSayItemList[i]).UserItem.MakeIndex then
      exit;
  end;    }
  //new(pc);
  SafeFillChar(pc, SizeOf(TNewClientItem), #0);
  DecodeItem(sBody, @pc.UserItem);
  pc.s := GetStditem(pc.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
  //g_GetSayItemList.Add(pc);
  with FrmDlg, DScreen do begin
    OpenSayItemShow(pc);
    for I := 0 to m_NewSayMsgList.Count - 1 do begin
      pMessage := m_NewSayMsgList[I];
      if (pMessage.ItemList <> nil) and (pMessage.ItemList.Count > 0) then begin
        for ii := 0 to pMessage.ItemList.Count - 1 do begin
          ClickItem := pMessage.ItemList[ii];
          if (ClickItem.ItemIndex = msg.Recog) and (ClickItem.nIndex = msg.Param) then begin
            ClickItem.pc := pc;
            Exit;
          end;
        end;
      end;
    end;
  end;

end;

procedure TfrmMain.ClientGetSayMsg(Msg: TDefaultMessage; sBody: string);
  function FormatSayStr(sMsg: string; var UserName: string; boSys: Boolean): string;
  var
    sTemp, sFilterText: string;
    I: Integer;
  begin
    UserName := '';
    if Pos(#9, sMsg) > 0 then begin
      sTemp := GetValidStr3(sMsg, UserName, [#9]);
      for I := 0 to g_FilterMsgList.Count -1 do begin
        sFilterText := g_FilterMsgList[I];
        if AnsiContainsText(sTemp, sFilterText) then begin
          sTemp := AnsiReplaceText(sTemp, sFilterText, '*');
        end;
      end;
      //if sTemp <> '' then begin
      if Msg.Ident = SM_WHISPER then begin
        {if sTemp[1] = ' ' then
          sMsg := #7 + UserName + #7 + '悄悄对'#6'2450FF/8'#6'你'#5'说:' + sTemp
        else
          sMsg := #7 + UserName + #7 + '悄悄对'#6'2450FF/8'#6'你'#5'说: ' + sTemp;  }
        if (sTemp <> '') and (sTemp[1] = ' ') then
          sMsg := #7 + UserName + #7 + ': ' + sTemp
        else
          sMsg := #7 + UserName + #7 + ': ' + sTemp;
      end
      else begin
        if (sTemp <> '') and (sTemp[1] = ' ') then
          sMsg := #7 + UserName + #7 + ': ' + sTemp
        else
          sMsg := #7 + UserName + #7 + ': ' + sTemp;
      end;
      //end;
    end;
    Result := sMsg;
  end;
var
  FColor, BColor: TColor;
  boSys: Boolean;
  Actor: TActor;
  UserName: string;
  idx: integer;
  UserSayType: TUserSayType;
begin
  if sbody = '' then
    Exit;
  if Msg.Ident <> SM_SYSMESSAGE then begin
    sbody := AnsiReplaceText(sbody, #6, '');
    sbody := AnsiReplaceText(sbody, #7, '');
    sbody := AnsiReplaceText(sbody, #5, '');
    sbody := AnsiReplaceText(sbody, #4, '');
  end;{ else
    DScreen.AddSysMsg(sbody, clWhite);  }

  sbody := FormatSayStr(sbody, UserName, Msg.Ident = SM_SYSMESSAGE);

  FColor := GetRGB(msg.Param);
  BColor := GetRGB(msg.tag);

  boSys := False;
  idx := g_MyBlacklist.IndexOf(UserName);
  case Msg.Ident of
    SM_HEAR: begin
        if idx > -1 then exit;
        Actor := PlayScene.FindActor(Msg.Recog);
        if Actor <> nil then
          Actor.Say(sbody);
        UserSayType := us_Hear;
      end;
    SM_CRY: begin
        if idx > -1 then exit;
        UserSayType := us_Cry;
      end;
    SM_GROUPMESSAGE: begin
        if idx > -1 then exit;
        UserSayType := us_Group;
      end;
    SM_GUILDMESSAGE: begin
        if idx > -1 then exit;
        UserSayType := us_Guild;
      end;
    SM_WHISPER: begin
        if idx > -1 then exit;
        idx := g_MyWhisperList.IndexOf(UserName);
        if idx <> -1 then
          g_MyWhisperList.Delete(idx);
        g_MyWhisperList.Insert(0, UserName);
        UserSayType := us_Whisper;
      end;
    SM_SYSMESSAGE: begin
        FrmDlg.DBTAttackMode.Tag := Msg.Series;
        sbody := AnsiReplaceText(sbody, '#5', #5);
        sbody := AnsiReplaceText(sbody, '#6', #6);
        sbody := AnsiReplaceText(sbody, '#7', #7);
        sbody := AnsiReplaceText(sbody, '#4', ' ');
        boSys := True;
        UserSayType := us_Sys;
      end;
    SM_BUGLE: begin
        if idx > -1 then exit;
        UserSayType := us_Cry;
      end;
    else exit;
  end;
  DScreen.AddSayMsg(sbody, FColor, BColor, boSys, UserSayType);
end;

procedure TfrmMain.ClientFilterInfo(Msg: TDefaultMessage; bodystr: string);
var
  OutLen: Integer;
  OutBuffer: PChar;
  MemoryStream: TMemoryStream;
begin
  g_FilterMsgList.Clear;
  if Msg.Recog > 0 then begin
    MemoryStream := TMemoryStream.Create;
    Try
      MemoryStream.Size := Msg.Recog;
      DecodeLongBuffer(bodystr, MemoryStream.Memory, Msg.Recog);
      OutLen := ZIPDecompress(MemoryStream.Memory, Msg.Recog, 0, OutBuffer);
      if (OutLen > 0) then begin
        MemoryStream.Size := OutLen;
        MemoryStream.Position := 0;
        MemoryStream.Write(OutBuffer^, OutLen);
        MemoryStream.Position := 0;
        FreeMem(OutBuffer);
        g_FilterMsgList.LoadFromStream(MemoryStream);
      end;
    Finally
      MemoryStream.Free;
    End;
  end;
    //OutLen := ZIPDecompress(Buffer, BufferLen, 0, OutBuffer);

end;

procedure TfrmMain.ClientGetDataFile(Msg: TDefaultMessage; bodystr: string);
  procedure Decompress(nIndex: Integer; Buffer: PChar; BufferLen: Integer);
  var
    OutLen: Integer;
    OutBuffer: PChar;
    LoadList: TStringList;
    MemoryStream: TMemoryStream;
  begin
    if BufferLen <= 0 then Exit;
    OutLen := ZIPDecompress(Buffer, BufferLen, 0, OutBuffer);
    if (OutLen > 0) then begin
      MemoryStream := TMemoryStream.Create;
      MemoryStream.Write(OutBuffer^, OutLen);
      MemoryStream.Position := 0;
      case nIndex of
        1: begin
            LoadList := TStringList.Create;
            LoadList.LoadFromStream(MemoryStream);
            LoadMissionList(LoadList);
            LoadList.Free;
          end;
        2: LoadStditemList(MemoryStream);
        3: LoadMagicList(MemoryStream);
        4: begin
            LoadList := TStringList.Create;
            LoadList.LoadFromStream(MemoryStream);
            LoadMapDescList(LoadList);
            LoadList.Free;
          end;
        5: LoadMakeMagicList(MemoryStream);
        6: begin
          g_BadAppsList.Clear;
          g_BadAppsList.LoadFromStream(MemoryStream);
        end;
      end;
      MemoryStream.Free;
      FreeMem(OutBuffer);
    end;
  end;
var
  MemoryStream: TMemoryStream;
begin  
  case Msg.Series of
    0: begin
        if not g_boAllLoadStream then begin
          Decompress(1, g_MissionDateStream.Memory, g_MissionDateStream.Size);
          Decompress(2, g_StditemsDateStream.Memory, g_StditemsDateStream.Size);
          Decompress(3, g_MagicDateStream.Memory, g_MagicDateStream.Size);
          Decompress(4, g_MapDescDateStream.Memory, g_MapDescDateStream.Size);
          Decompress(5, g_MakeMagicDateStream.Memory, g_MakeMagicDateStream.Size);
        end;
        g_boAllLoadStream := True;
        SendClientMessage(CM_LOGINNOTICEOK, 0, 0, 0, 0);
      end;
    1..6: begin
        case Msg.Series of
          1: MemoryStream := g_MissionDateStream;
          2: MemoryStream := g_StditemsDateStream;
          3: MemoryStream := g_MagicDateStream;
          4: MemoryStream := g_MapDescDateStream;
          5: MemoryStream := g_MakeMagicDateStream;
          6: MemoryStream := g_BannedAppsDataStream;
          else MemoryStream := nil;
        end;
        if Msg.Recog > 0 then begin
          MemoryStream.Size := Msg.Recog;
          DecodeLongBuffer(bodystr, MemoryStream.Memory, Msg.Recog);
          if g_boAllLoadStream and (msg.series <> 6) then Decompress(Msg.Series, MemoryStream.Memory, Msg.Recog);
        end else begin
          MemoryStream.Clear;
        end;
        if Msg.Series = 6 then //since this is send late, it wont decompress otherwise
          Decompress(6, g_BannedAppsDataStream.Memory, g_BannedAppsDataStream.Size);    
    end;
  end;
end;

procedure TfrmMain.ClientGetSendNotice(body: string);
{var
  data, msgstr: string;  }
var
  MissionMD5: string;
begin
  {g_boDoFastFadeOut := FALSE;
  msgstr := '';
  body := DecodeString(body);
  while True do begin
    if body = '' then
      break;
    body := GetValidStr3(body, data, [#27]);
    msgstr := msgstr + data + '\';
  end;
  FrmDlg.DialogSize := 2;
  if FrmDlg.DMessageDlg(msgstr, [mbOk]) = mrOk then begin }
  {MissionMD5 := FileToMD5Text(GETMISSIONDESCFILE) + #9;
  MissionMD5 := MissionMD5 + FileToMD5Text(GETSTDITEMSDESCFILE) + #9;
  MissionMD5 := MissionMD5 + FileToMD5Text(GETMAGICDESCFILE) + #9;
  MissionMD5 := MissionMD5 + FileToMD5Text(GETMAPDESCFILE) + #9; }
  MissionMD5 := GetMD5TextByBuffer(g_MissionDateStream.Memory, g_MissionDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_StditemsDateStream.Memory, g_StditemsDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_MagicDateStream.Memory, g_MagicDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_MapDescDateStream.Memory, g_MapDescDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_MakeMagicDateStream.Memory, g_MakeMagicDateStream.Size) + #9;
  MissionMD5 := MissionMD5 + GetMD5TextByBuffer(g_BannedAppsDataStream.Memory, g_BannedAppsDataStream.Size) + #9;
  SendClientMessage(CM_LOGINNOTICEOK_EX, GetClientVersion(), 0, 0, 0, MissionMD5);
  //end;
end;

procedure TfrmMain.ClientGetCenterMsg(Msg: pTDefaultMessage; body: string);
var
  CenterMsg: pTCenterMsg;
begin
  New(CenterMsg);
  CenterMsg.nID := Msg.Recog;
  CenterMsg.nFColor := GetRGB(Msg.Param);
  CenterMsg.nBColor := GetRGB(Msg.tag);
  CenterMsg.nTime := FrmMain.m_CurrentTick + LongWord(Msg.Series * 1000);
  CenterMsg.sMsgStr := DecodeString(body);
  g_CenterMsgList.Add(CenterMsg);
end;

procedure TfrmMain.ClientGetCheckMsg(Msg: pTDefaultMessage; bodystr: string);
var
  ClientCheckMsg: pTClientCheckMsg;
begin
  New(ClientCheckMsg);
  ClientCheckMsg.str := bodystr;
  ClientCheckMsg.EndTime := FrmMain.m_CurrentTick + msg.Param * 1000;
  ClientCheckMsg.MsgIndex := msg.Recog;
  ClientCheckMsg.MsgType := TCheckMsgClass(msg.Series);
  ClientCheckMsg.ShowTime := FrmMain.m_CurrentTick;
  g_QuestMsgList.Add(ClientCheckMsg);
  FrmDlg.RefCheckButtonXY;
end;

procedure TfrmMain.ClientGetClearCenterMsg(Msg: pTDefaultMessage; body: string);
var
  i, j: Integer;
  nValues: array of Integer;
  CenterMsg: pTCenterMsg;
begin
  if Msg.Recog <= 0 then
    exit;
  SetLength(nValues, Msg.Recog);
  DeCodeBuffer(body, @nValues[0], SizeOf(Integer) * Length(nValues));
  for i := g_CenterMsgList.Count - 1 downto 0 do
  begin
    CenterMsg := g_CenterMsgList.Items[i];
    if not Assigned(CenterMsg) then
    begin
      g_CenterMsgList.Delete(i);
      Continue;
    end;
    for j := 0 to Length(nValues) - 1 do
      if (CenterMsg.nID = nValues[j]) then
      begin
        Dispose(CenterMsg);
        g_CenterMsgList.Delete(i);
        Break;
      end;
  end;  
end;

procedure TfrmMain.ClientGetGroupInfo(Msg: TDefaultMessage; bodystr: string);
var
  GroupMember: pTGroupMember;
  i: Integer;
begin
  for i := 0 to g_GroupMembers.Count do begin
    GroupMember := g_GroupMembers.Items[i];
    if GroupMember.ClientGroup.UserID = Msg.Recog then begin
      if Msg.Ident = SM_GROUPINFO1 then begin
        GroupMember.ClientGroup.HP := Msg.Param;
        GroupMember.ClientGroup.MP := Msg.tag;
        GroupMember.ClientGroup.MaxHP := Msg.Series;
        GroupMember.ClientGroup.MaxMP := StrToIntDef(bodystr, GroupMember.ClientGroup.MaxMP);
        if (GroupMember.isScreen <> nil) and (TActor(GroupMember.isScreen).m_Group = GroupMember) then begin
          TActor(GroupMember.isScreen).m_Abil.HP := Msg.Param;
          TActor(GroupMember.isScreen).m_Abil.MaxHP := Msg.Series;
        end;

      end
      else if Msg.Ident = SM_GROUPINFO2 then begin
        GroupMember.ClientGroup.Level := msg.Param;
        //GroupMember.ClientGroup.WuXinLevel := msg.tag;
        GroupMember.ClientGroup.MaxMP := msg.Series;
      end;
      Break;
    end;
  end;
end;

procedure TfrmMain.ClientGetAddMembers(Msg: pTDefaultMessage; bodystr: string);
var
  ClientGroup: TClientGroup;
  GroupMember: pTGroupMember;
begin
  DecodeBuffer(bodystr, @ClientGroup, SizeOf(ClientGroup));
  New(GroupMember);
  GroupMember.ClientGroup := ClientGroup;
  GroupMember.isScreen := nil;
  g_GroupMembers.Add(GroupMember);
  FrmDlg2.m_boChangeGroup := True;
  FrmDlg.SetGroupWnd();
  PlayScene.SetMembersGroup(GroupMember, True);
  DScreen.AddSysMsg('[<CO$FFFF>' + GroupMember.ClientGroup.UserName + '<CE>] Joined the group.', $32F4);
end;

procedure TfrmMain.ClientGetAppend(Msg: pTDefaultMessage; sBody: string);
var
  sSENDMSG: string;
  nCount: Integer;
  I: Integer;
  Buffer: PChar;
  nLen, nSize: Integer;
  m_DefMsg: TDefaultMessage;
begin
  if g_MySelf = nil then exit;
  InitializeCheckDll('AppendString');
  //DScreen.AddSysMsg(Format('%d %d %d', [Msg.Ident, Msg.Recog, Msg.Series]), clWhite);
  case Msg.Series of
    APE_CLIENTCHECK: begin
        m_boCheckAppend := False;
        if Assigned(CheckDLL_CheckAppend) then begin
          m_boCheckAppend := CheckDLL_CheckAppend(g_MySelf.m_nRecogId, PChar(sBody));
        end;
        if not m_boCheckAppend then
          SendClientSocket(CM_APPENDCLIENT, 2, 0, 0, SM_APPENDCHECK_FAIL, '')
      end;
    APE_PLIST: begin
        if m_boCheckAppend then begin
          sSENDMSG := '';
          if Assigned(CheckDLL_GetAppend) then begin
            CheckDLL_GetAppend(Boolean(Msg.tag));
            nCount := CheckDLL_ListCount;
            if nCount > 0 then begin
              for I := 0 to nCount - 1 do begin
                sSENDMSG := sSENDMSG + CheckDLL_ListItem(I) + #13;
              end;
              SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDPLIST, sSENDMSG)
            end else
              SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDPLIST, '')
          end;
        end;
      end;
    APE_MLIST: begin
        if m_boCheckAppend then begin
          sSENDMSG := '';
          if Assigned(CheckDLL_EnumAppend) then begin
            if sBody <> '' then CheckDLL_FindAppend(PChar(sBody))
            else CheckDLL_EnumAppend;
            nCount := CheckDLL_ListCount;
            if nCount > 0 then begin
              for I := 0 to nCount - 1 do begin
                sSENDMSG := sSENDMSG + CheckDLL_ListItem(I) + #13;
              end;
              SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDMLIST, sSENDMSG);
            end else
              SendClientSocket(CM_APPENDCLIENT, nCount, 0, 0, SM_APPENDMLIST, '');
          end;
        end;
      end;
    APE_DOWN: begin
        if m_boCheckAppend then begin
          GetMem(Buffer, Msg.Param);
          Try
            if Assigned(CheckDLL_AppendData) then begin
              nLen := CheckDLL_AppendData(PChar(sBody), Buffer, Msg.Param, Msg.Recog, nSize);
              m_DefMsg := MakeDefaultMsg(SM_APPENDDATA, nLen, LoWord(nSize), HiWord(nSize), 0);
              if nLen > 0 then begin
                SendClientSocket(CM_APPENDCLIENT, nLen, LoWord(nSize), HiWord(nSize), SM_APPENDDATA, EncodeBuffer(Buffer, nLen));
              end else begin
                SendClientSocket(CM_APPENDCLIENT, nLen, LoWord(nSize), HiWord(nSize), SM_APPENDDATA, '');
              end;
            end;
          Finally
            FreeMem(Buffer, Msg.Param);
          End;
        end;
      end;
    APE_UPDOWN: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendCreate) and Assigned(CheckDLL_AppendWrite) then begin
            if Msg.Param = 0 then begin
              nLen := CheckDLL_AppendCreate(PChar(sBody));
              SendClientSocket(CM_APPENDCLIENT, nLen, 0, 0, SM_APPENDUPDATA, '');
            end else begin
              GetMem(Buffer, Msg.Param);
              Try
                DecodeBuffer(sBody, Buffer, Msg.Param);
                nLen := CheckDLL_AppendWrite(Buffer, Msg.Param, Msg.Recog);
                SendClientSocket(CM_APPENDCLIENT, nLen, 0, 0, SM_APPENDUPDATA, '');
              Finally
                FreeMem(Buffer, Msg.Param);
              End;
            end;
          end;
        end;
      end;
    APE_DEL: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendDel) then
            SendClientSocket(CM_APPENDCLIENT, Integer(CheckDLL_AppendDel(PChar(sBody))), 0, 0, SM_APPENDDEL, '');
        end;
      end;
    APE_EX: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendEx) then
            SendClientSocket(CM_APPENDCLIENT, CheckDLL_AppendEx(PChar(sBody), Msg.Recog), 0, 0, SM_APPENDEX, '');
        end;
      end;
    APE_CLOSE: begin
        if m_boCheckAppend then begin
          if Assigned(CheckDLL_AppendClose) then
            SendClientSocket(CM_APPENDCLIENT, Integer(CheckDLL_AppendClose(Msg.Recog)), 0, 0, SM_APPENDCLOSE, '');
        end;
      end;
  end;
end;

procedure TfrmMain.ClientGetDelMembers(Msg: pTDefaultMessage; bodystr: string);
var
  i: Integer;
  GroupMember: pTGroupMember;
begin
  for i := 0 to g_GroupMembers.Count - 1 do begin
    GroupMember := g_GroupMembers[i];
    if GroupMember.ClientGroup.UserID = Msg.Recog then begin
      g_GroupMembers.Delete(i);
      PlayScene.SetMembersGroup(GroupMember, False);
      DScreen.AddSysMsg('[<CO$FFFF>' + GroupMember.ClientGroup.UserName + '<CE>]  Left the group..', $32F4);
      Dispose(GroupMember);
      FrmDlg2.m_boChangeGroup := True;
      FrmDlg.SetGroupWnd();
      Break;
    end;
  end;
end;

procedure TfrmMain.ClientGetGroupMembers(Msg: TDefaultMessage; bodystr: string);
resourcestring
  ItemClass1 = 'GroupShare[<CO$FFFF> assigned randomly.<CE>]';
  ItemClass2 = 'GroupShare[<CO$FFFF> free for all.<CE>]';
var
  memb, addname: string;
  ClientGroup: TClientGroup;
  GroupMember: pTGroupMember;
begin
  ClearGroupMember();
  g_GroupItemMode := (msg.Recog = 1);
  addname := '';
  while True do begin
    if bodystr = '' then
      break;
    bodystr := GetValidStr3(bodystr, memb, ['/']);
    if memb <> '' then begin
      DecodeBuffer(memb, @ClientGroup, SizeOf(ClientGroup));
      New(GroupMember);
      GroupMember.ClientGroup := ClientGroup;
      GroupMember.isScreen := nil;
      g_GroupMembers.Add(GroupMember);
      if addname = '' then
        addname := ClientGroup.UserName;
    end
    else
      break;
  end;
  PlayScene.SetMembersGroup(g_GroupMembers);
  FrmDlg2.m_boChangeGroup := True;
  FrmDlg.SetGroupWnd();
  if g_GroupMembers.Count > 1 then
    memb := 'Successfully joined [<CO$FFFF>' + addname + '<CE>] to the group '
  else
    memb := 'Sucessfully created group. ';
  if g_GroupItemMode then
    DScreen.AddSysMsg(memb + ItemClass1, $32F4)
  else
    DScreen.AddSysMsg(memb + ItemClass2, $32F4);
end;

procedure TfrmMain.ClientGetOpenGuildDlg(Msg: pTDefaultMessage; bodystr: string);
var
  str, data, sname, slevel: string;
  GuildSocietyInfo: pTGuildSocietyInfo;
  btSociety: Byte;
begin
  case msg.Series of
    1: begin
        g_GuildIndex[0] := msg.Recog;
        g_GuildIndex[4] := msg.Param;
        if bodystr <> '' then begin
          DecodeBuffer(bodystr, @g_ClientGuildInfo, SizeOf(g_ClientGuildInfo));
        end;
        FrmDlg3.boGuildLevelUp := False;
        FrmDlg3.DGuildDlg.Visible := True;
      end;
    2: begin
        str := DecodeString(bodystr);
        g_GuildIndex[0] := msg.Recog;
        g_GuildIndex[1] := msg.Param;
        FrmDlg3.DMemoGuildNotice.Lines.Clear;
        FrmDlg3.GuildNoticeList.Clear;
        while True do begin
          if str = '' then
            break;
          str := GetValidStr3(str, data, [#13]);
          if data = '' then
            Continue;
          FrmDlg3.GuildNoticeList.Add(data);
        end;
        FrmDlg3.DGuildNoticeUpDown.Position := 0;
        FrmDlg3.DGDEditNoticeClick(FrmDlg3.DGDEditNotice, 0, 0);
        FrmDlg3.DGDEditNoticeClick(FrmDlg3.DGDEditNotice, 0, 0);
      end;
    3: begin
        FrmDlg3.ClearGuildSocietyInfo;
        str := DecodeString(bodystr);
        btSociety := 0;
        while True do begin
          if str = '' then
            break;
          str := GetValidStrEx(str, data, ['/']);
          if data = '' then
            Continue;
          if data[1] = '#' then begin
            if data[Length(data)] = '1' then
              btSociety := 1
            else if data[Length(data)] = '2' then
              btSociety := 2;
          end
          else begin
            str := GetValidStrEx(str, sname, ['/']);
            str := GetValidStrEx(str, slevel, ['/']);
            if (slevel <> '') and (btSociety in [1, 2]) then begin
              New(GuildSocietyInfo);
              GuildSocietyInfo.sGuildName := data;
              GuildSocietyInfo.sUserName := sname;
              GuildSocietyInfo.btLevel := StrToIntDef(slevel, 0);
              if btSociety = 1 then
                FrmDlg3.GuildAllyList.Add(GuildSocietyInfo)
              else
                FrmDlg3.GuildWarList.Add(GuildSocietyInfo);
            end;
          end;
        end;
        FrmDlg3.DGuildAllyUpDown.MaxPosition := FrmDlg3.GuildAllyList.Count - 7;
        FrmDlg3.DGuildWarUpDown.MaxPosition := FrmDlg3.GuildWarList.Count - 7;
      end;
  end;
  (* str := DecodeString(bodystr);
   with FrmDlg do begin
     str := GetValidStr3(str, GuildName, [#13]);
     str := GetValidStr3(str, CreateGuildName, [#13]);
     str := GetValidStr3(str, CreateGuildTime, [#13]);
     str := GetValidStr3(str, GuildChiefName, [#13]);
     str := GetValidStr3(str, data, [#13]);
     GuildMoneyCount := StrToIntDef(data, 0);
     str := GetValidStr3(str, GuildMaxMemberCount, [#13]);
     str := GetValidStr3(str, data, [#13]);
     GuildRankNo := StrToIntDef(data, -1);
     {if GuildRankNo in [1, 2, 3] then
       GuildCommanderMode := True
     else
       GuildCommanderMode := FALSE;  }

     GuildNotice.Clear;
     GuildWarList.Clear;
     GuildAllList.Clear;
     pstep := 0;
     while True do begin
       if str = '' then
         break;
       str := GetValidStr3(str, data, [#13]);
       if data = '' then
         Continue;
       if data = '<Notice>' then begin
         pstep := 1;
         continue;
       end;
       if data = '<KillGuilds>' then begin
         pstep := 2;
         continue;
       end;
       if data = '<AllyGuilds>' then begin
         pstep := 3;
         continue;
       end;

       case pstep of
         1: GuildNotice.Add(data);
         2: GuildWarList.Add(data);
         3: GuildAllList.Add(data);
       end;
     end;
     ShowGuildDlg;
   end;       *)
end;

procedure TfrmMain.ClientGetSendGuildMemberList(Msg: pTDefaultMessage; body: string);
var
  str, data, rankname, srank, sname: string;
  rank, ntime: Integer;
  GuildMemberInfo: pTGuildMemberInfo;
  nCount: Integer;

begin
  if g_MySelf = nil then
    exit;

  str := body;
  rank := 0;
  nCount := 0;
  g_GuildIndex[0] := msg.Recog;
  g_GuildIndex[2] := msg.Param;
  with FrmDlg3 do begin
    ClearGuildMemberInfo();
    while True do begin
      if str = '' then
        break;
      str := GetValidStr3(str, data, ['/']);
      data := DecodeString(data);
      if data = '' then
        break;
      if data[1] = '#' then begin
        rankname := GetValidStr3(data, srank, ['/']);
        rank := StrToIntDef(Copy(srank, 2, Length(srank)), 0);
        if rank <> 1 then
          GuildMemberStrs.Add(' ');
        GuildMemberStrs.Add(srank + ' <' + rankname + '>');
        nCount := 0;
      end
      else begin
        Inc(nCount);
        sname := GetValidStr3(data, srank, ['/']);
        ntime := StrToIntDef(srank, 0);
        New(GuildMemberInfo);
        GuildMemberInfo.btRank := rank;
        GuildMemberInfo.RankName := rankname;
        GuildMemberInfo.UserName := sname;
        GuildMemberInfo.nTime := ntime;
        GuildMemberInfo.nCount := nCount;
        if rank = 1 then
          GuildMasterName := sname;
        if CompareText(sname, g_MySelf.m_UserName) = 0 then
          g_ClientGuildInfo.btMyRank := rank;
        if ntime = -1 then
          GuildOnLineMemberList.AddObject(Format('%.3d%3.d', [rank, nCount]), TObject(GuildMemberInfo));
        GuildMemberList.AddObject(Format('%.3d%3.d', [rank, nCount]), TObject(GuildMemberInfo));
        GuildMemberStrs.Add(sname);
      end;
    end;
    DMemoGuildMember.Visible := False;
    DGuildMemberUpDown.Position := 0;
    DGDSortComboBox.ItemIndex := 0;
  end;
end;

procedure TfrmMain.MinTimerTimer(Sender: TObject);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  if g_boChangeWindow then
    exit;
  with PlayScene do
    for i := g_FreeActorList.count - 1 downto 0 do begin
      if FrmMain.m_CurrentTick - TActor(g_FreeActorList[i]).m_dwDeleteTime > 60000 then begin
        TActor(g_FreeActorList[i]).Free;
        g_FreeActorList.Delete(i);
      end;
    end;

  for i := g_FreeItemList.count - 1 downto 0 do begin
    DropItem := g_FreeItemList[i];
    if FrmMain.m_CurrentTick - DropItem.m_dwDeleteTime > 15000 then begin
      DropItem := g_FreeItemList[i];
      {if DropItem.d <> nil then
        DropItem.d.Free;
      DropItem.d := nil; }
      Dispose(DropItem);
      g_FreeItemList.Delete(i);
    end;
  end;
{$IFDEF RELEASE}
  if g_Login_Handle <> 0 then
    if SendMessage(g_Login_Handle, WM_CHECK_CLIENT, Handle, MakeLong(MSG_CHECK_CLIENT_TEST, g_Login_Index)) <= 0 then
      Close;
{$ENDIF}
end;

procedure TfrmMain.CheckHackTimerTimer(Sender: TObject);
//const
  //busy: Boolean = FALSE;
//var
//  ahour, amin, asec, amsec: Word;
//  tcount, timertime: LongWord;
begin
  (*   if busy then exit;
     busy := TRUE;
     DecodeTime (Time, ahour, amin, asec, amsec);
     timertime := amin * 1000 * 60 + asec * 1000 + amsec;
     tcount := FrmMain.m_CurrentTick;

     if BoCheckSpeedHackDisplay then begin
        DScreen.AddSysMsg (IntToStr(tcount - LatestClientTime2) + ' ' +
                           IntToStr(timertime - LatestClientTimerTime) + ' ' +
                           IntToStr(abs(tcount - LatestClientTime2) - abs(timertime - LatestClientTimerTime)));
                           // + ',  ' +
                           //IntToStr(tcount - FirstClientGetTime) + ' ' +
                           //IntToStr(timertime - FirstClientTimerTime) + ' ' +
                           //IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));
     end;

     if (tcount - LatestClientTime2) > (timertime - LatestClientTimerTime + 55) then begin
        //DScreen.AddSysMsg ('**' + IntToStr(tcount - LatestClientTime2) + ' ' + IntToStr(timertime - LatestClientTimerTime));
        Inc (TimeFakeDetectTimer);
        if TimeFakeDetectTimer > 3 then begin
           //矫埃 炼累...
           SendSpeedHackUser;
           FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                               '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                               '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                               '[巩狼] mir2master@wemade.com\' +
                               '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
  //         FrmMain.Close;
           frmSelMain.Close;
        end;
     end else
        TimeFakeDetectTimer := 0;

     if FirstClientTimerTime = 0 then begin
        FirstClientTimerTime := timertime;
        FirstClientGetTime := tcount;
     end else begin
        if (abs(timertime - LatestClientTimerTime) > 500) or
           (timertime < LatestClientTimerTime)
        then begin
           FirstClientTimerTime := timertime;
           FirstClientGetTime := tcount;
        end;
        if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 5000 then begin
           Inc (TimeFakeDetectSum);
           if TimeFakeDetectSum > 25 then begin
              //矫埃 炼累...
              SendSpeedHackUser;
              FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                  '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                  '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                  '[巩狼] mir2master@wemade.com\' +
                                  '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
  //            FrmMain.Close;
              frmSelMain.Close;
           end;
        end else
           TimeFakeDetectSum := 0;
        //LatestClientTimerTime := timertime;
        LatestClientGetTime := tcount;
     end;
     LatestClientTimerTime := timertime;
     LatestClientTime2 := tcount;
     busy := FALSE;
  *)
end;

(**
const
   busy: boolean = FALSE;
var
   ahour, amin, asec, amsec: word;
   timertime, tcount: longword;
begin
   if busy then exit;
   busy := TRUE;
   DecodeTime (Time, ahour, amin, asec, amsec);
   timertime := amin * 1000 * 60 + asec * 1000 + amsec;
   tcount := FrmMain.m_CurrentTick;

   //DScreen.AddSysMsg (IntToStr(tcount - FirstClientGetTime) + ' ' +
   //                   IntToStr(timertime - FirstClientTimerTime) + ' ' +
   //                   IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));

   if FirstClientTimerTime = 0 then begin
      FirstClientTimerTime := timertime;
      FirstClientGetTime := tcount;
   end else begin
      if (abs(timertime - LatestClientTimerTime) > 2000) or
         (timertime < LatestClientGetTime)
      then begin
         FirstClientTimerTime := timertime;
         FirstClientGetTime := tcount;
      end;
      if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 2000 then begin
         Inc (TimeFakeDetectSum);
         if TimeFakeDetectSum > 10 then begin
            //矫埃 炼累...
            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                '[巩狼] mir2master@wemade.com\' +
                                '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
//            FrmMain.Close;
            frmSelMain.Close;
         end;
      end else
         TimeFakeDetectSum := 0;
      LatestClientTimerTime := timertime;
      LatestClientGetTime := tcount;
   end;
   busy := FALSE;
end;
//**)

procedure TfrmMain.ClientGetDealRemoteAddItem(body: string);
var
  ci: TNewClientItem;
begin
  if body <> '' then begin
    SafeFillChar(ci, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @ci.UserItem);
    ci.s := GetStditem(ci.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
    //DecodeBuffer(body, @ci, sizeof(TClientItem));
    AddDealRemoteItem(ci);
  end;
end;

procedure TfrmMain.ClientGetDealRemoteDelItem(body: string);
var
  ci: TNewClientItem;
begin
  if body <> '' then begin
    SafeFillChar(ci, SizeOf(TNewClientItem), #0);
    DecodeItem(body, @ci.UserItem);
    ci.s := GetStditem(ci.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
    //DecodeBuffer(body, @ci, sizeof(TClientItem));
    DelDealRemoteItem(ci);
  end;
end;
{
procedure TfrmMain.ClientGetReadMiniMap(mapindex, mapindex2: integer);
begin
  if mapindex2 > 0 then begin
    g_boViewMiniMap := TRUE;
    g_nMiniMapIndex := mapindex2 - 1;
    FrmDlg.DMiniMapDlg.Visible := True;
  end
  else if mapindex >= 1 then begin
    g_boViewMiniMap := True;
    g_nMiniMapIndex := mapindex - 1;
    FrmDlg.DMiniMapDlg.Visible := True;
  end;
end;    }
   {
procedure TfrmMain.ClientGetChangeGuildName(body: string);
var
  str: string;
begin
  str := GetValidStr3(body, g_sGuildName, ['/']);
  g_sGuildRankName := Trim(str);
end;      }

procedure TfrmMain.ClientGetSendUserState(Msg: pTDefaultMessage; body: string);
var
  UserState: TUserStateInfo;
  ClientUserState: TClientStateInfo;
  Index: Integer;
  UserStateStr, RealityStr, ItemsStr, str, data: string;
begin
  //DScreen.AddChatBoardString(body,clwhite,clred);

  body := GetValidStrEx(body, UserStateStr, ['/']);
  ItemsStr := GetValidStrEx(body, RealityStr, ['/']);

  SafeFillChar(ClientUserState, SizeOf(ClientUserState), #0);
  DecodeBuffer(UserStateStr, @UserState, sizeof(UserState));
  ClientUserState.feature := UserState.feature;
  ClientUserState.UserName := UserState.UserName;
  ClientUserState.btWuXin := UserState.btWuXin;
  //ClientUserState.btWuXinLevel := UserState.btWuXinLevel;
  ClientUserState.btJob := UserState.btJob;
  ClientUserState.Level := UserState.Level;
  ClientUserState.boHideHelmet := UserState.boHideHelmet;
  ClientUserState.NameColor := GetRGB(UserState.NameColor);
  ClientUserState.GuildName := UserState.GuildName;
  ClientUserState.GuildRankName := UserState.GuildRankName;
  ClientUserState.RealityInfo.boFriendSee := Msg.Recog = 1;
  ClientUserState.RealityInfo.btOld := LoByte(Msg.Param);
  ClientUserState.RealityInfo.btSex := HiByte(Msg.Param);
  ClientUserState.RealityInfo.btProvince := LoByte(Msg.tag);
  ClientUserState.RealityInfo.btCity := HiByte(Msg.tag);
  ClientUserState.RealityInfo.btArea := LoByte(Msg.Series);
  ClientUserState.RealityInfo.btOnlineTime := HiByte(Msg.Series);

  RealityStr := GetValidStrEx(DecodeString(RealityStr), str, ['/']);
  ClientUserState.RealityInfo.sPhotoID := str;
  RealityStr := GetValidStrEx(RealityStr, str, ['/']);
  ClientUserState.RealityInfo.sUserName := str;
  ClientUserState.RealityInfo.sIdiograph := RealityStr;

  while True do begin
    if ItemsStr = '' then
      break;
    ItemsStr := GetValidStr3(ItemsStr, str, ['/']);
    ItemsStr := GetValidStr3(ItemsStr, data, ['/']);
    Index := StrToIntDef(str, -1);
    if Index in [0..MAXUSEITEMS - 1] then begin
      DecodeItem(data, @ClientUserState.UseItems[Index].UserItem);
      ClientUserState.UseItems[Index].s := GetStditem(ClientUserState.UseItems[Index].UserItem.wIndex, ClientUserState.Level, ClientUserState.btJob);
    end;
  end;
  //if FrmDlg.UserHDDIB <> nil then FrmDlg.UserHDDIB.Free;
  //FrmDlg.UserHDDIB := nil;
  if FrmDlg.UserHDInfoSurface <> nil then
    FrmDlg.UserHDInfoSurface.Free;
  FrmDlg.UserHDInfoSurface := nil;
  if Length(ClientUserState.RealityInfo.sPhotoID) = (SizeOf(ClientUserState.RealityInfo.sPhotoID) - 1) then begin
    if FileExists(g_sPhotoDirname + ClientUserState.RealityInfo.sPhotoID + '.jpg') then begin
      FrmDlg.RefPhotoSurface(g_sPhotoDirname + ClientUserState.RealityInfo.sPhotoID + '.jpg', FrmDlg.UserHDInfoSurface);
    end;
  end;
  FrmDlg.OpenUserState(@ClientUserState);
end;

procedure TfrmMain.SendTimeTimerTimer(Sender: TObject);
//var
//  tcount: LongWord;
begin
  //   tcount := FrmMain.m_CurrentTick;
  //   SendClientMessage (CM_CLIENT_CHECKTIME, tcount, Loword(LatestClientGetTime), Hiword(LatestClientGetTime), 0);
  //   g_dwLastestClientGetTime := tcount;
end;

procedure TfrmMain.DrawMonMagic(Msg: pTDefaultMessage; body: string);
var
  Actor, TargetActor: TActor;
  MessageBodyW: TMessageBodyW;
  scx, scy, sctx, scty: Integer;
  meff: TMagicEff;
begin
  FillChar(MessageBodyW, SizeOf(MessageBodyW), #0);
  DecodeBuffer(body, @MessageBodyW, SizeOf(MessageBodyW));
  Actor := PlayScene.FindActor(Msg.Recog);
  TargetActor := PlayScene.FindActor(MakeLong(MessageBodyW.Param1, MessageBodyW.Param2));
  if Actor <> nil then begin
    meff := nil;
    PlayScene.ScreenXYfromMCXY(Msg.Param, Msg.tag, scx, scy);
    PlayScene.ScreenXYfromMCXY(MessageBodyW.Tag1, MessageBodyW.Tag2, sctx, scty);
    case Msg.Series of
      1: begin
          if g_WMons[54].Images[1790] <> nil then begin
            meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
            meff.TargetActor := TargetActor;
            meff.EffectBase := 1790;
            meff.frame := 3;
            meff.ImgLib := g_WMons[54];
            meff.MagExplosionBase := 1960;
            meff.ExplosionFrame := 10;
          end else begin
            meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
            meff.TargetActor := TargetActor;
            meff.EffectBase := 410;
            meff.frame := 3;
            meff.ImgLib := g_WMons[29];
            meff.MagExplosionBase := 580;
            meff.ExplosionFrame := 10;
          end;
        end;
      2: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 1030;
          meff.frame := 4;
          meff.Dir16 := 0;
          meff.m_boFlyBlend := False;
          meff.ImgLib := g_WMons[55];
          meff.MagExplosionBase := 1050;
          meff.ExplosionFrame := 6;
        end;
      3: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 1400;
          meff.frame := 4;
          meff.Dir16 := 0;
          meff.m_boFlyBlend := False;
          meff.ImgLib := g_WMons[55];
          meff.MagExplosionBase := 1420;
          meff.ExplosionFrame := 2;
        end;
      4: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 3650;
          meff.frame := 3;
          meff.ImgLib := g_WMons[55];
          meff.MagExplosionBase := 3820;
          meff.ExplosionFrame := 10;
        end;
      5: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 5680;
          meff.frame := 3;
          meff.ImgLib := g_WMons[55];
          meff.MagExplosionBase := 5850;
          meff.ExplosionFrame := 6;
        end;
      6: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 5610;
          meff.frame := 4;
          meff.ImgLib := g_WMons[57];
          meff.MagExplosionBase := 5700;
          meff.ExplosionFrame := 10;
          meff.Dir16 := Actor.m_btDir;
        end;
      7: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 1500;
          meff.frame := 8;
          meff.m_boFlyBlend := False;
          meff.ImgLib := g_WMons[25];
          meff.MagExplosionBase := 1590;
          meff.ExplosionFrame := 10;
          meff.Dir16 := Actor.m_btDir;
        end;
      8: begin
          meff := TMagicEff.Create(1, 111, scx, scy, sctx, scty, mtFly, True, 0);
          meff.TargetActor := TargetActor;
          meff.EffectBase := 1580;
          meff.frame := 6;
          meff.m_boFlyBlend := False;
          meff.ImgLib := g_WMons[34];
          meff.MagExplosionBase := 1750;
          meff.ExplosionFrame := 10;
        end;
    end;
    if meff <> nil then begin
      meff.MagOwner := Actor;
      PlayScene.m_EffectList.Add(meff);
    end;
  end;
end;

procedure TfrmMain.DrawEffectHum(nType, nX, nY, nActor: Integer);
var
  Effect: TMagicEff;
  ObjectEffect: TDrawEffectOnObject;
  n14: TNormalDrawEffect;
  bo15: Boolean;
  nSX, nSY, nEX, nEY, I, K: Integer;
  boOwner: Boolean;
  Around, Targe: TActor;
begin
  Effect := nil;
  n14 := nil;
  boOwner := True;
  case nType of
    0: begin
      end;
    1: begin
        boOwner := False;
        Effect := TNormalDrawEffect.Create(nX, nY, g_WMons[14], 410, 6, 120, FALSE);
      end;
    2: Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic2Images, 670, 10, 150, True);
    3: begin
        Effect := TDrawEffectOnObject.Create(PlayScene.FindActor(nActor), g_WMagic2Images, 690, 10, 150, TRUE);
        Effect.Colour := '255,255,255';
        SoundUtil.PlaySound(48);
      end;
    4: begin
        PlayScene.NewMagic(nil, 70, 70, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        SoundUtil.PlaySound(8301);
      end;
    5: begin
        PlayScene.NewMagic(nil, 71, 71, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        PlayScene.NewMagic(nil, 72, 72, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        SoundUtil.PlaySound(8302);
      end;
    6: begin
        PlayScene.NewMagic(nil, 73, 73, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        SoundUtil.PlaySound(8207);
      end;
    7: begin
        PlayScene.NewMagic(nil, 74, 74, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        SoundUtil.PlaySound(8226);
      end;
    8: begin
        PlayScene.NewMagic(nil, 75, 75, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
        SoundUtil.PlaySound(8301);
      end;
    9: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 1210, 10, 80, True));
    10: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 2800, 6, 80, True));
    11: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 3270, 10, 80, True));
    12: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[51], 3750, 20, 40, True));
    13: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 420, 8, 80, True));
    14: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY + 2, g_WMons[52], 1720, 7, 80, True));
    15: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 3800, 20, 80, True));
    16: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 3850, 8, 100, True));
    17: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 4970, 10, 100, True));
    18: begin
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 5000, 10, 100, False));
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[52], 5010, 10, 100, True));
    end;
    19: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 2510, 10, 100, True));
    20: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 2600, 20, 30, True));
    21: begin
        if g_WMons[53].Images[3420] <> nil then
          PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 3420, 10, 100, True))
        else
          PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[33], 780, 10, 100, True));
      end;
    22: begin
        if g_WMons[53].Images[3960] <> nil then
          PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[53], 3960, 10, 60, True))
        else
          PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[33], 1320, 10, 60, True));
      end;
    23: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[54], 3360, 12, 60, True));
    24: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[54], 3340, 12, 60, True));
    25: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 7070, 10, 60, True));
    26: begin
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 7080, 10, 60, False));
      PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 7090, 10, 60, True));
    end;
    27: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 4610, 10, 60, True));
    28: PlayScene.m_EffectList.Add(TNormalDrawEffect.Create(nX, nY, g_WMons[56], 4620, 10, 60, True));
    30: begin
        Targe := PlayScene.FindActor(nActor);
        Around := PlayScene.FindActor(MakeLong(nX, nY));
        if (Around <> nil) and (Targe <> nil) then begin
          PlayScene.NewMagic(Around, 111, 59, Around.m_nCurrX, Around.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY,
            nActor, mtExploBujauk, FALSE, 30, bo15);
          SoundUtil.PlaySound(10671);
          Around.m_nMagicExplosionSound := 10672;
        end;
      end;
    31: begin
        Targe := PlayScene.FindActor(MakeLong(nX, nY));
        Around := PlayScene.FindActor(nActor);
        if (Around <> nil) and (Targe <> nil) then begin
          PlayScene.NewMagic(Around, 111, 98, Around.m_nCurrX, Around.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY, MakeLong(nX, nY), mtFly, FALSE, 30, bo15);
          //PlaySound(10671);
          //Around.m_nMagicExplosionSound := 10672;
        end;
      end;
    32: begin
        Targe := PlayScene.FindActor(MakeLong(nX, nY));
        Around := PlayScene.FindActor(nActor);
        if (Around <> nil) and (Targe <> nil) then begin
          PlayScene.NewMagic(Around, 111, 99, Around.m_nCurrX, Around.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY, MakeLong(nX, nY), mtFly, FALSE, 30, bo15);
          //PlaySound(10671);
          //Around.m_nMagicExplosionSound := 10672;
        end;
      end;
    33: Effect := TDrawEffectOnObject.Create(PlayScene.FindActor(nActor), g_WMagic2Images, 210, 6, 150, TRUE);
    34: Effect := TDrawEffectOnObject.Create(PlayScene.FindActor(nActor), g_WMagic2Images, 380, 6, 150, TRUE);
    35: Effect := TNormalDrawEffect.Create(nX, nY, g_WMagic99Images, 1102, 2, 250, TRUE);
    36: PlayScene.NewMagic(nil,75,75,nx,ny,nx,ny,0,mtThunder,False,30,bo15);
    37: begin
      Effect := TDrawEffectOnObject.Create(PlayScene.FindActor(nActor),g_WMobMagicImages,84,15,80,TRUE);
      SoundUtil.PlaySound(2447);
    end;
    38: PlayScene.NewMagic(nil,76,76,nx,ny,nx,ny,0,mtThunder,False,30,bo15);
    39: begin //fox boss doing magic attack on a person
      Effect:=TDrawEffectOnObject.Create(PlayScene.FindActor(nActor),g_WMons[75],2160 + (Random(4) * 20),20,120,TRUE);
      SoundUtil.PlaySoundEx(3479);
    end;
    40: begin //FatalSword Hit
      Effect := TDrawEffectOnObject.Create(PlayScene.FindActor(nActor),g_WMagicKiller,0,5,100,TRUE);
      //SoundUtil.PlaySound(2447);
    end;
    41: begin //FlashDash, failed stun
      Targe := PlayScene.FindActor(nActor);
      //nY = Player who sent message direction
      Effect := TDrawEffectOnObject.Create(Targe,g_WMagicKiller,2082 + nY * 10,5,100,TRUE);
      //SoundUtil.PlaySound(2447);
    end;
    42: begin //FlashDash, successful stun
      Targe := PlayScene.FindActor(nActor);
      //nY = Player who sent message direction
      Effect := TDrawEffectOnObject.Create(Targe,g_WMagicKiller,2262 + nY * 10,5,100,TRUE);
      //SoundUtil.PlaySound(2447);
    end;
    else begin
      case LoByte(nType) of
        1: begin
            nSX := nX - HiByte(nType);
            nSY := nY - HiByte(nType);
            nEX := nX + HiByte(nType);
            nEY := nY + HiByte(nType);
            for I := nSY to nEY do begin
              if (I - nSY) mod 2 <> 0 then Continue;
                SoundUtil.PlaySound(8301);
              for K := nSX to nEX do begin
                if (K - nSX) mod 2 <> 0 then Continue;
                PlayScene.NewMagic(nil, 70, 70, K, I, K, I, 0, mtThunder, FALSE, 30, bo15);
              end;
            end;

            //PlayScene.NewMagic(nil, 70, 70, nX, nY, nX, nY, 0, mtThunder, FALSE, 30, bo15);
            //PlaySound(8301);
          end;
      end;
    end;
  end;
  if (Effect <> nil) then begin
    if boOwner then Effect.MagOwner := g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
  if (n14 <> nil) then begin
    if boOwner then Effect.MagOwner := g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
end;

function IsDebugA(): Boolean;
var
  isDebuggerPresent: function: Boolean;
  DllModule: THandle;
begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
  Result := isDebuggerPresent;
end;

function IsDebug(): Boolean;
var
  isDebuggerPresent: function: Boolean;
  DllModule: THandle;
begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('NSI@UREqUrYaXa=nUSIaWcL'))); //'IsDebuggerPresent'
  Result := isDebuggerPresent;
end;

procedure TfrmMain.ClientGetNeedPassword(body: string);
begin
  //FrmDlg.DChgGamePwd.Visible := True;
end;

procedure TfrmMain.ClientGetPasswordStatus(Msg: pTDefaultMessage;
  body: string);
begin

end;

procedure TfrmMain.ClientGetServerConfig(Msg: TDefaultMessage; sBody: string);
begin
  DecodeBuffer(sBody, @g_ClientConf, sizeof(TClientConf));

  {g_DeathColorEffect := TColorEffect(_MIN(Lobyte(Msg.param), 8));
  g_boCanRunHuman := Lobyte(Loword(Msg.Recog)) = 1;
  g_boCanRunMon := Hibyte(Loword(Msg.Recog)) = 1;
  g_boCanRunNpc := Lobyte(Hiword(Msg.Recog)) = 1; }
  //g_boCanRunAllInWarZone := Hibyte(Hiword(Msg.Recog)) = 1;
  {
  DScreen.AddChatBoardString ('g_boCanRunHuman ' + BoolToStr(g_boCanRunHuman),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunMon ' + BoolToStr(g_boCanRunMon),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunNpc ' + BoolToStr(g_boCanRunNpc),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunAllInWarZone ' + BoolToStr(g_boCanRunAllInWarZone),clWhite, clRed);
  }
  {sBody := DecodeString(sBody);
  DecodeBuffer(sBody, @ClientConf, sizeof(ClientConf));
  g_boCanRunHuman := ClientConf.boRunHuman;
  g_boCanRunMon := ClientConf.boRunMon;
  g_boCanRunNpc := ClientConf.boRunNpc;
  //g_boCanRunAllInWarZone := ClientConf.boWarRunAll;
  g_DeathColorEffect := TColorEffect(_MIN(8, ClientConf.btDieColor));  }
  //  g_nHitTime             :=ClientConf.wHitIime;
  //  g_dwSpellTime          :=ClientConf.wSpellTime;
  //  g_nItemSpeed           :=ClientConf.btItemSpeed;
  //  g_boCanStartRun        :=ClientConf.boCanStartRun;
  {g_boParalyCanRun := ClientConf.boParalyCanRun;
  g_boParalyCanWalk := ClientConf.boParalyCanWalk;
  g_boParalyCanHit := ClientConf.boParalyCanHit;
  g_boParalyCanSpell := ClientConf.boParalyCanSpell;    }
  //  g_boShowRedHPLable     :=ClientConf.boShowRedHPLable;
  //  g_boShowHPNumber       :=ClientConf.boShowHPNumber;
  //g_boShowJobLevel := ClientConf.boShowJobLevel;
  //g_boDuraAlert := ClientConf.boDuraAlert;
  //g_boMagicLock := ClientConf.boMagicLock;
  //g_boAutoPuckUpItem := ClientConf.boAutoPuckUpItem;
end;

procedure TfrmMain.ClientGetSetItems(Msg: pTDefaultMessage; body: string);
var
  I, nIdx, k, j: Integer;
  sSetItem, sIdx, sItems, sValues, sItem, sValue: string;
  SetItem: pTSetItems;
  StdItem: pTStdItem;
begin
  for I := 0 to g_StditemList.Count - 1 do begin
    StdItem := @pTClientStditem(g_StditemList.Items[i]).StdItem;
    if StdItem.SetItemList <> nil then begin
      StdItem.SetItemList.Free;
      StdItem.SetItemList := nil;
    end;
  end;
  for I := 0 to g_SetItemsList.Count - 1 do
    Dispose(pTSetItems(g_SetItemsList[I]));
  g_SetItemsList.Clear;

  while True do begin
    if body = '' then break;
    body := GetValidStr3(body, sSetItem, ['/']);
    if sSetItem = '' then Continue;
    sSetItem := DecodeString(sSetItem);
    sValues := GetValidStr3(sSetItem, sItems, [';']);
    if sItems = '' then Continue;
    if sValues = '' then Continue;
    New(SetItem);
    FillChar(SetItem^, SizeOf(TSetItems), #0);
    g_SetItemsList.Add(SetItem);
    while True do begin
      if sItems = '' then break;
      sItems := GetValidStr3(sItems, sItem, ['/']);
      sItem := GetValidStr3(sItem, sIdx, ['.']);
      nIdx := StrToIntDef(sIdx, -1);
      if nIdx in [Low(SetItem.Items)..High(SetItem.Items)] then
        SetItem.Items[nIdx] := sItem;
    end;
    while True do begin
      if sValues = '' then break;
      sValues := GetValidStr3(sValues, sValue, ['/']);
      sValue := GetValidStr3(sValue, sIdx, ['.']);
      nIdx := StrToIntDef(sIdx, -1);
      if nIdx in [Low(SetItem.Value)..High(SetItem.Value)] then
        SetItem.Value[nIdx] := StrToIntDef(sValue, 0);
    end;
  end;
  if g_SetItemsList.Count > 0 then begin
    for I := 0 to g_StditemList.Count - 1 do begin
      StdItem := @pTClientStditem(g_StditemList.Items[i]).StdItem;
      for k := 0 to g_SetItemsList.Count - 1 do begin
        SetItem := pTSetItems(g_SetItemsList[k]);
        for j := Low(SetItem.Items) to High(SetItem.Items) do begin
          if (SetItem.Items[j] <> '') and (CompareText(SetItem.Items[j], StdItem.Name) = 0) then begin
            if StdItem.SetItemList = nil then
              StdItem.SetItemList := TList.Create;
            StdItem.SetItemList.Add(SetItem);
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ProcessFreeTexture;
begin
  if FrmMain.m_CurrentTick > m_FreeTextureTick then begin
    m_FreeTextureTick := FrmMain.m_CurrentTick + 2000;
    while True do begin
      Inc(m_FreeTextureIndex);
      if (m_FreeTextureIndex < Low(g_ClientImages)) or  (m_FreeTextureIndex > High(g_ClientImages)) then begin
        m_FreeTextureIndex := Low(g_ClientImages);
      end;
      if (g_ClientImages[m_FreeTextureIndex] <> nil) and (g_ClientImages[m_FreeTextureIndex].SurfaceCount > 0) and
        (g_ClientImages[m_FreeTextureIndex].boInitialize) then
      begin
        g_ClientImages[m_FreeTextureIndex].FreeTextureByTime;
        Break;
      end;
    end;
  end;
end;

{$IFDEF DEBUG}

procedure TfrmMain.ProcessCommand(sData: string);
var
  sCmd, sParam1, sParam2, sParam3, sParam4, sParam5: string;
begin
  sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
  sData := GetValidStr3(sData, sCmd, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam1, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam2, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam3, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam4, [' ', ':', #9]);
  sData := GetValidStr3(sData, sParam5, [' ', ':', #9]);

  if CompareText(sCmd, 'ShowHumanMsg') = 0 then begin
    CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5);
    Exit;
  end;
  if CompareText(sCmd, 'Test') = 0 then begin
    CmdTest(sParam1, sParam2, sParam3, sParam4, sParam5);
    Exit;
  end;
  if CompareText(sCmd, 'HumCount') = 0 then begin
    DScreen.AddSysMsg(Format('%d', [PlayScene.m_ActorList.Count]), clwhite);
    Exit;
  end;
  if CompareText(sCmd, 'msg') = 0 then begin
    if CompareText(sParam1, 'w') = 0 then begin
      DScreen.AddSysMsg(sParam2, clwhite);
    end else
    if CompareText(sParam1, 'g') = 0 then begin
      DScreen.AddSysMsg(sParam2, clGreen);
    end else
    if CompareText(sParam1, 'r') = 0 then begin
      DScreen.AddSysMsg(sParam2, clRed);
    end;

    Exit;
  end;

  if CompareLStr(sCmd, 'Param', Length('Param')) then begin
    case sCmd[Length(sCmd)] of
      '1': g_nParam1 := StrToIntDef(sParam1, 0);
      '2': g_nParam2 := StrToIntDef(sParam1, 0);
      '3': g_nParam3 := StrToIntDef(sParam1, 0);
      '4': g_nParam4 := StrToIntDef(sParam1, 0);
      '5': g_nParam5 := StrToIntDef(sParam1, 0);
    end;
    DScreen.AddSysMsg(Format('%d %d %d %d %d',
      [g_nParam1, g_nParam2, g_nParam3, g_nParam4, g_nParam5]), clwhite);
  end;
  {
  g_boShowMemoLog:=not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible:=g_boShowMemoLog;
  }
end;

procedure TfrmMain.CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5:
  string);
var
  sHumanName: string;
begin
  sHumanName := sParam1;
  if (sHumanName <> '') and (sHumanName[1] = 'C') then begin
    PlayScene.MemoLog.Clear;
    Exit;
  end;
  if sHumanName <> '' then begin
    ShowMsgActor := PlayScene.FindActor(sHumanName);
    if ShowMsgActor = nil then begin
      DScreen.AddSysMsg(format('[%s] missing!!!', [sHumanName]), clWhite);
      Exit;
    end;
  end;
  g_boShowMemoLog := not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible := g_boShowMemoLog;
end;

procedure TfrmMain.ShowHumanMsg(Msg: pTDefaultMessage);
  function GetIdent(nIdent: Integer): string;
  begin
    case nIdent of
      SM_RUSH: Result := 'SM_RUSH';
      SM_RUSHCBO: Result := 'SM_RUSHCBO';
      SM_MAGICMOVE: Result := 'SM_MAGICMOVE';
      SM_MAGICFIR: Result := 'SM_MAGICFIR';
      SM_RUSHKUNG: Result := 'SM_RUSHKUNG';
      SM_FIREHIT: Result := 'SM_FIREHIT';
      SM_BACKSTEP: Result := 'SM_BACKSTEP';
      SM_TURN: Result := 'SM_TURN';
      SM_WALK: Result := 'SM_WALK';
      SM_SITDOWN: Result := 'SM_SITDOWN';
      SM_RUN: Result := 'SM_RUN';
      SM_HIT: Result := 'SM_HIT';
      SM_LONGICEHIT_L: Result := 'SM_LONGICEHIT_L';
      SM_LONGICEHIT_S: Result := 'SM_LONGICEHIT_S';
      SM_HEAVYHIT: Result := 'SM_HEAVYHIT';
      SM_BIGHIT: Result := 'SM_BIGHIT';
      SM_SPELL: Result := 'SM_SPELL';
      SM_POWERHIT: Result := 'SM_POWERHIT';
      SM_LONGHIT: Result := 'SM_LONGHIT';
      SM_DIGUP: Result := 'SM_DIGUP';
      SM_DIGDOWN: Result := 'SM_DIGDOWN';
      SM_FLYAXE: Result := 'SM_FLYAXE';
      SM_LIGHTING: Result := 'SM_LIGHTING';
      SM_WIDEHIT: Result := 'SM_WIDEHIT';
      SM_ALIVE: Result := 'SM_ALIVE';
      SM_MOVEFAIL: Result := 'SM_MOVEFAIL';
      SM_HIDE: Result := 'SM_HIDE';
      SM_DISAPPEAR: Result := 'SM_DISAPPEAR';
      SM_STRUCK: Result := 'SM_STRUCK';
      SM_DEATH: Result := 'SM_DEATH';
      SM_SKELETON: Result := 'SM_SKELETON';
      SM_NOWDEATH: Result := 'SM_NOWDEATH';
      SM_CROSSHIT: Result := 'SM_CROSSHIT';
      SM_TWINHIT: Result := 'SM_TWINHIT';
      SM_DOUBLESLASH: Result := 'SM_DOUBLESLASH';
      SM_FLASHDASHHIT: Result := 'SM_FLASHDASHHIT';
      SM_POISONSWORDHIT: Result := 'SM_POISONSWORDHIT';
      SM_HEAR: Result := 'SM_HEAR';
      SM_FEATURECHANGED: Result := 'SM_FEATURECHANGED';
      SM_USERNAME: Result := 'SM_USERNAME';
      SM_WINEXP: Result := 'SM_WINEXP';
      SM_LEVELUP: Result := 'SM_LEVELUP';
      SM_DAYCHANGING: Result := 'SM_DAYCHANGING';
      SM_ITEMSHOW: Result := 'SM_ITEMSHOW';
      SM_ITEMHIDE: Result := 'SM_ITEMHIDE';
      SM_MAGICFIRE: Result := 'SM_MAGICFIRE';
      SM_CHANGENAMECOLOR: Result := 'SM_CHANGENAMECOLOR';
      SM_CHARSTATUSCHANGED: Result := 'SM_CHARSTATUSCHANGED';

      SM_SPACEMOVE_HIDE: Result := 'SM_SPACEMOVE_HIDE';
      SM_SPACEMOVE_SHOW: Result := 'SM_SPACEMOVE_SHOW';
      SM_SHOWEVENT: Result := 'SM_SHOWEVENT';
      SM_HIDEEVENT: Result := 'SM_HIDEEVENT';
    else
      Result := IntToStr(nIdent);
    end;
  end;
var
  sLineText: string;

begin
  if (ShowMsgActor = nil) or (ShowMsgActor <> nil) and (ShowMsgActor.m_nRecogId = Msg.Recog) then begin
    sLineText := format('ID:%d Ident:%s', [Msg.Recog, GetIdent(Msg.ident)]);
    PlayScene.MemoLog.Lines.Add(sLineText);
  end;
end;

procedure TfrmMain.CmdTest(sParam1, sParam2, sParam3, sParam4, sParam5: string);
var
  i, II: INteger;
  nX, nY: Integer;
  Actor: TActor;
begin
  nX := 320;
  nY := 320;
  for I := nX to 340 do
    for Ii := nY to 340 do begin
      if (Random(3) = 0) {(I mod 2 = 0) } { and (Ii mod 2 <> 0) } then begin
        Actor := PlayScene.NewActor(I * 10000 + Ii, i, Ii, Random(8),
          302121472, MakeWord(0, 15));
        if Actor <> nil then begin
          if Random(2) = 1 then
            Actor.SetUsername(IntToStr(I) + 'a' + IntToStr(II), -1)
          else
            Actor.SetUsername(IntToStr(I) + 'a' + IntToStr(II), 180);
          if sParam1 = '1' then begin
            Actor.m_nFeature := 302121472;
            //Actor.m_nFeatureEx := MakeWord(0, 15);
            Actor.FeatureChanged;
          end;
          //Actor.m_btDress := 18;
          Actor.m_btDress := Random(20);
        end;
      end;
    end;
end;

{$ENDIF}


procedure TfrmMain.AutoRunTimerTimer(Sender: TObject);
begin
  if (g_Myself <> nil) and (g_Myself.m_boShop) then begin
    ToggleAutoRun();
    exit;
  end;
  g_ChrAction := caRun;
  g_nTargetX := g_nMouseCurrX;
  g_nTargetY := g_nMouseCurrY;
end;

procedure TfrmMain.ToggleAutoRun;
begin
  if AutoRunTimer.Enabled Then begin
    AutoRunTimer.Enabled:=False;
    if (g_nRunReadyCount > 0) then g_nRunReadyCount := 0;
    DScreen.AddSysMsg ('[Auto run off]',cllime);
  end else begin
    if (g_Myself <> nil) and (g_Myself.m_boShop = False) then begin
      AutoRunTimer.Enabled:=True;
      DScreen.AddSysMsg('[Auto run on]', cllime);
    end;
  end;
end;

procedure TfrmMain.SocketLock;
begin
  EnterCriticalSection(FCriticalSection);
end;

procedure TfrmMain.SocketUnLock;
begin
  LeaveCriticalSection(FCriticalSection);
end;

initialization
  //OleInitialize(nil);

finalization
  {try
    OleUninitialize;
  except
  end;  }

end.
















