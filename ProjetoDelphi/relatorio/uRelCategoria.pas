unit uRelCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport,
  RLFilters, RLPDFFilter;

type
  TfrmRelCadCategoria = class(TForm)
    QryCategorias: TZQuery;
    dtsCategorias: TDataSource;
    QryCategoriascategoriaId: TIntegerField;
    QryCategoriasdescricao: TWideStringField;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    Rodap�: TRLBand;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand2: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel5: TRLLabel;
    RLLabel4: TRLLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadCategoria: TfrmRelCadCategoria;

implementation

{$R *.dfm}

procedure TfrmRelCadCategoria.FormCreate(Sender: TObject);
begin
	QryCategorias.Open;
end;

procedure TfrmRelCadCategoria.FormDestroy(Sender: TObject);
begin
	QryCategorias.Close;
end;

end.
