﻿unit cProVenda;

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
     Data.DB,
     uEnum,
     Datasnap.DBClient;

type
  TVenda = class
  private
    ConexaoDB : TZConnection;
    F_vendaId : Integer;
    F_clienteId : Integer;
    F_dataVenda : TDateTime;
    F_totalVenda : Double;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;


  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;
    function Inserir(cds:TClientDataSet):Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer; var cds:TClientDataSet):Boolean;
  published
    property VendaId:Integer     read F_vendaId    write F_vendaId;
    property ClienteId:Integer   read F_clienteId  write F_clienteId;
    property DataVenda:TDateTime read F_dataVenda  write F_dataVenda;
    property TotalVenda:Double   read F_totalVenda write F_totalVenda;
  end;

implementation


{ TCategoria }

{$region 'Constructor and Destructor'}
constructor TVenda.Create(aConexao:TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TVenda.Destroy;
begin

  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TVenda.Apagar: Boolean;
var
	Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Venda Nº: '+IntToStr(VendaId),mtConfirmation,[mbYes, mbNo],0) = mrNo then begin
     Result:=false;
     abort;
  end;

  try
    Result:=true;
    ConexaoDB.StartTransaction;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    //Apaga os Itens Primeiro
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM vendasItens '+
                ' WHERE vendaId=:vendaId ');
    Qry.ParamByName('vendaId').AsInteger := VendaId;
    Try
      Qry.ExecSQL;
      //Apaga a Tabela Master
      Qry.SQL.Clear;
      Qry.SQL.Add('DELETE FROM vendas '+
                  ' WHERE vendaId=:vendaId ');
      Qry.ParamByName('vendaId').AsInteger := VendaId;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TVenda.Atualizar: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE vendas '+
                '   SET clienteId=:clienteId '+
                '      ,dataVenda=:dataVenda '+
                '      ,totalVenda=:totalVenda '+
                ' WHERE vendaId=:vendaId ');
    Qry.ParamByName('vendaId').AsInteger    :=Self.F_vendaId;
    Qry.ParamByName('clienteId').AsInteger  :=Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime :=Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat   :=Self.F_totalVenda;

    Try
      //Update
      Qry.ExecSQL;
    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TVenda.Inserir(cds: TClientDataSet) : Boolean;
var Qry:TZQuery;
    IdVendaGerado : Integer;
begin
  try
  	Result := True;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    //Faz a Inclus�o no Banco de Dados
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO vendas (clienteId, dataVenda, totalVenda)  '+
                '            VALUES (:clienteId,:dataVenda,:totalVenda )');
    Qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    Try
      Qry.ExecSQL;
      //Recupera o ID Gerado no Insert
      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT SCOPE_IDENTITY() AS ID');
      Qry.Open;

      //Id da tabela Master (Venda)
      IdVendaGerado := Qry.FieldByName('ID').AsInteger;

      {$REGION 'Gravar na tabela VendasItens'}
      cds.First;
      while not cds.Eof do begin
        InserirItens(cds, IdVendaGerado);
        cds.Next;
      end;
      {$ENDREGION}

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

function TVenda.InserirItens(cds:TClientDataSet; IdVenda:Integer):Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO VendasItens ( VendaID, ProdutoID, ValorUnitario, Quantidade, TotalProduto) '+
                '                 VALUES (:VendaID,:ProdutoID,:ValorUnitario,:Quantidade,:TotalProduto) ');

    Qry.ParamByName('VendaID').AsInteger    := IdVenda;
    Qry.ParamByName('ProdutoID').AsInteger  := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('ValorUnitario').AsFloat:= cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('Quantidade').AsFloat   := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('TotalProduto').AsFloat := cds.FieldByName('valorTotalProduto').AsFloat;
    try
    	Qry.ExecSQL;
		Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TVenda.Selecionar(id: Integer; var cds:TClientDataSet): Boolean;
var Qry:TZQuery;
begin
  try
    Result := true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT vendaId '+
                '      ,clienteId '+
                '      ,dataVenda '+
                '      ,totalVenda '+
                '  FROM vendas '+
                ' WHERE vendaId=:vendaId');
    Qry.ParamByName('vendaId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_vendaId    := Qry.FieldByName('vendaId').AsInteger;
      Self.F_clienteId  := Qry.FieldByName('clienteId').AsInteger;
      Self.F_dataVenda  := Qry.FieldByName('dataVenda').AsDateTime;
      Self.F_totalVenda := Qry.FieldByName('totalVenda').AsFloat;

      {$REGION 'SELECIONAR na tabela VendasItens'}
      //Apaga o ClientDataSet Caso esteja com Registro
      cds.First;
      while not cds.Eof do begin
        cds.Delete;
      end;

      //Seleciona os Itens do Banco de Dados com a propriedade F_VendaId
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT VendasItens.ProdutoID, '+
                  '       Produtos.Nome, '+
                  '       VendasItens.ValorUnitario, '+
                  '       VendasItens.Quantidade, '+
                  '       VendasItens.TotalProduto '+
                  '  FROM VendasItens  '+
                  '       INNER JOIN produtos On Produtos.produtoId = VendasItens.produtoId '+
                  ' WHERE VendasItens.VendaID=:VendaID ');
      Qry.ParamByName('VendaID').AsInteger    := Self.F_vendaId;
      Qry.Open;

       //Pega da Query e Coloca no ClientDataSet
      Qry.First;
      while not Qry.Eof do begin
        cds.Append;
        cds.FieldByName('produtoId').AsInteger       := Qry.FieldByName('ProdutoID').AsInteger;
        cds.FieldByName('nomeProduto').AsString      := Qry.FieldByName('Nome').AsString;
        cds.FieldByName('valorUnitario').AsFloat     := Qry.FieldByName('ValorUnitario').AsFloat;
        cds.FieldByName('quantidade').AsFloat        := Qry.FieldByName('Quantidade').AsFloat;
        cds.FieldByName('valorTotalProduto').AsFloat := Qry.FieldByName('TotalProduto').AsFloat;
        cds.Post;
        Qry.Next;
      end;

      {$endRegion}

		Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
{$endregion}


end.
