inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 371
  ClientWidth = 762
  Position = poScreenCenter
  ExplicitWidth = 768
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 762
    Height = 316
    ActivePage = tabManutencao
    ExplicitWidth = 762
    ExplicitHeight = 316
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 754
      ExplicitHeight = 288
      inherited pnlListagemTopo: TPanel
        Width = 754
        ExplicitWidth = 754
      end
      inherited grdListagem: TDBGrid
        Width = 754
        Height = 225
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'usuarioID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 641
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 754
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
        Width = 710
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
    Top = 316
    Width = 762
    ExplicitTop = 316
    ExplicitWidth = 762
    inherited btnFechar: TBitBtn
      Left = 672
      ExplicitLeft = 672
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT usuarioID,'
      '       nome,'
      '       Senha'
      'FROM usuarios')
    Left = 582
    Top = 41
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
    DataSet = QryListagem
    Left = 673
    Top = 42
  end
end
