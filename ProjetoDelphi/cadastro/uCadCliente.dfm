inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 388
  ClientWidth = 1091
  Position = poDesktopCenter
  ExplicitWidth = 1097
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 1091
    Height = 333
    ExplicitWidth = 982
    ExplicitHeight = 333
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 974
      ExplicitHeight = 305
      inherited pnlListagemTopo: TPanel
        Width = 1083
        ExplicitWidth = 974
      end
      inherited grdListagem: TDBGrid
        Width = 1083
        Height = 242
        DataSource = dtsListagem
        TitleFont.Color = clBlack
        Columns = <
          item
            Expanded = False
            Width = 27
            Visible = True
          end
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
      object TLabel
        Left = 161
        Top = 21
        Width = 31
        Height = 13
        Caption = 'Status'
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
        NumbersOnly = True
        TabOrder = 3
        OnChange = edtcpfCnpjChange
        OnEnter = edtcpfCnpjEnter
      end
      object edttipoPessoa: TComboBox
        Left = 611
        Top = 93
        Width = 127
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = edttipoPessoaChange
      end
      object edtTelefone: TLabeledEdit
        Left = 762
        Top = 249
        Width = 121
        Height = 21
        EditLabel.Width = 42
        EditLabel.Height = 13
        EditLabel.Caption = 'Telefone'
        TabOrder = 11
        OnChange = edtTelefoneChange
      end
      object cbStatus: TComboBox
        Left = 161
        Top = 40
        Width = 127
        Height = 21
        Style = csDropDownList
        TabOrder = 12
        OnChange = edttipoPessoaChange
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 333
    Width = 1091
    ExplicitTop = 333
    ExplicitWidth = 982
    inherited btnFechar: TBitBtn
      Left = 998
      ExplicitLeft = 889
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    object Panel1: TPanel
      Left = 670
      Top = 6
      Width = 321
      Height = 38
      TabOrder = 7
      object Image1: TImage
        Left = 9
        Top = 12
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          0000100000000100180000000000000300001017000010170000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0E3
          902AB419009900019A00019A000099002AB419A1E391FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF44BF31019A000DA60025BE0037D00034CD0022BB00
          0EA700019A0043BE31FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF43BE31059E0025BE
          0035CE0033CC0031CA0031CA0031CA0031CA001EB700049D0041BD31FFFFFFFF
          FFFFFFFFFF9EE091019A0021BA002FC8002AC30026BF0024BD0023BC0024BD00
          26BF002AC3001BB400019A009CDE91FFFFFFFFFFFF26B0190CA50028C10023BC
          001DB60019B20017B00016AF0017B00019B2001DB60022BB0007A00024AE19FF
          FFFFFFFFFF00990018B1001EB70017B00011AA000CA5000AA30009A2000AA300
          0CA50011AA0017B00010A900009900FFFFFFFFFFFF00990019B20014AD000CA5
          00059E000199010B9D0B0E9F0E0B9D0B019901059E000CA50012AB00009900FF
          FFFFFFFFFF00990013AC000AA300019A0015A11527A92733AD3337AF3733AD33
          27A92715A115019A0009A200009900FFFFFFFFFFFF00990008A100019A001CA4
          1C37AF374DB84D5CBE5C61C0615CBE5C4DB84D37AF371CA41C019A00009900FF
          FFFFFFFFFF1DA719019A0015A11537AF3757BC5771C67183CD838AD08A83CD83
          71C67157BC5735AE35059B051AA419FFFFFFFFFFFF92D5900099001AA41A4DB8
          4D71C67191D391AADDAAB3E1B3AADDAA91D39171C6712FAC2F00990091D391FF
          FFFFFFFFFFFFFFFF33AD33059B053EB23E81CC81AADDAACCEBCCDDF1DDCCEBCC
          A6DBA654BA54069B063EB13EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FB23F029A
          0226A82678C978CDEACDEFF9EF8CD18C29AA29029A0249B649FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFA1DAA135AE35019901019901019901019901
          3EB13EA9DDA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
      end
      object Label2: TLabel
        Left = 29
        Top = 12
        Width = 25
        Height = 13
        Caption = 'Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image2: TImage
        Left = 57
        Top = 12
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          0000100000000100180000000000000300001017000010170000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0E0
          E064AEAE338F8F339090339090338F8F63AEAEC1E1E1FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF7BBBBB3490904AA0A079C2C29BDBDB95D7D771BDBD
          4CA1A133909079BBBBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF79BBBB3B959579C4
          C49EE0E09EE1E19CE0E09BE0E09CE0E09ADEDE70BEBE39949477BABAFFFFFFFF
          FFFFFFFFFFBEE0E034909076C2C299DFDF95DDDD91DBDB8FDBDB8EDADA8FDBDB
          91DBDB95DDDD6EBDBD339090BDDFDFFFFFFFFFFFFF5EACAC4CA3A392DBDB8DDA
          DA88D8D884D6D682D5D581D5D582D5D584D6D688D8D88AD7D7449D9D5DABABFF
          FFFFFFFFFF328F8F6DBEBE89D8D882D5D57CD3D377D1D175D0D074CFCF75D0D0
          77D1D17CD3D382D5D561B7B7328F8FFFFFFFFFFFFF328F8F7FD1D17FD4D477D1
          D170CECE6BCCCC6BCCCC6ECDCD6BCCCC6BCCCC70CECE77D1D176CCCC328F8FFF
          FFFFFFFFFF328F8F7AD0D075D0D06CCCCC72CECE7CD2D283D4D486D5D583D4D4
          7CD2D272CECE6CCCCC6CC7C7328F8FFFFFFFFFFFFF328F8F5EB9B96CCCCC76CF
          CF86D5D593D9D99BDCDC9EDDDD9BDCDC93D9D986D5D576CFCF53B2B2328F8FFF
          FFFFFFFFFF56A8A8409E9E70CDCD86D5D598DBDBA7E1E1B3E4E4B6E6E6B3E4E4
          A7E1E198DBDB83D3D3409D9D54A8A8FFFFFFFFFFFFB3DBDB33909063BBBB93D9
          D9A7E1E1BBE7E7C9ECECCFEEEEC9ECECBBE7E7A7E1E16DBCBC339090B1DADAFF
          FFFFFFFFFFFFFFFF67B4B43A969678C3C3B1E3E3C9ECECDDF3F3E7F7F7DDF3F3
          C5EAEA85C6C63994946EB5B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EB5B53490
          9057A7A79BCFCFDAEFEFF2F8F8A4D1D156A5A534909074B8B8FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFBADDDD62ACAC338F8F338F8F338F8F338F8F
          67AEAEBEDEDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
      end
      object Label5: TLabel
        Left = 77
        Top = 12
        Width = 40
        Height = 13
        Caption = 'Aten'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image3: TImage
        Left = 120
        Top = 12
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          0000100000000100180000000000000300001017000010170000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA3A3
          E42E2EC30000B90101B90101B90000B92D2DC3A4A4E4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF4848CA0101B91010BC2F2FC24545C64242C62A2AC1
          1111BC0101B94747CAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4747CA0606BA2F2F
          C24646C74444C64242C64242C64242C64141C52828C10505BA4545CAFFFFFFFF
          FFFFFFFFFFA1A1E40101B92C2CC24040C63B3BC53838C43636C43535C43636C4
          3838C43B3BC52525C10101B99F9FE4FFFFFFFFFFFF2929C31010BC3A3AC53434
          C42F2FC32B2BC22929C22828C22929C22B2BC22F2FC33232C40B0BBB2727C3FF
          FFFFFFFFFF0000B92323C03030C32929C22323C11F1FC01C1CC01B1BC01C1CC0
          1F1FC02323C12929C21A1ABE0000B9FFFFFFFFFFFF0000B92929C22626C21E1E
          C01818BF1313BE1010BE0F0FBE1010BE1313BE1818BF1E1EC02121C10000B9FF
          FFFFFFFFFF0000B92424C11C1CC01414BF0C0CBD0707BC0707BD0C0CBE0707BD
          0707BC0C0CBD1414BF1818BF0000B9FFFFFFFFFFFF0000B91313BD1414BF0A0A
          BD0C0CBE2525C53737CA3D3DCB3737CA2525C50C0CBE0A0ABD0C0CBC0000B9FF
          FFFFFFFFFF2020C20606BA0C0CBD0C0CBE3131C85050D06565D66D6DD86565D6
          5050D03131C80C0CBE0303BA1E1EC1FFFFFFFFFFFF9696E20000B90505BB2525
          C55050D07676DA9393E29F9FE59393E27676DA5050D01616C00000B99494E2FF
          FFFFFFFFFFFFFFFF3535C80101B92525C46363D69393E2BBBBEDCFCFF2BBBBED
          9090E14141CC0404BA3333C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3434C80101
          B91E1EC26B6BD7C0C0EEEFEFFB8383DD2525C30101B94040CBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF9A9AE42F2FC60101B90101B90101B90101B9
          3939C9A3A3E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
      end
      object Label6: TLabel
        Left = 140
        Top = 12
        Width = 50
        Height = 13
        Caption = 'Bloqueado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image4: TImage
        Left = 193
        Top = 12
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          0000100000000100180000000000000300001017000010170000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBA
          90FD4819FF0100FF0200FF0200FF0100FC4619FDBB91FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFC6531FF0200FC2500F46C00EE9F00EF9600F56100
          FB2700FF0200FC6231FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB6131FE0E00F36B
          00E9A100E79E00E69A00E59900E69A00E89800F25D00FE0B00FA5E31FFFFFFFF
          FFFFFFFFFFFCB591FF0300F06500E49500E28B00E08400DF8000DF7E00DF8000
          E08400E28B00EF5600FF0200FBB291FFFFFFFFFFFFFA3D19F92500E38600DE7D
          00DC7100DA6A00D86500D86300D86500DA6A00DC7100DF7900FA1900FA3A19FF
          FFFFFFFFFFFF0100EC5200DC7300D86500D65900D35000D24B00D14900D24B00
          D35000D65900D86500EC3F00FF0100FFFFFFFFFFFFFF0000DF6600D75E00D34E
          00CF4100CD3600CD3604CE3908CD3604CD3600CF4100D34E00DC5300FF0000FF
          FFFFFFFFFFFF0000DA5800D24B00CD3900CF3F0FD34D21D5572DD65A31D5572D
          D34D21CF3F0FCD3900D84100FF0000FFFFFFFFFFFFFF0000E33100CD3900D045
          16D65A31DA6C47DD7755DE7B5ADD7755DA6C47D65A31D04516E22100FF0000FF
          FFFFFFFFFFF62C19F40F00D03E0FD65A31DC7350E1886AE5977DE69C83E5977D
          E1886ADC7350D7572FF40E03F52719FFFFFFFFFFFFF79F90FE0100E23316DA6C
          47E1886AE8A28BEDB5A3EFBDADEDB5A3E8A28BE1886AE9412BFE0100F69B91FF
          FFFFFFFFFFFFFFFFF33F32FB0905E85039E5957BEDB5A3F3D1C5F7DED6F3D1C5
          EDB19FEE6150FD0806F4473CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4483DFE02
          01F82B24F47F74F8CDC6FFEFEFFA8C87FB2C28FF0202F75048FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8A7A0FA3934FF0101FF0101FF0101FF0101
          FB403CFAADA8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
      end
      object Label7: TLabel
        Left = 213
        Top = 12
        Width = 48
        Height = 13
        Caption = 'Prospecto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image5: TImage
        Left = 263
        Top = 11
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          0000100000000100180000000000000300001017000010170000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9A9A
          9A2424240000000000000000000000002424249B9B9BFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF3E3E3E0101010A0A0A1E1E1E2D2D2D2B2B2B1B1B1B
          0B0B0B0101013E3E3EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3E0404042020
          203232323333333333333333333333333131311D1D1D0303033E3E3EFFFFFFFF
          FFFFFFFFFF9A9A9A010101202020333333333333333333333333333333333333
          3333333333331E1E1E0101019A9A9AFFFFFFFFFFFF2424240C0C0C3232323333
          33333333333333333333333333333333333333333333313131090909242424FF
          FFFFFFFFFF000000202020333333333333333333333333333333333333333333
          3333333333333333331C1C1C000000FFFFFFFFFFFF0000002E2E2E3333333333
          333333333333333333333333333333333333333333333333332D2D2D000000FF
          FFFFFFFFFF000000303030333333333333333333393939444444484848444444
          3939393333333333332C2C2C000000FFFFFFFFFFFF0000002020203333333333
          334848485B5B5B6868686D6D6D6868685B5B5B4848483333331D1D1D000000FF
          FFFFFFFFFF2424240C0C0C3232324848486464647B7B7B8B8B8B9191918B8B8B
          7B7B7B6464644646460B0B0B242424FFFFFFFFFFFF9A9A9A0101012626265B5B
          5B7B7B7B989898ADADADB6B6B6ADADAD9898987B7B7B3737370101019A9A9AFF
          FFFFFFFFFFFFFFFF3E3E3E070707464646898989ADADADCCCCCCDBDBDBCCCCCC
          A9A9A9595959070707424242FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4343430202
          022828287A7A7ACBCBCBEFEFEF8A8A8A2A2A2A0202024C4C4CFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4373737010101010101010101010101
          3E3E3EABABABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
      end
      object Label8: TLabel
        Left = 282
        Top = 12
        Width = 34
        Height = 13
        Caption = 'Inativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select clienteId,'
      #9#9'nome,'
      '                                status,'
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
    Top = 29
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
    object QryListagemstatus: TWideStringField
      DisplayLabel = 'Status'
      FieldName = 'status'
    end
    object QryListagemtipoPessoa: TWideStringField
      DisplayLabel = 'Tipo'
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
      DisplayLabel = 'Data Nascimento'
      FieldName = 'dataNascimento'
    end
  end
  inherited dtsListagem: TDataSource
    DataSet = QryListagem
    Left = 696
  end
end
