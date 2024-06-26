object frmGeneralConfig: TfrmGeneralConfig
  Left = 369
  Top = 225
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'General Options'
  ClientHeight = 284
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 12
  object Label26: TLabel
    Left = 10
    Top = 264
    Width = 178
    Height = 15
    Caption = '???????????,??????????????'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
  end
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 401
    Height = 249
    ActivePage = ShareSheet
    TabOrder = 0
    OnChanging = PageControlChanging
    object NetWorkSheet: TTabSheet
      Caption = 'Network'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBoxNet: TGroupBox
        Left = 8
        Top = 5
        Width = 185
        Height = 68
        Caption = 'Gate'
        TabOrder = 0
        object LabelGateIPaddr: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Address:'
        end
        object LabelGatePort: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Port:'
        end
        object EditGateAddr: TEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 20
          Hint = '??????????IP,????????IP??,?????????0.0.0.0?'
          TabOrder = 0
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
        object EditGatePort: TEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 20
          Hint = '????????,??????5000?'
          TabOrder = 1
          Text = '5000'
          OnChange = EditValueChange
        end
      end
      object ButtonNetWorkSave: TButton
        Left = 325
        Top = 193
        Width = 65
        Height = 25
        Caption = 'Save(&S)'
        TabOrder = 1
        OnClick = ButtonNetWorkSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 77
        Width = 185
        Height = 68
        Caption = 'DBServer Configuration'
        TabOrder = 2
        object Label4: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Port:'
        end
        object Label5: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Address:'
        end
        object EditDBPort: TEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 20
          Hint = '?????????????'
          TabOrder = 0
          Text = '6000'
          OnChange = EditValueChange
        end
        object EditDBAddr: TEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 20
          Hint = '????????IP???'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 200
        Top = 5
        Width = 185
        Height = 68
        Caption = 'Login Server Configuration'
        TabOrder = 3
        object Label2: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Port:'
        end
        object Label3: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Address:'
        end
        object EditIDSPort: TEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 20
          Hint = '????????'
          TabOrder = 0
          Text = '5600'
          OnChange = EditValueChange
        end
        object EditIDSAddr: TEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 20
          Hint = '?????IP???'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 200
        Top = 77
        Width = 185
        Height = 68
        Caption = 'Log Server Configuration'
        TabOrder = 4
        object Label6: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Port:'
        end
        object Label7: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Address:'
        end
        object EditLogServerPort: TEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 20
          Hint = '??????????'
          TabOrder = 0
          Text = '10000'
          OnChange = EditValueChange
        end
        object EditLogServerAddr: TEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 20
          Hint = '???????IP???'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 149
        Width = 185
        Height = 68
        Caption = 'Message Server Configuration'
        TabOrder = 5
        object Label8: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Port:'
        end
        object Label9: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Address:'
        end
        object EditMsgSrvPort: TEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 20
          Hint = '????????,?????????????????????????????'
          TabOrder = 0
          Text = '4900'
          OnChange = EditValueChange
        end
        object EditMsgSrvAddr: TEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 20
          Hint = '??????IP,?????????????????????????????'
          TabOrder = 1
          Text = '127.0.0.1'
          OnChange = EditValueChange
        end
      end
    end
    object ServerInfoSheet: TTabSheet
      Caption = 'Server Configuration'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBoxInfo: TGroupBox
        Left = 8
        Top = 5
        Width = 185
        Height = 97
        Caption = 'Server'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 12
          Caption = 'Name:'
        end
        object Label10: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Index'
        end
        object Label11: TLabel
          Left = 96
          Top = 44
          Width = 42
          Height = 12
          Caption = 'Number:'
        end
        object EditGameName: TEdit
          Left = 64
          Top = 16
          Width = 113
          Height = 20
          Hint = '????????'
          TabOrder = 0
          Text = '????'
          OnChange = EditValueChange
        end
        object EditServerIndex: TEdit
          Left = 64
          Top = 40
          Width = 25
          Height = 20
          Hint = '???????,?????????????,???????0?'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditServerNumber: TEdit
          Left = 152
          Top = 40
          Width = 25
          Height = 20
          Hint = '??????,??????'
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxServiceMode: TCheckBox
          Left = 8
          Top = 64
          Width = 73
          Height = 17
          Hint = '????,?????????????'
          Caption = '????'
          TabOrder = 3
          Visible = False
          OnClick = EditValueChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 200
        Top = 5
        Width = 153
        Height = 97
        TabOrder = 1
        Visible = False
        object Label12: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label13: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label14: TLabel
          Left = 8
          Top = 68
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object EditTestLevel: TEdit
          Left = 64
          Top = 16
          Width = 73
          Height = 20
          Hint = '????,???????'
          TabOrder = 0
          Text = '0'
          OnChange = EditValueChange
        end
        object EditTestGold: TEdit
          Left = 64
          Top = 40
          Width = 73
          Height = 20
          Hint = '????,????????'
          TabOrder = 1
          Text = '0'
          OnChange = EditValueChange
        end
        object EditTestUserLimit: TEdit
          Left = 64
          Top = 64
          Width = 73
          Height = 20
          Hint = '????,???????'
          TabOrder = 2
          Text = '0'
          OnChange = EditValueChange
        end
        object CheckBoxTestServer: TCheckBox
          Left = 8
          Top = -2
          Width = 73
          Height = 17
          Hint = '????,?????,?????????????????'
          Caption = '????'
          TabOrder = 3
          OnClick = CheckBoxTestServerClick
        end
      end
      object ButtonServerInfoSave: TButton
        Left = 320
        Top = 189
        Width = 65
        Height = 25
        Caption = 'Save(&S)'
        TabOrder = 2
        OnClick = ButtonServerInfoSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 8
        Top = 112
        Width = 185
        Height = 49
        Caption = '??????'
        TabOrder = 3
        Visible = False
        object Label15: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object EditUserFull: TEdit
          Left = 64
          Top = 16
          Width = 41
          Height = 20
          Hint = '????????????'
          TabOrder = 0
          Text = '1000'
          OnChange = EditValueChange
        end
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 168
        Width = 185
        Height = 49
        Caption = 'DB Name'
        TabOrder = 4
        object Label16: TLabel
          Left = 5
          Top = 20
          Width = 30
          Height = 12
          Caption = 'Name:'
        end
        object EditDBName: TEdit
          Left = 64
          Top = 16
          Width = 73
          Height = 20
          TabOrder = 0
          Text = 'HeroDB'
          OnChange = EditValueChange
        end
      end
    end
    object ShareSheet: TTabSheet
      Caption = 'Directories'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label17: TLabel
        Left = 8
        Top = 12
        Width = 54
        Height = 12
        Caption = 'GuildDir:'
      end
      object Label18: TLabel
        Left = 7
        Top = 36
        Width = 60
        Height = 12
        Caption = 'GuildList:'
      end
      object Label24: TLabel
        Left = 7
        Top = 180
        Width = 42
        Height = 12
        BiDiMode = bdRightToLeft
        Caption = 'Plugins'
        ParentBiDiMode = False
      end
      object Label23: TLabel
        Left = 7
        Top = 158
        Width = 42
        Height = 12
        Caption = 'Notice:'
      end
      object Label22: TLabel
        Left = 8
        Top = 132
        Width = 48
        Height = 12
        Caption = 'Map Dir:'
      end
      object Label21: TLabel
        Left = 8
        Top = 108
        Width = 36
        Height = 12
        Caption = 'Envir:'
      end
      object Label20: TLabel
        Left = 8
        Top = 84
        Width = 42
        Height = 12
        Caption = 'Castle:'
      end
      object Label19: TLabel
        Left = 8
        Top = 60
        Width = 48
        Height = 12
        Caption = 'ConnDir:'
      end
      object Label25: TLabel
        Left = 7
        Top = 204
        Width = 42
        Height = 12
        BiDiMode = bdRightToLeft
        Caption = 'Venture'
        ParentBiDiMode = False
      end
      object EditGuildDir: TEdit
        Left = 64
        Top = 8
        Width = 241
        Height = 20
        Hint = '?????????'
        TabOrder = 0
        OnChange = EditValueChange
      end
      object EditGuildFile: TEdit
        Left = 64
        Top = 32
        Width = 241
        Height = 20
        Hint = '??????????'
        TabOrder = 1
        OnChange = EditValueChange
      end
      object EditConLogDir: TEdit
        Left = 64
        Top = 56
        Width = 241
        Height = 20
        Hint = '?????????????'
        TabOrder = 2
        OnChange = EditValueChange
      end
      object EditCastleDir: TEdit
        Left = 64
        Top = 80
        Width = 241
        Height = 20
        TabOrder = 3
        OnChange = EditValueChange
      end
      object EditEnvirDir: TEdit
        Left = 64
        Top = 104
        Width = 241
        Height = 20
        TabOrder = 4
        OnChange = EditValueChange
      end
      object EditMapDir: TEdit
        Left = 64
        Top = 128
        Width = 241
        Height = 20
        TabOrder = 5
        OnChange = EditValueChange
      end
      object EditNoticeDir: TEdit
        Left = 64
        Top = 152
        Width = 241
        Height = 20
        TabOrder = 6
        OnChange = EditValueChange
      end
      object EditPlugDir: TEdit
        Left = 64
        Top = 176
        Width = 241
        Height = 20
        TabOrder = 7
        OnChange = EditValueChange
      end
      object EditVentureDir: TEdit
        Left = 64
        Top = 200
        Width = 241
        Height = 20
        TabOrder = 8
        OnChange = EditValueChange
      end
      object ButtonShareDirSave: TButton
        Left = 325
        Top = 193
        Width = 65
        Height = 25
        Caption = 'Save(&S)'
        TabOrder = 9
        OnClick = ButtonShareDirSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Tips'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 5
        Top = 95
        Width = 193
        Height = 49
        Caption = '????'
        TabOrder = 0
        object Label29: TLabel
          Left = 10
          Top = 22
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object ColorBoxHint: TColorBox
          Left = 70
          Top = 16
          Width = 113
          Height = 22
          Hint = '?????????'
          ItemHeight = 16
          TabOrder = 0
          OnChange = ColorBoxHintChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 5
        Top = 8
        Width = 193
        Height = 81
        Caption = '????'
        TabOrder = 1
        object Label27: TLabel
          Left = 8
          Top = 25
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object Label28: TLabel
          Left = 8
          Top = 48
          Width = 30
          Height = 12
          Caption = '????:'
        end
        object ColorBox1: TColorBox
          Left = 68
          Top = 19
          Width = 113
          Height = 22
          Hint = '?????????'
          ItemHeight = 16
          TabOrder = 0
          OnChange = ColorBoxHintChange
        end
        object ColorBox2: TColorBox
          Left = 68
          Top = 44
          Width = 113
          Height = 22
          Hint = '?????????'
          ItemHeight = 16
          TabOrder = 1
          OnChange = ColorBoxHintChange
        end
      end
      object Button1: TButton
        Left = 320
        Top = 189
        Width = 65
        Height = 25
        Caption = 'Save(&S)'
        TabOrder = 2
        OnClick = ButtonNetWorkSaveClick
      end
    end
  end
end
