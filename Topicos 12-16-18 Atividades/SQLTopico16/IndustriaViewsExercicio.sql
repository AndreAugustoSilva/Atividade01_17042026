-- 1

CREATE DATABASE IndustriaViews;
USE IndustriaViews;

-- 2 / 3

CREATE TABLE funcionarios (
    idFuncionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200),
    cargo VARCHAR(100),
    setor VARCHAR(100),
    data_admissao DATE,
    salario DECIMAL(10,2),
    telefone VARCHAR(20),
    email VARCHAR(200),
    turno VARCHAR(50),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    status_funcionario VARCHAR(20)
);

-- 4

INSERT INTO funcionarios (
    nome, cargo, setor, data_admissao, salario,
    telefone, email, turno, cidade, estado, status_funcionario
)VALUES
(
'Carlos Silva','Operador de Produção','Usinagem',
'2020-03-15',3200.00,
'(51)99999-1111','carlos@industria.com',
'Manhã','Porto Alegre','RS','Ativo'
),
(
'Mariana Souza','Inspetora de Qualidade','Qualidade',
'2019-08-20',4100.00,
'(51)99999-2222','mariana@industria.com',
'Tarde','Canoas','RS','Ativo'
),
(
'João Pereira','Soldador','Soldagem',
'2021-01-10',3500.00,
'(51)99999-3333','joao@industria.com',
'Manhã','Gravataí','RS','Ativo'
),
(
'Fernanda Lima','Engenheira de Produção','Produção',
'2018-06-12',7800.00,
'(51)99999-4444','fernanda@industria.com',
'Integral','Porto Alegre','RS','Ativo'
),
(
'Rafael Martins','Técnico de Manutenção','Manutenção',
'2022-02-05',4200.00,
'(51)99999-5555','rafael@industria.com',
'Noite','São Leopoldo','RS','Ativo'
);

CREATE VIEW view_funcionarios AS
SELECT * FROM Funcionarios;

SELECT * FROM view_funcionarios;

-- 5

CREATE VIEW view_funcionarios_resumo AS
SELECT nome, setor, cargo
FROM funcionarios;

SELECT * FROM view_funcionarios_resumo;

-- 6

SELECT * FROM view_funcionarios_resumo
WHERE nome LIKE'%a';

SELECT * FROM view_funcionarios_resumo
WHERE setor LIKE'%agem';

-- 7

SELECT * FROM view_funcionarios_resumo
WHERE setor = "Usinagem";

-- 8

SELECT * FROM view_funcionarios_resumo
WHERE cargo = "Soldador";

ALTER VIEW view_funcionarios_resumo AS
SELECT nome, cargo, setor
FROM funcionarios;

DROP VIEW view_funcionarios_resumo;