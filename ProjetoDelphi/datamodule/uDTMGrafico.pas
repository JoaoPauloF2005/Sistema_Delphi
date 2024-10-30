unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TDTMGrafico = class(TDataModule)
    QryProdutoEstoque: TZQuery;
    QryProdutoEstoqueLabel: TWideStringField;
    QryProdutoEstoqueValue: TFloatField;
    ProdutoEstoque: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DTMGrafico: TDTMGrafico;

implementation

uses
  uDTMConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
