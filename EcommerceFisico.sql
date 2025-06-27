CREATE TABLE ECommerce (
    nomeEcommerce VARCHAR(255),
    cnpjEcommerce VARCHAR(18),
    telefoneEcommerce VARCHAR(20),
    siteURLEcommerce VARCHAR(255),
    sobreNosEcommerce VARCHAR(MAX),
    politicaPrivacidadeEcommerce VARCHAR(MAX),
    politicaTroceEcommerce VARCHAR(MAX),
    horarioFuncionamentoEcommerce VARCHAR(255),
    enderecoEcommerce VARCHAR(255),
    emailEcommerce VARCHAR(255),
    IdEcommerce INT PRIMARY KEY,
    dataCadastroEcommerce DATE,
    statusPlataformaEcommerce BIT,
    fk_Produto_IdProduto INT,
    fk_Estoque_idEstoque INT,
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT, -- Necessário para chave composta
    fk_Pagamento_idPagamento INT
);

CREATE TABLE Produto (
    IdProduto INT PRIMARY KEY,
    nomeProduto VARCHAR(255),
    descricaoProduto VARCHAR(MAX),
    precoUnitarioProduto DECIMAL(10,2),
    precoDoFornecedorProduto DECIMAL(10,2),
    quantidadeEmEstoqueProduto INT,
    categoriaProduto VARCHAR(255),
    pesoProduto DECIMAL(10,2),
    alturaProduto DECIMAL(10,2),
    larguraProduto DECIMAL(10,2),
    materiaProduto VARCHAR(255),
    comprimentoProduto DECIMAL(10,2),
    dataCadastroProduto DATE,
    codigoDeBarrasProduto VARCHAR(50),
    marcaProduto VARCHAR(255),
    statusProduto BIT,
    quantidadeEstoque INT
);

CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    nomeFornecedor VARCHAR(255),
    cnpjFornecedor VARCHAR(18),
    telefoneFornecedor VARCHAR(20),
    enderecoFornecedor VARCHAR(255),
    tipoProdutoFornecedor VARCHAR(255),
    emailFornecedor VARCHAR(255),
    dataCadastroFornecedor DATE,
    statusFornecedor BIT
);

CREATE TABLE Funcionario (
    nomeFuncionario VARCHAR(255),
    telefoneFuncionario VARCHAR(20),
    enderecoFuncionario VARCHAR(255),
    senhaHashFuncionario VARCHAR(255),
    cargoFuncionario VARCHAR(100),
    cpfFuncionario VARCHAR(11),
    loginFuncionario VARCHAR(100),
    emailFuncionario VARCHAR(255),
    idFuncionario INT PRIMARY KEY,
    salarioFuncionario DECIMAL(10,2),
    dataAdmicionalFuncionario DATE,
    statusFuncionario BIT,
    fk_ECommerce_IdEcommerce INT
);

CREATE TABLE Estoque (
    IdProduto INT,
    dataAtualizacaoEstoque DATE,
    quantidadeDisponivelEstoque INT,
    idEstoque INT PRIMARY KEY,
    localizacaoEstoque VARCHAR(255),
    quantidadeEstoque INT,
    minimoEstoque INT,
    maximoEstouque INT,
    fk_Produto_IdProduto INT,
    fk_Pedido_idPedido INT
);

CREATE TABLE Cliente_Pedido (
    idCliente INT,
    telefoneCliente VARCHAR(20),
    enderecoCliente VARCHAR(255),
    enderecoEntrega VARCHAR(255),
    loginCliente VARCHAR(100),
    cpfCliente VARCHAR(11),
    nomeCliente VARCHAR(255),
    statusCliente BIT,
    senhaHashCliente VARCHAR(255),
    valorTotalPedido DECIMAL(10,2),
    statusPedido BIT,
    idProduto INT,
    IdEntrega INT,
    IdPagamento INT,
    quantidadeEstoque INT,
    idPedido INT,
    dataPedido DATE,
    precoUnitarioProduto DECIMAL(10,2),
    fk_Funcionario_idFuncionario INT,
    PRIMARY KEY (idCliente, idPedido)
);

CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY,
    IdPedido INT,
    tipoPagamento VARCHAR(50),
    statusPagamento BIT,
    dataPagamento DATE,
    valorPagamento DECIMAL(10,2),
    comprovantePagamento VARBINARY(MAX)
);

CREATE TABLE Entrega (
    idPedido INT,
    dataEnvioEntrega DATE,
    dataFeitaEntrega DATE,
    codigoRastreioEntrega VARCHAR(100),
    statusEntrega BIT,
    enderecoEntrega VARCHAR(255),
    transpotadoraEntrega VARCHAR(255),
    dataPrevistaEntrega DATE,
    idEntrega INT PRIMARY KEY,
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT
);

-- Tabelas associativas
CREATE TABLE Fornecer (
    fk_ECommerce_IdEcommerce INT,
    fk_Fornecedor_idFornecedor INT
);

CREATE TABLE Administrar (
    fk_Estoque_idEstoque INT,
    fk_Funcionario_idFuncionario INT
);

CREATE TABLE Auxiliar (
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT,
    fk_Funcionario_idFuncionario INT
);

CREATE TABLE Pagar (
    fk_Pagamento_idPagamento INT,
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT
);

CREATE TABLE Autorizar (
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT,
    fk_Pagamento_idPagamento INT
);

CREATE TABLE Receber (
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT,
    fk_Entrega_idEntrega INT
);

CREATE TABLE ItensPedidos (
    fk_Produto_IdProduto INT,
    fk_Cliente_Pedido_idCliente INT,
    fk_Cliente_Pedido_idPedido INT
);

-- CHAVES ESTRANGEIRAS

ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_Produto
    FOREIGN KEY (fk_Produto_IdProduto) REFERENCES Produto (IdProduto);

ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_Estoque
    FOREIGN KEY (fk_Estoque_idEstoque) REFERENCES Estoque (idEstoque);

ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_Pagamento
    FOREIGN KEY (fk_Pagamento_idPagamento) REFERENCES Pagamento (idPagamento);

ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario_ECommerce
    FOREIGN KEY (fk_ECommerce_IdEcommerce) REFERENCES ECommerce (IdEcommerce);

ALTER TABLE Estoque ADD CONSTRAINT FK_Estoque_Produto
    FOREIGN KEY (fk_Produto_IdProduto) REFERENCES Produto (IdProduto);

-- OBS: fk_Pedido_idPedido precisa de referência válida; ajustado para Cliente_Pedido
ALTER TABLE Estoque ADD CONSTRAINT FK_Estoque_Pedido
    FOREIGN KEY (fk_Pedido_idPedido) REFERENCES Cliente_Pedido (idPedido);

ALTER TABLE Cliente_Pedido ADD CONSTRAINT FK_ClientePedido_Funcionario
    FOREIGN KEY (fk_Funcionario_idFuncionario) REFERENCES Funcionario (idFuncionario);

ALTER TABLE Entrega ADD CONSTRAINT FK_Entrega_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

ALTER TABLE Fornecer ADD CONSTRAINT FK_Fornecer_ECommerce
    FOREIGN KEY (fk_ECommerce_IdEcommerce) REFERENCES ECommerce (IdEcommerce);

ALTER TABLE Fornecer ADD CONSTRAINT FK_Fornecer_Fornecedor
    FOREIGN KEY (fk_Fornecedor_idFornecedor) REFERENCES Fornecedor (idFornecedor);

ALTER TABLE Administrar ADD CONSTRAINT FK_Administrar_Estoque
    FOREIGN KEY (fk_Estoque_idEstoque) REFERENCES Estoque (idEstoque);

ALTER TABLE Administrar ADD CONSTRAINT FK_Administrar_Funcionario
    FOREIGN KEY (fk_Funcionario_idFuncionario) REFERENCES Funcionario (idFuncionario);

ALTER TABLE Auxiliar ADD CONSTRAINT FK_Auxiliar_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

ALTER TABLE Auxiliar ADD CONSTRAINT FK_Auxiliar_Funcionario
    FOREIGN KEY (fk_Funcionario_idFuncionario) REFERENCES Funcionario (idFuncionario);

ALTER TABLE Pagar ADD CONSTRAINT FK_Pagar_Pagamento
    FOREIGN KEY (fk_Pagamento_idPagamento) REFERENCES Pagamento (idPagamento);

ALTER TABLE Pagar ADD CONSTRAINT FK_Pagar_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

ALTER TABLE Autorizar ADD CONSTRAINT FK_Autorizar_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

ALTER TABLE Autorizar ADD CONSTRAINT FK_Autorizar_Pagamento
    FOREIGN KEY (fk_Pagamento_idPagamento) REFERENCES Pagamento (idPagamento);

ALTER TABLE Receber ADD CONSTRAINT FK_Receber_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

ALTER TABLE Receber ADD CONSTRAINT FK_Receber_Entrega
    FOREIGN KEY (fk_Entrega_idEntrega) REFERENCES Entrega (idEntrega);

ALTER TABLE ItensPedidos ADD CONSTRAINT FK_ItensPedidos_Produto
    FOREIGN KEY (fk_Produto_IdProduto)
    REFERENCES Produto (IdProduto);

ALTER TABLE ItensPedidos ADD CONSTRAINT FK_ItensPedidos_ClientePedido
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido);

