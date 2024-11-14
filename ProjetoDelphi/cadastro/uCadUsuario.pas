unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,cAcaoAcesso, cCadUsuario, uEnum, uDTMConexao,
  System.ImageList, Vcl.ImgList, Vcl.WinXCtrls;

type
  TfrmCadUsuario = class(TfrmTelaHeranca)
    QryListagemusuarioID: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemSenha: TWideStringField;
    edtUsuarioId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchBox1Change(Sender: TObject);
  private
    { Private declarations }
    oUsuario:TUsuario;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):boolean; override;
    function Apagar:Boolean; override;public
    { Public declarations }
  end;

var
  frmCadUsuario: TfrmCadUsuario;

implementation

{$R *.dfm}

{ TfrmCadUsuario }

function TfrmCadUsuario.Apagar: Boolean;
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('usuarioID').AsInteger) then begin
    Result := oUsuario.Apagar;
  end;
end;

function TfrmCadUsuario.Gravar(EstadoDoCadastro: TEstadoDoCadastro): boolean;
begin
  if EstadoDoCadastro = ecInserir then
     Result := oUsuario.Inserir
  else if EstadoDoCadastro = ecAlterar then
     Result := oUsuario.Atualizar;

  TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);
end;

procedure TfrmCadUsuario.grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  // Aqui, deixamos vazio ou adicionamos outras ações conforme necessário
  // Isso impede que o atalho Ctrl + Shift + E ative o painel de exportação

end;

procedure TfrmCadUsuario.SearchBox1Change(Sender: TObject);
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
      'SELECT * FROM Usuarios ' +
      'WHERE nome LIKE :SearchText ';

    // Adiciona o parâmetro para o texto de pesquisa
    QryListagem.ParamByName('SearchText').AsString := '%' + SearchText + '%';
  end
  else
  begin
    // Restaura o SQL original sem filtro
    QryListagem.SQL.Text := 'SELECT * FROM Usuarios';
  end;

  // Reabre a query para atualizar a grid
  QryListagem.Open;

end;

Procedure TfrmCadUsuario.btnAlterarClick(Sender: TObject);
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('usuarioID').AsInteger) then begin
     edtUsuarioId.Text := IntToStr(oUsuario.codigo);
     edtNome.Text := oUsuario.nome;
     edtSenha.Text := oUsuario.senha;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;

procedure TfrmCadUsuario.btnGravarClick(Sender: TObject);
begin
  if oUsuario.UsuarioExiste(edtNome.Text) then begin
    MessageDlg('Usuário já cadastrado', mtInformation, [mbok],0);
    edtNome.SetFocus;
    abort;
  end;

  if edtUsuarioId.Text<>EmptyStr then
     oUsuario.codigo:=StrToInt(edtUsuarioId.Text)
  else
     oUsuario.codigo:=0;

  oUsuario.nome :=edtNome.Text;
  oUsuario.senha:=edtSenha.Text;

  inherited;
end;


procedure TfrmCadUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
  	FreeAndNil(oUsuario);
end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
  DesabilitarAtalhoExportar := True;
end;


end.
