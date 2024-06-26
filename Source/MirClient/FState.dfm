object FrmDlg: TFrmDlg
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmDlg'
  ClientHeight = 848
  ClientWidth = 1196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DWndSay: TDWindow
    Left = 610
    Top = 8
    Width = 243
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndSayDirectPaint
    OnEndDirectPaint = DWndSayEndDirectPaint
    OnMouseDown = DWndSayMouseDown
    OnMouseUp = DWndSayMouseUp
    OnInRealArea = DWndSayInRealArea
    WheelDControl = DSayUpDown
    Caption = 'Say window'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DBackground: TDWindow
    Left = 0
    Top = 0
    Width = 434
    Height = 362
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseDown = DBackgroundMouseDown
    OnBackgroundClick = DBackgroundBackgroundClick
    Caption = 'DBackground'
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DWinSelServer: TDWindow
    Left = 8
    Top = 8
    Width = 169
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWinSelServerDirectPaint
    OnMouseMove = DWinSelServerMouseMove
    OnClick = DWinSelServerClick
    OnVisible = DWinSelServerVisible
    Caption = '?????'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DWndHint: TDWindow
    Left = 183
    Top = 8
    Width = 169
    Height = 73
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndHintDirectPaint
    OnKeyDown = DWndHintKeyDown
    OnVisible = DWndHintVisible
    Caption = 'Prompt Window'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DBTHintClose: TDButton
    Left = 239
    Top = 24
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTHintCloseDirectPaint
    OnClick = DBTHintCloseClick
    Caption = 'Close'
    DParent = DWndHint
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLogIn: TDWindow
    Left = 8
    Top = 134
    Width = 169
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLogInDirectPaint
    Caption = 'Log In'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DLoginClose: TDButton
    Left = 64
    Top = 216
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginCloseClick
    Caption = 'Close'
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginOk: TDButton
    Left = 17
    Top = 216
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Ok'
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginChgPw: TDButton
    Left = 122
    Top = 162
    Width = 52
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginChgPwClick
    Caption = 'Change Password'
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginNew: TDButton
    Left = 127
    Top = 135
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginNewClick
    Caption = 'New Account'
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditID: TDEdit
    Left = 17
    Top = 134
    Width = 80
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deCDKey
    FrameColor = clBlack
    MaxLength = 10
    CloseSpace = True
    boTransparent = True
  end
  object DEditPass: TDEdit
    Left = 17
    Top = 157
    Width = 80
    Height = 16
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DLoginHome: TDButton
    Left = 122
    Top = 189
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = DLoginHomeClick
    Caption = 'Back'
    DParent = DLogIn
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DLoginExit: TDButton
    Left = 122
    Top = 216
    Width = 50
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Exit'
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DNewAccount: TDWindow
    Left = 183
    Top = 134
    Width = 169
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DNewAccountDirectPaint
    Caption = 'New Account'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DNewAccountOk: TDButton
    Left = 280
    Top = 216
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscOKCloseChrDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Ok'
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DNewAccountCancel: TDButton
    Left = 312
    Top = 216
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscOKCloseChrDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Cancel'
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditNewId: TDEdit
    Left = 192
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deCDKey
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DEditNewPasswd: TDEdit
    Left = 192
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditConfirm: TDEdit
    Left = 192
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditEMail: TDEdit
    Left = 192
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 30
    boTransparent = True
  end
  object DEditBirthDay: TDEdit
    Left = 192
    Top = 226
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DEditQuiz1: TDEdit
    Left = 223
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditAnswer1: TDEdit
    Left = 223
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditQuiz2: TDEdit
    Left = 223
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditAnswer2: TDEdit
    Left = 223
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 20
    boTransparent = True
  end
  object DEditYourName: TDEdit
    Left = 223
    Top = 226
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 12
    boTransparent = True
  end
  object DEditPhone: TDEdit
    Left = 254
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 14
    boTransparent = True
  end
  object DEditMobPhone: TDEdit
    Left = 254
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 14
    boTransparent = True
  end
  object DEditRecommendation: TDEdit
    Left = 254
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DChgPw: TDWindow
    Left = 358
    Top = 134
    Width = 161
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DNewAccountDirectPaint
    Caption = 'Change Password'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DChgpwOk: TDButton
    Left = 389
    Top = 212
    Width = 49
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscOKCloseChrDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'OK'
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DChgpwCancel: TDButton
    Left = 452
    Top = 212
    Width = 49
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscOKCloseChrDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Cancel'
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditChgId: TDEdit
    Left = 358
    Top = 134
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deCDKey
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditChgCurrentpw: TDEdit
    Left = 358
    Top = 157
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditChgNewPw: TDEdit
    Left = 358
    Top = 180
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DEditChgRepeat: TDEdit
    Left = 358
    Top = 203
    Width = 25
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DChgPw
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    PasswordChar = '*'
    FrameColor = clBlack
    MaxLength = 15
    boTransparent = True
  end
  object DMsgDlg: TDWindow
    Left = 357
    Top = 8
    Width = 161
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMsgDlgDirectPaint
    OnKeyDown = DMsgDlgKeyDown
    OnInRealArea = DMsgDlgInRealArea
    Caption = 'Message Box'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DMsgDlgOk: TDButton
    Left = 365
    Top = 95
    Width = 69
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMsgDlgOkClick
    Caption = 'Ok'
    DParent = DMsgDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMsgDlgCancel: TDButton
    Left = 440
    Top = 95
    Width = 69
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMsgDlgOkClick
    Caption = 'Cancel'
    DParent = DMsgDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSelectChr: TDWindow
    Left = 8
    Top = 243
    Width = 169
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = '????????'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DscSelect1: TDButton
    Left = 8
    Top = 274
    Width = 57
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Character 1'
    DParent = DSelectChr
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csStone
  end
  object DscSelect2: TDButton
    Left = 8
    Top = 301
    Width = 57
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Character 2'
    DParent = DSelectChr
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csStone
  end
  object DscSelect3: TDButton
    Left = 8
    Top = 331
    Width = 57
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Character 3'
    DParent = DSelectChr
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csStone
  end
  object DscStart: TDButton
    Left = 71
    Top = 261
    Width = 102
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscSelect1DirectPaint
    OnClick = DscSelect1Click
    Caption = 'Start'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscNewChr: TDButton
    Left = 71
    Top = 284
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscSelect1DirectPaint
    OnClick = DscSelect1Click
    Caption = 'New Character'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscEraseChr: TDButton
    Left = 71
    Top = 308
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscSelect1DirectPaint
    OnClick = DscSelect1Click
    Caption = 'Store Character'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscCredits: TDButton
    Left = 71
    Top = 331
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscSelect1DirectPaint
    OnClick = DscSelect1Click
    Caption = 'Restore Character'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DscExit: TDButton
    Left = 71
    Top = 354
    Width = 101
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscSelect1DirectPaint
    OnClick = DscSelect1Click
    Caption = 'Exit'
    DParent = DSelectChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCreateChr: TDWindow
    Left = 183
    Top = 249
    Width = 169
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCreateChrDirectPaint
    OnVisible = DCreateChrVisible
    Caption = 'Create Character'
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DccWarrior: TDButton
    Left = 183
    Top = 249
    Width = 51
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Warrior'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWizzard: TDButton
    Tag = 1
    Left = 183
    Top = 272
    Width = 50
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Wizard'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccMonk: TDButton
    Tag = 2
    Left = 183
    Top = 293
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Taoist'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccJ: TDButton
    Tag = 20
    Left = 279
    Top = 315
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Gold'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccM: TDButton
    Tag = 21
    Left = 314
    Top = 315
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Wood'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccS: TDButton
    Tag = 22
    Left = 253
    Top = 284
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Water'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccH: TDButton
    Tag = 23
    Left = 288
    Top = 284
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Fire'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccT: TDButton
    Tag = 24
    Left = 323
    Top = 284
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Earth'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccMale: TDButton
    Tag = 10
    Left = 300
    Top = 249
    Width = 23
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnClick = DscSelect1Click
    Caption = 'Male'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccFemale: TDButton
    Tag = 11
    Left = 329
    Top = 249
    Width = 23
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnClick = DscSelect1Click
    Caption = 'Female'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccClose: TDButton
    Left = 229
    Top = 356
    Width = 41
    Height = 18
    DFColor = clWhite
    DFEnabledColor = clWhite
    DFMoveColor = clWhite
    DFDownColor = clSilver
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Close'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccOk: TDButton
    Left = 186
    Top = 356
    Width = 40
    Height = 18
    DFColor = clWhite
    DFEnabledColor = clWhite
    DFMoveColor = clWhite
    DFDownColor = clSilver
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Ok'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DRenewChr: TDWindow
    Left = 447
    Top = 444
    Width = 165
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DRenewChrDirectPaint
    OnClick = DRenewChrClick
    Caption = 'Restore Character'
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DEditChrName: TDEdit
    Left = 239
    Top = 261
    Width = 43
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deStandard
    FrameColor = clBlack
    MaxLength = 10
    CloseSpace = True
    boTransparent = True
  end
  object DButRenewChr: TDButton
    Left = 555
    Top = 450
    Width = 49
    Height = 21
    DFColor = clWhite
    DFEnabledColor = clWhite
    DFMoveColor = clWhite
    DFDownColor = clSilver
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Restore'
    DParent = DRenewChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DButRenewClose: TDButton
    Left = 451
    Top = 449
    Width = 50
    Height = 21
    DFColor = clWhite
    DFEnabledColor = clWhite
    DFMoveColor = clWhite
    DFDownColor = clSilver
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Close'
    DParent = DRenewChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBottom: TDWindow
    Left = 8
    Top = 383
    Width = 344
    Height = 281
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottomDirectPaint
    OnEndDirectPaint = DBottomEndDirectPaint
    OnMouseMove = DBottomMouseMove
    OnMouseDown = DBottom2MouseDown
    Caption = 'Bottom'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DMyState: TDButton
    Left = 10
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'State'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMyBag: TDButton
    Left = 45
    Top = 383
    Width = 25
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Bag'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMyMagic: TDButton
    Left = 76
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Magic'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DOption: TDButton
    Left = 271
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Options'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotTrade: TDButton
    Left = 112
    Top = 384
    Width = 25
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Trade'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotGuild: TDButton
    Left = 143
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBotGuildDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotGuildClick
    Caption = 'Guild'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotGroup: TDButton
    Left = 178
    Top = 383
    Width = 24
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Group'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotFriend: TDButton
    Left = 208
    Top = 383
    Width = 25
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Friend'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotSort: TDButton
    Left = 239
    Top = 383
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotSortClick
    Caption = 'BotSort'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTop: TDWindow
    Left = 765
    Top = 499
    Width = 88
    Height = 105
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopDirectPaint
    OnMouseMove = DTopMouseMove
    Caption = 'Top Of Status'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DTopHelp: TDButton
    Left = 777
    Top = 520
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopHelpDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopHelpClick
    Caption = 'Help'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopGM: TDButton
    Left = 765
    Top = 499
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopGMClick
    Caption = 'GM'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DOpenMinmap: TDButton
    Left = 797
    Top = 499
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DOpenMinmapDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DOpenMinmapClick
    Caption = 'MiniMap'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMiniMapDlg: TDWindow
    Left = 766
    Top = 561
    Width = 87
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMiniMapDlgDirectPaint
    OnInRealArea = DMiniMapDlgInRealArea
    Caption = 'MiniMapDlg'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DMinMap128: TDWindow
    Left = 812
    Top = 563
    Width = 41
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMinMap128DirectPaint
    OnMouseMove = DMinMap128MouseMove
    OnMouseDown = DMinMap128MouseDown
    OnMouseEntry = DMinMap128MouseEntry
    Caption = '128*128'
    DParent = DMiniMapDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DTopShop: TDButton
    Left = 777
    Top = 563
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopShopDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopShopClick
    Caption = 'Shop'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMiniMapMax: TDButton
    Left = 832
    Top = 530
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DMiniMapMaxClick
    Caption = 'MiniMapIndex'
    DParent = DMinMap128
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMaxMiniMap: TDWindow
    Left = 525
    Top = 8
    Width = 79
    Height = 57
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMaxMiniMapDirectPaint
    Caption = 'Big Mini Map'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = True
    ControlStyle = dsTop
  end
  object DMaxMinimapClose: TDButton
    Left = 544
    Top = 8
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DMaxMiniMap
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMaxMap792: TDWindow
    Left = 525
    Top = 39
    Width = 61
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMaxMap792DirectPaint
    OnMouseMove = DMaxMap792MouseMove
    OnMouseDown = DMaxMap792MouseDown
    Caption = '792*536'
    DParent = DMaxMiniMap
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DBottom2: TDWindow
    Left = 8
    Top = 464
    Width = 344
    Height = 54
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom2DirectPaint
    OnEndDirectPaint = DBottom2EndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'Bottom 2'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemBag: TDWindow
    Left = 524
    Top = 134
    Width = 161
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseMove = DItemBagMouseMove
    OnMouseDown = DItemBagMouseDown
    OnVisible = DItemBagVisible
    Caption = 'Inventory'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DItemGrid: TDGrid
    Left = 525
    Top = 133
    Width = 161
    Height = 45
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = 'Item Grid'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 9
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DGold: TDButton
    Left = 525
    Top = 216
    Width = 72
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DGoldMouseMove
    OnClick = DGoldClick
    Caption = 'Gold'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCloseBag: TDButton
    Left = 657
    Top = 216
    Width = 29
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DEditDlgEdit: TDEdit
    Left = 365
    Top = 24
    Width = 80
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnKeyDown = DMsgDlgKeyDown
    OnMouseUp = DEditIDMouseUp
    DParent = DMsgDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deChinese
    FrameColor = clBlack
    MaxLength = 70
    CloseSpace = True
    boTransparent = True
  end
  object DBTEdit: TDButton
    Left = 724
    Top = 94
    Width = 37
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTEditDirectPaint
    OnClick = DBTEditClick
    WheelDControl = DSayUpDown
    Caption = 'Edit'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBTSayLock: TDButton
    Left = 692
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTSayLockDirectPaint
    OnClick = DBTSayLockClick
    WheelDControl = DSayUpDown
    Caption = 'Lock'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTSayMove: TDButton
    Left = 692
    Top = 16
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    Caption = 'Mobile'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSayUpDown: TDUpDown
    Left = 692
    Top = 47
    Width = 26
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DSayUpDown
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = False
  end
  object DEditChat: TDImageEdit
    Left = 724
    Top = 16
    Width = 37
    Height = 25
    DFColor = clWhite
    DFEnabledColor = clYellow
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnKeyPress = DEditChatKeyPress
    OnKeyDown = DEditChatKeyDown
    OnMouseUp = DEditIDMouseUp
    OnClick = DEditChatClick
    OnVisible = DEditChatVisible
    WheelDControl = DSayUpDown
    DParent = DWndSay
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    OnChange = DEditChatChange
    OnCheckItem = DEditChatCheckItem
    OnDrawEditImage = DEditChatDrawEditImage
    MaxLength = 70
    BeginChar = '{'
    EndChar = '}'
    ImageChar = '#'
    ItemCount = 3
    ImageCount = 5
    boTransparent = True
  end
  object DBTFace: TDButton
    Left = 767
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTFaceClick
    Caption = 'Emote'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTOption: TDButton
    Left = 799
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTOptionClick
    Caption = 'Option'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DWndFace: TDWindow
    Left = 784
    Top = 16
    Width = 61
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndFaceDirectPaint
    OnMouseMove = DWndFaceMouseMove
    OnClick = DWndFaceClick
    Caption = 'Emote'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsTop
  end
  object DWudItemShow: TDWindow
    Left = 784
    Top = 47
    Width = 61
    Height = 41
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWudItemShowDirectPaint
    OnMouseMove = DWudItemShowMouseMove
    OnVisible = DWudItemShowVisible
    Caption = 'Show Equipment'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DBTItemShowClose: TDButton
    Left = 816
    Top = 47
    Width = 17
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTItemShowCloseDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DWudItemShow
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserState: TDWindow
    Left = 358
    Top = 477
    Width = 401
    Height = 135
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateDirectPaint
    OnVisible = DUserStateVisible
    Caption = '????????'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DCloseUserState: TDButton
    Left = 732
    Top = 477
    Width = 27
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMerchantDlg: TDWindow
    Left = 858
    Top = 133
    Width = 139
    Height = 110
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMerchantDlgDirectPaint
    OnMouseMove = DMerchantDlgMouseMove
    OnMouseDown = DMerchantDlgMouseDown
    OnClick = DMerchantDlgClick
    WheelDControl = DMDlgUpDonw
    Caption = 'Npc Panel'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = True
    ControlStyle = dsNone
  end
  object DMDlgUpDonw: TDUpDown
    Left = 858
    Top = 133
    Width = 109
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnEndDirectPaint = DMDlgUpDonwEndDirectPaint
    WheelDControl = DMDlgUpDonw
    DParent = DMerchantDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 10
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = True
    OnPositionChange = DMDlgUpDonwPositionChange
  end
  object DMerchantDlgClose: TDButton
    Left = 973
    Top = 180
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMerchantDlgCloseClick
    Caption = 'Close'
    DParent = DMerchantDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuDlg: TDWindow
    Left = 858
    Top = 8
    Width = 139
    Height = 120
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMenuDlgDirectPaint
    OnVisible = DMenuDlgVisible
    WheelDControl = DMenuUpDonw
    Caption = 'Shop'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = True
    ControlStyle = dsNone
  end
  object DMenuUpDonw: TDUpDown
    Left = 945
    Top = 31
    Width = 22
    Height = 42
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DMenuUpDonw
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = True
  end
  object DWndBuy: TDWindow
    Left = 692
    Top = 134
    Width = 161
    Height = 109
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndBuyDirectPaint
    OnVisible = DWndBuyVisible
    Caption = 'Purchase Items'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsTop
  end
  object DBuyOK: TDButton
    Left = 720
    Top = 212
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DBuyOKClick
    Caption = 'Buy'
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyClose: TDButton
    Left = 784
    Top = 219
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyAdd: TDButton
    Left = 720
    Top = 161
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBuyAddDirectPaint
    OnClick = DBuyAddClick
    Caption = '+'
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyDel: TDButton
    Left = 784
    Top = 162
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBuyAddDirectPaint
    OnClick = DBuyAddClick
    Caption = '-'
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBuyEdit: TDEdit
    Left = 724
    Top = 138
    Width = 80
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnKeyPress = DBuyEditKeyPress
    OnMouseUp = DEditIDMouseUp
    DParent = DWndBuy
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deInteger
    OnChange = DBuyEditChange
    FrameColor = clBlack
    MaxLength = 5
    CloseSpace = True
    boTransparent = True
  end
  object DDealDlg: TDWindow
    Left = 876
    Top = 249
    Width = 121
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DDealDlgDirectPaint
    Caption = 'Trade'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DDRGrid: TDGrid
    Left = 885
    Top = 253
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Transaction Table'
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 6
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridMouseMove = DDRGridGridMouseMove
    OnGridPaint = DDRGridGridPaint
  end
  object DDGrid: TDGrid
    Left = 888
    Top = 307
    Width = 47
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Grid'
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 6
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DDGridGridSelect
    OnGridMouseMove = DDGridGridMouseMove
    OnGridPaint = DDGridGridPaint
  end
  object DDGold: TDButton
    Left = 885
    Top = 362
    Width = 49
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DDGoldClick
    Caption = 'Gold'
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DDealOk: TDButton
    Left = 890
    Top = 335
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DDealOkClick
    Caption = 'Trade'
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DDealClose: TDButton
    Left = 980
    Top = 249
    Width = 17
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DDealCloseClick
    Caption = 'Close'
    DParent = DDealDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DDealLock: TDButton
    Left = 964
    Top = 335
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DDealLockClick
    Caption = 'Lock'
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DDRDealLock: TDCheckBox
    Left = 885
    Top = 284
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    Caption = 'Deal'
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DDRDealOk: TDCheckBox
    Left = 967
    Top = 272
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    Caption = 'Ok'
    DParent = DDealDlg
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DGroupDlg: TDWindow
    Left = 876
    Top = 390
    Width = 122
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DGroupDlgDirectPaint
    OnMouseMove = DGroupDlgMouseMove
    OnVisible = DGroupDlgVisible
    WheelDControl = DGroupUpDown
    Caption = 'Group'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DGrpCreate: TDButton
    Left = 930
    Top = 497
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGrpCreateClick
    Caption = 'Create'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGrpAddMem: TDButton
    Left = 934
    Top = 471
    Width = 29
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGrpAddMemClick
    Caption = 'Add'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGrpDelMem: TDButton
    Left = 932
    Top = 444
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGrpDelMemClick
    Caption = 'Remove'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGroupExit: TDButton
    Left = 966
    Top = 444
    Width = 31
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DGroupExitClick
    Caption = 'Exit'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCBGroupItemDef: TDCheckBox
    Left = 932
    Top = 390
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DCBGroupItemDefClick
    Caption = 'Dont Share'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DCBGroupItemRam: TDCheckBox
    Left = 932
    Top = 417
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DCBGroupItemDefClick
    Caption = 'Share Items'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DGrpAllowGroup: TDCheckBox
    Left = 885
    Top = 390
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DGrpAllowGroupClick
    Caption = 'Allow Group'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DGrpCheckGroup: TDCheckBox
    Left = 885
    Top = 417
    Width = 65
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DTopGMMouseMove
    OnClick = DGrpCheckGroupClick
    Caption = 'Prompt to Join'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 4
    OffsetTop = 1
  end
  object DGrpDlgClose: TDButton
    Left = 896
    Top = 444
    Width = 30
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DGroupUpDown: TDUpDown
    Left = 969
    Top = 460
    Width = 24
    Height = 54
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DGroupUpDown
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = False
  end
  object DGrpMemberList: TDWindow
    Left = 897
    Top = 471
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DGrpMemberListDirectPaint
    OnMouseMove = DGrpMemberListMouseMove
    OnMouseDown = DGrpMemberListMouseDown
    OnMouseUp = DGrpMemberListMouseUp
    OnDblClick = DGrpMemberListDblClick
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DGrpUserList: TDWindow
    Left = 897
    Top = 498
    Width = 33
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DGrpMemberListDirectPaint
    OnMouseMove = DGrpUserListMouseMove
    OnMouseDown = DGrpUserListMouseDown
    OnMouseUp = DGrpUserListMouseUp
    OnDblClick = DGrpUserListDblClick
    WheelDControl = DGroupUpDown
    DParent = DGroupDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DTopEMail: TDButton
    Left = 832
    Top = 499
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopEMailDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DTopEMailClick
    Caption = 'Email'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck1: TDButton
    Left = 8
    Top = 462
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 1'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck2: TDButton
    Tag = 1
    Left = 43
    Top = 464
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 2'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck3: TDButton
    Tag = 2
    Left = 78
    Top = 462
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 3'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck4: TDButton
    Tag = 3
    Left = 113
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 4'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck5: TDButton
    Tag = 4
    Left = 148
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 5'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck6: TDButton
    Tag = 5
    Left = 183
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 6'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck7: TDButton
    Tag = 6
    Left = 218
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 7'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck8: TDButton
    Tag = 7
    Left = 253
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 8'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck9: TDButton
    Tag = 8
    Left = 288
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 9'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTCheck10: TDButton
    Tag = 9
    Left = 323
    Top = 463
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTCheck1DirectPaint
    OnClick = DBTCheck1Click
    Caption = 'Detect 10'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DPopUpEdits: TDPopUpMemu
    Left = 183
    Top = 111
    Width = 169
    Height = 17
    DFColor = 9236471
    DFEnabledColor = 6320757
    DFMoveColor = 12964541
    DFDownColor = clYellow
    DFBackColor = 8
    Caption = 'View pop-up box'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Item.Strings = (
      '????'
      '????'
      '????'
      '????')
    HeightOffset = 20
    OnPopIndex = DPopUpEditsPopIndex
    Alpha = 220
  end
  object DPopUpSayList: TDPopUpMemu
    Left = 691
    Top = 115
    Width = 161
    Height = 17
    DFColor = 9236471
    DFEnabledColor = 6320757
    DFMoveColor = 12964541
    DFDownColor = clYellow
    DFBackColor = 8
    Caption = 'Say List'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Item.Strings = (
      '????'
      '????'
      '????'
      '????')
    HeightOffset = 20
    OnPopIndex = DPopUpSayListPopIndex
    Alpha = 220
  end
  object DPopUpPlay: TDPopUpMemu
    Left = 183
    Top = 87
    Width = 169
    Height = 17
    DFColor = 9236471
    DFEnabledColor = 6320757
    DFMoveColor = 12964541
    DFDownColor = clYellow
    DFBackColor = 8
    Caption = 'View pop-up box'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Item.Strings = (
      '????'
      '????'
      '????'
      '????')
    HeightOffset = 20
    OnPopIndex = DPopUpPlayPopIndex
    Alpha = 220
  end
  object DStateWin: TDWindow
    Left = 357
    Top = 249
    Width = 495
    Height = 189
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinDirectPaint
    OnVisible = DStateWinVisible
    Caption = 'State Window'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = True
    ControlStyle = dsNone
  end
  object DStateWinItem: TDWindow
    Left = 359
    Top = 247
    Width = 105
    Height = 128
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    OnMouseMove = DStateWinItemMouseMove
    OnMouseUp = DStateWinItemMouseUp
    Caption = 'StateWinRC'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DSWWeapon: TDButton
    Tag = 1
    Left = 362
    Top = 255
    Width = 28
    Height = 16
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'weapon'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCloseState: TDButton
    Left = 823
    Top = 249
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = 'Close'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSWDress: TDButton
    Left = 362
    Top = 277
    Width = 28
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'dress'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWArmRingR: TDButton
    Tag = 6
    Left = 362
    Top = 300
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'BraceR'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWRingR: TDButton
    Tag = 8
    Left = 362
    Top = 326
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'RingR'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWBelt: TDButton
    Tag = 10
    Left = 362
    Top = 347
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Belt'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWBujuk: TDButton
    Tag = 9
    Left = 397
    Top = 347
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Amulet'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWHouse: TDButton
    Tag = 13
    Left = 432
    Top = 346
    Width = 29
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Mount'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWCharm: TDButton
    Tag = 12
    Left = 397
    Top = 303
    Width = 29
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Charm'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWCowry: TDButton
    Tag = 14
    Left = 397
    Top = 326
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Cowry'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWArmRingL: TDButton
    Tag = 5
    Left = 432
    Top = 320
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'RingL'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWLight: TDButton
    Tag = 4
    Left = 432
    Top = 294
    Width = 31
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Light'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWNecklace: TDButton
    Tag = 3
    Left = 430
    Top = 271
    Width = 31
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Necklace'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWHelmet: TDButton
    Tag = 2
    Left = 430
    Top = 250
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Helm'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWBoots: TDButton
    Tag = 11
    Left = 396
    Top = 254
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Boots'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DSWRingL: TDButton
    Tag = 7
    Left = 397
    Top = 277
    Width = 29
    Height = 20
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'RingL'
    DParent = DStateWinItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DStateWinAbil: TDWindow
    Left = 470
    Top = 247
    Width = 182
    Height = 44
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = 'StateWinAbil'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateBTItem: TDButton
    Left = 757
    Top = 249
    Width = 31
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = 'Equip'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateBTAbil: TDButton
    Tag = 1
    Left = 788
    Top = 249
    Width = 29
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = 'Stats'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateBTMagic: TDButton
    Tag = 2
    Left = 727
    Top = 247
    Width = 29
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = 'Magic'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateBTInfo: TDButton
    Tag = 3
    Left = 658
    Top = 247
    Width = 40
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = 'Profile'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateAbilOk: TDButton
    Left = 470
    Top = 247
    Width = 20
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateAbilExitClick
    Caption = 'Confirm'
    DParent = DStateWinAbil
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilExit: TDButton
    Left = 489
    Top = 247
    Width = 22
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateAbilExitClick
    Caption = 'Cancel'
    DParent = DStateWinAbil
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagic: TDWindow
    Left = 358
    Top = 361
    Width = 294
    Height = 78
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    OnVisible = DStateWinMagicVisible
    Caption = 'Magic'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateWinInfo: TDWindow
    Left = 470
    Top = 293
    Width = 181
    Height = 64
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = 'State Info'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateGrid: TDGrid
    Left = 358
    Top = 388
    Width = 49
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Grid'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 2
    RowCount = 5
    ColWidth = 38
    RowHeight = 38
    Coloffset = 79
    Rowoffset = 13
    ViewTopLine = 0
    OnGridSelect = DStateGridGridSelect
    OnGridPaint = DStateGridGridPaint
  end
  object DStateAbilAdd3: TDButton
    Tag = 2
    Left = 470
    Top = 270
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+3'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel3: TDButton
    Tag = 12
    Left = 489
    Top = 270
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-3'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd1: TDButton
    Left = 518
    Top = 247
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+1'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel1: TDButton
    Tag = 10
    Left = 537
    Top = 247
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-1'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd2: TDButton
    Tag = 1
    Left = 562
    Top = 247
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+2'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel2: TDButton
    Tag = 11
    Left = 581
    Top = 247
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-2'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd4: TDButton
    Tag = 3
    Left = 508
    Top = 270
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+4'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel4: TDButton
    Tag = 13
    Left = 527
    Top = 270
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-4'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd5: TDButton
    Tag = 4
    Left = 541
    Top = 270
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+5'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel5: TDButton
    Tag = 14
    Left = 560
    Top = 270
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-5'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilAdd6: TDButton
    Tag = 5
    Left = 573
    Top = 274
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '+6'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateAbilDel6: TDButton
    Tag = 15
    Left = 592
    Top = 274
    Width = 15
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnMouseMove = DStateAbilAdd1MouseMove
    OnMouseUp = DStateAbilAdd1MouseUp
    Caption = '-6'
    DParent = DStateWinAbil
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoName: TDEdit
    Left = 501
    Top = 292
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deStandard
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    MaxLength = 8
    boTransparent = True
  end
  object DStateInfoAge: TDEdit
    Left = 501
    Top = 310
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deInteger
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    MaxLength = 2
    boTransparent = True
  end
  object DStateInfoAM: TDCheckBox
    Left = 470
    Top = 297
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Morning'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoPM: TDCheckBox
    Left = 470
    Top = 310
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Day'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoNight: TDCheckBox
    Left = 470
    Top = 320
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Afternoon'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoMidNight: TDCheckBox
    Left = 470
    Top = 328
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Evening'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DStateInfoFriend: TDCheckBox
    Left = 587
    Top = 307
    Width = 40
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Friend'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OnChange = DStateInfoNameChange
    OffsetLeft = 1
    OffsetTop = 1
  end
  object DStateInfoExit: TDButton
    Left = 610
    Top = 325
    Width = 22
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinDirectPaint
    OnClick = DStateInfoExitClick
    Caption = 'Exit'
    DParent = DStateWinMagicCboGrid
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoSave: TDButton
    Left = 587
    Top = 333
    Width = 20
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinDirectPaint
    OnClick = DStateInfoSaveClick
    Caption = 'Save'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoRefPic: TDButton
    Left = 548
    Top = 326
    Width = 20
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateInfoRefPicDirectPaint
    OnClick = DStateInfoRefPicClick
    Caption = 'ProfilePic'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoUpLoadPic: TDButton
    Left = 574
    Top = 325
    Width = 22
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateInfoRefPicClick
    Caption = 'Upload'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateInfoMemo: TDMemo
    Left = 548
    Top = 307
    Width = 33
    Height = 17
    DFColor = 11913116
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    Caption = 'Memo'
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = 8
    boTransparent = True
    MaxLength = 120
  end
  object DStateInfoArea: TDComboBox
    Left = 517
    Top = 328
    Width = 25
    Height = 18
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 8
    ShowHeight = 18
    ItemIndex = -1
  end
  object DStateInfoCity: TDComboBox
    Left = 516
    Top = 311
    Width = 25
    Height = 16
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 8
    ShowHeight = 18
    Item.Strings = (
      
        '"0_0_0",["???","???","???","???","???","???","????","???","????"' +
        ',"???","???","???","???","???","???","???","???","???","???"]'
      '"0_0",["???"]'
      
        '"0_1_0",["???","???","???","???","???","???","???","???","???","' +
        '???","???","???","???","???","???","??","???","???","???","???"]'
      '"0_1",["???"]'
      
        '"0_2_0",["???","???","???","???","???","???","???","???","???","' +
        '???","????","???","????","???","???","???","???","???","???","??' +
        '?"]'
      '"0_2",["???"]'
      
        '"0_3_0",["???","????","???","????","????","???","???","???","???' +
        '","???","???","???","???","???","???","???","????","???","???","' +
        '???","???","???","???","???","???","???","???","???","???","???"' +
        ',"??","???","???","???","???","??","????????","??????????","????' +
        '??????","??????????"]'
      '"0_3",["???"]'
      
        '"0_4_0",["???","???","???","???","???","????","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","???","???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","??","???"]'
      
        '"0_4_1",["???","???","???","????","???","???????","???","???","?' +
        '??","???","???","????","???","????","??","???","???","???","???"' +
        ',"????","???","????","???","???","???","???","???","???","???","' +
        '????"]'
      
        '"0_4_2",["???","???","??????","???","????","???","???","???","??' +
        '?","???","???","???","???","???????","???","???????","???","????' +
        '??????","???"]'
      
        '"0_4_3",["???","????","????","???","???","???","???","???","???"' +
        ',"???????","???"]'
      
        '"0_4_4",["???","???","???","???","???","???","???","???","??","?' +
        '??","???","???","???","???","???","???","???","???","???","???"]'
      
        '"0_4_5",["???","???","???","???","???","???","???","???","???","' +
        '???","???","???","???","???","???????","???"]'
      
        '"0_4_6",["???","???","???","???","???","???","????","???","???",' +
        '"???","???","??","???","???","???","???","???","???","???","???"' +
        ',"???","??","???","???","???","???","???","???","???","???","???' +
        '","??","???","???","???","???","???","???","???","???","???","??' +
        '","???"]'
      
        '"0_4_7",["???","???","???","???","???","???","???","???","???","' +
        '???","???","???","???","???","???","??","???","???","???"]'
      
        '"0_4_8",["???","???","???","???","???","???","??","??????","??",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","???","???","??","???","???????","???"]'
      
        '"0_4_9",["???","???","???","???","???","??????","???","???","???' +
        '","???","???","???","???","???","??","???","???","???","???","??' +
        '?","???","???","???","???","???","???","???","???","??","???","?' +
        '??","????","???","???"]'
      
        '"0_4_10",["???","???","???","????","???","???","???????","???","' +
        '???","???","???","???","???","??","???","??","???","???","???","' +
        '???","????","??","????","???","???","???","???","???","???","??"' +
        ',"???","???","???"]'
      
        '"0_4",["????","????","???","????","???","???","???","???","???",' +
        '"???","???"]'
      
        '"0_5_0",["????","???","???","????","????","???","???","???","???' +
        '","???","???","???","???"]'
      
        '"0_5_1",["???","???","???","???","??","???","???","???","???","?' +
        '??"]'
      
        '"0_5_2",["??","??","???","???","???","???","???","???","???","??' +
        '?","???","???","???","???","???","???","???","???"]'
      '"0_5_3",["??","??","??","???","???","??","???"]'
      
        '"0_5_4",["??","??","???","???","???","???","???","???","???","??' +
        '?","???","???","???","???","???","???","???","???","???","??","?' +
        '??","???","???"]'
      
        '"0_5_5",["??","???","???","???","???","???","???","???","???","?' +
        '??"]'
      
        '"0_5_6",["???","???","???","???","???","???","??","???","???","?' +
        '??","???","???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???"]'
      
        '"0_5_7",["???","???","???","???","???","???","???","???","???","' +
        '???","???","???","???","???","??","???","???","???","???","???"]'
      
        '"0_5_8",["???","???","???","???","???","???","???","???","???","' +
        '???","????","??","???","???","???","???","???","??","???","???",' +
        '"???","??","???","???","???","???","???","??","???","???","???"]'
      
        '"0_5_9",["???","???","???","???","???","???","???","??","???","?' +
        '?","???","???","???","???","???","??","???","???","???","???","?' +
        '??","???","???"]'
      
        '"0_5_10",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","??","???","??","???","???",' +
        '"????","???","???"]'
      
        '"0_5",["???","???","???","???","???","???","???","???","???","??' +
        '?","???"]'
      
        '"0_6_0",["???","???","???","???","????","???","???","??????","??' +
        '???","???","????","???","?????","????"]'
      
        '"0_6_1",["????","???","???","???","????","???","???","???","????' +
        '?","????","?????????","????"]'
      '"0_6_2",["????","???","???"]'
      
        '"0_6_3",["???","????","???","???","???","???","???","??????","??' +
        '?","????","???","????","???","?????","???","????","???","????","' +
        '???","???","???"]'
      
        '"0_6_4",["????","?????","???","???","???","???","???","?????","?' +
        '???","???","???????","???","???????","????"]'
      
        '"0_6_5",["????","????","????","????","???","?????","???","???","' +
        '??????","???????","??????","?????","?????","?????","??????","???' +
        '?","???????","?????","???????????","????"]'
      
        '"0_6_6",["???","????","????","????","????","?????","?????","????' +
        '","???","???","???","???","????","?????","??????"]'
      
        '"0_6_7",["???","???","???","????","???","???","???","???","???",' +
        '"???","???","???","???????","?????","???????","????","???????","' +
        '?????","????","????"]'
      
        '"0_6_8",["???","???","????","???","?????","?????","????","?????"' +
        ',"????","?????","??????","????","???"]'
      
        '"0_6_9",["?????","????","???","???","???????","????","???????","' +
        '?????","????","????"]'
      
        '"0_6_10",["?????","?????","???","?????","????","?????","?????","' +
        '?????","?????","?????","????","??????","??????","?????","????","' +
        '???","???","?????","????","????","???","???"]'
      '"0_6_11",["?????","?????","?????","????","?????"]'
      
        '"0_6",["?????","???","???","???","???","?????","?????","?????","' +
        '?????","???","?????","????"]'
      
        '"0_7_0",["???","???","???","???","???","????","???","????","???"' +
        ',"???","???","???","???","???","???","???"]'
      
        '"0_7_1",["???","???","???","???","???","??????","???","?????????' +
        '??","????"]'
      
        '"0_7_2",["???","???","???","????","???","???","???","????????","' +
        '???"]'
      
        '"0_7_3",["???","???","????","???","???","??????","???","???","??' +
        '?","???"]'
      
        '"0_7_4",["???","???","???","???","???","??????","???????","???",' +
        '"???????","???"]'
      
        '"0_7_5",["???","???","???","???","???????","???","???????","???"' +
        ']'
      '"0_7_6",["???","???","???","????","????","???","???","???"]'
      
        '"0_7_7",["???","???","???","???","???","???","???","???????","??' +
        '?"]'
      '"0_7_8",["???","???","???","???","???","???????","???"]'
      
        '"0_7_9",["???","???","????","????","????","???","????","????","?' +
        '??","???","?????"]'
      '"0_7_10",["???","???","????","???","????","???"]'
      '"0_7_11",["????","????","???","???","???","???????"]'
      '"0_7_12",["???","???","???","???","???","???","???","??","???"]'
      '"0_7_13",["???","???","???","???","???","???","???","???"]'
      
        '"0_7",["???","???","???","???","???","???","???","???","???","??' +
        '?","???","???","???","????"]'
      
        '"0_8_0",["???","???","???","???","???","???","???","???","???","' +
        '???","???"]'
      '"0_8_1",["???","???","???","???","???","???","???"]'
      
        '"0_8_2",["???","???","????","???","???","???","???","???????????' +
        '","???"]'
      
        '"0_8_3",["???","???","???","???","???","???","???","???","???","' +
        '???"]'
      '"0_8_4",["???","???","???","????","???","???","???????","???"]'
      '"0_8_5",["???","???","???","???","???","???"]'
      
        '"0_8_6",["???","????","????","???","???","????","???","???","???' +
        '","???"]'
      
        '"0_8_7",["????","???","???","?????","???","???","???","???","???' +
        '?????","???"]'
      
        '"0_8_8",["???","???","???","???","???","???","???","???","???","' +
        '???"]'
      '"0_8",["???","???","???","???","???","???","???","???","???"]'
      
        '"0_9_0",["???","???","???","???","???","???","???","???","???","' +
        '???","???","???","???","???","???","???","??","???","???","???",' +
        '"???","???","???","???","???","???"]'
      
        '"0_9_1",["???","???","???","????","?????","????","????????","???' +
        '","???","???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","???","???","???"]'
      '"0_9_2",["???","???","????","???","???"]'
      
        '"0_9_3",["???","???","?????","???","???","???","???","???","???"' +
        ']'
      
        '"0_9_4",["????","???","????","???","???","???","???","???","???"' +
        ',"???","???","??????????","???"]'
      
        '"0_9_5",["???","???","???","???","???","???","???","???","???","' +
        '???"]'
      
        '"0_9_6",["???","???","???","???","???","???","???","????","???",' +
        '"????","????","???","????","???","????","???","???","???"]'
      
        '"0_9_7",["???","???","???","???","??","???","???","???","???","?' +
        '??","???","???","???","???","???"]'
      
        '"0_9_8",["???","???","????","???","???","???","???","???","???",' +
        '"???","???","???"]'
      
        '"0_9_9",["???","???","???","???","????","???","???","???","???",' +
        '"???"]'
      
        '"0_9_10",["???","???","???","???","???","????","???","???","???"' +
        ',"???","???","???"]'
      
        '"0_9_11",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???"]'
      '"0_9_12",["???","???","???","???","???","????"]'
      
        '"0_9",["????","?????","????","???","???","???","???","????","???' +
        '?","???","????","???","????"]'
      
        '"0_10_0",["???","???","???","???","???","???","???","???","???",' +
        '"????","???","???","???","???","???"]'
      
        '"0_10_1",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","??","???","??","???"]'
      
        '"0_10_2",["???","???","???","???","???","???","???","???","???",' +
        '"???","???"]'
      '"0_10_3",["???","???","???","???","???","???","???","???"]'
      
        '"0_10_4",["???","???","???","???","???","???","???","???","???",' +
        '"????","???","???"]'
      
        '"0_10_5",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???"]'
      '"0_10_6",["???","???","???","???","???","???","???","???"]'
      '"0_10_7",["???","???","???","???","???","???"]'
      
        '"0_10_8",["???","???","???","???","???","???","???","???","???",' +
        '"???"]'
      '"0_10_9",["???","???","???","???","???","???"]'
      '"0_10_10",["???","???","????","???","???","???","???"]'
      '"0_10_11",["???","???","???","???","???","???","???","???"]'
      
        '"0_10_12",["???","???","???","???","???","???","???","???","???"' +
        ',"???","????"]'
      
        '"0_10",["???","???","????","???","???","???","???","???","???","' +
        '???","???","???","???"]'
      
        '"0_11_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","????"]'
      '"0_11_1",["???","???","???","???","???","???","???","???"]'
      '"0_11_2",["???","???","???","???","???","???","???","???","???"]'
      '"0_11_3",["???","???","???","???","???","???"]'
      
        '"0_11_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???"]'
      '"0_11_5",["???","???","???","???","???","???","???"]'
      '"0_11_6",["???","???","???","???","???","???","???","???"]'
      
        '"0_11_7",["???","???","???","???","???","???","???","???","???",' +
        '"???"]'
      
        '"0_11_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???"]'
      
        '"0_11_9",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???"]'
      
        '"0_11_10",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","?????","???"]'
      
        '"0_11",["???","???","???","???","???","???","???","???","???","?' +
        '??","???"]'
      
        '"0_12_0",["???","???","???","???","???","???","???","???","???",' +
        '"???"]'
      '"0_12_1",["???","???","???","??","???","???","???","??","???"]'
      '"0_12_2",["???","???","???","???","???"]'
      '"0_12_3",["???","???","???","???","???","???","???"]'
      
        '"0_12_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      
        '"0_12_5",["???","????","???","???","???","???","???","???","???"' +
        ',"???"]'
      '"0_12_6",["????","???","????","????","???","???","???"]'
      
        '"0_12_7",["??","???","???","???","???","???","???","???","???","' +
        '???","???","???"]'
      '"0_12_8",["???","???","????","???","???"]'
      
        '"0_12_9",["???","???","???","???","???","??","???","???","???","' +
        '???"]'
      '"0_12_10",["????","????","??","???","???"]'
      
        '"0_12_11",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???"]'
      
        '"0_12_12",["???","???","???","??","???","???","???","??","???","' +
        '???","???"]'
      
        '"0_12_13",["???","???","??","???","???","???","???","???","???",' +
        '"???","???","???"]'
      '"0_12_14",["???","???","???","???","???","???","???","??","???"]'
      '"0_12_15",["???","???","???","???","???","???","???"]'
      
        '"0_12_16",["???","???","???","???","???","???","??","???","???",' +
        '"???","???","???"]'
      
        '"0_12",["???","???","???","???","???","???","???","???","????","' +
        '???","???","???","???","???","???","???","???"]'
      
        '"0_13_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???"]'
      
        '"0_13_1",["???","???","????","???","???","???","???","???","???"' +
        ',"???","???","???","???"]'
      '"0_13_2",["???","???","???","???","???"]'
      
        '"0_13_3",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","??","???","???","???","???","???","???"' +
        ']'
      
        '"0_13_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","?"]'
      '"0_13_5",["???","???","???","???","???","???"]'
      
        '"0_13_6",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???"]'
      
        '"0_13_7",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      
        '"0_13_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???"]'
      '"0_13",["???","???","???","???","???","???","???","???","???"]'
      
        '"0_14_0",["???","???","????","???","????","???","???","???","???' +
        '","???","???","???","???"]'
      
        '"0_14_1",["???","???","???","???","????","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???","??' +
        '?","???"]'
      '"0_14_2",["???","???","???","???","???"]'
      '"0_14_3",["???","???","???","???"]'
      '"0_14_4",["???","???","???"]'
      '"0_14_5",["???","???","???","???","???","???","???","???"]'
      
        '"0_14_6",["???","???","???","??","???","???","???","???","???","' +
        '???","???","???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","????","???","?' +
        '??","???","???"]'
      
        '"0_14_7",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","???","???"]'
      
        '"0_14_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","???"]'
      
        '"0_14_9",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???"]'
      
        '"0_14_10",["???","???","????","???","???","???","???","???","???' +
        '","???","???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","???","???"]'
      
        '"0_14",["???","???","????","???","???","???","???","???","???","' +
        '???","???"]'
      
        '"0_15_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      
        '"0_15_1",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      '"0_15_2",["????","???","???","??","???","???","??","???","???"]'
      
        '"0_15_3",["???","???","???","??","???","???","???","???","???","' +
        '???","???","???","???","???","???","???","???"]'
      '"0_15_4",["???","???","???","???","???","???","???","???"]'
      
        '"0_15_5",["???","???","???","???","???","???","??","???","??","?' +
        '??","???"]'
      
        '"0_15_6",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      
        '"0_15_7",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","????"]'
      '"0_15_8",["???","???","???","???"]'
      '"0_15_9",["???","???","???","???","??","???"]'
      
        '"0_15_10",["???","???","???","???","???","???","???","???","????' +
        '","???","???","???","???","???","???","??","???","???","???","??' +
        '?","???"]'
      '"0_15_11",["???","???","???","????","???","???"]'
      
        '"0_15_12",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???"]'
      '"0_15_13",["???","???","???","???","???","???","???","???"]'
      '"0_15_14",["???","???"]'
      
        '"0_15_15",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???"]'
      
        '"0_15_16",["???","??","???","???","???","???","???","??","???","' +
        '???","???","???","???","???","???","???","???"]'
      
        '"0_15",["???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","???","???","???","???","???"]'
      
        '"0_16_0",["???","???","?????","???","???","????","???","???","??' +
        '?","???","???","???","???"]'
      
        '"0_16_1",["???","???","?????","????","???","??","???","???","???' +
        '","???","???","???","???","???","???"]'
      '"0_16_2",["???","???","???","???","???","??","???","???","???"]'
      
        '"0_16_3",["???","???","?????","???","???","???","???","???","???' +
        '","???","???","???","???","??","???","???","???","???","???","??' +
        '?","???","???","???"]'
      
        '"0_16_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","??","???"]'
      
        '"0_16_5",["???","???","???","???","???","???","???","?????","???' +
        '","???","???","???","???","???","???","???","???","???"]'
      '"0_16_6",["???","???","???","??","???","??","???"]'
      
        '"0_16_7",["???","???","???","???","???","???","?????","???","???' +
        '","??","???","???","???"]'
      
        '"0_16_8",["???","???","???","???","???","??","???","???","???","' +
        '???","???"]'
      
        '"0_16_9",["???","???","???","???","???","???","???","???","???",' +
        '"??","???","???","???","???","???"]'
      
        '"0_16_10",["???","???","???","???","?????","???","???","???","??' +
        '?"]'
      '"0_16_11",["???","???","???","???","???","???","???"]'
      
        '"0_16_12",["???","???","???","???","???","???","???","???","??",' +
        '"???","???","???","??","???"]'
      
        '"0_16_13",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???","??' +
        '?"]'
      
        '"0_16_14",["??","???","??","???","???","???","???","???","???","' +
        '???","???","???","???","???","??","???"]'
      
        '"0_16_15",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???"]'
      
        '"0_16_16",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???"]'
      
        '"0_16",["???","???","????","???","???","???","???","???","???","' +
        '???","???","???","????","???","???","???","????"]'
      
        '"0_17_0",["???","???","???","???","???","???","???","????","???"' +
        ',"???","???","???","???"]'
      
        '"0_17_1",["???","???","????","??","???","???","???","??","???","' +
        '???","???","???","???"]'
      
        '"0_17_2",["???","???","???","????","???","???","???","???","???"' +
        ',"???","???","???"]'
      '"0_17_3",["???","???","???","???","???","???","???"]'
      
        '"0_17_4",["???","???","???","???","???","???","???","???","???",' +
        '"???"]'
      
        '"0_17_5",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???"]'
      '"0_17_6",["???","????","???"]'
      '"0_17_7",["????","????","???","???","???","???","???"]'
      
        '"0_17_8",["???","???","???","???","???","???","???","???","???",' +
        '"???"]'
      
        '"0_17_9",["???","???","???","???","???","???","???","???","????"' +
        ',"???","???"]'
      
        '"0_17_10",["???","????","???","???","???","???","???","???","???' +
        '","???","???","???","???","???","?????","????","?????","???"]'
      '"0_17_11",["???","???"]'
      '"0_17_12",["???","???","???","?????","???"]'
      
        '"0_17_13",["???","???","???","???","???","???","???","???","???"' +
        ',"????","???","???","???","???"]'
      
        '"0_17",["???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","?????","???"]'
      
        '"0_18_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","????","???","???"]'
      '"0_18_1",["???","????","???","???","???","???"]'
      
        '"0_18_2",["???","???","???","???","???","???","???","??","???","' +
        '???","???","???","???","???","???"]'
      '"0_18_3",["???","???","???","??","???","???","????","???","???"]'
      
        '"0_18_4",["????","???","???","???","???","???","????","???","???' +
        '","???","???","???","???"]'
      
        '"0_18_5",["???","???","???","???","???","???","???","??","???","' +
        '???","???","???","???"]'
      '"0_18_6",["???","???","???","???","???","????"]'
      
        '"0_18_7",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???"]'
      
        '"0_18_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???"]'
      
        '"0_18_9",["????","???","???","????","??","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","?????","' +
        '???"]'
      
        '"0_18_10",["???","???","???","???","???","???","???","????","???' +
        '","???","???","???","???","???","???","???","???","???","?????",' +
        '"???"]'
      
        '"0_18_11",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","?????","???","?????","???","?????","???","??' +
        '???","???","?????","???"]'
      '"0_18_12",["???","????","???","???","???","???","???"]'
      
        '"0_18_13",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???"]'
      
        '"0_18",["???","????","???","???","???","???","???","???","???","' +
        '???","???","???","???","???"]'
      
        '"0_19_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      '"0_19_1",["???","???","???","???","???","???"]'
      
        '"0_19_2",["???","???","???","???","???","???","???","???","???",' +
        '"?????","???","?????","???"]'
      
        '"0_19_3",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","?????","???"]'
      
        '"0_19_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???"]'
      
        '"0_19_5",["???","???","??","???","???","???","???","???","???","' +
        '???","???","???","???","???"]'
      '"0_19_6",["???","???","???","???","???"]'
      '"0_19_7",["???","???","???","???","???","???","???","???"]'
      '"0_19_8",["???","???","???","???","???","???","???","???"]'
      '"0_19_9",["??","???","???","???","???","???"]'
      '"0_19_10",["???","???","???","???","???","???"]'
      '"0_19_12",["???","???","???","???","???","???"]'
      '"0_19_13",["???","???","???"]'
      '"0_19_15",["???","???","???","???","???","???","???"]'
      '"0_19_16",["???","???","???","???","???"]'
      
        '"0_19_17",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???"]'
      '"0_19_18",["???","???","???","???","???","???","???","???"]'
      '"0_19_19",["???","???","???","??","???","???"]'
      '"0_19_20",["???","???","???","???","???","???","???"]'
      
        '"0_19_21",["???","???","???","???","???","???","???","???","???"' +
        ',"???","?????","???","?????","???"]'
      
        '"0_19",["???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","???","???","???","???","???","???","???","???",' +
        '"???","???"]'
      
        '"0_20_0",["???","???","???","????","???","???","???","??","???",' +
        '"???","???","???"]'
      
        '"0_20_1",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","???","???","???","???","???","?????","???","?????","???"]'
      
        '"0_20_2",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","?????","???","?????","???"]'
      
        '"0_20_3",["???","???","???","???","???","???","??","???","???","' +
        '???"]'
      '"0_20_4",["???","???","???","???","???","???"]'
      
        '"0_20_5",["???","???","???","???","??","???","???","???","???","' +
        '???"]'
      '"0_20_6",["???","???","???","???","???","???"]'
      '"0_20_7",["???","???","????","???","???"]'
      '"0_20_8",["???","???","???","???","???"]'
      
        '"0_20_9",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???"]'
      
        '"0_20_10",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???","??' +
        '?","???","?????","???"]'
      
        '"0_20_11",["????","???","???","???","???","???","???","???","???' +
        '","???","?????","???","?????","???","?????","???","?????","???",' +
        '"?????","???"]'
      
        '"0_20_12",["???","???","???","???","???","???","???","???","????' +
        '?","???"]'
      '"0_20_13",["???","???","???","???","???","???????","???"]'
      
        '"0_20",["???","???","???","???","???","???","???","???","????","' +
        '???","???","???","???","???"]'
      '"0_21_0",["???","???","???","???"]'
      
        '"0_21_2",["???","???","???","????","???","???","???","???","???"' +
        ',"???","???","???","???","???","?????","???","?????","???","????' +
        '?","???","?????","???","?????","???","?????","???"]'
      '"0_21",["???","???","???????"]'
      
        '"0_22_0",["???","???","???","???","???","????","????","???","???' +
        '","????","???","???","???","???","??","???","??","???","???","??' +
        '?","???","???","???","???"]'
      
        '"0_22_1",["???","???","???","???","???","???","???","???","???",' +
        '"???","???"]'
      
        '"0_22_2",["???","???","???","???","???","???","???","??","???","' +
        '???","???","?????","???","???","???"]'
      '"0_22_3",["???","???","???","???","???","???","???","???"]'
      
        '"0_22_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???"]'
      '"0_22_5",["???","???","???","???","???","???","???","???"]'
      '"0_22_6",["???","???","???","???","???","???","???","???"]'
      '"0_22_7",["???","???","???","???","???","???","???","???"]'
      
        '"0_22_8",["???","???","????","????","????","???","???","???","??' +
        '?","???","???","???","???","?????","???","?????","???"]'
      '"0_22_9",["????","???","???","???","??","???","???","???"]'
      
        '"0_22_10",["???","???","????","??","???","???","???","???","???"' +
        ',"???","???"]'
      
        '"0_22_11",["???","???","???","???","???","???","???","???","???"' +
        ',"??","???","???","???","??","???","???","???","???","???"]'
      '"0_22_12",["??","??","???","???","???","???","????"]'
      '"0_22_13",["???","???","???","???","???","???","???"]'
      
        '"0_22_14",["???","???","??","???","???","???","???","???","???",' +
        '"???","??","???"]'
      '"0_22_15",["???","???","???","???","???","???"]'
      
        '"0_22_16",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???"]'
      
        '"0_22_17",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???"]'
      
        '"0_22_18",["????","????","???","???","??","????","??","???","???' +
        '","???","????","???","???","???","???","???","???","???","???","' +
        '???","???","???","????","????","???","???"]'
      
        '"0_22_19",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???","??' +
        '?","???","???","???","???","???","???","???","???","???","???","' +
        '???","???","???","???","???","???"]'
      
        '"0_22_20",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","????","???","????","???","???","' +
        '???","???","???","???","???","???","???","????","???","???","???' +
        '","???","?????","???"]'
      
        '"0_22",["???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","????","???","???","???","???","???","???","???"' +
        ',"???"]'
      
        '"0_23_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???"]'
      '"0_23_1",["???","??","???","????","???","???"]'
      
        '"0_23_2",["????","???","???","???","???","???","???","????","???' +
        '","???","???","???","???","???","???","???","???","???","???","?' +
        '??","?????","???","?????","???"]'
      
        '"0_23_3",["???","???","???","???","???","?????","???","?????","?' +
        '??","?????","???"]'
      
        '"0_23_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","?????","???"]'
      
        '"0_23_5",["???","???","???","???","???","???","???","???","???",' +
        '"?????","???","?????","???","?????","???","?????","???","????","' +
        '???"]'
      
        '"0_23_6",["???","???","???","???","???","???","???","???","??","' +
        '???","???","???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???","??' +
        '?"]'
      
        '"0_23_7",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","?????","???"]'
      
        '"0_23_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","?????"]'
      
        '"0_23",["???","????","???","???","????","????","????","???","???' +
        '?"]'
      
        '"0_24_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","?????","???","?????",' +
        '"???","?????","???"]'
      
        '"0_24_1",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???"]'
      
        '"0_24_2",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","?????","???","?????","???","?????","???"]'
      '"0_24_3",["???","???","???","???","???","???","???","???","???"]'
      
        '"0_24_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","????","???","???","???","???","???","???","???","???","??' +
        '?","????"]'
      
        '"0_24_5",["???","???","???","???","???","?????","???","?????","?' +
        '??"]'
      
        '"0_24_6",["???","?????","???","?????","???","?????","???","?????' +
        '","???","?????","???","?????","???","?????","???","?????","???",' +
        '"?????","???"]'
      
        '"0_24_7",["???","???","???","??","???","???","???","???","???","' +
        '?????","???","?????","???","?????","???"]'
      '"0_24_8",["???","???","???","???","???","???","???","???"]'
      '"0_24_9",["???","???","???","???","?????","???","?????","???"]'
      '"0_24_10",["?????","???","???","???","?????","???"]'
      
        '"0_24_11",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","????","???","???","???","???","?????","????"' +
        ',"?????","???","?????","???"]'
      
        '"0_24_12",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???"]'
      
        '"0_24_13",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","?????","' +
        '???","?????","???","?????","???"]'
      
        '"0_24_14",["???","???","???","???","???","???","????","???","???' +
        '","???","???","???","???","???","???","???"]'
      '"0_24_15",["???","???","???","???","???"]'
      
        '"0_24",["???","???","???","???","???","???","???","???","???","?' +
        '??","???","???","???","???","???","?????"]'
      
        '"0_25_0",["???","???","?????","???","????","???","???","???","??' +
        '?","?????","???","???","???","?????","???"]'
      
        '"0_25_1",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","??","???","???","???","???","???","???","???"' +
        ']'
      
        '"0_25_2",["???","???","???","???","???","???","????","???","???"' +
        ',"???","???","???","???","???","???","???","???","???","???","??' +
        '?","???","???"]'
      
        '"0_25_3",["???","???","?????","?????","???","???","???","???","?' +
        '??","???","???","????","??","??"]'
      
        '"0_25_4",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???","???' +
        '","???","???","????","????"]'
      
        '"0_25_5",["????","????","????","???","???","???","????","???","?' +
        '??","???","???","???","???","????","???","???","???","???","????' +
        '","???","???","???","???","???","???","???","????","???","???","' +
        '????","????","???","???","???","???"]'
      
        '"0_25_6",["???","????","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","???"]'
      '"0_25",["???","????","????","????","????","?????","????"]'
      
        '"0_26_0",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","??","???","???","???"]'
      
        '"0_26_1",["???","???","????","???","???","???","????","???","???' +
        '?","???","???","???","???","???","???","??","???","???","???","?' +
        '??","???","???","???","???","???"]'
      '"0_26_2",["???","???","???","???","???"]'
      
        '"0_26_3",["???","???","???","??","???","???","???","???","???","' +
        '???","???","???","???","???","???","???","???","???","???"]'
      
        '"0_26_4",["???","???","???","???","???","???","???","???","??","' +
        '???","???","???","???","???","??","???","???","???","???","???",' +
        '"???","???","???","???"]'
      
        '"0_26_5",["???","???","???","???","???","???","???","???","???",' +
        '"??","???","??","???","???","???","???","????","??","????","???"' +
        ',"???"]'
      
        '"0_26_6",["???","???","???","???","???","??","???","???","???","' +
        '??","???","???","???","???","???","???","???","???","???","???",' +
        '"????"]'
      
        '"0_26_7",["???","???","???","???","???","???","???","???","????"' +
        ',"???","???","???","???","???","???","??","???","???","????","??' +
        '?","???","???","????"]'
      
        '"0_26_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???","???","???","???","???","???","???"]'
      
        '"0_26_9",["???","???","???","???","????","???","???","???","???"' +
        ',"???","???","???","???"]'
      
        '"0_26",["???","???","???","???","???","???","???","???","???","?' +
        '??"]'
      
        '"0_27_0",["???","????","???","???","???","???","???","???","???"' +
        ',"???","???"]'
      '"0_27_1",["???","???","???","???"]'
      '"0_27_2",["???","???","???","???","???","???","???","????"]'
      
        '"0_27_3",["???","???","???","???","???","???","???","????","???"' +
        ',"???","????","????"]'
      '"0_27_4",["???","???","???","???","???","?????","????"]'
      
        '"0_27_5",["???","???","???","???","???","???","???","?????","???' +
        '?","?????","????"]'
      
        '"0_27_6",["???","???","???","???","???","???","???","???","???",' +
        '"?????","????"]'
      
        '"0_27_7",["???","???","???","??","???","???","???","???","????",' +
        '"???","???","??","???","???","???"]'
      
        '"0_27_8",["???","???","???","???","???","???","???","???","???",' +
        '"???","???","???","???"]'
      
        '"0_27_9",["???","???","???","???","???","??","???","??","???","?' +
        '??","???","???","???"]'
      
        '"0_27_10",["???","??","???","???","???","??","??","???","???","?' +
        '??","??","???","???","???","??","???"]'
      
        '"0_27_11",["???","???","???","???","???","???","????","???","???' +
        '","???","???","?????","????","?????","????"]'
      
        '"0_27_12",["???","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","???","????"]'
      
        '"0_27",["???","????","???","???","???","???","???","???","???","' +
        '???","???","???","???"]'
      
        '"0_28_0",["???","???","???","???","?????","???","???","???","???' +
        '","????"]'
      
        '"0_28_1",["???","???","???","???","?????","???","?????","???","?' +
        '????","???","?????","???"]'
      '"0_28_2",["???","????","???","???","???","????","?????","???"]'
      
        '"0_28_3",["???","????","???","?????","???","???","???","????","?' +
        '??","???"]'
      '"0_28_4",["???","???","???","????","???","???","?????","????"]'
      
        '"0_28_5",["???","???","???","????","???","???","???","???","???"' +
        ',"?????","???","???"]'
      
        '"0_28_6",["???","???","???","????","???","???","???","?????","??' +
        '?","???","????","???"]'
      '"0_28_7",["????","????","???","????","???","?????","???","???"]'
      '"0_28",["???","????","???","???","???","???","???","???"]'
      '"0_29_0",["???","???","???","???","???","???","???","???"]'
      '"0_29_1",["????","???","???","???"]'
      '"0_29_2",["???","????","???","????","???","???"]'
      '"0_29_3",["???","???","???","???","???","???","???","???","???"]'
      '"0_29_4",["????","???","???"]'
      '"0_29",["???","????","???","???","???"]'
      
        '"0_30_0",["???","?????","???","????","????","????","???","?????"' +
        ',"?????"]'
      '"0_30_1",["?????","????","????","????"]'
      '"0_30_2",["????","????","?????","????"]'
      
        '"0_30_3",["???","???","?????","???","???","????","????","???","?' +
        '??","???","???","???","?????","????","????","????","????","???",' +
        '"???","???","???","?????","????"]'
      
        '"0_30_4",["????","???","???","???","???","???","???","???","???"' +
        ',"???","???","???","???","????","????","???","???"]'
      
        '"0_30_5",["???","???","???","?????","???","???","???","???","???' +
        '","???","???","????","???","???"]'
      '"0_30_6",["????","???","???","????","????"]'
      '"0_30_7",["???","???","???","??????","????"]'
      '"0_30_8",["????","????","????","????","????","???","???"]'
      '"0_30_9",["???","???","???","???","?????"]'
      
        '"0_30_10",["???","???","???","????","????","????","????","???","' +
        '???","?????","?????","?????","???"]'
      
        '"0_30_11",["????","???","???","???","???","???","???","???","???' +
        '","???","???","???","?????","???","???","?????","???"]'
      
        '"0_30_12",["???","???","???","?????","???","???","???","???","??' +
        '?","???","???","???","????","????","????","????","?????","???"]'
      
        '"0_30_13",["???","???","???","???","???","?????","???","???","??' +
        '?","?????","?????","???"]'
      
        '"0_30_14",["????","????","????","???","?????","???","????","???"' +
        ',"????"]'
      
        '"0_30",["?????","?????","???","????","?????","????","?????","???' +
        '?","???","?????","???","?????","???","????","?????"]'
      
        '"0_31_0",["???","??","????","???","??","????","???","????","????' +
        '","???","???","??","???","???","???","???","???","???"]'
      '"0_31",["?????"]'
      '"0_32_0",["?????"]'
      '"0_32",["?????"]'
      
        '"0_33",["??","??","??","??","??","??","??","??","??","??","??","' +
        '??","??","??","??","??","??","??","??"]')
    ItemIndex = -1
  end
  object DStateInfoProvince: TDComboBox
    Left = 515
    Top = 293
    Width = 25
    Height = 17
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 8
    ShowHeight = 18
    Item.Strings = (
      ''
      'Afghanistan'
      'Akrotiri'
      'Albania'
      'Algeria'
      'American Samoa'
      'Andorra'
      'Angola'
      'Anguilla'
      'Antarctica'
      'Antigua and Barbuda'
      'Argentina'
      'Armenia'
      'Aruba'
      'Ashmore and Cartier Islands'
      'Australia'
      'Austria'
      'Azerbaijan'
      'Bahamas, The'
      'Bahrain'
      'Bangladesh'
      'Barbados'
      'Bassas da India'
      'Belarus'
      'Belgium'
      'Belize'
      'Benin'
      'Bermuda'
      'Bhutan'
      'Bolivia'
      'Bosnia and Herzegovina'
      'Botswana'
      'Bouvet Island'
      'Brazil'
      'British Indian Ocean Territory'
      'British Virgin Islands'
      'Brunei'
      'Bulgaria'
      'Burkina Faso'
      'Burma'
      'Burundi'
      'Cambodia'
      'Cameroon'
      'Canada'
      'Cape Verde'
      'Cayman Islands'
      'Central African Republic'
      'Chad'
      'Chile'
      'China'
      'Christmas Island'
      'Clipperton Island'
      'Cocos (Keeling) Islands'
      'Colombia'
      'Comoros'
      'Congo, Democratic Republic of the'
      'Congo, Republic of the'
      'Cook Islands'
      'Coral Sea Islands'
      'Costa Rica'
      'Cote d'#39'Ivoire'
      'Croatia'
      'Cuba'
      'Cyprus'
      'Czech Republic'
      'Denmark'
      'Dhekelia'
      'Djibouti'
      'Dominica'
      'Dominican Republic'
      'Ecuador'
      'Egypt'
      'El Salvador'
      'Equatorial Guinea'
      'Eritrea'
      'Estonia'
      'Ethiopia'
      'Europa Island'
      'Falkland Islands (Islas Malvinas)'
      'Faroe Islands'
      'Fiji'
      'Finland'
      'France'
      'French Guiana'
      'French Polynesia'
      'French Southern and Antarctic Lands'
      'Gabon'
      'Gambia, The'
      'Gaza Strip'
      'Georgia'
      'Germany'
      'Ghana'
      'Gibraltar'
      'Glorioso Islands'
      'Greece'
      'Greenland'
      'Grenada'
      'Guadeloupe'
      'Guam'
      'Guatemala'
      'Guernsey'
      'Guinea'
      'Guinea-Bissau'
      'Guyana'
      'Haiti'
      'Heard Island and McDonald Islands'
      'Holy See (Vatican City)'
      'Honduras'
      'Hong Kong'
      'Hungary'
      'Iceland'
      'India'
      'Indonesia'
      'Iran'
      'Iraq'
      'Ireland'
      'Isle of Man'
      'Israel'
      'Italy'
      'Jamaica'
      'Jan Mayen'
      'Japan'
      'Jersey'
      'Jordan'
      'Juan de Nova Island'
      'Kazakhstan'
      'Kenya'
      'Kiribati'
      'Korea, North'
      'Korea, South'
      'Kuwait'
      'Kyrgyzstan'
      'Laos'
      'Latvia'
      'Lebanon'
      'Lesotho'
      'Liberia'
      'Libya'
      'Liechtenstein'
      'Lithuania'
      'Luxembourg'
      'Macau'
      'Macedonia'
      'Madagascar'
      'Malawi'
      'Malaysia'
      'Maldives'
      'Mali'
      'Malta'
      'Marshall Islands'
      'Martinique'
      'Mauritania'
      'Mauritius'
      'Mayotte'
      'Mexico'
      'Micronesia, Federated States of'
      'Moldova'
      'Monaco'
      'Mongolia'
      'Montserrat'
      'Morocco'
      'Mozambique'
      'Namibia'
      'Nauru'
      'Navassa Island'
      'Nepal'
      'Netherlands'
      'Netherlands Antilles'
      'New Caledonia'
      'New Zealand'
      'Nicaragua'
      'Niger'
      'Nigeria'
      'Niue'
      'Norfolk Island'
      'Northern Mariana Islands'
      'Norway'
      'Oman'
      'Pakistan'
      'Palau'
      'Panama'
      'Papua New Guinea'
      'Paracel Islands'
      'Paraguay'
      'Peru'
      'Philippines'
      'Pitcairn Islands'
      'Poland'
      'Portugal'
      'Puerto Rico'
      'Qatar'
      'Reunion'
      'Romania'
      'Russia'
      'Rwanda'
      'Saint Helena'
      'Saint Kitts and Nevis'
      'Saint Lucia'
      'Saint Pierre and Miquelon'
      'Saint Vincent and the Grenadines'
      'Samoa'
      'San Marino'
      'Sao Tome and Principe'
      'Saudi Arabia'
      'Senegal'
      'Serbia and Montenegro'
      'Seychelles'
      'Sierra Leone'
      'Singapore'
      'Slovakia'
      'Slovenia'
      'Solomon Islands'
      'Somalia'
      'South Africa'
      'South Georgia and the South Sandwich Islands'
      'Spain'
      'Spratly Islands'
      'Sri Lanka'
      'Sudan'
      'Suriname'
      'Svalbard'
      'Swaziland'
      'Sweden'
      'Switzerland'
      'Syria'
      'Taiwan'
      'Tajikistan'
      'Tanzania'
      'Thailand'
      'Timor-Leste'
      'Togo'
      'Tokelau'
      'Tonga'
      'Trinidad and Tobago'
      'Tromelin Island'
      'Tunisia'
      'Turkey'
      'Turkmenistan'
      'Turks and Caicos Islands'
      'Tuvalu'
      'Uganda'
      'Ukraine'
      'United Arab Emirates'
      'United Kingdom'
      'United States'
      'Uruguay'
      'Uzbekistan'
      'Vanuatu'
      'Venezuela'
      'Vietnam'
      'Virgin Islands'
      'Wake Island'
      'Wallis and Futuna'
      'West Bank'
      'Western Sahara'
      'Yemen'
      'Zambia'
      'Zimbabwe'
      '???'
      '???'
      '???'
      '??'#10'?'
      '???'
      '???'
      '???'
      '???'
      '??'
      '???'
      '???'
      '??'#10'?'
      '???'
      '??'
      '???'
      '???'
      '???'
      '??'
      '??'
      '??'
      '?'#10'?'
      '???')
    ItemIndex = -1
  end
  object DStateInfoSex: TDComboBox
    Left = 501
    Top = 328
    Width = 25
    Height = 18
    DFColor = 14605278
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DStateWinInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    OnChange = DStateInfoNameChange
    FrameColor = clBlack
    boTransparent = True
    ShowCount = 5
    ShowHeight = 18
    Item.Strings = (
      'male'
      'female')
    ItemIndex = -1
  end
  object DUserStateItem: TDWindow
    Left = 362
    Top = 477
    Width = 122
    Height = 132
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateItemDirectPaint
    OnMouseMove = DUserStateItemMouseMove
    OnClick = DUserStateItemClick
    Caption = '????'
    DParent = DUserState
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DWeaponUS1: TDButton
    Tag = 1
    Left = 368
    Top = 475
    Width = 28
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Weapon'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DDressUS1: TDButton
    Left = 367
    Top = 499
    Width = 29
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Dress'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DArmringRUS1: TDButton
    Tag = 6
    Left = 368
    Top = 522
    Width = 29
    Height = 19
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'BraceR'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DRingRUS1: TDButton
    Tag = 8
    Left = 368
    Top = 547
    Width = 29
    Height = 23
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'RingR'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBeltUS1: TDButton
    Tag = 10
    Left = 368
    Top = 576
    Width = 28
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Belt'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCharmUS1: TDButton
    Tag = 12
    Left = 403
    Top = 552
    Width = 36
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Charm'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBujukUS1: TDButton
    Tag = 9
    Left = 402
    Top = 576
    Width = 37
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Amulet'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHouseUS1: TDButton
    Tag = 13
    Left = 445
    Top = 578
    Width = 39
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Mount'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DCowryUS1: TDButton
    Tag = 14
    Left = 403
    Top = 524
    Width = 39
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Cowry'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBootsUS1: TDButton
    Tag = 11
    Left = 402
    Top = 476
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Boots'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DRingLUS1: TDButton
    Tag = 7
    Left = 445
    Top = 555
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'RingL'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DArmringLUS1: TDButton
    Tag = 5
    Left = 448
    Top = 535
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'BraceL'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DLightUS1: TDButton
    Tag = 4
    Left = 445
    Top = 515
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Light'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DNecklaceUS1: TDButton
    Tag = 3
    Left = 447
    Top = 495
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Neck'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHelmetUS1: TDButton
    Tag = 2
    Left = 442
    Top = 476
    Width = 39
    Height = 14
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWeaponUS1DirectPaint
    OnMouseMove = DWeaponUS1MouseMove
    Caption = 'Helm'
    DParent = DUserStateItem
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUserStateInfo: TDWindow
    Left = 490
    Top = 477
    Width = 102
    Height = 132
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateItemDirectPaint
    Caption = 'UserState'
    DParent = DUserState
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DUserStateInfoName: TDEdit
    Left = 487
    Top = 493
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deStandard
    FrameColor = clBlack
    MaxLength = 8
    boTransparent = True
  end
  object DUserStateInfoAge: TDEdit
    Left = 487
    Top = 516
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deInteger
    FrameColor = clBlack
    MaxLength = 2
    boTransparent = True
  end
  object DUserStateInfoMemo: TDMemo
    Left = 515
    Top = 552
    Width = 33
    Height = 17
    DFColor = 11913116
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Memo'
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = 8
    boTransparent = True
    MaxLength = 120
  end
  object DUserStateInfoRefPic: TDButton
    Left = 489
    Top = 583
    Width = 46
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateInfoRefPicClick
    Caption = 'ProfilePic'
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserStateInforeport: TDButton
    Left = 541
    Top = 583
    Width = 51
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'ReportImg'
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserStateInfoFriend: TDCheckBox
    Left = 490
    Top = 562
    Width = 48
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Friend'
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 1
    OffsetTop = 1
  end
  object DUserStateInfoMidNight: TDCheckBox
    Left = 549
    Top = 552
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'MNight'
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateInfoNight: TDCheckBox
    Left = 549
    Top = 534
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Night'
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateInfoPM: TDCheckBox
    Left = 547
    Top = 516
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Noon'
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateInfoAM: TDCheckBox
    Left = 548
    Top = 498
    Width = 25
    Height = 12
    DFColor = 12896698
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Morn'
    DParent = DUserStateInfo
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    Checked = False
    FontSpace = 3
    OffsetLeft = 0
    OffsetTop = 1
  end
  object DUserStateBTItem: TDButton
    Left = 658
    Top = 477
    Width = 31
    Height = 15
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateBTInfoDirectPaint
    OnClick = DUserStateBTItemClick
    Caption = 'Equip'
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DUserStateBTInfo: TDButton
    Tag = 3
    Left = 599
    Top = 477
    Width = 53
    Height = 15
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateBTInfoDirectPaint
    OnClick = DUserStateBTItemClick
    Caption = 'Info'
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DUserStateInfoSex: TDEdit
    Left = 487
    Top = 535
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 2
    boTransparent = True
  end
  object DUserStateInfoArea: TDEdit
    Left = 517
    Top = 539
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DUserStateInfoProvince: TDEdit
    Left = 517
    Top = 493
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DUserStateInfoCity: TDEdit
    Left = 517
    Top = 516
    Width = 24
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    DParent = DUserStateInfo
    Visible = True
    Enabled = True
    ReadOnly = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deNone
    FrameColor = clBlack
    MaxLength = 10
    boTransparent = True
  end
  object DItemAddBag1: TDButton
    Left = 525
    Top = 183
    Width = 34
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemAddBag1DirectPaint
    OnMouseMove = DItemAddBag1MouseMove
    OnMouseUp = DItemAddBag1MouseUp
    Caption = 'Add Bag1'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DItemAddBag2: TDButton
    Tag = 1
    Left = 565
    Top = 185
    Width = 34
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemAddBag1DirectPaint
    OnMouseMove = DItemAddBag1MouseMove
    OnMouseUp = DItemAddBag1MouseUp
    Caption = 'AddBag2'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DItemAddBag3: TDButton
    Tag = 2
    Left = 603
    Top = 185
    Width = 34
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemAddBag1DirectPaint
    OnMouseMove = DItemAddBag1MouseMove
    OnMouseUp = DItemAddBag1MouseUp
    Caption = 'AddBag3'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DItemAppendBag1: TDWindow
    Tag = 1
    Left = 525
    Top = 134
    Width = 53
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseDown = DItemBagMouseDown
    Caption = 'Bag 1'
    DParent = DItemBag
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemAppendBag2: TDWindow
    Tag = 2
    Left = 584
    Top = 134
    Width = 53
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseDown = DItemBagMouseDown
    Caption = 'Bag 2'
    DParent = DItemBag
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemAppendBag3: TDWindow
    Tag = 3
    Left = 643
    Top = 134
    Width = 53
    Height = 37
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagDirectPaint
    OnMouseDown = DItemBagMouseDown
    Caption = 'Bag 3'
    DParent = DItemBag
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DItemGrid1: TDGrid
    Tag = 1
    Left = 525
    Top = 134
    Width = 40
    Height = 29
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = 'Item Grid 1'
    DParent = DItemAppendBag1
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DItemGrid2: TDGrid
    Tag = 2
    Left = 584
    Top = 134
    Width = 40
    Height = 29
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = 'Item Grid 2'
    DParent = DItemAppendBag2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DItemGrid3: TDGrid
    Tag = 3
    Left = 643
    Top = 134
    Width = 40
    Height = 29
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DItemGridDblClick
    Caption = 'Item Grid 3'
    DParent = DItemAppendBag3
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 2
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DItemGridGridSelect
    OnGridMouseMove = DItemGridGridMouseMove
    OnGridPaint = DItemGridGridPaint
  end
  object DItemBagRef: TDButton
    Left = 622
    Top = 216
    Width = 29
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DItemBagRefDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DItemBagRefClick
    Caption = 'Refresh'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DItemBagShop: TDButton
    Left = 587
    Top = 216
    Width = 29
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DItemBagShopClick
    Caption = 'BagShop'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTTakeHorse: TDButton
    Left = 826
    Top = 94
    Width = 26
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTTakeHorseDirectPaint
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTTakeHorseClick
    Caption = 'Horse'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackMode: TDButton
    Left = 291
    Top = 494
    Width = 61
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeClick
    Caption = 'Attack Mode'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DWndAttackModeList: TDWindow
    Left = 8
    Top = 493
    Width = 277
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DWndAttackModeListDirectPaint
    Caption = '????????'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsTop
  end
  object DBTAttackModeAll: TDButton
    Left = 8
    Top = 493
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Attack All'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModePeace: TDButton
    Tag = 1
    Left = 64
    Top = 495
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Peacefull Attack'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeDear: TDButton
    Tag = 2
    Left = 120
    Top = 494
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Marriage Attack'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeMaster: TDButton
    Tag = 3
    Left = 176
    Top = 494
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Master Attack'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeGroup: TDButton
    Tag = 4
    Left = 232
    Top = 494
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Group Attack'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModeGuild: TDButton
    Tag = 5
    Left = 22
    Top = 440
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Guild Attack'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBTAttackModePK: TDButton
    Tag = 6
    Left = 78
    Top = 445
    Width = 50
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    OnClick = DBTAttackModeGuildClick
    Caption = 'Red And White Attack'
    DParent = DWndAttackModeList
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuShop: TDButton
    Left = 859
    Top = 13
    Width = 49
    Height = 17
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMenuShopDirectPaint
    OnClick = DMenuShopClick
    WheelDControl = DMenuUpDonw
    Caption = 'For Sale'
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMenuReturn: TDButton
    Tag = 1
    Left = 914
    Top = 8
    Width = 49
    Height = 17
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMenuShopDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DMenuShopClick
    WheelDControl = DMenuUpDonw
    Caption = 'Buy Back'
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMenuRepairAll: TDButton
    Left = 909
    Top = 104
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = 'RepAll'
    DParent = DMenuDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuSuperRepairAll: TDButton
    Left = 956
    Top = 106
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = 'SRepAll'
    DParent = DMenuDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuRepair: TDButton
    Left = 909
    Top = 77
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = 'Repair'
    DParent = DMenuDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuSuperRepair: TDButton
    Left = 956
    Top = 79
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = 'SRepair'
    DParent = DMenuDlg
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuBuy: TDButton
    Left = 862
    Top = 77
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = 'Buy'
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuSell: TDButton
    Left = 862
    Top = 104
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMenuSellClick
    WheelDControl = DMenuUpDonw
    Caption = 'Sell'
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuClose: TDButton
    Left = 969
    Top = 8
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DSaleDlgCloseClick
    WheelDControl = DMenuUpDonw
    Caption = 'Close'
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMenuGrid: TDGrid
    Tag = 1
    Left = 859
    Top = 31
    Width = 64
    Height = 40
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DMenuUpDonw
    Caption = 'MenuGrid'
    DParent = DMenuDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 6
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DMenuGridGridSelect
    OnGridMouseMove = DMenuGridGridMouseMove
    OnGridPaint = DMenuGridGridPaint
  end
  object DMagicFront: TDButton
    Left = 358
    Top = 426
    Width = 44
    Height = 17
    DFColor = 11922415
    DFEnabledColor = clWhite
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicFrontDirectPaint
    OnClick = DMagicFrontClick
    Caption = 'Prev'
    DParent = DStateWinMagic
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMagicNext: TDButton
    Left = 405
    Top = 426
    Width = 38
    Height = 17
    DFColor = 11922415
    DFEnabledColor = clWhite
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicFrontDirectPaint
    OnClick = DMagicFrontClick
    Caption = 'Next'
    DParent = DStateWinMagic
    Visible = True
    Enabled = False
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DUserKeyGrid1: TDGrid
    Left = 8
    Top = 414
    Width = 98
    Height = 30
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DUserKeyGrid2DblClick
    Caption = 'Key Grid'
    DParent = DBottom
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 12
    RowCount = 1
    ColWidth = 38
    RowHeight = 38
    Coloffset = 4
    Rowoffset = 0
    ViewTopLine = 0
    OnGridSelect = DUserKeyGrid1GridSelect
    OnGridRightSelect = DUserKeyGrid1GridRightSelect
    OnGridMouseMove = DUserKeyGrid1GridMouseMove
    OnGridPaint = DUserKeyGrid1GridPaint
  end
  object DUserKeyGrid2: TDGrid
    Tag = 1
    Left = 167
    Top = 435
    Width = 98
    Height = 30
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDblClick = DUserKeyGrid2DblClick
    Caption = 'KeyGrid2'
    DParent = DBottom2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 8
    RowCount = 1
    ColWidth = 38
    RowHeight = 38
    Coloffset = 4
    Rowoffset = 0
    ViewTopLine = 0
    OnGridSelect = DUserKeyGrid1GridSelect
    OnGridMouseMove = DUserKeyGrid1GridMouseMove
    OnGridPaint = DUserKeyGrid1GridPaint
  end
  object DMagicBase: TDButton
    Left = 358
    Top = 365
    Width = 51
    Height = 17
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicBaseDirectPaint
    OnClick = DMagicBaseClick
    Caption = 'Normal'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMagicCbo: TDButton
    Tag = 1
    Left = 415
    Top = 365
    Width = 44
    Height = 17
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicBaseDirectPaint
    OnClick = DMagicBaseClick
    Caption = 'Combo'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMagicCBOSetup: TDButton
    Left = 449
    Top = 426
    Width = 47
    Height = 17
    DFColor = 11922415
    DFEnabledColor = clWhite
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMagicCBOSetupClick
    Caption = 'ComboSet'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCbo: TDWindow
    Left = 533
    Top = 363
    Width = 114
    Height = 74
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinMagicCboDirectPaint
    OnVisible = DStateWinMagicCboVisible
    Caption = 'Combo Skills'
    DParent = DStateWinMagic
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = True
    EscExit = False
    ControlStyle = dsNone
  end
  object DStateWinMagicCboClose: TDButton
    Left = 618
    Top = 369
    Width = 29
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DMaxMinimapCloseClick
    Caption = '??'
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboOK: TDButton
    Left = 544
    Top = 411
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DStateWinMagicCboOKClick
    Caption = 'Ok'
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboExit: TDButton
    Left = 606
    Top = 410
    Width = 41
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DMaxMinimapCloseClick
    Caption = 'Cancel'
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboICO: TDButton
    Left = 542
    Top = 363
    Width = 50
    Height = 23
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinMagicCboICODirectPaint
    OnClick = DStateWinMagicCboICOClick
    OnInRealArea = DStateWinMagicCboICOInRealArea
    Caption = 'Icon'
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateWinMagicCboGrid: TDGrid
    Left = 544
    Top = 382
    Width = 56
    Height = 22
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    Caption = 'Skills'
    DParent = DStateWinMagicCbo
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 4
    RowCount = 1
    ColWidth = 38
    RowHeight = 38
    Coloffset = 10
    Rowoffset = 0
    ViewTopLine = 0
    OnGridSelect = DStateWinMagicCboGridGridSelect
    OnGridMouseMove = DStateWinMagicCboGridGridMouseMove
    OnGridPaint = DStateWinMagicCboGridGridPaint
  end
  object DBtnSayAll: TDButton
    Left = 610
    Top = 8
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'SayAll'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayWhisper: TDButton
    Tag = 2
    Left = 610
    Top = 39
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'Whisper'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayCry: TDButton
    Tag = 3
    Left = 610
    Top = 55
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'Shout'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayGroup: TDButton
    Tag = 4
    Left = 610
    Top = 71
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'Group'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayGuild: TDButton
    Tag = 5
    Left = 610
    Top = 88
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'Guild'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSaySys: TDButton
    Tag = 6
    Left = 610
    Top = 111
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'System'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayHear: TDButton
    Tag = 1
    Left = 610
    Top = 24
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'Nearby'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DBtnSayCustom: TDButton
    Tag = 7
    Left = 642
    Top = 111
    Width = 26
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBtnSayAllDirectPaint
    OnClick = DBtnSayAllClick
    Caption = 'Custom'
    DParent = DWndSay
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object dchkSayLock: TDCheckBox
    Left = 634
    Top = 8
    Width = 30
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseMove = DBTSayMoveMouseMove
    Caption = 'ScrollLock'
    DParent = DWndSay
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    Checked = True
    FontSpace = 3
    OnChange = dchkSayLockChange
    OffsetLeft = 0
    OffsetTop = 1
  end
  object dwndSayMode: TDWindow
    Left = 618
    Top = 444
    Width = 235
    Height = 27
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dwndSayModeDirectPaint
    Caption = 'Chat Mode Window'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object dbtnSayModeHear: TDButton
    Left = 618
    Top = 444
    Width = 50
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = 'Near'
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeWhisper: TDButton
    Tag = 1
    Left = 713
    Top = 444
    Width = 38
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = 'Whisper'
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeCry: TDButton
    Tag = 2
    Left = 757
    Top = 444
    Width = 39
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = 'Shout'
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeGroup: TDButton
    Tag = 3
    Left = 658
    Top = 445
    Width = 38
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = 'Group'
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeGuild: TDButton
    Tag = 4
    Left = 680
    Top = 444
    Width = 38
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = 'Guild'
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSayModeWorld: TDButton
    Tag = 5
    Left = 802
    Top = 444
    Width = 50
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSayModeHearDirectPaint
    OnClick = dbtnSayModeHearClick
    Caption = 'Custom'
    DParent = dwndSayMode
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dwndWhisperName: TDWindow
    Left = 358
    Top = 445
    Width = 87
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dwndWhisperNameDirectPaint
    OnVisible = dwndWhisperNameVisible
    Caption = 'Whisper Name'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object dbtnSelServer1: TDButton
    Left = 8
    Top = 16
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = dbtnSelServer1DirectPaint
    OnClick = dbtnSelServer1Click
    Caption = 'Server 1'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer2: TDButton
    Tag = 1
    Left = 67
    Top = 17
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 2'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer3: TDButton
    Tag = 2
    Left = 124
    Top = 17
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 3'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer4: TDButton
    Tag = 3
    Left = 8
    Top = 44
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 4'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer5: TDButton
    Tag = 4
    Left = 65
    Top = 44
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 5'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer6: TDButton
    Tag = 5
    Left = 124
    Top = 44
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 6'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer7: TDButton
    Tag = 6
    Left = 8
    Top = 71
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 7'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServer8: TDButton
    Tag = 7
    Left = 67
    Top = 71
    Width = 53
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = dbtnSelServer1Click
    Caption = 'Server 8'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnSelServerClose: TDButton
    Left = 153
    Top = 111
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Close'
    DParent = DWinSelServer
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object dbtnLoginLostPw: TDButton
    Left = 64
    Top = 189
    Width = 52
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DLoginHomeDirectPaint
    OnClick = dbtnLoginLostPwClick
    Caption = 'Lost Password'
    DParent = DLogIn
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMagicSub: TDButton
    Tag = 2
    Left = 470
    Top = 365
    Width = 53
    Height = 17
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMagicBaseDirectPaint
    OnClick = DMagicBaseClick
    Caption = 'Sub skills'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
  end
  object DMakeMagicAdd1: TDButton
    Left = 413
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd2: TDButton
    Tag = 1
    Left = 432
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd3: TDButton
    Tag = 2
    Left = 451
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd4: TDButton
    Tag = 3
    Left = 470
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd5: TDButton
    Tag = 4
    Left = 489
    Top = 388
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd6: TDButton
    Tag = 5
    Left = 413
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd7: TDButton
    Tag = 6
    Left = 432
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd8: TDButton
    Tag = 7
    Left = 451
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd9: TDButton
    Tag = 8
    Left = 470
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMakeMagicAdd10: TDButton
    Tag = 9
    Left = 489
    Top = 411
    Width = 13
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateAbilAdd3DirectPaint
    OnClick = DMakeMagicAdd1Click
    Caption = '+1'
    DParent = DStateWinMagic
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DButtonTop: TDButton
    Left = 797
    Top = 532
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DTopGMMouseMove
    OnClick = DButtonTopClick
    Caption = 'Top'
    DParent = DTop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCreateChr2: TDWindow
    Left = 859
    Top = 524
    Width = 146
    Height = 86
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCreateChrDirectPaint
    Caption = 'Create Character 2'
    DParent = DSelectChr
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DEditChrName2: TDEdit
    Left = 964
    Top = 523
    Width = 28
    Height = 17
    DFColor = clWhite
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnMouseUp = DEditIDMouseUp
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = True
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    EditClass = deStandard
    FrameColor = clBlack
    MaxLength = 10
    CloseSpace = True
    boTransparent = True
  end
  object DccOk2: TDButton
    Left = 957
    Top = 562
    Width = 40
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Ok'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccClose2: TDButton
    Left = 964
    Top = 586
    Width = 41
    Height = 18
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DscSelect1Click
    Caption = 'Close'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccManWarrior: TDButton
    Left = 876
    Top = 528
    Width = 51
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Warrior'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccManWizzard: TDButton
    Tag = 10
    Left = 876
    Top = 551
    Width = 50
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Wizard'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccManMonk: TDButton
    Tag = 20
    Left = 876
    Top = 572
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Taoist'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWoManWarrior: TDButton
    Tag = 1
    Left = 932
    Top = 528
    Width = 51
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'WoManWarr'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWoManWizzard: TDButton
    Tag = 11
    Left = 932
    Top = 551
    Width = 50
    Height = 15
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'WoManWiz'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccWoManMonk: TDButton
    Tag = 21
    Left = 932
    Top = 572
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DccManWarriorDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'WoManTao'
    DParent = DCreateChr2
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusEXP: TDButton
    Left = 8
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Exp'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusPOW: TDButton
    Tag = 1
    Left = 43
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Power'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusSC: TDButton
    Tag = 2
    Left = 78
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'SC'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusAC: TDButton
    Tag = 3
    Left = 113
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'AC'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusDC: TDButton
    Tag = 4
    Left = 148
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'DC'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusHIDEMODE: TDButton
    Tag = 5
    Left = 183
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Hide'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusSTONE: TDButton
    Tag = 6
    Left = 218
    Top = 533
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Stone'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMC: TDButton
    Tag = 7
    Left = 8
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'MC'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMP: TDButton
    Tag = 8
    Left = 43
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'MP'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMAC: TDButton
    Tag = 9
    Left = 78
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'MAC'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusHP: TDButton
    Tag = 10
    Left = 113
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'HP'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusDAMAGEARMOR: TDButton
    Tag = 11
    Left = 148
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'DamArm'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusDECHEALTH: TDButton
    Tag = 12
    Left = 183
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'DecHP'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusCOBWEB: TDButton
    Tag = 13
    Left = 218
    Top = 564
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Combweb'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateBTHorse: TDButton
    Tag = 4
    Left = 692
    Top = 249
    Width = 40
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = 'Mount'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateWinHorse: TDWindow
    Left = 657
    Top = 270
    Width = 61
    Height = 168
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = 'Mount State'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DHorseRein: TDButton
    Tag = 16
    Left = 657
    Top = 283
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Rein'
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseBell: TDButton
    Tag = 17
    Left = 657
    Top = 315
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Bell'
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseSaddle: TDButton
    Tag = 18
    Left = 658
    Top = 347
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Saddle'
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseDecoration: TDButton
    Tag = 19
    Left = 658
    Top = 379
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Decoration'
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DHorseNail: TDButton
    Tag = 20
    Left = 658
    Top = 411
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSWWeaponDirectPaint
    OnMouseMove = DSWWeaponMouseMove
    OnMouseUp = DSWWeaponMouseUp
    Caption = 'Nail'
    DParent = DStateWinHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUserStateBTHorse: TDButton
    Tag = 4
    Left = 695
    Top = 477
    Width = 31
    Height = 15
    DFColor = 42751
    DFEnabledColor = 12964541
    DFMoveColor = 7075839
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateBTInfoDirectPaint
    OnClick = DUserStateBTItemClick
    Caption = 'Mount'
    DParent = DUserState
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DUserStateHorse: TDWindow
    Left = 598
    Top = 507
    Width = 153
    Height = 97
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUserStateItemDirectPaint
    Caption = 'Mount'
    DParent = DUserState
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DUSHorseRein: TDButton
    Tag = 16
    Left = 598
    Top = 514
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = 'Rein'
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseBell: TDButton
    Tag = 17
    Left = 598
    Top = 551
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = 'Bell'
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseSaddle: TDButton
    Tag = 18
    Left = 598
    Top = 578
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = 'Saddle'
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseDecoration: TDButton
    Tag = 19
    Left = 679
    Top = 529
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = 'Decoration'
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DUSHorseNail: TDButton
    Tag = 20
    Left = 679
    Top = 561
    Width = 39
    Height = 26
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DUSHorseReinDirectPaint
    OnMouseMove = DUSHorseReinMouseMove
    Caption = 'Nail'
    DParent = DUserStateHorse
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DNewAccountClose: TDButton
    Left = 328
    Top = 134
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DWinSelServerExitClick
    Caption = 'Close'
    DParent = DNewAccount
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotMiniMap: TDButton
    Left = 306
    Top = 383
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DButRenewChrDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotMiniMapClick
    Caption = 'MiniMap'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotAddAbil: TDButton
    Left = 317
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBotAddAbilDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'AddAbil'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DBotMusic: TDButton
    Left = 282
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DMyStateClick
    Caption = 'Music'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DMiniMap: TDWindow
    Left = 525
    Top = 78
    Width = 79
    Height = 49
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMiniMapDirectPaint
    OnMouseMove = DMiniMapMouseMove
    OnMouseDown = DMiniMapMouseDown
    OnMouseEntry = DMiniMapMouseEntry
    Caption = 'MiniMap'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DBotWndSay: TDWindow
    Left = 264
    Top = 528
    Width = 73
    Height = 57
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBotWndSayDirectPaint
    OnMouseDown = DBotWndSayMouseDown
    OnMouseUp = DBotWndSayMouseUp
    OnInRealArea = DBotWndSayInRealArea
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DCloseSayHear: TDButton
    Left = 112
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = 'Near'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayWhisper: TDButton
    Left = 147
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = 'PM'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayCry: TDButton
    Left = 182
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = 'Shout'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayGuild: TDButton
    Left = 218
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = 'Guild'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DCloseSayGroup: TDButton
    Left = 253
    Top = 414
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DCloseSayHearDirectPaint
    OnMouseMove = DCloseSayHearMouseMove
    OnClick = DCloseSayHearClick
    Caption = 'Group'
    DParent = DBottom
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csStone
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DStateBTState: TDButton
    Tag = 5
    Left = 646
    Top = 262
    Width = 40
    Height = 15
    DFColor = 12500670
    DFEnabledColor = 12964541
    DFMoveColor = clWhite
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateBTItemDirectPaint
    OnClick = DStateBTItemClick
    Caption = 'Status'
    DParent = DStateWin
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
  end
  object DStateWinState: TDWindow
    Left = 724
    Top = 270
    Width = 61
    Height = 168
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DStateWinItemDirectPaint
    Caption = 'StateWinState'
    DParent = DStateWin
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsNone
  end
  object DOpenCompoundItem: TDButton
    Left = 643
    Top = 186
    Width = 25
    Height = 24
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DOpenCompoundItemDirectPaint
    OnClick = DOpenCompoundItemClick
    Caption = 'Compound'
    DParent = DItemBag
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
  end
  object DBottom3: TDWindow
    Left = 8
    Top = 670
    Width = 265
    Height = 95
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom3DirectPaint
    OnEndDirectPaint = DBottom3EndDirectPaint
    OnMouseDown = DBottom3MouseDown
    Caption = 'Bottom 3'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DBottom4: TDWindow
    Left = 279
    Top = 735
    Width = 184
    Height = 34
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom4DirectPaint
    OnEndDirectPaint = DBottom4EndDirectPaint
    OnMouseMove = DBottom4MouseMove
    OnMouseDown = DBottom4MouseDown
    Caption = 'Bottom 4'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DTopCharStatus: TDWindow
    Left = 279
    Top = 670
    Width = 104
    Height = 55
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopCharStatusDirectPaint
    OnEndDirectPaint = DTopCharStatusEndDirectPaint
    OnMouseDown = DTopCharStatusMouseDown
    Caption = 'Top Char Status'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DScrollBgTopMini: TDWindow
    Left = 246
    Top = 674
    Width = 19
    Height = 39
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom2DirectPaint
    OnEndDirectPaint = DBottom2EndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'Scrollbgtop'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DScrollBgBottomMini: TDWindow
    Left = 246
    Top = 730
    Width = 19
    Height = 35
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom2DirectPaint
    OnEndDirectPaint = DBottom2EndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'ScrollbgBottom'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DChatImgBgLeftTopMini: TDWindow
    Left = 20
    Top = 674
    Width = 19
    Height = 39
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom2DirectPaint
    OnEndDirectPaint = DBottom2EndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'DChatImgBgLeftTopMini'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DChatImgBgLeftBottomMini: TDWindow
    Left = 18
    Top = 719
    Width = 19
    Height = 39
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBottom2DirectPaint
    OnEndDirectPaint = DBottom2EndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'DChatImgBgLeftBottomMini'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DChatImgBgBottomMini: TDWindow
    Left = 78
    Top = 735
    Width = 99
    Height = 23
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DChatImgBgBottomMiniDirectPaint
    OnEndDirectPaint = DChatImgBgBottomMiniEndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'DChatImgBgBottomMini'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DChatImgBgTopMini: TDWindow
    Left = 78
    Top = 674
    Width = 102
    Height = 23
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DChatImgBgTopMiniDirectPaint
    OnEndDirectPaint = DChatImgBgTopMiniEndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'DChatImgBgTopMini'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DChatImgBgLeftMidleMini: TDWindow
    Left = 43
    Top = 719
    Width = 19
    Height = 39
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DChatImgMiddleMiniLeftDirectPaint
    OnEndDirectPaint = DChatImgMiddleMiniLeftEndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'DChatImgBgLeftMidleMini'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DScrollBgMiddleMini: TDWindow
    Left = 221
    Top = 719
    Width = 19
    Height = 39
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DChatImgMiddleMiniRightDirectPaint
    OnEndDirectPaint = DChatImgMiddleMiniRightEndDirectPaint
    OnMouseDown = DBottom2MouseDown
    Caption = 'DScrollBgMiddleMini'
    DParent = DBottom3
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DMiniMapFrame: TDWindow
    Left = 389
    Top = 670
    Width = 75
    Height = 55
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMiniMapFrameDirectPaint
    OnEndDirectPaint = DMiniMapFrameEndDirectPaint
    Caption = 'Minimap Frame'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DTopCharAvatar: TDWindow
    Left = 288
    Top = 674
    Width = 38
    Height = 39
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopCharAvatarDirectPaint
    OnEndDirectPaint = DTopCharAvatarEndDirectPaint
    Caption = 'DChatImgBgLeftTopMini'
    DParent = DTopCharStatus
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DFrameMaxMin: TDButton
    Left = 430
    Top = 677
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DButRenewChrDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DBotMiniMapClick
    Caption = 'FrameMaxMin'
    DParent = DMiniMapFrame
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DChatEnlargeButton: TDButton
    Left = 186
    Top = 674
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBotGuildDirectPaint
    OnMouseMove = DMyStateMouseMove
    OnClick = DChatEnlargeClick
    Caption = 'DChatEnlargeButton'
    DParent = DBottom3
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccKiller: TDButton
    Tag = 2
    Left = 183
    Top = 315
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Assassin'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DccRanger: TDButton
    Tag = 2
    Left = 183
    Top = 337
    Width = 50
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DscCreateChrDirectPaint
    OnMouseMove = DccWarriorMouseMove
    OnClick = DscSelect1Click
    Caption = 'Archer'
    DParent = DCreateChr
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSaleDlg: TDWindow
    Left = 479
    Top = 618
    Width = 120
    Height = 95
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSaleDlgDirectPaint
    Caption = 'DSaleDlg'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DSaleDlgSell: TDButton
    Left = 484
    Top = 680
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DSaleDlgSellClick
    Caption = 'Sell'
    DParent = DSaleDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSaleDlgClose: TDButton
    Left = 565
    Top = 629
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DButRenewChrDirectPaint
    OnClick = DSaleDlgCloseClick
    Caption = 'Close'
    DParent = DSaleDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSaleDlgSpot: TDButton
    Left = 489
    Top = 629
    Width = 70
    Height = 45
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSaleDlgSpotDirectPaint
    OnMouseMove = DSaleDlgSpotMouseMove
    OnClick = DSaleDlgSpotClick
    Caption = 'ItemSpot'
    DParent = DSaleDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSaleDlgLock: TDButton
    Left = 531
    Top = 680
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnClick = DSaleDlgLockClick
    Caption = 'Lock'
    DParent = DSaleDlg
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSubShop: TDWindow
    Left = 605
    Top = 618
    Width = 120
    Height = 95
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DSubShopDirectPaint
    Caption = 'DSubShop'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Floating = False
    EscExit = False
    ControlStyle = dsBottom
  end
  object DSubShopClose: TDButton
    Left = 695
    Top = 626
    Width = 24
    Height = 17
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DMyStateDirectPaint
    OnClick = DSaleDlgCloseClick
    Caption = 'Close'
    DParent = DSubShop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csGlass
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSubShopGrid: TDGrid
    Tag = 1
    Left = 618
    Top = 634
    Width = 64
    Height = 40
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DSubShopUpDown
    Caption = 'MenuGrid'
    DParent = DSubShop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ColCount = 5
    RowCount = 6
    ColWidth = 34
    RowHeight = 34
    Coloffset = 1
    Rowoffset = 1
    ViewTopLine = 0
    OnGridSelect = DSubShopGridGridSelect
    OnGridMouseMove = DSubShopGridGridMouseMove
    OnGridPaint = DSubShopGridGridPaint
  end
  object DSubShopBuy: TDButton
    Left = 618
    Top = 680
    Width = 41
    Height = 21
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DBTHintCloseDirectPaint
    OnClick = DSubShopBuyClick
    Caption = 'Buy'
    DParent = DSubShop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DSubShopUpDown: TDUpDown
    Left = 688
    Top = 649
    Width = 22
    Height = 42
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    WheelDControl = DSubShopUpDown
    DParent = DSubShop
    Visible = True
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ClickCount = csNone
    Position = 0
    Offset = 0
    Normal = False
    MovePosition = 1
    MoveShow = True
    MaxPosition = 0
    MoveFlicker = True
  end
  object DTopStatusSlowDown: TDButton
    Tag = 14
    Left = 8
    Top = 594
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Slow'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusFreeze: TDButton
    Tag = 15
    Left = 43
    Top = 595
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Frz'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusStun: TDButton
    Tag = 16
    Left = 78
    Top = 595
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Stun'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusRage: TDButton
    Tag = 17
    Left = 113
    Top = 595
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Rage'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusMagicBooster: TDButton
    Tag = 18
    Left = 148
    Top = 595
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'MB'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusUE: TDButton
    Tag = 19
    Left = 183
    Top = 595
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'UE'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusCurse: TDButton
    Tag = 20
    Left = 218
    Top = 595
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'Curse'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object DTopStatusProField: TDButton
    Tag = 21
    Left = 8
    Top = 626
    Width = 29
    Height = 25
    DFColor = 12964541
    DFEnabledColor = 12964541
    DFMoveColor = 12964541
    DFDownColor = clWhite
    DFBackColor = 8
    OnDirectPaint = DTopStatusEXPDirectPaint
    OnMouseMove = DTopStatusEXPMouseMove
    Caption = 'ProField'
    DParent = DBackground
    Visible = False
    Enabled = True
    MouseFocus = True
    KeyFocus = False
    ShowHint = True
    ClickCount = csNorm
    OnClickSound = dbtnSelServer1ClickSound
  end
  object RState: TRSA
    CommonalityKey = '39910943079509316779579'
    CommonalityMode = '486041964784552904735358570911'
    Left = 120
    Top = 72
  end
end
