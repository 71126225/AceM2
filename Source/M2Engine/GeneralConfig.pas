unit GeneralConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles, ExtCtrls;

type
  TfrmGeneralConfig = class(TForm)
    PageControl: TPageControl;
    ServerInfoSheet: TTabSheet;
    ShareSheet: TTabSheet;
    NetWorkSheet: TTabSheet;
    GroupBoxNet: TGroupBox;
    LabelGateIPaddr: TLabel;
    LabelGatePort: TLabel;
    EditGateAddr: TEdit;
    EditGatePort: TEdit;
    ButtonNetWorkSave: TButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    EditDBPort: TEdit;
    EditDBAddr: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditIDSPort: TEdit;
    EditIDSAddr: TEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    EditLogServerPort: TEdit;
    EditLogServerAddr: TEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    EditMsgSrvPort: TEdit;
    EditMsgSrvAddr: TEdit;
    GroupBoxInfo: TGroupBox;
    Label1: TLabel;
    EditGameName: TEdit;
    EditServerIndex: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditServerNumber: TEdit;
    CheckBoxServiceMode: TCheckBox;
    GroupBox5: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EditTestLevel: TEdit;
    EditTestGold: TEdit;
    EditTestUserLimit: TEdit;
    CheckBoxTestServer: TCheckBox;
    ButtonServerInfoSave: TButton;
    GroupBox6: TGroupBox;
    Label15: TLabel;
    EditUserFull: TEdit;
    GroupBox7: TGroupBox;
    Label16: TLabel;
    EditDBName: TEdit;
    EditGuildDir: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    EditGuildFile: TEdit;
    EditConLogDir: TEdit;
    EditCastleDir: TEdit;
    EditEnvirDir: TEdit;
    EditMapDir: TEdit;
    EditNoticeDir: TEdit;
    EditPlugDir: TEdit;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    EditVentureDir: TEdit;
    Label25: TLabel;
    ButtonShareDirSave: TButton;
    Label26: TLabel;
    TabSheet1: TTabSheet;
    GroupBox8: TGroupBox;
    ColorBoxHint: TColorBox;
    GroupBox9: TGroupBox;
    ColorBox1: TColorBox;
    Label27: TLabel;
    ColorBox2: TColorBox;
    Label28: TLabel;
    Label29: TLabel;
    Button1: TButton;
    procedure ButtonNetWorkSaveClick(Sender: TObject);
    procedure EditValueChange(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure CheckBoxTestServerClick(Sender: TObject);
    procedure ButtonServerInfoSaveClick(Sender: TObject);
    procedure ButtonShareDirSaveClick(Sender: TObject);
    procedure ColorBoxHintChange(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefDlgConf();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGeneralConfig: TfrmGeneralConfig;

implementation

uses HUtil32, M2Share;

{$R *.dfm}

procedure TfrmGeneralConfig.ModValue;
begin
  boModValued := True;
  ButtonNetWorkSave.Enabled := True;
  ButtonServerInfoSave.Enabled := True;
  ButtonShareDirSave.Enabled := True;
end;

procedure TfrmGeneralConfig.uModValue;
begin
  boModValued := False;
  ButtonNetWorkSave.Enabled := False;
  ButtonServerInfoSave.Enabled := False;
  ButtonShareDirSave.Enabled := False;
end;

procedure TfrmGeneralConfig.ButtonNetWorkSaveClick(Sender: TObject);
var
  Gateaddr, IDSAddr, DBAddr, LogServerAddr, MsgSrvAddr: string;
  GatePort, IDSPort, DBPort, LogServerPort, MsgSrvPort: Integer;
begin

  Gateaddr := Trim(EditGateAddr.Text);
  GatePort := StrToIntDef(Trim(EditGatePort.Text), -1);
  IDSAddr := Trim(EditIDSAddr.Text);
  IDSPort := StrToIntDef(Trim(EditIDSPort.Text), -1);
  DBAddr := Trim(EditDBAddr.Text);
  DBPort := StrToIntDef(Trim(EditDBPort.Text), -1);
  LogServerAddr := Trim(EditLogServerAddr.Text);
  LogServerPort := StrToIntDef(Trim(EditLogServerPort.Text), -1);

  MsgSrvAddr := Trim(EditMsgSrvAddr.Text);
  MsgSrvPort := StrToIntDef(Trim(EditMsgSrvPort.Text), -1);

  if not IsIPaddr(Gateaddr) then begin
    Application.MessageBox('Gateway address is set incorrectly!!!', 'Error Message', MB_OK +
      MB_ICONERROR);
    EditGateAddr.SetFocus;
    exit;
  end;

  if (GatePort < 0) or (GatePort > 65535) then begin
    Application.MessageBox('Gateway port settings wrong!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditGatePort.SetFocus;
    exit;
  end;

  if not IsIPaddr(IDSAddr) then begin
    Application.MessageBox('Management Server address is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditIDSAddr.SetFocus;
    exit;
  end;

  if (IDSPort < 0) or (IDSPort > 65535) then begin
    Application.MessageBox('Management server port setting is incorrect!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditIDSPort.SetFocus;
    exit;
  end;

  if not IsIPaddr(DBAddr) then begin
    Application.MessageBox('Database server address is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditDBAddr.SetFocus;
    exit;
  end;

  if (DBPort < 0) or (DBPort > 65535) then begin
    Application.MessageBox('Database server port is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditDBPort.SetFocus;
    exit;
  end;

  if not IsIPaddr(LogServerAddr) then begin
    Application.MessageBox('Log server address is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditLogServerAddr.SetFocus;
    exit;
  end;

  if (LogServerPort < 0) or (LogServerPort > 65535) then begin
    Application.MessageBox('Log server port setting is incorrect!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditLogServerPort.SetFocus;
    exit;
  end;

  if not IsIPaddr(MsgSrvAddr) then begin
    Application.MessageBox('The main game server address is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditMsgSrvAddr.SetFocus;
    exit;
  end;

  if (MsgSrvPort < 0) or (MsgSrvPort > 65535) then begin
    Application.MessageBox('The main game server port setting is incorrect!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditMsgSrvPort.SetFocus;
    exit;
  end;

  g_Config.sGateAddr := Gateaddr;
  g_Config.nGatePort := GatePort;
  g_Config.sIDSAddr := IDSAddr;
  g_Config.nIDSPort := IDSPort;
  g_Config.sDBAddr := DBAddr;
  g_Config.nDBPort := DBPort;
  g_Config.sLogServerAddr := LogServerAddr;
  g_Config.nLogServerPort := LogServerPort;
  g_Config.sMsgSrvAddr := MsgSrvAddr;
  g_Config.nMsgSrvPort := MsgSrvPort;

  Config.WriteString('Server', 'GateAddr', g_Config.sGateAddr);
  Config.WriteInteger('Server', 'GatePort', g_Config.nGatePort);
  Config.WriteString('Server', 'IDSAddr', g_Config.sIDSAddr);
  Config.WriteInteger('Server', 'IDSPort', g_Config.nIDSPort);
  Config.WriteString('Server', 'DBAddr', g_Config.sDBAddr);
  Config.WriteInteger('Server', 'DBPort', g_Config.nDBPort);
  Config.WriteString('Server', 'LogServerAddr', g_Config.sLogServerAddr);
  Config.WriteInteger('Server', 'LogServerPort', g_Config.nLogServerPort);
  Config.WriteString('Server', 'MsgSrvAddr', g_Config.sMsgSrvAddr);
  Config.WriteInteger('Server', 'MsgSrvPort', g_Config.nMsgSrvPort);
  uModValue();
end;

procedure TfrmGeneralConfig.Open;
begin
  boOpened := False;
  uModValue();
  EditGateAddr.Text := g_Config.sGateAddr;
  EditGatePort.Text := IntToStr(g_Config.nGatePort);
  EditIDSAddr.Text := g_Config.sIDSAddr;
  EditIDSPort.Text := IntToStr(g_Config.nIDSPort);
  EditDBAddr.Text := g_Config.sDBAddr;
  EditDBPort.Text := IntToStr(g_Config.nDBPort);
  EditLogServerAddr.Text := g_Config.sLogServerAddr;
  EditLogServerPort.Text := IntToStr(g_Config.nLogServerPort);

  EditGameName.Text := g_Config.sServerName;
  EditServerIndex.Text := IntToStr(nServerIndex);
  EditServerNumber.Text := IntToStr(g_Config.nServerNumber);
  CheckBoxServiceMode.Checked := g_Config.boServiceMode;
  CheckBoxTestServer.Checked := g_Config.boTestServer;
  EditTestLevel.Text := IntToStr(g_Config.nTestLevel);
  EditTestGold.Text := IntToStr(g_Config.nTestGold);
  EditTestUserLimit.Text := IntToStr(g_Config.nTestUserLimit);
  EditUserFull.Text := IntToStr(g_Config.nUserFull);
  CheckBoxTestServerClick(Self);
  EditDBName.Text := sDBName;

  EditGuildDir.Text := g_Config.sGuildDir;
  EditGuildFile.Text := g_Config.sGuildFile;
  EditConLogDir.Text := g_Config.sConLogDir;
  EditCastleDir.Text := g_Config.sCastleDir;
  EditEnvirDir.Text := g_Config.sEnvirDir;
  EditMapDir.Text := g_Config.sMapDir;
  //EditNoticeDir.Text := g_Config.sNoticeDir;
  //EditPlugDir.Text := g_Config.sPlugDir;
  //EditVentureDir.Text := g_Config.sVentureDir;

  RefDlgConf();

  boOpened := True;
  PageControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmGeneralConfig.EditValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  ModValue();
end;

procedure TfrmGeneralConfig.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if boModValued then begin
    if Application.MessageBox('Parameter settings have been modified, Comtinue without saving changes?',
           'Confirmation', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      uModValue
    end
    else
      AllowChange := False;
  end;
end;

procedure TfrmGeneralConfig.CheckBoxTestServerClick(Sender: TObject);
var
  boStatue: Boolean;
begin
  boStatue := CheckBoxTestServer.Checked;
  EditTestLevel.Enabled := boStatue;
  EditTestGold.Enabled := boStatue;
  EditTestUserLimit.Enabled := boStatue;
  EditValueChange(Sender);
end;

procedure TfrmGeneralConfig.ButtonServerInfoSaveClick(Sender: TObject);
var
  GameName, DBName: string;
  ServerIndex, ServerNumber, TestLevel, TestGold, TestUserLimit, UserFull:
    Integer;
  TestServer, ServiceMode: Boolean;
begin
  GameName := Trim(EditGameName.Text);
  ServerIndex := StrToIntDef(Trim(EditServerIndex.Text), -1);
  ServerNumber := StrToIntDef(Trim(EditServerNumber.Text), -1);
  ServiceMode := CheckBoxServiceMode.Checked;
  TestServer := CheckBoxTestServer.Checked;
  TestLevel := StrToIntDef(Trim(EditTestLevel.Text), -1);
  TestGold := StrToIntDef(Trim(EditTestGold.Text), -1);
  TestUserLimit := StrToIntDef(Trim(EditTestUserLimit.Text), -1);
  UserFull := StrToIntDef(Trim(EditUserFull.Text), -1);
  DBName := Trim(EditDBName.Text);
  if GameName = '' then begin
    Application.MessageBox('Game Title is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditGameName.SetFocus;
    exit;
  end;

  if (ServerIndex < 0) or (ServerIndex > 255) then begin
    Application.MessageBox('Server number is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditServerIndex.SetFocus;
    exit;
  end;

  if (ServerNumber < 0) or (ServerNumber > 255) then begin
    Application.MessageBox('Set the server number error!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditServerNumber.SetFocus;
    exit;
  end;
  if (TestLevel < 0) or (TestLevel > 65535) then begin
    Application.MessageBox('Start level setting error!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditTestLevel.SetFocus;
    exit;
  end;
  if (TestGold < 0) or (TestGold > High(Integer) div 2) then begin
    Application.MessageBox('Starting gold setting error!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditTestGold.SetFocus;
    exit;
  end;

  if (TestUserLimit < 0) or (TestUserLimit > 10000) then begin
    Application.MessageBox('Number of test users set error!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditTestUserLimit.SetFocus;
    exit;
  end;

  if (UserFull < 0) or (UserFull > 10000) then begin
    Application.MessageBox('Limit the number of users set errors!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditUserFull.SetFocus;
    exit;
  end;

  if DBName = '' then begin
    Application.MessageBox('Database name is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditDBName.SetFocus;
    exit;
  end;

  g_Config.sServerName := GameName;
  //nServerIndex:=ServerIndex;
  g_Config.nServerNumber := ServerNumber;
  g_Config.boServiceMode := ServiceMode;
  g_Config.boTestServer := TestServer;
  g_Config.nTestLevel := TestLevel;
  g_Config.nTestGold := TestGold;
  g_Config.nTestUserLimit := TestUserLimit;
  g_Config.nUserFull := UserFull;
  sDBName := DBName;

  Config.WriteString('Server', 'ServerName', g_Config.sServerName);
  Config.WriteInteger('Server', 'ServerIndex', nServerIndex);
  Config.WriteInteger('Server', 'ServerNumber', g_Config.nServerNumber);
  Config.WriteString('Server', 'TestServer', BoolToStr(g_Config.boTestServer));
  Config.WriteInteger('Server', 'TestLevel', g_Config.nTestLevel);
  Config.WriteInteger('Server', 'TestGold', g_Config.nTestGold);
  Config.WriteInteger('Server', 'TestServerUserLimit', g_Config.nTestUserLimit);
  Config.WriteInteger('Server', 'UserFull', g_Config.nUserFull);
  Config.WriteString('Server', 'DBName', sDBName);
  uModValue();
end;

procedure TfrmGeneralConfig.ButtonShareDirSaveClick(Sender: TObject);
var
  GuildDir, GuildFile, VentureDir, ConLogDir, CastleDir, EnvirDir, MapDir,
    NoticeDir, PlugDir: string;
begin
  GuildDir := Trim(EditGuildDir.Text);
  GuildFile := Trim(EditGuildFile.Text);
  VentureDir := Trim(EditVentureDir.Text);
  ConLogDir := Trim(EditConLogDir.Text);
  CastleDir := Trim(EditCastleDir.Text);
  EnvirDir := Trim(EditEnvirDir.Text);
  MapDir := Trim(EditMapDir.Text);
  NoticeDir := Trim(EditNoticeDir.Text);
  PlugDir := Trim(EditPlugDir.Text);

  if not DirectoryExists(GuildDir) or (GuildDir[Length(GuildDir)] <> '\') then
    begin
    Application.MessageBox('Guild directory error!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditGuildDir.SetFocus;
    exit;
  end;
  if not FileExists(GuildFile) then begin
    Application.MessageBox('Guilds list set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditGuildFile.SetFocus;
    exit;
  end;
  if not DirectoryExists(VentureDir) or (VentureDir[Length(VentureDir)] <> '\')
    then begin
    Application.MessageBox('Venture directory is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditVentureDir.SetFocus;
    exit;
  end;
  if not DirectoryExists(ConLogDir) or (ConLogDir[Length(ConLogDir)] <> '\') then
    begin
    Application.MessageBox('Log directory set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditConLogDir.SetFocus;
    exit;
  end;
  if not DirectoryExists(CastleDir) or (CastleDir[Length(CastleDir)] <> '\') then
    begin
    Application.MessageBox('Castle directory is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditCastleDir.SetFocus;
    exit;
  end;
  if not DirectoryExists(EnvirDir) or (EnvirDir[Length(EnvirDir)] <> '\') then
    begin
    Application.MessageBox('Configuration directory is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditEnvirDir.SetFocus;
    exit;
  end;
  if not DirectoryExists(MapDir) or (MapDir[Length(MapDir)] <> '\') then begin
    Application.MessageBox('Map directory is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditMapDir.SetFocus;
    exit;
  end;
  if not DirectoryExists(NoticeDir) or (NoticeDir[Length(NoticeDir)] <> '\') then
    begin
    Application.MessageBox('Notice directory is set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditNoticeDir.SetFocus;
    exit;
  end;
  if not DirectoryExists(PlugDir) or (PlugDir[Length(PlugDir)] <> '\') then begin
    Application.MessageBox('Plugin directory set incorrectly!!!','Error message', MB_OK +
      MB_ICONERROR);
    EditPlugDir.SetFocus;
    exit;
  end;

  g_Config.sGuildDir := GuildDir;
  g_Config.sGuildFile := GuildFile;
  //g_Config.sVentureDir := VentureDir;
  g_Config.sConLogDir := ConLogDir;
  g_Config.sCastleDir := CastleDir;
  g_Config.sEnvirDir := EnvirDir;
  g_Config.sMapDir := MapDir;
  //g_Config.sNoticeDir := NoticeDir;
  //g_Config.sPlugDir := PlugDir;

  Config.WriteString('Share', 'GuildDir', g_Config.sGuildDir);
  Config.WriteString('Share', 'GuildFile', g_Config.sGuildFile);
  //Config.WriteString('Share', 'VentureDir', g_Config.sVentureDir);
  Config.WriteString('Share', 'ConLogDir', g_Config.sConLogDir);
  Config.WriteString('Share', 'CastleDir', g_Config.sCastleDir);
  Config.WriteString('Share', 'EnvirDir', g_Config.sEnvirDir);
  Config.WriteString('Share', 'MapDir', g_Config.sMapDir);
  //Config.WriteString('Share', 'NoticeDir', g_Config.sNoticeDir);
  //Config.WriteString('Share', 'PlugDir', g_Config.sPlugDir);

  uModValue();
end;

procedure TfrmGeneralConfig.RefDlgConf;
begin
  ColorBoxHint.Selected := Application.HintColor;
end;

procedure TfrmGeneralConfig.ColorBoxHintChange(Sender: TObject);
begin
  Application.HintColor := ColorBoxHint.Selected;
end;

end.
