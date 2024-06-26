object frmPrefConfig: TfrmPrefConfig
  Left = 682
  Top = 363
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Performance'
  ClientHeight = 98
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBoxServer: TGroupBox
    Left = 8
    Top = 8
    Width = 177
    Height = 49
    Caption = 'Server Check Time Out'
    TabOrder = 0
    object LabelCheckTimeOut: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 12
      Caption = 'Time Out:'
    end
    object Label1: TLabel
      Left = 128
      Top = 20
      Width = 18
      Height = 12
      Caption = 'Sec'
    end
    object EditServerCheckTimeOut: TSpinEdit
      Left = 72
      Top = 16
      Width = 49
      Height = 21
      Hint = 
        'Communication between the game server detects the length of the ' +
        'timeout'
      EditorEnabled = False
      Increment = 30
      MaxLength = 600
      MaxValue = 60
      MinValue = 60
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 0
      OnChange = EditServerCheckTimeOutChange
    end
  end
  object GroupBox1: TGroupBox
    Left = 191
    Top = 8
    Width = 177
    Height = 49
    Caption = 'Client Block Size'
    TabOrder = 1
    object LabelSendBlockSize: TLabel
      Left = 8
      Top = 20
      Width = 78
      Height = 12
      Caption = 'Client Block:'
    end
    object Label3: TLabel
      Left = 136
      Top = 20
      Width = 24
      Height = 12
      Caption = 'Byte'
    end
    object EditSendBlockSize: TSpinEdit
      Left = 72
      Top = 16
      Width = 57
      Height = 21
      Hint = 'Packet size sent to the client'
      EditorEnabled = False
      Increment = 50
      MaxLength = 600
      MaxValue = 8192
      MinValue = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 100
      OnChange = EditSendBlockSizeChange
    end
  end
  object ButtonOK: TButton
    Left = 294
    Top = 63
    Width = 74
    Height = 25
    Caption = '&OK'
    TabOrder = 2
    OnClick = ButtonOKClick
  end
end
