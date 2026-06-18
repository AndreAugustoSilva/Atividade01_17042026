# Query's André
-- Liste os medicamentos por ordem de uso
SELECT m.nome_medicamento AS nomeMedicamento, COUNT(r.id_medicamento) AS quantidadeUso
FROM medicamentos AS m
JOIN receitas AS r ON r.id_medicamento = m.id_medicamento
GROUP BY m.id_medicamento, m.nome_medicamento
ORDER BY quantidadeUso DESC;

-- Liste os hospitais e suas vagas restantes
SELECT 
    h.nome_hospital AS nomeHospital, 
    (h.lotacao_maxima - COUNT(p.id_paciente)) AS vagasRestantes
FROM hospitais AS h
JOIN pacientes AS p ON p.id_hospital = h.id_hospital
GROUP BY h.id_hospital, h.nome_hospital, h.lotacao_maxima
ORDER BY vagasRestantes ASC;

# Query's Pedro
SELECT especialidade, COUNT(C.id_consulta) as qtd_consultas
FROM medicos as M
JOIN consultas as C ON C.id_medico = M.id_medico
GROUP BY especialidade
HAVING qtd_consultas > (
    SELECT AVG(qtd_consultas) as media_consultas
    FROM (
        SELECT COUNT(C.id_consulta) as qtd_consultas
        FROM medicos as M  
        JOIN consultas as C ON C.id_medico = M.id_medico
        GROUP BY especialidade
    ) as t
);

SELECT AVG(qtd_consultas) as media_consultas_p_especialidade
FROM (
    SELECT COUNT(C.id_consulta) as qtd_consultas
    FROM medicos as M  
    JOIN consultas as C ON C.id_medico = M.id_medico
    GROUP BY especialidade
) as t;

SELECT 
    SUM(CASE WHEN data_nascimento > '2022-01-01' THEN 1 ELSE 0 END) AS bebes,
    SUM(CASE WHEN data_nascimento BETWEEN '2016-01-01' AND '2022-01-01' THEN 1 ELSE 0 END) AS criancas,
    SUM(CASE WHEN data_nascimento BETWEEN '2009-01-01' AND '2016-01-01' THEN 1 ELSE 0 END) AS adolescentes,
    SUM(CASE WHEN data_nascimento BETWEEN '2000-01-01' AND '2009-01-01' THEN 1 ELSE 0 END) AS jovens,
    SUM(CASE WHEN data_nascimento BETWEEN '1986-01-01' AND '2000-01-01' THEN 1 ELSE 0 END) AS adultos,
    SUM(CASE WHEN data_nascimento BETWEEN '1971-01-01' AND '1986-01-01' THEN 1 ELSE 0 END) AS meia_idade,
    SUM(CASE WHEN data_nascimento BETWEEN '1946-01-01' AND '1971-01-01' THEN 1 ELSE 0 END) AS idosos,
    SUM(CASE WHEN data_nascimento BETWEEN '0001-01-01' AND '1946-01-01' THEN 1 ELSE 0 END) AS legend
FROM pacientes;


# Query's Alannis
--Liste os medicos cuja a média de atendimentos seja maior que a média geral de atendimentos
select m.nome_medico, avg(e.id_exame) from medicos m
join exames e on m.id_medico = e.id_medico
GROUP BY nome_medico
HAVING avg(id_exame) > (
    select avg(id_exame) from exames 
);
select avg(id_exame) from exames;

--Liste os pacientes que tem convenio e o preco do convenio seja maior que 600
select 
p.nome_paciente, 
c.nome_convenio, c.mensalidade
from pacientes p
join paciente_convenio pc on p.id_paciente = pc.id_paciente
join convenios c on pc.id_convenio = c.id_convenio
WHERE c.mensalidade > 600;


# Query's Natalia
-- Convênio mais barato
SELECT nome_convenio, mensalidade FROM convenios
WHERE mensalidade = (SELECT MIN(mensalidade) FROM convenios);

-- Salário mais alto 
SELECT cargo_funcionario, salario_funcionario FROM funcionarios
WHERE salario_funcionario = (SELECT MAX(salario_funcionario) FROM funcionarios);


# Query's Jullia
-- Pacientes com alergias a algum meidcamento
select cpf, nome_paciente, alergias FROM pacientes
where alergias IS NOT NULL;

-- Exame com tempo estimado maior que 40 min
select p.nome_paciente, e.nome_exame, e.tempo_estimado_exame 
FROM pacientes p 
INNER JOIN exames e ON p.id_paciente = e.id_paciente
where e.tempo_estimado_exame > '00:20:00';

--========================================
--============== EXERCÍCIOS ==============
--========================================

-- Problemas Operacionais

-- 1 Qual hospital realizou o maior número de atendimentos? — Permite identificar a unidade com maior demanda e apoiar decisões de expansão de infraestrutura e equipes.

SELECT COUNT(c.id_paciente) AS numeroAtendimentos, p.id_hospital
FROM consultas AS c
JOIN pacientes AS p ON p.id_paciente = c.id_paciente
GROUP BY p.id_hospital;

-- 2 Qual especialidade médica foi mais procurada pelos pacientes? — Ajuda a entender quais áreas da saúde concentram mais atendimentos e exigem maior investimento.

SELECT COUNT(c.id_medico) AS numeroBuscas, m.especialidade
FROM consultas AS c
JOIN medicos AS m ON m.id_medico = c.id_medico
GROUP BY m.especialidade;

-- 3 Quais pacientes retornaram ao hospital mais de uma vez no período analisado? — Possibilita identificar padrões de recorrência e necessidades de acompanhamento contínuo.

SELECT p.nome_paciente, COUNT(c.id_paciente) AS quantidadeAtendimentos
FROM pacientes AS p
JOIN consultas AS c ON c.id_paciente = p.id_paciente
WHERE c.data_consulta BETWEEN '2026-06-01 09:00:00' AND '2026-06-03 09:00:00'
GROUP BY p.nome_paciente
HAVING COUNT(c.id_paciente) > 1;

-- 4 Qual horário concentrou a maior quantidade de consultas? — Auxilia no planejamento de escalas médicas e otimização do atendimento.

SELECT TIME(c.data_consulta), COUNT(c.id_paciente) AS quantidadeAtendimentos
FROM consultas AS c
GROUP BY TIME(c.data_consulta)
ORDER BY COUNT(c.id_paciente);

-- 5 Quanto cada médico faturou em consultas realizadas? — Permite avaliar a contribuição financeira individual dos profissionais.

SELECT m.nome_medico, SUM(c.valor_consulta) AS totalGanho
FROM consultas AS c
JOIN medicos AS m ON m.id_medico = c.id_medico
GROUP BY m.nome_medico
ORDER BY SUM(c.valor_consulta) DESC

-- 6 Quanto cada hospital arrecadou com consultas? — Fornece uma visão comparativa do desempenho financeiro das unidades.

SELECT h.nome_hospital, SUM(c.valor_consulta) AS totalGanho
FROM hospitais AS h
JOIN pacientes AS p ON p.id_hospital = h.id_hospital
JOIN consultas AS c ON c.id_paciente = p.id_paciente
GROUP BY h.nome_hospital
ORDER BY SUM(c.valor_consulta) DESC;

-- 7 Qual é o valor médio das consultas realizadas? — Serve como indicador financeiro para análise de receita e precificação dos serviços.

SELECT AVG(c.valor_consulta) AS valorMedioConsultas
FROM consultas AS c

-- 8 Qual médico gerou o maior faturamento para a instituição? — Identifica os profissionais com maior impacto financeiro na operação.

SELECT m.nome_medico, SUM(c.valor_consulta) AS totalFaturado
FROM consultas AS c
JOIN medicos AS m ON m.id_medico = c.id_medico
GROUP BY m.nome_medico
ORDER BY SUM(c.valor_consulta) DESC

-- 9 Quais médicos possuem salário acima da média da equipe médica? — Auxilia em análises de remuneração e políticas salariais.

SELECT m.nome_medico, m.salario_medico
FROM medicos AS m
WHERE m.salario_medico > (
    SELECT AVG(m.salario_medico)
    FROM medicos AS m
);

-- 10 Qual medicamento foi mais prescrito pelos médicos? — Permite identificar os medicamentos de maior consumo e planejar reposições de estoque.

SELECT m.nome_medicamento, COUNT(r.id_medicamento)
FROM medicamentos AS m
JOIN receitas AS r ON r.id_medicamento = m.id_medicamento
GROUP BY m.nome_medicamento
ORDER BY COUNT(r.id_medicamento) DESC;

-- 11 Qual é o ranking dos medicamentos mais utilizados? — Ajuda a compreender o perfil de consumo farmacêutico da instituição.

SELECT m.nome_medicamento, COUNT(r.id_medicamento)
FROM medicamentos AS m
JOIN receitas AS r ON r.id_medicamento = m.id_medicamento
GROUP BY m.nome_medicamento
ORDER BY COUNT(r.id_medicamento) DESC;

-- 12 Quais medicamentos estão com estoque abaixo do limite mínimo definido? — Possibilita ações preventivas para evitar falta de medicamentos.

SELECT m.nome_medicamento, m.qtd_estoque
FROM medicamentos AS m
WHERE qtd_estoque < 700;

-- 13 Quais medicamentos são mais utilizados para cada diagnóstico registrado? — Permite analisar padrões terapêuticos adotados pelos profissionais.

SELECT m.nome_medicamento, COUNT(r.id_medicamento)
FROM medicamentos AS m
JOIN receitas AS r ON r.id_medicamento = m.id_medicamento
GROUP BY m.nome_medicamento
ORDER BY COUNT(r.id_medicamento) DESC;

-- 14 Quais medicamentos cadastrados nunca foram prescritos? — Ajuda a identificar itens com baixa rotatividade ou possíveis excessos de estoque.

SELECT m.nome_medicamento
FROM medicamentos AS m
JOIN receitas AS r ON r.id_medicamento = m.id_medicamento
WHERE r.id_medicamento IS NULL

-- 15 Quais pacientes possuem alergias registradas em seu prontuário? — Facilita consultas rápidas para aumentar a segurança dos atendimentos.

SELECT p.nome_paciente, p.alergias
FROM pacientes AS p
WHERE p.alergias IS NOT NULL;

-- 16 Como está distribuída a população de pacientes por tipo sanguíneo? — Auxilia no planejamento de campanhas e gestão de necessidades transfusionais.

SELECT p.tipo_sanguineo, COUNT(p.id_paciente)
FROM pacientes AS p
GROUP BY p.tipo_sanguineo
ORDER BY COUNT(p.id_paciente) DESC;

-- 17 Quem são os pacientes mais velhos cadastrados no sistema? — Permite identificar grupos que podem demandar maior atenção médica.

SELECT p.nome_paciente, p.data_nascimento
FROM pacientes AS p
ORDER BY p.data_nascimento;

-- 18 Quantos pacientes estão vinculados a cada hospital? — Fornece uma visão da distribuição da base de pacientes entre as unidades.

SELECT h.nome_hospital, COUNT(p.id_paciente)
FROM hospitais AS h
JOIN pacientes AS p ON p.id_hospital = h.id_hospital
GROUP BY h.nome_hospital

-- 19 Quais pacientes já foram atendidos por mais de um médico? — Possibilita analisar o compartilhamento de casos e a continuidade do cuidado.

SELECT p.nome_paciente, COUNT(DISTINCT c.id_medico) AS quantidadeMedicos
FROM pacientes AS p
JOIN consultas AS c ON c.id_paciente = p.id_paciente
GROUP BY p.nome_paciente
HAVING COUNT(DISTINCT c.id_medico) > 1;

-- 20 Qual a participação percentual de cada hospital no total de atendimentos realizados? — Permite comparar a representatividade operacional de cada unidade dentro da rede.


