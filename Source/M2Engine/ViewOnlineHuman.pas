unit ViewOnlineHuman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Spin, ObjPlay;

type
  TfrmViewOnlineHuman = class(TForm)
    PanelStatus: TPanel;
    GridHuman: TStringGrid;
    Timer: TTimer;
    Panel1: TPanel;
    ButtonRefGrid: TButton;
    Label1: TLabel;
    ComboBoxSort: TComboBox;
    EditSearchName: TEdit;
    ButtonSearch: TButton;
    ButtonView: TButton;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxSortClick(Sender: TObject);
    procedure GridHumanDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure ButtonViewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonRefGridClick(Sender: TObject);
  private
    ViewList: TStringList;
    dwTimeOutTick: LongWord;
    procedure RefGridSession();
    procedure GetOnlineList();
    procedure SortOnlineList(nSort: Integer);
    procedure ShowHumanInfo();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewOnlineHuman: TfrmViewOnlineHuman;

implementation

uses UsrEngn, M2Share, ObjBase, HUtil32, HumanInfo, Grobal2;

{$R *.dfm}

{ TfrmViewOnlineHuman }

procedure TfrmViewOnlineHuman.Open;
begin
  frmHumanInfo := TfrmHumanInfo.Create(Owner);
  dwTimeOutTick := GetTickCount();
  GetOnlineList();
  RefGridSession();
  Timer.Enabled := True;
  ComboBoxSort.Items.Add(sSTRING_GOLDNAME);
  ComboBoxSort.Items.Add(sSTRING_GAMEPOINT);
  ComboBoxSort.Items.Add(sSTRING_GAMEDIAMOND);
  ShowModal;
  Timer.Enabled := False;
  frmHumanInfo.Free;
end;

procedure TfrmViewOnlineHuman.GetOnlineList;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  ViewList.Clear;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    if UserEngine <> nil then begin
      for i := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
        if (PlayObject <> nil) and (CheckBox1.Checked or not PlayObject.m_boSafeOffLine) then
          ViewList.AddObject(UserEngine.m_PlayObjectList.Strings[i], UserEngine.m_PlayObjectList.Objects[i]);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  dwTimeOutTick := GetTickCount;
end;

procedure TfrmViewOnlineHuman.RefGridSession;
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  PanelStatus.Caption := 'Refreshing Grid...';
  GridHuman.Visible := False;
  GridHuman.Cells[0, 1] := '';
  GridHuman.Cells[1, 1] := '';
  GridHuman.Cells[2, 1] := '';
  GridHuman.Cells[3, 1] := '';
  GridHuman.Cells[4, 1] := '';
  GridHuman.Cells[5, 1] := '';
  GridHuman.Cells[6, 1] := '';
  GridHuman.Cells[7, 1] := '';
  GridHuman.Cells[8, 1] := '';
  GridHuman.Cells[9, 1] := '';
  GridHuman.Cells[10, 1] := '';
  GridHuman.Cells[11, 1] := '';
  GridHuman.Cells[12, 1] := '';
  GridHuman.Cells[13, 1] := '';
  GridHuman.Cells[14, 1] := '';
  GridHuman.Cells[15, 1] := '';
  if ViewList.Count <= 0 then begin
    GridHuman.RowCount := 2;
    GridHuman.FixedRows := 1;
  end
  else begin
    GridHuman.RowCount := ViewList.Count + 1;
  end;
  for i := 0 to ViewList.Count - 1 do begin
    PlayObject := TPlayObject(ViewList.Objects[i]);
    if (PlayObject <> nil) then begin
      GridHuman.Cells[0, i + 1] := IntToStr(i);
      GridHuman.Cells[1, i + 1] := PlayObject.m_sCharName;
      GridHuman.Cells[2, i + 1] := IntToSex(PlayObject.m_btGender);
      GridHuman.Cells[3, i + 1] := IntToJob(PlayObject.m_btJob);
      GridHuman.Cells[4, i + 1] := IntToStr(PlayObject.m_Abil.Level);
      GridHuman.Cells[5, i + 1] := PlayObject.m_sMapName;
      GridHuman.Cells[6, i + 1] := IntToStr(PlayObject.m_nCurrX) + ':' + IntToStr(PlayObject.m_nCurrY);
      GridHuman.Cells[7, i + 1] := PlayObject.m_sUserID;
      GridHuman.Cells[8, i + 1] := PlayObject.m_sIPaddr;
      GridHuman.Cells[9, i + 1] := IntToStr(PlayObject.m_btPermission);
      GridHuman.Cells[10, i + 1] := PlayObject.m_sIPLocal;
        // GetIPLocal(PlayObject.m_sIPaddr);
      GridHuman.Cells[11, i + 1] := IntToStr(PlayObject.m_nGameGold);
      GridHuman.Cells[12, i + 1] := IntToStr(PlayObject.m_nGamePoint);
      GridHuman.Cells[13, i + 1] := IntToStr(PlayObject.m_nGameDiamond);
      GridHuman.Cells[14, i + 1] := BooleanToStr(False);
      GridHuman.Cells[15, i + 1] := '';
    end;
  end;
  GridHuman.Visible := True;
end;

procedure TfrmViewOnlineHuman.FormCreate(Sender: TObject);
begin
  ViewList := TStringList.Create;
  GridHuman.Cells[0, 0] := 'Idx';
  GridHuman.Cells[1, 0] := 'CharName';
  GridHuman.Cells[2, 0] := 'Sex';
  GridHuman.Cells[3, 0] := 'Class';
  GridHuman.Cells[4, 0] := 'Level';
  GridHuman.Cells[5, 0] := 'Map';
  GridHuman.Cells[6, 0] := 'Co-Ord';
  GridHuman.Cells[7, 0] := 'Account';
  GridHuman.Cells[8, 0] := 'AccountIP';
  GridHuman.Cells[9, 0] := 'Perm';
  GridHuman.Cells[10, 0] := 'Country';
  GridHuman.Cells[11, 0] := sSTRING_GAMEGOLD;
  GridHuman.Cells[12, 0] := sSTRING_GAMEPOINT;
  GridHuman.Cells[13, 0] := sSTRING_GAMEDIAMOND;
  //GridHuman.Cells[14, 0] := '离线挂机';
  //GridHuman.Cells[15, 0] := '自动回复';
  if UserEngine <> nil then begin
    Caption := Format(' [Online：%d]', [UserEngine.PlayObjectCount]);
  end;
end;

procedure TfrmViewOnlineHuman.FormDestroy(Sender: TObject);
begin
  ViewList.Free;
end;

procedure TfrmViewOnlineHuman.ComboBoxSortClick(Sender: TObject);
begin
  if ComboBoxSort.ItemIndex < 0 then  exit;
  GetOnlineList();
  SortOnlineList(ComboBoxSort.ItemIndex);
  RefGridSession();
end;

procedure TfrmViewOnlineHuman.SortOnlineList(nSort: Integer);
var
  i: Integer;
  SortList: TStringList;
begin
  SortList := TStringList.Create;
  case nSort of
    0: begin
        ViewList.Sort;
        exit;
      end;
    1: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_btGender), ViewList.Objects[i]);
        end;
      end;
    2: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_btJob), ViewList.Objects[i]);
        end;
      end;
    3: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_Abil.Level), ViewList.Objects[i]);
        end;
      end;
    4: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(TPlayObject(ViewList.Objects[i]).m_sMapName, ViewList.Objects[i]);
        end;
      end;
    5: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(TPlayObject(ViewList.Objects[i]).m_sIPaddr, ViewList.Objects[i]);
        end;
      end;
    6: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_btPermission), ViewList.Objects[i]);
        end;
      end;
    7: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(TPlayObject(ViewList.Objects[i]).m_sIPLocal,  ViewList.Objects[i]);
        end;
      end;
    8: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_nGameGold),  ViewList.Objects[i]);
        end;
    end;
    9: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_nGamePoint),  ViewList.Objects[i]);
        end;
    end;
    10: begin
        for i := 0 to ViewList.Count - 1 do begin
          SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[i]).m_nGameDiamond),  ViewList.Objects[i]);
        end;
    end;
  end;
  ViewList.Free;
  ViewList := SortList;
  ViewList.Sort;
end;

procedure TfrmViewOnlineHuman.GridHumanDblClick(Sender: TObject);
begin
  ShowHumanInfo();
end;

procedure TfrmViewOnlineHuman.TimerTimer(Sender: TObject);
begin
  if (GetTickCount - dwTimeOutTick > 3 * 60 * 1000) and (ViewList.Count > 0) then begin
    ViewList.Clear;
    RefGridSession();
  end;
end;

procedure TfrmViewOnlineHuman.ButtonRefGridClick(Sender: TObject);
begin
  GetOnlineList();
  RefGridSession();
end;

procedure TfrmViewOnlineHuman.ButtonSearchClick(Sender: TObject);
var
  i: Integer;
  sHumanName: string;
  PlayObject: TPlayObject;
begin
  sHumanName := Trim(EditSearchName.Text);
  if sHumanName = '' then begin
    Application.MessageBox('Please enter the character name.', 'Message', MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;
  for i := 0 to ViewList.Count - 1 do begin
    PlayObject := TPlayObject(ViewList.Objects[i]);
    if CompareText(PlayObject.m_sCharName, sHumanName) = 0 then begin
      GridHuman.Row := i + 1;
      exit;
    end;
  end;
  Application.MessageBox('Character is not online.', 'Message', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TfrmViewOnlineHuman.ButtonViewClick(Sender: TObject);
begin
  ShowHumanInfo();
end;

procedure TfrmViewOnlineHuman.ShowHumanInfo;
var
  nSelIndex: Integer;
  sPlayObjectName: string;
  PlayObject: TPlayObject;
begin
  nSelIndex := GridHuman.Row;
  Dec(nSelIndex);
  if (nSelIndex < 0) or (ViewList.Count <= nSelIndex) then begin
    Application.MessageBox('Please select a character to view!!!', 'Message', MB_OK +
      MB_ICONINFORMATION);
    exit;
  end;
  sPlayObjectName := GridHuman.Cells[1, nSelIndex + 1];
  PlayObject := UserEngine.GetPlayObject(sPlayObjectName);
  if PlayObject = nil then begin
    Application.MessageBox('This character is no longer online!!!', 'Message', MB_OK +
      MB_ICONINFORMATION);
    exit;
  end;

  frmHumanInfo.PlayObject := TPlayObject(ViewList.Objects[nSelIndex]);
  frmHumanInfo.Top := Self.Top + 20;
  frmHumanInfo.Left := Self.Left;
  frmHumanInfo.Open();
end;

procedure TfrmViewOnlineHuman.Button1Click(Sender: TObject);
var
  i: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    if UserEngine <> nil then begin
      for i := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
        if (PlayObject <> nil) and (PlayObject.m_boSafeOffLine) then begin
          PlayObject.m_boEmergencyClose := True;
          PlayObject.m_boPlayOffLine := False;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

end.
