object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 224
  Width = 608
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Connected = True
    HostName = '.\SERVERCURSO'
    Port = 1433
    Database = 'vendas'
    User = 'sa'
    Password = 'domtec02'
    Protocol = 'mssql'
    LibraryLocation = 'C:\Users\devmv\Documents\JoaoPaulo\ProjetoDelphi\ntwdblib.dll'
    Left = 35
    Top = 40
  end
  object QryScriptCategorias: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'categorias'#39') IS NULL'
      'BEGIN'
      '  CREATE TABLE categorias('
      '    categoriaId int IDENTITY(1,1) NOT NULL,'
      '    descricao varchar(30) NULL,'
      '    PRIMARY KEY (categoriaId)'
      ')'
      'END')
    Params = <>
    Left = 251
    Top = 28
  end
  object QryScriptClientes: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'clientes'#39') IS NULL'
      'BEGIN'
      '  CREATE TABLE clientes('
      '    clienteId int IDENTITY(1,1) NOT NULL,'
      '    nome varchar(60) NULL,'
      '    endereco varchar(60) null,'
      '    cidade varchar(50) null,'
      '    bairro varchar(40) null,'
      '    estado varchar(2) null,'
      '    cep varchar(10) null,'
      '    telefone varchar(100) null,'
      '    email varchar (100) null,'
      '    dataNascimento datetime null,'
      '    PRIMARY KEY (clienteId),'
      '  )'
      '  END')
    Params = <>
    Left = 339
    Top = 25
  end
  object QryScriptProdutos: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'produtos'#39') IS NULL'
      'BEGIN'
      '  CREATE TABLE produtos('
      '    produtoId int IDENTITY(1,1) NOT NULL,'
      '    nome varchar(60) NULL,'
      '    descricao varchar(255) null,'
      '    valor decimal(18,5) default 0.00000 null,'
      '    quantidade decimal(18,5) default 0.00000 null,'
      '    categoriaId int null,'
      '    PRIMARY KEY (produtoId),'
      '    CONSTRAINT FK_ProdutosCategorias'
      '    FOREIGN KEY (categoriaId) references categorias(categoriaId)'
      '  )'
      '  END')
    Params = <>
    Left = 427
    Top = 29
  end
  object QryScriptVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'vendas'#39') IS NULL'
      'BEGIN'
      '  CREATE TABLE vendas ('
      '    vendaId int identity(1,1) not null,'
      '    clienteId int not null,'
      '    dataVenda datetime default getdate(),'
      '    totalVenda decimal(18,5) default 0.00000,'
      ''
      '    PRIMARY KEY (vendaId),'
      '    CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId)'
      '    REFERENCES clientes(clienteId)'
      '  )'
      'END;')
    Params = <>
    Left = 250
    Top = 78
  end
  object QryScriptItensVenda: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'vendasItens'#39') IS NULL'
      'BEGIN'
      '  CREATE TABLE vendasItens('
      '    vendaid int not null,'
      '    produtoId int not null,'
      '    valorUnitario decimal (18,5) default 0.00000,'
      '    quantidade decimal (18,5) default 0.00000,'
      '    totalProduto decimal (18,5) default 0.00000,'
      '    PRIMARY KEY (vendaId,produtoId),'
      '    CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId)'
      '    REFERENCES produtos(produtoId)'
      '  )'
      'END')
    Params = <>
    Left = 333
    Top = 81
  end
end
