inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro de A'#231#227'o de Acesso'
  ClientHeight = 437
  ClientWidth = 731
  Position = poScreenCenter
  ExplicitWidth = 737
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 601
    Height = 382
    ActivePage = tabManutencao
    ExplicitWidth = 601
    ExplicitHeight = 382
    inherited tabListagem: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 618
      ExplicitHeight = 338
      inherited grdListagem: TDBGrid
        Width = 612
        Height = 291
        DataSource = dtsListagem
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'acaoAcessoId'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'descricao'
            Title.Alignment = taCenter
            Width = 359
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'chave'
            Title.Alignment = taCenter
            Width = 253
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 593
      ExplicitHeight = 354
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
        Width = 566
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
    Top = 382
    Width = 731
    ExplicitTop = 382
    ExplicitWidth = 731
  end
  inherited Panel2: TPanel
    Left = 601
    Height = 382
    ExplicitLeft = 601
    ExplicitHeight = 382
    inherited btnFechar: TBitBtn
      Left = 12
      Top = 328
      ExplicitLeft = 12
      ExplicitTop = 328
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT acaoAcessoId,'
      '       descricao,'
      '       chave'
      '  FROM acaoAcesso')
    Left = 402
    Top = 148
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
    Left = 317
    Top = 32
  end
end
