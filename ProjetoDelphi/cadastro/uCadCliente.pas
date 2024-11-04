unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uEnum, cCadCliente, uPrincipal, RxToolEdit, System.ImageList, Vcl.ImgList;

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
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
    Result := oCliente.Apagar;
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

  // Busca o valor do campo de status sem exibir o texto
  StatusValue := QryListagem.FieldByName('status').AsString;

  if Column.Index = 0 then // Supondo que a coluna de status seja a primeira
  begin
    // Define o índice do ícone com base no valor do campo Status
    if StatusValue = 'Ativo' then
      IconIndex := 0 // Ícone verde
    else if StatusValue = 'Atenção' then
      IconIndex := 1 // Ícone amarelo
    else if StatusValue = 'Bloqueado' then
      IconIndex := 2 // Ícone vermelho
    else if StatusValue = 'Prospecto' then
      IconIndex := 3 // Ícone azul
    else if StatusValue = 'Inativo' then
      IconIndex := 5 // Ícone preto
    else
      Exit; // Sai se o valor não corresponder a nenhum status

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
    end
    else
    begin
      edtcpfCnpj.Clear;
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

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date := Date;
  edtNome.SetFocus;
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
end;

{$region 'Funções de Formatação'}

procedure TfrmCadCliente.edtcpfCnpjChange(Sender: TObject);
var
  Value: string; // Valor sem máscara
begin
  Value := SomenteNumeros(edtcpfCnpj.Text); // Remove a máscara existente

  // Aplica a máscara conforme o tipo selecionado
  if cbTipoPessoa.Text = 'Física' then
    edtcpfCnpj.Text := MascaraCpf(Value)
  else if cbTipoPessoa.Text = 'Jurídica' then
    edtcpfCnpj.Text := MascaraCnpj(Value);

  edtcpfCnpj.SelStart := Length(edtcpfCnpj.Text); // Ajusta o cursor para o final do texto
end;

procedure TfrmCadCliente.edtcpfCnpjEnter(Sender: TObject);
begin
  // Verifique se o tipo de pessoa está selecionado antes de permitir a edição
  if cbTipoPessoa.ItemIndex = -1 then
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
    1..2: Result := AValue;
    3..5: Result := Format('%s.%s', [Copy(AValue, 1, 2), Copy(AValue, 3, Length(AValue) - 2)]);
    6..8: Result := Format('%s.%s.%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, Length(AValue) - 5)]);
    9..11: Result := Format('%s.%s.%s/%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, 3), Copy(AValue, 9, Length(AValue) - 8)]);
    12..14: Result := Format('%s.%s.%s/%s-%s', [Copy(AValue, 1, 2), Copy(AValue, 3, 3), Copy(AValue, 6, 3), Copy(AValue, 9, 4), Copy(AValue, 13, 2)]);
  end;
end;

procedure TfrmCadCliente.edtTelefoneChange(Sender: TObject);
begin
  edtTelefone.Text := MascaraTelefone(edtTelefone.Text);
  edtTelefone.SelStart := Length(edtTelefone.Text); // Ajusta a posição do cursor
end;

function TfrmCadCliente.MascaraTelefone(const AValue: string): string;
var
  ValorSemMascara: string;
begin
  ValorSemMascara := SomenteNumeros(AValue);

  // Aplica a máscara de acordo com o comprimento do número e o prefixo
  if Copy(ValorSemMascara, 1, 4) = '0300' then
  begin
    if Length(ValorSemMascara) = 11 then
      Result := Format('%s %s %s', [Copy(ValorSemMascara, 1, 4), Copy(ValorSemMascara, 5, 3), Copy(ValorSemMascara, 8, 4)])
    else
      Result := ValorSemMascara; // Sem máscara se o número estiver incompleto
  end
  else
  begin
    case Length(ValorSemMascara) of
      10: // Formato fixo: (14) 3662-9252
        Result := Format('(%s) %s-%s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, 4), Copy(ValorSemMascara, 7, 4)]);

      11: // Formato celular: (14) 98123-8367
        Result := Format('(%s) %s-%s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, 5), Copy(ValorSemMascara, 8, 4)]);

      else
        Result := ValorSemMascara; // Retorna o valor sem formatação se não corresponder a nenhum formato esperado
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

