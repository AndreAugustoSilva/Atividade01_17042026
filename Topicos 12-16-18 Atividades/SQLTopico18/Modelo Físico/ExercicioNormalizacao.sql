CREATE DATABASE ManutencoesIndustriaDB;
USE ManutencoesIndustriaDB;

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_cliente VARCHAR(100),
    telefone_cliente CHAR(14),
    cidade_cliente VARCHAR(50)
);

CREATE TABLE Tecnicos (
    id_tecnico INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_tecnico VARCHAR(100),
    cargo_tecnico VARCHAR(50),
    telefone_tecnico CHAR(14)
);

CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_categoria VARCHAR(30),
    descricao_categoria TEXT
);

CREATE TABLE Equipamentos (
    id_equipamento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_equipamento VARCHAR(50),
    descricao_equipamento TEXT,

    id_categoria INT NOT NULL,

    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_fornecedor VARCHAR(100),
    cidade_fornecedor VARCHAR(50),
    telefone_fornecedor CHAR(14)
);

CREATE TABLE Pecas (
    id_peca INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_peca VARCHAR(30),
    valor_peca DECIMAL(9,2),
    quantidade_estoque_peca SMALLINT,

    id_fornecedor INT NOT NULL,

    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

CREATE TABLE OS (
    id_os INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    codigo_os CHAR(4),
    data_os DATE,

    id_cliente INT NOT NULL,
    id_equipamento INT NOT NULL,
    id_tecnico INT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamentos(id_equipamento),
    FOREIGN KEY (id_tecnico) REFERENCES Tecnicos(id_tecnico)
);

CREATE TABLE OS_Pecas (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,

    FOREIGN KEY (id_os) REFERENCES OS(id_os),
    FOREIGN KEY (id_peca) REFERENCES Pecas(id_peca)
);
INSERT INTO Clientes(nome_cliente, telefone_cliente, cidade_cliente) VALUES
("MetalSul", "(51)99999-1111", "Porto Alegre"),
("AutoMec", "(51)99999-1111", "Porto Alegre"),
("MetalSul", "(41)97777-2222", "Curitiba");

INSERT INTO Tecnicos(nome_tecnico, cargo_tecnico, telefone_tecnico) VALUES
("João Silva", "Técnico mecânico", "(51)98888-1111"),
("Maria Souza", "Técnica industrial", "(41)96666-2222"),
("Carlos Lima", "Engenheiro de Manutenção", "(51)95555-3333");

INSERT INTO Categorias(nome_categoria, descricao_categoria) VALUES
("Prensas", "Projetados para comprimir, moldar, extrair ou estampar"),
("Transporte interno", "Equipamentos para deslocamento de utensílios"),
("CNC", "Controlador de movimento e ações de máquinas");

INSERT INTO Equipamentos(nome_equipamento, descricao_equipamento, id_categoria) VALUES
("Prensa hidráulica", "Uma prensa que funciona por um sistema hidráulico", 1),
("Esteira transportadora", "Deslocadora de equipamentos", 2),
("Centro de Usinagem", "Realiza múltiplos processos de corte", 3);

INSERT INTO Fornecedores(nome_fornecedor, cidade_fornecedor, telefone_fornecedor) VALUES
("Industrial Parts", "Caxias do Sul", "(51)95555-8888"),
("MecParts", "Curitiba", "(41)97777-2222"),
("TecIndustrial", "Campinas", "(51)92222-4444");

INSERT INTO Pecas(nome_peca, valor_peca, quantidade_estoque_peca, id_fornecedor) VALUES
("Rolamento A", 150.00, 100, 1),
("Correia B", 80.00, 150, 1),
("Sensor X", 250.00, 120, 2),
("Válvula Z", 420.00, 80, 1),
("Motor Y", 980.00, 100, 3);

INSERT INTO OS(codigo_os, data_os, id_cliente, id_equipamento, id_tecnico) VALUES
("1001", "2025-03-10", 1, 1, 1),
("1002", "2025-03-12", 2, 2, 2),
("1003", "2025-03-13", 1, 1, 3),
("1004", "2025-03-15", 3, 3, 1);