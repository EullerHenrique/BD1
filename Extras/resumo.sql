/*
    ----------------- Resumo de Sql ------------------------

        Autor: Euller Henrique Bandeira Oliveira
        Curso: Sistemas De Informação
        Universidade: Universidade Federal De Uberlândia
   
    -----------------------------------------------------------
*/

/*------------------------aula 01----------------------------*/
		/* Criando e excluindo bancos de dados*/


/*Instruções DDL - Linguagem de definição de dados*/

CREATE DATABASE db_curso_web; /*cria um banco de dados*/
DROP DATABASE db_curso_web; /*exclui um banco de dados*/

/*-----------------------------------------------------------*/




/*------------------------aula 02----------------------------*/
			 /* Tabelas e tipos de dados */
/*
Tipos de texto:
   Text - tamanho variável que armazena uma grande quantidade de caracteres
   
      Char - tamanho fixo que armazena de 0 até 255 caracteres
			Vantagem: Mais rápido para pesquisas
			Desvantagem: Quando mal utilizado pode reservar espaço
			em disco de forma desnecessária
	   
   VarChar - tamanho variável 
			Vantagem: Por ser de tamanho variável ocupa apenas
			o espaço necessário em disco
			Desvantagem: Por ser de tamanho variável possui um meta
			dado com uma instrução de finalização do texto, o que 
			produz, em relação ao CHAR, maior lentidão em pesquisas.
	*/

/*
NULL significa que você não precisa fornecer um valor para o campo ...
NOT NULL significa que você deve fornecer um valor para os campos.
*/

/*Instruções DDL - Linguagem de definição de dados*/
USE db_curso_web; /*Usar um banco de dados*/

CREATE TABLE tb_cursos ( /*criar uma tabela*/
	/*colunas da tabela*/
	id_curso INT(11) NOT NULL,
    imagem_curso VARCHAR(100) NOT NULL,
    nome_curso CHAR(50) NOT NULL,
    resumo TEXT NULL,
    data_cadastro DATETIME NOT NULL,
    ativo BOOLEAN DEFAULT TRUE, /* default -> valor padrão */
    investimento FLOAT(8,2) DEFAULT 0, /* 5 digitos inteiro, 2 digitos fracionarios*/
	carga_horaria INT(5) NULL
);

DROP TABLE tb_cursos; /*apaga uma tabela*/

/*-----------------------------------------------------------*/



/*------------------------aula 03----------------------------*/
			  /*Editando nome das tabelas*/
              
/*Instruções DDL - Linguagem de definição de dados*/
RENAME TABLE tb_cursos TO tb_cursos_teste;
RENAME TABLE tb_cursos_teste TO tb_cursos;
/*-----------------------------------------------------------*/



/*------------------------aula 04----------------------------*/
	/*Incluindo, editando e removendo colunas de tabelas*/
/* 
ALTER TABLE nome_da_tabela
   ADD - Permite a inclusão de uma nova coluna em uma tabela
   CHANGE - Permite a alteração do nome de uma coluna e de suas
   propriedades, como por exemplo o tipo.
   DROP - Permite a remoção de uma coluna da tabela

*/
    
/*Instruções DDL - Linguagem de definição de dados*/

ALTER TABLE tb_cursos ADD COLUMN carga_horaria VARCHAR(5) NOT NULL;
ALTER TABLE tb_cursos CHANGE carga_horaria carga_hora INT(5) NULL;
ALTER TABLE tb_cursos CHANGE carga_hora carga_horaria INT(5) NULL;
ALTER TABLE tb_cursos DROP carga_horaria;
ALTER TABLE tb_cursos ADD carga_horaria INT(5) NULL;

/*-----------------------------------------------------------*/



/*------------------------aula 05----------------------------*/
		  /* INSERT - Inserindo dados em tabela */

/* DML - Data Manipulation Language - Linguagem de Manipulação
 de Dados. */
 
 INSERT INTO 
 tb_cursos(ativo, carga_horaria, data_cadastro, id_curso, imagem_curso, investimo, nome_curso, resumo)
 values
 (1, 35, '2020-02-16 02:57:38', 1, 'curso_angular.jpg', 575.86, 'Web Completo com JS, TS e Angular', 
 'Aprenda a criar aplicações front-end incríveis com JavaScript, TypeScript e Angular');

/*-----------------------------------------------------------*/



/*------------------------aula 04----------------------------*/
		  /* SELECT - Consultando dados*/
/*DQL - Data Query Language - Linguagem de Consulta de dados.*/

SELECT * FROM tb_cursos;
SELECT id_curso, imagem_curso FROM tb_cursos;


/*-----------------------------------------------------------*/



/*------------------------aula 06----------------------------*/
  /* Populando o banco de dados com registros para testes */

/*Instruções DDL - Linguagem de definição de dados*/
  
CREATE TABLE tb_alunos (
  id_aluno int not null,
  nome varchar(255) default NULL, /* default null, null e nenhuma especificação é a mesma coisa*/
  idade int default NULL,
  interesse varchar(255) default NULL, 
  email varchar(255) default NULL,
  estado varchar(255) default NULL
);

/* DML - Data Manipulation Language - Linguagem de Manipulação
 de Dados. */
 
INSERT INTO `tb_alunos` 
(`id_aluno`,`nome`,`idade`,`interesse`,`email`,`estado`) 
VALUES 
(1,"Jorden",47,"Esporte","vel.mauris.Integer@nec.net","DF"),
(2,"Lacey",59,"Jogos","ligula.eu.enim@egetlaoreetposuere.com","SC"),
(3,"Lillith",48,"Saúde","Curabitur@atvelitCras.org","MA"),
(4,"Zephania",63,"Saúde","erat.vitae@loremtristiquealiquet.net","RS"),
(5,"Scarlett",95,"Informática","facilisis.Suspendisse.commodo@placeratCrasdictum.org","MS"),
(6,"Nash",39,"Música","Aliquam@Maurisquisturpis.org","BA"),
(7,"Indigo",62,"Informática","mus.Proin@laoreet.co.uk","GO"),
(8,"Bernard",77,"Esporte","ut@Craspellentesque.net","PA"),
(9,"Cheyenne",78,"Música","vel.pede@liberoduinec.co.uk","PR"),
(10,"Nerea",88,"Música","non@facilisisvitae.edu","PB"),
(11,"Lucius",57,"Esporte","eu.erat@interdum.ca","PE"),
(12,"Fallon",38,"Saúde","risus@Etiamimperdietdictum.net","MT"),
(13,"Steven",35,"Música","tellus@netus.org","CE"),
(14,"Paul",37,"Música","sollicitudin.adipiscing@magnaCras.edu","GO"),
(15,"Bradley",31,"Música","massa.Vestibulum@vitaesemperegestas.com","AP"),
(16,"Jeanette",46,"Informática","vitae@accumsannequeet.co.uk","MG"),
(17,"Craig",40,"Informática","magna.et.ipsum@tellusid.edu","MS"),
(18,"Maia",94,"Esporte","ac@tempusnon.co.uk","PB"),
(19,"Harriet",16,"Jogos","ante.ipsum@maurissitamet.com","AL"),
(20,"Finn",99,"Informática","metus.vitae@vitaerisusDuis.com","MT"),
(21,"Rafael",71,"Esporte","adipiscing.elit.Etiam@vel.edu","MG"),
(22,"Cynthia",85,"Esporte","Donec.nibh.Quisque@Sed.org","RN"),
(23,"Evelyn",13,"Informática","lacus.Aliquam.rutrum@etrutrumeu.edu","MA"),
(24,"Sybil",39,"Saúde","semper@nuncsed.com","ES"),
(25,"Uriel",10,"Esporte","semper.pretium.neque@eumetusIn.ca","PB"),
(26,"Dakota",99,"Esporte","ipsum@etrutrumnon.co.uk","PB"),
(27,"Stewart",31,"Saúde","natoque.penatibus.et@inhendrerit.org","CE"),
(28,"Cruz",96,"Saúde","Cum.sociis.natoque@elementumloremut.org","RS"),
(29,"Kadeem",57,"Informática","consectetuer@faucibusleoin.net","MS"),
(30,"Wyatt",36,"Música","feugiat.non@dolorsitamet.net","SC"),
(31,"Griffith",28,"Jogos","Lorem@elementumsem.com","RO"),
(32,"Yvette",39,"Saúde","mauris@dignissim.com","RO"),
(33,"Burton",14,"Esporte","leo.elementum.sem@arcuVestibulumante.edu","SC"),
(34,"Tatum",4,"Saúde","eget.lacus@nequeInornare.com","PA"),
(35,"Graham",88,"Informática","ac@necurna.com","ES"),
(36,"Aretha",37,"Esporte","malesuada.augue@Nunc.com","ES"),
(37,"Sloane",5,"Saúde","parturient@purusMaecenaslibero.net","CE"),
(38,"Uriel",81,"Saúde","Praesent.interdum@enimnon.net","AL"),
(39,"Cameran",61,"Esporte","sem.consequat@senectus.com","PR"),
(40,"Chiquita",8,"Jogos","nisl.Quisque@utodio.co.uk","MA"),
(41,"Tanek",40,"Esporte","nonummy@lectusNullamsuscipit.org","AL"),
(42,"Bruno",3,"Jogos","semper.Nam@atpretium.ca","DF"),
(43,"Winter",14,"Jogos","Quisque.nonummy@dolorNulla.ca","RS"),
(44,"Jacob",82,"Música","nec.eleifend.non@sapien.ca","RR"),
(45,"Kuame",98,"Esporte","placerat@ametorci.ca","PR"),
(46,"Orli",74,"Saúde","eu.erat.semper@dolorsitamet.co.uk","ES"),
(47,"Amber",24,"Informática","eleifend.non@quamvelsapien.org","AL"),
(48,"Roary",77,"Saúde","quis.pede.Suspendisse@Duisa.com","SE"),
(49,"Octavius",28,"Jogos","euismod.in.dolor@posuere.edu","PA"),
(50,"Isabella",54,"Informática","eu@euarcuMorbi.ca","RR"),
(51,"Driscoll",70,"Informática","sem@malesuada.com","SP"),
(52,"Brendan",45,"Informática","arcu.et.pede@magna.com","SC"),
(53,"Quon",18,"Informática","elit@adipiscingnon.org","AP"),
(54,"Rajah",48,"Informática","magna.tellus@Quisquefringilla.org","RJ"),
(55,"Lewis",32,"Informática","faucibus@vulputate.com","PA"),
(56,"Ronan",34,"Esporte","tellus.non@eleifend.com","CE"),
(57,"Baxter",72,"Esporte","enim.sit@urnanec.ca","DF"),
(58,"Kyla",6,"Esporte","facilisis.eget@sociosquadlitora.net","AM"),
(59,"Ava",54,"Jogos","velit@acmattis.edu","RN"),
(60,"Leonard",59,"Música","fermentum.arcu@consequatenim.ca","MS"),
(61,"Byron",17,"Música","Pellentesque.habitant.morbi@sapienNunc.edu","MT"),
(62,"Roary",52,"Jogos","nec.eleifend.non@velvenenatis.org","GO"),
(63,"Amery",89,"Informática","mauris.aliquam.eu@Proindolor.net","PA"),
(64,"Adele",40,"Saúde","scelerisque@velvenenatisvel.com","RR"),
(65,"Ronan",14,"Saúde","posuere.cubilia@Donecnonjusto.co.uk","RJ"),
(66,"Marny",53,"Saúde","convallis.in.cursus@blanditatnisi.com","PA"),
(67,"Camden",31,"Música","magna@mauriseu.edu","RJ"),
(68,"Yoko",13,"Música","dolor@vehiculaet.com","AM"),
(69,"Ina",71,"Informática","gravida.sagittis@tempusscelerisquelorem.com","AL"),
(70,"Tyler",3,"Esporte","Proin.dolor.Nulla@nascetur.org","PI"),
(71,"Destiny",19,"Saúde","augue.id@elementum.edu","MG"),
(72,"Glenna",82,"Jogos","dui@interdumligula.ca","AP"),
(73,"Buffy",55,"Esporte","dictum.eu@placeratvelitQuisque.net","MA"),
(74,"Hashim",27,"Música","est.congue@enim.org","MA"),
(75,"Hiram",67,"Saúde","nunc.sit.amet@nibhPhasellus.co.uk","RN"),
(76,"Kenneth",50,"Esporte","a.nunc.In@Integermollis.edu","AL"),
(77,"Ariel",9,"Jogos","Etiam.vestibulum.massa@egestas.edu","PA"),
(78,"Barrett",24,"Informática","fringilla.mi@liberoIntegerin.com","PA"),
(79,"Kato",25,"Música","cursus.in.hendrerit@eu.org","BA"),
(80,"Lance",50,"Saúde","Nullam@necurna.net","CE"),
(81,"Porter",50,"Jogos","ultrices.mauris@nequesed.org","PA"),
(82,"Zeus",26,"Informática","hymenaeos@Integereu.net","RR"),
(83,"Oleg",36,"Informática","Nam@morbitristiquesenectus.ca","AL"),
(84,"Erin",25,"Saúde","ligula@Nullam.edu","TO"),
(85,"Wade",61,"Esporte","odio.Aliquam.vulputate@egestas.edu","MS"),
(86,"Ross",92,"Música","tortor.at.risus@ac.edu","DF"),
(87,"Martina",24,"Música","Cras@lacusAliquam.com","MS"),
(88,"Rowan",75,"Saúde","erat@afelisullamcorper.com","RO"),
(89,"Aristotle",22,"Esporte","at.auctor@Utnecurna.net","PI"),
(90,"Bernard",24,"Saúde","placerat.orci.lacus@vitaesemperegestas.edu","RJ"),
(91,"Teegan",9,"Música","id@Fuscealiquam.co.uk","DF"),
(92,"Graiden",7,"Jogos","ante.dictum@nibhAliquam.co.uk","AL"),
(93,"Alec",50,"Música","vestibulum.neque.sed@nislQuisque.co.uk","PE"),
(94,"Savannah",61,"Jogos","odio.a.purus@nequeSedeget.co.uk","ES"),
(95,"Rafael",45,"Informática","a@dolorsit.net","PB"),
(96,"Clementine",32,"Saúde","dictum@Aliquamerat.edu","RS"),
(97,"Tasha",53,"Esporte","in@justoProin.co.uk","AC"),
(98,"Hector",83,"Música","Class.aptent@et.co.uk","AM"),
(99,"Tara",95,"Jogos","Donec.porttitor.tellus@nonfeugiat.co.uk","DF"),
(100,"Charissa",50,"Informática","orci@elementumduiquis.ca","AP");

/*-----------------------------------------------------------*/
  

/*------------------------aula 07----------------------------*/
      /* SELECT - Filtros com operadores de comparação */

/*DQL - Data Query Language - Linguagem de Consulta de dados.*/

SELECT
	* 
FROM 
	tb_alunos 
WHERE
	interesse = 'Jogos';


SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	idade < 25;
    
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	idade <= 25;    
 
 
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	idade > 30; 
 
 
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	idade >= 35;
 
/*-----------------------------------------------------------*/
    
    
    
/*------------------------aula 08----------------------------*/
      /* SELECT - Filtros com operadores lógicos */

/*DQL - Data Query Language - Linguagem de Consulta de dados.*/

SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse = 'Jogos' AND idade > 45;
 
 
 
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse = 'Jogos' AND idade > 45 AND estado = 'RN';
 

SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse = 'Jogos' OR idade > 45;
 
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse = 'Jogos' OR idade > 45 OR estado = 'MG';
 
 
/*-----------------------------------------------------------*/
   
   
   
/*------------------------aula 09----------------------------*/
		   /* Filtros com o operador between */
           
/*DQL - Data Query Language - Linguagem de Consulta de dados.*/
   
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	idade >= 18 AND idade <= 21;
    
    
/*
	 |  |  |  |  |  |  |  |  |  |
     V  V  V  V  V  V  V  V  V  V
*/
    
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	idade BETWEEN 18 AND 21;
     
/*-----------------------------------------------------------*/
     
 
/*------------------------aula 10----------------------------*/
		   /* Filtros com o operador in */

/*DQL - Data Query Language - Linguagem de Consulta de dados.*/

SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse = 'Jogos' OR interesse = 'Música' OR interesse = 'Esporte';
    
    
/*
	 |  |  |  |  |  |  |  |  |  |
     V  V  V  V  V  V  V  V  V  V
*/
    
SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse IN ('Jogos', 'Música', 'Esporte');     

			/*------------------------------*/

SELECT
	* 
FROM 
	tb_alunos 
WHERE 
	interesse NOT IN ('Jogos', 'Música', 'Esporte');     
    
      
/*-----------------------------------------------------------*/
   
   
   
   
/*------------------------aula 10----------------------------*/
		   /* Filtros com o operador like */

/*LIKE -> Permite realizar filtros com base em uma pesquisa de caracteres 
		 dentro de uma coluna textual
    Caracteres curingas:
		%" " -> Retorna todas as linhas da tabela que terminam com o(s) caractere(s) 
        determinado(s), na coluna determinada .
        " " % -> Retorna todas as linhas da tabela que começam com o(s) caractere(s) 
        determinado(s), na coluna determinada.
        % " " % -> Retorna todas as linhas da tabela que possuem o(s) caractere(s) 
        determinado(s) entre dois conjuntos de caracteres, na coluna determinada.
        Obs: ' ' também é um caracter
        
        _" " -> Retorna todas as linhas da tabela que possuem um caracter indefinido 
        à esquerda do(s) caractere(s) determinado(s), na coluna determinada.
        " " _ -> Retorna todas as linhas da tabela que possuem um caracter à direita
        do(s) caractere(s) determinado(s), na coluna determinada.
        _ " " _ -> Retorna todas as linhas da tabela que possuem o(s) caractere(s) 
        determinado(s) entre caracteres indefinidos, na coluna determinada.
        Obs: Pode-se especificar mais de um caracter indefinido.

Obs: Os dois curingas podem ser usados simultaneamente
*/

/*DQL - Data Query Language - Linguagem de Consulta de dados.*/

/* Utilidade simples, equivalencia ao operador igual*/

SELECT 
	*
FROM
	tb_alunos
WHERE
	nome = 'Evelyn';

/*
	 |  |  |  |  |  |  |  |  |  |
     V  V  V  V  V  V  V  V  V  V
*/
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE 'Evelyn';
    
/*Utiliade real, uso do operador LIKE com curingas */
    
    
				/* Curinga % */    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE '%e';
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE '%ne';
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE 'a%';    
    
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE '%b%';    
    
					/* Curinga _ */
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE '_riel';  
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE '_ru_';  
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE 'I__';  
    
    /* Curinga  % e _ */
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	nome LIKE '%tt_';      
    

/*-----------------------------------------------------------*/
 
 
 
  /*----------------------------aula 11------------------------------*/

	/* SELECT - Ordenando resultado (ascendente ou descendente */
           
/*DQL - Data Query Language - Linguagem de Consulta de dados.*/     
      
SELECT 
	*
FROM
	tb_alunos
WHERE
	idade BETWEEN 18 AND 59
ORDER BY
	nome ASC;
    
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	idade BETWEEN 18 AND 59
ORDER BY
	nome DESC;    
    
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	idade BETWEEN 18 AND 59
ORDER BY
	nome ASC, idade DESC, estado ASC; /* ?? NÃO NOTEI NENHUMA DIFERENÇA */

/*-----------------------------------------------------------*/
 
 
 
 
	/*------------------------aula 12----------------------------*/
			       /* SELECT - Limitando retorno */
                   
/* 
	LIMIT 2 || 

	LIMIT 2,5 (offset, limit) || 

	LIMIT 5
	OFFSET 2
	obs: O offset (deslocamento) é vinculado ao limit
    
    OFFSET: inicio
    LIMIT: fim
*/
           
/*DQL - Data Query Language - Linguagem de Consulta de dados.*/     
      
SELECT 
	*
FROM
	tb_alunos
LIMIT 
	25; /* (0-24) */
    
SELECT 
	*
FROM
	tb_alunos
ORDER BY
	id_aluno DESC
LIMIT 
	25; /* (100 => 0 - 75 => 24) */
      
      
SELECT 
	*
FROM
	tb_alunos
LIMIT  
	4      
OFFSET 
	0; /* (1 => 0 - 4 => 3)*/  /* 0 => default*/
    
    
    
SELECT 
	*
FROM
	tb_alunos
LIMIT  
	4      
OFFSET 
	4; /* (5 => 4 - 8 => 7)*/  
    
SELECT 
	*
FROM
	tb_alunos
LIMIT  
	4      
OFFSET 
	8; /* (9 => 8 - 12 => 11)*/  
    
SELECT 
	*
FROM
	tb_alunos
LIMIT  
	8, 4;  /* (9 => 8 - 12 => 11)*/             
    
/*-----------------------------------------------------------*/
       
       
       
	/*------------------------aula 13----------------------------*/
		 /* SELECT - Funções de agregação (MAX, MIN, AVG) */
           
  /*
  
  MIN(<coluna>) -> Retorna o menor valor de todos os registros presentes em uma coluna
  MAX(<coluna>) -> Retorna o maior valor de todos os registros presentes em uma coluna
  AVG(<coluna>) -> Retorna a média de todos os registros presentes em uma coluna
  
  
  
  */
  

/*Instruções DDL - Linguagem de definição de dados*/

TRUNCATE tb_cursos; /* apaga todo o conteudo de uma tabela */

/* DML - Data Manipulation Language - Linguagem de Manipulação
 de Dados. */
 
INSERT INTO 
tb_cursos
(id_curso, imagem_curso, nome_curso, resumo, data_cadastro, ativo, investimento, carga_horaria)
VALUES 
 (1, 'curso_node.jpg', 'Curso Completo do Desenvolvedor NodeJS e MongoDB', 'Resumo do curso de NodeJS', '2018-01-01', 1, 159.99, 15),
 (2, 'curso_react_native.jpg', 'Multiplataforma Android/IOS com React e Redux', 'Resumo do curso de React Native', '2018-02-01', 1, 204.99, 37), 
 (3, 'angular.jpg', 'Desenvolvimento WEB com ES6, TypeScript e Angular', 'Resumo do curso de ES6, TypeScript e Angular', '2018-03-01', 1, 579.99, 31), 
 (4, 'web_completo_2.jpg', 'Web Completo 2.0', 'Resumo do curso de Web Completo 2.0', '2018-04-01', 1, 579.99, 59), 
 (5, 'linux.jpg', 'Introdução ao GNU/Linux', 'Resumo do curso de GNU/Linux', '2018-05-01', 0, 0, 1);
  
  
 /*DQL - Data Query Language - Linguagem de Consulta de dados.*/     
     
/*     MIN    */     
     
SELECT 
	MIN(investimento)
FROM
	tb_cursos;
  
  
  
SELECT 
	MIN(investimento)
FROM
	tb_cursos
WHERE 
	ativo = true;
    
/*     MAX    */

SELECT 
	MAX(investimento)
FROM
	tb_cursos
WHERE 
	ativo = true;   
    
    
/* 		AVG      */

SELECT 
	AVG(investimento)
FROM
	tb_cursos
WHERE 
	ativo = true;
  
  
SELECT 
	* 
FROM 
	tb_cursos 
WHERE 
	investimento 
		 = 
    (SELECT 
		MIN(investimento) 
	  from 
        tb_cursos
	  WHERE
		ativo = true        
	);  
  
/*---------------------------------------------------------------------*/
  
	/*------------------------aula 14----------------------------*/
		 /* SELECT - Funções de agregação (SUM, COUNT) */       
/*
	SUM(<coluna>) -> Retorna a soma dos valores de todos os registros com base em um cuma coluna
    COUNT(*) -> Retorna a quantidade de todos os registros de uma tabela

*/


/*DQL - Data Query Language - Linguagem de Consulta de dados.*/     
          
		/* SUM */          
          
   SELECT        
	SUM(investimento)
   FROM 
	 tb_cursos
   WHERE 
	 ativo = true;
     
		/* COUNT */
 
  SELECT        
	COUNT(*)
   FROM 
	 tb_cursos
   WHERE 
	 ativo = true;    
     
   SELECT        
	COUNT(*)
   FROM 
	 tb_cursos
   WHERE 
	 ativo = false;    
     
  SELECT        
	COUNT(*)
   FROM 
	 tb_cursos;
	
		
  /*---------------------------------------------------------------------*/
      
      
	/*------------------------aula 15----------------------------*/
		 /* SELECT - Agrupando seleção de registros (GROUP BY) */       

/*
	GROUP BY -> Agrupa os registros com base em uma ou mais colunas cujos valores sejam iguais.
    Permite realizar funções de agregação em cada subconjunto agrupado de registros;
	OBS: Retorna o primeiro registro de cada subgrupo
*/

   /*
   
   Estrutura completa atual
   
   SELECT 
		 <coluna(s)>
   FROM 
		<tabela(s)>
   WHERE
		<filtro(s)>
   GROUP BY
		<grupo(s)>
   ORDER BY
		<ordenação(s)>
   LIMIT
		<limit>
   OFFSET
		<offset>
   
   */

   /* COMANDO PARA FAZER O GROUP BY FUNCIONAR 
	SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
   */
   
   /*DQL - Data Query Language - Linguagem de Consulta de dados.*/     
  
   
   SELECT 
		* 
   FROM 
		tb_alunos 
   GROUP BY 
		interesse;
        
        
   SELECT 
		*, count(*) 
   FROM 
		tb_alunos 
   GROUP BY 
		interesse;     
        
        
   SELECT 
		interesse, count(*) 
   FROM 
		tb_alunos 
   GROUP BY 
		interesse;     
        
   SELECT 
		interesse, count(*) AS total_por_interesse /* AS <apelido> */
   FROM 
		tb_alunos 
   GROUP BY 
		interesse;          
        
   SELECT 
		*
   FROM 
		tb_alunos 
   GROUP BY 
		estado;          
        
        
   SELECT 
		estado,  count(*) AS total_por_estado
   FROM 
		tb_alunos 
   GROUP BY 
		estado;
        
        
   SELECT 
		*
   FROM 
		tb_alunos 
   WHERE
		estado = 'ES';
        
	
    
  /*---------------------------------------------------------------------*/
   

/*------------------------aula 16----------------------------*/
   /* SELECT - Filtrando seleções agrupadas (HAVING) */       


   /*
   
   Estrutura completa atual
   
   SELECT 
		 <coluna(s)>
   FROM 
		<tabela(s)>
   WHERE
		<filtro(s)>
   GROUP BY
		<grupo(s)>
   HAVING
		<filtros(s)_sobre_agrupamento>
   ORDER BY
		<ordenação(s)>
   LIMIT
		<limit>
   OFFSET
		<offset>
   
   */
   
   /*
	HAVING -> Filtro realizado sobre o resultado dos agrupamentos(GROUP BY)
   */
   
   /*DQL - Data Query Language - Linguagem de Consulta de dados.*/     
  
   
    SELECT 
	 estado, COUNT(*) AS total_de_registros_por_estado
   FROM
	tb_alunos
   GROUP BY
	 estado;
   
   
   SELECT 
	 estado, COUNT(*) AS total_de_registros_por_estado
   FROM
	tb_alunos
   GROUP BY
	 estado
	HAVING
	  total_de_registros_por_estado >= 5;
      
      
   SELECT 
	 estado, COUNT(*) AS total_de_registros_por_estado
   FROM
	tb_alunos
   WHERE
	 estado IN('CE', 'SC') 
   GROUP BY
	 estado
   HAVING
	 total_de_registros_por_estado > 4;
      
      
   SELECT 
	 estado, COUNT(*) AS total_de_registros_por_estado
   FROM
	tb_alunos
   WHERE 
	interesse != 'Esporte'
   GROUP BY
	 estado
   HAVING
	 total_de_registros_por_estado > 3;
      
      
       
/*---------------------------------------------------------------------*/       
       
/*---------------- Diferença entre where e having----------------------------------------
       
Embora tenham comportamentos semelhantes (a cláusula WHERE e a cláusula HAVING destinam-se 
a filtrar resultados), elas também tem suas diferenças. 

A primeira diferença refere-se a ordem em que são processadas. Enquanto a cláusula WHERE filtra 
as linhas antes de agrupar, a cláusula HAVING filtra as linhas após o agrupamento (entenda-se 
agrupamento a presença de funções como SUM, COUNT, etc e a cláusula GROUP BY). Isso já leva a 
uma diferença de desempenho, uma vez que na esmagadora maioria das vezes, filtrar os resultados 
o mais cedo possível é melhor. Qual seria a utilidade de selecionar registros, agrupá-los e depois
descartá-los ?


A segunda diferença refere-se a possibilidades de filtros. Enquanto a cláusula WHERE limita-se a 
filtrar resultados simples, a cláusula HAVING possibilita filtros com bases em funções agregadas.
Não é possível por exemplo colocar filtros na cláusula WHERE usando funções como COUNT, SUM, AVG,
etc e nem utilizar operadores como SOME, ANY e ALL. 

 
Via de regra eu diria o seguinte:

- Filtros de linhas referenciando campos não agregados devem ser feitos na cláusula WHERE

- Filtros de linhas referenciando campos agregados devem ser feitos na cláusula HAVING

- Não utilize uma cláusula para realizar filtros da outra


--------------------------------------------------------------------------------------------*/
       
       

/*------------------------aula 16----------------------------*/
			/* UPDATE - Atualizando registros */              
   
 /* DML - Data Manipulation Language - Linguagem de Manipulação  de Dados. */  
 
 /* WARNING = SEMPRE UTILIZE O WHERE, POIS CASO CONTRÁRIO A(S) COLUNA(S) DE 
 TODOS OS REGISTROS SERÃO SETADAS COM O MESMO VALOR*/
 
 
UPDATE 
	tb_alunos
SET
	nome = 'João'
WHERE
	id_aluno = 13;
    
    
SELECT 
	* 
FROM
	tb_alunos
WHERE
	idade >= 80;

    
UPDATE 
	tb_alunos
SET
	interesse = 'Saúde'
WHERE
	idade >= 80;
    
    
    
 UPDATE 
	tb_alunos
 SET
	nome = 'Euller', idade = 19, email = 'eullerhenrique@outlook.com'
 WHERE
	id_aluno = 18;
    
    
SELECT 
	*
FROM
	tb_alunos
WHERE
	idade 
    BETWEEN 18 AND 25
		AND 
    estado = 'PA';
    

UPDATE
	tb_alunos
SET
	nome = 'Maria'
WHERE
	idade 
    BETWEEN 18 AND 25
		AND 
    estado = 'PA';    
        
/*---------------------------------------------------------------------*/     
   
   
/*------------------------aula 17----------------------------*/
			/* DELETE - Excluindo registros */              
   
 /* DML - Data Manipulation Language - Linguagem de Manipulação  de Dados. */  
 
 /* WARNING = SEMPRE UTILIZE O WHERE, POIS CASO CONTRÁRIO A(S) COLUNA(S) DE 
 TODOS OS REGISTROS SERÃO APAGADOS*/
 
/*OBS: Normalmente, os registros não são apagados, são apenas 
setados como inativos */
  
DELETE 
FROM
	tb_alunos
WHERE 
	id_aluno  = 5;
    
DELETE 
FROM
	tb_alunos
WHERE 
	idade 
    IN(10,18,22,28,34) 
    AND
    interesse = 'Esporte';
    

/*---------------------------------------------------------------------*/     
   
 
	/*---------------------------aula 18-------------------------------*/
			/* Projeto Loja Virtual - Relacionamento Um pra Um */ 
    /*Um produto possui uma decrição, uma descrição possui um produto */
  
  CREATE DATABASE db_loja_virtual;    
         
  CREATE TABLE tb_produtos(
	id_produto INT NOT NULL 
    PRIMARY KEY /*PRIMARY KEY(chave primária) => A coluna setada como uma
				chave primária não permitirá que seus valores se repitam  */
				/* Tal coluna será responsável por fazer a relação entre
				a sua tabela e uma ou mais tabelas */
    AUTO_INCREMENT, /* AUTOINCREMENT => A cada registro realizado id_produto 
					se auto incrementará, ou seja, AUTO_INCREMENT++ */
					/* Apesar do campo ser not null, ou seja, apesar dele não 
					aceitar receber nenhum valor, não é preciso setar nada, 
                    pois o auto increment já faz isso, no primeiro registro 
                    o auto increment setará o valor do campo como 1 e fará 
                    o incremento a cada registro ...
                    OBS: Pode haver apenas uma coluna automática e deve ser definida como uma chave
                    */
    produto VARCHAR(200) NOT NULL,
    valor FLOAT(8,2) NOT NULL
  );
  
  
  CREATE TABLE tb_descricoes_tecnicas(
	id_descricao_tecnica INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_produto_fk INT NOT NULL,
    descricao_tecnica TEXT NOT NULL, 
	FOREIGN KEY(id_produto_fk) /*FOREIGN KEY(chave estrangeira) =>  A chave estrangeira
								é uma referência em uma tabela a uma chave primária de
								outra tabela, permitindo assim, um relacionamento entre 
								as duas tabelas*/
    REFERENCES /* referências => <Tabela da chave primária> <chave_primária>  */
    tb_produtos(id_produto)  
/*    Existe uma primary key chamada id_produto dentro da tabela tb_produtos.
	  Essa primary key deve ser utilizada como referência por meio do campo id_produto_fk
	  da tabela tb_descricoes_tecnicas que será criado como a foreign key da tabela 
	  tb_descricoes_tecnicas.
	  O id_produto_fk da tabela tb_descrições tecnicas representa a chave estrangeira 
	  advinda da tabela tb_produtos
		
	  Em outras palavras, o campo id_produto_fk (chave estrangeira)
	  da tabela tb_descricoes_tecnicas recebe a referencia, ou seja, o endereço para o campo id_produto (chave primária)
	  da tabela tb_produtos.
      
      Por meio dessa referência, o registro setado com um determinado valor
      no campo id_produto_fk da tabela td_descricoes_tecnicas consegue acessar o registro com o 
      mesmo valor no campo id_produto da tabela td_produtos.
      
      Analogia ao C,

        FOREIGN KEY(id_produto_fk) REFERENCES tb_produtos(id_produto) seria uma função :

        *tb_produtos(tb_produtos *id_produto){
            *id_produto_fk = id_produto;
            return id_produto_fk;
        }

		A tabela seria uma struct
        A campo id_produto seria o endereço de um vetor de struct
        O campo id_produtos_fk seria o ponteiro que iria armazenar o endereço de um vetor de struct

	*/
   );
         

DROP TABLE tb_descricoes_tecnicas;

/*---------------------------------------------------------------------*/     
   
         
       /*---------------------------------aula 20-------------------------------------*/
		  /* Projeto Loja Virtual - Relacionamento Um pra Um (populando tabelas) */             
         
 INSERT INTO 
 tb_produtos
 (produto, valor)
 VALUES 
 ('Notebook Dell Inspiron Ultrafino Intel Core i7, 16GB RAM e 240GB SSD', 3500.00),
 ('Smart TV LED 40" Samsung Full HD 2 HDMI 1 USB Wi-Fi Integrado', 1475.54),
 ('Smartphone LG K10 Dual Chip Android 7.0 4G Wi-Fi Câmera de 13MP', 629.99);
 
 
 INSERT INTO 
  tb_produtos
 (produto, valor)
 VALUES 
 ('Playstation 5, 1TB RAM e 1TB SSD', 10000.00);
 
INSERT INTO 
  tb_produtos
 (produto, valor)
 VALUES 
 ('HD Externo Portátil Seagate Expansion 1TB USP 3.0', 274.90);


INSERT INTO 
tb_descricoes_tecnicas
(id_produto_fk, descricao_tecnica)
VALUES 
(1,'O novo Inspiron Dell oferece um design elegante e tela infinita que amplia seus sentidos, mantendo a sofisticação e medidas compactas...'),
(2,'A smart TV da Samsung possui tela de 40" e oferece resolução Full HD, imagens duas vezes melhores que TVs HDs padrão...'),
(3,'Saia da mesmice. O smartphone LG está mais divertido, rápido, fácil, cheio de selfies e com tela HD de incríveis 5,3"...');  
   
SELECT * from tb_descricoes_tecnicas;   
   
/*---------------------------------------------------------------------*/     
            
       /*------------------------aula 21----------------------------*/
          /* Projeto Loja Virtual - Relacionamento Um pra Muitos */   
	/* Uma imagem está associada a um produto (ex: a imagem 1 está só pode ser associada ao produto 1, não pode-se associar a imagem 1 ao produto 2, produto 3 etc..
       Um produto está associado a uma ou mais imagens*/

/*	Apesar do relacionamento ser um para muitos, devido ao fato de id_produto 
	estar dentro de tb_imagens e id_imagem não estar dentro de tb_produtos
	a imagem sabe com qual produto está se relacionando,
	mas o produto não sabe com quais imagens está se relacionando 
*/       

			 /* Nesta relação, um produto pode ter várias imagens*/
                
  CREATE TABLE tb_imagens(
	id_imagem INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_produto_fk INT NOT NULL,
    url_imagem VARCHAR(200) NOT NULL,
	FOREIGN KEY(id_produto_fk) REFERENCES tb_produtos(id_produto)
  );        
  
  
  INSERT INTO    /* adição de 3 imagens para o produto 1 */
	tb_imagens
	(id_produto_fk, url_imagem)
  VALUES
	(1, 'notebook_1.jpg'),
    (1, 'notebook_2.jpg'),
    (1, 'notebook_3.jpg');
    
      
  INSERT INTO  /* adição de 2 imagens para o produto 2 */
	tb_imagens
	(id_produto_fk, url_imagem)
  VALUES
	(2, 'smart_tv_1.jpg'),
    (2, 'smart_tv__2.jpg');
    
    
 INSERT INTO/* adição de 1 imagem para o produto 3 */
	tb_imagens
	(id_produto_fk, url_imagem)
  VALUES
	(3, 'smartphone_1.jpg');

SELECT * FROM tb_imagens;
           
/*---------------------------------------------------------------------*/     

            
	/*----------------------------aula 22--------------------------------*/
		/* Projeto Loja Virtual - Relacionamento Muitos para Muitos */ 
        
		/* tb_pedidos_clientes está relacionado a um ou mais pedidos */
     
		/* tb_pedidos_clientes está relacionado a um ou mais clientes */
     
	  /* Nesta relação, um  unico pedido pode ter muitos produtos 
         Nesta relação, um  unico produto pode ter muitos pedidos
       */
        
CREATE TABLE tb_clientes(
	id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    idade INT(3) NOT NULL
);          


CREATE TABLE tb_pedidos(
	id_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente_fk INT NOT NULL,
	data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP /* data e hora atual*/,
    FOREIGN KEY(id_cliente_fk) REFERENCES tb_clientes(id_cliente)
);


CREATE TABLE tb_pedidos_produtos(
	id_pedido_fk INT NOT NULL,
    id_produto_fk INT NOT NULL,
    FOREIGN KEY (id_pedido_fk) REFERENCES tb_pedidos(id_pedido),
    FOREIGN KEY (id_produto_fk) REFERENCES tb_produtos(id_produto)
); 


          
/*---------------------------------------------------------------------*/     


		/*----------------------------aula 23--------------------------------*/
	/* Projeto Loja Virtual - Relacionamento Muitos para Muitos (populando tabelas) */ 
   
   
   INSERT INTO tb_clientes(nome, idade)  /* adição de um novo cliente */
   VALUES('Jorge', 29);
   
   INSERT INTO tb_clientes(nome, idade) /* adição de um novo cliente */ 
   VALUES('Euller', 20); 
   
   INSERT INTO tb_clientes(nome, idade) /* adição de um novo cliente */ 
   VALUES('Joao', 20); 
   
   INSERT INTO tb_clientes(nome, idade) /* adição de um novo cliente */ 
   VALUES('Maria', 20); 
   
   INSERT INTO tb_pedidos(id_cliente_fk) /* adição de um novo pedido para o cliente 1*/
   VALUES(1);
   
   INSERT INTO tb_pedidos(id_cliente_fk) /* adição de um novo pedido para o cliente 1*/
   VALUES(1);
   
   INSERT INTO tb_pedidos(id_cliente_fk) /* adição de um novo pedido para o cliente 2 */ 
   VALUES(2); 
   
   INSERT INTO tb_pedidos(id_cliente_fk) /* adição de um novo pedido para o cliente 5 */ 
   VALUES(5); 
   
   INSERT INTO tb_pedidos(id_cliente_fk) /* adição de um novo pedido para o cliente 6 */ 
   VALUES(6); /* Este comando não funciona pois tb_pedido está vinculado a tb_clientes, 
				logo o cliente com o id_cliente = 6 precisa existir*/ 

   INSERT INTO tb_pedidos_produtos(id_pedido_fk, id_produto_fk) /* adição de uma relação entre o pedido 1 e o produto 2*/
   VALUES(1, 2);
   
   INSERT INTO tb_pedidos_produtos(id_pedido_fk, id_produto_fk)  /* adição de uma relação entre o pedido 1 e o produto 3*/
   VALUES(1, 3);

   INSERT INTO tb_pedidos_produtos(id_pedido_fk, id_produto_fk)   /* adição de uma relação entre o pedido 2 e o produto 3*/
   VALUES(2, 3);
   
   INSERT INTO tb_pedidos_produtos(id_pedido_fk, id_produto_fk)   /* adição de uma relação entre o pedido 2 e o produto 3*/
   VALUES(2, 3);
   
   INSERT INTO tb_pedidos_produtos(id_pedido_fk, id_produto_fk)   /* adição de uma relação entre o pedido 3 e o produto 1*/
   VALUES(3, 2);
   
   INSERT INTO tb_pedidos_produtos(id_pedido_fk, id_produto_fk)   /* adição de uma relação entre o pedido 5 e o produto 5*/
   VALUES(4, 5);
   
   SELECT * FROM tb_clientes; /* O id_cliente 3 não apareceu pq eu tinha excluido ele*/
   SELECT * FROM tb_pedidos;
   SELECT * FROM tb_pedidos_produtos;

/*---------------------------------------------------------------------*/     


	/*----------------------------aula 24--------------------------------*/
		    /* Projeto Loja Virtual - LEFT JOIN -- Junção à esquerda */
   
SELECT 
	*
FROM
		tb_clientes /*tabela a esquerda*/


    LEFT JOIN  /* Indica como será feito o retorno dos registros
		  		  neste caso, a tabela da esquerda possui uma prioridade maior em relação
                  a tabela da direita.
                
                  Retorna todos os registros da tabela a esquerda e caso exista retorna 
                  também todos os registros da tabela a direita que satisfazem o relacionamento
                  explicitado no ON
                */
    
		tb_pedidos /* tabela a direita */
    
    ON    /*   Indica como os registros se relacionam*/
		  /*   Neste caso, serão retornados como uma união os registros de tb_clientes e os 
			   registros de tb_pedidos que possuirem o valor de id.cliente de tb_clientes e 
               o valor de id_cliente_fk iguais de tb_pedidos*/
		(tb_clientes.id_cliente = tb_pedidos.id_cliente_fk); 
 


SELECT 
	*
FROM
		tb_produtos LEFT JOIN tb_imagens
	ON 	
		(tb_produtos.id_produto = tb_imagens.id_produto_fk);
    
    
/*----------------------------aula 25--------------------------------*/
		    /* Projeto Loja Virtual - RIGHT JOIN -- Junção à direita */
   
SELECT 
	*
FROM
		tb_clientes /*tabela a esquerda*/


    RIGHT JOIN  /* Indica como será feito o retorno dos registros.
				   Neste caso, a tabela da direita possui uma prioridade maior em relação
				   a tabela da esquerda.
                
				   Retorna todos os registros da tabela a direita e caso exista retorna 
				   também todos os registros da tabela a esquerda que satisfazem o relacionamento
				   explicitado no ON
                */
    
		tb_pedidos /* tabela a direita */
    
	ON    /*  Indica como os registros se relacionam */
		 /*   Neste caso, serão retornados como uma união os registros de tb_clientes e os 
              registros de tb_pedidos que possuirem o valor de id.cliente de tb_clientes e o 
			  valor de id_cliente_fk de tb_pedidos iguais */
		(tb_clientes.id_cliente = tb_pedidos.id_cliente_fk); 
 
SELECT 
	*
FROM
		tb_produtos RIGHT JOIN tb_imagens
	ON 	
		(tb_produtos.id_produto = tb_imagens.id_produto_fk);
    
/*---------------------------------------------------------------------*/     
   
/*----------------------------aula 26--------------------------------*/
	/* Projeto Loja Virtual - INNER JOIN -- Junção interna */
              /* Faz a interseção entre as tabelas */
   
   
			/* USO SIMULTÂNEO DE LEFT JOIN E RIGHT JOIN */   
   
SELECT 
	*
FROM															
		tb_pedidos  /*	  tabela a esquerda   */ 													
	LEFT JOIN 														
		tb_pedidos_produtos	/* tabela a direita */   /* SEGUNDO LEFT JOIN => tabela a esquerda */  								
	ON 																
		(tb_pedidos.id_pedido = tb_pedidos_produtos.id_produto_fk) 	 
	LEFT JOIN 														 						
		tb_produtos  /* tabela a direita */  											  					
	ON 																  					
		(tb_pedidos_produtos.id_produto_fk = tb_produtos.id_produto);  
   
   
SELECT 
	*
FROM															
		tb_pedidos  /*	  tabela a esquerda   */ 													
	RIGHT JOIN 														
		tb_pedidos_produtos	/* tabela a direita */   /* SEGUNDO RIGHT JOIN => tabela a esquerda */  								
							/*tb_pedidos_produtos é prioritario em relação a tb_pedidos */
	ON 																
		(tb_pedidos.id_pedido = tb_pedidos_produtos.id_produto_fk) 	 
	RIGHT JOIN 														 						
		tb_produtos  /* tabela a direita */ /*tb_produtos é prioritario em relação a tb_pedidos_produtos*/ 											  					
	ON 																  					
		(tb_pedidos_produtos.id_produto_fk = tb_produtos.id_produto);
    
    
SELECT 
	*
FROM															
		tb_pedidos  /*	  tabela a esquerda   */ 													
	RIGHT JOIN 														
		tb_pedidos_produtos	/* tabela a direita */   /* SEGUNDO LEFT JOIN => tabela a esquerda */  								
	ON 																
		(tb_pedidos.id_pedido = tb_pedidos_produtos.id_produto_fk) 	 
	LEFT JOIN 														 						
		tb_produtos  /* tabela a direita */  											  					
	ON 																  					
		(tb_pedidos_produtos.id_produto_fk = tb_produtos.id_produto);   
   
   
								/* INNER JOIN  */  
   
SELECT 
	*
FROM
		tb_clientes /*tabela a esquerda*/

	INNER JOIN  /* Indica como será feito o retorno dos registros.
				   Neste caso não existe prioridade.  
                
                   Retorna todos os registros da tabela a direita que satisfazem o relacionamento
				   explicitado no ON && todos os registros da tabela a esquerda que 
                   satisfazem o relacionamento explicitado no ON.
                   Em outras palavras, retorna os registros das duas tabelas que satisfazem o relacionamento
                   explicitado no ON, ou seja, retorna a intersecção entre as duas tabelas.
                */
    
		tb_pedidos /* tabela a direita */
    
	ON   /*        Indica como os registros se relacionam*/
		 /*        Neste caso, serão retornados como uma união os registros de tb_clientes e os 
                   registros de tb_pedidos que possuirem o valor de id.cliente de tb_clientes e o 
				   valor de id_cliente_fk de tb_pedidos iguais*/
		(tb_clientes.id_cliente = tb_pedidos.id_cliente_fk); 
 
SELECT 
	*
FROM
		tb_produtos INNER JOIN tb_imagens
	ON 	
		(tb_produtos.id_produto = tb_imagens.id_produto_fk);
   
   
   
   
   
SELECT * FROM tb_pedidos;
SELECT * FROM tb_pedidos_produtos;   
   
SELECT 
	*
FROM
		tb_pedidos INNER JOIN  tb_pedidos_produtos
	ON 
		(tb_pedidos.id_pedido = tb_pedidos_produtos.id_pedido_fk); 
   

SELECT 
	*
FROM
		tb_pedidos 
	INNER JOIN  
		tb_pedidos_produtos
	ON 		
		(tb_pedidos.id_pedido = tb_pedidos_produtos.id_pedido_fk)
	INNER JOIN
		tb_produtos
	ON
		(tb_pedidos_produtos.id_produto_fk= tb_produtos.id_produto);
   

   /*---------------------------------------------------------------------*/     


/*----------------------------aula 27--------------------------------*/
			      /* Alias - Apelidando tabelas */ 
	
SELECT 
	*
FROM
		tb_produtos 
	LEFT JOIN
		tb_descricoes_tecnicas
	ON 
		(tb_produtos.id_produto = tb_descricoes_tecnicas.id_produto_fk);
    
    
SELECT 
	*
FROM
		tb_produtos AS p
	LEFT JOIN
		tb_descricoes_tecnicas AS dt
	ON 
		(p.id_produto = dt.id_produto_fk);
    


SELECT 
	tb_produtos.id_produto,
    tb_produtos.produto,
    tb_produtos.valor,
    tb_descricoes_tecnicas.descricao_tecnica
FROM
		tb_produtos 
	LEFT JOIN
		tb_descricoes_tecnicas 
	ON 
		(tb_produtos.id_produto = tb_descricoes_tecnicas.id_produto_fk);
        
 
SELECT 
	p.id_produto,
    p.produto,
    p.valor,
    dt.descricao_tecnica
FROM
		tb_produtos AS p
	LEFT JOIN
		tb_descricoes_tecnicas AS dt
	ON 
		(p.id_produto = dt.id_produto_fk);
        
 
SELECT 
	p.id_produto,
    p.produto,
    p.valor,
    dt.descricao_tecnica
FROM
	tb_produtos AS p LEFT JOIN tb_descricoes_tecnicas AS dt ON (p.id_produto = dt.id_produto_fk)
WHERE 
	p.valor >= 500;
    
    
SELECT 
	p.id_produto,
    p.produto,
    p.valor,
    dt.descricao_tecnica
FROM
	tb_produtos AS p LEFT JOIN tb_descricoes_tecnicas AS dt ON (p.id_produto = dt.id_produto_fk)
WHERE 
	p.valor >= 500
ORDER BY
	p.valor ASC;
    
 
    /*---------------------------------------------------------------------*/     


	/*----------------------------aula 28--------------------------------*/
							 
                              /* EXERCÍCIOS */ 
                              
    /* 
		1) Selecione todos os clientes com idade igual ou superior a 29. 
		Os registros devem ser ordenados de forma ascendente pela idade. 
    */                          
                    
    SELECT
		*
	FROM 
		tb_clientes
	WHERE 
		idade >= 29
	ORDER BY
		idade ASC;
      
      /* 
		2) Utilize instruções do subconjunto DDL do SQL para realizar a inclusão das colunas
		   abaixo na tabela tb_clientes:
			• Adicine a coluna “sexo” do tipo string com tamanho fixo de 1 caractere. 
            Coluna não pode ser vazia na inserção.
			• Adicione a coluna “endereço” do tipo string com tamanho variado de até 
            150 caracteres. Coluna pode ser vazia na inserção.
      */
      
      ALTER TABLE tb_clientes ADD COLUMN sexo CHAR(1) NOT NULL;
	  ALTER TABLE tb_clientes ADD COLUMN endereco VARCHAR(150) NULL;
    
        
      /*
		3) Efetue um update em tb_clientes dos registros de id_cliente igual a 1, 2, 3, 6 
		   e 7, atualizando o sexo para “M”. Utilize a instrução IN para este fim.
	  */
      
      
UPDATE 
	tb_clientes
SET
	sexo = 'M'
WHERE
	id_cliente
    IN(1,2,3,4,6,7); 
    

	/* 
		4) Efetue um update em tb_clientes dos registros de id_cliente igual a 4, 5, 8, 9 e 10,
		atualizando o sexo para “F”. Como desafio, faça este update utilizando dois between’s 
		no filtro. 
    */
    
UPDATE 
	tb_clientes
SET
	sexo = 'F'
WHERE
	id_cliente
	BETWEEN 4 AND 5
		OR
	id_cliente
    BETWEEN 8 AND 10;
    
	/* 
    5) Selecione todos os registros de tb_clientes que possuam relação 
	   com tb_pedidos 
			e 
	   com tb_pedidos_produtos (apenas registros com relacionamentos entre si).
		
        Recupe também os detalhes dos produtos da tabela tb_produtos.
        
        A consulta deve retornar de tb_clientes as colunas “id_cliente”, “nome”, “idade” 
        e de tb_produtos deve ser retornado as colunas “produto” e “valor”. */


	SELECT 
	*
	FROM
		tb_clientes AS c
	INNER JOIN  
		tb_pedidos AS p
	ON 		
		(c.id_cliente = p.id_cliente_fk);


    
	SELECT 
	*
	FROM
			tb_clientes AS c
		INNER JOIN  
			tb_pedidos AS p
		ON 		
			(c.id_cliente = p.id_cliente_fk)
		INNER JOIN
			tb_pedidos_produtos AS pp
		ON
			(p.id_pedido= pp.id_pedido_fk);
        
        
	SELECT 
	*
	FROM
			tb_clientes AS c
		INNER JOIN  
			tb_pedidos AS p
		ON 		
			(c.id_cliente = p.id_cliente_fk)
		INNER JOIN
			tb_pedidos_produtos AS pp
		ON
			(p.id_pedido= pp.id_pedido_fk)
		INNER JOIN
			tb_produtos AS prod
		ON 
			(pp.id_produto_fk = prod.id_produto);
            
	SELECT 
		c.id_cliente,
        c.nome,
        c.idade,
        p.id_pedido,
	    prod.id_produto,
        prod.produto,
        prod.valor
	FROM
			tb_clientes AS c
		INNER JOIN  
			tb_pedidos AS p
		ON 		
			(c.id_cliente = p.id_cliente_fk)
		INNER JOIN
			tb_pedidos_produtos AS pp
		ON
			(p.id_pedido= pp.id_pedido_fk)
		INNER JOIN
			tb_produtos AS prod
		ON 
			(pp.id_produto_fk = prod.id_produto);
   
   
    
    
    /*--------------------------!!!!!!!!!!!!!!END!!!!!!!!!!!!!!!------------------------------------*/     
		
    
    
    
                    
                    
                    
                    
                    
                    
     
     
                    
                    
                    
						
