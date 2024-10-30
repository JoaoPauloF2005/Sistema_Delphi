object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 645
  ClientWidth = 1110
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mainPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StbPrincipal: TStatusBar
    Left = 0
    Top = 626
    Width = 1110
    Height = 19
    Panels = <
      item
        Width = 150
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1110
    Height = 46
    Align = alTop
    Alignment = taLeftJustify
    TabOrder = 1
    object Label1: TLabel
      Left = 5
      Top = 9
      Width = 122
      Height = 25
      Caption = 'DASHBOARD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 46
    Width = 1110
    Height = 580
    Align = alClient
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = DBChart1
        Row = 0
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 2
    object DBChart1: TDBChart
      Left = 1
      Top = 1
      Width = 554
      Height = 289
      Title.Text.Strings = (
        'Produto em Estoque')
      Align = alClient
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TBarSeries
        Marks.Brush.Gradient.Colors = <
          item
            Color = clRed
          end
          item
            Color = 819443
            Offset = 0.067915690866510540
          end
          item
            Color = clYellow
            Offset = 1.000000000000000000
          end>
        Marks.Brush.Gradient.Direction = gdTopBottom
        Marks.Brush.Gradient.EndColor = clYellow
        Marks.Brush.Gradient.MidColor = 819443
        Marks.Brush.Gradient.StartColor = clRed
        Marks.Brush.Gradient.Visible = True
        Marks.Font.Color = 159
        Marks.Font.Name = 'Tahoma'
        Marks.Font.Style = [fsBold, fsItalic]
        Marks.Frame.Color = 33023
        Marks.RoundSize = 14
        DataSource = DTMGrafico.QryProdutoEstoque
        Title = 'ProdutoEstoque'
        XLabelsSource = 'Label'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
      end
    end
  end
  object mainPrincipal: TMainMenu
    Left = 689
    Top = 4
    object CADASTRO1: TMenuItem
      Caption = 'CADASTRO'
      object CLIENTE1: TMenuItem
        Caption = 'CLIENTE'
        OnClick = CLIENTE1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object CATEGORIA1: TMenuItem
        Caption = 'CATEGORIA'
        OnClick = CATEGORIA1Click
      end
      object PRODUTO1: TMenuItem
        Caption = 'PRODUTO'
        OnClick = PRODUTO1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object USURIO1: TMenuItem
        Caption = 'USU'#193'RIO'
        OnClick = USURIO1Click
      end
      object AOACESSO1: TMenuItem
        Caption = 'A'#199#195'O ACESSO'
        OnClick = AOACESSO1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object USURIOSVSAES1: TMenuItem
        Caption = 'USU'#193'RIOS VS A'#199#213'ES'
        OnClick = USURIOSVSAES1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ALTERARSENHA1: TMenuItem
        Caption = 'ALTERAR SENHA'
        OnClick = ALTERARSENHA1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object ROCARUSURIO1: TMenuItem
        Caption = 'TROCAR USU'#193'RIO'
        OnClick = ROCARUSURIO1Click
      end
      object mnuFechar: TMenuItem
        Caption = 'FECHAR'
        OnClick = mnuFecharClick
      end
    end
    object MOVIMENTAO1: TMenuItem
      Caption = 'MOVIMENTA'#199#195'O'
      object VENDAS1: TMenuItem
        Caption = 'VENDAS'
        OnClick = VENDAS1Click
      end
    end
    object RELATRIOS1: TMenuItem
      Caption = 'RELAT'#211'RIOS'
      object CATEGORIA2: TMenuItem
        Caption = 'CATEGORIA'
        OnClick = CATEGORIA2Click
      end
      object CLIENTE2: TMenuItem
        Caption = 'CLIENTE'
        OnClick = CLIENTE2Click
      end
      object FICHADECLIENTE1: TMenuItem
        Caption = 'FICHA DE CLIENTE'
        OnClick = FICHADECLIENTE1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object PRODUTO2: TMenuItem
        Caption = 'PRODUTO'
        OnClick = PRODUTO2Click
      end
      object PRODUTOPORCATEGORIA1: TMenuItem
        Caption = 'PRODUTOS POR CATEGORIA'
        OnClick = PRODUTOPORCATEGORIA1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object VENDAPORDATA1: TMenuItem
        Caption = 'VENDA POR DATA'
        OnClick = VENDAPORDATA1Click
      end
    end
  end
end
