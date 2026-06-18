--=========================================
-- QUESTÕES BÁSICAS - SUBQUERY COMO FILTRO
--=========================================

-- 1. Liste os alunos que possuem a maior idade cadastrada.

SELECT * FROM alunos
WHERE idade = (
    SELECT max(idade) FROM alunos
);

-- 2. Exiba os alunos que possuem idade menor que a média das idades.

SELECT * FROM alunos
WHERE idade < (
    SELECT AVG(idade) FROM alunos
)

-- 3. Mostre os cursos que possuem a maior carga horária.

SELECT * FROM cursos
WHERE carga_horaria = (
    SELECT MAX(carga_horaria) FROM cursos
)

-- 4. Liste os alunos que possuem nota igual à maior nota registrada nas matrículas.

SELECT alunos.nome, matriculas.nota FROM alunos
JOIN matriculas ON alunos.id_aluno = matriculas.id_aluno
WHERE matriculas.nota = (
    SELECT MAX(nota) FROM matriculas
)

-- 5. Exiba os alunos que possuem nota menor que a média geral das notas.

SELECT alunos.nome, matriculas.nota
FROM alunos
JOIN matriculas ON alunos.id_aluno = matriculas.id_aluno
WHERE matriculas.nota < (
    SELECT AVG(nota)
    FROM matriculas
)
ORDER BY matriculas.nota ASC;

-- 6. Mostre os cursos cuja carga horária seja maior que a média das cargas horárias.

SELECT cursos.nome_curso, cursos.carga_horaria
FROM cursos
WHERE cursos.carga_horaria > (
    SELECT AVG(carga_horaria)
    FROM cursos
)

-- 7. Liste os alunos que possuem exatamente a menor idade cadastrada.

SELECT alunos.nome, alunos.idade
FROM alunos
WHERE alunos.idade = (
    SELECT MIN(idade)
    FROM alunos
)

-- 8. Exiba as matrículas cuja quantidade de faltas seja maior que a média de faltas.

SELECT matriculas.id_matricula, matriculas.faltas
FROM matriculas
WHERE faltas > (
    SELECT AVG(faltas)
    FROM matriculas
)

-- 9. Mostre os cursos que possuem carga horária diferente da maior carga horária.

SELECT cursos.nome_curso, cursos.carga_horaria
FROM cursos
WHERE cursos.carga_horaria != (
    SELECT MAX(carga_horaria)
    FROM cursos
)

-- 10. Liste os alunos que possuem nota igual à menor nota registrada.

SELECT alunos.nome, matriculas.nota
FROM alunos
JOIN matriculas ON alunos.id_aluno = matriculas.id_aluno
WHERE matriculas.nota = (
    SELECT MIN(nota)
    FROM matriculas
)

--=========================================
-- QUESTÕES INTERMEDIÁRIAS - SUBQUERY COM IN
--=========================================

-- 1. Liste os nomes dos alunos que possuem matrícula cadastrada.

SELECT alunos.nome
FROM alunos
WHERE alunos.id_aluno IN (
    SELECT id_aluno
    FROM matriculas
)

-- 2. Exiba os cursos que possuem alunos matriculados.

SELECT cursos.nome_curso
FROM cursos
WHERE id_curso IN (
    SELECT id_curso
    FROM matriculas
)

-- 3. Mostre os alunos que estão matriculados no curso “Python”.

SELECT alunos.nome
FROM alunos
WHERE id_aluno IN (
    SELECT id_aluno
    FROM matriculas
    JOIN cursos ON matriculas.id_curso = cursos.id_curso
    WHERE nome_curso = 'Python'
)

-- 4. Liste os alunos matriculados em cursos com carga horária maior que 60 horas.

SELECT alunos.nome
FROM alunos
WHERE id_aluno IN (
    SELECT id_aluno
    FROM matriculas
    JOIN cursos ON matriculas.id_curso = cursos.id_curso
    WHERE cursos.carga_horaria > 60
)

-- 5. Exiba os cursos nos quais existem alunos com nota maior que 8.

SELECT cursos.nome_curso
FROM cursos
WHERE id_curso IN (
    SELECT matriculas.id_curso
    FROM matriculas
    WHERE matriculas.nota > 8
)

-- 6. Mostre os alunos que possuem mais de uma matrícula.

SELECT alunos.nome
FROM alunos
WHERE 1 < (
    SELECT COUNT(id_aluno)
    FROM matriculas
    WHERE alunos.id_aluno = matriculas.id_aluno
);

-- 7. Liste os cursos que NÃO possuem matrículas cadastradas.

SELECT cursos.nome_curso
FROM cursos
WHERE id_curso NOT IN (
    SELECT id_curso
    FROM matriculas
)

-- 8. Exiba os alunos que possuem faltas maiores que 5 em alguma matrícula.

SELECT alunos.nome
FROM alunos
WHERE id_aluno IN (
    SELECT id_aluno
    FROM matriculas
    WHERE faltas > 5
)

-- 9. Mostre os cursos frequentados por alunos da cidade de Curitiba.

SELECT cursos.nome_curso
FROM cursos
WHERE id_curso IN (
    SELECT id_curso
    FROM matriculas
    JOIN alunos ON matriculas.id_aluno = alunos.id_aluno
    WHERE cidade = 'Curitiba'
)

-- 10. Liste os alunos matriculados no curso com maior carga horária.

SELECT alunos.nome
FROM alunos
JOIN matriculas ON alunos.id_aluno = matriculas.id_aluno
JOIN cursos ON cursos.id_curso = matriculas.id_curso
WHERE carga_horaria IN (
    SELECT MAX(carga_horaria)
    FROM cursos
)

--=========================================
-- QUESTÕES AVANÇADAS - SUBQUERY COM OPERADORES DE COMPARAÇÃO
--=========================================

-- 1. Exiba os alunos cuja idade seja maior que a média de idade dos alunos de São Paulo.

SELECT alunos.nome
FROM alunos
WHERE alunos.idade > (
    SELECT AVG(idade)
    FROM alunos
    WHERE cidade = 'São Paulo'
)

-- 2. Liste os cursos cuja média de notas seja maior que a média geral das notas.

SELECT cursos.nome_curso
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
WHERE nota > (
    SELECT AVG(nota)
    FROM matriculas
)

-- 3. Mostre os alunos cuja soma de faltas seja maior que a média total de faltas.

SELECT alunos.nome
FROM alunos
JOIN matriculas ON matriculas.id_aluno = alunos.id_aluno
WHERE matriculas.faltas > (
    SELECT AVG(faltas)
    FROM matriculas
)

-- 4. Exiba os cursos cuja maior nota registrada seja igual à maior nota do sistema.

SELECT cursos.nome_curso
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
WHERE nota = (
    SELECT MAX(nota)
    FROM matriculas
);

-- 5. Liste os alunos cuja média de notas seja menor que a média geral dos alunos.

SELECT alunos.nome, matriculas.nota
FROM alunos
JOIN matriculas ON matriculas.id_aluno = alunos.id_aluno
GROUP BY alunos.nome
HAVING AVG(nota) > (
    SELECT AVG(nota)
    FROM matriculas
);

-- 6. Mostre os cursos cuja quantidade de matrículas seja maior que a média de matrículas dos cursos.

SELECT cursos.nome_curso, COUNT(matriculas.id_curso)
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY matriculas.id_curso
HAVING COUNT(matriculas.id_curso) > (
    SELECT AVG(matriculas.id_curso)
    FROM matriculas
);

-- 7. Exiba os alunos que possuem nota maior que todas as notas do curso “Banco de Dados”.

SELECT alunos.nome, matriculas.nota
FROM alunos
JOIN matriculas ON alunos.id_aluno = matriculas.id_aluno
WHERE matriculas.nota > (
    SELECT MAX(matriculas.nota)
    FROM matriculas
    JOIN cursos ON matriculas.id_curso = cursos.id_curso
    WHERE cursos.nome_curso = "Banco de Dados"
)

-- 8. Liste os cursos cuja menor nota seja maior que a média geral das menores notas dos cursos.

SELECT cursos.nome_curso, MIN(matriculas.nota)
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY cursos.nome_curso
HAVING MIN(matriculas.nota) > (
    SELECT AVG(matriculas.nota)
    FROM matriculas
    WHERE nota < 6
)

-- 9. Mostre os alunos cuja idade seja igual à idade média dos alunos.

SELECT alunos.nome, alunos.idade
FROM alunos
WHERE alunos.idade = (
    SELECT AVG(alunos.idade)
    FROM alunos
);

-- 10. Exiba os cursos cuja carga horária seja menor que a maior carga horária cadastrada.

SELECT cursos.nome_curso, cursos.carga_horaria
FROM cursos
WHERE cursos.carga_horaria < (
    SELECT AVG(cursos.carga_horaria)
    FROM cursos
)

--=========================================
-- QUESTÕES - SUBQUERY COMO NOVA COLUNA
--=========================================

-- 1. Liste os alunos e exiba ao lado a quantidade total de matrículas de cada aluno.

SELECT alunos.nome, (
    SELECT COUNT(matriculas.id_aluno)
    FROM matriculas
    WHERE alunos.id_aluno = matriculas.id_aluno
) AS quantidade_matriculas
FROM alunos
ORDER BY quantidade_matriculas DESC;

-- 2. Exiba os cursos e mostre ao lado a média das notas de cada curso.

SELECT cursos.nome_curso, (
    SELECT AVG(matriculas.nota)
    FROM matriculas
    WHERE cursos.id_curso = matriculas.id_curso
) AS media_notas
FROM cursos
GROUP BY cursos.nome_curso
ORDER BY media_notas DESC;

-- 3. Liste os alunos e mostre a soma total de faltas de cada um.

SELECT alunos.nome, (
    SELECT SUM(matriculas.faltas)
    FROM matriculas
    WHERE alunos.id_aluno = matriculas.id_aluno
) AS quantidade_faltas
FROM alunos
GROUP BY alunos.nome
ORDER BY quantidade_faltas DESC;

-- 4. Exiba os cursos e mostre quantos alunos estão matriculados em cada curso.

SELECT cursos.nome_curso, (
    SELECT COUNT(matriculas.id_aluno)
    FROM matriculas
    WHERE matriculas.id_curso = cursos.id_curso
) AS quantidade_matriculas
FROM cursos
GROUP BY cursos.nome_curso
ORDER BY quantidade_matriculas;

-- 5. Liste os alunos e apresente sua maior nota registrada.

SELECT alunos.nome, (
    SELECT MAX(matriculas.nota)
    FROM matriculas
    WHERE matriculas.id_aluno = alunos.id_aluno
) AS maior_nota
FROM alunos
ORDER BY maior_nota DESC;

-- 6. Exiba os cursos e mostre a menor nota registrada em cada curso.

SELECT cursos.nome_curso, (
    SELECT MIN(matriculas.nota)
    FROM matriculas
    WHERE matriculas.id_curso = cursos.id_curso
) AS menor_nota
FROM cursos
ORDER BY menor_nota ASC;

-- 7. Liste os alunos e mostre a média de notas de cada um em uma nova coluna chamada Media_Aluno.

SELECT alunos.nome, (
    SELECT AVG(matriculas.nota)
    FROM matriculas
    WHERE matriculas.id_aluno = alunos.id_aluno
) AS Media_Aluno
FROM alunos
ORDER BY Media_Aluno DESC;

-- 8. Exiba os cursos e apresente o total de faltas registradas em cada curso.

SELECT cursos.nome_curso, (
    SELECT SUM(matriculas.faltas)
    FROM matriculas
    WHERE matriculas.id_curso = cursos.id_curso
) AS total_faltas
FROM cursos
ORDER BY total_faltas DESC;

-- 9. Liste os alunos e mostre a quantidade de cursos diferentes em que estão matriculados.

SELECT alunos.nome, (
    SELECT COUNT(id_curso)
    FROM matriculas
    WHERE matriculas.id_aluno = alunos.id_aluno
) AS quantidade_cursos
FROM alunos
ORDER BY quantidade_cursos DESC;

-- 10. Exiba os cursos e mostre a quantidade de alunos aprovados (nota maior ou igual a 7).

SELECT cursos.nome_curso, (
    SELECT COUNT(nota)
    FROM matriculas
    WHERE matriculas.id_curso = cursos.id_curso AND matriculas.nota > 7
) AS quantidadeAprovados
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY nome_curso
HAVING AVG(matriculas.nota) > 7;

--=========================================
-- QUESTÕES DESAFIO - MISTURANDO GROUP BY + HAVING + SUBQUERY
--=========================================

-- 1. Liste as cidades cuja média de idade seja maior que a média geral de idade dos alunos.

SELECT alunos.cidade
FROM alunos
GROUP BY alunos.cidade
HAVING AVG(alunos.idade) > (
    SELECT AVG(alunos.idade)
    FROM alunos
);

-- 2. Exiba os cursos cuja média de notas seja maior que a média das médias dos cursos.

SELECT cursos.nome_curso
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY cursos.nome_curso
HAVING AVG(matriculas.nota) > (
    SELECT AVG(matriculas.nota)
    FROM matriculas
);

-- 3. Mostre os alunos cuja soma de faltas seja maior que a soma média de faltas dos alunos.

SELeCT alunos.nome
FROM alunos
JOIN matriculas ON matriculas.id_aluno = alunos.id_aluno
GROUP BY alunos.nome
HAVING SUM(matriculas.faltas) > (
    SELECT AVG(matriculas.faltas)
    FROM matriculas
);

-- 4. Liste os cursos que possuem quantidade de matrículas acima da média de matrículas por curso.

SELECT cursos.nome_curso
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY cursos.nome_curso
HAVING COUNT(matriculas.id_matricula) > (
    SELECT AVG(qtdMatriculas)
    FROM (
        SELECT COUNT(matriculas.id_matricula) AS qtdMatriculas
        FROM matriculas
        GROUP BY matriculas.id_curso
    ) AS contagemMediaMatriculas
);

-- 5. Exiba os alunos cuja média de notas seja maior que a média dos alunos da cidade de São Paulo.

SELECT alunos.nome
FROM alunos
JOIN matriculas ON matriculas.id_aluno = alunos.id_aluno
GROUP BY alunos.nome
HAVING AVG(matriculas.nota) > (
    SELECT AVG(matriculas.nota)
    FROM matriculas, alunos
    WHERE alunos.cidade = "São Paulo"
);

-- 6. Mostre os cursos cuja carga horária seja maior que a média das cargas horárias dos cursos com matrícula.

SELECT cursos.nome_curso
FROM cursos
GROUP BY cursos.nome_curso, cursos.carga_horaria
HAVING cursos.carga_horaria > (
    SELECT AVG(cursos.carga_horaria)
    FROM cursos
);

-- 7. Liste os alunos que possuem mais matrículas que a média de matrículas dos alunos.

SELECT alunos.nome
FROM alunos
JOIN matriculas ON matriculas.id_aluno = alunos.id_aluno
GROUP BY alunos.nome
HAVING COUNT(matriculas.id_matricula) > (
    SELECT AVG(qtdMatriculas)
    FROM (
        SELECT COUNT(matriculas.id_matricula) AS qtdMatriculas
        FROM matriculas
        GROUP BY matriculas.id_aluno
    ) AS contagemMediaMatriculas
);

SELECT * FROM matriculas;

-- 8. Exiba os cursos cuja maior nota seja inferior à maior nota geral do sistema.

SELECT cursos.nome_curso, MAX(matriculas.nota) AS maiorNota
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY cursos.nome_curso
HAVING MAX(matriculas.nota) < (
    SELECT MAX(matriculas.nota)
    FROM matriculas
)


-- 9. Mostre os alunos cuja média de faltas seja menor que a média geral de faltas.

SELECT alunos.nome
FROM alunos
JOIN matriculas ON matriculas.id_aluno = alunos.id_aluno
GROUP BY alunos.nome
HAVING AVG(matriculas.faltas) < (
    SELECT AVG(matriculas.faltas)
    FROM matriculas
)

-- 10. Liste os cursos cuja quantidade de alunos aprovados seja maior que a média de aprovados dos cursos.

SELECT cursos.nome_curso, (
    SELECT COUNT(matriculas.id_aluno)
    FROM matriculas
    WHERE matriculas.id_curso = cursos.id_curso AND matriculas.nota > 7
) quantidadeAprovados
FROM cursos
JOIN matriculas ON matriculas.id_curso = cursos.id_curso
GROUP BY cursos.nome_curso, cursos.id_curso
HAVING (
    SELECT COUNT(m.id_aluno)
    FROM matriculas AS m
    WHERE m.id_curso = cursos.id_curso AND m.nota > 7
) > (
    SELECT AVG(contagemMaior)
    FROM (
        SELECT COUNT(matriculas.id_aluno) AS contagemMaior
        FROM matriculas
        WHERE matriculas.nota > 7
        GROUP BY matriculas.id_curso
    ) AS contagemMatriculas
);