unit uUsuarioVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmUsuarioVsAcoes = class(TForm)
    Panel3: TPanel;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    QryUsuario: TZQuery;
    QryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    QryUsuariousuarioID: TIntegerField;
    QryUsuarioNome: TWideStringField;
    QryAcoesusuarioId: TIntegerField;
    QryAcoesacaoAcessoId: TIntegerField;
    QryAcoesdescricao: TWideStringField;
    QryAcoesativo: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

uses
  uDTMConexao;

{$R *.dfm}

end.
