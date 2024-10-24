unit uTelaHeranca;

interface

uses
  // M�dulos e bibliotecas que o c�digo utiliza, como componentes visuais, banco de dados, etc.
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Buttons, uDTMConexao, ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum, RxToolEdit, RxCurrEdit;
  
type
  // Defini��o de uma classe de formul�rio chamada TfrmTelaHeranca
  TfrmTelaHeranca = class(TForm)
    // Declara��o de componentes visuais usados no formul�rio
    pgcPrincipal: TPageControl; // Controle de abas
    pnlRodape: TPanel; // Painel no rodap�
    tabListagem: TTabSheet; // Aba de listagem
    tabManutencao: TTabSheet; // Aba de manuten��o
    pnlListagemTopo: TPanel; // Painel superior na aba de listagem
    mskPesquisar: TMaskEdit; // Campo para pesquisa
    btnPesquisar: TButton; // Bot�o de pesquisa
    grdListagem: TDBGrid; // Grid que exibe os dados
    btnNovo: TBitBtn; // Bot�o "Novo"
    btnAlterar: TBitBtn; // Bot�o "Alterar"
    btnCancelar: TBitBtn; // Bot�o "Cancelar"
    btnGravar: TBitBtn; // Bot�o "Gravar"
    btnApagar: TBitBtn; // Bot�o "Apagar"
    btnFechar: TBitBtn; // Bot�o "Fechar"
    btnNavigator: TDBNavigator; // Componente para navega��o nos dados
    QryListagem: TZQuery; // Query que realiza opera��es no banco de dados
    dtsListagem: TDataSource; // DataSource que conecta os dados ao Grid
    lblIndice: TLabel; // R�tulo para exibir o �ndice atual
    // Declara��o de m�todos (procedures) que tratam eventos como cliques de bot�es
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    // Vari�veis e m�todos privados
    // M�todos privados para controlar bot�es e abas
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn; Navegador:TDBNavigator;
              pgcPrincipal: TPageControl; Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: string): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
  public
    // Vari�veis p�blicas
    IndiceAtual:string; // Vari�vel para armazenar o �ndice atual de ordena��o
    EstadoDoCadastro:TEstadoDoCadastro; // Vari�vel que armazena o estado atual do cadastro (inserir, alterar, etc.)
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
  end;

var
  frmTelaHeranca: TfrmTelaHeranca; // Inst�ncia do formul�rio

implementation

{$R *.dfm} // Diretiva que associa o arquivo de design visual (DFM) ao c�digo
 		{$region 'OBSERVA��ES'}
 //TAG:1 - CHAVE PRIMARIA PK
 //TAG:2 - CAMPOS OBRIGATORIOS
 {$ENDREGION }

{$region 'FUN��ES E PROCEDURES'}
// Controle de bot�es, habilita ou desabilita os bot�es com base no estado do cadastro
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn; Navegador:TDBNavigator;
          pgcPrincipal: TPageControl; Flag:Boolean);
begin
    // Habilita ou desabilita os bot�es conforme o valor de 'Flag'
    btnNovo.Enabled     :=Flag;
    btnApagar.Enabled   :=Flag;
    btnAlterar.Enabled  :=Flag;
    Navegador.Enabled   :=Flag;
    pgcPrincipal.Pages [0].TabVisible  :=Flag;
    btnCancelar.Enabled :=not(Flag);
    btnGravar.Enabled   :=not(Flag);
end;

// Altera a aba vis�vel do PageControl para a aba especificada
procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
      pgcPrincipal.TabIndex:=Indice;
end;

// Fun��o que retorna o nome de um campo traduzido
function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:string):string;
var i:Integer;
begin
  // Percorre todos os campos da query e busca o campo correspondente ao nome passado
  for I := 0 to QryListagem.Fields.Count-1 do begin
    if LowerCase(QryListagem.Fields[i].FieldName)=LowerCase(Campo) then begin
      Result:=QryListagem.Fields[i].DisplayLabel;
      Break;
    end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo:string; aLabel:TLabel);
begin
  aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio:Boolean;
var i:Integer;
begin
  Result:=False;
  for I := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
       if (TLabeledEdit(Components[i]).Tag = 2) and (TLabeledEdit(Components[i]).Text = EmptyStr) then begin
          MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' � um campo obrigat�rio' ,mtInformation,[mbOK],0);
          TLabeledEdit(Components[i]).SetFocus;
          Result:=True;
          Break;
       end;
    end;
  end;
end;


procedure TfrmTelaHeranca.DesabilitarEditPK;
var i:Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if(Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
           TLabeledEdit(Components[i]).Enabled:=False;
           Break;
      end;
    end;
  end;

end;

procedure TfrmTelaHeranca.LimparEdits;
var i:Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if(Components[i] is TLabeledEdit) then
      TLabeledEdit(Components[i]).Text:=EmptyStr
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text:=''

    else if (Components[i] is TMemo) then
      TMemo(Components[i]).Text:=''
     else if (Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[i]).KeyValue:=null
     else if (Components[i] is TCurrencyEdit) then
      TCurrencyEdit(Components[i]).Value:=0
    else if (Components[i] is TDateEdit) then
      TDateEdit(Components[i]).Date:=0
     else if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text:=''

    end;
end;


{$endregion}

{$REGION 'M�TODOS VIRTUAIS'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('DELETADO');
  Result:=True;
end;

function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean;
begin
  if (EstadoDoCadastro=ecInserir) then
      ShowMessage('Inserir')
  else if (EstadoDoCadastro=ecAlterar) then
      ShowMessage('Alterado');
  Result := True;
end;
{$ENDREGION}

// A��o do bot�o "Novo" para inserir um novo registro
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
     // Desabilita alguns bot�es e altera o estado para "inserir"
     ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
     EstadoDoCadastro:=ecInserir;
     LimparEdits;
end;

// A��o do bot�o "Alterar" para modificar um registro existente
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  // Desabilita alguns bot�es e altera o estado para "alterar"
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro:=ecAlterar;
end;

// A��o do bot�o "Apagar" para Apagar um registro
procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  Try
    if (Apagar) then begin
    // Restaura a interface ao estado padr�o ap�s a exclus�o
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      QryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na Exclus�o', mtError, [mbOK], 0);
    end;
  Finally
    EstadoDoCadastro:=ecNenhum;
  End;
end;

// A��o do bot�o "Cancelar" para cancelar uma opera��o em andamento
procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  // Restaura a interface ao estado padr�o ao cancelar
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro:=ecNenhum;
  LimparEdits;
end;

// A��o do bot�o "Gravar" para salvar um registro no banco de dados
procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then
    Abort;

  Try
    if Gravar(EstadoDoCadastro) then begin  //Metodo virtual
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      QryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na Grava��o', mtError, [mbOK], 0)
    end;
  Finally

  End;
end;


// A��o do bot�o "Fechar" para fechar o formul�rio
procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close; // Fecha o formul�rio
end;

// A��o executada quando o formul�rio � fechado
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close; // Fecha a query
end;

// A��o executada ao criar o formul�rio
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  // Configura a conex�o e associa os componentes
  QryListagem.Connection:=dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet:=QryListagem;
  grdListagem.DataSource:=dtsListagem;
  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
                        dgCancelOnExit,dgTitleClick,dgTitleHotTrack]
end;

procedure TfrmTelaHeranca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

// A��o executada quando o formul�rio � mostrado
procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  // Abre a query se a SQL n�o estiver vazia
  if (QryListagem.SQL.Text<>EmptyStr) then begin
    QryListagem.IndexFieldNames:=IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    QryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
end;

// Remover a implementa��o duplicada e incompleta
function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  // Implementa��o original que mostra as mensagens
  if (EstadoDoCadastro = ecInserir) then
    ShowMessage('Inserir')
  else if (EstadoDoCadastro = ecAlterar) then
    ShowMessage('Alterado');
  Result := True;
end;


// A��o executada ao clicar no t�tulo de uma coluna no grid
procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  // Aplica a cor de fundo personalizada para linha selecionada
  if gdSelected in State then
    grdListagem.Canvas.Brush.Color := RGB(190, 223, 241)  // Beau Blue
  else
    grdListagem.Canvas.Brush.Color := clWindow;  // Cor padr�o de fundo
    grdListagem.Canvas.Font.Color := clBlack;   // Cor do texto preta

  // Preenche o ret�ngulo da c�lula
  grdListagem.Canvas.FillRect(Rect);

  // Exibe o texto da c�lula alinhado
  grdListagem.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName; // Atualiza o �ndice atual para ordenar os dados
  QryListagem.IndexFieldNames:=IndiceAtual; // Ordena os dados pelo campo clicado
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
  	//bloqueia o CTRL + DEL
    if (Shift = [ssCtrl]) and (Key = 46) then
    	Key := 0;
end;



end .
