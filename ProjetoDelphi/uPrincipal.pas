unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao,cCadCliente, Enter, ufrmAtualizaDB;


type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    CADASTRO1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    RELATRIOS1: TMenuItem;
    CLIENTE1: TMenuItem;
    N1: TMenuItem;
    CATEGORIA1: TMenuItem;
    PRODUTO1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    VENDAS1: TMenuItem;
    CLIENTE2: TMenuItem;
    N3: TMenuItem;
    PRODUTO2: TMenuItem;
    N4: TMenuItem;
    VENDAPORDATA1: TMenuItem;
    CATEGORIA2: TMenuItem;
    FICHADECLIENTE1: TMenuItem;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CATEGORIA1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLIENTE1Click(Sender: TObject);
    procedure PRODUTO1Click(Sender: TObject);
    procedure VENDAS1Click(Sender: TObject);
    procedure CATEGORIA2Click(Sender: TObject);
    procedure CLIENTE2Click(Sender: TObject);
    procedure FICHADECLIENTE1Click(Sender: TObject);
  private
    { Private declarations }
    oCliente: TCliente;
    TeclaEnter:TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uCadCategoria, uCadCliente, uCadProduto, uProVenda, uRelCategoria, uRelCadCliente, uRelCadClienteFicha;
{$R *.dfm}


procedure TfrmPrincipal.CATEGORIA1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.CATEGORIA2Click(Sender: TObject);
begin
	frmRelCategoria := TfrmRelCategoria.Create(Self);
  frmRelCategoria.Relatorio.PreviewModal;
  frmRelCategoria.Release;
end;

procedure TfrmPrincipal.CLIENTE1Click(Sender: TObject);
begin
   frmCadCliente := TfrmCadCliente.Create(Self);
   frmCadCliente.ShowModal;
   frmCadCliente.Release;
end;

procedure TfrmPrincipal.CLIENTE2Click(Sender: TObject);
begin
	frmRelCadCliente := TfrmRelCadCliente.Create(Self);
  frmRelCadCliente.Relatorio.PreviewModal;
  frmRelCadCliente.Release;
end;

procedure TfrmPrincipal.PRODUTO1Click(Sender: TObject);
begin
    frmCadProduto := TfrmCadProduto.Create(Self);
    frmCadProduto.ShowModal;
    frmCadProduto.Release;
end;

procedure TfrmPrincipal.VENDAS1Click(Sender: TObject);
begin
  frmProVenda := TfrmProVenda.Create(Self);
  frmProVenda.ShowModal;
  frmProVenda.Release;
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm:TfrmAtualizaDB);
begin
  aForm.chkConexao.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.QryScriptCategorias.ExecSQL;
  aForm.chkCategoria.Checked := True;
  aForm.Refresh;
  Sleep(100);

   dtmPrincipal.QryScriptProdutos.ExecSQL;
  aForm.chkProduto.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.QryScriptClientes.ExecSQL;
  aForm.chkCliente.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.QryScriptVendas.ExecSQL;
  aForm.chkVendas.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.QryScriptItensVenda.ExecSQL;
  aForm.chkItensVenda.Checked := True;
  aForm.Refresh;
  Sleep(100);
end;

procedure TfrmPrincipal.FICHADECLIENTE1Click(Sender: TObject);
begin
	frmRelCadClienteFicha := TfrmRelCadClienteFicha.Create(Self);
  frmRelCadClienteFicha.Relatorio.PreviewModal;
  frmRelCadClienteFicha.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      FreeAndNil(TeclaEnter);
      FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmAtualizaDB := TfrmAtualizaDB.Create(Self);
  frmAtualizaDB.Show;
  frmAtualizaDB.Refresh;
  dtmPrincipal := TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do begin
    SQLHourGlass := True;
    Protocol := 'mssql';
    LibraryLocation:='C:\Users\devmv\Documents\JoaoPaulo\ProjetoDelphi\ntwdblib.dll';
    HostName:='.\SERVERCURSO';
    Port:=1433  ;
    User:='sa';
    Password:='domtec02';
    Database:='vendas';
    Connected := True;
  end;
  AtualizacaoBancoDados(frmAtualizaDB);
  frmAtualizaDB.Free;
  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := true;
  TeclaEnter.FocusColor := clInfoBk;

end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;
end.
