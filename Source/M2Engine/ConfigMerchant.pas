unit ConfigMerchant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ObjNpc;

type
  TfrmConfigMerchant = class(TForm)
    GroupBoxNPC: TGroupBox;
    Label2: TLabel;
    EditScriptName: TEdit;
    Label3: TLabel;
    EditMapName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditShowName: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CheckBoxOfCastle: TCheckBox;
    ComboBoxDir: TComboBox;
    EditImageIdx: TSpinEdit;
    EditX: TSpinEdit;
    EditY: TSpinEdit;
    GroupBoxScript: TGroupBox;
    MemoScript: TMemo;
    ButtonScriptSave: TButton;
    GroupBox3: TGroupBox;
    CheckBoxBuy: TCheckBox;
    CheckBoxSell: TCheckBox;
    CheckBoxStorage: TCheckBox;
    CheckBoxGetback: TCheckBox;
    CheckBoxMakedrug: TCheckBox;
    CheckBoxArmStrengthen: TCheckBox;
    CheckBoxArmUnseal: TCheckBox;
    CheckBoxRepair: TCheckBox;
    CheckBoxS_repair: TCheckBox;
    ButtonReLoadNpc: TButton;
    ButtonSave: TButton;
    CheckBoxDenyRefStatus: TCheckBox;
    Label9: TLabel;
    EditPriceRate: TSpinEdit;
    Label10: TLabel;
    EditMapDesc: TEdit;
    CheckBoxSendMsg: TCheckBox;
    CheckBoxAutoMove: TCheckBox;
    Label11: TLabel;
    EditMoveTime: TSpinEdit;
    ButtonClearTempData: TButton;
    ButtonViewData: TButton;
    GroupBox1: TGroupBox;
    ListBoxMerChant: TListBox;
    CheckBoxArmRemoveStone: TCheckBox;
    CheckBoxUpgradeNow: TCheckBox;
    CheckBoxGetBackUpgnow: TCheckBox;
    CheckBoxArmAbilityMove: TCheckBox;
    procedure ListBoxMerChantClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure CheckBoxDenyRefStatusClick(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure EditShowNameChange(Sender: TObject);
    procedure EditImageIdxChange(Sender: TObject);
    procedure CheckBoxOfCastleClick(Sender: TObject);
    procedure CheckBoxBuyClick(Sender: TObject);
    procedure CheckBoxSellClick(Sender: TObject);
    procedure CheckBoxGetbackClick(Sender: TObject);
    procedure CheckBoxStorageClick(Sender: TObject);
    procedure CheckBoxArmStrengthenClick(Sender: TObject);
    procedure CheckBoxArmUnsealClick(Sender: TObject);
    procedure CheckBoxRepairClick(Sender: TObject);
    procedure CheckBoxS_repairClick(Sender: TObject);
    procedure CheckBoxMakedrugClick(Sender: TObject);
    //procedure EditPriceRateChange(Sender: TObject);
    procedure ButtonScriptSaveClick(Sender: TObject);
    procedure ButtonReLoadNpcClick(Sender: TObject);
    procedure EditScriptNameChange(Sender: TObject);
    procedure EditMapNameChange(Sender: TObject);
    procedure ComboBoxDirChange(Sender: TObject);
    procedure MemoScriptChange(Sender: TObject);
    procedure CheckBoxSendMsgClick(Sender: TObject);
    procedure CheckBoxAutoMoveClick(Sender: TObject);
    procedure EditMoveTimeChange(Sender: TObject);
    procedure ButtonClearTempDataClick(Sender: TObject);
    procedure CheckBoxArmRemoveStoneClick(Sender: TObject);
    procedure CheckBoxGetBackUpgnowClick(Sender: TObject);
    procedure CheckBoxUpgradeNowClick(Sender: TObject);
    procedure CheckBoxArmAbilityMoveClick(Sender: TObject);
  private
    SelMerchant: TMerchant;
    boOpened: Boolean;
    //    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefListBoxMerChant();
    procedure ClearMerchantData();
    procedure LoadScriptFile();
    procedure ChangeScriptAllowAction();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMerchant: TfrmConfigMerchant;

implementation

uses UsrEngn, M2Share, Grobal2;

{$R *.dfm}

{ TfrmConfigMerchant }

procedure TfrmConfigMerchant.ModValue;
begin
  ButtonSave.Enabled := True;
  ButtonScriptSave.Enabled := True;
end;

procedure TfrmConfigMerchant.uModValue;
begin
  ButtonSave.Enabled := False;
  ButtonScriptSave.Enabled := False;
end;

procedure TfrmConfigMerchant.Open;
begin
  boOpened := False;
  uModValue();
  CheckBoxDenyRefStatus.Checked := False;
  SelMerchant := nil;
  RefListBoxMerChant;

  boOpened := True;
  ShowModal;
end;

procedure TfrmConfigMerchant.ButtonClearTempDataClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Are you sure you clear the NPC data��'), 'Confirmation',
    MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    ClearMerchantData();
  end;
end;

procedure TfrmConfigMerchant.ButtonSaveClick(Sender: TObject);
{var
  i: Integer;
  SaveList: TStringList;
  Merchant: TMerchant;
  sMerchantFile: string;
  sIsCastle: string;
  sCanMove: string;  }
begin
{  sMerchantFile := g_Config.sEnvirDir + 'Merchant.txt';
  SaveList := TStringList.Create;
  UserEngine.m_MerchantList.Lock;
  try
    for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if Merchant.m_sMapName = '0' then
        Continue;

      if Merchant.m_boCastle then
        sIsCastle := '1'
      else
        sIsCastle := '0';
      if Merchant.m_boCanMove then
        sCanMove := '1'
      else
        sCanMove := '0';

      SaveList.Add(Merchant.m_sScript + #9 +
        Merchant.m_sMapName + #9 +
        IntToStr(Merchant.m_nCurrX) + #9 +
        IntToStr(Merchant.m_nCurrY) + #9 +
        Merchant.m_sCharName + #9 +
        IntToStr(Merchant.m_nFlag) + #9 +
        IntToStr(Merchant.m_wAppr) + #9 +
        sIsCastle + #9 +
        sCanMove + #9 +
        IntToStr(Merchant.m_dwMoveTime)
        )
    end;
    SaveList.SaveToFile(sMerchantFile);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
  SaveList.Free;
  uModValue();  }
  uModValue();
end;

procedure TfrmConfigMerchant.ClearMerchantData;
var
  i: Integer;
  Merchant: TMerchant;
begin
  UserEngine.m_MerchantList.Lock;
  try
    for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      Merchant.ClearData();
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

procedure TfrmConfigMerchant.RefListBoxMerChant;
var
  i: Integer;
  Merchant: TMerchant;
begin
  UserEngine.m_MerchantList.Lock;
  try
    for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if (Merchant.m_sMapName = '0') and (Merchant.m_nCurrX = 0) and
        (Merchant.m_nCurrY = 0) then
        Continue;
      ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' +
        Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' +
        IntToStr(Merchant.m_nCurrY) + ')', Merchant);
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;

end;

procedure TfrmConfigMerchant.ListBoxMerChantClick(Sender: TObject);
var
  nSelIndex: Integer;
begin
  CheckBoxDenyRefStatus.Checked := False;
  uModValue();
  boOpened := False;
  nSelIndex := ListBoxMerChant.ItemIndex;
  if nSelIndex < 0 then
    exit;
  SelMerchant := TMerchant(ListBoxMerChant.Items.Objects[nSelIndex]);
  EditScriptName.Text := SelMerchant.m_sScript;
  EditMapName.Text := SelMerchant.m_sMapName;
  EditMapDesc.Text := SelMerchant.m_PEnvir.sMapDesc;
  EditX.Value := SelMerchant.m_nCurrX;
  EditY.Value := SelMerchant.m_nCurrY;
  EditShowName.Text := SelMerchant.m_sCharName;
  ComboBoxDir.ItemIndex := SelMerchant.m_nFlag;
  EditImageIdx.Value := SelMerchant.m_wAppr;
  CheckBoxOfCastle.Checked := SelMerchant.m_boCastle;
  CheckBoxAutoMove.Checked := SelMerchant.m_boCanMove;
  EditMoveTime.Value := SelMerchant.m_dwMoveTime;

  CheckBoxBuy.Checked := SelMerchant.m_boBuy;
  CheckBoxSell.Checked := SelMerchant.m_boSell;
  //CheckBoxGetback.Checked := SelMerchant.m_boGetback;
  CheckBoxStorage.Checked := SelMerchant.m_boStorage;
  //CheckBoxUpgradenow.Checked := SelMerchant.m_boUpgradenow;
  //CheckBoxGetbackupgnow.Checked := SelMerchant.m_boGetBackupgnow;
  CheckBoxRepair.Checked := SelMerchant.m_boRepair;
  CheckBoxS_repair.Checked := SelMerchant.m_boS_repair;
  CheckBoxMakedrug.Checked := SelMerchant.m_boMakeDrug;
  CheckBoxSendMsg.Checked := SelMerchant.m_boSendmsg2;

  CheckBoxArmStrengthen.Checked := SelMerchant.m_boArmStrengthen;
  CheckBoxArmUnseal.Checked := SelMerchant.m_boArmUnseal;
  CheckBoxArmRemoveStone.Checked := SelMerchant.m_boArmRemoveStone;
  CheckBoxArmAbilityMove.Checked := SelMerchant.m_boArmAbilityMove;

  CheckBoxUpgradeNow.Checked := SelMerchant.m_boUpgradeNow;
  CheckBoxGetBackUpgnow.Checked := SelMerchant.m_boGetBackUpgnow;

  //EditPriceRate.Value := SelMerchant.m_nPriceRate;
  MemoScript.Clear;
  ButtonReLoadNpc.Enabled := False;
  LoadScriptFile();

  GroupBoxNPC.Enabled := True;
  GroupBoxScript.Enabled := True;

  boOpened := True;
end;

procedure TfrmConfigMerchant.FormCreate(Sender: TObject);
begin
  ComboBoxDir.Items.Add('0');
  ComboBoxDir.Items.Add('1');
  ComboBoxDir.Items.Add('2');
  ComboBoxDir.Items.Add('3');
  ComboBoxDir.Items.Add('4');
  ComboBoxDir.Items.Add('5');
  ComboBoxDir.Items.Add('6');
  ComboBoxDir.Items.Add('7');
end;

procedure TfrmConfigMerchant.CheckBoxDenyRefStatusClick(Sender: TObject);
begin
  {if SelMerchant <> nil then begin
    SelMerchant.m_boDenyRefStatus := CheckBoxDenyRefStatus.Checked;
  end;        }
end;

procedure TfrmConfigMerchant.EditXChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_nCurrX := EditX.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.EditYChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_nCurrY := EditY.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.EditShowNameChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_sCharName := Trim(EditShowName.Text);
  ModValue();
end;

procedure TfrmConfigMerchant.EditImageIdxChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_wAppr := EditImageIdx.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.EditScriptNameChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_sScript := Trim(EditScriptName.Text);
  ModValue();
end;

procedure TfrmConfigMerchant.EditMapNameChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_sMapName := Trim(EditMapName.Text);
  ModValue();
end;

procedure TfrmConfigMerchant.ComboBoxDirChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_nFlag := ComboBoxDir.ItemIndex;
  ModValue();
end;

procedure TfrmConfigMerchant.CheckBoxOfCastleClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boCastle := CheckBoxOfCastle.Checked;
  ModValue();
end;

procedure TfrmConfigMerchant.CheckBoxAutoMoveClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boCanMove := CheckBoxAutoMove.Checked;
  ModValue();
end;

procedure TfrmConfigMerchant.EditMoveTimeChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_dwMoveTime := EditMoveTime.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.LoadScriptFile;
var
  i: Integer;
  sScriptFile: string;
  LoadList: TStringList;
  LineText: string;
  boNoHeader: Boolean;
begin
  if SelMerchant = nil then
    exit;
  sScriptFile := g_Config.sEnvirDir + 'Market_Def\' + SelMerchant.m_sScript + '-' + SelMerchant.m_sMapName + '.txt';
  MemoScript.Visible := False;
  LineText := '(';
  if SelMerchant.m_boBuy then
    LineText := LineText + sBUY + ' ';
  if SelMerchant.m_boSell then
    LineText := LineText + sSELL + ' ';
  if SelMerchant.m_boMakeDrug then
    LineText := LineText + sMAKEDURG + ' ';
  if SelMerchant.m_boStorage then
    LineText := LineText + sSTORAGE + ' ';
  //if SelMerchant.m_boGetback then
    //LineText := LineText + sGETBACK + ' ';
  if SelMerchant.m_boRepair then
    LineText := LineText + sREPAIR + ' ';
  if SelMerchant.m_boS_repair then
    LineText := LineText + sSUPERREPAIR + ' ';
  if SelMerchant.m_boSendmsg2 then
    LineText := LineText + sSL_SENDMSG + ' ';

  if SelMerchant.m_boBuyOff then
    LineText := LineText + sBUYOFF + ' ';
  if SelMerchant.m_boSellOff then
    LineText := LineText + sSELLOFF + ' ';
  if SelMerchant.m_boGetSellGold then
    LineText := LineText + sGETSELLGOLD + ' ';
  if SelMerchant.m_boArmStrengthen then
    LineText := LineText + sArmStrengthen + ' ';
  if SelMerchant.m_boArmAbilityMove then
    LineText := LineText + sArmAbilityMove + ' ';
  if SelMerchant.m_boArmUnseal then
    LineText := LineText + sArmUnseal + ' ';
  if SelMerchant.m_boInputInteger then
    LineText := LineText + sINPUTINTEGER + ' ';
  if SelMerchant.m_boInputString then
    LineText := LineText + sINPUTSTRING + ' ';
  if SelMerchant.m_boUpgradeNow then
    LineText := LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackUpgnow then
    LineText := LineText + sGETBACKUPGNOW + ' ';
  if SelMerchant.m_boArmRemoveStone then
    LineText := LineText + sArmRemoveStone + ' ';

  LineText := LineText + ')';
  MemoScript.Lines.Add(LineText);
  //LineText := '%' + IntToStr(SelMerchant.m_nPriceRate);
  //MemoScript.Lines.Add(LineText);
  {for i := 0 to SelMerchant.m_ItemTypeList.Count - 1 do begin
    LineText := '+' + IntToStr(Integer(SelMerchant.m_ItemTypeList.Items[i]));
    MemoScript.Lines.Add(LineText);
  end;        }
  if FileExists(sScriptFile) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sScriptFile);
    boNoHeader := False;
    for i := 0 to LoadList.Count - 1 do begin
      LineText := LoadList.Strings[i];
      if (LineText = '') or (LineText[1] = ';') then
        Continue;

      if (LineText[1] = '[') or (LineText[1] = '#') then
        boNoHeader := True;
      if boNoHeader then begin
        MemoScript.Lines.Add(LineText);
      end;

    end;
    LoadList.Free;
  end;
  MemoScript.Visible := True;
end;

procedure TfrmConfigMerchant.ChangeScriptAllowAction;
var
  LineText: string;
begin
  if (SelMerchant = nil) or (MemoScript.Lines.Count <= 0) then
    exit;
  LineText := '(';
  if SelMerchant.m_boBuy then
    LineText := LineText + sBUY + ' ';
  if SelMerchant.m_boSell then
    LineText := LineText + sSELL + ' ';
  if SelMerchant.m_boMakeDrug then
    LineText := LineText + sMAKEDURG + ' ';
  if SelMerchant.m_boStorage then
    LineText := LineText + sSTORAGE + ' ';
  //if SelMerchant.m_boGetback then
    //LineText := LineText + sGETBACK + ' ';
  {if SelMerchant.m_boUpgradenow then
    LineText := LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackupgnow then
    LineText := LineText + sGETBACKUPGNOW + ' ';    }
  if SelMerchant.m_boRepair then
    LineText := LineText + sREPAIR + ' ';
  if SelMerchant.m_boS_repair then
    LineText := LineText + sSUPERREPAIR + ' ';
  if SelMerchant.m_boSendmsg2 then
    LineText := LineText + sSL_SENDMSG + ' ';
  if SelMerchant.m_boArmStrengthen then
    LineText := LineText + sArmStrengthen + ' ';
  if SelMerchant.m_boArmAbilityMove then
    LineText := LineText + sArmAbilityMove + ' ';
  if SelMerchant.m_boArmUnseal then
    LineText := LineText + sArmUnseal + ' ';
  if SelMerchant.m_boInputInteger then
    LineText := LineText + sINPUTINTEGER + ' ';
  if SelMerchant.m_boInputString then
    LineText := LineText + sINPUTSTRING + ' ';
  if SelMerchant.m_boUpgradeNow then
    LineText := LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackUpgnow then
    LineText := LineText + sGETBACKUPGNOW + ' ';
  if SelMerchant.m_boArmRemoveStone then
    LineText := LineText + sArmRemoveStone + ' ';

  LineText := LineText + ')';
  MemoScript.Lines[0] := LineText;
end;

procedure TfrmConfigMerchant.CheckBoxBuyClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boBuy := CheckBoxBuy.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxSellClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boSell := CheckBoxSell.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxGetbackClick(Sender: TObject);
begin
  {if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boGetback := CheckBoxGetback.Checked;
  ModValue();
  ChangeScriptAllowAction();   }
end;

procedure TfrmConfigMerchant.CheckBoxGetBackUpgnowClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then exit;
  SelMerchant.m_boGetBackUpgnow := CheckBoxGetBackUpgnow.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxStorageClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boStorage := CheckBoxStorage.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxArmAbilityMoveClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boArmAbilityMove := CheckBoxArmAbilityMove.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxArmRemoveStoneClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then exit;
  SelMerchant.m_boArmRemoveStone := CheckBoxArmRemoveStone.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxArmStrengthenClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boArmStrengthen := CheckBoxArmStrengthen.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxArmUnsealClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boArmUnseal := CheckBoxArmUnseal.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxRepairClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boRepair := CheckBoxRepair.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxS_repairClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boS_repair := CheckBoxS_repair.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxUpgradeNowClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then exit;
  SelMerchant.m_boUpgradeNow := CheckBoxUpgradeNow.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxMakedrugClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boMakeDrug := CheckBoxMakedrug.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxSendMsgClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  SelMerchant.m_boSendmsg2 := CheckBoxSendMsg.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;
 {
procedure TfrmConfigMerchant.EditPriceRateChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;

  SelMerchant.m_nPriceRate := EditPriceRate.Value;
  MemoScript.Lines[1] := '%' + IntToStr(SelMerchant.m_nPriceRate);
  ModValue();

end;    }

procedure TfrmConfigMerchant.ButtonScriptSaveClick(Sender: TObject);
{var
  sScriptFile: string;    }
begin
  {sScriptFile := g_Config.sEnvirDir + 'Market_Def\' + SelMerchant.m_sScript + '-' + SelMerchant.m_sMapName + '.txt';
  MemoScript.Lines.SaveToFile(sScriptFile);   }
  uModValue();
  ButtonReLoadNpc.Enabled := True;
end;

procedure TfrmConfigMerchant.ButtonReLoadNpcClick(Sender: TObject);
begin
  if (SelMerchant = nil) then
    exit;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    SelMerchant.ClearScript;
    SelMerchant.LoadNpcScript;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  ButtonReLoadNpc.Enabled := False;
end;

procedure TfrmConfigMerchant.MemoScriptChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then
    exit;
  ModValue();
end;

end.
