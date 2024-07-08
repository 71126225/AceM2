object FormShop: TFormShop
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GameShop Management'
  ClientHeight = 511
  ClientWidth = 941
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 918
    Height = 491
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Shop List Configuration'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 401
        Top = 294
        Width = 18
        Height = 15
        Caption = 'Idx:'
      end
      object Label6: TLabel
        Left = 401
        Top = 354
        Width = 52
        Height = 15
        Caption = 'Discount:'
      end
      object Label4: TLabel
        Left = 200
        Top = 434
        Width = 31
        Height = 15
        Caption = '????:'
        Visible = False
      end
      object Label2: TLabel
        Left = 200
        Top = 295
        Width = 37
        Height = 15
        Caption = 'Name:'
      end
      object Label1: TLabel
        Left = 200
        Top = 324
        Width = 52
        Height = 15
        Caption = 'Category:'
      end
      object Label7: TLabel
        Left = 200
        Top = 384
        Width = 68
        Height = 15
        Caption = 'Current/Max:'
      end
      object Label3: TLabel
        Left = 401
        Top = 324
        Width = 31
        Height = 15
        Caption = 'Time:'
      end
      object Label8: TLabel
        Left = 200
        Top = 353
        Width = 71
        Height = 15
        Caption = 'Gamepoints:'
      end
      object Label10: TLabel
        Left = 401
        Top = 384
        Width = 28
        Height = 15
        Caption = 'Sold:'
      end
      object Label9: TLabel
        Left = 515
        Top = 294
        Width = 59
        Height = 15
        Hint = 
          'Set whether the items are allowed to use to buy gold coins, 0 is' +
          ' not allowed'
        Caption = 'Gold price:'
      end
      object ButtonAdd: TButton
        Left = 270
        Top = 413
        Width = 94
        Height = 28
        Caption = '&Add'
        Enabled = False
        TabOrder = 0
        OnClick = ButtonAddClick
      end
      object ButtonDel: TButton
        Left = 371
        Top = 413
        Width = 94
        Height = 28
        Caption = '&Delete'
        Enabled = False
        TabOrder = 1
        OnClick = ButtonDelClick
      end
      object ButtonEdit: TButton
        Left = 473
        Top = 413
        Width = 93
        Height = 28
        Caption = '&Edit'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonEditClick
      end
      object ButtonSave: TButton
        Left = 574
        Top = 413
        Width = 94
        Height = 28
        Caption = '&Save'
        TabOrder = 3
        OnClick = ButtonSaveClick
      end
      object ButtonRefur: TButton
        Left = 675
        Top = 413
        Width = 94
        Height = 28
        Caption = '&Reload'
        TabOrder = 4
        OnClick = ButtonRefurClick
      end
      object SpinEditItems: TSpinEdit
        Left = 446
        Top = 290
        Width = 65
        Height = 27
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -15
        Font.Name = '??'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        Value = 100
      end
      object EditName: TEdit
        Left = 270
        Top = 291
        Width = 124
        Height = 25
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -15
        Font.Name = '??'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object EditText: TEdit
        Left = 270
        Top = 429
        Width = 626
        Height = 23
        MaxLength = 127
        TabOrder = 7
        Visible = False
      end
      object GroupBox4: TGroupBox
        Left = 10
        Top = 24
        Width = 183
        Height = 417
        Caption = 'ItemList(Find: Ctrl+F)'
        TabOrder = 8
        object ListBoxitemList: TListBox
          Left = 10
          Top = 20
          Width = 161
          Height = 381
          ItemHeight = 15
          TabOrder = 0
          OnClick = ListBoxitemListClick
          OnKeyDown = ListBoxitemListKeyDown
        end
      end
      object CheckBox1: TCheckBox
        Left = 688
        Top = 294
        Width = 91
        Height = 21
        Caption = 'Non-Tradable'
        TabOrder = 9
      end
      object CheckBox2: TCheckBox
        Tag = 1
        Left = 786
        Top = 295
        Width = 105
        Height = 21
        Caption = 'Non-Storage'
        TabOrder = 10
      end
      object CheckBox3: TCheckBox
        Tag = 2
        Left = 688
        Top = 314
        Width = 110
        Height = 21
        Caption = 'Not Repaired'
        TabOrder = 11
      end
      object CheckBox4: TCheckBox
        Tag = 3
        Left = 786
        Top = 314
        Width = 118
        Height = 21
        Caption = 'Not Discarded'
        TabOrder = 12
      end
      object CheckBox5: TCheckBox
        Tag = 4
        Left = 688
        Top = 334
        Width = 81
        Height = 21
        Caption = 'Not Drop'
        TabOrder = 13
      end
      object CheckBox6: TCheckBox
        Tag = 5
        Left = 786
        Top = 334
        Width = 95
        Height = 21
        Caption = 'Non-Upgrade'
        TabOrder = 14
      end
      object ButtonOutHint: TButton
        Left = 618
        Top = 425
        Width = 120
        Height = 29
        Caption = '????(&W)'
        TabOrder = 15
        Visible = False
        OnClick = ButtonOutHintClick
      end
      object ComboBoxAgio: TComboBox
        Left = 446
        Top = 350
        Width = 65
        Height = 23
        Hint = 'Discount'
        Style = csDropDownList
        ItemHeight = 15
        ItemIndex = 0
        TabOrder = 16
        Text = '10.0'
        Items.Strings = (
          '10.0'
          '9.5'
          '9'
          '8.5'
          '8'
          '7.5'
          '7'
          '6.5'
          '6'
          '5.5'
          '5'
          '4.5'
          '4'
          '3.5'
          '3'
          '2.5'
          '2'
          '1.5'
          '1'
          '0.5')
      end
      object CheckBox7: TCheckBox
        Tag = 6
        Left = 688
        Top = 351
        Width = 91
        Height = 22
        Caption = 'Not Sold'
        TabOrder = 17
      end
      object CheckBox8: TCheckBox
        Tag = 7
        Left = 786
        Top = 351
        Width = 125
        Height = 22
        Hint = 'Discarded disappear'
        Caption = 'Drop Disappear'
        TabOrder = 18
      end
      object ComboBoxClass: TComboBox
        Left = 271
        Top = 320
        Width = 124
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        TabOrder = 19
        Items.Strings = (
          'Hot'
          'Warrior'
          'Wizard'
          'Taoist')
      end
      object SpinEditCount: TSpinEdit
        Left = 270
        Top = 380
        Width = 61
        Height = 24
        MaxValue = 30000
        MinValue = -1
        TabOrder = 20
        Value = -1
      end
      object SpinEditTime: TSpinEdit
        Left = 446
        Top = 320
        Width = 65
        Height = 24
        Hint = 'Limit Time'
        MaxValue = 0
        MinValue = 0
        TabOrder = 21
        Value = 0
      end
      object SpinEditPrice: TSpinEdit
        Left = 271
        Top = 349
        Width = 124
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnChange = SpinEditPriceChange
      end
      object ListViewShopList: TListView
        Left = 200
        Top = 30
        Width = 696
        Height = 256
        Columns = <
          item
            Caption = 'Category'
            Width = 75
          end
          item
            Caption = 'Item Name'
            Width = 125
          end
          item
            Caption = 'Sold'
          end
          item
            Caption = 'ID'
            Width = 45
          end
          item
            Caption = 'Price'
            Width = 63
          end
          item
            Caption = 'Limit'
            Width = 45
          end
          item
            Caption = 'Discount'
            Width = 45
          end
          item
            Caption = 'Quantity'
            Width = 45
          end
          item
            Caption = 'Trade'
            Width = 30
          end
          item
            Caption = 'Store'
            Width = 30
          end
          item
            Caption = 'Repair'
            Width = 30
          end
          item
            Caption = 'Discard'
            Width = 30
          end
          item
            Caption = 'Drop'
            Width = 30
          end
          item
            Caption = 'Build'
            Width = 30
          end
          item
            Caption = 'Sell'
            Width = 30
          end
          item
            Caption = 'Disappear'
            Width = 30
          end
          item
            Caption = 'Gold Price'
            Width = 75
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 23
        ViewStyle = vsReport
        OnChange = ListViewShopListChange
        OnColumnClick = ListViewShopListColumnClick
        OnCompare = ListViewShopListCompare
      end
      object SpinEditSellCount: TSpinEdit
        Left = 446
        Top = 380
        Width = 65
        Height = 24
        MaxValue = 65535
        MinValue = 0
        TabOrder = 24
        Value = 0
      end
      object ComboBoxSupplyType: TComboBox
        Left = 519
        Top = 380
        Width = 190
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        TabOrder = 25
        Items.Strings = (
          'never'
          'on sold out (30min)'
          'on weekday:'
          'on weekday: (sold out)')
      end
      object SpinEditSupplyCount: TSpinEdit
        Left = 334
        Top = 380
        Width = 60
        Height = 24
        Hint = 'Automatically added to our number of settings'
        MaxValue = 30000
        MinValue = -1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 26
        Value = -1
      end
      object ComboBoxSupplyTime: TComboBox
        Left = 716
        Top = 380
        Width = 82
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        TabOrder = 27
        Items.Strings = (
          'monday'
          'thuesday'
          'wednesday'
          'thursday'
          'friday'
          'saturday'
          'sunday')
      end
      object Button1: TButton
        Left = 776
        Top = 413
        Width = 115
        Height = 28
        Caption = 'Reset Sales'
        TabOrder = 28
        OnClick = Button1Click
      end
      object EditGold: TSpinEdit
        Left = 585
        Top = 290
        Width = 83
        Height = 24
        Hint = '????????????????,?0????'
        MaxValue = 0
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 29
        Value = 0
        OnChange = SpinEditPriceChange
      end
    end
  end
end
