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
    password VARCHAR,
    profile_picture VARCHAR(255)
);

-- DROP TABLE IF EXISTS biblioteca.libros CASCADE;

CREATE TABLE biblioteca.libros (
	isbn VARCHAR(255) PRIMARY KEY,
    nombre VARCHAR(255),
    saga VARCHAR(255),
    "PosSaga" INTEGER,
    tipo biblioteca.tipolibro NOT NULL,
    autor VARCHAR(255),
    genero VARCHAR(255),
    editorial VARCHAR(255),
    FechaPubli VARCHAR(255),
    idioma VARCHAR(255),
    imagen VARCHAR(255)
);

-- DROP TABLE IF EXISTS biblioteca.resenas CASCADE;

CREATE TABLE biblioteca.resenas (
    personajes INT,
    relaciones INT,
    mundo INT,
    personajeFavorito VARCHAR(255),
    personajeOdiado VARCHAR(255),
    review TEXT,
    fraseFavorita VARCHAR(255),
    capituloFavorito VARCHAR(255),
    libro_id VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    fechaInicio VARCHAR(255),
    fechaFinal VARCHAR(255),
    CONSTRAINT resenas_pk PRIMARY KEY (libro_id, username),
    CONSTRAINT resenas_libro_fk FOREIGN KEY (libro_id) REFERENCES biblioteca.libros(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT resenas_user_fk FOREIGN KEY (username) REFERENCES biblioteca.users(username) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla de unión para relacionar usuarios y libros
-- DROP TABLE IF EXISTS biblioteca.colecciones CASCADE;

CREATE TABLE biblioteca.colecciones (
    id SERIAL PRIMARY KEY,
    iduser VARCHAR(255) NOT NULL,
    libro_id VARCHAR NOT NULL,
    CONSTRAINT colecciones_libros_fk FOREIGN KEY (libro_id) REFERENCES biblioteca.libros(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT colecciones_users_fk FOREIGN KEY (iduser) REFERENCES biblioteca.users(username) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Insertar usuario de ejemplo
INSERT INTO biblioteca.users (username, password, profile_picture)
VALUES ('admin', 'admin', NULL);

-- Insertar libros de ejemplo
INSERT INTO biblioteca.libros (isbn, nombre, saga, "PosSaga", tipo, autor, genero, editorial, FechaPubli, idioma, imagen) 
VALUES 
('9788445007006', 'El Ojo del Mundo', 'La Rueda del Tiempo', 1, 'novela', 'Robert Jordan', 'Fantasia', 'Minotauro',  '2019-10-15', 'Español', 'https://proassetspdlcom.cdnstatics2.com/usuaris/libros/fotos/300/original/portada_el-ojo-del-mundo-n-0114_robert-jordan_201910151031.jpg');

-- Insertar relaciones entre usuario y libros
-- Supongamos que los IDs obtenidos son 1 y 2
INSERT INTO biblioteca.colecciones(iduser, libro_id) VALUES ('admin', '9788445007006');

-- Insertar reseñas de ejemplo
-- Supongamos que el libro con ID 1 es 'El Ojo del Mundo'
INSERT INTO biblioteca.resenas (personajes, relaciones, mundo, personajeFavorito, personajeOdiado, review, fraseFavorita, capituloFavorito, libro_id,  username, nombre, fechaInicio, fechaFinal)
VALUES (7, 8, 7, 'Perrin', 'Ishamael', 'Libro de fantasía juvenil bien elaborado', '!Violencia¡', '24', '9788445007006','admin', 'El Ojo del Mundo', '05/21', '06/21');
