object frmUsuarioVsAcoes: TfrmUsuarioVsAcoes
  Left = 0
  Top = 0
  Caption = 'Usu'#225'rio VS A'#231#245'es'
  ClientHeight = 614
  ClientWidth = 1038
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 342
    Top = 0
    Width = 6
    Height = 573
    ExplicitLeft = 336
  end
  object Panel3: TPanel
    Left = 0
    Top = 573
    Width = 1038
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 488
    ExplicitTop = 213
    ExplicitWidth = 185
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 573
    Align = alLeft
    TabOrder = 1
    ExplicitHeight = 696
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 340
      Height = 571
      Align = alClient
      DataSource = dtsUsuario
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'usuarioID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 227
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 348
    Top = 0
    Width = 690
    Height = 573
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 435
    ExplicitTop = 368
    ExplicitWidth = 185
    ExplicitHeight = 41
    object DBGrid2: TDBGrid
      Left = 1
      Top = 1
      Width = 688
      Height = 571
      Align = alClient
      DataSource = dtsAcoes
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object QryUsuario: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT usuarioID,'
      '       Nome'
      '  FROM usuarios')
    Params = <>
    Left = 194
    Top = 257
    object QryUsuariousuarioID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioID'
      ReadOnly = True
    end
    object QryUsuarioNome: TWideStringField
      FieldName = 'Nome'
      Required = True
      Size = 50
    end
  end
  object QryAcoes: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT ua.usuarioId,'
      '       ua.acaoAcessoId,'
      '       a.descricao,'
      '       ua.ativo'
      '  FROM usuariosAcaoAcesso AS ua'
      
        '    INNER JOIN acaoAcesso AS a ON a.acaoAcessoId = ua.acaoAcesso' +
        'Id'
      'WHERE ua.usuarioId = :usuarioId')
    Params = <
      item
        DataType = ftUnknown
        Name = 'usuarioId'
        ParamType = ptUnknown
      end>
    Left = 656
    Top = 254
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'usuarioId'
        ParamType = ptUnknown
      end>
    object QryAcoesusuarioId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioId'
      Required = True
    end
    object QryAcoesacaoAcessoId: TIntegerField
      FieldName = 'acaoAcessoId'
      Required = True
    end
    object QryAcoesdescricao: TWideStringField
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QryAcoesativo: TBooleanField
      FieldName = 'ativo'
      Required = True
    end
  end
  object dtsUsuario: TDataSource
    DataSet = QryUsuario
    Left = 215
    Top = 322
  end
  object dtsAcoes: TDataSource
    DataSet = QryAcoes
    Left = 632
    Top = 320
  end
end
