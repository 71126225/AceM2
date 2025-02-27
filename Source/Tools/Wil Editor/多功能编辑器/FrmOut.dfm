object FormOut: TFormOut
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export Data'
  ClientHeight = 209
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 62
    Width = 153
    Height = 79
    Caption = 'Number'
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 22
      Width = 36
      Height = 12
      Caption = 'Start:'
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 24
      Height = 12
      Caption = 'End:'
    end
    object edtIndexStart: TSpinEdit
      Left = 68
      Top = 18
      Width = 69
      Height = 21
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 0
      Value = 9
    end
    object edtIndexEnd: TSpinEdit
      Left = 68
      Top = 45
      Width = 69
      Height = 21
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 1
      Value = 9
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 48
    Caption = 'SetUp'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 42
      Height = 12
      Caption = 'Output:'
    end
    object edtSaveDir: TEdit
      Left = 68
      Top = 17
      Width = 143
      Height = 20
      TabOrder = 0
    end
    object Button1: TButton
      Left = 217
      Top = 16
      Width = 29
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 167
    Top = 62
    Width = 98
    Height = 79
    Caption = #36873#39033
    TabOrder = 2
    object Out_Alpha: TCheckBox
      Left = 8
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Export Alpha'
      TabOrder = 0
    end
    object Out_Offset: TCheckBox
      Left = 8
      Top = 35
      Width = 87
      Height = 17
      Caption = 'Export X Y'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = Out_OffsetClick
    end
    object Out_Format: TCheckBox
      Left = 8
      Top = 53
      Width = 87
      Height = 17
      Caption = 'Export Format'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object btnGo: TButton
    Left = 54
    Top = 155
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 3
    OnClick = btnGoClick
  end
  object btnExit: TButton
    Left = 159
    Top = 155
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Exit'
    Default = True
    ModalResult = 2
    TabOrder = 4
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 197
    Width = 275
    Height = 12
    Align = alBottom
    TabOrder = 5
  end
end
