-- DROP SCHEMA IF EXISTS biblioteca CASCADE;

CREATE SCHEMA biblioteca AUTHORIZATION postgres;

CREATE TYPE biblioteca.tipolibro AS ENUM (
 'novela',
 'poemario',
 'manga',
 'comic'
);

-- DROP TABLE IF EXISTS biblioteca.users CASCADE;

CREATE TABLE biblioteca.users (
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR
);

-- DROP TABLE IF EXISTS biblioteca.libros CASCADE;

CREATE TABLE biblioteca.libros (
    nombre VARCHAR(255) PRIMARY KEY,
    saga VARCHAR(255),
    "PosSaga" INTEGER,
    tipo biblioteca.tipolibro NOT NULL,
    autor VARCHAR(255),
    genero VARCHAR(255),
    editorial VARCHAR(255),
    isbn VARCHAR(255) NOT NULL,
    FechaPubli varchar (255),
    idioma VARCHAR(255),
    iduser VARCHAR(255),
    imagen VARCHAR(255),
    CONSTRAINT libros_iduser_fk FOREIGN KEY (iduser) REFERENCES biblioteca.users(username) ON DELETE CASCADE ON UPDATE CASCADE
);

-- DROP TABLE IF EXISTS biblioteca.resenas CASCADE;

CREATE TABLE biblioteca.resenas (
	personajes int4 NULL,
	relaciones int4 NULL,
	mundo int4 NULL,
	personajeFavorito varchar(255) NULL,
	personajeOdiado varchar(255) NULL,
	review text NULL,
	fraseFavorita varchar(255) NULL,
	capituloFavorito varchar NULL,
	nombre varchar(255) NOT NULL,
	fechaInicio varchar NOT NULL,
	fechaFinal varchar NOT NULL,
	CONSTRAINT resenas_pk PRIMARY KEY (nombre),
	CONSTRAINT resenas_libros_fk FOREIGN KEY (nombre) REFERENCES biblioteca.libros(nombre) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO biblioteca.users (username, password)
VALUES ('admin', 'admin');

INSERT INTO biblioteca.libros (nombre, saga, "PosSaga", tipo, autor, genero, editorial, isbn, FechaPubli, idioma, iduser,imagen)
 VALUES
 ('El Ojo del Mundo', 'La Rueda del Tiempo', 1, 'novela', 'Robert Jordan', 'Fantasia', 'Minotauro', '9788445007006', '2019-10-15', 'Español', 'admin','https://proassetspdlcom.cdnstatics2.com/usuaris/libros/fotos/300/original/portada_el-ojo-del-mundo-n-0114_robert-jordan_201910151031.jpg'),
 ('La Gran Caceria', 'La Rueda del Tiempo', 2, 'novela', 'Robert Jordan', 'Fantasia', 'Minotauro', '9788445007013', '2019-11-19', 'Español', 'admin','/home/jperpi/Descargas/914DPO9905L._AC_UF894,1000_QL80_.jpg');

INSERT INTO biblioteca.resenas (personajes, relaciones, mundo, personajeFavorito, personajeOdiado, review, fraseFavorita, capituloFavorito, nombre, fechaInicio,fechaFinal)
 VALUES (7, 8, 7, 'Perrin', 'Ishamael', 'Libro de fanasia juvenil bien elaborado', '!Violencia¡', 24, 'El Ojo del Mundo','05/21','06/21');
