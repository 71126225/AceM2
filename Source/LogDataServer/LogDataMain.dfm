object FormMain: TFormMain
  Left = 230
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Log Data Server'
  ClientHeight = 48
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 68
    Height = 15
    Caption = 'Current Log:'
  end
  object Label2: TLabel
    Left = 8
    Top = 29
    Width = 57
    Height = 15
    Caption = 'File Name'
  end
  object Label3: TLabel
    Left = 110
    Top = 8
    Width = 7
    Height = 15
    Caption = '0'
  end
  object Memo1: TMemo
    Left = 0
    Top = 60
    Width = 371
    Height = 181
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 273
    Top = 6
    Width = 90
    Height = 22
    Caption = 'ViewError'
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object MainMenu1: TMainMenu
    Left = 176
    Top = 8
    object V1: TMenuItem
      Caption = '&View'
      object MEMU_VIEW_LOGVIEW: TMenuItem
        Caption = '&Log View'
        OnClick = MEMU_VIEW_LOGVIEWClick
      end
    end
    object H1: TMenuItem
      Caption = '&Help'
      object MEMU_HELP_ABOUT: TMenuItem
        Caption = '&About'
        OnClick = MEMU_HELP_ABOUTClick
      end
    end
  end
  object TimerSave: TTimer
    Interval = 3000
    OnTimer = TimerSaveTimer
    Left = 144
    Top = 16
  end
  object IdUDPServer: TIdUDPServer
    BufferSize = 81920
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 0
      end>
    DefaultPort = 0
    OnUDPRead = IdUDPServerUDPRead
    Left = 184
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\db.mdb;Persist Se' +
      'curity Info=False'
    Parameters = <>
    SQL.Strings = (
      'sql')
    Left = 96
    Top = 16
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 120
    Top = 8
  end
end
