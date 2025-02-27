object frmViewList: TfrmViewList
  Left = 242
  Top = 196
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'List Window'
  ClientHeight = 504
  ClientWidth = 915
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
  object PageControl1: TPageControl
    Left = 8
    Top = 9
    Width = 899
    Height = 488
    ActivePage = TabSheet4
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet15: TTabSheet
      Caption = 'Options'
      object PageControlViewList: TPageControl
        Left = 3
        Top = 3
        Width = 694
        Height = 368
        ActivePage = TabSheet10
        TabOrder = 0
        object TabSheet10: TTabSheet
          Caption = 'Admin'
          ImageIndex = 10
          object GroupBox12: TGroupBox
            Left = 8
            Top = 4
            Width = 180
            Height = 334
            Caption = 'List'
            TabOrder = 0
            object ListBoxAdminList: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 310
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxAdminListClick
            end
          end
          object GroupBox15: TGroupBox
            Left = 194
            Top = 4
            Width = 175
            Height = 181
            Caption = 'Admin'
            TabOrder = 1
            object Label4: TLabel
              Left = 9
              Top = 20
              Width = 30
              Height = 12
              Caption = 'Name:'
            end
            object Label5: TLabel
              Left = 9
              Top = 44
              Width = 42
              Height = 12
              Caption = 'Permit:'
            end
            object LabelAdminIPaddr: TLabel
              Left = 9
              Top = 68
              Width = 18
              Height = 12
              Caption = 'IP:'
            end
            object EditAdminName: TEdit
              Left = 65
              Top = 16
              Width = 97
              Height = 20
              TabOrder = 0
            end
            object EditAdminPremission: TSpinEdit
              Left = 65
              Top = 39
              Width = 61
              Height = 21
              MaxValue = 10
              MinValue = 1
              TabOrder = 1
              Value = 10
            end
            object ButtonAdminListAdd: TButton
              Left = 10
              Top = 104
              Width = 70
              Height = 25
              Caption = 'Add(&A)'
              TabOrder = 2
              OnClick = ButtonAdminListAddClick
            end
            object ButtonAdminListChange: TButton
              Left = 91
              Top = 104
              Width = 70
              Height = 25
              Caption = 'Change(&M)'
              TabOrder = 3
              OnClick = ButtonAdminListChangeClick
            end
            object ButtonAdminListDel: TButton
              Left = 10
              Top = 138
              Width = 70
              Height = 25
              Caption = 'Delete(&D)'
              TabOrder = 4
              OnClick = ButtonAdminListDelClick
            end
            object EditAdminIPaddr: TEdit
              Left = 65
              Top = 64
              Width = 97
              Height = 20
              TabOrder = 5
            end
            object ButtonAdminLitsSave: TButton
              Left = 91
              Top = 138
              Width = 70
              Height = 25
              Caption = 'Save(&S)'
              TabOrder = 6
              OnClick = ButtonAdminLitsSaveClick
            end
          end
        end
        object TabSheet8: TTabSheet
          Hint = '??????,???????????????,??????????'
          Caption = 'Log'
          ImageIndex = 8
          object GroupBox8: TGroupBox
            Left = 288
            Top = 4
            Width = 177
            Height = 334
            Caption = 'List'
            TabOrder = 0
            object ListBoxGameLogList: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 309
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxGameLogListClick
              OnKeyDown = ListBox1KeyDown
            end
          end
          object ButtonGameLogAdd: TButton
            Left = 200
            Top = 24
            Width = 73
            Height = 25
            Caption = 'Add(&A)'
            TabOrder = 1
            OnClick = ButtonGameLogAddClick
          end
          object ButtonGameLogDel: TButton
            Left = 200
            Top = 56
            Width = 73
            Height = 25
            Caption = 'Delete(&D)'
            TabOrder = 2
            OnClick = ButtonGameLogDelClick
          end
          object ButtonGameLogAddAll: TButton
            Left = 200
            Top = 88
            Width = 73
            Height = 25
            Caption = 'Add All'
            TabOrder = 3
            OnClick = ButtonGameLogAddAllClick
          end
          object ButtonGameLogDelAll: TButton
            Left = 199
            Top = 121
            Width = 73
            Height = 25
            Caption = 'Delete All'
            TabOrder = 4
            OnClick = ButtonGameLogDelAllClick
          end
          object ButtonGameLogSave: TButton
            Left = 200
            Top = 152
            Width = 73
            Height = 25
            Caption = 'Save(&S)'
            TabOrder = 5
            OnClick = ButtonGameLogSaveClick
          end
          object GroupBox9: TGroupBox
            Left = 8
            Top = 4
            Width = 177
            Height = 334
            Caption = 'GameLog'
            TabOrder = 6
            object ListBoxitemList2: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 309
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBoxitemList2Click
              OnKeyDown = ListBox1KeyDown
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Drop'
          ImageIndex = 2
          object Label1: TLabel
            Left = 191
            Top = 21
            Width = 60
            Height = 12
            Caption = 'Item Name:'
          end
          object Label2: TLabel
            Left = 191
            Top = 65
            Width = 60
            Height = 12
            Caption = 'Max Count:'
          end
          object Label3: TLabel
            Left = 191
            Top = 92
            Width = 60
            Height = 12
            Caption = 'Min Count:'
          end
          object Label6: TLabel
            Left = 191
            Top = 121
            Width = 60
            Height = 12
            Caption = 'Start Year'
          end
          object Label7: TLabel
            Left = 191
            Top = 146
            Width = 54
            Height = 12
            Caption = 'Start Mon'
          end
          object Label8: TLabel
            Left = 191
            Top = 173
            Width = 60
            Height = 12
            Caption = 'Start Date'
          end
          object Label9: TLabel
            Left = 191
            Top = 200
            Width = 30
            Height = 12
            Caption = 'Start'
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 4
            Width = 177
            Height = 334
            Caption = 'List Box (Find: Ctrl + F)'
            TabOrder = 0
            object ListBox1: TListBox
              Left = 8
              Top = 16
              Width = 161
              Height = 309
              ItemHeight = 12
              TabOrder = 0
              OnClick = ListBox1Click
              OnKeyDown = ListBox1KeyDown
            end
          end
          object GroupBox3: TGroupBox
            Left = 307
            Top = 4
            Width = 377
            Height = 334
            Caption = 'Mon Drop Limit'
            TabOrder = 1
            object StringGridMonDropLimit: TStringGrid
              Left = 8
              Top = 16
              Width = 361
              Height = 309
              ColCount = 4
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 2
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              TabOrder = 0
              OnClick = StringGridMonDropLimitClick
              ColWidths = (
                92
                62
                60
                120)
            end
          end
          object EditMonDropName: TEdit
            Left = 191
            Top = 36
            Width = 110
            Height = 20
            TabOrder = 2
          end
          object ButtonMonDropAdd: TButton
            Left = 191
            Top = 230
            Width = 52
            Height = 25
            Caption = '&Add'
            Enabled = False
            TabOrder = 3
            OnClick = ButtonMonDropAddClick
          end
          object EditMonDropMaxCount: TSpinEdit
            Left = 247
            Top = 62
            Width = 54
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
          object EditMonDropMinCount: TSpinEdit
            Left = 247
            Top = 89
            Width = 54
            Height = 21
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object EditMonDropYear: TSpinEdit
            Left = 247
            Top = 116
            Width = 54
            Height = 21
            MaxValue = 3000
            MinValue = 2010
            TabOrder = 6
            Value = 2010
          end
          object EditMonDropMonth: TSpinEdit
            Left = 247
            Top = 143
            Width = 54
            Height = 21
            MaxValue = 12
            MinValue = 0
            TabOrder = 7
            Value = 0
          end
          object EditMonDropDay: TSpinEdit
            Left = 247
            Top = 170
            Width = 54
            Height = 21
            MaxValue = 31
            MinValue = 0
            TabOrder = 8
            Value = 0
          end
          object ButtonMonDropDel: TButton
            Left = 249
            Top = 230
            Width = 52
            Height = 25
            Caption = '&Delete'
            Enabled = False
            TabOrder = 9
            OnClick = ButtonMonDropDelClick
          end
          object ButtonMonDropSave: TButton
            Left = 249
            Top = 292
            Width = 52
            Height = 25
            Caption = '&Save'
            Enabled = False
            TabOrder = 10
            OnClick = ButtonMonDropSaveClick
          end
          object ButtonMonDropLoad: TButton
            Left = 191
            Top = 292
            Width = 52
            Height = 25
            Caption = '&Reload'
            TabOrder = 11
            OnClick = ButtonMonDropLoadClick
          end
          object EditMonDropHour: TSpinEdit
            Left = 247
            Top = 197
            Width = 54
            Height = 21
            MaxValue = 31
            MinValue = 0
            TabOrder = 12
            Value = 0
          end
          object ButtonMonDropClear: TButton
            Left = 249
            Top = 261
            Width = 52
            Height = 25
            Caption = '&Clear'
            TabOrder = 13
            OnClick = ButtonMonDropClearClick
          end
          object ButtonMonDropEdit: TButton
            Left = 191
            Top = 261
            Width = 52
            Height = 25
            Caption = '&Edit'
            Enabled = False
            TabOrder = 14
            OnClick = ButtonMonDropEditClick
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'User CMD'
          ImageIndex = 3
          object Label12: TLabel
            Left = 447
            Top = 24
            Width = 226
            Height = 223
            AutoSize = False
            Caption = 
              'Game command: Test command'#13#13'Which are identified as: 1'#13#13'The play' +
              'ers enter: @ test command parameter parameter'#13#13'Note: Total suppo' +
              'rt with nine parameters'#13#13'The set QFunction-0.txt:'#13#13'[@USERCMD1]'#13'F' +
              'irst Param: <$STR(T0)> \'#13'Second Param: <$STR(T1)> \'#13'Third Param:' +
              ' <$STR(T2)> \'
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 4
            Width = 433
            Height = 334
            Caption = 'User CMD'
            TabOrder = 0
            object Label10: TLabel
              Left = 281
              Top = 20
              Width = 48
              Height = 12
              Caption = 'Command:'
            end
            object Label11: TLabel
              Left = 281
              Top = 44
              Width = 18
              Height = 12
              Caption = 'ID:'
            end
            object StringGridUserCmd: TStringGrid
              Left = 8
              Top = 16
              Width = 267
              Height = 309
              ColCount = 3
              DefaultRowHeight = 18
              FixedCols = 0
              RowCount = 30
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              TabOrder = 0
              OnClick = StringGridUserCmdClick
              ColWidths = (
                93
                46
                100)
            end
            object EditUserCmdName: TEdit
              Left = 337
              Top = 16
              Width = 88
              Height = 20
              TabOrder = 1
            end
            object EditUserCmdID: TSpinEdit
              Left = 337
              Top = 39
              Width = 40
              Height = 21
              EditorEnabled = False
              MaxValue = 255
              MinValue = 1
              TabOrder = 2
              Value = 1
            end
            object ButtonUserCmdAdd: TButton
              Left = 284
              Top = 75
              Width = 66
              Height = 25
              Caption = '&Add'
              TabOrder = 3
              OnClick = ButtonUserCmdAddClick
            end
            object ButtonUserCmdDel: TButton
              Left = 356
              Top = 75
              Width = 66
              Height = 25
              Caption = '&Delete'
              Enabled = False
              TabOrder = 4
              OnClick = ButtonUserCmdDelClick
            end
            object ButtonUserCmdEdit: TButton
              Left = 284
              Top = 106
              Width = 66
              Height = 25
              Caption = '&Edit'
              Enabled = False
              TabOrder = 5
              OnClick = ButtonUserCmdEditClick
            end
            object ButtonUserCmdSave: TButton
              Left = 356
              Top = 106
              Width = 66
              Height = 25
              Caption = '&Save'
              Enabled = False
              TabOrder = 6
              OnClick = ButtonUserCmdSaveClick
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Item planning'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 363
        Caption = 'Item list (Ctrl + F Find)'
        TabOrder = 0
        object ListBoxItem: TListBox
          Left = 8
          Top = 38
          Width = 161
          Height = 317
          Style = lbOwnerDrawFixed
          ItemHeight = 12
          MultiSelect = True
          TabOrder = 0
          OnClick = ListBoxItemClick
          OnDrawItem = ListBoxItemDrawItem
          OnKeyDown = ListBox1KeyDown
        end
        object CheckBox1: TCheckBox
          Left = 8
          Top = 17
          Width = 57
          Height = 17
          Caption = 'Show'
          TabOrder = 1
          OnClick = CheckBox1Click
        end
        object ComboBox1: TComboBox
          Left = 71
          Top = 15
          Width = 98
          Height = 20
          Style = csDropDownList
          Enabled = False
          ItemHeight = 12
          TabOrder = 2
          OnChange = CheckBox1Click
          Items.Strings = (
            'All'
            'Build prompted'
            'Drop prompted'
            'Chest tips')
        end
      end
      object GroupBox18: TGroupBox
        Left = 191
        Top = 8
        Width = 674
        Height = 334
        Caption = 'Item Rule Properties'
        TabOrder = 1
        object CheckBoxMake: TCheckBox
          Left = 8
          Top = 17
          Width = 200
          Height = 17
          Hint = 'Selected, throw items, picking up the script trigger'
          Caption = 'Build prompted'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDropHint: TCheckBox
          Tag = 1
          Left = 320
          Top = 17
          Width = 250
          Height = 17
          Caption = 'Drop prompted'
          TabOrder = 1
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDropDown: TCheckBox
          Tag = -1
          Left = 320
          Top = 34
          Width = 250
          Height = 17
          Caption = 'Prohibition of the burst'
          Enabled = False
          TabOrder = 2
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxSave: TCheckBox
          Tag = -1
          Left = 320
          Top = 51
          Width = 250
          Height = 17
          Caption = 'Prohibited for storage'
          Enabled = False
          TabOrder = 3
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object chkBox: TCheckBox
          Tag = 2
          Left = 8
          Top = 34
          Width = 200
          Height = 17
          Caption = 'Chest tips'
          TabOrder = 4
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxSell: TCheckBox
          Tag = -1
          Left = 8
          Top = 51
          Width = 200
          Height = 17
          Caption = 'Ban the sale of'
          Enabled = False
          TabOrder = 5
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDeath: TCheckBox
          Tag = -1
          Left = 8
          Top = 101
          Width = 200
          Height = 17
          Caption = 'Death Drop'
          Enabled = False
          TabOrder = 6
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxBoxs: TCheckBox
          Tag = -1
          Left = 320
          Top = 68
          Width = 250
          Height = 17
          Hint = 
            'Selected, items open the chest to get sent to the full-service p' +
            'rompt. The prompt files modified in the Strings.ini.'
          Caption = 'Chest tips'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxGhost: TCheckBox
          Tag = -1
          Left = 8
          Top = 84
          Width = 200
          Height = 17
          Caption = 'Drop off'
          Enabled = False
          TabOrder = 8
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxPlaySell: TCheckBox
          Tag = -1
          Left = 320
          Top = 85
          Width = 250
          Height = 17
          Caption = 'Prohibition of the stall'
          Enabled = False
          TabOrder = 9
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxResell: TCheckBox
          Tag = -1
          Left = 8
          Top = 68
          Width = 200
          Height = 17
          Caption = 'Cannot repair'
          Enabled = False
          TabOrder = 10
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxNoDrop: TCheckBox
          Tag = -1
          Left = 320
          Top = 101
          Width = 250
          Height = 17
          Hint = 'Selected, the death of the items do not fall.'
          Caption = 'Never fall'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxDropHint2: TCheckBox
          Tag = -1
          Left = 8
          Top = 117
          Width = 200
          Height = 17
          Hint = 
            'Selected, objects to fall on the ground to the full-service hair' +
            ' to coordinate prompt. The prompt files modified in the Strings.' +
            'ini.'
          Caption = 'Drop prompted'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxNoLevel: TCheckBox
          Tag = -1
          Left = 320
          Top = 117
          Width = 250
          Height = 17
          Hint = 
            'This option is only used in Sabac weapon upgrades, set of prohib' +
            'ited upgraded weapons.'
          Caption = 'Prohibition of the upgrade'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxButchItem: TCheckBox
          Tag = -1
          Left = 8
          Top = 133
          Width = 200
          Height = 17
          Hint = 
            'Selected, the specified items from monsters or strange body dug ' +
            'full-service prompt. The prompt files modified in the Strings.in' +
            'i.'
          Caption = 'excavation of prompt'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxHeroBag: TCheckBox
          Tag = -1
          Left = 320
          Top = 133
          Width = 250
          Height = 17
          Hint = 'Items are prohibited on the hero wrapped'
          Caption = 'Hero parcel'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBox17: TCheckBox
          Tag = -1
          Left = 320
          Top = 149
          Width = 250
          Height = 17
          Caption = 'Placeholder'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object CheckBoxNoTakeOff: TCheckBox
          Tag = 3
          Left = 8
          Top = 149
          Width = 200
          Height = 17
          Caption = 'Prohibit Remove'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnMouseUp = CheckBoxMakeMouseUp
        end
        object ButtonAllAdd: TButton
          Left = 5
          Top = 303
          Width = 92
          Height = 23
          Caption = 'Select All'
          TabOrder = 18
        end
        object ButtonAllClose: TButton
          Left = 132
          Top = 303
          Width = 93
          Height = 23
          Caption = 'UnSelect All'
          TabOrder = 19
        end
      end
      object ButtonRuleSave: TButton
        Left = 795
        Top = 348
        Width = 70
        Height = 23
        Caption = 'Save'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonRuleSaveClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'SetItems'
      ImageIndex = 2
      object GroupBox6: TGroupBox
        Left = 191
        Top = 139
        Width = 697
        Height = 318
        Caption = 'Settings'
        TabOrder = 0
        object Label14: TLabel
          Left = 336
          Top = 27
          Width = 18
          Height = 12
          Caption = 'HP:'
        end
        object Label15: TLabel
          Left = 452
          Top = 26
          Width = 18
          Height = 12
          Caption = 'MP:'
        end
        object Label16: TLabel
          Left = 572
          Top = 26
          Width = 18
          Height = 12
          Caption = 'AC:'
        end
        object Label17: TLabel
          Left = 336
          Top = 49
          Width = 24
          Height = 12
          Caption = 'MAC:'
        end
        object Label18: TLabel
          Left = 452
          Top = 50
          Width = 18
          Height = 12
          Caption = 'DC:'
        end
        object Label19: TLabel
          Left = 572
          Top = 49
          Width = 18
          Height = 12
          Caption = 'MC:'
        end
        object Label20: TLabel
          Left = 336
          Top = 73
          Width = 18
          Height = 12
          Caption = 'SC:'
        end
        object Label21: TLabel
          Left = 452
          Top = 74
          Width = 24
          Height = 12
          Caption = 'Acc:'
        end
        object Label22: TLabel
          Left = 336
          Top = 96
          Width = 54
          Height = 12
          Caption = 'HP Recov:'
        end
        object Label23: TLabel
          Left = 452
          Top = 97
          Width = 54
          Height = 12
          Caption = 'MP Recov:'
        end
        object Label24: TLabel
          Left = 336
          Top = 119
          Width = 60
          Height = 12
          Caption = 'Anti Magic'
        end
        object Label25: TLabel
          Left = 452
          Top = 120
          Width = 60
          Height = 12
          Caption = 'Anti Poion'
        end
        object Label32: TLabel
          Left = 336
          Top = 142
          Width = 30
          Height = 12
          Caption = 'DC+ %'
        end
        object Label31: TLabel
          Left = 452
          Top = 143
          Width = 30
          Height = 12
          Caption = 'MC+ %'
        end
        object Label26: TLabel
          Left = 572
          Top = 72
          Width = 30
          Height = 12
          Caption = 'Agil:'
        end
        object Label27: TLabel
          Left = 572
          Top = 95
          Width = 54
          Height = 12
          Caption = 'Posion Re'
        end
        object Label28: TLabel
          Left = 572
          Top = 118
          Width = 54
          Height = 12
          Caption = 'EXP Rate:'
        end
        object Label29: TLabel
          Left = 572
          Top = 141
          Width = 30
          Height = 12
          Caption = 'SC+ %'
        end
        object Label35: TLabel
          Left = 572
          Top = 164
          Width = 36
          Height = 12
          Caption = 'Crit+%'
        end
        object Label36: TLabel
          Left = 452
          Top = 166
          Width = 36
          Height = 12
          Caption = 'MAC+ %'
        end
        object Label37: TLabel
          Left = 336
          Top = 165
          Width = 30
          Height = 12
          Caption = 'AC+ %'
        end
        object Label30: TLabel
          Left = 15
          Top = 288
          Width = 30
          Height = 12
          Caption = 'Name:'
        end
        object Label33: TLabel
          Left = 336
          Top = 188
          Width = 30
          Height = 12
          Caption = 'Para:'
        end
        object Label34: TLabel
          Left = 452
          Top = 189
          Width = 54
          Height = 12
          Caption = 'BodyAtrib'
        end
        object Label38: TLabel
          Left = 572
          Top = 187
          Width = 60
          Height = 12
          Caption = 'Resurrect:'
        end
        object Label50: TLabel
          Left = 336
          Top = 212
          Width = 48
          Height = 12
          Caption = 'DmgBns%:'
        end
        object Label51: TLabel
          Left = 452
          Top = 213
          Width = 48
          Height = 12
          Caption = 'DmgAbs%:'
        end
        object EditHP: TSpinEdit
          Tag = 7
          Left = 394
          Top = 23
          Width = 52
          Height = 21
          Color = clWhite
          MaxValue = 60000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditHPChange
        end
        object EditMP: TSpinEdit
          Tag = 8
          Left = 514
          Top = 23
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditHPChange
        end
        object EditACt: TSpinEdit
          Left = 634
          Top = 23
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = EditHPChange
        end
        object EditMAC3: TSpinEdit
          Tag = 1
          Left = 394
          Top = 45
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditHPChange
        end
        object EditDC: TSpinEdit
          Tag = 2
          Left = 514
          Top = 46
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = EditHPChange
        end
        object EditMC: TSpinEdit
          Tag = 3
          Left = 634
          Top = 46
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = EditHPChange
        end
        object EditSC: TSpinEdit
          Tag = 4
          Left = 394
          Top = 69
          Width = 52
          Height = 21
          Color = clWhite
          MaxValue = 60000
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = EditHPChange
        end
        object EditSC2: TSpinEdit
          Tag = 5
          Left = 514
          Top = 69
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditHPChange
        end
        object EditAC: TSpinEdit
          Tag = 14
          Left = 394
          Top = 92
          Width = 52
          Height = 21
          Hint = '?????1??10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditHPChange
        end
        object EditAC2: TSpinEdit
          Tag = 15
          Left = 514
          Top = 92
          Width = 52
          Height = 21
          Hint = '?????1??10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = EditHPChange
        end
        object EditMAC: TSpinEdit
          Tag = 17
          Left = 394
          Top = 115
          Width = 52
          Height = 21
          Hint = '?????1??10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditHPChange
        end
        object EditMAC2: TSpinEdit
          Tag = 18
          Left = 514
          Top = 115
          Width = 52
          Height = 21
          Hint = '?????1??10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = EditHPChange
        end
        object EditHitPoint: TSpinEdit
          Tag = 11
          Left = 394
          Top = 138
          Width = 52
          Height = 21
          Hint = '?????10??1?'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 12
          Value = 0
          OnChange = EditHPChange
        end
        object EditSpeedPoint: TSpinEdit
          Tag = 12
          Left = 514
          Top = 138
          Width = 52
          Height = 21
          Hint = '?????10??1?'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 13
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit1: TSpinEdit
          Tag = 6
          Left = 634
          Top = 69
          Width = 52
          Height = 21
          MaxValue = 60000
          MinValue = 0
          TabOrder = 14
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit2: TSpinEdit
          Tag = 16
          Left = 634
          Top = 92
          Width = 52
          Height = 21
          Hint = '?????1??10%'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 15
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit3: TSpinEdit
          Tag = 22
          Left = 634
          Top = 115
          Width = 52
          Height = 21
          Hint = '?????10??1?'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 16
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit4: TSpinEdit
          Tag = 13
          Left = 634
          Top = 138
          Width = 52
          Height = 21
          Hint = '?????10??1?'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 17
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit8: TSpinEdit
          Tag = 21
          Left = 634
          Top = 161
          Width = 52
          Height = 21
          Hint = '?????1??1%'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 18
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit9: TSpinEdit
          Tag = 10
          Left = 514
          Top = 161
          Width = 52
          Height = 21
          Hint = '?????10??1?'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 19
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit10: TSpinEdit
          Tag = 9
          Left = 394
          Top = 161
          Width = 52
          Height = 21
          Hint = '?????10??1?'
          MaxValue = 1000
          MinValue = 0
          TabOrder = 20
          Value = 0
          OnChange = EditHPChange
        end
        object Button1: TButton
          Left = 336
          Top = 283
          Width = 62
          Height = 25
          Caption = 'Add'
          Enabled = False
          TabOrder = 21
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 404
          Top = 283
          Width = 62
          Height = 25
          Caption = 'Edit'
          Enabled = False
          TabOrder = 22
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 472
          Top = 283
          Width = 62
          Height = 25
          Caption = 'Delete'
          Enabled = False
          TabOrder = 23
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 540
          Top = 283
          Width = 62
          Height = 25
          Caption = 'Save'
          Enabled = False
          TabOrder = 24
          OnClick = Button4Click
        end
        object Edit1: TEdit
          Tag = -1
          Left = 63
          Top = 285
          Width = 259
          Height = 20
          Hint = '?????????????,??????????'
          MaxLength = 50
          TabOrder = 25
        end
        object SpinEdit5: TSpinEdit
          Tag = 23
          Left = 394
          Top = 184
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 1
          MinValue = 0
          TabOrder = 26
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit6: TSpinEdit
          Tag = 24
          Left = 514
          Top = 184
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 1
          MinValue = 0
          TabOrder = 27
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit7: TSpinEdit
          Tag = 25
          Left = 634
          Top = 184
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 1
          MinValue = 0
          TabOrder = 28
          Value = 0
          OnChange = EditHPChange
        end
        object GroupBox10: TGroupBox
          Left = 20
          Top = 21
          Width = 310
          Height = 258
          Caption = 'Item List'
          TabOrder = 29
          object Label13: TLabel
            Left = 10
            Top = 22
            Width = 24
            Height = 12
            Caption = 'Arm:'
          end
          object Label39: TLabel
            Left = 167
            Top = 23
            Width = 12
            Height = 12
            Caption = 'Or'
          end
          object Label40: TLabel
            Left = 10
            Top = 48
            Width = 24
            Height = 12
            Caption = 'Wep:'
          end
          object Label41: TLabel
            Left = 10
            Top = 74
            Width = 24
            Height = 12
            Caption = 'Neck'
          end
          object Label42: TLabel
            Left = 10
            Top = 100
            Width = 24
            Height = 12
            Caption = 'Helm'
          end
          object Label43: TLabel
            Left = 10
            Top = 126
            Width = 36
            Height = 12
            Caption = 'Candle'
          end
          object Label44: TLabel
            Left = 10
            Top = 152
            Width = 30
            Height = 12
            Caption = 'Brace'
          end
          object Label45: TLabel
            Left = 159
            Top = 152
            Width = 30
            Height = 12
            Caption = 'Brace'
          end
          object Label46: TLabel
            Left = 159
            Top = 178
            Width = 24
            Height = 12
            Caption = 'Ring'
          end
          object Label47: TLabel
            Left = 10
            Top = 178
            Width = 24
            Height = 12
            Caption = 'Ring'
          end
          object Label49: TLabel
            Left = 10
            Top = 204
            Width = 24
            Height = 12
            Caption = 'Belt'
          end
          object Label48: TLabel
            Left = 10
            Top = 230
            Width = 30
            Height = 12
            Caption = 'Boots'
          end
          object Edit2: TEdit
            Left = 46
            Top = 19
            Width = 107
            Height = 20
            Hint = '???????,????????????????!'
            TabOrder = 0
          end
          object Edit3: TEdit
            Tag = 1
            Left = 46
            Top = 45
            Width = 107
            Height = 20
            Hint = '???????,???'
            TabOrder = 1
          end
          object Edit4: TEdit
            Tag = 3
            Left = 46
            Top = 71
            Width = 107
            Height = 20
            Hint = '???????,???'
            TabOrder = 2
          end
          object Edit5: TEdit
            Tag = 2
            Left = 46
            Top = 97
            Width = 107
            Height = 20
            Hint = '???????,???'
            TabOrder = 3
          end
          object Edit6: TEdit
            Tag = 4
            Left = 46
            Top = 123
            Width = 107
            Height = 20
            Hint = '???????,???'
            TabOrder = 4
          end
          object Edit7: TEdit
            Tag = 5
            Left = 46
            Top = 149
            Width = 107
            Height = 20
            Hint = '???????,????????????????????'
            TabOrder = 5
          end
          object Edit8: TEdit
            Tag = 7
            Left = 46
            Top = 175
            Width = 107
            Height = 20
            Hint = '???????,????????????????????'
            TabOrder = 6
          end
          object Edit9: TEdit
            Tag = 10
            Left = 46
            Top = 201
            Width = 107
            Height = 20
            Hint = '???????,???'
            TabOrder = 7
          end
          object Edit10: TEdit
            Tag = 11
            Left = 46
            Top = 227
            Width = 107
            Height = 20
            Hint = '???????,???'
            TabOrder = 8
          end
          object Edit11: TEdit
            Tag = 9
            Left = 195
            Top = 19
            Width = 107
            Height = 20
            Hint = '???????,????????????????!'
            TabOrder = 9
          end
          object Edit12: TEdit
            Tag = 6
            Left = 195
            Top = 149
            Width = 107
            Height = 20
            Hint = '???????,????????????????????'
            TabOrder = 10
          end
          object Edit13: TEdit
            Tag = 8
            Left = 195
            Top = 175
            Width = 107
            Height = 20
            Hint = '???????,????????????????????'
            TabOrder = 11
          end
        end
        object SpinEdit11: TSpinEdit
          Tag = 19
          Left = 394
          Top = 208
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 30
          Value = 0
          OnChange = EditHPChange
        end
        object SpinEdit12: TSpinEdit
          Tag = 20
          Left = 514
          Top = 208
          Width = 52
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 31
          Value = 0
          OnChange = EditHPChange
        end
        object CheckBox2: TCheckBox
          Left = 336
          Top = 238
          Width = 110
          Height = 17
          Caption = 'Do not display ingame item pop up.'
          TabOrder = 32
        end
      end
      object GroupBox7: TGroupBox
        Left = 191
        Top = 8
        Width = 697
        Height = 125
        Caption = 'SetItems'
        TabOrder = 1
        object ListViewSuit: TListView
          Left = 9
          Top = 18
          Width = 672
          Height = 98
          Columns = <
            item
              Caption = 'SetName'
              Width = 160
            end
            item
              Caption = 'ItemList'
              Width = 220
            end
            item
              AutoSize = True
              Caption = 'Properties'
            end
            item
              Caption = 'Hidden attribute'
              Width = 60
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewSuitClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 449
        Caption = 'Item List'
        TabOrder = 2
        object ListBoxSetItems: TListBox
          Left = 7
          Top = 18
          Width = 161
          Height = 418
          Style = lbOwnerDrawFixed
          ItemHeight = 12
          MultiSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          OnKeyDown = ListBox1KeyDown
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 40
    Top = 144
    object A1: TMenuItem
      Caption = 'Add'
      OnClick = A1Click
    end
  end
end
