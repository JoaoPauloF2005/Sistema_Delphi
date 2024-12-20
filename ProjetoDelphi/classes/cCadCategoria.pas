unit cCadCategoria;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection, ZConnection,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils; // Lista de units necess�rias

type
  // Classe TCategoria para gerenciar categorias no banco de dados
  TCategoria = class
  private
    ConexaoDB: TZConnection;  // Conex�o com o banco de dados (via Zeos)
    F_categoriaId: Integer;   // Campo que armazena o ID da categoria
    F_descricao: String;      // Campo que armazena a descri��o da categoria

    // Fun��o para obter o ID da categoria
    function getCodigo: Integer;

    // Fun��o para obter a descri��o da categoria
    function getDescricao: string;

    // Procedimento para definir o ID da categoria
    procedure setCodigo(const Value: Integer);

    // Procedimento para definir a descri��o da categoria
    procedure setDescricao(const Value: string);

  public
    // Construtor que inicializa a classe com a conex�o ao banco de dados
    constructor Create(aConexao: TZConnection);

    // Destrutor que libera recursos ao destruir a classe
    destructor Destroy; override;

    // Fun��o para inserir uma nova categoria no banco de dados
    function Inserir: Boolean;

    // Fun��o para atualizar uma categoria existente no banco de dados
    function Atualizar: Boolean;

    // Fun��o para apagar uma categoria do banco de dados
    function Apagar: Boolean;

    // Fun��o para selecionar uma categoria espec�fica pelo ID
    function Selecionar(id: Integer): Boolean;

  published
    // Propriedade para acessar o ID da categoria
    property codigo: Integer read getCodigo write setCodigo;

    // Propriedade para acessar a descri��o da categoria
    property descricao: string read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }

{$REGION 'Constructor and Destructor'}

constructor TCategoria.Create(aConexao: TZConnection);
begin
  // Inicializa a conex�o recebida no par�metro
  ConexaoDB := aConexao;
end;

destructor TCategoria.Destroy;
begin
  // Executa procedimentos de limpeza (caso necess�rio) e chama o destrutor da classe pai
  inherited;
end;

{$ENDREGION}

{$REGION 'CRUD'}

function TCategoria.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  Result := False;

  // Solicita confirma��o ao usu�rio antes de apagar o registro
  if MessageDlg('Deseja realmente apagar a categoria "' + F_descricao + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Text := 'DELETE FROM categorias WHERE categoriaId = :categoriaId';
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;

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
          raise Exception.Create('N�o � poss�vel excluir esta categoria porque ela est� vinculada a outros registros.')
        else
          raise Exception.Create('Erro ao excluir a categoria: ' + E.Message);
      end;
    end;
  finally
    Qry.Free;
  end;
end;



function TCategoria.Atualizar: Boolean;
var
  Qry: TZQuery; // Declara��o de uma consulta SQL do tipo TZQuery
begin
  try
    // Cria e configura a consulta
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB; // Associa a conex�o ao banco

    // Prepara a instru��o SQL para atualizar uma categoria
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE categorias SET descricao = :descricao WHERE categoriaId = :categoriaId');

    // Atribui valores aos par�metros SQL
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString := Self.F_descricao;

    try
    	ConexaoDB.StartTransaction;
      Qry.ExecSQL;   // Executa a consulta SQL
      ConexaoDB.Commit;
    except
    	ConexaoDB.Rollback;
      Result:=False;
    end;

  finally
    // Libera a consulta da mem�ria
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

  Result := True; // Retorna True para indicar sucesso
end;


function TCategoria.Inserir: Boolean;
var
  Qry: TZQuery; // Declara��o de uma consulta SQL do tipo TZQuery
begin
  try
    // Cria e configura a consulta
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB; // Associa a conex�o ao banco

    // Prepara a instru��o SQL para inserir uma nova categoria
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO categorias (descricao) VALUES (:descricao)');

    // Atribui valor ao par�metro SQL
    Qry.ParamByName('descricao').AsString := Self.F_descricao;

    try
    	ConexaoDB.StartTransaction;
      Qry.ExecSQL;   // Executa a consulta SQL
      ConexaoDB.Commit;
    except
    	ConexaoDB.Rollback;
      Result:=False;
    end;

  finally
    // Libera a consulta da mem�ria
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

  Result := True; // Retorna True para indicar sucesso
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var
  Qry: TZQuery; // Declara��o de uma consulta SQL do tipo TZQuery
begin
  try
    Result := True; // Inicializa o resultado como True

    // Cria e configura a consulta
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB; // Associa a conex�o ao banco

    // Prepara a instru��o SQL para selecionar uma categoria pelo ID
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT categoriaId, descricao FROM categorias WHERE categoriaId = :categoriaId');

    // Atribui valor ao par�metro SQL
    Qry.ParamByName('categoriaId').AsInteger := id;

    try
      Qry.Open; // Executa a consulta e abre o dataset com os resultados

      // Atribui os valores obtidos �s vari�veis da classe
      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_descricao := Qry.FieldByName('descricao').AsString;

    except
      Result := False; // Retorna False em caso de erro
    end;

  finally
    // Libera a consulta da mem�ria
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$ENDREGION}

{$REGION 'Gets'}

function TCategoria.getCodigo: Integer;
begin
  // Retorna o ID da categoria
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: string;
begin
  // Retorna a descri��o da categoria
  Result := Self.F_descricao;
end;

{$ENDREGION}

{$REGION 'Sets'}

procedure TCategoria.setCodigo(const Value: Integer);
begin
  // Define o ID da categoria
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: string);
begin
  // Define a descri��o da categoria
  Self.F_descricao := Value;
end;

{$ENDREGION}

end.

