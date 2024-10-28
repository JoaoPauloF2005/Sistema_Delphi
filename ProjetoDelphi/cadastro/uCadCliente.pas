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
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemendereco: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemestado: TWideStringField;
    QryListagemcep: TWideStringField;
    QryListagemtelefone: TWideStringField;
    QryListagememail: TWideStringField;
    QryListagemdatanascimento: TDateTimeField;
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
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);

  private
    { Private declarations }
    oCliente:TCliente;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
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




end.
