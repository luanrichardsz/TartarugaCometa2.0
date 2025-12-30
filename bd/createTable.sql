CREATE TABLE Endereco (
    idEndereco SERIAL PRIMARY KEY,
    cep VARCHAR(9),
    cidade VARCHAR(58),
    rua VARCHAR(80),
    numero VARCHAR(10),
    bairro VARCHAR(50),
    estado VARCHAR(50),
    complemento VARCHAR(100)
);

CREATE TABLE Cliente (
    idCliente SERIAL PRIMARY KEY,
    nome VARCHAR(180),
    cpf_cnpj VARCHAR(18) UNIQUE,
    razaoSocial VARCHAR(170) UNIQUE,
    isFisico BOOLEAN,
    Endereco_ID INTEGER REFERENCES Endereco(idEndereco) ON DELETE SET NULL,
    ativo BOOLEAN DEFAULT TRUE 
);

CREATE TABLE Produto (
    idProduto SERIAL PRIMARY KEY,
    nome VARCHAR(40),
    peso DOUBLE PRECISION,
    volume INTEGER CHECK (volume >= 0), 
    valor NUMERIC(10,2),
    descricao VARCHAR(80),
    Cliente_ID INTEGER REFERENCES Cliente(IdCliente) ON DELETE CASCADE,
    ativo BOOLEAN DEFAULT TRUE 
);

CREATE TABLE Entrega (
    idEntrega SERIAL PRIMARY KEY,
    realizada BOOLEAN DEFAULT FALSE,
    clienteRemetente_ID INTEGER REFERENCES Cliente(idCliente),
    clienteDestinatario_ID INTEGER REFERENCES Cliente(idCliente)
);

CREATE TABLE Produto_Entrega (
    entrega_ID INTEGER REFERENCES Entrega (idEntrega) ON DELETE CASCADE,
    produto_ID INTEGER REFERENCES Produto (idProduto),
    quantidade INTEGER,
    frete NUMERIC(10,2) 
);

DROP TABLE Endereco, Cliente, Produto, Entrega, Produto_Entrega;
we