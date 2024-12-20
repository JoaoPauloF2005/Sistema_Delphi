﻿object frmRelCadProdutoComGrupoCategoria: TfrmRelCadProdutoComGrupoCategoria
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Cadastro de Produto por Categoria'
  ClientHeight = 740
  ClientWidth = 819
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
    Left = 2
    Top = -9
    Width = 794
    Height = 1123
    DataSource = dtsProdutos
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
        Width = 372
        Height = 24
        Caption = 'Listagem de Produtos por Categoria'
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
      Top = 233
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
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 95
      Width = 718
      Height = 138
      DataFields = 'categoriaId'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object RLDBText5: TRLDBText
          Left = 83
          Top = 0
          Width = 22
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'categoriaId'
          DataSource = dtsProdutos
          Text = ''
          Transparent = False
        end
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 84
          Height = 16
          Caption = 'CATEGORIA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText6: TRLDBText
          Left = 119
          Top = -1
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLLabel9: TRLLabel
          Left = 105
          Top = -3
          Width = 8
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 18
        Width = 718
        Height = 16
        BandType = btColumnHeader
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel10: TRLLabel
          Left = 76
          Top = 0
          Width = 115
          Height = 16
          Caption = 'Nome do Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 0
          Top = 0
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel12: TRLLabel
          Left = 435
          Top = 0
          Width = 152
          Height = 16
          Caption = 'Quantidade de Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel13: TRLLabel
          Left = 680
          Top = 0
          Width = 38
          Height = 16
          Alignment = taCenter
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 34
        Width = 718
        Height = 23
        object RLDBText1: TRLDBText
          Left = 0
          Top = 3
          Width = 57
          Height = 16
          DataField = 'produtoId'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 76
          Top = 3
          Width = 38
          Height = 16
          DataField = 'Nome'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 516
          Top = 3
          Width = 71
          Height = 16
          Alignment = taRightJustify
          DataField = 'Quantidade'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 678
          Top = 3
          Width = 40
          Height = 16
          Alignment = taRightJustify
          DataField = 'Valor'
          DataSource = dtsProdutos
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 57
        Width = 718
        Height = 59
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 609
          Top = 16
          Width = 109
          Height = 16
          Alignment = taRightJustify
          DataField = 'Quantidade'
          DataSource = dtsProdutos
          Info = riSum
          Text = ''
          Transparent = False
        end
        object RLDraw4: TRLDraw
          Left = 336
          Top = 4
          Width = 382
          Height = 9
          DrawKind = dkLine
        end
        object RLLabel4: TRLLabel
          Left = 336
          Top = 16
          Width = 243
          Height = 16
          Alignment = taRightJustify
          Caption = 'Quantidade de Estoque por Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = 387
          Top = 38
          Width = 192
          Height = 16
          Alignment = taRightJustify
          Caption = 'M'#233'dia de Valor por Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResult2: TRLDBResult
          Left = 626
          Top = 38
          Width = 92
          Height = 16
          Alignment = taRightJustify
          DataField = 'Valor'
          DataSource = dtsProdutos
          Info = riAverage
          Text = ''
          Transparent = False
        end
      end
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT produtos.produtoId,'
      '       produtos.Nome,'
      '       produtos.Descricao,'
      '       produtos.Valor,'
      '       produtos.Quantidade,'
      '       produtos.categoriaId,'
      '       categorias.descricao AS DescricaoCategoria'
      '  FROM produtos'
      
        '      LEFT JOIN categorias on categorias.CategoriaId = produtos.' +
        'CategoriaId'
      'ORDER BY produtos.categoriaId, produtos.produtoId')
    Params = <>
    Left = 403
    Top = 350
    object QryProdutosprodutoId: TIntegerField
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryProdutosNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryProdutosValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#0.00'
    end
    object QryProdutosQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '#0.00'
    end
    object QryProdutosDescricao: TWideStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object QryProdutoscategoriaId: TIntegerField
      FieldName = 'categoriaId'
    end
    object QryProdutosDescricaoCategoria: TWideStringField
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
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
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 455
    Top = 469
  end
end
