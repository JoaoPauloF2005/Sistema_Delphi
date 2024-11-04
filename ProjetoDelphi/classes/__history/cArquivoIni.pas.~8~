unit cArquivoIni;

interface

uses
  System.SysUtils, System.IniFiles, Vcl.Forms;

type
  TArquivoIni = class
  public
    class function ArquivoIni: string; static;
    class procedure AtualizarIni(aSecao, aEntrada, aValor: String); static;
    class function LerIni(aSecao, aEntrada: String; aValorPadrao: String = ''): String; static;
  end;

implementation

{ TArquivoIni }

class function TArquivoIni.ArquivoIni: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

class procedure TArquivoIni.AtualizarIni(aSecao, aEntrada, aValor: String);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ArquivoIni);
  try
    Ini.WriteString(aSecao, aEntrada, aValor);
  finally
    Ini.Free;
  end;
end;

class function TArquivoIni.LerIni(aSecao, aEntrada: String; aValorPadrao: String = ''): String;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ArquivoIni);
  try
    Result := Ini.ReadString(aSecao, aEntrada, aValorPadrao);
  finally
    Ini.Free;
  end;
end;

end.

