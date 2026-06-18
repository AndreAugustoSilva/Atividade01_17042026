CREATE DATABASE CINEMA;
USE CINEMA;

CREATE TABLE CLIENTE (
	id_usuario int primary key auto_increment,
    nome varchar(200) not null,
    maior_idade boolean not null,
    rg char(9)
);
CREATE TABLE PEDIDO (
	id_pedido int primary key auto_increment,
    forma_pagamento varchar(100),
    id_usuario int,
    foreign key(id_usuario) references USUARIO(id_usuario)
);
CREATE TABLE INGRESSO (
	id_ingresso int primary key auto_increment,
    id_filme int,
    foreign key (id_filme) references FILME(id_filme),
    categoria enum
);
CREATE TABLE SESSAO (
	id_sessao int primary key auto_increment,
    horario date,
    id_venda int,
    id_sala int,
    foreign key(id_venda) references VENDA(id_venda),
    foreign key(id_sala) references SALA(id_sala)
);
CREATE TABLE SALA (
	id_sala int primary key auto_increment,
    vip boolean,
    threed boolean
);
CREATE TABLE FILME (
	id_filme int primary key auto_increment,
    faixa_etaria char(3),
    duracao time,
    classificacao enum
);
CREATE TABLE VENDA (
	id_venda int primary key auto_increment,
    id_ingresso int,
    id_pedido int,
    foreign key(id_ingresso) references INGRESSO(id_ingresso),
    foreign key(id_pedido) references PEDIDO(id_pedido)
);

select * from CLIENTE;
select * from PEDIDO;
select * from INGRESSO;
select * from SESSAO;
select * from SALA;
select * from FILME;
select * from VENDA;