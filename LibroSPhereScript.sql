-- DROP SCHEMA "Biblioteca";

CREATE SCHEMA "Biblioteca" AUTHORIZATION postgres;

COMMENT ON SCHEMA "Biblioteca" IS 'standard public schema';
-- "Biblioteca".libros definition

-- Drop table

-- DROP TABLE "Biblioteca".libros;

CREATE TABLE "Biblioteca".libros (
	nombre varchar NOT NULL,
	saga varchar NULL,
	"Pos-Saga" int4 NULL,
	autor varchar NULL,
	genero varchar null,
	editorial varchar NULL,
	isbn varchar NOT NULL,
	"Fecha-Publi" varchar NULL,
	idioma varchar NULL,
	CONSTRAINT libros_pk PRIMARY KEY (isbn)
);



-- "Biblioteca".users definition

-- Drop table

-- DROP TABLE "Biblioteca".users;

CREATE TABLE "Biblioteca".users (
	username varchar NOT NULL,
	"password" varchar NULL,
	CONSTRAINT usersname_pk PRIMARY KEY (username)
);


INSERT INTO users (username, "password")
VALUES ('admin','admin');

INSERT INTO libros (nombre, saga, "Pos-Saga", autor, genero, editorial, isbn, "Fecha-Publi", idioma)
VALUES 
('El Ojo del Mundo', 'La Rueda del Tiempo', 1, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007006', '2019-10-15', 'Español'),
('La Gran Caceria', 'La Rueda del Tiempo', 2, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007013', '2019-11-19', 'Español'),
('El Dragón Renacido', 'La Rueda del Tiempo', 3, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007020', '2020-01-16', 'Español'),
('El Ascenso de la Sombra', 'La Rueda del Tiempo', 4, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007037', '2020-03-10', 'Español'),
('Cielo en Llamas', 'La Rueda del Tiempo', 5, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007044', '2020-05-19', 'Español'),
('El Señor del Caos', 'La Rueda del Tiempo', 6, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007051', '2020-06-02', 'Español'),
('La Corona de Espadas', 'La Rueda del Tiempo', 7, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007068', '2020-09-17', 'Español'),
('El Camino de Dagas', 'La Rueda del Tiempo', 8, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007075', '2020-10-29', 'Español'),
('El Corazón del invierno', 'La Rueda del Tiempo', 9, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007082', '2021-01-20', 'Español'),
('Encrucijada en el crepúsculo', 'La Rueda del Tiempo', 10, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007099', '2021-03-17', 'Español'),
('Cuchillo de sueños', 'La Rueda del Tiempo', 11, 'Robert Jordan','Fantasia', 'Minotauro', '9788445007105', '2021-05-30', 'Español'),
('La tormenta', 'La Rueda del Tiempo', 12, 'Robert Jordan, Brandon Sanderson','Fantasia', 'Minotauro', '9788445007112', '2021-09-09', 'Español'),
('Torres de Medianoche', 'La Rueda del Tiempo', 13, 'Robert Jordan, Brandon Sanderson','Fantasia', 'Minotauro', '9788445007129', '2021-10-20', 'Español'),
('Un Recurdo de Luz', 'La Rueda del Tiempo', 14, 'Robert Jordan, Brandon Sanderson','Fantasia', 'Minotauro', '9788445007136', '2021-11-10', 'Español'),
('Alas de Sangre', 'Empireo', 1, 'Rebecca Yarros','Fantasia', 'Planeta', '9788408279990', '2023-11-15', 'Español'),
('Alas de Hierro', 'Empireo', 2, 'Rebecca Yarros','Fantasia', 'Planeta', '9788408284550', '2024-02-21', 'Español'),
('La Riada','Blackwater', 1,'Michael McDowel','Horror','Blackie Books','9788419654892','2024-02-07','Español' ),
('El Dique','Blakwater', 2,'Michael McDowel','Horror','Blackie Books','9788419654915','2024-02-21','Español' ),
('La Casa','Blackwater', 3,'Michael McDowel','Horror','Blackie Books','9788419654939','2024-03-06','Español' ),
('La Guerra','Blackwater', 4,'Michael McDowel','Horror','Blackie Books','9788419654953','2024-03-20','Español' ),
('La Fortuna','Blackwater', 5,'Michael McDowel','Horror','Blackie Books','9788419654977','2024-04-03','Español' ),
('Lluvia','Blackwater', 6,'Michael McDowel','Horror','Blackie Books','9788419654991','2024-04-17','Español' ),
('SKULDUGGERY PLEASANT','Skulduggery Pleasant ', 1,'Derek Landy','Fantasia','SM','9788467519846','2007-09-19','Español' ),
('Jugando con Fuego','Skulduggery Pleasant ', 2,'Derek Landy','Fantasia','SM','9788467530773','2008-29-25','Español' ),
('Los Sin Rostro','Skulduggery Pleasant ', 3,'Derek Landy','Fantasia','SM','9788467536157','2009-10-02','Español' ),
('Dias Oscuros','Skulduggery Pleasant ', 4,'Derek Landy','Fantasia','SM','9788467548020','2011-03-23','Español' ),
('Ataduras Mortales','Skulduggery Pleasant ', 5,'Derek Landy','Fantasia','SM','9788467554366','2012-03-14','Español' ),
('La Invocadora de la Muerte','Skulduggery Pleasant ', 6,'Derek Landy','Fantasia','SM','9788467561593','2013-06-06','Español' ),
('El Reino de los Malvados','Skulduggery Pleasant ', 7,'Derek Landy','Fantasia','SM','9788467571653','2014-05-28','Español' ),
('La Ultima Batalla de los Hombres Cadaver','Skulduggery Pleasant', 8,'Derek Landy','Fantasia','SM','9788467582741','2015-09-23','Español' ),
('La Muerte de la Luz','Skulduggery Pleasant', 9,'Derek Landy','Fantasia','SM','9788467590609','2016-09-22','Español' ),
('Resurreccion','Skulduggery Pleasant', 10,'Derek Landy','Fantasia','SM','9788491072850','2018-04-05','Español' );