object FormGMManage: TFormGMManage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GM Menu'
  ClientHeight = 388
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pgc1: TPageControl
    Left = 11
    Top = 11
    Width = 650
    Height = 377
    ActivePage = ts1
    Align = alClient
    Style = tsButtons
    TabOrder = 0
    object ts5: TTabSheet
      Caption = 'Options'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grp2: TGroupBox
        Left = 4
        Top = 4
        Width = 167
        Height = 317
        Caption = 'Options'
        TabOrder = 0
        object chk1: TCheckBox
          Left = 20
          Top = 30
          Width = 121
          Height = 21
          Caption = 'Show Item ID'
          TabOrder = 0
        end
      end
    end
    object ts1: TTabSheet
      Caption = 'Item Adjustment'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grp1: TGroupBox
        Left = 3
        Top = 4
        Width = 168
        Height = 329
        BiDiMode = bdLeftToRight
        Caption = 'Items:'
        ParentBiDiMode = False
        TabOrder = 0
        object lstItems: TListBox
          Left = 10
          Top = 50
          Width = 148
          Height = 270
          ItemHeight = 12
          TabOrder = 0
          OnClick = lstItemsClick
        end
        object cbbSelectList: TComboBox
          Left = 10
          Top = 18
          Width = 148
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 1
          OnChange = cbbSelectListChange
          Items.Strings = (
            ''
            'Bag Items'
            'Wear Items')
        end
      end
      object pgcts4: TPageControl
        Left = 190
        Top = 10
        Width = 445
        Height = 324
        ActivePage = ts2
        Style = tsButtons
        TabOrder = 1
        object ts2: TTabSheet
          Caption = 'Basic'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lbl7: TLabel
            Left = 4
            Top = 110
            Width = 31
            Height = 15
            Caption = 'Time:'
          end
          object lbl5: TLabel
            Left = 4
            Top = 139
            Width = 33
            Height = 15
            Caption = 'Mode:'
          end
          object lbl4: TLabel
            Left = 179
            Top = 76
            Width = 51
            Height = 15
            Caption = 'DuraMax:'
          end
          object lbl3: TLabel
            Left = 4
            Top = 76
            Width = 30
            Height = 15
            Caption = 'Dura:'
          end
          object lbl2: TLabel
            Left = 4
            Top = 44
            Width = 35
            Height = 15
            Caption = 'DB ID:'
          end
          object lbl1: TLabel
            Left = 4
            Top = 11
            Width = 39
            Height = 15
            Caption = 'ItemID:'
          end
          object edtTime: TEdit
            Left = 79
            Top = 106
            Width = 267
            Height = 20
            TabOrder = 0
            Text = '1234567890'
          end
          object seMaxDura: TSpinEdit
            Left = 254
            Top = 73
            Width = 92
            Height = 21
            MaxValue = 65535
            MinValue = 1
            TabOrder = 1
            Value = 1
            OnChange = seMaxDuraChange
          end
          object seDura: TSpinEdit
            Left = 79
            Top = 73
            Width = 92
            Height = 21
            MaxValue = 65535
            MinValue = 1
            TabOrder = 2
            Value = 1
          end
          object edtID: TEdit
            Left = 79
            Top = 8
            Width = 92
            Height = 20
            Color = clScrollBar
            ReadOnly = True
            TabOrder = 3
            Text = '1234567890'
          end
          object chklstBind1: TCheckListBox
            Left = 79
            Top = 138
            Width = 154
            Height = 145
            BevelInner = bvNone
            BevelOuter = bvNone
            Color = clBtnFace
            ItemHeight = 14
            Items.Strings = (
              'No Trade'
              'Cant Store'
              'No Repair'
              'No Drop'
              'Never Fail'
              'No Strengthen'
              'No Sell'
              'Destroy on Drop')
            Style = lbOwnerDrawFixed
            TabOrder = 4
          end
          object chklstBind2: TCheckListBox
            Left = 240
            Top = 139
            Width = 106
            Height = 145
            BevelInner = bvNone
            BevelOuter = bvNone
            Color = clBtnFace
            ItemHeight = 14
            Items.Strings = (
              'No Open'
              'Bound')
            Style = lbOwnerDrawFixed
            TabOrder = 5
          end
          object seIndex: TSpinEdit
            Left = 79
            Top = 40
            Width = 92
            Height = 21
            MaxValue = 65535
            MinValue = 1
            TabOrder = 6
            Value = 1
          end
          object Button1: TButton
            Left = 179
            Top = 5
            Width = 82
            Height = 29
            Caption = 'Import'
            TabOrder = 7
            OnClick = Button1Click
          end
        end
        object ts3: TTabSheet
          Caption = 'Special '
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lbl6: TLabel
            Left = 4
            Top = 11
            Width = 56
            Height = 15
            Caption = 'Elements:'
          end
          object lbl8: TLabel
            Left = 4
            Top = 44
            Width = 47
            Height = 15
            Caption = 'Sockets:'
          end
          object lbl9: TLabel
            Left = 4
            Top = 78
            Width = 59
            Height = 15
            Caption = 'Socket1ID:'
          end
          object lbl10: TLabel
            Left = 149
            Top = 78
            Width = 59
            Height = 15
            Caption = 'Socket2ID:'
          end
          object lbl11: TLabel
            Left = 294
            Top = 78
            Width = 59
            Height = 15
            Caption = 'Socket3ID:'
          end
          object lbl12: TLabel
            Left = 261
            Top = 115
            Width = 73
            Height = 15
            Caption = 'Max Strength:'
          end
          object lbl13: TLabel
            Left = 4
            Top = 111
            Width = 93
            Height = 15
            Caption = 'Current Strength:'
          end
          object lbl14: TLabel
            Left = 4
            Top = 145
            Width = 46
            Height = 15
            Caption = 'Bonus3:'
          end
          object lbl18: TLabel
            Left = 223
            Top = 145
            Width = 46
            Height = 15
            Caption = 'Bonus6:'
          end
          object lbl15: TLabel
            Left = 223
            Top = 178
            Width = 53
            Height = 15
            Caption = 'Bonus12:'
          end
          object lbl16: TLabel
            Left = 4
            Top = 178
            Width = 46
            Height = 15
            Caption = 'Bonus9:'
          end
          object lbl17: TLabel
            Left = 223
            Top = 210
            Width = 53
            Height = 15
            Caption = 'Bonus18:'
          end
          object lbl19: TLabel
            Left = 4
            Top = 210
            Width = 53
            Height = 15
            Caption = 'Bonus15:'
          end
          object cbbWuXin: TComboBox
            Left = 79
            Top = 8
            Width = 62
            Height = 23
            Style = csDropDownList
            ItemHeight = 15
            TabOrder = 0
            Items.Strings = (
              'No'
              'Gold'
              'Wood'
              'Water'
              'Fire'
              'Earth')
          end
          object seFluteCount: TSpinEdit
            Left = 79
            Top = 40
            Width = 62
            Height = 21
            MaxValue = 3
            MinValue = 0
            TabOrder = 1
            Value = 1
            OnChange = seFluteCountChange
          end
          object seFlute1: TSpinEdit
            Left = 79
            Top = 74
            Width = 62
            Height = 21
            MaxValue = 65535
            MinValue = 0
            TabOrder = 2
            Value = 1
          end
          object seFlute2: TSpinEdit
            Left = 224
            Top = 74
            Width = 62
            Height = 21
            MaxValue = 65535
            MinValue = 0
            TabOrder = 3
            Value = 1
          end
          object seFlute3: TSpinEdit
            Left = 369
            Top = 74
            Width = 62
            Height = 21
            MaxValue = 65535
            MinValue = 0
            TabOrder = 4
            Value = 1
          end
          object cbbStrengthenMax: TComboBox
            Left = 366
            Top = 108
            Width = 63
            Height = 23
            Style = csDropDownList
            ItemHeight = 15
            ItemIndex = 0
            TabOrder = 5
            Text = '0'
            OnChange = cbbStrengthenMaxChange
            Items.Strings = (
              '0'
              '3'
              '6'
              '9'
              '12'
              '15'
              '18')
          end
          object seStrengthenCount: TSpinEdit
            Left = 139
            Top = 108
            Width = 62
            Height = 21
            MaxValue = 18
            MinValue = 0
            TabOrder = 6
            Value = 1
          end
          object cbbStrengthen3: TComboBox
            Left = 64
            Top = 141
            Width = 150
            Height = 20
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 7
          end
          object cbbStrengthen6: TComboBox
            Left = 279
            Top = 141
            Width = 150
            Height = 20
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
          end
          object cbbStrengthen12: TComboBox
            Left = 279
            Top = 174
            Width = 150
            Height = 20
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 9
          end
          object cbbStrengthen9: TComboBox
            Left = 64
            Top = 174
            Width = 150
            Height = 20
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 10
          end
          object cbbStrengthen18: TComboBox
            Left = 279
            Top = 206
            Width = 150
            Height = 20
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 11
          end
          object cbbStrengthen15: TComboBox
            Left = 64
            Top = 206
            Width = 150
            Height = 20
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 12
          end
        end
        object ts4: TTabSheet
          Caption = 'Addtional'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lbl20: TLabel
            Left = 4
            Top = 40
            Width = 28
            Height = 15
            Caption = 'MC2:'
          end
          object lbl21: TLabel
            Left = 4
            Top = 11
            Width = 26
            Height = 15
            Caption = 'AC2:'
          end
          object lbl22: TLabel
            Left = 4
            Top = 69
            Width = 28
            Height = 15
            Caption = 'MAC:'
          end
          object lbl23: TLabel
            Left = 4
            Top = 98
            Width = 20
            Height = 15
            Caption = 'SC:'
          end
          object lbl24: TLabel
            Left = 4
            Top = 126
            Width = 51
            Height = 15
            Caption = 'Accuracy:'
          end
          object lbl25: TLabel
            Left = 4
            Top = 155
            Width = 55
            Height = 15
            Caption = 'AntiMagic:'
          end
          object lbl26: TLabel
            Left = 4
            Top = 185
            Width = 57
            Height = 15
            Caption = 'MP Recov:'
          end
          object lbl27: TLabel
            Left = 4
            Top = 215
            Width = 37
            Height = 15
            Caption = 'Curse:'
          end
          object lbl28: TLabel
            Left = 146
            Top = 11
            Width = 35
            Height = 15
            Caption = 'MAC2:'
          end
          object lbl29: TLabel
            Left = 146
            Top = 40
            Width = 27
            Height = 15
            Caption = 'SC2:'
          end
          object lbl30: TLabel
            Left = 146
            Top = 69
            Width = 21
            Height = 15
            Caption = 'DC:'
          end
          object lbl31: TLabel
            Left = 146
            Top = 98
            Width = 27
            Height = 15
            Caption = 'HP+:'
          end
          object lbl32: TLabel
            Left = 146
            Top = 126
            Width = 34
            Height = 15
            Caption = 'Agility:'
          end
          object lbl33: TLabel
            Left = 146
            Top = 155
            Width = 55
            Height = 15
            Caption = 'AntiPoion:'
          end
          object lbl34: TLabel
            Left = 146
            Top = 185
            Width = 71
            Height = 15
            Caption = 'PoisonReco:'
          end
          object lbl35: TLabel
            Left = 146
            Top = 215
            Width = 66
            Height = 15
            Caption = 'DmgBonus:'
          end
          object lbl36: TLabel
            Left = 291
            Top = 11
            Width = 28
            Height = 15
            Caption = 'DC2:'
          end
          object lbl37: TLabel
            Left = 291
            Top = 40
            Width = 19
            Height = 15
            Caption = 'AC:'
          end
          object lbl38: TLabel
            Left = 291
            Top = 69
            Width = 21
            Height = 15
            Caption = 'MC:'
          end
          object lbl39: TLabel
            Left = 291
            Top = 98
            Width = 27
            Height = 15
            Caption = 'MP+:'
          end
          object lbl40: TLabel
            Left = 291
            Top = 128
            Width = 46
            Height = 15
            Caption = 'Strengh:'
          end
          object lbl41: TLabel
            Left = 291
            Top = 155
            Width = 57
            Height = 15
            Caption = 'HP Recov:'
          end
          object lbl42: TLabel
            Left = 291
            Top = 185
            Width = 29
            Height = 15
            Caption = 'Luck:'
          end
          object lbl43: TLabel
            Left = 291
            Top = 215
            Width = 69
            Height = 15
            Caption = 'AbsorbDmg:'
          end
          object lbl44: TLabel
            Left = 291
            Top = 245
            Width = 22
            Height = 15
            Caption = 'Crit:'
          end
          object lbl45: TLabel
            Left = 146
            Top = 245
            Width = 47
            Height = 15
            Caption = 'ElmtDef:'
          end
          object lbl46: TLabel
            Left = 4
            Top = 245
            Width = 55
            Height = 15
            Caption = 'ElmtDmg:'
          end
          object se9: TSpinEdit
            Left = 79
            Top = 8
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 0
            Value = 1
          end
          object se10: TSpinEdit
            Tag = 3
            Left = 79
            Top = 36
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 1
            Value = 1
          end
          object se11: TSpinEdit
            Tag = 6
            Left = 79
            Top = 65
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 2
            Value = 1
          end
          object se12: TSpinEdit
            Tag = 9
            Left = 79
            Top = 94
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 3
            Value = 1
          end
          object se13: TSpinEdit
            Tag = 12
            Left = 79
            Top = 123
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 4
            Value = 1
          end
          object se14: TSpinEdit
            Tag = 15
            Left = 79
            Top = 151
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 5
            Value = 1
          end
          object se15: TSpinEdit
            Tag = 18
            Left = 79
            Top = 181
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 6
            Value = 1
          end
          object se16: TSpinEdit
            Tag = 21
            Left = 79
            Top = 211
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 7
            Value = 1
          end
          object se17: TSpinEdit
            Tag = 1
            Left = 221
            Top = 8
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
          object se18: TSpinEdit
            Tag = 4
            Left = 221
            Top = 36
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 9
            Value = 1
          end
          object se19: TSpinEdit
            Tag = 7
            Left = 221
            Top = 65
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 10
            Value = 1
          end
          object se20: TSpinEdit
            Tag = 10
            Left = 221
            Top = 94
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 11
            Value = 1
          end
          object se21: TSpinEdit
            Tag = 13
            Left = 221
            Top = 123
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 12
            Value = 1
          end
          object se22: TSpinEdit
            Tag = 16
            Left = 221
            Top = 151
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 13
            Value = 1
          end
          object se23: TSpinEdit
            Tag = 19
            Left = 221
            Top = 181
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 14
            Value = 1
          end
          object se24: TSpinEdit
            Tag = 22
            Left = 221
            Top = 211
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 15
            Value = 1
          end
          object se25: TSpinEdit
            Tag = 2
            Left = 366
            Top = 8
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 16
            Value = 1
          end
          object se26: TSpinEdit
            Tag = 5
            Left = 366
            Top = 36
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 17
            Value = 1
          end
          object se27: TSpinEdit
            Tag = 8
            Left = 366
            Top = 65
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 18
            Value = 1
          end
          object se28: TSpinEdit
            Tag = 11
            Left = 366
            Top = 94
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 19
            Value = 1
          end
          object se29: TSpinEdit
            Tag = 14
            Left = 366
            Top = 123
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 20
            Value = 1
          end
          object se30: TSpinEdit
            Tag = 17
            Left = 366
            Top = 151
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 21
            Value = 1
          end
          object se31: TSpinEdit
            Tag = 20
            Left = 366
            Top = 181
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 22
            Value = 1
          end
          object se32: TSpinEdit
            Tag = 23
            Left = 366
            Top = 211
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 23
            Value = 1
          end
          object se33: TSpinEdit
            Tag = 26
            Left = 366
            Top = 241
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 24
            Value = 1
          end
          object se34: TSpinEdit
            Tag = 25
            Left = 221
            Top = 241
            Width = 63
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 25
            Value = 1
          end
          object se35: TSpinEdit
            Tag = 24
            Left = 79
            Top = 241
            Width = 62
            Height = 21
            MaxValue = 255
            MinValue = 0
            TabOrder = 26
            Value = 1
          end
        end
      end
      object btnSave: TButton
        Left = 199
        Top = 313
        Width = 67
        Height = 22
        Caption = 'Save'
        TabOrder = 2
        OnClick = btnSaveClick
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 11
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object pnl2: TPanel
    Left = 0
    Top = 11
    Width = 11
    Height = 377
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
  end
  object pnl3: TPanel
    Left = 661
    Top = 11
    Width = 12
    Height = 377
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Left = 384
    Top = 72
  end
end
