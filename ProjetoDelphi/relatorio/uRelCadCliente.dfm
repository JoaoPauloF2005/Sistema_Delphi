﻿object frmRelCadCliente: TfrmRelCadCliente
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Cadastro de Cliente'
  ClientHeight = 740
  ClientWidth = 819
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 1
    Top = -7
    Width = 794
    Height = 1123
    DataSource = dtsCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 57
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 3
        Top = 15
        Width = 217
        Height = 24
        Caption = 'Listagem de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 359
        Top = 45
        Width = 359
        Height = 12
        Align = faClientBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 45
        Width = 359
        Height = 12
        Align = faClientBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object Rodapé: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 39
      BandType = btFooter
      object RLDraw3: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 19
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 20
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 674
        Top = 20
        Width = 19
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 700
        Top = 20
        Width = 17
        Height = 16
        Alignment = taRightJustify
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 693
        Top = 20
        Width = 12
        Height = 16
        Caption = '/'
      end
      object RLLabel3: TRLLabel
        Left = 629
        Top = 20
        Width = 53
        Height = 16
        Alignment = taRightJustify
        Caption = 'P'#225'gina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 111
      Width = 718
      Height = 18
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 52
        Height = 16
        DataField = 'clienteId'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 68
        Top = 0
        Width = 38
        Height = 16
        DataField = 'Nome'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 340
        Top = 0
        Width = 35
        Height = 16
        DataField = 'email'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 669
        Top = 0
        Width = 49
        Height = 16
        Alignment = taRightJustify
        DataField = 'telefone'
        DataSource = dtsCliente
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 95
      Width = 718
      Height = 16
      BandType = btColumnHeader
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 16
        Align = faClient
        Color = clInfoBk
        ParentColor = False
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 68
        Top = -1
        Width = 41
        Height = 16
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 2
        Top = -1
        Width = 49
        Height = 16
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 340
        Top = 0
        Width = 39
        Height = 16
        Caption = 'Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 658
        Top = 0
        Width = 60
        Height = 16
        Alignment = taRightJustify
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT clientes.clienteId,'
      '       clientes.Nome,'
      '       Clientes.email,'
      '       clientes.telefone'
      '  FROM clientes'
      '  ORDER BY clientes.Nome')
    Params = <>
    Left = 403
    Top = 350
    object QryClienteclienteId: TIntegerField
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryClienteNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryClienteemail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object QryClientetelefone: TWideStringField
      FieldName = 'telefone'
      Size = 14
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 497
    Top = 351
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 455
    Top = 407
  end
end
