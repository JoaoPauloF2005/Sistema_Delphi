﻿unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uEnum, cCadCliente, uPrincipal, RxToolEdit, System.ImageList, Vcl.ImgList, Vcl.Clipbrd, uRelCadCliente, Printers,
  Vcl.WinXCtrls, uReceitaCNPJ, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, System.JSON, IdSSLOpenSSL,
  IdAuthentication;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCEP: TMaskEdit;
    edtDataNascimento: TDateEdit;
    cbEstado: TComboBox;
    edtBairro: TLabeledEdit;
    edtcpfCnpj: TLabeledEdit;
    cbTipoPessoa: TComboBox;
    edtTelefone: TLabeledEdit;
    cbStatus: TComboBox;
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemtipoPessoa: TWideStringField;
    QryListagemcpfCnpj: TWideStringField;
    QryListagemendereco: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemestado: TWideStringField;
    QryListagemcep: TWideStringField;
    QryListagemtelefone: TWideStringField;
    QryListagememail: TWideStringField;
    QryListagemdataNascimento: TDateTimeField;
    QryListagemstatus: TWideStringField;
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    Image2: TImage;
    Label5: TLabel;
    Image3: TImage;
    Label6: TLabel;
    Image4: TImage;
    Label7: TLabel;
    Image5: TImage;
    Label8: TLabel;
    ImageListStatus: TImageList;
    btnBuscarCNPJ: TButton;
    pnlPesquisarCNPJ: TPanel;
    edtCNPJPesquisa: TLabeledEdit;
    btnConfirmarCNPJ: TBitBtn;
    IdHTTP1: TIdHTTP;

    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edtcpfCnpjChange(Sender: TObject);
    procedure cbTipoPessoaChange(Sender: TObject);
    procedure edtcpfCnpjEnter(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure QryListagemcpfCnpjGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure btnBuscarCNPJClick(Sender: TObject);
    procedure btnConfirmarCNPJClick(Sender: TObject);
    procedure IdHTTP1Authorization(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean);
    procedure edtCNPJPesquisaChange(Sender: TObject);

  private
    oCliente: TCliente;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function MascaraCnpj(const AValue: string): string;
    function MascaraCpf(const AValue: string): string;
    function SomenteNumeros(const AValue: string): string;
    function MascaraTelefone(const AValue: string): string;
    function ValidarCPF(const CPF: string): Boolean;
    function ValidarCNPJ(const CNPJ: string): Boolean;
     procedure PreencherCamposCliente(ReceitaCNPJ: TfrmReceitaCNPJ);
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uDTMConexao;

{ TfrmCadCliente }

{$region 'Override'}
function TfrmCadCliente.Apagar: Boolean;
begin
  try
    if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
      Result := oCliente.Apagar;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message); // Exibe a mensagem simplificada gerada no método Apagar
      Result := False;
    end;
  end;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  oCliente.codigo := StrToIntDef(edtClienteId.Text, 0);
  oCliente.nome := edtNome.Text;
  oCliente.status := cbStatus.Text;
  oCliente.tipoPessoa := cbTipoPessoa.Text;
  oCliente.cpfCnpj := SomenteNumeros(edtcpfCnpj.Text);
  oCliente.cep := edtCEP.Text;
  oCliente.endereco := edtEndereco.Text;
  oCliente.bairro := edtBairro.Text;
  oCliente.cidade := edtCidade.Text;
  oCliente.telefone := edtTelefone.Text;
  oCliente.email := edtEmail.Text;
  oCliente.estado := cbEstado.Text;
  oCliente.dataNascimento := edtDataNascimento.Date;

  // Validação de CPF ou CNPJ
  if oCliente.tipoPessoa = 'Física' then
  begin
    if not ValidarCPF(oCliente.cpfCnpj) then
    begin
      ShowMessage('CPF inválido. Por favor, verifique o número.');
      Result := False;
      Exit;
    end;
  end
  else if oCliente.tipoPessoa = 'Jurídica' then
  begin
    if not ValidarCNPJ(oCliente.cpfCnpj) then
    begin
      ShowMessage('CNPJ inválido. Por favor, verifique o número.');
      Result := False;
      Exit;
    end;
  end;

  // Procede com a inserção ou atualização se a validação passar
  case EstadoDoCadastro of
    ecInserir: Result := oCliente.Inserir;
    ecAlterar: Result := oCliente.Atualizar;
  end;
end;

procedure TfrmCadCliente.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  IconIndex: Integer;
  StatusValue: string;
begin
  // Chama o método herdado da tela de herança para garantir que as alterações sejam aplicadas
  inherited grdListagemDrawColumnCell(Sender, Rect, DataCol, Column, State);

  // Verifica se a coluna atual está associada ao campo de status
  if Column.Field = QryListagemstatus then
  begin
    // Obtém o valor do campo de status
    StatusValue := QryListagem.FieldByName('status').AsString;

    // Define o índice do ícone com base no valor do campo de status
    if StatusValue = 'Ativo' then
      IconIndex := 0 // Ícone verde
    else if StatusValue = 'Atenção' then
      IconIndex := 1 // Ícone amarelo
    else if StatusValue = 'Bloqueado' then
      IconIndex := 2 // Ícone vermelho
    else if StatusValue = 'Prospecto' then
      IconIndex := 3 // Ícone azul
    else if StatusValue = 'Inativo' then
      IconIndex := 4 // Ícone preto
    else
      Exit; // Sai se o valor não corresponder a nenhum status

    // Preenche o fundo da célula
    grdListagem.Canvas.FillRect(Rect);

    // Desenha o ícone no centro da célula
    ImageListStatus.Draw(grdListagem.Canvas, Rect.Left + (Rect.Width - ImageListStatus.Width) div 2,
      Rect.Top + (Rect.Height - ImageListStatus.Height) div 2, IconIndex);
  end
  else
  begin
    // Desenha o conteúdo padrão da célula nas outras colunas
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmCadCliente.IdHTTP1Authorization(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean);
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    // Configura o SSL para usar TLS 1.2
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];

    HTTP.IOHandler := SSLHandler;
    HTTP.Request.ContentType := 'application/json';

    // Faz a requisição
    ShowMessage(HTTP.Get('https://www.receitaws.com.br/v1/cnpj/12345678000195'));

  finally
    HTTP.Free;
    SSLHandler.Free;
  end;
end;

{$endregion}

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
  begin
    edtClienteId.Text := IntToStr(oCliente.codigo);
    edtNome.Text := oCliente.nome;
    cbStatus.Text := oCliente.status;
    cbTipoPessoa.Text := oCliente.tipoPessoa;

    // Verifica se o cpfCnpj não está vazio antes de aplicar a máscara
    if oCliente.cpfCnpj <> '' then
    begin
      if oCliente.tipoPessoa = 'Física' then
        edtcpfCnpj.Text := MascaraCpf(oCliente.cpfCnpj)
      else if oCliente.tipoPessoa = 'Jurídica' then
        edtcpfCnpj.Text := MascaraCnpj(oCliente.cpfCnpj);
    end;

    edtCEP.Text := oCliente.cep;
    edtEndereco.Text := oCliente.endereco;
    edtBairro.Text := oCliente.bairro;
    edtCidade.Text := oCliente.cidade;
    edtTelefone.Text := oCliente.telefone;
    edtEmail.Text := oCliente.email;
    cbEstado.Text := oCliente.estado;
    edtDataNascimento.Date := oCliente.dataNascimento;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadCliente.btnBuscarCNPJClick(Sender: TObject);
begin
  // Exibe o painel para digitar o CNPJ
  pnlPesquisarCNPJ.Visible := True;
  edtCNPJPesquisa.SetFocus;
end;

procedure TfrmCadCliente.btnConfirmarCNPJClick(Sender: TObject);
var
  frmReceitaCNPJ: TfrmReceitaCNPJ;
  JSONResponse: string;
  JSONObj: TJSONObject;
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  CNPJ: string;
begin
  // Obtém o CNPJ digitado e remove caracteres não numéricos
  CNPJ := SomenteNumeros(edtCNPJPesquisa.Text);

  // Valida o CNPJ antes de prosseguir
  if not ValidarCNPJ(CNPJ) then
  begin
    ShowMessage('CNPJ inválido! Por favor, digite um número válido.');
    edtCNPJPesquisa.SetFocus;
    Exit;
  end;
  // Configura o HTTP e SSL Handler para a API
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    HTTP.IOHandler := SSLHandler;
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];

    try
      // Realiza a requisição à API
      JSONResponse := HTTP.Get('https://www.receitaws.com.br/v1/cnpj/' + Trim(SomenteNumeros(edtCNPJPesquisa.Text)));
      JSONObj := TJSONObject.ParseJSONValue(JSONResponse) as TJSONObject;

      if Assigned(JSONObj) then
      begin
        // Cria o formulário uReceitaCNPJ e preenche os campos com os dados retornados
        frmReceitaCNPJ := TfrmReceitaCNPJ.Create(Self);
        try
          frmReceitaCNPJ.PreencherCampos(JSONObj); // Método no uReceitaCNPJ
          if frmReceitaCNPJ.ShowModal = mrOk then
          begin
            // Transfere os dados do uReceitaCNPJ para os campos do cliente
            edtNome.Text := frmReceitaCNPJ.edtNome.Caption;
            edtcpfCnpj.Text := frmReceitaCNPJ.edtCnpj.Caption;
            edtEndereco.Text := frmReceitaCNPJ.edtEndereco.Caption;
            edtBairro.Text := frmReceitaCNPJ.edtBairro.Caption;
            edtCidade.Text := frmReceitaCNPJ.edtCidade.Caption;
            cbEstado.Text := frmReceitaCNPJ.edtEstado.Caption;
            edtCEP.Text := frmReceitaCNPJ.edtCep.Caption;
            edtTelefone.Text := frmReceitaCNPJ.edtTelefone.Caption;
            cbTipoPessoa.ItemIndex := cbTipoPessoa.Items.IndexOf('Jurídica');
          end;
        finally
          frmReceitaCNPJ.Free; // Libera o formulário após o uso
          pnlPesquisarCNPJ.Visible := False;
        end;
      end
      else
        ShowMessage('Erro ao processar os dados retornados da API.');
    except
      on E: Exception do
        ShowMessage('Erro ao acessar a API: ' + E.Message);
    end;
  finally
    HTTP.Free;
    SSLHandler.Free;

  end;
end;

procedure TfrmCadCliente.PreencherCamposCliente(ReceitaCNPJ: TfrmReceitaCNPJ);
begin
  edtNome.Text := ReceitaCNPJ.edtNome.Caption;
  edtEndereco.Text := ReceitaCNPJ.edtEndereco.Caption;
  edtBairro.Text := ReceitaCNPJ.edtBairro.Caption;
  edtCidade.Text := ReceitaCNPJ.edtCidade.Caption;
  cbEstado.Text := ReceitaCNPJ.edtEstado.Caption;
  edtCEP.Text := ReceitaCNPJ.edtCEP.Caption;
  edtTelefone.Text := MascaraTelefone(ReceitaCNPJ.edtTelefone.Caption);
  cbTipoPessoa.ItemIndex := cbTipoPessoa.Items.IndexOf('Jurídica');
end;

procedure TfrmCadCliente.btnImprimirClick(Sender: TObject);
var
  Relatorio: TfrmRelCadCliente;
begin
  // Cria o formulário do relatório
  Relatorio := TfrmRelCadCliente.Create(nil);
  try
    // Abre a consulta com os dados do cliente
    Relatorio.QryCliente.Close;
    Relatorio.QryCliente.Open;

    // Prepara o relatório para exibição e impressão
    if Relatorio.Relatorio.Prepare then
    begin
      // Exibe o relatório diretamente na pré-visualização
      Relatorio.Relatorio.Preview;

      // Abre a caixa de diálogo de impressão imediatamente após o relatório ser carregado
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
    // Fecha a conexão com os dados e libera o formulário do relatório
    Relatorio.QryCliente.Close;
    Relatorio.Free;
  end;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date := Date;
  cbStatus.SetFocus;
  cbTipoPessoa.ItemIndex := -1;
  cbStatus.ItemIndex := -1;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(dtmPrincipal.ConexaoDB);

  // Inicializa ComboBoxes
  with cbTipoPessoa do
  begin
    Items.Add('Física');
    Items.Add('Jurídica');
  end;

  cbEstado.Items.AddStrings([
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ]);

  cbStatus.Items.AddStrings([
    'Ativo', 'Bloqueado', 'Atenção', 'Inativo', 'Prospecto'
  ]);

  edtcpfCnpj.ReadOnly := True; // Bloqueia a edição inicialmente

  // Configura a coluna de status sem associar um campo
  grdListagem.Columns[0].Width := ImageListStatus.Width + 4; // Ajusta a largura para caber o ícone

  grdListagem.Columns[0].Title.Caption := ''; // Define o título como vazio
end;

{$region 'Funções de Formatação'}

procedure TfrmCadCliente.edtCNPJPesquisaChange(Sender: TObject);
var
  CNPJ: string;
begin
  // Remove caracteres não numéricos e aplica a máscara
  CNPJ := SomenteNumeros(edtCNPJPesquisa.Text);
  edtCNPJPesquisa.Text := MascaraCnpj(CNPJ);

  // Reposiciona o cursor no final do texto
  edtCNPJPesquisa.SelStart := Length(edtCNPJPesquisa.Text);

  // Valida o CNPJ quando atingir o comprimento completo
  if Length(CNPJ) = 14 then
  begin
    if not ValidarCNPJ(CNPJ) then
    begin
      ShowMessage('CNPJ inválido! Verifique o número digitado.');
      edtCNPJPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadCliente.edtcpfCnpjChange(Sender: TObject);
var
  Value: string;
begin
  // Obtém apenas os números do campo
  Value := SomenteNumeros(edtcpfCnpj.Text);

  // Limita e aplica a máscara com base no tipo de pessoa
  if cbTipoPessoa.Text = 'Física' then
  begin
    // Limita a 11 dígitos e aplica máscara de CPF
    if Length(Value) > 11 then
      Value := Copy(Value, 1, 11);

    edtcpfCnpj.Text := MascaraCpf(Value);

    // Validação de CPF quando o valor está completo
    if Length(Value) = 11 then
    begin
      if not ValidarCPF(Value) then
        ShowMessage('CPF inválido! Por favor, verifique o número.');
    end;
  end
  else if cbTipoPessoa.Text = 'Jurídica' then
  begin
    // Limita a 14 dígitos e aplica máscara de CNPJ
    if Length(Value) > 14 then
      Value := Copy(Value, 1, 14);

    edtcpfCnpj.Text := MascaraCnpj(Value);

    // Validação de CNPJ quando o valor está completo
    if Length(Value) = 14 then
    begin
      if not ValidarCNPJ(Value) then
        ShowMessage('CNPJ inválido! Por favor, verifique o número.');
    end;
  end;

  // Posiciona o cursor no final do texto após aplicar a máscara
  edtcpfCnpj.SelStart := Length(edtcpfCnpj.Text);
end;

procedure TfrmCadCliente.edtcpfCnpjEnter(Sender: TObject);
begin
  // Verifica se o tipo de pessoa não está selecionado (vazio)
  if cbTipoPessoa.Text = '' then
  begin
    ShowMessage('Por favor, selecione primeiro o Tipo de Pessoa.');
    cbTipoPessoa.SetFocus;
  end
  else
  begin
    edtcpfCnpj.ReadOnly := False; // Permite edição caso o tipo de pessoa esteja selecionado
  end;
end;

procedure TfrmCadCliente.cbTipoPessoaChange(Sender: TObject);
begin
  edtcpfCnpj.ReadOnly := cbTipoPessoa.ItemIndex = -1; // Bloqueia ou permite edição
  if edtcpfCnpj.ReadOnly then
    edtcpfCnpj.Clear; // Limpa o campo se estiver bloqueado
end;

function TfrmCadCliente.MascaraCpf(const AValue: string): string;
begin
  case Length(AValue) of
    1..3: Result := AValue;
    4..6: Result := Format('%s.%s', [Copy(AValue, 1, 3), Copy(AValue, 4, Length(AValue) - 3)]);
    7..9: Result := Format('%s.%s.%s', [Copy(AValue, 1, 3), Copy(AValue, 4, 3), Copy(AValue, 7, Length(AValue) - 6)]);
    10..11: Result := Format('%s.%s.%s-%s', [Copy(AValue, 1, 3), Copy(AValue, 4, 3), Copy(AValue, 7, 3), Copy(AValue, 10, 2)]);
  end;
end;

function TfrmCadCliente.ValidarCPF(const CPF: string): Boolean;
var
  I, Soma, Resto, Digito1, Digito2: Integer;
  Numero: string;
begin
  Result := False;
  Numero := SomenteNumeros(CPF);

   // Verifica se o CPF possui exatamente 11 dígitos e se não é uma sequência repetida
  if (Length(Numero) <> 11) or (Numero = StringOfChar(Numero[1], 11)) then
    Exit;

  // Calcula o primeiro dígito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(Numero[I]) * (11 - I);
  Resto := (Soma * 10) mod 11;
  if (Resto =  10) then
    Digito1 := 0
  else
    Digito1 := Resto;

  // Calcula o segundo dígito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(Numero[I]) * (12 - I);
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) then
    Digito2 := 0
  else
    Digito2 := Resto;

  // Verifica se os dígitos calculados correspondem aos dígitos informados
  Result := (Digito1 = StrToInt(Numero[10])) and (Digito2 = StrToInt(Numero[11]));
end;

function TfrmCadCliente.ValidarCNPJ(const CNPJ: string): Boolean;
var
  I, Soma, Resto, Digito1, Digito2: Integer;
  Numero: string;
const
  Peso1: array[1..12] of Integer = (5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  Peso2: array[1..13] of Integer = (6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
begin
  Result := False;
  Numero := SomenteNumeros(CNPJ); // Remove caracteres não numéricos

  // Verifica se o CNPJ possui exatamente 14 dígitos e se não é uma sequência repetida
  if (Length(Numero) <> 14) or (Numero = StringOfChar(Numero[1], 14)) then
    Exit;

  // Calcula o primeiro dígito verificador
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + StrToInt(Numero[I]) * Peso1[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  // Calcula o segundo dígito verificador
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + StrToInt(Numero[I]) * Peso2[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  // Verifica se os dígitos calculados correspondem aos dígitos informados
  Result := (Digito1 = StrToInt(Numero[13])) and (Digito2 = StrToInt(Numero[14]));
end;

function TfrmCadCliente.MascaraCnpj(const AValue: string): string;
begin
  case Length(AValue) of
    1..2:
      Result := AValue;
    3..5:
      Result := Format('%s.%s', [Copy(AValue, 1, 2), Copy(AValue, 3, Length(AValue) - 2)]);
    6..8:
      Result := Format('%s.%s.%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, Length(AValue) - 5)]);
    9..11:
      Result := Format('%s.%s.%s/%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, 3), Copy(AValue, 9, Length(AValue) - 8)]);
    12:
      Result := Format('%s.%s.%s/%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, 3), Copy(AValue, 9, 4)]);
    13:
      Result := Format('%s.%s.%s/%s-%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, 3), Copy(AValue, 9, 4), Copy(AValue, 13, 1)]);
    14:
      Result := Format('%s.%s.%s/%s-%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, 3), Copy(AValue, 9, 4), Copy(AValue, 13, 2)]);
  end;
end;

procedure TfrmCadCliente.edtTelefoneChange(Sender: TObject);
begin
  // Aplica a máscara ao texto do campo de telefone
  edtTelefone.Text := MascaraTelefone(edtTelefone.Text);

  // Reposiciona o cursor no final do texto após aplicar a máscara
  edtTelefone.SelStart := Length(edtTelefone.Text);
end;

function TfrmCadCliente.MascaraTelefone(const AValue: string): string;
var
  ValorSemMascara: string;
begin
  ValorSemMascara := SomenteNumeros(AValue);

  // Limita o número de dígitos conforme o tipo de telefone
  if (Length(ValorSemMascara) >= 4) and (Copy(ValorSemMascara, 3, 2) = '00') then
  begin
    // Máscara para número comercial (ex.: 0300 123 4567 ou 0800 123 4567)
    if Length(ValorSemMascara) > 11 then
      ValorSemMascara := Copy(ValorSemMascara, 1, 11);
    if Length(ValorSemMascara) >= 8 then
      Result := Format('%s %s %s', [Copy(ValorSemMascara, 1, 4), Copy(ValorSemMascara, 5, 3), Copy(ValorSemMascara, 8, 4)])
    else if Length(ValorSemMascara) >= 5 then
      Result := Format('%s %s', [Copy(ValorSemMascara, 1, 4), Copy(ValorSemMascara, 5, Length(ValorSemMascara) - 4)])
    else
      Result := ValorSemMascara;
  end
  else
  begin
    // Limita a 11 dígitos para números de telefone fixo e celular
    if Length(ValorSemMascara) > 11 then
      ValorSemMascara := Copy(ValorSemMascara, 1, 11);

    // Aplica a máscara de acordo com o comprimento do número
    case Length(ValorSemMascara) of
      1..2:
        Result := Format('(%s', [ValorSemMascara]);
      3..6:
        Result := Format('(%s) %s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, Length(ValorSemMascara) - 2)]);
      7..10: // Telefone fixo: (99) 1234-5678
        Result := Format('(%s) %s-%s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, 4), Copy(ValorSemMascara, 7, Length(ValorSemMascara) - 6)]);
      11: // Celular: (99) 91234-5678
        Result := Format('(%s) %s-%s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, 5), Copy(ValorSemMascara, 8, 4)]);
      else
        Result := ValorSemMascara; // Retorna sem máscara se o formato for diferente
    end;
  end;
end;

procedure TfrmCadCliente.QryListagemcpfCnpjGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString <> '' then
  begin
    // Aplica a máscara conforme o tipo de pessoa na grid
    if QryListagemtipoPessoa.AsString = 'Física' then
      Text := MascaraCpf(Sender.AsString)
    else if QryListagemtipoPessoa.AsString = 'Jurídica' then
      Text := MascaraCnpj(Sender.AsString)
    else
      Text := Sender.AsString;
  end
  else
    Text := ''; // Deixa vazio se não houver valor
end;

procedure TfrmCadCliente.SearchBox1Change(Sender: TObject);
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
      'SELECT * FROM Clientes ' +
      'WHERE nome LIKE :SearchText ' +
      'OR clienteId LIKE :SearchText ' +
      'OR tipoPessoa LIKE :SearchText ' +
      'OR cpfCnpj LIKE :SearchText ' +
      'OR endereco LIKE :SearchText ' +
      'OR cidade LIKE :SearchText ' +
      'OR bairro LIKE :SearchText ' +
      'OR estado LIKE :SearchText ' +
      'OR cep LIKE :SearchText ' +
      'OR telefone LIKE :SearchText ' +
      'OR email LIKE :SearchText ' +
      'OR status LIKE :SearchText';

    // Adiciona o parâmetro para o texto de pesquisa
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text := 'SELECT * FROM Clientes';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;
end;

function TfrmCadCliente.SomenteNumeros(const AValue: string): string;
var
  I: Integer;
begin
  Result := ''; // Inicializa a string de resultado como vazia

  // Percorre cada caractere da string
  for I := 1 to Length(AValue) do
  begin
    // Verifica se o caractere é numérico e adiciona ao resultado
    if CharInSet(AValue[I], ['0'..'9']) then
      Result := Result + AValue[I];
  end;
end;
{$ENDREGION}
end.
