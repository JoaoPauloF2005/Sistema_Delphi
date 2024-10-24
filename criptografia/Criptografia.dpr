program Criptografia;

uses
  Vcl.Forms,
  uCriptografia in 'uCriptografia.pas' {frmCriptografia};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCriptografia, frmCriptografia);
  Application.Run;
end.
