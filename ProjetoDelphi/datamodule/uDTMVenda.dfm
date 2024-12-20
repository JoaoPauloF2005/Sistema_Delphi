﻿object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 266
  Width = 589
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT clienteId,'
      '     nome'
      'FROM clientes')
    Params = <>
    Left = 91
    Top = 59
    object QryClienteclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryClientenome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtoId,'
      '       nome,'
      '       valor,'
      '       quantidade'
      '  From produtos')
    Params = <>
    Left = 185
    Top = 63
    object Código: TIntegerField
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object Nome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object Valor: TFloatField
      FieldName = 'valor'
      DisplayFormat = 'R$ #,##0.00'
    end
    object QryProdutosquantidade: TFloatField
      FieldName = 'quantidade'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 277
    Top = 65
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'valorUnitario'
      DisplayFormat = 'R$ #,##0.00'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total do Produto'
      FieldName = 'valorTotalProduto'
      DisplayFormat = 'R$ #,##0.00'
    end
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 279
    Top = 117
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 86
    Top = 115
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 186
    Top = 117
  end
end
