CREATE DATABASE PassoFirmeCalçadosS_A;
GO

USE PassoFirmeCalçadosS_A;
GO


CREATE TABLE Empresa (
    IdEmpresa INT IDENTITY PRIMARY KEY,
    RazaoSocial VARCHAR(150),
    NomeFantasia VARCHAR(150),
    CNPJ VARCHAR(18),
    DataFundacao DATE
); 


CREATE TABLE Filial (
    IdFilial INT IDENTITY PRIMARY KEY,
    IdEmpresa INT,
    NomeFilial VARCHAR(100),
    Cidade VARCHAR(100),
    Estado VARCHAR(50),
    TipoFilial VARCHAR(50),
    FOREIGN KEY (IdEmpresa) REFERENCES Empresa(IdEmpresa)
);


CREATE TABLE Cliente (
    IdCliente INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(150),
    CPF VARCHAR(14),
    Email VARCHAR(150),
    Telefone VARCHAR(20),
    Cidade VARCHAR(100),
    Estado VARCHAR(50),
    DataCadastro DATE
);


CREATE TABLE Funcionario (
    IdFuncionario INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(150),
    CPF VARCHAR(14),
    DataAdmissao DATE,
    Salario DECIMAL(10,2),
    IdFilial INT,
    IdCargo INT
);


CREATE TABLE Cargo (
    IdCargo INT IDENTITY PRIMARY KEY,
    NomeCargo VARCHAR(100)
);


CREATE TABLE Fornecedor (
    IdFornecedor INT IDENTITY PRIMARY KEY,
    NomeFornecedor VARCHAR(150),
    CNPJ VARCHAR(18),
    Cidade VARCHAR(100),
    Estado VARCHAR(50),
    Telefone VARCHAR(20)
);



CREATE TABLE Categoria (
    IdCategoria INT IDENTITY PRIMARY KEY,
    NomeCategoria VARCHAR(100)
);



CREATE TABLE Marca (
    IdMarca INT IDENTITY PRIMARY KEY,
    NomeMarca VARCHAR(100)
);



CREATE TABLE Produto (
    IdProduto INT IDENTITY PRIMARY KEY,
    NomeProduto VARCHAR(150),
    IdCategoria INT,
    IdMarca INT,
    PrecoVenda DECIMAL(10,2),
    Custo DECIMAL(10,2),
    Ativo BIT,
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
    FOREIGN KEY (IdMarca) REFERENCES Marca(IdMarca)
);



CREATE TABLE Estoque (
    IdEstoque INT IDENTITY PRIMARY KEY,
    IdProduto INT,
    IdFilial INT,
    Quantidade INT,
    FOREIGN KEY (IdProduto) REFERENCES Produto(IdProduto),
    FOREIGN KEY (IdFilial) REFERENCES Filial(IdFilial)
);



CREATE TABLE MovimentacaoEstoque (
    IdMovimento INT IDENTITY PRIMARY KEY,
    IdProduto INT,
    IdFilial INT,
    TipoMovimento VARCHAR(50),
    Quantidade INT,
    DataMovimento DATETIME
);




CREATE TABLE PedidoVenda (
    IdPedido INT IDENTITY PRIMARY KEY,
    IdCliente INT,
    IdFilial INT,
    DataPedido DATETIME,
    ValorTotal DECIMAL(12,2),
    StatusPedido VARCHAR(50)
);



CREATE TABLE PedidoVendaItem (
    IdItem INT IDENTITY PRIMARY KEY,
    IdPedido INT,
    IdProduto INT,
    Quantidade INT,
    ValorUnitario DECIMAL(10,2),
    ValorTotal DECIMAL(10,2)
);



CREATE TABLE PedidoCompra (
    IdPedidoCompra INT IDENTITY PRIMARY KEY,
    IdFornecedor INT,
    DataPedido DATE,
    ValorTotal DECIMAL(12,2)
);



CREATE TABLE PedidoCompraItem (
    IdItem INT IDENTITY PRIMARY KEY,
    IdPedidoCompra INT,
    IdProduto INT,
    Quantidade INT,
    ValorUnitario DECIMAL(10,2)
);



CREATE TABLE ContasReceber (
    IdReceber INT IDENTITY PRIMARY KEY,
    IdPedido INT,
    Valor DECIMAL(12,2),
    DataVencimento DATE,
    Status VARCHAR(50)
);




CREATE TABLE ContasPagar (
    IdPagar INT IDENTITY PRIMARY KEY,
    IdPedidoCompra INT,
    Valor DECIMAL(12,2),
    DataVencimento DATE,
    Status VARCHAR(50)
);





CREATE TABLE NotaFiscal (
    IdNotaFiscal INT IDENTITY PRIMARY KEY,
    NumeroNota VARCHAR(20),
    IdPedido INT,
    DataEmissao DATE,
    ValorTotal DECIMAL(12,2)
);





CREATE TABLE Transportadora (
    IdTransportadora INT IDENTITY PRIMARY KEY,
    NomeTransportadora VARCHAR(150),
    CNPJ VARCHAR(18)
);






CREATE TABLE Entrega (
    IdEntrega INT IDENTITY PRIMARY KEY,
    IdPedido INT,
    IdTransportadora INT,
    DataEnvio DATE,
    DataEntrega DATE,
    StatusEntrega VARCHAR(50)
);



-- POPULANDO TABELAS

INSERT INTO Empresa (RazaoSocial, NomeFantasia, CNPJ, DataFundacao) VALUES
('Comercial Bressan LTDA','Bressan Store','12.345.678/0001-10','2010-03-10'),
('Grupo Lima Comercio SA','Lima Fashion','22.456.789/0001-20','2012-07-15'),
('Varejo Paulista LTDA','Paulista Store','33.567.890/0001-30','2015-01-20');


INSERT INTO Filial (IdEmpresa, NomeFilial, Cidade, Estado, TipoFilial) VALUES
(1,'Matriz Ribeirão','Ribeirão Preto','SP','Matriz'),
(1,'Filial Campinas','Campinas','SP','Loja'),
(2,'Filial São Paulo','São Paulo','SP','Loja'),
(3,'Filial Santos','Santos','SP','Loja');


INSERT INTO Cargo (NomeCargo) VALUES
('Vendedor'),
('Gerente'),
('Estoquista'),
('Financeiro'),
('Comprador');


INSERT INTO Funcionario (Nome, CPF, DataAdmissao, Salario, IdFilial, IdCargo) VALUES
('Carlos Silva','111.111.111-11','2022-01-10',3500,1,1),
('Mariana Souza','222.222.222-22','2021-05-15',6000,1,2),
('Pedro Lima','333.333.333-33','2023-03-20',2800,2,3),
('Fernanda Costa','444.444.444-44','2022-11-10',4000,3,4);


INSERT INTO Cliente (Nome, CPF, Email, Telefone, Cidade, Estado, DataCadastro) VALUES
('João Pereira','123.456.789-10','joao@email.com','16999999999','Ribeirão Preto','SP','2024-01-10'),
('Ana Martins','234.567.890-11','ana@email.com','16988888888','Campinas','SP','2024-02-12'),
('Lucas Andrade','345.678.901-22','lucas@email.com','16977777777','São Paulo','SP','2024-03-05');


--FORNECEDOR

INSERT INTO Fornecedor (NomeFornecedor, CNPJ, Cidade, Estado, Telefone) VALUES
('Fornecedor Moda Brasil','44.555.666/0001-10','São Paulo','SP','1133334444'),
('Distribuidora Têxtil','55.666.777/0001-20','Campinas','SP','1933335555');

--7️⃣ CATEGORIA

INSERT INTO Categoria (NomeCategoria) VALUES
('Camisetas'),
('Calças'),
('Jaquetas'),
('Sapatos');

--8️⃣ MARCA

INSERT INTO Marca (NomeMarca) VALUES
('Nike'),
('Adidas'),
('Puma'),
('Reserva');

--9️⃣ PRODUTO

INSERT INTO Produto (NomeProduto, IdCategoria, IdMarca, PrecoVenda, Custo, Ativo) VALUES
('Camiseta Nike Dry',1,1,120,60,1),
('Calça Adidas Sport',2,2,220,120,1),
('Jaqueta Puma Winter',3,3,350,200,1),
('Tênis Nike Air',4,1,450,250,1);

--🔟 ESTOQUE

INSERT INTO Estoque (IdProduto, IdFilial, Quantidade) VALUES
(1,1,100),
(2,1,80),
(3,2,50),
(4,3,40);

--11️⃣ MOVIMENTAÇÃO ESTOQUE

INSERT INTO MovimentacaoEstoque (IdProduto, IdFilial, TipoMovimento, Quantidade, DataMovimento) VALUES
(1,1,'ENTRADA',100,GETDATE()),
(2,1,'ENTRADA',80,GETDATE()),
(3,2,'ENTRADA',50,GETDATE()),
(4,3,'ENTRADA',40,GETDATE());

--12️⃣ PEDIDO VENDA

INSERT INTO PedidoVenda (IdCliente, IdFilial, DataPedido, ValorTotal, StatusPedido) VALUES
(1,1,GETDATE(),240,'FATURADO'),
(2,2,GETDATE(),220,'PENDENTE'),
(3,3,GETDATE(),450,'FATURADO');

--13️⃣ PEDIDO VENDA ITEM

INSERT INTO PedidoVendaItem (IdPedido, IdProduto, Quantidade, ValorUnitario, ValorTotal) VALUES
(1,1,2,120,240),
(2,2,1,220,220),
(3,4,1,450,450);

--14️⃣ PEDIDO COMPRA

INSERT INTO PedidoCompra (IdFornecedor, DataPedido, ValorTotal) VALUES
(1,'2025-01-10',5000),
(2,'2025-02-10',8000);

--15️⃣ PEDIDO COMPRA ITEM

INSERT INTO PedidoCompraItem (IdPedidoCompra, IdProduto, Quantidade, ValorUnitario) VALUES
(1,1,50,60),
(1,2,30,120),
(2,3,20,200);

--16️⃣ CONTAS RECEBER

INSERT INTO ContasReceber (IdPedido, Valor, DataVencimento, Status) VALUES
(1,240,'2025-03-10','PAGO'),
(2,220,'2025-03-15','PENDENTE'),
(3,450,'2025-03-20','PAGO');

--17️⃣ CONTAS PAGAR

INSERT INTO ContasPagar (IdPedidoCompra, Valor, DataVencimento, Status) VALUES
(1,5000,'2025-04-10','PENDENTE'),
(2,8000,'2025-04-15','PENDENTE');

--18️⃣ NOTA FISCAL

INSERT INTO NotaFiscal (NumeroNota, IdPedido, DataEmissao, ValorTotal) VALUES
('10001',1,GETDATE(),240),
('10002',3,GETDATE(),450);

--19️⃣ TRANSPORTADORA

INSERT INTO Transportadora (NomeTransportadora, CNPJ) VALUES
('Transportadora Rápido Brasil','66.777.888/0001-00'),
('Logística Express','77.888.999/0001-11');

--20️⃣ ENTREGA

INSERT INTO Entrega (IdPedido, IdTransportadora, DataEnvio, DataEntrega, StatusEntrega) VALUES
(1,1,GETDATE(),GETDATE(),'ENTREGUE'),
(2,2,GETDATE(),NULL,'EM TRANSPORTE'),
(3,1,GETDATE(),GETDATE(),'ENTREGUE');


-- 1️⃣ Gerar 100.000 CLIENTES (FORMA PROFISSIONAL)

--Criar listas de nomes e sobrenomes

DECLARE @PrimeiroNome TABLE (Nome VARCHAR(50))
INSERT INTO @PrimeiroNome VALUES
('João'),('Maria'),('José'),('Ana'),('Carlos'),('Paulo'),('Pedro'),
('Lucas'),('Gabriel'),('Rafael'),('Bruno'),('Ricardo'),('Fernando'),
('Mariana'),('Juliana'),('Patricia'),('Camila'),('Larissa'),
('Amanda'),('Beatriz'),('Eduardo'),('Gustavo'),('Marcelo')

DECLARE @Sobrenome TABLE (Sobrenome VARCHAR(50))
INSERT INTO @Sobrenome VALUES
('Silva'),('Santos'),('Oliveira'),('Souza'),('Rodrigues'),
('Ferreira'),('Alves'),('Pereira'),('Lima'),('Gomes'),
('Costa'),('Ribeiro'),('Martins'),('Carvalho'),
('Almeida'),('Barbosa'),('Cardoso'),('Teixeira'),
('Correia'),('Moura'),('Rocha')



WITH Numeros AS
(
SELECT TOP 100000
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Num
FROM sys.objects a
CROSS JOIN sys.objects b
)

INSERT INTO Cliente
(Nome,CPF,Email,Telefone,Cidade,Estado,DataCadastro)

SELECT
p.Nome + ' ' + s.Sobrenome,
FORMAT(Num,'00000000000'),
LOWER(p.Nome)+Num+'@gmail.com',
'1699'+RIGHT('00000000'+CAST(Num AS VARCHAR),8),
'Ribeirão Preto',
'SP',
DATEADD(DAY,-ABS(CHECKSUM(NEWID())) % 1000,GETDATE())

FROM Numeros
CROSS APPLY (SELECT TOP 1 Nome FROM @PrimeiroNome ORDER BY NEWID()) p
CROSS APPLY (SELECT TOP 1 Sobrenome FROM @Sobrenome ORDER BY NEWID()) s



INSERT INTO Funcionario
(Nome,CPF,DataAdmissao,Salario,IdFilial,IdCargo)

SELECT TOP 200
p.Nome + ' ' + s.Sobrenome,
FORMAT(ABS(CHECKSUM(NEWID())) % 99999999999,'00000000000'),
DATEADD(DAY,-ABS(CHECKSUM(NEWID())) % 2000,GETDATE()),
ABS(CHECKSUM(NEWID())) % 5000 + 2000,
ABS(CHECKSUM(NEWID())) % 4 + 1,
ABS(CHECKSUM(NEWID())) % 5 + 1

FROM @PrimeiroNome p
CROSS JOIN @Sobrenome s
ORDER BY NEWID()