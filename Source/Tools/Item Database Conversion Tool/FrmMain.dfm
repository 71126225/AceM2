object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'AppleM2??????? (20120501)'
  ClientHeight = 330
  ClientWidth = 653
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 633
    Height = 310
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'StdItems.DB'
      object Label5: TLabel
        Left = 9
        Top = 9
        Width = 208
        Height = 15
        Caption = '??:???StdItems.DB??????????????,'
      end
      object Label6: TLabel
        Left = 9
        Top = 28
        Width = 248
        Height = 15
        Caption = '????:StdItems_New.DB,??????:StdItems.DB'
      end
      object BtnStdItems: TButton
        Left = 420
        Top = 9
        Width = 191
        Height = 31
        Caption = '????StdItems.DB'
        TabOrder = 0
        OnClick = BtnStdItemsClick
      end
      object GroupBox2: TGroupBox
        Left = 9
        Top = 46
        Width = 602
        Height = 65
        Caption = '??'
        TabOrder = 1
        object Label7: TLabel
          Left = 20
          Top = 30
          Width = 45
          Height = 15
          Caption = '??????:'
        end
        object CBStdItems: TComboBox
          Left = 133
          Top = 26
          Width = 68
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          ItemIndex = 0
          TabOrder = 0
          Text = 'SKY'
          Items.Strings = (
            'SKY'
            'BLUE')
        end
        object CheckBoxStdItems: TCheckBox
          Left = 230
          Top = 29
          Width = 369
          Height = 21
          Caption = '???????StdMode(???????,???)'
          TabOrder = 1
          Visible = False
        end
      end
      object LogStdItems: TMemo
        Left = 9
        Top = 119
        Width = 602
        Height = 132
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -15
        Font.Name = '??'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object BarStdItems: TProgressBar
        Left = 9
        Top = 259
        Width = 602
        Height = 14
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Monster.DB'
      ImageIndex = 1
      object Label2: TLabel
        Left = 9
        Top = 9
        Width = 202
        Height = 15
        Caption = '??:???Monster.DB??????????????,'
      end
      object Label3: TLabel
        Left = 9
        Top = 28
        Width = 237
        Height = 15
        Caption = '????:Monster_New.DB,??????:Monster.DB'
      end
      object BtnMonster: TButton
        Left = 420
        Top = 9
        Width = 191
        Height = 31
        Caption = '????Monster.DB'
        TabOrder = 0
        OnClick = BtnMonsterClick
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 46
        Width = 602
        Height = 65
        Caption = '??'
        TabOrder = 1
        object CheckBoxMonster: TCheckBox
          Left = 11
          Top = 26
          Width = 540
          Height = 22
          Caption = '????????Race?RaceImg??,????????????????'
          TabOrder = 0
          Visible = False
        end
      end
      object LogMonster: TMemo
        Left = 9
        Top = 119
        Width = 602
        Height = 132
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -15
        Font.Name = '??'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object BarMonster: TProgressBar
        Left = 9
        Top = 259
        Width = 602
        Height = 14
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Magic.DB'
      ImageIndex = 2
      object Label1: TLabel
        Left = 20
        Top = 20
        Width = 139
        Height = 15
        Caption = 'Magic.DB??????????DB'
      end
    end
  end
  object Query: TQuery
    Left = 32
    Top = 136
  end
  object QuerySave: TQuery
    Left = 64
    Top = 136
  end
end
