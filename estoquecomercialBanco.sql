CREATE DATABASE estoquecomercial;
USE estoquecomercial;

CREATE TABLE itens_estoque(
    id_item INT NOT NULL AUTO_INCREMENT,
    descricao_item VARCHAR(200),
    setor_item VARCHAR(200),
    preco_venda_item DECIMAL(9,2),
    estoque_item INT,
    PRIMARY KEY (id_item)
);

INSERT INTO itens_estoque (descricao_item, setor_item, preco_venda_item, estoque_ item) VALUES
('Suco de Laranja','Bebidas','7.50',250),
('Macarrão 1kg','Alimentos','5.20',180),
('Sabão em pó','Limpeza','12.90',90),
('Café Torrado','Alimentos','15.80',120),
('Iogurte Natural','Laticínios','4.30',350),
('Biscoito Integral',NULL,'3.90',210),
('Molho de Tomate','Alimentos','2.80',500);

SELECT * FROM itens_estoque;

DESCRIBE itens_estoque;

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