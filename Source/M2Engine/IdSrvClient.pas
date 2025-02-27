unit IdSrvClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IniFiles, JSocket, WinSock, Grobal2, Common, SDK, M2Share, ObjPlay;

type
  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private

    TList_2DC: TList;
    IDSrvAddr: string; //0x2E0
    IDSendStr: string;
    IDSrvPort: Integer; //0x2E4
    //    sIDSckStr :String; //0x2E8
    //    boConnected:Boolean;
    dwClearEmptySessionTick: LongWord;
    procedure GetPasswdSuccess(sData: string);
    procedure GetCancelAdmission(sData: string);
    procedure GetCancelAdmissionA(sData: string);
    procedure SetTotalHumanCount(sData: string);
    procedure GetServerLoad(sData: string);
    procedure GetSQLMsg(sData: string);
    procedure GetGameGoldChange(sData: string);
    procedure DelSession(nSessionID: Integer);
    procedure NewSession(sAccount, sIPaddr: string; nSessionID, nUserCDKey, nGameGold, nCheckEMail: Integer);
    procedure ClearSession();
    //    procedure ClearEmptySession();
    procedure SendSocket(sSENDMSG: string);
    procedure SendDelaySocket();
    { Private declarations }
  public
    m_SessionList: TGList; //0x2D8
    procedure Initialize();
    procedure Run();
    procedure SendOnlineHumCountMsg(nCount: Integer);
    procedure SendHumanLogOutMsg(sUserID: string; nID: Integer);
    procedure SendCreateGuildMsg(sMsg: string);
    procedure SendGameGoldChange(sMsg: string);
    procedure SendGetLargessGold(sMsg: string);
    procedure SendGameGoldChangeMsg(PlayObject: TPlayObject; nGoldCount, nLogIndex: Integer; boAdd: Boolean;
      sAppendStr: string);
    function GetAdmission(sAccount, sIPaddr: string; nSessionID: Integer; var nGameGold: Integer;
      var nIDIndex: Integer; var nCheckEMail: Integer): pTSessInfo;
    function GetSessionCount(): Integer;
    //procedure GetSessionList(List: TList);
    procedure SendLogonCostMsg(sAccount: string; nTime: Integer);
    procedure GameGoldChange(PlayObject: TPlayObject; nGoldCount: Integer);
    procedure Close();
    { Public declarations }
  end;
procedure IDSocketThread(ThreadInfo: pTThreadInfo); stdcall;
var
  FrmIDSoc: TFrmIDSoc;

implementation

uses HUtil32;

{$R *.dfm}

{ TFrmIDSoc }

procedure TFrmIDSoc.FormCreate(Sender: TObject);
var
  Conf: TIniFile;
begin
  IDSocket.Host := '';
  if FileExists(sConfigFileName) then begin
    Conf := TIniFile.Create(sConfigFileName);
    if Conf <> nil then begin
      IDSrvAddr := Conf.ReadString('Server', 'IDSAddr', '127.0.0.1');
      IDSrvPort := Conf.ReadInteger('Server', 'IDSPort', 5600);
    end;
    Conf.Free;
  end
  else
    ShowMessage('Configuration file ' + sConfigFileName + ' not found');

  m_SessionList := TGList.Create;
  TList_2DC := TList.Create;
  g_Config.boIDSocketConnected := False;
  //    sub_48D290();
end;

procedure TFrmIDSoc.FormDestroy(Sender: TObject);
begin
  ClearSession();
  m_SessionList.Free;
  TList_2DC.Free;
end;

procedure TFrmIDSoc.Timer1Timer(Sender: TObject);
begin
  if not IDSocket.Active then begin
    IDSocket.Active := True;
  end;
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  IDSendStr := '';
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  EnterCriticalSection(g_Config.UserIDSection);
  try
    g_Config.sIDSocketRecvText := g_Config.sIDSocketRecvText + Socket.ReceiveText;
  finally
    LeaveCriticalSection(g_Config.UserIDSection);
  end;
end;

procedure TFrmIDSoc.Initialize; //0048D3F8
begin
  IDSocket.Active := False;
  IDSocket.Address := IDSrvAddr;
  IDSocket.Port := IDSrvPort;
  IDSocket.Active := True;
  Timer1.Enabled := True;
end;
{$IF IDSOCKETMODE = TIMERENGINE}

procedure TFrmIDSoc.SendSocket(sSENDMSG: string);
begin
  EnterCriticalSection(g_Config.UserIDSection);
  try
    if IDSendStr <> '' then begin
      IDSendStr := IDSendStr + sSendMsg;
    end else begin
      if IDSocket.Socket.SendText(sSendMsg) = - 1 then
        IDSendStr := sSendMsg;
    end;
  finally
    LeaveCriticalSection(g_Config.UserIDSection);
  end;
  {if IDSocket.Socket.Connected then begin
    IDSocket.Socket.SendText(sSENDMSG);
  end;  }
end;
{$ELSE}

procedure TFrmIDSoc.SendSocket(sSENDMSG: string);
var
  boSendData: Boolean;
  Config: pTConfig;                       
  ThreadInfo: pTThreadInfo;
  timeout: TTimeVal;
  writefds: TFDSet;
  nRet: Integer;
  s: TSocket;
begin
  Config := @g_Config;
  ThreadInfo := @g_Config.IDSocketThread;
  s := Config.IDSocket;
  boSendData := False;
  while True do begin
    if not boSendData then
      Sleep(1)
    else
      Sleep(0);
    boSendData := False;
    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 128;

    ThreadInfo.nRunFlag := 129;
    timeout.tv_sec := 0;
    timeout.tv_usec := 20;

    writefds.fd_count := 1;
    writefds.fd_array[0] := s;

    nRet := select(0, nil, @writefds, nil, @timeout);
    if nRet = SOCKET_ERROR then begin
      nRet := WSAGetLastError();
      Config.nIDSocketWSAErrCode := nRet - WSABASEERR;
      Inc(Config.nIDSocketErrorCount);
      if nRet = WSAEWOULDBLOCK then begin
        Continue;
      end;
      if Config.IDSocket = INVALID_SOCKET then
        break;
      Config.IDSocket := INVALID_SOCKET;
      Sleep(100);
      Config.boIDSocketConnected := False;
      break;
    end;
    if nRet <= 0 then begin
      Continue;
    end;
    boSendData := True;
    nRet := Send(s, sSENDMSG[1], Length(sSENDMSG), 0);
    if nRet = SOCKET_ERROR then begin
      Inc(Config.nIDSocketErrorCount);
      Config.nIDSocketWSAErrCode := WSAGetLastError - WSABASEERR;
      Continue;
    end;
    Inc(Config.nDBSocketSendLen, nRet);
    break;
  end;
end;

{$IFEND}

procedure TFrmIDSoc.SendGameGoldChangeMsg(PlayObject: TPlayObject; nGoldCount, nLogIndex: Integer; boAdd: Boolean;
  sAppendStr: string);
resourcestring
  sFormatMsg = '(%d/%d/%s/%s/%d/%s/%d/%d/%d/%s)';
begin
  SendSocket(format(sFormatMsg, [SS_CHANGEGOLD, PlayObject.m_nIDIndex, PlayObject.m_sUserID, PlayObject.m_sCharName,
    nLogIndex, g_Config.sServerName, nGoldCount, Integer(boAdd), PlayObject.m_nDBIndex, sAppendStr]));
end;

procedure TFrmIDSoc.SendGetLargessGold(sMsg: string);
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  SendSocket(format(sFormatMsg, [SS_GETLARGESSGOLD, sMsg]));
end;

procedure TFrmIDSoc.SendGameGoldChange(sMsg: string);
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  SendSocket(format(sFormatMsg, [SS_CHANGEGOLD, sMsg]));
end;

procedure TFrmIDSoc.SendCreateGuildMsg(sMsg: string);
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  SendSocket(format(sFormatMsg, [SS_CREATENEWGUILD, sMsg]));
end;

procedure TFrmIDSoc.SendDelaySocket;
var
  nSendLen: Integer;
  sData: string;
begin
  EnterCriticalSection(g_Config.UserIDSection);
  try
    while IDSendStr <> '' do begin
      nSendLen := Length(IDSendStr);
      if nSendLen > MAXSOCKETBUFFLEN then begin
        sData := Copy(IDSendStr, 1, MAXSOCKETBUFFLEN);
        if IDSocket.Socket.SendText(sData) <> -1 then begin
          IDSendStr := Copy(IDSendStr, MAXSOCKETBUFFLEN + 1, nSendLen - MAXSOCKETBUFFLEN);
        end
        else
          break;
      end
      else begin
        if IDSocket.Socket.SendText(IDSendStr) <> -1 then
          IDSendStr := '';
        break;
      end;
    end;
  finally
    LeaveCriticalSection(g_Config.UserIDSection);
  end;
end;

procedure TFrmIDSoc.SendHumanLogOutMsg(sUserID: string; nID: Integer); //0048D448
{var
  i: Integer;
  SessInfo: pTSessInfo;  }
resourcestring
  sFormatMsg = '(%d/%s/%d)';
begin
  {m_SessionList.Lock;
  try
    for i := 0 to m_SessionList.Count - 1 do begin
      SessInfo := m_SessionList.Items[i];
      if (SessInfo.nSessionID = nID) and (SessInfo.sAccount = sUserID) then begin
        //SessInfo.dwCloseTick:=GetTickCount();
        //SessInfo.boClosed:=True;
        break;
      end;
    end;
  finally
    m_SessionList.UnLock;
  end;          }
  SendSocket(format(sFormatMsg, [SS_SOFTOUTSESSION, sUserID, nID]));
end;

procedure TFrmIDSoc.SendLogonCostMsg(sAccount: string; nTime: Integer);
  //0048D53C
resourcestring
  sFormatMsg = '(%d/%s/%d)';
begin
  SendSocket(format(sFormatMsg, [SS_LOGINCOST, sAccount, nTime]));
end;

procedure TFrmIDSoc.SendOnlineHumCountMsg(nCount: Integer);
resourcestring
  sFormatMsg = '(%d/%s/%d/%d)';
begin
  SendSocket(format(sFormatMsg, [SS_SERVERINFO, g_Config.sServerName, nServerIndex, nCount]));
end;

procedure TFrmIDSoc.Run; //0048D724
var
  sSocketText: string;
  sData: string;
  sBody: string;
  sCode: string;
  //  nLen: Integer;
  Config: pTConfig;
resourcestring
  sExceptionMsg = '[Exception] TFrmIdSoc::DecodeSocStr';
begin
  Config := @g_Config;
  SendDelaySocket;
  EnterCriticalSection(Config.UserIDSection);
  try
    if Config.sIDSocketRecvText <> '' then begin
      if Pos(')', Config.sIDSocketRecvText) <= 0 then Exit;
      sSocketText := Config.sIDSocketRecvText;
      Config.sIDSocketRecvText := '';
    end;
  finally
    LeaveCriticalSection(Config.UserIDSection);
  end;
  try
    while (True) do begin
      sSocketText := ArrestStringEx(sSocketText, '(', ')', sData);
      if sData = '' then break;
      sBody := GetValidStr3(sData, sCode, ['/']);
      case StrToIntDef(sCode, 0) of
        SS_OPENSESSION {100}: GetPasswdSuccess(sBody);
        SS_CLOSESESSION {101}: GetCancelAdmission(sBody);
        SS_KEEPALIVE {104}: SetTotalHumanCount(sBody);
        //UNKNOWMSG: ;
        SS_KICKUSER {111}: GetCancelAdmissionA(sBody);
        SS_SERVERLOAD {113}: GetServerLoad(sBody);
        //SS_CHANGEGOLD: GetGameGoldChange(sBody);
        SS_M2SERVERBACK: GetSQLMsg(sBody);
        SS_M2GAMEGOLDCHANGE: GetGameGoldChange(sBody);
      end;
      if Pos(')', sSocketText) <= 0 then
        break;
    end;
    EnterCriticalSection(Config.UserIDSection);
    try
      Config.sIDSocketRecvText := sSocketText + Config.sIDSocketRecvText;
    finally
      LeaveCriticalSection(Config.UserIDSection);
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  if GetTickCount - dwClearEmptySessionTick > 10000 then begin
    dwClearEmptySessionTick := GetTickCount();
    //ClearEmptySession();
  end;
{$IFDEF RELEASE}
  if IsDebuggerPresent then
    Application.Terminate;
{$ENDIF}
end;

procedure TFrmIDSoc.GetPasswdSuccess(sData: string); //0048D9B4
var
  sAccount: string;
  sSessionID: string;
  //sPayCost: string;
  sIPaddr: string;
  //sPayMode: string;
  sUserCDKey: string;
  sGameGold: string;
  sCheckEMail: string;
resourcestring
  sExceptionMsg = '[Exception] TFrmIdSoc::GetPasswdSuccess';
begin
  try
    sData := GetValidStr3(sData, sAccount, ['/']);
    sData := GetValidStr3(sData, sSessionID, ['/']);
    sData := GetValidStr3(sData, sUserCDKey, ['/']); //boPayCost
    sData := GetValidStr3(sData, sGameGold, ['/']); //nPayMode
    sData := GetValidStr3(sData, sCheckEMail, ['/']); //nPayMode
    sData := GetValidStr3(sData, sIPaddr, ['/']); //sIPaddr
    NewSession(sAccount, sIPaddr, StrToIntDef(sSessionID, 0), StrToIntDef(sUserCDKey, 0), StrToIntDef(sGameGold, 0), StrToIntDef(sCheckEMail, 0));
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TFrmIDSoc.GetCancelAdmission(sData: string); //0048DB60
var
  SC, sSessionID: string;
resourcestring
  sExceptionMsg = '[Exception] TFrmIdSoc::GetCancelAdmission';
begin
  try
    sSessionID := GetValidStr3(sData, SC, ['/']);
    DelSession(StrToIntDef(sSessionID, 0));
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TFrmIDSoc.NewSession(sAccount, sIPaddr: string; nSessionID, nUserCDKey, nGameGold, nCheckEMail: Integer); //0048DC44
var
  SessInfo: pTSessInfo;
begin
  New(SessInfo);
  SessInfo.sAccount := sAccount;
  SessInfo.sIPaddr := sIPaddr;
  SessInfo.nSessionID := nSessionID;
  SessInfo.nPayMent := 0;
  SessInfo.nPayMode := 0;
  SessInfo.nUserCDKey := nUserCDKey;
  SessInfo.nGameGold := nGameGold;
  SessInfo.nCheckEMail := nCheckEMail;
  SessInfo.nSessionStatus := 0;
  SessInfo.dwStartTick := GetTickCount();
  SessInfo.dwActiveTick := GetTickCount();
  SessInfo.nRefCount := 1;
  m_SessionList.Lock;
  try
    m_SessionList.Add(SessInfo);
  finally
    m_SessionList.UnLock;
  end;
end;

procedure TFrmIDSoc.DelSession(nSessionID: Integer); //0048DD5C
var
  i: Integer;
  sAccount: string;
  SessInfo: pTSessInfo;
resourcestring
  sExceptionMsg = '[Exception] FrmIdSoc::DelSession %d';
begin
  try
    sAccount := '';
    m_SessionList.Lock;
    try
      for i := m_SessionList.Count - 1 downto 0 do begin //for i := 0 to m_SessionList.Count - 1 do begin
        SessInfo := m_SessionList.Items[i];
        if SessInfo.nSessionID = nSessionID then begin
          sAccount := SessInfo.sAccount;
          m_SessionList.Delete(i);
          DisPose(SessInfo);
          break;
        end;
      end;
    finally
      m_SessionList.UnLock;
    end;
    if sAccount <> '' then begin
      RunSocket.KickUser(sAccount, nSessionID);
    end;
  except
    on E: Exception do begin
      MainOutMessage(format(sExceptionMsg, [0]));
      MainOutMessage(E.Message);
    end;
  end;
end;

{procedure TFrmIDSoc.ClearEmptySession;
var
  i: Integer;
  SessInfo: pTSessInfo;
begin
  m_SessionList.Lock;
  try
    for i := m_SessionList.Count - 1 downto 0 do begin
      SessInfo := m_SessionList.Items[i];
      if SessInfo.nRefCount <= 0 then begin
        DisPose(SessInfo);
        m_SessionList.Delete(i);
        Continue;
      end;
      {
      if GetTickCount - SessInfo.dwActiveTick > 10 * 60 * 1000 then begin
        Dispose(SessInfo);
        m_SessionList.Delete(I);
        Continue;
      end;

    end;
  finally
    m_SessionList.UnLock;
  end;
end;         }

procedure TFrmIDSoc.ClearSession;
var
  i: Integer;
begin
  m_SessionList.Lock;
  try
    for i := 0 to m_SessionList.Count - 1 do begin
      DisPose(pTSessInfo(m_SessionList.Items[i]));
    end;
    m_SessionList.Clear;
  finally
    m_SessionList.UnLock;
  end;
end;

function TFrmIDSoc.GetAdmission(sAccount, sIPaddr: string; nSessionID: Integer;
   var nGameGold: Integer; var nIDIndex: Integer; var nCheckEMail: Integer): pTSessInfo; //0048DE80
var
  i: Integer;
  //  nCount: Integer;
  SessInfo: pTSessInfo;
  boFound: Boolean;
resourcestring
  sGetFailMsg = '[Illegal login] Global session validation failure(%s/%s/%d)';
begin
  //  Result:=3;
  //  exit;
  boFound := False;
  Result := nil;
  //nPayMent := 0;
  //nPayMode := 0;
  m_SessionList.Lock;
  try
    for i := 0 to m_SessionList.Count - 1 do begin
      SessInfo := m_SessionList.Items[i];
      if (SessInfo.nSessionID = nSessionID) and
        (SessInfo.sAccount = sAccount) {and (SessInfo.sIPaddr = sIPaddr)} then begin
        //if SessInfo.nSessionStatus <> 0 then break;
        //SessInfo.nSessionStatus:=1;
        {case SessInfo.nPayMent of
          2: nPayMent := 3;
          1: nPayMent := 2;
          0: nPayMent := 1;
        end;   }
        nIDIndex := SessInfo.nUserCDKey;
        nGameGold := SessInfo.nGameGold;
        nCheckEMail := SessInfo.nCheckEMail;
        Result := SessInfo;
        //nPayMode := SessInfo.nPayMode;
        boFound := True;
        break;
      end;
    end;
  finally
    m_SessionList.UnLock;
  end;
  if g_Config.boViewAdmissionFailure and not boFound then begin
    MainOutMessage(format(sGetFailMsg, [sAccount, sIPaddr, nSessionID]));
  end;
end;

procedure TFrmIDSoc.SetTotalHumanCount(sData: string); //0048E014
begin
  g_nTotalHumCount := StrToIntDef(sData, 0)
end;

procedure TFrmIDSoc.GetCancelAdmissionA(sData: string); //0048E06C
var
  nSessionID: Integer;
  sSessionID: string;
  sAccount: string;
resourcestring
  sExceptionMsg = '[Exception] FrmIdSoc::GetCancelAdmissionA';
begin
  try
    sSessionID := GetValidStr3(sData, sAccount, ['/']);
    nSessionID := StrToIntDef(sSessionID, 0);
    if not g_Config.boTestServer then begin
      //UserEngine.HumanExpire(sAccount);
      DelSession(nSessionID);
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TFrmIDSoc.GetGameGoldChange(sData: string);
var
  sAccount, sGameGold: string;
  nGameGold: Integer;
  SessInfo: pTSessInfo;
  I: Integer;
  boSession: Boolean;
  PlayObject: TPlayObject;
begin
  sGameGold := GetValidStr3(sData, sAccount, ['/']);
  nGameGold := StrToIntDef(sGameGold, -1);
  if (sAccount <> '') and (nGameGold >= 0) then begin
    boSession := False;
    m_SessionList.Lock;
    try
      for i := m_SessionList.Count - 1 downto 0 do begin //for i := 0 to m_SessionList.Count - 1 do begin
        SessInfo := m_SessionList.Items[i];
        if SessInfo.sAccount = sAccount then begin
          SessInfo.nGameGold := nGameGold;
          boSession := True;
          break;
        end;
      end;
    finally
      m_SessionList.UnLock;
    end;
    if boSession then begin
      EnterCriticalSection(ProcessHumanCriticalSection);
      Try
        for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
          PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
          if (PlayObject <> nil) and (not PlayObject.m_boGhost) and (PlayObject.m_sUserID = sAccount) then begin
            PlayObject.m_nGamePoint := nGameGold;
            PlayObject.GameGoldChanged;
            break;
          end;
        end;
      Finally
        LeaveCriticalSection(ProcessHumanCriticalSection);
      End;
    end;
  end;
end;

procedure TFrmIDSoc.GetSQLMsg(sData: string);
var
  sWaitID, sDBIndex, sIdent: String;
  PlayObject: TPlayObject;
  wIdent: Word;
begin
  sData := GetValidStr3(sData, sWaitID, ['/']);
  sData := GetValidStr3(sData, sDBIndex, ['/']);
  sData := GetValidStr3(sData, sIdent, ['/']);
  wIdent := StrToIntDef(sIdent, 0);
  PlayObject := GetLoginPlay(StrToIntDef(sDBIndex, -1));
  if (PlayObject <> nil) then begin
    if (PlayObject.m_nWaitIndex <> 0) and (PlayObject.m_nWaitIndex = StrToIntDef(sWaitID, 0)) then
      PlayObject.SendMsg(PlayObject, wIdent, Integer(PlayObject.m_nSQLAppendBool), PlayObject.m_nWaitIndex,
        PlayObject.m_nSQLAppendCount, PlayObject.m_nSQLAppendShopIndex,
        sData + '/' + PlayObject.m_nSQLAppendString);
    PlayObject.m_nWaitIndex := 0;
    PlayObject.m_nSQLAppendCount := 0;
    PlayObject.m_nSQLAppendShopIndex := 0;
    PlayObject.m_nSQLAppendString := '';
    PlayObject.m_nSQLAppendBool := False;
  end;
end;

procedure TFrmIDSoc.GameGoldChange(PlayObject: TPlayObject; nGoldCount: Integer);
var
  SessInfo: pTSessInfo;
  i: integer;
begin
  if PlayObject <> nil then begin
    if nGoldCount <> -1 then begin
      m_SessionList.Lock;
      try
        for i := 0 to m_SessionList.Count - 1 do begin
          SessInfo := pTSessInfo(m_SessionList[i]);
          if (SessInfo.nSessionID = PlayObject.m_nSessionID) and
            (SessInfo.nUserCDKey = PlayObject.m_nIDIndex) then begin
            SessInfo.nGameGold := nGoldCount;
            break;
          end;
        end;
      finally
        m_SessionList.UnLock;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.GetServerLoad(sData: string); //0048E174
var
  SC, s10, s14, s18, s1C: string;
begin
  sData := GetValidStr3(sData, SC, ['/']);
  sData := GetValidStr3(sData, s10, ['/']);
  sData := GetValidStr3(sData, s14, ['/']);
  sData := GetValidStr3(sData, s18, ['/']);
  sData := GetValidStr3(sData, s1C, ['/']);
  nCurrentMonthly := StrToIntDef(SC, 0);
  nLastMonthlyTotalUsage := StrToIntDef(s10, 0);
  nTotalTimeUsage := StrToIntDef(s14, 0);
  nGrossTotalCnt := StrToIntDef(s18, 0);
  nGrossResetCnt := StrToIntDef(s1C, 0);
end;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_Config.boIDSocketConnected := True;
  MainOutMessage('LoginSrv(' + Socket.RemoteAddress + ':' +
    IntToStr(Socket.RemotePort) + ')Connected...');
  IDSendStr := '';
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if g_Config.boIDSocketConnected then begin
    ClearSession();
    g_Config.boIDSocketConnected := False;
    MainOutMessage('LoginSrv(' + Socket.RemoteAddress + ':' +
      IntToStr(Socket.RemotePort) + ')Disconnected...');
    IDSendStr := '';
  end;
end;
{$IF IDSOCKETMODE = TIMERENGINE}

procedure TFrmIDSoc.Close;
begin
  Timer1.Enabled := False;
  IDSocket.Active := False;
end;
{$ELSE}

procedure TFrmIDSoc.Close;
var
  ThreadInfo: pTThreadInfo;
begin
  ThreadInfo := @g_Config.IDSocketThread;
  ThreadInfo.boTerminaled := True;
  if WaitForSingleObject(ThreadInfo.hThreadHandle, 1000) <> 0 then begin
    SuspendThread(ThreadInfo.hThreadHandle);
  end;
end;
{$IFEND}

function TFrmIDSoc.GetSessionCount: Integer;
begin
  //  Result := 0;
  m_SessionList.Lock;
  try
    Result := m_SessionList.Count;
  finally
    m_SessionList.UnLock;
  end;
end;
{
procedure TFrmIDSoc.GetSessionList(List: TList);
var
  i: Integer;
begin
  m_SessionList.Lock;
  try
    for i := 0 to m_SessionList.Count - 1 do begin
      List.Add(m_SessionList.Items[i]);
    end;
  finally
    m_SessionList.UnLock;
  end;
end;    }

procedure IDSocketRead(Config: pTConfig);
var
  dwReceiveTimeTick: LongWord;
  nReceiveTime: Integer;
  sRecvText: string;
  nRecvLen: Integer;
  nRet: Integer;
begin
  if Config.IDSocket = INVALID_SOCKET then Exit;

  dwReceiveTimeTick := GetTickCount();
  nRet := ioctlsocket(Config.IDSocket, FIONREAD, nRecvLen);
  if (nRet = SOCKET_ERROR) or (nRecvLen = 0) then begin
    WSAGetLastError;
    Config.IDSocket := INVALID_SOCKET;
    Sleep(100);
    Config.boIDSocketConnected := False;
    Exit;
  end;
  setlength(sRecvText, nRecvLen);
  nRecvLen := recv(Config.IDSocket, Pointer(sRecvText)^, nRecvLen, 0);
  setlength(sRecvText, nRecvLen);

  Inc(Config.nIDSocketRecvIncLen, nRecvLen);
  if (nRecvLen <> SOCKET_ERROR) and (nRecvLen > 0) then begin
    if nRecvLen > Config.nIDSocketRecvMaxLen then
      Config.nIDSocketRecvMaxLen := nRecvLen;
    EnterCriticalSection(Config.UserIDSection);
    try
      Config.sIDSocketRecvText := Config.sIDSocketRecvText + sRecvText;
    finally
      LeaveCriticalSection(Config.UserIDSection);
    end;
    FrmIDSoc.Run;
  end;
  Inc(Config.nIDSocketRecvCount);
  nReceiveTime := GetTickCount - dwReceiveTimeTick;
  if Config.nIDReceiveMaxTime < nReceiveTime then
    Config.nIDReceiveMaxTime := nReceiveTime;
end;

procedure IDSocketProcess(Config: pTConfig; ThreadInfo: pTThreadInfo);
var
  s: TSocket;
  Name: sockaddr_in;
  HostEnt: PHostEnt;
  argp: LongInt;
  readfds: TFDSet;
  timeout: TTimeVal;
  nRet: Integer;
  boRecvData: BOOL;
  nRunTime: Integer;
  dwRunTick: LongWord;
  boShow: Boolean;
resourcestring
  sIDServerConnected = 'LoginSrv(%s:%d)Connected...';
  sIDServerDisconnect = 'LoginSrv(%s:%d)Disconnected...';
begin
  s := INVALID_SOCKET;
  if Config.IDSocket <> INVALID_SOCKET then
    s := Config.IDSocket;
  dwRunTick := GetTickCount();
  ThreadInfo.dwRunTick := dwRunTick;
  boRecvData := False;
  boShow := False;
  while True do begin
    if ThreadInfo.boTerminaled then
      break;
    if not boRecvData then
      Sleep(1)
    else
      Sleep(0);
    boRecvData := False;
    nRunTime := GetTickCount - ThreadInfo.dwRunTick;
    if ThreadInfo.nRunTime < nRunTime then
      ThreadInfo.nRunTime := nRunTime;
    if ThreadInfo.nMaxRunTime < nRunTime then
      ThreadInfo.nMaxRunTime := nRunTime;
    if GetTickCount - dwRunTick >= 1000 then begin
      dwRunTick := GetTickCount();
      if ThreadInfo.nRunTime > 0 then
        Dec(ThreadInfo.nRunTime);
    end;

    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 125;
    if (Config.IDSocket = INVALID_SOCKET) or (s = INVALID_SOCKET) then begin
      if Config.IDSocket <> INVALID_SOCKET then begin
        Config.IDSocket := INVALID_SOCKET;
        Sleep(100);
        ThreadInfo.nRunFlag := 126;
        Config.boIDSocketConnected := False;
      end;
      if s <> INVALID_SOCKET then begin
        closesocket(s);
        s := INVALID_SOCKET;
      end;
      if Config.sIDSAddr = '' then
        Continue;

      s := Socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
      if s = INVALID_SOCKET then
        Continue;

      ThreadInfo.nRunFlag := 127;

      HostEnt := gethostbyname(PChar(@Config.sIDSAddr[1]));
      if HostEnt = nil then
        Continue;

      PInteger(@Name.sin_addr.S_addr)^ := PInteger(HostEnt.h_addr^)^;
      Name.sin_family := HostEnt.h_addrtype;
      Name.sin_port := htons(Config.nIDSPort);
      Name.sin_family := PF_INET;

      ThreadInfo.nRunFlag := 128;
      if connect(s, Name, SizeOf(Name)) = SOCKET_ERROR then begin
        WSAGetLastError;
         if boShow then begin
          boShow := False;
          MainOutMessage(format(sIDServerDisconnect, [Config.sIDSAddr, Config.nIDSPort]));
         end;
        closesocket(s);
        s := INVALID_SOCKET;
        Continue;
      end;

      argp := 1;
      if ioctlsocket(s, FIONBIO, argp) = SOCKET_ERROR then begin
        closesocket(s);
        s := INVALID_SOCKET;
        Continue;
      end;
      ThreadInfo.nRunFlag := 129;
      Config.IDSocket := s;
      Config.boIDSocketConnected := True;
      if not boShow then begin
        boShow := True;
        MainOutMessage(format(sIDServerConnected, [Config.sIDSAddr, Config.nIDSPort]));
      end;
    end;
    readfds.fd_count := 1;
    readfds.fd_array[0] := s;
    timeout.tv_sec := 0;
    timeout.tv_usec := 20;
    ThreadInfo.nRunFlag := 130;
    nRet := select(0, @readfds, nil, nil, @timeout);
    if nRet = SOCKET_ERROR then begin
      ThreadInfo.nRunFlag := 131;
      nRet := WSAGetLastError;
      if nRet = WSAEWOULDBLOCK then begin
        Sleep(10);
        Continue;
      end;
      ThreadInfo.nRunFlag := 132;
      nRet := WSAGetLastError;
      Config.nIDSocketWSAErrCode := nRet - WSABASEERR;
      Inc(Config.nIDSocketErrorCount);
      Config.IDSocket := INVALID_SOCKET;
      Sleep(100);
      Config.boIDSocketConnected := False;
      closesocket(s);
      s := INVALID_SOCKET;
      Continue;
    end;
    boRecvData := True;
    ThreadInfo.nRunFlag := 133;
    while (nRet > 0) do begin
      IDSocketRead(Config);
      Dec(nRet);
    end;
  end;
  if Config.IDSocket <> INVALID_SOCKET then begin
    Config.IDSocket := INVALID_SOCKET;
    Config.boIDSocketConnected := False;
  end;
  if s <> INVALID_SOCKET then begin
    closesocket(s);
  end;
end;

procedure IDSocketThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '[Exception] IDSocketThread ErrorCount = %d';
begin
  nErrorCount := 0;
  while True do begin
    try
      IDSocketProcess(ThreadInfo.Config, ThreadInfo);
      break;
    except
      Inc(nErrorCount);
      if nErrorCount > 10 then
        break;
      MainOutMessage(format(sExceptionMsg, [nErrorCount]));
    end;
  end;
  ExitThread(0);
end;

end.
