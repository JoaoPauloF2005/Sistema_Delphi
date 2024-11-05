inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 390
  ClientWidth = 715
  Position = poScreenCenter
  ExplicitWidth = 721
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 585
    Height = 335
    ExplicitWidth = 585
    ExplicitHeight = 335
    inherited tabListagem: TTabSheet
      ExplicitWidth = 577
      ExplicitHeight = 307
      inherited grdListagem: TDBGrid
        Width = 754
        Height = 307
        DataSource = dtsListagem
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'usuarioID'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'nome'
            Title.Alignment = taCenter
            Width = 641
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 577
      ExplicitHeight = 288
      object edtUsuarioId: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 35
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Left = 11
        Top = 87
        Width = 465
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Usu'#225'rio'
        MaxLength = 50
        TabOrder = 1
      end
      object edtSenha: TLabeledEdit
        Left = 11
        Top = 138
        Width = 247
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 335
    Width = 715
    ExplicitTop = 335
    ExplicitWidth = 715
  end
  inherited Panel2: TPanel
    Left = 585
    Height = 335
    ExplicitLeft = 585
    ExplicitHeight = 335
    inherited btnFechar: TBitBtn
      Left = 12
      Top = 285
      ExplicitLeft = 12
      ExplicitTop = 285
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT usuarioID,'
      '       nome,'
      '       Senha'
      'FROM usuarios')
    Left = 254
    Top = 64
    object QryListagemusuarioID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioID'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryListagemSenha: TWideStringField
      FieldName = 'Senha'
      Required = True
      Size = 40
    end
  end
  inherited dtsListagem: TDataSource
    Left = 345
    Top = 65
  end
end
