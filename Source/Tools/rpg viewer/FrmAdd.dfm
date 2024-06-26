object FormAdd: TFormAdd
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import Data'
  ClientHeight = 504
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 371
    Height = 61
    Caption = 'Content'
    TabOrder = 0
    object ImageStream: TRadioButton
      Left = 9
      Top = 25
      Width = 74
      Height = 21
      Caption = 'Image'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = ImageStreamClick
    end
    object WavaStream: TRadioButton
      Left = 90
      Top = 25
      Width = 74
      Height = 21
      Caption = 'Audio'
      TabOrder = 1
      OnClick = ImageStreamClick
    end
    object DataStream: TRadioButton
      Left = 171
      Top = 25
      Width = 74
      Height = 21
      Caption = 'Other'
      TabOrder = 2
      OnClick = ImageStreamClick
    end
    object NoneStream: TRadioButton
      Left = 253
      Top = 25
      Width = 115
      Height = 21
      Caption = 'Blank Space'
      TabOrder = 3
      OnClick = ImageStreamClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 389
    Top = 10
    Width = 252
    Height = 470
    Caption = 'File List'
    TabOrder = 3
    object File_List: TListBox
      Left = 9
      Top = 25
      Width = 232
      Height = 356
      ItemHeight = 15
      MultiSelect = True
      Sorted = True
      TabOrder = 0
    end
    object File_Add: TButton
      Left = 9
      Top = 389
      Width = 72
      Height = 31
      Caption = '&Add'
      TabOrder = 2
      OnClick = File_AddClick
    end
    object File_Del: TButton
      Left = 89
      Top = 428
      Width = 72
      Height = 31
      Caption = '&Delete'
      TabOrder = 3
      OnClick = File_DelClick
    end
    object File_Clear: TButton
      Left = 169
      Top = 428
      Width = 72
      Height = 31
      Caption = '&Clear'
      TabOrder = 4
      OnClick = File_ClearClick
    end
    object File_Begin: TButton
      Left = 9
      Top = 428
      Width = 72
      Height = 31
      Caption = '&Begin'
      TabOrder = 1
      OnClick = File_BeginClick
    end
    object File_AddDIR: TButton
      Left = 89
      Top = 389
      Width = 72
      Height = 31
      Caption = 'Add D&ir'
      TabOrder = 5
      OnClick = File_AddDIRClick
    end
    object File_AddDIRALL: TButton
      Left = 169
      Top = 389
      Width = 72
      Height = 31
      Caption = 'AddDirALL'
      TabOrder = 6
      OnClick = File_AddDIRALLClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 10
    Top = 383
    Width = 178
    Height = 97
    Caption = 'Import Mode'
    TabOrder = 1
    object Mode_after: TRadioButton
      Left = 10
      Top = 23
      Width = 108
      Height = 21
      Caption = 'At End'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = ImageStreamClick
    end
    object Mode_Insert: TRadioButton
      Left = 10
      Top = 44
      Width = 154
      Height = 21
      Caption = 'Current Position'
      TabOrder = 1
      OnClick = ImageStreamClick
    end
    object Mode_Bestrow: TRadioButton
      Left = 10
      Top = 65
      Width = 108
      Height = 21
      Caption = 'Replace'
      TabOrder = 2
      OnClick = ImageStreamClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 195
    Top = 383
    Width = 186
    Height = 97
    Caption = 'Number'
    TabOrder = 2
    object Label3: TLabel
      Left = 10
      Top = 61
      Width = 47
      Height = 15
      Caption = 'End No.:'
      Enabled = False
    end
    object Label2: TLabel
      Left = 10
      Top = 29
      Width = 50
      Height = 15
      Caption = 'Start No.:'
      Enabled = False
    end
    object Index_Start: TSpinEdit
      Left = 85
      Top = 23
      Width = 86
      Height = 24
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 0
      Value = 9
      OnChange = ImageStreamClick
    end
    object Index_End: TSpinEdit
      Left = 85
      Top = 56
      Width = 86
      Height = 24
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 1
      Value = 9
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 489
    Width = 650
    Height = 15
    Align = alBottom
    TabOrder = 5
  end
  object NoneOption: TGroupBox
    Left = 10
    Top = 79
    Width = 324
    Height = 296
    Caption = '?????'
    TabOrder = 6
    object Label6: TLabel
      Left = 10
      Top = 28
      Width = 47
      Height = 15
      Caption = 'Quantity:'
    end
    object None_Count: TSpinEdit
      Left = 51
      Top = 24
      Width = 78
      Height = 24
      MaxValue = 100000
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
  end
  object WavaOption: TGroupBox
    Left = 10
    Top = 79
    Width = 324
    Height = 296
    Caption = '????'
    TabOrder = 4
    object GroupBox8: TGroupBox
      Left = 13
      Top = 21
      Width = 296
      Height = 64
      Caption = '????'
      TabOrder = 0
      object Label4: TLabel
        Left = 118
        Top = 28
        Width = 57
        Height = 15
        Caption = '????(0~9)'
      end
      object Wava_ZIP: TCheckBox
        Left = 13
        Top = 25
        Width = 81
        Height = 21
        Caption = 'ZIP??'
        TabOrder = 0
        OnClick = ImageStreamClick
      end
      object Wava_ZIP_Level: TSpinEdit
        Left = 225
        Top = 23
        Width = 54
        Height = 24
        EditorEnabled = False
        MaxValue = 9
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
  end
  object DataOption: TGroupBox
    Left = 10
    Top = 79
    Width = 324
    Height = 296
    Caption = 'Data Options'
    TabOrder = 8
    object GroupBox9: TGroupBox
      Left = 13
      Top = 21
      Width = 296
      Height = 64
      Caption = 'Compression Options'
      TabOrder = 0
      object Label5: TLabel
        Left = 118
        Top = 28
        Width = 133
        Height = 15
        Caption = 'Compression level(0~9)'
      end
      object Data_ZIP: TCheckBox
        Left = 13
        Top = 25
        Width = 81
        Height = 21
        Caption = 'ZIP Compression'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = ImageStreamClick
      end
      object Data_ZIP_Level: TSpinEdit
        Left = 225
        Top = 23
        Width = 54
        Height = 24
        EditorEnabled = False
        MaxValue = 9
        MinValue = 0
        TabOrder = 1
        Value = 9
      end
    end
  end
  object ImageOption: TGroupBox
    Left = 10
    Top = 79
    Width = 371
    Height = 296
    Caption = 'Image Options'
    TabOrder = 7
    object GroupBox7: TGroupBox
      Left = 13
      Top = 21
      Width = 343
      Height = 190
      Caption = 'Import Options'
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 89
        Width = 62
        Height = 15
        Caption = 'TransColor'
      end
      object Label7: TLabel
        Left = 10
        Top = 121
        Width = 65
        Height = 15
        Caption = 'Blend Mode'
      end
      object Label8: TLabel
        Left = 40
        Top = 154
        Width = 39
        Height = 15
        Caption = 'Format'
      end
      object Image_ImgAndOffset: TRadioButton
        Left = 10
        Top = 25
        Width = 155
        Height = 21
        Caption = 'Image+Placements'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = ImageStreamClick
      end
      object Image_Img: TRadioButton
        Left = 163
        Top = 25
        Width = 70
        Height = 21
        Caption = 'Image'
        TabOrder = 1
        OnClick = ImageStreamClick
      end
      object Image_Offset: TRadioButton
        Left = 240
        Top = 25
        Width = 104
        Height = 21
        Caption = 'Placements'
        TabOrder = 2
        OnClick = ImageStreamClick
      end
      object Image_Alpha: TCheckBox
        Left = 10
        Top = 54
        Width = 123
        Height = 21
        Caption = 'Alpha Channel'
        TabOrder = 3
        OnClick = ImageStreamClick
      end
      object Image_RLE: TCheckBox
        Left = 159
        Top = 54
        Width = 84
        Height = 21
        Caption = 'RLE'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = ImageStreamClick
      end
      object Image_Cut: TCheckBox
        Left = 240
        Top = 54
        Width = 105
        Height = 21
        Caption = 'Flip Image'
        TabOrder = 5
        OnClick = ImageStreamClick
      end
      object Image_TColor: TRzColorEdit
        Left = 93
        Top = 83
        Width = 58
        Height = 23
        SelectedColor = clBlack
        ShowCustomColor = True
        TabOrder = 6
      end
      object Image_Blend: TComboBox
        Left = 93
        Top = 116
        Width = 190
        Height = 23
        Hint = 'Mixed-mode'
        Style = csDropDownList
        Ctl3D = False
        DropDownCount = 10
        ItemHeight = 15
        ParentCtl3D = False
        TabOrder = 7
        OnChange = Image_BlendChange
      end
      object Image_Format: TComboBox
        Left = 93
        Top = 149
        Width = 190
        Height = 23
        Hint = 'Mixed Mode'
        Style = csDropDownList
        Ctl3D = False
        DropDownCount = 10
        ItemHeight = 15
        ParentCtl3D = False
        TabOrder = 8
        OnChange = ImageStreamClick
        Items.Strings = (
          '16bit Colour(A4R4G4B4)'
          '16bit Colour + Alpha(A1R5G5B5)'
          'High Colour(R5G6B5)'
          '32bit Colour(A8R8G8B8)')
      end
      object Image_Window: TCheckBox
        Left = 159
        Top = 88
        Width = 74
        Height = 21
        Caption = 'Default'
        TabOrder = 9
        OnClick = ImageStreamClick
      end
      object Image_Format_byFile: TCheckBox
        Left = 240
        Top = 88
        Width = 56
        Height = 21
        Caption = 'File'
        TabOrder = 10
        OnClick = ImageStreamClick
      end
    end
    object GroupBox6: TGroupBox
      Left = 13
      Top = 219
      Width = 343
      Height = 62
      Caption = 'Placements'
      TabOrder = 1
      object Image_Offset_File: TRadioButton
        Left = 10
        Top = 26
        Width = 111
        Height = 22
        Caption = 'From File'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = ImageStreamClick
      end
      object Image_Offset_App: TRadioButton
        Left = 134
        Top = 26
        Width = 62
        Height = 22
        Caption = 'Fixed'
        TabOrder = 1
        OnClick = ImageStreamClick
      end
      object Image_Offset_AppData: TEdit
        Left = 204
        Top = 24
        Width = 80
        Height = 23
        TabOrder = 2
        Text = '0,0'
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 
      '??????|*.*|BMP (*.bmp;*.dib)|*.bmp;*.dib|TARGA (*.tga)|*.tga|PNG' +
      ' (*.png)|*.png|WAV (*.wav)|*.wav|MP3 (*.mp3)|*.mp3'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 323
    Top = 34
  end
end
