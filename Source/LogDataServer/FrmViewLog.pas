unit FrmViewLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, ComCtrls, Buttons, DB, ADODB, DateUtils, Menus;

type
  TFormView = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    LogGrid: TStringGrid;
    Label1: TLabel;
    DateTimeBegin: TDateTimePicker;
    Label2: TLabel;
    BitBtnOK: TBitBtn;
    DateTimeEnd: TDateTimePicker;
    ADOQuery1: TADOQuery;
    pm1: TPopupMenu;
    Menu_ItemName: TMenuItem;
    N2: TMenuItem;
    Menu_Write: TMenuItem;
    Menu_ItemID: TMenuItem;
    dlgSave1: TSaveDialog;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    Edit4: TEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit5: TEdit;
    GroupBox1: TGroupBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    Edit1: TEdit;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    Edit6: TEdit;
    CheckBox20: TCheckBox;
    Edit7: TEdit;
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    CheckBox21: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxTerm1Change(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure LogGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure LogGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Menu_WriteClick(Sender: TObject);
  private
    SelACol: Integer;
    SelARow: Integer;
    procedure CreateCheckBox();
    procedure ViewLog();
    function GetDBFileName(nDate: TDateTime): string;
    function GetWorkName(Idx: Integer): string;
    procedure ReadLog(sFileName: string; Idx: Integer);
  public
    { Public declarations }
  end;

var
  FormView: TFormView;

implementation
uses
  LogShare, Grobal2;

{$R *.dfm}

procedure TFormView.FormCreate(Sender: TObject);
begin
  DateTimeBegin.DateTime := Now;
  DateTimeEnd.DateTime := Now;
  LogGrid.Cells[0, 0] := 'number';
  LogGrid.Cells[1, 0] := 'action';
  LogGrid.Cells[2, 0] := 'map';
  LogGrid.Cells[3, 0] := 'Coordinate X';
  LogGrid.Cells[4, 0] := 'Coordinate Y';
  LogGrid.Cells[5, 0] := 'name';
  LogGrid.Cells[6, 0] := 'Item Name';
  LogGrid.Cells[7, 0] := 'Item ID';
  LogGrid.Cells[8, 0] := 'number of the stuffs';
  LogGrid.Cells[9, 0] := 'Trading partners';
  LogGrid.Cells[10, 0] := 'Note 1';
  LogGrid.Cells[11, 0] := 'Note 2';
  LogGrid.Cells[12, 0] := 'Note 3';
  LogGrid.Cells[13, 0] := 'time';
  CreateCheckBox;
end;

procedure TFormView.CreateCheckBox();
{var
  I: Integer;  }
begin
 (* ComboBoxTerm2.Items.AddObject('全部动作', TObject(-1));
  for I := Low(m_LogList) to High(m_LogList) do begin
    ComboBoxTerm2.Items.AddObject(m_LogList[I].sLogName,
      TObject(m_LogList[I].nLogIdx));
  end;
  { ComboBoxTerm2.Items.AddObject('取回物品',TObject(0));
   ComboBoxTerm2.Items.AddObject('存放物品',TObject(1));
   ComboBoxTerm2.Items.AddObject('炼制药品',TObject(2));
   ComboBoxTerm2.Items.AddObject('持久消失',TObject(3));
   ComboBoxTerm2.Items.AddObject('捡取物品',TObject(4));
   ComboBoxTerm2.Items.AddObject('制造物品',TObject(5));
   ComboBoxTerm2.Items.AddObject('毁掉物品',TObject(6));
   ComboBoxTerm2.Items.AddObject('扔掉物品',TObject(7));
   ComboBoxTerm2.Items.AddObject('交易物品',TObject(8));
   ComboBoxTerm2.Items.AddObject('购买物品',TObject(9));
   ComboBoxTerm2.Items.AddObject('出售物品',TObject(10));
   ComboBoxTerm2.Items.AddObject('使用物品',TObject(11));
   ComboBoxTerm2.Items.AddObject('人物升级',TObject(12));
   ComboBoxTerm2.Items.AddObject('减少金币',TObject(13));
   ComboBoxTerm2.Items.AddObject('增加金币',TObject(14));
   ComboBoxTerm2.Items.AddObject('死亡掉落',TObject(15));
   ComboBoxTerm2.Items.AddObject('掉落物品',TObject(16));
   ComboBoxTerm2.Items.AddObject('等级调整',TObject(17));
   ComboBoxTerm2.Items.AddObject('人物死亡',TObject(19));
   ComboBoxTerm2.Items.AddObject('升级成功',TObject(20));
   ComboBoxTerm2.Items.AddObject('升级失败',TObject(21));
   ComboBoxTerm2.Items.AddObject('升级取回',TObject(24));
   ComboBoxTerm2.Items.AddObject('武器升级',TObject(25));
   ComboBoxTerm2.Items.AddObject('城堡减钱',TObject(22));
   ComboBoxTerm2.Items.AddObject('城堡加钱',TObject(23));
   ComboBoxTerm2.Items.AddObject('背包减少',TObject(26));
   ComboBoxTerm2.Items.AddObject('改变城主',TObject(27));
   ComboBoxTerm2.Items.AddObject('元宝改变',TObject(28));
   ComboBoxTerm2.Items.AddObject('能量改变',TObject(29));
   ComboBoxTerm2.Items.AddObject('商铺购买',TObject(30)); }
  ComboBoxTerm2.ItemIndex := 0;  *)
end;

procedure TFormView.ComboBoxTerm1Change(Sender: TObject);
begin
  {if ComboBoxTerm1.ItemIndex = 4 then begin
    EditText.Text := '*';
    EditText.Enabled := False;
  end
  else begin
    EditText.Enabled := True;
  end;  }
end;

procedure TFormView.ViewLog();
resourcestring
  {Text1 = 'select * from Log where %s='#39'%s%s order by 编号';
  Text2 = 'select * from Log where %s=%s%s order by 编号';
  Text3 = 'select * from Log order by 编号';
  Text4 = 'select * from Log where %s=%d order by 编号';  }
  SqlBegin = 'select * from Log ';
  SqlEnd = ' order by serial number';

  function GetAddCode(): string;
  const
    AndOrText:array[0..1] of string[5] = (' and ', ' or ');
  var
    AddStr2: string;
  begin
    Result := '';
    if CheckBox1.Checked then begin
      if Trim(Edit2.Text) = '' then begin
        Application.MessageBox('Character name cannot be empty', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      Result := ' name = ''' + Trim(Edit2.Text) + ''' ';
    end;
    if CheckBox2.Checked then begin
      if Trim(Edit3.Text) = '' then begin
        Application.MessageBox('Item name cannot be empty', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      if Result <> '' then Result := Result + AndOrText[ComboBox1.ItemIndex];
      Result := Result + ' item name = ''' + Trim(Edit3.Text) + ''' ';
    end;
    if CheckBox3.Checked then begin
      if Trim(Edit4.Text) = '' then begin
        Application.MessageBox('The transaction object cannot be empty', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      if Result <> '' then Result := Result + AndOrText[ComboBox1.ItemIndex];
      Result := Result + ' Transaction Object = ''' + Trim(Edit4.Text) + ''' ';
    end;
    if CheckBox4.Checked then begin
      if StrToIntDef(Trim(Edit5.Text), -1) = -1 then begin
        Application.MessageBox('The item ID is incorrect.', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      if Result <> '' then Result := Result + AndOrText[ComboBox1.ItemIndex];
      Result := Result + ' Item ID = ' + Trim(Edit5.Text) + ' ';
    end;
    if CheckBox20.Checked then begin
      if Trim(Edit7.Text) = '' then begin
        Application.MessageBox('Note 1 cannot be empty', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      if Result <> '' then Result := Result + AndOrText[ComboBox1.ItemIndex];
      Result := Result + ' note 1 = ''' + Trim(Edit7.Text) + ''' ';
    end;
    if CheckBox18.Checked then begin
      if Trim(Edit1.Text) = '' then begin
        Application.MessageBox('Note 2 cannot be empty', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      if Result <> '' then Result := Result + AndOrText[ComboBox1.ItemIndex];
      Result := Result + ' note 2 = ''' + Trim(Edit1.Text) + ''' ';
    end;
    if CheckBox19.Checked then begin
      if Trim(Edit6.Text) = '' then begin
        Application.MessageBox('Note 3 cannot be empty', 'hint', MB_OK + MB_ICONINFORMATION);
        Result := '';
        Exit;
      end;
      if Result <> '' then Result := Result + AndOrText[ComboBox1.ItemIndex];
      Result := Result + ' note 3 = ''' + Trim(Edit6.Text) + ''' ';
    end;
    AddStr2 := '';
    if CheckBox5.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 0 ';
    end;
    if CheckBox6.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 1 ';
    end;
    if CheckBox7.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 2 ';
    end;
    if CheckBox8.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 3 ';
    end;
    if CheckBox9.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 4 ';
    end;
    if CheckBox10.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 5 ';
    end;
    if CheckBox11.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 6 ';
    end;
    if CheckBox12.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 7 ';
    end;
    if CheckBox13.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 8 ';
    end;
    if CheckBox14.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 9 ';
    end;
    if CheckBox15.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 10 ';
    end;
    if CheckBox16.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 11 ';
    end;
    if CheckBox17.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 12 ';
    end;
    if CheckBox21.Checked then begin
      if AddStr2 <> '' then AddStr2 := AddStr2 + ' or ';
      AddStr2 := AddStr2 + ' action = 13 ';
    end;
    if AddStr2 <> '' then begin
      if Result <> '' then begin
        if ComboBox1.ItemIndex = 0 then Result := Result + ' and (' + AddStr2 + ' )'
        else Result := ' ( ' + Result + ' ) and (' + AddStr2 + ' )';
      end
      else Result := AddStr2;
    end;
    if Result <> '' then Result := SqlBegin + ' where ' + Result + SqlEnd
    else Result := SqlBegin + SqlEnd;
  end;

var
  X, I, N, II: Integer;
  nDate: TDateTime;
  FileName: string;
  ADDCode: string;
//  SqlStr: string;
begin
  DateTimeBegin.Enabled := False;
  DateTimeEnd.Enabled := DateTimeBegin.Enabled;
  //ComboBoxTerm1.Enabled := DateTimeBegin.Enabled;
  //ComboBoxTerm2.Enabled := DateTimeBegin.Enabled;
  //EditText.Enabled := DateTimeBegin.Enabled;
  BitBtnOK.Enabled := DateTimeBegin.Enabled;
  X := DaysBetween(DateTimeBegin.DateTime, DateTimeEnd.DateTime);
  LogGrid.RowCount := 2;
  LogGrid.Cells[0, 1] := '';
  LogGrid.Cells[1, 1] := '';
  LogGrid.Cells[2, 1] := '';
  LogGrid.Cells[3, 1] := '';
  LogGrid.Cells[4, 1] := '';
  LogGrid.Cells[5, 1] := '';
  LogGrid.Cells[6, 1] := '';
  LogGrid.Cells[7, 1] := '';
  LogGrid.Cells[8, 1] := '';
  LogGrid.Cells[9, 1] := '';
  LogGrid.Cells[10, 1] := '';
  LogGrid.Cells[11, 1] := '';
  LogGrid.Cells[12, 1] := '';
  LogGrid.Cells[13, 1] := '';
  II := 0;
  Try
    ADDCode := GetAddCode;
    if AddCode = '' then Exit;
   { Application.MessageBox(PChar(AddCode), '提示信息', MB_OK +
      MB_ICONINFORMATION);   }

    if X >= 0 then begin
      for I := 0 to X do begin
        nDate := DateTimeBegin.DateTime + I;
        FileName := sBaseDir + GetDBFileName(nDate);
        //showmessage(FileName);
        if FileExists(FileName) then begin
          ADOQuery1.ConnectionString := Format(ADODBString, [FileName]);
          //showmessage(ADOQuery1.ConnectionString);
          try
            (*if ComboBoxTerm2.ItemIndex > 0 then begin
              if ComboBoxTerm1.ItemIndex = 2 then
                AddCode := ' and 动作=' + IntToStr(Integer(ComboBoxTerm2.Items.Objects[ComboBoxTerm2.ItemIndex]))
              else
                AddCode := #39 + ' and 动作=' + IntToStr(Integer(ComboBoxTerm2.Items.Objects[ComboBoxTerm2.ItemIndex]));
            end
            else begin
              if ComboBoxTerm1.ItemIndex = 2 then
                AddCode := ''
              else
                AddCode := ' ' + #39;
            end;
            case ComboBoxTerm1.ItemIndex of
              0: SqlStr := Format(Text1, ['人物名称', EditText.Text, AddCode]);
              1: SqlStr := Format(Text1, ['物品名称', EditText.Text, AddCode]);
              2: SqlStr := Format(Text2, ['物品ID', EditText.Text, AddCode]);
              3: SqlStr := Format(Text1, ['交易对像', EditText.Text, AddCode]);
              4: begin
                  if ComboBoxTerm2.ItemIndex > 0 then
                    SqlStr := Format(Text4, ['动作',
                      Integer(ComboBoxTerm2.Items.Objects[ComboBoxTerm2.ItemIndex])])
                  else
                    SqlStr := Text3;
                end;
            end;     *)
            ADOQuery1.SQL.Clear;
            ADOQuery1.SQL.Add(AddCode);
            //ShowMessage(SqlStr);
            try
              ADOQuery1.Open;
            finally
            end;
            for N := 0 to ADOQuery1.RecordCount - 1 do begin
              Inc(II);
              ReadLog(FileName, II);
              ADOQuery1.Next;
            end;
          finally
            ADOQuery1.Close;
          end;
        end;
      end;
    end
    else
      MessageBox(Handle, 'End date cannot be less than start date!', 'hint', MB_OK or  MB_ICONASTERISK);
  Finally
    DateTimeBegin.Enabled := True;
    DateTimeEnd.Enabled := DateTimeBegin.Enabled;
    //ComboBoxTerm1.Enabled := DateTimeBegin.Enabled;
    //ComboBoxTerm2.Enabled := DateTimeBegin.Enabled;
    //EditText.Enabled := DateTimeBegin.Enabled;
    BitBtnOK.Enabled := DateTimeBegin.Enabled;
    ComboBoxTerm1Change(nil);
  End;

end;

procedure TFormView.ReadLog(sFileName: string; Idx: Integer);
begin
  if Idx >= LogGrid.RowCount then
    LogGrid.RowCount := LogGrid.RowCount + 1;
  try
    LogGrid.Objects[0, Idx] := TObject(TBlobField(ADOQuery1.FieldByName('item data')).BlobSize);
    LogGrid.Cells[0, Idx] := IntToStr(ADOQuery1.FieldByName('number').AsInteger);
    LogGrid.Cells[1, Idx] := GetWorkName(ADOQuery1.FieldByName('action').AsInteger);
    LogGrid.Cells[2, Idx] := ADOQuery1.FieldByName('map').AsString;
    LogGrid.Cells[3, Idx] := ADOQuery1.FieldByName('X coordinate').AsString;
    LogGrid.Cells[4, Idx] := ADOQuery1.FieldByName('Y coordinate').AsString;
    LogGrid.Cells[5, Idx] := ADOQuery1.FieldByName('name').AsString;
    LogGrid.Cells[6, Idx] := ADOQuery1.FieldByName('Item Name').AsString;
    LogGrid.Cells[7, Idx] := ADOQuery1.FieldByName('Item ID').AsString;
    LogGrid.Cells[8, Idx] := ADOQuery1.FieldByName('number of the stuffs').AsString;
    LogGrid.Cells[9, Idx] := ADOQuery1.FieldByName('Trading partners').AsString;
    LogGrid.Cells[10, Idx] := ADOQuery1.FieldByName('Note 1').AsString;
    LogGrid.Cells[11, Idx] := ADOQuery1.FieldByName('Note 2').AsString;
    LogGrid.Cells[12, Idx] := ADOQuery1.FieldByName('Note 3').AsString;
    LogGrid.Cells[13, Idx] := DateTimeToStr(ADOQuery1.FieldByName('time').AsDateTime);
    LogGrid.Cells[14, Idx] := sFileName;
    //ADOQuery1.Insert;
  except
  end;
end;

procedure TFormView.BitBtnOKClick(Sender: TObject);
begin
  {if (ComBoBoxTerm1.ItemIndex <> 4) and (EditText.Text = '') then begin
    MessageBox(Handle, '请输入查询内容！', '提示信息', MB_OK or MB_ICONASTERISK);
  end
  else begin  }
  if DateTimeEnd.DateTime < DateTimeBegin.DateTime then begin
    MessageBox(Handle, 'End date cannot be less than start date!', 'hint', MB_OK or MB_ICONASTERISK);
  end
  else begin
    try
      ViewLog;
    except
      MessageBox(Handle, 'Item ID must be a numeric value!', 'hint', MB_OK or MB_ICONASTERISK);
    end;
  end;
  //end;
end;

function TFormView.GetDBFileName(nDate: TDateTime): string;
begin
  Result := FormatDateTime('yy-mm-dd', nDate) + '.mdb';
end;

function TFormView.GetWorkName(Idx: Integer): string;
begin
  if (Idx >= Low(m_LogList)) and (Idx <= High(m_LogList)) then
    Result := m_LogList[Idx].sLogName
  else
    Result := IntToStr(Idx);
end;

procedure TFormView.LogGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbRight = Button then begin
    if LogGrid.Cells[6, SelARow] <> '' then begin
      Menu_ItemName.Caption := '&name: ' + LogGrid.Cells[6, SelARow];
      Menu_ItemID.Caption := '&Idx:  ' + LogGrid.Cells[7, SelARow];
      Menu_Write.Enabled := LogGrid.Objects[0, SelARow] <> nil;
      pm1.Popup(LogGrid.ClientOrigin.X + X, LogGrid.ClientOrigin.Y + Y);
    end;
  end;
end;

procedure TFormView.LogGridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  SelACol := ACol;
  SelARow := ARow;
end;

procedure TFormView.Menu_WriteClick(Sender: TObject);
var
  CurrentDir, sSaveFileName: string;
  FileStream: TFileStream;
begin
  if (LogGrid.Objects[0, SelARow] <> nil) and (FileExists(LogGrid.Cells[14, SelARow])) then begin
    CurrentDir := GetCurrentDir;
    Try
      dlgSave1.FileName := '';
      if not dlgSave1.Execute(Handle) then Exit;
    Finally
      SetCurrentDir(CurrentDir);
    End;
    if dlgSave1.FileName <> '' then begin
      sSaveFileName := dlgSave1.FileName;
      ADOQuery1.ConnectionString := Format(ADODBString, [LogGrid.Cells[14, SelARow]]);
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('select item data from Log where number=' +  LogGrid.Cells[0, SelARow]);
      Try
        ADOQuery1.Open;
        if ADOQuery1.RecordCount > 0 then begin
          if FileExists(sSaveFileName) then
            if not DeleteFile(sSaveFileName) then Exit;
          FileStream := TFileStream.Create(sSaveFileName, fmCreate);
          Try
            if TBlobField(ADOQuery1.FieldByName('Item data')).BlobSize = SizeOf(TUserItem) then begin
              TBlobField(ADOQuery1.FieldByName('Item data')).SaveToStream(FileStream);
              Application.MessageBox(PChar('Successfully saved product data to' + #13#10 + sSaveFileName), 'hint', MB_OK +
                MB_ICONINFORMATION);

            end;
          Finally
            FileStream.Free;
          End;
        end;
      Finally
        ADOQuery1.Close;
      End;
    end;
  end;
end;

end.
