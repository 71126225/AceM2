unit HumDB;

interface
uses
  Windows, Dialogs, Classes, SysUtils, Forms, MudUtil, Grobal2, ADODB;
const
  MAX_STATUS_ATTRIBUTE = 12;
  MAXPATHLEN = 255;
  DIRPATHLEN = 80;
  MapNameLen = 16;
  ActorNameLen = 14;

  sDBHeaderDesc = 'New Mir database file 2011/06/14';
  sDBIdxHeaderDesc = sDBHeaderDesc;

type
  TDBHeader = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
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
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nHumCount: Integer; //0x68
    n6C: Integer; //0x6C
    n70: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;
  pTDBHeader = ^TDBHeader;

  TIdxHeader = packed record //Size 124
    sDesc: string[39]; //0x00
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
    n60: Integer; //0x60  95
    n70: Integer; //0x70  99
    nQuickCount: Integer; //0x74  100
    nHumCount: Integer; //0x78
    nDeleteCount: Integer; //0x7C
    nLastIndex: Integer; //0x80
    dUpdateDate: TDateTime; //0x84
  end;
  pTIdxHeader = ^TIdxHeader;

  THumInfo = packed record //Size 72
    Header: TRecordHeader;
    sChrName: string[ActorNameLen]; //0x14  //角色名称   44
    sAccount: string[16]; //账号
    boDeleted: Boolean; //是否删除
    boGMDeleted: Boolean; //是否管理员禁止
    boSelected: Boolean; //是否选择
    dModDate: TDateTime;
    btCount: Byte; //操作计次
  end;
  pTHumInfo = ^THumInfo;

  TIdxRecord = record
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileHumDB = class
    n4: Integer; //0x04
    m_nFileHandle: Integer; //0x08
    n0C: Integer; //0x0C
    m_OnChange: TNotifyEvent;

    m_boChanged: Boolean; //0x18
    m_Header: TDBHeader; //0x1C
    m_QuickList: TQuickList; //0x98
    m_QuickIDList: TQuickIDList; //0x9C
    m_DeletedList: TList; //0xA0 已被删除的记录号

  private
    procedure LoadQuickList;
    procedure UpdateDB();
    procedure BackupDB();
    procedure Lock;
    procedure UnLock;
    function UpdateRecord(HumRecord: THumInfo; boNew: Boolean):
      Boolean;
    function GetRecord(sCharName: String; var HumDBRecord: THumInfo): Boolean;

  public
    constructor Create();
    destructor Destroy; override;
    function DeleteRecord(sChrName: String): Boolean;
    function Index(sName: string): Integer;
    function Get(sCharName: String; var HumDBRecord: THumInfo): Boolean;
    function GetBy(sChrName: String; var HumDBRecord: THumInfo): Boolean;
    function FindByName(sChrName: string; ChrList: TStringList): Integer;
    function FindByAccount(sAccount: string; var ChrList: TStringList): Integer;
    function ChrCountOfAccount(sAccount: string): Integer;
    function Add(HumRecord: THumInfo): Boolean;
    function Delete(sName: string): Boolean;
    function Count(): Integer;
    function Update(var HumDBRecord: THumInfo): Boolean;

  end;

  TFileDB = class
    n4: Integer; //0x4
    m_nFileHandle: Integer; //0x08
    nC: Integer;
    //    m_OnChange: TNotifyEvent; //0x10
    m_boChanged: Boolean; //0x18
    m_nLastIndex: Integer; //0x1C
    m_dUpdateTime: TDateTime; //0x20
    m_Header: TDBHeader; //0x28
    m_QuickList: TQuickList; //0xA4
    m_DeletedList: TList; //0xA8 已被删除的记录号
    m_sDBFileName: string; //0xAC
    m_sIdxFileName: string; //0xB0
  private
    procedure LoadQuickList;
    function AddNewRecord(nIndex:integer;HumanRCD:THumDataInfo):Boolean;
    function GetRecord(nIndex: Integer; var HumanRCD: THumDataInfo): Boolean;
    function GetRecordHeader(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function UpdateRecord(nIndex: Integer; var HumanRCD: THumDataInfo; boNew: Boolean): Boolean;
    function updateItem(Item: TUserItem;sTableName, sCharName: string; nPosition: integer; nGridIdx: integer=0): boolean;
    procedure GetItem(var target: TUserItem);
    //Sams SQL Getter and Setters...
    function GetStatusArray(sChrName: String; var HumanRCD: THumDataInfo): Boolean;

    function getHumItems(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateHumItems(var HumanRCD: THumDataInfo): Boolean;

    function getReturnItems(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateReturnItems(var HumanRCD: THumDataInfo): Boolean;

    function getBagItems(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateBagItems(var HumanRCD: THumDataInfo): Boolean;

    function getStorageItems(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateStorageItems(var HumanRCD: THumDataInfo): Boolean;

    function getAppendItems(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateAppendItems(var HumanRCD: THumDataInfo): Boolean;

    function getMagic(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateMagic(var HumanRCD: THumDataInfo): Boolean;

    function getFriend(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateFriend(var HumanRCD: THumDataInfo): Boolean;

    function getAbility(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateAbility(var HumanRCD: THumDataInfo): Boolean;

    function getProfile(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateProfile(var HumanRCD: THumDataInfo): Boolean;

    function getOptions(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateOptions(var HumanRCD: THumDataInfo): Boolean;

    function getKeyInfo(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateKeyInfo(var HumanRCD: THumDataInfo): Boolean;

    function getMaster(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateMaster(var HumanRCD: THumDataInfo): Boolean;

    function getQuestFlag(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateQuestFlag(var HumanRCD: THumDataInfo): Boolean;

    function getMission(sChrName: String; var HumanRCD: THumDataInfo): Boolean;
    function updateMission(var HumanRCD: THumDataInfo): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    function DeleteRecord(index:integer): Boolean;
    function Index(sName: string): Integer;
    function Get(nIndex: Integer; var HumanRCD: THumDataInfo): Integer;
    function Update(nIndex: Integer; var HumanRCD: THumDataInfo): Boolean;
    function Add(var HumanRCD: THumDataInfo): Boolean;
    function Find(sChrName: string; List: TStrings): Integer;
    function Count(): Integer;
    function Delete(sChrName: string): Boolean; overload;
    function Delete(nIndex: Integer): Boolean; overload;
  end;
var
  HumChrDB: TFileHumDB;
  HumDataDB: TFileDB;
  Query: TADOQuery;
  sConnection: String;
  AdoConnection : TADOConnection;
  ADOCommand : TADOCommand;
implementation

uses DBShare, HUtil32, OldMirDB, DBSMain;

{ TFileHumDB }

constructor TFileHumDB.Create();
begin
  m_QuickList := TQuickList.Create;
  m_QuickIDList := TQuickIDList.Create;
  m_DeletedList := TList.Create;
  n4ADAFC := 0;
  n4ADB04 := 0;
  boHumDBReady := False;
  sConnection := 'Driver={SQL Server Native Client 10.0};Server=' + sSQLInstance + ';Database=' + sSQLDBServer + ';Trusted_Connection=yes;';
  try
    AdoConnection:=TADOConnection.Create(nil);
    AdoConnection.LoginPrompt:=False;//dont ask for the login parameters
    AdoConnection.ConnectionString:=sConnection;
    AdoConnection.Connected:=True; //open the connection
//    ADOCommand:=TADOCommand.Create(nil);
//    ADOCommand.Connection:=AdoConnection;
  except
    on e: Exception do
      MainOutMessage(e.Message);
  end;
  Query := DBSMain.FrmDBSrv.Query;
  UpdateDB();

  LoadQuickList();
end;

destructor TFileHumDB.Destroy;
begin
  m_QuickList.Free;
  m_QuickIDList.Free;
  ADOCommand.Free;
  if AdoConnection.Connected then
    AdoConnection.Close;
  AdoConnection.Free;
  inherited;
end;

procedure TFileHumDB.Lock();
begin
  EnterCriticalSection(HumDB_CS);
end;

procedure TFileHumDB.UnLock(); //0x0048B888

    var
      i: TObject;begin
  LeaveCriticalSection(HumDB_CS);
end;

procedure TFileHumDB.LoadQuickList();
//0x48BA64
var
  nIndex: Integer;
  AccountList: TStringList;
  ChrNameList: TStringList;
ResourceString
  sSQLString = 'SELECT * FROM TBL_CHARLIST ORDER BY nIndex';
begin
  try
  n4 := 0;
  m_QuickList.Clear;
  m_QuickIDList.Clear;
  m_DeletedList.Clear;
  n4ADAFC := 0;
  n4ADB00 := 0;
  n4ADB04 := 0;
  AccountList := TStringList.Create;
  ChrNameList := TStringList.Create;
  Query.ConnectionString := sConnection;
  lock();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
    n4ADB04 := Query.RecordCount;
    for nIndex := 0 to n4ADB04 - 1 do begin
      Inc(n4ADAFC);
      m_QuickList.AddObject(Query.FieldByName('CharName').AsString, TObject(nIndex));
      AccountList.AddObject(Query.FieldByName('Account').AsString, TObject(Query.FieldByName('SelectID')));
      ChrNameList.AddObject(Query.FieldByName('CharName').AsString, TObject(nIndex));
      Inc(n4ADB00);
      Query.Next;
      Application.ProcessMessages;
      if Application.Terminated then begin
        Query.Close;
        Exit;
      end;
    end;
  finally
    Query.Close();
  end;
  unlock();
  for nIndex := 0 to AccountList.Count - 1 do begin
    m_QuickIDList.AddRecord(AccountList.Strings[nIndex],
      ChrNameList.Strings[nIndex],
      Integer(ChrNameList.Objects[nIndex]),
      Integer(AccountList.Objects[nIndex]));
    if (nIndex mod 100) = 0 then
      Application.ProcessMessages;
  end;
  //0x0048BCF4
  AccountList.Free;
  ChrNameList.Free;
  m_QuickList.SortString(0, m_QuickList.Count - 1);
  boHumDBReady := True;
  except
    on e: Exception do
      MainOutMessage('[LoadQuickList] ' + e.Message);
  end;
end;

procedure TFileHumDB.BackupDB;
var
  TheTime: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  sFileName:string;
begin
  sFileName:= ExtractFilePath(Application.ExeName) + 'DB\';
  if not DirectoryExists(sFileName) then begin
    createdir(sFileName);
  end;
  TheTime := now();
  DecodeDate(TheTime, Year, Month, Day);
  DecodeTime(TheTime, Hour, Min, Sec, MSec);
  sFileName:=format(sFileName + '%S-%d-%d-%d,%d-%d.bak',[sSQLDBServer,year,month,day,hour,min]);
  try
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.CommandText:=format('BACKUP DATABASE %s TO DISK = ''%s''',[sSQLDBServer,sFileName]);
      ADOCommand.Execute;
    except

    end;
  finally
    ADOCommand.Free;
  end;
  if FileExists(sfileName) then
    ShowMessage('Database ' +  sSQLDBServer + ' has been backed up at ' + sFileName)
  else begin
    //a problem with making a db backup, dont continue to run update code now :
    ShowMessage('Failed to backup database ' + sSQLDBServer + ' at: ' + sFileName);
    FrmDBSrv.m_boRemoteClose := true;
    FrmDBSrv.Close;
  end;
end;

procedure TFileHumDB.UpdateDB;
  procedure Updatetov0();
  var
    sInput, sInput2: string;
     i,j, k: integer;
     sSqlString: string;
    //questflag table
    QuestFlag: TQuestFlag;
    MissionFlag: TMissionFlag;
    MissionArithmometer: TMissionArithmometer;
    MissionIndex: TMissionIndex;
    QuestFlags, MissionFlags, MissionArithmometers, MissionIndexs: array of byte;
    //charinfo table
    MagicList:TCboMagicListInfo;
    CustomVariable:THumCustomVariable;
    MakeMagic:TMakeMagic;
    MagicListArr,CustomVariableArr,MakeMagicArr: array of byte;
    //useritem/bagtable table
    btvalue:TUserItemValueArray;
    temp1: array[0..48] of Byte;
    Flute: array[0..MAXFLUTECOUNT - 1] of Word;
    StrengthenInfo: TUserItemValueArray;
    btvalues,temp1s,flutes,StrengthenInfos: array of byte;
    sTableNames: array[0..4] of string;
    //charprofile
    photodata: array[0..MAXPHOTODATASIZE] of byte;
    photodatas: array of byte;
  begin
    //create version table
    sSqlString := 'CREATE TABLE Tbl_Version (Version int);';
    try
      Query.ConnectionString := sConnection;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      on e: Exception do
        MainOutMessage(e.Message);
    end;
    //questflag table
    //make binary fields so we can store the questflags and stuff in binary instead of x-x-x-x-
    sSqlString := 'ALTER TABLE Tbl_charquest ADD QuestFlags binary(' + inttostr(SizeOf(TQuestFlag))
    + '), MissionFlags binary(' + inttostr(SizeOf(TMissionFlag))
    + '), MissionAriths binary(' + inttostr(SizeOf(TMissionArithmometer))
    + '), MissionIndexs binary(' + inttostr(SizeOf(TMissionIndex)) + ');';
    try
      Query.ConnectionString := sConnection;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      on e: Exception do
        MainOutMessage(e.Message);
    end;
    //load the old questflag data and convert it to new data
    sSqlString := 'select Charname, QuestFlag, MissionFlag, MissionArith, MissionIndex from Tbl_Charquest;';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
      for i := 0 to Query.RecordCount - 1 do begin
        //read old questflags
        sInput := Query.FieldByName('QuestFlag').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          sInput:=GetValidStr3(sInput,sInput2,['-']);
          if Length(sInput2) > 0 then begin
            QuestFlag[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(QuestFlag) then break;
          end;
        end;
        //read old missionflags
        sInput := Query.FieldByName('MissionFlag').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          sInput := GetValidStr3(sInput,sInput2,['-']);
          if Length(sInput2) > 0 then begin
            MissionFlag[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(MissionFlag) then break;
          end;
        end;
        //read old missionarith
        sInput := Query.FieldByName('MissionArith').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          sInput := GetValidStr3(sInput,sInput2,['-']);
          if Length(sInput2) > 0 then begin
            MissionArithmometer[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(MissionArithmometer) then break;
          end;
        end;
        //read old missionindex
        sInput := Query.FieldByName('MissionIndex').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          sInput := GetValidStr3(sInput,sInput2,['-']);
          if Length(sInput2) > 0 then begin
            MissionIndex[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(MissionIndex) then break;
          end;
        end;
        //convert them to byte arrays
        SetLength(QuestFlags, Length(QuestFlag));
        SetLength(MissionFlags, Length(MissionFlag));
        SetLength(MissionArithMometers, Length(MissionArithMometer));
        SetLength(MissionIndexs, Length(MissionIndex));
        for j := 0 to length(QuestFlag) - 1 do
          QuestFlags[j] := QuestFlag[j];
        for j := 0 to length(MissionFlags) - 1 do
          MissionFlags[j] := MissionFlag[j];
        for j := 0 to length(MissionArithMometer) - 1 do
          MissionArithMometers[j] := MissionArithMometer[j];
        for j := 0 to length(MissionIndex) - 1 do
          MissionIndexs[j] := MissionIndex[j];

        //now make the update string (and run it)
        sSqlString:='Update Tbl_CharQuest set QuestFlags=:QuestFlags, MissionFlags=:MissionFlags, MissionAriths=:MissionAriths, MissionIndexs=:MissionIndexs where CharName=''' +  Query.FieldByName('CharName').AsString + ''';';
        try
          ADOCommand:=TADOCommand.Create(nil);
          ADOCommand.Connection:=AdoConnection;
          ADOCommand.Parameters.Clear;
          ADOCommand.CommandText:=sSqlString;
          ADOCommand.ParamCheck:=False;
          ADOCommand.Parameters.ParamByName('QuestFlags').Value:= QuestFlags;
          ADOCommand.Parameters.ParamByName('MissionFlags').Value:= MissionFlags;
          ADOCommand.Parameters.ParamByName('MissionAriths').Value := MissionArithMometers;
          ADOCommand.Parameters.ParamByName('MissionIndexs').Value := MissionIndexs;
          ADOCommand.Execute;
        finally
          ADOCommand.Free;
        end;

        Query.Next;
      end;
    finally
      Query.Close;
    end;
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := 'ALTER TABLE Tbl_CharQuest DROP COLUMN QuestFlag;';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'EXEC sp_RENAME  ''Tbl_CharQuest.[QuestFlags]'',''QuestFlag'';';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'ALTER TABLE Tbl_CharQuest DROP COLUMN MissionFlag;';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'EXEC sp_RENAME  ''Tbl_CharQuest.[MissionFlags]'',''MissionFlag'';';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'ALTER TABLE Tbl_CharQuest DROP COLUMN MissionArith;';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'EXEC sp_RENAME  ''Tbl_CharQuest.[MissionAriths]'',''MissionArith'';';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'ALTER TABLE Tbl_CharQuest DROP COLUMN MissionIndex;';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'EXEC sp_RENAME  ''Tbl_CharQuest.[MissionIndexs]'',''MissionIndex'';';
      ADOCommand.Execute;
    finally
      ADOCommand.Free;
    end;



     //charlist table
     sSqlString := 'ALTER TABLE TBL_CHARINFO ADD MagicLists binary(' + inttostr(SizeOf(MagicList.MagicList))
    + '), CustomVariables binary(' + inttostr(SizeOf(CustomVariable))
    + '), MakeMagics binary(' + inttostr(SizeOf(MakeMagic)) + ');';
    try
      Query.ConnectionString := sConnection;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      on e: Exception do
        MainOutMessage(e.Message);
    end;
    //load
    sSqlString := 'select MagicList,CustomVariable,MakeMagic, nidx from TBL_CHARINFO;';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
      for i := 0 to Query.RecordCount - 1 do begin
        sInput := Query.FieldByName('MagicList').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          if Length(sInput2) > 0 then begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            MagicList.MagicList[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(MagicList.MagicList) then break;
          end;
        end;
        {//pointless to read them since old code is saving negative values split by '-' signs lol
        sInput := Query.FieldByName('CustomVariable').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          if Length(sInput2) > 0 then begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            CustomVariable[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(CustomVariable) then break;
          end;
        end;
        }
        sInput := Query.FieldByName('MakeMagic').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          if Length(sInput2) > 0 then begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            MakeMagic[j] := StrToInt(sInput2);
            inc(j);
          if j >= Length(MakeMagic) then break;
          end;
        end;
        //convert them to byte arrays
        SetLength(MagicListArr, Length(MagicList.MagicList));
        SetLength(CustomVariableArr, Length(CustomVariable)*4); //integers take 4 bytes to make a whole :(
        SetLength(MakeMagicArr, Length(MakeMagic));
        for j := 0 to length(MagicList.MagicList) - 1 do
          MagicListArr[j] := MagicList.MagicList[j];
        for j := 0 to length(CustomVariable) - 1 do begin
          CustomVariableArr[j*4] := LoByte(LoWord(CustomVariable[j]));
          CustomVariableArr[1+j*4] := HiByte(LoWord(CustomVariable[j]));
          CustomVariableArr[2+j*4] := LoByte(HiWord(CustomVariable[j]));
          CustomVariableArr[3+j*4] := LoByte(HiWord(CustomVariable[j]));
        end;
        for j := 0 to length(MakeMagic) - 1 do
          MakeMagicArr[j] := MakeMagic[j];
        //next save it back
        //now make the update string (and run it)
        sSqlString:='Update TBL_CHARINFO set MagicLists=:MagicLists, CustomVariables=:CustomVariables, MakeMagics=:MakeMagics where nidx=' +  IntToStr(Query.FieldByName('nidx').AsInteger) + ';';
        try
          ADOCommand:=TADOCommand.Create(nil);
          ADOCommand.Connection:=AdoConnection;
          ADOCommand.Parameters.Clear;
          ADOCommand.CommandText:=sSqlString;
          ADOCommand.ParamCheck:=False;
          ADOCommand.Parameters.ParamByName('MagicLists').Value:= MagicListArr;
          ADOCommand.Parameters.ParamByName('CustomVariables').Value:= CustomVariableArr;
          ADOCommand.Parameters.ParamByName('MakeMagics').Value := MakeMagicArr;
          ADOCommand.Execute;
        finally
          ADOCommand.Free;
        end;
        Query.Next;
      end;
    finally
      Query.Close;
    end;
     try
       ADOCommand:=TADOCommand.Create(nil);
        ADOCommand.Connection:=AdoConnection;
        ADOCommand.Parameters.Clear;
        ADOCommand.ParamCheck:=False;
        ADOCommand.CommandText := 'ALTER TABLE TBL_CHARINFO DROP COLUMN MagicList;';
        ADOCommand.Execute;
        ADOCommand.CommandText := 'EXEC sp_RENAME  ''TBL_CHARINFO.[MagicLists]'',''MagicList'';';
        ADOCommand.Execute;
        ADOCommand.CommandText := 'ALTER TABLE TBL_CHARINFO DROP COLUMN CustomVariable;';
        ADOCommand.Execute;
        ADOCommand.CommandText := 'EXEC sp_RENAME  ''TBL_CHARINFO.[CustomVariables]'',''CustomVariable'';';
        ADOCommand.Execute;
        ADOCommand.CommandText := 'ALTER TABLE TBL_CHARINFO DROP COLUMN MakeMagic;';
        ADOCommand.Execute;
        ADOCommand.CommandText := 'EXEC sp_RENAME  ''TBL_CHARINFO.[MakeMagics]'',''MakeMagic'';';
        ADOCommand.Execute;
     finally
        ADOCommand.Free;
     end;


    sTableNames[0]:='Tbl_HumItems';
    sTableNames[1]:='Tbl_BagItems';
    sTableNames[2]:='Tbl_StoreItems';
    sTableNames[3]:='Tbl_AppendItems';
    sTableNames[4]:='Tbl_ReturnItems';
    for k := 0 to Length(sTableNames) - 1 do begin
      sSqlString := 'ALTER TABLE ' + sTableNames[k] + ' ADD Valuearr binary(' + inttostr(SizeOf(btvalue))
      + '), temp1s binary(' + inttostr(SizeOf(temp1))
      + '), flutes binary(' + inttostr(SizeOf(flute))
      + '), StrengthInfos binary(' + inttostr(SizeOf(Strengtheninfo)) + ');';
      try
        Query.ConnectionString := sConnection;
        Query.SQL.Clear;
        Query.SQL.Add(sSQLString);
        Query.ExecSQL;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
      sSqlString := 'SELECT value,temp1,flute,strengthinfo,charname,makeindex FROM ' + sTableNames[k] + ' ;';
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.Open;
        for i := 0 to Query.RecordCount - 1 do begin
          sInput := Query.FieldByName('Value').AsString;
          j:=0;
            while Length(sInput) <> 0 do begin
              sInput:=GetValidStr3(sInput,sInput2,['-']);
              if Length(sInput2) > 0 then begin
                btValue[j] := StrToInt(sInput2);
                inc(j);
                if j >= Length(btValue) then break;
              end;
          end;
          sInput := Query.FieldByName('temp1').AsString;
          j:=0;
          while Length(sInput) <> 0 do begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            if Length(sInput2) > 0 then begin
              temp1[j] := StrToInt(sInput2);
              inc(j);
              if j >= Length(temp1) then break;
            end;
          end;
          sInput := Query.FieldByName('flute').AsString;
          j:=0;
          while Length(sInput) <> 0 do begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            if Length(sInput2) > 0 then begin
              Flute[j] := StrToInt(sInput2);
              inc(j);
              if j >= Length(Flute) then break;
            end;
          end;
          sInput := Query.FieldByName('StrengthInfo').AsString;
          j:=0;
          while Length(sInput) <> 0 do begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            if Length(sInput2) > 0 then begin
              StrengthenInfo[j] := StrToInt(sInput2);
              inc(j);
              if j >= Length(StrengthenInfo) then break;
            end;
          end;
          //convert them to byte arrays
          SetLength(btvalues, Length(btvalue));
          SetLength(temp1s, Length(temp1));
          SetLength(Flutes, Length(Flute)*2);//words take 2 bytes
          SetLength(StrengthenInfos, Length(StrengthenInfo));
          for j := 0 to length(btvalue) - 1 do
            btvalues[j] := btvalue[j];
          for j := 0 to length(Flute) - 1 do begin
            Flutes[j*2] := LoByte(Flute[j]);
            Flutes[1+j*2] := HiByte(Flute[j]);
          end;
          for j := 0 to length(temp1) - 1 do
            temp1s[j] := temp1[j];
          for j := 0 to length(StrengthenInfo) - 1 do
            StrengthenInfos[j] := StrengthenInfo[j];
          //next save it back
          //now make the update string (and run it)
          sSqlString:='Update ' + sTableNames[k] + ' set valuearr=:values, temp1s=:temp1s, flutes=:flutes, StrengthInfos=:Strengthinfos where makeindex=' +  Query.FieldByName('makeindex').AsString + ' and CharName= ''' + Query.FieldByName('CharName').AsString +''';';
          try
            ADOCommand:=TADOCommand.Create(nil);
            ADOCommand.Connection:=AdoConnection;
            ADOCommand.Parameters.Clear;
            ADOCommand.CommandText:=sSqlString;
            ADOCommand.ParamCheck:=False;
            ADOCommand.Parameters.ParamByName('values').Value:= btvalues;
            ADOCommand.Parameters.ParamByName('temp1s').Value:= temp1s;
            ADOCommand.Parameters.ParamByName('flutes').Value := flutes;
            ADOCommand.Parameters.ParamByName('Strengthinfos').Value := StrengthenInfos;
            ADOCommand.Execute;
          finally
            ADOCommand.Free;
          end;
          Query.Next;
        end;
      finally
        Query.Close;
      end;
        try
          ADOCommand:=TADOCommand.Create(nil);
          ADOCommand.Connection:=AdoConnection;
          ADOCommand.Parameters.Clear;
          ADOCommand.ParamCheck:=False;
          ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' DROP COLUMN value;';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' DROP COLUMN temp1;';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' DROP COLUMN flute;';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' DROP COLUMN StrengthInfo;';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'EXEC sp_RENAME  ''' + sTableNames[k] + '.[valuearr]'',''value'';';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'EXEC sp_RENAME  ''' + sTableNames[k] + '.[temp1s]'',''temp1'';';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'EXEC sp_RENAME  ''' + sTableNames[k] + '.[flutes]'',''flute'';';
          ADOCommand.Execute;
          ADOCommand.CommandText := 'EXEC sp_RENAME  ''' + sTableNames[k] + '.[StrengthInfos]'',''StrengthInfo'';';
          ADOCommand.Execute;
        finally
          ADOCommand.Free;
        end;
    end;




    //charprofile
    sSqlString := 'ALTER TABLE TBL_CharProfile ADD pPhotoDatas binary(' + inttostr(SizeOf(photodata)) + ');';
    try
      Query.ConnectionString := sConnection;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      on e: Exception do
        MainOutMessage(e.Message);
    end;
    //load
    sSqlString := 'select pPhotoData, CharName from TBL_CharProfile;';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
      for i := 0 to Query.RecordCount - 1 do begin
      { //original code never did this so there's no data to start with lol
        sInput := Query.FieldByName('pPhotoData').AsString;
        j:=0;
        while Length(sInput) <> 0 do begin
          if Length(sInput2) > 0 then begin
            sInput := GetValidStr3(sInput,sInput2,['-']);
            photodata[j] := StrToInt(sInput2);
            inc(j);
            if j >= Length(photodata) then break;
          end;
        end;
      }
        //convert to var array
        SetLength(photodatas,length(photodata));
        for j := 0 to length(photodata) - 1 do
          photodatas[j] := photodata[j];

        //next save it back
        //now make the update string (and run it)
        sSqlString:='Update TBL_CharProfile set pPhotoDatas=:photodata where CharName=''' +  Query.FieldByName('CharName').AsString + ''';';
        try
          ADOCommand:=TADOCommand.Create(nil);
          ADOCommand.Connection:=AdoConnection;
          ADOCommand.Parameters.Clear;
          ADOCommand.CommandText:=sSqlString;
          ADOCommand.ParamCheck:=False;
          ADOCommand.Parameters.ParamByName('photodata').Value:= photodatas;
          ADOCommand.Execute;
        finally
          ADOCommand.Free;
        end;
        Query.Next;
      end;
    finally
      Query.Close;
    end;
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := 'ALTER TABLE TBL_CharProfile DROP COLUMN pPhotoData;';
      ADOCommand.Execute;
      ADOCommand.CommandText := 'EXEC sp_RENAME  ''TBL_CharProfile.[pPhotoDatas]'',''pPhotoData'';';
      ADOCommand.Execute;
    finally
      ADOCommand.Free;
    end;
  end;

  procedure Updatetov1();
  var
    sSqlString: string;
  begin
    try
      //sSqlString := 'Update Tbl_Version set Version = 1';
      //lol i forgot to set the version number in first update so this fixes it :p
      sSqlString := 'Insert into Tbl_Version (Version) values(1);';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    //using mainmakeindex to identify the horse items original 'horse' item
    sSqlString := 'CREATE TABLE Tbl_HorseItems (' +
    'MainMakeindex integer not null, MakeIndex integer not null, wIndex integer,Dura integer, ' +
    'btBindMode1 smallint, btBindMode2 smallint, TermTime bigint, ' +
    'btAC smallint, btMAC smallint, btDC smallint, btHP smallint, '
    + 'CONSTRAINT KeyIndex PRIMARY KEY (MainMakeIndex,MakeIndex));';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;

  procedure Updatetov2();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=2;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    //using mainmakeindex to identify the horse items original 'horse' item
    sSqlString := 'ALTER TABLE TBL_HorseItems ADD nposition tinyint;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;

    procedure Updatetov3();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=3;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    //using mainmakeindex to identify the horse items original 'horse' item
    sSqlString := 'ALTER TABLE TBL_StoreItems ADD nGridIdx tinyint;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;

  procedure Updatetov4();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=4;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    //Update to add new Status column for EnergyShield
    sSqlString := 'ALTER TABLE tbl_statusarray ADD Status12 int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;
  procedure Updatetov5();
  var
    sSqlString: string;
    sTableNames: array[0..4] of string;
    k: integer;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=5;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;

    sTableNames[0]:='Tbl_HumItems';
    sTableNames[1]:='Tbl_BagItems';
    sTableNames[2]:='Tbl_StoreItems';
    sTableNames[3]:='Tbl_AppendItems';
    sTableNames[4]:='Tbl_ReturnItems';
    for k := 0 to Length(sTableNames) - 1 do begin
      try
        ADOCommand:=TADOCommand.Create(nil);
        ADOCommand.Connection:=AdoConnection;
        ADOCommand.Parameters.Clear;
        ADOCommand.ParamCheck:=False;
        ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' ALTER COLUMN value binary(30);';
        ADOCommand.Execute;
      finally
        ADOCommand.Free;
      end
    end;
  end;
  procedure Updatetov6();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=6;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    //Update to add new Status column for EnergyShield
    sSqlString := 'ALTER TABLE tbl_charinfo ADD StorageGold int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;
  procedure Updatetov7();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=7;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    try
      sSqlString := 'ALTER TABLE Tbl_CharInfo ALTER COLUMN nAllowSetup bigint;';;
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;
  procedure Updatetov8();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=8;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    try
      sSqlString := 'ALTER TABLE tbl_hummagic ALTER COLUMN TranPoint bigint;';;
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    try
      sSqlString := 'ALTER TABLE tbl_hummagic ALTER COLUMN Interv bigint;';;
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;
  procedure Updatetov9();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=9;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_hummagic ADD idx2 int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'update tbl_hummagic set idx2=Idx;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_hummagic DROP COLUMN Idx;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'EXEC sp_RENAME  ''tbl_hummagic.[idx2]'',''Idx'';';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;

  procedure Updatetov10();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=10;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_charmission DROP COLUMN Idx;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_charmission ADD nidx int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_charkeyinfo DROP COLUMN Idx;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_charkeyinfo ADD idx int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_charmaster ADD idx int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_charfriend ADD idx int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_returnitems ADD idx int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE tbl_appenditems ADD idx int;';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;
    procedure Updatetov11();
  var
    sSqlString: string;
    sTableNames: array[0..4] of string;
    k: integer;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=11;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sTableNames[0]:='Tbl_HumItems';
    sTableNames[1]:='Tbl_BagItems';
    sTableNames[2]:='Tbl_StoreItems';
    sTableNames[3]:='Tbl_AppendItems';
    sTableNames[4]:='Tbl_ReturnItems';
    for k := 0 to Length(sTableNames) - 1 do begin
      try
        ADOCommand:=TADOCommand.Create(nil);
        ADOCommand.Connection:=AdoConnection;
        ADOCommand.Parameters.Clear;
        ADOCommand.ParamCheck:=False;
        ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' DROP COLUMN Exp, Hp, Lvl, MaxExp, AliveTime, Bind, MapDesc, MapName, CurrX, CurrY;';
        ADOCommand.Execute;
      finally
        ADOCommand.Free;
      end;
      try
        ADOCommand:=TADOCommand.Create(nil);
        ADOCommand.Connection:=AdoConnection;
        ADOCommand.Parameters.Clear;
        ADOCommand.ParamCheck:=False;
        ADOCommand.CommandText := 'ALTER TABLE ' + sTableNames[k] + ' REBUILD';
        ADOCommand.Execute;
      finally
        ADOCommand.Free;
      end;
    end;
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := 'DROP TABLE Tbl_HorseItems;';
      ADOCommand.Execute;
    finally
      ADOCommand.Free;
    end;
  end;
  procedure Updatetov12();
  var
    sSqlString: string;
  begin
    try
      sSqlString := 'Update Tbl_Version set Version=12;';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
        ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
    sSqlString := 'ALTER TABLE [tbl_charinfo] ALTER COLUMN [sGuildName] varchar(17);';
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.ParamCheck:=False;
      ADOCommand.CommandText := sSqlString;
      try
      ADOCommand.Execute;
      except
        on e: Exception do
          MainOutMessage(e.Message);
      end;
    finally
      ADOCommand.Free;
    end;
  end;

var
  nVersion: integer;
  sSqlString: string;
  //note: in theory you cant use the Txxx variables cause those might change,
  //would have to use custom array sizes or custom variables with this exact db version to make sure you can convert

ResourceString
  sSQLVersionString = 'SELECT * FROM Tbl_Version';
begin

  nVersion := -1;//default 
  Query.ConnectionString := sConnection;
  lock();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLVersionString);
  try  // dont think i can do a finaly + except in one try so
    try //test if the version table even excists
      Query.Open;
      nVersion:=Query.FieldByName('Version').AsInteger;
    except
       on e: Exception do begin
         if AnsiPos('Invalid object name ', e.Message) > 0 then
          //the table doesnt excist yet so technicaly version -1 :p
          nVersion := -1;
      end;
    end;
  finally
    Query.Close();
  end;
  try
    if (nVersion < 0) then begin
      //if we are on version -1 then make a version table
      //backup the excisting db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update adds the tbl_version
      // converts alot of huge string fields to simple binary fields (and converts the data
      Updatetov0();
    end;
    if (nVersion < 1) then begin
      //backup the excisting db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update adds the tbl_horseitems
      Updatetov1();
    end;
    if (nVersion < 2) then begin
      //backup the excisting db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update adds the position field to tbl_horseitems
      Updatetov2();
    end;
    if (nVersion < 3) then begin
      //backup the excisting db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update adds the ngrididx field to tbl_storeitems
      Updatetov3();
    end;
    if (nVersion < 4) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update adds the Status12 field to tbl_StatusArray
      Updatetov4();
    end;
    if (nVersion < 5) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update increases the btvalues field on items (freeze and poison stats)
      Updatetov5();
    end;
    if (nVersion < 6) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update adds the storagegold value to charinfo table
      Updatetov6();
    end;
    if (nVersion < 7) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update turns nallowsetup in tbl_charinfo into a bigint
      Updatetov7();
    end;
    if (nVersion < 8) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update edits the size of 2 values in hummagic table to bigint
      Updatetov8();
    end;
    if (nVersion < 9) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update replaces the auto increment index of hummagic with a manual one
      Updatetov9();
    end;
    if (nVersion < 10) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update replaces auto increment index's with manual ones
      Updatetov10();
    end;
    if (nVersion < 11) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //this update deletes all the double fields on item stats + horseitem table
      Updatetov11();
    end;
    if (nVersion < 12) then begin
      //backup the existing db
      BackupDB();
      if FrmDBSrv.m_boRemoteClose then exit;//if we failed to backup dont run update code!
      //Increases sGuildName length to 30
      Updatetov12();
    end;
  except
    on e: Exception do
      MainOutMessage(e.Message);
  end;
  unlock();
end;

function TFileHumDB.Count: Integer;
begin
  try
    Result := m_QuickList.Count;
  except
    on e: Exception do
      MainOutMessage('[Count] ' + e.Message);
  end;
end;

function TFileHumDB.Index(sName: string): Integer;
begin
  try
    Result := m_QuickList.GetIndex(sName);
  except
    on e: Exception do
      MainOutMessage('[Index] ' + e.Message);
  end;
end;

function TFileHumDB.Get(sCharName: String; var HumDBRecord: THumInfo): Boolean;
begin
  try
    Result := false;
    if sCharName = '' then
      exit;
    Result := GetRecord(sCharName,HumDBRecord);
  except
    on e: Exception do
      MainOutMessage('[Get] ' + e.Message);
  end;
end;

function TFileHumDB.GetRecord(sCharName: String; var HumDBRecord: THumInfo): Boolean;
var
  sSQLString : String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARLIST WHERE CharName=' + quotedstr(sCharName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    if Query.RecordCount <> 0 then begin
      HumDBRecord.sAccount := Query.FieldByName('Account').AsString;
      HumDBRecord.sChrName := Query.FieldByName('CharName').AsString;
      HumDBRecord.boDeleted := getBoolean(Query.FieldByName('Deleted').AsInteger);
      HumDBRecord.boGMDeleted := getBoolean(Query.FieldByName('GMDeleted').AsInteger);
      HumDBRecord.boSelected := getBoolean(Query.FieldByName('Selected').AsInteger);
      HumDBRecord.dModDate := Query.FieldByName('ModDate').AsDateTime;
      HumDBRecord.Header.nSelectID := Query.FieldByName('SelectID').AsInteger;
      Result := True;
    end
    else
      Result := False;
  finally
    Query.Close;
  end;
  unlock();
except
on e: Exception do
  MainOutMessage('[GetRecord] ' + e.Message);
end;
end;

function TFileHumDB.FindByName(sChrName: string; ChrList: TStringList): Integer; //0x0048C3E0
var
  i: Integer;
begin
try
  for i := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[i], sChrName, Length(sChrName)) then begin
      ChrList.AddObject(m_QuickList.Strings[i], m_QuickList.Objects[i]);
    end;
  end;
  Result := ChrList.Count;
except
on e: Exception do
  MainOutMessage('[FindByName] ' + e.Message);
end;
end;

function TFileHumDB.GetBy(sChrName: String; var HumDBRecord: THumInfo): Boolean; //0x0048C118
begin
try
  Result := Get(sChrName, HumDBRecord);
except
on e: Exception do
  MainOutMessage('[GetBy] ' + e.Message);
end;
end;

function TFileHumDB.FindByAccount(sAccount: string; var ChrList: TStringList): Integer; //0x0048C4DC
var
  ChrNameList: TList;
  QuickID: pTQuickID;
  i: Integer;
begin
try
  ChrNameList := nil;
  m_QuickIDList.GetChrList(sAccount, ChrNameList);
  if ChrNameList <> nil then begin
    for i := 0 to ChrNameList.Count - 1 do begin
      QuickID := ChrNameList.Items[i];
      ChrList.AddObject(QuickID.sAccount, TObject(QuickID));
    end;
  end;
  Result := ChrList.Count;
except
on e: Exception do
  MainOutMessage('[FindByAccount] ' + e.Message);
end;
end;

function TFileHumDB.ChrCountOfAccount(sAccount: string): Integer; //0x0048C5B0
var
  sSQLString : String;
begin
try
  sSQLString := 'SELECT CharName FROM TBL_CHARLIST Where Account=' + quotedstr(sAccount) + ' AND Deleted=0';
  Query.ConnectionString := sConnection;
  lock();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
    Result := Query.RecordCount;
  finally
    Query.Close;
  end;
  unlock();
except
on e: Exception do
  MainOutMessage('[ChrCountOfAccount] ' + e.Message);
end;
end;

function TFileHumDB.Add(HumRecord: THumInfo): Boolean; //0x0048C1F4
begin
try
  if m_QuickList.GetIndex(HumRecord.sChrName) >= 0 then
    Result := false
  else begin
    if UpdateRecord(HumRecord, True) then begin
      m_QuickList.AddRecord(HumRecord.sChrName,0);
      m_QuickIDList.AddRecord(HumRecord.sAccount, HumRecord.sChrName, m_QuickList.Count, HumRecord.Header.nSelectID);
      Result := True;
    end else begin
      Result := False;
    end;
  end;
except
on e: Exception do
  MainOutMessage('[Add] ' + e.Message);
end;
end;

function TFileHumDB.UpdateRecord(HumRecord: THumInfo;
  boNew: Boolean): Boolean; //0x0048BF5C
var
  nSelected, nDeleted: Integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  nSelected := 0;
  nDeleted := 0;
  if boNew then begin
    HumRecord.boDeleted := False;
    HumRecord.dModDate := Now();
    if HumRecord.boSelected then
      nSelected := 1;

    sSQLString:='Insert INTO TBL_CHARLIST(CharName, Account, ModDate, SelectID, Deleted, Selected)' +
    ' VALUES(' + quotedstr(HumRecord.sChrName)+ ',' + quotedstr(HumRecord.sAccount) + ',' + quotedstr(dateForSQL(Now())) + ',' + IntToStr(HumRecord.Header.nSelectID) + ',0,' + IntToStr(nSelected) + ')';
    try
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
      MainOutMessage('A problem has occured adding a new character to the database.');
      MainOutMessage(sSQLString);
    end;
  end else begin
    HumRecord.dModDate := Now();

    if HumRecord.boDeleted then
      nDeleted := 1;
    if HumRecord.boSelected then
      nSelected := 1;

    sSQLString:='Update TBL_CHARLIST Set ModDate=' + quotedstr(dateForSqL(Now())) + ',SelectID=' + IntToStr(HumRecord.Header.nSelectID) + ',Deleted=' + IntToStr(nDeleted) + ', Selected=' + IntToStr(nSelected) + ' WHERE CharName=' + quotedstr(HumRecord.sChrName);
    try
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      Query.ExecSQL;
    except
    on e: Exception do
      MainOutMessage('[Error Updating Chara: ] ' + e.Message);
    end;
  end;
  Result := True;
except
on e: Exception do
  MainOutMessage('[UpdateRecord] ' + e.Message);
end;
end;

function TFileHumDB.Delete(sName: string): Boolean; //0x0048BDE0
begin
try
  Result := DeleteRecord(sName);
except
on e: Exception do
  MainOutMessage('[Delete] ' + e.Message);
end;
end;

function TFileHumDB.DeleteRecord(sChrName: String): Boolean; //0x0048BD58
var
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString:='Update TBL_CHARLIST Set ModDate=' + quotedstr(dateForSQL(Now())) + ',Deleted=1 WHERE CharName=' + quotedstr(sChrName);
    try
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.Open;
        Query.ExecSQL;
      finally
        Query.Close;
      end;
    except
      MainOutMessage('There has been as issue with deleting this character: ' + sChrName);
    end;
  Result := True;
except
on e: Exception do
  MainOutMessage('[DeleteRecord] ' + e.Message);
end;
end;

function TFileHumDB.Update(var HumDBRecord: THumInfo): Boolean;
begin
try
  Result := UpdateRecord(HumDBRecord, false);
except
on e: Exception do
  MainOutMessage('[Update] ' + e.Message);
end;
end;

{ TFileDB }

constructor TFileDB.Create(); //0x0048A0F4
begin
  n4 := 0;
  boDataDBReady := False;
  m_QuickList := TQuickList.Create;
  m_DeletedList := TList.Create;
  n4ADAE4 := 0;
  n4ADAF0 := 0;
  sConnection := 'Driver={SQL Server Native Client 10.0};Server=' + sSQLInstance + ';Database=' + sSQLDBServer + ';Trusted_Connection=yes;';
  m_nLastIndex := -1;
  CheckFileVer(m_sDBFileName);
  LoadQuickList();
end;

destructor TFileDB.Destroy;
begin
  if boDataDBReady then
  m_QuickList.Free;
  m_DeletedList.Free;
  inherited;
end;

procedure TFileDB.LoadQuickList; //0x0048A440
var
  i, nIndex: Integer;
  sSQLString, sCharName: string;
begin
try
  n4 := 0;
  m_QuickList.Clear;
  m_DeletedList.Clear;
  n4ADAE4 := 0;
  n4ADAE8 := 0;
  n4ADAF0 := 0;
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT nIdx,sChrName FROM Tbl_charinfo Order by nIdx';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    nIndex := 0;
    for i := 0 to Query.RecordCount - 1 do begin
      sCharName := Query.FieldByName('sChrName').AsString;
      nIndex := Query.FieldByName('nIdx').AsInteger;
      m_QuickList.AddObject(sCharName, TObject(nIndex));
      inc(n4ADAE8);
      Query.Next
    end;
  finally
    Query.Close;
  end;
  unlock();
  m_QuickList.SortString(0,m_QuickList.Count -1);
  m_nLastIndex:=nIndex;
  boDataDBReady:=True;
except
  on e: Exception do
    MainOutMessage('[LoadQuickList] ' + e.Message);
end;
end;

procedure TFileDB.Lock; //00048A254
begin
  EnterCriticalSection(HumDB_CS);
end;

procedure TFileDB.UnLock; //0048A268
begin
  LeaveCriticalSection(HumDB_CS);
end;

function TFileDB.Index(sName: string): Integer; //0x0048B534
begin
try
  Result := m_QuickList.GetIndex(sName);
except
  on e: Exception do
    MainOutMessage('[Index] ' + e.Message);
end;
end;

function TFileDB.Get(nIndex: Integer; var HumanRCD: THumDataInfo): Integer;
//0x0048B320
var
  nIdx: Integer;
begin
try
  nIdx := Integer(m_QuickList.Objects[nIndex]);
  if GetRecord(nIdx, HumanRCD) then
    Result := nIdx
  else
    Result := -1;
except
  on e: Exception do
    MainOutMessage('[TFileDB Get] ' + e.Message);
end;
end;

function TFileDB.Update(nIndex: Integer;
  var HumanRCD: THumDataInfo): Boolean; //0x0048B36C
begin
try
  Result := False;
  if (nIndex >= 0) and (m_QuickList.Count > nIndex) then
    if UpdateRecord(Integer(m_QuickList.Objects[nIndex]), HumanRCD, False) then
      Result := True;
except
  on e: Exception do
    MainOutMessage('[TFileDB Update] ' + e.Message);
end;
end;

function TFileDB.Add(var HumanRCD: THumDataInfo): Boolean; //0x0048B3E0
var
  sHumanName :String;
  nIdx       :Integer;
  mResult: Boolean;
begin
try
  nIdx := 0;
  mResult := false;
  try
    sHumanName:=HumanRCD.Header.sName;
    if m_QuickList.GetIndex(sHumanName) >= 0 then begin
      mResult:=False;
    end else begin
      Inc(m_nLastIndex);
      nIdx:=m_nLastIndex;
    end;
    AddNewRecord(nIdx,HumanRCD);
    m_QuickList.AddRecord(HumanRCD.Header.sName,nIdx);
    mResult:=True;
  except
    MainOutMessage('FileDB add Error');
  end;
  Result := mResult;
except
  on e: Exception do
    MainOutMessage('[TFileDB Add] ' + e.Message);
end;
end;

function TFileDB.AddNewRecord(nIndex:integer;HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: string;
  master, storagelock, addstabpoint, changename: Integer;
  store2, store3: Integer;
  MagicList,MakeMagic,CustomVariable: array of byte;
begin
try
  master := 0;
  storagelock := 0;
  addstabpoint := 0;
  changename := 0;
  store2 := 0;
  store3 := 0;
  if HumanRCD.Data.boMaster then
    master := 1;
  if HumanRCD.Data.boStorageLock then
    storagelock := 1;
  if HumanRCD.Data.boAddStabilityPoint then
    addstabpoint := 1;
  if HumanRCD.Data.boChangeName then
    changename := 1;
  if HumanRCD.Data.StorageOpen2 then
    store2 := 1;
  if HumanRCD.Data.StorageOpen3 then
    store3 := 1;

  SetLength(MagicList,Length(HumanRCD.Data.CboMagicListInfo.MagicList));
  for i:= 0 to Length(HumanRCD.Data.CboMagicListInfo.MagicList)-1 do
    MagicList[i]:=HumanRCD.Data.CboMagicListInfo.MagicList[i];

  SetLength(MakeMagic,Length(HumanRCD.Data.MakeMagic));
  for i:= 0 to Length(HumanRCD.Data.MakeMagic)-1 do
    MakeMagic[i]:=HumanRCD.Data.MakeMagic[i];

  SetLength(CustomVariable,Length(HumanRCD.Data.CustomVariable)*4);
  for i:= 0 to ((Length(HumanRCD.Data.CustomVariable) div 4)-1) do begin //4bytes for an integer here
    CustomVariable[i*4]:=LoByte(LoWord(HumanRCD.Data.CustomVariable[i]));
    CustomVariable[1+i*4]:=HiByte(LoWord(HumanRCD.Data.CustomVariable[i]));
    CustomVariable[2+i*4]:=LoByte(HiWord(HumanRCD.Data.CustomVariable[i]));
    CustomVariable[3+i*4]:=HiByte(HiWord(HumanRCD.Data.CustomVariable[i]));
  end;

  Query.ConnectionString := sConnection;
  with HumanRCD.Data do begin
    sSQLString := 'Insert INTO Tbl_CharInfo(nIdx, sChrName, sCurMap, wCurX, wCurY, btDir, btHair, btSex, btJob, nGold, nBindGold,' +
      'nNakedAbilCount, sHomeMap, wHomeX, wHomeY, sDieMap, wDieX, wDieY, sDearName, LoginTime, LoginAddr, btCreditPoint, sStoragePwd,' +
      'boMaster, boStorageLock, btStorageErrorCount, StorageLockTime, btReLevel, nGameGold, nGamePoint, nGameDiamond, nGameGird, nPKPoint,' +
      'nPullulation, btAttatckMode, nIncHealth, nIncSpell, nIncHealing, btFightZoneDieCount, sAccount, sGuildName, wContribution, dBodyLuck,' +
      'wGuildRcallTime, wGroupRcallTime, nAllowSetup, boAddStabilityPoint, btMasterCount, btWuXin, boChangeName, nExpRate, nExpTime,' +
      'dwUpLoadPhotoTime, wNakedBackCount, nItemsSetupCount, MagicList, nMagicList, MakeMagicPoint, CustomVariable, MakeMagic, StorageOpen2, StorageTime2, ' +
      'StorageOpen3, StorageTime3) ' +
    'VALUES(' + inttostr(nIndex) + ',' + quotedstr(sChrName) + ',' + quotedstr(sCurMap) + ',' + inttostr(wCurX) + ',' + inttostr(wCurY) + ',' +
      inttostr(btDir) + ',' + inttostr(btHair) + ',' + inttostr(btSex) + ',' + inttostr(btJob) + ',' + inttostr(nGold) + ',' + inttostr(nBindGold) + ',' +
      inttostr(nNakedAbilCount) + ',' + quotedstr(sHomeMap) + ',' + inttostr(wHomeX) + ',' +inttostr(wHomeY) + ',' + quotedstr(sDieMap) + ',' +
      inttostr(wDieX) + ',' + inttostr(wDieY) + ',' + quotedstr(sDearName) + ',' + quotedstr(dateForSql(LoginTime)) + ',' + quotedstr(LoginAddr) + ',' +
      inttostr(btCreditPoint) + ',' + quotedstr(sStoragePwd) + ',' + inttostr(master) + ',' + inttostr(storagelock) + ',' + inttostr(btStorageErrorCount) + ',' +
      quotedstr(dateForSql(StorageLockTime)) + ',' + inttostr(btReLevel) + ',' + inttostr(nGameGold) + ',' + inttostr(nGamePoint) + ',' +
      inttostr(nGameDiamond) + ',' + inttostr(nGameGird) + ',' + inttostr(nPKPoint) + ',' + inttostr(nPullulation) + ',' + inttostr(btAttatckMode) + ',' +
      inttostr(nIncHealth) + ',' + inttostr(nIncSpell) + ',' + inttostr(nIncHealing) + ',' + inttostr(btFightZoneDieCount) + ',' + quotedstr(sAccount) + ',' +
      quotedstr(sGuildName) + ',' + inttostr(wContribution) + ',' + floattostr(dBodyLuck) + ',' + inttostr(wGuildRcallTime) + ',' + inttostr(wGroupRcallTime) + ',' + inttostr(nAllowSetup) + ',' +
      inttostr(addstabpoint) + ',' + inttostr(btMasterCount) + ',' + inttostr(btWuXin) + ',' + inttostr(changename) + ',' + inttostr(nExpRate) + ',' +
      inttostr(nExpTime) + ',' + quotedstr(dateForSql(dwUpLoadPhotoTime)) + ',' + inttostr(wNakedBackCount) + ',' + inttostr(nItemsSetupCount) + ',:MagicList,'
      + inttostr(CboMagicListInfo.nMagicList) + ',' + inttostr(MakeMagicPoint) + ',:Custom,:MakeMagic,' +
      inttostr(store2) + ',' + quotedstr(dateforsql(StorageTime2)) + ',' + inttostr(store3) + ',' + quotedstr(dateforsql(StorageTime3)) + ')';
  end;
  try
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.CommandText := sSQLString;
      ADOCommand.ParamCheck:=False;
      ADOCommand.Parameters.ParamByName('MagicList').Value :=MagicList;
      ADOCommand.Parameters.ParamByName('MakeMagic').Value :=MakeMagic;
      ADOCommand.Parameters.ParamByName('Custom').Value :=CustomVariable;
      ADOCommand.Execute;
    except
      on e: Exception do begin
        MainOutMessage(e.Message);
        MainOutMessage('[UserAddNew] Error Inserting char:' + HumanRCD.Data.sChrName);
      end;
    end;
  finally
    ADOCommand.Free;
  end;

  sSqlString:='Insert Into Tbl_StatusArray(';
  for i:= 0 to MAX_STATUS_ATTRIBUTE-1 do
    sSqlString := sSqlString + 'Status' + IntToStr(i) + ',';
  sSqlString := sSqlString + 'CharName) Values(';
  for i:= 0 to MAX_STATUS_ATTRIBUTE-1 do
    sSqlString := sSqlString +IntToStr(HumanRCD.Data.wStatusTimeArr[i]) + ',';
  sSqlString := sSqlString + '''' + HumanRCD.Data.sChrName + ''')';
  try
    Query.SQL.Clear;
    Query.SQL.Add(sSqlString);
    Query.ExecSQL;
  except
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage('[StatusArray] Error inserting char:' + HumanRCD.Data.sChrName);
    end;
  end;
  Result:=True;
except
  on e: Exception do
    MainOutMessage('[TFileDB AddNewRecord] ' + e.Message);
end;
end;

function TFileDB.GetRecord(nIndex: Integer; var HumanRCD: THumDataInfo): Boolean; //0x0048B0C8
var
  i: integer;
  sSQLString: string;
  input: array of byte;
begin
try
SafeFillChar(HumanRCD,SizeOf(THumDataInfo),#0);
  result := false;
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARINFO WHERE nIdx=' + inttostr(nIndex);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;

    Input := Query.FieldByName('MagicList').AsVariant;
    for i := 0 to Length(Input) - 1 do begin
      HumanRCD.Data.CboMagicListInfo.MagicList[i] := Input[i];
      if i >= Length(HumanRCD.Data.CboMagicListInfo.MagicList) then break;
    end;

    Input := Query.FieldByName('CustomVariable').AsVariant;
    for i := 0 to (Length(Input) div 4) - 1 do begin
      HumanRCD.Data.CustomVariable[i] := MakeLong(MakeWord(Input[i * 4],Input[i*4+1]),MakeWord(Input[i*4+2],Input[i*4+3])); 
      if i >= Length(HumanRCD.Data.CustomVariable) then break;
    end;

    Input := Query.FieldByName('MakeMagic').AsVariant;
    for i := 0 to Length(Input) - 1 do begin
      HumanRCD.Data.MakeMagic[i] := Input[i];
      if i >= Length(HumanRCD.Data.MakeMagic) then break;
    end;
    
    HumanRCD.Data.nIdx := Query.FieldByName('nIdx').AsInteger;
    HumanRCD.Header.sName := Query.FieldByName('sChrName').AsString;
    HumanRCD.Data.sChrName := Query.FieldByName('sChrName').AsString;
    HumanRCD.Data.sCurMap := Query.FieldByName('sCurMap').AsString;
    HumanRCD.Data.wCurX := Query.FieldByName('wCurX').AsInteger;
    HumanRCD.Data.wCurY := Query.FieldByName('wCurY').AsInteger;
    HumanRCD.Data.btDir := Query.FieldByName('btDir').AsInteger;
    HumanRCD.Data.btHair := Query.FieldByName('btHair').AsInteger;
    HumanRCD.Data.btSex := Query.FieldByName('btSex').AsInteger;
    HumanRCD.Data.btJob := Query.FieldByName('btJob').AsInteger;
    HumanRCD.Data.nGold := Query.FieldByName('nGold').AsInteger;
    HumanRCD.Data.nBindGold := Query.FieldByName('nBindGold').AsInteger;
    HumanRCD.Data.nNakedAbilCount := Query.FieldByName('nNakedAbilCount').AsInteger;
    HumanRCD.Data.sHomeMap := Query.FieldByName('sHomeMap').AsString;
    HumanRCD.Data.wHomeX := Query.FieldByName('wHomeX').AsInteger;
    HumanRCD.Data.wHomeY := Query.FieldByName('wHomeY').AsInteger;
    HumanRCD.Data.sDieMap := Query.FieldByName('sDieMap').AsString;
    HumanRCD.Data.wDieX := Query.FieldByName('wDieX').AsInteger;
    HumanRCD.Data.wDieY := Query.FieldByName('wDieY').AsInteger;
    HumanRCD.Data.sDearName := Query.FieldByName('sDearName').AsString;
    HumanRCD.Data.LoginTime := Query.FieldByName('LoginTime').AsDateTime;
    HumanRCD.Data.LoginAddr := Query.FieldByName('LoginAddr').AsString;
    HumanRCD.Data.btCreditPoint := Query.FieldByName('btCreditPoint').AsInteger;
    HumanRCD.Data.sStoragePwd := Query.FieldByName('sStoragePwd').AsString;
    HumanRCD.Data.boMaster := getBoolean(Query.FieldByName('boMaster').AsInteger);
    HumanRCD.Data.boStorageLock := getBoolean(Query.FieldByName('boStorageLock').AsInteger);
    HumanRCD.Data.btStorageErrorCount := Query.FieldByName('btStorageErrorCount').AsInteger;
    HumanRCD.Data.StorageLockTime := Query.FieldByName('StorageLockTime').AsDateTime;
    HumanRCD.Data.btReLevel := Query.FieldByName('btReLevel').AsInteger;
    HumanRCD.Data.nGameGold := Query.FieldByName('nGameGold').AsInteger;
    HumanRCD.Data.nGamePoint := Query.FieldByName('nGamePoint').AsInteger;
    HumanRCD.Data.nGameDiamond := Query.FieldByName('nGameDiamond').AsInteger;
    HumanRCD.Data.nGameGird := Query.FieldByName('nGameGird').AsInteger;
    HumanRCD.Data.nPKPoint := Query.FieldByName('nPKPoint').AsInteger;
    HumanRCD.Data.nPullulation := Query.FieldByName('nPullulation').AsInteger;
    HumanRCD.Data.btAttatckMode := Query.FieldByName('btAttatckMode').AsInteger;
    HumanRCD.Data.nIncHealth := Query.FieldByName('nIncHealth').AsInteger;
    HumanRCD.Data.nIncSpell := Query.FieldByName('nIncSpell').AsInteger;
    HumanRCD.Data.nIncHealing := Query.FieldByName('nIncHealing').AsInteger;
    HumanRCD.Data.btFightZoneDieCount := Query.FieldByName('btFightZoneDieCount').AsInteger;
    HumanRCD.Data.sAccount := Query.FieldByName('sAccount').AsString;
    HumanRCD.Data.sGuildName := Query.FieldByName('sGuildName').AsString;
    HumanRCD.Data.wContribution := Query.FieldByName('wContribution').AsInteger;
    HumanRCD.Data.dBodyLuck := Query.FieldByName('dBodyLuck').AsFloat;
    HumanRCD.Data.wGuildRcallTime := Query.FieldByName('wGuildRcallTime').AsInteger;
    HumanRCD.Data.wGroupRcallTime := Query.FieldByName('wGroupRcallTime').AsInteger;
    HumanRCD.Data.nAllowSetup := Query.FieldByName('nAllowSetup').AsInteger;
    HumanRCD.Data.boAddStabilityPoint := getBoolean(Query.FieldByName('boAddStabilityPoint').AsInteger);
    HumanRCD.Data.btMasterCount := Query.FieldByName('btMasterCount').AsInteger;
    HumanRCD.Data.btWuXin := Query.FieldByName('btWuXin').AsInteger;
    HumanRCD.Data.boChangeName := getBoolean(Query.FieldByName('boChangeName').AsInteger);
    HumanRCD.Data.nExpRate := Query.FieldByName('nExpRate').AsInteger;
    HumanRCD.Data.nExpTime := Query.FieldByName('nExpTime').AsInteger;
    HumanRCD.Data.dwUpLoadPhotoTime := Query.FieldByName('dwUpLoadPhotoTime').AsDateTime;
    HumanRCD.Data.wNakedBackCount := Query.FieldByName('wNakedBackCount').AsInteger;
    HumanRCD.Data.nItemsSetupCount := Query.FieldByName('nItemsSetupCount').AsInteger;
    HumanRCD.Data.nIncHealth := Query.FieldByName('nIncHealth').AsInteger;
    HumanRCD.Data.CboMagicListInfo.nMagicList := Query.FieldByName('nMagicList').AsInteger;
    HumanRCD.Data.MakeMagicPoint := Query.FieldByName('MakeMagicPoint').AsInteger;
    HumanRCD.Data.StorageOpen2 := getBoolean(Query.FieldByName('StorageOpen2').AsInteger);
    HumanRCD.Data.StorageTime2 := Query.FieldByName('StorageTime2').AsDateTime;
    HumanRCD.Data.StorageOpen3 := getBoolean(Query.FieldByName('StorageOpen3').AsInteger);
    HumanRCD.Data.StorageTime3 := Query.FieldByName('StorageTime3').AsDateTime;
    HumanRCD.Data.nStorageGold := Query.FieldByName('StorageGold').AsInteger;
  finally
    Query.Close;
  end;
  unlock();
  if not getQuestFlag(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getMission(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getMagic(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getAbility(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getProfile(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getKeyInfo(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getMaster(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getOptions(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getHumItems(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getBagItems(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getStorageItems(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getReturnItems(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getAppendItems(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getRecordHeader(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getStatusArray(HumanRCD.Header.sName, HumanRCD) then exit;
  if not getFriend(HumanRCD.Header.sName, HumanRCD) then exit;
  Result := True;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetRecord] ' + e.Message);
end;
end;

function TFileDB.GetRecordHeader(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  sSQLString: string;
begin
try
  try
    lock();
    Query.ConnectionString := sConnection;
    sSQLString := 'SELECT * FROM Tbl_CharList Where(CharName=' + quotedstr(sChrName) + ')';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    Query.Open;

    HumanRCD.Data.sAccount    := Query.FieldByName('Account').AsString;
    HumanRCD.Header.sName    := Query.FieldByName('CharName').AsString;
    HumanRCD.Header.dwCreateDate := now();
    HumanRCD.Header.dwUpdateDate  := Query.FieldByName('ModDate').AsDateTime;
    HumanRCD.Header.boDeleted   := getBoolean(Query.FieldByName('Deleted').AsInteger);
    HumanRCD.Header.nSelectID   := Query.FieldByName('SelectID').AsInteger;
  finally
    Query.Close();
  end;
  Result:=True;
  unlock();
except
  on e: Exception do
    MainOutMessage('[TFileDB GetRecordHeader] ' + e.Message);
end;
end;

function TFileDB.getHumItems(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i, position: integer;
  sSQLString: string;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_HUMITEMS WHERE CharName=' + quotedstr(sChrName) + ' ORDER BY nPosition';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      position := Query.FieldByName('nPosition').AsInteger;
      if i < length(HumanRCD.Data.HumItems) - 1 then begin
        GetItem(HumanRCD.Data.HumItems[position]);
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetHumItems] ' + e.Message);
end;
end;
procedure TFileDB.GetItem(var target: TUserItem);
var
  j: integer;
  input: array of byte;
begin
try
//technicaly by using query from the global declaration i'm cheating,
// query should be passed along but since it's already global, just use it
  try
    target.MakeIndex := Query.FieldByName('MakeIndex').AsInteger;
    target.wIndex := Query.FieldByName('nIndex').AsInteger;
    target.btBindMode1 := Query.FieldByName('BindMode1').AsInteger;
    target.btBindMode2 := Query.FieldByName('BindMode2').AsInteger;
    target.TermTime := Query.FieldByName('ExpiryTime').AsInteger;
    target.Dura:= Query.FieldByName('Dura').AsInteger;
    target.DuraMax := Query.FieldByName('MaxDura').AsInteger;
    target.ComLevel := Query.FieldByName('ComLevel').AsInteger;
    target.EffectValue.btColor := Query.FieldByName('Colour').AsInteger;
    target.EffectValue.btEffect := Query.FieldByName('Effect').AsInteger;
    target.EffectValue.btUpgrade := Query.FieldByName('Upgrade').AsInteger;
    target.EffectValue.btReserved := Query.FieldByName('Reserved').AsInteger;
    target.EffectValue.btReserved2 := Query.FieldByName('Reserved2').AsInteger;
    target.Value.btWuXin := Query.FieldByName('Element').AsInteger;
    target.Value.StrengthenInfo.btCanStrengthenCount := Query.FieldByName('CanStrengthCount').AsInteger;
    target.Value.StrengthenInfo.btStrengthenCount := Query.FieldByName('StrengthCount').AsInteger;
    target.Value.btFluteCount := Query.FieldByName('btFluteCount').AsInteger;

        input:=Query.FieldByName('Value').AsVariant;

        for j := 0 to Length(input) - 1 do begin
          target.Value.btValue[j] := Input[j];
          if j >= Length(target.Value.btValue) then break;
        end;

        input:=Query.FieldByName('temp1').AsVariant;
        for j := 0 to Length(input) - 1 do begin
          target.temp1[j] := Input[j];
          if j >= Length(target.temp1) then break;
        end;
        input:=Query.FieldByName('flute').AsVariant;
        for j := 0 to (Length(input) - 1) div 2 do begin
          target.Value.wFlute[j] := makeword(Input[j*2],Input[(j*2)+1]);
          if (j*2) >= Length(target.Value.wFlute) then break;
        end;
        input:=Query.FieldByName('StrengthInfo').AsVariant;
        for j := 0 to Length(input) - 1 do begin
          target.Value.StrengthenInfo.btStrengthenInfo[j] := Input[j];
          if j >= Length(target.Value.StrengthenInfo.btStrengthenInfo) then break;
        end;
  except
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage('[GetItemData] failed to fetch item data');
    end;
  end;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetItem] ' + e.Message);
end;
end;

function TFileDB.UpdateItem(Item: TUserItem;sTableName, sCharName: string; nPosition:integer; nGridIdx: integer = 0): boolean;
var
  sSqlString:string;
  Temp,Flute,Values,Strength: array of byte;
  i: integer;
begin
try
  result := False;
  try
  with Item do begin
    SetLength(Temp,Length(temp1));
    for I := 0 to Length(temp1) - 1 do
      Temp[i]:=temp1[i];

    SetLength(Values,Length(Value.btValue));
    for i := 0 to Length(Value.btValue) - 1 do
      Values[i]:=Value.btValue[i];

    SetLength(Flute,Length(Value.wFlute)*2);
    for i := 0 to Length(Value.wFlute) - 1 do begin
      Flute[i*2] := LoByte(Value.wFlute[i]);
      Flute[1+i*2] := HiByte(Value.wFlute[i]);
    end;
    SetLength(Strength,Length(Value.StrengthenInfo.btStrengthenInfo));
    for i := 0 to length(Value.StrengthenInfo.btStrengthenInfo) - 1 do
      Strength[i] := Value.StrengthenInfo.btStrengthenInfo[i];
    sSQLString := 'INSERT INTO ' + sTableName + '(CharName, nPosition, MakeIndex, nIndex, BindMode1, BindMode2, ExpiryTime, Dura, MaxDura, ' +
        'ComLevel, temp1, Colour, Effect, Upgrade, Reserved, Reserved2, Element, btFluteCount, ' +
        'Flute, Value, CanStrengthCount, StrengthCount, StrengthInfo';
        if nGridIdx > 0 then
           sSqlString := sSqlString + ', nGridIdx';
        sSqlString := sSqlString + ') VALUES(' + quotedstr(sCharName) + ',' + inttostr(nPosition) + ',' + inttostr(MakeIndex) + ', ' + inttostr(wIndex) + ', ' + inttostr(btBindMode1) + ', ' + inttostr(btBindMode2) +
         ', ' +  inttostr(TermTime) + ', ' + inttostr(Dura) + ', ' + inttostr(DuraMax) + ', ' + inttostr(ComLevel) + ', :temp ' +
         ', ' + inttostr(EffectValue.btColor) + ', ' + inttostr(EffectValue.btEffect) + ', ' + inttostr(EffectValue.btUpgrade) + ', ' + inttostr(EffectValue.btReserved) + ', ' + inttostr(EffectValue.btReserved2) + ', ' + inttostr(Value.btWuXin) +
         ', ' + inttostr(Value.btFluteCount) + ', :flute , :value '  +
         ', ' + inttostr(Value.StrengthenInfo.btCanStrengthenCount) + ', ' + inttostr(Value.StrengthenInfo.btStrengthenCount) + ', :strength ';
         if nGridIdx > 0 then
           sSqlString := sSqlString + ', ' + inttostr(nGridIdx);
         sSqlString := sSqlString +')';


      try
        try
          ADOCommand:=TADOCommand.Create(nil);
          ADOCommand.Connection:=AdoConnection;
          ADOCommand.Parameters.Clear;
          ADOCommand.CommandText := sSQLString;
          ADOCommand.ParamCheck:=False;
          ADOCommand.Parameters.ParamByName('temp').Value :=Temp;
          ADOCommand.Parameters.ParamByName('flute').Value :=Flute;
          ADOCommand.Parameters.ParamByName('value').Value :=Values;
          ADOCommand.Parameters.ParamByName('strength').Value :=Strength;
          ADOCommand.Execute;
        except
          on e: Exception do begin
              MainOutMessage(e.Message);
              MainOutMessage('[' + sTableName + '] Error Inserting item to char:' + sChArName);
          end;
        end;
      finally
        ADOCommand.Free;
      end;
  end;
  except
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage('[' + sTableName + '] Error converting item for char:' + sChArName);
    end;
  end;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateItem] ' + e.Message);
end;
end;

function TFileDB.updateHumItems(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSqlString:string;
  boSucces:boolean;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_HUMITEMS WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserItems] Error deleting items from char:' + HumanRCD.Data.sChrName);
  end;
  boSucces:=True;
  for i := 0 to length(HumanRCD.Data.HumItems) - 1 do begin
    with HumanRCD.Data.HumItems[i] do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.HumItems[i],'Tbl_HumItems',HumanRCD.Data.sChrName,i) then boSucces:=False;
      end;
    end;
  end;
  //if boSucces then
    Result := true
  //else
  //  Result := false;

except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateHumItems] ' + e.Message);
end;
end;

function TFileDB.getBagItems(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i, position: integer;
  sSQLString: string;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_BAGITEMS WHERE CharName=' + quotedstr(sChrName) + ' ORDER BY nPosition';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      position := Query.FieldByName('nPosition').AsInteger;
      if i < length(HumanRCD.Data.BagItems) then begin
        GetItem(HumanRCD.Data.BagItems[position]);
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  unlock;
  Result := True;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetBagItems] ' + e.Message);
end;
end;

function TFileDB.GetStatusArray(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i:integer;
  sSQLString: string;
begin
try
  try
    lock();
    Query.ConnectionString := sConnection;
    sSQLString := 'SELECT * FROM TBL_STATUSARRAY Where(CharName=' + quotedstr(sChrName) + ')';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    Query.Open;
      
    for i:= 0 to Length(HumanRCD.Data.wStatusTimeArr)-1 do
      HumanRCD.Data.wStatusTimeArr[i] := Query.FieldByName('Status' + IntToStr(i)).AsInteger;
  finally
    Query.Close();
  end;
  unlock();
  Result:=True;
except
  on e: Exception do
    MainOutMessage('[TFileDB StatusArray] ' + e.Message);
end;
end;

function TFileDB.getStorageItems(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i, j, Position: Integer;
  store1Count, store2Count, store3Count: Integer;
  sSQLString: string;
begin
try
  store1Count := 0;
  store2Count := 0;
  store3Count := 0;
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_STOREITEMS WHERE CharName=' + quotedstr(sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      Position := Query.FieldByName('nPosition').AsInteger;
      case Position of
        1: begin
          if store1Count < length(HumanRCD.Data.StorageItems) then begin
            HumanRCD.Data.StorageItems[store1Count].idx := Query.FieldByName('nGridIdx').AsInteger;
            GetItem(HumanRCD.Data.StorageItems[store1Count].UserItem);
            inc(store1Count);
          end;
        end;
        2: begin
          if store2Count < length(HumanRCD.Data.StorageItems2) then begin
            HumanRCD.Data.StorageItems2[store2Count].idx := Query.FieldByName('nGridIdx').AsInteger;
            GetItem(HumanRCD.Data.StorageItems2[store2Count].UserItem);
            inc(store2Count);
          end;
        end;
        3: begin
          if store3Count < length(HumanRCD.Data.StorageItems3) then begin
            HumanRCD.Data.StorageItems3[store3Count].idx := Query.FieldByName('nGridIdx').AsInteger;
            GetItem(HumanRCD.Data.StorageItems3[store3Count].UserItem);
            inc(store3Count);
          end;
        end
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetStorageItems] ' + e.Message);
end;
end;

function TFileDB.updateStorageItems(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString:string;
  boSucces:boolean;
begin
try
  boSucces:=true;
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_STOREITEMS WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserItems] Error deleting items from char:' + HumanRCD.Data.sChrName);
  end;

  for i := 0 to length(HumanRCD.Data.StorageItems) - 1 do begin
    with HumanRCD.Data.StorageItems[i].UserItem do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.StorageItems[i].UserItem,'Tbl_StoreItems',HumanRCD.Data.sChrName,1, HumanRCD.Data.StorageItems[i].idx) then boSucces:=False;
      end;
    end;
  end;
  for i := 0 to length(HumanRCD.Data.StorageItems2) - 1 do begin
    with HumanRCD.Data.StorageItems2[i].UserItem do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.StorageItems2[i].UserItem,'Tbl_StoreItems',HumanRCD.Data.sChrName,2, HumanRCD.Data.StorageItems[i].idx) then boSucces:=False;
      end;
    end;
  end;
  for i := 0 to length(HumanRCD.Data.StorageItems3) - 1 do begin
    with HumanRCD.Data.StorageItems3[i].UserItem do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.StorageItems3[i].UserItem,'Tbl_StoreItems',HumanRCD.Data.sChrName,3, HumanRCD.Data.StorageItems[i].idx) then boSucces:=False;
      end;
    end;
  end;
  result:=true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateStorageItems] ' + e.Message);
end;
end;

function TFileDB.updateBagItems(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: string;
  boSucces:boolean;
begin
try
  result := false;
  boSucces:=True;
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_BAGITEMS WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserItems] Error deleting items from char:' + HumanRCD.Data.sChrName);
  end;

  for i := 0 to length(HumanRCD.Data.BagItems) - 1 do begin
    with HumanRCD.Data.BagItems[i] do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.BagItems[i],'TBL_BAGITEMS',HumanRCD.Data.sChrName,i) then boSucces:=False;
      end;
    end;
  end;
  result:=boSucces;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateBagItems] ' + e.Message);
end;
end;

function TFileDB.getAppendItems(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: string;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_APPENDITEMS WHERE CharName=' + quotedstr(sChrName) + ' order by nposition';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      if i < length(HumanRCD.Data.AppendBagItems) then begin
        GetItem(HumanRCD.Data.AppendBagItems[i]);
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetAppendItems] ' + e.Message);
end;
end;

function TFileDB.updateAppendItems(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: string;
  boSucces:boolean;
begin
try
  boSucces:=true;
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_APPENDITEMS WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserItems] Error deleting items from char:' + HumanRCD.Data.sChrName);
  end;

  for i := 0 to length(HumanRCD.Data.AppendBagItems) - 1 do begin
    with HumanRCD.Data.AppendBagItems[i] do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.AppendBagItems[i],'TBL_APPENDITEMS',HumanRCD.Data.sChrName,i) then boSucces:=False;
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateAppendItem] ' + e.Message);
end;
end;

function TFileDB.getReturnItems(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: string;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_RETURNITEMS WHERE CharName=' + quotedstr(sChrName) +  ' order by nPosition';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      if i < length(HumanRCD.Data.ReturnItems) then begin
        GetItem(HumanRCD.Data.ReturnItems[i]);
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetReturnItems] ' + e.Message);
end;
end;

function TFileDB.updateReturnItems(var HumanRCD: THumDataInfo): Boolean;
var
  i, j: Integer;
  sSQLString: string;
  boSucces:boolean;
begin
try
  boSucces:=True;
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_RETURNITEMS WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserItems] Error deleting items from char:' + HumanRCD.Data.sChrName);
  end;

  for i := 0 to length(HumanRCD.Data.ReturnItems) - 1 do begin
    with HumanRCD.Data.ReturnItems[i] do begin
      if (MakeIndex <> 0) and (wIndex <> 0) then begin
        if not UpdateItem(HumanRCD.Data.ReturnItems[i],'TBL_RETURNITEMS',HumanRCD.Data.sChrName,i) then boSucces:=False;
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateReturnItems] ' + e.Message);
end;
end;

function TFileDB.getMagic(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_HUMMAGIC WHERE CharName=' + quotedstr(sChrName) + ' order by idx';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    try
      Query.Open;
      for i := 0 to Query.RecordCount-1 do begin
        if i < length(HumanRCD.Data.HumMagics) then begin
          HumanRCD.Data.HumMagics[i].btLevel := Query.FieldByName('Lvl').AsInteger;
          HumanRCD.Data.HumMagics[i].wMagIdx := Query.FieldByName('MagicID').AsInteger;
          HumanRCD.Data.HumMagics[i].nTranPoint := Query.FieldByName('TranPoint').AsInteger;
          HumanRCD.Data.HumMagics[i].nInterval := Query.FieldByName('Interv').AsInteger;
        end;
        Query.Next;
      end;
    except
      on e: Exception do begin
        MainOutMessage(e.Message);
        MainOutMessage('[MagicDB] A problem has occured reading in a users magic: ' + sChrName);
      end;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetMagic] ' + e.Message);
end;
end;

function TFileDB.updateMagic(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_HUMMAGIC WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserMagic] Error deleting magic to char:' + HumanRCD.Data.sChrName);
  end;
  for i := 0 to length(HumanRCD.Data.HumMagics) - 1 do begin
    with HumanRCD.Data.HumMagics[i] do begin
      if wMagIdx = 0 then continue;
      
      sSQLString := 'INSERT INTO TBL_HUMMAGIC(Idx,CharName, Lvl, MagicID, TranPoint, Interv) VALUES(' + inttostr(i) + ',' + quotedstr(HumanRCD.Data.sChrName) + ', ' + inttostr(btLevel) + ', ' + inttostr(wMagIdx) + ', ' + inttostr(nTranPoint) + ', ' + inttostr(nInterval) + ')';
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.ExecSQL;
      except
        on e: Exception do begin
            MainOutMessage(e.Message);
            MainOutMessage(sSQLString);
            MainOutMessage('[UserMagic] Error Inserting magic char:' + HumanRCD.Data.sChrName + ' Magicindex:' + IntToStr(wMagIdx))
          end;
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateMagic] ' + e.Message);
end;
end;

function TFileDB.getFriend(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARFRIEND WHERE CharName=' + quotedstr(sChrName) + ' order by  idx';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      if i < length(HumanRCD.Data.FriendList) - 1 then begin
        HumanRCD.Data.FriendList[i].sChrName := Query.FieldByName('FriendName').AsString;
        HumanRCD.Data.FriendList[i].nChrIdx := Query.FieldByName('FriendIdx').AsInteger;
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetFriend] ' + e.Message);
end;
end;

function TFileDB.updateFriend(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_CHARFRIEND WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserFriend] Error deleting friends from char:' + HumanRCD.Data.sChrName);
  end;
  for I := Low(HumanRCD.Data.FriendList) to High(HumanRCD.Data.FriendList) do begin
    with HumanRCD.Data.FriendList[i] do begin
      if Trim(sChrName) <> '' then begin
        sSQLString := 'INSERT INTO TBL_CHARFRIEND(CharName, FriendName, FriendIdx, idx) VALUES(' + quotedstr(HumanRCD.Data.sChrName) + ', ' + quotedstr(sChrName) + ', ' + inttostr(nChrIdx) + ', ' + inttostr(i) +  ')';
        Query.SQL.Clear;
        Query.SQL.Add(sSQLString);
        try
          Query.ExecSQL;
        except
        //MainOutMessage('[UserMagic] Error inserting magic to char:' + HumanRCD.Data.sChrName);
          on e: Exception do begin
            MainOutMessage(e.Message);
            MainOutMessage('[UserFriend] Error Inserting friends for char:' + HumanRCD.Data.sChrName);
          end;
        end;
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateFriend] ' + e.Message);
end;
end;

function TFileDB.getAbility(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARABILITY WHERE CharName=' + quotedstr(sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    HumanRCD.Data.Abil.Level := Query.FieldByName('Lvl').AsInteger;
    HumanRCD.Data.Abil.AC := Query.FieldByName('AC').AsInteger;
    HumanRCD.Data.Abil.MAC := Query.FieldByName('MAC').AsInteger;
    HumanRCD.Data.Abil.DC := Query.FieldByName('DC').AsInteger;
    HumanRCD.Data.Abil.MC := Query.FieldByName('MC').AsInteger;
    HumanRCD.Data.Abil.SC := Query.FieldByName('SC').AsInteger;
    HumanRCD.Data.Abil.HP := Query.FieldByName('HP').AsInteger;
    HumanRCD.Data.Abil.MP := Query.FieldByName('MP').AsInteger;
    HumanRCD.Data.Abil.MaxHP := Query.FieldByName('MaxHP').AsInteger;
    HumanRCD.Data.Abil.MaxMP := Query.FieldByName('MaxMP').AsInteger;
    HumanRCD.Data.Abil.Exp := Query.FieldByName('Exp').AsInteger;
    HumanRCD.Data.Abil.MaxExp := Query.FieldByName('MaxExp').AsInteger;
    HumanRCD.Data.Abil.Weight := Query.FieldByName('Weight').AsInteger;
    HumanRCD.Data.Abil.MaxWeight := Query.FieldByName('MaxWeight').AsInteger;
    HumanRCD.Data.Abil.WearWeight := Query.FieldByName('WearWeight').AsInteger;
    HumanRCD.Data.Abil.MaxWearWeight := Query.FieldByName('MaxWearWeight').AsInteger;
    HumanRCD.Data.Abil.HandWeight := Query.FieldByName('HandWeight').AsInteger;
    HumanRCD.Data.Abil.MaxHandWeight := Query.FieldByName('MaxHandWeight').AsInteger;
    HumanRCD.Data.NakedAbil.nAc := Query.FieldByName('nAC').AsInteger;
    HumanRCD.Data.NakedAbil.nMac := Query.FieldByName('nMAC').AsInteger;
    HumanRCD.Data.NakedAbil.nDC := Query.FieldByName('nDC').AsInteger;
    HumanRCD.Data.NakedAbil.nMC := Query.FieldByName('nMC').AsInteger;
    HumanRCD.Data.NakedAbil.nSC := Query.FieldByName('nSC').AsInteger;
    HumanRCD.Data.NakedAbil.nHP := Query.FieldByName('nHP').AsInteger;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetAbility] ' + e.Message);
end;
end;

function TFileDB.updateAbility(var HumanRCD: THumDataInfo): Boolean;
var
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString:='DELETE FROM TBL_CHARABILITY WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserAbility] Error deleting ability details from char:' + HumanRCD.Data.sChrName);
  end;

  with HumanRCD.Data do begin
    sSQLString := 'INSERT INTO TBL_CHARABILITY(CharName,Lvl,AC,MAC,DC,MC,SC,HP,MP,MaxHP,MaxMP,Exp,MaxExp,' +
  'Weight,MaxWeight,WearWeight,MaxWearWeight,HandWeight,MaxHandWeight,nAC,nMAC,nDC,nMC,nSC,nHP) VALUES(' + quotedstr(HumanRCD.Data.sChrName) +
  ',' + inttostr(Abil.Level) + ',' + inttostr(Abil.AC) + ',' + inttostr(Abil.MAC) + ',' + inttostr(Abil.DC) + ',' + inttostr(Abil.MC) + ',' + inttostr(Abil.SC) +
  ',' + inttostr(Abil.HP) + ',' + inttostr(Abil.MP) + ',' + inttostr(Abil.MaxHP) + ',' + inttostr(Abil.MaxMP) + ',' + inttostr(Abil.Exp) + ',' + inttostr(Abil.MaxExp) +
  ',' + inttostr(Abil.Weight) + ',' + inttostr(Abil.MaxWeight) + ',' + inttostr(Abil.WearWeight) + ',' + inttostr(Abil.MaxWearWeight) +
  ',' + inttostr(Abil.HandWeight) + ',' + inttostr(Abil.MaxHandWeight) + ',' + inttostr(NakedAbil.nAc) + ',' + inttostr(NakedAbil.nMac) +
  ',' + inttostr(NakedAbil.nDC) + ',' + inttostr(NakedAbil.nMC) + ',' + inttostr(NakedAbil.nSC) + ',' + inttostr(NakedAbil.nHP) + ')';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.ExecSQL;
    except
        //MainOutMessage('[UserMagic] Error inserting magic to char:' + HumanRCD.Data.sChrName);
      on e: Exception do begin
        MainOutMessage(e.Message);
        MainOutMessage('[UserAbility] Error Inserting ability to char:' + HumanRCD.Data.sChrName);
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateAbility] ' + e.Message);
end;
end;

function TFileDB.getProfile(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  sSQLString: String;
  Input: array of byte;
  i: integer;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARPROFILE WHERE CharName=' + quotedstr(sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    if Query.RecordCount > 0 then begin

      HumanRCD.Data.UserRealityInfo.sUserName := Query.FieldByName('sUserName').AsString;
      HumanRCD.Data.UserRealityInfo.btOld := Query.FieldByName('btOld').AsInteger;
      HumanRCD.Data.UserRealityInfo.btSex := Query.FieldByName('btSex').AsInteger;
      HumanRCD.Data.UserRealityInfo.btProvince := Query.FieldByName('btProvince').AsInteger;
      HumanRCD.Data.UserRealityInfo.btCity := Query.FieldByName('btCity').AsInteger;
      HumanRCD.Data.UserRealityInfo.btArea := Query.FieldByName('btArea').AsInteger;
      HumanRCD.Data.UserRealityInfo.btOnlineTime := Query.FieldByName('btOnlineTime').AsInteger;
      HumanRCD.Data.UserRealityInfo.sIdiograph := Query.FieldByName('sIdiograph').AsString;
      HumanRCD.Data.UserRealityInfo.boFriendSee := getBoolean(Query.FieldByName('boFriendSee').AsInteger);
      HumanRCD.Data.UserRealityInfo.sPhotoID := Query.FieldByName('sPhotoID').AsString;
      HumanRCD.Data.nPhotoSize := Query.FieldByName('nPhotoSize').AsInteger;
      Input := Query.FieldByName('pPhotoData').AsVariant;
      for i := 0 to Length(input) - 1 do begin
        HumanRCD.Data.pPhotoData[i] := Input[i];
        if i >= Length(HumanRCD.Data.pPhotoData) then break;
      end;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetProfile] ' + e.Message);
end;
end;

function TFileDB.updateProfile(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: string;
  PhotoData: array of byte;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString:='DELETE FROM TBL_CHARPROFILE WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserProfile] Error deleting profile details from char:' + HumanRCD.Data.sChrName);
  end;
  try
    SetLength(Photodata,Length(HumanRCD.Data.pPhotoData));
    for i := 0 to Length(HumanRCD.Data.pPhotoData) - 1 do
      PhotoData[i] := HumanRCD.Data.pPhotoData[i];

    with HumanRCD.Data.UserRealityInfo do begin
      sSQLString := 'INSERT INTO TBL_CHARPROFILE(CharName,sUserName,btOld,btSex,btProvince,btCity,btArea,btOnlineTime,sIdiograph,boFriendSee,sPhotoID,nPhotoSize,pPhotoData) VALUES(' +
      quotedstr(HumanRCD.Data.sChrName) + ',' + quotedstr(sUserName) + ',' + inttostr(btOld) + ',' + inttostr(btSex) + ',' + inttostr(btProvince) + ',' +
      inttostr(btCity) + ',' + inttostr(btArea) + ',' + inttostr(btOnlineTime) + ',' + quotedstr(sIdiograph) + ',' + inttostr(setBoolean(boFriendSee)) + ',' + quotedstr(sPhotoID) + ',' +
      inttostr(HumanRCD.Data.nPhotoSize) + ', :photodata)';
    end;
    try
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.CommandText := sSQLString;
      ADOCommand.ParamCheck:=False;
      ADOCommand.Parameters.ParamByName('photodata').Value :=PhotoData;
      ADOCommand.Execute;
    finally
      AdoCommand.Free;
    end;
  except
        //MainOutMessage('[UserMagic] Error inserting magic to char:' + HumanRCD.Data.sChrName);
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage('[UserProfile] Error Inserting Profile details to char:' + HumanRCD.Data.sChrName);
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateProfile] ' + e.Message);
end;
end;

function TFileDB.getOptions(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHAROPTIONS WHERE CharName=' + quotedstr(sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    HumanRCD.Data.UserOptionSetup.nOptionSetup := Query.FieldByName('nOptionSetup').AsInteger;
    HumanRCD.Data.UserOptionSetup.nExpFiltrateCount:= Query.FieldByName('nExpFiltrateCount').AsInteger;
    HumanRCD.Data.UserOptionSetup.nHpProtectCount := Query.FieldByName('nHpProtectCount').AsInteger;
    HumanRCD.Data.UserOptionSetup.dwHpProtectTime := Query.FieldByName('dwHpProtectTime').AsInteger;
    HumanRCD.Data.UserOptionSetup.nMpProtectCount := Query.FieldByName('nMpProtectCount').AsInteger;
    HumanRCD.Data.UserOptionSetup.dwMpProtectTime := Query.FieldByName('dwMpProtectTime').AsInteger;
    HumanRCD.Data.UserOptionSetup.nHpProtectCount2 := Query.FieldByName('nHpProtectCount2').AsInteger;
    HumanRCD.Data.UserOptionSetup.dwHpProtectTime2 := Query.FieldByName('dwHpProtectTime2').AsInteger;
    HumanRCD.Data.UserOptionSetup.nMpProtectCount2 := Query.FieldByName('nMpProtectCount2').AsInteger;
    HumanRCD.Data.UserOptionSetup.dwMpProtectTime2 := Query.FieldByName('dwMpProtectTime2').AsInteger;
    HumanRCD.Data.UserOptionSetup.nHpProtectCount3 := Query.FieldByName('nHpProtectCount3').AsInteger;
    HumanRCD.Data.UserOptionSetup.dwHpProtectTime3 := Query.FieldByName('dwHpProtectTime3').AsInteger;
    HumanRCD.Data.UserOptionSetup.btHpProtectIdx := Query.FieldByName('btHpProtectIdx').AsInteger;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetOptions] ' + e.Message);
end;
end;

function TFileDB.updateOptions(var HumanRCD: THumDataInfo): Boolean;
var
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString:='DELETE FROM TBL_CHAROPTIONS WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserOptions] Error deleting options from char:' + HumanRCD.Data.sChrName);
  end;

  with HumanRCD.Data.UserOptionSetup do begin
    sSQLString := 'INSERT INTO TBL_CHAROPTIONS(CharName,nOptionSetup,nExpFiltrateCount,nHpProtectCount,dwHpProtectTime,nMPProtectCount,' +
    'dwMpProtectTime,nHpProtectCount2,dwHpProtectTime2,nMpProtectCount2,dwMpProtectTime2,nHpProtectCount3,dwHpProtectTime3,' +
    'btHpProtectIdx) VALUES(' + quotedstr(HumanRCD.Data.sChrName) + ',' + inttostr(nOptionSetup) + ',' + inttostr(nExpFiltrateCount) + ',' + inttostr(nHpProtectCount) + ',' + inttostr(dwHpProtectTime) + ',' +
    inttostr(nMPProtectCount) + ',' + inttostr(dwMpProtectTime) + ',' + inttostr(nHpProtectCount2) + ',' + inttostr(dwHpProtectTime2) + ',' + inttostr(nMpProtectCount2) + ',' + inttostr(dwMpProtectTime2) +
    ',' + inttostr(nHpProtectCount3) + ',' + inttostr(dwHpProtectTime3) + ',' + inttostr(btHpProtectIdx) + ')';
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.ExecSQL;
    except
        //MainOutMessage('[UserMagic] Error inserting magic to char:' + HumanRCD.Data.sChrName);
      on e: Exception do begin
        MainOutMessage(e.Message);
        MainOutMessage('[UserProfile] Error Inserting options to char:' + HumanRCD.Data.sChrName);
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateOptions] ' + e.Message);
end;
end;

function TFileDB.getKeyInfo(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARKEYINFO WHERE CharName=' + quotedstr(sChrName) + ' order by idx';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      if i < length(HumanRCD.Data.UserKeySetup) - 1 then begin
        HumanRCD.Data.UserKeySetup[i].btType := Query.FieldByName('btType').AsInteger;
        HumanRCD.Data.UserKeySetup[i].wIndex := Query.FieldByName('nIndex').AsInteger;
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetKeyInfo] ' + e.Message);
end;
end;

function TFileDB.updateKeyInfo(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_CHARKEYINFO WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserKeyInfo] Error deleting key info from char:' + HumanRCD.Data.sChrName);
  end;

  for i := 0 to length(HumanRCD.Data.UserKeySetup) - 1 do begin
    with HumanRCD.Data.UserKeySetup[i] do begin
      if (btType = 0) and (wIndex = 0) then continue;
      sSQLString := 'INSERT INTO TBL_CHARKEYINFO(CharName, btType, nIndex, idx) VALUES(' + quotedstr(HumanRCD.Data.sChrName) + ', ' + inttostr(btType) + ', ' + inttostr(wIndex) +  ', ' + inttostr(i) + ')';
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.ExecSQL;
      except
        on e: Exception do begin
            MainOutMessage(e.Message);
            MainOutMessage('[UserKeyInfo] Error Inserting Key info to char:' + HumanRCD.Data.sChrName);
          end;
      end;
    end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateKeyInfo] ' + e.Message);
end;
end;

function TFileDB.getMaster(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARMASTER WHERE CharName=' + quotedstr(sChrName) + ' order by idx';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      if i < length(HumanRCD.Data.MasterName) - 1 then begin
        HumanRCD.Data.MasterName[i] := Query.FieldByName('MasterName').AsString;
      end;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetMaster] ' + e.Message);
end;;
end;

function TFileDB.updateMaster(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_CHARMASTER WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserMaster] Error deleting master info from char:' + HumanRCD.Data.sChrName);
  end;

  for i := 0 to length(HumanRCD.Data.MasterName) - 1 do begin
      with HumanRCD.Data do begin
      if length(MasterName[i]) > 0 then begin
        sSQLString := 'INSERT INTO TBL_CHARMASTER(CharName, MasterName, idx) VALUES(' + quotedstr(HumanRCD.Data.sChrName) + ', ' + quotedstr(MasterName[i]) + ', ' + inttostr(i) +  ')';
        Query.SQL.Clear;
        Query.SQL.Add(sSQLString);
        try
          Query.ExecSQL;
        except
          on e: Exception do begin
              MainOutMessage(e.Message);
              MainOutMessage('[UserMaster] Error Inserting master info to char:' + HumanRCD.Data.sChrName);
          end;
        end;
      end;
   end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateMaster] ' + e.Message);
end;
end;

function TFileDB.getQuestFlag(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: string;
  input: array of byte;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARQUEST WHERE CharName=' + quotedstr(sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();
  try
    Query.Open;
    if query.RecordCount > 0 then begin
      Input := Query.FieldByName('QuestFlag').AsVariant;
      for i := 0 to length(input) - 1 do begin
        HumanRCD.Data.QuestFlag[i] := input[i];
        if i >= Length(HumanRCD.Data.QuestFlag) then break
      end;

      Input := Query.FieldByName('MissionFlag').AsVariant;
      for i := 0 to length(input) - 1 do begin
        HumanRCD.Data.MissionFlag[i] := input[i];
        if i >= Length(HumanRCD.Data.MissionFlag) then break
      end;

      Input := Query.FieldByName('MissionArith').AsVariant;
      for i := 0 to length(input) - 1 do begin
        HumanRCD.Data.MissionArithmometer[i] := input[i];
        if i >= Length(HumanRCD.Data.MissionArithmometer) then break
      end;

      Input := Query.FieldByName('MissionIndex').AsVariant;
      for i := 0 to length(input) - 1 do begin
        HumanRCD.Data.MissionIndex[i] := input[i];
        if i >= Length(HumanRCD.Data.MissionIndex) then break
      end;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetQuestFlag] ' + e.Message);
end;
end;

function TFileDB.updateQuestFlag(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: string;
  QuestFlag, MissionFlag, MissionArithmometer, MissionIndex: array of byte;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_CHARQUEST WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserQuest] Error deleting questflags info from char:' + HumanRCD.Data.sChrName);
  end;
  try
    try
      SetLength(QuestFlag,Length(HumanRCD.Data.QuestFlag));
      for i := 0 to length(HumanRCD.Data.QuestFlag) - 1 do
        QuestFlag[i]:=HumanRCD.Data.QuestFlag[i];

      SetLength(MissionFlag,Length(HumanRCD.Data.MissionFlag));
      for i := 0 to length(HumanRCD.Data.MissionFlag) - 1 do
        MissionFlag[i]:=HumanRCD.Data.MissionFlag[i];

      SetLength(MissionArithmometer,Length(HumanRCD.Data.MissionArithmometer));
      for i := 0 to length(HumanRCD.Data.MissionArithmometer) - 1 do
        MissionArithmometer[i]:=HumanRCD.Data.MissionArithmometer[i];

      SetLength(MissionIndex,Length(HumanRCD.Data.MissionIndex));
      for i := 0 to length(HumanRCD.Data.MissionIndex) - 1 do
        MissionIndex[i]:=HumanRCD.Data.MissionIndex[i];


      sSQLString := 'INSERT INTO TBL_CHARQUEST(CharName, QuestFlag, MissionFlag, MissionArith, MissionIndex) VALUES(' + quotedstr(HumanRCD.Data.sChrName) + ', :QuestFlag , :MissionFlag , :MissionArithmometer , :MissionIndex )';
      ADOCommand:=TADOCommand.Create(nil);
      ADOCommand.Connection:=AdoConnection;
      ADOCommand.Parameters.Clear;
      ADOCommand.CommandText := sSQLString;
      ADOCommand.ParamCheck:=False;
      ADOCommand.Parameters.ParamByName('QuestFlag').Value :=QuestFlag;
      ADOCommand.Parameters.ParamByName('MissionFlag').Value :=MissionFlag;
      ADOCommand.Parameters.ParamByName('MissionArithmometer').Value :=MissionArithmometer;
      ADOCommand.Parameters.ParamByName('MissionIndex').Value :=MissionIndex;
      ADOCommand.Execute;
    except
      on e: Exception do begin
        MainOutMessage(e.Message);
        MainOutMessage('[UserQuest] Error Inserting master info to char:' + HumanRCD.Data.sChrName);
      end;
    end;
  finally
    ADOCommand.Free;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateQuestFlag] ' + e.Message);
end;
end;

function TFileDB.getMission(sChrName: string; var HumanRCD: THumDataInfo): Boolean;
var
  i: integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSQLString := 'SELECT * FROM TBL_CHARMISSION WHERE CharName=' + quotedstr(sChrName) + 'ORDER BY nIdx';
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  lock();

  try
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do begin
      if i > high(HumanRCD.Data.MissionInfo) then continue;

//    for i := low(HumanRCD.Data.MissionInfo) to high(HumanRCD.Data.MissionInfo) do begin
      HumanRCD.Data.MissionInfo[i].sMissionName := Query.FieldByName('sMissionName').AsString;
      HumanRCD.Data.MissionInfo[i].btKillCount1 := Query.FieldByName('btKillCount1').AsInteger;
      HumanRCD.Data.MissionInfo[i].btKillCount2 := Query.FieldByName('btKillCount2').AsInteger;
      HumanRCD.Data.MissionInfo[i].boTrack := getBoolean(Query.FieldByName('boTrack').AsInteger);
      HumanRCD.Data.MissionInfo[i].wTime := Query.FieldByName('wTime').AsInteger;

      Query.Next;
    end;
  finally
    Query.Close;
  end;
  Result := True;
  unlock;
except
  on e: Exception do
    MainOutMessage('[TFileDB GetMission] ' + e.Message);
end;
end;

function TFileDB.updateMission(var HumanRCD: THumDataInfo): Boolean;
var
  i: Integer;
  sSQLString: String;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString:='DELETE FROM TBL_CHARMISSION WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.ExecSQL;
  except
    MainOutMessage('[UserMission] Error deleting info to char:' + HumanRCD.Data.sChrName);
  end;

  for i := low(HumanRCD.Data.MissionInfo) to high(HumanRCD.Data.MissionInfo) do begin
      with HumanRCD.Data do begin
        if MissionInfo[i].sMissionName = '' then continue;
        sSQLString := 'INSERT INTO TBL_CHARMISSION(nIdx, CharName, sMissionName, btKillCount1, btKillCount2, boTrack, wTime) VALUES(' + inttostr(i) + ', ' + quotedstr(HumanRCD.Data.sChrName) + ', ' + quotedstr(MissionInfo[i].sMissionName) + ', ' + inttostr(MissionInfo[i].btKillCount1) + ', ' + inttostr(MissionInfo[i].btKillCount2) + ', ' + inttostr(setBoolean(MissionInfo[i].boTrack)) + ', ' + inttostr(MissionInfo[i].wTime) + ')';
        Query.SQL.Clear;
        Query.SQL.Add(sSQLString);
        try
          Query.ExecSQL;
        except
          on e: Exception do begin
              MainOutMessage(e.Message);
              MainOutMessage('[UserMission] Error Inserting info to char:' + HumanRCD.Data.sChrName);
          end;
        end;

   end;
  end;
  result := true;
except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateMission] ' + e.Message);
end;
end;

function TFileDB.UpdateRecord(nIndex: Integer; var HumanRCD: THumDataInfo; boNew: Boolean): Boolean;
var
  i: Integer;
  sSQLString: string;
  MagicList, MakeMagics, Custom: array of byte;
begin
try
  Query.ConnectionString := sConnection;
  sSqlString := '';
  with HumanRCD.Data do begin
  try
  try
    SetLength(MagicList,Length(HumanRCD.Data.CboMagicListInfo.MagicList));
    for i := 0 to length(HumanRCD.Data.CboMagicListInfo.MagicList) - 1 do
      MagicList[i]:=HumanRCD.Data.CboMagicListInfo.MagicList[i];
    SetLength(MakeMagics,Length(HumanRCD.Data.MakeMagic));
    for i := 0 to length(HumanRCD.Data.MakeMagic) - 1 do
        MakeMagic[i]:=HumanRCD.Data.MakeMagic[i];
    SetLength(Custom,Length(HumanRCD.Data.CustomVariable)*4);
    for i := 0 to length(HumanRCD.Data.CustomVariable) - 1 do begin
      Custom[i*4]:=LoByte(LoWord(HumanRCD.Data.CustomVariable[i]));
      Custom[1+i*4]:=HiByte(LoWord(HumanRCD.Data.CustomVariable[i]));
      Custom[2+i*4]:=LoByte(HiWord(HumanRCD.Data.CustomVariable[i]));
      Custom[3+i*4]:=HiByte(HiWord(HumanRCD.Data.CustomVariable[i]));
    end;



    sSqlString:='UPDATE TBL_CHARINFO SET sCurMap=' + quotedstr(sCurMap) + ', wCurX=' + inttostr(wCurX) + ', wCurY=' + inttostr(wCurY) +
    ', btDir=' + inttostr(btDir) + ', btHair=' + inttostr(btHair) + ', btSex=' + inttostr(btSex) + ', btJob=' + inttostr(btJob) + ', nGold=' + inttostr(nGold) +
    ', nBindGold=' + inttostr(nBindGold) + ', nNakedAbilCount=' + inttostr(nNakedAbilCount) + ', sHomeMap=' + quotedstr(sHomeMap) + ', wHomeX=' + inttostr(wHomeX) +
    ', wHomeY=' + inttostr(wHomeY) + ', sDieMap=' + quotedstr(sDieMap) + ', wDieX=' + inttostr(wDieX) + ', wDieY=' + inttostr(wDieY) + ', sDearName=' + quotedstr(sDearName) +
    ', LoginTime=' + quotedstr(dateforsql(LoginTime)) + ', LoginAddr=' + quotedstr(LoginAddr) + ', btCreditPoint=' + inttostr(btCreditPoint) +
    ', sStoragePwd=' + quotedstr(sStoragePwd) + ', boMaster=' + inttostr(setBoolean(boMaster)) + ', boStorageLock=' + inttostr(setBoolean(boStorageLock)) + ', btStorageErrorCount=' + inttostr(btStorageErrorCount) +
    ', StorageLockTime=' + quotedstr(dateforsql(StorageLockTime)) + ', btReLevel=' + inttostr(btReLevel) + ', nGameGold=' + inttostr(nGameGold) + ', nGamePoint=' + inttostr(nGamePoint) +
    ', nGameDiamond=' + inttostr(nGameDiamond) + ', nGameGird=' + inttostr(nGameGird) + ', nPKPoint=' + inttostr(nPKPoint) + ', nPullulation=' + inttostr(nPullulation) +
    ', btAttatckMode=' + inttostr(btAttatckMode) + ', nIncHealth=' + inttostr(nIncHealth) + ', nIncSpell=' + inttostr(nIncSpell) + ', nIncHealing=' + inttostr(nIncHealing) +
    ', btFightZoneDieCount=' + inttostr(btFightZoneDieCount) + ', sAccount=' + quotedstr(sAccount) + ', sGuildName=' + quotedstr(sGuildName) + ', wContribution=' + inttostr(wContribution) +
    ', dBodyLuck=' + floattostr(dBodyLuck) + ', wGuildRcallTime=' + inttostr(wGuildRcallTime) + ', wGroupRcallTime=' + inttostr(wGroupRcallTime) + ', nAllowSetup=' + inttostr(nAllowSetup) +
    ', boAddStabilityPoint=' + inttostr(setBoolean(boAddStabilityPoint)) + ', btMasterCount=' + inttostr(btMasterCount) + ', btWuXin=' + inttostr(btWuXin) +
    ', boChangeName=' + inttostr(setBoolean(boChangeName)) + ', nExpRate=' + inttostr(nExpRate) + ', nExpTime=' + inttostr(nExpTime) + ', dwUpLoadPhotoTime=' + quotedstr(dateforsql(dwUpLoadPhotoTime)) +
    ', wNakedBackCount=' + inttostr(wNakedBackCount) + ', nItemsSetupCount=' + inttostr(nItemsSetupCount) + ', MagicList=:magiclist, nMagicList=' + inttostr(CboMagicListInfo.nMagicList) +
    ',StorageGold=' + inttostr(nStorageGold) + ', MakeMagicPoint=' + inttostr(MakeMagicPoint) + ', CustomVariable=:custom, MakeMagic=:makemagic, ' +
    'StorageOpen2=' + inttostr(setBoolean(StorageOpen2)) + ', StorageTime2=' + quotedstr(dateforsql(StorageTime2)) + ', StorageOpen3=' + inttostr(setBoolean(StorageOpen3)) + ', StorageTime3=' + quotedstr(dateforsql(StorageTime3)) +
    ' WHERE nIdx=' + inttostr(nIndex);
    ADOCommand:=TADOCommand.Create(nil);
    ADOCommand.Connection:=AdoConnection;
    ADOCommand.Parameters.Clear;
    ADOCommand.CommandText := sSQLString;
    ADOCommand.ParamCheck:=False;
    ADOCommand.Parameters.ParamByName('magiclist').Value :=MagicList;
    ADOCommand.Parameters.ParamByName('makemagic').Value :=makemagics;
    ADOCommand.Parameters.ParamByName('custom').Value :=custom;
    ADOCommand.Execute;
  except
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage(sSqlString);
      MainOutMessage('[CharInfo]tbl_charinfo, Error updating char:' + HumanRCD.Data.sChrName);
    end;
  end;
  finally
    ADOCommand.Free;
  end;
  end;

  sSqlString:='Update Tbl_CharList SET ModDate=' + quotedstr(dateforsql(now())) + ' WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  try
    Query.SQL.Clear;
    Query.SQL.Add(sSqlString);
    Query.ExecSQL
  except
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage('[CharList]tbl_charlist, Error updating char:' + HumanRCD.Data.sChrName);
    end;
  end;

  sSqlString:='Update Tbl_StatusArray SET ';
  for i:= 0 to MAX_STATUS_ATTRIBUTE-1 do
    sSqlString := sSqlString + 'Status' + IntToStr(i) + '=' + IntToStr(HumanRCD.Data.wStatusTimeArr[i]) + ', ';
  sSqlString := sSqlString + ' CharName=' + quotedstr(HumanRCD.Data.sChrName) + ' WHERE CharName=' + quotedstr(HumanRCD.Data.sChrName);
  try
    Query.SQL.Clear;
    Query.SQL.Add(sSqlString);
    Query.ExecSQL;
  except
    on e: Exception do begin
      MainOutMessage(e.Message);
      MainOutMessage('[StatusArray]tbl_statusarray, Error updating char:' + HumanRCD.Data.sChrName);
    end;
  end;

  updateMagic(HumanRCD);
  updateAbility(HumanRCD);
  updateProfile(HumanRCD);
  updateKeyInfo(HumanRCD);
  updateMaster(HumanRCD);
  updateOptions(HumanRCD);
  updateQuestFlag(HumanRCD);
  updateMission(HumanRCD);
  updateFriend(HumanRCD);
  updateHumItems(HumanRCD);
  updateBagItems(HumanRCD);
  updateReturnItems(HumanRCD);
  updateAppendItems(HumanRCD);
  updateStorageItems(HumanRCD);
  Result := True;

except
  on e: Exception do
    MainOutMessage('[TFileDB UpdateRecord] ' + e.Message);
end;
end;

function TFileDB.Find(sChrName: string;
  List: TStrings): Integer; //0x0048B590
var
  i: Integer;
begin
try
  for i := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[i], sChrName, Length(sChrName)) then begin
      List.AddObject(m_QuickList.Strings[i], m_QuickList.Objects[i]);
    end;
  end;
  Result := List.Count;
except
  on e: Exception do
    MainOutMessage('[TFileDB Find] ' + e.Message);
end;
end;

function TFileDB.Delete(nIndex: Integer): Boolean; //0x0048AF4C
var
  I: Integer;
  s14:String;
begin
  try
    for I := 0 to m_QuickList.Count - 1 do begin
      if Integer(m_QuickList.Objects[i]) = nIndex then begin
        s14:=m_QuickList.Strings[i];
        if DeleteRecord(nIndex) then begin
          m_QuickList.Delete(i);
          break;
        end;
      end;
    end;
  except
    MainOutMessage('FileDB delete Error: ' + IntToStr(nIndex));
  end;
  result := true;
end;

function TFileDB.DeleteRecord(index:integer): Boolean; //0x0048AD8C
begin
  result := true;
end;

function TFileDB.Count: Integer;
begin
try
  Result := m_QuickList.Count;
except
  on e: Exception do
    MainOutMessage('[TFileDB Count] ' + e.Message);
end;
end;

function TFileDB.Delete(sChrName: string): Boolean; //0x0048AEB4
var
  n10: Integer;
begin
try
  Result := False;
  n10 := m_QuickList.GetIndex(sChrName);
  if n10 < 0 then
    Exit;
  if DeleteRecord(Integer(m_QuickList.Objects[n10])) then begin
    m_QuickList.Delete(n10);
    Result := True;
  end;
except
  on e: Exception do
    MainOutMessage('[TFileDB Delete] ' + e.Message);
end;
end;
end.

