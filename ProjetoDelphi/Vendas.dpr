program Vendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDTMConexao in 'datamodule\uDTMConexao.pas' {dtmPrincipal: TDataModule},
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uCadCategoria in 'cadastro\uCadCategoria.pas' {frmCadCategoria},
  Vcl.Themes,
  Vcl.Styles,
  Enter in 'terceiros\Enter.pas',
  uEnum in 'heranca\uEnum.pas',
  cCadCategoria in 'classes\cCadCategoria.pas',
  uCadCliente in 'cadastro\uCadCliente.pas' {frmCadCliente},
  cCadCliente in 'classes\cCadCliente.pas',
  uCadProduto in 'cadastro\uCadProduto.pas' {frmCadProduto},
  cCadProduto in 'classes\cCadProduto.pas',
  ufrmAtualizaDB in 'datamodule\ufrmAtualizaDB.pas' {frmAtualizaDB},
  uDTMVenda in 'datamodule\uDTMVenda.pas' {dtmVenda: TDataModule},
  uProVenda in 'processo\uProVenda.pas' {frmProVenda},
  cProVenda in 'classes\cProVenda.pas',
  cControleEstoque in 'classes\cControleEstoque.pas',
  uRelCadClienteFicha in 'relatorio\uRelCadClienteFicha.pas' {frmRelCadClienteFicha},
  uRelCadProduto in 'relatorio\uRelCadProduto.pas' {frmRelCadProduto},
  uRelCadCliente in 'relatorio\uRelCadCliente.pas' {frmRelCadCliente},
  uRelCategoria in 'relatorio\uRelCategoria.pas' {frmRelCadCategoria},
  uRelProVenda in 'relatorio\uRelProVenda.pas' {frmRelProVenda},
  uSelecionarData in 'relatorio\uSelecionarData.pas' {frmSelecionarData},
  uRelCadProdutoComGrupoCategoria in 'relatorio\uRelCadProdutoComGrupoCategoria.pas' {frmRelCadProdutoComGrupoCategoria},
  uRelVendaPorData in 'relatorio\uRelVendaPorData.pas' {frmRelVendaPorData},
  uFuncaoCriptografia in 'heranca\uFuncaoCriptografia.pas',
  uCadUsuario in 'cadastro\uCadUsuario.pas' {frmCadUsuario},
  cCadUsuario in 'classes\cCadUsuario.pas',
  uLogin in 'login\uLogin.pas' {frmLogin},
  uAlterarSenha in 'login\uAlterarSenha.pas' {frmAlterarSenha},
  cUsuarioLogado in 'classes\cUsuarioLogado.pas',
  cAtualizacaoBancoDeDados in 'classes\cAtualizacaoBancoDeDados.pas',
  cAtualizacaoTabelaMSSQL in 'classes\cAtualizacaoTabelaMSSQL.pas',
  cAtualizacaoCampoMSSQL in 'classes\cAtualizacaoCampoMSSQL.pas',
  cArquivoIni in 'classes\cArquivoIni.pas',
  cAcaoAcesso in 'classes\cAcaoAcesso.pas',
  uCadAcaoAcesso in 'cadastro\uCadAcaoAcesso.pas' {frmCadAcaoAcesso},
  uUsuarioVsAcoes in 'login\uUsuarioVsAcoes.pas' {frmUsuarioVsAcoes},
  uDTMGrafico in 'datamodule\uDTMGrafico.pas' {DTMGrafico: TDataModule},
  uCadSubCategoria in 'cadastro\uCadSubCategoria.pas' {frmCadSubCategoria},
  cCadSubCategoria in 'classes\cCadSubCategoria.pas',
  uReceitaCNPJ in 'API\uReceitaCNPJ.pas' {frmReceitaCNPJ};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDTMGrafico, DTMGrafico);
  Application.CreateForm(TfrmReceitaCNPJ, frmReceitaCNPJ);
  Application.Run;
end.
