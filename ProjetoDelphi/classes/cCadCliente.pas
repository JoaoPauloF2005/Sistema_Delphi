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
    F_status: string;
    F_tipoPessoa: string;
    F_cpfCnpj: string;
    F_endereco: String;        // Endere�o do cliente.
    F_cidade: String;          // Cidade do cliente.
    F_bairro: String;          // Bairro do cliente.
    F_estado: String;          // Estado do cliente.
    F_cep: String;             // CEP do cliente.
    F_telefone: String;        // Telefone do cliente.
    F_email: String;           // E-mail do cliente.
    F_dataNascimento: TDateTime;
    function VerificarDuplicidade: Boolean; // Data de nascimento do cliente.

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
    property status: string read F_status write F_status;
    property tipoPessoa: string read F_tipoPessoa write F_tipoPessoa;
    property cpfCnpj: string read F_cpfCnpj write F_cpfCnpj;
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
var
  Qry: TZQuery;
begin
  Result := False;

  // Solicita confirma��o ao usu�rio antes de apagar o registro
  if MessageDlg('Deseja realmente apagar o cliente "' + F_nome + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Text := 'DELETE FROM clientes WHERE clienteId = :clienteId';
    Qry.ParamByName('clienteId').AsInteger := F_clienteId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        ConexaoDB.Rollback;

        // Verifica se o erro � de chave estrangeira
        if Pos('FK_', E.Message) > 0 then
          raise Exception.Create('N�o � poss�vel excluir este cliente porque ele est� vinculado a outros registros.')
        else
          raise Exception.Create('Erro ao excluir o cliente: ' + E.Message);
      end;
    end;
  finally
    Qry.Free;
  end;
end;



function TCliente.Atualizar: Boolean;
var Qry: TZQuery;
begin

  if VerificarDuplicidade then
  begin
    raise Exception.Create('Cliente j� cadastrado com o mesmo CPF ou nome.');
    Exit(False);
  end;

   Result := True;

  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE clientes SET nome=:nome, status=:status, tipoPessoa=:tipoPessoa, cpfCnpj=:cpfCnpj, endereco=:endereco, cidade=:cidade, ' +
                'bairro=:bairro, estado=:estado, cep=:cep, telefone=:telefone, ' +
                'email=:email, dataNascimento=:dataNascimento WHERE clienteId=:clienteId');

    // Atribui valores aos par�metros da query.
    Qry.ParamByName('clienteId').AsInteger := F_clienteId;
    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('status').AsString := F_status;
    Qry.ParamByName('tipoPessoa').AsString := F_tipoPessoa;
    Qry.ParamByName('cpfCnpj').AsString := F_cpfCnpj;
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

 if VerificarDuplicidade then
  begin
    raise Exception.Create('Cliente j� cadastrado com o mesmo CPF ou nome.');
    Exit(False);
  end;

   Result := True;

  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO clientes (nome, status, tipoPessoa, cpfCnpj, endereco, cidade, bairro, estado, cep, telefone, ' +
                'email, datanascimento) VALUES (:nome, :status, :tipoPessoa, :cpfCnpj, :endereco, :cidade, :bairro, :estado, ' +
                ':cep, :telefone, :email, :datanascimento)');

    // Define os valores dos par�metros.
    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('status').AsString := F_status;
    Qry.ParamByName('tipoPessoa').AsString := F_tipoPessoa;
    Qry.ParamByName('cpfCnpj').AsString := F_cpfCnpj;
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
      F_status := Qry.FieldByName('status').AsString;
      F_tipoPessoa := Qry.FieldByName('tipoPessoa').AsString;
      F_cpfCnpj := Qry.FieldByName('cpfCnpj').AsString;
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

function TCliente.VerificarDuplicidade: Boolean;
var
  Qry: TZQuery;
begin
  Result := False; // Assume que n�o h� duplicidade por padr�o
  Qry := TZQuery.Create(nil);
  try
    Qry.Connection := ConexaoDB;
    Qry.SQL.Text := 'SELECT clienteId FROM clientes WHERE (cpfCnpj = :cpfCnpj OR nome = :nome) AND clienteId <> :clienteId';
    Qry.ParamByName('cpfCnpj').AsString := F_cpfCnpj;
    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('clienteId').AsInteger := F_clienteId; // Exclui o cliente atual (em caso de atualiza��o)
    Qry.Open;

    if not Qry.IsEmpty then
      Result := True; // Indica que h� duplicidade
  finally
    Qry.Free;
  end;
end;



end.
