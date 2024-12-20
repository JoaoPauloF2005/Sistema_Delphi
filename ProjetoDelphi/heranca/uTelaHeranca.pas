﻿unit uTelaHeranca;

interface

uses
  // M�dulos e bibliotecas que o c�digo utiliza, como componentes visuais, banco de dados, etc.
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Buttons, uDTMConexao, ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum, RxToolEdit, RxCurrEdit,
  ZAbstractConnection, Printers, ZConnection, cArquivoIni, System.ImageList, Vcl.ImgList, Vcl.OleAuto, Clipbrd, Math, Vcl.Imaging.pngimage, System.IOUtils, Vcl.Imaging.jpeg,
  Vcl.WinXCtrls;

type
  // Defini��o de uma classe de formul�rio chamada TfrmTelaHeranca
  TfrmTelaHeranca = class(TForm)
    // Declara��o de componentes visuais usados no formul�rio
    pgcPrincipal: TPageControl; // Controle de abas
    pnlRodape: TPanel; // Painel no rodap�
    tabListagem: TTabSheet; // Aba de listagem
    tabManutencao: TTabSheet; // Bot�o de pesquisa
    grdListagem: TDBGrid; // Grid que exibe os dados
    btnNovo: TBitBtn; // Bot�o "Novo"
    btnAlterar: TBitBtn; // Bot�o "Alterar"
    btnCancelar: TBitBtn; // Bot�o "Cancelar"
    btnGravar: TBitBtn; // Bot�o "Gravar"
    btnApagar: TBitBtn; // Bot�o "Apagar"
    btnFechar: TBitBtn; // Bot�o "Fechar"
    QryListagem: TZQuery; // Query que realiza opera��es no banco de dados
    dtsListagem: TDataSource;
    btnExcel: TButton;
    ImageList1: TImageList;
    pExportar: TPanel;
    Panel5: TPanel;
    btnFecharPanel: TSpeedButton;
    btnExportarHTML: TButton;
    btnExportarCSV: TButton;
    PrintDialog: TPrintDialog;
    SaveDialog: TSaveDialog;
    btnImprimir: TButton;
    SearchBox1: TSearchBox;
    Panel6: TPanel; // R�tulo para exibir o �ndice atual
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
    procedure btnPesquisarClick(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdListagemColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure btnExcelClick(Sender: TObject);
    procedure btnFecharPanelClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnExportarHTMLClick(Sender: TObject);
    procedure btnExportarCSVClick(Sender: TObject);
  private

    // Vari�veis e m�todos privados
    // M�todos privados para controlar bot�es e abas
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn;
              pgcPrincipal: TPageControl; Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: string): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
    procedure CarregarConfiguracaoColunas;
    procedure SalvarConfiguracaoColunas;
    procedure ExportarDBGridParaExcel(DBGrid: TDBGrid);
    procedure ExportarParaHTML(DBGrid: TDBGrid; const FileName: string);
    procedure ExportarParaCSV(DBGrid: TDBGrid; const FileName: string);
    procedure ExportarParaTexto(DBGrid: TDBGrid; const FileName: string);
    procedure ImprimirDBGrid(DBGrid: TDBGrid; OrientacaoPaisagem: Boolean);

  public
  DesabilitarAtalhoExportar: Boolean;
    // Vari�veis p�blicas
    IndiceAtual:string; // Vari�vel para armazenar o �ndice atual de ordena��o
    EstadoDoCadastro:TEstadoDoCadastro; // Vari�vel que armazena o estado atual do cadastro (inserir, alterar, etc.)
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
    class function TenhoAcesso (aUsuarioId: Integer; aChave: string; aConexao: TZConnection): Boolean; static;
end;

var
  frmTelaHeranca: TfrmTelaHeranca; // Inst�ncia do formul�rio

implementation

{$R *.dfm} // Diretiva que associa o arquivo de design visual (DFM) ao c�digo

uses uPrincipal;

 		{$region 'OBSERVA��ES'}
 //TAG:1 - CHAVE PRIMARIA PK
 //TAG:2 - CAMPOS OBRIGATORIOS
 {$ENDREGION }

{$region 'FUN��ES E PROCEDURES'}
// Controle de bot�es, habilita ou desabilita os bot�es com base no estado do cadastro
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TBitBtn;
          pgcPrincipal: TPageControl; Flag:Boolean);
begin
    // Habilita ou desabilita os bot�es conforme o valor de 'Flag'
    btnNovo.Enabled     :=Flag;
    btnApagar.Enabled   :=Flag;
    btnAlterar.Enabled  :=Flag;

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

class function TfrmTelaHeranca.TenhoAcesso(aUsuarioId: Integer; aChave: string; aConexao: TZConnection): Boolean;
var Qry:TZQuery;
begin
	try
  	Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId '+
    						' FROM usuariosAcaoAcesso '+
                ' WHERE usuarioId = :usuarioId '+
                ' AND acaoAcessoId =(SELECT TOP 1 acaoAcessoId FROM acaoAcesso WHERE chave = :chave)'+
                ' AND ativo = 1');
    Qry.ParamByName('usuarioId').AsInteger	:= aUsuarioId;
    Qry.ParamByName('chave').AsString	:= aChave;

    Qry.Open;

    if Qry.IsEmpty then
    	Result := False;
  finally
  	if Assigned(Qry) then
    	FreeAndNil(Qry);

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
          MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' é um campo obrigatório' ,mtInformation,[mbOK],0);
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
  try
    // Lógica de exclusão do registro
    QryListagem.Delete; // Exemplo de exclusão via dataset
    Result := True;
  except
    on E: Exception do
    begin
      // Relança a exceção para o método chamador
      raise Exception.Create(E.Message);
    end;
  end;
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
  if not TenhoAcesso(oUsuarioLogado.codigo, Self.Name+'_'+TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK], 0);
    Abort;
  end;

	// Desabilita alguns bot�es e altera o estado para "inserir"
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, pgcPrincipal, false);
  EstadoDoCadastro:=ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
begin
	if not TenhoAcesso(oUsuarioLogado.codigo, Self.Name+'_'+TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
    begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK], 0);
    Abort;
  end;
end;

// A��o do bot�o "Alterar" para modificar um registro existente
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  if not TenhoAcesso(oUsuarioLogado.codigo, Self.Name+'_'+TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
   begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK], 0);
    Abort;
  end;

  // Desabilita alguns bot�es e altera o estado para "alterar"
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, pgcPrincipal, false);
  EstadoDoCadastro:=ecAlterar;
end;

// A��o do bot�o "Apagar" para Apagar um registro
procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if not TenhoAcesso(oUsuarioLogado.codigo, Self.Name + '_' + TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usuário: ' + oUsuarioLogado.nome + ', não tem permissão de acesso', mtWarning, [mbOK], 0);
    Abort;
  end;

  try
    if Apagar then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, pgcPrincipal, True);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      QryListagem.Refresh;
    end;
  except
    on E: Exception do
    begin
      // Verifica se é um erro de chave estrangeira
      if Pos('foreign key', LowerCase(E.Message)) > 0 then
        MessageDlg('O registro não pode ser excluído porque está vinculado a outros dados.', mtWarning, [mbOK], 0)
      else
        MessageDlg('Erro ao tentar apagar o registro: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;

  EstadoDoCadastro := ecNenhum;
end;

// A��o do bot�o "Cancelar" para cancelar uma opera��o em andamento
procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  // Restaura a interface ao estado padr�o ao cancelar
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro:=ecNenhum;
  LimparEdits;
end;

// A��o do bot�o "Gravar" para salvar um registro no banco de dados
procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if not TenhoAcesso(oUsuarioLogado.codigo, Self.Name+'_'+TBitBtn(Sender).Name, dtmPrincipal.ConexaoDB) then
    begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK], 0);
    Abort;
  end;

  if (ExisteCampoObrigatorio) then
    Abort;

  Try
    if Gravar(EstadoDoCadastro) then begin  //Metodo virtual
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, pgcPrincipal, true);
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

// A��o do bot�o "Fechar" para fechar o formul�rio
procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close; // Fecha o formul�rio
end;

// A��o executada quando o formul�rio � fechado
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close; // Fecha a query
  SalvarConfiguracaoColunas;
  inherited
end;

// A��o executada ao criar o formul�rio
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  // Configura a conex�o e associa os componentes
  QryListagem.Connection:=dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet:=QryListagem;
  grdListagem.DataSource:=dtsListagem;
  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
                        dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
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

    QryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, pgcPrincipal, true);

    CarregarConfiguracaoColunas;
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
procedure TfrmTelaHeranca.grdListagemColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  SalvarConfiguracaoColunas; // Salva a configura��o das colunas sempre que uma coluna � movida
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  // Alterna a cor de fundo das linhas
  if Odd(grdListagem.DataSource.DataSet.RecNo) then
    grdListagem.Canvas.Brush.Color := clWhite // Cor cinza claro para linhas �mpares
  else
    grdListagem.Canvas.Brush.Color := $00E9E9E9; // Cor branca para linhas pares

  // Verifica se a c�lula est� selecionada
  if (gdSelected in State) then
  begin
    grdListagem.Canvas.Brush.Color := RGB(165, 208, 247);; // Cor de fundo da c�lula selecionada  [
    grdListagem.Canvas.Font.Color := clBlack; // Mant�m a cor do texto preta ao selecionar
  end
  else
  begin
    grdListagem.Canvas.Font.Color := clBlack; // Cor do texto normal
  end;

  // Preenche o ret�ngulo da c�lula
  grdListagem.Canvas.FillRect(Rect);

  // Desenha o texto na c�lula
  grdListagem.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if DesabilitarAtalhoExportar then
    Exit; // Sai do procedimento se o atalho estiver desabilitado para esta tela

  // Verifica se Ctrl + Shift + E foi pressionado
  if (Shift = [ssCtrl, ssShift]) and (Key = Ord('E')) then
  begin
    pExportar.Visible := True; // Torna o painel visível
    pExportar.BringToFront; // Garante que o painel esteja na frente dos outros componentes
  end;
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName; // Atualiza o �ndice atual para ordenar os dados
  QryListagem.IndexFieldNames:=IndiceAtual; // Ordena os dados pelo campo clicado
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

{$REGION 'Salvar configura��es da coluna'}
procedure TfrmTelaHeranca.SalvarConfiguracaoColunas;
var
  I: Integer;
begin
  for I := 0 to grdListagem.Columns.Count - 1 do
  begin
    TArquivoIni.AtualizarIni(Name, 'Coluna' + IntToStr(I) + '_Nome', grdListagem.Columns[I].FieldName);
    TArquivoIni.AtualizarIni(Name, 'Coluna' + IntToStr(I) + '_Largura', IntToStr(grdListagem.Columns[I].Width));
    TArquivoIni.AtualizarIni(Name, 'Coluna' + IntToStr(I) + '_Posicao', IntToStr(grdListagem.Columns[I].Index));
  end;
end;

procedure TfrmTelaHeranca.btnFecharPanelClick(Sender: TObject);
begin
   pExportar.Visible := False;
end;

procedure TfrmTelaHeranca.CarregarConfiguracaoColunas;
var
  I, J, Largura, Posicao: Integer;
  ColunaNome: string;
begin
  for I := 0 to grdListagem.Columns.Count - 1 do
  begin
    ColunaNome := TArquivoIni.LerIni(Name, 'Coluna' + IntToStr(I) + '_Nome', grdListagem.Columns[I].FieldName);
    Largura := StrToIntDef(TArquivoIni.LerIni(Name, 'Coluna' + IntToStr(I) + '_Largura'), grdListagem.Columns[I].Width);
    Posicao := StrToIntDef(TArquivoIni.LerIni(Name, 'Coluna' + IntToStr(I) + '_Posicao'), grdListagem.Columns[I].Index);

    // Localiza a coluna correspondente pelo nome e aplica as configura��es de largura e posi��o
    for J := 0 to grdListagem.Columns.Count - 1 do
    begin
      if grdListagem.Columns[J].FieldName = ColunaNome then
      begin
        grdListagem.Columns[J].Width := Largura;
        grdListagem.Columns[J].Index := Posicao;
        Break;
      end;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Funções de atalhos exportar grid'}
procedure TfrmTelaHeranca.ExportarDBGridParaExcel(DBGrid: TDBGrid);
var
  ExcelApp, Workbook, Worksheet: OleVariant;
  Col, Row, ExcelCol: Integer;
  Range: OleVariant;
  ColumnTitle, CellValue: string;
begin
  try
    // Cria a instância do Excel
    ExcelApp := CreateOleObject('Excel.Application');
    ExcelApp.Visible := False;

    // Adiciona uma nova pasta de trabalho
    Workbook := ExcelApp.Workbooks.Add;
    Worksheet := Workbook.Worksheets[1];

    // Exporta os títulos das colunas, ignorando colunas com campos de imagem
    ExcelCol := 1; // Índice da coluna no Excel
    for Col := 0 to DBGrid.Columns.Count - 1 do
    begin
      if not (DBGrid.Columns[Col].Field.DataType in [ftGraphic, ftBlob]) then
      begin
        // Força o título "Status" para o campo correspondente
        if DBGrid.Columns[Col].FieldName = 'status' then
          ColumnTitle := 'Status'
        else
          ColumnTitle := DBGrid.Columns[Col].Title.Caption;

        Worksheet.Cells[1, ExcelCol] := ColumnTitle;
        Inc(ExcelCol);
      end;
    end;

    // Exporta os dados, ignorando colunas com campos de imagem
    DBGrid.DataSource.DataSet.First;
    Row := 2; // Começa na segunda linha porque a primeira é para os títulos
    while not DBGrid.DataSource.DataSet.Eof do
    begin
      ExcelCol := 1; // Reinicia o índice da coluna no Excel para cada nova linha
      for Col := 0 to DBGrid.Columns.Count - 1 do
      begin
        if not (DBGrid.Columns[Col].Field.DataType in [ftGraphic, ftBlob]) then
        begin
          // Obtém o valor da célula como string
          CellValue := DBGrid.Columns[Col].Field.AsString;

          // Verifica se o campo é CPF ou CNPJ e aplica o formato de texto usando Range
          if (DBGrid.Columns[Col].FieldName = 'cpfCnpj') then
          begin
            Worksheet.Cells[Row, ExcelCol] := '''' + CellValue; // Insere o valor como texto
          end
          else
          begin
            Worksheet.Cells[Row, ExcelCol] := CellValue;
          end;
          Inc(ExcelCol);
        end;
      end;
      Inc(Row);
      DBGrid.DataSource.DataSet.Next;
    end;

    // Adiciona bordas e formatação de tabela
    Range := Worksheet.Range[Worksheet.Cells[1, 1], Worksheet.Cells[Row - 1, ExcelCol - 1]];
    Range.Borders.Weight := 2; // Define bordas para a tabela
    Range.Borders.LineStyle := 1; // Define o estilo das bordas (contínuo)

    // Ajusta as colunas automaticamente
    Worksheet.Columns.AutoFit;

    // Torna o Excel visível e seleciona a planilha
    ExcelApp.Visible := True;
    ExcelApp.UserControl := True;

    // Libera os objetos
    Worksheet := Unassigned;
    Workbook := Unassigned;
    ExcelApp := Unassigned;

  except
    on E: Exception do
      ShowMessage('Erro ao exportar para o Excel: ' + E.Message);
  end;
end;

procedure TfrmTelaHeranca.btnExcelClick(Sender: TObject);
begin
  // Chama a função de exportação passando o grid da tela atual
  ExportarDBGridParaExcel(grdListagem);
end;

procedure TfrmTelaHeranca.ImprimirDBGrid(DBGrid: TDBGrid; OrientacaoPaisagem: Boolean);
var
  Col, Y, X, MaxColWidth: Integer;
  Texto: string;
  ColunaLargura: Integer;
begin
  // Configura a orientação da impressora
  if OrientacaoPaisagem then
    Printer.Orientation := poLandscape
  else
    Printer.Orientation := poPortrait;

  // Abre o diálogo de impressão
  if PrintDialog.Execute then
  begin
    Printer.BeginDoc; // Inicia o trabalho de impressão

    try
      Y := 100; // Define a posição inicial no eixo Y
      MaxColWidth := Printer.PageWidth div DBGrid.Columns.Count;

      // Ajuste de largura das colunas para cada coluna
      for Col := 0 to DBGrid.Columns.Count - 1 do
      begin
        Texto := DBGrid.Columns[Col].Title.Caption;
        ColunaLargura := Min(MaxColWidth, Printer.Canvas.TextWidth(Texto) + 50);
        Printer.Canvas.TextOut(100 + (Col * ColunaLargura), Y, Texto);
      end;

      // Move para a próxima linha após imprimir os títulos das colunas
      Inc(Y, Printer.Canvas.TextHeight('W') + 10);

      // Imprime os dados das linhas do DBGrid
      DBGrid.DataSource.DataSet.DisableControls;
      try
        DBGrid.DataSource.DataSet.First;
        while not DBGrid.DataSource.DataSet.Eof do
        begin
          X := 100; // Posição inicial de X para cada linha
          for Col := 0 to DBGrid.Columns.Count - 1 do
          begin
            Texto := DBGrid.Columns[Col].Field.AsString;
            Printer.Canvas.TextOut(X, Y, Texto);
            Inc(X, ColunaLargura); // Move X para a próxima coluna
          end;

          // Move para a próxima linha
          Inc(Y, Printer.Canvas.TextHeight('W') + 10);

          // Verifica se a posição Y excede o comprimento da página
          if Y > Printer.PageHeight - 100 then
          begin
            Printer.NewPage; // Inicia uma nova página se necessário
            Y := 100;        // Reinicia a posição Y
          end;

          // Passa para o próximo registro
          DBGrid.DataSource.DataSet.Next;
        end;
      finally
        DBGrid.DataSource.DataSet.EnableControls;
      end;

    finally
      Printer.EndDoc; // Finaliza o trabalho de impressão
    end;

    ShowMessage('Impressão concluída.');
  end;
end;

procedure TfrmTelaHeranca.btnImprimirClick(Sender: TObject);
begin
  ImprimirDBGrid(grdListagem, True); // Imprime em modo paisagem
end;

procedure TfrmTelaHeranca.ExportarParaTexto(DBGrid: TDBGrid; const FileName: string);
var
  SL: TStringList;
  Col: Integer;
  Line: string;
begin
  SL := TStringList.Create;
  try
    // Cabeçalho das colunas
    Line := '';
    for Col := 0 to DBGrid.Columns.Count - 1 do
      Line := Line + Format('%-20s', [DBGrid.Columns[Col].Title.Caption]); // Ajuste de largura
    SL.Add(Line);

    // Linhas de dados
    DBGrid.DataSource.DataSet.First;
    while not DBGrid.DataSource.DataSet.Eof do
    begin
      Line := '';
      for Col := 0 to DBGrid.Columns.Count - 1 do
        Line := Line + Format('%-20s', [DBGrid.Columns[Col].Field.AsString]); // Ajuste de largura
      SL.Add(Line);
      DBGrid.DataSource.DataSet.Next;
    end;

    // Salva o conteúdo em um arquivo de texto
    SL.SaveToFile(FileName);
    ShowMessage('Exportação para texto concluída!');
  finally
    SL.Free;
  end;
end;

procedure TfrmTelaHeranca.btnExportarCSVClick(Sender: TObject);
begin
  SaveDialog.Filter := 'CSV Files (*.csv)|*.csv';
  SaveDialog.DefaultExt := 'csv';
  SaveDialog.Title := 'Salvar como CSV';

  if SaveDialog.Execute then
  begin
    ExportarParaCSV(grdListagem, SaveDialog.FileName);
    ShowMessage('Exportação para CSV concluída e salva em "' + SaveDialog.FileName + '"');
  end;
end;

procedure TfrmTelaHeranca.btnExportarHTMLClick(Sender: TObject);
begin
  begin
  SaveDialog.Filter := 'HTML Files (*.html)|*.html';
  SaveDialog.DefaultExt := 'html';
  SaveDialog.Title := 'Salvar como HTML';

  if SaveDialog.Execute then
  begin
    ExportarParaHTML(grdListagem, SaveDialog.FileName);
    ShowMessage('Exportação para HTML concluída e salva em "' + SaveDialog.FileName + '"');
  end;
end;
end;

procedure TfrmTelaHeranca.ExportarParaHTML(DBGrid: TDBGrid; const FileName: string);
var
  HTMLFile: TextFile;
  Col, Row: Integer;
begin
  AssignFile(HTMLFile, FileName);
  Rewrite(HTMLFile);
  try
    // Cabeçalho HTML
    Writeln(HTMLFile, '<html><body><table border="1">');
    // Títulos das colunas
    Writeln(HTMLFile, '<tr>');
    for Col := 0 to DBGrid.Columns.Count - 1 do
      Writeln(HTMLFile, '<th>' + DBGrid.Columns[Col].Title.Caption + '</th>');
    Writeln(HTMLFile, '</tr>');

    // Linhas de dados
    DBGrid.DataSource.DataSet.First;
    while not DBGrid.DataSource.DataSet.Eof do
    begin
      Writeln(HTMLFile, '<tr>');
      for Col := 0 to DBGrid.Columns.Count - 1 do
        Writeln(HTMLFile, '<td>' + DBGrid.Columns[Col].Field.AsString + '</td>');
      Writeln(HTMLFile, '</tr>');
      DBGrid.DataSource.DataSet.Next;
    end;
    Writeln(HTMLFile, '</table></body></html>');
  finally
    CloseFile(HTMLFile);
  end;
  ShowMessage('Exportação para HTML concluída!');
end;

procedure TfrmTelaHeranca.ExportarParaCSV(DBGrid: TDBGrid; const FileName: string);
var
  CSVFile: TextFile;
  Col, Row: Integer;
begin
  AssignFile(CSVFile, FileName);
  Rewrite(CSVFile);
  try
    // Títulos das colunas
    for Col := 0 to DBGrid.Columns.Count - 1 do
    begin
      Write(CSVFile, DBGrid.Columns[Col].Title.Caption);
      if Col < DBGrid.Columns.Count - 1 then
        Write(CSVFile, ';');
    end;
    Writeln(CSVFile);

    // Linhas de dados
    DBGrid.DataSource.DataSet.First;
    while not DBGrid.DataSource.DataSet.Eof do
    begin
      for Col := 0 to DBGrid.Columns.Count - 1 do
      begin
        Write(CSVFile, DBGrid.Columns[Col].Field.AsString);
        if Col < DBGrid.Columns.Count - 1 then
          Write(CSVFile, ';');
      end;
      Writeln(CSVFile);
      DBGrid.DataSource.DataSet.Next;
    end;
  finally
    CloseFile(CSVFile);
  end;
  ShowMessage('Exportação para CSV concluída!');
end;


{$ENDREGION}

end .
