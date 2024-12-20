unit uCadSubCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, cCadSubCategoria, uDTMConexao, uEnum, Vcl.DBCtrls, System.ImageList, Vcl.ImgList, Vcl.WinXCtrls;

type
  TfrmCadSubCategoria = class(TfrmTelaHeranca)  // Campo de texto para o ID da subcategoria
    edtSubCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;       // Campo de texto para a descri��o da subcategoria
    lcbCategoria: TDBLookupComboBox; // Lookup para selecionar a categoria
    Label1: TLabel;
    QryListagemsubCategoriaId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    QryListagemcategoriaId: TIntegerField;
    QryCategoria: TZQuery;
    QryCategoriacategoriaId: TIntegerField;
    QryCategoriadescricao: TWideStringField;
    dtsCategoria: TDataSource;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
  private
    { Declara��es privadas }
    oSubCategoria: TSubCategoria;  // Objeto da classe TSubCategoria que faz opera��es no banco de dados
    function Apagar: Boolean; override;  // Fun��o para apagar um registro (sobrescrita)
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;  // Fun��o para salvar (sobrescrita)
  public
    { Declara��es p�blicas }
  end;

var
  frmCadSubCategoria: TfrmCadSubCategoria;

implementation

{$R *.dfm}

{$REGION 'Override'}
function TfrmCadSubCategoria.Apagar: Boolean;
begin
  try
    // Seleciona a subcategoria e tenta apagar
    if oSubCategoria.Selecionar(QryListagem.FieldByName('subCategoriaId').AsInteger) then
      Result := oSubCategoria.Apagar;
  except
    on E: Exception do
    begin
      // Exibe a mensagem amig�vel ao usu�rio
      ShowMessage(E.Message);
      Result := False;
    end;
  end;
end;

function TfrmCadSubCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  // Verifica se o campo ID da subcategoria est� preenchido
  if edtSubCategoriaId.Text <> EmptyStr then
    oSubCategoria.codigo := StrToInt(edtSubCategoriaId.Text)
  else
    oSubCategoria.codigo := 0;

  // Atribui os valores dos campos aos atributos do objeto oSubCategoria
  oSubCategoria.descricao := edtDescricao.Text;
  oSubCategoria.categoriaId := lcbCategoria.KeyValue;

  // Verifica o estado do cadastro (inserir ou alterar)
  if EstadoDoCadastro = ecInserir then
    Result := oSubCategoria.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result := oSubCategoria.Atualizar;
end;
{$ENDREGION}

procedure TfrmCadSubCategoria.FormCreate(Sender: TObject);
begin
  inherited;

  // Cria o objeto oSubCategoria
  oSubCategoria := TSubCategoria.Create(dtmPrincipal.ConexaoDB);

  // Configura a query para carregar categorias
  QryCategoria.Connection := dtmPrincipal.ConexaoDB;
  QryCategoria.SQL.Text := 'SELECT categoriaId, descricao FROM categorias';
  QryCategoria.Open;

  // Configura o DataSource do LookupComboBox
  lcbCategoria.ListSource := dtsCategoria;
  lcbCategoria.ListField := 'descricao';
  lcbCategoria.KeyField := 'categoriaId';
  lcbCategoria.DataSource := nil; // Define o DataSource como nulo (Lookup puro)

  // Define o �ndice padr�o para listagem de subcategorias
  IndiceAtual := 'descricao';
end;


procedure TfrmCadSubCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;  // Chama o m�todo herdado da classe base

  // Libera o objeto oSubCategoria da mem�ria
  if Assigned(oSubCategoria) then
    FreeAndNil(oSubCategoria);
end;

procedure TfrmCadSubCategoria.btnAlterarClick(Sender: TObject);
begin
  // Seleciona os dados da subcategoria para edi��o
  if oSubCategoria.Selecionar(QryListagem.FieldByName('subCategoriaId').AsInteger) then
  begin
    edtSubCategoriaId.Text := IntToStr(oSubCategoria.codigo);
    edtDescricao.Text := oSubCategoria.descricao;
    lcbCategoria.KeyValue := oSubCategoria.categoriaId;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadSubCategoria.SearchBox1Change(Sender: TObject);
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
      'SELECT * FROM subCategorias ' +
      'WHERE descricao LIKE :SearchText ' +
      'OR subCategoriaId LIKE :SearchText ' +
      'OR categoriaId LIKE :SearchText';

    // Adiciona o par�metro para o texto de pesquisa
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text := 'SELECT * FROM subCategorias';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;
end;

end.

