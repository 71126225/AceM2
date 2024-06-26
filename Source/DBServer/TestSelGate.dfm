object frmTestSelGate: TfrmTestSelGate
  Left = 466
  Top = 183
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Select Gate Test'
  ClientHeight = 166
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
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
    Top = 33
    Width = 331
    Height = 123
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 66
      Height = 15
      Caption = 'Select Gate:'
    end
    object Label2: TLabel
      Left = 10
      Top = 55
      Width = 66
      Height = 15
      Caption = 'Game Gate:'
    end
    object EditSelGate: TEdit
      Left = 80
      Top = 20
      Width = 241
      Height = 23
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object EditGameGate: TEdit
      Left = 80
      Top = 50
      Width = 241
      Height = 23
      TabOrder = 1
    end
    object ButtonTest: TButton
      Left = 131
      Top = 83
      Width = 92
      Height = 32
      Caption = '&Test'
      TabOrder = 2
      OnClick = ButtonTestClick
    end
    object Button1: TButton
      Left = 230
      Top = 83
      Width = 91
      Height = 32
      Caption = '&Change'
      Default = True
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 10
    Top = 6
    Width = 331
    Height = 35
    TabOrder = 1
    object Label3: TLabel
      Left = 10
      Top = 13
      Width = 92
      Height = 15
      Caption = 'Select Gate Test:'
    end
  end
end
