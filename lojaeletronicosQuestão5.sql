CREATE DATABASE LOJAELETRONICOS;
USE LOJAELETRONICOS;

CREATE TABLE CLIENTE (
	id_usuario int primary key auto_increment,
	nome varchar(100) not null,
    cpf char(11) not null,
    telefone char(13),
    endereco varchar(100)
);
CREATE TABLE PRODUTO (
	id_produto int auto_increment primary key,
	id_estoque int,
    nome_produto varchar(30),
    preco_produto decimal(5, 2),
    categoria enum('Higiene pessoal', 'Consumíveis', 'Limpeza'),
    marca varchar(20),
    qtd_produto smallint,
    foreign key (id_estoque) references ESTOQUE(id_estoque)
);
CREATE TABLE VENDA (
	id_venda int auto_increment primary key,
	id_usuario int,
    data_venda date,
    valor_total decimal(9, 2),
    foreign key (id_usuario) references CLIENTE(id_usuario)
);
CREATE TABLE PAGAMENTO (
	id_pagamento int auto_increment primary key,
	id_venda int,
    forma_pagamento varchar(20),
    data_pagamento date,
    foreign key (id_venda) references VENDA(id_venda)
);
CREATE TABLE ESTOQUE (
	id_estoque int auto_increment primary key,
    qtd_min smallint,
    capacidade smallint
);
CREATE TABLE ITEM_VENDA (
	id_compra int auto_increment primary key,
	id_venda int,
    id_produto int,
    foreign key (id_venda) references VENDA(id_venda),
    foreign key (id_produto) references PRODUTO(id_produto)
);

SELECT * FROM CLIENTE;
SELECT * FROM PRODUTO;
SELECT * FROM VENDA;
SELECT * FROM PAGAMENTO;
SELECT * FROM ESTOQUE;
SELECT * FROM ITEM_VENDA;