START TRANSACTION; -- STARTAR UM CHECKPOINT
BEGIN; -- STARTAR UM CHECKPOINT
ROLLBACK; -- DESFAZER O QUE VOCÊ FEZ E VOLTAR NO CHECKPOINT
COMMIT; -- SALVAR AS MUDANÇAS FEITAS

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
	Endereco_ID INTEGER REFERENCES Endereco(idEndereco) ON DELETE SET NULL
);

CREATE TABLE Produto (
	idProduto SERIAL PRIMARY KEY,
	nome VARCHAR(40),
	peso DOUBLE PRECISION,
	volume INTEGER,
	valor NUMERIC(10,2),
	descricao VARCHAR(80)
);

CREATE TABLE Entrega (
	idEntrega SERIAL PRIMARY KEY,
	realizada BOOLEAN default false,
	clienteRemetente_ID INTEGER REFERENCES Cliente(idCliente), -- vindo da tabela CLIENTE
	clienteDestinatario_ID INTEGER REFERENCES Cliente(idCliente) -- vindo da tabela CLIENTE
);

CREATE TABLE Produto_Entrega (
	entrega_ID INTEGER REFERENCES Entrega (idEntrega) ON DELETE CASCADE,
	produto_ID INTEGER REFERENCES Produto (idProduto) ON DELETE CASCADE,
	quantidade INTEGER,
    frete INTEGER
);

DROP TABLE Endereco, Cliente, Produto, Entrega, Produto_Entrega;
