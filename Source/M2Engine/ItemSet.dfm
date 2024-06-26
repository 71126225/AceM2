object frmItemSet: TfrmItemSet
  Left = 457
  Top = 335
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Item Functions'
  ClientHeight = 329
  ClientWidth = 505
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
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 489
    Height = 313
    ActivePage = TabSheet9
    TabOrder = 0
    object TabSheet8: TTabSheet
      Caption = 'Normal Items'
      object ItemSetPageControl: TPageControl
        Left = 8
        Top = 4
        Width = 465
        Height = 245
        ActivePage = TabSheet4
        MultiLine = True
        TabOrder = 0
        object TabSheet22: TTabSheet
          Caption = 'Other'
          ImageIndex = 5
          object GroupBox82: TGroupBox
            Left = 3
            Top = 3
            Width = 150
            Height = 70
            Caption = '????'
            TabOrder = 0
            object CheckBoxOpenArmStrengthen: TCheckBox
              Left = 16
              Top = 16
              Width = 121
              Height = 17
              Caption = 'OpenArmStrengthen'
              TabOrder = 0
              OnClick = CheckBoxOpenArmStrengthenClick
            end
            object CheckBoxOpenItemFlute: TCheckBox
              Left = 16
              Top = 39
              Width = 102
              Height = 17
              Caption = 'OpenItemFlute'
              TabOrder = 1
              OnClick = CheckBoxOpenItemFluteClick
            end
          end
          object GroupBox83: TGroupBox
            Left = 3
            Top = 80
            Width = 126
            Height = 70
            Caption = 'Ability Move'
            TabOrder = 1
            object Label234: TLabel
              Left = 8
              Top = 20
              Width = 60
              Height = 12
              Caption = 'Base Rate:'
            end
            object Label235: TLabel
              Left = 8
              Top = 43
              Width = 30
              Height = 12
              Caption = 'Gold:'
            end
            object EditAbilityMoveBaseRate: TSpinEdit
              Left = 64
              Top = 16
              Width = 60
              Height = 21
              MaxValue = 100
              MinValue = 0
              TabOrder = 0
              Value = 20
              OnChange = EditAbilityMoveBaseRateChange
            end
            object EditAbilityMoveGold: TSpinEdit
              Left = 64
              Top = 39
              Width = 60
              Height = 21
              MaxValue = 0
              MinValue = 0
              TabOrder = 1
              Value = 0
              OnChange = EditAbilityMoveGoldChange
            end
          end
        end
        object TabSheet1: TTabSheet
          Caption = 'Experience'
          object GroupBox141: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = 'Exp Rate'
            TabOrder = 0
            object Label108: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object Label109: TLabel
              Left = 8
              Top = 144
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                '????????,?????,??????,???????65,???65000?,??????????????????,???' +
                '??10000,?? 6.5?????????????????,???????'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = '??'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditItemExpRate: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditItemExpRateChange
            end
            object GroupBox1: TGroupBox
              Left = 160
              Top = 16
              Width = 201
              Height = 81
              Caption = 'Database Set [141]'
              TabOrder = 1
              object Label1: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = 'Weapons, candles use: AniCount'
              end
              object Label2: TLabel
                Left = 8
                Top = 32
                Width = 132
                Height = 12
                Caption = 'Other items use: Shape'
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Power'
          ImageIndex = 1
          object GroupBox142: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = 'Power Rate'
            TabOrder = 0
            object Label110: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object Label3: TLabel
              Left = 8
              Top = 144
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                '????????,?????,??????,???????65,???65000?,??????????????????,???' +
                '??10000,?? 6.5?????????????????,???????'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = '??'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditItemPowerRate: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditItemPowerRateChange
            end
            object GroupBox2: TGroupBox
              Left = 160
              Top = 16
              Width = 201
              Height = 81
              Caption = 'Database Set [142]'
              TabOrder = 1
              object Label4: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = 'Weapons, candles use: AniCount'
              end
              object Label5: TLabel
                Left = 8
                Top = 32
                Width = 132
                Height = 12
                Caption = 'Other Items use: Shape'
              end
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Recall'
          ImageIndex = 3
          object GroupBox28: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = 'Guild Recall'
            TabOrder = 0
            object Label85: TLabel
              Left = 11
              Top = 24
              Width = 72
              Height = 12
              Caption = 'Recall Time:'
            end
            object Label86: TLabel
              Left = 8
              Top = 144
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                'Sets the time the guild recall will last as long as the wearer i' +
                's still alive'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = '??'
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditGuildRecallTime: TSpinEdit
              Left = 79
              Top = 20
              Width = 57
              Height = 21
              Hint = '???????,???????????????????,??????????'
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditGuildRecallTimeChange
            end
            object GroupBox29: TGroupBox
              Left = 160
              Top = 16
              Width = 201
              Height = 81
              Caption = 'Database Set [145]'
              TabOrder = 1
              object Label87: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = 'Weapons, candles use: AniCount'
              end
              object Label88: TLabel
                Left = 8
                Top = 32
                Width = 132
                Height = 12
                Caption = 'Other Items Use: Shape'
              end
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Paralysis'
          ImageIndex = 4
          object GroupBox44: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 201
            Caption = 'Paralysis'
            TabOrder = 0
            object GroupBox45: TGroupBox
              Left = 165
              Top = 16
              Width = 194
              Height = 81
              Caption = 'Database Set [113]'
              TabOrder = 0
              object Label122: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = 'Weapons, candles use: AniCount'
              end
              object Label123: TLabel
                Left = 8
                Top = 32
                Width = 132
                Height = 12
                Caption = 'Other Items use: Shape'
              end
            end
            object GroupBox42: TGroupBox
              Left = 8
              Top = 16
              Width = 150
              Height = 81
              Caption = 'Ring'
              TabOrder = 1
              object Label120: TLabel
                Left = 11
                Top = 24
                Width = 30
                Height = 12
                Caption = 'Rate:'
              end
              object Label116: TLabel
                Left = 11
                Top = 48
                Width = 30
                Height = 12
                Caption = 'Time:'
              end
              object Label124: TLabel
                Left = 126
                Top = 48
                Width = 18
                Height = 12
                Caption = 'Sec'
              end
              object EditAttackPosionRate: TSpinEdit
                Left = 72
                Top = 20
                Width = 49
                Height = 21
                Hint = '??????,????????,??????5'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditAttackPosionRateChange
              end
              object EditAttackPosionTime: TSpinEdit
                Left = 72
                Top = 44
                Width = 49
                Height = 21
                Hint = '??????,???,?????6'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 1
                Value = 100
                OnChange = EditAttackPosionTimeChange
              end
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'Teleport'
          ImageIndex = 5
          object GroupBox43: TGroupBox
            Left = 5
            Top = 9
            Width = 369
            Height = 201
            Caption = 'Teleport'
            TabOrder = 0
            object GroupBox46: TGroupBox
              Left = 165
              Top = 16
              Width = 194
              Height = 81
              Caption = 'Database Set [112]'
              TabOrder = 0
              object Label117: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = 'Weapons, candles use: AniCount'
              end
              object Label118: TLabel
                Left = 8
                Top = 32
                Width = 132
                Height = 12
                Caption = 'Other Items Use: Shape'
              end
            end
            object GroupBox47: TGroupBox
              Left = 8
              Top = 16
              Width = 150
              Height = 81
              Caption = 'Parameters'
              TabOrder = 1
              object Label119: TLabel
                Left = 11
                Top = 56
                Width = 30
                Height = 12
                Caption = 'Time:'
              end
              object Label121: TLabel
                Left = 123
                Top = 56
                Width = 18
                Height = 12
                Caption = 'Sec'
              end
              object CheckBoxUserMoveCanDupObj: TCheckBox
                Left = 8
                Top = 16
                Width = 137
                Height = 17
                Hint = '??????,???????????????'
                Caption = 'Move Dupe'
                TabOrder = 0
                OnClick = CheckBoxUserMoveCanDupObjClick
              end
              object CheckBoxUserMoveCanOnItem: TCheckBox
                Left = 8
                Top = 32
                Width = 137
                Height = 17
                Hint = '??????,???????????????'
                Caption = 'Move OnItem'
                TabOrder = 1
                OnClick = CheckBoxUserMoveCanOnItemClick
              end
              object EditUserMoveTime: TSpinEdit
                Left = 72
                Top = 52
                Width = 49
                Height = 21
                Hint = '??????????'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 2
                Value = 100
                OnChange = EditUserMoveTimeChange
              end
            end
          end
        end
      end
      object ButtonItemSetSave: TButton
        Left = 396
        Top = 255
        Width = 77
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonItemSetSaveClick
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Added Chance'
      ImageIndex = 1
      object AddValuePageControl: TPageControl
        Left = 8
        Top = 4
        Width = 465
        Height = 245
        ActivePage = TabSheet10
        MultiLine = True
        TabOrder = 0
        object TabSheet10: TTabSheet
          Caption = 'Other'
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 225
            Height = 102
            Caption = 'Chances of Added Value'
            TabOrder = 0
            object Label6: TLabel
              Left = 11
              Top = 24
              Width = 54
              Height = 12
              Caption = 'Mon Drop:'
            end
            object Label7: TLabel
              Left = 11
              Top = 48
              Width = 66
              Height = 12
              Caption = 'When @make:'
            end
            object Label125: TLabel
              Left = 11
              Top = 73
              Width = 72
              Height = 12
              Caption = 'From Script:'
            end
            object EditMonRandomAddValue: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = '??????????????,????,?????'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMonRandomAddValueChange
            end
            object EditMakeRandomAddValue: TSpinEdit
              Left = 72
              Top = 44
              Width = 57
              Height = 21
              Hint = 'GM????????????,????,?????'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMakeRandomAddValueChange
            end
            object EditNpcMakeRandomAddValue: TSpinEdit
              Left = 72
              Top = 69
              Width = 57
              Height = 21
              Hint = 'NPC???????????,????,?????'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNpcMakeRandomAddValueChange
            end
            object CheckBoxMonRandom: TCheckBox
              Left = 135
              Top = 22
              Width = 82
              Height = 17
              Hint = '??????????,?????NPC???'
              Caption = 'MonRandom'
              TabOrder = 3
              OnClick = CheckBoxMonRandomClick
            end
            object CheckBoxMakeRandom: TCheckBox
              Left = 135
              Top = 47
              Width = 82
              Height = 17
              Hint = '??????????,?????NPC???'
              Caption = 'MakeRandom'
              TabOrder = 4
              OnClick = CheckBoxMakeRandomClick
            end
            object CheckBoxNpcMakeRandom: TCheckBox
              Left = 135
              Top = 71
              Width = 82
              Height = 17
              Hint = '??????????,?????NPC???'
              Caption = 'NPCMakeRandom'
              TabOrder = 5
              OnClick = CheckBoxNpcMakeRandomClick
            end
          end
          object GroupBox60: TGroupBox
            Left = 239
            Top = 8
            Width = 137
            Height = 102
            Caption = 'Flute'
            TabOrder = 1
            object Label169: TLabel
              Left = 11
              Top = 24
              Width = 66
              Height = 12
              Caption = 'Flute1Rate:'
            end
            object Label170: TLabel
              Left = 11
              Top = 48
              Width = 66
              Height = 12
              Caption = 'Flute2Rate:'
            end
            object Label171: TLabel
              Left = 11
              Top = 73
              Width = 66
              Height = 12
              Caption = 'Flute3Rate:'
            end
            object EditFlute1Rate: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = '???????????,????,?????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditFlute1RateChange
            end
            object EditFlute2Rate: TSpinEdit
              Left = 72
              Top = 44
              Width = 57
              Height = 21
              Hint = '???????????,????,?????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditFlute2RateChange
            end
            object EditFlute3Rate: TSpinEdit
              Left = 72
              Top = 69
              Width = 57
              Height = 21
              Hint = '???????????,????,?????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditFlute3RateChange
            end
          end
          object GroupBox61: TGroupBox
            Left = 8
            Top = 116
            Width = 137
            Height = 77
            Caption = '????'
            TabOrder = 2
            object Label172: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = '????:'
            end
            object Label173: TLabel
              Left = 11
              Top = 48
              Width = 30
              Height = 12
              Caption = '????:'
            end
            object EditWuXinMinRate: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWuXinMinRateChange
            end
            object EditWuXinMaxRate: TSpinEdit
              Left = 72
              Top = 44
              Width = 57
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWuXinMaxRateChange
            end
          end
        end
        object TabSheet18: TTabSheet
          Caption = 'Helmet'
          ImageIndex = 8
          object GroupBox7: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label14: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label15: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label16: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditHelmetACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox8: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label17: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label18: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label19: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditHelmetMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox9: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label20: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label21: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label22: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditHelmetCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox10: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label23: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label24: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label25: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditHelmetDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox11: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label26: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label27: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label28: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditHelmetMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
          object GroupBox12: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label29: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label30: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label31: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditHelmetSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
            object EditHelmetSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Weapon'
          ImageIndex = 1
          object GroupBox4: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 0
            object Label8: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label9: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label130: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditWeaponDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox5: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 1
            object Label10: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label11: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label131: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditWeaponMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox6: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 2
            object Label12: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label13: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label133: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditWeaponSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox48: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 3
            object Label126: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label127: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label32: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditWeaponACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox52: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 4
            object Label128: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label129: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label132: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditWeaponMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
          object GroupBox53: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 5
            object Label134: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label135: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label136: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditWeaponCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
            object EditWeaponCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet12: TTabSheet
          Caption = 'Armour'
          ImageIndex = 2
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label33: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label34: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label35: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDressACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox14: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label36: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label37: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label38: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDressMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox15: TGroupBox
            Left = 246
            Top = 10
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label39: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label40: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label41: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDressCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox16: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label42: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label43: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label44: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDressDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox17: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label45: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label46: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label47: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDressMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
          object GroupBox18: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label48: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label49: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label50: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDressSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = 'Necklace'
          ImageIndex = 3
          object GroupBox19: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label51: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label52: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label53: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNecklaceACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox20: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label54: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label55: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label56: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNecklaceMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox21: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label57: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label58: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label59: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNecklaceCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox22: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label60: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label61: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label62: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNecklaceDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox23: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label63: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label64: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label65: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNecklaceMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox24: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label66: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label67: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label68: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNecklaceSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
            object EditNecklaceSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = 'Bracelet'
          ImageIndex = 5
          object GroupBox25: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label69: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label70: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label71: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditArmRingACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox26: TGroupBox
            Left = 127
            Top = 10
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label72: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label73: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label74: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditArmRingMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox27: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label75: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label76: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label77: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditArmRingCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox30: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label78: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label79: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label80: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditArmRingDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox31: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label81: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label82: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label83: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditArmRingMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
          object GroupBox32: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label84: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label89: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label90: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditArmRingSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
            object EditArmRingSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRingACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = 'Ring'
          ImageIndex = 6
          object GroupBox33: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label91: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label92: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label93: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditRingACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox34: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label94: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label95: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label96: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditRingMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox35: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label97: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label98: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label99: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditRingCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox36: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label100: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label101: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label102: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditRingDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox37: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label103: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label104: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label105: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditRingMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
          object GroupBox38: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label106: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label107: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label111: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditRingSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
            object EditRingSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Belt'
          ImageIndex = 7
          object GroupBox39: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label112: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label113: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label114: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBeltACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox40: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label115: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label137: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label138: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBeltMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 13
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox41: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label139: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label140: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label141: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBeltCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox49: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label142: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label143: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label144: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBeltDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox50: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label145: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label146: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label147: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBeltMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
          object GroupBox51: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label148: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label149: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label150: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBeltSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
            object EditBeltSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBeltACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'Boots'
          ImageIndex = 8
          object GroupBox54: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label151: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label152: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label153: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBootACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox55: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label154: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label155: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label156: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBootMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox56: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 2
            object Label157: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label158: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label159: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBootCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox57: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = 'DC'
            TabOrder = 3
            object Label160: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label161: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label162: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBootDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox58: TGroupBox
            Left = 127
            Top = 104
            Width = 113
            Height = 89
            Caption = 'MC'
            TabOrder = 4
            object Label163: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label164: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label165: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBootMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
          object GroupBox59: TGroupBox
            Left = 246
            Top = 104
            Width = 113
            Height = 89
            Caption = 'SC'
            TabOrder = 5
            object Label166: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label167: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label168: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBootSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
            object EditBootSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet14: TTabSheet
          Caption = 'Rein'
          ImageIndex = 9
          object GroupBox78: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label222: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label223: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label224: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditReinACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
          object GroupBox79: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label225: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label226: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label227: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditReinMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
          object GroupBox80: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'DC'
            TabOrder = 2
            object Label228: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label229: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label230: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditReinDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
          object GroupBox81: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 3
            object Label231: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label232: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label233: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditReinCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
            object EditReinCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReinACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet17: TTabSheet
          Caption = 'Bell'
          ImageIndex = 10
          object GroupBox62: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label174: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label175: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label176: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBellACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
          object GroupBox63: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label177: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label178: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label179: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBellMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
          object GroupBox64: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'DC'
            TabOrder = 2
            object Label180: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label181: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label182: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBellDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
          object GroupBox65: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 3
            object Label183: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label184: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label185: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditBellCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
            object EditBellCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBellACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet19: TTabSheet
          Caption = 'Saddle'
          ImageIndex = 11
          object GroupBox66: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label186: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label187: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label188: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditSaddleACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
          object GroupBox67: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label189: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label190: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label191: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditSaddleMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
          object GroupBox68: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'DC'
            TabOrder = 2
            object Label192: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label193: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label194: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditSaddleDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
          object GroupBox69: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 3
            object Label195: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label196: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label197: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditSaddleCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
            object EditSaddleCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditSaddleACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet20: TTabSheet
          Caption = 'Decoration'
          ImageIndex = 12
          object GroupBox70: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label198: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label199: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label200: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDecorationACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
          object GroupBox71: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label201: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label202: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label203: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDecorationMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
          object GroupBox72: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'DC'
            TabOrder = 2
            object Label204: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label205: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label206: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDecorationDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
          object GroupBox73: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 3
            object Label207: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label208: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label209: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditDecorationCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
            object EditDecorationCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDecorationACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet21: TTabSheet
          Caption = 'Nail'
          ImageIndex = 13
          object GroupBox74: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 88
            Caption = 'AC'
            TabOrder = 0
            object Label210: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label211: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label212: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNailACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
          object GroupBox75: TGroupBox
            Left = 127
            Top = 8
            Width = 113
            Height = 88
            Caption = 'MAC'
            TabOrder = 1
            object Label213: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label214: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label215: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNailMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
          object GroupBox76: TGroupBox
            Left = 246
            Top = 8
            Width = 113
            Height = 88
            Caption = 'DC'
            TabOrder = 2
            object Label216: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label217: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label218: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNailDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
          object GroupBox77: TGroupBox
            Left = 8
            Top = 102
            Width = 113
            Height = 88
            Caption = 'CC'
            TabOrder = 3
            object Label219: TLabel
              Left = 11
              Top = 16
              Width = 24
              Height = 12
              Caption = 'Max:'
            end
            object Label220: TLabel
              Left = 11
              Top = 40
              Width = 36
              Height = 12
              Caption = 'Value:'
            end
            object Label221: TLabel
              Left = 11
              Top = 64
              Width = 30
              Height = 12
              Caption = 'Rate:'
            end
            object EditNailCCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = '??????????'
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailCCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = '???????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
            object EditNailCCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = '????????,????????,????????????'
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNailACAddValueMaxLimitChange
            end
          end
        end
      end
      object ButtonAddValueSave: TButton
        Left = 401
        Top = 255
        Width = 77
        Height = 25
        Caption = '&Save'
        TabOrder = 1
        OnClick = ButtonAddValueSaveClick
      end
    end
  end
end
