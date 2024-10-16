unit uTelaHeranca;

interface

uses
  // Módulos e bibliotecas que o código utiliza, como componentes visuais, banco de dados, etc.
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Buttons, uDTMConexao, ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum, RxToolEdit, RxCurrEdit;

type
  // Definição de uma classe de formulário chamada TfrmTelaHeranca
  TfrmTelaHeranca = class(TForm)
    // Declaração de componentes visuais usados no formulário
    pgcPrincipal: TPageControl; // Controle de abas
    pnlRodape: TPanel; // Painel no rodapé
    tabListagem: TTabSheet; // Aba de listagem
    tabManutencao: TTabSheet; // Aba de manutenção
    pnlListagemTopo: TPanel; // Painel superior na aba de listagem
    mskPesquisar: TMaskEdit; // Campo para pesquisa
    btnPesquisar: TButton; // Botão de pesquisa
    grdListagem: TDBGrid; // Grid que exibe os dados
    btnNovo: TBitBtn; // Botão "Novo"
    btnAlterar: TBitBtn; // Botão "Alterar"
    btnCancelar: TBitBtn; // Botão "Cancelar"
    btnGravar: TBitBtn; // Botão "Gravar"
    btnApagar: TBitBtn; // Botão "Apagar"
    btnFechar: TBitBtn; // Botão "Fechar"
    btnNavigator: TDBNavigator; // Componente para navegação nos dados
    QryListagem: TZQuery; // Query que realiza operações no banco de dados
    dtsListagem: TDataSource; // DataSource que conecta os dados ao Grid
    lblIndice: TLabel; // Rótulo para exibir o índice atual
    // Declaração de métodos (procedures) que tratam eventos como cliques de botões
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
    procedure FormDblClick(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
  private
    // Variáveis e métodos privados
    // Métodos privados para controlar botões e abas
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn; Navegador:TDBNavigator;
              pgcPrincipal: TPageControl; Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: string): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
  public
    // Variáveis públicas
    IndiceAtual:string; // Variável para armazenar o índice atual de ordenação
    EstadoDoCadastro:TEstadoDoCadastro; // Variável que armazena o estado atual do cadastro (inserir, alterar, etc.)
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca; // Instância do formulário

implementation

{$R *.dfm} // Diretiva que associa o arquivo de design visual (DFM) ao código
 {$region 'OBSERVAÇÕES'}
 //TAG:1 - CHAVE PRIMARIA PK
 //TAG:2 - CAMPOS OBRIGATORIOS
 {$ENDREGION }

{$region 'FUNÇÕES E PROCEDURES'}
// Controle de botões, habilita ou desabilita os botões com base no estado do cadastro
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn; Navegador:TDBNavigator;
          pgcPrincipal: TPageControl; Flag:Boolean);
begin
    // Habilita ou desabilita os botões conforme o valor de 'Flag'
    btnNovo.Enabled     :=Flag;
    btnApagar.Enabled   :=Flag;
    btnAlterar.Enabled  :=Flag;
    Navegador.Enabled   :=Flag;
    pgcPrincipal.Pages [0].TabVisible  :=Flag;
    btnCancelar.Enabled :=not(Flag);
    btnGravar.Enabled   :=not(Flag);
end;

// Altera a aba visível do PageControl para a aba especificada
procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
      pgcPrincipal.TabIndex:=Indice;
end;

// Função que retorna o nome de um campo traduzido
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
  for i := 0 to ComponentCount -1 do begin
    if(Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
            (TLabeledEdit(Components[i]).Text=EmptyStr) then begin
            MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
              ' é um campo obrigatório',mtInformation,[mbOK],0);
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

{$REGION 'MÉTODOS VIRTUAIS'}
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

// Ação do botão "Novo" para inserir um novo registro
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
     // Desabilita alguns botões e altera o estado para "inserir"
     ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
     EstadoDoCadastro:=ecInserir;
     LimparEdits;
end;

// Ação do botão "Alterar" para modificar um registro existente
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  // Desabilita alguns botões e altera o estado para "alterar"
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro:=ecAlterar;
end;

// Ação do botão "Apagar" para Apagar um registro
procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  Try
    if (Apagar) then begin
    // Restaura a interface ao estado padrão após a exclusão
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      QryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na Exclusão', mtError, [mbOK], 0);
    end;
  Finally
    EstadoDoCadastro:=ecNenhum;
  End;
end;

// Ação do botão "Cancelar" para cancelar uma operação em andamento
procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  // Restaura a interface ao estado padrão ao cancelar
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro:=ecNenhum;
  LimparEdits;
end;

// Ação do botão "Gravar" para salvar um registro no banco de dados
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
      MessageDlg('Erro na Gravação', mtError, [mbOK], 0)
    end;
  Finally

  End;
end;


// Ação do botão "Fechar" para fechar o formulário
procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close; // Fecha o formulário
end;

// Ação executada quando o formulário é fechado
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close; // Fecha a query
end;

// Ação executada ao criar o formulário
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  // Configura a conexão e associa os componentes
  QryListagem.Connection:=dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet:=QryListagem;
  grdListagem.DataSource:=dtsListagem;
  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
                        dgCancelOnExit,dgTitleClick,dgTitleHotTrack]
end;

procedure TfrmTelaHeranca.FormDblClick(Sender: TObject);
begin

end;

// Ação executada quando o formulário é mostrado
procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  // Abre a query se a SQL não estiver vazia
  if (QryListagem.SQL.Text<>EmptyStr) then begin
    QryListagem.IndexFieldNames:=IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    QryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
end;

// Remover a implementação duplicada e incompleta
function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  // Implementação original que mostra as mensagens
  if (EstadoDoCadastro = ecInserir) then
    ShowMessage('Inserir')
  else if (EstadoDoCadastro = ecAlterar) then
    ShowMessage('Alterado');
  Result := True;
end;


// Ação executada ao clicar no título de uma coluna no grid
procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName; // Atualiza o índice atual para ordenar os dados
  QryListagem.IndexFieldNames:=IndiceAtual; // Ordena os dados pelo campo clicado
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

end.

