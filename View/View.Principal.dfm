object FrmBuscaGTIN: TFrmBuscaGTIN
  Left = 0
  Top = 0
  Caption = 'FrmBuscaGTIN'
  ClientHeight = 684
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LblCodBarras: TLabel
    Left = 8
    Top = 27
    Width = 97
    Height = 15
    Caption = 'Codigo De Barras :'
  end
  object ImgProduto: TImage
    Left = 431
    Top = 250
    Width = 554
    Height = 415
  end
  object CxInfosProdutos: TMemo
    Left = 32
    Top = 70
    Width = 393
    Height = 354
    TabOrder = 0
  end
  object CxCodBarras: TEdit
    Left = 112
    Top = 24
    Width = 489
    Height = 23
    TabOrder = 1
    Text = '7898906467224'
    OnExit = CxCodBarrasExit
  end
  object GroupBox1: TGroupBox
    Left = 488
    Top = 70
    Width = 329
    Height = 174
    Caption = 'Configurac'#245'es'
    TabOrder = 2
    object LblUsername: TLabel
      Left = 26
      Top = 33
      Width = 59
      Height = 15
      Caption = 'Username :'
    end
    object LblPassword: TLabel
      Left = 26
      Top = 75
      Width = 56
      Height = 15
      Caption = 'Password :'
    end
    object Label1: TLabel
      Left = 26
      Top = 113
      Width = 24
      Height = 15
      Caption = 'API :'
    end
    object Label2: TLabel
      Left = 26
      Top = 145
      Width = 37
      Height = 15
      Caption = 'Token :'
    end
    object cxUsername: TEdit
      Left = 95
      Top = 30
      Width = 129
      Height = 23
      TabOrder = 0
    end
    object cxPassword: TEdit
      Left = 95
      Top = 72
      Width = 129
      Height = 23
      TabOrder = 1
    end
    object CbSelecionaAPI: TComboBox
      Left = 95
      Top = 110
      Width = 82
      Height = 23
      Style = csDropDownList
      CharCase = ecUpperCase
      ItemIndex = 0
      TabOrder = 2
      Text = 'RSC'
      Items.Strings = (
        'RSC'
        'COSMOS')
    end
    object CxTokenAPI: TEdit
      Left = 95
      Top = 142
      Width = 129
      Height = 23
      TabOrder = 3
    end
  end
end
