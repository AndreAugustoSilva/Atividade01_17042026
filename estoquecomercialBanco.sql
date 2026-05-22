CREATE DATABASE estoquecomercial;
USE estoquecomercial;

CREATE TABLE itens_estoque(
    id_item INT NOT NULL AUTO_INCREMENT,
    descricao_item VARCHAR(200),
    preco_venda_item DECIMAL(9,2),
    estoque_item INT,
    adicionados CHAR(1),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    PRIMARY KEY (id_item)
);

CREATE TABLE categoria(
   id_categoria INT NOT NULL AUTO_INCREMENT,
   setor_item VARCHAR(200),
   descricao_categoria VARCHAR(100),
   PRIMARY KEY (id_categoria)
);

SELECT * FROM itens_estoque
WHERE preco_venda_item = 3.90 OR estoque_item > 210;

SELECT * FROM itens_estoque
WHERE (preco_venda_item < 5 OR estoque_item < 150) AND setor_item = 'Alimentos';

SELECT * FROM itens_estoque
WHERE NOT preco_venda_item < 10;

SELECT * FROM itens_estoque
WHERE setor_item = 'Alimentos' AND NOT estoque_item in (100,200,250,300,350,500);

SELECT descricao_item AS nome_produto
FROM itens_estoque
WHERE preco_venda_item
BETWEEN 5 AND 10;

SELECT * FROM itens_estoque
WHERE preco_venda_item
BETWEEN 3 AND 7;

SELECT descricao_item FROM itens_estoque
WHERE id_item IS NULL; 

SELECT descricao_item AS descricao, preco_venda_item AS preco FROM itens_estoque;

SELECT descricao_item AS nome, estoque_item AS estoque FROM itens_estoque
WHERE estoque_item BETWEEN 5 AND 150
ORDER BY descricao_item;

SELECT * FROM itens_estoque
WHERE setor_item != "Alimentos" AND preco_venda_item > 4
ORDER BY descricao_item;

TRUNCATE itens_estoque;

INSERT INTO itens_estoque (descricao_item, preco_venda_item, estoque_item, adicionados, id_categoria) VALUES
('Suco de Laranja',7.50,250,'N',2),
('Macarrão 1kg',5.20,180,'N',1),
('Sabão em pó',12.90,90,'N',3),
('Café Torrado',15.80,120,'N',1),
('Iogurte Natural',4.30,350,'N',2),
('Biscoito Integral',3.90,210,'N',1),
('Molho de Tomate',2.80,500,'N',1),
('Paçoquinha',1.00,400,'S',1),
('Alfajor',10.00,200,'S',1),
('Vassoura',8.00,30,'S',3)

INSERT INTO categoria (setor_item, descricao_categoria) VALUES
('Alimentos', 'Produtos consumíveis'),
('Bebidas', 'Líquidos bebíveis'),
('Limpeza', 'Materiais para limpeza')

SELECT * FROM itens_estoque;
SELECT * FROM categoria;

-- Funções de Agregação

SELECT COUNT (descricao_item)
FROM itens_estoque
WHERE descricao_item LIKE'%Molho%';

SELECT AVG(preco_venda_item)
FROM itens_estoque
WHERE preco_venda_item IN (7.50, 5.50, 12.90);

SELECT SUM(estoque_item)
FROM itens_estoque
WHERE adicionados != 'S' AND (id_categoria = 3 OR id_categoria = 2);

SELECT MIN(descricao_item)
FROM itens_estoque
WHERE adicionados != 'S';

SELECT MAX(preco_venda_item)
FROM itens_estoque
WHERE adicionados != 'S' AND estoque_item > 300;
