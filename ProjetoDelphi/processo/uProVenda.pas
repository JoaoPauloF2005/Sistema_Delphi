﻿unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uDTMConexao, uDTMVenda,
  RxToolEdit, RxCurrEdit, uEnum, cProVenda, System.ImageList, Vcl.ImgList, Vcl.WinXCtrls;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    QryListagemvendaId: TIntegerField;
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdataVenda: TDateTimeField;
    QryListagemtotalVenda: TFloatField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label4: TLabel;
    edtDataVenda: TDateEdit;
    panelGridItensVenda: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtValorTotal: TCurrencyEdit;
    Label2: TLabel;
    lkpProduto: TDBLookupComboBox;
    Label1: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnApagarItem: TBitBtn;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbGridItensVenda: TDBGrid;
    SearchBox2: TSearchBox;
    QryRelatorio: TZQuery;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure dbGridItensVendaDblClick(Sender: TObject);
    procedure dbGridItensVendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnImprimirClick(Sender: TObject);
    procedure SearchBox2Change(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
  private
    { Private declarations }
  	dtmVenda: TdtmVenda;
    oVenda:TVenda;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;

  public
      { Public declarations }
  end;


var
  frmProVenda: TfrmProVenda;

implementation

uses
  uRelProVenda;

{$R *.dfm}


{$REGION 'Override'}
function TfrmProVenda.Apagar: Boolean;
begin
	if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
 		Result:=oVenda.Apagar;
  end;

end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): boolean;
begin
  if edtVendaId.Text <> EmptyStr then
  	oVenda.VendaId := StrToInt(edtVendaId.Text)
  else
  	oVenda.VendaId := 0;

    oVenda.ClienteId    := lkpCliente.KeyValue;
    oVenda.DataVenda		:= edtDataVenda.Date;
    oVenda.TotalVenda		:= edtValorTotal.Value;

  if(EstadoDoCadastro = ecInserir)then
  	oVenda.VendaId := oVenda.Inserir(dtmVenda.cdsItensVenda)
  else
  if(EstadoDoCadastro = ecAlterar)then
  	oVenda.Atualizar(dtmVenda.cdsItensVenda);

  frmRelProVenda := TfrmRelProVenda.Create(Self);
  frmRelProVenda.QryVenda.Close;
  frmRelProVenda.QryVenda.ParamByName('VendaId').AsInteger := oVenda.VendaId;
  frmRelProVenda.QryVenda.Open;

  frmRelProVenda.QryVendasItens.Close;
  frmRelProVenda.QryVendasItens.ParamByName('VendaId').AsInteger := oVenda.VendaId;
  frmRelProVenda.QryVendasItens.Open;

  Result := true;
end;


procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
 	if lkpProduto.KeyValue <> Null then begin
    edtValorUnitario.Value := dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  end;
end;

procedure TfrmProVenda.SearchBox1Change(Sender: TObject);
var
  SearchText: string;
begin
  inherited;

  // Obtém o texto digitado pelo usuário
  SearchText := Trim(TSearchBox(Sender).Text);

  // Desabilita a query para ajuste do SQL
  QryListagem.Close;

  // Ajusta o SQL dinamicamente para aplicar o filtro em todos os campos necessários
  if SearchText <> '' then
  begin
    QryListagem.SQL.Text :=
      'SELECT vendas.vendaId, ' +
      '       vendas.clienteId, ' +
      '       clientes.nome, ' +
      '       vendas.dataVenda, ' +
      '       vendas.totalVenda ' +
      'FROM vendas ' +
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId ' +
      'WHERE clientes.nome LIKE :SearchText ' +
      '   OR vendas.vendaId LIKE :SearchText ' +
      '   OR vendas.dataVenda LIKE :SearchText ' +
      '   OR vendas.totalVenda LIKE :SearchText ';

    // Adiciona o parâmetro para evitar SQL Injection
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text :=
      'SELECT vendas.vendaId, ' +
      '       vendas.clienteId, ' +
      '       clientes.nome, ' +
      '       vendas.dataVenda, ' +
      '       vendas.totalVenda ' +
      'FROM vendas ' +
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;
end;

procedure TfrmProVenda.SearchBox2Change(Sender: TObject);
var
  SearchText: string;
begin
  inherited;

  // Obtém o texto digitado pelo usuário
  SearchText := Trim(TSearchBox(Sender).Text);

  // Fecha a query para ajuste do SQL
  QryListagem.Close;

  // Ajusta o SQL dinamicamente para aplicar o filtro nos campos de "VendasItens"
  if SearchText <> '' then
  begin
    QryListagem.SQL.Text :=
      'SELECT vendasItens.vendaId AS "Numero Venda", ' +
      '       vendasItens.produtoId AS "Codigo Produto", ' +
      '       produtos.nome AS "Nome Produto", ' +
      '       vendasItens.valorUnitario AS "Valor Unitario", ' +
      '       vendasItens.quantidade AS "Quantidade", ' +
      '       vendasItens.totalProduto AS "Total Produto" ' +
      'FROM vendasItens ' +
      'INNER JOIN produtos ON produtos.produtoId = vendasItens.produtoId ' +
      'WHERE produtos.nome LIKE :SearchText ' +
      '   OR vendasItens.valorUnitario LIKE :SearchText ' +
      '   OR vendasItens.quantidade LIKE :SearchText ' +
      '   OR vendasItens.totalProduto LIKE :SearchText ' +
      '   OR vendasItens.vendaId LIKE :SearchText ' +
      '   OR vendasItens.produtoId LIKE :SearchText';

    // Define o parâmetro para o texto de pesquisa
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text :=
      'SELECT vendasItens.vendaId AS "Numero Venda", ' +
      '       vendasItens.produtoId AS "Codigo Produto", ' +
      '       produtos.nome AS "Nome Produto", ' +
      '       vendasItens.valorUnitario AS "Valor Unitario", ' +
      '       vendasItens.quantidade AS "Quantidade", ' +
      '       vendasItens.totalProduto AS "Total Produto" ' +
      'FROM vendasItens ' +
      'INNER JOIN produtos ON produtos.produtoId = vendasItens.produtoId';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;
end;





{$ENDREGION}

procedure TfrmProVenda.btnAdicionarClick(Sender: TObject);
begin
	if lkpProduto.KeyValue = Null then begin
    MessageDlg('Produto é um campo obrigatório' ,mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    Abort;
  end;

  if edtValorUnitario.Value <= 0 then begin
    MessageDlg('Valor Unitário não pode ser zero' ,mtInformation, [mbOK], 0);
    edtValorUnitario.SetFocus;
    Abort;
  end;

  if edtQuantidade.Value <= 0 then begin
    	MessageDlg('Quantidade não pode ser zero' ,mtInformation, [mbOK], 0);
      edtQuantidade.SetFocus;
      Abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
    MessageDlg('Este Produto já foi selecionado' ,mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    abort;
  end;

  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString := lkpProduto.KeyValue;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString := dtmVenda.QryProdutos.FieldByName('nome').AsString;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat := edtTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;
  edtValorTotal.Value	:= TotalizarVenda;
  LimparComponenteItem;
  lkpProduto.SetFocus;

end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
     edtVendaId.Text     := IntToStr(oVenda.VendaId);
     lkpCliente.KeyValue := oVenda.ClienteId;
     edtDataVenda.Date   := oVenda.DataVenda;
     edtValorTotal.Value := oVenda.TotalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
begin
  inherited;

  if lkpProduto.KeyValue = Null then begin
     MessageDlg('Selecione o Produto a ser excluído' ,mtInformation,[mbOK],0);
     dbGridItensVenda.SetFocus;
     abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
     dtmVenda.cdsItensVenda.Delete;
     LimparComponenteItem;
  end;
		edtValorTotal.Value	:= TotalizarVenda;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
	LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
	LimparCds;
end;

procedure TfrmProVenda.btnImprimirClick(Sender: TObject);
var
  Relatorio: TfrmRelProVenda;
begin
  Relatorio := TfrmRelProVenda.Create(nil);
  try
    Relatorio.QryVenda.Close;
    Relatorio.QryVenda.Open;

    if Relatorio.Relatorio.Prepare then
    begin
      Relatorio.Relatorio.Preview;

      if MessageDlg('Deseja imprimir este relatório?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Relatorio.Relatorio.Print;
      end;
    end
    else
    begin
      ShowMessage('Falha ao preparar o relatório. Verifique os dados e tente novamente.');
    end;
  finally
    Relatorio.QryVenda.Close;
    Relatorio.Free;
  end;
end;


procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.dbGridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbGridItensVendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  // Alterna a cor de fundo das linhas
  if Odd(dbGridItensVenda.DataSource.DataSet.RecNo) then
    dbGridItensVenda.Canvas.Brush.Color := clWhite // Cor cinza claro para linhas �mpares
  else
    dbGridItensVenda.Canvas.Brush.Color := $00E9E9E9; // Cor branca para linhas pares

  // Verifica se a c�lula est� selecionada
  if (gdSelected in State) then
  begin
    dbGridItensVenda.Canvas.Brush.Color := RGB(165, 208, 247);; // Cor de fundo da c�lula selecionada  [
    dbGridItensVenda.Canvas.Font.Color := clBlack; // Mant�m a cor do texto preta ao selecionar
  end
  else
  begin
    dbGridItensVenda.Canvas.Font.Color := clBlack; // Cor do texto normal
  end;

  // Preenche o ret�ngulo da c�lula
  dbGridItensVenda.Canvas.FillRect(Rect);

  // Desenha o texto na c�lula
  dbGridItensVenda.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
  	inherited;
    BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   if Assigned(dtmVenda) then
   	FreeAndNil(dtmVenda);

   if Assigned(oVenda) then
   	FreeAndNil(dtmVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda := TdtmVenda.Create(Self);
  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual:='nome';
end;

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue			:= dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtValorUnitario.Value	:= dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtQuantidade.Value			:= dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
	edtTotalProduto.Value		:= dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade : Double) : 	Double;
begin
	result := valorUnitario  * Quantidade;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  	lkpProduto.KeyValue			:= null;
    edtQuantidade.Value			:= 0;
    edtValorUnitario.Value  := 0;
    edtTotalProduto.Value		:= 0;
end;

procedure TfrmProVenda.LimparCds;
begin
	dtmVenda.cdsItensVenda.First;
	while not dtmVenda.CdsItensVenda.Eof	do
  	dtmVenda.cdsItensVenda.Delete;
end;

function TfrmProVenda.TotalizarVenda : Double;
begin
  result := 0;
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do begin
    result := result + dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVenda.cdsItensVenda.Next;
  end;
end;
end.



