﻿unit cCadProduto;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils,
     Data.DB;

type
  TProduto = class
  private
    ConexaoDB:TZConnection;
    F_produtoId:Integer;  //Int
    F_nome:String; //VarChar
    F_descricao: string;
    F_valor:Double;
    F_quantidade: Double;
    F_categoriaId: Integer;
    F_imagem: TMemoryStream; // Novo campo para a imagem
    F_subCategoriaId : Integer;

  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
  published
    property codigo        :Integer    read F_produtoId      write F_produtoId;
    property nome          :string     read F_nome           write F_nome;
    property descricao     :string     read F_descricao      write F_descricao;
    property valor         :Double     read F_valor          write F_valor;
    property quantidade    :Double     read F_quantidade     write F_quantidade;
    property categoriaId   :Integer    read F_categoriaId    write F_categoriaId;
    property subCategoriaId :Integer   read F_subCategoriaId  write F_subCategoriaId;
     property imagem: TMemoryStream read F_imagem write F_imagem;
  end;

implementation


{ TCategoria }

{$region 'Constructor and Destructor'}
constructor TProduto.Create(aConexao:TZConnection);
begin
  ConexaoDB:=aConexao;
  F_imagem := TMemoryStream.Create;
end;

destructor TProduto.Destroy;
begin
  F_imagem.Free;
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TProduto.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  Result := False;

  // Confirmação para exclusão
  if MessageDlg('Deseja realmente apagar o produto "' + F_nome + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Text := 'DELETE FROM produtos WHERE produtoId = :produtoId';
    Qry.ParamByName('produtoId').AsInteger := F_produtoId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        ConexaoDB.Rollback;

        // Verifica se o erro é de chave estrangeira
        if Pos('FK_', E.Message) > 0 then
          raise Exception.Create('Não é possível excluir este produto porque ele está vinculado a outros registros.')
        else
          raise Exception.Create('Erro ao excluir o produto: ' + E.Message);
      end;
    end;
  finally
    Qry.Free;
  end;
end;

function TProduto.Atualizar: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos SET nome = :nome, descricao = :descricao, valor = :valor, quantidade = :quantidade, ' +
                'categoriaId = :categoriaId, subCategoriaId = :subCategoriaId, imagem = :imagem WHERE produtoId = :produtoId');

    Qry.ParamByName('produtoId').AsInteger := F_produtoId;
    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('descricao').AsString := F_descricao;
    Qry.ParamByName('valor').AsFloat := F_valor;
    Qry.ParamByName('quantidade').AsFloat := F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;
    Qry.ParamByName('subCategoriaId').AsInteger := F_subCategoriaId;

    if F_imagem.Size > 0 then
    begin
      F_imagem.Position := 0; // Garante que o stream esteja no início
      Qry.ParamByName('imagem').LoadFromStream(F_imagem, ftBlob);
    end
    else
      Qry.ParamByName('imagem').Clear; // Configura o parâmetro como NULL

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;

function TProduto.Inserir: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO produtos (nome, descricao, valor, quantidade, categoriaId, subCategoriaId, imagem) ' +
                'VALUES (:nome, :descricao, :valor, :quantidade, :categoriaId,  :subCategoriaId, :imagem)');

    Qry.ParamByName('nome').AsString := F_nome;
    Qry.ParamByName('descricao').AsString := F_descricao;
    Qry.ParamByName('valor').AsFloat := F_valor;
    Qry.ParamByName('quantidade').AsFloat := F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;
    Qry.ParamByName('subCategoriaId').AsInteger := F_subCategoriaId;

    if F_imagem.Size > 0 then
    begin
      F_imagem.Position := 0; // Garante que o stream esteja no início
      Qry.ParamByName('imagem').LoadFromStream(F_imagem, ftBlob);
    end
    else
      Qry.ParamByName('imagem').Clear; // Configura o parâmetro como NULL

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    Qry.Free;
  end;
end;


function TProduto.Selecionar(id: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT produtoId, nome, descricao, valor, quantidade, categoriaId, subCategoriaId, imagem ' +
                'FROM produtos WHERE produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := id;

    try
      Qry.Open;

      F_produtoId := Qry.FieldByName('produtoId').AsInteger;
      F_nome := Qry.FieldByName('nome').AsString;
      F_descricao := Qry.FieldByName('descricao').AsString;
      F_valor := Qry.FieldByName('valor').AsFloat;
      F_quantidade := Qry.FieldByName('quantidade').AsFloat;
      F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      F_subCategoriaId := Qry.FieldByName('subCategoriaId').AsInteger;

      // Carrega a imagem do banco de dados, se disponível
      F_imagem.Clear;
      if not Qry.FieldByName('imagem').IsNull then
        TBlobField(Qry.FieldByName('imagem')).SaveToStream(F_imagem);

    except
      Result := false;
    end;

  finally
    Qry.Free;
  end;
end;

{$endregion}


end.
