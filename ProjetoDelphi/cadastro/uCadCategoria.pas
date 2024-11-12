unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, cCadCategoria, uDTMConexao, uEnum, Vcl.DBCtrls, System.ImageList, Vcl.ImgList, uRelCategoria;

type
  // Declara��o do formul�rio TfrmCadCategoria, que herda de TfrmTelaHeranca
  TfrmCadCategoria = class(TfrmTelaHeranca)
    // Campos do banco de dados vinculados � query
    intgrfldQryListagemcategoriaId : TIntegerField;  // Campo para o ID da categoria
    wdstrngfldQryListagemdescricao : TWideStringField;  // Campo para a descri��o da categoria
    edtCategoriaId : TLabeledEdit;  // Campo de texto para o ID da categoria
    edtDescricao : TLabeledEdit;    // Campo de texto para a descri��o da categoria
    // Eventos do formul�rio
    procedure FormCreate(Sender : TObject);  // Evento ao criar o formul�rio
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure btnAlterarClick(Sender : TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnImprimirClick(Sender: TObject);

  private
    { Declara��es privadas }
    oCategoria : TCategoria;  // Objeto da classe TCategoria que faz opera��es no banco de dados
    function Apagar : Boolean; override;  // Fun��o para apagar um registro (sobrescrita)
    function Gravar(EstadoDoCadastro : TEstadoDoCadastro): Boolean; override;  // Fun��o para salvar (sobrescrita)
  public
    { Declara��es p�blicas }
  end;

var
  frmCadCategoria : TfrmCadCategoria;

implementation

{$R *.dfm}

{$REGION 'Override'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  if oCategoria.Selecionar(QryListagem.FieldByName('categoriaId').AsInteger) then begin
  Result:=oCategoria.Apagar;
  end;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  // Verifica se o campo ID da categoria est� preenchido
  if edtCategoriaId.Text <> EmptyStr then
    // Se estiver preenchido, converte o valor para inteiro e atribui ao c�digo da categoria
    oCategoria.codigo := StrToInt(edtCategoriaId.Text)
  else
    // Se estiver vazio, define o c�digo como 0 (novo registro)
    oCategoria.codigo := 0;

  // Atribui o valor do campo de descri��o ao objeto oCategoria
  oCategoria.descricao := edtDescricao.Text;

  // Verifica o estado do cadastro (inserir ou alterar)
  if (EstadoDoCadastro = ecInserir) then
    Result := oCategoria.Inserir  // Se for para inserir, chama o m�todo Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCategoria.Atualizar;  // Se for para alterar, chama o m�todo Atualizar
end;
procedure TfrmCadCategoria.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

end;

{$ENDREGION}

procedure TfrmCadCategoria.btnAlterarClick(Sender : TObject);
begin
  if oCategoria.Selecionar(QryListagem.FieldByName('categoriaId').AsInteger) then begin
    edtCategoriaId.Text := IntToStr(oCategoria.codigo);
    edtDescricao.Text := oCategoria.descricao;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
    inherited;

end;



procedure TfrmCadCategoria.btnImprimirClick(Sender: TObject);
var
  Relatorio: TfrmRelCadCategoria;
begin
  // Cria o formul�rio do relat�rio
  Relatorio := TfrmRelCadCategoria.Create(nil);
  try
    // Abre a conex�o com os dados do cliente
    Relatorio.QryCategorias.Open;

    // Prepara o relat�rio para impress�o
    if Relatorio.Relatorio.Prepare then
    begin
      // Exibe a caixa de di�logo de impress�o e imprime o relat�rio
      Relatorio.Relatorio.Print;
    end
    else
    begin
      ShowMessage('Falha ao preparar o relat�rio.');
    end;

  finally
    // Fecha a conex�o com os dados e libera o formul�rio
    Relatorio.QryCategorias.Close;
    Relatorio.Free;
  end;

end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action : TCloseAction);
begin
  inherited;  // Chama o m�todo herdado da classe base

  // Verifica se o objeto oCategoria foi criado
  if Assigned(oCategoria) then
    // Libera o objeto da mem�ria
    FreeAndNil(oCategoria);
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;  // Chama o m�todo herdado da classe base

  // Cria o objeto oCategoria e passa a conex�o com o banco de dados
  oCategoria := TCategoria.Create(dtmPrincipal.ConexaoDB);

  // Define o �ndice padr�o para listar categorias (baseado na descri��o)
  IndiceAtual := 'descricao';
end;

end.

