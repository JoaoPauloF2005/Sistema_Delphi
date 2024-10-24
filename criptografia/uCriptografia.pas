unit uCriptografia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmCriptografia = class(TForm)
    edtCriptografia: TEdit;
    edtDesCriptografia: TEdit;
    btnExecutar: TBitBtn;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCriptografia: TfrmCriptografia;

implementation

{$R *.dfm}


function Criptografar (const aEntrada:string) :string;
Var i, iQtdeEnt, iIntervalo:Integer;
  sSaida:string;
  sProximoCaracter :string;


  begin
    iIntervalo :=6;
    i          :=0;
    iQtdeEnt   :=0;

    if (aEntrada <> EmptyStr) then
    begin
      iQtdeEnt  := Length(aEntrada);
      for i := iQtdeEnt downto 1 do //FAZ O LOOP CONTRÁRIO
      begin
        sProximoCaracter := Copy(aEntrada, i, 1);
        sSaida := sSaida +(Char(Ord(sProximoCaracter[1]) + iIntervalo));
      end;
    end;
    Result:=sSaida;
  end;

function Descriptografar (const aEntrada:string) :string;
Var i, iQtdeEnt, iIntervalo:Integer;
  sSaida:string;
  sProximoCaracter :string;


  begin
    iIntervalo :=6;
    i          :=0;
    iQtdeEnt   :=0;

    if (aEntrada <> EmptyStr) then
    begin
      iQtdeEnt  := Length(aEntrada);
      for i := iQtdeEnt downto 1 do //FAZ O LOOP CONTRÁRIO
      begin
        sProximoCaracter := Copy(aEntrada, i, 1);
        sSaida := sSaida +(Char(Ord(sProximoCaracter[1]) - iIntervalo));
      end;
    end;
    Result:=sSaida;
  end;

procedure TfrmCriptografia.btnExecutarClick(Sender: TObject);
begin
  edtCriptografia.Text :=Criptografar(edtCriptografia.Text);
  edtDesCriptografia.Text := Descriptografar(edtCriptografia.Text);
end;

end.
