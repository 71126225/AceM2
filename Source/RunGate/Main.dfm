object FrmMain: TFrmMain
  Left = 445
  Top = 167
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'RunGate'
  ClientHeight = 166
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 144
    Top = 193
    Width = 38
    Height = 15
    Caption = 'Label1'
  end
  object MemoLog: TMemo
    Left = 0
    Top = 144
    Width = 335
    Height = 3
    Align = alClient
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssHorizontal
    TabOrder = 0
    OnChange = MemoLogChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 147
    Width = 335
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = '????'
        Width = 45
      end
      item
        Alignment = taCenter
        Text = '???'
        Width = 60
      end
      item
        Alignment = taCenter
        Text = '0/0/0'
        Width = 90
      end
      item
        Alignment = taCenter
        Text = '????'
        Width = -1
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 335
    Height = 144
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 335
      Height = 83
      Align = alTop
      Caption = '????'
      TabOrder = 0
      object LabelReviceMsgSize: TLabel
        Left = 15
        Top = 19
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelSendBlockSize: TLabel
        Left = 15
        Top = 39
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelBufferOfM2Size: TLabel
        Left = 144
        Top = 60
        Width = 48
        Height = 15
        Caption = '?????: 0'
      end
      object LabelSelfCheck: TLabel
        Left = 15
        Top = 60
        Width = 41
        Height = 15
        Caption = '????: 0'
      end
      object LabelPlayMsgSize: TLabel
        Left = 144
        Top = 40
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelLogonMsgSize: TLabel
        Left = 144
        Top = 20
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelProcessMsgSize: TLabel
        Left = 254
        Top = 40
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelDeCodeMsgSize: TLabel
        Left = 254
        Top = 20
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 83
      Width = 335
      Height = 61
      Align = alClient
      Caption = '????'
      TabOrder = 1
      object LabelReceTime: TLabel
        Left = 15
        Top = 19
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelSendTime: TLabel
        Left = 15
        Top = 39
        Width = 27
        Height = 15
        Caption = '??: 0'
      end
      object LabelSendLimitTime: TLabel
        Left = 125
        Top = 39
        Width = 55
        Height = 15
        Caption = '??????: 0'
      end
      object LabelReviceLimitTime: TLabel
        Left = 125
        Top = 19
        Width = 55
        Height = 15
        Caption = '??????: 0'
      end
      object Label14: TLabel
        Left = 266
        Top = 19
        Width = 28
        Height = 15
        Caption = '????'
      end
      object LabelLoopTime: TLabel
        Left = 266
        Top = 39
        Width = 53
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '0'
      end
    end
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnListen = ServerSocketListen
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 75
    Top = 102
  end
  object SendTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = SendTimerTimer
    Left = 105
    Top = 102
  end
  object ClientSocket: TClientSocket
    Active = False
    Address = '127.0.0.1'
    ClientType = ctNonBlocking
    Port = 5000
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 45
    Top = 102
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 135
    Top = 102
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 195
    Top = 102
  end
  object MainMenu: TMainMenu
    Left = 223
    Top = 102
    object MENU_CONTROL: TMenuItem
      Caption = '&Control'
      object MENU_CONTROL_START: TMenuItem
        Caption = '&Start'
        Visible = False
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = 'Stop'
        Visible = False
        OnClick = MENU_CONTROL_STOPClick
      end
      object MENU_CONTROL_RECONNECT: TMenuItem
        Caption = '&Reconnect'
        Visible = False
        OnClick = MENU_CONTROL_RECONNECTClick
      end
      object MENU_CONTROL_RELOADCONFIG: TMenuItem
        Caption = 'Reload Config'
        OnClick = MENU_CONTROL_RELOADCONFIGClick
      end
      object MENU_CONTROL_CLEAELOG: TMenuItem
        Caption = '&Clear Log'
        OnClick = MENU_CONTROL_CLEAELOGClick
      end
      object N1: TMenuItem
        Caption = 'Prohibit Connect (& F)'
        OnClick = N1Click
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = '&Exit'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object V1: TMenuItem
      Caption = '&View'
      object I2: TMenuItem
        Caption = 'Details (&I)'
        OnClick = I2Click
      end
      object G1: TMenuItem
        Caption = '&Log Message'
        OnClick = G1Click
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = '&Options'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = '&General'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_PERFORM: TMenuItem
        Caption = '&Perform'
        OnClick = MENU_OPTION_PERFORMClick
      end
      object MENU_OPTION_IPFILTER: TMenuItem
        Caption = 'IP Filter'
        OnClick = MENU_OPTION_IPFILTERClick
      end
    end
    object H1: TMenuItem
      Caption = '&Help'
      object I1: TMenuItem
        Caption = 'About'
        OnClick = I1Click
      end
    end
  end
  object StartTimer: TTimer
    Interval = 200
    OnTimer = StartTimerTimer
    Left = 165
    Top = 102
  end
  object CenterSocket: TClientSocket
    Active = False
    Address = '127.0.0.1'
    ClientType = ctNonBlocking
    Port = 5600
    OnConnect = CenterSocketConnect
    OnDisconnect = CenterSocketDisconnect
    OnRead = CenterSocketRead
    OnError = CenterSocketError
    Left = 13
    Top = 102
  end
end
