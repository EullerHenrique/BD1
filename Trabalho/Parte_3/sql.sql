
CREATE SCHEMA CONTROLE_VACINA;

SET search_path TO CONTROLE_VACINA;
SET datestyle to dmy;

CREATE TABLE PESSOA(

	cpf VARCHAR(11),
	nro_cadastro_sus VARCHAR(15),
	nome VARCHAR(70) NOT NULL,
	endereco VARCHAR(200) NOT NULL,
	email VARCHAR(40) NOT NULL,
	nome_pai VARCHAR(70) NOT NULL,
	nome_mae VARCHAR(70) NOT NULL,
	data_nascimento DATE NOT NULL,
	
	CONSTRAINT PESSOA_PK PRIMARY KEY (CPF)

);

CREATE TABLE PACIENTE (

	cpf VARCHAR(11),
	profissao VARCHAR(40) NOT NULL,

	CONSTRAINT PACIENTE_PK_CPF PRIMARY KEY(cpf),
	CONSTRAINT PACIENTE_FK_CPF FOREIGN KEY (cpf) REFERENCES PESSOA(cpf) 

);

CREATE TABLE PROFISSIONAL_DE_SAUDE (

	cpf VARCHAR(11),
	nro_coren VARCHAR(19) NOT NULL,

	CONSTRAINT PROFISSIONAL_DE_SAUDE_PK_CPF PRIMARY KEY(cpf),
	CONSTRAINT PROFISSIONAL_DE_SAUDE_FK_CPF FOREIGN KEY(cpf) REFERENCES PESSOA(cpf)

);

CREATE SEQUENCE FASE_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE FASE_DE_VACINACAO(
	
	nro SMALLINT DEFAULT nextval(LOWER('FASE_INCREMENT')),
	data_inicial DATE NOT NULL,
	data_final DATE NOT NULL,
	idade_minima SMALLINT NOT NULL,
	grupo_prioritario VARCHAR(50),
	
	CONSTRAINT FASE_DE_VACINACAO_PK_NRO PRIMARY KEY (nro)
);


CREATE SEQUENCE FILA_V_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE FILA_DE_VACINACAO (

	id INT DEFAULT nextval(LOWER('FILA_V_INCREMENT')),
	descricao VARCHAR(100) NOT NULL,
	nro INT,

	CONSTRAINT FILA_DE_VACINACAO_PK_ID PRIMARY KEY(id),
	CONSTRAINT FILA_DE_VACINACAO_FK_NRO FOREIGN KEY(nro) REFERENCES FASE_DE_VACINACAO(nro) 

);

CREATE TABLE INGRESSA (

	cpf VARCHAR(11),
	id INT,
	data DATE NOT NULL,
	hora TIME NOT NULL,

	CONSTRAINT INGRESSA_PK_CPF PRIMARY KEY(cpf),
	CONSTRAINT INGRESSA_FK_CPF FOREIGN KEY(cpf) REFERENCES PACIENTE(cpf),
	CONSTRAINT INGRESSA_FK_ID FOREIGN KEY(id) REFERENCES FILA_DE_VACINACAO(id)

);

CREATE TABLE TELEFONE( 

	cpf VARCHAR(11),
	telefone VARCHAR(20) NOT NULL,

	CONSTRAINT TELEFONE_PK_CPF_TELEFONE PRIMARY KEY (cpf, telefone),
	CONSTRAINT TELEFONE_FK_CPF FOREIGN KEY (cpf) REFERENCES PESSOA

);

CREATE SEQUENCE LOCAL_A_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE LOCAL_DE_APLICACAO (

	id_l_a INT DEFAULT nextval(LOWER('LOCAL_A_INCREMENT')),
	nome VARCHAR(100) NOT NULL,
	endereco VARCHAR(150) NOT NULL,
	telefone VARCHAR(20) NOT NULL,

	CONSTRAINT LOCAL_DE_APLICACAO_PK_ID_l_A PRIMARY KEY(id_l_a)
);

CREATE SEQUENCE AGENDAMENTO_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE AGENDAMENTO(
	
	id_agendamento INT DEFAULT nextval(LOWER('AGENDAMENTO_INCREMENT')),
	data DATE NOT NULL,
	horario TIME NOT NULL,
	dose SMALLINT NOT NULL,
	confirmacao_aplicacao BOOLEAN NOT NULL,
	cpf_paciente VARCHAR(11),
	id_l_a INT,
	
	CONSTRAINT AGENDAMENTO_PK_ID_AGENDAMENTO PRIMARY KEY (id_agendamento),
	CONSTRAINT AGENDAMENTO_FK_ID_l_A FOREIGN KEY (id_l_a) REFERENCES LOCAL_DE_APLICACAO (id_l_a),
	CONSTRAINT AGENDAMENTO_FK_CPF_PACIENTE FOREIGN KEY (cpf_paciente) REFERENCES PACIENTE (cpf)
);

CREATE TABLE ATENDE(
	
id_agendamento INT,
cpf VARCHAR(11),

CONSTRAINT ATENDE_PK_ID_AGENDAMENTO  PRIMARY KEY (id_agendamento),
CONSTRAINT ATENDE_FK_ID_AGENDAMENTO FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO,
CONSTRAINT ATENDE_FK_CPF FOREIGN KEY (cpf) REFERENCES PESSOA
);

CREATE TABLE VACINA(

	nome_vacina VARCHAR(70),
	desenvolvedor VARCHAR(80) NOT NULL,
	pais_origem VARCHAR(50) NOT NULL,
	eficacia DECIMAL(5, 2) NOT NULL,	
	registro_anvisa VARCHAR(10) NOT NULL,
	data_aprovacao DATE NOT NULL,
	nro_aplicacoes SMALLINT NOT NULL CHECK (nro_aplicacoes >= 0),
	
	CONSTRAINT VACINA_PK_NOME_VACINA PRIMARY KEY (nome_vacina)
);

CREATE SEQUENCE LOTE_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE LOTE(

	nome_vacina VARCHAR(70) UNIQUE,
	nro_lote INT DEFAULT nextval(LOWER('LOTE_INCREMENT')) UNIQUE,
	data_fabricacao DATE NOT NULL,
	data_validade DATE NOT NULL,
	data_recebimento DATE NOT NULL,
	qtd_doses INT NOT NULL CHECK (qtd_doses >= 0),
	custo_doses DECIMAL(5,2) NOT NULL,
	
	CONSTRAINT LOTE_PK_NOME_VACINA__NRO_LOTE  PRIMARY KEY (nome_vacina, nro_lote),
	CONSTRAINT LOTE_FK_NOME_VACINA  FOREIGN KEY (nome_vacina) REFERENCES VACINA(nome_vacina) 

);

CREATE TABLE POSSUI(

	id_agendamento INT,
	nro_lote INT,
	nome_vacina VARCHAR(70),

CONSTRAINT POSSUI_PK_ID_AGENDAMENTO  PRIMARY KEY (id_agendamento),
CONSTRAINT POSSUI_FK_ID_AGENDAMENTO  FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO(id_agendamento) ,
CONSTRAINT POSSUI_FK_NRO_LOTE FOREIGN KEY (nro_lote) REFERENCES LOTE(nro_lote), 
CONSTRAINT POSSUI_FK_NOME_VACINA FOREIGN KEY (nome_vacina) REFERENCES LOTE(nome_vacina) 
);

CREATE TABLE ENCAMINHADO (
	id_l_a INT,
	nro_lote INT,
	nome_vacina VARCHAR(70),
	qtd_doses INT NOT NULL,
	data DATE NOT NULL,

	CONSTRAINT ENCAMINHADO_PK_ID_l_a__NRO_LOTE__NOME_VACINA  PRIMARY KEY(id_l_a, nro_lote, nome_vacina),
	CONSTRAINT ENCAMINHADO_FK_ID_l_A FOREIGN KEY(id_l_a) REFERENCES LOCAL_DE_APLICACAO(id_l_a) ,
	CONSTRAINT ENCAMINHADO_FK_NRO_LOTE FOREIGN KEY(nro_lote) REFERENCES LOTE(nro_lote) ,
	CONSTRAINT ENCAMINHADO_FK_NOME_VACINA  FOREIGN KEY(nome_vacina) REFERENCES LOTE(nome_vacina)
);

CREATE SEQUENCE DOSE_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE DOSE (
	
	nome_vacina VARCHAR(70),
	nro_dose INT DEFAULT nextval(LOWER('DOSE_INCREMENT')),
	intervalo_aplicacao SMALLINT NOT NULL,

	CONSTRAINT DOSE_PK_NOME_VACINA__NRO_DOSE  PRIMARY KEY (nome_vacina, nro_dose),
	CONSTRAINT DOSE_FK_NOME_VACINA FOREIGN KEY (nome_vacina) REFERENCES VACINA(nome_vacina)
);

CREATE TABLE LABORATORIO_PARCEIRO(

	nome_vacina VARCHAR(70),
	nome_lab VARCHAR(70),
	
	CONSTRAINT LABORATORIO_PK_NOME_VACINA PRIMARY KEY (nome_vacina),
	CONSTRAINT LABORATORIO_FK_NOME_VACINA FOREIGN KEY (nome_vacina) REFERENCES VACINA(nome_vacina)
);

CREATE SEQUENCE BULA_INCREMENT INCREMENT 1 MINVALUE 1 START 1;
CREATE TABLE BULA (

	id_bula INT DEFAULT nextval(LOWER('BULA_INCREMENT')),
	apresentacao VARCHAR(500) NOT NULL,
	composicao VARCHAR(500) NOT NULL,
	indicacao VARCHAR(500) NOT NULL,
	funcionamento VARCHAR(500) NOT NULL,
	manuseio VARCHAR(500) NOT NULL,
	metodo_aplicacao VARCHAR(500) NOT NULL,
	instrucoes_esquecimento VARCHAR(500) NOT NULL,
	instrucoes_mal_uso VARCHAR(500) NOT NULL,
	nome_vacina VARCHAR(70) ,

	CONSTRAINT BULA_PK_ID_BULA PRIMARY KEY (id_bula),
	CONSTRAINT BULA_FK_NOME_VACINA FOREIGN KEY (nome_vacina) REFERENCES VACINA(nome_vacina)
);

CREATE TABLE EFEITO_COLATERAL (
	
	nome_e_c VARCHAR(100),
	prob_ocorrencia DECIMAL(5,2) NOT NULL,
	gravidade VARCHAR(20) NOT NULL,
	num_pessoas_afetadas INT NOT NULL,

	CONSTRAINT EFEITO_COLATERAL_PK_NOME_E_C PRIMARY KEY(nome_e_c)
);


CREATE TABLE CONTEM (
	nome_e_c VARCHAR(70),
	id_bula INT,

	CONSTRAINT CONTEM_PK_NOME_E_C  PRIMARY KEY(nome_e_c),
	CONSTRAINT CONTEM_FK_NOME_E_c FOREIGN KEY(nome_e_c) REFERENCES EFEITO_COLATERAL(nome_e_c) ,
	CONSTRAINT CONTEM_ID_BULA FOREIGN KEY(id_bula) REFERENCES BULA(id_bula) 
);

/* PESSOA */

/* 1 */
INSERT INTO PESSOA VALUES ('69810996080', '842795282370018', 'Filipe Semedo Fortunato', 'Rua Rio Danúbio, 1400,  Mansour, Uberlândia, MG', 'felipe_semedo@outlook.com', 'Estêvão Taborda Quintal', 'Rita Neto Ferraz', '09/04/1982');

/* 2 */
INSERT INTO PESSOA VALUES ('15866367076', '199659500890003', 'Filip Caldeira Saloio', 'Rua Raphael Lourenço, 500, Saraiva, Uberlândia, MG', 'filip_caldeira@gmail.com', 'Israel Macieira Barra', 'Sheila Grangeia Prado', '11/06/1983');
/* 3 */
INSERT INTO PESSOA VALUES ('49333082093', '296567098770003', 'Maimuna Gonçalves Diegues', 'Rua Couval, 1347, Morumbi, Uberlândia, MG', 'maimuna_golçalves@yahoo.com', 'Edgar Grangeia Bernardes','Cora Quaresma Mansilha', '09/11/2001');

/* 4 */
INSERT INTO PESSOA VALUES ('50914950029', '150339749040007', 'Amadeu Franca Caparica', 'Rua dos Miosótis, 678, Cidade Jardim, Uberlândia, MG', 'amadeu_franca@icloud.com', 'César Assunção Craveiro', 'Alana Fogaça Simas', '20/06/1981');

/* 5 */
INSERT INTO PESSOA VALUES ('21624082017', '158512812690007', 'Sancho Gago Canto', 'Rua E, 55, Granja Marileusa, Uberlândia, MG', 'sancho_gago@ufu.br', 'Rogério Ginjeira Lousã','Iriana Varejão Noleto', '05/10/1944');

/* 6 */
INSERT INTO PESSOA VALUES ('11976911036', '858511789760001', 'Anabel Fortunato Bandeira', 'Avenida Confederação do Equador, 560, Nossa Senhora das Graças, Uberlândia, MG', 'anabel_fortunato@uol.com', 'Kael Pereira Oleiro','Angela Nunes Gentil', '08/09/1943');

/* 7 */
INSERT INTO PESSOA VALUES ('27793074041', '836437431650009', 'César Guerreiro Lopes', 'Rua Itiocira, 456, Bela Vista, Uberlândia, MG', 'cesar_guerreiro@usp.com', 'José Sampaio Eiró','Yasmin Franca Pardo', '14/09/1942');

/* 8 */
INSERT INTO PESSOA VALUES ('61709896027', '895665402670007', 'Emilia Tabosa Albernaz', 'Rua Luiz Vieira Tavares, 956, Custódio Pereira, Uberlândia, MG', 'emilia_tabosa@outlook.com', 'Estevão Anes Vale', 'Celina Hipólito Benevides', '05/03/1951');

/* 9 */
INSERT INTO PESSOA VALUES ('86885803081', '812098530150001', 'Lunna Salvado Mainha', 'Rua Doutor Leopoldo de Castro, 567, Presidente Roosevelt, Uberlândia, MG', 'lunna_salvado@gmail.com', 'Adrián Lucas Marques', 'Ângela Varela Barata', '03/10/1963');

/* 10 */
INSERT INTO PESSOA VALUES ('67753532006', '795042553130008', 'Raquel Távora Vale', 'Praça Manoel Hipólito Dantas, 642, Tibery, Uberlândia, MG', 'raquel_tavora@yahoo.com', 'Keven Anes Benevides','Nídia Garcia Gaspar', '23/05/1964');

/* PACIENTE */

/* 1 */
INSERT INTO PACIENTE VALUES ('69810996080','Profissional de saúde');

/* 2 */
INSERT INTO PACIENTE VALUES ('15866367076','Profissional de saúde');

/* 3 */
INSERT INTO PACIENTE VALUES ('49333082093','Profissional de saúde');

/* 4 */
INSERT INTO PACIENTE VALUES ('50914950029','Profissional de saúde');

/* 5 */
INSERT INTO PACIENTE VALUES ('21624082017','Profissional de saúde');

/* 6 */
INSERT INTO PACIENTE VALUES ('11976911036','Profissional de saúde');

/* 7 */
INSERT INTO PACIENTE VALUES ('27793074041','Profissional de saúde');

/* 8 */
INSERT INTO PACIENTE VALUES ('61709896027','Profissional de saúde');

/* 9 */
INSERT INTO PACIENTE VALUES ('86885803081','Profissional de saúde');

/* 10 */
INSERT INTO PACIENTE VALUES ('67753532006','Profissional de saúde');

/* PROFISSIONAL DE SAÚDE */

/* 1 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('69810996080','COREN-MG 785.136-AE');

/* 2 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('15866367076','COREN-MG 123.456-AE');

/* 3 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('49333082093','COREN-MG 456.789-AE');

/* 4 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('50914950029','COREN-MG 543.123-AE');

/* 5 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('21624082017','COREN-MG 654.125-AE');

/* 6 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('11976911036','COREN-MG 258.726-AE');

/* 7 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('27793074041','COREN-MG 615.763-AE');

/* 8 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('61709896027','COREN-MG 926.348-AE');

/* 9 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('86885803081','COREN-MG 526.862-AE');

/* 10 */
INSERT INTO PROFISSIONAL_DE_SAUDE VALUES ('67753532006','COREN-MG 827.346-AE');

/* FASE DE VACINAÇÃO */

/* 1 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/01/2021', '01/02/2021', 100, 'Idosos');

/* 2 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/02/2021','01/03/2021', 90, 'Idosos');

/* 3 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/03/2021','01/04/2021',80, 'Idosos');

/* 4 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/04/2021','01/05/2021', 65, 'Idosos');

/* 5 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/05/2021','01/06/2021', 50, 'Adultos');

/* 6 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/06/2021','01/07/2021', 40, 'Adultos');

/* 7 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/07/2021','01/08/2021', 30, 'Adultos');

/* 8 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/08/2021','01/09/2021', 18, 'Adultos');

/* 9 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/09/2021','01/10/2021', 10, 'Pré adolescentes e adolescentes');

/* 10 */
INSERT INTO FASE_DE_VACINACAO VALUES (DEFAULT, '01/10/2021','01/12/2021', 1, 'Crianças');

/* FILA DE VACINAÇÃO */

/* 1 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Idosos, Idade prioritária: 100 anos',1);

/* 2 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Idosos, Idade prioritária: 90 anos',2);

/* 3 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Idosos, Idade prioritária: 80 anos',3);

/* 4 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Idosos, Idade prioritária: 65 anos',4);

/* 5 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Adultos, Idade prioritária: 50 anos',5);

/* 6 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Adultos, Idade prioritária: 40 anos',6);

/* 7 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Adultos, Idade prioritária: 30 anos',7);

/* 8 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Adultos, Idade prioritária: 18 anos',8);

/* 9 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'FGrupo prioritário: Pré Adolescentes e Adolescentes, Idade prioritária: 10 anos',9);

/* 10 */
INSERT INTO FILA_DE_VACINACAO VALUES (DEFAULT, 'Grupo prioritário: Crianças, Idade prioritária: 1 anos',10);

/* INGRESSA */

/* 1 */
INSERT INTO INGRESSA VALUES ('69810996080', 1, '13/01/2021', '8:00:00');

/* 2 */
INSERT INTO INGRESSA VALUES ('15866367076', 2, '02/02/2021', '9:00:00');

/* 3 */
INSERT INTO INGRESSA VALUES ('49333082093', 3, '02/03/2021', '10:00:00');

/* 4 */
INSERT INTO INGRESSA VALUES ('50914950029', 4, '02/04/2021', '11:00:00');

/* 5 */
INSERT INTO INGRESSA VALUES ('21624082017', 5, '02/05/2021', '12:00:00');

/* 6 */
INSERT INTO INGRESSA VALUES ('11976911036', 6,'02/06/2021', '13:00:00');

/* 7 */
INSERT INTO INGRESSA VALUES ('27793074041', 7, '02/07/2021', '14:00:00');

/* 8 */
INSERT INTO INGRESSA VALUES ('61709896027', 8, '02/08/2021', '15:00:00');

/* 9 */
INSERT INTO INGRESSA VALUES ('86885803081', 9, '02/09/2021', '16:00:00');

/* 10 */
INSERT INTO INGRESSA VALUES ('67753532006', 10,'02/11/2021', '17:00:00');

/* TELEFONE */

/* 1 */
INSERT INTO TELEFONE VALUES ('69810996080', '(34) 98878-8308');

/* 2 */
INSERT INTO TELEFONE VALUES ('15866367076', '(34) 99390-9269');

/* 3 */
INSERT INTO TELEFONE VALUES ('49333082093', '(34) 98513-9244');

/* 4 */
INSERT INTO TELEFONE VALUES ('50914950029', '(34) 98260-4520');

/* 5 */
INSERT INTO TELEFONE VALUES ('21624082017', '(34) 98131-8740');

/* 6 */
INSERT INTO TELEFONE VALUES ('11976911036', '(34) 99190-3586');

/* 7 */
INSERT INTO TELEFONE VALUES ('27793074041', '(34) 98283-8159');

/* 8 */
INSERT INTO TELEFONE VALUES ('61709896027', '(34) 99420-8403');

/* 9 */
INSERT INTO TELEFONE VALUES ('86885803081', '(34) 98101-3336');

/* 10 */
INSERT INTO TELEFONE VALUES ('67753532006', '(34) 98307-7593');

/* LOCAL_DE_APLICACAO */

/* 1 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Pampulha', 'Avenida João Naves de Ávila, 4.920, Uberlândia, MG','(34) 3211-8206');

/* 2 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Planalto', 'Rua do Engenheiro, 246, Uberlândia, MG', '(34) 3227-8010');

/* 3 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Luizote', 'Rua Mateus Vaz, 465, Uberlândia, MG', '(34) 3223-8043');

/* 4 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Martins', 'Avenida Belo Horizonte, 1.084, Uberlândia, MG', '(34) 3231-0016');

/* 5 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Morumbi', 'Avenida Felipe Calixto Milken, 47, Uberlândia, MG','(34) 3213-5682');

/* 6 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Roosevelt', 'Avenida Cesário Crosara, 4.000, Uberlândia, MG', '(34) 3254-8777');

/* 7 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI São Jorge', 'Avenida Toledo, 165, Uberlândia, MG','(34) 3227-2264');

/* 8 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UAI Tibery', 'Avenida Benjamim Magalhães, 1.115, Uberlândia, MG','(34) 3227-8060');

/* 9 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UBS Brasil', 'Rua Porto Alegre 140, Uberlândia, MG','(34) 3232-3722');

/* 10 */
INSERT INTO LOCAL_DE_APLICACAO VALUES (DEFAULT, 'UBS Tocantins', 'Av. Dr. Manoel Tomaz T. de Souza, 758, Uberlândia, MG','(34) 3232-3722');

/* AGENDAMENTO */

/* 1 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '01/01/2021', '9:00:00',  1, True, '69810996080', 1);

/* 2 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '21/01/2021', '10:00:00', 2, False, '69810996080', 2);

/* 3 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '01/02/2021', '11:00:00', 1, True, '15866367076', 3);

/* 4 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '21/02/2021', '12:00:00', 2, False, '15866367076', 4);

/* 5 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '01/03/2021', '13:00:00', 1, True, '49333082093', 5);

/* 6 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '21/03/2021', '14:00:00', 2, False, '49333082093', 6);

/* 7 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '01/04/2021', '15:00:00', 1, True, '50914950029', 7);

/* 8 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '21/04/2021', '16:00:00', 2, False, '50914950029', 8);

/* 9 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '01/05/2021', '17:00:00', 1, True, '21624082017', 9);

/* 10 */
INSERT INTO AGENDAMENTO VALUES (DEFAULT, '21/05/2021', '18:00:00', 2, False, '21624082017', 10);

/* ATENDE */

/* 1 */
INSERT INTO ATENDE VALUES (1, '11976911036');

/* 2 */
INSERT INTO ATENDE VALUES (2, '27793074041');

/* 3 */
INSERT INTO ATENDE VALUES (3, '61709896027');

/* 4 */
INSERT INTO ATENDE VALUES (4, '86885803081');

/* 5 */
INSERT INTO ATENDE VALUES (5, '67753532006');

/* 6 */
INSERT INTO ATENDE VALUES (6, '11976911036');

/* 7 */
INSERT INTO ATENDE VALUES (7, '27793074041');

/* 8 */
INSERT INTO ATENDE VALUES (8, '61709896027');

/* 9 */
INSERT INTO ATENDE VALUES (9, '86885803081');

/* 10 */
INSERT INTO ATENDE VALUES (10, '67753532006');

/* VACINA */

/* 1 */
INSERT INTO VACINA VALUES ('CoronaVac', 'Sinovac/Butantan','China',50.38,'7695718626', '01/10/2020', 2);

/* 2 */
INSERT INTO VACINA VALUES ('AZD1222','Oxford/AstraZeneca/Fiocruz', 'Reino Unido', 70.40, '35130072', '15/10/2020', 2);

/* 3 */
INSERT INTO VACINA VALUES ('Comirnaty', 'Pfizer/BioNTech','Alemanha e Estados Unidos', 95.00, '4391832005', '01/11/2020', 2);

/* 4 */
INSERT INTO VACINA VALUES ('mRNA-1273','Moderna', 'Estados Unidos', 94.10, '9358495022', '15/11/2020', 2);

/* 5 */
INSERT INTO VACINA VALUES ('Sputinik V','Instituto Gamaleya','Rússia', 91.60, '3957813953', '01/12/2020', 2);

/* 6 */
INSERT INTO VACINA VALUES ('Janssen Covid-19', 'Jannsen/Johnson & Johnson','Estados Unidos',66.00,'455607825','10/12/2020', 2);

/* 7 */
INSERT INTO VACINA VALUES ('EpiVacCorona', 'Novosibirsk Scientific Center Vecto','Rússia',100,'368146781','15/12/2020', 2);

/* 8 */
INSERT INTO VACINA VALUES ('NVX-CoV2373', 'Novavax','Austrália',96.40,'5592765277','18/12/2020', 2);

/* 9 */
INSERT INTO VACINA VALUES ('Covaxin','Bharat Biotech','Índia',81.00,'5705483054','19/12/2020', 2);

/* 10 */
INSERT INTO VACINA VALUES ('Sinopharm-Pequim', 'Sinopharm','China',79.30,'9680349728','20/12/2020', 2);

/* LOTE */

/* 1 */
INSERT INTO LOTE VALUES ('CoronaVac', DEFAULT, '5/10/2020', '5/12/2021', '10/10/2020', 110000, 10.00);

/* 2 */
INSERT INTO LOTE VALUES ('AZD1222', DEFAULT, '20/10/2021', '20/10/2022', '25/10/2020', 120000, 20.00);

/* 3 */
INSERT INTO LOTE VALUES ('Comirnaty', DEFAULT, '05/11/2021', '05/11/2022', '10/11/2020', 130000, 30.00);

/* 4 */
INSERT INTO LOTE VALUES ('mRNA-1273', DEFAULT, '20/11/2021', '20/11/2022', '25/11/2020', 140000, 40.00);

/* 5 */
INSERT INTO LOTE VALUES ('Sputinik V', DEFAULT, '05/12/2021', '05/12/2022', '10/12/2020', 150000, 50.00);

/* 6 */
INSERT INTO LOTE VALUES ('Janssen Covid-19', DEFAULT, '15/12/2021', '15/12/2022', '20/12/2020', 160000, 60.00);

/* 7 */
INSERT INTO LOTE VALUES ('EpiVacCorona', DEFAULT, '20/12/2021', '20/12/2022', '25/12/2020', 170000, 70.00);

/* 8 */
INSERT INTO LOTE VALUES ('NVX-CoV2373', DEFAULT, '25/12/2021', '25/12/2022', '30/12/2020', 180000, 80.00);

/* 9 */
INSERT INTO LOTE VALUES ('Covaxin', DEFAULT, '27/12/2021', '27/12/2022', '30/12/2020', 190000, 90.00);

/* 10 */
INSERT INTO LOTE VALUES ('Sinopharm-Pequim', DEFAULT, '31/12/2021', '31/12/2022', '01/01/2021', 200000, 100.00);

/* POSSUI */

/* 1 */
INSERT INTO POSSUI VALUES (1, 1, 'CoronaVac');

/* 2 */
INSERT INTO POSSUI VALUES (2, 2, 'AZD1222');

/* 3 */
INSERT INTO POSSUI VALUES (3, 3, 'Comirnaty');

/* 4 */
INSERT INTO POSSUI VALUES (4, 4, 'mRNA-1273');

/* 5 */
INSERT INTO POSSUI VALUES (5, 5, 'Sputinik V');

/* 6 */
INSERT INTO POSSUI VALUES (6, 6, 'Janssen Covid-19');

/* 7 */
INSERT INTO POSSUI VALUES (7, 7, 'EpiVacCorona');

/* 8 */
INSERT INTO POSSUI VALUES (8, 8, 'NVX-CoV2373');

/* 9 */
INSERT INTO POSSUI VALUES (9, 9, 'Covaxin');

/* 10 */
INSERT INTO POSSUI VALUES (10, 10, 'Sinopharm-Pequim');

/* ENCAMINHADO */

/* 1 */
INSERT INTO ENCAMINHADO VALUES (1, 1, 'CoronaVac', 50000, '01/01/2021');

/* 2 */
INSERT INTO ENCAMINHADO VALUES (2, 2, 'AZD1222', 60000, '02/01/2021');

/* 3 */
INSERT INTO ENCAMINHADO VALUES (3, 3, 'Comirnaty', 70000, '03/01/2021');

/* 4 */
INSERT INTO ENCAMINHADO VALUES (4, 4, 'mRNA-1273', 80000, '04/01/2021');

/* 5 */
INSERT INTO ENCAMINHADO VALUES (5, 5, 'Sputinik V', 90000, '05/01/2021');

/* 6 */
INSERT INTO ENCAMINHADO VALUES (6, 6, 'Janssen Covid-19', 100000, '06/01/2021');

/* 7 */
INSERT INTO ENCAMINHADO VALUES (7, 7, 'EpiVacCorona', 110000, '07/01/2021');

/* 8 */
INSERT INTO ENCAMINHADO VALUES (8, 8, 'NVX-CoV2373', 120000, '08/01/2021');

/* 9 */
INSERT INTO ENCAMINHADO VALUES (9, 9, 'Covaxin', 130000, '09/01/2021');

/* 10 */
INSERT INTO ENCAMINHADO VALUES (10, 10, 'Sinopharm-Pequim', 140000, '10/01/2021');

/* DOSE */

/* 1 */
INSERT INTO DOSE VALUES ('CoronaVac', DEFAULT, 20);

/* 2 */
INSERT INTO DOSE VALUES ('AZD1222', DEFAULT, 20);

/* 3 */
INSERT INTO DOSE VALUES ('Comirnaty', DEFAULT, 20);

/* 4 */
INSERT INTO DOSE VALUES ('mRNA-1273', DEFAULT, 20);

/* 5 */
INSERT INTO DOSE VALUES ('Sputinik V', DEFAULT, 20);

/* 6 */
INSERT INTO DOSE VALUES ('Janssen Covid-19', DEFAULT, 20);

/* 7 */
INSERT INTO DOSE VALUES ('EpiVacCorona', DEFAULT, 20);

/* 8 */
INSERT INTO DOSE VALUES ('NVX-CoV2373', DEFAULT, 20);

/* 9 */
INSERT INTO DOSE VALUES ('Covaxin', DEFAULT, 20);

/* 10 */
INSERT INTO DOSE VALUES ('Sinopharm-Pequim', DEFAULT, 20);

/* LABORATORIO_PARCEIRO */

/* 1 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('CoronaVac', 'Lab 1');

/* 2 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('AZD1222', 'Lab 2');

/* 3 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('Comirnaty',  'Lab 3');

/* 4 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('mRNA-1273', 'Lab 4');

/* 5 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('Sputinik V', 'Lab 5');

/* 6 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('Janssen Covid-19', 'Lab 6');

/* 7 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('EpiVacCorona', 'Lab 7');

/* 8 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('NVX-CoV2373', 'Lab 8');

/* 9 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('Covaxin', 'Lab 9');

/* 10 */
INSERT INTO LABORATORIO_PARCEIRO VALUES ('Sinopharm-Pequim', 'Lab 10');

/* BULA */

/* 1 */
INSERT INTO BULA VALUES (DEFAULT, 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ac lacus at lacus ornare mollis. Aenean venenatis finibus tempus. Vivamus id enim ligula. Phasellus hendrerit urna sit amet est consequat convallis in a dui. Sed sed dignissim erat. Cras rutrum iaculis elit, et pretium dolor fringilla quis. Integer rutrum dui maximus, tempus purus quis, vestibulum nunc. Proin quis hendrerit sapien, et auctor lacus. Ut eget suscipit magna, eget laoreet odio. Sed eros diam, rhoncus vel commodo ac leo.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis hendrerit lorem a purus accumsan facilisis. Integer laoreet nisl dui, ut bibendum dui hendrerit eget. Mauris vulputate justo sit amet auctor venenatis. Aliquam nec erat faucibus nunc dictum auctor. Fusce fringilla velit in mollis malesuada. Praesent laoreet purus quis urna convallis, id feugiat erat consectetur. Etiam eget imperdiet tellus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus pharetra.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque nec lacus tortor. Aliquam mollis porttitor tellus, a euismod orci tristique vel. Nullam et risus at libero lobortis porttitor. Suspendisse fermentum lorem sit amet felis sodales interdum. Nulla laoreet diam ac sodales imperdiet. Curabitur faucibus dolor accumsan turpis consequat venenatis. Vestibulum quis turpis ac erat blandit imperdiet. Nulla at est at risus feugiat ornare. Curabitur placerat metus id tincidunt orci aliquam.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tortor justo, dignissim in arcu ut, condimentum consectetur nibh. Ut quis nunc non enim aliquam placerat. Duis pharetra sapien id sem placerat, vitae posuere est tincidunt. Nulla venenatis risus justo, id dapibus ex efficitur nec. Nunc vulputate, orci ac eleifend malesuada, felis metus commodo libero, at tristique felis lorem et velit. Nam quis suscipit metus, et aliquam nisl. Maecenas sed felis sit amet est vulputate aliquam mauris.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc gravida risus eget felis hendrerit, non pulvinar odio accumsan. Suspendisse elementum dapibus nisi cursus dignissim. Phasellus pharetra, urna vitae egestas condimentum, nibh nulla egestas diam, at iaculis sapien mi quis neque. Ut ac blandit tortor. Aliquam et elit finibus, vulputate ex at, malesuada tellus. Vivamus scelerisque erat in lacinia porta. Maecenas a est mauris. Aenean tincidunt nisi ac malesuada pulvinar. Sed egestas donec.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In arcu nisi, auctor ac eros eu, lobortis commodo massa. Fusce aliquet, nunc sed pharetra tempor, turpis magna interdum justo, quis venenatis erat metus sed tortor. Aliquam ut sodales risus. Sed scelerisque vestibulum ante, et ultrices quam imperdiet tristique. Nam eros ex, vehicula eget enim vel, aliquet elementum eros. Nulla facilisi. Mauris ullamcorper porta sodales. Duis consequat velit volutpat eros pretium, et vestibulum mi volutpat.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam diam lacus, pellentesque eget ligula in, rhoncus bibendum nisl. Aliquam aliquam vel diam vel elementum. Etiam bibendum, neque sed aliquet interdum, nisi leo accumsan ante, eget feugiat mi nibh in dolor. Aliquam tristique leo id turpis ornare faucibus. Duis porttitor placerat sapien, feugiat cursus libero fringilla eu. Nulla auctor ipsum quam, accumsan porttitor mauris lacinia id. Curabitur elementum aliquam neque ut laoreet. In nec.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam imperdiet metus eu quam placerat congue. Integer vel ante quis lacus venenatis tincidunt et ut justo. Phasellus tempus eros eget suscipit sodales. Suspendisse non volutpat leo. Proin sit amet porttitor arcu. Praesent ultricies vulputate felis. Nulla nulla ligula, vulputate id viverra sit amet, semper nec tortor. Mauris hendrerit auctor ante, eget imperdiet ipsum. Nulla ex odio, commodo sed elementum eget, condimentum quis augue eros.', 
						 'CoronaVac');

/* 2 */
INSERT INTO BULA VALUES (DEFAULT, 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus porttitor turpis odio, vel pretium enim elementum id. Donec feugiat gravida neque, vitae posuere purus venenatis rhoncus. Donec eget tempus odio, eget finibus justo. Donec fringilla orci a velit dictum pharetra. Curabitur pulvinar, diam at suscipit gravida, lectus dui eleifend augue, in mollis nunc enim nec purus. Nulla eget diam tristique, lobortis nisi in, ultrices odio. Suspendisse luctus venenatis turpis sit amet pretium nam.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse accumsan auctor nisi, et fringilla erat tristique sit amet. Proin suscipit massa sollicitudin fermentum convallis. Morbi diam ante, imperdiet in quam sit amet, dignissim pharetra neque. Integer vel posuere est, ut imperdiet enim. Quisque semper urna sit amet arcu viverra cursus. Fusce cursus id magna a faucibus. Nullam ultrices purus gravida, condimentum urna eget, maximus risus. Maecenas nulla tortor, gravida id arcu pharetra.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet libero sollicitudin, pretium purus sed, ullamcorper nunc. Maecenas quis porttitor nisi. In ultricies orci sapien, nec suscipit ex ornare ac. Donec eget aliquam tellus. Nulla id risus egestas, lacinia lacus vitae, luctus lacus. Curabitur tincidunt diam lectus, eu tristique enim vehicula a. Suspendisse in purus id ipsum mattis venenatis et sit amet quam. Ut condimentum turpis neque, viverra sollicitudin augue vestibulum.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet sapien vitae urna ullamcorper fermentum. Sed venenatis accumsan eleifend. Quisque posuere ultrices sapien, sed accumsan lorem porttitor ut. Aliquam vel nulla sem. Cras interdum lacinia odio, non tristique nisi blandit sit amet. Integer ullamcorper vehicula elit, ut ornare velit ornare volutpat. In finibus egestas tortor, id tempor nulla viverra in. Donec felis justo, placerat non fermentum eget, dictum tincidunt accumsan.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque et fermentum quam, at semper velit. Nullam eget lacinia leo, ac tristique nisl. Aliquam efficitur tincidunt diam, eget imperdiet lectus pharetra ac. Donec laoreet libero a arcu efficitur, nec varius arcu ultrices. Nunc finibus aliquam eros sit amet semper. Morbi interdum, nulla quis efficitur varius, lacus enim tincidunt nulla, a sollicitudin lorem arcu gravida nisi. Nam eget justo arcu. Nulla hendrerit odio non ipsum facilisis eu.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque interdum diam et arcu ultrices aliquet a ac quam. Mauris velit purus, vehicula aliquet sapien in, tempus faucibus ex. Fusce non orci pulvinar, feugiat ex at, vehicula nisi. Duis vitae egestas elit, sit amet porta magna. Ut pulvinar gravida accumsan. Fusce ac mauris vitae nisl lacinia tristique. Proin feugiat mauris urna, eu laoreet nulla scelerisque in. Duis sed eros dui. Donec ut quam euismod, iaculis nulla non, condimentum dolor.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi a lectus at dui eleifend consequat. Vestibulum posuere dignissim mauris nec rutrum. Cras mauris ipsum, volutpat id aliquam ac, rhoncus nec ipsum. Curabitur quis ultrices ipsum. Mauris arcu augue, dictum sed erat non, viverra tempus arcu. Integer pharetra enim vitae tempus aliquet. Morbi condimentum ligula at iaculis blandit. Duis eleifend tortor sed imperdiet porta. Sed eget augue lobortis, molestie metus consectetur, mattis laoreet.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas vulputate eros vitae aliquet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque congue ornare mollis. Donec at sagittis ipsum. Mauris facilisis mattis sem et mollis. Pellentesque consequat vulputate erat, quis commodo sem imperdiet nec. Ut consequat nunc sed augue hendrerit, ac aliquet neque auctor. Mauris nec bibendum lacus, ut gravida lectus. Morbi id velit eget sit.',
						 'AZD1222');

/* 3 */
INSERT INTO BULA VALUES (DEFAULT,
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sollicitudin, quam id vulputate rhoncus, nisl erat tristique metus, gravida accumsan diam felis et enim. Proin ut ex quis purus venenatis tempus. Aliquam vehicula iaculis tellus id commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat, libero et placerat bibendum, velit ex pretium arcu, vitae ultrices erat massa eget dui. Ut pulvinar magna quis consequat pharetra. Ut libero enim, convallis a tempus accumsan.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sit amet augue fermentum ante aliquam congue a non lacus. Praesent commodo velit vitae venenatis aliquet. In dignissim posuere metus sit amet vehicula. Maecenas imperdiet dolor quis libero tempor elementum. Suspendisse quis convallis orci. Vestibulum convallis diam risus. Nulla euismod, lacus sit amet fringilla dictum, ligula nibh aliquet massa, eu tempor est nisl nec dolor. Pellentesque vitae felis quam. Vestibulum viverra augue mi.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dictum velit sed finibus dapibus. Vestibulum rhoncus, arcu eget viverra porta, nibh arcu sodales lectus, eu pulvinar tortor purus sit amet libero. Vestibulum eros neque, aliquam pellentesque feugiat sed, auctor ac arcu. Curabitur in orci ornare, fringilla sem non, volutpat mauris. Cras rhoncus condimentum nisl. Nulla urna odio, tincidunt auctor tempor vitae, sollicitudin quis arcu. Donec a justo ex. Nulla ac fermentum risus libero.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed nibh ac libero porttitor scelerisque. In quam nisl, sollicitudin ut feugiat ut, aliquam eget ante. Quisque vel nisi dignissim, lacinia nisl ut, mattis orci. Etiam ac libero purus. Proin nec purus ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Duis sodales arcu posuere sapien efficitur turpis duis.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dignissim, justo quis condimentum consequat, mauris nibh aliquet eros, ut congue libero tortor ut arcu. In ultricies, lacus aliquet auctor iaculis, elit leo laoreet nulla, ac lobortis neque leo vitae erat. In id eros lorem. In imperdiet at sem ut volutpat. Morbi sed pretium nisi, eget auctor dui. Quisque blandit sapien orci, eget hendrerit sem sodales a. Vestibulum nisl enim, bibendum sed efficitur sed, maximus non erat nullam sodales.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus libero et massa volutpat, at posuere sapien maximus. Ut nec libero a libero tempus auctor. Nulla lacus nulla, aliquet in ipsum non, fringilla pellentesque purus. Nunc suscipit quis nisl nec blandit. Donec eu sapien elementum, molestie velit id, interdum augue. Etiam molestie commodo dolor, ac auctor risus interdum nec. Sed tempus fermentum sapien, sit amet lobortis est efficitur vel. Aenean in libero molestie, efficitur eros.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam faucibus porttitor congue. Sed elementum scelerisque mi malesuada efficitur. Nulla vitae consectetur purus, id accumsan nisi. Donec nulla leo, viverra vel tempus eget, lacinia non massa. Aliquam a libero hendrerit lorem faucibus tincidunt. Nulla id neque at arcu tempor ultricies eget quis nulla. Morbi imperdiet arcu ac dui dictum interdum. Donec congue nisi vitae neque fringilla molestie. Morbi lorem turpis, tristique sit amet cras.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur viverra nisi ut euismod egestas. Fusce rutrum ultrices neque, quis tincidunt tortor vestibulum egestas. In id varius purus. Suspendisse potenti. Aliquam erat volutpat. Sed ultricies, risus vitae semper viverra, tellus nunc pharetra sem, sit amet eleifend elit velit quis odio. In sit amet iaculis risus. Aenean consequat lectus metus, at pulvinar dui dictum nec. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices nisi.', 
						 'Comirnaty');

/* 4 */
INSERT INTO BULA VALUES (DEFAULT, 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut a justo libero. Aliquam rutrum malesuada orci, id vulputate libero semper vitae. Morbi sagittis vel sem ut dignissim. Morbi congue mollis massa eu vestibulum. Nullam viverra diam eu fringilla egestas. Fusce sed tellus vel lorem posuere ornare vitae non velit. Ut viverra mollis ex, sit amet egestas dolor pharetra sit amet. Duis tempus semper lacus ut aliquet. Aliquam suscipit lacus consequat augue mattis hendrerit. Donec placerat ligula.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi finibus elit nec nibh interdum cursus. Quisque non suscipit velit, sit amet euismod nibh. Fusce egestas massa non malesuada tempor. Aliquam bibendum cursus massa non volutpat. Aenean vehicula nulla ac tristique auctor. Pellentesque iaculis maximus est, quis auctor ex. Aliquam tortor est, rhoncus sit amet mauris non, placerat maximus purus. Pellentesque in elit non tellus pharetra varius quis ac magna. Nulla in turpis dui. Nullam nam.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque quis eros vel dolor pharetra porta. Nunc vitae tincidunt ante. Nunc magna justo, luctus in lacinia vel, vulputate posuere dolor. Suspendisse tincidunt vestibulum dui ut sollicitudin. Nulla egestas malesuada tempor. Suspendisse est urna, pretium id semper condimentum, accumsan elementum quam. Vestibulum scelerisque non massa sed iaculis. Aliquam a facilisis diam. Nullam sit amet ante dolor. Maecenas in urna varius, dictum magna dui.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In rutrum eros id accumsan elementum. Donec ut nibh in mauris consectetur varius. In hac habitasse platea dictumst. Nunc dictum in turpis at lacinia. Nulla non convallis mi, vel luctus velit. Vestibulum tristique massa ut bibendum pretium. Duis facilisis ligula turpis, ac bibendum ex sollicitudin vel. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vehicula diam non arcu sodales, vel pretium purus ullamcorper orci aliquam.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tincidunt, felis vitae aliquam tempor, justo augue porttitor turpis, nec tempus nisi enim sit amet risus. Cras gravida ante quis purus cursus, quis fermentum mi vestibulum. Ut rhoncus lorem elit, a eleifend enim porttitor et. Curabitur sit amet sem sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor justo a est pharetra, eget dapibus mi venenatis. Praesent scelerisque, leo et cursus viverra, urna felis dui.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam finibus nec dolor vitae mollis. Cras eget quam maximus elit facilisis mattis ut sed dui. Ut lacinia maximus leo, non efficitur velit mollis et. Aliquam ut semper sapien, quis convallis felis. Cras eget tristique lacus, eget consectetur purus. Ut viverra nunc quis nibh dapibus, vel semper turpis aliquam. Etiam auctor, mi in lacinia facilisis, ex ex consectetur tortor, et pharetra ex risus quis sem. Mauris sagittis sit amet velit eu.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ultrices, felis quis pretium lobortis, mauris lacus rutrum felis, nec vulputate elit metus eget libero. Pellentesque sodales convallis lectus nec iaculis. Nulla pharetra nulla id augue volutpat, nec accumsan lacus sagittis. Donec vel ultrices quam. Pellentesque eros nunc, ultrices ut est vitae, lacinia aliquam nulla. Morbi consequat nunc id nibh dictum, id finibus quam vehicula. Pellentesque lacinia nisl vitae volutpat eleifend leo.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vehicula vehicula est a vehicula. Maecenas vel commodo odio. Fusce pulvinar congue metus, in vestibulum metus scelerisque id. Proin fringilla ante eget tellus facilisis, lacinia fringilla dui venenatis. Phasellus sodales et arcu sed elementum. In rhoncus dui dui, ut euismod eros tempor sed. Vestibulum dignissim, urna a bibendum rutrum, felis ligula dictum turpis, nec tincidunt nisi metus vitae elit. Sed in facilisis magna non.', 
						 'mRNA-1273');

/* 5 */
INSERT INTO BULA VALUES (DEFAULT,
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris turpis mi, tincidunt lobortis dignissim sit amet, posuere sed urna. Pellentesque scelerisque urna tellus, nec maximus augue tempor sit amet. Quisque velit turpis, interdum in facilisis id, tempus vitae augue. In auctor dui ornare eros convallis molestie. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi enim neque, condimentum eget elit sed, malesuada laoreet ex. Curabitur vestibulum sagittis metus at orci aliquam.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec scelerisque diam in orci venenatis consectetur. Vivamus sed rhoncus massa. Pellentesque eu sapien orci. Sed congue arcu at elit elementum egestas. Curabitur ante metus, hendrerit ut pharetra eu, tristique a ligula. Quisque sodales bibendum enim, et malesuada sapien volutpat in. Nam risus quam, aliquet ut nisl vitae, viverra ultrices libero. Praesent congue vestibulum leo, quis faucibus nisl elementum sit amet. Suspendisse porta ante.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut posuere malesuada nulla, sit amet venenatis erat condimentum eu. In eu nisi nec orci pretium sagittis. Nullam viverra purus vel condimentum laoreet. Aliquam in luctus tellus, et cursus elit. Maecenas sed convallis dui. Quisque molestie enim eget quam congue vestibulum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut vel sem id sapien posuere faucibus. Quisque venenatis tristique ipsum, ut metus.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sit amet placerat enim. In porta, metus quis porttitor rhoncus, quam nisl luctus lorem, at tempor magna mi a nibh. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam ac hendrerit turpis, id aliquam purus. Pellentesque vel est non orci pretium sagittis vitae quis justo. Curabitur erat magna, fermentum id blandit in, consectetur id turpis. Nam pharetra porta sollicitudin. Vestibulum aliquam.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean feugiat lacus id blandit eleifend. Maecenas quis venenatis nisl, in tempor dolor. In laoreet orci quis condimentum fermentum. Vestibulum faucibus, tortor at ullamcorper dignissim, mi lacus malesuada quam, nec tincidunt purus sapien sit amet urna. Aliquam elementum lectus eget pellentesque iaculis. Phasellus euismod risus et ex fringilla, in rhoncus nibh tincidunt. Mauris viverra lacinia laoreet. Vestibulum viverra metus id lacus id.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean cursus molestie nunc et interdum. Maecenas blandit nulla mauris, sit amet accumsan ipsum hendrerit ornare. Suspendisse ullamcorper aliquet lacus, at viverra ex aliquam eget. Nulla semper lacus nec velit consectetur, ac sollicitudin leo fringilla. Quisque fermentum, augue at malesuada auctor, turpis ligula tristique dui, eu sagittis quam erat nec augue. Nunc vitae ornare metus. Mauris sed sapien est. Etiam id est eleifend purus duis.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at rutrum nibh. Vivamus viverra sapien a elit consectetur, accumsan convallis sapien tempor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce libero eros, ultricies non auctor at, ullamcorper ac massa. Phasellus orci metus, placerat id neque ut, maximus blandit urna. Aliquam a dapibus turpis. Donec lobortis velit et tristique auctor. Proin dolor metus, ultricies a eleifend in quam.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac nibh consectetur, euismod enim et, malesuada nulla. Nam viverra non metus id pretium. Nulla pretium risus quis elit tincidunt semper. Vivamus dictum justo eu lacus ultrices, nec faucibus libero interdum. Aenean quis massa quis leo vehicula sagittis. Pellentesque laoreet dapibus dolor, eget venenatis lacus ultricies a. Ut placerat risus vitae mi scelerisque dapibus. Class aptent taciti sociosqu ad litora torquent per conubia proin.', 
						 'Sputinik V');

/* 6 */
INSERT INTO BULA VALUES (DEFAULT,
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis ante in metus mattis bibendum ut in massa. Cras egestas quis est non efficitur. Sed pretium laoreet enim a mollis. Donec posuere ultrices massa, sed feugiat augue hendrerit non. Duis eu aliquam orci. Fusce consequat eget lacus eget eleifend. Cras tincidunt ipsum eget imperdiet vulputate. Duis bibendum ut neque eget sollicitudin. Praesent vitae vehicula dolor. Vestibulum in ex in purus hendrerit egestas vitae id diam aliquam.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi condimentum nunc in mi cursus, eu pretium urna auctor. Praesent vestibulum cursus suscipit. Pellentesque at vehicula odio. Aliquam scelerisque vel erat sit amet tincidunt. Duis gravida consequat ex at tincidunt. Sed scelerisque feugiat lacinia. Mauris et risus accumsan dolor commodo scelerisque non nec arcu. Fusce tempor luctus suscipit. Nulla pulvinar lectus at nisl porttitor accumsan. Sed sit amet arcu et ligula viverra porta ante.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sollicitudin, orci ac ullamcorper viverra, urna magna tincidunt leo, ut auctor mauris risus tempus quam. Duis interdum purus massa, nec blandit erat commodo congue. Suspendisse diam ante, mollis quis varius at, convallis sed lectus. Mauris pharetra ultricies elit. Ut accumsan tempor fringilla. Pellentesque vel dolor eget ipsum posuere placerat. Proin dignissim quis purus sit amet condimentum. Sed finibus nulla vitae sem cursus aenean.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in velit eu metus scelerisque aliquam sed non risus. Morbi malesuada mi id enim vulputate, vel posuere est scelerisque. Donec luctus pretium arcu, eget rutrum diam semper nec. Etiam a erat tempor, varius nulla ac, sodales augue. Nulla nec velit et enim elementum posuere. Aenean eget tempus ligula. Fusce velit massa, cursus a molestie in, elementum vel velit. Etiam a lorem dictum, molestie purus ac, blandit dui. Curabitur odio nisi nam.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rhoncus, purus et ornare ultrices, dui lacus pulvinar arcu, in sagittis justo justo ut nisi. Nullam neque libero, tristique ut arcu vel, tincidunt egestas ipsum. Maecenas vitae feugiat nulla, sit amet porta lectus. Aliquam sit amet aliquet lacus. Ut mattis rhoncus nisl ut faucibus. Phasellus id hendrerit mauris, sed ullamcorper odio. Nam tempor vehicula ligula, nec iaculis justo venenatis a. In volutpat sem vel metus tincidunt mauris.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pellentesque pulvinar eros, aliquam placerat diam auctor vitae. Suspendisse nec aliquam tortor. Cras tortor odio, tincidunt eget libero non, ultrices hendrerit dui. Donec vel porttitor turpis, vel commodo purus. Cras ligula est, tincidunt ut orci non, lacinia sodales sem. Nullam auctor commodo mi id tempor. Nunc felis ex, cursus eget enim sed, mattis tempus eros. Curabitur ut lobortis risus. Nullam vel interdum erat, quis ornare augue.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ultricies, velit eget congue lacinia, ex felis pharetra libero, ut consequat tortor mi quis mauris. Quisque quam mauris, pharetra quis feugiat eget, luctus ut nisi. Sed sed lectus nec erat sagittis pellentesque. Mauris ultrices libero ac est luctus, id sollicitudin leo luctus. Integer efficitur lobortis cursus. Morbi pulvinar lectus eu erat vestibulum, at malesuada mi ornare. Donec varius ut erat sed dictum. Morbi enim purus morbi.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mi mi, feugiat id scelerisque eget, iaculis tristique velit. Maecenas semper ex a accumsan tincidunt. Vestibulum vel vestibulum leo, quis tincidunt dolor. Vestibulum id lacus in libero auctor pellentesque at nec sem. Maecenas et gravida neque. Donec in leo euismod, cursus neque sed, commodo nisi. Proin iaculis, leo quis rhoncus bibendum, odio purus facilisis ante, vel fringilla metus nisl at diam. Ut bibendum eget enim sit amet metus.', 
						 'Janssen Covid-19');

/* 7 */
INSERT INTO BULA VALUES (DEFAULT,
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec augue purus, maximus ac mi vitae, suscipit imperdiet est. Nullam sed mauris ut ante malesuada accumsan vestibulum pharetra tortor. Duis felis enim, iaculis vel est sit amet, luctus sagittis urna. Donec sed faucibus lacus. Proin auctor libero in tellus egestas, quis volutpat metus efficitur. Morbi nec commodo enim. Fusce ut volutpat elit. Ut eget facilisis metus. Vivamus in nunc eget ipsum maximus hendrerit. In ut odio id diam ligula.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum venenatis consectetur lacus, sed interdum dui sagittis eleifend. Aliquam nunc elit, pharetra commodo nisl vitae, auctor eleifend ante. Integer nisl quam, sollicitudin suscipit sem non, tempor feugiat massa. Integer tortor dui, rutrum vitae lobortis ac, pharetra vitae erat. Vestibulum sem lacus, elementum sit amet arcu a, accumsan lacinia nisi. Proin posuere magna a scelerisque luctus. Sed vitae pretium dui. Maecenas feugiat nec.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse rhoncus ex ac nunc varius, eget condimentum sapien dignissim. Ut interdum sed justo eu ullamcorper. Sed placerat metus quis tortor elementum laoreet ornare ac magna. Mauris convallis risus non dolor tincidunt, bibendum consequat nisl varius. Cras at faucibus quam. Donec maximus nibh et leo porta ullamcorper. Mauris fermentum in risus id molestie. Etiam non tellus erat. Phasellus dapibus, ante eu pharetra pellentesque, erat leo.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi mollis lectus eu magna pellentesque, nec lobortis lacus sollicitudin. In ultricies ex eu felis interdum, sed dictum urna posuere. Vivamus convallis tellus at ipsum dapibus, vel elementum leo sagittis. Fusce id aliquet est. Nullam in placerat nulla. Nam posuere pretium facilisis. Phasellus a libero aliquet, faucibus risus in, blandit lectus. Ut eu elit ut sem porta rhoncus. Pellentesque id magna id libero varius interdum sed in velit.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ut sapien efficitur, placerat erat vitae, dignissim justo. Quisque id purus hendrerit, congue nisi vitae, suscipit eros. Duis tincidunt pharetra felis quis varius. Praesent malesuada volutpat accumsan. Nam rutrum, est ut pellentesque egestas, dui libero dapibus elit, non luctus tellus turpis sed urna. Aliquam ac augue quis lacus congue tempus. Ut lobortis felis tristique quam auctor, sit amet venenatis velit congue. Proin orci nec.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce enim mauris, iaculis sit amet lobortis quis, rutrum sed tortor. Quisque tempus nisl id metus porta, congue sagittis nisi feugiat. Morbi pharetra euismod metus, vitae interdum eros consectetur at. Vestibulum hendrerit molestie lorem. In bibendum varius quam eu scelerisque. Pellentesque congue elementum pellentesque. Aliquam tristique enim eget ex pellentesque, ac sollicitudin libero tempor. Aenean ornare lectus nec sem convallis cras.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean lacinia justo quis metus tincidunt iaculis. Etiam ut enim in dui faucibus rhoncus. Mauris et nisl dui. Duis sit amet blandit nibh. Nulla fermentum ante sed magna semper placerat. Nam iaculis mattis convallis. Mauris leo libero, consequat eu ipsum quis, finibus posuere lacus. In ullamcorper mauris nec imperdiet semper. Nulla nisl metus, porttitor sed turpis eu, sodales euismod augue. Vestibulum ut feugiat nunc, ut ullamcorper mi vel.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis purus ut lectus finibus blandit eu non arcu. Nunc velit ipsum, porta et mattis sit amet, elementum eget sapien. Ut eget fringilla elit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque sed arcu varius, hendrerit lacus ut, dignissim nunc. Integer facilisis posuere nisi et sagittis. Nunc vel hendrerit risus, non dictum justo. Praesent at vehicula neque. Cras viverra sagittis nisi, eget finibus libero fusce.', 
						 'EpiVacCorona');

/* 8 */
INSERT INTO BULA VALUES (DEFAULT, 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer tristique, metus nec tempus pulvinar, leo ipsum fermentum ligula, vitae cursus eros quam et urna. Cras pharetra odio ac mauris tempus, at mattis metus rutrum. Fusce nunc leo, sagittis sed ex non, maximus faucibus elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aenean dignissim, odio ullamcorper suscipit condimentum, dui tortor fringilla velit, eu scelerisque nibh lorem sed orci viverra.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam bibendum quam sed elit vestibulum aliquam. Donec maximus lobortis lacus nec porttitor. Duis a cursus massa, sit amet imperdiet dui. In ut nunc condimentum, placerat enim vel, maximus eros. Suspendisse potenti. Quisque vehicula justo nec massa sagittis posuere. In et consectetur nunc. Suspendisse ut purus in elit tincidunt bibendum ac quis diam. Vivamus laoreet auctor tempor. Quisque ac est sit amet eros lacinia maximus. Morbi metus.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla enim erat, molestie sit amet ornare a, maximus a sapien. Donec lobortis, velit non iaculis ornare, odio mi interdum ligula, ut ultricies mauris mauris a nulla. Proin varius egestas est, in porta tortor bibendum vitae. Curabitur sed nulla eleifend, sagittis tellus ornare, rhoncus tellus. Sed nunc diam, eleifend eu augue eu, commodo ultrices erat. Mauris non consectetur tortor, eget imperdiet dolor. Vivamus euismod lorem sed tortor ut.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel ante sit amet risus molestie cursus. Duis tempus diam libero, sit amet efficitur urna tincidunt et. Sed ultrices, ante eu lobortis pharetra, mauris erat tempor ligula, sed bibendum leo ipsum auctor magna. Maecenas ipsum tellus, accumsan eget hendrerit congue, ullamcorper ut sapien. Donec rhoncus dolor sed suscipit rutrum. Vestibulum tempus, ex ut maximus suscipit, orci ipsum feugiat leo, id finibus mauris urna euismod arcu nec.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada libero vitae lacinia varius. Mauris dignissim elementum massa a mattis. Suspendisse nec turpis pretium, tempus turpis id, pharetra nunc. Praesent elementum tincidunt ullamcorper. Ut lobortis tortor non urna lacinia cursus. In sit amet diam ut erat facilisis aliquam eleifend id nisl. Ut convallis finibus tellus, vitae consequat augue ultrices eget. Suspendisse potenti. Curabitur finibus volutpat enim, vel ullamcorper donec.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer eu purus in dolor venenatis ornare. Nam vel pretium sem, quis fringilla ligula. Praesent sit amet dolor iaculis, tempus lectus sit amet, euismod purus. Aliquam quis semper metus. Sed vitae malesuada ante. Vestibulum in metus purus. Nunc viverra orci egestas tellus finibus, aliquam ultricies quam lacinia. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut quis ante consectetur porttitor.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse mollis, ex vitae auctor hendrerit, justo sem euismod massa, quis ornare sem metus id lacus. Donec a laoreet elit. Fusce libero lacus, volutpat eget dolor ullamcorper, bibendum viverra purus. Etiam commodo fermentum mauris, sed fringilla nunc ornare consequat. Pellentesque ex ligula, consectetur eu enim vel, pellentesque pharetra neque. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos sodales sed.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel consequat justo, sed tincidunt massa. In posuere, libero nec accumsan molestie, ex sem lobortis dolor, vel iaculis neque diam non ipsum. Suspendisse ornare, ante sed fermentum pulvinar, ipsum massa fermentum libero, at accumsan augue sem sit amet nibh. Ut eu vulputate nisi. Donec dignissim malesuada congue. Nulla vestibulum, elit sed faucibus hendrerit, justo sapien molestie ante, id imperdiet eros mauris et massa. Etiam et.', 
						 'NVX-CoV2373');

/* 9 */
INSERT INTO BULA VALUES (DEFAULT, 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras fringilla nibh eget libero viverra facilisis. Nulla gravida, odio ut pharetra tempor, purus risus porta massa, maximus maximus turpis neque id risus. Aenean mattis molestie nulla eu semper. Morbi semper ex et dolor tristique, et pellentesque magna efficitur. In dolor nisl, molestie eu tempus at, varius eget augue. Pellentesque dictum neque elit, vitae laoreet neque blandit eget. Aliquam porttitor lectus nec elit posuere, vitae tortor.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus tempus, nisl vitae dictum pharetra, magna arcu lacinia odio, ac condimentum odio est at metus. Aenean sit amet rhoncus lorem. Duis nunc ligula, vestibulum ac nisi et, tempor dignissim tortor. Nulla facilisi. Nunc pretium dapibus interdum. Ut vehicula ante tortor, quis vestibulum elit varius in. Cras pretium dolor purus, vel tempor dui tristique sed. Nulla ex lectus, pellentesque at vulputate scelerisque, ultrices vestibulum eros.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus rhoncus ipsum leo, a posuere neque gravida tristique. Proin interdum non tellus in feugiat. Donec pulvinar ipsum metus, ut auctor velit pellentesque ac. Proin accumsan diam odio. Mauris posuere ligula tellus, sed faucibus sem sodales ac. Mauris dui sem, scelerisque id sodales ut, efficitur et mi. Nullam nec erat quis mauris lacinia porta eget vitae libero. Vestibulum fermentum non lectus et ultricies. Donec magna mi, dictum eros.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec cursus volutpat eros non condimentum. Nullam auctor ante vitae suscipit sodales. Phasellus sed nunc eu lacus iaculis aliquam. Sed id laoreet sem, id tempor est. Duis semper libero id purus vulputate, ac vestibulum ligula malesuada. Fusce convallis lorem ac egestas pharetra. Suspendisse quis ligula pulvinar, pellentesque massa eget, maximus mauris. Aliquam rutrum ornare elit eget bibendum. Phasellus eleifend dictum justo id cras amet.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nibh justo, vehicula vestibulum iaculis pellentesque, consequat vitae diam. Sed luctus bibendum nisi dapibus tincidunt. Aenean maximus aliquam leo, sit amet consectetur leo dictum vitae. Nam semper pharetra justo et euismod. Praesent laoreet nulla nisi, ac condimentum eros auctor sit amet. Curabitur quis massa dictum, consequat est sed, vestibulum elit. Phasellus luctus sapien laoreet diam porta ultrices. Fusce congue lorem ut fusce.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tellus arcu, auctor pellentesque nisl sed, congue tincidunt neque. Morbi sed nulla ac arcu pretium gravida. Donec et elit odio. Cras porta in augue et consequat. Morbi in tortor cursus, commodo erat ac, facilisis nulla. Sed placerat quis arcu non eleifend. Phasellus ac vehicula tellus. Aliquam erat volutpat. Pellentesque egestas ex eu gravida semper. Nulla in sollicitudin turpis. Morbi ultricies felis id vestibulum molestie. Etiam id.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mollis commodo neque eget maximus. Nullam et malesuada justo, nec pretium augue. Fusce sapien libero, aliquet id leo vel, aliquet posuere leo. Maecenas at euismod nisl. Praesent at elementum diam. Proin volutpat leo at orci rhoncus bibendum. Phasellus facilisis erat id lectus iaculis maximus. Duis mattis hendrerit nunc, a ultrices dui congue at. Integer lobortis, ante iaculis elementum dignissim, neque nisi faucibus dolor, vel libero.', 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget magna felis. Nunc ultrices nibh a dui feugiat, vitae malesuada enim eleifend. Integer nibh ipsum, aliquam in augue in, malesuada lobortis nunc. Aliquam imperdiet risus sed pulvinar pharetra. Phasellus tempus porttitor posuere. Etiam lacinia leo et risus iaculis placerat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse vitae metus lectus. Orci varius natoque penatibus eu.', 
						 'Covaxin');

/* 10 */
INSERT INTO BULA VALUES (DEFAULT, 
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sollicitudin pretium dolor, ac condimentum orci mattis et. Vestibulum nec tortor id tortor molestie faucibus id eget ex. Nulla eu mollis lacus, sed efficitur diam. Ut metus arcu, maximus ac aliquam non, pretium sed magna. Cras blandit fermentum finibus. Donec quis auctor eros, ac mollis odio. Donec ornare aliquam justo, in pharetra nisi maximus egestas. Orci varius natoque penatibus et magnis dis parturient montes, nascetur massa nunc.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus dapibus nisi sollicitudin, vulputate dolor eu, ornare eros. Proin at nisi commodo, facilisis massa eu, mollis lectus. Nulla non sagittis urna. Nunc scelerisque eget mi a pulvinar. Sed aliquet leo dolor, sollicitudin ornare nunc tempus vel. Etiam et commodo nisi. Phasellus ut faucibus tortor. Duis venenatis, odio imperdiet egestas blandit, dolor sapien iaculis nibh, eu hendrerit sapien urna et diam. Nam gravida ligula et eleifend.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi id dui vel quam cursus accumsan ut ut sem. Proin sed posuere mi, ut egestas velit. Vivamus dignissim tincidunt turpis eget congue. Praesent sit amet condimentum ex. Mauris ac fermentum lorem. Fusce ipsum enim, commodo et semper id, luctus ut augue. Mauris eu dignissim ligula, sit amet efficitur risus. Ut lacinia orci enim, eu porttitor lorem ullamcorper eu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere sed.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam blandit venenatis est, vitae pretium metus feugiat in. Sed at erat a eros rutrum mattis. Sed molestie feugiat leo nec molestie. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla odio nisl, feugiat quis odio aliquet, condimentum fringilla augue. Sed ut sem id elit cursus viverra. Donec ac lorem auctor, euismod est vel, elementum arcu. Quisque malesuada neque quis enim sollicitudin tempor donec.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat nibh justo, id dapibus libero convallis eu. Aenean ullamcorper tristique justo, id mollis lectus feugiat nec. Etiam euismod, felis id efficitur posuere, arcu eros dignissim ligula, pellentesque faucibus est turpis nec ex. Sed vitae bibendum tellus. Donec a felis non est auctor convallis. Sed ac arcu non quam venenatis dignissim eu sit amet arcu. Donec sed tempus lacus, at ultricies lectus. Quisque aliquam dolor dapibus nam.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras gravida quam enim, vel cursus elit maximus in. Aliquam vitae orci in urna dictum venenatis auctor eget ex. Suspendisse potenti. Aenean id varius neque, nec auctor leo. Nunc hendrerit ex justo, sit amet vestibulum mi tristique facilisis. Nunc justo risus, viverra sed nibh non, vestibulum porta nunc. Etiam rutrum, elit non ullamcorper facilisis, velit arcu finibus tellus, et placerat augue ante at metus. Praesent sed convallis eleifend.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc facilisis aliquet orci non venenatis. Vivamus leo augue, mollis a ex sit amet, pulvinar auctor dolor. Nam quis tortor diam. Vestibulum venenatis lectus sit amet tellus euismod, at molestie purus iaculis. In tristique molestie cursus. Donec auctor sem quis laoreet tincidunt. Morbi at leo augue. Suspendisse at turpis et enim tempus volutpat. Nulla efficitur quam lacus, a tincidunt sapien iaculis vel. Nulla id eleifend nulla. Aliquam at.',
						 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ligula arcu, dapibus a viverra et, fermentum sodales tortor. Vestibulum nec nisl turpis. Nullam fringilla lobortis libero, in bibendum lorem accumsan ac. Phasellus faucibus sapien at orci laoreet posuere. Nulla finibus placerat lacus, sit amet laoreet velit lacinia sit amet. Donec blandit eleifend sapien, non iaculis est fermentum sit amet. Etiam eget ligula condimentum, sollicitudin neque sed, dignissim nisi. Mauris in justo augue.',
						 'Sinopharm-Pequim');
						 
/* EFEITO_COLATERAL */

/* 1 */
INSERT INTO EFEITO_COLATERAL VALUES ('Dor no local da injeção', 99, 'Baixa', 9999999);

/* 2 */
INSERT INTO EFEITO_COLATERAL VALUES ('Cansaço excessivo', 98, 'Baixa', 8888888);

/* 3 */
INSERT INTO EFEITO_COLATERAL VALUES ('Dor de cabeça', 97, 'Baixa', 7777777);

/* 4 */
INSERT INTO EFEITO_COLATERAL VALUES ('Dor muscular', 96, 'Baixa', 6666666);

/* 5 */
INSERT INTO EFEITO_COLATERAL VALUES ('Febre e calafrios', 95, 'Baixa', 5555555);

/* 6 */
INSERT INTO EFEITO_COLATERAL VALUES ('Diarreia', 94, 'Baixa', 4444444);

/* 7 */
INSERT INTO EFEITO_COLATERAL VALUES ('Náusea', 93, 'Baixa', 3333333);

/* 8 */
INSERT INTO EFEITO_COLATERAL VALUES ('Anafilaxia', 3, 'Moderada', 222222);

/* 9 */
INSERT INTO EFEITO_COLATERAL VALUES ('Embolia pulmonar', 2, 'Alta', 11111);

/* 10 */
INSERT INTO EFEITO_COLATERAL VALUES ('Trombose venosa profunda', 1, 'Extremamente Alta', 1111);

/* CONTEM */

/* 1 */
INSERT INTO CONTEM VALUES ('Dor no local da injeção', 1);

/* 2 */
INSERT INTO CONTEM VALUES ('Cansaço excessivo', 2);

/* 3 */
INSERT INTO CONTEM VALUES ('Dor de cabeça', 3);

/* 4 */
INSERT INTO CONTEM VALUES ('Dor muscular', 4);

/* 5 */
INSERT INTO CONTEM VALUES ('Febre e calafrios', 5);

/* 6 */
INSERT INTO CONTEM VALUES ('Diarreia', 6);

/* 7 */
INSERT INTO CONTEM VALUES ('Náusea', 7);

/* 8 */
INSERT INTO CONTEM VALUES ('Anafilaxia', 8);

/* 9 */
INSERT INTO CONTEM VALUES ('Embolia pulmonar', 9);

/* 10 */
INSERT INTO CONTEM VALUES ('Trombose venosa profunda', 10);




SELECT PA.nome as nome_paciente, PS.nome as nome_enfermeiro 
FROM ATENDE AT
INNER JOIN AGENDAMENTO AG ON AG.id_agendamento = AT.id_agendamento
INNER JOIN PROFISSIONAL_DE_SAUDE P_S ON AT.cpf = P_S.cpf
INNER JOIN PACIENTE P_A ON AG.cpf_paciente = P_A.cpf
INNER JOIN PESSOA PA ON PA.cpf = P_A.cpf
INNER JOIN PESSOA PS ON PS.cpf = P_S.cpf; 

SELECT V.desenvolvedor
FROM
BULA B 
INNER JOIN VACINA V ON B.nome_vacina = V.nome_vacina
INNER JOIN CONTEM C ON B.id_bula = C.id_bula
INNER JOIN EFEITO_COLATERAL EC ON EC.nome_e_c = C.nome_e_c
WHERE EC.gravidade in ('Moderada', 'Alta', 'Extremamente Alta') ;


SELECT LA.nome
FROM VACINA V, LABORATORIO_PARCEIRO LP, LOTE LO, ENCAMINHADO E, LOCAL_DE_APLICACAO LA
WHERE LP.nome_lab = 'Lab 5' 
AND LP.nome_vacina = V.nome_vacina
AND V.nome_vacina = LO.nome_vacina
AND E.nro_lote = LO.nro_lote
AND E.nome_vacina = LO.nome_vacina
AND E.id_l_A =LA.id_l_A;





SELECT P.nome
FROM PESSOA P
INNER JOIN PROFISSIONAL_DE_SAUDE PS ON P.CPF = PS.CPF
INNER JOIN ATENDE AT ON PS.CPF = AT.CPF
INNER JOIN AGENDAMENTO AG ON AT.id_agendamento = AG.id_agendamento
INNER JOIN POSSUI PO ON AG.id_agendamento = PO.id_agendamento
INNER JOIN LOTE LT ON PO.nro_lote = LT.nro_lote
WHERE AG.confirmacao_aplicacao = True AND LT.nro_lote = 9;


SELECT * FROM AGENDAMENTO;




SELECT P.nome_pai, P.nome_mae
FROM PESSOA P 
INNER JOIN PROFISSIONAL_DE_SAUDE PS ON P.CPF = PS.CPF
INNER JOIN ATENDE AT ON PS.CPF = AT.CPF
INNER JOIN AGENDAMENTO AG ON AT.id_agendamento = AG.id_agendamento
INNER JOIN POSSUI PO ON AG.id_agendamento = PO.id_agendamento
INNER JOIN LOTE LT ON PO.nro_lote = LT.nro_lote
WHERE LT.nro_lote = 6;


SELECT EN.data, EN.nro_lote
	FROM ENCAMINHADO EN
	INNER JOIN LOTE LT ON EN.nro_lote = LT.nro_lote
	INNER JOIN POSSUI PO ON LT.nro_lote = PO.nro_lote
	INNER JOIN AGENDAMENTO AG ON PO.id_agendamento = AG.id_agendamento
	WHERE AG.id_agendamento = 4;


SELECT P.nome
FROM 
PESSOA P  INNER JOIN 
PACIENTE PA ON  PA.cpf = P.cpf
LEFT JOIN  AGENDAMENTO A 
ON  PA.cpf = A.cpf_paciente
WHERE A.cpf_paciente IS NULL;




SELECT P.nome
FROM 
PESSOA P  INNER JOIN 
PACIENTE PA ON  PA.cpf = P.cpf
LEFT JOIN  AGENDAMENTO A 
ON  PA.cpf = A.cpf_paciente
WHERE A.cpf_paciente IS NULL;





SELECT PA.nome as nome_paciente, PS.nome as nome_enfermeiro
FROM ATENDE AT
INNER JOIN AGENDAMENTO AG ON AG.id_agendamento = AT.id_agendamento
INNER JOIN PROFISSIONAL_DE_SAUDE P_S ON AT.cpf = P_S.cpf
INNER JOIN PACIENTE P_A ON AG.cpf_paciente = P_A.cpf
INNER JOIN PESSOA PA ON PA.cpf = P_A.cpf
INNER JOIN PESSOA PS ON PS.cpf = P_S.cpf;











SELECT V.desenvolvedor
FROM
BULA B
INNER JOIN VACINA V ON B.nome_vacina = V.nome_vacina
INNER JOIN CONTEM C ON B.id_bula = C.id_bula
INNER JOIN EFEITO_COLATERAL EC ON EC.nome_e_c = C.nome_e_c
WHERE EC.gravidade in ('Moderada', 'Alta', 'Extremamente Alta') ;








/* 3. Quais locais de aplicação receberam vacinas do Lab 5 */

SELECT LA.nome
FROM VACINA V, LABORATORIO_PARCEIRO LP, LOTE LO, ENCAMINHADO E,
LOCAL_DE_APLICACAO LA
WHERE LP.nome_lab = 'Lab 5'
AND LP.nome_vacina = V.nome_vacina
AND V.nome_vacina = LO.nome_vacina
AND E.nro_lote = LO.nro_lote
AND E.nome_vacina = LO.nome_vacina
AND E.id_l_A =LA.id_l_A;












/* 4. Qual o nome das vacinas, local de aplicação para lotes que foram encaminhados e
possuem data de validade que expira em dezembro de 2022 */


SELECT V.nome_vacina AS Vacina, LA.nome AS Local_de_aplicacao
FROM VACINA V, Lote L, Encaminhado E, LOCAL_DE_APLICACAO LA
WHERE V.nome_vacina = L.nome_vacina
AND E.nro_lote = L.nro_lote
AND E.nome_vacina = L.nome_vacina
AND E.id_l_A =LA.id_l_A
AND L.data_validade BETWEEN '2022-12-01' AND '2022-12-31';














/* 5. Listar a média de idade dos pacientes por fila de vacinação */

SELECT FV.descricao, AVG(extract(year from age(PE.data_nascimento)))
FROM PESSOA PE, FILA_DE_VACINACAO FV, INGRESSA I, PACIENTE PA
WHERE PE.cpf = PA.cpf
AND PA.cpf = I.cpf
AND I.id = FV.id
GROUP BY FV.descricao;










/* 6. Quais pessoas foram vacinadas com vacinas do lote 9 */

SELECT P.nome
FROM PESSOA P
INNER JOIN PROFISSIONAL_DE_SAUDE PS ON P.CPF = PS.CPF
INNER JOIN ATENDE AT ON PS.CPF = AT.CPF
INNER JOIN AGENDAMENTO AG ON AT.id_agendamento = AG.id_agendamento
INNER JOIN POSSUI PO ON AG.id_agendamento = PO.id_agendamento
INNER JOIN LOTE LT ON PO.nro_lote = LT.nro_lote
WHERE AG.confirmacao_aplicacao = True AND LT.nro_lote = 9;









/* 7. Qual o nome do pai e da mãe dos pacientes que foram vacinados do lote 6 */


SELECT P.nome_pai, P.nome_mae
FROM PESSOA P
INNER JOIN PROFISSIONAL_DE_SAUDE PS ON P.CPF = PS.CPF
INNER JOIN ATENDE AT ON PS.CPF = AT.CPF
INNER JOIN AGENDAMENTO AG ON AT.id_agendamento = AG.id_agendamento
INNER JOIN POSSUI PO ON AG.id_agendamento = PO.id_agendamento
INNER JOIN LOTE LT ON PO.nro_lote = LT.nro_lote
WHERE LT.nro_lote = 6;









/* 8. Defina a quantidade de pessoas por vacina */

SELECT V.nome_vacina, COUNT(PE.nome)
FROM VACINA V, LOTE L, POSSUI PO, AGENDAMENTO A, PESSOA PE
WHERE V.nome_vacina = L.nome_vacina
AND L.nro_lote = PO.nro_lote
AND L.nome_vacina = PO.nome_vacina
AND A.id_agendamento = PO.id_agendamento
AND A.cpf_paciente = PE.cpf
GROUP BY V.nome_vacina;








/* 9. Qual a data que foi encaminhado a vacina e o número do lote da vacina com o
identificação do agendamento 4 */

SELECT EN.data, EN.nro_lote
FROM ENCAMINHADO EN
INNER JOIN LOTE LT ON EN.nro_lote = LT.nro_lote
INNER JOIN POSSUI PO ON LT.nro_lote = PO.nro_lote
INNER JOIN AGENDAMENTO AG ON PO.id_agendamento = AG.id_agendamento
WHERE AG.id_agendamento = 4;







/* 10. Liste as pessoas que não possuem um agendamento */

SELECT P.nome
FROM
PESSOA P INNER JOIN
PACIENTE PA ON PA.cpf = P.cpf
LEFT JOIN AGENDAMENTO A
ON PA.cpf = A.cpf_paciente
WHERE A.cpf_paciente IS NULL;






/* 1. Atribua a string ‘86885803081’ ao campo cpf e o número 2 ao campo id_i_a na tupla da
tabela Agendamento que possui o id agendamento = 5. */


UPDATE AGENDAMENTO
SET cpf_paciente = '86885803081',
id_l_a = 2
WHERE id_agendamento = 5;






/* 2. Atribua o número 9 ao campo nro_lote e a string ‘Covaxin’ ao campo nome_vacina na
tupla da tabela Encaminhado que possui o id_I_a = 4. */

UPDATE ENCAMINHADO
SET
nro_lote = 9,
nome_vacina = 'Covaxin'
WHERE id_l_a = 4;




SELECT * FROM ENCAMINHADO;
