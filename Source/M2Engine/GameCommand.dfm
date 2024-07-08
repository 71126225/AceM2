object frmGameCmd: TfrmGameCmd
  Left = 343
  Top = 287
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Game Commands'
  ClientHeight = 407
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 4
    Top = 8
    Width = 574
    Height = 390
    ActivePage = TabSheet3
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Player'
      object StringGridGameCmd: TStringGrid
        Left = 7
        Top = 8
        Width = 552
        Height = 254
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameCmdClick
        ColWidths = (
          90
          60
          128
          248)
      end
      object GroupBox1: TGroupBox
        Left = 7
        Top = 268
        Width = 552
        Height = 89
        Caption = 'Details'
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Command:'
        end
        object Label6: TLabel
          Left = 176
          Top = 18
          Width = 66
          Height = 12
          Caption = 'Permission:'
        end
        object LabelUserCmdFunc: TLabel
          Left = 64
          Top = 44
          Width = 401
          Height = 12
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object LabelUserCmdParam: TLabel
          Left = 64
          Top = 68
          Width = 401
          Height = 12
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Desc:'
        end
        object Label3: TLabel
          Left = 8
          Top = 68
          Width = 24
          Height = 12
          Caption = 'Use:'
        end
        object EditUserCmdName: TEdit
          Left = 64
          Top = 16
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditUserCmdNameChange
        end
        object EditUserCmdPerMission: TSpinEdit
          Left = 236
          Top = 15
          Width = 45
          Height = 21
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditUserCmdPerMissionChange
        end
        object EditUserCmdOK: TButton
          Left = 471
          Top = 15
          Width = 73
          Height = 25
          Caption = '&OK'
          TabOrder = 2
          OnClick = EditUserCmdOKClick
        end
        object EditUserCmdSave: TButton
          Left = 471
          Top = 55
          Width = 73
          Height = 25
          Caption = '&Save'
          TabOrder = 3
          OnClick = EditUserCmdSaveClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'GM-S'
      ImageIndex = 1
      object StringGridGameMasterCmd: TStringGrid
        Left = 7
        Top = 8
        Width = 552
        Height = 254
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameMasterCmdClick
        ColWidths = (
          90
          60
          129
          248)
      end
      object GroupBox2: TGroupBox
        Left = 7
        Top = 268
        Width = 552
        Height = 89
        Caption = 'Details'
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Command:'
        end
        object Label5: TLabel
          Left = 176
          Top = 18
          Width = 66
          Height = 12
          Caption = 'Permission:'
        end
        object LabelGameMasterCmdFunc: TLabel
          Left = 64
          Top = 44
          Width = 401
          Height = 12
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object LabelGameMasterCmdParam: TLabel
          Left = 64
          Top = 68
          Width = 401
          Height = 12
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Desc:'
        end
        object Label8: TLabel
          Left = 8
          Top = 68
          Width = 24
          Height = 12
          Caption = 'Use:'
        end
        object EditGameMasterCmdName: TEdit
          Left = 64
          Top = 16
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditGameMasterCmdNameChange
        end
        object EditGameMasterCmdPerMission: TSpinEdit
          Left = 236
          Top = 15
          Width = 45
          Height = 21
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditGameMasterCmdPerMissionChange
        end
        object EditGameMasterCmdOK: TButton
          Left = 471
          Top = 15
          Width = 73
          Height = 25
          Caption = '&OK'
          TabOrder = 2
          OnClick = EditGameMasterCmdOKClick
        end
        object EditGameMasterCmdSave: TButton
          Left = 471
          Top = 55
          Width = 73
          Height = 25
          Caption = '&Save'
          TabOrder = 3
          OnClick = EditGameMasterCmdSaveClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Admin'
      ImageIndex = 2
      object StringGridGameDebugCmd: TStringGrid
        Left = 7
        Top = 8
        Width = 552
        Height = 254
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect]
        TabOrder = 0
        OnClick = StringGridGameDebugCmdClick
        ColWidths = (
          90
          60
          129
          248)
      end
      object GroupBox3: TGroupBox
        Left = 7
        Top = 268
        Width = 552
        Height = 89
        Caption = 'Details'
        TabOrder = 1
        object Label9: TLabel
          Left = 8
          Top = 20
          Width = 48
          Height = 12
          Caption = 'Command:'
        end
        object Label10: TLabel
          Left = 176
          Top = 18
          Width = 66
          Height = 12
          Caption = 'Permission:'
        end
        object LabelGameDebugCmdFunc: TLabel
          Left = 64
          Top = 44
          Width = 401
          Height = 12
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object LabelGameDebugCmdParam: TLabel
          Left = 64
          Top = 68
          Width = 401
          Height = 12
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = 'Desc:'
        end
        object Label12: TLabel
          Left = 8
          Top = 68
          Width = 66
          Height = 12
          Caption = 'How to use:'
        end
        object EditGameDebugCmdName: TEdit
          Left = 64
          Top = 16
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditGameDebugCmdNameChange
        end
        object EditGameDebugCmdPerMission: TSpinEdit
          Left = 236
          Top = 15
          Width = 45
          Height = 21
          MaxValue = 10
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditGameDebugCmdPerMissionChange
        end
        object EditGameDebugCmdOK: TButton
          Left = 471
          Top = 15
          Width = 73
          Height = 25
          Caption = '&OK'
          TabOrder = 2
          OnClick = EditGameDebugCmdOKClick
        end
        object EditGameDebugCmdSave: TButton
          Left = 471
          Top = 55
          Width = 73
          Height = 25
          Caption = '&Save'
          TabOrder = 3
          OnClick = EditGameDebugCmdSaveClick
        end
      end
    end
  end
end
