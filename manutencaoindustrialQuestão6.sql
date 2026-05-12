CREATE DATABASE MANUTENCAOINDUSTRIAL;
USE MANUTENCAOINDUSTRIAL;

CREATE TABLE MAQUINA (
	id_maquina smallint auto_increment primary key,
    nome_maquina varchar(50) not null,
    setor tinyint,
    data_aquisicao date
);
CREATE TABLE TECNICO (
	id_tecnico smallint auto_increment primary key,
    nome_tecnico varchar(200),
    cpf_tecnico char(11),
    especialidade_tecnico varchar(30),
    telefone_tecnico char(13)
);
CREATE TABLE OS (
	id_os int auto_increment primary key,
	id_maquina smallint,
    id_tecnico smallint,
    id_peca smallint,
    data_abertura date,
    data_fechamento date,
    foreign key (id_maquina) references MAQUINA(id_maquina),
    foreign key (id_tecnico) references TECNICO(id_tecnico),
    foreign key (id_peca) references PECAS(id_peca)
);
CREATE TABLE REGISTRO (
	id_registro int auto_increment primary key,
	id_operacao int,
    descricao_registro text,
    tempo_gasto time,
    foreign key (id_operacao) references OPERACAO(id_operacao)
);
CREATE TABLE PECAS (
	id_peca smallint auto_increment primary key,
	id_estoque smallint,
    nome_peca varchar(20),
    descricao_peca text,
    foreign key (id_estoque) references ESTOQUE(id_estoque)
);
CREATE TABLE ESTOQUE (
	id_estoque smallint auto_increment primary key,
    qtd_disp smallint,
    capacidade smallint,
    qtd_min smallint
);
CREATE TABLE OPERACAO (
	id_operacao int auto_increment primary key,
    id_tecnico smallint,
    id_os int,
    foreign key (id_tecnico) references TECNICO(id_tecnico),
    foreign key (id_os) references OS(id_os)
);

SELECT * FROM MAQUINA;
SELECT * FROM TECNICO;
SELECT * FROM OS;
SELECT * FROM REGISTRO;
SELECT * FROM PECAS;
SELECT * FROM ESTOQUE;
SELECT * FROM OPERACAO;