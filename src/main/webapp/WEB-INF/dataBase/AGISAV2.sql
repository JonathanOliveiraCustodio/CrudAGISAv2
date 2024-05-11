USE master
CREATE DATABASE SistemaAGISAV2
GO
USE SistemaAGISAV2 
GO
CREATE TABLE curso (
codigo					INT CHECK (codigo >= 0 AND codigo <= 100),
nome					VARCHAR(100),
cargaHoraria			INT,			
sigla					VARCHAR(10),
ultimaNotaENADE			DECIMAL(5,2),
turno					VARCHAR(20),
periodo_matricula_inicio	DATE,
periodo_matricula_fim	DATE,
PRIMARY KEY  (codigo)
)
GO
CREATE TABLE aluno (
CPF							CHAR(11) UNIQUE,
nome						VARCHAR(100),
nomeSocial					VARCHAR(100),
dataNascimento				DATE,
telefoneContato				VARCHAR(20),
emailPessoal				VARCHAR(100),
emailCorporativo			VARCHAR(100),
dataConclusao2Grau			DATE,
instituicaoConclusao2Grau	VARCHAR(100),
pontuacaoVestibular			DECIMAL(5,2),
posicaoVestibular			INT,
anoIngresso					INT,
semestreIngresso			INT,
semestreAnoLimiteGraduacao  DATE,
RA							INT,
curso						INT
PRIMARY KEY (CPF)
FOREIGN KEY (curso) REFERENCES curso(codigo)
)
GO
CREATE TABLE professor (
codigo    INT ,
nome      VARCHAR(100) ,
titulacao  VARCHAR(50)
PRIMARY KEY (codigo)
)
GO
CREATE TABLE disciplina (
codigo				INT IDENTITY (1001,1),
nome				VARCHAR(100),
horasSemanais		INT,
horarioInicio       VARCHAR(10),
semestre			INT,
diaSemana			VARCHAR(20),
codigoProfessor		INT,	
codigoCurso		INT	
PRIMARY KEY (codigo)
FOREIGN KEY (codigoProfessor) REFERENCES professor(codigo),
FOREIGN KEY (codigoCurso) REFERENCES curso(codigo)
)
GO
CREATE TABLE telefone (
aluno			CHAR(11),
numero  		CHAR(12),
tipo			VARCHAR(100)
PRIMARY KEY (aluno, numero)
FOREIGN KEY (aluno) REFERENCES aluno(CPF)
)
GO
CREATE TABLE matricula (
codigo				INT	,
codigoAluno				CHAR(11),
dataMatricula		DATE,
semestre        	INT
PRIMARY KEY (codigo)
FOREIGN KEY (codigoAluno) REFERENCES aluno(CPF),
)
GO
CREATE TABLE matriculaDisciplina (
CodigoMatricula				    INT,
codigoDisciplina				INT,
situacao						VARCHAR(20),
notaFinal						DECIMAL	(4,2)
PRIMARY KEY (CodigoMatricula,codigoDisciplina)
FOREIGN KEY (CodigoMatricula) REFERENCES matricula(codigo),
FOREIGN KEY (codigoDisciplina) REFERENCES disciplina(codigo)
)
GO
CREATE TABLE conteudo(
codigo				INT,
nome				VARCHAR(100) ,
descricao			VARCHAR(100),
codigoDisciplina	INT		
PRIMARY KEY   (codigo)
FOREIGN KEY (codigoDisciplina) REFERENCES disciplina (codigo)
)
GO
INSERT INTO curso (codigo, nome, cargaHoraria, sigla, ultimaNotaENADE, turno, periodo_matricula_inicio, periodo_matricula_fim) 
VALUES 
(1, 'Administra��o de Empresas', 4000, 'ADM', 7.8, 'Matutino', '2024-01-01', '2024-01-01'),
(2, 'Engenharia Civil', 4500, 'ENG CIV', 8.5, 'Vespertino', '2024-01-01', '2024-01-01'),
(3, 'Direito', 4000, 'DIR', 8.2, 'Noturno', '2024-01-01', '2024-01-01'),
(4, 'Medicina', 6000, 'MED', 9.3, 'Integral', '2024-01-01', '2024-01-01'),
(5, 'Ci�ncia da Computa��o', 3600, 'CC', 8.9, 'Matutino', '2024-01-01', '2024-01-01'),
(6, 'Psicologia', 4200, 'PSI', 8.0, 'Vespertino', '2024-01-01', '2024-01-01'),
(7, 'Administra��o P�blica', 3800, 'ADM PUB', 7.5, 'Noturno', '2024-01-01', '2024-01-01'),
(8, 'Engenharia El�trica', 4800, 'ENG ELE', 8.7, 'Integral', '2024-01-01', '2024-01-01'),
(9, 'Gastronomia', 3200, 'GAS', 7.0, 'Matutino', '2024-01-01', '2024-01-01'),
(10, 'Arquitetura e Urbanismo', 4200, 'ARQ', 8.4, 'Vespertino', '2024-01-01', '2024-01-01'),
(11, 'Analise e Desenvolvimento de Sistemas', 4200, 'ADS', 8.4, 'Vespertino', '2024-01-01', '2024-01-01');
GO
INSERT INTO aluno (CPF, nome, nomeSocial, dataNascimento, telefoneContato, emailPessoal, emailCorporativo, dataConclusao2Grau, instituicaoConclusao2Grau, pontuacaoVestibular, posicaoVestibular, anoIngresso, semestreIngresso, semestreAnoLimiteGraduacao, RA, curso)
VALUES
    ('55312103020', 'Jo�o Silva', NULL, '1998-05-15', '123456789', 'joao@email.com', 'joao@empresa.com', '2016-12-20', 'Escola Estadual ABC', 8.75, 25, 2016, 1, '2020-12-31', 2016456, 1),
    ('86462326034', 'Maria Santos', NULL, '1999-09-22', '987654321', 'maria@email.com', 'maria@empresa.com', '2017-05-10', 'Escola Municipal XYZ', 8.50, 30, 2017, 1, '2021-12-31', 20174567, 2),
    ('39112829072', 'Jos� Oliveira', NULL, '1997-02-10', '987123456', 'jose@email.com', 'jose@empresa.com', '2016-08-30', 'Col�gio Particular QRS', 9.00, 15, 2016, 2, '2020-12-31', 2016378, 1),
    ('39590327060', 'Ana Souza', NULL, '2000-11-05', '654987321', 'ana@email.com', 'ana@empresa.com', '2017-11-28', 'Escola Estadual XYZ', 8.25, 40, 2017, 1, '2021-12-31', 2016789, 2),
    ('09129892031', 'Pedro Lima', NULL, '1996-07-30', '987123654', 'pedro@email.com', 'pedro@empresa.com', '2016-04-12', 'Col�gio Municipal DEF', 8.90, 20, 2016, 2, '2020-12-31', 20167890, 1),
    ('89125916068', 'Juliana Castro', NULL, '1999-03-18', '654321987', 'juliana@email.com', 'juliana@empresa.com', '2017-09-03', 'Col�gio Estadual LMN', 8.80, 10, 2017, 1, '2021-12-31', 2016901, 2),
    ('97006247063', 'Lucas Almeida', NULL, '1998-12-25', '321987654', 'lucas@email.com', 'lucas@empresa.com', '2016-10-05', 'Escola Particular GHI', 8.70, 35, 2016, 2, '2020-12-31', 20169012, 1),
    ('12697967044', 'Carla Pereira', NULL, '2001-04-08', '987321654', 'carla@email.com', 'carla@empresa.com', '2017-12-15', 'Col�gio Municipal OPQ', 8.45, 50, 2017, 1, '2021-12-31', 201690123, 2),
    ('29180596096', 'Marcos Fernandes', NULL, '1997-10-20', '654321789', 'marcos@email.com', 'marcos@empresa.com', '2016-06-18', 'Escola Estadual RST', 8.95, 5, 2016, 1, '2020-12-31', 201634, 1),
    ('30260403040', 'Aline Rocha', NULL, '2000-01-12', '321654987', 'aline@email.com', 'aline@empresa.com', '2017-08-20', 'Col�gio Particular UVW', 8.60, 45, 2017, 2, '2021-12-31', 2017450, 2);
GO
-- Semestre 1
INSERT INTO professor (codigo, nome, titulacao) VALUES
(1, 'Carlos Silva', 'Doutor'),
(2, 'Ana Santos', 'Mestre'),
(3, 'Paulo Oliveira', 'Doutor'),
(4, 'Maria Costa', 'Mestre'),
(5, 'Fernanda Mendes', 'Doutor'),
(6, 'Jos� Pereira', 'Mestre'),
(7, 'Aline Almeida', 'Doutor'),
(8, 'Rafael Ramos', 'Mestre'),
(9, 'Juliana Fernandes', 'Doutor'),
(10, 'Marcos Sousa', 'Mestre'),
(11, 'Larissa Lima', 'Doutor'),
(12, 'Gustavo Gomes', 'Mestre'),
(13, 'Camila Oliveira', 'Doutor'),
(14, 'Pedro Barbosa', 'Mestre'),
(15, 'Patr�cia Martins', 'Doutor'),
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
('Introdu��o � Administra��o', 4, '13:00', 1, 'Segunda-feira', 1, 1),
('Contabilidade Financeira', 2, '13:00', 1, 'Ter�a-feira', 2, 1),
('Economia Empresarial', 4, '13:00', 1, 'Quarta-feira', 3, 1),
('Gest�o de Pessoas', 2, '13:00', 1, 'Quinta-feira', 4, 1),
('Marketing e Vendas', 4, '13:00', 1, 'Sexta-feira', 5, 1),
('Empreendedorismo', 2, '13:00', 1, 'S�bado', 6, 1),
('Gest�o Estrat�gica', 4, '13:00', 2, 'Segunda-feira', 7, 1),
('Log�stica Empresarial', 2, '13:00', 2, 'Ter�a-feira', 8, 1),
('Direito Empresarial', 4, '13:00', 2, 'Quarta-feira', 9, 1),
('Finan�as Corporativas', 2, '13:00', 2, 'Quinta-feira', 10, 1),
('Gest�o de Projetos', 4, '13:00', 2, 'Sexta-feira', 1, 1),
('Comportamento Organizacional', 2, '13:00', 2, 'S�bado', 2, 1),
('Gest�o de Qualidade', 4, '14:50', 3, 'Segunda-feira', 3, 1),
('Administra��o de Produ��o', 2, '14:50', 3, 'Ter�a-feira', 4, 1),
('Comunica��o Empresarial', 4, '14:50', 3, 'Quarta-feira', 5, 1),
('Tecnologia da Informa��o', 2, '14:50', 3, 'Quinta-feira', 6, 1),
('Gest�o Ambiental', 4, '14:50', 3, 'Sexta-feira', 7, 1),
('�tica e Responsabilidade Social', 2, '14:50', 3, 'S�bado', 8, 1),
('Estrat�gias de Marketing', 4, '14:50', 4, 'Segunda-feira', 1, 1),
('Finan�as Corporativas Avan�adas', 2, '14:50', 4, 'Ter�a-feira', 2, 1),
('Gest�o de Projetos Empresariais', 4, '14:50', 4, 'Quarta-feira', 3, 1),
('Com�rcio Internacional', 2, '14:50', 4, 'Quinta-feira', 4, 1),
('Empreendedorismo Corporativo', 4, '14:50', 4, 'Sexta-feira', 5, 1),
('Gest�o de Opera��es', 2, '14:50', 4, 'S�bado', 6, 1),
('Gest�o de Riscos', 4, '16:40', 5, 'Segunda-feira', 7, 1),
('Marketing Digital', 2, '16:40', 5, 'Ter�a-feira', 8, 1),
('�tica nos Neg�cios', 4, '16:40', 5, 'Quarta-feira', 9, 1),
('Gest�o da Inova��o', 2, '16:40', 5, 'Quinta-feira', 10, 1),
('Gest�o de Carreira', 4, '16:40', 5, 'Sexta-feira', 1, 1),
('Empreendedorismo Social', 2, '16:40', 5, 'S�bado', 2, 1),
('Negocia��o Empresarial', 4, '16:40', 6, 'Segunda-feira', 3, 1),
('Gest�o de Conflitos', 2, '16:40', 6, 'Ter�a-feira', 4, 1),
('Gest�o de Mudan�as Organizacionais', 4, '16:40', 6, 'Quarta-feira', 5, 1),
('An�lise de Investimentos', 2, '16:40', 6, 'Quinta-feira', 6, 1),
('Consultoria Empresarial', 4, '16:40', 6, 'Sexta-feira', 7, 1),
('Projeto Integrador em Administra��o', 2, '16:40', 6, 'S�bado', 8, 1);
GO
-- Disciplinas Curso 2
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Engenharia Civil', 4, '13:00', 1, 'Segunda-feira', 11, 2),
('C�lculo Diferencial e Integral', 2, '13:00', 1, 'Ter�a-feira', 12, 2),
('F�sica Aplicada � Engenharia', 4, '13:00', 1, 'Quarta-feira', 13, 2),
('Desenho T�cnico', 2, '13:00', 1, 'Quinta-feira', 14, 2),
('Qu�mica Geral', 4, '13:00', 1, 'Sexta-feira', 15, 2),
('Introdu��o � Programa��o', 2, '13:00', 1, 'S�bado', 16, 2),
('�lgebra Linear', 4, '13:00', 2, 'Segunda-feira', 17, 2),
('C�lculo Vetorial e Geometria Anal�tica', 2, '13:00', 2, 'Ter�a-feira', 18, 2),
('Mec�nica Geral', 4, '13:00', 2, 'Quarta-feira', 19, 2),
('Desenho Assistido por Computador', 2, '13:00', 2, 'Quinta-feira', 20, 2),
('Geologia para Engenharia', 4, '13:00', 2, 'Sexta-feira', 21, 2),
('Introdu��o � Economia', 2, '13:00', 2, 'S�bado', 22, 2),
('Mec�nica dos S�lidos', 4, '14:50', 3, 'Segunda-feira', 23, 2),
('Mec�nica dos Fluidos', 2, '14:50', 3, 'Ter�a-feira', 24, 2),
('Topografia', 4, '14:50', 3, 'Quarta-feira', 25, 2),
('Materiais de Constru��o Civil', 2, '14:50', 3, 'Quinta-feira', 26, 2),
('Estat�stica Aplicada � Engenharia', 4, '14:50', 3, 'Sexta-feira', 27, 2),
('Fundamentos de Eletricidade e Magnetismo', 2, '14:50', 3, 'S�bado', 28, 2),
('Estruturas de Concreto', 4, '14:50', 4, 'Segunda-feira', 29, 2),
('Estruturas de A�o', 2, '14:50', 4, 'Ter�a-feira', 30, 2),
('Hidr�ulica Aplicada', 4, '14:50', 4, 'Quarta-feira', 31, 2),
('Saneamento B�sico', 2, '14:50', 4, 'Quinta-feira', 32, 2),
('Geotecnia', 4, '14:50', 4, 'Sexta-feira', 33, 2),
('Legisla��o e Normas T�cnicas', 2, '14:50', 4, 'S�bado', 34, 2),
('Engenharia de Tr�fego', 4, '16:40', 5, 'Segunda-feira', 35, 2),
('Estradas e Pavimenta��o', 2, '16:40', 5, 'Ter�a-feira', 36, 2),
('Gest�o de Projetos em Engenharia Civil', 4, '16:40', 5, 'Quarta-feira', 37, 2),
('Meio Ambiente e Desenvolvimento Sustent�vel', 2, '16:40', 5, 'Quinta-feira', 38, 2),
('Constru��o Civil', 4, '16:40', 5, 'Sexta-feira', 39, 2),
('Seguran�a do Trabalho', 2, '16:40', 5, 'S�bado', 40, 2),
('Gest�o de Res�duos', 4, '16:40', 6, 'Segunda-feira', 41, 2),
('Projetos de Funda��es', 2, '16:40', 6, 'Ter�a-feira', 42, 2),
('Engenharia S�smica', 4, '16:40', 6, 'Quarta-feira', 43, 2),
('Restaura��o e Conserva��o de Estruturas', 2, '16:40', 6, 'Quinta-feira', 44, 2),
('�tica Profissional em Engenharia', 4, '16:40', 6, 'Sexta-feira', 45, 2),
('Trabalho de Conclus�o de Curso', 2, '16:40', 6, 'S�bado', 46, 2);
GO
--Curso 3
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o ao Estudo do Direito', 4, '13:00', 1, 'Segunda-feira', 1, 3),
('Teoria Geral do Estado', 2, '13:00', 1, 'Ter�a-feira', 2, 3),
('Hist�ria do Direito', 4, '13:00', 1, 'Quarta-feira', 3, 3),
('Filosofia do Direito', 2, '13:00', 1, 'Quinta-feira', 4, 3),
('Direito Civil I', 4, '13:00', 1, 'Sexta-feira', 5, 3),
('Direito Penal I', 2, '13:00', 1, 'S�bado', 6, 3), 
('Direito Constitucional I', 4, '13:00', 2, 'Segunda-feira', 7, 3),
('Direito Administrativo I', 2, '13:00', 2, 'Ter�a-feira', 8, 3),
('Direito Processual Civil I', 4, '13:00', 2, 'Quarta-feira', 9, 3),
('Direito Empresarial I', 2, '13:00', 2, 'Quinta-feira', 10, 3),
('Direito do Trabalho I', 4, '13:00', 2, 'Sexta-feira', 11, 3),
('Direito Internacional P�blico', 2, '13:00', 2, 'S�bado', 12, 3),
('Direito Constitucional II', 4, '14:50', 3, 'Segunda-feira', 13, 3),
('Direito Tribut�rio I', 2, '14:50', 3, 'Ter�a-feira', 14, 3),
('Direito Processual Penal I', 4, '14:50', 3, 'Quarta-feira', 15, 3),
('Direito Internacional Privado', 2, '14:50', 3, 'Quinta-feira', 16, 3),
('Direito do Consumidor', 4, '14:50', 3, 'Sexta-feira', 17, 3),
('Direito Ambiental', 2, '14:50', 3, 'S�bado', 18, 3),
('Direito Civil II', 4, '14:50', 4, 'Segunda-feira', 19, 3),
('Direito Processual Civil II', 2, '14:50', 4, 'Ter�a-feira', 20, 3),
('Direito Penal II', 4, '14:50', 4, 'Quarta-feira', 21, 3),
('Direito Processual Penal II', 2, '14:50', 4, 'Quinta-feira', 22, 3),
('Direito Administrativo II', 4, '14:50', 4, 'Sexta-feira', 23, 3),
('Direito Tribut�rio II', 2, '14:50', 4, 'S�bado', 24, 3),
('Direito Civil III', 4, '16:40', 5, 'Segunda-feira', 25, 3),
('Direito Processual Civil III', 2, '16:40', 5, 'Ter�a-feira', 26, 3),
('Direito Penal III', 4, '16:40', 5, 'Quarta-feira', 27, 3),
('Direito Processual Penal III', 2, '16:40', 5, 'Quinta-feira', 28, 3),
('Direito do Trabalho II', 4, '16:40', 5, 'Sexta-feira', 29, 3),
('Direito Previdenci�rio', 2, '16:40', 5, 'S�bado', 30, 3),
('Direito Civil IV', 4, '16:40', 6, 'Segunda-feira', 31, 3),
('Direito Processual Civil IV', 2, '16:40', 6, 'Ter�a-feira', 32, 3),
('Direito Penal IV', 4, '16:40', 6, 'Quarta-feira', 33, 3),
('Direito Processual Penal IV', 2, '16:40', 6, 'Quinta-feira', 34, 3),
('Direito Empresarial II', 4, '16:40', 6, 'Sexta-feira', 35, 3),
('Direito da Fam�lia e Sucess�es', 2, '16:40', 6, 'S�bado', 36, 3);
GO
--Disciplinas Curso 4

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Anatomia Humana I', 4, '13:00', 1, 'Segunda-feira', 1, 4),
('Bioqu�mica M�dica I', 2, '13:00', 1, 'Ter�a-feira', 2, 4),
('Biologia Celular e Molecular', 4, '13:00', 1, 'Quarta-feira', 3, 4),
('Embriologia', 2, '13:00', 1, 'Quinta-feira', 4, 4),
('Histologia', 4, '13:00', 1, 'Sexta-feira', 5, 4),
('Fisiologia Humana I', 2, '13:00', 1, 'S�bado', 6, 4),
('Anatomia Humana II', 4, '13:00', 2, 'Segunda-feira', 7, 4),
('Bioqu�mica M�dica II', 2, '13:00', 2, 'Ter�a-feira', 8, 4),
('Gen�tica M�dica', 4, '13:00', 2, 'Quarta-feira', 9, 4),
('Imunologia', 2, '13:00', 2, 'Quinta-feira', 10, 4),
('Parasitologia', 4, '13:00', 2, 'Sexta-feira', 11, 4),
('Microbiologia', 2, '13:00', 2, 'S�bado', 12, 4),
('Patologia Geral', 4, '14:50', 3, 'Segunda-feira', 13, 4),
('Farmacologia', 2, '14:50', 3, 'Ter�a-feira', 14, 4),
('Epidemiologia', 4, '14:50', 3, 'Quarta-feira', 15, 4),
('Semiologia M�dica', 2, '14:50', 3, 'Quinta-feira', 16, 4),
('Psicologia M�dica', 4, '14:50', 3, 'Sexta-feira', 17, 4),
('Bioestat�stica', 2, '14:50', 3, 'S�bado', 18, 4),
('Patologia Especial', 4, '14:50', 4, 'Segunda-feira', 19, 4),
('Farmacologia Cl�nica', 2, '14:50', 4, 'Ter�a-feira', 20, 4),
('Sa�de P�blica', 4, '14:50', 4, 'Quarta-feira', 21, 4),
('Medicina Preventiva e Social', 2, '14:50', 4, 'Quinta-feira', 22, 4),
('Medicina Legal', 4, '14:50', 4, 'Sexta-feira', 23, 4),
('�tica M�dica', 2, '14:50', 4, 'S�bado', 24, 4), 
('Cl�nica M�dica I', 4, '16:40', 5, 'Segunda-feira', 25, 4),
('Cl�nica Cir�rgica I', 2, '16:40', 5, 'Ter�a-feira', 26, 4),
('Pediatria', 4, '16:40', 5, 'Quarta-feira', 27, 4),
('Ginecologia e Obstetr�cia', 2, '16:40', 5, 'Quinta-feira', 28, 4),
('Sa�de Mental', 4, '16:40', 5, 'Sexta-feira', 29, 4),
('Medicina de Fam�lia e Comunidade', 2, '16:40', 5, 'S�bado', 30, 4),
('Cl�nica M�dica II', 4, '16:40', 6, 'Segunda-feira', 31, 4),
('Cl�nica Cir�rgica II', 2, '16:40', 6, 'Ter�a-feira', 32, 4),
('Ortopedia e Traumatologia', 4, '16:40', 6, 'Quarta-feira', 33, 4),
('Urologia', 2, '16:40', 6, 'Quinta-feira', 34, 4),
('Oftalmologia', 4, '16:40', 6, 'Sexta-feira', 35, 4),
('Otorrinolaringologia', 2, '16:40', 6, 'S�bado', 36, 4);
GO
-- Curso 5 
-- Semestre 1
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Programa��o', 4, '13:00', 1, 'Segunda-feira', 1, 5),
('Algoritmos e Estrutura de Dados', 2, '13:00', 1, 'Ter�a-feira', 2, 5),
('C�lculo I', 4, '13:00', 1, 'Quarta-feira', 3, 5),
('L�gica Matem�tica', 2, '13:00', 1, 'Quinta-feira', 4, 5),
('Arquitetura de Computadores', 4, '13:00', 1, 'Sexta-feira', 5, 5),
('Ingl�s T�cnico', 2, '13:00', 1, 'S�bado', 6, 5),
('Estruturas de Dados Avan�adas', 4, '13:00', 2, 'Segunda-feira', 7, 5),
('Programa��o Orientada a Objetos', 2, '13:00', 2, 'Ter�a-feira', 8, 5),
('C�lculo II', 4, '13:00', 2, 'Quarta-feira', 9, 5),
('Redes de Computadores', 2, '13:00', 2, 'Quinta-feira', 10, 5),
('Banco de Dados', 4, '13:00', 2, 'Sexta-feira', 11, 5),
('�tica e Cidadania', 2, '13:00', 2, 'S�bado', 12, 5),
('Sistemas Operacionais', 4, '14:50', 3, 'Segunda-feira', 13, 5),
('Engenharia de Software I', 2, '14:50', 3, 'Ter�a-feira', 14, 5),
('C�lculo III', 4, '14:50', 3, 'Quarta-feira', 15, 5),
('Gest�o de Projetos de TI', 2, '14:50', 3, 'Quinta-feira', 16, 5),
('Seguran�a da Informa��o', 4, '14:50', 3, 'Sexta-feira', 17, 5),
('Empreendedorismo', 2, '14:50', 3, 'S�bado', 18, 5),
('Programa��o Web', 4, '14:50', 4, 'Segunda-feira', 19, 5),
('Engenharia de Software II', 2, '14:50', 4, 'Ter�a-feira', 20, 5),
('Matem�tica Discreta', 4, '14:50', 4, 'Quarta-feira', 21, 5),
('Intelig�ncia Artificial', 2, '14:50', 4, 'Quinta-feira', 22, 5),
('Computa��o Gr�fica', 4, '14:50', 4, 'Sexta-feira', 23, 5),
('Trabalho de Conclus�o de Curso I', 2, '14:50', 4, 'S�bado', 24, 5),
('Programa��o Paralela e Distribu�da', 4, '16:40', 5, 'Segunda-feira', 25, 5),
('Minera��o de Dados', 2, '16:40', 5, 'Ter�a-feira', 26, 5),
('Computa��o em Nuvem', 4, '16:40', 5, 'Quarta-feira', 27, 5),
('Gest�o de Tecnologia da Informa��o', 2, '16:40', 5, 'Quinta-feira', 28, 5),
('Desenvolvimento Mobile', 4, '16:40', 5, 'Sexta-feira', 29, 5),
('Est�gio Supervisionado', 2, '16:40', 5, 'S�bado', 30, 5),
('Computa��o Qu�ntica', 4, '16:40', 6, 'Segunda-feira', 31, 5),
('�tica em Tecnologia da Informa��o', 2, '16:40', 6, 'Ter�a-feira', 32, 5),
('T�picos Avan�ados em Ci�ncia da Computa��o', 4, '16:40', 6, 'Quarta-feira', 33, 5),
('Sistemas Distribu�dos', 2, '16:40', 6, 'Quinta-feira', 34, 5),
('Projeto de Sistemas', 4, '16:40', 6, 'Sexta-feira', 35, 5),
('Trabalho de Conclus�o de Curso II', 2, '16:40', 6, 'S�bado', 36, 5);
GO
-- Disciplinas Curso 6

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Psicologia', 4, '13:00', 1, 'Segunda-feira', 1, 6),
('Psicologia Geral', 2, '14:50', 1, 'Ter�a-feira', 2, 6),
('Teorias da Personalidade', 4, '13:00', 1, 'Quarta-feira', 3, 6),
('Neuroci�ncia e Comportamento', 2, '14:50', 1, 'Quinta-feira', 4, 6),
('Metodologia Cient�fica em Psicologia', 4, '13:00', 1, 'Sexta-feira', 5, 6),
('�tica e Deontologia em Psicologia', 2, '14:50', 1, 'S�bado', 6, 6), 
('Psicologia do Desenvolvimento', 4, '13:00', 2, 'Segunda-feira', 7, 6),
('Psicopatologia Geral', 2, '14:50', 2, 'Ter�a-feira', 8, 6),
('Psicologia Social', 4, '13:00', 2, 'Quarta-feira', 9, 6),
('Psicologia Organizacional e do Trabalho', 2, '14:50', 2, 'Quinta-feira', 10, 6),
('Avalia��o Psicol�gica', 4, '13:00', 2, 'Sexta-feira', 11, 6),
('Psicologia Jur�dica', 2, '14:50', 2, 'S�bado', 12, 6),
('Psicologia da Sa�de', 4, '13:00', 3, 'Segunda-feira', 13, 6),
('Psicoterapia Breve', 2, '14:50', 3, 'Ter�a-feira', 14, 6),
('Psicologia Escolar e Educacional', 4, '13:00', 3, 'Quarta-feira', 15, 6),
('Psicologia Hospitalar', 2, '14:50', 3, 'Quinta-feira', 16, 6),
('Psicologia do Esporte', 4, '13:00', 3, 'Sexta-feira', 17, 6),
('Psicologia Ambiental', 2, '14:50', 3, 'S�bado', 18, 6),
('Psicologia do Envelhecimento', 4, '13:00', 4, 'Segunda-feira', 19, 6),
('Psicologia da Fam�lia', 2, '14:50', 4, 'Ter�a-feira', 20, 6),
('Psicologia Comunit�ria', 4, '13:00', 4, 'Quarta-feira', 21, 6),
('Psicologia da Arte', 2, '14:50', 4, 'Quinta-feira', 22, 6),
('Psicologia Transpessoal', 4, '13:00', 4, 'Sexta-feira', 23, 6),
('Psicologia do Tr�nsito', 2, '14:50', 4, 'S�bado', 24, 6),
('Neuropsicologia', 4, '13:00', 5, 'Segunda-feira', 25, 6),
('Psicologia Hospitalar', 2, '14:50', 5, 'Ter�a-feira', 26, 6),
('Psicologia Cl�nica Infantil', 4, '13:00', 5, 'Quarta-feira', 27, 6),
('Psicoterapia de Grupo', 2, '14:50', 5, 'Quinta-feira', 28, 6),
('Psicologia do Esporte', 4, '13:00', 5, 'Sexta-feira', 29, 6),
('Psicologia Organizacional', 2, '14:50', 5, 'S�bado', 30, 6),
('Psicologia da Personalidade', 4, '13:00', 6, 'Segunda-feira', 31, 6),
('Psicologia Anal�tica', 2, '14:50', 6, 'Ter�a-feira', 32, 6),
('Psicologia do Desenvolvimento', 4, '13:00', 6, 'Quarta-feira', 33, 6),
('Psicologia Social', 2, '14:50', 6, 'Quinta-feira', 34, 6),
('Psicologia Cl�nica', 4, '13:00', 6, 'Sexta-feira', 35, 6),
('Psicologia do Trabalho', 2, '14:50', 6, 'S�bado', 36, 6);
GO
-- Disciplinas Curso 7

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Administra��o P�blica', 4, '13:00', 1, 'Segunda-feira', 1, 7),
('Gest�o de Pol�ticas P�blicas', 2, '14:50', 1, 'Ter�a-feira', 2, 7),
('Administra��o Financeira e Or�ament�ria', 4, '13:00', 1, 'Quarta-feira', 3, 7),
('Gest�o de Pessoas no Setor P�blico', 2, '14:50', 1, 'Quinta-feira', 4, 7),
('Direito Administrativo', 4, '13:00', 1, 'Sexta-feira', 5, 7),
('�tica na Administra��o P�blica', 2, '14:50', 1, 'S�bado', 6, 7),
('Planejamento e Gest�o Estrat�gica', 4, '13:00', 2, 'Segunda-feira', 7, 7),
('Administra��o de Recursos Humanos no Setor P�blico', 2, '14:50', 2, 'Ter�a-feira', 8, 7),
('Licita��es e Contratos Administrativos', 4, '13:00', 2, 'Quarta-feira', 9, 7),
('Gest�o da Qualidade no Setor P�blico', 2, '14:50', 2, 'Quinta-feira', 10, 7),
('Legisla��o Tribut�ria Municipal', 4, '13:00', 2, 'Sexta-feira', 11, 7),
('Gest�o Ambiental no Setor P�blico', 2, '14:50', 2, 'S�bado', 12, 7),
('Desenvolvimento Econ�mico e Social', 4, '13:00', 3, 'Segunda-feira', 13, 7),
('Elabora��o e Avalia��o de Projetos Sociais', 2, '14:50', 3, 'Ter�a-feira', 14, 7),
('Contabilidade P�blica', 4, '13:00', 3, 'Quarta-feira', 15, 7),
('Marketing Governamental', 2, '14:50', 3, 'Quinta-feira', 16, 7),
('Gest�o de Crises e Emerg�ncias', 4, '13:00', 3, 'Sexta-feira', 17, 7),
('Governan�a e Transpar�ncia', 2, '14:50', 3, 'S�bado', 18, 7),
('Gest�o de Projetos no Setor P�blico', 4, '13:00', 4, 'Segunda-feira', 19, 7),
('Gest�o da Inova��o no Setor P�blico', 2, '14:50', 4, 'Ter�a-feira', 20, 7),
('Pol�ticas P�blicas de Sa�de', 4, '13:00', 4, 'Quarta-feira', 21, 7),
('Pol�ticas Educacionais', 2, '14:50', 4, 'Quinta-feira', 22, 7),
('Planejamento Urbano e Regional', 4, '13:00', 4, 'Sexta-feira', 23, 7),
('Gest�o de Servi�os P�blicos', 2, '14:50', 4, 'S�bado', 24, 7),
('�tica e Responsabilidade Social', 4, '13:00', 5, 'Segunda-feira', 25, 7),
('Comunica��o no Setor P�blico', 2, '14:50', 5, 'Ter�a-feira', 26, 7),
('Or�amento P�blico', 4, '13:00', 5, 'Quarta-feira', 27, 7),
('Pol�ticas de Seguran�a P�blica', 2, '14:50', 5, 'Quinta-feira', 28, 7),
('Gest�o de Tecnologia da Informa��o no Setor P�blico', 4, '13:00', 5, 'Sexta-feira', 29, 7),
('Pol�ticas de Assist�ncia Social', 2, '14:50', 5, 'S�bado', 30, 7),
('Direito Administrativo Avan�ado', 4, '13:00', 6, 'Segunda-feira', 31, 7),
('Gest�o de Conflitos e Negocia��o', 2, '14:50', 6, 'Ter�a-feira', 32, 7),
('Sustentabilidade e Responsabilidade Socioambiental', 4, '13:00', 6, 'Quarta-feira', 33, 7),
('Inova��o e Governo Aberto', 2, '14:50', 6, 'Quinta-feira', 34, 7),
('Direito e Legisla��o Aplicada � Administra��o P�blica', 4, '13:00', 6, 'Sexta-feira', 35, 7),
('Pol�ticas Culturais e de Turismo', 2, '14:50', 6, 'S�bado', 36, 7);
GO
-- Disciplinas Curso 8
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Circuitos El�tricos I', 4, '13:00', 1, 'Segunda-feira', 1, 8),
('Eletromagnetismo', 2, '14:50', 1, 'Ter�a-feira', 2, 8),
('Eletr�nica Anal�gica I', 4, '13:00', 1, 'Quarta-feira', 3, 8),
('Programa��o para Engenharia', 2, '14:50', 1, 'Quinta-feira', 4, 8),
('C�lculo I', 4, '13:00', 1, 'Sexta-feira', 5, 8),
('Introdu��o � Engenharia El�trica', 2, '14:50', 1, 'S�bado', 6, 8),
('Circuitos El�tricos II', 4, '13:00', 2, 'Segunda-feira', 7, 8),
('Eletr�nica Anal�gica II', 2, '14:50', 2, 'Ter�a-feira', 8, 8),
('M�quinas El�tricas', 4, '13:00', 2, 'Quarta-feira', 9, 8),
('C�lculo II', 2, '14:50', 2, 'Quinta-feira', 10, 8),
('F�sica Aplicada � Engenharia', 4, '13:00', 2, 'Sexta-feira', 11, 8),
('Desenho T�cnico', 2, '14:50', 2, 'S�bado', 12, 8),
('Instala��es El�tricas', 4, '13:00', 3, 'Segunda-feira', 13, 8),
('Controle e Automa��o', 2, '14:50', 3, 'Ter�a-feira', 14, 8),
('Materiais El�tricos', 4, '13:00', 3, 'Quarta-feira', 15, 8),
('Equa��es Diferenciais', 2, '14:50', 3, 'Quinta-feira', 16, 8),
('Teoria Eletromagn�tica', 4, '13:00', 3, 'Sexta-feira', 17, 8),
('F�sica III', 2, '14:50', 3, 'S�bado', 18, 8),
('Sistemas de Energia', 4, '13:00', 4, 'Segunda-feira', 19, 8),
('Eletr�nica de Pot�ncia', 2, '14:50', 4, 'Ter�a-feira', 20, 8),
('Eletromagnetismo Aplicado', 4, '13:00', 4, 'Quarta-feira', 21, 8),
('M�todos Num�ricos', 2, '14:50', 4, 'Quinta-feira', 22, 8),
('Sinais e Sistemas', 4, '13:00', 4, 'Sexta-feira', 23, 8),
('Mec�nica dos Fluidos', 2, '14:50', 4, 'S�bado', 24, 8),
('Prote��o de Sistemas El�tricos', 4, '13:00', 5, 'Segunda-feira', 25, 8),
('Sistemas Digitais', 2, '14:50', 5, 'Ter�a-feira', 26, 8),
('Convers�o de Energia', 4, '13:00', 5, 'Quarta-feira', 27, 8),
('Economia de Energia', 2, '14:50', 5, 'Quinta-feira', 28, 8),
('Engenharia Econ�mica', 4, '13:00', 5, 'Sexta-feira', 29, 8),
('Controle de Processos', 2, '14:50', 5, 'S�bado', 30, 8),
('Subesta��es El�tricas', 4, '13:00', 6, 'Segunda-feira', 31, 8),
('Efici�ncia Energ�tica', 2, '14:50', 6, 'Ter�a-feira', 32, 8),
('Automa��o Industrial', 4, '13:00', 6, 'Quarta-feira', 33, 8),
('Redes de Comunica��o', 2, '14:50', 6, 'Quinta-feira', 34, 8),
('Projeto Integrado de Engenharia El�trica', 4, '13:00', 6, 'Sexta-feira', 35, 8),
('Trabalho de Conclus�o de Curso', 2, '14:50', 6, 'S�bado', 36, 8);
GO
-- Disciplinas Curso 9

INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Gastronomia', 4, '13:00', 1, 'Segunda-feira', 1, 9),
('Higiene e Seguran�a Alimentar', 2, '14:50', 1, 'Ter�a-feira', 2, 9),
('T�cnicas B�sicas de Culin�ria', 4, '13:00', 1, 'Quarta-feira', 3, 9),
('Gastronomia Brasileira', 2, '14:50', 1, 'Quinta-feira', 4, 9),
('Hist�ria da Gastronomia', 4, '13:00', 1, 'Sexta-feira', 5, 9),
('Nutri��o e Diet�tica', 2, '14:50', 1, 'S�bado', 6, 9),
('T�cnicas de Confeitaria', 4, '13:00', 2, 'Segunda-feira', 7, 9),
('Panifica��o', 2, '14:50', 2, 'Ter�a-feira', 8, 9),
('Cozinha Internacional', 4, '13:00', 2, 'Quarta-feira', 9, 9),
('Gastronomia Molecular', 2, '14:50', 2, 'Quinta-feira', 10, 9),
('Gest�o de Restaurantes e Bares', 4, '13:00', 2, 'Sexta-feira', 11, 9),
('Enologia', 2, '14:50', 2, 'S�bado', 12, 9), 
('Gastronomia Asi�tica', 4, '13:00', 3, 'Segunda-feira', 13, 9),
('Gastronomia Italiana', 2, '14:50', 3, 'Ter�a-feira', 14, 9),
('Gastronomia Francesa', 4, '13:00', 3, 'Quarta-feira', 15, 9),
('Gastronomia Espanhola', 2, '14:50', 3, 'Quinta-feira', 16, 9),
('Gastronomia Regional Brasileira', 4, '13:00', 3, 'Sexta-feira', 17, 9),
('Arte Culin�ria', 2, '14:50', 3, 'S�bado', 18, 9),
('Gastronomia Contempor�nea', 4, '13:00', 4, 'Segunda-feira', 19, 9),
('Gastronomia Molecular Avan�ada', 2, '14:50', 4, 'Ter�a-feira', 20, 9),
('Gastronomia Funcional', 4, '13:00', 4, 'Quarta-feira', 21, 9),
('Gastronomia Sustent�vel', 2, '14:50', 4, 'Quinta-feira', 22, 9),
('Gastronomia Cultural', 4, '13:00', 4, 'Sexta-feira', 23, 9),
('Empreendedorismo na Gastronomia', 2, '14:50', 4, 'S�bado', 24, 9),
('Gest�o de Custos em Gastronomia', 4, '13:00', 5, 'Segunda-feira', 25, 9),
('Gest�o de Qualidade em Servi�os de Alimenta��o', 2, '14:50', 5, 'Ter�a-feira', 26, 9),
('Gastronomia de Eventos', 4, '13:00', 5, 'Quarta-feira', 27, 9),
('Gastronomia Hospitalar', 2, '14:50', 5, 'Quinta-feira', 28, 9),
('Gastronomia Social e Comunit�ria', 4, '13:00', 5, 'Sexta-feira', 29, 9),
('Marketing Gastron�mico', 2, '14:50', 5, 'S�bado', 30, 9),
('Cozinha Internacional Avan�ada', 4, '13:00', 6, 'Segunda-feira', 31, 9),
('Gastronomia Molecular Avan�ada II', 2, '14:50', 6, 'Ter�a-feira', 32, 9),
('Gastronomia Criativa', 4, '13:00', 6, 'Quarta-feira', 33, 9),
('Cozinha Funcional', 2, '14:50', 6, 'Quinta-feira', 34, 9),
('Gastronomia Esportiva', 4, '13:00', 6, 'Sexta-feira', 35, 9),
('Planejamento de Card�pios', 2, '14:50', 6, 'S�bado', 36, 9);
GO
-- Disciplinas Curso 10
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Arquitetura', 4, '13:00', 1, 'Segunda-feira', 1, 10),
('Hist�ria da Arte', 2, '14:50', 1, 'Ter�a-feira', 2, 10),
('Desenho Arquitet�nico I', 4, '13:00', 1, 'Quarta-feira', 3, 10),
('Teoria da Arquitetura', 2, '14:50', 1, 'Quinta-feira', 4, 10),
('Geometria Descritiva', 4, '13:00', 1, 'Sexta-feira', 5, 10),
('Inform�tica Aplicada � Arquitetura', 2, '14:50', 1, 'S�bado', 6, 10),
('Constru��o Civil I', 4, '13:00', 2, 'Segunda-feira', 7, 10),
('Desenho Arquitet�nico II', 2, '14:50', 2, 'Ter�a-feira', 8, 10),
('Sociologia Urbana', 4, '13:00', 2, 'Quarta-feira', 9, 10),
('Topografia', 2, '14:50', 2, 'Quinta-feira', 10, 10),
('C�lculo Estrutural', 4, '13:00', 2, 'Sexta-feira', 11, 10),
('Est�tica e Paisagismo', 2, '14:50', 2, 'S�bado', 12, 10), 
('Constru��o Civil II', 4, '13:00', 3, 'Segunda-feira', 13, 10),
('Desenho Arquitet�nico III', 2, '14:50', 3, 'Ter�a-feira', 14, 10),
('Ecologia Urbana', 4, '13:00', 3, 'Quarta-feira', 15, 10),
('Materiais de Constru��o', 2, '14:50', 3, 'Quinta-feira', 16, 10),
('Estruturas de Concreto', 4, '13:00', 3, 'Sexta-feira', 17, 10),
('Projeto Arquitet�nico I', 2, '14:50', 3, 'S�bado', 18, 10),
('Instala��es Prediais', 4, '13:00', 4, 'Segunda-feira', 19, 10),
('Desenho Arquitet�nico IV', 2, '14:50', 4, 'Ter�a-feira', 20, 10),
('Planejamento Urbano', 4, '13:00', 4, 'Quarta-feira', 21, 10),
('Sistemas Estruturais', 2, '14:50', 4, 'Quinta-feira', 22, 10),
('Legisla��o Urbana', 4, '13:00', 4, 'Sexta-feira', 23, 10),
('Projeto Arquitet�nico II', 2, '14:50', 4, 'S�bado', 24, 10),
('Conforto Ambiental', 4, '13:00', 5, 'Segunda-feira', 25, 10),
('Desenho Assistido por Computador', 2, '14:50', 5, 'Ter�a-feira', 26, 10),
('Patrim�nio Hist�rico', 4, '13:00', 5, 'Quarta-feira', 27, 10),
('Projeto de Interiores', 2, '14:50', 5, 'Quinta-feira', 28, 10),
('Planejamento de Espa�os Urbanos', 4, '13:00', 5, 'Sexta-feira', 29, 10),
('Projeto de Urbanismo', 2, '14:50', 5, 'S�bado', 30, 10),
('Arquitetura Sustent�vel', 4, '13:00', 6, 'Segunda-feira', 31, 10),
('Projeto de Arquitetura III', 2, '14:50', 6, 'Ter�a-feira', 32, 10),
('Legisla��o e �tica Profissional', 4, '13:00', 6, 'Quarta-feira', 33, 10),
('Trabalho de Conclus�o de Curso I', 2, '14:50', 6, 'Quinta-feira', 34, 10),
('Gest�o de Projetos em Arquitetura', 4, '13:00', 6, 'Sexta-feira', 35, 10),
('Trabalho de Conclus�o de Curso II', 2, '14:50', 6, 'S�bado', 36, 10);
GO
-- Disciplinas Curso 11
INSERT INTO disciplina (nome, horasSemanais, horarioInicio, semestre, diaSemana, codigoProfessor, codigoCurso)
VALUES 
('Introdu��o � Programa��o', 4, '13:00', 1, 'Segunda-feira', 1, 11),
('Matem�tica Discreta', 2, '14:50', 1, 'Ter�a-feira', 2, 11),
('Algoritmos e Estrutura de Dados', 4, '13:00', 1, 'Quarta-feira', 3, 11),
('L�gica de Programa��o', 2, '14:50', 1, 'Quinta-feira', 4, 11),
('Banco de Dados', 4, '13:00', 1, 'Sexta-feira', 5, 11),
('Comunica��o e Express�o', 2, '14:50', 1, 'S�bado', 6, 11), 
('Programa��o Orientada a Objetos', 4, '13:00', 2, 'Segunda-feira', 7, 11),
('Estrutura de Dados Avan�ada', 2, '14:50', 2, 'Ter�a-feira', 8, 11),
('Desenvolvimento Web', 4, '13:00', 2, 'Quarta-feira', 9, 11),
('Redes de Computadores', 2, '14:50', 2, 'Quinta-feira', 10, 11),
('Engenharia de Software', 4, '13:00', 2, 'Sexta-feira', 11, 11),
('�tica e Legisla��o em Inform�tica', 2, '14:50', 2, 'S�bado', 12, 11),
('Desenvolvimento Mobile', 4, '13:00', 3, 'Segunda-feira', 13, 11),
('Sistemas Operacionais', 2, '14:50', 3, 'Ter�a-feira', 14, 11),
('An�lise e Projeto de Sistemas', 4, '13:00', 3, 'Quarta-feira', 15, 11),
('Gest�o de Projetos de TI', 2, '14:50', 3, 'Quinta-feira', 16, 11),
('Seguran�a da Informa��o', 4, '13:00', 3, 'Sexta-feira', 17, 11),
('Ingl�s T�cnico', 2, '14:50', 3, 'S�bado', 18, 11),
('Intelig�ncia Artificial', 4, '13:00', 4, 'Segunda-feira', 19, 11),
('Gest�o da Qualidade de Software', 2, '14:50', 4, 'Ter�a-feira', 20, 11),
('Teste de Software', 4, '13:00', 4, 'Quarta-feira', 21, 11),
('Governan�a de TI', 2, '14:50', 4, 'Quinta-feira', 22, 11),
('Empreendedorismo', 4, '13:00', 4, 'Sexta-feira', 23, 11),
('Projeto Integrador I', 2, '14:50', 4, 'S�bado', 24, 11), 
('Desenvolvimento de Jogos', 4, '13:00', 5, 'Segunda-feira', 25, 11),
('Big Data', 2, '14:50', 5, 'Ter�a-feira', 26, 11),
('Computa��o em Nuvem', 4, '13:00', 5, 'Quarta-feira', 27, 11),
('Programa��o Funcional', 2, '14:50', 5, 'Quinta-feira', 28, 11),
('Modelagem de Dados', 4, '13:00', 5, 'Sexta-feira', 29, 11),
('Projeto Integrador II', 2, '14:50', 5, 'S�bado', 30, 11),
('Blockchain', 4, '13:00', 6, 'Segunda-feira', 31, 11),
('DevOps', 2, '14:50', 6, 'Ter�a-feira', 32, 11),
('Arquitetura de Software', 4, '13:00', 6, 'Quarta-feira', 33, 11),
('Desenvolvimento �gil de Software', 2, '14:50', 6, 'Quinta-feira', 34, 11),
('Trabalho de Conclus�o de Curso I', 4, '13:00', 6, 'Sexta-feira', 35, 11),
('Trabalho de Conclus�o de Curso II', 2, '14:50', 6, 'S�bado', 36, 11);
GO
INSERT INTO matricula (codigo, codigoAluno, dataMatricula, semestre)
VALUES
(1, '55312103020', '2022-01-10', 1),
(2, '55312103020', '2022-07-28', 2),
(3, '86462326034', '2024-01-28', 1),
(4, '86462326034', '2024-07-28', 2),
(5, '39112829072', '2025-03-28', 1),
(6, '39112829072', '2024-03-28', 2),
(7, '39590327060', '2024-03-28', 1),
(8, '39590327060', '2021-01-1', 2),
(9, '39590327060', '2021-07-28', 3);
GO
INSERT INTO matriculaDisciplina (CodigoMatricula, codigoDisciplina, situacao, notaFinal)
VALUES
(1,1001,'Aprovado', 8.5),
(1,1002,'Reprovado', 5.0),
(1,1003,'Aprovado', 7.2),
(2,1001,'Reprovado', 4.8),
(2,1002,'Aprovado', 9.0),
(2,1003,'Reprovado', 6.5),
(3,1001,'Aprovado', 8.0),
(4,1002, 'Reprovado', 4.0),
(4,1003, 'Aprovado', 7.8),
(5,1001, 'Reprovado', 3.5);
GO
INSERT INTO conteudo VALUES 
    (1, '�lgebra', 'Estudo dos n�meros e opera��es', 1003),
    (2, 'Geometria', 'Estudo das formas e dos espa�os', 1003),
    (3, 'C�lculo Diferencial', 'Estudo das taxas de varia��o', 1003),
    (4, 'C�lulas', 'Unidades b�sicas da vida', 1005),
    (5, 'Energia', 'Capacidade de realizar trabalho', 1005),
    (6, 'Evolu��o', 'Desenvolvimento das esp�cies ao longo do tempo', 1005),
    (7, 'Idade M�dia', 'Per�odo hist�rico entre os s�culos V e XV', 1001),
    (8, 'Revolu��o Industrial', 'Transforma��es econ�micas e sociais no s�culo XVIII', 1001),
    (9, 'Descobrimento do Brasil', 'Chegada dos portugueses em 1500', 1002),
    (10, 'Relevo Brasileiro', 'Caracter�sticas geogr�ficas do pa�s', 1002),
    (11, 'Literatura Brasileira', 'Produ��es liter�rias do Brasil', 1004),
    (12, 'Gram�tica', 'Estudo da estrutura e funcionamento da l�ngua', 1004),
    (13, 'Equa��es', 'Express�es matem�ticas com inc�gnitas', 1003),
    (14, 'Fisiologia', 'Estudo das fun��es dos organismos vivos', 1005),
    (15, 'Guerra Fria', 'Conflito pol�tico entre EUA e URSS', 1005),
    (16, 'Globaliza��o', 'Integra��o econ�mica e cultural mundial', 1004),
    (17, 'Morfologia', 'Estudo da estrutura das palavras', 1004),
    (18, 'Polin�mios', 'Express�es alg�bricas com v�rias vari�veis',1004),
    (19, 'Gen�tica', 'Estudo dos genes e hereditariedade', 1003),
    (20, 'Renascimento', 'Movimento cultural e art�stico do s�culo XVI', 1004);
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
            SET @saida = 'Titula��o inv�lida'
            RETURN
        END
        
        IF EXISTS (SELECT 1 FROM professor WHERE codigo = @codigo)
        BEGIN
            SET @saida = 'C�digo de professor j� existe.'
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
            SET @saida = 'Titula��o inv�lida'
            RETURN
        END
        
        UPDATE professor SET nome = @nome, titulacao = @titulacao WHERE codigo = @codigo
        SET @saida = 'Professor alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DECLARE @count INT
        -- Verificar se h� disciplinas associadas a esse professor
        SELECT @count = COUNT(*) FROM disciplina WHERE codigoProfessor = @codigo
        
        -- Se houver disciplinas associadas, emitir uma mensagem e n�o excluir o professor
        IF @count > 0
        BEGIN
            SET @saida = 'Este professor est� associado a disciplinas e n�o pode ser exclu�do.'
            RETURN
        END
        
        DELETE FROM professor WHERE codigo = @codigo
        SET @saida = 'Professor exclu�do com sucesso'
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

    -- Verificar se o c�digo � v�lido
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
            RAISERROR('C�digo de curso inv�lido', 16, 1)
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
            RAISERROR('C�digo de curso inv�lido', 16, 1)
            RETURN
        END
    END
    ELSE BEGIN
    IF (@acao = 'D')
    BEGIN
        -- Verificar se existem disciplinas associadas a este curso
        IF EXISTS (SELECT 1 FROM disciplina WHERE codigoCurso = @codigo)
        BEGIN
            SET @saida = 'N�o � poss�vel excluir o curso pois existem disciplinas associadas a ele.';
            RETURN;
        END;

        DELETE FROM curso WHERE codigo = @codigo;
        SET @saida = 'Curso exclu�do com sucesso.';
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

    SET @valido = 0; -- Inicializa como inv�lido por padr�o

    -- Verifica��o se o CPF cont�m apenas d�gitos num�ricos
    IF @CPF NOT LIKE '%[^0-9]%' AND @CPF NOT IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999')
    BEGIN
        -- C�lculo do primeiro d�gito verificador
        SET @soma = 0;
        SET @i = 10;
        WHILE @i >= 2
        BEGIN
            SET @soma = @soma + (CAST(SUBSTRING(@CPF, 11 - @i, 1) AS INT) * @i);
            SET @i = @i - 1;
        END;
        SET @resto = @soma % 11;
        SET @primeiroDigito = IIF(@resto < 2, 0, 11 - @resto);

        -- C�lculo do segundo d�gito verificador
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

        -- Verifica��o dos d�gitos verificadores
        IF LEN(@CPF) = 11 AND SUBSTRING(@CPF, 10, 1) = CAST(@primeiroDigito AS NVARCHAR(1)) AND SUBSTRING(@CPF, 11, 1) = CAST(@segundoDigito AS NVARCHAR(1))
        BEGIN
            SET @valido = 1; -- CPF v�lido
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
        SET @valido = 0; -- Idade inv�lida
    END
    ELSE
    BEGIN
        SET @valido = 1; -- Idade v�lida
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
        SET @saida = 'Aluno n�o encontrado.';
        RETURN;
    END;

    -- Validar CPF
    EXEC sp_validaCPF @CPF, @validoCPF OUTPUT;

    IF @validoCPF = 0
    BEGIN
        SET @saida = 'CPF inv�lido.';
        RETURN;
    END;

    -- Validar Idade
    EXEC sp_ValidarIdade @dataNascimento, @validoIdade OUTPUT;

    IF @validoIdade = 0
    BEGIN
        SET @saida = 'Idade inv�lida para ingresso.';
        RETURN;
    END;

    -- Calcular data limite de gradua��o
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
        SET @saida = 'Opera��o inv�lida.';
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
        -- Excluir os conte�dos relacionados � disciplina
        DELETE FROM conteudo WHERE codigoDisciplina = @codigo
        
        -- Em seguida, excluir a disciplina
        DELETE FROM disciplina WHERE codigo = @codigo
        
        SET @saida = 'Disciplina exclu�da com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
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
        SET @saida = 'Conte�do inserido com sucesso'
    END
    ELSE IF (@acao = 'U')
    BEGIN
        UPDATE conteudo 
        SET nome = @nome, descricao = @descricao, codigoDisciplina = @codigoDisciplina
        WHERE codigo = @codigo
        SET @saida = 'Conte�do alterado com sucesso'
    END
    ELSE IF (@acao = 'D')
    BEGIN
        DELETE FROM conteudo WHERE codigo = @codigo
        SET @saida = 'Conte�do exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
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
        SET @saida = 'Per�odo de matr�cula alterado com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Datas inv�lidas', 16, 1)
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
		RAISERROR('Um ou mais hor�rios de disciplinas apresentam conflitos', 16, 1)
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
        SET @saida = 'Telefone exclu�do com sucesso'
    END
    ELSE
    BEGIN
        RAISERROR('Opera��o inv�lida', 16, 1)
        RETURN
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
