unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uDTMConexao, uDTMVenda,
  RxToolEdit, RxCurrEdit, uEnum, cProVenda;

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
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtValorTotal: TCurrencyEdit;
    Label2: TLabel;
    dbGridItensVenda: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    Label1: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnApagarItem: TBitBtn;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
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
  	Result := oVenda.Inserir(dtmVenda.cdsItensVenda)
  else
  if(EstadoDoCadastro = ecAlterar)then
  	Result := oVenda.Atualizar;
end;


procedure TfrmProVenda.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  // Aplica a cor de fundo personalizada para linha selecionada
  if gdSelected in State then
    grdListagem.Canvas.Brush.Color := RGB(190, 223, 241)  // Beau Blue
  else
    grdListagem.Canvas.Brush.Color := clWindow;  // Cor padrão de fundo
    grdListagem.Canvas.Font.Color := clBlack;   // Cor do texto preta

  // Preenche o retângulo da célula
  grdListagem.Canvas.FillRect(Rect);

  // Exibe o texto da célula alinhado
  grdListagem.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
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
  if gdSelected in State then
  begin
    // Define a cor de fundo e da fonte para a linha selecionada
    dbGridItensVenda.Canvas.Brush.Color := $F1DFBE;  // Cor de fundo branco
    dbGridItensVenda.Canvas.Font.Color := clBlack;   // Cor do texto preta
  end
  else
    dbGridItensVenda.Canvas.Brush.Color := clWindow;  // Cor normal de fundo

  dbGridItensVenda.Canvas.FillRect(Rect);  // Preenche a célula
  dbGridItensVenda.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
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



