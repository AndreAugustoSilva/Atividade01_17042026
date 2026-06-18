-- =========================
-- HOSPITAIS
-- =========================
INSERT INTO hospitais (nome_hospital, cep, horario_funcionamento, lotacao_maxima, categoria_hospital) VALUES
('Hospital Santa Catarina', '88010001', '07:00:00', 250, 'Público'),
('Hospital São Lucas', '88020002', '06:30:00', 180, 'Privado');

-- =========================
-- SETORES
-- =========================
INSERT INTO setores (nome_setor, gerente_setor, descricao_setor) VALUES
('Emergência', 'Carlos Almeida', 'Atendimento de urgência e emergência'),
('Clínica Geral', 'Mariana Souza', 'Consultas gerais'),
('Ortopedia', 'Rafael Costa', 'Tratamento de lesões ósseas');

-- =========================
-- USUÁRIOS
-- =========================
INSERT INTO usuariossistema (usuario, senha_hash, nivel_acesso) VALUES
('admin', 'hash_admin', 'ADMIN'),
('medico1', 'hash_med1', 'MEDICO'),
('medico2', 'hash_med2', 'MEDICO');

-- =========================
-- MÉDICOS
-- =========================
INSERT INTO medicos (nome_medico, telefone_medico, email_medico, salario_medico, especialidade, id_hospital) VALUES
('Dr. João Pereira', '48999990001', 'joao@hospital.com', 15000.00, 'Clínica Geral', 1),
('Dra. Ana Martins', '48999990002', 'ana@hospital.com', 14500.00, 'Pediatria', 1),
('Dr. Carlos Mendes', '48999990003', 'carlos@hospital.com', 16000.00, 'Ortopedia', 2);

-- =========================
-- PACIENTES
-- =========================
INSERT INTO pacientes (nome_paciente, cpf, data_nascimento, telefone, email, endereco, tipo_sanguineo, alergias, id_hospital) VALUES
('Lucas Silva', '12345678901', '1990-05-10', '48988880001', 'lucas@email.com', 'Rua A', 'O+', NULL, 1),
('Maria Oliveira', '12345678902', '1985-03-22', '48988880002', 'maria@email.com', 'Rua B', 'A-', 'Dipirona', 1),
('Pedro Santos', '12345678903', '2000-11-15', '48988880003', 'pedro@email.com', 'Rua C', 'B+', NULL, 2),
('Juliana Costa', '12345678904', '1995-07-09', '48988880004', 'juliana@email.com', 'Rua D', 'AB+', NULL, 2),
('Fernanda Lima', '12345678905', '1978-12-01', '48988880005', 'fernanda@email.com', 'Rua E', 'O-', 'Penicilina', 1),
('Rafael Souza', '12345678906', '1992-09-18', '48988880006', 'rafael@email.com', 'Rua F', 'A+', NULL, 2),
('Camila Rocha', '12345678907', '2001-02-25', '48988880007', 'camila@email.com', 'Rua G', 'B-', NULL, 1),
('Bruno Alves', '12345678908', '1988-06-11', '48988880008', 'bruno@email.com', 'Rua H', 'O+', NULL, 1);

-- =========================
-- MEDICAMENTOS (POUCOS + MUITO USO FUTURO)
-- =========================
INSERT INTO medicamentos (nome_medicamento, fabricante, qtd_estoque, preco_medicamento) VALUES
('Paracetamol 500mg', 'EMS', 1000, 10.00),
('Dipirona 1g', 'Medley', 900, 8.50),
('Ibuprofeno 600mg', 'Bayer', 700, 18.00),
('Amoxicilina 500mg', 'EMS', 500, 25.00),
('Omeprazol 20mg', 'AstraZeneca', 600, 22.00);

-- =========================
-- CONSULTAS (MUITAS PARA GERAR MÉTRICAS)
-- =========================
INSERT INTO consultas (data_consulta, diagnostico, observacoes, valor_consulta, id_paciente, id_medico) VALUES
('2026-06-01 08:00:00', 'Dor de cabeça', 'Sintomático', 150.00, 1, 1),
('2026-06-01 09:00:00', 'Febre', 'Observação', 150.00, 2, 1),
('2026-06-01 10:00:00', 'Gripe', 'Repouso', 150.00, 3, 2),
('2026-06-01 11:00:00', 'Inflamação', 'Anti-inflamatório', 200.00, 4, 3),
('2026-06-02 08:00:00', 'Dor muscular', 'Ibuprofeno prescrito', 200.00, 5, 3),
('2026-06-02 09:00:00', 'Febre alta', 'Monitoramento', 150.00, 6, 1),
('2026-06-02 10:00:00', 'Infecção leve', 'Antibiótico', 250.00, 7, 2),
('2026-06-02 11:00:00', 'Dor abdominal', 'Observação', 200.00, 8, 1),
('2026-06-03 08:00:00', 'Gripe', 'Sintomático', 150.00, 1, 2),
('2026-06-03 09:00:00', 'Febre', 'Dipirona', 150.00, 2, 1),
('2026-06-03 10:00:00', 'Dor de cabeça', 'Paracetamol', 150.00, 3, 1),
('2026-06-03 11:00:00', 'Inflamação', 'Ibuprofeno', 200.00, 4, 3),
('2026-06-04 08:00:00', 'Gripe', 'Repouso', 150.00, 5, 2),
('2026-06-04 09:00:00', 'Febre', 'Dipirona', 150.00, 6, 1),
('2026-06-04 10:00:00', 'Infecção', 'Amoxicilina', 250.00, 7, 2),
('2026-06-04 11:00:00', 'Dor muscular', 'Ibuprofeno', 200.00, 8, 3);

-- =========================
-- RECEITAS (MEDICAMENTOS REPETIDOS PARA ESTATÍSTICA)
-- =========================
INSERT INTO receitas (id_consulta, id_medicamento, data_receita, observacoes) VALUES
(1, 1, '2026-06-01', 'Dor de cabeça'),
(2, 2, '2026-06-01', 'Febre'),
(3, 1, '2026-06-01', 'Gripe'),
(4, 3, '2026-06-01', 'Inflamação'),
(5, 3, '2026-06-02', 'Dor muscular'),
(6, 2, '2026-06-02', 'Febre alta'),
(7, 4, '2026-06-02', 'Infecção'),
(8, 1, '2026-06-02', 'Dor abdominal'),
(9, 1, '2026-06-03', 'Gripe'),
(10, 2, '2026-06-03', 'Febre'),
(11, 1, '2026-06-03', 'Dor de cabeça'),
(12, 3, '2026-06-03', 'Inflamação'),
(13, 1, '2026-06-04', 'Gripe'),
(14, 2, '2026-06-04', 'Febre'),
(15, 4, '2026-06-04', 'Infecção'),
(16, 3, '2026-06-04', 'Dor muscular');

-- =========================
-- DETALHE RECEITA-MEDICAMENTO
-- =========================
INSERT INTO receitamedicamento (id_receita, id_medicamento, dosagem_receitaMedicamento, frequencia_receitaMedicamento, observacao_receitaMedicamento) VALUES
(1, 1, '500mg', '6/6h', 'Uso leve'),
(2, 2, '1g', '8/8h', 'Febre'),
(3, 1, '500mg', '6/6h', 'Gripe'),
(4, 3, '600mg', '8/8h', 'Inflamação'),
(5, 3, '600mg', '8/8h', 'Dor muscular'),
(6, 2, '1g', '6/6h', 'Febre alta'),
(7, 4, '500mg', '12/12h', 'Antibiótico'),
(8, 1, '500mg', '6/6h', 'Dor'),
(9, 1, '500mg', '6/6h', 'Gripe'),
(10, 2, '1g', '8/8h', 'Febre'),
(11, 1, '500mg', '6/6h', 'Dor cabeça'),
(12, 3, '600mg', '8/8h', 'Inflamação'),
(13, 1, '500mg', '6/6h', 'Gripe'),
(14, 2, '1g', '8/8h', 'Febre'),
(15, 4, '500mg', '12/12h', 'Infecção'),
(16, 3, '600mg', '8/8h', 'Dor muscular');