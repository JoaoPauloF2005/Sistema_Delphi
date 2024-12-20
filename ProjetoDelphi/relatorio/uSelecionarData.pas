unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, System.DateUtils;

type
  TfrmSelecionarData = class(TForm)
    Label3: TLabel;
    EdtDataInicio: TDateEdit;
    Label1: TLabel;
    EdtDataFinal: TDateEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.BitBtn1Click(Sender: TObject);
begin
  if (EdtDataFinal.Date) < (EdtDataInicio.Date) then
  begin
    MessageDlg('Data Final n�o pode ser menor que a Data In�cio', mtInformation, [mbOK], 0);
    EdtDataFinal.SetFocus;
    Abort;
  end;

  if (EdtDataFinal.Date = 0) or (EdtDataInicio.Date = 0) then
  begin
    MessageDlg('Data Inicial ou Final s�o campos obrigat�rios', mtInformation, [mbOK], 0);
    EdtDataInicio.SetFocus;
    Abort;
  end;

  ModalResult := mrOk;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
	EdtDataInicio.Date := StartOfTheMonth(Date);
  EdtDataFinal.Date := EndOfTheMonth(Date);
end;

end.

