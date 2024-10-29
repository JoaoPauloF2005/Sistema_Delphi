unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao,cCadCliente, Enter, ufrmAtualizaDB, cUsuarioLogado,
  Vcl.ComCtrls, ZDbcIntfs, cAtualizacaoBancoDeDados, cAcaoAcesso, RLReport;


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
    PRODUTOPORCATEGORIA1: TMenuItem;
    USURIO1: TMenuItem;
    N5: TMenuItem;
    ALTERARSENHA1: TMenuItem;
    StbPrincipal: TStatusBar;
    AOACESSO1: TMenuItem;
    N6: TMenuItem;
    USURIOSVSAES1: TMenuItem;
    N7: TMenuItem;
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
    procedure PRODUTO2Click(Sender: TObject);
    procedure PRODUTOPORCATEGORIA1Click(Sender: TObject);
    procedure VENDAPORDATA1Click(Sender: TObject);
    procedure USURIO1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ALTERARSENHA1Click(Sender: TObject);
    procedure AOACESSO1Click(Sender: TObject);
    procedure USURIOSVSAES1Click(Sender: TObject);

  private
    { Private declarations }
    oCliente: TCliente;
    TeclaEnter:TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure CriarForm(aNomeForm: TFormClass);
    procedure CriarRelatorio(aNomeForm: TFormClass);
  public
    { Public declarations }
  end;

var
  frmPrincipal : TfrmPrincipal;
  oUsuarioLogado : TUsuarioLogado;

implementation

uses uCadCategoria, uCadCliente, uCadProduto, uProVenda, uRelCategoria, uRelCadCliente, uRelCadClienteFicha, uRelCadProduto, uRelCadProdutoComGrupoCategoria, uSelecionarData, uRelVendaPorData,
  uCadUsuario, uLogin, uAlterarSenha, cArquivoIni, uCadAcaoAcesso, uUsuarioVsAcoes, uTelaHeranca;
{$R *.dfm}


procedure TfrmPrincipal.CATEGORIA1Click(Sender: TObject);
begin
  CriarForm(TfrmCadCategoria);
end;

procedure TfrmPrincipal.CATEGORIA2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadCategoria);
end;

procedure TfrmPrincipal.CLIENTE1Click(Sender: TObject);
begin
   CriarForm(TfrmCadCliente);
end;

procedure TfrmPrincipal.CLIENTE2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadCliente);
end;

procedure TfrmPrincipal.PRODUTO1Click(Sender: TObject);
begin
  CriarForm(TfrmCadProduto);
end;

procedure TfrmPrincipal.PRODUTO2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadProduto);
end;

procedure TfrmPrincipal.PRODUTOPORCATEGORIA1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria);
end;

procedure TfrmPrincipal.USURIO1Click(Sender: TObject);
begin
  CriarForm(TfrmCadUsuario);
end;

procedure TfrmPrincipal.USURIOSVSAES1Click(Sender: TObject);
begin
	CriarForm(TfrmUsuarioVsAcoes);
end;

procedure TfrmPrincipal.VENDAPORDATA1Click(Sender: TObject);
begin
	Try
    frmSelecionarData  := TfrmSelecionarData.Create(Self);
    frmSelecionarData.ShowModal;

    frmRelVendaPorData := TfrmRelVendaPorData.Create(Self);
    frmRelVendaPorData.QryVenda.Close;
    frmRelVendaPorData.QryVenda.ParamByName('DataInicio').AsDate := frmSelecionarData.EdtDataInicio.Date;
    frmRelVendaPorData.QryVenda.ParamByName('DataFim').AsDate := frmSelecionarData.EdtDataFinal.Date;
    frmRelVendaPorData.QryVenda.Open;
    frmRelVendaPorData.Relatorio.PreviewModal;
  Finally
    frmSelecionarData.Release;
    frmRelVendaPorData.Release;
  End;
end;

procedure TfrmPrincipal.VENDAS1Click(Sender: TObject);
begin
  frmProVenda := TfrmProVenda.Create(Self);
  frmProVenda.ShowModal;
  frmProVenda.Release;
end;

procedure TfrmPrincipal.ALTERARSENHA1Click(Sender: TObject);
begin
  CriarForm(TfrmAlterarSenha);
end;


procedure TfrmPrincipal.AOACESSO1Click(Sender: TObject);
begin
  CriarForm(TfrmCadAcaoAcesso);
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm:TfrmAtualizaDB);
var oAtualizarMSSQL: TAtualizaBancoDadosMSSQL;
begin
  aForm.Refresh;
  try
    oAtualizarMSSQL := TAtualizaBancoDadosMSSQL.Create(dtmPrincipal.ConexaoDB);
    oAtualizarMSSQL.AtualizarBancoDeDadosMSSQL;
  finally
  	if Assigned(oAtualizarMSSQL) then
    	FreeAndNil(oAtualizarMSSQL);
  end;

end;

procedure TfrmPrincipal.FICHADECLIENTE1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadClienteFicha);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);

  if Assigned (oUsuarioLogado) then
     FreeAndNil(oUsuarioLogado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
	if not FileExists(TArquivoIni.ArquivoIni) then
  begin
      TArquivoIni.AtualizarIni('SERVER', 'TipoDataBase', 'MSSQL');
      TArquivoIni.AtualizarIni('SERVER', 'HostName', '.\');
      TArquivoIni.AtualizarIni('SERVER', 'Port', '1433');
      TArquivoIni.AtualizarIni('SERVER', 'User', 'sa');
      TArquivoIni.AtualizarIni('SERVER', 'Password', 'mudar@123');
      TArquivoIni.AtualizarIni('SERVER', 'Database', 'vendas');
      MessageDlg('Arquivo '+ TArquivoIni.ArquivoIni +' Criado com sucesso' +#13+
                 'Configure o arquivo antes de inicializar aplica��o',MtInformation,[mbok],0);

      Application.Terminate;
  end
  else
    begin
      frmAtualizaDB := TfrmAtualizaDB.Create(Self);
      frmAtualizaDB.Show;
      frmAtualizaDB.Refresh;
      dtmPrincipal := TdtmPrincipal.Create(Self);
      with dtmPrincipal.ConexaoDB do
      begin
        SQLHourGlass := True;
        if TArquivoIni.LerIni('SERVER', 'TipoDataBase') = 'MSSQL' then
        	Protocol := 'mssql';
        LibraryLocation:='C:\Users\devmv\Documents\JoaoPaulo\ProjetoDelphi\ntwdblib.dll';
        HostName := TArquivoIni.LerIni('SERVER', 'HostName');
        Port := StrToInt(TArquivoIni.LerIni('SERVER', 'Port'));
        User := TArquivoIni.LerIni('SERVER', 'User');;
        Password := TArquivoIni.LerIni('SERVER', 'Password');
        Database := TArquivoIni.LerIni('SERVER', 'DataBase');
        AutoCommit := True;
        TransactIsolationLevel := tiReadCommitted;
        Connected := True;
      end;
      AtualizacaoBancoDados(frmAtualizaDB);

      TAcaoAcesso.CriarAcoes(TfrmCadCategoria,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmCadCliente,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmCadProduto,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmCadUsuario,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmAlterarSenha,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmProVenda,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelVendaPorData,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelCadCliente,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoComGrupoCategoria,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelCadProduto,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelCadCategoria,dtmPrincipal.ConexaoDB);

      TAcaoAcesso.PreencherUsuariosVSAcoes(dtmPrincipal.ConexaoDB);

      frmAtualizaDB.Free;

      TeclaEnter := TMREnter.Create(Self);
      TeclaEnter.FocusEnabled := true;
      TeclaEnter.FocusColor := clInfoBk;
    end
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
	try
    oUsuarioLogado := TUsuarioLogado.Create;

    frmLogin := TfrmLogin.Create(Self);
    frmLogin.ShowModal;
  finally
  	frmLogin.Release;
    StbPrincipal.Panels[0].Text := 'USU�RIO: '+oUsuarioLogado.nome;
  end;
end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;


procedure TfrmPrincipal.CriarForm(aNomeForm: TFormClass);
var form: TForm;
begin
	try
    form := aNomeForm.Create(Application);
    if TfrmTelaHeranca.TenhoAcesso(oUsuarioLogado.codigo, form.Name, dtmPrincipal.ConexaoDB) then
    begin
    form.ShowModal;
    end
    else
    begin
      MessageDlg('Usu�rio: '+oUsuarioLogado.nome +' N�o tem permiss�o de Acesso', mtWarning,[mbOK], 0);
    end;
  finally
  	if Assigned(form) then
    	form.Release;
  end;
end;

procedure TfrmPrincipal.CriarRelatorio(aNomeForm: TFormClass);
var form: TForm;
		aRelatorio:TRLReport;
    i:Integer;

begin
	try
    form := aNomeForm.Create(Application);
    for i := 0 to form.ComponentCount -1 do
    begin
      TRLReport(form.Components[i]).PreviewModal;
      Break;
    end;
  finally

  end;
end;
end.
