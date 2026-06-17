CREATE USER 'andre'@'localhost' IDENTIFIED BY 'senha123';

SELECT * FROM mysql.user;

CREATE USER 'andre2'@'localhost' IDENTIFIED BY'';

SELECT host, user
FROM mysql.user;

DROP USER 'andre2'@'localhost';

CREATE USER 'andre3'@'localhost' IDENTIFIED BY'';

GRANT CREATE,SELECT,INSERT,DELETE
ON *.*
TO 'andre3'@'localhost';

FLUSH PRIVILEGES;

REVOKE DELETE
ON *.*
FROM 'andre3'@'localhost';

GRANT UPDATE
ON *.*
TO 'andre3'@'localhost';

GRANT ALL PRIVILEGES ON *.* TO 'andre'@'localhost';

CREATE DATABASE andregrant_db;
USE andregrant_db;

CREATE TABLE usuarios (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    nome_usuario VARCHAR(100),
    idade_usuario TINYINT
);

CREATE TABLE produtos (
	id_produto INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    nome_produto VARCHAR(30),
    descricao_produto TEXT
);

CREATE TABLE carrinhoCompras (
	id_compra INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    quantidade SMALLINT,
	id_produto INT,
    id_usuario INT,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE USER 'programador'@'localhost' IDENTIFIED BY 'senha123';

GRANT SELECT,INSERT,UPDATE
ON *.*
TO 'programador'@'localhost';

INSERT INTO usuarios(nome_usuario, idade_usuario) VALUES
("André", 16),
("André2", 16),
("André3", 16);

INSERT INTO produtos(nome_produto, descricao_produto) VALUES
("Tomate", "Suculento"),
("Alface", "Direto da horta"),
("Pepino", "Fresquinho");

INSERT INTO carrinhoCompras(quantidade, id_produto, id_usuario) VALUES
(5, 1, 1),
(2, 2, 1),
(6, 3, 2),
(1, 1, 3),
(2, 2, 3);
 
SELECT c.id_compra, u.nome_usuario, p.nome_produto, c.quantidade
FROM carrinhoCompras AS c
JOIN usuarios AS u ON u.id_usuario = c.id_usuario
JOIN produtos AS p ON p.id_produto = c.id_produto;

UPDATE carrinhoCompras
SET quantidade = 0
WHERE quantidade > 5;

CREATE DATABASE vamosla;

CREATE ROLE 'app_desenvolvedor',
'app_leitura',
'app_escrita';

USE vamosla;

GRANT ALL ON vamosla.* TO'app_desenvolvedor';

GRANT SELECT ON vamosla.* TO'app_leitura';

GRANT INSERT,UPDATE,DELETE ON vamosla.* TO'app_escrita';

CREATE USER 'usuario_desenvolvedor'@'localhost';

CREATE USER 'usuario_leitura'@'localhost';

CREATE USER 'usuario_escrita'@'localhost';

GRANT 'app_desenvolvedor'
TO 'usuario_desenvolvedor'@'localhost';

GRANT 'app_leitura'
TO 'usuario_leitura'@'localhost';

GRANT 'app_escrita'
TO 'usuario_escrita'@'localhost';

SET DEFAULT ROLE 'app_escrita'
FOR 'usuario_escrita'@'localhost';

FLUSH PRIVILEGES;

CREATE ROLE 'app_desativado';

GRANT 'app_desativado'
TO 'usuario_desenvolvedor';