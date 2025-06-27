/* EcommerceLogico: */

CREATE TABLE ECommerce (
    nomeEcommerce VARCHAR,
    cnpjEcommerce VARCHAR,
    telefoneEcommerce VARCHAR,
    siteURLEcommerce VARCHAR,
    sobreNosEcommerce VARCHAR,
    politicaPrivacidadeEcommerce VARCHAR,
    politicaTroceEcommerce VARCHAR,
    horarioFuncionamentoEcommerce VARCHAR,
    enderecoEcommerce VARCHAR,
    emailEcommerce VARCHAR,
    IdEcommerce INTEGER PRIMARY KEY,
    dataCadastroEcommerce DATE,
    statusPlataformaEcommerce BOOLEAN,
    fk_Produto_IdProduto INTEGER,
    fk_Estoque_idEstoque INTEGER,
    fk_Cliente_Pedido_idCliente INTEGER,
    fk_Pagamento_idPagamento INTEGER
);

CREATE TABLE Produto (
    IdProduto INTEGER PRIMARY KEY,
    nomeProduto VARCHAR,
    descricaoProduto VARCHAR,
    precoUnitarioProduto DECIMAL,
    precoDoFornecedorProduto DECIMAL,
    quantidadeEmEstoqueProduto INTEGER,
    categoriaProduto VARCHAR,
    pesoProduto DECIMAL,
    alturaProduto DECIMAL,
    larguraProduto DECIMAL,
    materiaProduto VARCHAR,
    comprimentoProduto FLOAT,
    dataCadastroProduto DATE,
    codigoDeBarrasProduto VARCHAR,
    marcaProduto VARCHAR,
    statusProduto BOOLEAN,
    quantidadeEstoque INTEGER
);

CREATE TABLE Fornecedor (
    idFornecedor INTEGER PRIMARY KEY,
    nomeFornecedor VARCHAR,
    cnpjFornecedor VARCHAR,
    telefoneFornecedor VARCHAR,
    enderecoFornecedor VARCHAR,
    tipoProdutoFornecedor VARCHAR,
    emailFornecedor VARCHAR,
    dataCadastroFornecedor DATE,
    statusFornecedor BOOLEAN
);

CREATE TABLE Funcionario (
    nomeFuncionario VARCHAR,
    telefoneFuncionario VARCHAR,
    enderecoFuncionario VARCHAR,
    senhaHashFuncionario VARCHAR,
    cargoFuncionario VARCHAR,
    cpfFuncionario VARCHAR,
    loginFuncionario VARCHAR,
    emailFuncionario VARCHAR,
    idFuncionario INTEGER PRIMARY KEY,
    salarioFuncionario DECIMAL,
    dataAdmicionalFuncionario DATE,
    statusFuncionario BOOLEAN,
    fk_ECommerce_IdEcommerce INTEGER
);

CREATE TABLE Estoque (
    IdProduto INTEGER,
    dataAtualizacaoEstoque DATE,
    quantidadeDisponivelEstoque INTEGER,
    idEstoque INTEGER PRIMARY KEY,
    localizacaoEstoque VARCHAR,
    quantidadeEstoque INTEGER,
    minimoEstoque INTEGER,
    maximoEstouque INTEGER,
    fk_Produto_IdProduto INTEGER,
    fk_Pedido_idPedido INTEGER
);

CREATE TABLE Cliente_Pedido (
    idCliente INTEGER,
    telefoneCliente VARCHAR,
    enderecoCliente VARCHAR,
    enderecoEntrega VARCHAR,
    loginCliente VARCHAR,
    cpfCliente VARCHAR,
    nomeCliente VARCHAR,
    statusCliente BOOLEAN,
    senhaHashCliente VARCHAR,
    valorTotalPedido DECIMAL,
    statusPedido BOOLEAN,
    idProduto INTEGER,
    IdEntrega INTEGER,
    IdPagamento INTEGER,
    quantidadeEstoque INTEGER,
    idPedido INTEGER,
    idCliente INTEGER,
    dataPedido DATE,
    precoUnitarioProduto DECIMAL,
    fk_Funcionario_idFuncionario INTEGER,
    PRIMARY KEY (idCliente, idPedido)
);

CREATE TABLE Pagamento (
    idPagamento INTEGER PRIMARY KEY,
    IdPedido INTEGER,
    tipoPagamento VARCHAR,
    statusPagamento BOOLEAN,
    dataPagamento DATE,
    valorPagamento DECIMAL,
    comprovantePagamento BLOB
);

CREATE TABLE Entrega (
    idPedido INTEGER,
    dataEnvioEntrega DATE,
    dataFeitaEntrega DATE,
    codigoRastreioEntrega VARCHAR,
    statusEntrega BOOLEAN,
    enderecoEntrega VARCHAR,
    transpotadoraEntrega VARCHAR,
    dataPrevistaEntrega DATE,
    idEntrega INTEGER PRIMARY KEY,
    fk_Cliente_Pedido_idCliente INTEGER,
    fk_Cliente_Pedido_idPedido INTEGER
);

CREATE TABLE Fornecer (
    fk_ECommerce_IdEcommerce INTEGER,
    fk_Fornecedor_idFornecedor INTEGER
);

CREATE TABLE Administrar (
    fk_Estoque_idEstoque INTEGER,
    fk_Funcionario_idFuncionario INTEGER
);

CREATE TABLE Auxiliar (
    fk_Cliente_Pedido_idCliente INTEGER,
    fk_Funcionario_idFuncionario INTEGER
);

CREATE TABLE Pagar (
    fk_Pagamento_idPagamento INTEGER,
    fk_Cliente_Pedido_idCliente INTEGER
);

CREATE TABLE Autorizar (
    fk_Cliente_Pedido_idCliente INTEGER,
    fk_Cliente_Pedido_idPedido INTEGER,
    fk_Pagamento_idPagamento INTEGER
);

CREATE TABLE Receber (
    fk_Cliente_Pedido_idCliente INTEGER,
    fk_Cliente_Pedido_idPedido INTEGER,
    fk_Entrega_idEntrega INTEGER
);

CREATE TABLE ItensPedidos (
    fk_Produto_IdProduto INTEGER,
    fk_Cliente_Pedido_idCliente INTEGER,
    fk_Cliente_Pedido_idPedido INTEGER
);
 
ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_2
    FOREIGN KEY (fk_Produto_IdProduto)
    REFERENCES Produto (IdProduto)
    ON DELETE RESTRICT;
 
ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_3
    FOREIGN KEY (fk_Estoque_idEstoque)
    REFERENCES Estoque (idEstoque)
    ON DELETE RESTRICT;
 
ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_4
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, ???)
    REFERENCES Cliente_Pedido (idCliente, ???)
    ON DELETE RESTRICT;
 
ALTER TABLE ECommerce ADD CONSTRAINT FK_ECommerce_5
    FOREIGN KEY (fk_Pagamento_idPagamento)
    REFERENCES Pagamento (idPagamento)
    ON DELETE RESTRICT;
 
ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario_2
    FOREIGN KEY (fk_ECommerce_IdEcommerce)
    REFERENCES ECommerce (IdEcommerce)
    ON DELETE CASCADE;
 
ALTER TABLE Estoque ADD CONSTRAINT FK_Estoque_2
    FOREIGN KEY (fk_Produto_IdProduto)
    REFERENCES Produto (IdProduto)
    ON DELETE CASCADE;
 
ALTER TABLE Estoque ADD CONSTRAINT FK_Estoque_3
    FOREIGN KEY (fk_Pedido_idPedido)
    REFERENCES ??? (???);
 
ALTER TABLE Cliente_Pedido ADD CONSTRAINT FK_Cliente_Pedido_2
    FOREIGN KEY (fk_Funcionario_idFuncionario)
    REFERENCES Funcionario (idFuncionario)
    ON DELETE CASCADE;
 
ALTER TABLE Entrega ADD CONSTRAINT FK_Entrega_2
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido)
    ON DELETE RESTRICT;
 
ALTER TABLE Fornecer ADD CONSTRAINT FK_Fornecer_1
    FOREIGN KEY (fk_ECommerce_IdEcommerce)
    REFERENCES ECommerce (IdEcommerce)
    ON DELETE RESTRICT;
 
ALTER TABLE Fornecer ADD CONSTRAINT FK_Fornecer_2
    FOREIGN KEY (fk_Fornecedor_idFornecedor)
    REFERENCES Fornecedor (idFornecedor)
    ON DELETE RESTRICT;
 
ALTER TABLE Administrar ADD CONSTRAINT FK_Administrar_1
    FOREIGN KEY (fk_Estoque_idEstoque)
    REFERENCES Estoque (idEstoque)
    ON DELETE SET NULL;
 
ALTER TABLE Administrar ADD CONSTRAINT FK_Administrar_2
    FOREIGN KEY (fk_Funcionario_idFuncionario)
    REFERENCES Funcionario (idFuncionario)
    ON DELETE SET NULL;
 
ALTER TABLE Auxiliar ADD CONSTRAINT FK_Auxiliar_1
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, ???)
    REFERENCES Cliente_Pedido (idCliente, ???)
    ON DELETE SET NULL;
 
ALTER TABLE Auxiliar ADD CONSTRAINT FK_Auxiliar_2
    FOREIGN KEY (fk_Funcionario_idFuncionario)
    REFERENCES Funcionario (idFuncionario)
    ON DELETE SET NULL;
 
ALTER TABLE Pagar ADD CONSTRAINT FK_Pagar_1
    FOREIGN KEY (fk_Pagamento_idPagamento)
    REFERENCES Pagamento (idPagamento)
    ON DELETE RESTRICT;
 
ALTER TABLE Pagar ADD CONSTRAINT FK_Pagar_2
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, ???)
    REFERENCES Cliente_Pedido (idCliente, ???)
    ON DELETE RESTRICT;
 
ALTER TABLE Autorizar ADD CONSTRAINT FK_Autorizar_1
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido)
    ON DELETE RESTRICT;
 
ALTER TABLE Autorizar ADD CONSTRAINT FK_Autorizar_2
    FOREIGN KEY (fk_Pagamento_idPagamento)
    REFERENCES Pagamento (idPagamento)
    ON DELETE SET NULL;
 
ALTER TABLE Receber ADD CONSTRAINT FK_Receber_1
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido)
    ON DELETE RESTRICT;
 
ALTER TABLE Receber ADD CONSTRAINT FK_Receber_2
    FOREIGN KEY (fk_Entrega_idEntrega)
    REFERENCES Entrega (idEntrega)
    ON DELETE SET NULL;
 
ALTER TABLE ItensPedidos ADD CONSTRAINT FK_ItensPedidos_1
    FOREIGN KEY (fk_Produto_IdProduto)
    REFERENCES Produto (IdProduto)
    ON DELETE RESTRICT;
 
ALTER TABLE ItensPedidos ADD CONSTRAINT FK_ItensPedidos_2
    FOREIGN KEY (fk_Cliente_Pedido_idCliente, fk_Cliente_Pedido_idPedido)
    REFERENCES Cliente_Pedido (idCliente, idPedido)
    ON DELETE RESTRICT;