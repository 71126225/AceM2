object frmFunctionConfig: TfrmFunctionConfig
  Left = 269
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Option Functions'
  ClientHeight = 378
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 359
    Width = 244
    Height = 15
    Caption = '?????????,???????????????,??????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object FunctionConfigControl: TPageControl
    Left = 6
    Top = 8
    Width = 457
    Height = 345
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 3
      object ButtonGeneralSave: TButton
        Left = 368
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 0
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 163
        Caption = 'Name Color'
        TabOrder = 1
        object Label85: TLabel
          Left = 11
          Top = 22
          Width = 54
          Height = 12
          Caption = 'PK Brown:'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 112
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 11
          Top = 46
          Width = 60
          Height = 12
          Caption = 'PK Yellow:'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 112
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 11
          Top = 70
          Width = 42
          Height = 12
          Caption = 'Pk Red:'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 112
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 11
          Top = 94
          Width = 30
          Height = 12
          Caption = 'Ally:'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 112
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 11
          Top = 118
          Width = 24
          Height = 12
          Caption = 'War:'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 112
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 11
          Top = 142
          Width = 48
          Height = 12
          Caption = 'PK Zone:'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 112
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 64
          Top = 18
          Width = 41
          Height = 21
          Hint = '??????????????,???47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 64
          Top = 42
          Width = 41
          Height = 21
          Hint = '???PK???100??????,???251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 64
          Top = 66
          Width = 41
          Height = 21
          Hint = '???PK???200??????,???249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 64
          Top = 90
          Width = 41
          Height = 21
          Hint = '?????????,??????????????,???180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 64
          Top = 114
          Width = 41
          Height = 21
          Hint = '?????????,??????????,???69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 64
          Top = 138
          Width = 41
          Height = 21
          Hint = '?????????????????,???221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 156
        Top = 183
        Width = 198
        Height = 106
        Caption = 'Map Event'
        TabOrder = 2
        object chkStartDropItemMapEvent: TCheckBox
          Left = 9
          Top = 16
          Width = 168
          Height = 17
          Caption = 'Start Drop Item MapEvent'
          TabOrder = 0
          OnClick = chkStartDropItemMapEventClick
        end
        object chkStartPickUpItemMapEvent: TCheckBox
          Left = 9
          Top = 33
          Width = 176
          Height = 17
          Caption = 'Start PickUp Item MapEvent'
          TabOrder = 1
          OnClick = chkStartPickUpItemMapEventClick
        end
        object chkStartHeavyHitMapEvent: TCheckBox
          Left = 9
          Top = 50
          Width = 152
          Height = 17
          Caption = 'Start Mining MapEvent'
          TabOrder = 2
          OnClick = chkStartHeavyHitMapEventClick
        end
        object chkStartWalkMapEvent: TCheckBox
          Left = 9
          Top = 67
          Width = 144
          Height = 17
          Caption = 'Start Walk MapEvent'
          TabOrder = 3
          OnClick = chkStartWalkMapEventClick
        end
        object chkStartRunMapEvent: TCheckBox
          Left = 9
          Top = 84
          Width = 144
          Height = 17
          Caption = 'Start Run MapEvent'
          TabOrder = 4
          OnClick = chkStartRunMapEventClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 156
        Top = 8
        Width = 285
        Height = 163
        Caption = 'Health Stone / Mana Stone Set'
        TabOrder = 3
        object Label147: TLabel
          Left = 9
          Top = 22
          Width = 24
          Height = 12
          Caption = 'HP <'
        end
        object Label148: TLabel
          Left = 89
          Top = 22
          Width = 126
          Height = 12
          Caption = '% OpenHPStoneInterval'
        end
        object Label149: TLabel
          Left = 239
          Top = 22
          Width = 18
          Height = 12
          Caption = 'Sec'
        end
        object Label150: TLabel
          Left = 9
          Top = 46
          Width = 102
          Height = 12
          Caption = 'HPStone Add Rate:'
        end
        object Label151: TLabel
          Left = 203
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label152: TLabel
          Left = 9
          Top = 94
          Width = 24
          Height = 12
          Caption = 'MP <'
        end
        object Label153: TLabel
          Left = 89
          Top = 94
          Width = 132
          Height = 12
          Caption = '% OpenMPStoneInterval:'
        end
        object Label154: TLabel
          Left = 239
          Top = 94
          Width = 18
          Height = 12
          Caption = 'Sec'
        end
        object Label155: TLabel
          Left = 207
          Top = 118
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label156: TLabel
          Left = 9
          Top = 118
          Width = 102
          Height = 12
          Caption = 'MPStone Add Rate:'
        end
        object Label157: TLabel
          Left = 207
          Top = 70
          Width = 30
          Height = 12
          Caption = 'Point'
        end
        object Label158: TLabel
          Left = 9
          Top = 70
          Width = 132
          Height = 12
          Caption = 'HPStone Decrease Dura:'
        end
        object Label159: TLabel
          Left = 9
          Top = 142
          Width = 132
          Height = 12
          Caption = 'MPStone Decrease Dura:'
        end
        object Label160: TLabel
          Left = 207
          Top = 142
          Width = 30
          Height = 12
          Caption = 'Point'
        end
        object SpinEditHPStoneStartRate: TSpinEdit
          Left = 43
          Top = 18
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = SpinEditHPStoneStartRateChange
        end
        object SpinEditHPStoneIntervalTime: TSpinEdit
          Left = 197
          Top = 18
          Width = 39
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 1
          OnChange = SpinEditHPStoneIntervalTimeChange
        end
        object SpinEditHPStoneAddRate: TSpinEdit
          Left = 146
          Top = 42
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPStoneAddRateChange
        end
        object SpinEditMPStoneStartRate: TSpinEdit
          Left = 43
          Top = 90
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = SpinEditMPStoneStartRateChange
        end
        object SpinEditMPStoneIntervalTime: TSpinEdit
          Left = 197
          Top = 90
          Width = 39
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 5
          Value = 1
          OnChange = SpinEditMPStoneIntervalTimeChange
        end
        object SpinEditMPStoneAddRate: TSpinEdit
          Left = 146
          Top = 114
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = SpinEditMPStoneAddRateChange
        end
        object SpinEditHPStoneDecDura: TSpinEdit
          Left = 146
          Top = 66
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 1000
          OnChange = SpinEditHPStoneDecDuraChange
        end
        object SpinEditMPStoneDecDura: TSpinEdit
          Left = 146
          Top = 138
          Width = 55
          Height = 21
          EditorEnabled = False
          MaxValue = 100000
          MinValue = 0
          TabOrder = 7
          Value = 1000
          OnChange = SpinEditMPStoneDecDuraChange
        end
      end
      object grp1: TGroupBox
        Left = 8
        Top = 183
        Width = 137
        Height = 50
        Caption = 'Other Options'
        TabOrder = 4
        object chkMonSayMsg: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = 'MonSayMsg'
          TabOrder = 0
          OnClick = chkMonSayMsgClick
        end
        object chkCheckGuild: TCheckBox
          Left = 8
          Top = 40
          Width = 120
          Height = 17
          Caption = 'CheckGuild'
          TabOrder = 1
          Visible = False
          OnClick = chkCheckGuildClick
        end
      end
      object GroupBox55: TGroupBox
        Left = 8
        Top = 239
        Width = 137
        Height = 50
        Caption = 'Growth Points'
        TabOrder = 5
        object Label140: TLabel
          Left = 11
          Top = 22
          Width = 66
          Height = 12
          Caption = 'Per Min Inc'
        end
        object EditPullulation: TSpinEdit
          Left = 77
          Top = 19
          Width = 52
          Height = 21
          Hint = '????????????????1??????=60????? 10'
          MaxValue = 100000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditPullulationChange
        end
      end
    end
    object TabSheet33: TTabSheet
      Caption = 'Master'
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 153
        Caption = 'Apprenticeship'
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 8
          Top = 16
          Width = 145
          Height = 49
          Caption = 'Level'
          TabOrder = 0
          object Label29: TLabel
            Left = 8
            Top = 18
            Width = 36
            Height = 12
            Caption = 'Level:'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = '??????,??????,????????????'
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 8
          Top = 72
          Width = 145
          Height = 73
          Caption = 'Master proceeds'
          TabOrder = 1
          object Label30: TLabel
            Left = 8
            Top = 18
            Width = 72
            Height = 12
            Caption = 'CreditPoint:'
          end
          object Label31: TLabel
            Left = 8
            Top = 42
            Width = 66
            Height = 12
            Caption = 'BonusPoint:'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = '?????,??????????'
            MaxValue = 1000
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 68
            Top = 39
            Width = 53
            Height = 21
            Hint = '?????,??????????'
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
    end
    object TabSheet38: TTabSheet
      Caption = 'ReNew'
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 257
        Caption = 'Auto Change Color'
        TabOrder = 0
        object Label56: TLabel
          Left = 11
          Top = 16
          Width = 12
          Height = 12
          Caption = '1:'
        end
        object LabelReNewNameColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 11
          Top = 40
          Width = 12
          Height = 12
          Caption = '2:'
        end
        object LabelReNewNameColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 11
          Top = 64
          Width = 12
          Height = 12
          Caption = '3:'
        end
        object LabelReNewNameColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 11
          Top = 88
          Width = 12
          Height = 12
          Caption = '4:'
        end
        object LabelReNewNameColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 11
          Top = 112
          Width = 12
          Height = 12
          Caption = '5:'
        end
        object LabelReNewNameColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 11
          Top = 136
          Width = 12
          Height = 12
          Caption = '6:'
        end
        object LabelReNewNameColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 11
          Top = 160
          Width = 12
          Height = 12
          Caption = '7:'
        end
        object LabelReNewNameColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 11
          Top = 184
          Width = 12
          Height = 12
          Caption = '8:'
        end
        object LabelReNewNameColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 11
          Top = 208
          Width = 12
          Height = 12
          Caption = '9:'
        end
        object LabelReNewNameColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 11
          Top = 232
          Width = 18
          Height = 12
          Caption = '10:'
        end
        object LabelReNewNameColor10: TLabel
          Left = 88
          Top = 230
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 40
          Top = 228
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 128
        Top = 8
        Width = 105
        Height = 65
        Caption = 'Colour'
        TabOrder = 2
        object Label57: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = 'Time:'
        end
        object Label59: TLabel
          Left = 83
          Top = 44
          Width = 18
          Height = 12
          Caption = 'Sec'
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 37
          Height = 21
          Hint = '??????,??????,????????????'
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = 
            'After you turn on this feature, the reincarnation of the names o' +
            'f the characters color will automatically change.'
          Caption = 'ChangeColor'
          TabOrder = 1
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 128
        Top = 80
        Width = 105
        Height = 41
        Caption = 'Exp'
        TabOrder = 3
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = 'Renew is clear already experience.'
          Caption = 'Clear Exp'
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = 'Mon Upgrade'
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 0
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 233
        Caption = 'Mon Color'
        TabOrder = 1
        object Label65: TLabel
          Left = 11
          Top = 16
          Width = 12
          Height = 12
          Caption = '1:'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 11
          Top = 40
          Width = 12
          Height = 12
          Caption = '2:'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 11
          Top = 64
          Width = 12
          Height = 12
          Caption = '3:'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 11
          Top = 88
          Width = 12
          Height = 12
          Caption = '4:'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 11
          Top = 112
          Width = 12
          Height = 12
          Caption = '5:'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 11
          Top = 136
          Width = 12
          Height = 12
          Caption = '6:'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 11
          Top = 160
          Width = 12
          Height = 12
          Caption = '7:'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 11
          Top = 184
          Width = 12
          Height = 12
          Caption = '8:'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 11
          Top = 208
          Width = 12
          Height = 12
          Caption = '9:'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 128
        Top = 8
        Width = 97
        Height = 233
        Caption = 'Kills'
        TabOrder = 2
        object Label61: TLabel
          Left = 11
          Top = 16
          Width = 12
          Height = 12
          Caption = '1:'
        end
        object Label63: TLabel
          Left = 11
          Top = 40
          Width = 12
          Height = 12
          Caption = '2:'
        end
        object Label78: TLabel
          Left = 11
          Top = 64
          Width = 12
          Height = 12
          Caption = '3:'
        end
        object Label79: TLabel
          Left = 11
          Top = 88
          Width = 12
          Height = 12
          Caption = '4:'
        end
        object Label80: TLabel
          Left = 11
          Top = 112
          Width = 12
          Height = 12
          Caption = '5:'
        end
        object Label81: TLabel
          Left = 11
          Top = 136
          Width = 12
          Height = 12
          Caption = '6:'
        end
        object Label82: TLabel
          Left = 11
          Top = 160
          Width = 12
          Height = 12
          Caption = '7:'
        end
        object Label83: TLabel
          Left = 11
          Top = 184
          Width = 30
          Height = 12
          Caption = 'Base:'
        end
        object Label84: TLabel
          Left = 11
          Top = 208
          Width = 30
          Height = 12
          Caption = 'Rate:'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 40
          Top = 12
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 40
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 40
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 40
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 40
          Top = 108
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 40
          Top = 132
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 40
          Top = 156
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 40
          Top = 180
          Width = 49
          Height = 21
          Hint = '????=?? * ?? + ?? + ?? + ????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 40
          Top = 204
          Width = 49
          Height = 21
          Hint = '????=???? * ?? + ?? + ?? + ????'
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 232
        Top = 8
        Width = 137
        Height = 113
        Caption = 'Master'
        TabOrder = 3
        object Label88: TLabel
          Left = 11
          Top = 40
          Width = 30
          Height = 12
          Caption = 'Rate:'
        end
        object Label90: TLabel
          Left = 11
          Top = 64
          Width = 36
          Height = 12
          Caption = 'Power:'
        end
        object Label92: TLabel
          Left = 11
          Top = 88
          Width = 36
          Height = 12
          Caption = 'Speed:'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = 'Die Mutiny'
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = '????,???????'
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 72
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 232
        Top = 128
        Width = 137
        Height = 73
        Caption = 'Change Color'
        TabOrder = 4
        object Label112: TLabel
          Left = 11
          Top = 40
          Width = 30
          Height = 12
          Caption = 'Time:'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 126
          Height = 17
          Caption = 'Auto Change Color'
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = '????,??????,??(?)?'
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Skills'
      ImageIndex = 1
      object ButtonSkillSave: TButton
        Left = 379
        Top = 275
        Width = 68
        Height = 23
        Caption = '&Save'
        TabOrder = 0
        OnClick = ButtonSkillSaveClick
      end
      object MagicPageControl: TPageControl
        Left = 0
        Top = 2
        Width = 446
        Height = 269
        ActivePage = TabSheet15
        TabOrder = 1
        object TabSheet54: TTabSheet
          Caption = 'Basic Parameters'
          object GroupBox17: TGroupBox
            Left = 8
            Top = 8
            Width = 145
            Height = 49
            Caption = 'Magic Attack Range'
            TabOrder = 0
            object Label12: TLabel
              Left = 8
              Top = 21
              Width = 66
              Height = 12
              Caption = 'Range Size:'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 68
              Top = 18
              Width = 60
              Height = 21
              Hint = '????????,???????????'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox75: TGroupBox
            Left = 7
            Top = 68
            Width = 145
            Height = 49
            Caption = 'Magic Attack Mons Rate'
            TabOrder = 1
            object Label186: TLabel
              Left = 8
              Top = 21
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditMagicAttackMonsteRate: TSpinEdit
              Left = 68
              Top = 18
              Width = 60
              Height = 21
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMagicAttackMonsteRateChange
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Warrior Skills'
          ImageIndex = 1
          object PageControl2: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 237
            ActivePage = TabSheet4
            TabOrder = 0
            object TabSheet3: TTabSheet
              Caption = 'Fencing'
              object GroupBox9: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Fencing Setting'
                TabOrder = 0
                object CheckBoxLimitSwordLong: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = 
                    'Turn this feature on, it will check whether the check compartmen' +
                    'ts roles to prohibit Fencing.'
                  Caption = 'Fencing'
                  TabOrder = 0
                  OnClick = CheckBoxLimitSwordLongClick
                end
              end
              object GroupBox10: TGroupBox
                Left = 8
                Top = 56
                Width = 129
                Height = 41
                Caption = 'Power Rate'
                TabOrder = 1
                object Label4: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = 'Rate:'
                end
                object Label10: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSwordLongPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = 
                    'ATK multiples, digital size divided by 100 is the actual multipl' +
                    'es.'
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = '???'
              ImageIndex = 1
              object GroupBox56: TGroupBox
                Left = 159
                Top = 86
                Width = 138
                Height = 51
                Caption = '??????'
                TabOrder = 0
                Visible = False
                object Label119: TLabel
                  Left = 10
                  Top = 24
                  Width = 18
                  Height = 12
                  Caption = '??:'
                end
                object Label120: TLabel
                  Left = 114
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '?'
                end
                object SpinEditSkill39Sec: TSpinEdit
                  Left = 50
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkill39SecChange
                end
              end
              object GroupBox57: TGroupBox
                Left = 9
                Top = 65
                Width = 137
                Height = 46
                Caption = '??PK'
                TabOrder = 1
                object CheckBoxDedingAllowPK: TCheckBox
                  Left = 9
                  Top = 18
                  Width = 97
                  Height = 17
                  Caption = '??PK'
                  TabOrder = 0
                  OnClick = CheckBoxDedingAllowPKClick
                end
              end
              object GroupBox52: TGroupBox
                Left = 9
                Top = 9
                Width = 137
                Height = 50
                Caption = '????'
                TabOrder = 2
                object Label135: TLabel
                  Left = 10
                  Top = 24
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object SpinEditDidingPowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditDidingPowerRateChange
                end
              end
            end
            object TabSheet5: TTabSheet
              Caption = 'LionRoar'
              ImageIndex = 2
              object GroupBox48: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 59
                Caption = 'Paralysis Options'
                TabOrder = 0
                object CheckBoxGroupMbAttackPlayObject: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = 'Para Players'
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackPlayObjectClick
                end
                object CheckBoxGroupMbAttackSlave: TCheckBox
                  Left = 8
                  Top = 36
                  Width = 97
                  Height = 17
                  Caption = 'Para Slaves'
                  TabOrder = 1
                  OnClick = CheckBoxGroupMbAttackSlaveClick
                end
              end
            end
            object TabSheet6: TTabSheet
              Caption = '???'
              ImageIndex = 3
              object GroupBox50: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 65
                Caption = '???????'
                TabOrder = 0
                object CheckBoxPullPlayObject: TCheckBox
                  Left = 9
                  Top = 17
                  Width = 89
                  Height = 17
                  Caption = '?????'
                  TabOrder = 0
                  OnClick = CheckBoxPullPlayObjectClick
                end
                object CheckBoxPullCrossInSafeZone: TCheckBox
                  Left = 9
                  Top = 40
                  Width = 121
                  Height = 17
                  Caption = '????????'
                  TabOrder = 1
                  OnClick = CheckBoxPullCrossInSafeZoneClick
                end
              end
            end
            object ts1: TTabSheet
              Caption = 'Skill110'
              ImageIndex = 4
              object grp3: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl3: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill110PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill110PowerRateChange
                end
              end
            end
            object ts2: TTabSheet
              Caption = 'Skill111'
              ImageIndex = 5
              object grp4: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                Visible = False
                object lbl4: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill111PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill111PowerRateChange
                end
              end
            end
            object ts3: TTabSheet
              Caption = 'Skill112'
              ImageIndex = 6
              object grp5: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl5: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill112PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill112PowerRateChange
                end
              end
            end
            object ts4: TTabSheet
              Caption = 'Skill113'
              ImageIndex = 7
              object grp6: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl6: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill113PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill113PowerRateChange
                end
              end
            end
            object TabSheet24: TTabSheet
              Caption = 'Skill70'
              ImageIndex = 8
              object GroupBox59: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 195
                Caption = 'Skill Parameters'
                TabOrder = 0
                object Label142: TLabel
                  Left = 10
                  Top = 21
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object EditSkill70PowerRate: TSpinEdit
                  Left = 75
                  Top = 16
                  Width = 51
                  Height = 21
                  Hint = 
                    'The actual multiples equal to the current number is divided by 1' +
                    '00'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill70PowerRateChange
                end
                object CheckBoxSkill70MbAttackMon: TCheckBox
                  Left = 10
                  Top = 40
                  Width = 107
                  Height = 17
                  Caption = 'Attack Mon'
                  TabOrder = 1
                  OnClick = CheckBoxSkill70MbAttackMonClick
                end
                object CheckBoxSkill70MbAttackHuman: TCheckBox
                  Left = 10
                  Top = 57
                  Width = 107
                  Height = 17
                  Caption = 'Attack Human'
                  TabOrder = 2
                  OnClick = CheckBoxSkill70MbAttackHumanClick
                end
                object CheckBoxSkill70MbAttackSlave: TCheckBox
                  Left = 10
                  Top = 74
                  Width = 107
                  Height = 17
                  Caption = 'Attack Slave'
                  TabOrder = 3
                  OnClick = CheckBoxSkill70MbAttackSlaveClick
                end
                object CheckBoxSkill70MbFastParalysis: TCheckBox
                  Left = 10
                  Top = 91
                  Width = 107
                  Height = 17
                  Hint = 
                    'When the character or monster skills paralysis, is attacked imme' +
                    'diately cancel paralysis.'
                  Caption = 'Fast Paralysis'
                  TabOrder = 4
                  OnClick = CheckBoxSkill70MbFastParalysisClick
                end
                object CheckBoxSkill70RunGuard: TCheckBox
                  Left = 10
                  Top = 158
                  Width = 124
                  Height = 13
                  Hint = 
                    'Turn this feature on, the characters will be able to pass throug' +
                    'h the guards (machetes, archers,)'
                  Caption = 'Run Through Guard'
                  TabOrder = 5
                  OnClick = CheckBoxSkill70RunGuardClick
                end
                object CheckBoxSkill70RunNpc: TCheckBox
                  Left = 10
                  Top = 142
                  Width = 117
                  Height = 13
                  Hint = 
                    'Turn this feature on, the characters will be able to pass throug' +
                    'h the NPC'
                  Caption = 'Run Through NPC'
                  TabOrder = 6
                  OnClick = CheckBoxSkill70RunNpcClick
                end
                object CheckBoxSkill70RunMon: TCheckBox
                  Left = 10
                  Top = 126
                  Width = 117
                  Height = 13
                  Hint = 
                    'Turn this feature on, the characters will be able to pass throug' +
                    'h the monster'
                  Caption = 'Run Through Mon'
                  TabOrder = 7
                  OnClick = CheckBoxSkill70RunMonClick
                end
                object CheckBoxSkill70RunHum: TCheckBox
                  Left = 10
                  Top = 110
                  Width = 124
                  Height = 13
                  Hint = 
                    'Turn this feature on, the characters will be able to pass throug' +
                    'h other characters'
                  Caption = 'Run Through Hum'
                  TabOrder = 8
                  OnClick = CheckBoxSkill70RunHumClick
                end
                object CheckBoxSkill70WarDisHumRun: TCheckBox
                  Left = 10
                  Top = 174
                  Width = 119
                  Height = 13
                  Hint = 'Turn this feature completely banned in the siege area'
                  Caption = 'Disabled in War'
                  TabOrder = 9
                  OnClick = CheckBoxSkill70WarDisHumRunClick
                end
              end
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'Wizard Skills'
          ImageIndex = 2
          object PageControl3: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 236
            ActivePage = TabSheet17
            TabOrder = 0
            object TabSheet8: TTabSheet
              Caption = 'Taming'
              object GroupBox38: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Taming'
                TabOrder = 0
                object Label98: TLabel
                  Left = 8
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = 'Mag:'
                end
                object EditMagTammingLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = '??????????????,??????????????'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingLevelChange
                end
              end
              object GroupBox45: TGroupBox
                Left = 128
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Count'
                TabOrder = 1
                object Label111: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = 'Count:'
                end
                object EditTammingCount: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = '????????'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditTammingCountChange
                end
              end
              object GroupBox39: TGroupBox
                Left = 8
                Top = 56
                Width = 113
                Height = 73
                Caption = 'Target'
                TabOrder = 2
                object Label99: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = 'Level:'
                end
                object Label100: TLabel
                  Left = 8
                  Top = 44
                  Width = 48
                  Height = 12
                  Caption = 'HP Rate:'
                end
                object EditMagTammingTargetLevel: TSpinEdit
                  Left = 64
                  Top = 15
                  Width = 41
                  Height = 21
                  Hint = '??????,??????????'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingTargetLevelChange
                end
                object EditMagTammingHPRate: TSpinEdit
                  Left = 64
                  Top = 39
                  Width = 41
                  Height = 21
                  Hint = '??????,?????,?????'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditMagTammingHPRateChange
                end
              end
            end
            object TabSheet12: TTabSheet
              Caption = 'Fire Bang'
              ImageIndex = 4
              object GroupBox13: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Range'
                TabOrder = 0
                object Label7: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = 'Cells:'
                end
                object EditFireBoomRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = '?????????'
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditFireBoomRageChange
                end
              end
            end
            object TabSheet9: TTabSheet
              Caption = 'Fire Wall'
              ImageIndex = 1
              object GroupBox53: TGroupBox
                Left = 8
                Top = 55
                Width = 185
                Height = 74
                Caption = 'FireWall Skill Parameters'
                TabOrder = 0
                object Label117: TLabel
                  Left = 8
                  Top = 20
                  Width = 66
                  Height = 12
                  Caption = 'Delay Time:'
                end
                object Label116: TLabel
                  Left = 8
                  Top = 44
                  Width = 66
                  Height = 12
                  Caption = 'Fire Power:'
                end
                object SpinEditFireDelayTime: TSpinEdit
                  Left = 96
                  Top = 16
                  Width = 81
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditFireDelayTimeChange
                end
                object SpinEditFirePower: TSpinEdit
                  Left = 96
                  Top = 40
                  Width = 81
                  Height = 21
                  Hint = '????????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = SpinEditFirePowerChange
                end
              end
              object GroupBox46: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Safe Zone'
                TabOrder = 1
                object CheckBoxFireCrossInSafeZone: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = 'Turn this feature does not allow fire wall in the safe zone.'
                  Caption = 'Disable in SZ'
                  TabOrder = 0
                  OnClick = CheckBoxFireCrossInSafeZoneClick
                end
              end
              object GroupBox63: TGroupBox
                Left = 127
                Top = 8
                Width = 134
                Height = 41
                Caption = 'Chg Map Disappear FW'
                TabOrder = 2
                object CheckBoxFireChgMapExtinguish: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 108
                  Height = 17
                  Caption = 'Disappear FW'
                  TabOrder = 0
                  OnClick = CheckBoxFireChgMapExtinguishClick
                end
              end
              object grp2: TGroupBox
                Left = 199
                Top = 55
                Width = 143
                Height = 74
                Caption = 'Damage Time Rate'
                TabOrder = 3
                object lbl1: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = 'Char:'
                end
                object lbl2: TLabel
                  Left = 8
                  Top = 44
                  Width = 24
                  Height = 12
                  Caption = 'Mon:'
                end
                object seFirePlayDamageTimeRate: TSpinEdit
                  Left = 50
                  Top = 17
                  Width = 81
                  Height = 21
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seFirePlayDamageTimeRateChange
                end
                object seFireMonDamageTimeRate: TSpinEdit
                  Left = 50
                  Top = 41
                  Width = 81
                  Height = 21
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = seFireMonDamageTimeRateChange
                end
              end
            end
            object TabSheet11: TTabSheet
              Caption = 'Thunder Storm'
              ImageIndex = 3
              object GroupBox15: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Range'
                TabOrder = 0
                object Label9: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = 'Cells:'
                end
                object EditElecBlizzardRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = '?????????'
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditElecBlizzardRangeChange
                end
              end
            end
            object TabSheet10: TTabSheet
              Caption = 'Turn Undead'
              ImageIndex = 2
              object GroupBox37: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Turn Undead'
                TabOrder = 0
                object Label97: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = 'Level:'
                end
                object EditMagTurnUndeadLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = '??????????????,??????????????'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTurnUndeadLevelChange
                end
              end
            end
            object TabSheet13: TTabSheet
              Caption = 'Ice Storm'
              ImageIndex = 5
              object GroupBox14: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = 'Range'
                TabOrder = 0
                object Label8: TLabel
                  Left = 8
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = 'Cells:'
                end
                object EditSnowWindRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = '?????????'
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditSnowWindRangeChange
                end
              end
            end
            object TabSheet17: TTabSheet
              Caption = '???'
              ImageIndex = 7
              object GroupBox51: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = '?MP?'
                TabOrder = 0
                object CheckBoxPlayObjectReduceMP: TCheckBox
                  Left = 8
                  Top = 18
                  Width = 97
                  Height = 17
                  Caption = '???MP?'
                  TabOrder = 0
                  OnClick = CheckBoxPlayObjectReduceMPClick
                end
              end
            end
            object TabSheet36: TTabSheet
              Caption = 'Skill66'
              ImageIndex = 13
              object GroupBox70: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = 'Reduce MP'
                TabOrder = 0
                object CheckBoxSkill66ReduceMP: TCheckBox
                  Left = 8
                  Top = 18
                  Width = 97
                  Height = 17
                  Caption = 'Hit Reduce MP'
                  TabOrder = 0
                  OnClick = CheckBoxSkill66ReduceMPClick
                end
              end
            end
            object TabSheet27: TTabSheet
              Caption = 'Skill63'
              ImageIndex = 12
              object GroupBox64: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 102
                Caption = 'Skill Parameters'
                TabOrder = 0
                object CheckBoxSkill63RunGuard: TCheckBox
                  Left = 10
                  Top = 65
                  Width = 99
                  Height = 13
                  Hint = 
                    'Turn this feature on, the characters can overlap guards (sword, ' +
                    'archer)'
                  Caption = 'Run Guard'
                  TabOrder = 0
                  OnClick = CheckBoxSkill63RunGuardClick
                end
                object CheckBoxSkill63RunNpc: TCheckBox
                  Left = 10
                  Top = 49
                  Width = 99
                  Height = 13
                  Hint = 'Turn this feature on, the characters will overlap NPC'
                  Caption = 'Run NPC'
                  TabOrder = 1
                  OnClick = CheckBoxSkill63RunNpcClick
                end
                object CheckBoxSkill63RunMon: TCheckBox
                  Left = 10
                  Top = 33
                  Width = 99
                  Height = 13
                  Hint = 'Turn this feature on, the characters will overlap monster'
                  Caption = 'Run Mon'
                  TabOrder = 2
                  OnClick = CheckBoxSkill63RunMonClick
                end
                object CheckBoxSkill63RunHum: TCheckBox
                  Left = 10
                  Top = 17
                  Width = 98
                  Height = 13
                  Hint = 
                    'Turn this feature on, the characters will overlap other characte' +
                    'rs'
                  Caption = 'Run Hum'
                  TabOrder = 3
                  OnClick = CheckBoxSkill63RunHumClick
                end
                object CheckBoxSkill63WarDisHumRun: TCheckBox
                  Left = 10
                  Top = 81
                  Width = 119
                  Height = 13
                  Hint = 'Turn this feature completely Disabled in the siege area'
                  Caption = 'DisHumRun in War'
                  TabOrder = 4
                  OnClick = CheckBoxSkill63WarDisHumRunClick
                end
              end
            end
            object ts5: TTabSheet
              Caption = '???'
              ImageIndex = 7
              object grp7: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = '????'
                TabOrder = 0
                object lbl7: TLabel
                  Left = 10
                  Top = 24
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object seSkill114PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill114PowerRateChange
                end
              end
            end
            object ts6: TTabSheet
              Caption = '???'
              ImageIndex = 8
              object grp8: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = '????'
                TabOrder = 0
                object lbl8: TLabel
                  Left = 10
                  Top = 24
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object seSkill115PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill115PowerRateChange
                end
              end
            end
            object ts7: TTabSheet
              Caption = '???'
              ImageIndex = 9
              object grp9: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = '????'
                TabOrder = 0
                object lbl9: TLabel
                  Left = 10
                  Top = 24
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object seSkill116PowerRate: TSpinEdit
                  Left = 74
                  Top = 18
                  Width = 51
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill116PowerRateChange
                end
              end
            end
            object ts8: TTabSheet
              Caption = '????'
              ImageIndex = 10
              object grp10: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = '????'
                TabOrder = 0
                object lbl10: TLabel
                  Left = 10
                  Top = 24
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object seSkill117PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill117PowerRateChange
                end
              end
            end
            object TabSheet25: TTabSheet
              Caption = 'Skill71'
              ImageIndex = 11
              object GroupBox60: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 133
                Caption = 'Skill Parameters'
                TabOrder = 0
                object Label143: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object EditSkill71PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = '????????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill71PowerRateChange
                end
                object CheckBoxSkill71MbAttackMon: TCheckBox
                  Left = 10
                  Top = 46
                  Width = 107
                  Height = 17
                  Caption = 'Attack Mon'
                  TabOrder = 1
                  OnClick = CheckBoxSkill71MbAttackMonClick
                end
                object CheckBoxSkill71MbAttackHuman: TCheckBox
                  Left = 10
                  Top = 66
                  Width = 107
                  Height = 17
                  Caption = 'Attack Human'
                  TabOrder = 2
                  OnClick = CheckBoxSkill71MbAttackHumanClick
                end
                object CheckBoxSkill71MbAttackSlave: TCheckBox
                  Left = 10
                  Top = 87
                  Width = 107
                  Height = 17
                  Caption = 'Attack Slave'
                  TabOrder = 3
                  OnClick = CheckBoxSkill71MbAttackSlaveClick
                end
                object CheckBoxSkill71MbFastParalysis: TCheckBox
                  Left = 10
                  Top = 107
                  Width = 107
                  Height = 17
                  Hint = 
                    'When the character or monster skills paralysis, is attacked imme' +
                    'diately cancel paralysis.'
                  Caption = 'Fast Paralysis'
                  TabOrder = 4
                  OnClick = CheckBoxSkill71MbFastParalysisClick
                end
              end
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = 'Taoist Skills'
          ImageIndex = 3
          object PageControl4: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 236
            ActivePage = TabSheet26
            TabOrder = 0
            object TabSheet16: TTabSheet
              Caption = 'Poisoning'
              object GroupBox16: TGroupBox
                Left = 8
                Top = 8
                Width = 137
                Height = 49
                Caption = 'Poison'
                TabOrder = 0
                object Label11: TLabel
                  Left = 8
                  Top = 18
                  Width = 42
                  Height = 12
                  Caption = 'Points:'
                end
                object EditAmyOunsulPoint: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = '???????????,??????????????????,????????????,?????,?????'
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAmyOunsulPointChange
                end
              end
            end
            object TabSheet18: TTabSheet
              Caption = 'BoneFamm'
              ImageIndex = 1
              object GroupBox5: TGroupBox
                Left = 5
                Top = 2
                Width = 124
                Height = 204
                Caption = 'Setting'
                TabOrder = 0
                object Label2: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = 'Name:'
                end
                object Label3: TLabel
                  Left = 8
                  Top = 58
                  Width = 36
                  Height = 12
                  Caption = 'Count:'
                end
                object EditBoneFammName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = 'Set the name of the default summon monsters.'
                  TabOrder = 0
                  OnChange = EditBoneFammNameChange
                end
                object EditBoneFammCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = 'the maximum number.'
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditBoneFammCountChange
                end
              end
              object GroupBox6: TGroupBox
                Left = 135
                Top = 2
                Width = 284
                Height = 204
                Caption = 'List'
                TabOrder = 1
                object GridBoneFamm: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 177
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet19: TTabSheet
              Caption = 'Shinsu'
              ImageIndex = 2
              object GroupBox11: TGroupBox
                Left = 5
                Top = 2
                Width = 124
                Height = 204
                Caption = 'Setting'
                TabOrder = 0
                object Label5: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = 'Name:'
                end
                object Label6: TLabel
                  Left = 8
                  Top = 58
                  Width = 36
                  Height = 12
                  Caption = 'Count:'
                end
                object EditDogzName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = 'Set the name of the default summon monsters.'
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditDogzCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = 'The maximum number.'
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDogzCountChange
                end
              end
              object GroupBox12: TGroupBox
                Left = 135
                Top = 2
                Width = 284
                Height = 204
                Caption = 'List'
                TabOrder = 1
                object GridDogz: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 179
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet31: TTabSheet
              Caption = '????'
              ImageIndex = 9
              object GroupBox67: TGroupBox
                Left = 5
                Top = 2
                Width = 124
                Height = 204
                Caption = 'Setting'
                TabOrder = 0
                object Label161: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = 'Name:'
                end
                object Label162: TLabel
                  Left = 8
                  Top = 58
                  Width = 36
                  Height = 12
                  Caption = 'Count:'
                end
                object EditMoonSpiritName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = 'Set the name of the default summon monsters.'
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditMoonSpiritCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = 'The maximum number'
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMoonSpiritCountChange
                end
              end
              object GroupBox68: TGroupBox
                Left = 135
                Top = 2
                Width = 284
                Height = 204
                Caption = 'List'
                TabOrder = 1
                object GridMoonSpirit: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 179
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet20: TTabSheet
              Caption = 'Para Ball'
              ImageIndex = 3
              object GroupBox41: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 73
                Caption = 'Setting'
                TabOrder = 0
                object Label101: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = 'Hit Rate:'
                end
                object Label102: TLabel
                  Left = 8
                  Top = 42
                  Width = 66
                  Height = 12
                  Caption = 'MinLvLimit:'
                end
                object EditMabMabeHitRandRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = 
                    'Attack attack both sides difference between the level of chance ' +
                    'to hit, the greater the probability of the smaller digital.'
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitRandRateChange
                end
                object EditMabMabeHitMinLvLimit: TSpinEdit
                  Left = 68
                  Top = 39
                  Width = 53
                  Height = 21
                  Hint = 
                    'Attack attack Level chance to hit difference between the two sid' +
                    'es, the minimum limit, the lower the number the lower rates.'
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMabMabeHitMinLvLimitChange
                end
              end
              object GroupBox43: TGroupBox
                Left = 160
                Top = 8
                Width = 145
                Height = 49
                Caption = 'Paralysis Time Rate'
                TabOrder = 1
                object Label104: TLabel
                  Left = 8
                  Top = 18
                  Width = 60
                  Height = 12
                  Caption = 'Time Rate:'
                end
                object EditMabMabeHitMabeTimeRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = 
                    'Paralysis of the length of time magnification, the cardinality o' +
                    'f the role of magic.'
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitMabeTimeRateChange
                end
              end
              object GroupBox42: TGroupBox
                Left = 8
                Top = 88
                Width = 145
                Height = 49
                Caption = 'Hit Success Rate'
                TabOrder = 2
                object Label103: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = 'Rate:'
                end
                object EditMabMabeHitSucessRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = 
                    'Likely to attack paralysis, the minimum limit, the lower the num' +
                    'ber the lower rates.'
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitSucessRateChange
                end
              end
            end
            object TabSheet32: TTabSheet
              Caption = '???'
              ImageIndex = 10
            end
            object ts9: TTabSheet
              Caption = 'Skill118'
              ImageIndex = 4
              object grp11: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl11: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill118PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill118PowerRateChange
                end
              end
            end
            object ts10: TTabSheet
              Caption = 'Skill119'
              ImageIndex = 5
              object grp12: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl12: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill119PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill119PowerRateChange
                end
              end
            end
            object ts11: TTabSheet
              Caption = 'Skill120'
              ImageIndex = 6
              object grp13: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl13: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill120PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill120PowerRateChange
                end
              end
            end
            object ts12: TTabSheet
              Caption = 'Skill121'
              ImageIndex = 7
              object grp14: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 50
                Caption = 'Skill Parameters'
                TabOrder = 0
                object lbl14: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object seSkill121PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = 'Actual multiples equal to the current number of 100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = seSkill121PowerRateChange
                end
              end
            end
            object TabSheet26: TTabSheet
              Caption = 'Skill72'
              ImageIndex = 8
              object GroupBox61: TGroupBox
                Left = 10
                Top = 9
                Width = 137
                Height = 174
                Caption = 'Skill Parameters'
                TabOrder = 0
                object Label144: TLabel
                  Left = 10
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = 'Power Rate:'
                end
                object EditSkill72PowerRate: TSpinEdit
                  Left = 75
                  Top = 19
                  Width = 51
                  Height = 21
                  Hint = '????????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                end
                object CheckBoxSkill72MbAttackMon: TCheckBox
                  Left = 10
                  Top = 46
                  Width = 107
                  Height = 17
                  Caption = 'Attack Mon'
                  TabOrder = 1
                end
                object CheckBoxSkill72MbAttackHuman: TCheckBox
                  Left = 10
                  Top = 66
                  Width = 107
                  Height = 17
                  Caption = 'Attack Human'
                  TabOrder = 2
                end
                object CheckBoxSkill72MbAttackSlave: TCheckBox
                  Left = 10
                  Top = 87
                  Width = 107
                  Height = 17
                  Caption = 'Attack Slave'
                  TabOrder = 3
                end
                object CheckBoxSkill72Damagearmor: TCheckBox
                  Left = 10
                  Top = 107
                  Width = 107
                  Height = 17
                  Caption = 'Red Poison'
                  TabOrder = 4
                end
                object CheckBoxSkill72DecHealth: TCheckBox
                  Left = 10
                  Top = 127
                  Width = 107
                  Height = 17
                  Caption = 'Green Poison'
                  TabOrder = 5
                end
                object CheckBoxSkill72MbFastParalysis: TCheckBox
                  Left = 10
                  Top = 150
                  Width = 107
                  Height = 17
                  Hint = 
                    'When the character or monster skills paralysis, is attacked imme' +
                    'diately cancel paralysis.'
                  Caption = 'Fast Paralysis'
                  TabOrder = 6
                end
              end
            end
          end
        end
        object TabSheet28: TTabSheet
          Caption = 'Generic Skills'
          ImageIndex = 4
          object PageControl1: TPageControl
            Left = 3
            Top = 3
            Width = 432
            Height = 236
            ActivePage = TabSheet30
            TabOrder = 0
            object TabSheet29: TTabSheet
              Caption = '????'
              object GroupBox69: TGroupBox
                Left = 8
                Top = 8
                Width = 319
                Height = 130
                Caption = '????'
                TabOrder = 0
                object Label163: TLabel
                  Left = 8
                  Top = 21
                  Width = 72
                  Height = 12
                  Caption = '????0??????:'
                end
                object Label164: TLabel
                  Left = 190
                  Top = 21
                  Width = 36
                  Height = 12
                  Caption = '% ????'
                end
                object Label165: TLabel
                  Left = 303
                  Top = 21
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label166: TLabel
                  Left = 8
                  Top = 48
                  Width = 72
                  Height = 12
                  Caption = '????1??????:'
                end
                object Label167: TLabel
                  Left = 190
                  Top = 48
                  Width = 36
                  Height = 12
                  Caption = '% ????'
                end
                object Label168: TLabel
                  Left = 303
                  Top = 48
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label169: TLabel
                  Left = 8
                  Top = 75
                  Width = 72
                  Height = 12
                  Caption = '????2??????:'
                end
                object Label170: TLabel
                  Left = 190
                  Top = 75
                  Width = 36
                  Height = 12
                  Caption = '% ????'
                end
                object Label171: TLabel
                  Left = 303
                  Top = 75
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object Label172: TLabel
                  Left = 8
                  Top = 102
                  Width = 72
                  Height = 12
                  Caption = '????3??????:'
                end
                object Label173: TLabel
                  Left = 190
                  Top = 102
                  Width = 36
                  Height = 12
                  Caption = '% ????'
                end
                object Label174: TLabel
                  Left = 303
                  Top = 102
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object EditProtectShieldRunRate0: TSpinEdit
                  Left = 143
                  Top = 18
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditProtectShieldRunRate0Change
                end
                object EditProtectShieldDelDamage0: TSpinEdit
                  Left = 256
                  Top = 18
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = EditProtectShieldDelDamage0Change
                end
                object EditProtectShieldRunRate1: TSpinEdit
                  Left = 143
                  Top = 45
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 2
                  Value = 100
                  OnChange = EditProtectShieldRunRate1Change
                end
                object EditProtectShieldDelDamage1: TSpinEdit
                  Left = 256
                  Top = 45
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 3
                  Value = 100
                  OnChange = EditProtectShieldDelDamage1Change
                end
                object EditProtectShieldRunRate2: TSpinEdit
                  Left = 143
                  Top = 72
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 4
                  Value = 100
                  OnChange = EditProtectShieldRunRate2Change
                end
                object EditProtectShieldDelDamage2: TSpinEdit
                  Left = 256
                  Top = 72
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 5
                  Value = 100
                  OnChange = EditProtectShieldDelDamage2Change
                end
                object EditProtectShieldRunRate3: TSpinEdit
                  Left = 143
                  Top = 99
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 6
                  Value = 100
                  OnChange = EditProtectShieldRunRate3Change
                end
                object EditProtectShieldDelDamage3: TSpinEdit
                  Left = 256
                  Top = 99
                  Width = 41
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 7
                  Value = 100
                  OnChange = EditProtectShieldDelDamage3Change
                end
              end
            end
            object TabSheet30: TTabSheet
              Caption = '????'
              ImageIndex = 1
              object GroupBox65: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 49
                Caption = '????'
                TabOrder = 0
                object Label145: TLabel
                  Left = 8
                  Top = 21
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object EditEtenMagicSize: TSpinEdit
                  Left = 68
                  Top = 18
                  Width = 53
                  Height = 21
                  Hint = '????????,???????????'
                  EditorEnabled = False
                  MaxValue = 10
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditEtenMagicSizeChange
                end
              end
              object GroupBox66: TGroupBox
                Left = 8
                Top = 64
                Width = 145
                Height = 50
                Caption = '????'
                TabOrder = 1
                object Label146: TLabel
                  Left = 8
                  Top = 24
                  Width = 30
                  Height = 12
                  Caption = '????:'
                end
                object EditEtenPowerRate: TSpinEdit
                  Left = 68
                  Top = 21
                  Width = 53
                  Height = 21
                  Hint = '???????????100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditEtenPowerRateChange
                end
              end
            end
          end
        end
      end
    end
    object TabSheet34: TTabSheet
      Caption = 'Weap Upg'
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 121
        Caption = 'Upgrade'
        TabOrder = 0
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 66
          Height = 12
          Caption = 'Max Points:'
        end
        object Label15: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = 'Cost:'
        end
        object Label16: TLabel
          Left = 8
          Top = 66
          Width = 30
          Height = 12
          Caption = 'Time:'
        end
        object Label17: TLabel
          Left = 8
          Top = 90
          Width = 36
          Height = 12
          Caption = 'Expir:'
        end
        object Label18: TLabel
          Left = 136
          Top = 65
          Width = 18
          Height = 12
          Caption = 'Sec'
        end
        object Label19: TLabel
          Left = 136
          Top = 89
          Width = 18
          Height = 12
          Caption = 'Day'
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 68
          Top = 15
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 68
          Top = 39
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 68
          Top = 63
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 68
          Top = 87
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 176
        Top = 8
        Width = 265
        Height = 89
        Caption = 'DC Rate'
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = 'DC 1:'
        end
        object Label21: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = 'DC 2:'
        end
        object Label22: TLabel
          Left = 8
          Top = 66
          Width = 30
          Height = 12
          Caption = 'DC 3:'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = '???????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = '????????,????????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = '????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox19: TGroupBox
        Left = 176
        Top = 104
        Width = 265
        Height = 97
        Caption = 'SC Rate'
        TabOrder = 2
        object Label23: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = 'SC 1:'
        end
        object Label24: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = 'SC 2:'
        end
        object Label25: TLabel
          Left = 8
          Top = 66
          Width = 30
          Height = 12
          Caption = 'SC 3:'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = '??????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = '????????,????????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = '????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox20: TGroupBox
        Left = 176
        Top = 208
        Width = 265
        Height = 89
        Caption = 'MC Rate'
        TabOrder = 3
        object Label26: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = 'MC 1:'
        end
        object Label27: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = 'MC 2:'
        end
        object Label28: TLabel
          Left = 8
          Top = 66
          Width = 30
          Height = 12
          Caption = 'MC 3:'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = '??????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = '????????,????????'
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = '????????,????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonUpgradeWeaponSave: TButton
        Left = 8
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Save'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 80
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Default'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
    end
    object TabSheet35: TTabSheet
      Caption = 'Mine'
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 60
        Caption = 'Ore Rates'
        TabOrder = 0
        object Label32: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = 'Hit Rate:'
        end
        object Label33: TLabel
          Left = 8
          Top = 36
          Width = 60
          Height = 12
          Caption = 'Mine Rate:'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 73
          Top = 15
          Width = 129
          Height = 15
          Hint = '????????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = '????????????'
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 8
        Top = 72
        Width = 273
        Height = 217
        Caption = 'Probability Of Ore Types'
        TabOrder = 1
        object Label34: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = 'Copper:'
        end
        object Label35: TLabel
          Left = 8
          Top = 38
          Width = 30
          Height = 12
          Caption = 'Gold:'
        end
        object Label36: TLabel
          Left = 8
          Top = 56
          Width = 42
          Height = 12
          Caption = 'Silver:'
        end
        object Label37: TLabel
          Left = 8
          Top = 76
          Width = 30
          Height = 12
          Caption = 'Iron:'
        end
        object Label38: TLabel
          Left = 8
          Top = 96
          Width = 66
          Height = 12
          Caption = 'Black Iron:'
          Visible = False
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
          Visible = False
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 9
          Visible = False
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Save'
        TabOrder = 2
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 288
        Top = 8
        Width = 153
        Height = 121
        Caption = 'Ore quality (Dura)'
        TabOrder = 3
        object Label39: TLabel
          Left = 8
          Top = 18
          Width = 48
          Height = 12
          Caption = 'Minimum:'
        end
        object Label40: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = 'General:'
        end
        object Label41: TLabel
          Left = 8
          Top = 66
          Width = 36
          Height = 12
          Caption = 'Added:'
        end
        object Label42: TLabel
          Left = 8
          Top = 90
          Width = 60
          Height = 12
          Caption = 'Max Added:'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 92
          Top = 15
          Width = 45
          Height = 21
          Hint = '???????????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 92
          Top = 39
          Width = 45
          Height = 21
          Hint = '?????????????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 92
          Top = 63
          Width = 45
          Height = 21
          Hint = '???????????,????????20???????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 92
          Top = 87
          Width = 45
          Height = 21
          Hint = '????????????????'
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Default'
        TabOrder = 4
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = 'WLuck'
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 143
        Caption = 'Weapon Luck'
        TabOrder = 0
        object Label105: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = 'UnLuck:'
        end
        object Label106: TLabel
          Left = 8
          Top = 38
          Width = 42
          Height = 12
          Caption = 'Luck 1:'
        end
        object Label107: TLabel
          Left = 8
          Top = 56
          Width = 42
          Height = 12
          Caption = 'Luck 2:'
        end
        object Label108: TLabel
          Left = 8
          Top = 76
          Width = 72
          Height = 12
          Caption = 'Luck 2 Rate:'
        end
        object Label109: TLabel
          Left = 8
          Top = 96
          Width = 42
          Height = 12
          Caption = 'Luck 3:'
        end
        object Label110: TLabel
          Left = 8
          Top = 116
          Width = 72
          Height = 12
          Caption = 'Luck 3 Rate:'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = '?????????,?????????'
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = '???????????????????100% ???'
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Hint = '????????????????????????????????'
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Hint = '????,?????????'
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Hint = '????????????????????????????????'
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 72
          Top = 116
          Width = 129
          Height = 15
          Hint = '????,?????????'
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 208
          Top = 116
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Default'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Save'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
      object GroupBox58: TGroupBox
        Left = 287
        Top = 7
        Width = 138
        Height = 55
        Caption = 'Unluck Max'
        TabOrder = 3
        object Label141: TLabel
          Left = 12
          Top = 22
          Width = 60
          Height = 12
          Caption = 'Max Count:'
        end
        object EditUnLuckMaxCount: TSpinEdit
          Left = 73
          Top = 19
          Width = 49
          Height = 21
          Hint = '?????????????100%??????,??? 7'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = EditUnLuckMaxCountChange
        end
      end
    end
    object TabSheet37: TTabSheet
      Caption = 'Lottery'
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 169
        Caption = 'Winning Chances'
        TabOrder = 0
        object Label43: TLabel
          Left = 8
          Top = 42
          Width = 24
          Height = 12
          Caption = '1st:'
        end
        object Label44: TLabel
          Left = 8
          Top = 62
          Width = 24
          Height = 12
          Caption = '2nd:'
        end
        object Label45: TLabel
          Left = 8
          Top = 80
          Width = 24
          Height = 12
          Caption = '3rd:'
        end
        object Label46: TLabel
          Left = 8
          Top = 100
          Width = 24
          Height = 12
          Caption = '4th:'
        end
        object Label47: TLabel
          Left = 8
          Top = 120
          Width = 24
          Height = 12
          Caption = '5th:'
        end
        object Label48: TLabel
          Left = 8
          Top = 140
          Width = 24
          Height = 12
          Caption = '6th:'
        end
        object Label49: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = 'Win Rate:'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 56
          Top = 40
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 192
          Top = 40
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 56
          Top = 60
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 192
          Top = 60
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 56
          Top = 80
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 192
          Top = 80
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 56
          Top = 100
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 192
          Top = 100
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWinLottery5Max: TEdit
          Left = 192
          Top = 120
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 56
          Top = 120
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 56
          Top = 140
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 192
          Top = 140
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object EditWinLotteryRate: TEdit
          Left = 192
          Top = 16
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 56
          Top = 16
          Width = 129
          Height = 15
          Max = 100000
          PageSize = 0
          TabOrder = 13
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 288
        Top = 8
        Width = 145
        Height = 169
        Caption = 'Prize'
        TabOrder = 1
        object Label50: TLabel
          Left = 8
          Top = 18
          Width = 24
          Height = 12
          Caption = '1st:'
        end
        object Label51: TLabel
          Left = 8
          Top = 42
          Width = 24
          Height = 12
          Caption = '2nd:'
        end
        object Label52: TLabel
          Left = 8
          Top = 66
          Width = 24
          Height = 12
          Caption = '3rd:'
        end
        object Label53: TLabel
          Left = 8
          Top = 90
          Width = 24
          Height = 12
          Caption = '4th:'
        end
        object Label54: TLabel
          Left = 8
          Top = 114
          Width = 24
          Height = 12
          Caption = '5th:'
        end
        object Label55: TLabel
          Left = 8
          Top = 138
          Width = 24
          Height = 12
          Caption = '6th:'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 56
          Top = 15
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 56
          Top = 39
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 56
          Top = 63
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 56
          Top = 87
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 56
          Top = 111
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 56
          Top = 135
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Save'
        ModalResult = 1
        TabOrder = 2
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = '&Default'
        TabOrder = 3
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = 'Spirit'
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 8
        Top = 9
        Width = 137
        Height = 89
        Caption = 'Spirit'
        TabOrder = 0
        object Label94: TLabel
          Left = 11
          Top = 40
          Width = 30
          Height = 12
          Caption = 'Time:'
        end
        object Label96: TLabel
          Left = 11
          Top = 64
          Width = 66
          Height = 12
          Caption = 'Power Rate:'
          Enabled = False
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = 'Spirit Mutiny'
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
        object EditSpiritPowerRate: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditSpiritPowerRateChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet14: TTabSheet
      Caption = 'Make Magic'
      ImageIndex = 10
      object ButtonMakeMagicSave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 0
        OnClick = ButtonMakeMagicSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 183
        Top = 6
        Width = 148
        Height = 158
        Caption = 'Basic Parameters'
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 22
          Width = 60
          Height = 12
          Caption = 'Add Point:'
        end
        object Label113: TLabel
          Left = 12
          Top = 49
          Width = 60
          Height = 12
          Caption = 'Use Point:'
        end
        object Label114: TLabel
          Left = 12
          Top = 76
          Width = 54
          Height = 12
          Caption = 'Add Rate:'
        end
        object Label115: TLabel
          Left = 12
          Top = 103
          Width = 60
          Height = 12
          Caption = 'Max Level:'
        end
        object lbl15: TLabel
          Left = 12
          Top = 129
          Width = 66
          Height = 12
          Caption = 'MaxBeginLv:'
        end
        object EditMakeMagicAddPoint: TSpinEdit
          Left = 73
          Top = 19
          Width = 49
          Height = 21
          Hint = '?????????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMakeMagicAddPointChange
        end
        object EditMakeMagicUsePoint: TSpinEdit
          Left = 73
          Top = 46
          Width = 49
          Height = 21
          Hint = '???????????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMakeMagicUsePointChange
        end
        object EditMakeMagicAddRate: TSpinEdit
          Left = 72
          Top = 73
          Width = 49
          Height = 21
          Hint = '??????????????????????? = ???? / ???? '
          EditorEnabled = False
          MaxValue = 200
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMakeMagicAddRateChange
        end
        object EditMakeMagicMaxLevel: TSpinEdit
          Left = 73
          Top = 100
          Width = 49
          Height = 21
          Hint = '???????????????'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMakeMagicMaxLevelChange
        end
        object seEditMakeMagicMaxBeginLevel: TSpinEdit
          Left = 73
          Top = 126
          Width = 49
          Height = 21
          Hint = '????????????,???????????'
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = seEditMakeMagicMaxBeginLevelChange
        end
      end
      object grp15: TGroupBox
        Left = 8
        Top = 6
        Width = 169
        Height = 283
        Caption = 'Level Control'
        TabOrder = 2
        object GridMakeMagic: TStringGrid
          Left = 10
          Top = 42
          Width = 149
          Height = 234
          ColCount = 2
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 12
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
          TabOrder = 0
          OnSetEditText = GridMakeMagicSetEditText
          ColWidths = (
            72
            71)
        end
        object ComboBoxMakeMagicType: TComboBox
          Left = 10
          Top = 17
          Width = 149
          Height = 20
          Style = csDropDownList
          ItemHeight = 0
          ItemIndex = 0
          TabOrder = 1
          Text = '????'
          OnChange = ComboBoxMakeMagicTypeChange
          Items.Strings = (
            '????'
            '????'
            '????'
            '????'
            '????'
            '????'
            '????'
            '????'
            '????'
            '????')
        end
      end
    end
    object TabSheet21: TTabSheet
      Caption = 'Attribute'
      ImageIndex = 11
      object GroupBox2: TGroupBox
        Left = 8
        Top = 6
        Width = 148
        Height = 83
        Caption = 'Basic Parameters'
        TabOrder = 0
        object Label118: TLabel
          Left = 12
          Top = 22
          Width = 60
          Height = 12
          Caption = 'Add Point:'
        end
        object Label124: TLabel
          Left = 12
          Top = 49
          Width = 72
          Height = 12
          Caption = 'Begin Level:'
        end
        object EditNakedAddPoint: TSpinEdit
          Left = 73
          Top = 19
          Width = 49
          Height = 21
          Hint = '????????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditNakedAddPointChange
        end
        object EditNakedBeginLevel: TSpinEdit
          Left = 73
          Top = 46
          Width = 49
          Height = 21
          Hint = '????????????,?????????????'
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditNakedBeginLevelChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 95
        Width = 313
        Height = 186
        Caption = '??????'
        TabOrder = 1
        object Label121: TLabel
          Left = 12
          Top = 22
          Width = 24
          Height = 12
          Caption = '??->'
        end
        object Label122: TLabel
          Left = 53
          Top = 22
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label123: TLabel
          Left = 165
          Top = 22
          Width = 42
          Height = 12
          Caption = '??????:'
        end
        object Label125: TLabel
          Left = 12
          Top = 49
          Width = 24
          Height = 12
          Caption = '??->'
        end
        object Label126: TLabel
          Left = 53
          Top = 49
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label127: TLabel
          Left = 165
          Top = 49
          Width = 42
          Height = 12
          Caption = '??????:'
        end
        object Label128: TLabel
          Left = 12
          Top = 76
          Width = 24
          Height = 12
          Caption = '??->'
        end
        object Label129: TLabel
          Left = 53
          Top = 76
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label130: TLabel
          Left = 165
          Top = 76
          Width = 42
          Height = 12
          Caption = '??????:'
        end
        object Label131: TLabel
          Left = 12
          Top = 103
          Width = 24
          Height = 12
          Caption = '??->'
        end
        object Label132: TLabel
          Left = 53
          Top = 103
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label133: TLabel
          Left = 165
          Top = 103
          Width = 42
          Height = 12
          Caption = '??????:'
        end
        object Label134: TLabel
          Left = 12
          Top = 130
          Width = 24
          Height = 12
          Caption = '??->'
        end
        object Label136: TLabel
          Left = 53
          Top = 130
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label137: TLabel
          Left = 165
          Top = 130
          Width = 42
          Height = 12
          Caption = '??????:'
        end
        object Label138: TLabel
          Left = 12
          Top = 157
          Width = 24
          Height = 12
          Caption = '??->'
        end
        object Label139: TLabel
          Left = 53
          Top = 157
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object EditNakedAc2Point: TSpinEdit
          Left = 113
          Top = 19
          Width = 49
          Height = 21
          Hint = '???????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditNakedAc2PointChange
        end
        object EditNakedAcPoint: TSpinEdit
          Left = 249
          Top = 19
          Width = 49
          Height = 21
          Hint = '??????????,?????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditNakedAcPointChange
        end
        object EditNakedMac2Point: TSpinEdit
          Left = 113
          Top = 46
          Width = 49
          Height = 21
          Hint = '???????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditNakedMac2PointChange
        end
        object EditNakedMacPoint: TSpinEdit
          Left = 249
          Top = 46
          Width = 49
          Height = 21
          Hint = '??????????,?????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditNakedMacPointChange
        end
        object EditNakedDc2Point: TSpinEdit
          Left = 113
          Top = 73
          Width = 49
          Height = 21
          Hint = '???????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditNakedDc2PointChange
        end
        object EditNakedDcPoint: TSpinEdit
          Left = 249
          Top = 73
          Width = 49
          Height = 21
          Hint = '??????????,?????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditNakedDcPointChange
        end
        object EditNakedMC2Point: TSpinEdit
          Left = 113
          Top = 100
          Width = 49
          Height = 21
          Hint = '???????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditNakedMC2PointChange
        end
        object EditNakedMCPoint: TSpinEdit
          Left = 249
          Top = 100
          Width = 49
          Height = 21
          Hint = '??????????,?????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditNakedMCPointChange
        end
        object EditNakedSC2Point: TSpinEdit
          Left = 113
          Top = 127
          Width = 49
          Height = 21
          Hint = '???????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditNakedSC2PointChange
        end
        object EditNakedSCPoint: TSpinEdit
          Left = 249
          Top = 127
          Width = 49
          Height = 21
          Hint = '??????????,?????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditNakedSCPointChange
        end
        object EditNakedHPPoint: TSpinEdit
          Left = 113
          Top = 154
          Width = 49
          Height = 21
          Hint = '????????????????'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 10
          Value = 100
          OnChange = EditNakedHPPointChange
        end
      end
      object ButtonNakedSave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 2
        OnClick = ButtonNakedSaveClick
      end
    end
    object TabSheet22: TTabSheet
      Caption = 'Literary'
      ImageIndex = 12
      object GroupBox4: TGroupBox
        Left = 8
        Top = 6
        Width = 185
        Height = 283
        Caption = 'EXP Control'
        TabOrder = 0
        object GridLiterary: TStringGrid
          Left = 15
          Top = 22
          Width = 167
          Height = 258
          Hint = 'Experience multiple times 100 = 1'
          ColCount = 2
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 31
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
          TabOrder = 0
          OnSetEditText = GridLiterarySetEditText
          ColWidths = (
            72
            71)
        end
      end
      object ButtonLiterarySave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonLiterarySaveClick
      end
    end
    object TabSheet23: TTabSheet
      Caption = 'Options'
      ImageIndex = 13
      object GroupBox40: TGroupBox
        Left = 10
        Top = 6
        Width = 207
        Height = 114
        Caption = 'Client Setting'
        TabOrder = 0
        object CheckBoxShowStrengthenInfo: TCheckBox
          Left = 13
          Top = 19
          Width = 168
          Height = 17
          Caption = 'Show Strengthen Info'
          TabOrder = 0
          OnClick = CheckBoxShowStrengthenInfoClick
        end
        object CheckBoxShowCBOForm: TCheckBox
          Left = 13
          Top = 41
          Width = 168
          Height = 17
          Caption = 'Show combo skills panel'
          TabOrder = 1
          OnClick = CheckBoxShowCBOFormClick
        end
        object CheckBoxShowMakeMagicForm: TCheckBox
          Left = 13
          Top = 64
          Width = 149
          Height = 17
          Caption = 'Show Make Magic Panel'
          TabOrder = 2
          OnClick = CheckBoxShowMakeMagicFormClick
        end
        object CheckBoxCancelDropItemHint: TCheckBox
          Left = 13
          Top = 88
          Width = 149
          Height = 17
          Hint = 
            'Selected, the the customers throw items will no longer pop-up co' +
            'nfirmation window.'
          Caption = 'Cancel Drop Item Hint'
          TabOrder = 3
          OnClick = CheckBoxCancelDropItemHintClick
        end
      end
      object ButtonFunSave: TButton
        Left = 363
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonFunSaveClick
      end
      object GroupBox49: TGroupBox
        Left = 223
        Top = 6
        Width = 218
        Height = 92
        Caption = 'M2 Setting'
        TabOrder = 2
        object CheckBoxExpIsCumulative: TCheckBox
          Left = 13
          Top = 19
          Width = 150
          Height = 17
          Hint = 'Double time experience, whether cumulative'
          Caption = '??????????'
          TabOrder = 0
          OnClick = CheckBoxExpIsCumulativeClick
        end
        object CheckBoxExpOffLienSave: TCheckBox
          Left = 13
          Top = 41
          Width = 172
          Height = 17
          Hint = 'Double experience time off the assembly line you want to save'
          Caption = 'Exp Offline Save'
          TabOrder = 1
          OnClick = CheckBoxExpOffLienSaveClick
        end
        object CheckBoxExpOffLineRunTime: TCheckBox
          Left = 35
          Top = 64
          Width = 142
          Height = 17
          Hint = 'Save whether to continue the computation time'
          Caption = 'Exp Offline Run Time '
          TabOrder = 2
          OnClick = CheckBoxExpOffLineRunTimeClick
        end
      end
      object GroupBox54: TGroupBox
        Left = 10
        Top = 127
        Width = 207
        Height = 74
        Caption = 'Set to hang within the client'
        TabOrder = 3
        object CheckBoxWarLongWide: TCheckBox
          Left = 13
          Top = 19
          Width = 147
          Height = 17
          Hint = 'Whether to allow soldiers compartments assassinate'
          Caption = 'War Long Wide'
          TabOrder = 0
          OnClick = CheckBoxWarLongWideClick
        end
        object CheckBoxNotShiftKey: TCheckBox
          Left = 13
          Top = 41
          Width = 149
          Height = 17
          Hint = 
            'inked within selected Free Shift key, whether free Shift is alwa' +
            'ys in the open state, do not need to press the Shift key to swit' +
            'ch.'
          Caption = 'No Shift Key'
          TabOrder = 1
          OnClick = CheckBoxNotShiftKeyClick
        end
      end
    end
    object TabSheet41: TTabSheet
      Caption = 'Horse'
      ImageIndex = 14
      object GroupBox71: TGroupBox
        Left = 10
        Top = 6
        Width = 199
        Height = 75
        Caption = 'Horse Options'
        TabOrder = 0
        object Label175: TLabel
          Left = 12
          Top = 45
          Width = 84
          Height = 12
          Caption = 'Gain Exp Rate:'
        end
        object Label180: TLabel
          Left = 151
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object CheckBoxAllow32HorseGetExp: TCheckBox
          Left = 13
          Top = 19
          Width = 180
          Height = 17
          Hint = 
            'Recommended that you turn this otherwise ordinary horse will not' +
            ' be able to upgrade to gain experience.'
          Caption = 'allow non-riding experience'
          TabOrder = 0
          OnClick = CheckBoxAllow32HorseGetExpClick
        end
        object Edit32HorseGetExpRate: TSpinEdit
          Left = 96
          Top = 42
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 1
          Value = 20
          OnChange = Edit32HorseGetExpRateChange
        end
      end
      object ButtonSaveHorse: TButton
        Left = 365
        Top = 261
        Width = 65
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonSaveHorseClick
      end
      object GroupBox72: TGroupBox
        Left = 10
        Top = 87
        Width = 199
        Height = 98
        Caption = 'Battle Ridding Options'
        TabOrder = 2
        object Label176: TLabel
          Left = 12
          Top = 45
          Width = 120
          Height = 12
          Caption = 'Non-Riding Exp Rate:'
        end
        object Label177: TLabel
          Left = 12
          Top = 72
          Width = 96
          Height = 12
          Caption = 'Riding Exp Rate:'
        end
        object Label181: TLabel
          Left = 187
          Top = 46
          Width = 6
          Height = 12
          Caption = '%'
        end
        object Label182: TLabel
          Left = 187
          Top = 73
          Width = 6
          Height = 12
          Caption = '%'
        end
        object CheckBoxAllow33HorseGetExp: TCheckBox
          Left = 13
          Top = 19
          Width = 180
          Height = 17
          Hint = 
            'War the ride can attack killing monsters to gain experience, and' +
            ' whether to allow your own.'
          Caption = 'allow non-riding experience'
          TabOrder = 0
          OnClick = CheckBoxAllow33HorseGetExpClick
        end
        object Edit33HorseGetExpRate: TSpinEdit
          Left = 132
          Top = 42
          Width = 49
          Height = 21
          Hint = 'Non-riding experience proportion'
          EditorEnabled = False
          Enabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 1
          Value = 20
          OnChange = Edit33HorseGetExpRateChange
        end
        object Edit33HorseGetExpRate2: TSpinEdit
          Left = 132
          Top = 69
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 999
          MinValue = 0
          TabOrder = 2
          Value = 20
          OnChange = Edit33HorseGetExpRate2Change
        end
      end
      object GroupBox73: TGroupBox
        Left = 215
        Top = 6
        Width = 199
        Height = 75
        Caption = 'Mount Options'
        TabOrder = 3
        object Label178: TLabel
          Left = 12
          Top = 22
          Width = 102
          Height = 12
          Caption = 'Horse Alive Time:'
        end
        object Label179: TLabel
          Left = 167
          Top = 23
          Width = 18
          Height = 12
          Caption = 'Min'
        end
        object Label183: TLabel
          Left = 12
          Top = 45
          Width = 96
          Height = 12
          Caption = 'TakeOnHorseTime:'
        end
        object Label184: TLabel
          Left = 167
          Top = 46
          Width = 18
          Height = 12
          Caption = 'Sec'
        end
        object EditHorseAliveTime: TSpinEdit
          Left = 120
          Top = 19
          Width = 41
          Height = 21
          Hint = 'Horse death resurrection time'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditHorseAliveTimeChange
        end
        object EditTakeOnHorseUseTime: TSpinEdit
          Left = 96
          Top = 42
          Width = 65
          Height = 21
          Hint = 'Launched preparation time'
          MaxValue = 10000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditTakeOnHorseUseTimeChange
        end
      end
      object GroupBox74: TGroupBox
        Left = 215
        Top = 88
        Width = 199
        Height = 97
        Caption = 'Domestication mount options'
        TabOrder = 4
        object Label185: TLabel
          Left = 12
          Top = 22
          Width = 84
          Height = 12
          Caption = 'Domestic Rate:'
        end
        object EditDomesticationRate: TSpinEdit
          Left = 96
          Top = 19
          Width = 46
          Height = 21
          Hint = 'The higher the number the greater the chances of success'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditDomesticationRateChange
        end
        object CheckBoxDomesticationUseWeapon: TCheckBox
          Left = 12
          Top = 44
          Width = 173
          Height = 17
          Hint = 'Dedicated domesticated weapons Stdmode = 9'
          Caption = 'Domestication Use Weapon'
          TabOrder = 1
          OnClick = CheckBoxDomesticationUseWeaponClick
        end
        object CheckBoxDomesticationCheckLevel: TCheckBox
          Left = 12
          Top = 64
          Width = 173
          Height = 17
          Hint = 'The player'#39's level must be higher than the monsters level'
          Caption = 'Domestication Check Level'
          TabOrder = 2
          OnClick = CheckBoxDomesticationCheckLevelClick
        end
      end
    end
  end
end
