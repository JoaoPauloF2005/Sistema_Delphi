unit cUsuarioLogado;

interface

uses System.Classes;

type
  TUsuarioLogado = class
  private
    F_usuarioId:Integer;
    F_nome:String;
    F_senha: string;

  public


  published
    property codigo        :Integer    read F_usuarioId      write F_usuarioId;
    property nome          :string     read F_nome           write F_nome;
    property senha         :string     read F_senha          write F_senha;
  end;


implementation



end.
