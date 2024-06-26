object frmConfigMerchant: TfrmConfigMerchant
  Left = 190
  Top = 330
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NPC Configuration'
  ClientHeight = 510
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBoxNPC: TGroupBox
    Left = 8
    Top = 332
    Width = 401
    Height = 137
    Caption = 'Setting'
    Enabled = False
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 72
      Height = 12
      Caption = 'Script Name:'
    end
    object Label3: TLabel
      Left = 208
      Top = 20
      Width = 54
      Height = 12
      Caption = 'Map Name:'
    end
    object Label4: TLabel
      Left = 8
      Top = 44
      Width = 30
      Height = 12
      Caption = 'Co-X:'
    end
    object Label5: TLabel
      Left = 120
      Top = 44
      Width = 12
      Height = 12
      Caption = 'Y:'
    end
    object Label6: TLabel
      Left = 8
      Top = 68
      Width = 60
      Height = 12
      Caption = 'Show Name:'
    end
    object Label7: TLabel
      Left = 208
      Top = 68
      Width = 24
      Height = 12
      Caption = 'Dir:'
    end
    object Label8: TLabel
      Left = 304
      Top = 68
      Width = 36
      Height = 12
      Caption = 'Shape:'
    end
    object Label10: TLabel
      Left = 208
      Top = 44
      Width = 54
      Height = 12
      Caption = 'Map Desc:'
    end
    object Label11: TLabel
      Left = 288
      Top = 92
      Width = 60
      Height = 12
      Caption = 'Move Time:'
    end
    object EditScriptName: TEdit
      Left = 64
      Top = 16
      Width = 121
      Height = 20
      Hint = #33050#26412#25991#20214#21517#31216#12290#25991#20214#21517#31216#20197#27492#21517#23383#21152#22320#22270#21517#32452#21512#20026#23454#38469#25991#20214#21517#12290
      TabOrder = 0
      OnChange = EditScriptNameChange
    end
    object EditMapName: TEdit
      Left = 264
      Top = 16
      Width = 121
      Height = 20
      Hint = #22320#22270#21517#31216#12290
      TabOrder = 1
      OnChange = EditMapNameChange
    end
    object EditShowName: TEdit
      Left = 64
      Top = 64
      Width = 121
      Height = 20
      TabOrder = 2
      OnChange = EditShowNameChange
    end
    object CheckBoxOfCastle: TCheckBox
      Left = 64
      Top = 88
      Width = 81
      Height = 17
      Hint = 
        'Specify this NPC belongs to the management of the castle, the NP' +
        'C will stop operating when the siege.'
      Caption = 'Castle'
      TabOrder = 3
      OnClick = CheckBoxOfCastleClick
    end
    object ComboBoxDir: TComboBox
      Left = 240
      Top = 64
      Width = 49
      Height = 20
      Hint = #40664#35748#31449#31435#26041#21521#12290
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
      OnChange = ComboBoxDirChange
    end
    object EditImageIdx: TSpinEdit
      Left = 336
      Top = 63
      Width = 49
      Height = 21
      Hint = #22806#35266#22270#24418#12290
      EditorEnabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = EditImageIdxChange
    end
    object EditX: TSpinEdit
      Left = 64
      Top = 39
      Width = 49
      Height = 21
      Hint = #24403#21069#24231#26631'X'#12290
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 6
      Value = 1
      OnChange = EditXChange
    end
    object EditY: TSpinEdit
      Left = 136
      Top = 39
      Width = 49
      Height = 21
      Hint = #24403#21069#24231#26631'Y'#12290
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 7
      Value = 1
      OnChange = EditYChange
    end
    object EditMapDesc: TEdit
      Left = 264
      Top = 40
      Width = 121
      Height = 20
      Enabled = False
      ReadOnly = True
      TabOrder = 8
    end
    object CheckBoxAutoMove: TCheckBox
      Left = 208
      Top = 88
      Width = 81
      Height = 17
      Hint = 'NPC will want to move the map with'
      Caption = 'Auto Move'
      TabOrder = 9
      OnClick = CheckBoxAutoMoveClick
    end
    object EditMoveTime: TSpinEdit
      Left = 344
      Top = 87
      Width = 41
      Height = 21
      Hint = #38543#26426#31227#21160#38388#38548#26102#38388#31186
      EditorEnabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 10
      Value = 0
      OnChange = EditMoveTimeChange
    end
  end
  object GroupBoxScript: TGroupBox
    Left = 416
    Top = 8
    Width = 401
    Height = 494
    Caption = 'Script Editor'
    Enabled = False
    TabOrder = 1
    object MemoScript: TMemo
      Left = 8
      Top = 136
      Width = 385
      Height = 351
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = MemoScriptChange
    end
    object ButtonScriptSave: TButton
      Left = 335
      Top = 25
      Width = 57
      Height = 25
      Hint = #20445#23384#33050#26412#25991#20214#12290
      Caption = '&Save'
      TabOrder = 1
      OnClick = ButtonScriptSaveClick
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 16
      Width = 321
      Height = 113
      Caption = 'Parameters'
      TabOrder = 2
      object Label9: TLabel
        Left = 8
        Top = 88
        Width = 66
        Height = 12
        Caption = 'Price rate:'
        Visible = False
      end
      object CheckBoxBuy: TCheckBox
        Left = 8
        Top = 16
        Width = 33
        Height = 17
        Caption = 'Buy'
        TabOrder = 0
        OnClick = CheckBoxBuyClick
      end
      object CheckBoxSell: TCheckBox
        Left = 8
        Top = 32
        Width = 41
        Height = 17
        Caption = 'Sell'
        TabOrder = 1
        OnClick = CheckBoxSellClick
      end
      object CheckBoxStorage: TCheckBox
        Left = 72
        Top = 32
        Width = 65
        Height = 17
        Caption = 'Store'
        TabOrder = 2
        OnClick = CheckBoxStorageClick
      end
      object CheckBoxGetback: TCheckBox
        Left = 72
        Top = 16
        Width = 65
        Height = 17
        Caption = 'Getback'
        TabOrder = 3
        OnClick = CheckBoxGetbackClick
      end
      object CheckBoxMakedrug: TCheckBox
        Left = 240
        Top = 48
        Width = 73
        Height = 17
        Caption = 'MakeDrug'
        TabOrder = 4
        OnClick = CheckBoxMakedrugClick
      end
      object CheckBoxArmStrengthen: TCheckBox
        Left = 152
        Top = 16
        Width = 82
        Height = 17
        Caption = 'Strengthen'
        TabOrder = 5
        OnClick = CheckBoxArmStrengthenClick
      end
      object CheckBoxArmUnseal: TCheckBox
        Left = 152
        Top = 32
        Width = 73
        Height = 17
        Caption = 'Unseal'
        TabOrder = 6
        OnClick = CheckBoxArmUnsealClick
      end
      object CheckBoxRepair: TCheckBox
        Left = 240
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Repair'
        TabOrder = 7
        OnClick = CheckBoxRepairClick
      end
      object CheckBoxS_repair: TCheckBox
        Left = 240
        Top = 32
        Width = 73
        Height = 17
        Caption = 'S_Repair'
        TabOrder = 8
        OnClick = CheckBoxS_repairClick
      end
      object EditPriceRate: TSpinEdit
        Left = 77
        Top = 86
        Width = 49
        Height = 21
        Hint = 'NPC transaction discounts, 80 to 80%'
        EditorEnabled = False
        MaxValue = 500
        MinValue = 60
        TabOrder = 9
        Value = 60
        Visible = False
      end
      object CheckBoxSendMsg: TCheckBox
        Left = 72
        Top = 48
        Width = 73
        Height = 17
        Caption = 'SendMsg'
        TabOrder = 10
        OnClick = CheckBoxSendMsgClick
      end
      object CheckBoxArmRemoveStone: TCheckBox
        Left = 152
        Top = 48
        Width = 82
        Height = 17
        Caption = 'RemoveStone'
        TabOrder = 11
        OnClick = CheckBoxArmRemoveStoneClick
      end
      object CheckBoxUpgradeNow: TCheckBox
        Left = 72
        Top = 64
        Width = 73
        Height = 17
        Caption = 'Upgrade'
        TabOrder = 12
        OnClick = CheckBoxUpgradeNowClick
      end
      object CheckBoxGetBackUpgnow: TCheckBox
        Left = 152
        Top = 64
        Width = 82
        Height = 17
        Caption = 'GetbackUpg'
        TabOrder = 13
        OnClick = CheckBoxGetBackUpgnowClick
      end
      object CheckBoxArmAbilityMove: TCheckBox
        Left = 240
        Top = 64
        Width = 81
        Height = 17
        Caption = 'Abil Move'
        TabOrder = 14
        OnClick = CheckBoxArmAbilityMoveClick
      end
    end
    object ButtonReLoadNpc: TButton
      Left = 336
      Top = 56
      Width = 57
      Height = 25
      Hint = #37325#26032#21152#36733'NPC'#33050#26412#12290
      Caption = '&Reload'
      Enabled = False
      TabOrder = 3
      OnClick = ButtonReLoadNpcClick
    end
  end
  object ButtonSave: TButton
    Left = 8
    Top = 476
    Width = 57
    Height = 25
    Hint = 'Save transaction NPC settings'
    Caption = '&Save'
    TabOrder = 2
    OnClick = ButtonSaveClick
  end
  object CheckBoxDenyRefStatus: TCheckBox
    Left = 328
    Top = 476
    Width = 73
    Height = 17
    Hint = 
      'Using this method, you can refresh the data of the NPC in the ga' +
      'me. Open this option for a few seconds and then shut down the NP' +
      'C changed parameters will be refreshed in the game.'
    Caption = 'Refresh'
    TabOrder = 3
    OnClick = CheckBoxDenyRefStatusClick
  end
  object ButtonClearTempData: TButton
    Left = 168
    Top = 476
    Width = 89
    Height = 25
    Hint = 
      'Clear all NPC'#39's temporary files, including temporary price and t' +
      'rading goods inventory, NPC trading articles can use this featur' +
      'e cleanup.'#13#10
    Caption = '&Clear Data'
    TabOrder = 4
    OnClick = ButtonClearTempDataClick
  end
  object ButtonViewData: TButton
    Left = 72
    Top = 476
    Width = 89
    Height = 25
    Caption = '&View Data'
    TabOrder = 5
    Visible = False
    OnClick = ButtonClearTempDataClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 401
    Height = 318
    Caption = 'NPC List:'
    TabOrder = 6
    object ListBoxMerChant: TListBox
      Left = 8
      Top = 16
      Width = 385
      Height = 290
      ItemHeight = 12
      TabOrder = 0
      OnClick = ListBoxMerChantClick
    end
  end
end
