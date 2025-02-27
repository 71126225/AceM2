unit DBTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmDBTool = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GridMirDBInfo: TStringGrid;
    GroupBox2: TGroupBox;
    GridHumDBInfo: TStringGrid;
    TimerShowInfo: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartRebuildClick(Sender: TObject);
    procedure TimerShowInfoTimer(Sender: TObject);
    procedure CheckBoxDelDenyChrClick(Sender: TObject);
    procedure CheckBoxDelLevelClick(Sender: TObject);
    procedure CheckBoxDelAllItemClick(Sender: TObject);
    procedure CheckBoxDelAllSkillClick(Sender: TObject);
    procedure CheckBoxDelBonusAbilClick(Sender: TObject);
  private
    procedure RefDBInfo();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

  TBuildDB = class(TThread)
  private
    //procedure UpdateProcess();
    { Private declarations }
  protected
    procedure Execute; override;
  end;
var
  frmDBTool: TfrmDBTool;

implementation

uses HumDB, DBShare, Grobal2, Hutil32;
var
  boRebuilding: Boolean = False;
//  BuildDB: TBuildDB;
  nProcID: Integer;
  nProcMax: Integer;
  //  UpdateProcessTick: LongWord;
  boDelDenyChr: Boolean = False;
  boDelAllItem: Boolean = False;
  boDelAllSkill: Boolean = False;
  boDelBonusAbil: Boolean = False;
  boDelLevel: Boolean = False;

{$R *.dfm}

  { TfrmDBTool }

procedure TfrmDBTool.Open;
begin
  RefDBInfo();
  ShowModal;
end;

procedure TfrmDBTool.RefDBInfo;
begin
  try
    //if HumDataDB.OpenEx then begin
      GridMirDBInfo.Cells[1, 1] := HumDataDB.m_sDBFileName;
      GridMirDBInfo.Cells[1, 2] := HumDataDB.m_Header.sDesc;
      GridMirDBInfo.Cells[1, 3] := IntToStr(HumDataDB.m_Header.nHumCount);
      GridMirDBInfo.Cells[1, 4] := IntToStr(HumDataDB.m_QuickList.Count);
      GridMirDBInfo.Cells[1, 5] := IntToStr(HumDataDB.m_DeletedList.Count);
      GridMirDBInfo.Cells[1, 6] :=
        DateTimeToStr(HumDataDB.m_Header.dUpdateDate);
    //end;
  finally
    //HumDataDB.Close();
  end;
  try
      GridHumDBInfo.Cells[1, 1] := 'Speak to sam about fixing tools';
      GridHumDBInfo.Cells[1, 2] := HumChrDB.m_Header.sDesc;
      GridHumDBInfo.Cells[1, 3] := IntToStr(HumChrDB.m_Header.nHumCount);
      GridHumDBInfo.Cells[1, 4] := IntToStr(HumChrDB.m_QuickList.Count);
      GridHumDBInfo.Cells[1, 5] := IntToStr(HumChrDB.m_DeletedList.Count);
      GridHumDBInfo.Cells[1, 6] := DateTimeToStr(HumChrDB.m_Header.dUpdateDate);
  finally
  end;
end;

procedure TfrmDBTool.FormCreate(Sender: TObject);
begin
  GridMirDBInfo.Cells[0, 0] := 'parameter';
  GridMirDBInfo.Cells[1, 0] := 'content';
  GridMirDBInfo.Cells[0, 1] := 'File Location';
  GridMirDBInfo.Cells[0, 2] := 'File Identification';
  GridMirDBInfo.Cells[0, 3] := 'Total number of records';
  GridMirDBInfo.Cells[0, 4] := 'Effective quantity';
  GridMirDBInfo.Cells[0, 5] := 'Delete quantity';
  GridMirDBInfo.Cells[0, 6] := 'Updated';

  GridHumDBInfo.Cells[0, 0] := 'parameter';
  GridHumDBInfo.Cells[1, 0] := 'content';
  GridHumDBInfo.Cells[0, 1] := 'File Location';
  GridHumDBInfo.Cells[0, 2] := 'File Identification';
  GridHumDBInfo.Cells[0, 3] := 'Total number of records';
  GridHumDBInfo.Cells[0, 4] := 'Effective quantity';
  GridHumDBInfo.Cells[0, 5] := 'Delete quantity';
  GridHumDBInfo.Cells[0, 6] := 'Updated';
end;

procedure TfrmDBTool.ButtonStartRebuildClick(Sender: TObject);

begin
  {boAutoClearDB := False;
  boRebuilding := True;
  ButtonStartRebuild.Enabled := False;
  BuildDB := TBuildDB.Create(False);
  BuildDB.FreeOnTerminate := True;
  TimerShowInfo.Enabled := True;   }
  //
end;

{ TBuildDB }

procedure TBuildDB.Execute;
var
  i: Integer;
  NewChrDB: TFileHumDB;
  NewDataDB: TFileDB;
  SrcHumanRCD: THumDataInfo;
  HumRecord: THumInfo;
  nSrcHumIndex: Integer;
begin
  NewChrDB := TFileHumDB.Create();
  NewDataDB := TFileDB.Create();
  try
    //if HumDataDB.Open then begin
      nProcID := 0;
      nProcMax := HumDataDB.m_QuickList.Count - 1;
      for i := 0 to HumDataDB.m_QuickList.Count - 1 do begin
        nProcID := i;
        if (HumDataDB.Get(i, SrcHumanRCD) < 0) or (SrcHumanRCD.Data.sChrName =
          '') then
          Continue;
        if boDelDenyChr then begin
          SafeFillChar(HumRecord, SizeOf(HumRecord), #0);
          nSrcHumIndex := HumChrDB.Index(SrcHumanRCD.Data.sChrName);
          if HumChrDB.Get(SrcHumanRCD.Data.sChrName, HumRecord) then begin
            if HumRecord.boDeleted then
              Continue;
          end;
        end;
        if boDelLevel then begin
          SafeFillChar(SrcHumanRCD.Data.Abil, SizeOf(TAbility), #0);
          SrcHumanRCD.Data.sCurMap := '3';
          SrcHumanRCD.Data.wCurX := 330;
          SrcHumanRCD.Data.wCurY := 330;
          SrcHumanRCD.Data.nGold := 0;
          SrcHumanRCD.Data.sHomeMap := '3';
          SrcHumanRCD.Data.wHomeX := 330;
          SrcHumanRCD.Data.wHomeY := 330;
          SrcHumanRCD.Data.btReLevel := 0;
          SrcHumanRCD.Data.sDearName := '';
          SrcHumanRCD.Data.boMaster := False;
          SrcHumanRCD.Data.sDearName := '';
          SrcHumanRCD.Data.btCreditPoint := 0;
          //SrcHumanRCD.Data.btMarryCount := 0;
          SrcHumanRCD.Data.sStoragePwd := '';
          SrcHumanRCD.Data.nGameGold := 0;
          SrcHumanRCD.Data.nPKPoint := 0;
        end;

        if boDelAllItem then begin
          SafeFillChar(SrcHumanRCD.Data.HumItems, SizeOf(THumItems), #0);
          SafeFillChar(SrcHumanRCD.Data.BagItems, SizeOf(TBagItems), #0);
          SafeFillChar(SrcHumanRCD.Data.StorageItems, SizeOf(TStorageItems), #0);
          //SafeFillChar(SrcHumanRCD.Data.HumAddItems, SizeOf(THumItems), #0);
        end;

        if boDelAllSkill then begin
          SafeFillChar(SrcHumanRCD.Data.HumMagics, SizeOf(THumMagics), #0);
        end;
        {if boDelBonusAbil then begin
          SafeFillChar(SrcHumanRCD.Data.BonusAbil, SizeOf(TNakedAbility), #0);
          SrcHumanRCD.Data.nBonusPoint := 0;
        end;  }

        NewDataDB.Lock;
        try
          if NewDataDB.Index(SrcHumanRCD.Data.sChrName) >= 0 then
            Continue;
        finally
          NewDataDB.UnLock;
        end;
        SafeFillChar(HumRecord, SizeOf(THumInfo), #0);
        try

            if NewChrDB.ChrCountOfAccount(SrcHumanRCD.Data.sChrName) < 2 then
              begin
              HumRecord.sChrName := SrcHumanRCD.Data.sChrName;
              HumRecord.sAccount := SrcHumanRCD.Data.sAccount;
              HumRecord.boDeleted := False;
              HumRecord.btCount := 0;
              HumRecord.Header.sName := SrcHumanRCD.Data.sChrName;
              NewChrDB.Add(HumRecord);
            end;

        finally
        end;

        try
          if NewDataDB.Index(SrcHumanRCD.Data.sChrName) = -1
  then begin
            NewDataDB.Add(SrcHumanRCD);
          end;
        finally
          //NewDataDB.Close;
        end;
      end;
    //end;
  finally
    //HumDataDB.Close;
  end;

  NewChrDB.Free;
  NewDataDB.Free;
  boRebuilding := False;

end;

{procedure TBuildDB.UpdateProcess;
begin
  if (GetTickCount - UpdateProcessTick > 1000) or (nProcID >= nProcMax) then begin
    UpdateProcessTick := GetTickCount();
    //frmDBTool.LabelProcess.Caption:=IntToStr(nProcID) + '/' + IntToStr(nProcMax);
  end;

end;     }

procedure TfrmDBTool.TimerShowInfoTimer(Sender: TObject);
begin
  {LabelProcess.Caption := IntToStr(nProcID) + '/' + IntToStr(nProcMax);
  if not boRebuilding then begin
    TimerShowInfo.Enabled := False;
    LabelProcess.Caption := 'Finish!!!';
    ShowMessage('Finish!!!');
  end;       }
end;

procedure TfrmDBTool.CheckBoxDelDenyChrClick(Sender: TObject);
begin
  //boDelDenyChr := CheckBoxDelDenyChr.Checked;
end;

procedure TfrmDBTool.CheckBoxDelLevelClick(Sender: TObject);
begin
  //boDelLevel := CheckBoxDelLevel.Checked;
end;

procedure TfrmDBTool.CheckBoxDelAllItemClick(Sender: TObject);
begin
  //boDelAllItem := CheckBoxDelAllItem.Checked;
end;

procedure TfrmDBTool.CheckBoxDelAllSkillClick(Sender: TObject);
begin
 // boDelAllSkill := CheckBoxDelAllSkill.Checked;
end;

procedure TfrmDBTool.CheckBoxDelBonusAbilClick(Sender: TObject);
begin
  //boDelBonusAbil := CheckBoxDelBonusAbil.Checked;
end;

end.
