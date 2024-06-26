unit IDDB;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2, MudUtil, ADODB;
resourcestring
  sDBHeaderDesc = '新热血传奇数据库文件 2009/10/26';
  sDBIdxHeaderDesc = '新热血传奇数据库文件 2009/10/26';
type
  TDBHeader = packed record
    sDesc: string[34]; //0x00
    n23: Integer; //0x23
    n28: Integer; //0x27
    n2C: Integer; //0x2B
    n30: Integer; //0x2F
    n34: Integer; //0x33
    n38: Integer; //0x37
    n3C: Integer; //0x3B
    n40: Integer; //0x3F
    n44: Integer; //0x43
    n48: Integer; //0x47
    n4B: Byte; //0x4B
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nIDCount: Integer; //0x68
    n6C: Integer; //0x6C
    nDeletedIdx: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;
  pTDBHeader = ^TDBHeader;

  TIdxHeader = packed record
    sDesc: string[43]; //0x00
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    n5C: Integer; //0x5C
    n60: Integer; //0x60
    nQuickCount: Integer; //0x64
    nIDCount: Integer; //0x68
    nLastIndex: Integer; //0x6C
    dUpdateDate: TDateTime; //0x70
  end;

  TIdxRecord = packed record
    sName: string[11];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;
  //TNotifyEvent = procedure(Sender: TObject) of object;
  TFileIDDB = class
    m_nLastReadIdx: Integer; //0x4  最后访问的记录号
    m_nDeletedIdx: Integer; //0x8  已删除的最后一个记录号
    nC: Integer; //0x0C
    //    w10         :Word;           //0x10
    //    w12         :Word;           //0x12
    //    n14         :Integer;
    m_OnChange: TNotifyEvent;
    m_boChanged: Boolean; //0x18 数据库已被更改
    m_nLastIndex: Integer; //0x1C 最后一次写数据的记录号
    m_dLastDate: TDateTime; //0x20 最后修改日期
    m_nFileHandle: Integer; //0x28
    m_Header: TDBHeader; //0x2C 数据库头
    m_QuickList: TQuickList; //0xA4 数据索引表
    FCriticalSection: TRTLCriticalSection;
  private
    procedure LoadQuickList;
    function GetRecord(sAccountName: String; var DBRecord: TAccountDBRecord): Boolean;
    function UpdateRecord(DBRecord: TAccountDBRecord; boNew: Boolean): Boolean;
  public
    constructor Create(sInstance, sDatabase: String);
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    function Index(sName: string): Integer;
    function Get(sAccountName: String; var DBRecord: TAccountDBRecord): Boolean;
    function FindByName(sName: string; var List: TStringList): Integer;
    function Update(var DBRecord: TAccountDBRecord): Boolean;
    function Add(var DBRecord: TAccountDBRecord): Boolean;
  end;
var
  AccountDB: TFileIDDB;
  Query: TADOQuery;
  sConnection: String;
implementation

uses LSShare, HUtil32;

{ TFileIDDB }
//00457D5C
constructor TFileIDDB.Create(sInstance, sDatabase: String);
begin
  InitializeCriticalSection(FCriticalSection);
  m_nLastReadIdx := 0;
  sConnection := 'Driver={SQL Server Native Client 10.0};Server=' + sInstance + ';Database=' + sDatabase + ';Trusted_Connection=yes;';
  Query := TADOQuery.Create(nil);
  m_QuickList := TQuickList.Create;

  g_n472A6C := 0;
  g_n472A74 := 0;
  g_boDataDBReady := False;
  m_nLastIndex := -1;
  m_nDeletedIdx := -1;

  LoadQuickList();
end;

destructor TFileIDDB.Destroy;
begin
  m_QuickList.Free;
  Query.Free;
  DeleteCriticalSection(FCriticalSection);
end;

procedure TFileIDDB.Lock;
begin
  EnterCriticalSection(FCriticalSection);
end;

procedure TFileIDDB.UnLock;
begin
  LeaveCriticalSection(FCriticalSection);
end;

procedure TFileIDDB.LoadQuickList();
var
  nIndex: Integer;
  n10: Integer;
  DBHeader: TDBHeader;
  DBRecord: TAccountDBRecord;
  DeletedHeader: TRecordDeletedHeader;
  boDeleted: Boolean;
  sAccount: String;
ResourceString
  sSQLString = 'SELECT * FROM TBL_ACCOUNTLIST ORDER BY nIndex';
begin
  boDeleted := False;
  m_nLastReadIdx := 0;
  m_nDeletedIdx := -1;
  g_n472A6C := 0;
  g_n472A70 := 0;
  g_n472A74 := 0;
  m_QuickList.Clear;
  Query.ConnectionString := sConnection;
  lock();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
    g_n472A74 := Query.RecordCount;
    for nIndex := 0 to g_n472A74 - 1 do begin
      Inc(g_n472A6C);

      if Query.FieldByName('Deleted').AsInteger > 0 then
        boDeleted := True;

      if not boDeleted then begin
        sAccount := Query.FieldByName('Account').AsString;
        if sAccount <> '' then begin
          m_QuickList.AddObject(sAccount, TObject(nIndex));
          Inc(g_n472A70);
        end;
      end;
      Query.Next;
      Application.ProcessMessages;
      if Application.Terminated then begin
        Query.Close();
        Exit;
      end;
    end;
  finally
    Query.Close();
  end;
  m_QuickList.SortString(0, m_QuickList.Count - 1);
  m_nLastIndex := g_n472A74;
  m_dLastDate := Now();
  g_boDataDBReady := true;
end;

function TFileIDDB.FindByName(sName: string;
  var List: TStringList): Integer;
var
  I: Integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[I], sName, length(sName)) then begin
      List.AddObject(m_QuickList.Strings[I], m_QuickList.Objects[I]);
    end;
  end;
  Result := List.Count;
end;

function TFileIDDB.GetRecord(sAccountName: String; var DBRecord: TAccountDBRecord): Boolean;
var
  sSQLString: String;
  function GetBoolean(nValue: Integer): Boolean;
  begin
    Result := False;
    if nValue > 0 then
      Result := True;
  end;
begin
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_ACCOUNTLIST WHERE Account=' + quotedstr(sAccountName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    if Query.RecordCount <> 0 then begin
      DBRecord.UserEntry.sAccount := Query.FieldByName('Account').AsString;
      DBRecord.UserEntry.sPassword := Query.FieldByName('AccPassword').AsString;
      DBRecord.UserEntry.sQuiz := Query.FieldByName('Question1').AsString;
      DBRecord.UserEntry.sAnswer := Query.FieldByName('Answer1').AsString;
      DBRecord.UserEntryAdd.sQuiz2 := Query.FieldByName('Question2').AsString;
      DBRecord.UserEntryAdd.sAnswer2 := Query.FieldByName('Answer2').AsString;
      DBRecord.UserEntry.sEMail := Query.FieldByName('Email').AsString;
      DBRecord.nErrorCount := Query.FieldByName('ErrorCount').AsInteger;
      DBRecord.dwActionTick := Query.FieldByName('RetryTime').AsInteger;
      DBRecord.Header.CreateDate := Query.FieldByName('CreationDate').AsDateTime;
      DBRecord.Header.boDeleted := GetBoolean(Query.FieldByName('Deleted').AsInteger);
      DBRecord.UserEntryAdd.sBirthDay := Query.FieldByName('DOB').AsString;
      DBRecord.Header.UpdateDate := Query.FieldByName('ModDate').AsDateTime;
      Result := True;
    end
    else
      Result := False;
  finally
    Query.Close;
  end;
  unlock();
end;

function TFileIDDB.Index(sName: string): Integer;
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileIDDB.Get(sAccountName: String; var DBRecord: TAccountDBRecord): Boolean;
var
  nRecordIndex: Integer;
begin
  Result := false;
  if sAccountName = '' then
    exit;
  Result := GetRecord(sAccountName,DBRecord);
end;

function TFileIDDB.Update(var DBRecord: TAccountDBRecord): Boolean;
begin
  Result := UpdateRecord(DBRecord, False);
end;

function TFileIDDB.Add(var DBRecord: TAccountDBRecord): Boolean;
begin
  if m_QuickList.GetIndex(DBRecord.UserEntry.sAccount) >= 0 then begin
    Result := False;
  end else begin
    if UpdateRecord(DBRecord, True) then begin
      m_QuickList.AddRecord(DBRecord.UserEntry.sAccount, 0);
      Result := True;
    end else begin
      Result := False;
    end;
  end;
end;

function TFileIDDB.UpdateRecord(DBRecord: TAccountDBRecord; boNew: Boolean): Boolean;
var
  sSQLString: String;
  nDeleted: Integer;
begin
  Query.ConnectionString := sConnection;
  nDeleted := 0;
  if boNew then begin
    DBRecord.Header.CreateDate := Now();
    DBRecord.Header.boDeleted := False;
    sSQLString:='Insert INTO TBL_ACCOUNTLIST(Account, AccPassword, Question1, Answer1, Question2, Answer2, Email, ErrorCount, RetryTime, CreationDate, Deleted, DOB, ModDate)' +
    ' VALUES(' + quotedstr(DBRecord.UserEntry.sAccount) + ',' + quotedstr(DBRecord.UserEntry.sPassword) + ',' + quotedstr(DBRecord.UserEntry.sQuiz) + ',' + quotedstr(DBRecord.UserEntry.sAnswer) +
    ',' + quotedstr(DBRecord.UserEntryAdd.sQuiz2) + ',' + quotedstr(DBRecord.UserEntryAdd.sAnswer2) + ',' + quotedstr(DBRecord.UserEntry.sEMail) + ',0,0,' +
    quotedstr(dateForSQL(DBRecord.Header.CreateDate)) + ',' + inttostr(nDeleted) + ',' + quotedstr(DBRecord.UserEntryAdd.sBirthDay) + ',' + quotedstr(dateForSQL(DBRecord.Header.CreateDate)) + ')';
    try
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      MainOutMessage('CreateAccount: An error occured attempting to add this account to the MSSQL database.');
      MainOutMessage(sSQLString);
    end;
  end else begin
    if DBRecord.Header.boDeleted then
      nDeleted := 1;
    
    DBRecord.Header.UpdateDate := Now();
    sSQLString:='Update TBL_ACCOUNTLIST Set ModDate=' + quotedstr(dateForSqL(DBRecord.Header.UpdateDate)) + ',AccPassword=' + quotedstr(DBRecord.UserEntry.sPassword) + ',Deleted=' + IntToStr(nDeleted) + ', ErrorCount=' + IntToStr(DBRecord.nErrorCount) + ', RetryTime=' + inttostr(DBRecord.dwActionTick) + ' WHERE Account=' + quotedstr(DBRecord.UserEntry.sAccount);
    try
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      MainOutMessage('UpdateAccount: An error occured attempting to update this account to the MSSQL database.');
      MainOutMessage(sSQLString);
    end;
  end;
  Result := True;
end;
end.
