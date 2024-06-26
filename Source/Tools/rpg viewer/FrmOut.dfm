object FormOut: TFormOut
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export Data'
  ClientHeight = 261
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 10
    Top = 78
    Width = 191
    Height = 98
    Caption = 'Number'
    TabOrder = 0
    object Label2: TLabel
      Left = 10
      Top = 28
      Width = 28
      Height = 15
      Caption = 'Start:'
    end
    object Label3: TLabel
      Left = 10
      Top = 60
      Width = 25
      Height = 15
      Caption = 'End:'
    end
    object edtIndexStart: TSpinEdit
      Left = 85
      Top = 23
      Width = 86
      Height = 21
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 0
      Value = 9
    end
    object edtIndexEnd: TSpinEdit
      Left = 85
      Top = 56
      Width = 86
      Height = 21
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 1
      Value = 9
    end
  end
  object GroupBox2: TGroupBox
    Left = 10
    Top = 10
    Width = 359
    Height = 60
    Caption = 'SetUp'
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 26
      Width = 39
      Height = 15
      Caption = 'Output:'
    end
    object edtSaveDir: TEdit
      Left = 85
      Top = 21
      Width = 211
      Height = 20
      TabOrder = 0
    end
    object Button1: TButton
      Left = 304
      Top = 21
      Width = 36
      Height = 27
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 209
    Top = 78
    Width = 152
    Height = 98
    Caption = 'Options'
    TabOrder = 2
    object Out_Alpha: TCheckBox
      Left = 10
      Top = 20
      Width = 131
      Height = 21
      Caption = 'Export Alpha'
      TabOrder = 0
    end
    object Out_Offset: TCheckBox
      Left = 10
      Top = 44
      Width = 109
      Height = 21
      Caption = 'Export X Y'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = Out_OffsetClick
    end
    object Out_Format: TCheckBox
      Left = 10
      Top = 66
      Width = 131
      Height = 22
      Caption = 'Export Format'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object btnGo: TButton
    Left = 68
    Top = 194
    Width = 93
    Height = 31
    Caption = '&OK'
    TabOrder = 3
    OnClick = btnGoClick
  end
  object btnExit: TButton
    Left = 199
    Top = 194
    Width = 94
    Height = 31
    Cancel = True
    Caption = '&Exit'
    Default = True
    ModalResult = 2
    TabOrder = 4
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 246
    Width = 379
    Height = 15
    Align = alBottom
    TabOrder = 5
  end
end
