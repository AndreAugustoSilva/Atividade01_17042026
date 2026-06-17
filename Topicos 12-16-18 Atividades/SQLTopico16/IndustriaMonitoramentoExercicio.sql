CREATE DATABASE IndustriaMonitoramento;
USE IndustriaMonitoramento;

CREATE TABLE setor (
    id_setor INT NOT NULL AUTO_INCREMENT,
    nome_setor VARCHAR(100),
    localizacao VARCHAR(100),
    PRIMARY KEY (id_setor)
);

CREATE TABLE equipamento (
    id_equipamento INT NOT NULL AUTO_INCREMENT,
    nome_equipamento VARCHAR(100),
    fabricante VARCHAR(100),
    data_instalacao DATE,
    id_setor INT,
PRIMARY KEY (id_equipamento),
FOREIGN KEY (id_setor)REFERENCES setor(id_setor)
);

INSERT INTO setor (nome_setor, localizacao) VALUES
('Usinagem','Bloco A'),
('Soldagem','Bloco B'),
('Montagem','Bloco C');

INSERT INTO equipamento (nome_equipamento, fabricante, data_instalacao, id_setor) VALUES
('Torno CNC','Siemens','2021-03-10',1),
('Robô de Solda','ABB','2020-08-15',2),
('Esteira Automatizada','WEG','2022-01-20',3);

SELECT*FROM equipamento;
SELECT*FROM setor;

SELECT E.nome_equipamento AS Equipamento, E.fabricante AS Fabricante, S.nome_setor AS Setor
FROM equipamento AS E
INNER JOIN setor AS S
ON E.id_setor= S.id_setor;

CREATE VIEW view_equipamentos_setor AS
SELECT E.nome_equipamento AS Equipamento, E.fabricante AS Fabricante, S.nome_setor AS Setor
FROM equipamento AS E
INNER JOIN setor AS S
ON E.id_setor= S.id_setor;

SELECT * FROM view_equipamentos_setor;