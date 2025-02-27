unit FrmFindId;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Grids, IDDB, Grobal2;
type
  TFrmFindUserId = class(TForm)
    IdGrid: TStringGrid;
    Panel1: TPanel;
    EdFindId: TEdit;
    Label1: TLabel;
    BtnFindAll: TButton;
    Button1: TButton;
    BtnEdit: TButton;
    Button2: TButton;

    procedure FormCreate(Sender: TObject);
    procedure BtnFindAllClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EdFindIdKeyPress(Sender: TObject; var Key: Char);
  private
    procedure RefChrGrid(nIndex: Integer; var DBRecord: TAccountDBRecord);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFindUserId: TFrmFindUserId;

implementation

uses EditUserInfo, LMain, MasSock, LSShare;
{$R *.DFM}
procedure TFrmFindUserId.EdFindIdKeyPress(Sender: TObject; var Key: Char);
var
  sAccount: string;
  n08, nIndex: Integer;
  boAccountExists: Boolean;
  DBRecord: TAccountDBRecord;
begin
  if Key <> #13 then Exit;
  sAccount := Trim(EdFindId.Text);
  IdGrid.RowCount := 1;
  try
    //if AccountDB.Open then begin
      n08 := AccountDB.Index(sAccount);
      if n08 >= 0 then begin
        boAccountExists := AccountDB.Get(sAccount, DBRecord);
        if boAccountExists then RefChrGrid(-1, DBRecord);
      end;
    //end;
  except
    MainOutMessage('EdFindIdKeyPress: An error has occured trying to process an account');
  end;
end;

procedure TFrmFindUserId.FormCreate(Sender: TObject);
begin
  IdGrid.RowCount := 2;
  IdGrid.Cells[0, 0] := 'Account';
  IdGrid.Cells[1, 0] := 'Password';
  IdGrid.Cells[2, 0] := 'Name';
  IdGrid.Cells[3, 0] := 'SS No';
  IdGrid.Cells[4, 0] := 'DOB';
  IdGrid.Cells[5, 0] := 'Question 1';
  IdGrid.Cells[6, 0] := 'Answer 1';
  IdGrid.Cells[7, 0] := 'Question 2';
  IdGrid.Cells[8, 0] := 'Answer 2';
  IdGrid.Cells[9, 0] := 'Phone No';
  IdGrid.Cells[10, 0] := 'Mobile No';
  IdGrid.Cells[11, 0] := 'Note 1';
  IdGrid.Cells[12, 0] := 'Note 2';
  IdGrid.Cells[13, 0] := 'Created On';
  IdGrid.Cells[14, 0] := 'Last Login';
  IdGrid.Cells[15, 0] := 'EMail Address';
end;
//0x00467BF8
procedure TFrmFindUserId.BtnFindAllClick(Sender: TObject);
var
  sAccount: string;
  AccountList: TStringList;
  I, nIndex: Integer;
  DBRecord: TAccountDBRecord;
begin
  try
    IdGrid.RowCount := 1;
    sAccount := Trim(EdFindId.Text);
    if sAccount = '' then Exit;
    AccountList := TStringList.Create;
    try
      //if AccountDB.Open then begin
        if AccountDB.FindByName(sAccount, AccountList) > 0 then begin
          for I := 0 to AccountList.Count - 1 do begin
            nIndex := Integer(AccountList.Objects[I]);
            if AccountDB.Get(sAccount, DBRecord) then begin
              RefChrGrid(-1, DBRecord);
            end;
          end;
        end;
      //end;
    except
      MainOutMessage('BtnFindAllClick: An error has occured trying to process an account');
    end;
    AccountList.Free;
  except
    MainOutMessage('TFrmFindUserId.BtnFindAllClick');
  end;
end;

procedure TFrmFindUserId.Button1Click(Sender: TObject);
begin
  FrmMasSoc.LoadServerAddr();
end;
//0x00467D84
procedure TFrmFindUserId.BtnEditClick(Sender: TObject);
var
  nRow, nIndex: Integer;
  sAccount: string;
  DBRecord: TAccountDBRecord;
  //bo11,
  bo12: Boolean;
  Config: pTConfig;
resourcestring
  sEditAccount = 'ch2';
begin
  Config := @g_Config;
  nRow := IdGrid.Row;
  if nRow <= 0 then Exit;
  sAccount := IdGrid.Cells[0, nRow];
  if sAccount = '' then Exit;
  bo12 := False;
  try
    //if AccountDB.OpenEx then begin
      nIndex := AccountDB.Index(sAccount);
      if nIndex >= 0 then
        if not AccountDB.Get(sAccount, DBRecord) then exit;
    //end;
  except
    MainOutMessage('BtnEditClick: An error has occured trying to process an account');
  end;
  if FrmUserInfoEdit.sub_466AEC(DBRecord) then begin
    try
      //if AccountDB.Open then begin
        nIndex := AccountDB.Index(sAccount);
        if nIndex >= 0 then
          if AccountDB.Update(DBRecord) then begin
            RefChrGrid(nRow, DBRecord);
            bo12 := true;
          end;
      //end;
    except
      MainOutMessage('BtnEditClick: An error has occured trying to process an account');
    end;
  end;
  if bo12 then begin //00467F34
    WriteLogMsg(Config, sEditAccount, DBRecord.UserEntry, DBRecord.UserEntryAdd);
  end;
end;
//00467F94
procedure TFrmFindUserId.Button2Click(Sender: TObject);
var
  DBRecord: TAccountDBRecord;
  sAccount: string;
  nIndex: Integer;
  boMakeSuccess: Boolean;
  Config: pTConfig;
resourcestring
  sAddAccount = 'ch2';
  sMakingIDSuccess = 'D created: %s';
begin
  Config := @g_Config;
  FillChar(DBRecord, SizeOf(TAccountDBRecord), #0);
  boMakeSuccess := False;
  if FrmUserInfoEdit.sub_466B10(true, DBRecord) and (DBRecord.UserEntry.sAccount <> '') then begin
    sAccount := DBRecord.UserEntry.sAccount;
    DBRecord.Header.sAccount := sAccount;
    try
      //if AccountDB.Open then begin
        nIndex := AccountDB.Index(sAccount);
        if nIndex < 0 then begin
          if AccountDB.Add(DBRecord) then boMakeSuccess := true;
        end;
      //end;
    except
      MainOutMessage('Button2Click: An error has occured trying to process an account');
    end;
  end;
  if boMakeSuccess then begin
    MainOutMessage(format(sMakingIDSuccess, [sAccount]));
    WriteLogMsg(Config, sAddAccount, DBRecord.UserEntry, DBRecord.UserEntryAdd);
  end;
end;

procedure TFrmFindUserId.RefChrGrid(nIndex: Integer; var DBRecord: TAccountDBRecord);
var
  nRow: Integer;
begin
  try
    if nIndex <= 0 then begin
      IdGrid.RowCount := IdGrid.RowCount + 1;
      IdGrid.FixedRows := 1;
      nRow := IdGrid.RowCount - 1;
    end else begin
      nRow := nIndex;
    end;
    IdGrid.Cells[0, nRow] := DBRecord.UserEntry.sAccount;
    IdGrid.Cells[1, nRow] := DBRecord.UserEntry.sPassword;
    IdGrid.Cells[2, nRow] := DBRecord.UserEntry.sUserName;
    IdGrid.Cells[3, nRow] := DBRecord.UserEntry.sSSNo;
    IdGrid.Cells[4, nRow] := DBRecord.UserEntryAdd.sBirthDay;
    IdGrid.Cells[5, nRow] := DBRecord.UserEntry.sQuiz;
    IdGrid.Cells[6, nRow] := DBRecord.UserEntry.sAnswer;
    IdGrid.Cells[7, nRow] := DBRecord.UserEntryAdd.sQuiz2;
    IdGrid.Cells[8, nRow] := DBRecord.UserEntryAdd.sAnswer2;
    IdGrid.Cells[9, nRow] := DBRecord.UserEntry.sPhone;
    IdGrid.Cells[10, nRow] := DBRecord.UserEntryAdd.sMobilePhone;
    IdGrid.Cells[11, nRow] := DBRecord.UserEntryAdd.sMemo;
    IdGrid.Cells[12, nRow] := DBRecord.UserEntryAdd.sMemo2;
    IdGrid.Cells[13, nRow] := DateTimeToStr(DBRecord.Header.CreateDate);
    IdGrid.Cells[14, nRow] := DateTimeToStr(DBRecord.Header.UpdateDate);
    IdGrid.Cells[15, nRow] := DBRecord.UserEntry.sEMail;
  except

  end;
end;

end.
