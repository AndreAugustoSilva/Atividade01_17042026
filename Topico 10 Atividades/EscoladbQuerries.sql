CREATE DATABASE EscolaDB;
USE EscolaDB;

CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    idade INT
);

CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,
    id_curso INT,
    nota DECIMAL(4,2),
    faltas INT,
FOREIGN KEY (id_aluno)REFERENCES Alunos(id_aluno),
FOREIGN KEY (id_curso)REFERENCES Cursos(id_curso)
);

INSERT INTO Alunos (nome, cidade, idade)VALUES
('Carlos','São Paulo',18),
('Mariana','Curitiba',22),
('João','Florianópolis',19),
('Fernanda','São Paulo',25),
('Lucas','Rio de Janeiro',20),
('Patricia','Curitiba',21),
('Ana','Porto Alegre',23),
('Bruno','São Paulo',24);

INSERT INTO Cursos (nome_curso, carga_horaria)VALUES
('Python',40),
('Banco de Dados',60),
('Java',80),
('Data Science',100);

INSERT INTO Matriculas (id_aluno, id_curso, nota, faltas)VALUES
(1,1,8.5,2),
(1,2,7.0,5),
(2,1,9.5,1),
(2,4,8.0,4),
(3,2,6.5,6),
(3,3,7.5,3),
(4,4,9.0,0),
(5,1,5.5,10),
(5,2,6.0,7),
(6,3,8.5,2),
(7,4,7.0,5),
(8,2,9.5,1);

-- ========================
-- QUERYS BÁSICAS --
-- ========================

-- 1. Liste todos os alunos cadastrados.

SELECT * FROM Alunos;

-- 2. Liste apenas os nomes dos alunos.

SELECT nome FROM Alunos;

-- 3. Exiba todos os cursos cadastrados.

SELECT * FROM Cursos;

-- 4. Mostre os alunos que moram em São Paulo.

SELECT * FROM Alunos
WHERE cidade = 'São Paulo';

-- 5. Liste os alunos com idade maior que 20 anos.

SELECT * FROM Alunos
WHERE idade > 20;

-- 6. Exiba os cursos com carga horária maior que 50 horas.

SELECT * FROM Cursos
WHERE carga_horaria > 50;

-- 7. Mostre os alunos com idade entre 18 e 22 anos.

SELECT * FROM Alunos
WHERE idade BETWEEN 18 AND 22;

-- 8. Liste os alunos da cidade de Curitiba.

SELECT * FROM Alunos
WHERE cidade = 'Curitiba';

-- 9. Exiba os alunos cuja idade seja menor que 21 anos.

SELECT * FROM Alunos
WHERE idade < 21;

-- 10. Liste todas as matrículas cadastradas.

SELECT * FROM Matriculas;

-- ========================
-- QUERYS INTERMEDIÁRIAS --
-- ========================

-- 1. Mostre os alunos que possuem nota maior que 8.

SELECT id_aluno, nota FROM Matriculas
WHERE nota > 8;

-- 2. Liste os alunos que tiveram mais de 5 faltas.

SELECT id_aluno, faltas FROM Matriculas
WHERE faltas > 5;

-- 3. Exiba os cursos com carga horária igual a 80 horas.

SELECT * FROM Cursos
WHERE carga_horaria = 80;

-- 4. Mostre os alunos que NÃO moram em São Paulo.

SELECT * FROM Alunos
WHERE cidade != 'São Paulo';

-- 5. Liste os alunos cujo nome começa com a letra “A”.

SELECT * FROM Alunos
WHERE nome LIKE'A%';

-- 6. Exiba os alunos cujo nome termina com a letra “a”.

SELECT * FROM Alunos
WHERE nome LIKE'%a';

-- 7. Liste os cursos cujo nome contenha a palavra “Dados”.

SELECT * FROM Cursos
WHERE nome_curso LIKE'%Dados%';

-- 8. Mostre as matrículas com nota entre 7 e 9.

SELECT * FROM Matriculas
WHERE nota BETWEEN 7 AND 9;

-- 9. Liste os alunos que possuem exatamente 20 anos.

SELECT * FROM Alunos
WHERE idade = 20;

-- 10. Exiba os cursos com carga horária menor ou igual a 60 horas.

SELECT * FROM Cursos
WHERE carga_horaria <= 60;

-- ========================
-- QUERYS GROUP BY
-- ========================

-- 1. Mostre quantos alunos existem em cada cidade.

SELECT cidade, COUNT(cidade) AS AlunosPorCidade FROM Alunos
GROUP BY cidade;

-- 2. Exiba a média de idade dos alunos agrupada por cidade.

SELECT cidade, AVG(idade) AS MediaDasIdades FROM Alunos
GROUP BY cidade;

-- 3. Mostre a quantidade de matrículas por curso.

SELECT id_curso, COUNT(id_curso) AS MatriculasNoCurso FROM Matriculas
GROUP BY id_curso;

-- 4. Exiba a média das notas por curso.

SELECT id_curso,AVG(nota) AS MediaDasNotas FROM Matriculas
GROUP BY id_curso;

-- 5. Mostre o total de faltas agrupado por curso.

SELECT id_curso, SUM(faltas) AS FaltasPorGrupo FROM Matriculas
GROUP BY id_curso;

-- 6. Liste a maior nota obtida em cada curso.

SELECT id_curso, MAX(nota) AS MaiorNota FROM Matriculas
GROUP BY id_curso;

-- 7. Exiba a menor nota registrada em cada curso.

SELECT id_curso, MIN(nota) AS MenorNota FROM Matriculas
GROUP BY id_curso;

-- 8. Mostre a soma total das faltas agrupadas por aluno.

SELECT id_aluno, SUM(faltas) AS FaltasTotais FROM Matriculas
GROUP BY id_aluno;

-- 9. Exiba a média de notas agrupada por aluno.

SELECT id_aluno, AVG(nota) AS MediaNotas FROM Matriculas
GROUP BY id_aluno;

-- 10. Mostre quantos alunos existem em cada faixa etária.

SELECT idade, COUNT(id_aluno) AS QuantidadeAlunos FROM Alunos
GROUP BY idade;

-- ========================
-- QUERYS AVANÇADAS - HAVING E ORDER BY
-- ========================

-- 1. Liste as cidades que possuem mais de 2 alunos.

SELECT cidade, COUNT(id_aluno) AS QuantidadeAlunos FROM Alunos
GROUP BY cidade
HAVING COUNT(id_aluno) > 2;

-- 2. Exiba os cursos cuja média de notas seja maior que 8.

SELECT id_curso, AVG(nota) AS MediaNotas FROM Matriculas
GROUP BY id_curso
HAVING AVG(nota) > 8;

-- 3. Mostre os cursos que possuem mais de 2 matrículas.

SELECT id_curso, COUNT(id_aluno) AS QuantidadeAlunos FROM Matriculas
GROUP BY id_curso
HAVING COUNT(id_aluno) > 2;

-- 4. Liste os alunos cuja soma de faltas seja maior que 5.

SELECT id_aluno, SUM(faltas) AS FaltasTotais FROM Matriculas
GROUP BY id_aluno
HAVING SUM(faltas) > 5;

-- 5. Exiba os cursos cuja menor nota seja maior que 6.

SELECT id_curso, MIN(nota) AS MenorNota FROM Matriculas
GROUP BY id_curso
HAVING MIN(nota) > 6;

-- 6. Mostre os cursos ordenados pela carga horária em ordem decrescente.

SELECT * FROM Cursos
ORDER BY carga_horaria DESC;

-- 7. Liste os alunos ordenados por idade do maior para o menor.

SELECT * FROM Alunos
ORDER BY idade DESC;

-- 8. Exiba a média de notas por curso ordenada da maior para a menor.

SELECT id_curso, AVG(nota) AS MediaNotas FROM Matriculas
GROUP BY id_curso
ORDER BY AVG(nota) DESC;

-- 9. Mostre as cidades ordenadas pela quantidade de alunos.

SELECT cidade, COUNT(id_aluno) AS QuantidadeAlunos FROM Alunos
GROUP BY cidade
ORDER BY COUNT(id_aluno) DESC;

-- 10. Liste os alunos com média de notas maior que 7 ordenados pela média decrescente.

SELECT id_aluno, AVG(nota) AS MediaNotas FROM Matriculas
GROUP BY id_aluno
HAVING MediaNotas > 7
ORDER BY MediaNotas DESC;
