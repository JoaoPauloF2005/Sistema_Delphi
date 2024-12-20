unit uRelProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport,
  RLFilters, RLPDFFilter, RLXLSFilter;

type
  TfrmRelProVenda = class(TForm)
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
    RLLabel10: TRLLabel;
    RLLabel13: TRLLabel;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult2: TRLDBResult;
    RLDraw5: TRLDraw;
    RLLabel5: TRLLabel;
    QryVendasItens: TZQuery;
    dtsVendasItens: TDataSource;
    QryVendavendaId: TIntegerField;
    QryVendaclienteId: TIntegerField;
    QryVendanome: TWideStringField;
    QryVendadataVenda: TDateTimeField;
    QryVendatotalVenda: TFloatField;
    QryVendasItensvendaId: TIntegerField;
    QryVendasItensprodutoId: TIntegerField;
    QryVendasItensNome: TWideStringField;
    QryVendasItensquantidade: TFloatField;
    QryVendasItensvalorUnitario: TFloatField;
    QryVendasItenstotalProduto: TFloatField;
    RLLabel6: TRLLabel;
    RLSubDetail1: TRLSubDetail;
    RLBand2: TRLBand;
    RLBand4: TRLBand;
    rldbtxtprodutoId: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLLabel9: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProVenda: TfrmRelProVenda;

implementation

{$R *.dfm}

procedure TfrmRelProVenda.FormCreate(Sender: TObject);
begin
	QryVenda.Open;

end;

procedure TfrmRelProVenda.FormDestroy(Sender: TObject);
begin
	QryVenda.Close;
  QryVendasItens.Close;
end;

end.
