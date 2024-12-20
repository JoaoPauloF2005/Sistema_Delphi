unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao,cCadCliente, Enter, ufrmAtualizaDB, cUsuarioLogado,
  Vcl.ComCtrls, ZDbcIntfs, cAtualizacaoBancoDeDados, cAcaoAcesso, RLReport, Vcl.ExtCtrls, Vcl.StdCtrls, VclTee.TeeGDIPlus,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,
  VCLTee.Series, System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    StbPrincipal: TStatusBar;
    Panel1: TPanel;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    Panel2: TPanel;
    btnFechar: TImage;
    btnVenda: TImage;
    btnProduto: TImage;
    btnCliente: TImage;
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
    procedure ROCARUSURIO1Click(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnVendaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
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
  uCadUsuario, uLogin, uAlterarSenha, cArquivoIni, uCadAcaoAcesso, uUsuarioVsAcoes, uTelaHeranca, uDTMGrafico, uRelProVenda, uCadSubCategoria;
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

procedure TfrmPrincipal.ROCARUSURIO1Click(Sender: TObject);
begin
  // Libere o usu�rio logado atual
  FreeAndNil(oUsuarioLogado);

  // Crie uma nova inst�ncia do formul�rio de login
  frmLogin := TfrmLogin.Create(Self);

  try
    // Exiba o formul�rio de login
    frmLogin.ShowModal;
  finally
    // Libere o formul�rio de login ap�s o fechamento
    frmLogin.Release;
  end;

  // Atualize a barra de status para refletir a troca de usu�rio
  StbPrincipal.Panels[0].Text := 'USU�RIO: N�o Logado';
end;

procedure TfrmPrincipal.TreeView1DblClick(Sender: TObject);
begin
  if Assigned(TreeView1.Selected) then
  begin
    // Verifique o texto do n� selecionado para abrir o formul�rio ou o relat�rio correspondente
    if TreeView1.Selected.Text = 'Cadastro de Clientes' then
    begin
      CriarForm(TfrmCadCliente);
    end
    else if TreeView1.Selected.Text = 'Cadastro de Categorias' then
    begin
      CriarForm(TfrmCadCategoria);
    end
    else if TreeView1.Selected.Text = 'Cadastro de SubCategorias' then
    begin
      CriarForm(TfrmCadSubCategoria);
    end
    else if TreeView1.Selected.Text = 'Cadastro de Produtos' then
    begin
      CriarForm(TfrmCadProduto);
    end
    else if TreeView1.Selected.Text = 'Cadastro de Usu�rios' then
    begin
      CriarForm(TfrmCadUsuario);
    end
    else if TreeView1.Selected.Text = 'Vendas' then
    begin
      CriarForm(TfrmProVenda);
    end
    else if TreeView1.Selected.Text = 'A��o Acesso' then
    begin
      CriarForm(TfrmCadAcaoAcesso);
    end
    else if TreeView1.Selected.Text = 'Usu�rios VS A��es' then
    begin
      CriarForm(TfrmUsuarioVsAcoes);
    end
    else if TreeView1.Selected.Text = 'Alterar Senha' then
    begin
      CriarForm(TfrmAlterarSenha);
    end
    else if TreeView1.Selected.Text = 'Relat�rio de Categorias' then
    begin
      CriarRelatorio(TfrmRelCadCategoria);
    end
    else if TreeView1.Selected.Text = 'Relat�rio de Clientes' then
    begin
      CriarRelatorio(TfrmRelCadCliente);
    end
    else if TreeView1.Selected.Text = 'Relat�rio de Ficha de Clientes' then
    begin
      CriarRelatorio(TfrmRelCadClienteFicha);
    end
    else if TreeView1.Selected.Text = 'Relat�rio de Produtos' then
    begin
      CriarRelatorio(TfrmRelCadProduto);
    end
    else if TreeView1.Selected.Text = 'Relat�rio de Produtos por Categoria' then
    begin
      CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria);
    end

    else if TreeView1.Selected.Text = 'Relat�rio de Venda por Data' then
    begin
      Try
      // Abre o formul�rio de sele��o de data
      frmSelecionarData := TfrmSelecionarData.Create(Self);

      // Exibe o formul�rio para selecionar as datas
      if frmSelecionarData.ShowModal = mrOk then
      begin
        // Abre o relat�rio com as datas selecionadas
        frmRelVendaPorData := TfrmRelVendaPorData.Create(Self);
        Try
          frmRelVendaPorData.QryVenda.Close;
          frmRelVendaPorData.QryVenda.ParamByName('DataInicio').AsDate := frmSelecionarData.EdtDataInicio.Date;
          frmRelVendaPorData.QryVenda.ParamByName('DataFim').AsDate := frmSelecionarData.EdtDataFinal.Date;
          frmRelVendaPorData.QryVenda.Open;

          // Exibe o relat�rio em modo de visualiza��o
          frmRelVendaPorData.Relatorio.PreviewModal;
        Finally
          frmRelVendaPorData.Release;
        End;
      end;

      Finally
        frmSelecionarData.Release;
      End;
    end
   else if TreeView1.Selected.Text = 'Relat�rio de Vendas' then
    begin
      CriarRelatorio(TfrmRelProVenda);
    end

  end;
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
    if TfrmTelaHeranca.TenhoAcesso(oUsuarioLogado.codigo, frmSelecionarData.Name, dtmPrincipal.ConexaoDB) then
    begin
    	frmSelecionarData.ShowModal;

    	frmRelVendaPorData := TfrmRelVendaPorData.Create(Self);
    	frmRelVendaPorData.QryVenda.Close;
    	frmRelVendaPorData.QryVenda.ParamByName('DataInicio').AsDate := frmSelecionarData.EdtDataInicio.Date;
    	frmRelVendaPorData.QryVenda.ParamByName('DataFim').AsDate := frmSelecionarData.EdtDataFinal.Date;
    	frmRelVendaPorData.QryVenda.Open;
    	frmRelVendaPorData.Relatorio.PreviewModal;
    end
    else begin
      MessageDlg('Usuario: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso', mtWarning, [mbOK], 0);
    end;

  Finally
    if Assigned(frmSelecionarData) then
      frmSelecionarData.Release;
    if Assigned(frmRelVendaPorData) then
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

procedure TfrmPrincipal.btnClienteClick(Sender: TObject);
begin
  CriarForm(TfrmCadCliente);
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TfrmPrincipal.btnProdutoClick(Sender: TObject);
begin
  CriarForm(TfrmCadProduto);
end;

procedure TfrmPrincipal.btnVendaClick(Sender: TObject);
begin
 CriarForm(TfrmProVenda);
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
      TAcaoAcesso.CriarAcoes(TfrmCadSubCategoria, dtmPrincipal.ConexaoDB);
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
      TAcaoAcesso.CriarAcoes(TfrmRelProVenda,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmRelCadCategoria,dtmPrincipal.ConexaoDB);
      TAcaoAcesso.CriarAcoes(TfrmUsuarioVsAcoes, dtmPrincipal.ConexaoDB);

      TAcaoAcesso.PreencherUsuariosVSAcoes(dtmPrincipal.ConexaoDB);

      frmAtualizaDB.Free;

      TeclaEnter := TMREnter.Create(Self);
      TeclaEnter.FocusEnabled := true;
      TeclaEnter.FocusColor := clInfoBk;
    end;
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
    if TfrmTelaHeranca.TenhoAcesso(oUsuarioLogado.codigo, form.Name, dtmPrincipal.ConexaoDB) then
    begin
    	for i := 0 to form.ComponentCount -1 do
    	begin
      	if form.Components[i] is TRLReport then
      		begin
      			TRLReport(form.Components[i]).PreviewModal;
      			Break;
        	end;
    	end;
    end
    else begin
    	MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso', mtWarning, [mbOK], 0);
    end;

  finally
    if Assigned(form) then
    end;form.Release;
end;

end.
