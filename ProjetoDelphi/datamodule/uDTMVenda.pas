unit uDTMVenda;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TdtmVenda = class(TDataModule)
    QryCliente: TZQuery;
    QryClienteclienteId: TIntegerField;
    QryClientenome: TWideStringField;
    QryProdutos: TZQuery;
    C�digo: TIntegerField;
    Nome: TWideStringField;
    Valor: TFloatField;
    QryProdutosquantidade: TFloatField;
    cdsItensVenda: TClientDataSet;
    dtsItensVenda: TDataSource;
    dtsCliente: TDataSource;
    dtsProdutos: TDataSource;
    cdsItensVendaprodutoId: TIntegerField;
    cdsItensVendaNomeProduto: TStringField;
    cdsItensVendaquantidade: TFloatField;
    cdsItensVendavalorUnitario: TFloatField;
    cdsItensVendavalorTotalProduto: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmVenda: TdtmVenda;

implementation

uses
  uDTMConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmVenda.DataModuleCreate(Sender: TObject);
begin
  cdsItensVenda.CreateDataSet;
  QryCliente.Open;
  QryProdutos.Open;
end;

procedure TdtmVenda.DataModuleDestroy(Sender: TObject);
begin
  cdsItensVenda.Close;
  QryCliente.Close;
  QryProdutos.Close;
end;


end.
