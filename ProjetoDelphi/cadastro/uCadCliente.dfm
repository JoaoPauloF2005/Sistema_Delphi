inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 388
  ClientWidth = 982
  Position = poDesktopCenter
  ExplicitWidth = 988
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 982
    Height = 333
    ActivePage = tabManutencao
    ExplicitWidth = 982
    ExplicitHeight = 333
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 974
      ExplicitHeight = 305
      inherited pnlListagemTopo: TPanel
        Width = 974
        ExplicitWidth = 974
      end
      inherited grdListagem: TDBGrid
        Width = 974
        Height = 242
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
            FieldName = 'tipoPessoa'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cpfCnpj'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bairro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'estado'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dataNascimento'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 974
      ExplicitHeight = 305
      object Label1: TLabel
        Left = 753
        Top = 125
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label2: TLabel
        Left = 753
        Top = 233
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label3: TLabel
        Left = 611
        Top = 130
        Width = 81
        Height = 13
        Caption = 'Data Nascimento'
      end
      object Label4: TLabel
        Left = 611
        Top = 233
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object TLabel
        Left = 611
        Top = 77
        Width = 20
        Height = 13
        Caption = 'Tipo'
      end
      object edtNome: TLabeledEdit
        Left = 11
        Top = 93
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
        Left = 753
        Top = 144
        Width = 130
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 6
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 11
        Top = 197
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
        TabOrder = 7
      end
      object edtCidade: TLabeledEdit
        Left = 11
        Top = 249
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
        TabOrder = 9
      end
      object edtTelefone: TMaskEdit
        Left = 755
        Top = 249
        Width = 127
        Height = 21
        EditMask = '(99) 9999-9999;1;_'
        MaxLength = 14
        TabOrder = 11
        Text = '(  )     -    '
      end
      object edtEmail: TLabeledEdit
        Left = 11
        Top = 144
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
        TabOrder = 4
      end
      object edtDataNascimento: TDateEdit
        Left = 611
        Top = 144
        Width = 127
        Height = 21
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 5
      end
      object edtEstado: TComboBox
        Left = 611
        Top = 249
        Width = 127
        Height = 21
        Style = csDropDownList
        TabOrder = 10
      end
      object edtBairro: TLabeledEdit
        Left = 611
        Top = 197
        Width = 272
        Height = 21
        BiDiMode = bdLeftToRight
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 30
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 8
      end
      object edtcpfCnpj: TLabeledEdit
        Left = 753
        Top = 93
        Width = 130
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'CPF/CNPJ'
        MaxLength = 60
        TabOrder = 3
        OnChange = edtcpfCnpjChange
      end
      object edttipoPessoa: TComboBox
        Left = 611
        Top = 93
        Width = 127
        Height = 21
        Style = csDropDownList
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 333
    Width = 982
    ExplicitTop = 333
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
      '                                tipoPessoa,'
      '                                cpfCnpj,'
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
    object QryListagemtipoPessoa: TWideStringField
      DisplayLabel = 'Tipo Pessoa'
      FieldName = 'tipoPessoa'
      Size = 10
    end
    object QryListagemcpfCnpj: TWideStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'cpfCnpj'
      Size = 14
    end
    object QryListagemendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o'
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
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object QryListagemtelefone: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 100
    end
    object QryListagememail: TWideStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 100
    end
    object QryListagemdataNascimento: TDateTimeField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'dataNascimento'
    end
  end
  inherited dtsListagem: TDataSource
    DataSet = QryListagem
    Left = 696
  end
end
