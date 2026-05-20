CREATE TABLE ecommerce;
USE ecommerce;

CREATE TABLE categoria (
   id INT(11) NOT NULL AUTO_INCREMENT,
   nome VARCHAR(100) DEFAULT NULL,
   descricao TEXT DEFAULT NULL,
   status CHAR(1) DEFAULT 'A',
   PRIMARY KEY (id)
);

INSERT INTO categoria (id, nome, descricao, status) VALUES 
(1, 'Limpeza', 'Produtos para limpeza', 'A'),
(2, 'Frutas e verduras', 'Alimentos saudáveis', 'I'),
(3, 'Padaria', 'Doces e salgados em massas', 'A'),
(4, 'Açougue', 'Carnes e derivados', 'A'),
(5, 'Bebidas', 'Líquidos consumíveis', 'A');

CREATE TABLE IF NOT EXISTS produto (
   id INT(11) NOT NULL AUTO_INCREMENT,
   nome VARCHAR(150) DEFAULT NULL,
   descricao TEXT DEFAULT NULL,
   preco DECIMAL(10,2) DEFAULT NULL,
   estoque INT(11) DEFAULT NULL,
   categoria_id INT(11) DEFAULT NULL,
   status CHAR(1) DEFAULT 'A',
   PRIMARY KEY (`id`),
   FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

INSERT INTO `produto` (`id`, `nome`, `descricao`, `preco`, `estoque`, `categoria_id`, `status`) VALUES 
(1, 'Palha de aço', 'Palha de aço da marca bombril', 5.40, 12, 1, 'A'),
(2, 'Detergente', 'Detergente aromatizado de limão', 6.50, 13, 1, 'A'),
(3, 'Vassoura', 'Vassoura de madeira com cerdas de palha', 13.00, 17, 1, 'A'),
(4, 'Tomate', 'Fresco da horta', 2.60, 54, 2, 'I'),
(5, 'Maçã', 'Maçã suculenta, uma maçã por dia evita médicos e cirurgia', 3.00, 46, 2, 'I'),
(6, 'Pastel', 'Pastel de queijo', 8.00, 20, 3, 'A'),
(7, 'Coxinha', 'Coxinha de frango', 5.00, 23, 3, 'A'),
(8, 'Pernil', 'Pernil suculento', 20.70, 5, 4, 'A'),
(9, 'Contra-filé', 'Cuidado com o corte!', 25.50, 13, 4, 'A'),
(10, 'Linguicinha', 'A mais saborosa do mercado', 27.80, 31, 4, 'A'),
(11, 'Água', 'Mineral, com gás', 4.50, 40, 5, 'A'),
(12, 'Refrigerante', 'Refrigerante de cola', 7.00, 34, 5, 'A'),
(13, 'Suco', 'Natural direto da fruta', 5.00, 24, 5, 'A');