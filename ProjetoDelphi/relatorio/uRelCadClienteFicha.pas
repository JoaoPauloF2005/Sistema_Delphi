unit uRelCadClienteFicha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport,
  RLFilters, RLPDFFilter, Vcl.Imaging.pngimage;

type
  TfrmRelCadClienteFicha = class(TForm)
    QryCliente: TZQuery;
    dtsCliente: TDataSource;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    Rodapé: TRLBand;
    RLDraw3: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel5: TRLLabel;
    QryClienteclienteId: TIntegerField;
    QryClienteNome: TWideStringField;
    QryClienteemail: TWideStringField;
    QryClientetelefone: TWideStringField;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    QryClientecep: TWideStringField;
    QryClienteendereco: TWideStringField;
    QryClientebairro: TWideStringField;
    QryClientecidade: TWideStringField;
    QryClienteestado: TWideStringField;
    QryClientedataNascimento: TDateTimeField;
    RLLabel4: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLDraw4: TRLDraw;
    RLDraw1: TRLDraw;
    RLImage1: TRLImage;
    RLAngleLabel1: TRLAngleLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadClienteFicha: TfrmRelCadClienteFicha;

implementation

{$R *.dfm}

procedure TfrmRelCadClienteFicha.FormCreate(Sender: TObject);
begin
	QryCliente.Open;
end;

procedure TfrmRelCadClienteFicha.FormDestroy(Sender: TObject);
begin
	QryCliente.Close;
end;

end.
