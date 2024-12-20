unit cCadSubCategoria;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection, ZConnection,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils;

type
  // Classe TSubCategoria para gerenciar subcategorias no banco de dados
  TSubCategoria = class
  private
    ConexaoDB: TZConnection;  // Conex�o com o banco de dados (via Zeos)
    F_subCategoriaId: Integer;   // Campo que armazena o ID da subcategoria
    F_descricao: String;         // Campo que armazena a descri��o da subcategoria
    F_categoriaId: Integer;      // Campo que armazena o ID da categoria associada

    // Fun��o para obter o ID da subcategoria
    function getCodigo: Integer;

    // Fun��o para obter a descri��o da subcategoria
    function getDescricao: string;

    // Fun��o para obter o ID da categoria
    function getCategoriaId: Integer;

    // Procedimento para definir o ID da subcategoria
    procedure setCodigo(const Value: Integer);

    // Procedimento para definir a descri��o da subcategoria
    procedure setDescricao(const Value: string);

    // Procedimento para definir o ID da categoria
    procedure setCategoriaId(const Value: Integer);

  public
    // Construtor que inicializa a classe com a conex�o ao banco de dados
    constructor Create(aConexao: TZConnection);

    // Destrutor que libera recursos ao destruir a classe
    destructor Destroy; override;

    // Fun��o para inserir uma nova subcategoria no banco de dados
    function Inserir: Boolean;

    // Fun��o para atualizar uma subcategoria existente no banco de dados
    function Atualizar: Boolean;

    // Fun��o para apagar uma subcategoria do banco de dados
    function Apagar: Boolean;

    // Fun��o para selecionar uma subcategoria espec�fica pelo ID
    function Selecionar(id: Integer): Boolean;

  published
    // Propriedades para acessar os campos
    property codigo: Integer read getCodigo write setCodigo;
    property descricao: string read getDescricao write setDescricao;
    property categoriaId: Integer read getCategoriaId write setCategoriaId;
  end;

implementation

{ TSubCategoria }

{$REGION 'Constructor and Destructor'}
constructor TSubCategoria.Create(aConexao: TZConnection);
begin
  // Inicializa a conex�o recebida no par�metro
  ConexaoDB := aConexao;
end;

destructor TSubCategoria.Destroy;
begin
  // Executa procedimentos de limpeza (caso necess�rio) e chama o destrutor da classe pai
  inherited;
end;
{$ENDREGION}

{$REGION 'CRUD'}
function TSubCategoria.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  Result := False;

  // Solicita confirma��o ao usu�rio antes de apagar o registro
  if MessageDlg('Deseja realmente apagar a subcategoria "' + F_descricao + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Text := 'DELETE FROM subCategorias WHERE subCategoriaId = :subCategoriaId';
    Qry.ParamByName('subCategoriaId').AsInteger := F_subCategoriaId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        ConexaoDB.Rollback;
        if Pos('FK_', E.Message) > 0 then
          raise Exception.Create('N�o � poss�vel excluir esta subCategoria porque ela est� vinculada a outros registros.')
        else
          raise Exception.Create('Erro ao excluir a subcategoria: ' + E.Message);
      end;
    end;
  finally
    Qry.Free;
  end;
end;

function TSubCategoria.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE subCategorias SET descricao = :descricao, categoriaId = :categoriaId WHERE subCategoriaId = :subCategoriaId');

    Qry.ParamByName('subCategoriaId').AsInteger := F_subCategoriaId;
    Qry.ParamByName('descricao').AsString := F_descricao;
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      Result := True;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    Qry.Free;
  end;
end;

function TSubCategoria.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO subCategorias (descricao, categoriaId) VALUES (:descricao, :categoriaId)');

    Qry.ParamByName('descricao').AsString := F_descricao;
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      Result := True;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    Qry.Free;
  end;
end;

function TSubCategoria.Selecionar(id: Integer): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT subCategoriaId, descricao, categoriaId FROM subCategorias WHERE subCategoriaId = :subCategoriaId');
    Qry.ParamByName('subCategoriaId').AsInteger := id;

    try
      Qry.Open;
      F_subCategoriaId := Qry.FieldByName('subCategoriaId').AsInteger;
      F_descricao := Qry.FieldByName('descricao').AsString;
      F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;

      Result := True;
    except
      Result := False;
    end;
  finally
    Qry.Free;
  end;
end;
{$ENDREGION}

{$REGION 'Gets'}
function TSubCategoria.getCodigo: Integer;
begin
  Result := F_subCategoriaId;
end;

function TSubCategoria.getDescricao: string;
begin
  Result := F_descricao;
end;

function TSubCategoria.getCategoriaId: Integer;
begin
  Result := F_categoriaId;
end;
{$ENDREGION}

{$REGION 'Sets'}
procedure TSubCategoria.setCodigo(const Value: Integer);
begin
  F_subCategoriaId := Value;
end;

procedure TSubCategoria.setDescricao(const Value: string);
begin
  F_descricao := Value;
end;

procedure TSubCategoria.setCategoriaId(const Value: Integer);
begin
  F_categoriaId := Value;
end;
{$ENDREGION}

end.

