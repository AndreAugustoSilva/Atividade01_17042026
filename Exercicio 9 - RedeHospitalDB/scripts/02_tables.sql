CREATE TABLE hospitais (
    id_hospital INT PRIMARY KEY AUTO_INCREMENT,
    nome_hospital VARCHAR(100) NOT NULL,
    cep CHAR(8) NOT NULL,
    horario_funcionamento TIME NOT NULL,
    lotacao_maxima SMALLINT,
    categoria_hospital VARCHAR(50)
);

CREATE TABLE medicos (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nome_medico VARCHAR(100) NOT NULL,
    telefone_medico VARCHAR(20),
    email_medico VARCHAR(100),
    salario_medico DECIMAL(10,2),
    especialidade VARCHAR(50) NOT NULL,

    id_hospital INT NOT NULL,

    FOREIGN KEY (id_hospital)
        REFERENCES hospitais(id_hospital)
);

CREATE TABLE pacientes (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome_paciente VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE,
    telefone CHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(200),
    tipo_sanguineo VARCHAR(5),
    alergias TEXT,
    
    id_hospital INT,
    
    FOREIGN KEY (id_hospital)
        REFERENCES hospitais(id_hospital)
);

CREATE TABLE convenios (
    id_convenio INT PRIMARY KEY AUTO_INCREMENT,
    nome_convenio VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    cobertura TEXT,
    mensalidade DECIMAL(10, 2) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE paciente_convenio (
    id_paciente_convenio INT PRIMARY KEY AUTO_INCREMENT,
 
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,

    numero_carteira VARCHAR(50),

    FOREIGN KEY (id_paciente)
        REFERENCES pacientes(id_paciente),

    FOREIGN KEY (id_convenio)
        REFERENCES convenios(id_convenio)
);

CREATE TABLE consultas (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,

    data_consulta DATETIME NOT NULL,
    diagnostico TEXT,
    observacoes TEXT,
    valor_consulta DECIMAL(10,2),

    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,

    FOREIGN KEY (id_paciente)
        REFERENCES pacientes(id_paciente),

    FOREIGN KEY (id_medico)
        REFERENCES medicos(id_medico)
);

CREATE TABLE medicamentos (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_medicamento VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100),
    qtd_estoque INT,
    preco_medicamento DECIMAL(10,2)
);

CREATE TABLE receitas (
    id_receita INT PRIMARY KEY AUTO_INCREMENT,
 
    id_consulta INT NOT NULL,
    id_medicamento INT NOT NULL,

    data_receita DATE,
    observacoes TEXT,

    FOREIGN KEY (id_consulta)
        REFERENCES consultas(id_consulta),
    FOREIGN KEY (id_medicamento)
        REFERENCES medicamentos(id_medicamento)
);

CREATE TABLE receitamedicamento (
   id_receita_medicamento INT PRIMARY KEY AUTO_INCREMENT,

   id_receita INT NOT NULL,
   id_medicamento INT NOT NULL,

   dosagem_receitaMedicamento VARCHAR(100),
   frequencia_receitaMedicamento VARCHAR(100),
   observacao_receitaMedicamento TEXT,

   FOREIGN KEY (id_receita)
       REFERENCES receitas(id_receita),

   FOREIGN KEY (id_medicamento)
       REFERENCES medicamentos(id_medicamento)
);

CREATE TABLE exames (
   id_exame INT PRIMARY KEY AUTO_INCREMENT,

   nome_exame VARCHAR(100),
   resultado_exame TEXT,
   data_exame DATE,
   tempo_estimado_exame TIME,

   id_paciente INT NOT NULL,
   id_medico INT NOT NULL,

   FOREIGN KEY (id_paciente)
       REFERENCES pacientes(id_paciente),

   FOREIGN KEY (id_medico)
       REFERENCES medicos(id_medico)
);

CREATE TABLE quartos (
   id_quarto INT PRIMARY KEY AUTO_INCREMENT,

   numero_quarto VARCHAR(10),
   tipo_quarto VARCHAR(50),
   capacidade_quarto INT,
   status_quarto VARCHAR(50),

   id_hospital INT NOT NULL,

   FOREIGN KEY (id_hospital)
       REFERENCES hospitais(id_hospital)
);

CREATE TABLE internacoes (
   id_internacao INT PRIMARY KEY AUTO_INCREMENT,

   data_entrada_internacao DATETIME,
   data_saida_internacao DATETIME,
   motivo_internacao TEXT,

   id_paciente INT NOT NULL,
   id_quarto INT NOT NULL,

   FOREIGN KEY (id_paciente)
       REFERENCES pacientes(id_paciente),

   FOREIGN KEY (id_quarto)
       REFERENCES quartos(id_quarto)
);

CREATE TABLE setores (
   id_setor INT PRIMARY KEY AUTO_INCREMENT,
   nome_setor VARCHAR(100) NOT NULL,
   gerente_setor VARCHAR(100) NOT NULL,
   descricao_setor TEXT
);

CREATE TABLE funcionarios (
   id_funcionario INT PRIMARY KEY AUTO_INCREMENT,

   nome_funcionario VARCHAR(100),
   cpf_funcionario CHAR(11),
   cargo_funcionario VARCHAR(100),
   salario_funcionario DECIMAL(10,2),
   data_admissao_funcionario DATE,
   carga_horaria_funcionario TIME,

   id_setor INT NOT NULL,
   id_hospital INT NOT NULL,

   FOREIGN KEY (id_setor)
       REFERENCES setores(id_setor),

   FOREIGN KEY (id_hospital)
       REFERENCES hospitais(id_hospital)
);

CREATE TABLE pagamentos (
   id_pagamento INT PRIMARY KEY AUTO_INCREMENT,

   valor_pagamento DECIMAL(10,2),
   data_pagamento DATE,
   forma_pagamento VARCHAR(50),

   id_consulta INT,

   FOREIGN KEY (id_consulta)
       REFERENCES consultas(id_consulta)
);

CREATE TABLE usuariossistema (
   id_usuario INT PRIMARY KEY AUTO_INCREMENT,

   usuario VARCHAR(50) UNIQUE,
   senha_hash VARCHAR(255),
   nivel_acesso VARCHAR(50)
);

CREATE TABLE Logs (
   id_log INT PRIMARY KEY AUTO_INCREMENT,

   acao_log TEXT,
   data_log DATETIME,

   id_usuario INT,

   FOREIGN KEY (id_usuario)
       REFERENCES usuariossistema(id_usuario)
);