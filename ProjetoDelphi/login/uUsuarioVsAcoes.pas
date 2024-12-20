﻿unit uUsuarioVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmUsuarioVsAcoes = class(TForm)
    Panel3: TPanel;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    QryUsuario: TZQuery;
    QryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    QryUsuariousuarioID: TIntegerField;
    QryUsuarioNome: TWideStringField;
    QryAcoesusuarioId: TIntegerField;
    QryAcoesacaoAcessoId: TIntegerField;
    QryAcoesdescricao: TWideStringField;
    QryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure QryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

uses
  uDTMConexao;

{$R *.dfm}

procedure TfrmUsuarioVsAcoes.btnFecharClick(Sender: TObject);
begin
	Close;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDblClick(Sender: TObject);
var Qry:TZQuery;
    bmRegistroAtual:TBookmark;
begin
  try
    bmRegistroAtual := QryAcoes.GetBookmark;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=DtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuariosAcaoAcesso '+
                '   SET ativo=:ativo '+
                ' WHERE usuarioId=:usuarioId '+
                '   AND acaoAcessoId=:acaoAcessoId ');
    Qry.ParamByName('usuarioId').AsInteger    :=QryAcoes.FieldByName('usuarioId').AsInteger;
    Qry.ParamByName('acaoAcessoId').AsInteger :=QryAcoes.FieldByName('acaoAcessoId').AsInteger;
    Qry.ParamByName('ativo').AsBoolean        :=not QryAcoes.FieldByName('ativo').AsBoolean;
    Try

      DtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      DtmPrincipal.ConexaoDB.Commit;
    Except
      DtmPrincipal.ConexaoDB.Rollback;
    End;

  finally
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookmark(bmRegistroAtual);
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;

end;

procedure TfrmUsuarioVsAcoes.grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

// Alterna a cor de fundo das linhas
  if Odd(grdAcoes.DataSource.DataSet.RecNo) then
    grdAcoes.Canvas.Brush.Color := clWhite // Cor cinza claro para linhas �mpares
  else
    grdAcoes.Canvas.Brush.Color := $00E9E9E9; // Cor branca para linhas pares

  // Verifica se a c�lula est� selecionada
  if (gdSelected in State) then
  begin
    grdAcoes.Canvas.Brush.Color := RGB(165, 208, 247);; // Cor de fundo da c�lula selecionada  [
    grdAcoes.Canvas.Font.Color := clBlack; // Mant�m a cor do texto preta ao selecionar
  end
  else
  begin
    grdAcoes.Canvas.Font.Color := clBlack; // Cor do texto normal
  end;

  // Preenche o ret�ngulo da c�lula
  grdAcoes.Canvas.FillRect(Rect);

  // Desenha o texto na c�lula
  grdAcoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);


	if not QryAcoes.FieldByName('ativo').AsBoolean then
  begin
    TDBGrid(Sender).Canvas.Font.Color := clWhite;
    TDBGrid(Sender).Canvas.Brush.Color := clRed;
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).Columns[DataCol].Field, State);
end;

procedure TfrmUsuarioVsAcoes.grdUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  // Alterna a cor de fundo das linhas
  if Odd(grdUsuarios.DataSource.DataSet.RecNo) then
    grdUsuarios.Canvas.Brush.Color := clWhite // Cor cinza claro para linhas �mpares
  else
    grdUsuarios.Canvas.Brush.Color := $00E9E9E9; // Cor branca para linhas pares

  // Verifica se a c�lula est� selecionada
  if (gdSelected in State) then
  begin
    grdUsuarios.Canvas.Brush.Color := RGB(165, 208, 247);; // Cor de fundo da c�lula selecionada  [
    grdUsuarios.Canvas.Font.Color := clBlack; // Mant�m a cor do texto preta ao selecionar
  end
  else
  begin
    grdUsuarios.Canvas.Font.Color := clBlack; // Cor do texto normal
  end;

  // Preenche o ret�ngulo da c�lula
  grdUsuarios.Canvas.FillRect(Rect);

  // Desenha o texto na c�lula
  grdUsuarios.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmUsuarioVsAcoes.FormShow(Sender: TObject);
begin
	try
    QryUsuario.DisableControls;
    QryUsuario.Open;
    SelecionarAcoesAcessoPorUsuario;
  finally
  	QryUsuario.EnableControls;
  end;
end;

procedure TfrmUsuarioVsAcoes.QryUsuarioAfterScroll(DataSet: TDataSet);
begin
	SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuarioVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
	QryAcoes.Close;
  QryAcoes.ParamByName('usuarioId').AsInteger := QryUsuario.FieldByName('usuarioID').AsInteger;
  QryAcoes.Open;
end;

end.
