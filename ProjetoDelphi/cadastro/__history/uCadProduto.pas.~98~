unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, RxCurrEdit, cCadProduto, uEnum, uCadCategoria, System.ImageList, Vcl.ImgList, uRelCadProduto, Vcl.WinXCtrls;

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
    Label4: TLabel;
    Label5: TLabel;
    btnCarregarImagem: TBitBtn;
    btnRemoverImagem: TBitBtn;
    Panel1: TPanel;
    imgProduto: TImage;
    QryListagemimagem: TBlobField;
    panelImagem: TPanel;
    imgProdutoPreview: TImage;
    Label6: TLabel;
    Panel3: TPanel;
    QryCategoria: TZQuery;
    QryCategoriacategoriaId: TIntegerField;
    QryCategoriadescricao: TWideStringField;
    dtsCategoria: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarImagemClick(Sender: TObject);
    procedure btnRemoverImagemClick(Sender: TObject);
    procedure QryListagemAfterScroll(DataSet: TDataSet);
    procedure btnImprimirClick(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
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
  try
    // Seleciona o produto e tenta apagá-lo
    if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
      Result := oProduto.Apagar;
  except
    on E: Exception do
    begin
      // Exibe a mensagem amigável ao usuário
      ShowMessage(E.Message);
      Result := False;
    end;
  end;
end;


function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  oProduto.codigo := StrToIntDef(edtProdutoId.Text, 0);
  oProduto.nome := edtNome.Text;
  oProduto.descricao := edtDescricao.Text;
  oProduto.categoriaId := lkpCategoria.KeyValue;
  oProduto.valor := edtValor.Value;
  oProduto.quantidade := edtQuantidade.Value;

  // Verifica se imgProduto tem uma imagem carregada antes de salvar
  if (imgProduto.Picture <> nil) and (imgProduto.Picture.Graphic <> nil) and
     not imgProduto.Picture.Graphic.Empty then
  begin
    oProduto.imagem.Clear; // Limpa o stream antes de salvar
    imgProduto.Picture.Graphic.SaveToStream(oProduto.imagem);
  end
  else
  begin
    oProduto.imagem.Clear; // Garante que o stream esteja vazio se não houver imagem
  end;

  if EstadoDoCadastro = ecInserir then
    Result := oProduto.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result := oProduto.Atualizar;
end;

procedure TfrmCadProduto.QryListagemAfterScroll(DataSet: TDataSet);
var
  Picture: TPicture;
  ImageStream: TMemoryStream;
begin
  if not QryListagemimagem.IsNull then
  begin
    ImageStream := TMemoryStream.Create;
    Picture := TPicture.Create;
    try
      TBlobField(QryListagemimagem).SaveToStream(ImageStream);
      ImageStream.Position := 0; // Garante que o stream esteja no início
      Picture.LoadFromStream(ImageStream);
      imgProdutoPreview.Picture.Assign(Picture);
      panelImagem.Visible := True; // Mostra o painel com a imagem
    finally
      Picture.Free;
      ImageStream.Free;
    end;
  end
  else
  begin
    imgProdutoPreview.Picture := nil; // Remove a imagem se não houver dados
    panelImagem.Visible := False; // Esconde o painel se não houver imagem
  end;
end;


procedure TfrmCadProduto.SearchBox1Change(Sender: TObject);
var
  SearchText: string;
begin
  inherited;

  // Obtém o texto digitado pelo usuário
  SearchText := Trim(TSearchBox(Sender).Text);

  // Desabilita a query para ajuste do SQL
  QryListagem.Close;

  // Ajusta o SQL dinamicamente para aplicar o filtro em todos os campos
  if SearchText <> '' then
  begin
    QryListagem.SQL.Text :=
      'SELECT * FROM Produtos ' +
      'WHERE nome LIKE :SearchText ' +
      'OR descricaoCategoria LIKE :SearchText ' +
      'OR valor LIKE :SearchText ' +
      'OR quantidade LIKE :SearchText ' +
      'OR produtoId LIKE :SearchText ' +
      'OR categoriaId LIKE :SearchText ';


    // Adiciona o parâmetro para o texto de pesquisa
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text := 'SELECT * FROM Produtos';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;
end;

{$endregion}

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
var
  Picture: TPicture;
begin
  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
  begin
    edtProdutoId.Text := IntToStr(oProduto.codigo);
    edtNome.Text := oProduto.nome;
    edtDescricao.Text := oProduto.descricao;
    lkpCategoria.KeyValue := oProduto.categoriaId;
    edtValor.Value := oProduto.valor;
    edtQuantidade.Value := oProduto.quantidade;

    // Carrega a imagem do TMemoryStream para o TImage
    if oProduto.imagem.Size > 0 then
    begin
      oProduto.imagem.Position := 0; // Garante que o stream esteja no início
      Picture := TPicture.Create;
      try
        Picture.LoadFromStream(oProduto.imagem);
        imgProduto.Picture.Assign(Picture);
      finally
        Picture.Free;
      end;
    end
    else
      imgProduto.Picture := nil; // Remove a imagem se o stream estiver vazio
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


procedure TfrmCadProduto.btnImprimirClick(Sender: TObject);
var
  Relatorio: TfrmRelCadProduto;
begin
  // Cria o formulário do relatório
  Relatorio := TfrmRelCadProduto.Create(nil);
  try
    // Abre a conexão com os dados do cliente
    Relatorio.QryProdutos.Close;
    Relatorio.QryProdutos.Open;

    // Prepara o relatório para impressão
    if Relatorio.Relatorio.Prepare then
    begin
      // Exibe a caixa de diálogo de impressão e imprime o relatório
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
    // Fecha a conexão com os dados e libera o formulário
    Relatorio.QryProdutos.Close;
    Relatorio.Free;
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
  inherited;
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

