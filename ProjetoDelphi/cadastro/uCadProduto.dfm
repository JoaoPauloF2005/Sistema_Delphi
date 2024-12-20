inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produtos'
  ClientHeight = 593
  ClientWidth = 1458
  Position = poDesktopCenter
  ExplicitWidth = 1464
  ExplicitHeight = 622
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 1328
    Height = 538
    ExplicitWidth = 1328
    ExplicitHeight = 538
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 1320
      ExplicitHeight = 510
      inherited grdListagem: TDBGrid
        Top = 41
        Width = 1023
        Height = 469
        Margins.Left = 0
        Margins.Top = 40
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Categoria'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SubCategoria'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'imagem'
            Visible = False
          end>
      end
      inherited pExportar: TPanel
        Left = 357
        Top = 116
        TabOrder = 3
        ExplicitLeft = 357
        ExplicitTop = 116
      end
      inherited Panel6: TPanel
        Width = 1320
        ExplicitWidth = 1320
        inherited SearchBox1: TSearchBox
          Top = 7
          OnChange = SearchBox1Change
          ExplicitTop = 7
        end
      end
      object panelImagem: TPanel
        Left = 1023
        Top = 41
        Width = 297
        Height = 469
        Align = alRight
        TabOrder = 1
        object imgProdutoPreview: TImage
          Left = 0
          Top = 42
          Width = 297
          Height = 272
          Stretch = True
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 295
          Height = 35
          Align = alTop
          Color = clGray
          ParentBackground = False
          TabOrder = 0
          object Label6: TLabel
            Left = 86
            Top = 9
            Width = 127
            Height = 16
            Align = alCustom
            Alignment = taCenter
            Caption = 'Imagem do Produto'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
        end
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 1320
      ExplicitHeight = 510
      object Label1: TLabel
        Left = 12
        Top = 82
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 12
        Top = 210
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 158
        Top = 210
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 534
        Top = 25
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object Label5: TLabel
        Left = 318
        Top = 210
        Width = 22
        Height = 13
        Caption = 'Foto'
      end
      object Label7: TLabel
        Left = 729
        Top = 25
        Width = 65
        Height = 13
        Caption = 'SubCategoria'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
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
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 148
        Top = 40
        Width = 368
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtDescricao: TMemo
        Left = 12
        Top = 101
        Width = 894
        Height = 89
        Ctl3D = True
        DoubleBuffered = False
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
      end
      object edtValor: TCurrencyEdit
        Left = 12
        Top = 226
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object edtQuantidade: TCurrencyEdit
        Left = 158
        Top = 226
        Width = 121
        Height = 21
        DisplayFormat = ' ,0.00;- ,0.00'
        TabOrder = 5
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 534
        Top = 40
        Width = 177
        Height = 21
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 2
        OnCloseUp = lkpCategoriaCloseUp
      end
      object btnCarregarImagem: TBitBtn
        Tag = 99
        Left = 618
        Top = 226
        Width = 28
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FF0A6B0A0A6B0A0A6B0A0A6B0AFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFB25D130A6B0A42D37331B85A0A6B0AA8
          4E0FA54A0EA4480DA1440DA0420C9F3F0C9D3E0BFF00FFFF00FFFF00FFFF00FF
          B561140A6B0A78F3A440D1710A6B0AFBF0DEFBEFDAFBEDD5FBEBD1FBE9CDFBE7
          C89E400BFF00FFFF00FF0A6B0A0A6B0A0A6B0A0A6B0A78F3A444D5740A6B0A0A
          6B0A0A6B0A0A6B0AFCEDD6FBEBD1FBEACEA1430CFF00FFFF00FF0A6B0A78F3A4
          53E4844FE1804CDD7C48D97845D67541D27231B85A0A6B0AFBEFDBFCEDD6FBEB
          D1A3470DFF00FFFF00FF0A6B0A78F3A478F3A478F3A478F3A44DDE7D78F3A478
          F3A442D3730A6B0AFCF1E0FBEFDBFBEDD7A64B0EFF00FFFF00FF0A6B0A0A6B0A
          0A6B0A0A6B0A78F3A450E2810A6B0A0A6B0A0A6B0A0A6B0AFCF4E4FBF1E1FCEF
          DCA94F0FFF00FFFF00FFFF00FFFF00FFC375190A6B0A78F3A454E5850A6B0AFC
          F9F5FCF7F1FCF7EEFCF5E9FBF3E4FCF2E2AC5110FF00FFFF00FFFF00FFFF00FF
          C579190A6B0A78F3A478F3A40A6B0AFCFAF7FCF9F5FCF7F2FCF7EEFBF6E9FBF3
          E5AD5611FF00FFFF00FFFF00FFFF00FFC77C1A0A6B0A0A6B0A0A6B0A0A6B0AFC
          FBFBFCFAF8FCF9F5FBF8F2FCF7EEFBF6EAB05A12FF00FFFF00FFFF00FFFF00FF
          C97F1CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFAFCFBF8FCF9F6FCF8F2FCF7
          EFB35E13FF00FFFF00FFFF00FFFF00FFCC821CFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFAFCFBF9FCFAF6FCF8F3B66214FF00FFFF00FFFF00FFFF00FF
          CE851DFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFCFBF9FCFA
          F7B96615FF00FFFF00FFFF00FFFF00FFCF861DFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFCFCFCFCFCFCFBFCFBF8BC6A16FF00FFFF00FFFF00FFFF00FF
          CF871DCF871DCE861DCC831CCC821CCA801BC87D1BC67A1AC47719C37419C172
          17BF6F17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnCarregarImagemClick
      end
      object btnRemoverImagem: TBitBtn
        Left = 618
        Top = 257
        Width = 28
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9797BD2F31A78181B8FF00FFFF00FFFF00FFFF00
          FFC1C1C64546AB10109DFF00FF6B3B3B6B3B3B9191918F8F8FAFAFAF191BA40A
          22CA1314A39999C89C9C9C7E5454AC94993C3BAE1119AB1117A86B3B3BCF6F0A
          CB6A0AF7F7F7C2620ACF884C4D4FBA1221BD0A2BDC1315A2B3B3D9D7B7A83C3C
          AD121AAF0A18B81819A06B3B3BD3730AD06F0AFBFBFBC6650AC77020E7E7EC38
          3AB01221BC0A29D81314A03635AC131CB30A1EC31415A0A6A6C06B3B3BD7770A
          D3730AFCFCFCCB6A0AC6670BEBECEBE6E6EB383AB01221BC0A27D41223C00A24
          CF1213A0A0A0BEFF00FF6B3B3BDC7B0AD6760AEDCBA5FCFCFCF7F7F7EFEFEFEB
          EBEBE5E6F010119E0A29D70A31E91416A59693CBFF00FFFF00FF6B3B3BDF7E0A
          DB7B0AD7760AD3730ACF700BCF7823D8A9813D3DAF1323BE0A30E60C26D00E24
          CB1B1BA4A9A9C0FF00FF6B3B3BE3830ADF7F0ADB7A0AD7760AD67F20DCAA7B3D
          3DAF1323BF0A35F11316A52A2AA8121FBA1028CE1818A0A6A6C06B3B3BE7870A
          FCF6EAFBF4E4FCF1E0FBF2E44F51BA1323BF0A36F3161CAC8A8ACDF4ECE73837
          AC121FBA1129CD292AA46B3B3BEA890AEDEAE5E9E5DFE5E1D8EAE6E11112A00A
          31EA151BAE7474C6E0D8CDD6CCBBD4A6833637AD131AAE1C1DA26B3B3BEE8D0A
          FCF8F1FCF7ECFCF5E7FCF4E79190D01213A06B6CC4FCF0DEFCE7CAFBE5C1C871
          249D81868585B8B0B0C36B3B3BF1900AF1EFECEDEAE6E9E5E1E6E2DBE7E3DBE8
          E4DCE3DDD3DAD1C3D4CABAD1C6B5C5650B724444FF00FFFF00FF6B3B3BF4930A
          FCFAF7FCF8F3FCF7EEFCF6E9FCF3E4FCF1DEFCEED9FBECD3FCEACFFCE7C8C969
          0A6B3B3BFF00FFFF00FF6B3B3BF7960AACAAFBA0A2FA959AF98993F87E8CF774
          85F6697FF56178F35874F2516EF0CE6E0A6B3B3BFF00FFFF00FF6B3B3B6B3B3B
          2D2BB4292AB42627B42125B41E22B41920B4171EB4141CB4111AB40E19B46B3B
          3B6B3B3BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnRemoverImagemClick
      end
      object Panel1: TPanel
        Left = 315
        Top = 226
        Width = 297
        Height = 279
        BevelOuter = bvLowered
        BiDiMode = bdRightToLeftReadingOnly
        BorderStyle = bsSingle
        Ctl3D = False
        DoubleBuffered = False
        ParentBiDiMode = False
        ParentBackground = False
        ParentCtl3D = False
        ParentDoubleBuffered = False
        TabOrder = 8
        object imgProduto: TImage
          Left = 2
          Top = 2
          Width = 352
          Height = 272
          Stretch = True
        end
      end
      object lkpSubCategoria: TDBLookupComboBox
        Left = 729
        Top = 40
        Width = 177
        Height = 21
        KeyField = 'subCategoriaId'
        ListField = 'descricao'
        ListSource = dtsSubCategoria
        TabOrder = 9
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 538
    Width = 1458
    ExplicitTop = 538
    ExplicitWidth = 1458
  end
  inherited Panel2: TPanel
    Left = 1328
    Height = 538
    ExplicitLeft = 1328
    ExplicitHeight = 538
    inherited btnFechar: TBitBtn
      Left = 12
      Top = 481
      ExplicitLeft = 12
      ExplicitTop = 481
    end
  end
  inherited QryListagem: TZQuery
    AfterScroll = QryListagemAfterScroll
    SQL.Strings = (
      'SELECT '
      '    p.produtoId,'
      '    p.nome,'
      '    p.descricao,'
      '    p.valor,'
      '    p.quantidade,'
      '    p.imagem,'
      '    c.descricao AS Categoria,'
      '    sc.descricao AS SubCategoria'
      'FROM '
      '    Produtos p'
      'LEFT JOIN '
      '    Categorias c ON p.categoriaId = c.categoriaId'
      'LEFT JOIN '
      '    SubCategorias sc ON p.subCategoriaId = sc.subCategoriaId;')
    Left = 775
    Top = 140
    object QryListagemprodutoId: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemdescricao: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object QryListagemvalor: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      DisplayFormat = 'R$ #,##0.00'
    end
    object QryListagemquantidade: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object QryListagemCategoria: TWideStringField
      Alignment = taCenter
      FieldName = 'Categoria'
      Size = 30
    end
    object QryListagemSubCategoria: TWideStringField
      Alignment = taCenter
      FieldName = 'SubCategoria'
      Required = True
      Size = 100
    end
    object QryListagemimagem: TBlobField
      DisplayLabel = 'Imagem'
      FieldName = 'imagem'
    end
  end
  inherited dtsListagem: TDataSource
    Left = 928
    Top = 138
  end
  inherited ImageList1: TImageList
    Left = 860
    Top = 125
  end
  inherited PrintDialog: TPrintDialog
    Left = 673
    Top = 154
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'Select categoriaId, descricao from categorias')
    Params = <>
    Left = 720
    Top = 259
    object QryCategoriacategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryCategoriadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 933
    Top = 248
  end
  object QrySubCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    AfterScroll = QryListagemAfterScroll
    SQL.Strings = (
      'SELECT '
      '  subCategoriaId, '
      '  descricao, '
      '  categoriaId '
      'FROM '
      '  subCategorias '
      'WHERE '
      '  categoriaId = :categoriaId')
    Params = <
      item
        DataType = ftUnknown
        Name = 'categoriaId'
        ParamType = ptUnknown
      end>
    Left = 790
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'categoriaId'
        ParamType = ptUnknown
      end>
    object QrySubCategoriasubCategoriaId: TIntegerField
      FieldName = 'subCategoriaId'
      ReadOnly = True
    end
    object QrySubCategoriadescricao: TWideStringField
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QrySubCategoriacategoriaId: TIntegerField
      FieldName = 'categoriaId'
      Required = True
    end
  end
  object dtsSubCategoria: TDataSource
    DataSet = QrySubCategoria
    Left = 912
    Top = 347
  end
end
