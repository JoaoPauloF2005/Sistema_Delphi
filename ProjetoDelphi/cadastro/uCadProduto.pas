unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, RxCurrEdit, cCadProduto, uEnum, uCadCategoria;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    QryListagemprodutoId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdescricao: TWideStringField;
    QryListagemvalor: TFloatField;
    QryListagemquantidade: TFloatField;
    QryListagemcategoriaId: TIntegerField;
    QryListagemDescricaoCategoria: TWideStringField;
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    Label1: TLabel;
    edtValor: TCurrencyEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtQuantidade: TCurrencyEdit;
    lkpCategoria: TDBLookupComboBox;
    QryCategoria: TZQuery;
    QryCategoriacategoriaId: TIntegerField;
    QryCategoriadescricao: TWideStringField;
    dtsCategoria: TDataSource;
    Label4: TLabel;
    imgProduto: TImage;
    btnCarregarImagem: TBitBtn;
    Label5: TLabel;
    btnRemoverImagem: TBitBtn;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarImagemClick(Sender: TObject);
    procedure btnRemoverImagemClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);

  private
    { Private declarations }
    oProduto: TProduto;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

uses uDTMConexao, uPrincipal;

{$region 'Override'}
function TfrmCadProduto.Apagar: Boolean;
begin
  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
    Result := oProduto.Apagar;
end;

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtProdutoId.Text <> EmptyStr then
    oProduto.codigo := StrToInt(edtProdutoId.Text)
  else
    oProduto.codigo := 0;

  oProduto.nome := edtNome.Text;
  oProduto.descricao := edtDescricao.Text;
  oProduto.categoriaId := lkpCategoria.KeyValue;
  oProduto.valor := edtValor.Value;
  oProduto.quantidade := edtQuantidade.Value;

  // Salva a imagem no campo de imagem do objeto
  if not imgProduto.Picture.Graphic.Empty then
  begin
    oProduto.imagem.Clear;
    imgProduto.Picture.Graphic.SaveToStream(oProduto.imagem);
  end
  else
    oProduto.imagem.Clear;

  if EstadoDoCadastro = ecInserir then
    Result := oProduto.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result := oProduto.Atualizar;
end;
procedure TfrmCadProduto.Panel1Click(Sender: TObject);
begin
  inherited;

end;

{$endregion}

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
  begin
    edtProdutoId.Text := IntToStr(oProduto.codigo);
    edtNome.Text := oProduto.nome;
    edtDescricao.Text := oProduto.descricao;
    lkpCategoria.KeyValue := oProduto.categoriaId;
    edtValor.Value := oProduto.valor;
    edtQuantidade.Value := oProduto.quantidade;

    // Carrega a imagem do campo de imagem do objeto
    if oProduto.imagem.Size > 0 then
    begin
      oProduto.imagem.Position := 0;
      imgProduto.Picture.Graphic.LoadFromStream(oProduto.imagem);
    end
    else
      imgProduto.Picture := nil;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadProduto.btnCarregarImagemClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Filter := 'Imagens|*.jpg;*.jpeg;*.png;*.bmp';
    if OpenDialog.Execute then
    begin
      imgProduto.Picture.LoadFromFile(OpenDialog.FileName);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TfrmCadProduto.btnRemoverImagemClick(Sender: TObject);
begin
  imgProduto.Picture := nil; // Remove a imagem do TImage
  oProduto.imagem.Clear; // Limpa o stream de imagem do objeto
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
  imgProduto.Picture := nil; // Limpa a imagem ao iniciar um novo cadastro
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QryCategoria.Close;
  if Assigned(oProduto) then
    FreeAndNil(oProduto);
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);
  edtDescricao.Text := '';
  imgProduto.Picture := nil; // Inicializa sem imagem
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  QryCategoria.Open;
end;

end.

