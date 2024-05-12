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
    "FechaPubli" DATE,
    idioma VARCHAR(255),
    iduser VARCHAR(255),
    CONSTRAINT libros_iduser_fk FOREIGN KEY (iduser) REFERENCES biblioteca.users(username) ON DELETE CASCADE ON UPDATE CASCADE
);

-- DROP TABLE IF EXISTS biblioteca.resenas CASCADE;

CREATE TABLE biblioteca.resenas (
    personajes INTEGER NOT NULL,
    relaciones INTEGER NOT NULL,
    mundo INTEGER NOT NULL,
    pjfavorito VARCHAR(255) NOT NULL,
    pjodiado VARCHAR(255) NOT NULL,
    resena TEXT NOT NULL,
    frasefav VARCHAR(255) NOT NULL,
    capitulofav INTEGER NOT NULL,
    nombre VARCHAR(255),
    CONSTRAINT resenas_pk PRIMARY KEY (nombre),
    CONSTRAINT resenas_libros_fk FOREIGN KEY (nombre) REFERENCES biblioteca.libros(nombre) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO biblioteca.users (username, password)
VALUES ('admin', 'admin');

INSERT INTO biblioteca.libros (nombre, saga, "PosSaga", tipo, autor, genero, editorial, isbn, "FechaPubli", idioma, iduser)
 VALUES
 ('El Ojo del Mundo', 'La Rueda del Tiempo', 1, 'novela', 'Robert Jordan', 'Fantasia', 'Minotauro', '9788445007006', '2019-10-15', 'Español', 'admin'),
 ('La Gran Caceria', 'La Rueda del Tiempo', 2, 'novela', 'Robert Jordan', 'Fantasia', 'Minotauro', '9788445007013', '2019-11-19', 'Español', 'admin');

INSERT INTO biblioteca.resenas (personajes, relaciones, mundo, pjfavorito, pjodiado, resena, frasefav, capitulofav, nombre)
 VALUES (7, 8, 7, 'Perrin', 'Ishamael', 'Libro de fanasia juvenil bien elaborado', '!Violencia¡', 24, 'El Ojo del Mundo');
