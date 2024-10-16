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
    dbGriditensVenda: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    Label1: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnRemover: TBitBtn;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
  private
    { Private declarations }
  	dtmVenda: TdtmVenda;
    oVenda:TVenda;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;

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
	if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger) then begin
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
  	Result := oVenda.Inserir
  else
  if(EstadoDoCadastro = ecAlterar)then
  	Result := oVenda.Atualizar;
end;


procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  edtValorUnitario.Value := dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
  edtQuantidade.Value := 1;
  edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

{$ENDREGION}

procedure TfrmProVenda.btnAdicionarClick(Sender: TObject);
begin
	if lkpProduto.KeyValue = Null then begin
    MessageDlg('Produto � um campo obrigat�rio' ,mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    Abort;
  end;

  if edtValorUnitario.Value <= 0 then begin
    MessageDlg('Valor Unit�rio n�o pode ser zero' ,mtInformation, [mbOK], 0);
    edtValorUnitario.SetFocus;
    Abort;
  end;

  if edtQuantidade.Value <= 0 then begin
    	MessageDlg('Quantidade n�o pode ser zero' ,mtInformation, [mbOK], 0);
      edtQuantidade.SetFocus;
      Abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
    MessageDlg('Este Produto j� foi selecionado' ,mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    abort;
  end;

  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString := lkpProduto.KeyValue;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString := dtmVenda.QryProdutos.FieldByName('nome').AsString;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat := edtTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;
  LimparComponenteItem;
  lkpProduto.SetFocus;

end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  	lkpProduto.KeyValue			:= null;
    edtQuantidade.Value			:= 0;
    edtValorUnitario.Value  := 0;
    edtTotalProduto.Value		:= 0;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade : Double) : 	Double;
begin
	Result := valorUnitario  * Quantidade;

	if
  	oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger) then begin
      edtVendaId.Text    		:= IntToStr(oVenda.VendaId);
      lkpCliente.KeyValue   := oVenda.ClienteId;
      edtDataVenda.Date			:= oVenda.DataVenda;
      edtValorTotal.Value		:= OVenda.TotalVenda;
    end;
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger) then begin
     edtVendaId.Text     :=IntToStr(oVenda.VendaId);
     lkpCliente.KeyValue :=oVenda.ClienteId;
     edtDataVenda.Date   :=oVenda.DataVenda;
     edtValorTotal.Value :=oVenda.TotalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date:=Date;
  lkpCliente.SetFocus;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
  	inherited;
    BloqueiaCTRL_DEL_DBGrid(Key, Shift);
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
  dtmVenda:=TdtmVenda.Create(Self);
  oVenda:=TVenda.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual:='clienteId';
end;

end.



