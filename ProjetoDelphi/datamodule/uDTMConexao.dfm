object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 224
  Width = 608
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    AutoCommit = False
    TransactIsolationLevel = tiReadCommitted
    Connected = True
    HostName = '.\SERVERCURSO'
    Port = 1433
    Database = 'vendas'
    User = 'sa'
    Password = 'domtec02'
    Protocol = 'mssql'
    LibraryLocation = 'C:\Users\devmv\Documents\JoaoPaulo\ProjetoDelphi\ntwdblib.dll'
    Left = 31
    Top = 42
  end
end
