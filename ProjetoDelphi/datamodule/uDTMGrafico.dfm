object DTMGrafico: TDTMGrafico
  OldCreateOrder = False
  Height = 378
  Width = 639
  object QryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, produtoId) +'#39' - '#39' +nome AS Label, Quanti' +
        'dade AS Value FROM produtos')
    Params = <>
    Left = 193
    Top = 26
    object QryProdutoEstoqueLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object QryProdutoEstoqueValue: TFloatField
      FieldName = 'Value'
    end
  end
  object ProdutoEstoque: TDataSource
    DataSet = QryProdutoEstoque
    Left = 286
    Top = 37
  end
end
