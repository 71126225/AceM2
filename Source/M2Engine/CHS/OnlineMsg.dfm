object frmOnlineMsg: TfrmOnlineMsg
  Left = 367
  Top = 319
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Online Message'
  ClientHeight = 415
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 5
    Top = 211
    Width = 54
    Height = 15
    Caption = 'Message:'
  end
  object ComboBoxMsg: TComboBox
    Left = 79
    Top = 206
    Width = 467
    Height = 25
    Style = csSimple
    ItemHeight = 15
    TabOrder = 0
    OnChange = ComboBoxMsgChange
    OnKeyPress = ComboBoxMsgKeyPress
  end
  object MemoMsg: TMemo
    Left = 4
    Top = 5
    Width = 542
    Height = 191
    Lines.Strings = (
      'MemoMsg')
    TabOrder = 1
    OnChange = MemoMsgChange
  end
  object StringGrid: TStringGrid
    Left = 4
    Top = 274
    Width = 542
    Height = 132
    ColCount = 1
    DefaultColWidth = 430
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    ScrollBars = ssVertical
    TabOrder = 2
    OnClick = StringGridClick
    OnDblClick = StringGridDblClick
  end
  object ButtonAdd: TButton
    Left = 459
    Top = 239
    Width = 84
    Height = 29
    Caption = 'Add(&A)'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 369
    Top = 239
    Width = 84
    Height = 29
    Caption = 'Delete(&D)'
    Enabled = False
    TabOrder = 4
    OnClick = ButtonDeleteClick
  end
  object ButtonSend: TButton
    Left = 185
    Top = 238
    Width = 84
    Height = 28
    Caption = 'Send(&S)'
    TabOrder = 5
    OnClick = ButtonSendClick
  end
end
