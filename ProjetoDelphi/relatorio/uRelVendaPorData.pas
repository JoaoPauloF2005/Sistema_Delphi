unit uRelVendaPorData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport,
  RLFilters, RLPDFFilter, RLXLSFilter;

type
  TfrmRelVendaPorData = class(TForm)
    QryVenda: TZQuery;
    dtsVenda: TDataSource;
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
    RLXLSFilter1: TRLXLSFilter;
    BandaDoGrupo: TRLGroup;
    RLBand3: TRLBand;
    RLDBText5: TRLDBText;
    RLLabel8: TRLLabel;
    RLBand2: TRLBand;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw4: TRLDraw;
    RLLabel4: TRLLabel;
    QryVendavendaId: TIntegerField;
    QryVendaclienteId: TIntegerField;
    QryVendanome: TWideStringField;
    QryVendadataVenda: TDateTimeField;
    QryVendatotalVenda: TFloatField;
    RLBand5: TRLBand;
    RLDBResult2: TRLDBResult;
    RLDraw5: TRLDraw;
    RLLabel5: TRLLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVendaPorData: TfrmRelVendaPorData;

implementation

{$R *.dfm}

procedure TfrmRelVendaPorData.FormCreate(Sender: TObject);
begin
	QryVenda.Open;
end;

procedure TfrmRelVendaPorData.FormDestroy(Sender: TObject);
begin
	QryVenda.Close;
end;

end.
