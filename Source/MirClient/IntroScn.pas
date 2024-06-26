unit IntroScn;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, HGETextures, HGECanvas, HGEBase, Grobal2, cliUtil, SoundUtil,
  HUtil32, EDcodeEx;

const

  SELECTEDFRAME = 16;
  FREEZEFRAME = 13;
  EFFECTFRAME = 14;
  LOGINBAGIMGINDEX = 22;
  GLOWFRAME     = 12;

type
  TLoginState = (lsLogin, lsNewid, lsNewidRetry, lsChgpw, lsCloseAll, lsCard);
  TSelectChrState = (scSelectChr, scCreateChr, scRenewChr);
  TSceneType = (stLogin, stSelectChr, stPlayGame, stSelServer, stHint, stClose);
  TLastForm = (lf_Login, lf_SelectChr, lf_Play);

  TSelChar = record
    Valid: Boolean;
    UserChr: TUserCharacterInfo;
    Selected: Boolean;
    AniIndex: Integer; //녹는(어는) 애니메이션
    DarkLevel: Integer;
    EffIndex: Integer; //효과 애니메이션
    StartTime: LongWord;
    moretime: LongWord;
    startefftime: LongWord;
    NewCharacter: Boolean;
    PerformAction: Boolean;
    GlowIndex: Integer;
    ActionIndex: Integer;
  end;

  TScene = class
  private
  public
    scenetype: TSceneType;
    constructor Create(scenetype: TSceneType);
    function Initialize: Boolean; dynamic;
    procedure Finalize; dynamic;
    procedure OpenScene; dynamic;
    procedure CloseScene; dynamic;
    procedure OpeningScene; dynamic;
    procedure KeyPress(var Key: Char); dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
      Integer);
      dynamic;
    procedure PlayScene(MSurface: TDirectDrawSurface); dynamic;
  end;

  TSelServer = class(TScene)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
  end;

  THintScene = class(TScene)
  private
  public
    constructor Create;
    destructor Destroy; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
  end;

  TLoginScene = class(TScene)
  private
    m_nLightCurFrame: Integer;
    m_nLightMaxFrame: Integer;
    m_nFire1CurFrame: Integer;
    m_nFire1MaxFrame: Integer;
    m_nFire2CurFrame: Integer;
    m_nFire2MaxFrame: Integer;
    m_nFire3CurFrame: Integer;
    m_nFire3MaxFrame: Integer;
    m_nFire4CurFrame: Integer;
    m_nFire4MaxFrame: Integer;
    m_dwEffectTick: LongWord;
    m_dwFireEffectTick: LongWord;
    m_nCurFrame: Integer;
    m_nMaxFrame: Integer;
    m_dwStartTime: LongWord; //한 프래임당 시간
    m_boNowOpening: Boolean;
    m_boOpenFirst: Boolean;
    m_NewIdRetryUE: TUserEntry;
    m_NewIdRetryAdd: TUserEntryAdd;
    procedure EdLoginIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdLoginPasswdKeyPress(Sender: TObject; var Key: Char);
    procedure EdNewIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdCardKeyPress(Sender: TObject; var Key: Char);
    procedure EdNewOnEnter(Sender: TObject);
    function CheckUserEntrys: Boolean;
    function NewIdCheckNewId: Boolean;
    function NewIdCheckBirthDay: Boolean;
    procedure EdChrnameKeyPress(Sender: TObject; var Key: Char);
  public
    m_sLoginId: string;
    m_sLoginPasswd: string;
    //m_boUpdateAccountMode: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
    procedure ChangeLoginState(State: TLoginState);
    procedure NewClick;
    procedure NewIdRetry(boupdate: Boolean);
    procedure OkClick;
    procedure ChgPwClick;
    procedure NewAccountOk;
    procedure CardOK;
    procedure NewAccountClose;
    procedure ChgpwOk;
    procedure ChgpwCancel;
    procedure HideLoginBox;
    procedure OpenLoginDoor;
    procedure PassWdFail;
  end;

  TSelectChrScene = class(TScene)
  private
    SoundTimer: TTimer;
    m_nEffectLoginWater1Tick : LongWord;
    m_nEffectLoginWater1Frame : Integer;
    m_nEffectLoginWater2Tick : LongWord;
    m_nEffectLoginWater2Frame : Integer;
    m_nEffectLoginFire5Tick : LongWord;
    m_nEffectLoginFire5Frame : Integer;
    m_nEffectLoginFire6Tick : LongWord;
    m_nEffectLoginFire6Frame : Integer;
    m_nEffectLoginFire7Tick : LongWord;
    m_nEffectLoginFire7Frame : Integer;
    m_nEffectLoginFire8Tick : LongWord;
    m_nEffectLoginFire8Frame : Integer;
    procedure SoundOnTimer(Sender: TObject);
    procedure MakeNewChar(Index: Integer);
  public
    NewIndex: Integer;
    ChrArr: array[0..2] of TSelChar;
    RenewChr: array[0..16] of TRenewChrInfo;
    CreateChrMode: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
    procedure SelChrSelect1Click;
    procedure SelChrSelect2Click;
    procedure SelChrSelect3Click;
    procedure SelChrStartClick;
    procedure SelChrNewChrClick;
    procedure SelChrEraseChrClick;
    procedure SelChrCreditsClick;
    procedure SelChrExitClick;
    procedure SelChrNewClose;
    procedure SelChrNewJob(job: Integer);
    procedure SelChrNewm_btSex(sex: Integer);
    procedure SelChrNewPrevHair;
    procedure SelChrNewNextHair;
    procedure SelChrNewOk;
    procedure SelRenewChr;
    procedure ClearChrs;
    procedure AddChr(uname: string; ID, job, wuxin, Level, sex: Integer; LoginTime: TDateTime);
    procedure SelectChr(Index: Integer);
    procedure ChangeSelectChrState(State: TSelectChrState);
  end;

var
  LastForm: TLastForm = lf_Login;

implementation

uses
  ClMain, MShare, Share, HGEGUI, FState, FState2, WMFile, MD5Unit, MNShare;


constructor TScene.Create(scenetype: TSceneType);
begin
  //  scenetype := scenetype;
end;

function TScene.Initialize: Boolean;
begin
  Result := False;
end;

procedure TScene.Finalize;
begin
end;

procedure TScene.OpenScene;
begin
  ;
end;

procedure TScene.CloseScene;
begin
  ;
end;

procedure TScene.OpeningScene;
begin
end;

procedure TScene.KeyPress(var Key: Char);
begin
end;

procedure TScene.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

procedure TScene.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TScene.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
  Integer);
begin
end;

procedure TScene.PlayScene(MSurface: TDirectDrawSurface);
begin
  ;
end;

procedure TLoginScene.Initialize;
begin
  with FrmDlg2.DCardNo1 do begin
    Height := 16;
    Width := 54;
    Left := 45;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  with FrmDlg2.DCardNo2 do begin
    Height := 16;
    Width := 34;
    Left := 128;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

  with FrmDlg2.DCardNo3 do begin
    Height := 16;
    Width := 34;
    Left := 211;
    Top := 86;
    OnKeyPress := EdCardKeyPress;
    Visible := True;
  end;

//make account fields
  with FrmDlg.DEditNewId do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 47;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditNewPasswd do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 68;
    //MaxLength := 10;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditConfirm do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 89;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditEMail do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 110;
    //MaxLength := 40;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditBirthDay do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 131;
    boTransparent := False;
    //MaxLength := 10;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditQuiz1 do begin
    Height := 16;
    Width := 163;
    Left := 119;
    Top := 152;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditAnswer1 do begin
    Height := 16;
    Width := 163;
    Left := 119;
    Top := 173;
    //MaxLength := 12;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditQuiz2 do begin
    Height := 16;
    Width := 163;
    Left := 119;
    Top := 194;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditAnswer2 do begin
    Height := 16;
    Width := 163;
    Left := 119;
    Top := 215;
    //MaxLength := 12;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
  end;

  with FrmDlg.DEditYourName do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 186;
    //MaxLength := 20;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
    Visible := False;
  end;

  with FrmDlg.DEditRecommendation do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 225;
    //MaxLength := 14;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
    Visible := False;
  end;

  with FrmDlg.DEditPhone do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 346;
    //MaxLength := 14;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
    Visible := False;
  end;

  with FrmDlg.DEditMobPhone do begin
    Height := 16;
    Width := 116;
    Left := 119;
    Top := 367;
    //MaxLength := 13;
    OnKeyPress := EdNewIdKeyPress;
    OnEnter := EdNewOnEnter;
    tag := 11;
    Visible := False;
  end;

//change password fields
  with FrmDlg.DEditChgId do begin
    Height := 16;
    Width := 136;
    Left := 178;
    Top := 69;
    boTransparent := False;
    //MaxLength := 15;
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgCurrentpw do begin
    Height := 16;
    Width := 136;
    Left := 178;
    Top := 96;
    boTransparent := False;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgNewPw do begin
    Height := 16;
    Width := 136;
    Left := 178;
    Top := 123;
    boTransparent := False;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  with FrmDlg.DEditChgRepeat do begin
    Height := 16;
    Width := 136;
    Left := 178;
    Top := 150;
    boTransparent := False;
    //MaxLength := 20;
    PasswordChar := '*';
    OnKeyPress := EdNewIdKeyPress;
    tag := 12;
  end;

  //눼쉔훙膠
  with FrmDlg.DEditChrName do begin
    Height := 16;
    Width := 200;
    Left := 40;
    Top := 357;
    MaxLength := 14;
    boTransparent := False;
    OnKeyPress := EdChrnameKeyPress;
  end;
end;

{--------------------- Login ----------------------}

constructor TLoginScene.Create;
begin
  inherited Create(stLogin);
end;

destructor TLoginScene.Destroy;
begin
  inherited Destroy;
end;

procedure TLoginScene.OpenScene;
//var
//  i: Integer;
//  d: TDirectDrawSurface;
begin;
  m_nCurFrame := 0;
  HGE.Gfx_Restore(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT, 16);
  m_nMaxFrame := 19;

  //m_sLoginId := '';
  //m_sLoginPasswd := '';

  //FrmDlg.DEditID.
  //FrmDlg.DEditPass.

  with FrmDlg.DEditID do begin
    Left := 320;
    Top := 215;
    Height := 16;
    Width := 136;
    Visible := True;
    OnKeyPress := EdLoginIdKeyPress;
    Tag := 10;
  end;
  with FrmDlg.DEditPass do begin
    Left := 320;
    Top := 295;
    Height := 16;
    Width := 136;
    Visible := True;
    OnKeyPress := EdLoginPasswdKeyPress;
    Tag := 10;
  end;
  m_boOpenFirst := True;

  FrmDlg.DLogin.Visible := True;
  FrmDlg.DNewAccount.Visible := FALSE;
  FrmDlg.DChgPw.Visible := False;
  FrmDlg2.DMatrixCardWnd.Visible := False;
  m_boNowOpening := FALSE;

end;

procedure TLoginScene.CloseScene;
begin
  FrmDlg.DNewAccount.Visible := FALSE;
  FrmDlg.DChgPw.Visible := False;
  FrmDlg.DLogin.Visible := FALSE;
  FrmDlg2.DMatrixCardWnd.Visible := False;
end;

procedure TLoginScene.EdLoginIdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    Key := #0;
    m_sLoginId := LowerCase(FrmDlg.DEditID.Text);
    if m_sLoginId <> '' then begin
      FrmDlg.DEditPass.SetFocus;
    end;
  end;
end;

procedure TLoginScene.EdLoginPasswdKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = '~') or (Key = '''') then
    Key := '_';
  if Key = #13 then begin
    Key := #0;
    m_sLoginId := LowerCase(FrmDlg.DEditID.Text);
    m_sLoginPasswd := FrmDlg.DEditPass.Text;
  {  if g_nInterface = 1 then begin //These message boxes crash with the new interface?
    if Length(m_sLoginId) < 5 then begin
      FrmDlg.DMessageDlg('ID must be over 5 characters.', [mbOk]);
      FrmDlg.DEditID.SetFocus;
      exit;
    end;
    if Length(m_sLoginPasswd) < 5 then begin
      FrmDlg.DMessageDlg('Password must be over 5 characters.', [mbOk]);
      FrmDlg.DEditPass.SetFocus;
      exit;
    end;
  end
  else if g_nInterface = 2 then begin}
    if (m_sLoginId <> '') and (m_sLoginPasswd <> '') then begin
      FrmDlg.HintBack := stSelServer;
      FrmDlg.sHintStr := 'Vertifying account password information...';
      FrmDlg.DBTHintClose.Caption := 'Cancel';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
      if g_boSQLReg then
        frmMain.SendLogin(m_sLoginId, GetMD5TextOf16(m_sLoginPasswd))
      else
        frmMain.SendLogin(m_sLoginId, m_sLoginPasswd);
      FrmDlg.DEditID.Text := '';
      FrmDlg.DEditPass.Text := '';
    end
    else if (FrmDlg.DEditID.Text = '') then
      FrmDlg.DEditID.SetFocus;
 // end;
 end;
end;

procedure TLoginScene.PassWdFail;
begin
  FrmDlg.DEditID.SetFocus;
end;

function TLoginScene.NewIdCheckNewId: Boolean;
begin
  Result := True;
  FrmDlg.DEditNewId.Text := Trim(FrmDlg.DEditNewId.Text);
  if Length(FrmDlg.DEditNewId.Text) < 5 then begin
    FrmDlg.DMessageDlg('Login ID must be over 5 characters.', [mbOk]);
    Beep;
    FrmDlg.DEditNewId.SetFocus;
    Result := FALSE;
  end;
end;

procedure TLoginScene.NewIdRetry(boupdate: Boolean);
begin
  ChangeLoginState(lsNewidRetry);
  FrmDlg.DEditNewId.Text := m_NewIdRetryUE.sAccount;
  FrmDlg.DEditNewPasswd.Text := m_NewIdRetryUE.sPassword;
  FrmDlg.DEditBirthDay.Text := m_NewIdRetryAdd.sBirthDay;
  FrmDlg.DEditQuiz1.Text := m_NewIdRetryUE.sQuiz;
  FrmDlg.DEditAnswer1.Text := m_NewIdRetryUE.sAnswer;
  FrmDlg.DEditEMail.Text := m_NewIdRetryUE.sEMail;
  FrmDlg.DEditQuiz2.Text := m_NewIdRetryAdd.sQuiz2;
  FrmDlg.DEditAnswer2.Text := m_NewIdRetryAdd.sAnswer2;
  FrmDlg.DEditMobPhone.Text := m_NewIdRetryAdd.sMobilePhone;
  FrmDlg.DEditPhone.Text := m_NewIdRetryUE.sPhone;
  FrmDlg.DEditYourName.Text := m_NewIdRetryUE.sUserName;
  FrmDlg.DEditRecommendation.Text := m_NewIdRetryUE.sSSNo;
end;

function TLoginScene.NewIdCheckBirthDay: Boolean;
var
  str, syear, smon, sday: string;
  ayear, amon, aday: Integer;
  flag: Boolean;
begin
  Result := True;
  flag := True;
  str := FrmDlg.DEditBirthDay.Text;
  str := GetValidStr3(str, syear, ['/']);
  str := GetValidStr3(str, smon, ['/']);
  str := GetValidStr3(str, sday, ['/']);
  ayear := StrToIntDef(syear, 0);
  amon := StrToIntDef(smon, 0);
  aday := StrToIntDef(sday, 0);
  if (ayear <= 1890) or (ayear > 2101) then
    flag := FALSE;
  if (amon <= 0) or (amon > 12) then
    flag := FALSE;
  if (aday <= 0) or (aday > 31) then
    flag := FALSE;
  if not flag then begin
    Beep;
    FrmDlg.DEditBirthDay.SetFocus;
    Result := FALSE;
  end;
end;

procedure TLoginScene.EdNewIdKeyPress(Sender: TObject; var Key: Char);
//var
  //syear, smon, sday: string;
  //ayear, amon, aday, sex: Integer;
//  flag: Boolean;
begin
  if (Sender = FrmDlg.DEditNewPasswd) or (Sender = FrmDlg.DEditChgNewPw) or
    (Sender = FrmDlg.DEditChgRepeat) then
    if (Key = '~') or (Key = '''') or (Key = ' ') then
      Key := #0;
  if Key = #13 then begin
    Key := #0;
    if Sender = FrmDlg.DEditNewId then begin
      if not NewIdCheckNewId then
        Exit;
    end;
    if Sender = FrmDlg.DEditNewPasswd then begin
      if Length(FrmDlg.DEditNewPasswd.Text) < 4 then begin
        FrmDlg.DMessageDlg('Password must be over 4 characters.', [mbOk]);
        Beep;
        FrmDlg.DEditNewPasswd.SetFocus;
        Exit;
      end;
    end;
    if Sender = FrmDlg.DEditConfirm then begin
      if FrmDlg.DEditNewPasswd.Text <> FrmDlg.DEditConfirm.Text then begin
        FrmDlg.DMessageDlg('New passwords do not match!', [mbOk]);
        Beep;
        FrmDlg.DEditConfirm.SetFocus;
        Exit;
      end;
    end;
    if (Sender = FrmDlg.DEditQuiz1) or (Sender= FrmDlg.DEditAnswer1)
      or
      (Sender = FrmDlg.DEditQuiz2) or (Sender = FrmDlg.DEditAnswer2) or (Sender
      = FrmDlg.DEditPhone) or
      (Sender = FrmDlg.DEditMobPhone) or (Sender = FrmDlg.DEditEMail) then begin
      TDEdit(Sender).Text := Trim(TDEdit(Sender).Text);
      if TDEdit(Sender).Text = '' then begin
        Beep;
        TDEdit(Sender).SetFocus;
        Exit;
      end;
    end;
    if Sender = FrmDlg.DEditBirthDay then begin
      if not NewIdCheckBirthDay then
        Exit;
    end;
    if TDEdit(Sender).Text <> '' then begin
      if Sender = FrmDlg.DEditNewId then
        FrmDlg.DEditNewPasswd.SetFocus;
      if Sender = FrmDlg.DEditNewPasswd then
        FrmDlg.DEditConfirm.SetFocus;
      if Sender = FrmDlg.DEditConfirm then
        FrmDlg.DEditEMail.SetFocus;
      if Sender = FrmDlg.DEditEMail then
        FrmDlg.DEditBirthDay.SetFocus;
      if Sender = FrmDlg.DEditBirthDay then
        FrmDlg.DEditQuiz1.SetFocus;
      if Sender = FrmDlg.DEditQuiz1 then
        FrmDlg.DEditAnswer1.SetFocus;
      if Sender = FrmDlg.DEditAnswer1 then
        FrmDlg.DEditQuiz2.SetFocus;
      if Sender = FrmDlg.DEditQuiz2 then
        FrmDlg.DEditAnswer2.SetFocus;
      if Sender = FrmDlg.DEditAnswer2 then
        //submit the form at this point!
         NewAccountOk();
        //FrmDlg.DEditPhone.SetFocus;
      if Sender = FrmDlg.DEditPhone then
        FrmDlg.DEditYourName.SetFocus;
      if Sender = FrmDlg.DEditYourName then
        FrmDlg.DEditMobPhone.SetFocus;
      if Sender = FrmDlg.DEditMobPhone then
        FrmDlg.DEditRecommendation.SetFocus;
      if Sender = FrmDlg.DEditRecommendation then
        FrmDlg.DEditNewId.SetFocus;

      if Sender = FrmDlg.DEditChgId then
        FrmDlg.DEditChgCurrentpw.SetFocus;
      if Sender = FrmDlg.DEditChgCurrentpw then
        FrmDlg.DEditChgNewPw.SetFocus;
      if Sender = FrmDlg.DEditChgNewPw then
        FrmDlg.DEditChgRepeat.SetFocus;
      if Sender = FrmDlg.DEditChgRepeat then
        FrmDlg.DEditChgId.SetFocus;
    end;
  end;
end;

procedure TLoginScene.EdNewOnEnter(Sender: TObject);
begin
  FrmDlg.NAHelps.Clear;
  if Sender = FrmDlg.DEditNewId then begin
    FrmDlg.NAHelps.Add('[User]Account ID');
    FrmDlg.NAHelps.Add('Can be a combination of characters, and');
    FrmDlg.NAHelps.Add('numbers. Account ID must be at least');
    FrmDlg.NAHelps.Add('four characters in length.');
    FrmDlg.NAHelps.Add('');
  end;
  if Sender = FrmDlg.DEditNewPasswd then begin
    FrmDlg.NAHelps.Add('Your password must be a combination of');
    FrmDlg.NAHelps.Add('characters and numbers.');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('Minimum password length is 4');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('In order to create a secure password');
    FrmDlg.NAHelps.Add('We recommend:');
    FrmDlg.NAHelps.Add('1: Keeping password safe and secure');
    FrmDlg.NAHelps.Add('2: Do not use simple words');
    FrmDlg.NAHelps.Add('3: Create a good combination of letters');
    FrmDlg.NAHelps.Add('    and numbers.');
  end;
  if Sender = FrmDlg.DEditConfirm then begin
    FrmDlg.NAHelps.Add('Confirm the password entered above');
  end;
  if Sender = FrmDlg.DEditYourName then begin
    FrmDlg.NAHelps.Add('Please enter your full name');
    FrmDlg.NAHelps.Add('This can be used to help retrieve lost passwords.');
  end;
  if Sender = FrmDlg.DEditBirthDay then begin
    FrmDlg.NAHelps.Add('Please enter your date of birth.');
    FrmDlg.NAHelps.Add('Year/Month/Day:1977/09/15');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('This can be used to help retrieve');
    FrmDlg.NAHelps.Add('lost passwords.');
  end;
  if (Sender = FrmDlg.DEditQuiz1) then begin
    FrmDlg.NAHelps.Add('Enter your security question number one.');
    FrmDlg.NAHelps.Add('This can be used to help retrieve');
    FrmDlg.NAHelps.Add('lost passwords.');
  end;
  if (Sender = FrmDlg.DEditAnswer1) then begin
    FrmDlg.NAHelps.Add('Please enter your answer to security');
    FrmDlg.NAHelps.Add('question number one.');
  end;
  if (Sender = FrmDlg.DEditQuiz2) then begin
    FrmDlg.NAHelps.Add('Enter your security question number two.');
    FrmDlg.NAHelps.Add('This can be used to help retrieve');
    FrmDlg.NAHelps.Add('lost passwords.');
  end;
  if (Sender = FrmDlg.DEditAnswer2) then begin
    FrmDlg.NAHelps.Add('Please enter your answer to security');
    FrmDlg.NAHelps.Add('question number two.');
  end;


  if (Sender = FrmDlg.DEditYourName) or (Sender = FrmDlg.DEditQuiz1) or (Sender = FrmDlg.DEditQuiz2) or (Sender = FrmDlg.DEditAnswer1) or (Sender = FrmDlg.DEditAnswer2) then begin
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('You must enter the correct information.');
    FrmDlg.NAHelps.Add('');
    FrmDlg.NAHelps.Add('If you use the wrong information, you will');
    FrmDlg.NAHelps.Add('not be able to retrieve your account if ');
    FrmDlg.NAHelps.Add('passwords are lost. Any innacurate');
    FrmDlg.NAHelps.Add('information your account could be');
    FrmDlg.NAHelps.Add('canceled.');
  end;

  if Sender = FrmDlg.DEditPhone then begin
    FrmDlg.NAHelps.Add('Please enter your Phone Number');
    FrmDlg.NAHelps.Add('This can be used to directly get in contact with your if passwords lost.');
    FrmDlg.NAHelps.Add('');
  end;
  if Sender = FrmDlg.DEditMobPhone then begin
    FrmDlg.NAHelps.Add('Please enter your Mobile Number');
    FrmDlg.NAHelps.Add('This can be used to directly get in contact with your if passwords lost.');
    FrmDlg.NAHelps.Add('');
  end;

  if Sender = FrmDlg.DEditEMail then begin
    FrmDlg.NAHelps.Add('Please enter your E-Mail address.');
    FrmDlg.NAHelps.Add('Your email will be used for retrieving');
    FrmDlg.NAHelps.Add('lost passwords.');
  end;
end;

procedure TLoginScene.HideLoginBox;
begin
  //EdId.Visible := FALSE;
  //EdPasswd.Visible := FALSE;
  //FrmDlg.DLogin.Visible := FALSE;
  ChangeLoginState(lsCloseAll);
end;

procedure TLoginScene.OpenLoginDoor;
begin
  DScreen.ChangeScene(stLogin);
  HideLoginBox;
  m_boNowOpening := True;
  m_dwStartTime := FrmMain.m_CurrentTick;
  PlaySound(s_rock_door_open);
  //ClearBGM;
  //PlaySoundEx(bmg_LoginDoor);
end;

procedure TLoginScene.PlayScene(MSurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  e: TDirectDrawSurface;
  px, py: Integer;
begin
  LastForm := lf_Login;
  if m_boOpenFirst then begin
    m_boOpenFirst := FALSE;
    FrmDlg.DEditID.SetFocus;
  end;
  d := g_LoginEffectImages.Images[0];
  if (d <> nil) and (g_boCanDraw) then begin
    MSurface.Draw(0, 0, d.ClientRect, d, FALSE);

    if m_boNowOpening then begin
      if (FrmMain.m_CurrentTick - m_dwStartTime) > 150 then begin
        m_dwStartTime := FrmMain.m_CurrentTick;
        Inc(m_nCurFrame);
        if m_nCurFrame >= 20 - 1 then begin
          m_nCurFrame := m_nMaxFrame - 1;
          DScreen.ChangeScene(stSelectChr);
        end;
      end;

      if not g_boDoFadeOut and not g_boDoFadeIn then begin
        g_boDoFadeOut := True;
        g_boDoFadeIn := True;
        g_nFadeIndex := 29;
      end;

      d := g_LoginEffectImages.Images[540 + m_nCurFrame]; // Door Open Image
      if d <> nil then
        MSurface.Draw(297, 62, d.ClientRect, d, True); //Draw Door Open
      if g_boDoFadeOut then begin
        if g_nFadeIndex <= 1 then begin
          DScreen.ChangeScene(stSelectChr);
        end;
      end;
    end;

    if (FrmMain.m_CurrentTick - m_dwFireEffectTick) > 50 then begin
      m_dwFireEffectTick := FrmMain.m_CurrentTick;
      if m_nFire1CurFrame < m_nFire1MaxFrame - 1 then begin
        Inc(m_nFire1CurFrame, 1);
      end else m_nFire1CurFrame := 0;
      if m_nFire2CurFrame < m_nFire2MaxFrame - 1 then begin
        Inc(m_nFire2CurFrame, 1);
      end else m_nFire2CurFrame := 0;
      if m_nFire3CurFrame < m_nFire3MaxFrame - 1 then begin
        Inc(m_nFire3CurFrame, 1);
      end else m_nFire3CurFrame := 0;
      if m_nFire4CurFrame < m_nFire4MaxFrame - 1 then begin
        Inc(m_nFire4CurFrame, 1);
      end else m_nFire4CurFrame := 0;
    end;

    if (FrmMain.m_CurrentTick - m_dwEffectTick) > 100 then begin
      m_dwEffectTick := FrmMain.m_CurrentTick;
      if m_nLightCurFrame < m_nLightMaxFrame - 1 then begin
        Inc(m_nLightCurFrame, 1);
      end else m_nLightCurFrame := 0;
    end;

    e := g_LoginEffectImages.GetCachedImage(310 + m_nLightCurFrame, px, py); //Light Effect Image
    end else m_nLightCurFrame := 0;
    if e <> nil then begin
      DrawBlend(MSurface,0, 0, e, 1); //Draw Light Effect;
    end;

    e := g_LoginEffectImages.GetCachedImage(210 + m_nFire3CurFrame, px, py); //Fire3 Effect Image
    if e <> nil then begin
      DrawBlend(MSurface,px + 1100,py + 450, e, 1); //Draw Fire3 Effect;
    end;

    e := g_LoginEffectImages.GetCachedImage(260 + m_nFire4CurFrame, px, py); //Fire4 Effect Image
    if e <> nil then begin
      DrawBlend(MSurface,px - 69,py + 445, e, 1); //Draw Fire4 Effect;
    end;

    e := g_LoginEffectImages.GetCachedImage(10 + m_nFire1CurFrame, px, py); //Fire1 Effect Image
    if e <> nil then begin
      DrawBlend(MSurface,- 13,375 + py, e, 1); //Draw Fire1 Effect;
    end;

    e := g_LoginEffectImages.GetCachedImage(60 + m_nFire2CurFrame, px, py); //Fire2 Effect Image
    if e <> nil then begin
    //DrawEffect(0,0,e,e,cerED);
      DrawBlend(MSurface,px + 410,py + 375, e, 1); //Draw Fire2 Effect;
    end;
end;

procedure TLoginScene.CardOK;
var
  No1, No2, No3: Integer;
begin
  No1 := StrToIntDef(FrmDlg2.DCardNo1.Text, -1);
  No2 := StrToIntDef(FrmDlg2.DCardNo2.Text, -1);
  No3 := StrToIntDef(FrmDlg2.DCardNo3.Text, -1);
  if (No1 < 0) then begin
    FrmDlg2.DCardNo1.SetFocus;
    Beep;
    exit;
  end;
  if (No2 < 0) then begin
    FrmDlg2.DCardNo2.SetFocus;
    Beep;
    exit;
  end;
  if (No3 < 0) then begin
    FrmDlg2.DCardNo3.SetFocus;
    Beep;
    exit;
  end;
  FrmDlg.HintBack := stSelServer;
  FrmDlg.sHintStr := 'Vertifying security information...';
  FrmDlg.DBTHintClose.Caption := 'Cancel';
  FrmDlg.boHintFocus := False;
  DScreen.ChangeScene(stHint);
  frmMain.SendCardInfo(No1, No2, No3);
end;

procedure TLoginScene.ChangeLoginState(State: TLoginState);
var
  i, focus: Integer;
  c: TControl;
begin
  focus := -1;
  case State of
    lsLogin: focus := 10;
    lsNewid: focus := 11;
    lsChgpw: focus := 12;
    lsCloseAll: focus := -1;
  end;
  with FrmDlg do begin //login
    for i := 0 to ControlCount - 1 do begin
      c := Controls[i];
      if c is TDEdit then begin
        if c.tag = focus then begin
          TDEdit(c).Text := '';
        end;
      end;
    end;
    case State of
      lsLogin: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := True;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditID.SetFocus;
        end;
      lsNewid: begin
          FrmDlg.DNewAccount.Visible := True;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditBirthDay.Text := '1988/01/01';
          FrmDlg.DEditNewId.SetFocus;
        end;
      lsChgpw: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := True;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditChgId.SetFocus;
        end;
      lsCard: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := True;
          FrmDlg2.DCardNo1.Text := '';
          FrmDlg2.DCardNo2.Text := '';
          FrmDlg2.DCardNo3.Text := '';
          FrmDlg2.DCardNo1.SetFocus;
          m_boOpenFirst := False;
        end;
      lsCloseAll: begin
          FrmDlg.DNewAccount.Visible := FALSE;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
        end;
      lsNewidRetry: begin
          FrmDlg.DNewAccount.Visible := True;
          FrmDlg.DChgPw.Visible := FALSE;
          FrmDlg.DLogin.Visible := FALSE;
          FrmDlg2.DMatrixCardWnd.Visible := False;
          FrmDlg.DEditNewId.SetFocus;
        end;
    end;
  end;
end;

procedure TLoginScene.NewClick;
var
  Msg: TDefaultMessage;
begin
  ChangeLoginState(lsNewid);
end;

procedure TLoginScene.OkClick;
var
  Key: Char;
begin
  Key := #13;
  EdLoginPasswdKeyPress(Self, Key);
end;

procedure TLoginScene.ChgPwClick;
begin
  ChangeLoginState(lsChgpw);
end;

function TLoginScene.CheckUserEntrys: Boolean;
begin
  Result := FALSE;
  FrmDlg.DEditNewId.Text := Trim(FrmDlg.DEditNewId.Text);
  FrmDlg.DEditQuiz1.Text := Trim(FrmDlg.DEditQuiz1.Text);
  //FrmDlg.DEditYourName.Text := Trim(FrmDlg.DEditYourName.Text);
  if not NewIdCheckNewId then
    Exit;
  if Length(FrmDlg.DEditNewPasswd.Text) < 5 then begin
    FrmDlg.DMessageDlg('Password length should not be less than 5.', [mbOk]);
    Beep;
    FrmDlg.DEditNewPasswd.SetFocus;
    Exit;
  end;
  if not NewIdCheckBirthDay then
    Exit;
  if Length(FrmDlg.DEditNewId.Text) < 6 then begin
    FrmDlg.DEditNewId.SetFocus;
    Exit;
  end;

  if FrmDlg.DEditNewPasswd.Text <> FrmDlg.DEditConfirm.Text then begin
    FrmDlg.DEditConfirm.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditQuiz1.Text) < 1 then begin
    FrmDlg.DEditQuiz1.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditAnswer1.Text) < 1 then begin
    FrmDlg.DEditAnswer1.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditQuiz2.Text) < 1 then begin
    FrmDlg.DEditQuiz2.SetFocus;
    Exit;
  end;
  if Length(FrmDlg.DEditAnswer2.Text) < 1 then begin
    FrmDlg.DEditAnswer2.SetFocus;
    Exit;
  end;
//  if Length(FrmDlg.DEditYourName.Text) < 1 then begin
//    FrmDlg.DEditYourName.SetFocus;
//    Exit;
//  end;
  Result := True;
end;

procedure TLoginScene.NewAccountOk;
var
  ue: TUserEntry;
  ua: TUserEntryAdd;
begin
  if CheckUserEntrys then begin
    SafeFillChar(ue, sizeof(TUserEntry), #0);
    SafeFillChar(ua, sizeof(TUserEntryAdd), #0);
    ue.sAccount := LowerCase(FrmDlg.DEditNewId.Text);
    ue.sPassword := FrmDlg.DEditNewPasswd.Text;
    ue.sUserName := FrmDlg.DEditYourName.Text;

    ue.sSSNo := FrmDlg.DEditRecommendation.Text;

    ue.sQuiz := FrmDlg.DEditQuiz1.Text;
    ue.sAnswer := Trim(FrmDlg.DEditAnswer1.Text);
    ue.sPhone := FrmDlg.DEditPhone.Text;
    ue.sEMail := Trim(FrmDlg.DEditEMail.Text);

    ua.sQuiz2 := FrmDlg.DEditQuiz2.Text;
    ua.sAnswer2 := Trim(FrmDlg.DEditAnswer2.Text);
    ua.sBirthDay := FrmDlg.DEditBirthDay.Text;
    ua.sMobilePhone := FrmDlg.DEditMobPhone.Text;

    m_NewIdRetryUE := ue;
    m_NewIdRetryUE.sAccount := '';
    m_NewIdRetryUE.sPassword := '';
    m_NewIdRetryAdd := ua;
    frmMain.SendNewAccount(ue, ua);
    NewAccountClose;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := 'Creating new account...';
    FrmDlg.DBTHintClose.Caption := 'Cancel';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end;
end;

procedure TLoginScene.NewAccountClose;
begin
  ChangeLoginState(lsLogin);
end;

procedure TLoginScene.ChgpwOk;
var
  uid, passwd, newpasswd: string;
begin
  if FrmDlg.DEditChgNewPw.Text = FrmDlg.DEditChgRepeat.Text then begin
    uid := FrmDlg.DEditChgId.Text;
    passwd := FrmDlg.DEditChgCurrentpw.Text;
    newpasswd := FrmDlg.DEditChgNewPw.Text;
    ChgpwCancel;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := 'Vertifying account information...';
    FrmDlg.DBTHintClose.Caption := 'Cancel';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
    frmMain.SendChgPw(uid, passwd, newpasswd);
  end
  else begin
    FrmDlg.DMessageDlg('The new passwords do not match!!', [mbOk]);
    FrmDlg.DEditChgNewPw.SetFocus;
  end;
end;

procedure TLoginScene.ChgpwCancel;
begin
  ChangeLoginState(lsLogin);
end;

{-------------------- TSelectChrScene ------------------------}

constructor TSelectChrScene.Create;
begin
  CreateChrMode := FALSE;
  SafeFillChar(ChrArr, sizeof(TSelChar) * 3, #0);
  NewIndex := 99;

  ChrArr[0].NewCharacter := False;
  ChrArr[1].NewCharacter := False;
  ChrArr[2].NewCharacter := False;
  //ChrArr[3].NewCharacter := False;
  //ChrArr[4].NewCharacter := False;

  SoundTimer := TTimer.Create(frmMain.Owner);
  with SoundTimer do begin
    OnTimer := SoundOnTimer;
    Interval := 1;
    Enabled := FALSE;
  end;

  inherited Create(stSelectChr);
end;

destructor TSelectChrScene.Destroy;
begin
  inherited Destroy;
end;

procedure TSelectChrScene.OpenScene;
begin
  HGE.Gfx_Restore(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT, 16);
  FrmDlg.DSelectChr.Visible := True;
  SoundTimer.Enabled := True;
  SoundTimer.Interval := 100;
  ChangeSelectChrState(scSelectChr);
end;

procedure TSelectChrScene.CloseScene;
begin
  //ClearBGM;
  SilenceSound;
  FrmDlg.DCreateChr.Visible := FALSE;
  FrmDlg.DRenewChr.Visible := FALSE;
  FrmDlg.DSelectChr.Visible := FALSE;
  SoundTimer.Enabled := FALSE;
end;

procedure TSelectChrScene.SoundOnTimer(Sender: TObject);
begin
  SilenceSound;
  PlayBGM(bmg_select);
  SoundTimer.Enabled := FALSE;
  //SoundTimer.Interval := 38 * 1000;
end;

procedure TSelectChrScene.SelChrSelect1Click;
begin
  if (not ChrArr[0].Selected) and (ChrArr[0].Valid) then begin

    ChrArr[0].Selected := True;
    ChrArr[1].Selected := False;
    ChrArr[2].Selected := False;

    ChrArr[0].PerformAction := True;
    ChrArr[0].AniIndex := 0;
    ChrArr[0].GlowIndex := 0;
    ChrArr[0].ActionIndex := 0;
    ChrArr[0].DarkLevel := 0;
    ChrArr[0].EffIndex := 0;
    ChrArr[0].StartTime := 0;
    ChrArr[0].moretime := 0;
    ChrArr[0].startefftime := 0;
  end;
end;

procedure TSelectChrScene.SelChrSelect2Click;
begin
  if (not ChrArr[1].Selected) and (ChrArr[1].Valid) then begin
  
    ChrArr[1].Selected := True;
    ChrArr[0].Selected := False;
    ChrArr[2].Selected := False;

    ChrArr[1].PerformAction := True;
    ChrArr[1].AniIndex := 0;
    ChrArr[1].GlowIndex := 0;
    ChrArr[1].ActionIndex := 0;
    ChrArr[1].DarkLevel := 0;
    ChrArr[1].EffIndex := 0;
    ChrArr[1].StartTime := FrmMain.m_CurrentTick;
    ChrArr[1].moretime := FrmMain.m_CurrentTick;
    ChrArr[1].startefftime := FrmMain.m_CurrentTick;
  end;
end;

procedure TSelectChrScene.SelChrSelect3Click;
begin
  if (not ChrArr[2].Selected) and (ChrArr[2].Valid) then begin

    ChrArr[2].Selected := True;
    ChrArr[0].Selected := False;
    ChrArr[1].Selected := False;

    ChrArr[2].PerformAction := True;
    ChrArr[2].AniIndex := 0;
    ChrArr[2].GlowIndex := 0;
    ChrArr[2].ActionIndex := 0;
    ChrArr[2].DarkLevel := 0;
    ChrArr[2].EffIndex := 0;
    ChrArr[2].StartTime := FrmMain.m_CurrentTick;
    ChrArr[2].moretime := FrmMain.m_CurrentTick;
    ChrArr[2].startefftime := FrmMain.m_CurrentTick;
  end;
end;

procedure TSelectChrScene.SelChrStartClick;
var
  chrname: string;
begin
  chrname := '';

  if ChrArr[0].Valid and ChrArr[0].Selected then begin
    chrname := ChrArr[0].UserChr.name;
  end;
  if ChrArr[1].Valid and ChrArr[1].Selected then begin
    chrname := ChrArr[1].UserChr.name;
  end;
  if ChrArr[2].Valid and ChrArr[2].Selected then begin
    chrname := ChrArr[2].UserChr.name;
  end;

  if chrname <> '' then begin
    frmMain.SendSelChr(chrname);
    LastForm := lf_Play;
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := 'Ready to enter Game Server...';
    FrmDlg.DBTHintClose.Caption := 'Cancel';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end
  else
    FrmDlg.DMessageDlg('No characters found\Click create a character button to make a new character!', [mbOk]);
end;

procedure TSelectChrScene.SelChrNewChrClick;
begin
  if not ChrArr[0].Valid or not ChrArr[1].Valid or not ChrArr[2].Valid { or not ChrArr[3].Valid or not ChrArr[4].Valid} then begin
    if not ChrArr[0].Valid then MakeNewChar(0) else
    if not ChrArr[1].Valid then MakeNewChar(1) else
    if not ChrArr[2].Valid then MakeNewChar(2)
  end else
    FrmDlg.DMessageDlg('You can only have three active Characters at a time.\ Please store a Character first.', [mbOk]);
end;

procedure TSelectChrScene.SelChrEraseChrClick;
var
  n: Integer;
begin
  n := 0;

  if ChrArr[0].Valid and ChrArr[0].Selected then
    n := 0;
  if ChrArr[1].Valid and ChrArr[1].Selected then
    n := 1;
  if ChrArr[2].Valid and ChrArr[2].Selected then
    n := 2;

  if (ChrArr[n].Valid) and (ChrArr[n].Selected) and
    (ChrArr[n].UserChr.name <> '') then begin

    if mrYes = FrmDlg.DMessageDlg('Are you sure you want to store ' + ChrArr[n].UserChr.name + ' ?', [mbYes, mbNo]) then begin
      frmMain.SendDelChr(ChrArr[n].UserChr.Name);
      FrmDlg.HintBack := stSelServer;
      FrmDlg.sHintStr := 'Storing character, please wait...';
      FrmDlg.DBTHintClose.Caption := 'Cancel';
      FrmDlg.boHintFocus := False;
      DScreen.ChangeScene(stHint);
    end;

  end;
end;

procedure TSelectChrScene.SelChrCreditsClick;
begin
  if FrmDlg.DRenewChr.Visible then
    Exit;
  if (not ChrArr[0].Valid) or (not ChrArr[1].Valid) or (not ChrArr[2].Valid) then begin
    FrmMain.SendViewDelHum;
    FrmDlg.HintBack := stSelectChr;
    FrmDlg.sHintStr := 'Retrieving deleted characters, please wait..';
    FrmDlg.DBTHintClose.Caption := 'Cancel';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end
  else
    FrmDlg.DMessageDlg('You already have enough characters...', [mbOk]);
end;

procedure TSelectChrScene.SelChrExitClick;
begin
  //frmMain.Close;
  FrmMain.CSocket.Active := False;
  DScreen.ChangeScene(stSelServer);
end;

procedure TSelectChrScene.ChangeSelectChrState(State: TSelectChrState);
begin
  case State of
    scSelectChr: begin
        CreateChrMode := False;
        FrmDlg.DSelectChr.Visible := True;
        FrmDlg.DCreateChr.Visible := False;
        FrmDlg.DCreateChr2.Visible := False;
        FrmDlg.DRenewChr.Visible := False;
      end;
    scCreateChr: begin
        CreateChrMode := True;
        FrmDlg.DRenewChr.Visible := False;
        FrmDlg.DSelectChr.Visible := False;
        FrmDlg.DCreateChr.Visible := True;
        FrmDlg.DEditChrName.SetFocus;
      end;
    scRenewChr: begin
        CreateChrMode := True;
        FrmDlg.DSelectChr.Visible := False;
        FrmDlg.DRenewChr.Visible := True;
        FrmDlg.DCreateChr.Visible := False;
      end;
  end;
  FrmDlg.DscSelect1.Visible := not CreateChrMode;
  FrmDlg.DscSelect2.Visible := not CreateChrMode;
  FrmDlg.DscSelect3.Visible := not CreateChrMode;
  FrmDlg.DscStart.Visible := not CreateChrMode;
  FrmDlg.DscNewChr.Visible := not CreateChrMode;
  FrmDlg.DscEraseChr.Visible := not CreateChrMode;
  FrmDlg.DscCredits.Visible := not CreateChrMode;
  FrmDlg.DscExit.Visible := not CreateChrMode;
  FrmDlg.DscSelect1.Enabled := not CreateChrMode;
  FrmDlg.DscSelect2.Enabled := not CreateChrMode;
  FrmDlg.DscSelect3.Enabled := not CreateChrMode;
  FrmDlg.DscStart.Enabled := not CreateChrMode;
  FrmDlg.DscNewChr.Enabled := not CreateChrMode;
  FrmDlg.DscEraseChr.Enabled := not CreateChrMode;
  FrmDlg.DscCredits.Enabled := not CreateChrMode;
  FrmDlg.DscExit.Enabled := not CreateChrMode;
end;

procedure TSelectChrScene.ClearChrs;
begin
  SafeFillChar(ChrArr, SizeOf(TSelChar) * 3, #0);
  ChrArr[0].UserChr.Name := '';
  ChrArr[1].UserChr.Name := '';
  ChrArr[2].UserChr.Name := '';
end;

procedure TSelectChrScene.AddChr(uname: string; ID, job, wuxin, Level, sex: Integer; LoginTime: TDateTime);
var
  n: Integer;
begin
  if not ChrArr[0].Valid then
    n := 0
  else if not ChrArr[1].Valid then
    n := 1
  else if not ChrArr[2].Valid then
    n := 2
  else
    Exit;
  ChrArr[n].UserChr.ID := ID;
  ChrArr[n].UserChr.name := uname;
  ChrArr[n].UserChr.job := job;
  ChrArr[n].UserChr.wuxin := wuxin;
  ChrArr[n].UserChr.Level := Level;
  ChrArr[n].UserChr.sex := sex;
  ChrArr[n].UserChr.LoginTime := LoginTime;
  ChrArr[n].Valid := True;
end;

procedure TSelectChrScene.MakeNewChar(Index: Integer);
begin
  ChangeSelectChrState(scCreateChr); //Change scene to Create Character Mode

  NewIndex := Index; //New Character Index. 0..2
  ChrArr[NewIndex].Valid := True; //Turn Character Index Valid
  ChrArr[NewIndex].NewCharacter := True; //Character Index is a New Character, this changes there Image to Big.
  SelectChr(NewIndex); //Adjust Animation settings etc.
  SafeFillChar(ChrArr[Index].UserChr, SizeOf(TUserCharacterInfo), #0); //SafeFill
end;

procedure TLoginScene.EdCardKeyPress(Sender: TObject; var Key: Char);
begin
  {if Sender = FrmDlg2.DCardNo1 then begin
    if (Length(FrmDlg2.DCardNo1.Text) >= 1) then begin
      FrmDlg2.DCardNo2.SetFocus;
      Exit;
    end;
  end;
  if Sender = FrmDlg2.DCardNo2 then begin
    if (Length(FrmDlg2.DCardNo2.Text) >= 1) then begin
      FrmDlg2.DCardNo3.SetFocus;
      Exit;
    end;
  end;     }
  if (Sender = FrmDlg2.DCardNo3) and (Key = #13) then begin
    CardOK;
  end;
end;

procedure TLoginScene.EdChrnameKeyPress(Sender: TObject; var Key: Char);
begin

end;

procedure TSelectChrScene.SelectChr(Index: Integer);
begin
  //Change Animation Settings etc.
  ChrArr[Index].PerformAction := True;
  ChrArr[Index].AniIndex := 0;
  ChrArr[Index].GlowIndex := 0;
  ChrArr[Index].ActionIndex := 0;
  ChrArr[Index].DarkLevel := 0;
  ChrArr[Index].EffIndex := 0;
  ChrArr[Index].StartTime := 0;
  ChrArr[Index].moretime := 0;
  ChrArr[Index].startefftime := 0;

  ChrArr[Index].Selected := True;

  //Deselect other index characters.
  if Index = 0 then begin
    ChrArr[1].Selected := FALSE;
    ChrArr[2].Selected := FALSE;
  end
  else if Index = 1 then begin
    ChrArr[0].Selected := FALSE;
    ChrArr[2].Selected := FALSE;
  end
  else begin
    ChrArr[0].Selected := FALSE;
    ChrArr[1].Selected := FALSE;
  end;

end;

procedure TSelectChrScene.SelRenewChr;
begin
  if (FrmDlg.RenewChrIdx - 1) in [Low(RenewChr)..high(RenewChr)] then begin
    FrmMain.SendRenewHum(RenewChr[FrmDlg.RenewChrIdx - 1].Name);
    FrmDlg.HintBack := stSelServer;
    FrmDlg.sHintStr := 'Recovering character, please wait...';
    FrmDlg.DBTHintClose.Caption := 'Cancel';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end;
end;

procedure TSelectChrScene.SelChrNewClose;
begin
  ChrArr[NewIndex].Valid := False;
  FrmDlg.DCreateChr.Visible := False;
  if ChrArr[0].Valid then begin
    ChrArr[0].Valid := True;
    SelectChr(0);
  end;
  ChangeSelectChrState(scSelectChr);
end;

procedure TSelectChrScene.SelChrNewOk;
var
  chrname, shair, sjob, ssex: string;
begin
  chrname := Trim(FrmDlg.DEditChrName.Text);
  if (chrname <> '') then begin
    if not (Length(chrname) in [3..14]) then begin
      FrmDlg.DMessageDlg('[Failed]: Does not meet required name length.', []);
      exit;
    end;
    if not CheckCorpsChr(chrname) then begin
      FrmDlg.DMessageDlg('[Failed]: Your character name contains special characters!', []);
      exit;
    end;
    ChrArr[NewIndex].Valid := FALSE;
    ChrArr[newindex].PerformAction := False;

   if NewIndex = 1 then begin
      ChrArr[0].Selected := False;
      ChrArr[1].Selected := TRUE;
      ChrArr[2].Selected := False;
   end;
   if NewIndex = 2 then begin
      ChrArr[0].Selected := False;
      ChrArr[1].Selected := False;
      ChrArr[2].Selected := TRUE;
   end;
    shair := IntToStr(FrmDlg.btWuXin + 1);
    sjob := IntToStr(FrmDlg.btjob);
    ssex := IntToStr(FrmDlg.btsex);
    frmMain.SendNewChr(frmMain.LoginID, chrname, shair, sjob, ssex);
    frmMain.CreateChrName := chrname;
    FrmDlg.HintBack := stSelectChr;
    FrmDlg.sHintStr := 'Creating characters, please wait...';
    FrmDlg.DBTHintClose.Caption := 'Cancel';
    FrmDlg.boHintFocus := False;
    DScreen.ChangeScene(stHint);
  end;
end;

procedure TSelectChrScene.SelChrNewJob(job: Integer);
begin
  if (job in [0..4]) and (ChrArr[NewIndex].UserChr.job <> job) then begin
    ChrArr[NewIndex].UserChr.job := job;
    SelectChr(NewIndex);
  end;
end;

procedure TSelectChrScene.SelChrNewm_btSex(sex: Integer);
begin
  if sex <> ChrArr[NewIndex].UserChr.sex then begin
    ChrArr[NewIndex].UserChr.sex := sex;
    SelectChr(NewIndex);
  end;
end;

procedure TSelectChrScene.SelChrNewPrevHair;
begin
end;

procedure TSelectChrScene.SelChrNewNextHair;
begin
end;

procedure TSelectChrScene.PlayScene(MSurface: TDirectDrawSurface);
var
  I, n, img, imgsh, imggl, imgeff: Integer;
  sx, sy : Integer; //Image Positions
  px, py : Integer; //Character Placements
  pxsh, pysh : Integer; //Shadow Placements
  pxgl, pygl : Integer; //Glow Placements
  dx, dy: Integer; //Login Effects Placements
  pxEff, pyEff : Integer; //Effect Placements
  bx, by: Integer;
  PerformFrame : Integer; //Perform Action Frame Count
  SelectedFrame: Integer; //Character Frame Amount
  d: TDirectDrawSurface; //Textures
begin
  LastForm := lf_SelectChr;
  d := g_LoginEffectImages.Images[3]; //Background Image
  if d <> nil then begin
    MSurface.Draw((DEFMAXSCREENWIDTH - d.Width) div 2, (DEFMAXSCREENHEIGHT - d.Height) div 2, d.ClientRect, d, False); //Draw Background
  end;

  d := g_LoginEffectImages.GetCachedImage(440  + m_nEffectLoginWater1Frame, dx, dy); //Water 1 Image
  if d <> nil then
    DrawBlend(MSurface,dx + 508,dy + 380,d, 1); //Draw Water 1 Images
  if FrmMain.m_CurrentTick - m_nEffectLoginWater1Tick > 100 then begin //Get Water 1 Frame Speed
    m_nEffectLoginWater1Tick := FrmMain.m_CurrentTick;
    inc(m_nEffectLoginWater1Frame, 1);
    if m_nEffectLoginWater1Frame >= 39 then m_nEffectLoginWater1Frame := 0;
  end;

  d := g_LoginEffectImages.GetCachedImage(490  + m_nEffectLoginWater2Frame, dx, dy); //Water 2 Images
  if d <> nil then
  DrawBlend(MSurface,dx + 508,dy + 380, d, 1); //Draw Water 2 Images
  if FrmMain.m_CurrentTick - m_nEffectLoginWater2Tick > 100 then begin  //Get Water 2 Frame Speed
    m_nEffectLoginWater2Tick := FrmMain.m_CurrentTick;
    inc(m_nEffectLoginWater2Frame, 1);
    if m_nEffectLoginWater2Frame >= 37 then m_nEffectLoginWater2Frame := 0;
  end;

  d := g_LoginEffectImages.GetCachedImage(340  + m_nEffectLoginFire5Frame, dx, dy); //Fire 5 Images
  if d <> nil then
  DrawBlend(MSurface,dx + 500,dy + 290,d, 1); //Draw Fire5 Images
  if FrmMain.m_CurrentTick - m_nEffectLoginFire5Tick > 75 then begin  //Get Fire 5 Frame Speed
    m_nEffectLoginFire5Tick := FrmMain.m_CurrentTick;
    inc(m_nEffectLoginFire5Frame, 1);
    if m_nEffectLoginFire5Frame >= 40 then m_nEffectLoginFire5Frame := 0;
  end;

  d := g_LoginEffectImages.GetCachedImage(390  + m_nEffectLoginFire6Frame, dx, dy); //Fire 6 Images
  if d <> nil then
  DrawBlend(MSurface,dx + 555,dy + 290,d, 1); //Draw Fire6 Images
  if FrmMain.m_CurrentTick - m_nEffectLoginFire6Tick > 75 then begin  //Get Fire 6 Frame Speed
    m_nEffectLoginFire6Tick := FrmMain.m_CurrentTick;
    inc(m_nEffectLoginFire6Frame, 1);
    if m_nEffectLoginFire6Frame >= 40 then m_nEffectLoginFire6Frame := 0;
  end;

  d := g_LoginEffectImages.GetCachedImage(210  + m_nEffectLoginFire7Frame, dx, dy); //Fire 7 Images
  if d <> nil then
  DrawBlend(MSurface,dx + 680,dy + 320,d, 1); //Draw Fire7 Images
  if FrmMain.m_CurrentTick - m_nEffectLoginFire7Tick > 75 then begin  //Get Fire 7 Frame Speed
    m_nEffectLoginFire7Tick := FrmMain.m_CurrentTick;
    inc(m_nEffectLoginFire7Frame, 1);
    if m_nEffectLoginFire7Frame >= 40 then m_nEffectLoginFire7Frame := 0;
  end;

  d := g_LoginEffectImages.GetCachedImage(260  + m_nEffectLoginFire8Frame, dx, dy); //Fire 8 Images
  if d <> nil then
  DrawBlend(MSurface,dx + 340,dy + 320,d, 1); //Draw Fire8 Images
  if FrmMain.m_CurrentTick - m_nEffectLoginFire8Tick > 75 then begin  //Get Fire 8 Frame Speed
    m_nEffectLoginFire8Tick := FrmMain.m_CurrentTick;
    inc(m_nEffectLoginFire8Frame, 1);
    if m_nEffectLoginFire8Frame >= 40 then m_nEffectLoginFire8Frame := 0;
  end;

  d := g_wUI3Images.Images[2806]; //Bottom Button Bar Image
  if (d <> nil) and not ( (CreateChrMode) or (FrmDlg.DRenewChr.Visible) ) then begin
    msurface.Draw(0, DEFMAXScreenHeight - 74, d.ClientRect, d, True); //Draw Bottom button Bar image
  end;

  for n := 0 to 2 do begin

    if ChrArr[n].Valid then begin
      if ChrArr[n].NewCharacter then begin //Big Images

        //If new character, make sure we have the selected Job/Sex what was decided before.
        ChrArr[n].UserChr.Job := FrmDlg.btJob;
        ChrArr[n].UserChr.Sex := FrmDlg.btSex;

        if ChrArr[n].PerformAction then begin
          img := 20 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Character Images
          imgsh := 1820 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Shadow Images
          imgeff := 1200 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Effect Images
        end
        else begin //if not ChrArr[n].PerformAction
          img := 0 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Character Images
          imgsh := 1800 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Shadow Images
          imggl := 0; //GlowImages
        end;
      end
      else begin //if not ChrArr[n].NewCharacter
        if ChrArr[n].PerformAction then begin
          img := 620 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Character Images
          imgsh := 2420 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Shadow Images
          imgeff := 1230 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Shadow Images
          imggl := 3000 + ChrArr[n].GlowIndex; //GlowImages
        end
        else begin //If not ChrArr[n].PerformAction
          img := 600 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Character Images
          imgsh := 2400 + ChrArr[n].UserChr.job * 120 + ChrArr[n].AniIndex + ChrArr[n].UserChr.sex * 60; //Shadow Images
          imggl := 3000 + ChrArr[n].GlowIndex; //GlowImages
        end;
      end;

      if ChrArr[n].NewCharacter then begin //If New Character, shift shadow position
        sx := 515;
        sy := 400;
      end
      else begin //if not ChrArr[n].NewCharacter
        Case n of
          0: begin
            sx := 515;
            sy := 300;
          end;
          1: begin
            sx := 520 - 175;
            sy := 300 + 100;
          end;
          2: begin
            sx := 520 + 170;
            sy := 300 + 100;
          end;
          3: begin
            sx := 520 - 175 - 175;
            sy := 300 + 100 + 100;
          end;
          4: begin
            sx := 520 + 175 + 175;
            sy := 300 + 100 + 100;
          end;
        end;
      end;
    end;

  //g_DXCanvas.TextOut(20, 20, 'NewIndex: ' + IntToStr(NewIndex), GetRGB(255));

    if CreateChrMode then begin
      if ChrArr[n].NewCharacter then begin
        d := g_ChrSel2Images.GetCachedImage(imgsh, pxsh, pysh); //Shadow Images
        if d <> nil then //if shadow is valid
          MSurface.Draw(pxsh + sx,pysh + sy, d.ClientRect, d, True); //Draw Shadows
        d := g_ChrSel2Images.GetCachedImage(img, px, py); //Character Image
        if d <> nil then //If character image is valid
          MSurface.Draw(px + sx,py + sy, d.ClientRect, d, True); //Draw Characters
      end;
    end
    else begin  //if not CreateChrMode
      d := g_ChrSel2Images.GetCachedImage(imgsh, pxsh, pysh); //Shadow Images
      if d <> nil then
        MSurface.Draw(pxsh + sx,pysh + sy, d.ClientRect, d, True); //Draw Shadows
      d := g_ChrSel2Images.GetCachedImage(img, px, py); //Character Image
      if d <> nil then begin
        MSurface.Draw(px + sx,py + sy, d.ClientRect, d, True); //Draw Characters
      end;

      if ChrArr[n].Selected then begin
        d := g_ChrSel2Images.GetCachedImage(imggl, pxgl, pygl);  //Glow Images
        if d <> nil then
          DrawBlend(MSurface, pxgl + sx,pygl + sy, d, 1); //Draw Glow
      end;
    end;

    if ChrArr[n].PerformAction and ChrArr[n].Selected then begin
      d := g_ChrSel2Images.GetCachedImage(imgeff, pxeff, pyeff); //Effect images
      if d <> nil then
        DrawBlend(MSurface, pxeff + sx,pyeff + sy, d, 1); //Draw Effect
    end;

    Case ChrArr[n].UserChr.job of //Character Frame Counts
      0: Begin
        if ChrArr[n].UserChr.sex = 0 then begin
          PerformFrame := 21;
          SelectedFrame := 13;
        end
        else begin
          PerformFrame := 22;
          SelectedFrame := 13;
        end;
      end;
      1: Begin
        if ChrArr[n].UserChr.sex = 0 then begin
          PerformFrame := 24;
          SelectedFrame := 14;
        end
        else begin
          PerformFrame := 25;
          SelectedFrame := 15;
        end;
      end;
      2: Begin
        if ChrArr[n].UserChr.sex = 0 then begin
          PerformFrame := 25;
          SelectedFrame := 15;
        end
        else begin
          PerformFrame := 25;
          SelectedFrame := 15;
        end;
      end;
      3: Begin
        if ChrArr[n].UserChr.sex = 0 then begin
          PerformFrame := 25;
          SelectedFrame := 15;
        end
        else begin
          PerformFrame := 25;
          SelectedFrame := 15;
        end;
      end;
      4: Begin
        if ChrArr[n].UserChr.sex = 0 then begin
          PerformFrame := 25;
          SelectedFrame := 15;
        end
        else begin
         PerformFrame := 25;
         SelectedFrame := 15;
        end;
      end; 
    end;

    if ChrArr[n].PerformAction and (not ChrArr[n].Selected) then begin
      ChrArr[n].AniIndex:=0;
      ChrArr[n].PerformAction:= False;
    end;

    if FrmMain.m_CurrentTick - ChrArr[n].StartTime > 100 then begin // Delay Character Select
      ChrArr[n].StartTime := FrmMain.m_CurrentTick;
      ChrArr[n].AniIndex := ChrArr[n].AniIndex + 1;
      if ChrArr[n].PerformAction and ChrArr[n].Selected then begin
        if ChrArr[n].AniIndex > PERFORMFRAME - 1 then begin
          ChrArr[n].PerformAction := False;
          ChrArr[n].AniIndex := 0;
        end;
      end
      else begin
        if ChrArr[n].AniIndex > SELECTEDFRAME - 1 then
          ChrArr[n].AniIndex := 0;
      end;

      ChrArr[n].GlowIndex := ChrArr[n].GlowIndex + 1;
      if ChrArr[n].GlowIndex > GLOWFRAME - 1 then
        ChrArr[n].GlowIndex := 0;
    end;

    if not CreateChrMode then begin
      with g_DXCanvas do begin
        If ChrArr[n].Valid and (not ChrArr[n].PerformAction) and (n = 0) then begin
          d := G_WUI3Images.Images[2811];
          if d <> nil then begin
            Draw(450, 150, d.ClientRect, d, True);
            TextOut(450 + 5, 150 +  10,  'Name: '  + ChrArr[0].UserChr.Name, GetRGB(95));
            TextOut(450 + 5, 150 +  35, 'Level: ' + IntToStr(ChrArr[0].UserChr.Level), GetRGB(95));
            TextOut(450 + 5, 150 +  50, 'Class: ' + GetJobName(ChrArr[0].UserChr.job), GetRGB(95));
          end;
        end;

        If ChrArr[n].Valid and (not ChrArr[n].PerformAction) and (n = 1) then begin
          d := G_WUI3Images.Images[2811];
          if d <> nil then begin
            Draw(290, 250, d.ClientRect, d, True);
            TextOut(290 + 5, 250 +  10,  'Name: '  + ChrArr[1].UserChr.Name, GetRGB(95));
            TextOut(290 + 5, 250 +  35, 'Level: ' + IntToStr(ChrArr[1].UserChr.Level), GetRGB(95));
            TextOut(290 + 5, 250 +  50, 'Class: ' + GetJobName(ChrArr[1].UserChr.job), GetRGB(95));
          end;
        end;

        If ChrArr[n].Valid and (not ChrArr[n].PerformAction) and (n = 2) then begin
          d := G_WUI3Images.Images[2811];
          if d <> nil then begin
            Draw(615, 250, d.ClientRect, d, True);
            TextOut(615 + 5, 250 +  10,  'Name: '  + ChrArr[2].UserChr.Name, GetRGB(95));
            TextOut(615 + 5, 250 +  35, 'Level: ' + IntToStr(ChrArr[2].UserChr.Level), GetRGB(95));
            TextOut(615 + 5, 250 +  50, 'Class: ' + GetJobName(ChrArr[2].UserChr.job), GetRGB(95));
          end;
        end;

        {If ChrArr[3].Valid and (not ChrArr[3].PerformAction) and (n = 3) then begin
          d := G_WUI3Images.Images[2811];
          d.TextOutEx(5, 10, ChrArr[3].UserChr.Name, GetRGB(95));
          d.TextOutEx(5, 35, 'Level: ' + IntToStr(ChrArr[3].UserChr.Level), GetRGB(95));
          d.TextOutEx(5, 50, 'Class: ' + GetJobName(ChrArr[3].UserChr.job), GetRGB(95));
          if d <> nil then
          DrawAlpha(Bounds(120, 350,118,76),d.ClientRect,d,True,200);
          //g_UI3Images.ClearCache;
        end;
<<<<<<< .mine

        If ChrArr[4].Valid and (not ChrArr[4].PerformAction) and (n = 4) then begin
          d := G_WUI3Images.Images[2811];
          d.TextOutEx(5, 10, ChrArr[4].UserChr.Name, GetRGB(95));
          d.TextOutEx(5, 35, 'Level: ' + IntToStr(ChrArr[4].UserChr.Level), GetRGB(95));
          d.TextOutEx(5, 50, 'Class: ' + GetJobName(ChrArr[4].UserChr.job), GetRGB(95));
          if d <> nil then
          DrawAlpha(Bounds(800, 350,118,76),d.ClientRect,d,True,200);
          //g_WUI3Images.ClearCache;
        end;         }
      end;
    end;
  end;
end;

{ TSelServer }

procedure TSelServer.CloseScene;
begin
  //inherited;
  FrmDlg.DWinSelServer.Visible := False;
end;

constructor TSelServer.Create;
begin
  inherited Create(stSelServer);
  LoginScene.m_nLightCurFrame := 0;
  LoginScene.m_nLightMaxFrame := 20;
  LoginScene.m_nFire1CurFrame := 0;
  LoginScene.m_nFire1MaxFrame := 40;
  LoginScene.m_nFire2CurFrame := 0;
  LoginScene.m_nFire2MaxFrame := 40;
  LoginScene.m_nFire3CurFrame := 0;
  LoginScene.m_nFire3MaxFrame := 40;
  LoginScene.m_nFire4CurFrame := 0;
  LoginScene.m_nFire4MaxFrame := 40;
  LoginScene.m_dwEffectTick:=FrmMain.m_CurrentTick;
  LoginScene.m_dwFireEffectTick:=FrmMain.m_CurrentTick;
end;

destructor TSelServer.Destroy;
begin
  inherited Destroy;
end;

procedure TSelServer.OpenScene;
begin
  //inherited OpenScene;
  FrmDlg.DWinSelServer.Visible := True;
  HGE.Gfx_Restore(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT, 16);
  PlayBGM(bmg_intro);
end;

procedure TSelServer.PlayScene(MSurface: TDirectDrawSurface);
begin
  LastForm := lf_Login;
  LoginScene.PlayScene(MSurface);
  {
  if (g_boCanDraw) then begin
    //MSurface.Draw(0, 0, d.ClientRect, d, FALSE);
    with g_DXCanvas do begin
      TextOut(DEFSCREENWIDTH - TextWidth(CLIENTUPDATETIME) - 1, DEFSCREENHEIGHT - TextHeight(CLIENTUPDATETIME) - 1, clYellow, CLIENTUPDATETIME);
    end;
  end;
  }
end;

{ THintScene }

procedure THintScene.CloseScene;
begin
  FrmDlg.DWndHint.Visible := False;
end;

constructor THintScene.Create;
begin
  inherited Create(stHint);
end;

destructor THintScene.Destroy;
begin
  inherited;
end;

procedure THintScene.OpenScene;
begin
  FrmDlg.DWndHint.Visible := True;
  FrmDlg.DBTHintClose.Visible := True;
  HGE.Gfx_Restore(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT, 16);
end;

procedure THintScene.PlayScene(MSurface: TDirectDrawSurface);
var
  d, e: TDirectDrawSurface;
  px,py :integer;
begin
    if LastForm = lf_Login then begin
      LoginScene.PlayScene(MSurface);
  end else
    if LastForm = lf_SelectChr then begin
      SelectChrScene.PlayScene(MSurface);
    end;
end;


end.

