unit uCadAcaoAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cAcaoAcesso, uEnum, uDTMConexao,
  System.ImageList, Vcl.ImgList, System.Win.ComObj, Vcl.OleAuto, Vcl.WinXCtrls;

type
  TfrmCadAcaoAcesso = class(TfrmTelaHeranca)
    QryListagemacaoAcessoId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    QryListagemchave: TWideStringField;
    edtAcaoAcessoId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtChave: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure SearchBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    oAcaoAcesso : TAcaoAcesso;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro) : Boolean; override;
    function Apagar: Boolean; override;
  end;

var
  frmCadAcaoAcesso: TfrmCadAcaoAcesso;

implementation

{$R *.dfm}

{ TfrmCadAcaoAcesso }

function TfrmCadAcaoAcesso.Apagar: Boolean;
begin
	if oAcaoAcesso.Selecionar(QryListagem.FieldByName('acaoAcessoId').AsInteger) then begin
    Result := oAcaoAcesso.Apagar;
  end;
end;

procedure TfrmCadAcaoAcesso.btnAlterarClick(Sender: TObject);
begin
	if oAcaoAcesso.Selecionar(QryListagem.FieldByName('acaoAcessoId').AsInteger) then begin
  	edtAcaoAcessoId.Text := IntToStr(oAcaoAcesso.codigo);
    edtDescricao.Text	:= oAcaoAcesso.descricao;
    edtChave.Text	:=	oAcaoAcesso.chave;

	end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;

end;


procedure TfrmCadAcaoAcesso.btnGravarClick(Sender: TObject);
begin


  if edtAcaoAcessoId.Text <> EmptyStr then
     oAcaoAcesso.codigo := StrToInt(edtAcaoAcessoId.Text)
  else
  	 oAcaoAcesso.codigo := 0;

  oAcaoAcesso.descricao	:= edtDescricao.Text;
  oAcaoAcesso.chave	:= edtChave.Text;

  if oAcaoAcesso.ChaveExiste(edtChave.Text, oAcaoAcesso.codigo ) then begin
  	MessageDlg('Chave j� cadastrado', mtInformation, [mbOK], 0);
  	edtChave.SetFocus;
  	Abort;
  end;

  inherited;

end;

procedure TfrmCadAcaoAcesso.btnNovoClick(Sender: TObject);
begin
  inherited;
   edtDescricao.SetFocus;
end;

procedure TfrmCadAcaoAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oAcaoAcesso) then
  	FreeAndNil(oAcaoAcesso);
end;

procedure TfrmCadAcaoAcesso.FormCreate(Sender: TObject);
begin
  inherited;
  oAcaoAcesso := TAcaoAcesso.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'descricao';
  DesabilitarAtalhoExportar := True;
end;

function TfrmCadAcaoAcesso.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
 if EstadoDoCadastro = ecInserir then
 	Result := oAcaoAcesso.Inserir
 else if EstadoDoCadastro = ecAlterar then
 	Result := oAcaoAcesso.Atualizar;
end;

procedure TfrmCadAcaoAcesso.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   inherited grdListagemDrawColumnCell(Sender, Rect, DataCol, Column, State);

end;

procedure TfrmCadAcaoAcesso.grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  // Aqui, deixamos vazio ou adicionamos outras a��es conforme necess�rio
  // Isso impede que o atalho Ctrl + Shift + E ative o painel de exporta��o
end;


procedure TfrmCadAcaoAcesso.SearchBox1Change(Sender: TObject);
var
  SearchText: string;
begin
  inherited;

  // Obt�m o texto digitado pelo usu�rio
  SearchText := Trim(TSearchBox(Sender).Text);

  // Desabilita a query para ajuste do SQL
  QryListagem.Close;

  // Ajusta o SQL dinamicamente para aplicar o filtro em todos os campos
  if SearchText <> '' then
  begin
    QryListagem.SQL.Text :=
      'SELECT * FROM AcaoAcesso ' +
      'WHERE descricao LIKE :SearchText ' +
      'OR chave LIKE :SearchText ' +
      'OR acaoAcessoId LIKE :SearchText ';


    // Adiciona o par�metro para o texto de pesquisa
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text := 'SELECT * FROM AcaoAcesso';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;
end;

end.
