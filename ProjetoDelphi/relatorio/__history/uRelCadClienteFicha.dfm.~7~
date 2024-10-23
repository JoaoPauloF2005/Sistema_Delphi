object frmRelCadClienteFicha: TfrmRelCadClienteFicha
  Left = 0
  Top = 0
  Caption = 'frmRelCadClienteFicha'
  ClientHeight = 740
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 8
    Top = -6
    Width = 794
    Height = 1123
    DataSource = dtsCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 57
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 3
        Top = 15
        Width = 179
        Height = 24
        Caption = 'Ficha de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 359
        Top = 45
        Width = 359
        Height = 12
        Align = faClientBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 45
        Width = 359
        Height = 12
        Align = faClientBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object Rodapé: TRLBand
      Left = 38
      Top = 221
      Width = 718
      Height = 39
      BandType = btFooter
      object RLDraw3: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 19
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 20
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 674
        Top = 20
        Width = 19
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 700
        Top = 20
        Width = 17
        Height = 16
        Alignment = taRightJustify
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 693
        Top = 20
        Width = 12
        Height = 16
        Caption = '/'
      end
      object RLLabel3: TRLLabel
        Left = 629
        Top = 20
        Width = 53
        Height = 16
        Alignment = taRightJustify
        Caption = 'P'#225'gina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 95
      Width = 718
      Height = 126
      object RLDBText1: TRLDBText
        Left = 61
        Top = 0
        Width = 52
        Height = 16
        DataField = 'clienteId'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 61
        Top = 19
        Width = 25
        Height = 16
        DataField = 'cep'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 315
        Top = 56
        Width = 35
        Height = 16
        DataField = 'email'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 61
        Top = 56
        Width = 49
        Height = 16
        DataField = 'telefone'
        DataSource = dtsCliente
        Text = ''
      end
      object RLLabel4: TRLLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 16
        Caption = 'C'#243'digo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 0
        Top = 19
        Width = 34
        Height = 16
        Caption = 'CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 268
        Top = 56
        Width = 44
        Height = 16
        Alignment = taCenter
        Caption = 'Email:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 0
        Top = 56
        Width = 64
        Height = 16
        Caption = 'Telefone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText5: TRLDBText
        Left = 315
        Top = 0
        Width = 38
        Height = 16
        DataField = 'Nome'
        DataSource = dtsCliente
        Text = ''
      end
      object RLLabel8: TRLLabel
        Left = 267
        Top = 0
        Width = 45
        Height = 16
        Alignment = taCenter
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText6: TRLDBText
        Left = 315
        Top = 19
        Width = 57
        Height = 16
        DataField = 'endereco'
        DataSource = dtsCliente
        Text = ''
      end
      object RLLabel9: TRLLabel
        Left = 231
        Top = 19
        Width = 81
        Height = 16
        Alignment = taCenter
        Caption = 'Logradouro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText7: TRLDBText
        Left = 61
        Top = 38
        Width = 36
        Height = 16
        DataField = 'bairro'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 315
        Top = 38
        Width = 42
        Height = 16
        DataField = 'cidade'
        DataSource = dtsCliente
        Text = ''
      end
      object RLLabel10: TRLLabel
        Left = 0
        Top = 38
        Width = 47
        Height = 16
        Caption = 'Bairro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 259
        Top = 38
        Width = 53
        Height = 16
        Alignment = taCenter
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText9: TRLDBText
        Left = 665
        Top = 38
        Width = 43
        Height = 16
        DataField = 'estado'
        DataSource = dtsCliente
        Text = ''
      end
      object RLLabel12: TRLLabel
        Left = 634
        Top = 38
        Width = 25
        Height = 16
        Caption = 'UF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText10: TRLDBText
        Left = 141
        Top = 75
        Width = 98
        Height = 16
        DataField = 'dataNascimento'
        DataSource = dtsCliente
        Text = ''
      end
      object RLLabel13: TRLLabel
        Left = 0
        Top = 75
        Width = 135
        Height = 16
        Caption = 'Data de Nascimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT clienteId,'
      '       nome,'
      '       cep,'
      '       endereco,'
      '       bairro,'
      '       cidade,'
      '       estado,'
      '       email,'
      '       telefone,'
      '       dataNascimento'
      '  FROM clientes'
      'ORDER BY nome'
      '')
    Params = <>
    Left = 404
    Top = 349
    object QryClienteclienteId: TIntegerField
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryClienteNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryClienteemail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object QryClientetelefone: TWideStringField
      FieldName = 'telefone'
      Size = 14
    end
    object QryClientecep: TWideStringField
      FieldName = 'cep'
      Size = 10
    end
    object QryClienteendereco: TWideStringField
      FieldName = 'endereco'
      Size = 60
    end
    object QryClientebairro: TWideStringField
      FieldName = 'bairro'
      Size = 40
    end
    object QryClientecidade: TWideStringField
      FieldName = 'cidade'
      Size = 50
    end
    object QryClienteestado: TWideStringField
      FieldName = 'estado'
      Size = 2
    end
    object QryClientedataNascimento: TDateTimeField
      FieldName = 'dataNascimento'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 497
    Top = 351
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 455
    Top = 407
  end
end
