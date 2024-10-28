inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
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
            FieldName = 'clienteId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 22
      ExplicitWidth = 974
      ExplicitHeight = 368
      object Label1: TLabel
        Left = 611
        Top = 80
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label2: TLabel
        Left = 611
        Top = 232
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label3: TLabel
        Left = 11
        Top = 280
        Width = 81
        Height = 13
        Caption = 'Data Nascimento'
      end
      object Label4: TLabel
        Left = 611
        Top = 183
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object edtNome: TLabeledEdit
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
      object edtClienteId: TLabeledEdit
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
      object edtCEP: TMaskEdit
        Left = 611
        Top = 96
        Width = 248
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 11
        Top = 150
        Width = 579
        Height = 21
        BiDiMode = bdLeftToRight
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
      end
      object edtCidade: TLabeledEdit
        Left = 11
        Top = 202
        Width = 579
        Height = 21
        BiDiMode = bdLeftToRight
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 50
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 5
      end
      object edtTelefone: TMaskEdit
        Left = 611
        Top = 247
        Width = 248
        Height = 21
        EditMask = '(99) 9999-9999;1;_'
        MaxLength = 14
        TabOrder = 8
        Text = '(  )     -    '
      end
      object edtEmail: TLabeledEdit
        Left = 11
        Top = 247
        Width = 579
        Height = 21
        BiDiMode = bdLeftToRight
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        MaxLength = 100
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 7
      end
      object edtDataNascimento: TDateEdit
        Left = 11
        Top = 298
        Width = 121
        Height = 21
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 9
      end
      object edtEstado: TComboBox
        Left = 611
        Top = 202
        Width = 248
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
      object edtBairro: TLabeledEdit
        Left = 611
        Top = 150
        Width = 248
        Height = 21
        BiDiMode = bdLeftToRight
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 30
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
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
      'select clienteId,'
      #9#9'nome,'
      #9#9'endereco,'
      #9#9'cidade,'
      #9#9'bairro,'
      #9#9'estado,'
      #9#9'cep,'
      #9#9'telefone,'
      #9#9'email,'
      #9#9'dataNascimento'
      'from clientes')
    Left = 623
    Top = 30
    object QryListagemclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemendereco: TWideStringField
      DisplayLabel = 'Endereco'
      FieldName = 'endereco'
      Size = 60
    end
    object QryListagemcidade: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 50
    end
    object QryListagembairro: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 40
    end
    object QryListagemestado: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object QryListagemcep: TWideStringField
      DisplayLabel = 'Cep'
      FieldName = 'cep'
      Size = 10
    end
    object QryListagemtelefone: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 14
    end
    object QryListagememail: TWideStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 100
    end
    object QryListagemdataNascimento: TDateTimeField
      DisplayLabel = 'Data Nascimento'
      FieldName = 'dataNascimento'
    end
  end
  inherited dtsListagem: TDataSource
    DataSet = QryListagem
    Left = 696
  end
end
