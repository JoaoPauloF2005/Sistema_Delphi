unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uEnum, cCadCliente, uPrincipal, RxToolEdit;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCEP: TMaskEdit;
    Label1: TLabel;
    edtTelefone: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtDataNascimento: TDateEdit;
    edtEstado: TComboBox;
    edtBairro: TLabeledEdit;
    Label4: TLabel;
    edtcpfCnpj: TLabeledEdit;
    edttipoPessoa: TComboBox;
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
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure edtcpfCnpjChange(Sender: TObject);

  private
    { Private declarations }
    oCliente:TCliente;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function MascaraCpfCnpj(const AValue: string): string; // Adicione aqui

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
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then begin
     Result:=oCliente.Apagar;
  end;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtClienteId.Text<>EmptyStr then
     oCliente.codigo:=StrToInt(edtClienteId.Text)
  else
     oCliente.codigo:=0;

  oCliente.nome           :=edtNome.Text;
  oCliente.tipoPessoa     :=edttipoPessoa.Text;
  oCliente.cpfCnpj        :=edtcpfCnpj.Text;
  oCliente.cep            :=edtCEP.Text;
  oCliente.endereco       :=edtEndereco.Text;
  oCliente.bairro         :=edtBairro.Text;
  oCliente.cidade         :=edtCidade.Text;
  oCliente.telefone       :=edtTelefone.Text;
  oCliente.email          :=edtEmail.Text;
  oCliente.estado					:=edtEstado.Text;
  oCliente.dataNascimento :=edtDataNascimento.Date;

  if (EstadoDoCadastro=ecInserir) then
     Result:=oCliente.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
     Result:=oCliente.Atualizar;
end;
{$endregion}

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then begin
     edtClienteId.Text := IntToStr(oCliente.codigo);
     edtNome.Text     := oCliente.nome;
     edtTipoPessoa.Text := oCliente.tipoPessoa;
     edtcpfCnpj.Text  := oCliente.cpfCnpj;
     edtCEP.Text      := oCliente.cep;
     edtEndereco.Text := oCliente.endereco;
     edtBairro.Text   := oCliente.bairro;
     edtCidade.Text   := oCliente.cidade;
     edtTelefone.Text := oCliente.telefone;
     edtEmail.Text    := oCliente.email;
     edtEstado.Text		:= oCliente.estado;
		 edtDataNascimento.Date := oCliente.dataNascimento;

  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;


procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date:=Date;
  edtNome.SetFocus;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
     FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente:=TCliente.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual:='nome';

  edtTipoPessoa.Items.Add('F�sica');
  edtTipoPessoa.Items.Add('Jur�dica');


    // Adicionando as siglas dos estados ao ComboBox
  edtEstado.Items.Add('AC'); // Acre
  edtEstado.Items.Add('AL'); // Alagoas
  edtEstado.Items.Add('AP'); // Amap�
  edtEstado.Items.Add('AM'); // Amazonas
  edtEstado.Items.Add('BA'); // Bahia
  edtEstado.Items.Add('CE'); // Cear�
  edtEstado.Items.Add('DF'); // Distrito Federal
  edtEstado.Items.Add('ES'); // Esp�rito Santo
  edtEstado.Items.Add('GO'); // Goi�s
  edtEstado.Items.Add('MA'); // Maranh�o
  edtEstado.Items.Add('MT'); // Mato Grosso
  edtEstado.Items.Add('MS'); // Mato Grosso do Sul
  edtEstado.Items.Add('MG'); // Minas Gerais
  edtEstado.Items.Add('PA'); // Par�
  edtEstado.Items.Add('PB'); // Para�ba
  edtEstado.Items.Add('PR'); // Paran�
  edtEstado.Items.Add('PE'); // Pernambuco
  edtEstado.Items.Add('PI'); // Piau�
  edtEstado.Items.Add('RJ'); // Rio de Janeiro
  edtEstado.Items.Add('RN'); // Rio Grande do Norte
  edtEstado.Items.Add('RS'); // Rio Grande do Sul
  edtEstado.Items.Add('RO'); // Rond�nia
  edtEstado.Items.Add('RR'); // Roraima
  edtEstado.Items.Add('SC'); // Santa Catarina
  edtEstado.Items.Add('SP'); // S�o Paulo
  edtEstado.Items.Add('SE'); // Sergipe
  edtEstado.Items.Add('TO'); // Tocantins

  // Define o ComboBox como DropDownList para impedir edi��o
  edtEstado.Style := csDropDownList;

end;

procedure TfrmCadCliente.edtcpfCnpjChange(Sender: TObject);
var
  Value: string; // Valor sem m�scara
  OldLength: Integer; // Comprimento do texto antes da m�scara
  CursorPos: Integer; // Posi��o do cursor
begin
  // Remove a m�scara temporariamente
  Value := StringReplace(edtcpfCnpj.Text, '.', '', [rfReplaceAll]);
  Value := StringReplace(Value, '/', '', [rfReplaceAll]);
  Value := StringReplace(Value, '-', '', [rfReplaceAll]);

  // Limita a entrada a 14 d�gitos
  if Length(Value) > 14 then
    Value := Copy(Value, 1, 14);

  // Armazena a posi��o atual do cursor e o comprimento do texto
  CursorPos := edtcpfCnpj.SelStart;
  OldLength := Length(edtcpfCnpj.Text);

  // Aplica a m�scara enquanto o usu�rio digita
  edtcpfCnpj.Text := MascaraCpfCnpj(Value);

  // Ajusta a posi��o do cursor
  if CursorPos > Length(edtcpfCnpj.Text) then
    CursorPos := Length(edtcpfCnpj.Text) // Ajusta se o cursor est� al�m do novo texto
  else
    CursorPos := CursorPos + (Length(edtcpfCnpj.Text) - OldLength); // Ajusta com base na diferen�a de comprimento

  // Move o cursor para a nova posi��o
  edtcpfCnpj.SelStart := CursorPos;
end;


function TfrmCadCliente.MascaraCpfCnpj(const AValue: string): string;
var
  I: Integer;  // Vari�vel de controle para loops
begin
  Result := '';  // Inicializa o resultado como uma string vazia

  // Remove caracteres n�o num�ricos
  for I := 1 to Length(AValue) do
  begin
    if AValue[I] in ['0'..'9'] then
      Result := Result + AValue[I];  // Concatena apenas os d�gitos num�ricos
  end;

  // Aplica a m�scara com base no n�mero de d�gitos
  case Length(Result) of
    1..3: Result := Result;  // Apenas d�gitos (sem m�scara)
    4..6: Result := Format('%s.%s', [Copy(Result, 1, 3), Copy(Result, 4, Length(Result) - 3)]);  // 3 d�gitos + .
    7..9: Result := Format('%s.%s.%s', [Copy(Result, 1, 3), Copy(Result, 4, 3), Copy(Result, 7, Length(Result) - 6)]);  // 6 d�gitos + .
    10..11: Result := Format('%s.%s.%s-%s', [Copy(Result, 1, 3), Copy(Result, 4, 3), Copy(Result, 7, 3), Copy(Result, 10, 2)]);  // CPF Completo
    12..14: Result := Format('%s.%s.%s/%s-%s',
      [Copy(Result, 1, 2),
       Copy(Result, 3, 3),
       Copy(Result, 6, 3),
       Copy(Result, 9, 4),
       Copy(Result, 13, 2)]);  // CNPJ Completo
  end;
end;



end.
