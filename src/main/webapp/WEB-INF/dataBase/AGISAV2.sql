USE master
CREATE DATABASE SistemaAGISAV2
GO
USE SistemaAGISAV2 
GO
CREATE TABLE curso (
    codigo INT CHECK (codigo >= 0 AND codigo <= 100),
    nome VARCHAR(100),
    cargaHoraria INT,            
    sigla VARCHAR(10),
    ultimaNotaENADE DECIMAL(5,2),
    turno VARCHAR(20),
    periodo_matricula_inicio DATE,
    periodo_matricula_fim DATE,
    PRIMARY KEY (codigo)
)
GO

CREATE TABLE aluno (
    CPF CHAR(11) UNIQUE,
    nome VARCHAR(100),
    nomeSocial VARCHAR(100),
    dataNascimento DATE,
    telefoneContato VARCHAR(20),
    emailPessoal VARCHAR(100),
    emailCorporativo VARCHAR(100),
    dataConclusao2Grau DATE,
    instituicaoConclusao2Grau VARCHAR(100),
    pontuacaoVestibular DECIMAL(5,2),
    posicaoVestibular INT,
    anoIngresso INT,
    semestreIngresso INT,
    semestreAnoLimiteGraduacao DATE,
    RA INT,
    curso INT,
    PRIMARY KEY (CPF),
    FOREIGN KEY (curso) REFERENCES curso(codigo)
)
GO
CREATE TABLE professor (
    codigo INT ,
    nome VARCHAR(100) ,
    titulacao VARCHAR(50),
    PRIMARY KEY (codigo)
)
GO
CREATE TABLE disciplina (
    codigo INT IDENTITY (1001,1),
    nome VARCHAR(100),
    horasSemanais INT,
    horarioInicio VARCHAR(10),
    semestre INT,
    diaSemana VARCHAR(20),
    codigoProfessor INT,    
    codigoCurso INT,    
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigoProfessor) REFERENCES professor(codigo),
    FOREIGN KEY (codigoCurso) REFERENCES curso(codigo)
)
GO
CREATE TABLE telefone (
    aluno CHAR(11),
    numero CHAR(12),
    tipo VARCHAR(100),
    PRIMARY KEY (aluno, numero),
    FOREIGN KEY (aluno) REFERENCES aluno(CPF)
)
GO
CREATE TABLE matricula (
    codigo INT,
    codigoAluno CHAR(11),
    dataMatricula DATE,
    semestre INT,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigoAluno) REFERENCES aluno(CPF)
)
GO
CREATE TABLE matriculaDisciplina (
    codigoMatricula INT,
    codigoDisciplina INT,
    situacao VARCHAR(20),
    notaFinal DECIMAL (4,2),
    PRIMARY KEY (codigoMatricula, codigoDisciplina),
    FOREIGN KEY (codigoMatricula) REFERENCES matricula(codigo),
    FOREIGN KEY (codigoDisciplina) REFERENCES disciplina(codigo),
)
GO
CREATE TABLE conteudo(
    codigo INT,
    nome VARCHAR(100) ,
    descricao VARCHAR(100),
    codigoDisciplina INT,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigoDisciplina) REFERENCES disciplina (codigo)
)
GO
CREATE TABLE eliminacoes (
    codigo INT IDENTITY(1,1),
    codigoMatricula		INT,
    codigoDisciplina    INT,
    dataEliminacao		DATE,
	status VARCHAR(30) DEFAULT 'Em análise',
    nomeInstituicao  	VARCHAR(255),
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigoMatricula, codigoDisciplina) REFERENCES matriculaDisciplina(codigoMatricula, codigoDisciplina)
)
GO
CREATE TABLE listaChamada (
    codigo INT,
    codigoMatricula INT,
    codigoDisciplina INT,
    dataChamada DATE,
	presenca1 INT,
    presenca2 INT,
	presenca3 INT,
	presenca4 INT
	PRIMARY KEY (codigo),
    FOREIGN KEY (codigoMatricula, codigoDisciplina) REFERENCES matriculaDisciplina(codigoMatricula, codigoDisciplina)
)
GO



INSERT INTO curso (codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno, periodo_matricula_inicio, periodo_matricula_fim) 
VALUES 
(1, 'Administração de Empresas', 4000, 'ADM', 7.8, 'Matutino', '2024-01-01', '2025-01-01'),
(2, 'Engenharia Civil', 4500, 'ENG CIV', 8.5, 'Vespertino', '2024-01-01', '2025-01-01'),
(3, 'Direito', 4000, 'DIR', 8.2, 'Noturno', '2024-01-01', '2025-01-01'),
(4, 'Medicina', 6000, 'MED', 9.3, 'Integral', '2024-01-01', '2025-01-01'),
(5, 'Ciência da Computação', 3600, 'CC', 8.9, 'Matutino', '2024-01-01', '2025-01-01'),
(6, 'Psicologia', 4200, 'PSI', 8.0, 'Vespertino', '2024-01-01', '2025-01-01'),
(7, 'Administração Pública', 3800, 'ADM PUB', 7.5, 'Noturno', '2024-01-01', '2025-01-01'),
(8, 'Engenharia Elétrica', 4800, 'ENG ELE', 8.7, 'Integral', '2024-01-01', '2025-01-01'),
(9, 'Gastronomia', 3200, 'GAS', 7.0, 'Matutino', '2024-01-01', '2025-01-01'),
(10, 'Arquitetura e Urbanismo', 4200, 'ARQ', 8.4, 'Vespertino', '2024-01-01', '2025-01-01'),
(11, 'Analise e Desenvolvimento de Sistemas', 4200, 'ADS', 8.4, 'Vespertino', '2024-01-01', '2024-01-01');
GO
INSERT INTO aluno (CPF, nome, nomeSocial, dataNascimento, telefoneContato, emailPessoal, emailCorporativo, dataConclusao2Grau, instituicaoConclusao2Grau, pontuacaoVestibular, posicaoVestibular, anoIngresso, semestreIngresso, semestreAnoLimiteGraduacao, RA, curso)
VALUES
('55312103020', 'João Silva', NULL, '1998-05-15', '123456789', 'joao@email.com', 'joao@empresa.com', '2016-12-20', 'Escola Estadual ABC', 8.75, 25, 2016, 1, '2020-12-31', 2016456, 1),
('86462326034', 'Maria Santos', NULL, '1999-09-22', '987654321', 'maria@email.com', 'maria@empresa.com', '2017-05-10', 'Escola Municipal XYZ', 8.50, 30, 2017, 1, '2021-12-31', 20174567, 2),
('39112829072', 'José Oliveira', NULL, '1997-02-10', '987123456', 'jose@email.com', 'jose@empresa.com', '2016-08-30', 'Colégio Particular QRS', 9.00, 15, 2016, 2, '2020-12-31', 2016378, 1),
('39590327060', 'Ana Souza', NULL, '2000-11-05', '654987321', 'ana@email.com', 'ana@empresa.com', '2017-11-28', 'Escola Estadual XYZ', 8.25, 40, 2017, 1, '2021-12-31', 2016789, 2),
('09129892031', 'Pedro Lima', NULL, '1996-07-30', '987123654', 'pedro@email.com', 'pedro@empresa.com', '2016-04-12', 'Colégio Municipal DEF', 8.90, 20, 2016, 2, '2020-12-31', 20167890, 1),
('89125916068', 'Juliana Castro', NULL, '1999-03-18', '654321987', 'juliana@email.com', 'juliana@empresa.com', '2017-09-03', 'Colégio Estadual LMN', 8.80, 10, 2017, 1, '2021-12-31', 2016901, 2),
('97006247063', 'Lucas Almeida', NULL, '1998-12-25', '321987654', 'lucas@email.com', 'lucas@empresa.com', '2016-10-05', 'Escola Particular GHI', 8.70, 35, 2016, 2, '2020-12-31', 20169012, 1),
('12697967044', 'Carla Pereira', NULL, '2001-04-08', '987321654', 'carla@email.com', 'carla@empresa.com', '2017-12-15', 'Colégio Municipal OPQ', 8.45, 50, 2017, 1, '2021-12-31', 201690123, 2),
('29180596096', 'Marcos Fernandes', NULL, '1997-10-20', '654321789', 'marcos@email.com', 'marcos@empresa.com', '2016-06-18', 'Escola Estadual RST', 8.95, 5, 2016, 1, '2020-12-31', 201634, 1),
('30260403040', 'Aline Rocha', NULL, '2000-01-12', '321654987', 'aline@email.com', 'aline@empresa.com', '2017-08-20', 'Colégio Particular UVW', 8.60, 45, 2017, 2, '2021-12-31', 2017450, 2);
GO
-- Semestre 1
INSERT INTO professor (codigo, nome, titulacao) VALUES
(1, 'Carlos Silva', 'Doutor'),
(2, 'Ana Santos', 'Mestre'),
(3, 'Paulo Oliveira', 'Doutor'),
(4, 'Maria Costa', 'Mestre'),
(5, 'Fernanda Mendes', 'Doutor'),
(6, 'José Pereira', 'Mestre'),
(7, 'Aline Almeida', 'Doutor'),
(8, 'Rafael Ramos', 'Mestre'),
(9, 'Juliana Fernandes', 'Doutor'),
(10, 'Marcos Sousa', 'Mestre'),
(11, 'Larissa Lima', 'Doutor'),
(12, 'Gustavo Gomes', 'Mestre'),
(13, 'Camila Oliveira', 'Doutor'),
(14, 'Pedro Barbosa', 'Mestre'),
(15, 'Patrícia Martins', 'Doutor'),
(16, 'Lucas Santos', 'Mestre'),
(17, 'Tatiane Costa', 'Doutor'),
(18, 'Felipe Oliveira', 'Mestre'),
(19, 'Amanda Lima', 'Doutor'),
(20, 'Daniel Pereira', 'Mestre'),
(21, 'Carla Almeida', 'Doutor'),
(22, 'Renato Ramos', 'Mestre'),
(23, 'Laura Fernandes', 'Doutor'),
(24, 'Marcelo Sousa', 'Mestre'),
(25, 'Sandra Lima', 'Doutor'),
(26, 'Diego Gomes', 'Mestre'),
(27, 'Vanessa Oliveira', 'Doutor'),
(28, 'Thiago Barbosa', 'Mestre'),
(29, 'Erika Martins', 'Doutor'),
(30, 'Rodrigo Santos', 'Mestre'),
(31, 'Patricia Costa', 'Doutor'),
(32, 'Fernando Oliveira', 'Mestre'),
(33, 'Luciana Lima', 'Doutor'),
(34, 'Giovanni Pereira', 'Mestre'),
(35, 'Bruna Almeida', 'Doutor'),
(36, 'Renan Ramos', 'Mestre'),
(37, 'Jessica Fernandes', 'Doutor'),
(38, 'Marcela Sousa', 'Mestre'),
(39, 'Luciano Lima', 'Doutor'),
(40, 'Roberta Oliveira', 'Mestre'),
(41, 'Thales Barbosa', 'Doutor'),
(42, 'Vanessa Martins', 'Mestre'),
(43, 'Guilherme Santos', 'Doutor'),
(44, 'Fabiana Costa', 'Mestre'),
(45, 'Leandro Oliveira', 'Doutor'),
(46, 'Nathalia Gomes', 'Mestre'),
(47, 'Vitoria Lima', 'Doutor'),
(48, 'Ricardo Pereira', 'Mestre'),
(49, 'Carolina Almeida', 'Doutor'),
(50, 'Matheus Ramos', 'Mestre');
GO
-- Disciplinas Curso 1
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Administração', 4, '13:00', 1, 'Segunda-feira', 1, 1),
('Contabilidade Financeira', 2, '13:00', 1, 'Terça-feira', 2, 1),
('Economia Empresarial', 4, '13:00', 1, 'Quarta-feira', 3, 1),
('Gestão de Pessoas', 2, '13:00', 1, 'Quinta-feira', 4, 1),
('Marketing e Vendas', 4, '13:00', 1, 'Sexta-feira', 5, 1),
('Empreendedorismo', 2, '13:00', 1, 'Sábado', 6, 1),
('Gestão Estratégica', 4, '13:00', 2, 'Segunda-feira', 7, 1),
('Logística Empresarial', 2, '13:00', 2, 'Terça-feira', 8, 1),
('Direito Empresarial', 4, '13:00', 2, 'Quarta-feira', 9, 1),
('Finanças Corporativas', 2, '13:00', 2, 'Quinta-feira', 10, 1),
('Gestão de Projetos', 4, '13:00', 2, 'Sexta-feira', 1, 1),
('Comportamento Organizacional', 2, '13:00', 2, 'Sábado', 2, 1),
('Gestão de Qualidade', 4, '14:50', 3, 'Segunda-feira', 3, 1),
('Administração de Produção', 2, '14:50', 3, 'Terça-feira', 4, 1),
('Comunicação Empresarial', 4, '14:50', 3, 'Quarta-feira', 5, 1),
('Tecnologia da Informação', 2, '14:50', 3, 'Quinta-feira', 6, 1),
('Gestão Ambiental', 4, '14:50', 3, 'Sexta-feira', 7, 1),
('Ética e Responsabilidade Social', 2, '14:50', 3, 'Sábado', 8, 1),
('Estratégias de Marketing', 4, '14:50', 4, 'Segunda-feira', 1, 1),
('Finanças Corporativas Avançadas', 2, '14:50', 4, 'Terça-feira', 2, 1),
('Gestão de Projetos Empresariais', 4, '14:50', 4, 'Quarta-feira', 3, 1),
('Comércio Internacional', 2, '14:50', 4, 'Quinta-feira', 4, 1),
('Empreendedorismo Corporativo', 4, '14:50', 4, 'Sexta-feira', 5, 1),
('Gestão de Operações', 2, '14:50', 4, 'Sábado', 6, 1),
('Gestão de Riscos', 4, '16:40', 5, 'Segunda-feira', 7, 1),
('Marketing Digital', 2, '16:40', 5, 'Terça-feira', 8, 1),
('Ética nos Negócios', 4, '16:40', 5, 'Quarta-feira', 9, 1),
('Gestão da Inovação', 2, '16:40', 5, 'Quinta-feira', 10, 1),
('Gestão de Carreira', 4, '16:40', 5, 'Sexta-feira', 1, 1),
('Empreendedorismo Social', 2, '16:40', 5, 'Sábado', 2, 1),
('Negociação Empresarial', 4, '16:40', 6, 'Segunda-feira', 3, 1),
('Gestão de Conflitos', 2, '16:40', 6, 'Terça-feira', 4, 1),
('Gestão de Mudanças Organizacionais', 4, '16:40', 6, 'Quarta-feira', 5, 1),
('Análise de Investimentos', 2, '16:40', 6, 'Quinta-feira', 6, 1),
('Consultoria Empresarial', 4, '16:40', 6, 'Sexta-feira', 7, 1),
('Projeto Integrador em Administração', 2, '16:40', 6, 'Sábado', 8, 1);
GO
-- Disciplinas Curso 2
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Engenharia Civil', 4, '13:00', 1, 'Segunda-feira', 11, 2),
('Cálculo Diferencial e Integral', 2, '13:00', 1, 'Terça-feira', 12, 2),
('Física Aplicada à Engenharia', 4, '13:00', 1, 'Quarta-feira', 13, 2),
('Desenho Técnico', 2, '13:00', 1, 'Quinta-feira', 14, 2),
('Química Geral', 4, '13:00', 1, 'Sexta-feira', 15, 2),
('Introdução à Programação', 2, '13:00', 1, 'Sábado', 16, 2),
('Álgebra Linear', 4, '13:00', 2, 'Segunda-feira', 17, 2),
('Cálculo Vetorial e Geometria Analítica', 2, '13:00', 2, 'Terça-feira', 18, 2),
('Mecânica Geral', 4, '13:00', 2, 'Quarta-feira', 19, 2),
('Desenho Assistido por Computador', 2, '13:00', 2, 'Quinta-feira', 20, 2),
('Geologia para Engenharia', 4, '13:00', 2, 'Sexta-feira', 21, 2),
('Introdução à Economia', 2, '13:00', 2, 'Sábado', 22, 2),
('Mecânica dos Sólidos', 4, '14:50', 3, 'Segunda-feira', 23, 2),
('Mecânica dos Fluidos', 2, '14:50', 3, 'Terça-feira', 24, 2),
('Topografia', 4, '14:50', 3, 'Quarta-feira', 25, 2),
('Materiais de Construção Civil', 2, '14:50', 3, 'Quinta-feira', 26, 2),
('Estatística Aplicada à Engenharia', 4, '14:50', 3, 'Sexta-feira', 27, 2),
('Fundamentos de Eletricidade e Magnetismo', 2, '14:50', 3, 'Sábado', 28, 2),
('Estruturas de Concreto', 4, '14:50', 4, 'Segunda-feira', 29, 2),
('Estruturas de Aço', 2, '14:50', 4, 'Terça-feira', 30, 2),
('Hidráulica Aplicada', 4, '14:50', 4, 'Quarta-feira', 31, 2),
('Saneamento Básico', 2, '14:50', 4, 'Quinta-feira', 32, 2),
('Geotecnia', 4, '14:50', 4, 'Sexta-feira', 33, 2),
('Legislação e Normas Técnicas', 2, '14:50', 4, 'Sábado', 34, 2),
('Engenharia de Tráfego', 4, '16:40', 5, 'Segunda-feira', 35, 2),
('Estradas e Pavimentação', 2, '16:40', 5, 'Terça-feira', 36, 2),
('Gestão de Projetos em Engenharia Civil', 4, '16:40', 5, 'Quarta-feira', 37, 2),
('Meio Ambiente e Desenvolvimento Sustentável', 2, '16:40', 5, 'Quinta-feira', 38, 2),
('Construção Civil', 4, '16:40', 5, 'Sexta-feira', 39, 2),
('Segurança do Trabalho', 2, '16:40', 5, 'Sábado', 40, 2),
('Gestão de Resíduos', 4, '16:40', 6, 'Segunda-feira', 41, 2),
('Projetos de Fundações', 2, '16:40', 6, 'Terça-feira', 42, 2),
('Engenharia Sísmica', 4, '16:40', 6, 'Quarta-feira', 43, 2),
('Restauração e Conservação de Estruturas', 2, '16:40', 6, 'Quinta-feira', 44, 2),
('Ética Profissional em Engenharia', 4, '16:40', 6, 'Sexta-feira', 45, 2),
('Trabalho de Conclusão de Curso', 2, '16:40', 6, 'Sábado', 46, 2);
GO
--Curso 3
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução ao Estudo do Direito', 4, '13:00', 1, 'Segunda-feira', 1, 3),
('Teoria Geral do Estado', 2, '13:00', 1, 'Terça-feira', 2, 3),
('História do Direito', 4, '13:00', 1, 'Quarta-feira', 3, 3),
('Filosofia do Direito', 2, '13:00', 1, 'Quinta-feira', 4, 3),
('Direito Civil I', 4, '13:00', 1, 'Sexta-feira', 5, 3),
('Direito Penal I', 2, '13:00', 1, 'Sábado', 6, 3), 
('Direito Constitucional I', 4, '13:00', 2, 'Segunda-feira', 7, 3),
('Direito Administrativo I', 2, '13:00', 2, 'Terça-feira', 8, 3),
('Direito Processual Civil I', 4, '13:00', 2, 'Quarta-feira', 9, 3),
('Direito Empresarial I', 2, '13:00', 2, 'Quinta-feira', 10, 3),
('Direito do Trabalho I', 4, '13:00', 2, 'Sexta-feira', 11, 3),
('Direito Internacional Público', 2, '13:00', 2, 'Sábado', 12, 3),
('Direito Constitucional II', 4, '14:50', 3, 'Segunda-feira', 13, 3),
('Direito Tributário I', 2, '14:50', 3, 'Terça-feira', 14, 3),
('Direito Processual Penal I', 4, '14:50', 3, 'Quarta-feira', 15, 3),
('Direito Internacional Privado', 2, '14:50', 3, 'Quinta-feira', 16, 3),
('Direito do Consumidor', 4, '14:50', 3, 'Sexta-feira', 17, 3),
('Direito Ambiental', 2, '14:50', 3, 'Sábado', 18, 3),
('Direito Civil II', 4, '14:50', 4, 'Segunda-feira', 19, 3),
('Direito Processual Civil II', 2, '14:50', 4, 'Terça-feira', 20, 3),
('Direito Penal II', 4, '14:50', 4, 'Quarta-feira', 21, 3),
('Direito Processual Penal II', 2, '14:50', 4, 'Quinta-feira', 22, 3),
('Direito Administrativo II', 4, '14:50', 4, 'Sexta-feira', 23, 3),
('Direito Tributário II', 2, '14:50', 4, 'Sábado', 24, 3),
('Direito Civil III', 4, '16:40', 5, 'Segunda-feira', 25, 3),
('Direito Processual Civil III', 2, '16:40', 5, 'Terça-feira', 26, 3),
('Direito Penal III', 4, '16:40', 5, 'Quarta-feira', 27, 3),
('Direito Processual Penal III', 2, '16:40', 5, 'Quinta-feira', 28, 3),
('Direito do Trabalho II', 4, '16:40', 5, 'Sexta-feira', 29, 3),
('Direito Previdenciário', 2, '16:40', 5, 'Sábado', 30, 3),
('Direito Civil IV', 4, '16:40', 6, 'Segunda-feira', 31, 3),
('Direito Processual Civil IV', 2, '16:40', 6, 'Terça-feira', 32, 3),
('Direito Penal IV', 4, '16:40', 6, 'Quarta-feira', 33, 3),
('Direito Processual Penal IV', 2, '16:40', 6, 'Quinta-feira', 34, 3),
('Direito Empresarial II', 4, '16:40', 6, 'Sexta-feira', 35, 3),
('Direito da Família e Sucessões', 2, '16:40', 6, 'Sábado', 36, 3);
GO
--Disciplinas Curso 4

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Anatomia Humana I', 4, '13:00', 1, 'Segunda-feira', 1, 4),
('Bioquímica Médica I', 2, '13:00', 1, 'Terça-feira', 2, 4),
('Biologia Celular e Molecular', 4, '13:00', 1, 'Quarta-feira', 3, 4),
('Embriologia', 2, '13:00', 1, 'Quinta-feira', 4, 4),
('Histologia', 4, '13:00', 1, 'Sexta-feira', 5, 4),
('Fisiologia Humana I', 2, '13:00', 1, 'Sábado', 6, 4),
('Anatomia Humana II', 4, '13:00', 2, 'Segunda-feira', 7, 4),
('Bioquímica Médica II', 2, '13:00', 2, 'Terça-feira', 8, 4),
('Genética Médica', 4, '13:00', 2, 'Quarta-feira', 9, 4),
('Imunologia', 2, '13:00', 2, 'Quinta-feira', 10, 4),
('Parasitologia', 4, '13:00', 2, 'Sexta-feira', 11, 4),
('Microbiologia', 2, '13:00', 2, 'Sábado', 12, 4),
('Patologia Geral', 4, '14:50', 3, 'Segunda-feira', 13, 4),
('Farmacologia', 2, '14:50', 3, 'Terça-feira', 14, 4),
('Epidemiologia', 4, '14:50', 3, 'Quarta-feira', 15, 4),
('Semiologia Médica', 2, '14:50', 3, 'Quinta-feira', 16, 4),
('Psicologia Médica', 4, '14:50', 3, 'Sexta-feira', 17, 4),
('Bioestatística', 2, '14:50', 3, 'Sábado', 18, 4),
('Patologia Especial', 4, '14:50', 4, 'Segunda-feira', 19, 4),
('Farmacologia Clínica', 2, '14:50', 4, 'Terça-feira', 20, 4),
('Saúde Pública', 4, '14:50', 4, 'Quarta-feira', 21, 4),
('Medicina Preventiva e Social', 2, '14:50', 4, 'Quinta-feira', 22, 4),
('Medicina Legal', 4, '14:50', 4, 'Sexta-feira', 23, 4),
('Ética Médica', 2, '14:50', 4, 'Sábado', 24, 4), 
('Clínica Médica I', 4, '16:40', 5, 'Segunda-feira', 25, 4),
('Clínica Cirúrgica I', 2, '16:40', 5, 'Terça-feira', 26, 4),
('Pediatria', 4, '16:40', 5, 'Quarta-feira', 27, 4),
('Ginecologia e Obstetrícia', 2, '16:40', 5, 'Quinta-feira', 28, 4),
('Saúde Mental', 4, '16:40', 5, 'Sexta-feira', 29, 4),
('Medicina de Família e Comunidade', 2, '16:40', 5, 'Sábado', 30, 4),
('Clínica Médica II', 4, '16:40', 6, 'Segunda-feira', 31, 4),
('Clínica Cirúrgica II', 2, '16:40', 6, 'Terça-feira', 32, 4),
('Ortopedia e Traumatologia', 4, '16:40', 6, 'Quarta-feira', 33, 4),
('Urologia', 2, '16:40', 6, 'Quinta-feira', 34, 4),
('Oftalmologia', 4, '16:40', 6, 'Sexta-feira', 35, 4),
('Otorrinolaringologia', 2, '16:40', 6, 'Sábado', 36, 4);
GO
-- Curso 5 
-- Semestre 1
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Programação', 4, '13:00', 1, 'Segunda-feira', 1, 5),
('Algoritmos e Estrutura de Dados', 2, '13:00', 1, 'Terça-feira', 2, 5),
('Cálculo I', 4, '13:00', 1, 'Quarta-feira', 3, 5),
('Lógica Matemática', 2, '13:00', 1, 'Quinta-feira', 4, 5),
('Arquitetura de Computadores', 4, '13:00', 1, 'Sexta-feira', 5, 5),
('Inglês Técnico', 2, '13:00', 1, 'Sábado', 6, 5),
('Estruturas de Dados Avançadas', 4, '13:00', 2, 'Segunda-feira', 7, 5),
('Programação Orientada a Objetos', 2, '13:00', 2, 'Terça-feira', 8, 5),
('Cálculo II', 4, '13:00', 2, 'Quarta-feira', 9, 5),
('Redes de Computadores', 2, '13:00', 2, 'Quinta-feira', 10, 5),
('Banco de Dados', 4, '13:00', 2, 'Sexta-feira', 11, 5),
('Ética e Cidadania', 2, '13:00', 2, 'Sábado', 12, 5),
('Sistemas Operacionais', 4, '14:50', 3, 'Segunda-feira', 13, 5),
('Engenharia de Software I', 2, '14:50', 3, 'Terça-feira', 14, 5),
('Cálculo III', 4, '14:50', 3, 'Quarta-feira', 15, 5),
('Gestão de Projetos de TI', 2, '14:50', 3, 'Quinta-feira', 16, 5),
('Segurança da Informação', 4, '14:50', 3, 'Sexta-feira', 17, 5),
('Empreendedorismo', 2, '14:50', 3, 'Sábado', 18, 5),
('Programação Web', 4, '14:50', 4, 'Segunda-feira', 19, 5),
('Engenharia de Software II', 2, '14:50', 4, 'Terça-feira', 20, 5),
('Matemática Discreta', 4, '14:50', 4, 'Quarta-feira', 21, 5),
('Inteligência Artificial', 2, '14:50', 4, 'Quinta-feira', 22, 5),
('Computação Gráfica', 4, '14:50', 4, 'Sexta-feira', 23, 5),
('Trabalho de Conclusão de Curso I', 2, '14:50', 4, 'Sábado', 24, 5),
('Programação Paralela e Distribuída', 4, '16:40', 5, 'Segunda-feira', 25, 5),
('Mineração de Dados', 2, '16:40', 5, 'Terça-feira', 26, 5),
('Computação em Nuvem', 4, '16:40', 5, 'Quarta-feira', 27, 5),
('Gestão de Tecnologia da Informação', 2, '16:40', 5, 'Quinta-feira', 28, 5),
('Desenvolvimento Mobile', 4, '16:40', 5, 'Sexta-feira', 29, 5),
('Estágio Supervisionado', 2, '16:40', 5, 'Sábado', 30, 5),
('Computação Quântica', 4, '16:40', 6, 'Segunda-feira', 31, 5),
('Ética em Tecnologia da Informação', 2, '16:40', 6, 'Terça-feira', 32, 5),
('Tópicos Avançados em Ciência da Computação', 4, '16:40', 6, 'Quarta-feira', 33, 5),
('Sistemas Distribuídos', 2, '16:40', 6, 'Quinta-feira', 34, 5),
('Projeto de Sistemas', 4, '16:40', 6, 'Sexta-feira', 35, 5),
('Trabalho de Conclusão de Curso II', 2, '16:40', 6, 'Sábado', 36, 5);
GO
-- Disciplinas Curso 6

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Psicologia', 4, '13:00', 1, 'Segunda-feira', 1, 6),
('Psicologia Geral', 2, '14:50', 1, 'Terça-feira', 2, 6),
('Teorias da Personalidade', 4, '13:00', 1, 'Quarta-feira', 3, 6),
('Neurociência e Comportamento', 2, '14:50', 1, 'Quinta-feira', 4, 6),
('Metodologia Científica em Psicologia', 4, '13:00', 1, 'Sexta-feira', 5, 6),
('Ética e Deontologia em Psicologia', 2, '14:50', 1, 'Sábado', 6, 6), 
('Psicologia do Desenvolvimento', 4, '13:00', 2, 'Segunda-feira', 7, 6),
('Psicopatologia Geral', 2, '14:50', 2, 'Terça-feira', 8, 6),
('Psicologia Social', 4, '13:00', 2, 'Quarta-feira', 9, 6),
('Psicologia Organizacional e do Trabalho', 2, '14:50', 2, 'Quinta-feira', 10, 6),
('Avaliação Psicológica', 4, '13:00', 2, 'Sexta-feira', 11, 6),
('Psicologia Jurídica', 2, '14:50', 2, 'Sábado', 12, 6),
('Psicologia da Saúde', 4, '13:00', 3, 'Segunda-feira', 13, 6),
('Psicoterapia Breve', 2, '14:50', 3, 'Terça-feira', 14, 6),
('Psicologia Escolar e Educacional', 4, '13:00', 3, 'Quarta-feira', 15, 6),
('Psicologia Hospitalar', 2, '14:50', 3, 'Quinta-feira', 16, 6),
('Psicologia do Esporte', 4, '13:00', 3, 'Sexta-feira', 17, 6),
('Psicologia Ambiental', 2, '14:50', 3, 'Sábado', 18, 6),
('Psicologia do Envelhecimento', 4, '13:00', 4, 'Segunda-feira', 19, 6),
('Psicologia da Família', 2, '14:50', 4, 'Terça-feira', 20, 6),
('Psicologia Comunitária', 4, '13:00', 4, 'Quarta-feira', 21, 6),
('Psicologia da Arte', 2, '14:50', 4, 'Quinta-feira', 22, 6),
('Psicologia Transpessoal', 4, '13:00', 4, 'Sexta-feira', 23, 6),
('Psicologia do Trânsito', 2, '14:50', 4, 'Sábado', 24, 6),
('Neuropsicologia', 4, '13:00', 5, 'Segunda-feira', 25, 6),
('Psicologia Hospitalar', 2, '14:50', 5, 'Terça-feira', 26, 6),
('Psicologia Clínica Infantil', 4, '13:00', 5, 'Quarta-feira', 27, 6),
('Psicoterapia de Grupo', 2, '14:50', 5, 'Quinta-feira', 28, 6),
('Psicologia do Esporte', 4, '13:00', 5, 'Sexta-feira', 29, 6),
('Psicologia Organizacional', 2, '14:50', 5, 'Sábado', 30, 6),
('Psicologia da Personalidade', 4, '13:00', 6, 'Segunda-feira', 31, 6),
('Psicologia Analítica', 2, '14:50', 6, 'Terça-feira', 32, 6),
('Psicologia do Desenvolvimento', 4, '13:00', 6, 'Quarta-feira', 33, 6),
('Psicologia Social', 2, '14:50', 6, 'Quinta-feira', 34, 6),
('Psicologia Clínica', 4, '13:00', 6, 'Sexta-feira', 35, 6),
('Psicologia do Trabalho', 2, '14:50', 6, 'Sábado', 36, 6);
GO
-- Disciplinas Curso 7

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Administração Pública', 4, '13:00', 1, 'Segunda-feira', 1, 7),
('Gestão de Políticas Públicas', 2, '14:50', 1, 'Terça-feira', 2, 7),
('Administração Financeira e Orçamentária', 4, '13:00', 1, 'Quarta-feira', 3, 7),
('Gestão de Pessoas no Setor Público', 2, '14:50', 1, 'Quinta-feira', 4, 7),
('Direito Administrativo', 4, '13:00', 1, 'Sexta-feira', 5, 7),
('Ética na Administração Pública', 2, '14:50', 1, 'Sábado', 6, 7),
('Planejamento e Gestão Estratégica', 4, '13:00', 2, 'Segunda-feira', 7, 7),
('Administração de Recursos Humanos no Setor Público', 2, '14:50', 2, 'Terça-feira', 8, 7),
('Licitações e Contratos Administrativos', 4, '13:00', 2, 'Quarta-feira', 9, 7),
('Gestão da Qualidade no Setor Público', 2, '14:50', 2, 'Quinta-feira', 10, 7),
('Legislação Tributária Municipal', 4, '13:00', 2, 'Sexta-feira', 11, 7),
('Gestão Ambiental no Setor Público', 2, '14:50', 2, 'Sábado', 12, 7),
('Desenvolvimento Econômico e Social', 4, '13:00', 3, 'Segunda-feira', 13, 7),
('Elaboração e Avaliação de Projetos Sociais', 2, '14:50', 3, 'Terça-feira', 14, 7),
('Contabilidade Pública', 4, '13:00', 3, 'Quarta-feira', 15, 7),
('Marketing Governamental', 2, '14:50', 3, 'Quinta-feira', 16, 7),
('Gestão de Crises e Emergências', 4, '13:00', 3, 'Sexta-feira', 17, 7),
('Governança e Transparência', 2, '14:50', 3, 'Sábado', 18, 7),
('Gestão de Projetos no Setor Público', 4, '13:00', 4, 'Segunda-feira', 19, 7),
('Gestão da Inovação no Setor Público', 2, '14:50', 4, 'Terça-feira', 20, 7),
('Políticas Públicas de Saúde', 4, '13:00', 4, 'Quarta-feira', 21, 7),
('Políticas Educacionais', 2, '14:50', 4, 'Quinta-feira', 22, 7),
('Planejamento Urbano e Regional', 4, '13:00', 4, 'Sexta-feira', 23, 7),
('Gestão de Serviços Públicos', 2, '14:50', 4, 'Sábado', 24, 7),
('Ética e Responsabilidade Social', 4, '13:00', 5, 'Segunda-feira', 25, 7),
('Comunicação no Setor Público', 2, '14:50', 5, 'Terça-feira', 26, 7),
('Orçamento Público', 4, '13:00', 5, 'Quarta-feira', 27, 7),
('Políticas de Segurança Pública', 2, '14:50', 5, 'Quinta-feira', 28, 7),
('Gestão de Tecnologia da Informação no Setor Público', 4, '13:00', 5, 'Sexta-feira', 29, 7),
('Políticas de Assistência Social', 2, '14:50', 5, 'Sábado', 30, 7),
('Direito Administrativo Avançado', 4, '13:00', 6, 'Segunda-feira', 31, 7),
('Gestão de Conflitos e Negociação', 2, '14:50', 6, 'Terça-feira', 32, 7),
('Sustentabilidade e Responsabilidade Socioambiental', 4, '13:00', 6, 'Quarta-feira', 33, 7),
('Inovação e Governo Aberto', 2, '14:50', 6, 'Quinta-feira', 34, 7),
('Direito e Legislação Aplicada à Administração Pública', 4, '13:00', 6, 'Sexta-feira', 35, 7),
('Políticas Culturais e de Turismo', 2, '14:50', 6, 'Sábado', 36, 7);
GO
-- Disciplinas Curso 8
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Circuitos Elétricos I', 4, '13:00', 1, 'Segunda-feira', 1, 8),
('Eletromagnetismo', 2, '14:50', 1, 'Terça-feira', 2, 8),
('Eletrônica Analógica I', 4, '13:00', 1, 'Quarta-feira', 3, 8),
('Programação para Engenharia', 2, '14:50', 1, 'Quinta-feira', 4, 8),
('Cálculo I', 4, '13:00', 1, 'Sexta-feira', 5, 8),
('Introdução à Engenharia Elétrica', 2, '14:50', 1, 'Sábado', 6, 8),
('Circuitos Elétricos II', 4, '13:00', 2, 'Segunda-feira', 7, 8),
('Eletrônica Analógica II', 2, '14:50', 2, 'Terça-feira', 8, 8),
('Máquinas Elétricas', 4, '13:00', 2, 'Quarta-feira', 9, 8),
('Cálculo II', 2, '14:50', 2, 'Quinta-feira', 10, 8),
('Física Aplicada à Engenharia', 4, '13:00', 2, 'Sexta-feira', 11, 8),
('Desenho Técnico', 2, '14:50', 2, 'Sábado', 12, 8),
('Instalações Elétricas', 4, '13:00', 3, 'Segunda-feira', 13, 8),
('Controle e Automação', 2, '14:50', 3, 'Terça-feira', 14, 8),
('Materiais Elétricos', 4, '13:00', 3, 'Quarta-feira', 15, 8),
('Equações Diferenciais', 2, '14:50', 3, 'Quinta-feira', 16, 8),
('Teoria Eletromagnética', 4, '13:00', 3, 'Sexta-feira', 17, 8),
('Física III', 2, '14:50', 3, 'Sábado', 18, 8),
('Sistemas de Energia', 4, '13:00', 4, 'Segunda-feira', 19, 8),
('Eletrônica de Potência', 2, '14:50', 4, 'Terça-feira', 20, 8),
('Eletromagnetismo Aplicado', 4, '13:00', 4, 'Quarta-feira', 21, 8),
('Métodos Numéricos', 2, '14:50', 4, 'Quinta-feira', 22, 8),
('Sinais e Sistemas', 4, '13:00', 4, 'Sexta-feira', 23, 8),
('Mecânica dos Fluidos', 2, '14:50', 4, 'Sábado', 24, 8),
('Proteção de Sistemas Elétricos', 4, '13:00', 5, 'Segunda-feira', 25, 8),
('Sistemas Digitais', 2, '14:50', 5, 'Terça-feira', 26, 8),
('Conversão de Energia', 4, '13:00', 5, 'Quarta-feira', 27, 8),
('Economia de Energia', 2, '14:50', 5, 'Quinta-feira', 28, 8),
('Engenharia Econômica', 4, '13:00', 5, 'Sexta-feira', 29, 8),
('Controle de Processos', 2, '14:50', 5, 'Sábado', 30, 8),
('Subestações Elétricas', 4, '13:00', 6, 'Segunda-feira', 31, 8),
('Eficiência Energética', 2, '14:50', 6, 'Terça-feira', 32, 8),
('Automação Industrial', 4, '13:00', 6, 'Quarta-feira', 33, 8),
('Redes de Comunicação', 2, '14:50', 6, 'Quinta-feira', 34, 8),
('Projeto Integrado de Engenharia Elétrica', 4, '13:00', 6, 'Sexta-feira', 35, 8),
('Trabalho de Conclusão de Curso', 2, '14:50', 6, 'Sábado', 36, 8);
GO
-- Disciplinas Curso 9

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Gastronomia', 4, '13:00', 1, 'Segunda-feira', 1, 9),
('Higiene e Segurança Alimentar', 2, '14:50', 1, 'Terça-feira', 2, 9),
('Técnicas Básicas de Culinária', 4, '13:00', 1, 'Quarta-feira', 3, 9),
('Gastronomia Brasileira', 2, '14:50', 1, 'Quinta-feira', 4, 9),
('História da Gastronomia', 4, '13:00', 1, 'Sexta-feira', 5, 9),
('Nutrição e Dietética', 2, '14:50', 1, 'Sábado', 6, 9),
('Técnicas de Confeitaria', 4, '13:00', 2, 'Segunda-feira', 7, 9),
('Panificação', 2, '14:50', 2, 'Terça-feira', 8, 9),
('Cozinha Internacional', 4, '13:00', 2, 'Quarta-feira', 9, 9),
('Gastronomia Molecular', 2, '14:50', 2, 'Quinta-feira', 10, 9),
('Gestão de Restaurantes e Bares', 4, '13:00', 2, 'Sexta-feira', 11, 9),
('Enologia', 2, '14:50', 2, 'Sábado', 12, 9), 
('Gastronomia Asiática', 4, '13:00', 3, 'Segunda-feira', 13, 9),
('Gastronomia Italiana', 2, '14:50', 3, 'Terça-feira', 14, 9),
('Gastronomia Francesa', 4, '13:00', 3, 'Quarta-feira', 15, 9),
('Gastronomia Espanhola', 2, '14:50', 3, 'Quinta-feira', 16, 9),
('Gastronomia Regional Brasileira', 4, '13:00', 3, 'Sexta-feira', 17, 9),
('Arte Culinária', 2, '14:50', 3, 'Sábado', 18, 9),
('Gastronomia Contemporânea', 4, '13:00', 4, 'Segunda-feira', 19, 9),
('Gastronomia Molecular Avançada', 2, '14:50', 4, 'Terça-feira', 20, 9),
('Gastronomia Funcional', 4, '13:00', 4, 'Quarta-feira', 21, 9),
('Gastronomia Sustentável', 2, '14:50', 4, 'Quinta-feira', 22, 9),
('Gastronomia Cultural', 4, '13:00', 4, 'Sexta-feira', 23, 9),
('Empreendedorismo na Gastronomia', 2, '14:50', 4, 'Sábado', 24, 9),
('Gestão de Custos em Gastronomia', 4, '13:00', 5, 'Segunda-feira', 25, 9),
('Gestão de Qualidade em Serviços de Alimentação', 2, '14:50', 5, 'Terça-feira', 26, 9),
('Gastronomia de Eventos', 4, '13:00', 5, 'Quarta-feira', 27, 9),
('Gastronomia Hospitalar', 2, '14:50', 5, 'Quinta-feira', 28, 9),
('Gastronomia Social e Comunitária', 4, '13:00', 5, 'Sexta-feira', 29, 9),
('Marketing Gastronômico', 2, '14:50', 5, 'Sábado', 30, 9),
('Cozinha Internacional Avançada', 4, '13:00', 6, 'Segunda-feira', 31, 9),
('Gastronomia Molecular Avançada II', 2, '14:50', 6, 'Terça-feira', 32, 9),
('Gastronomia Criativa', 4, '13:00', 6, 'Quarta-feira', 33, 9),
('Cozinha Funcional', 2, '14:50', 6, 'Quinta-feira', 34, 9),
('Gastronomia Esportiva', 4, '13:00', 6, 'Sexta-feira', 35, 9),
('Planejamento de Cardápios', 2, '14:50', 6, 'Sábado', 36, 9);
GO
-- Disciplinas Curso 10
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Arquitetura', 4, '13:00', 1, 'Segunda-feira', 1, 10),
('História da Arte', 2, '14:50', 1, 'Terça-feira', 2, 10),
('Desenho Arquitetônico I', 4, '13:00', 1, 'Quarta-feira', 3, 10),
('Teoria da Arquitetura', 2, '14:50', 1, 'Quinta-feira', 4, 10),
('Geometria Descritiva', 4, '13:00', 1, 'Sexta-feira', 5, 10),
('Informática Aplicada à Arquitetura', 2, '14:50', 1, 'Sábado', 6, 10),
('Construção Civil I', 4, '13:00', 2, 'Segunda-feira', 7, 10),
('Desenho Arquitetônico II', 2, '14:50', 2, 'Terça-feira', 8, 10),
('Sociologia Urbana', 4, '13:00', 2, 'Quarta-feira', 9, 10),
('Topografia', 2, '14:50', 2, 'Quinta-feira', 10, 10),
('Cálculo Estrutural', 4, '13:00', 2, 'Sexta-feira', 11, 10),
('Estética e Paisagismo', 2, '14:50', 2, 'Sábado', 12, 10), 
('Construção Civil II', 4, '13:00', 3, 'Segunda-feira', 13, 10),
('Desenho Arquitetônico III', 2, '14:50', 3, 'Terça-feira', 14, 10),
('Ecologia Urbana', 4, '13:00', 3, 'Quarta-feira', 15, 10),
('Materiais de Construção', 2, '14:50', 3, 'Quinta-feira', 16, 10),
('Estruturas de Concreto', 4, '13:00', 3, 'Sexta-feira', 17, 10),
('Projeto Arquitetônico I', 2, '14:50', 3, 'Sábado', 18, 10),
('Instalações Prediais', 4, '13:00', 4, 'Segunda-feira', 19, 10),
('Desenho Arquitetônico IV', 2, '14:50', 4, 'Terça-feira', 20, 10),
('Planejamento Urbano', 4, '13:00', 4, 'Quarta-feira', 21, 10),
('Sistemas Estruturais', 2, '14:50', 4, 'Quinta-feira', 22, 10),
('Legislação Urbana', 4, '13:00', 4, 'Sexta-feira', 23, 10),
('Projeto Arquitetônico II', 2, '14:50', 4, 'Sábado', 24, 10),
('Conforto Ambiental', 4, '13:00', 5, 'Segunda-feira', 25, 10),
('Desenho Assistido por Computador', 2, '14:50', 5, 'Terça-feira', 26, 10),
('Patrimônio Histórico', 4, '13:00', 5, 'Quarta-feira', 27, 10),
('Projeto de Interiores', 2, '14:50', 5, 'Quinta-feira', 28, 10),
('Planejamento de Espaços Urbanos', 4, '13:00', 5, 'Sexta-feira', 29, 10),
('Projeto de Urbanismo', 2, '14:50', 5, 'Sábado', 30, 10),
('Arquitetura Sustentável', 4, '13:00', 6, 'Segunda-feira', 31, 10),
('Projeto de Arquitetura III', 2, '14:50', 6, 'Terça-feira', 32, 10),
('Legislação e Ética Profissional', 4, '13:00', 6, 'Quarta-feira', 33, 10),
('Trabalho de Conclusão de Curso I', 2, '14:50', 6, 'Quinta-feira', 34, 10),
('Gestão de Projetos em Arquitetura', 4, '13:00', 6, 'Sexta-feira', 35, 10),
('Trabalho de Conclusão de Curso II', 2, '14:50', 6, 'Sábado', 36, 10);
GO
-- Disciplinas Curso 11
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdução à Programação', 4, '13:00', 1, 'Segunda-feira', 1, 11),
('Matemática Discreta', 2, '14:50', 1, 'Terça-feira', 2, 11),
('Algoritmos e Estrutura de Dados', 4, '13:00', 1, 'Quarta-feira', 3, 11),
('Lógica de Programação', 2, '14:50', 1, 'Quinta-feira', 4, 11),
('Banco de Dados', 4, '13:00', 1, 'Sexta-feira', 5, 11),
('Comunicação e Expressão', 2, '14:50', 1, 'Sábado', 6, 11), 
('Programação Orientada a Objetos', 4, '13:00', 2, 'Segunda-feira', 7, 11),
('Estrutura de Dados Avançada', 2, '14:50', 2, 'Terça-feira', 8, 11),
('Desenvolvimento Web', 4, '13:00', 2, 'Quarta-feira', 9, 11),
('Redes de Computadores', 2, '14:50', 2, 'Quinta-feira', 10, 11),
('Engenharia de Software', 4, '13:00', 2, 'Sexta-feira', 11, 11),
('Ética e Legislação em Informática', 2, '14:50', 2, 'Sábado', 12, 11),
('Desenvolvimento Mobile', 4, '13:00', 3, 'Segunda-feira', 13, 11),
('Sistemas Operacionais', 2, '14:50', 3, 'Terça-feira', 14, 11),
('Análise e Projeto de Sistemas', 4, '13:00', 3, 'Quarta-feira', 15, 11),
('Gestão de Projetos de TI', 2, '14:50', 3, 'Quinta-feira', 16, 11),
('Segurança da Informação', 4, '13:00', 3, 'Sexta-feira', 17, 11),
('Inglês Técnico', 2, '14:50', 3, 'Sábado', 18, 11),
('Inteligência Artificial', 4, '13:00', 4, 'Segunda-feira', 19, 11),
('Gestão da Qualidade de Software', 2, '14:50', 4, 'Terça-feira', 20, 11),
('Teste de Software', 4, '13:00', 4, 'Quarta-feira', 21, 11),
('Governança de TI', 2, '14:50', 4, 'Quinta-feira', 22, 11),
('Empreendedorismo', 4, '13:00', 4, 'Sexta-feira', 23, 11),
('Projeto Integrador I', 2, '14:50', 4, 'Sábado', 24, 11), 
('Desenvolvimento de Jogos', 4, '13:00', 5, 'Segunda-feira', 25, 11),
('Big Data', 2, '14:50', 5, 'Terça-feira', 26, 11),
('Computação em Nuvem', 4, '13:00', 5, 'Quarta-feira', 27, 11),
('Programação Funcional', 2, '14:50', 5, 'Quinta-feira', 28, 11),
('Modelagem de Dados', 4, '13:00', 5, 'Sexta-feira', 29, 11),
('Projeto Integrador II', 2, '14:50', 5, 'Sábado', 30, 11),
('Blockchain', 4, '13:00', 6, 'Segunda-feira', 31, 11),
('DevOps', 2, '14:50', 6, 'Terça-feira', 32, 11),
('Arquitetura de Software', 4, '13:00', 6, 'Quarta-feira', 33, 11),
('Desenvolvimento Ágil de Software', 2, '14:50', 6, 'Quinta-feira', 34, 11),
('Trabalho de Conclusão de Curso I', 4, '13:00', 6, 'Sexta-feira', 35, 11),
('Trabalho de Conclusão de Curso II', 2, '14:50', 6, 'Sábado', 36, 11);
GO
INSERT INTO matricula (codigo, codigoAluno, dataMatricula, semestre)
VALUES
(1, '55312103020', '2022-01-10', 1),
(2, '55312103020', '2022-07-28', 2),
(3, '86462326034', '2024-01-28', 1),
(4, '09129892031', '2024-07-28', 2),
(5, '39112829072', '2025-03-28', 1),
(6, '97006247063', '2024-03-28', 2),
(7, '39590327060', '2024-03-28', 1),
(8, '29180596096', '2021-01-1', 2),
(9, '30260403040', '2021-07-28', 3),
(10, '09129892031', '2024-07-28', 1),
(11, '97006247063', '2024-03-28', 1);
GO
INSERT INTO matriculaDisciplina (CodigoMatricula, codigoDisciplina, situacao, notaFinal)
VALUES
(1,1001,'Reprovado', 8.5),
(1,1002,'Reprovado', 5.0),
(1,1003,'Reprovado', 7.2),
(2,1001,'Aprovado', 4.8),
(2,1002,'Aprovado', 9.0),
(2,1003,'Aprovado', 6.5),
(3,1001,'Reprovado', 4.8),
(3,1002,'Reprovado', 9.0),
(3,1003,'Reprovado', 6.5),
(4,1001,'Aprovado', 4.8),
(4,1002,'Aprovado', 9.0),
(4,1003,'Em Curso', 6.5),
(5,1001,'Em Curso', 4.8),
(5,1002,'Em Curso', 9.0),
(5,1003,'Em Curso', 6.5),
(6,1001,'Em Curso', 4.8),
(6,1002,'Em Curso', 9.0),
(6,1003,'Em Curso', 6.5),
(7,1001,'Em Curso', 4.8),
(7,1002,'Em Curso', 9.0),
(7,1003,'Em Curso', 6.5),
(8,1001,'Em Curso', 4.8),
(8,1002,'Em Curso', 9.0),
(8,1003,'Em Curso', 6.5),
(9,1001,'Em Curso', 4.8),
(9,1002,'Em Curso', 9.0),
(9,1003,'Em Curso', 6.5),
(10,1001,'Em Curso', 4.8),
(10,1002,'Em Curso', 9.0),
(10,1003,'Em Curso', 6.5),
(11,1001,'Em Curso', 4.8),
(11,1002,'Em Curso', 9.0),
(11,1003,'Em Curso', 6.5);
GO
INSERT INTO conteudo VALUES 
    (1, 'Álgebra', 'Estudo dos números e operações', 1003),
    (2, 'Geometria', 'Estudo das formas e dos espaços', 1003),
    (3, 'Cálculo Diferencial', 'Estudo das taxas de variação', 1003),
    (4, 'Células', 'Unidades básicas da vida', 1005),
    (5, 'Energia', 'Capacidade de realizar trabalho', 1005),
    (6, 'Evolução', 'Desenvolvimento das espécies ao longo do tempo', 1005),
    (7, 'Idade Média', 'Período histórico entre os séculos V e XV', 1001),
    (8, 'Revolução Industrial', 'Transformações econômicas e sociais no século XVIII', 1001),
    (9, 'Descobrimento do Brasil', 'Chegada dos portugueses em 1500', 1002),
    (10, 'Relevo Brasileiro', 'Características geográficas do país', 1002),
    (11, 'Literatura Brasileira', 'Produções literárias do Brasil', 1004),
    (12, 'Gramática', 'Estudo da estrutura e funcionamento da língua', 1004),
    (13, 'Equações', 'Expressões matemáticas com incógnitas', 1003),
    (14, 'Fisiologia', 'Estudo das funções dos organismos vivos', 1005),
    (15, 'Guerra Fria', 'Conflito político entre EUA e URSS', 1005),
    (16, 'Globalização', 'Integração econômica e cultural mundial', 1004),
    (17, 'Morfologia', 'Estudo da estrutura das palavras', 1004),
    (18, 'Polinômios', 'Expressões algébricas com várias variáveis',1004),
    (19, 'Genética', 'Estudo dos genes e hereditariedade', 1003),
    (20, 'Renascimento', 'Movimento cultural e artístico do século XVI', 1004);
GO
INSERT INTO eliminacoes (codigoMatricula, codigoDisciplina, dataEliminacao, status, nomeInstituicao)
VALUES 
(1, 1001, '2024-04-01', 'D', 'UNICSUL'),
(2, 1002, '2024-04-02', 'D', 'FATEC Zona Sul'),
(3, 1003, '2024-04-03', 'Em análise', 'UNINOVE'),
(4, 1001, '2024-04-04', 'D', 'UNICID'),
(4, 1003, '2024-04-04', 'D', 'ETEC'),
(5, 1002, '2024-04-05', 'Recusado', 'FATEC Zona Sul');
GO
SELECT * FROM matricula 
INSERT INTO listaChamada (codigo, codigoMatricula, codigoDisciplina, dataChamada, presenca1, presenca2, presenca3, presenca4)
VALUES
(1, 1, 1001, '2024-04-01', 0, 1, 1, 1),
(2, 2, 1002, '2024-04-02', 1, 1, 1, 1),
(3, 3, 1003, '2024-04-03', 0, 1, 1, 1),
(4, 4, 1001, '2024-04-04', 1, 1, 1, 1),
(5, 5, 1002, '2024-04-05', 0, 0, 0, 0),
(6, 6, 1003, '2024-04-03', 0, 1, 1, 1),
(7, 7, 1001, '2024-04-04', 1, 1, 1, 1),
(8, 8, 1002, '2024-04-05', 0, 0, 0, 0),
(9, 9, 1003, '2024-04-03', 0, 1, 1, 1),
(10, 10, 1001, '2024-04-04', 1, 1, 1, 1),
(11, 11, 1002, '2024-04-05', 0, 0, 0, 0),
(12, 1, 1001, '2024-04-04', 1, 0, 1, 0),
(13, 2, 1002, '2024-04-04', 0, 1, 0, 1),
(14, 3, 1003, '2024-04-03', 1, 1, 1, 1),
(15, 4, 1001, '2024-04-02', 0, 0, 0, 0),
(16, 5, 1002, '2024-04-01', 1, 0, 1, 0),
(17, 6, 1003, '2024-04-01', 0, 1, 0, 1),
(18, 7, 1001, '2024-04-02', 1, 1, 1, 1),
(19, 8, 1002, '2024-04-03', 0, 0, 0, 0),
(20, 9, 1003, '2024-04-04', 1, 0, 1, 0),
(21, 10, 1001, '2024-04-05', 0, 1, 0, 1),
(22, 11, 1002, '2024-04-01', 1, 1, 1, 1),
(23, 2, 1003, '2024-04-02', 0, 0, 0, 0),
(24, 3, 1001, '2024-04-03', 1, 0, 1, 0),
(25, 4, 1002, '2024-04-04', 0, 1, 0, 1),
(26, 5, 1003, '2024-04-02', 1, 1, 1, 1),
(27, 6, 1001, '2024-04-01', 0, 0, 0, 0),
(28, 7, 1002, '2024-04-02', 1, 0, 1, 0),
(29, 8, 1003, '2024-04-03', 0, 1, 0, 1),
(30, 9, 1001, '2024-04-04', 1, 1, 1, 1),
(31, 1, 1002, '2024-04-05', 0, 0, 0, 0),
(32, 2, 1001, '2024-04-01', 0, 1, 0, 1),
(33, 3, 1002, '2024-04-02', 1, 0, 1, 0),
(34, 4, 1003, '2024-04-03', 0, 1, 0, 1),
(35, 5, 1001, '2024-04-04', 1, 0, 1, 0),
(36, 6, 1002, '2024-04-05', 0, 1, 0, 1),
(37, 7, 1003, '2024-04-01', 1, 0, 1, 0),
(38, 8, 1001, '2024-04-02', 0, 1, 0, 1),
(39, 9, 1002, '2024-04-03', 1, 0, 1, 0),
(40, 10, 1003, '2024-04-04', 0, 1, 0, 1),
(41, 1, 1001, '2024-04-05', 1, 0, 1, 0),
(42, 2, 1002, '2024-04-01', 0, 1, 0, 1),
(43, 3, 1003, '2024-04-02', 1, 0, 1, 0),
(44, 4, 1001, '2024-04-03', 0, 1, 0, 1),
(45, 5, 1002, '2024-04-04', 1, 0, 1, 0),
(46, 6, 1003, '2024-04-05', 0, 1, 0, 1),
(47, 7, 1001, '2024-04-01', 1, 0, 1, 0),
(48, 8, 1002, '2024-04-02', 0, 1, 0, 1),
(49, 9, 1003, '2024-04-03', 1, 0, 1, 0),
(50, 10, 1001, '2024-04-04', 0, 1, 0, 1),
(51, 1, 1002, '2024-04-05', 1, 0, 1, 0),
(52, 2, 1003, '2024-04-01', 0, 1, 0, 1),
(53, 3, 1001, '2024-04-02', 1, 0, 1, 0),
(54, 4, 1002, '2024-04-03', 0, 1, 0, 1),
(55, 5, 1003, '2024-04-04', 1, 0, 1, 0),
(56, 6, 1001, '2024-04-05', 0, 1, 0, 1),
(57, 7, 1002, '2024-04-01', 1, 0, 1, 0),
(58, 8, 1003, '2024-04-02', 0, 1, 0, 1),
(59, 9, 1001, '2024-04-03', 1, 0, 1, 0),
(60, 10, 1002, '2024-04-04', 0, 1, 0, 1);
GO
CREATE VIEW v_listarCurso AS
SELECT codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno FROM curso
GO
CREATE VIEW v_periodoMatricula AS
SELECT TOP 1 periodo_matricula_inicio, periodo_matricula_fim FROM curso ORDER BY codigo ASC
GO
CREATE VIEW v_listarAluno AS
SELECT a.CPF, a.nome, a.nomeSocial, a.dataNascimento, a.telefoneContato,
a.emailPessoal, a.emailCorporativo, a.dataConclusao2Grau, a.instituicaoConclusao2Grau, 
a.pontuacaoVestibular, a.posicaoVestibular, a.anoIngresso, a.semestreIngresso, 
a.semestreAnoLimiteGraduacao, a.RA, c.codigo AS codigoCurso, c.nome AS nomeCurso
FROM aluno a JOIN curso c ON a.curso = c.codigo
GO
CREATE PROCEDURE sp_validatitulacao 
	@titulacao VARCHAR(50),
	@valido BIT OUTPUT
AS
BEGIN
   IF(@titulacao = 'Doutor' OR @titulacao = 'Mestre' OR @titulacao = 'Especialista')
   BEGIN 
       SET @valido =1
   END
   ELSE
   BEGIN 
       SET @valido = 0
   END
END
GO
CREATE PROCEDURE sp_iud_professor 
    @acao CHAR(1), 
    @codigo INT, 
    @nome VARCHAR(100), 
    @titulacao VARCHAR(50),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @tit_valido BIT
    
    IF (@acao = 'I')
    BEGIN
        EXEC sp_validatitulacao @titulacao, @tit_valido OUTPUT
        
        IF @tit_valido = 0
        BEGIN
            SET @saida = 'Titulação inválida'
            RETURN
        END
        
        IF EXISTS (SELECT 1 FROM professor WHERE codigo = @codigo)
        BEGIN
            SET @saida = 'Código de professor já existe.'
            RETURN
        END
        
        INSERT INTO professor VALUES (@codigo, @nome, @titulacao)
        SET @saida = 'Professor inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        EXEC sp_validatitulacao @titulacao, @tit_valido OUTPUT
        
        IF @tit_valido = 0
        BEGIN
            SET @saida = 'Titulação inválida'
            RETURN
        END
        
        UPDATE professor SET nome = @nome, titulacao = @titulacao WHERE codigo = @codigo
        SET @saida = 'Professor alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DECLARE @count INT
        -- Verificar se há disciplinas associadas a esse professor
        SELECT @count = COUNT(*) FROM disciplina WHERE codigoProfessor = @codigo
        
        -- Se houver disciplinas associadas, emitir uma mensagem e não excluir o professor
        IF @count > 0
        BEGIN
            SET @saida = 'Este professor está associado a disciplinas e não pode ser excluído.'
            RETURN
        END
        
        DELETE FROM professor WHERE codigo = @codigo
        SET @saida = 'Professor excluído com sucesso'
    END
END



GO
CREATE PROCEDURE sp_iud_curso 
    @acao CHAR(1), 
    @codigo INT, 
    @nome VARCHAR(100), 
    @cargaHoraria INT,
    @sigla VARCHAR(10),
    @ultimaNotaENADE DECIMAL(5,2),
    @turno VARCHAR(20),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @validoCodigo BIT

    -- Verificar se o código é válido
    IF (@codigo >= 0 AND @codigo <= 100)
    BEGIN
        SET @validoCodigo = 1
    END
    ELSE
    BEGIN
        SET @validoCodigo = 0
    END

    IF (@acao = 'I')
    BEGIN
        -- Inserir curso
        IF @validoCodigo = 1
        BEGIN
            INSERT INTO curso (codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno) 
            VALUES (@codigo, @nome, @cargaHoraria, @sigla, @ultimaNotaENADE, @turno)
            SET @saida = 'Curso inserido com sucesso'
        END
        ELSE
        BEGIN
            RAISERROR('Código de curso inválido', 16, 1)
            RETURN
        END
    END
    ELSE IF (@acao = 'U')
    BEGIN
        -- Atualizar curso
        IF @validoCodigo = 1
        BEGIN
            UPDATE curso SET nome = @nome, cargaHoraria = @cargaHoraria, 
            sigla = @sigla, ultimaNotaENADE = @ultimaNotaENADE, turno = @turno 
            WHERE codigo = @codigo
            SET @saida = 'Curso alterado com sucesso'
        END
        ELSE
        BEGIN
            RAISERROR('Código de curso inválido', 16, 1)
            RETURN
        END
    END
    ELSE BEGIN
    IF (@acao = 'D')
    BEGIN
        -- Verificar se existem disciplinas associadas a este curso
        IF EXISTS (SELECT 1 FROM disciplina WHERE codigoCurso = @codigo)
        BEGIN
            SET @saida = 'Não é possível excluir o curso pois existem disciplinas associadas a ele.';
            RETURN;
        END;

        DELETE FROM curso WHERE codigo = @codigo;
        SET @saida = 'Curso excluído com sucesso.';
    END
END
END
GO
CREATE PROCEDURE sp_validaCPF 
    @CPF CHAR(11),
    @valido BIT OUTPUT
AS
BEGIN
    DECLARE @primeiroDigito INT;
    DECLARE @segundoDigito INT;
    DECLARE @i INT;
    DECLARE @soma INT;
    DECLARE @resto INT;

    SET @valido = 0; -- Inicializa como inválido por padrão

    -- Verificação se o CPF contém apenas dígitos numéricos
    IF @CPF NOT LIKE '%[^0-9]%' AND @CPF NOT IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999')
    BEGIN
        -- Cálculo do primeiro dígito verificador
        SET @soma = 0;
        SET @i = 10;
        WHILE @i >= 2
        BEGIN
            SET @soma = @soma + (CAST(SUBSTRING(@CPF, 11 - @i, 1) AS INT) * @i);
            SET @i = @i - 1;
        END;
        SET @resto = @soma % 11;
        SET @primeiroDigito = IIF(@resto < 2, 0, 11 - @resto);

        -- Cálculo do segundo dígito verificador
        SET @soma = 0;
        SET @i = 11;
        SET @CPF = @CPF + CAST(@primeiroDigito AS NVARCHAR(1));
        WHILE @i >= 2
        BEGIN
            SET @soma = @soma + (CAST(SUBSTRING(@CPF, 12 - @i, 1) AS INT) * @i);
            SET @i = @i - 1;
        END;
        SET @resto = @soma % 11;
        SET @segundoDigito = IIF(@resto < 2, 0, 11 - @resto);

        -- Verificação dos dígitos verificadores
        IF LEN(@CPF) = 11 AND SUBSTRING(@CPF, 10, 1) = CAST(@primeiroDigito AS NVARCHAR(1)) AND SUBSTRING(@CPF, 11, 1) = CAST(@segundoDigito AS NVARCHAR(1))
        BEGIN
            SET @valido = 1; -- CPF válido
        END;
    END;
END;
GO
CREATE PROCEDURE sp_ValidarIdade 
    @dataNascimento DATE,
    @valido BIT OUTPUT
AS
BEGIN
    SET @valido = 0;

    IF DATEDIFF(YEAR, @dataNascimento, GETDATE()) < 16 
    BEGIN
        SET @valido = 0; -- Idade inválida
    END
    ELSE
    BEGIN
        SET @valido = 1; -- Idade válida
    END;
END;
GO
CREATE PROCEDURE sp_CalcularDataLimiteGraduacao 
    @anoIngresso INT,
    @dataLimiteGraduacao DATE OUTPUT
AS
BEGIN
    SET @dataLimiteGraduacao = DATEADD(YEAR, 5, DATEFROMPARTS(@anoIngresso, 1, 1));
END;
GO
CREATE PROCEDURE sp_GerarRA 
    @AnoIngresso INT,
    @SemestreIngresso INT,
    @RA VARCHAR(10) OUTPUT
AS
BEGIN
    SET @RA = CAST(@AnoIngresso AS VARCHAR(4)) + CAST(@SemestreIngresso AS VARCHAR(2)) + RIGHT('0000' + CAST(CAST(RAND() * 10000 AS INT) AS VARCHAR), 4);
END;
GO
CREATE PROCEDURE sp_iud_aluno 
    @acao CHAR(1), 
    @CPF CHAR(11), 
    @nome VARCHAR(100), 
    @nomeSocial VARCHAR(100),
    @dataNascimento DATE,
    @telefoneContato VARCHAR(20),
    @emailPessoal VARCHAR(100),
    @emailCorporativo VARCHAR(100),
    @dataConclusao2Grau DATE,
    @instituicaoConclusao2Grau VARCHAR(100),
    @pontuacaoVestibular DECIMAL(5,2),
    @posicaoVestibular INT,
    @anoIngresso INT,
    @semestreIngresso INT,
    @semestreAnoLimiteGraduacao DATE OUTPUT,
    @RA VARCHAR(10) OUTPUT,
	@curso INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    DECLARE @validoCPF BIT;
    DECLARE @validoIdade BIT;

    -- Verificar se o aluno existe
    IF (UPPER(@acao) <> 'I') AND (NOT EXISTS (SELECT 1 FROM aluno WHERE CPF = @CPF))
    BEGIN
        SET @saida = 'Aluno não encontrado.';
        RETURN;
    END;

    -- Validar CPF
    EXEC sp_validaCPF @CPF, @validoCPF OUTPUT;

    IF @validoCPF = 0
    BEGIN
        SET @saida = 'CPF inválido.';
        RETURN;
    END;

    -- Validar Idade
    EXEC sp_ValidarIdade @dataNascimento, @validoIdade OUTPUT;

    IF @validoIdade = 0
    BEGIN
        SET @saida = 'Idade inválida para ingresso.';
        RETURN;
    END;

    -- Calcular data limite de graduação
    EXEC sp_CalcularDataLimiteGraduacao @anoIngresso, @semestreAnoLimiteGraduacao OUTPUT;

    -- Gerar RA
    EXEC sp_GerarRA @anoIngresso, @semestreIngresso, @RA OUTPUT;

    -- Inserir, atualizar ou deletar aluno
    IF (UPPER(@acao) = 'I')
    BEGIN
        INSERT INTO aluno VALUES (@CPF, @nome, @nomeSocial, @dataNascimento, @telefoneContato,
            @emailPessoal, @emailCorporativo,
            @dataConclusao2Grau, @instituicaoConclusao2Grau,
            @pontuacaoVestibular, @posicaoVestibular,
            @anoIngresso, @semestreIngresso,
            @semestreAnoLimiteGraduacao, @RA, @curso);
        SET @saida = 'Aluno inserido com sucesso.';
    END
    ELSE IF (UPPER(@acao) = 'U')
    BEGIN
        UPDATE aluno SET nome = @nome, nomeSocial = @nomeSocial, dataNascimento = @dataNascimento,
            telefoneContato = @telefoneContato, emailPessoal = @emailPessoal,
            emailCorporativo = @emailCorporativo,
            dataConclusao2Grau = @dataConclusao2Grau, instituicaoConclusao2Grau = @instituicaoConclusao2Grau,
            pontuacaoVestibular = @pontuacaoVestibular, posicaoVestibular = @posicaoVestibular,
            anoIngresso = @anoIngresso, semestreIngresso = @semestreIngresso,
            semestreAnoLimiteGraduacao = @semestreAnoLimiteGraduacao, curso = @curso
        WHERE CPF = @CPF;
        SET @saida = 'Aluno atualizado com sucesso.';
    END
    ELSE IF (UPPER(@acao) = 'D')
    BEGIN
        DELETE FROM aluno WHERE CPF = @CPF;
        SET @saida = 'Aluno deletado com sucesso.';
    END
    ELSE
    BEGIN
        SET @saida = 'Operação inválida.';
        RETURN;
    END;
END;
GO
CREATE PROCEDURE sp_iud_disciplina
    @acao CHAR(1),
    @codigo INT,
    @nome VARCHAR(100),
    @horasSemanais INT,
    @horarioInicio TIME,
    @semestre INT,
    @diaSemana VARCHAR(20),
    @codigoProfessor INT,
    @codigoCurso INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
        VALUES (@nome, @horasSemanais, @horarioInicio, @semestre, @diaSemana, @codigoProfessor, @codigoCurso)
        SET @saida = 'Disciplina inserida com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE disciplina
        SET nome = @nome, horasSemanais = @horasSemanais, horarioInicio = @horarioInicio, semestre = @semestre,
            diaSemana = @diaSemana, codigoProfessor = @codigoProfessor, codigoCurso = @codigoCurso
        WHERE codigo = @codigo
        SET @saida = 'Disciplina alterada com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        -- Excluir os conteúdos relacionados à disciplina
        DELETE FROM conteudo WHERE codigoDisciplina = @codigo
        
        -- Em seguida, excluir a disciplina
        DELETE FROM disciplina WHERE codigo = @codigo
        
        SET @saida = 'Disciplina excluída com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_iud_conteudo 
 @acao CHAR(1), 
 @codigo INT, 
 @nome VARCHAR(100), 
 @descricao VARCHAR(100),
 @codigoDisciplina INT,
 @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO conteudo (codigo, nome, descricao, codigoDisciplina) 
        VALUES (@codigo, @nome, @descricao, @codigoDisciplina)
        SET @saida = 'Conteúdo inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE conteudo 
        SET nome = @nome, descricao = @descricao, codigoDisciplina = @codigoDisciplina
        WHERE codigo = @codigo
        SET @saida = 'Conteúdo alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM conteudo WHERE codigo = @codigo
        SET @saida = 'Conteúdo excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_u_periodomatricula 
 @periodo_inicio DATE, 
 @periodo_fim DATE,
 @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@periodo_inicio IS NOT NULL AND @periodo_fim IS NOT NULL)
    BEGIN
        UPDATE curso SET periodo_matricula_inicio = @periodo_inicio, periodo_matricula_fim = @periodo_fim
        SET @saida = 'Período de matrícula alterado com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Datas inválidas', 16, 1)
        RETURN
    END
END
GO
CREATE PROCEDURE sp_nova_matricula
	@codigo_aluno	CHAR(11),
	@saida VARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE @semestre INT
	SELECT @semestre = MAX(semestre) FROM matricula WHERE codigoAluno = @codigo_aluno
	IF @semestre IS NULL
	BEGIN
		SET @semestre = 1
	END
	ELSE
	BEGIN
		SET @semestre = @semestre + 1
	END
	DECLARE @codigo INT
	SELECT @codigo = MAX(codigo) FROM matricula
	SET @codigo = @codigo + 1

	INSERT INTO matricula VALUES (@codigo, @codigo_aluno, GETDATE(), @semestre)
END
GO
CREATE PROCEDURE sp_matricular_disciplina
	@codigo_disciplina	INT,
	@codigo_matricula	INT,
	@saida VARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE @horario_inicio INT, @horas_semanais INT, @dia_semana VARCHAR(100)
	SELECT @horario_inicio = (CAST(SUBSTRING(horarioInicio, 1, CHARINDEX(':', horarioInicio) - 1) AS INT) + 1) FROM disciplina WHERE codigo = @codigo_disciplina
	SELECT @horas_semanais = horasSemanais FROM disciplina WHERE codigo = @codigo_disciplina
	SELECT @dia_semana = diaSemana FROM disciplina WHERE codigo = @codigo_disciplina

	DECLARE @conflito INT
	SELECT @conflito = COUNT(d.codigo) FROM matriculaDisciplina m JOIN disciplina d ON m.codigoDisciplina = d.codigo WHERE m.CodigoMatricula = @codigo_matricula AND d.diaSemana = @dia_semana AND
	((CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) >= @horario_inicio AND (@horario_inicio + @horas_semanais) >= CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT)) OR
	((CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) + d.horasSemanais) >= @horario_inicio AND (@horario_inicio + @horas_semanais) >= (CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) + d.horasSemanais)) OR
	(CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) <= @horario_inicio AND (@horario_inicio + @horas_semanais) <= (CAST(SUBSTRING(d.horarioInicio, 1, CHARINDEX(':', d.horarioInicio) - 1) AS INT) + d.horasSemanais)))
	
	IF @conflito > 0
	BEGIN
		RAISERROR('Um ou mais horários de disciplinas apresentam conflitos', 16, 1)
        RETURN
	END
	ELSE
	BEGIN
		INSERT INTO matriculaDisciplina VALUES (@codigo_matricula, @codigo_disciplina, 'Cursando', 0.0)
	END
END
GO
CREATE PROCEDURE sp_iud_telefone
 @acao CHAR(1), 
 @numero VARCHAR(100), 
 @aluno VARCHAR(100), 
 @tipo VARCHAR(100),
 @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO telefone VALUES (@aluno, @numero, @tipo) 
        SET @saida = 'Telefone inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE telefone 
        SET tipo = @tipo
        WHERE aluno = @aluno AND numero = @numero
        SET @saida = 'Telefone alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM telefone WHERE aluno = @aluno AND numero = @numero
        SET @saida = 'Telefone excluído com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO
CREATE FUNCTION fn_Lista_Chamada_Disciplina
(
    @codigoDisciplina INT,
    @dataChamada DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT lc.codigo, 
           lc.codigoMatricula, 
           lc.codigoDisciplina, 
           lc.dataChamada, 
           lc.presenca1, 
           lc.presenca2,
           lc.presenca3,
           lc.presenca4, 
           a.nome AS nomeAluno,
           d.nome AS nomeDisciplina
    FROM listaChamada lc
    JOIN matricula M ON lc.codigoMatricula = m.codigo
    JOIN aluno a ON M.codigoAluno = a.CPF
    JOIN disciplina d ON lc.codigoDisciplina = d.codigo
    WHERE lc.codigoDisciplina = @codigoDisciplina
    AND lc.dataChamada = @dataChamada
);
GO
--SELECT * FROM eliminacoes

--SELECT * FROM fn_Lista_Chamada_Disciplina(1001,'2024-04-02');
CREATE PROCEDURE sp_iud_listaChamada
    @acao CHAR(1),
    @codigo INT,
    @codigoMatricula INT,
    @codigoDisciplina INT,
    @dataChamada DATE,
    @presenca1 INT,
    @presenca2 INT,
    @presenca3 INT,
    @presenca4 INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'I')
    BEGIN
        INSERT INTO listaChamada (codigo, codigoMatricula, codigoDisciplina, dataChamada, presenca1, presenca2, presenca3, presenca4)
        VALUES (@codigo, @codigoMatricula, @codigoDisciplina, @dataChamada, @presenca1, @presenca2, @presenca3, @presenca4)
        SET @saida = 'Registro de chamada inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE listaChamada
        SET codigoMatricula = @codigoMatricula, codigoDisciplina = @codigoDisciplina, dataChamada = @dataChamada,
            presenca1 = @presenca1, presenca2 = @presenca2, presenca3 = @presenca3, presenca4 = @presenca4
        WHERE codigo = @codigo
        SET @saida = 'Registro de chamada alterado com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1)
        RETURN
    END
END
GO

CREATE FUNCTION fn_lista_eliminacoes()
RETURNS TABLE
AS
RETURN
(
    SELECT e.codigo,
           e.codigoMatricula,
           e.codigoDisciplina,
           e.dataEliminacao,
           e.status,
           e.nomeInstituicao,
           a.nome AS nomeAluno,
           d.nome AS nomeDisciplina,
           c.nome AS nomeCurso
    FROM eliminacoes e
    JOIN matricula M ON e.codigoMatricula = M.codigo
    JOIN aluno a ON M.codigoAluno = a.CPF
    JOIN disciplina d ON e.codigoDisciplina = d.codigo
    JOIN curso c ON a.curso = c.codigo
    WHERE e.status = 'Em análise'
);
GO
--SELECT * FROM fn_lista_eliminacoes();
--SELECT * FROM eliminacoes();
CREATE FUNCTION fn_lista_eliminacoes_por_RA (@RA INT)
RETURNS TABLE
AS
RETURN
(
    SELECT e.codigo,
           e.codigoMatricula,
           e.codigoDisciplina,
           e.dataEliminacao,
           e.status,
           e.nomeInstituicao,
           a.nome AS nomeAluno,
		   a.RA,
           d.nome AS nomeDisciplina,
           c.nome AS nomeCurso
    FROM eliminacoes e
    JOIN matricula M ON e.codigoMatricula = M.codigo
    JOIN aluno a ON M.codigoAluno = a.CPF
    JOIN disciplina d ON e.codigoDisciplina = d.codigo
    JOIN curso c ON a.curso = c.codigo
    WHERE a.RA = @RA
);
GO
--SELECT * FROM fn_lista_eliminacoes_por_RA(20167890);

CREATE FUNCTION fn_buscar_eliminacao (@codigo INT)
RETURNS TABLE
AS
RETURN
(
    SELECT e.codigo,
           e.codigoMatricula,
           e.codigoDisciplina,
           e.dataEliminacao,
           e.status,
           e.nomeInstituicao,
           a.nome AS nomeAluno,
		   a.CPF AS cpfAluno,
           d.nome AS nomeDisciplina,
           c.nome AS nomeCurso,
		   c.codigo AS codigoCurso
    FROM eliminacoes e
    JOIN matricula M ON e.codigoMatricula = M.codigo
    JOIN aluno a ON M.codigoAluno = a.CPF
    JOIN disciplina d ON e.codigoDisciplina = d.codigo
    JOIN curso c ON a.curso = c.codigo
    WHERE e.codigo = @codigo
);
GO
CREATE FUNCTION fn_listar_disciplinas_RA (@RA INT)
RETURNS TABLE
AS
RETURN
(
    SELECT nomeDisciplina, codigoDisciplina, codigoMatricula
    FROM (
        SELECT d.nome AS nomeDisciplina,
               d.codigo AS codigoDisciplina,
               m.codigo AS codigoMatricula,
               ROW_NUMBER() OVER (PARTITION BY d.codigo ORDER BY m.codigo) AS row_num
        FROM aluno a
        INNER JOIN matricula m ON a.CPF = m.codigoAluno
        INNER JOIN curso c ON a.curso = c.codigo
        INNER JOIN disciplina d ON c.codigo = d.codigoCurso
        WHERE a.RA = @RA
    ) AS disciplinas_numero_linha
    WHERE row_num = 1
);


--SELECT * FROM fn_listar_disciplinas_RA(20169012);

--SELECT * FROM matricula

GO
CREATE FUNCTION fn_consultar_aluno_RA (@RA INT)
RETURNS TABLE
AS
RETURN
(
    SELECT a.CPF, 
           a.nome, 
           a.nomeSocial, 
           a.dataNascimento, 
           a.telefoneContato, 
           a.emailPessoal, 
           a.emailCorporativo, 
           a.dataConclusao2Grau, 
           a.instituicaoConclusao2Grau, 
           a.pontuacaoVestibular, 
           a.posicaoVestibular, 
           a.anoIngresso, 
           a.semestreIngresso, 
           a.semestreAnoLimiteGraduacao, 
           a.RA, 
           c.codigo AS codigoCurso, 
           c.nome AS nomeCurso 
    FROM aluno a 
    JOIN curso c ON a.curso = c.codigo 
    WHERE a.RA = @RA
);
GO
CREATE PROCEDURE sp_inserir_eliminacao
    @codigoMatricula INT,
    @codigoDisciplina INT,
    @nomeInstituicao VARCHAR(255),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inserir a nova eliminação na tabela
    INSERT INTO eliminacoes (codigoMatricula, codigoDisciplina, dataEliminacao, status, nomeInstituicao)
    VALUES (@codigoMatricula, @codigoDisciplina, GETDATE(), 'Em análise', @nomeInstituicao);

    -- Definir a mensagem de saída
    SET @saida = 'Eliminação inserida com sucesso.';
END;
GO

CREATE FUNCTION fn_listar_disciplinas_professor
(
    @codigo_professor INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT d.codigo AS codigoDisciplina, d.nome AS nomeDisciplina, d.horasSemanais, SUBSTRING(d.horarioInicio, 1, 5) AS horarioInicio, d.semestre, d.diaSemana, p.nome AS nomeProfessor, c.nome AS nomeCurso 
    FROM disciplina d 
    JOIN professor p ON d.codigoProfessor = p.codigo 
    JOIN curso c ON d.codigoCurso = c.codigo 
    WHERE p.codigo = @codigo_professor
);
GO
--SELECT * FROM fn_listar_lista_chamada_datas(1001);
CREATE FUNCTION fn_listar_lista_chamada_datas (@codigoDisciplina INT)
RETURNS TABLE
AS
RETURN
(
    SELECT dataChamada
    FROM listaChamada
    WHERE codigoDisciplina = @codigoDisciplina
    GROUP BY dataChamada
);
GO
CREATE PROCEDURE sp_update_eliminacao
    @acao CHAR(1),
    @codigo INT,
    @codigoMatricula INT,
    @codigoDisciplina INT,
    @dataEliminacao DATE,
    @status VARCHAR(30),
    @nomeInstituicao VARCHAR(255),
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF (@acao = 'U')
    BEGIN
        UPDATE eliminacoes
        SET codigoMatricula = @codigoMatricula,
            codigoDisciplina = @codigoDisciplina,
            dataEliminacao = @dataEliminacao,
            status = @status,
            nomeInstituicao = @nomeInstituicao
        WHERE codigo = @codigo;

        SET @saida = 'Registro de eliminação atualizado com sucesso';
    END
    ELSE
    BEGIN
        RAISERROR('Operação inválida', 16, 1);
        RETURN;
    END
END
GO
CREATE TRIGGER t_matricula_primeiro_semestre ON aluno
FOR INSERT
AS
BEGIN
	DECLARE @codigo_curso INT,
			@cpf CHAR(11),
			@codigo_matricula INT,
			@codigo_disciplina INT
	SELECT @codigo_curso = curso FROM INSERTED
	SELECT @cpf = cpf FROM INSERTED
	SELECT @codigo_matricula = ((SELECT MAX(codigo) FROM matricula) + 1 )
	INSERT INTO matricula VALUES (@codigo_matricula, @cpf, GETDATE(), 1)
	DECLARE c CURSOR FOR SELECT codigo FROM disciplina WHERE semestre = 1 AND codigoCurso = @codigo_curso
	OPEN c
	FETCH NEXT FROM c INTO @codigo_disciplina
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO matriculaDisciplina VALUES (@codigo_matricula, @codigo_disciplina, 'Cursando', 0.00)
		FETCH NEXT FROM c INTO @codigo_disciplina
	END
	CLOSE c;
    DEALLOCATE c;
END
