object frmRelProVenda: TfrmRelProVenda
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Venda'
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
    Left = 8
    Top = -10
    Width = 794
    Height = 1123
    DataSource = dtsVenda
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
        Width = 77
        Height = 24
        Caption = 'VENDA'
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
      Top = 262
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
      Height = 115
      DataFields = 'vendaId'
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
          Left = 68
          Top = 0
          Width = 47
          Height = 16
          Alignment = taRightJustify
          DataField = 'vendaId'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 52
          Height = 16
          Caption = 'VENDA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 18
        Width = 718
        Height = 23
        object RLDBText1: TRLDBText
          Left = 55
          Top = 3
          Width = 52
          Height = 16
          Alignment = taRightJustify
          DataField = 'clienteId'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 116
          Top = 3
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 652
          Top = 3
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'dataVenda'
          DataSource = dtsVenda
          DisplayMask = '#0.00'
          Text = ''
        end
        object RLLabel10: TRLLabel
          Left = 0
          Top = 3
          Width = 53
          Height = 16
          Caption = 'Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 107
          Top = 2
          Width = 9
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel13: TRLLabel
          Left = 608
          Top = 3
          Width = 38
          Height = 16
          Alignment = taCenter
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 41
        Width = 718
        Height = 64
        DataSource = dtsVendasItens
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 26
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel4: TRLLabel
            Left = 8
            Top = 6
            Width = 77
            Height = 16
            Caption = 'PRODUTOS'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel9: TRLLabel
            Left = 356
            Top = 6
            Width = 78
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel11: TRLLabel
            Left = 498
            Top = 6
            Width = 92
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Unit'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel12: TRLLabel
            Left = 644
            Top = 6
            Width = 74
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 26
          Width = 718
          Height = 22
          object rldbtxtprodutoId: TRLDBText
            Left = -5
            Top = 4
            Width = 57
            Height = 16
            Alignment = taRightJustify
            DataField = 'produtoId'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLLabel7: TRLLabel
            Left = 52
            Top = 4
            Width = 9
            Height = 16
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLDBText6: TRLDBText
            Left = 61
            Top = 4
            Width = 38
            Height = 16
            DataField = 'Nome'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLDBText3: TRLDBText
            Left = 366
            Top = 4
            Width = 67
            Height = 16
            Alignment = taRightJustify
            DataField = 'quantidade'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLDBText7: TRLDBText
            Left = 512
            Top = 4
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'valorUnitario'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLDBText8: TRLDBText
            Left = 643
            Top = 4
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'totalProduto'
            DataSource = dtsVendasItens
            Text = ''
          end
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 210
      Width = 718
      Height = 52
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 613
        Top = 24
        Width = 105
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalVenda'
        DataSource = dtsVenda
        DisplayMask = '#0.00'
        Info = riSum
        Text = ''
        Transparent = False
      end
      object RLDraw5: TRLDraw
        Left = 481
        Top = 9
        Width = 229
        Height = 9
        DrawKind = dkLine
      end
      object RLLabel5: TRLLabel
        Left = 481
        Top = 24
        Width = 105
        Height = 16
        Alignment = taRightJustify
        Caption = 'Total da Venda:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
  end
  object QryVenda: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      '       vendas.totalVenda'
      '  FROM vendas'
      
        '       INNER JOIN clientes on clientes.clienteId = vendas.client' +
        'eId'
      '  WHERE vendas.vendaId =:vendaId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 20
      end>
    Left = 403
    Top = 350
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 20
      end>
    object QryVendavendaId: TIntegerField
      FieldName = 'vendaId'
      ReadOnly = True
    end
    object QryVendaclienteId: TIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object QryVendanome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendadataVenda: TDateTimeField
      FieldName = 'dataVenda'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QryVendatotalVenda: TFloatField
      FieldName = 'totalVenda'
      Required = True
      DisplayFormat = '#0.00'
    end
  end
  object dtsVenda: TDataSource
    DataSet = QryVenda
    Left = 497
    Top = 350
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
  object QryVendasItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT vendasItens.vendaId,'
      '       vendasItens.produtoId,'
      '       produtos.Nome,'
      '       vendasItens.quantidade,'
      '       vendasItens.valorUnitario,'
      '       vendasItens.totalProduto'
      '  FROM vendasItens'
      
        '    INNER JOIN produtos on produtos.produtoId = vendasItens.prod' +
        'utoId'
      '  WHERE vendasItens.vendaId = :vendaId'
      'ORDER BY vendasItens.produtoId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 20
      end>
    Left = 606
    Top = 358
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 20
      end>
    object QryVendasItensvendaId: TIntegerField
      FieldName = 'vendaId'
      Required = True
    end
    object QryVendasItensprodutoId: TIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryVendasItensNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryVendasItensquantidade: TFloatField
      FieldName = 'quantidade'
      Required = True
    end
    object QryVendasItensvalorUnitario: TFloatField
      FieldName = 'valorUnitario'
      Required = True
    end
    object QryVendasItenstotalProduto: TFloatField
      FieldName = 'totalProduto'
      Required = True
    end
  end
  object dtsVendasItens: TDataSource
    DataSet = QryVendasItens
    Left = 700
    Top = 358
  end
end
