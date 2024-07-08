object FormMain: TFormMain
  Left = 230
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Log Data Server'
  ClientHeight = 38
  ClientWidth = 298
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
  TextHeight = 12
  object Label1: TLabel
    Left = 6
    Top = 6
    Width = 72
    Height = 12
    Caption = 'Current Log:'
  end
  object Label2: TLabel
    Left = 6
    Top = 23
    Width = 54
    Height = 12
    Caption = 'File Name'
  end
  object Label3: TLabel
    Left = 88
    Top = 6
    Width = 6
    Height = 12
    Caption = '0'
  end
  object Memo1: TMemo
    Left = 0
    Top = 48
    Width = 297
    Height = 145
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 218
    Top = 5
    Width = 72
    Height = 17
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
