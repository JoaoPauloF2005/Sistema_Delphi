inherited frmCadSubCategoria: TfrmCadSubCategoria
  Caption = 'Cadastro de SubCategoria'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Top = 41
        Height = 491
        Align = alClient
        DataSource = dtsListagem
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'subCategoriaId'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'categoriaId'
            Visible = False
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Descri'#231#227'oCategoria'
            Visible = True
          end>
      end
      inherited Panel6: TPanel
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 892
      end
    end
    inherited tabManutencao: TTabSheet
      object Label1: TLabel
        Left = 169
        Top = 25
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 96
        Width = 579
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 0
      end
      object edtSubCategoriaId: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 1
      end
      object lcbCategoria: TDBLookupComboBox
        Left = 169
        Top = 44
        Width = 167
        Height = 21
        KeyField = 'categoriaId'
        ListField = 'descricao'
        TabOrder = 2
      end
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT'
      '    sc.subCategoriaId,'
      '    sc.descricao,'
      '    sc.categoriaId,'
      '    c.descricao AS Descri'#231#227'oCategoria'
      'FROM '
      '    subCategorias sc'
      'LEFT JOIN '
      '    categorias c ON sc.categoriaId = c.categoriaId;')
    Top = 32
    object QryListagemsubCategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'subCategoriaId'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'SubCategoria'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QryListagemcategoriaId: TIntegerField
      FieldName = 'categoriaId'
    end
    object QryListagemDescriçãoCategoria: TWideStringField
      DisplayLabel = 'Categoria'
      FieldName = 'Descri'#231#227'oCategoria'
      Size = 30
    end
  end
  inherited ImageList1: TImageList
    Left = 847
    Top = 177
  end
  inherited SaveDialog: TSaveDialog
    Left = 816
    Top = 131
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'Select categoriaId, descricao from categorias')
    Params = <>
    Left = 851
    Top = 238
    object QryCategoriacategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryCategoriadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 850
    Top = 285
  end
end
