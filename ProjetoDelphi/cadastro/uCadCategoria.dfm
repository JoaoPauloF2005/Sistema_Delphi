inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientHeight = 486
  ClientWidth = 955
  Position = poScreenCenter
  ExplicitWidth = 961
  ExplicitHeight = 515
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 825
    Height = 431
    ExplicitWidth = 825
    ExplicitHeight = 431
    inherited tabListagem: TTabSheet
      ExplicitWidth = 817
      ExplicitHeight = 403
      inherited grdListagem: TDBGrid
        Top = 41
        Width = 817
        Height = 362
        Align = alClient
        BorderStyle = bsNone
        DataSource = dtsListagem
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'categoriaId'
            Title.Alignment = taCenter
            Width = 95
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'descricao'
            Title.Alignment = taCenter
            Width = 708
            Visible = True
          end>
      end
      inherited pExportar: TPanel
        Left = 262
        Top = 112
        ExplicitLeft = 262
        ExplicitTop = 112
      end
      inherited Panel6: TPanel
        Width = 817
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 817
        inherited SearchBox1: TSearchBox
          Top = 11
          OnChange = SearchBox1Change
          ExplicitTop = 11
        end
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 817
      ExplicitHeight = 403
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
    end
  end
  inherited pnlRodape: TPanel
    Top = 431
    Width = 955
    ExplicitTop = 431
    ExplicitWidth = 955
  end
  inherited Panel2: TPanel
    Left = 825
    Height = 431
    ExplicitLeft = 825
    ExplicitHeight = 431
    inherited btnFechar: TBitBtn
      Left = 12
      Top = 376
      ExplicitLeft = 12
      ExplicitTop = 376
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId, descricao FROM categorias')
    Left = 482
    Top = 130
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
    Left = 544
    Top = 131
  end
end
