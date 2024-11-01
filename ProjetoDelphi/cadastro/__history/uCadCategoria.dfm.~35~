inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientHeight = 451
  ClientWidth = 982
  Position = poScreenCenter
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
      inherited btnPesquisar: TButton
        Top = 20
        ExplicitTop = 20
      end
      inherited grdListagem: TDBGrid
        Width = 974
        Height = 305
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 555
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 974
      ExplicitHeight = 368
      object edtCategoriaId: TLabeledEdit
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
        TabOrder = 0
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
        TabOrder = 1
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 396
    Width = 982
    ExplicitTop = 396
    ExplicitWidth = 982
    inherited btnGravar: TBitBtn
      Left = 268
      ExplicitLeft = 268
    end
    inherited btnFechar: TBitBtn
      Left = 888
      ExplicitLeft = 888
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId, descricao FROM categorias')
    object intgrfldQryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object wdstrngfldQryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    DataSet = QryListagem
  end
end
