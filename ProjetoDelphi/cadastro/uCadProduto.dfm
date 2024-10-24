inherited frmCadProduto: TfrmCadProduto
  ActiveControl = edtNome
  Caption = 'Cadastro de Produtos'
  ClientHeight = 451
  ClientWidth = 982
  Position = poDesktopCenter
  ExplicitWidth = 988
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 982
    Height = 396
    ActivePage = tabManutencao
    ExplicitWidth = 982
    ExplicitHeight = 396
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 974
      ExplicitHeight = 368
      inherited pnlListagemTopo: TPanel
        Width = 974
        ExplicitWidth = 974
      end
      inherited grdListagem: TDBGrid
        Width = 974
        Height = 305
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Width = 126
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Width = 154
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoCategoria'
            Width = 313
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 974
      ExplicitHeight = 368
      object Label1: TLabel
        Left = 11
        Top = 134
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 11
        Top = 262
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 157
        Top = 262
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 614
        Top = 79
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        Enabled = False
        MaxLength = 10
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 96
        Width = 579
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtDescricao: TMemo
        Left = 11
        Top = 153
        Width = 947
        Height = 89
        Ctl3D = True
        DoubleBuffered = False
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
      end
      object edtValor: TCurrencyEdit
        Left = 11
        Top = 281
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object edtQuantidade: TCurrencyEdit
        Left = 157
        Top = 281
        Width = 121
        Height = 21
        DisplayFormat = ' ,0.00;- ,0.00'
        TabOrder = 5
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 614
        Top = 96
        Width = 344
        Height = 21
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 396
    Width = 982
    ExplicitTop = 396
    ExplicitWidth = 982
    inherited btnFechar: TBitBtn
      Left = 889
      ExplicitLeft = 889
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT p.produtoId,'
      #9'     p.nome,'
      #9'     p.descricao,'
      #9'     p.valor,'
      #9'     p.quantidade,'
      #9'     p.categoriaId,'
      #9'     c.descricao As DescricaoCategoria'
      'From produtos as p'
      #9'LEFT JOIN categorias as c on c.categoriaId = p.categoriaId')
    Left = 730
    Top = 33
    object QryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object QryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object QryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object QryListagemcategoriaId: TIntegerField
      DisplayLabel = 'Cod. Categoria'
      FieldName = 'categoriaId'
    end
    object QryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Descri'#231#227'o da Categoria'
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    DataSet = QryListagem
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'Select categoriaId, descricao from categorias')
    Params = <>
    Left = 512
    Top = 316
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
    Left = 592
    Top = 304
  end
end
