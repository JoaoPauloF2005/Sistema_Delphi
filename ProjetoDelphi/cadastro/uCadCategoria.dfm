inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientHeight = 389
  ClientWidth = 759
  Position = poScreenCenter
  ExplicitWidth = 765
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 629
    Height = 334
    ActivePage = tabManutencao
    ExplicitWidth = 629
    ExplicitHeight = 334
    inherited tabListagem: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 844
      ExplicitHeight = 368
      inherited grdListagem: TDBGrid
        Width = 974
        Height = 243
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
            Width = 555
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 621
      ExplicitHeight = 306
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
    Top = 334
    Width = 759
    ExplicitTop = 334
    ExplicitWidth = 759
  end
  inherited Panel2: TPanel
    Left = 629
    Height = 334
    ExplicitLeft = 629
    ExplicitHeight = 334
    inherited btnFechar: TBitBtn
      Left = 12
      Top = 284
      ExplicitLeft = 12
      ExplicitTop = 284
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId, descricao FROM categorias')
    Left = 265
    Top = 189
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
    Left = 356
    Top = 188
  end
end
