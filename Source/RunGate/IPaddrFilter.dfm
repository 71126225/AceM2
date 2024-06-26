object frmIPaddrFilter: TfrmIPaddrFilter
  Left = 376
  Top = 266
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IP Filtering'
  ClientHeight = 347
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 116
    Height = 331
    Caption = 'Curr Connection'
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 72
      Height = 12
      Caption = 'Active List:'
    end
    object ListBoxActiveList: TListBox
      Left = 8
      Top = 34
      Width = 99
      Height = 287
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      ParentShowHint = False
      PopupMenu = ActiveListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 130
    Top = 8
    Width = 225
    Height = 331
    Caption = 'IP Blocks'
    TabOrder = 1
    object LabelTempList: TLabel
      Left = 8
      Top = 16
      Width = 72
      Height = 12
      Caption = 'Temp IP Ban:'
    end
    object Label1: TLabel
      Left = 113
      Top = 16
      Width = 102
      Height = 12
      Caption = 'Permanent IP Ban:'
    end
    object Label23: TLabel
      Left = 7
      Top = 187
      Width = 48
      Height = 12
      Caption = 'IP List:'
    end
    object ListBoxBlockList: TListBox
      Left = 113
      Top = 34
      Width = 99
      Height = 146
      Hint = #27704#20037#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#27492#21015#34920#23558#20445#23384#20110#37197#32622#25991#20214#20013#65292#22312#31243#24207#37325#26032#21551#21160#26102#20250#37325#26032#21152#36733#27492#21015#34920
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      ParentShowHint = False
      PopupMenu = BlockListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
    end
    object ListBoxTempList: TListBox
      Left = 8
      Top = 34
      Width = 99
      Height = 146
      Hint = #21160#24577#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#20294#22312#31243#24207#37325#26032#21551#21160#26102#27492#21015#34920#30340#20449#24687#23558#34987#28165#31354
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      ParentShowHint = False
      PopupMenu = TempBlockListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 1
    end
    object ListBoxIpList: TListBox
      Left = 8
      Top = 204
      Width = 204
      Height = 117
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      ParentShowHint = False
      PopupMenu = IPListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 2
    end
  end
  object GroupBox6: TGroupBox
    Left = 354
    Top = 8
    Width = 187
    Height = 331
    Caption = 'Attack Protection'
    TabOrder = 2
    object GroupBox4: TGroupBox
      Left = 10
      Top = 204
      Width = 168
      Height = 117
      Caption = 'Flow Control'
      TabOrder = 0
      object Label6: TLabel
        Left = 8
        Top = 44
        Width = 54
        Height = 12
        Caption = 'Max Size:'
      end
      object Label8: TLabel
        Left = 8
        Top = 68
        Width = 54
        Height = 12
        Caption = #25968#37327#38480#21046':'
      end
      object Label5: TLabel
        Left = 8
        Top = 20
        Width = 54
        Height = 12
        Hint = 'Critical Size:'
        Caption = 'Nom Size:'
      end
      object EditMaxSize: TSpinEdit
        Left = 64
        Top = 40
        Width = 65
        Height = 21
        Hint = 
          'Data information received maximum limit, if it exceeds this size' +
          ' is considered to attack.'
        Increment = 10
        MaxValue = 10000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 6000
        OnChange = EditMaxSizeChange
      end
      object EditMaxClientMsgCount: TSpinEdit
        Left = 64
        Top = 64
        Width = 65
        Height = 21
        Hint = 
          'Amount, once receiving the data information, exceeds a specified' +
          ' quantity will be regarded as an attack.'
        MaxValue = 100
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Value = 5
        OnChange = EditMaxClientMsgCountChange
      end
      object CheckBoxLostLine: TCheckBox
        Left = 8
        Top = 91
        Width = 157
        Height = 17
        Hint = 
          'After you turn on this feature, if the client sends data exceeds' +
          ' the specified limit will be directly dropped'
        BiDiMode = bdLeftToRight
        Caption = 'Abnormal dropped processing'
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = CheckBoxLostLineClick
      end
      object EditNomSize: TSpinEdit
        Left = 64
        Top = 16
        Width = 65
        Height = 21
        Hint = 
          'The critical size of the received data information, if it exceed' +
          's this size, will be special handling.'
        Increment = 10
        MaxValue = 1000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Value = 100
        OnChange = EditNomSizeChange
      end
    end
    object GroupBox7: TGroupBox
      Left = 10
      Top = 19
      Width = 168
      Height = 179
      Caption = 'Connection Protection'
      TabOrder = 1
      object Label7: TLabel
        Left = 57
        Top = 89
        Width = 84
        Height = 12
        Caption = 'Ms/ Conn Limit'
      end
      object Label2: TLabel
        Left = 57
        Top = 114
        Width = 78
        Height = 12
        Caption = 'Ms/Conn Limit'
      end
      object Label9: TLabel
        Left = 7
        Top = 41
        Width = 90
        Height = 12
        Caption = 'Client TimeOut:'
      end
      object Label3: TLabel
        Left = 7
        Top = 19
        Width = 90
        Height = 12
        Caption = 'Max Connection:'
      end
      object Label10: TLabel
        Left = 119
        Top = 17
        Width = 48
        Height = 12
        Caption = 'Conn/IP '
      end
      object Label11: TLabel
        Left = 119
        Top = 41
        Width = 18
        Height = 12
        Caption = 'Sec'
      end
      object Label19: TLabel
        Left = 119
        Top = 64
        Width = 18
        Height = 12
        Caption = 'Min'
      end
      object Label20: TLabel
        Left = 7
        Top = 64
        Width = 84
        Height = 12
        Caption = 'SessionTimeOut'
      end
      object Edit_CountLimit1: TSpinEdit
        Left = 126
        Top = 85
        Width = 38
        Height = 21
        Hint = 
          'Ultra connection protection, the maximum allowable number of con' +
          'nections within the connection time specified.'
        MaxValue = 255
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 1
        OnChange = Edit_CountLimit1Change
      end
      object Edit_CountLimit2: TSpinEdit
        Left = 126
        Top = 110
        Width = 38
        Height = 21
        Hint = 
          'Ultra connection protection, the maximum allowable number of con' +
          'nections within the connection time specified.'
        MaxValue = 255
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Value = 1
        OnChange = Edit_CountLimit2Change
      end
      object Edit_LimitTime1: TSpinEdit
        Left = 7
        Top = 85
        Width = 47
        Height = 21
        Hint = 'Ultra-connection protection, connect the specified time.'
        Increment = 100
        MaxValue = 20000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Value = 1
        OnChange = Edit_LimitTime1Change
      end
      object Edit_LimitTime2: TSpinEdit
        Left = 7
        Top = 110
        Width = 47
        Height = 21
        Hint = 'Ultra-connection protection, connect the specified time.'
        Increment = 100
        MaxValue = 20000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Value = 1
        OnChange = Edit_LimitTime2Change
      end
      object EditMaxConnect: TSpinEdit
        Left = 75
        Top = 14
        Width = 41
        Height = 21
        MaxValue = 1000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Value = 50
        OnChange = EditMaxConnectChange
      end
      object EditClientTimeOutTime: TSpinEdit
        Left = 75
        Top = 37
        Width = 41
        Height = 21
        MaxValue = 60
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Value = 5
        OnChange = EditClientTimeOutTimeChange
      end
      object EditSessionTimeOutTime: TSpinEdit
        Left = 75
        Top = 60
        Width = 41
        Height = 21
        Hint = 
          'Interval and client communications, no data transmission over th' +
          'e time disconnected ..'
        MaxValue = 999
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        Value = 5
        OnChange = EditSessionTimeOutTimeChange
      end
      object CheckBoxCCProtect: TCheckBox
        Left = 7
        Top = 146
        Width = 147
        Height = 17
        Hint = 'This setting can prevent a certain amount of CC attack'
        Caption = 'Automatic CC Protect'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = CheckBoxCCProtectClick
      end
    end
  end
  object ButtonOK: TButton
    Left = 616
    Top = 313
    Width = 79
    Height = 26
    Caption = '&OK'
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object GroupBox5: TGroupBox
    Left = 547
    Top = 8
    Width = 148
    Height = 135
    Caption = 'Speech Settings'
    TabOrder = 4
    object Label12: TLabel
      Left = 120
      Top = 90
      Width = 18
      Height = 12
      Caption = 'Sec'
    end
    object Label13: TLabel
      Left = 120
      Top = 66
      Width = 12
      Height = 12
      Caption = #27425
    end
    object Label14: TLabel
      Left = 120
      Top = 42
      Width = 24
      Height = 12
      Caption = 'MSec'
    end
    object Label15: TLabel
      Left = 8
      Top = 43
      Width = 30
      Height = 12
      Caption = 'Time:'
    end
    object Label16: TLabel
      Left = 8
      Top = 19
      Width = 66
      Height = 12
      Caption = 'Txt Length:'
    end
    object Label17: TLabel
      Left = 8
      Top = 67
      Width = 60
      Height = 12
      Caption = 'Msg Count:'
    end
    object Label18: TLabel
      Left = 8
      Top = 91
      Width = 54
      Height = 12
      Caption = 'Gag Time:'
    end
    object MsgMaxLenSpinEdit: TSpinEdit
      Left = 64
      Top = 14
      Width = 55
      Height = 21
      Enabled = False
      MaxLength = 2
      MaxValue = 99
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = MsgMaxLenSpinEditChange
    end
    object MsgTimeSpinEdit: TSpinEdit
      Left = 64
      Top = 38
      Width = 55
      Height = 21
      Enabled = False
      Increment = 1000
      MaxValue = 99999
      MinValue = 1
      TabOrder = 1
      Value = 3000
      OnChange = MsgTimeSpinEditChange
    end
    object MsgCountSpinEdit: TSpinEdit
      Left = 64
      Top = 62
      Width = 55
      Height = 21
      Enabled = False
      MaxValue = 100
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = MsgCountSpinEditChange
    end
    object MsgCloseTimeSpinEdit: TSpinEdit
      Left = 64
      Top = 86
      Width = 55
      Height = 21
      Enabled = False
      MaxValue = 65535
      MinValue = 1
      TabOrder = 3
      Value = 1
      OnChange = MsgCloseTimeSpinEditChange
    end
    object CheckBoxBlockSay: TCheckBox
      Left = 8
      Top = 111
      Width = 105
      Height = 19
      BiDiMode = bdLeftToRight
      Caption = 'Block Say'
      Enabled = False
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = CheckBoxBlockSayClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 547
    Top = 230
    Width = 148
    Height = 73
    Caption = #25915#20987#25805#20316
    TabOrder = 5
    object RadioAddBlockList: TRadioButton
      Left = 16
      Top = 48
      Width = 129
      Height = 17
      Hint = 
        'This connection the IP to join the permanent filter list, and al' +
        'l of the IP connection forcibly interrupted'
      Caption = 'Add To Block List'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioAddBlockListClick
    end
    object RadioAddTempList: TRadioButton
      Left = 16
      Top = 32
      Width = 129
      Height = 17
      Hint = 
        'This connection the IP add dynamic filter list, and all of the I' +
        'P connection forcibly interrupt'
      Caption = 'Add To Temp List'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioAddTempListClick
    end
    object RadioDisConnect: TRadioButton
      Left = 16
      Top = 15
      Width = 129
      Height = 17
      Hint = 'Will connect disconnect processing'
      Caption = 'Disconnected'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = RadioDisConnectClick
    end
  end
  object GroupBox8: TGroupBox
    Left = 547
    Top = 149
    Width = 148
    Height = 75
    Caption = 'Variable Speed Control'
    TabOrder = 6
    object Label21: TLabel
      Left = 8
      Top = 20
      Width = 66
      Height = 12
      Caption = 'Speed Tick:'
    end
    object Label22: TLabel
      Left = 8
      Top = 44
      Width = 66
      Height = 12
      Caption = 'Speed Time:'
    end
    object EditSpeedTick: TSpinEdit
      Left = 64
      Top = 16
      Width = 65
      Height = 21
      Increment = 10
      MaxValue = 99999999
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 5000
      OnChange = EditSpeedTickChange
    end
    object EditSpeedTime: TSpinEdit
      Left = 64
      Top = 40
      Width = 65
      Height = 21
      Increment = 10
      MaxValue = 99999999
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 1000
      OnChange = EditSpeedTimeChange
    end
  end
  object BlockListPopupMenu: TPopupMenu
    OnPopup = BlockListPopupMenuPopup
    Left = 271
    Top = 117
    object BPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = BPOPMENU_SORTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_ADDTEMPLIST: TMenuItem
      Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
      OnClick = BPOPMENU_ADDTEMPLISTClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object TempBlockListPopupMenu: TPopupMenu
    OnPopup = TempBlockListPopupMenuPopup
    Left = 160
    Top = 118
    object TPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = TPOPMENU_REFLISTClick
    end
    object TPOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = TPOPMENU_SORTClick
    end
    object TPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = TPOPMENU_ADDClick
    end
    object TPOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = TPOPMENU_BLOCKLISTClick
    end
    object TPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = TPOPMENU_DELETEClick
    end
  end
  object ActiveListPopupMenu: TPopupMenu
    OnPopup = ActiveListPopupMenuPopup
    Left = 61
    Top = 204
    object APOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = APOPMENU_REFLISTClick
    end
    object APOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = APOPMENU_SORTClick
    end
    object APOPMENU_ADDTEMPLIST: TMenuItem
      Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
      OnClick = APOPMENU_ADDTEMPLISTClick
    end
    object APOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = APOPMENU_BLOCKLISTClick
    end
    object APOPMENU_KICK: TMenuItem
      Caption = #36386#38500#19979#32447'(&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
  object IPListPopupMenu: TPopupMenu
    OnPopup = IPListPopupMenuPopup
    Left = 215
    Top = 253
    object IPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = IPMENU_SORTClick
    end
    object IPMENU_ADD: TMenuItem
      Caption = #22686#21152'IP'#27573'(&A)'
      OnClick = IPMENU_ADDClick
    end
    object IPMENU_DEL: TMenuItem
      Caption = #21024#38500'IP'#27573'(&D)'
      OnClick = IPMENU_DELClick
    end
  end
end
