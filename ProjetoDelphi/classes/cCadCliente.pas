unit cCadCliente;  // Declara a unidade (m�dulo) que cont�m a classe TCliente.

interface

uses
  System.Classes,          // Permite o uso de classes b�sicas do Delphi.
  Vcl.Controls,            // Cont�m controles visuais da VCL.
  Vcl.ExtCtrls,            // Permite o uso de pain�is e controles avan�ados.
  Vcl.Dialogs,             // Utiliza caixas de di�logo.
  ZAbstractConnection,     // Permite trabalhar com conex�es abstratas.
  ZConnection,             // Trabalha com a conex�o ao banco de dados usando Zeos.
  ZAbstractRODataset,      // Dataset apenas de leitura.
  ZAbstractDataset,        // Classe base para Datasets.
  ZDataset,                // Componente de dataset para execu��o de SQL.
  System.SysUtils;         // Fun��es utilit�rias do sistema, como manipula��o de strings e datas.

type
  // Declara��o da classe TCliente, que encapsula opera��es de um cliente.
  TCliente = class
  private
    ConexaoDB: TZConnection;  // Armazena a conex�o com o banco de dados.
    F_clienteId: Integer;      // ID do cliente.
    F_nome: String;            // Nome do cliente.
    F_endereco: String;        // Endere�o do cliente.
    F_cidade: String;          // Cidade do cliente.
    F_bairro: String;          // Bairro do cliente.
    F_estado: String;          // Estado do cliente.
    F_cep: String;             // CEP do cliente.
    F_telefone: String;        // Telefone do cliente.
    F_email: String;           // E-mail do cliente.
    F_dataNascimento: TDateTime; // Data de nascimento do cliente.

  public
    constructor Create(aConexao: TZConnection); // Construtor para inicializar a conex�o.
    destructor Destroy; override;               // Destrutor para liberar recursos.
    function Inserir: Boolean;                  // Insere um novo cliente no banco.
    function Atualizar: Boolean;                // Atualiza os dados de um cliente.
    function Apagar: Boolean;                   // Exclui um cliente do banco.
    function Selecionar(id: Integer): Boolean;  // Seleciona um cliente pelo ID.

  published
    // Propriedades para acessar e modificar os campos privados.
    property codigo: Integer read F_clienteId write F_clienteId;
    property nome: string read F_nome write F_nome;
    property endereco: string read F_endereco write F_endereco;
    property cidade: string read F_cidade write F_cidade;
    property bairro: string read F_bairro write F_bairro;
    property estado: string read F_estado write F_estado;
    property cep: string read F_cep write F_cep;
    property telefone: string read F_telefone write F_telefone;
    property email: string read F_email write F_email;
    property dataNascimento: TDateTime read F_dataNascimento write F_dataNascimento;
  end;

implementation

{ TCliente }

{$region 'Constructor and Destructor'}
constructor TCliente.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;  // Inicializa a conex�o recebida por par�metro.
end;

destructor TCliente.Destroy;
begin
  inherited;  // Garante que o destrutor da classe base tamb�m seja executado.
end;
{$endregion}

{$region 'CRUD'}
function TCliente.Apagar: Boolean;
var Qry: TZQuery;  // Declara uma vari�vel para armazenar a query.
begin
  // Exibe uma mensagem de confirma��o antes de apagar o registro.
  if MessageDlg('Apagar o Registro: ' + #13#13 +
                'C�digo: ' + IntToStr(F_clienteId) + #13 +
                'Descri��o: ' + F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := False;  // Cancela a opera��o se o usu�rio escolher "N�o".
    Abort;  // Aborta a execu��o.
  end;

  try
    Result := True;  // Define o resultado como verdadeiro por padr�o.
    Qry := TZQuery.Create(nil);  // Cria a query.
    Qry.Connection := ConexaoDB;  // Associa a conex�o.
    Qry.SQL.Clear;  // Limpa comandos SQL anteriores.
    Qry.SQL.Add('DELETE FROM clientes WHERE clienteId=:clienteId');  // SQL de exclus�o.
    Qry.ParamByName('clienteId').AsInteger := F_clienteId;  // Define o par�metro.

    try
      ConexaoDB.StartTransaction;  // Inicia uma transa��o.
      Qry.ExecSQL;  // Executa o comando SQL.
      ConexaoDB.Commit;  // Confirma a transa��o.
    except
      ConexaoDB.Rollback;  // Desfaz a transa��o em caso de erro.
      Result := False;
    end;
  finally
    FreeAndNil(Qry);  // Libera a mem�ria alocada para a query.
  end;
end;

function TCliente.Atualizar: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE clientes SET nome=:nome, endereco=:endereco, cidade=:cidade, ' +
                'bairro=:bairro, estado=:estado, cep=:cep, telefone=:telefone, ' +
                'email=:email, dataNascimento=:dataNascimento WHERE clienteId=:clienteId');

    // Atribui valores aos par�metros da query.
    Qry.ParamByName('clienteId').AsInteger := F_clienteId;
    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('endereco').AsString := F_endereco;
    Qry.ParamByName('cidade').AsString := F_cidade;
    Qry.ParamByName('bairro').AsString := F_bairro;
    Qry.ParamByName('estado').AsString := F_estado;
    Qry.ParamByName('cep').AsString := F_cep;
    Qry.ParamByName('telefone').AsString := F_telefone;
    Qry.ParamByName('email').AsString := F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := F_dataNascimento;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

function TCliente.Inserir: Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO clientes (nome, endereco, cidade, bairro, estado, cep, telefone, ' +
                'email, datanascimento) VALUES (:nome, :endereco, :cidade, :bairro, :estado, ' +
                ':cep, :telefone, :email, :datanascimento)');

    // Define os valores dos par�metros.
    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('endereco').AsString := F_endereco;
    Qry.ParamByName('cidade').AsString := F_cidade;
    Qry.ParamByName('bairro').AsString := F_bairro;
    Qry.ParamByName('estado').AsString := F_estado;
    Qry.ParamByName('cep').AsString := F_cep;
    Qry.ParamByName('telefone').AsString := F_telefone;
    Qry.ParamByName('email').AsString := F_email;
    Qry.ParamByName('dataNascimento').AsDateTime := F_dataNascimento;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

function TCliente.Selecionar(id: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT * FROM clientes WHERE clienteId=:clienteId');
    Qry.ParamByName('clienteId').AsInteger := id;

    try
      Qry.Open;

      // Atribui os valores retornados para os atributos da classe.
      F_clienteId := Qry.FieldByName('clienteId').AsInteger;
      F_nome := Qry.FieldByName('nome').AsString;
      F_endereco := Qry.FieldByName('endereco').AsString;
      F_cidade := Qry.FieldByName('cidade').AsString;
      F_bairro := Qry.FieldByName('bairro').AsString;
      F_estado := Qry.FieldByName('estado').AsString;
      F_cep := Qry.FieldByName('cep').AsString;
      F_telefone := Qry.FieldByName('telefone').AsString;
      F_email := Qry.FieldByName('email').AsString;
      F_dataNascimento := Qry.FieldByName('datanascimento').AsDateTime;
    except
      Result := False;


    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
{$endregion}


end.
