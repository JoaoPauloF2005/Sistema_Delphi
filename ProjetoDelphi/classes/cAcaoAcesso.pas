unit cAcaoAcesso;

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
     Vcl.Forms,
     Vcl.Buttons;

type
	TAcaoAcesso = class
    private
    	ConexaoDB: TZConnection;
      F_acaoAcessoId: Integer;
      F_descricao: string;
      F_chave: string;
      
    public
    	constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id:Integer): Boolean;
      function ChaveExiste(aChave: string): Boolean;
      
    published
    	property codigo 			:Integer 	read F_acaoAcessoId		write F_acaoAcessoId;
      property descricao    :string   read F_descricao      write F_descricao;
      property chave 	      :string   read F_chave          write F_chave;
  end;

implementation

{ TAcaoAcesso }

function TAcaoAcesso.Apagar: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'C�digo: '+IntToStr(F_acaoAcessoId)+#13+
                'Nome: '  +F_descricao, mtConfirmation,[mbYes, mbNo],0) = mrNo then begin
     Result := false;
     abort;
  end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM acaoAcesso '+
                ' WHERE acaoAcessoId = :acaoAcessoId ');
    Qry.ParamByName('acaoAcessoId').AsInteger := F_acaoAcessoId;
    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TAcaoAcesso.Atualizar: Boolean;
var Qry:TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE acaoAcesso '+
                '   SET descricao = :descricao '+
                '      ,chave = :chave '+
                ' WHERE acaoAcessoId = :acaoAcessoId ');
    Qry.ParamByName('acaoAcessoId').AsInteger := Self.F_acaoAcessoId;
    Qry.ParamByName('descricao').AsString := Self.F_descricao;
    Qry.ParamByName('chave').AsString := Self.F_chave;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
function TAcaoAcesso.ChaveExiste(aChave: string): Boolean;
var Qry:TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(acaoAcessoId) AS Qtde '+
                '  FROM acaoAcesso '+
                ' WHERE chave = :chave ');
    Qry.ParamByName('chave').AsString := aChave;
    Try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
         result := true
      else
         result := false;

    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
constructor TAcaoAcesso.Create(aConexao: TZConnection);
begin
	ConexaoDB := aConexao;
end;

destructor TAcaoAcesso.Destroy;
begin

  inherited;
end;

function TAcaoAcesso.Inserir: Boolean;
var Qry:TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO acaoAcesso (descricao, '+
                '                        chave )'+
                ' VALUES                (:descricao, '+
                '                        :chave )' );

    Qry.ParamByName('descricao').AsString := Self.F_descricao;
    Qry.ParamByName('chave').AsString := Self.F_chave;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;


function TAcaoAcesso.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT acaoAcessoId,'+
                '       descricao, '+
                '       chave '+
                '  FROM acaoAcesso '+
                ' WHERE acaoAcessoId = :acaoAcessoId');
    Qry.ParamByName('acaoAcessoId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_acaoAcessoId  := Qry.FieldByName('acaoAcessoId').AsInteger;
      Self.F_descricao     := Qry.FieldByName('descricao').AsString;
      Self.F_chave         := Qry.FieldByName('chave').AsString;;
    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;


end.
