unit cAtualizacaoBancoDeDados;

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
     Data.DB,
     System.SysUtils;


type
  TAtualizaBancoDados = class

  private

  public
  	ConexaoDB:TZConnection;
  	constructor Create(aConexao:TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
end;

Type
  TAtualizaBancoDadosMSSQL = Class
  private
  	ConexaoDB: TZConnection;
  public
  	function AtualizarBancoDeDadosMSSQL: Boolean;
    constructor Create(aConexao: TZConnection);
End;


implementation

{ TAtualizaBancoDados }

constructor TAtualizaBancoDados.Create(aConexao: TZConnection);
begin
	ConexaoDB := aConexao;
end;

procedure TAtualizaBancoDados.ExecutaDiretoBancoDeDados(aScript: String);
Var Qry:TZQuery;
Begin
  Try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(aScript);
    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
    End;
  Finally
    Qry.Close;
    if Assigned(Qry) then
       FreeAndNil(Qry);
  End;
end;

{ TAtualizaBancoDadosMSSQL }

function TAtualizaBancoDadosMSSQL.AtualizarBancoDeDadosMSSQL: Boolean;
var oAtualizarDB:TAtualizaBancoDados;
    oTabela: TAtualizaBancoDadosMSSQL;

begin
  Try
    //Classe Principal de Atualização
    oAtualizarDB := TAtualizaBancoDados.Create(ConexaoDB);

    //Sub-Class de Atualização
    oTabela := TAtualizaBancoDadosMSSQL.Create(ConexaoDB);

  Finally
  	if	Assigned(oAtualizarDB) then
   		FreeAndNil(oAtualizarDB);

    if	Assigned(oTabela) then
   		FreeAndNil(oTabela);
  End;
end;

constructor TAtualizaBancoDadosMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB:=aConexao;
end;

end.
