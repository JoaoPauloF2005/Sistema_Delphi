unit uReceitaCNPJ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.Buttons, System.JSON, IdSSLOpenSSL, Vcl.ExtCtrls;

type
  TfrmReceitaCNPJ = class(TForm)
    Label1: TLabel;
    btnAcessar: TBitBtn;
    btnFechar: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    IdHTTP1: TIdHTTP;
    edtNome: TLabel;
    edtCnpj: TLabel;
    edtTelefone: TLabel;
    edtCep: TLabel;
    edtEndereco: TLabel;
    edtBairro: TLabel;
    edtCidade: TLabel;
    edtEstado: TLabel;
    Panel1: TPanel;
    Label9: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure PreencherCampos(JSON: TJSONObject);
    procedure btnAcessarClick(Sender: TObject);
  private
    function SomenteNumeros(const AValue: string): string;
  public
    { Public declarations }
  end;

var
  frmReceitaCNPJ: TfrmReceitaCNPJ;

implementation

{$R *.dfm}

procedure TfrmReceitaCNPJ.PreencherCampos(JSON: TJSONObject);
begin
  edtNome.Caption := JSON.GetValue<string>('nome', '');
  edtCnpj.Caption := JSON.GetValue<string>('cnpj', '');
  edtTelefone.Caption := JSON.GetValue<string>('telefone', '');
  edtCep.Caption := JSON.GetValue<string>('cep', '');
  edtEndereco.Caption := JSON.GetValue<string>('logradouro', '');
  edtBairro.Caption := JSON.GetValue<string>('bairro', '');
  edtCidade.Caption := JSON.GetValue<string>('municipio', '');
  edtEstado.Caption := JSON.GetValue<string>('uf', '');
end;


procedure TfrmReceitaCNPJ.btnAcessarClick(Sender: TObject);
var
  JSONResponse: string;
  JSONObj: TJSONObject;
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  if Trim(edtCnpj.Caption) = '' then
  begin
    ShowMessage('Digite o CNPJ para consulta.');
    Exit;
  end;

  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    HTTP.IOHandler := SSLHandler;
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];

    // Realiza a requisição HTTP
    JSONResponse := HTTP.Get('https://www.receitaws.com.br/v1/cnpj/' + Trim(SomenteNumeros(edtCnpj.Caption)));
    JSONObj := TJSONObject.ParseJSONValue(JSONResponse) as TJSONObject;

    if Assigned(JSONObj) then
    begin
      PreencherCampos(JSONObj);
    end
    else
      ShowMessage('Erro ao processar os dados da API.');
  except
    on E: Exception do
      ShowMessage('Erro ao acessar a API: ' + E.Message);
  end;
  HTTP.Free;
  SSLHandler.Free;
  ModalResult := mrOk;
end;

function TfrmReceitaCNPJ.SomenteNumeros(const AValue: string): string;
var
  I: Integer;
begin
  Result := ''; // Inicializa a string de resultado como vazia

  // Percorre cada caractere da string
  for I := 1 to Length(AValue) do
  begin
    // Verifica se o caractere é numérico e adiciona ao resultado
    if CharInSet(AValue[I], ['0'..'9']) then
      Result := Result + AValue[I];
  end;
end;

procedure TfrmReceitaCNPJ.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrCancel; // Fecha o formulário sem preencher os dados
end;



end.

