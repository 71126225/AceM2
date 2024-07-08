object FrmViewCompoundInfo: TFrmViewCompoundInfo
  Left = 0
  Top = 0
  Caption = 'Equipped with synthetic'
  ClientHeight = 600
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1000
    Height = 90
    Align = alTop
    Caption = 'Basic'
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 8
      Top = 10
      Width = 190
      Height = 70
      Caption = 'Color Setting'
      TabOrder = 0
      object Label1: TLabel
        Left = 2
        Top = 20
        Width = 54
        Height = 12
        Caption = '1stColor:'
      end
      object Label2: TLabel
        Left = 100
        Top = 19
        Width = 48
        Height = 12
        Caption = '2ndColo:'
      end
      object Label3: TLabel
        Left = 2
        Top = 43
        Width = 54
        Height = 12
        Caption = '3rdColor:'
      end
      object Label4: TLabel
        Left = 100
        Top = 43
        Width = 54
        Height = 12
        Caption = '4thColor:'
      end
      object seColor1: TSpinEdit
        Left = 44
        Top = 16
        Width = 48
        Height = 21
        MaxValue = 255
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = seColorChange
      end
      object seColor2: TSpinEdit
        Left = 136
        Top = 16
        Width = 48
        Height = 21
        MaxValue = 255
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnChange = seColorChange
      end
      object seColor3: TSpinEdit
        Left = 44
        Top = 41
        Width = 48
        Height = 21
        MaxValue = 255
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = seColorChange
      end
      object seColor4: TSpinEdit
        Left = 136
        Top = 41
        Width = 48
        Height = 21
        MaxValue = 255
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = seColorChange
      end
    end
    object GroupBox3: TGroupBox
      Left = 210
      Top = 10
      Width = 240
      Height = 70
      Caption = 'Cost Setting (Gold)'
      TabOrder = 1
      object Label5: TLabel
        Left = 3
        Top = 19
        Width = 42
        Height = 12
        Caption = '1stFee:'
      end
      object Label6: TLabel
        Left = 124
        Top = 19
        Width = 42
        Height = 12
        Caption = '2ndFee:'
      end
      object Label7: TLabel
        Left = 3
        Top = 43
        Width = 42
        Height = 12
        Caption = '3rdFee:'
      end
      object Label8: TLabel
        Left = 124
        Top = 42
        Width = 42
        Height = 12
        Caption = '4thFee:'
      end
      object eGoldFee1: TEdit
        Left = 44
        Top = 16
        Width = 70
        Height = 20
        TabOrder = 0
        Text = '0'
        OnChange = eGoldFeeChange
      end
      object eGoldFee2: TEdit
        Left = 163
        Top = 16
        Width = 70
        Height = 20
        TabOrder = 1
        Text = '0'
        OnChange = eGoldFeeChange
      end
      object eGoldFee3: TEdit
        Left = 44
        Top = 41
        Width = 70
        Height = 20
        TabOrder = 2
        Text = '0'
        OnChange = eGoldFeeChange
      end
      object eGoldFee4: TEdit
        Left = 164
        Top = 41
        Width = 70
        Height = 20
        TabOrder = 3
        Text = '0'
        OnChange = eGoldFeeChange
      end
    end
    object GroupBox4: TGroupBox
      Left = 462
      Top = 10
      Width = 240
      Height = 70
      Caption = 'Cost Setting (GameGold)'
      TabOrder = 2
      object Label9: TLabel
        Left = 5
        Top = 19
        Width = 42
        Height = 12
        Caption = '1stFee:'
      end
      object Label10: TLabel
        Left = 124
        Top = 19
        Width = 42
        Height = 12
        Caption = '2ndFee:'
      end
      object Label11: TLabel
        Left = 5
        Top = 43
        Width = 42
        Height = 12
        Caption = '3rdFee:'
      end
      object Label12: TLabel
        Left = 124
        Top = 43
        Width = 42
        Height = 12
        Caption = '4thFee:'
      end
      object eGameGoldFee1: TEdit
        Left = 44
        Top = 16
        Width = 70
        Height = 20
        TabOrder = 0
        Text = '0'
        OnChange = eGoldFeeChange
      end
      object eGameGoldFee2: TEdit
        Left = 163
        Top = 16
        Width = 70
        Height = 20
        TabOrder = 1
        Text = '0'
        OnChange = eGoldFeeChange
      end
      object eGameGoldFee3: TEdit
        Left = 44
        Top = 41
        Width = 70
        Height = 20
        TabOrder = 2
        Text = '0'
        OnChange = eGoldFeeChange
      end
      object eGameGoldFee4: TEdit
        Left = 164
        Top = 41
        Width = 70
        Height = 20
        TabOrder = 3
        Text = '0'
        OnChange = eGoldFeeChange
      end
    end
    object GroupBox5: TGroupBox
      Left = 714
      Top = 10
      Width = 190
      Height = 70
      Caption = 'Drop Rate'
      TabOrder = 3
      object Label13: TLabel
        Left = 3
        Top = 19
        Width = 48
        Height = 12
        Caption = '1stRate:'
      end
      object Label14: TLabel
        Left = 97
        Top = 19
        Width = 48
        Height = 12
        Caption = '2ndRate:'
      end
      object Label15: TLabel
        Left = 3
        Top = 43
        Width = 48
        Height = 12
        Caption = '3rdRate:'
      end
      object Label16: TLabel
        Left = 97
        Top = 43
        Width = 48
        Height = 12
        Caption = '4thRate:'
      end
      object seDropRate1: TSpinEdit
        Left = 44
        Top = 16
        Width = 48
        Height = 21
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = seDropRateChange
      end
      object seDropRate2: TSpinEdit
        Left = 136
        Top = 16
        Width = 48
        Height = 21
        MaxValue = 100
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnChange = seDropRateChange
      end
      object seDropRate3: TSpinEdit
        Left = 44
        Top = 41
        Width = 48
        Height = 21
        MaxValue = 100
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = seDropRateChange
      end
      object seDropRate4: TSpinEdit
        Left = 136
        Top = 41
        Width = 48
        Height = 21
        MaxValue = 100
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = seDropRateChange
      end
    end
    object BtnSave: TButton
      Left = 915
      Top = 55
      Width = 75
      Height = 25
      Caption = '&Save'
      TabOrder = 4
      OnClick = BtnSaveClick
    end
    object GroupBox6: TGroupBox
      Left = 910
      Top = 10
      Width = 80
      Height = 40
      Caption = 'Value Limit'
      TabOrder = 5
      object seValueLimit: TSpinEdit
        Left = 10
        Top = 14
        Width = 60
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 10
        OnChange = seDropRateChange
      end
    end
  end
  object lvCompoundInfo: TListView
    Left = 0
    Top = 90
    Width = 1000
    Height = 491
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Equip Name'
      end
      item
        Caption = 'Class'
        Width = 40
      end
      item
        Caption = 'Success Rate'
      end
      item
        Caption = 'AC'
        Width = 65
      end
      item
        Caption = 'MAC'
        Width = 65
      end
      item
        Caption = 'DC'
        Width = 65
      end
      item
        Caption = 'MC'
        Width = 65
      end
      item
        Caption = 'SC'
        Width = 65
      end
      item
        Caption = 'HP'
        Width = 65
      end
      item
        Caption = 'MP'
        Width = 65
      end
      item
        Caption = 'Accuracy'
        Width = 60
      end
      item
        Caption = 'Agility'
        Width = 60
      end
      item
        Caption = 'Critical'
        Width = 60
      end
      item
        Caption = 'DMG'
        Width = 60
      end
      item
        Caption = 'DMG Absorb'
        Width = 60
      end
      item
        Caption = 'Magic Absorb'
        Width = 60
      end>
    GridLines = True
    HotTrackStyles = [htHandPoint]
    MultiSelect = True
    OwnerData = True
    RowSelect = True
    ShowWorkAreas = True
    TabOrder = 1
    ViewStyle = vsReport
    OnCustomDrawItem = lvCompoundInfoCustomDrawItem
    OnData = lvCompoundInfoData
    OnMouseDown = lvCompoundInfoMouseDown
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 581
    Width = 1000
    Height = 19
    Panels = <
      item
        Text = 
          'Use Ctrl+Shift to select multiple items. Right-click to modify t' +
          'he value. The modification will take effect immediately. Please ' +
          'pay attention to save the modification results. The settings cla' +
          'ssified as 0 will not be saved.'
        Width = 50
      end>
  end
end
