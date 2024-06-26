object frmViewOnlineHuman: TfrmViewOnlineHuman
  Left = 273
  Top = 420
  Caption = 'Online Players'
  ClientHeight = 390
  ClientWidth = 903
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PanelStatus: TPanel
    Left = 0
    Top = 41
    Width = 903
    Height = 349
    Align = alClient
    Caption = '??????...'
    TabOrder = 0
    object GridHuman: TStringGrid
      Left = 1
      Top = 1
      Width = 901
      Height = 347
      Align = alClient
      ColCount = 14
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 25
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      OnDblClick = GridHumanDblClick
      ColWidths = (
        33
        78
        31
        44
        39
        37
        47
        124
        89
        32
        138
        59
        55
        57)
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 903
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 30
      Height = 12
      Caption = 'Sort:'
    end
    object ButtonRefGrid: TButton
      Left = 384
      Top = 9
      Width = 73
      Height = 21
      Caption = 'Reload(&R)'
      TabOrder = 0
      OnClick = ButtonRefGridClick
    end
    object ComboBoxSort: TComboBox
      Left = 48
      Top = 10
      Width = 113
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      OnClick = ComboBoxSortClick
      Items.Strings = (
        '??'
        '??'
        '??'
        '??'
        '??'
        'IP'
        '??'
        '????')
    end
    object EditSearchName: TEdit
      Left = 170
      Top = 10
      Width = 129
      Height = 20
      TabOrder = 2
    end
    object ButtonSearch: TButton
      Left = 305
      Top = 9
      Width = 73
      Height = 21
      Caption = 'Search(&S)'
      TabOrder = 3
      OnClick = ButtonSearchClick
    end
    object ButtonView: TButton
      Left = 463
      Top = 9
      Width = 113
      Height = 21
      Caption = 'View (&I)'
      TabOrder = 4
      OnClick = ButtonViewClick
    end
    object CheckBox1: TCheckBox
      Left = 582
      Top = 12
      Width = 97
      Height = 17
      Caption = '??????'
      TabOrder = 5
    end
    object Button1: TButton
      Left = 681
      Top = 9
      Width = 145
      Height = 21
      Caption = '??????????'
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 392
    Top = 200
  end
end
