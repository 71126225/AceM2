object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #26032#28909#34880#20256#22855'GM'#31649#29702#24037#20855
  ClientHeight = 400
  ClientWidth = 917
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mm1: TMainMenu
    Left = 128
    Top = 72
    object T1: TMenuItem
      Caption = 'Tools(&T)'
      object Q1: TMenuItem
        Caption = 'Player Questions&Q)'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object E1: TMenuItem
        Caption = 'Exit(&E)'
      end
    end
    object H1: TMenuItem
      Caption = 'Help(&H)'
      object A1: TMenuItem
        Caption = 'About(&A)'
      end
    end
  end
end
