CREATE SCHEMA locadora;
SET search_path TO locadora;
SET datestyle TO 'DMY';

CREATE TABLE CLIENTE (
	numCliente INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(50) NOT NULL,
	foneresidencial VARCHAR(15) NOT NULL,
	fonecelular VARCHAR(15) NOT NULL,
	CONSTRAINT PK_CLIENTE
		PRIMARY KEY (numCliente)
);

CREATE TABLE ATOR (
	cod INTEGER NOT NULL,
	datanasc DATE NOT NULL,
	nacionalidade VARCHAR(50) NOT NULL,
	nomereal VARCHAR(50) NOT NULL,
	nomeartistico VARCHAR(50) NOT NULL,
	CONSTRAINT PK_ATOR
		PRIMARY KEY (cod)
);

CREATE TABLE CLASSIFICACAO (
	cod INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	preco FLOAT NOT NULL,
	CONSTRAINT PK_CLASSIFICACAO
		PRIMARY KEY (cod)
);

CREATE TABLE FILME (
	numFilme INTEGER NOT NULL,
	titulo_original VARCHAR(50) NOT NULL,
	titulo_pt VARCHAR(50) NOT NULL,
	duracao INTEGER NOT NULL,
	data_lancamento DATE NOT NULL,
	direcao VARCHAR(250) NOT NULL,
	categoria VARCHAR(50) NOT NULL,
	classificacao INTEGER NOT NULL,
	CONSTRAINT PK_FILME
		PRIMARY KEY (numFilme),
	CONSTRAINT FK_MIDIA
		FOREIGN KEY (classificacao) REFERENCES CLASSIFICACAO
		ON UPDATE CASCADE
);

CREATE TABLE MIDIA (
	numFilme INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	tipo VARCHAR(50) NOT NULL,
	CONSTRAINT PK_MIDIA
		PRIMARY KEY (numFilme, numero, tipo),
	CONSTRAINT FK_MIDIA
		FOREIGN KEY (numFilme) REFERENCES FILME
		ON UPDATE CASCADE
		ON DELETE CASCADE
);
	
CREATE TABLE ESTRELA (
	numFilme INTEGER NOT NULL,
	codator INTEGER NOT NULL,
	CONSTRAINT PK_ESTRELA
		PRIMARY KEY (numfilme, codator),
	CONSTRAINT FK_ESTRELA
		FOREIGN KEY (numFilme) REFERENCES FILME
		ON UPDATE CASCADE
		ON DELETE CASCADE,
		FOREIGN KEY (codator) REFERENCES ATOR
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE EMPRESTIMO (
	numFilme INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	tipo VARCHAR(50) NOT NULL,
	cliente INTEGER NOT NULL,
	dataret DATE NOT NULL,
	datedev DATE NOT NULL,
	valor_pago FLOAT NOT NULL,
	CONSTRAINT PK_EMPRESTIMO
		PRIMARY KEY (numfilme, numero, tipo, cliente),
	CONSTRAINT FK_EMPRESTIMO
		FOREIGN KEY (numFilme, numero, tipo) REFERENCES MIDIA (numFilme, numero, tipo)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
		FOREIGN KEY (cliente) REFERENCES CLIENTE
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO CLIENTE VALUES (1, 'Jo�o Silva', 'Rua dos Pinheiros, 1687, Zona Sul', '(34) 3524-4651', '(34) 99254-4651');
INSERT INTO CLIENTE VALUES (2, 'Maria Magalh�es', 'Rua dos Coqueiros, 5484, Morro Alto', '(34) 3842-9741', '(34) 99954-9741');
INSERT INTO CLIENTE VALUES (3, 'Alice Fernandes', 'Av. Jasmim Manga, 842, Novo Cerrado', '(34) 2164-8974', '(34) 99988-8974');
INSERT INTO CLIENTE VALUES (4, 'Bento Jones', 'Rua dos Ip�s, 21, Centro', '(34) 3249-1245', '(34) 98821-1245');
INSERT INTO CLIENTE VALUES (5, 'Marco Castoldi', 'Rua dos Limoeiros, 10, Nova Morada', '(34) 3984-5566', '(34) 99287-5566');
INSERT INTO CLIENTE VALUES (6, 'Dimas Sousa', 'Av. Laranjeiras, 1111, Novo Bosque', '(34) 3218-7138', '(34) 98671-7138');
INSERT INTO CLIENTE VALUES (7, 'Gabriela Sousa', 'Av. Laranjeiras, 1111, Novo Bosque', '(34) 3218-7138', '(34) 98671-7138');

INSERT INTO CLASSIFICACAO VALUES (1,'Super-lan�amento',25.00);
INSERT INTO CLASSIFICACAO VALUES (2,'Lan�amento',15.00);
INSERT INTO CLASSIFICACAO VALUES (3,'Acervo',10.00);

INSERT INTO FILME VALUES (1, 'The Godfather', 'O Poderoso Chef�o', 175, '24/03/1972', 'Francis Ford Coppola', 'Crime', 3);
INSERT INTO FILME VALUES (2, 'Over Flew Over The Cuckoos Nest', 'Um Estranho no Ninho', 133, '21/11/1975', 'Millos Forman', 'Drama', 3);
INSERT INTO FILME VALUES (3, 'The Avengers', 'Os Vingadores', 143, '26/04/2012', 'Joss Whedon', 'A��o', 2);
INSERT INTO FILME VALUES (4, 'A Clockwork Orange', 'Laranja Mec�nica', 136, '13/01/1972', 'Stanley Kubrick', 'Fic��o Cient�fica', 3);
INSERT INTO FILME VALUES (5, 'Inception', 'A Origem', 148, '16/07/2010', 'Christopher Nolan', 'Aventura', 2);
INSERT INTO FILME VALUES (6, 'Pulp Fiction', 'Pulp Fiction: Tempo de Viol�ncia', 154, '21/10/1994', 'Quentin Tarantino', 'Crime', 3);
INSERT INTO FILME VALUES (7, 'The Hangover Part III', 'Se Beber, N�o Case! Parte: 3', 100, '24/05/2013', 'Tood Phillips', 'Com�dia', 2);
INSERT INTO FILME VALUES (8, 'The Silence of the Lambs', 'O Sil�ncio dos Inocentes', 118, '31/05/1991', 'Jonathan Demme', 'Suspense', 3);
INSERT INTO FILME VALUES (9, 'Memento', 'Amn�sia', 113, '20/10/2000', 'Christopher Nolan', 'Suspense', 3);
INSERT INTO FILME VALUES (10, 'Les Mis�rables', 'Os Miser�veis', 158, '11/01/2013', 'Tom Hooper', 'Musical', 2);
INSERT INTO FILME VALUES (11, 'The Pianist', 'O Pianista', 150, '24/01/2003', 'Roman Polanski', 'Biografia', 3);
INSERT INTO FILME VALUES (12, 'Citizen Kane', 'Cidad�o Kane', 119, '24/01/1942', 'Orson Welles', 'Drama', 3); 
INSERT INTO FILME VALUES (13, 'The Shining', 'O Iluminado', 146, '25/12/1980', 'Stanley Kubrick', 'Terror', 3);
INSERT INTO FILME VALUES (14, 'World War Z', 'Guerra Mundial Z', 116, '21/06/2013', 'Marc Forster', 'A��o', 2);
INSERT INTO FILME VALUES (15, 'Django Unchained', 'Django Livre', 165, '18/01/2013', 'Quentin Tarantino', 'Velho-Oeste', 2);
INSERT INTO FILME VALUES (16, 'Joker', 'Coringa', 122, '03/10/2019', 'Todd Phillips', 'Drama', 1);
INSERT INTO FILME VALUES (17, 'Marriage Story', 'Hist�ria de um Casamento', 136, '29/08/2019', 'Noah Baumbach', 'Drama', 1);
INSERT INTO FILME VALUES (18, 'The Irishman', 'O Irland�s', 209, '14/11/2019', 'Martin Scorsese', 'Drama', 1);
INSERT INTO FILME VALUES (19, 'Star Wars: The Rise of Skywalker', 'Star Wars: A Ascens�o Skywalker', 141, '19/12/2019', 'J.J. Abrams', 'Fic��o Cient�fica', 1);

INSERT INTO MIDIA VALUES (7,1,'Blu-ray');
INSERT INTO MIDIA VALUES (7,2,'DVD');
INSERT INTO MIDIA VALUES (10,1,'Blu-ray');
INSERT INTO MIDIA VALUES (14,1,'Blu-ray');
INSERT INTO MIDIA VALUES (14,2,'DVD');
INSERT INTO MIDIA VALUES (14,3,'VHS');
INSERT INTO MIDIA VALUES (15,1,'Blu-ray');
INSERT INTO MIDIA VALUES (16,1,'Blu-ray');
INSERT INTO MIDIA VALUES (16,2,'Blu-ray');
INSERT INTO MIDIA VALUES (16,3,'Blu-ray');
INSERT INTO MIDIA VALUES (17,1,'Blu-ray');
INSERT INTO MIDIA VALUES (17,2,'Blu-ray');
INSERT INTO MIDIA VALUES (18,1,'Blu-ray');
INSERT INTO MIDIA VALUES (18,2,'Blu-ray');
INSERT INTO MIDIA VALUES (18,3,'Blu-ray');
INSERT INTO MIDIA VALUES (18,4,'Blu-ray');
INSERT INTO MIDIA VALUES (19,1,'Blu-ray');
INSERT INTO MIDIA VALUES (3,1,'Blu-ray');
INSERT INTO MIDIA VALUES (3,2,'DVD');
INSERT INTO MIDIA VALUES (3,3,'VHS');
INSERT INTO MIDIA VALUES (5,1,'Blu-ray');
INSERT INTO MIDIA VALUES (5,2,'DVD');
INSERT INTO MIDIA VALUES (1,1,'DVD');
INSERT INTO MIDIA VALUES (1,2,'DVD');
INSERT INTO MIDIA VALUES (1,3,'VHS');
INSERT INTO MIDIA VALUES (2,1,'VHS');
INSERT INTO MIDIA VALUES (2,2,'VHS');
INSERT INTO MIDIA VALUES (4,1,'VHS');
INSERT INTO MIDIA VALUES (6,1,'DVD');
INSERT INTO MIDIA VALUES (8,1,'VHS');
INSERT INTO MIDIA VALUES (9,1,'DVD');
INSERT INTO MIDIA VALUES (11,1,'DVD');
INSERT INTO MIDIA VALUES (12,1,'VHS');
INSERT INTO MIDIA VALUES (13,1,'DVD');

INSERT INTO EMPRESTIMO VALUES (1,3,'VHS',1,'15/08/2014', '16/08/2015', 1220.00);
INSERT INTO EMPRESTIMO VALUES (2,1,'VHS',2,'12/01/2015', '14/01/2015', 10.00);
INSERT INTO EMPRESTIMO VALUES (3,1,'Blu-ray',3,'29/04/2016', '30/04/2016', 15.00);
INSERT INTO EMPRESTIMO VALUES (4,1,'VHS',4,'01/01/2017', '03/01/2017', 10.00);
INSERT INTO EMPRESTIMO VALUES (5,1,'Blu-ray',5,'30/09/2018', '01/10/2018', 15.00);
INSERT INTO EMPRESTIMO VALUES (6,1,'DVD',6,'04/05/2020', '06/05/2020', 10.00);
INSERT INTO EMPRESTIMO VALUES (7,1,'Blu-ray',7,'27/05/2020', '28/05/2020', 15.00);
INSERT INTO EMPRESTIMO VALUES (8,1,'VHS',1,'16/03/2020', '17/03/2020', 10.00);
INSERT INTO EMPRESTIMO VALUES (9,1,'DVD',2,'24/03/2020', '25/03/2020', 10.00);
INSERT INTO EMPRESTIMO VALUES (10,1,'Blu-ray',3,'22/06/2019', '23/06/2019', 15.00);
INSERT INTO EMPRESTIMO VALUES (11,1,'DVD',4,'12/01/2019', '14/01/2019', 10.00);
INSERT INTO EMPRESTIMO VALUES (12,1,'VHS',5,'12/02/2015', '14/02/2015', 10.00);
INSERT INTO EMPRESTIMO VALUES (13,1,'DVD',6,'12/10/2016', '15/10/2016', 10.00);
INSERT INTO EMPRESTIMO VALUES (14,1,'Blu-ray',7,'23/06/2017', '27/06/2017', 30.00);
INSERT INTO EMPRESTIMO VALUES (15,1,'Blu-ray',1,'15/02/2018', '19/02/2018', 30.00);
INSERT INTO EMPRESTIMO VALUES (1,1,'DVD',2,'02/05/2019', '05/05/2019', 10.00);
INSERT INTO EMPRESTIMO VALUES (2,2,'VHS',3,'09/04/2015', '12/04/2015', 10.00);
INSERT INTO EMPRESTIMO VALUES (3,1,'Blu-ray',4,'19/02/2016', '20/02/2016', 15.00);
INSERT INTO EMPRESTIMO VALUES (4,1,'VHS',5,'07/06/2017', '08/06/2017', 10.00);
INSERT INTO EMPRESTIMO VALUES (5,1,'Blu-ray',6,'15/06/2018', '27/06/2018', 60.00);
INSERT INTO EMPRESTIMO VALUES (16,1,'Blu-ray',7,'01/02/2021', '03/02/2021', 25.00);
INSERT INTO EMPRESTIMO VALUES (17,1,'Blu-ray',7,'01/02/2021', '03/02/2021', 25.00);
INSERT INTO EMPRESTIMO VALUES (18,1,'Blu-ray',7,'01/02/2021', '03/02/2021', 25.00);
INSERT INTO EMPRESTIMO VALUES (19,1,'Blu-ray',6,'07/03/2021', '10/03/2021', 25.00);

INSERT INTO ATOR VALUES (1, '03/04/1923', 'EUA', 'Marlon Brando Jr.', 'Marlon Brando');
INSERT INTO ATOR VALUES (2, '25/04/1940', 'EUA', 'Alfredo James Pacino', 'Al Pacino');
INSERT INTO ATOR VALUES (3, '26/03/1940', 'EUA', 'James Edmund Caan', 'James Caan');
INSERT INTO ATOR VALUES (4, '22/04/1937', 'EUA', 'John Joseph Nicholson', 'Jack Nicholson');
INSERT INTO ATOR VALUES (5, '17/11/1944', 'EUA', 'Daniel Michae DeVito Jr.', 'Danny DeVito');
INSERT INTO ATOR VALUES (6, '22/10/1938', 'EUA', 'Christopher Allen Lloyd', 'Christopher Lloyd');
INSERT INTO ATOR VALUES (7, '04/04/1965', 'EUA', 'Robert John Downey Jr.', 'Robert Downey Jr.'); 
INSERT INTO ATOR VALUES (8, '22/12/1967', 'EUA', 'Mark Alan Ruffalo', 'Mark Ruffalo');
INSERT INTO ATOR VALUES (9, '22/11/1984', 'EUA', 'Scarlett Ingrid Johansson', 'Scarlett Johansson');
INSERT INTO ATOR VALUES (10, '13/06/1943', 'Inglaterra', 'Malcolm John Taylor', 'Malcolm McDowell');
INSERT INTO ATOR VALUES (11, '26/04/1947', 'Inglaterra', 'Alan Clarke', 'Warren Clarke');
INSERT INTO ATOR VALUES (12, '13/11/1930', 'Inglaterra', 'Adrienne Riccoboni', 'Adrienne Corri');
INSERT INTO ATOR VALUES (13, '11/11/1974', 'EUA', 'Leonardo Wilhelm DiCaprio', 'Leonardo DiCaprio');
INSERT INTO ATOR VALUES (14, '17/02/1981', 'EUA', 'Joseph Leonard Gordon-Levitt', 'Joseph Gordon-Levitt');
INSERT INTO ATOR VALUES (15, '21/02/1987', 'Canad�', 'Ellen Philpotts-Page', 'Ellen Page');
INSERT INTO ATOR VALUES (16, '18/02/1954', 'EUA', 'John Joseph Travolta', 'John Travolta');
INSERT INTO ATOR VALUES (17, '21/12/1948', 'EUA', 'Samuel Leroy Jackson', 'Samuel L. Jackson');
INSERT INTO ATOR VALUES (18, '19/03/1955', 'Alemanha', 'Walter Bruce Willis', 'Bruce Willis');
INSERT INTO ATOR VALUES (19, '05/01/1975', 'EUA', 'Bradley Charles Cooper', 'Bradley Cooper');
INSERT INTO ATOR VALUES (20, '24/01/1974', 'EUA', 'Edward Paul Helms', 'Ed Helms');
INSERT INTO ATOR VALUES (21, '01/10/1969', 'EUA', 'Zacharius Knight Galifianakis', 'Zach Galifianakis');
INSERT INTO ATOR VALUES (22, '31/12/1937', 'UK', 'Philip Anthony Hopkins', 'Anthony Hopkins');
INSERT INTO ATOR VALUES (23, '19/11/1962', 'EUA', 'Alicia Christian Foster', 'Jodie Foster');
INSERT INTO ATOR VALUES (24, '25/08/1944', 'EUA', 'Philip Anthony Mair Heald', 'Anthony Heald');
INSERT INTO ATOR VALUES (25, '05/10/1967', 'Inglaterra', 'Guy Edward Peace', 'Guy Pearce');
INSERT INTO ATOR VALUES (26, '21/08/1967', 'Canad�', 'Carrie-Anne Moss', 'Carrie-Anne Moss');
INSERT INTO ATOR VALUES (27, '12/09/1951', 'EUA', 'Joseph Peter Pantoliano', 'Joe Pantoliano');
INSERT INTO ATOR VALUES (28, '12/10/1968', 'Austr�lia', 'Hugh Michael Jackman', 'Hugh Jackman');
INSERT INTO ATOR VALUES (29, '07/04/1964', 'Nova Zel�ndia', 'Russel Ira Crowe', 'Russel Crowe');
INSERT INTO ATOR VALUES (30, '03/12/1985', 'EUA', 'Amanda Michelle Seyfried', 'Amanda Seyfried');
INSERT INTO ATOR VALUES (31, '14/04/1973', 'EUA', 'Adrien Brody', 'Adrien Brody');
INSERT INTO ATOR VALUES (32, '31/07/1964', 'Inglaterra', 'Emilia Lydia Rose Fox', 'Emilia Fox');
INSERT INTO ATOR VALUES (33, '06/08/1926', 'Inglaterra', 'Francis Finlay', 'Frank Finlay');
INSERT INTO ATOR VALUES (34, '15/05/1905', 'EUA', 'Joseph Cheshire Cotten', 'Joseph Cotten');
INSERT INTO ATOR VALUES (35, '24/08/1913', 'EUA', 'Margaret Louise Comingore', 'Dorothy Comingore');
INSERT INTO ATOR VALUES (36, '06/12/1900', 'EUA', 'Agnes Robertson Moorehead', 'Agnes Moorehead');
INSERT INTO ATOR VALUES (37,'07/07/1949', 'EUA', 'Shelley Alexis Duvall', 'Shelley Duvall');
INSERT INTO ATOR VALUES (38, '23/05/1910', 'EUA', 'Bejamin Sherman Crothers', 'Scatman Crothers');
INSERT INTO ATOR VALUES (39, '18/12/1963', 'EUA', 'William Bradley Pitt', 'Brad Pitt');
INSERT INTO ATOR VALUES (40, '22/09/1975', 'EUA', 'Mireille Enos', 'Mireille Enos');
INSERT INTO ATOR VALUES (41, '14/07/1966', 'EUA', 'Matthew Chandler Fox', 'Matthew Fox');
INSERT INTO ATOR VALUES (42, '13/12/1967', 'EUA', 'Eric Marlon Bishop', 'Jamie Foxx');
INSERT INTO ATOR VALUES (43, '04/10/1956', '�ustria', 'Christoph Waltz', 'Christoph Waltz');
INSERT INTO ATOR VALUES (44, '28/10/1974', 'Porto Rico', 'Joaquin Rafael Bottom', 'Joaquin Phoenix');
INSERT INTO ATOR VALUES (45, '17/08/1943', 'EUA', 'Robert Anthony De Niro Jr', 'Robert De Niro');
INSERT INTO ATOR VALUES (46, '19/11/1983', 'EUA', 'Adam Douglas Driver', 'Adam Driver');
INSERT INTO ATOR VALUES (47, '10/04/1992', 'Inglaterra', 'Daisy Jazz Isobel Ridley', 'Daisy Ridley');

-- The Godfather
INSERT INTO ESTRELA VALUES (1,1);
INSERT INTO ESTRELA VALUES (1,2);
INSERT INTO ESTRELA VALUES (1,3);

-- Over Flew Over The Cuckoos Nest
INSERT INTO ESTRELA VALUES (2,4);
INSERT INTO ESTRELA VALUES (2,5);
INSERT INTO ESTRELA VALUES (2,6);

-- The Avengers
INSERT INTO ESTRELA VALUES (3,7);
INSERT INTO ESTRELA VALUES (3,8);
INSERT INTO ESTRELA VALUES (3,9);

-- A Clockwork Orange
INSERT INTO ESTRELA VALUES (4,10);
INSERT INTO ESTRELA VALUES (4,11);
INSERT INTO ESTRELA VALUES (4,12);

-- Inception
INSERT INTO ESTRELA VALUES (5,13);
INSERT INTO ESTRELA VALUES (5,14);
INSERT INTO ESTRELA VALUES (5,15);

-- Pulp Fiction
INSERT INTO ESTRELA VALUES (6,16);
INSERT INTO ESTRELA VALUES (6,17);
INSERT INTO ESTRELA VALUES (6,18);

-- The Hangover Part III
INSERT INTO ESTRELA VALUES (7,19);
INSERT INTO ESTRELA VALUES (7,20);
INSERT INTO ESTRELA VALUES (7,21);

-- The Silence of the Lambs
INSERT INTO ESTRELA VALUES (8,22);
INSERT INTO ESTRELA VALUES (8,23);
INSERT INTO ESTRELA VALUES (8,24);

-- Memento
INSERT INTO ESTRELA VALUES (9,25);
INSERT INTO ESTRELA VALUES (9,26);
INSERT INTO ESTRELA VALUES (9,27);

-- Les Mis�rables
INSERT INTO ESTRELA VALUES (10,28);
INSERT INTO ESTRELA VALUES (10,29);
INSERT INTO ESTRELA VALUES (10,30);

-- The Pianist
INSERT INTO ESTRELA VALUES (11,31);
INSERT INTO ESTRELA VALUES (11,32);
INSERT INTO ESTRELA VALUES (11,33);

-- Citizen Kane
INSERT INTO ESTRELA VALUES (12,34);
INSERT INTO ESTRELA VALUES (12,35);
INSERT INTO ESTRELA VALUES (12,36);

-- The Shining
INSERT INTO ESTRELA VALUES (13,4);
INSERT INTO ESTRELA VALUES (13,37);
INSERT INTO ESTRELA VALUES (13,38);

-- World War Z
INSERT INTO ESTRELA VALUES (14,39);
INSERT INTO ESTRELA VALUES (14,40);
INSERT INTO ESTRELA VALUES (14,41);

-- Django Unchained
INSERT INTO ESTRELA VALUES (15,13);
INSERT INTO ESTRELA VALUES (15,42);
INSERT INTO ESTRELA VALUES (15,43);

-- Joker
INSERT INTO ESTRELA VALUES (16,44);
INSERT INTO ESTRELA VALUES (16,45);

-- Marriage Story
INSERT INTO ESTRELA VALUES (17,9);
INSERT INTO ESTRELA VALUES (17,46);

-- The Irishman
INSERT INTO ESTRELA VALUES (18,2);
INSERT INTO ESTRELA VALUES (18,45);

-- Star Wars: The Rise of Skywalker
INSERT INTO ESTRELA VALUES (19,17);
INSERT INTO ESTRELA VALUES (19,46);
INSERT INTO ESTRELA VALUES (19,47);
