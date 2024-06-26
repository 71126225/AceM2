object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Map Conversion'
  ClientHeight = 338
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object DropFile: TDropFileGroupBox
    Left = 8
    Top = 8
    Width = 401
    Height = 91
    Caption = 'Map File'
    TabOrder = 0
    OnDropFile = DropFileDropFile
    Active = True
    AutoActive = True
    object lbl1: TLabel
      Left = 9
      Top = 24
      Width = 54
      Height = 12
      Caption = 'Map File:'
    end
    object lblOpenFileHint: TLabel
      Left = 69
      Top = 70
      Width = 6
      Height = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 9
      Top = 49
      Width = 54
      Height = 12
      Caption = 'Progress:'
    end
    object edtFileName: TEdit
      Left = 69
      Top = 21
      Width = 276
      Height = 20
      TabOrder = 0
      Text = 'FileName'
    end
    object btnOpenFile: TButton
      Left = 351
      Top = 18
      Width = 41
      Height = 23
      Caption = 'Open'
      TabOrder = 1
      OnClick = btnOpenFileClick
    end
    object pbOpenFile: TProgressBar
      Left = 69
      Top = 47
      Width = 276
      Height = 17
      TabOrder = 2
    end
  end
  object grp1: TGroupBox
    Left = 415
    Top = 8
    Width = 244
    Height = 321
    Caption = 'Map Configuration Information'
    TabOrder = 1
    object tvFileInfo: TRzCheckTree
      Left = 10
      Top = 19
      Width = 223
      Height = 294
      OnStateChange = tvFileInfoStateChange
      Indent = 19
      MultiSelect = True
      SelectionPen.Color = clBtnShadow
      StateImages = tvFileInfo.CheckImages
      TabOrder = 0
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 105
    Width = 401
    Height = 224
    Caption = 'Conversion Options'
    TabOrder = 2
    object lbl5: TLabel
      Left = 9
      Top = 166
      Width = 383
      Height = 12
      Alignment = taCenter
      AutoSize = False
      Caption = 'Waiting Indication'
    end
    object grp3: TGroupBox
      Left = 9
      Top = 17
      Width = 383
      Height = 120
      Caption = 'File Options'
      TabOrder = 0
      object lbl2: TLabel
        Left = 6
        Top = 24
        Width = 84
        Height = 12
        Caption = 'Export Folder:'
      end
      object lbl6: TLabel
        Left = 6
        Top = 51
        Width = 84
        Height = 12
        Caption = 'Import Folder:'
      end
      object lbl4: TLabel
        Left = 211
        Top = 100
        Width = 96
        Height = 12
        Caption = 'Export quantity:'
      end
      object lblOutCount: TLabel
        Left = 311
        Top = 100
        Width = 6
        Height = 12
        Caption = '0'
      end
      object lblInCount: TLabel
        Left = 311
        Top = 77
        Width = 6
        Height = 12
        Caption = '0'
      end
      object lbl8: TLabel
        Left = 211
        Top = 77
        Width = 96
        Height = 12
        Caption = 'Import Quantity:'
      end
      object lbl7: TLabel
        Left = 6
        Top = 77
        Width = 78
        Height = 12
        Caption = 'Imp FileName:'
      end
      object lbl9: TLabel
        Left = 6
        Top = 100
        Width = 48
        Height = 12
        Caption = 'Current:'
      end
      object lbl10: TLabel
        Left = 80
        Top = 100
        Width = 6
        Height = 12
      end
      object edtOutData: TEdit
        Left = 80
        Top = 21
        Width = 249
        Height = 20
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'FileName'
      end
      object btnOutData: TButton
        Left = 334
        Top = 19
        Width = 41
        Height = 23
        Caption = 'Select'
        TabOrder = 1
        OnClick = btnOutDataClick
      end
      object edtInData: TEdit
        Left = 80
        Top = 48
        Width = 249
        Height = 20
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = 'FileName'
      end
      object btnInObjects: TButton
        Left = 334
        Top = 46
        Width = 41
        Height = 23
        Caption = 'Select'
        TabOrder = 3
        OnClick = btnInObjectsClick
      end
      object cbbInFileName: TComboBox
        Left = 80
        Top = 74
        Width = 121
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 4
        OnChange = cbbInFileNameChange
      end
    end
    object btn1: TButton
      Left = 136
      Top = 186
      Width = 129
      Height = 25
      Caption = 'Start Conversion'
      TabOrder = 1
      OnClick = btn1Click
    end
    object pb1: TProgressBar
      Left = 9
      Top = 143
      Width = 383
      Height = 17
      TabOrder = 2
    end
    object btnLoad: TButton
      Left = 5
      Top = 186
      Width = 116
      Height = 25
      Caption = 'Record File Editor'
      TabOrder = 3
      OnClick = btnLoadClick
    end
  end
  object dlgOpen: TOpenDialog
    Filter = 'ConversionData.dat|ConversionData.dat'
    Left = 24
    Top = 128
  end
end
