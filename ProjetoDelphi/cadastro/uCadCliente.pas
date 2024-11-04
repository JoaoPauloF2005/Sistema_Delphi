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
  // Busca o valor do campo de status sem exibir o texto
  StatusValue := QryListagem.FieldByName('status').AsString;

  if Column.Index = 0 then // Supondo que a coluna de status seja a primeira
  begin
    // Define o �ndice do �cone com base no valor do campo Status
    if StatusValue = 'Ativo' then
      IconIndex := 0 // �cone verde
    else if StatusValue = 'Aten��o' then
      IconIndex := 1 // �cone amarelo
    else if StatusValue = 'Bloqueado' then
      IconIndex := 2 // �cone vermelho
    else if StatusValue = 'Prospecto' then
      IconIndex := 3 // �cone azul
    else if StatusValue = 'Inativo' then
      IconIndex := 5 // �cone preto
    else
      Exit; // Sai se o valor n�o corresponder a nenhum status

    // Preenche o fundo da c�lula com a cor padr�o do grid para remover a borda branca

    grdListagem.Canvas.FillRect(Rect);

    // Desenha o �cone no centro da c�lula
    ImageListStatus.Draw(grdListagem.Canvas, Rect.Left + (Rect.Width - ImageListStatus.Width) div 2,
      Rect.Top + (Rect.Height - ImageListStatus.Height) div 2, IconIndex);
  end
  else
  begin
    // Desenha o conte�do padr�o da c�lula nas outras colunas
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

  // Verifica se o cpfCnpj n�o est� vazio antes de aplicar a m�scara
    if oCliente.cpfCnpj <> '' then
    begin
      if oCliente.tipoPessoa = 'F�sica' then
        edtcpfCnpj.Text := MascaraCpf(oCliente.cpfCnpj)
      else if oCliente.tipoPessoa = 'Jur�dica' then
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
    Items.Add('F�sica');
    Items.Add('Jur�dica');
  end;

  cbEstado.Items.AddStrings([
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ]);

  cbStatus.Items.AddStrings([
    'Ativo', 'Bloqueado', 'Aten��o', 'Inativo', 'Prospecto'
  ]);

  edtcpfCnpj.ReadOnly := True; // Bloqueia a edi��o inicialmente

  // Configura a coluna de status sem associar um campo
  grdListagem.Columns[0].Width := ImageListStatus.Width + 4; // Ajusta a largura para caber o �cone
end;

{$region 'Fun��es de Formata��o'}

procedure TfrmCadCliente.edtcpfCnpjChange(Sender: TObject);
var
  Value: string; // Valor sem m�scara
begin
  inherited;

  // Remove a m�scara e limita a 14 d�gitos
  Value := StringReplace(StringReplace(StringReplace(edtcpfCnpj.Text, '.', '', [rfReplaceAll]), '/', '', []), '-', '', []);

  // Limita o n�mero de d�gitos conforme o tipo de pessoa
  if cbTipoPessoa.Text = 'F�sica' then
  begin
    if Length(Value) > 11 then
      Value := Copy(Value, 1, 11);
    edtcpfCnpj.Text := MascaraCpf(Value);

    // Valida o CPF apenas se estiver completo (11 d�gitos)
    if Length(Value) = 11 then
    begin
      if not ValidarCPF(Value) then
        ShowMessage('CPF inv�lido!');
    end

  end
  else if cbTipoPessoa.Text = 'Jur�dica' then
  begin
    if Length(Value) > 14 then
      Value := Copy(Value, 1, 14);
    edtcpfCnpj.Text := MascaraCnpj(Value);

     // Valida o CNPJ apenas se estiver completo (14 d�gitos)
    if Length(Value) = 14 then
    begin
      if not ValidarCNPJ(Value) then
        ShowMessage('CNPJ inv�lido!');
    end;
  end;

  edtcpfCnpj.SelStart := Length(edtcpfCnpj.Text); // Ajusta a posi��o do cursor
end;

procedure TfrmCadCliente.edtcpfCnpjEnter(Sender: TObject);
begin
  if cbTipoPessoa.ItemIndex = -1 then
  begin
    ShowMessage('Por favor, selecione primeiro o Tipo de Pessoa.');
    cbTipoPessoa.SetFocus; // Foco no Tipo de Pessoa
  end;
end;

procedure TfrmCadCliente.cbTipoPessoaChange(Sender: TObject);
begin
  edtcpfCnpj.ReadOnly := cbTipoPessoa.ItemIndex = -1; // Bloqueia ou permite edi��o
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

   // Verifica se o CPF possui exatamente 11 d�gitos e se n�o � uma sequ�ncia repetida
  if (Length(Numero) <> 11) or (Numero = StringOfChar(Numero[1], 11)) then
    Exit;

  // Calcula o primeiro d�gito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(Numero[I]) * (11 - I);
  Resto := (Soma * 10) mod 11;
  if (Resto =  10) then
    Digito1 := 0
  else
    Digito1 := Resto;

  // Calcula o segundo d�gito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(Numero[I]) * (12 - I);
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) then
    Digito2 := 0
  else
    Digito2 := Resto;

  // Verifica se os d�gitos calculados correspondem aos d�gitos informados
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
  Numero := SomenteNumeros(CNPJ); // Remove caracteres n�o num�ricos

  // Verifica se o CNPJ possui exatamente 14 d�gitos e se n�o � uma sequ�ncia repetida
  if (Length(Numero) <> 14) or (Numero = StringOfChar(Numero[1], 14)) then
    Exit;

  // Calcula o primeiro d�gito verificador
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + StrToInt(Numero[I]) * Peso1[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  // Calcula o segundo d�gito verificador
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + StrToInt(Numero[I]) * Peso2[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  // Verifica se os d�gitos calculados correspondem aos d�gitos informados
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
  edtTelefone.SelStart := Length(edtTelefone.Text); // Ajusta a posi��o do cursor
end;

function TfrmCadCliente.MascaraTelefone(const AValue: string): string;
var
  ValorSemMascara: string;
begin
  ValorSemMascara := SomenteNumeros(AValue);

  case Length(ValorSemMascara) of
    10: // Formato fixo: (14) 3662-9252
      Result := Format('(%s) %s-%s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, 4), Copy(ValorSemMascara, 7, 4)]);

    11: // Formato celular: (14) 98123-8367
      Result := Format('(%s) %s-%s', [Copy(ValorSemMascara, 1, 2), Copy(ValorSemMascara, 3, 5), Copy(ValorSemMascara, 8, 4)]);

    12: // Formato 0300: 0300 123 4566
      Result := Format('%s %s %s', [Copy(ValorSemMascara, 1, 4), Copy(ValorSemMascara, 5, 3), Copy(ValorSemMascara, 8, 4)]);

    else
      Result := AValue; // Retorna sem formata��o caso n�o corresponda a nenhum formato esperado
  end;
end;

function TfrmCadCliente.SomenteNumeros(const AValue: string): string;
var
  I: Integer;
begin
  Result := ''; // Inicializa a string de resultado como vazia

  // Percorre cada caractere da string
  for I := 1 to Length(AValue) do
  begin
    // Verifica se o caractere � num�rico e adiciona ao resultado
    if CharInSet(AValue[I], ['0'..'9']) then
      Result := Result + AValue[I];
  end;
end;
{$ENDREGION}
end.

