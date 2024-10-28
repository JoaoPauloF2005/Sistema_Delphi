inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro de A'#231#227'o de Acesso'
  ClientHeight = 421
  ClientWidth = 756
  Position = poScreenCenter
  ExplicitWidth = 762
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 756
    Height = 366
    ActivePage = tabManutencao
    ExplicitWidth = 756
    ExplicitHeight = 366
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 748
      ExplicitHeight = 338
      inherited pnlListagemTopo: TPanel
        Width = 748
        ExplicitWidth = 748
      end
      inherited grdListagem: TDBGrid
        Width = 748
        Height = 275
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'acaoAcessoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 359
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'chave'
            Width = 253
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 748
      ExplicitHeight = 338
      object edtAcaoAcessoId: TLabeledEdit
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
        Width = 723
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 1
      end
      object edtChave: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 152
        Width = 423
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Chave'
        MaxLength = 60
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 366
    Width = 756
    ExplicitTop = 366
    ExplicitWidth = 756
    inherited btnGravar: TBitBtn
      Left = 270
      ExplicitLeft = 270
    end
    inherited btnFechar: TBitBtn
      Left = 663
      ExplicitLeft = 663
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT acaoAcessoId,'
      '       descricao,'
      '       chave'
      '  FROM acaoAcesso')
    Left = 597
    Top = 38
    object QryListagemacaoAcessoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'acaoAcessoId'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QryListagemchave: TWideStringField
      DisplayLabel = 'Chave'
      FieldName = 'chave'
      Required = True
      Size = 60
    end
  end
  inherited dtsListagem: TDataSource
    DataSet = QryListagem
    Left = 688
    Top = 38
  end
end
