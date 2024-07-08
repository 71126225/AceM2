object FormShop: TFormShop
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GameShop Management'
  ClientHeight = 398
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 734
    Height = 393
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Shop List Configuration'
      object Label5: TLabel
        Left = 321
        Top = 235
        Width = 24
        Height = 12
        Caption = 'Idx:'
      end
      object Label6: TLabel
        Left = 321
        Top = 283
        Width = 54
        Height = 12
        Caption = 'Discount:'
      end
      object Label4: TLabel
        Left = 156
        Top = 350
        Width = 54
        Height = 12
        Caption = 'Descript:'
        Visible = False
      end
      object Label2: TLabel
        Left = 160
        Top = 236
        Width = 30
        Height = 12
        Caption = 'Name:'
      end
      object Label1: TLabel
        Left = 160
        Top = 259
        Width = 54
        Height = 12
        Caption = 'Category:'
      end
      object Label7: TLabel
        Left = 160
        Top = 307
        Width = 72
        Height = 12
        Caption = 'Current/Max:'
      end
      object Label3: TLabel
        Left = 321
        Top = 259
        Width = 30
        Height = 12
        Caption = 'Time:'
      end
      object Label8: TLabel
        Left = 160
        Top = 282
        Width = 66
        Height = 12
        Caption = 'Gamepoints:'
      end
      object Label10: TLabel
        Left = 321
        Top = 307
        Width = 30
        Height = 12
        Caption = 'Sold:'
      end
      object Label9: TLabel
        Left = 412
        Top = 235
        Width = 66
        Height = 12
        Hint = 
          'Set whether the items are allowed to use to buy gold coins, 0 is' +
          ' not allowed'
        Caption = 'Gold price:'
      end
      object ButtonAdd: TButton
        Left = 216
        Top = 330
        Width = 75
        Height = 23
        Caption = '&Add'
        Enabled = False
        TabOrder = 0
        OnClick = ButtonAddClick
      end
      object ButtonDel: TButton
        Left = 297
        Top = 330
        Width = 75
        Height = 23
        Caption = '&Delete'
        Enabled = False
        TabOrder = 1
        OnClick = ButtonDelClick
      end
      object ButtonEdit: TButton
        Left = 378
        Top = 330
        Width = 75
        Height = 23
        Caption = '&Edit'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonEditClick
      end
      object ButtonSave: TButton
        Left = 459
        Top = 330
        Width = 75
        Height = 23
        Caption = '&Save'
        TabOrder = 3
        OnClick = ButtonSaveClick
      end
      object ButtonRefur: TButton
        Left = 540
        Top = 330
        Width = 75
        Height = 23
        Caption = '&Reload'
        TabOrder = 4
        OnClick = ButtonRefurClick
      end
      object SpinEditItems: TSpinEdit
        Left = 357
        Top = 232
        Width = 52
        Height = 21
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
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
        Left = 216
        Top = 233
        Width = 99
        Height = 20
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = '??'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object EditText: TEdit
        Left = 216
        Top = 343
        Width = 501
        Height = 20
        MaxLength = 127
        TabOrder = 7
        Visible = False
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 19
        Width = 146
        Height = 334
        Caption = 'ItemList(Find: Ctrl+F)'
        TabOrder = 8
        object ListBoxitemList: TListBox
          Left = 8
          Top = 16
          Width = 129
          Height = 305
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemListClick
          OnKeyDown = ListBoxitemListKeyDown
        end
      end
      object CheckBox1: TCheckBox
        Left = 550
        Top = 235
        Width = 73
        Height = 17
        Caption = 'Non-Tradable'
        TabOrder = 9
      end
      object CheckBox2: TCheckBox
        Tag = 1
        Left = 629
        Top = 236
        Width = 84
        Height = 17
        Caption = 'Non-Storage'
        TabOrder = 10
      end
      object CheckBox3: TCheckBox
        Tag = 2
        Left = 550
        Top = 251
        Width = 88
        Height = 17
        Caption = 'Not Repaired'
        TabOrder = 11
      end
      object CheckBox4: TCheckBox
        Tag = 3
        Left = 629
        Top = 251
        Width = 94
        Height = 17
        Caption = 'Not Discarded'
        TabOrder = 12
      end
      object CheckBox5: TCheckBox
        Tag = 4
        Left = 550
        Top = 267
        Width = 65
        Height = 17
        Caption = 'Not Drop'
        TabOrder = 13
      end
      object CheckBox6: TCheckBox
        Tag = 5
        Left = 629
        Top = 267
        Width = 76
        Height = 17
        Caption = 'Non-Upgrade'
        TabOrder = 14
      end
      object ButtonOutHint: TButton
        Left = 494
        Top = 340
        Width = 96
        Height = 23
        Caption = '????(&W)'
        TabOrder = 15
        Visible = False
        OnClick = ButtonOutHintClick
      end
      object ComboBoxAgio: TComboBox
        Left = 357
        Top = 280
        Width = 52
        Height = 20
        Hint = 'Discount'
        Style = csDropDownList
        ItemHeight = 12
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
        Left = 550
        Top = 281
        Width = 73
        Height = 17
        Caption = 'Not Sold'
        TabOrder = 17
      end
      object CheckBox8: TCheckBox
        Tag = 7
        Left = 629
        Top = 281
        Width = 100
        Height = 17
        Hint = 'Discarded disappear'
        Caption = 'Drop Disappear'
        TabOrder = 18
      end
      object ComboBoxClass: TComboBox
        Left = 217
        Top = 256
        Width = 99
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 19
        Items.Strings = (
          'Hot'
          'Warrior'
          'Wizard'
          'Taoist')
      end
      object SpinEditCount: TSpinEdit
        Left = 216
        Top = 304
        Width = 49
        Height = 21
        MaxValue = 30000
        MinValue = -1
        TabOrder = 20
        Value = -1
      end
      object SpinEditTime: TSpinEdit
        Left = 357
        Top = 256
        Width = 52
        Height = 21
        Hint = 'Limit Time'
        MaxValue = 0
        MinValue = 0
        TabOrder = 21
        Value = 0
      end
      object SpinEditPrice: TSpinEdit
        Left = 217
        Top = 279
        Width = 99
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnChange = SpinEditPriceChange
      end
      object ListViewShopList: TListView
        Left = 160
        Top = 24
        Width = 557
        Height = 205
        Columns = <
          item
            Caption = 'Category'
            Width = 60
          end
          item
            Caption = 'Item Name'
            Width = 100
          end
          item
            Caption = 'Sold'
            Width = 40
          end
          item
            Caption = 'ID'
            Width = 36
          end
          item
            Caption = 'Price'
          end
          item
            Caption = 'Limit'
            Width = 36
          end
          item
            Caption = 'Discount'
            Width = 36
          end
          item
            Caption = 'Quantity'
            Width = 36
          end
          item
            Caption = 'Trade'
            Width = 24
          end
          item
            Caption = 'Store'
            Width = 24
          end
          item
            Caption = 'Repair'
            Width = 24
          end
          item
            Caption = 'Discard'
            Width = 24
          end
          item
            Caption = 'Drop'
            Width = 24
          end
          item
            Caption = 'Build'
            Width = 24
          end
          item
            Caption = 'Sell'
            Width = 24
          end
          item
            Caption = 'Disappear'
            Width = 24
          end
          item
            Caption = 'Gold Price'
            Width = 60
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
        Left = 357
        Top = 304
        Width = 52
        Height = 21
        MaxValue = 65535
        MinValue = 0
        TabOrder = 24
        Value = 0
      end
      object ComboBoxSupplyType: TComboBox
        Left = 415
        Top = 304
        Width = 152
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 25
        Items.Strings = (
          'never'
          'on sold out (30min)'
          'on weekday:'
          'on weekday: (sold out)')
      end
      object SpinEditSupplyCount: TSpinEdit
        Left = 267
        Top = 304
        Width = 48
        Height = 21
        Hint = 'Automatically added to our number of settings'
        MaxValue = 30000
        MinValue = -1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 26
        Value = -1
      end
      object ComboBoxSupplyTime: TComboBox
        Left = 573
        Top = 304
        Width = 65
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
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
        Left = 621
        Top = 330
        Width = 92
        Height = 23
        Caption = 'Reset Sales'
        TabOrder = 28
        OnClick = Button1Click
      end
      object EditGold: TSpinEdit
        Left = 468
        Top = 232
        Width = 66
        Height = 21
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
