import 'package:biblioteca_app/model/libros.dart';
import 'package:postgres/postgres.dart';

class LibrosRepository {
  Future<List<Libros>> obtenerLibrosPorUsuario(String userId) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      //'192.168.31.154',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT * FROM biblioteca.libros l JOIN biblioteca.colecciones c ON l.isbn = c.libro_id WHERE c.iduser = @userId',
        substitutionValues: {'userId': userId},
      );

      List<Libros> libros = [];
      for (var row in results) {
        libros.add(Libros(
          isbn: row[0] as String,
          nombre: row[1] as String,
          saga: row[2] as String?,
          posSaga: row[3] as int?,
          tipo: row[4] as String,
          autor: row[5] as String?,
          genero: row[6] as String?,
          editorial: row[7] as String?,
          fechaPubli: row[8] as String?,
          idioma: row[9] as String?,
          imagen: row[10] as String?,
        ));
      }
      return libros;
    } finally {
      await connection.close();
    }
  }

  Future<List<String>> obtenerGeneros() async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      //'192.168.31.154',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT DISTINCT genero FROM biblioteca.libros WHERE genero IS NOT NULL',
      );

      List<String> generos = [];
      for (var row in results) {
        generos.add(row[0] as String);
      }
      return generos;
    } finally {
      await connection.close();
    }
  }

  Future<List<String>> obtenerTipos() async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      //'192.168.31.154',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT DISTINCT tipo FROM biblioteca.libros',
      );

      List<String> tipos = [];
      for (var row in results) {
        tipos.add(row[0] as String);
      }
      return tipos;
    } finally {
      await connection.close();
    }
  }

  Future<void> agregarLibroParaUsuario(Libros libro, String userId) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      //'192.168.31.154',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      // Verificar si el libro ya existe en la tabla de libros
      List<List<dynamic>> existingBooks = await connection.query(
        'SELECT isbn FROM biblioteca.libros WHERE isbn = @isbn',
        substitutionValues: {'isbn': libro.isbn},
      );

      // Si el libro no existe, agregarlo a la tabla de libros
      if (existingBooks.isEmpty) {
        await connection.query(
          'INSERT INTO biblioteca.libros (isbn, nombre, saga, "PosSaga", tipo, autor, genero, editorial, FechaPubli, idioma, imagen) VALUES (@isbn, @nombre, @saga, @posSaga, @tipo, @autor, @genero, @editorial, @fechaPubli, @idioma, @imagen)',
          substitutionValues: {
            'isbn': libro.isbn,
            'nombre': libro.nombre,
            'saga': libro.saga,
            'posSaga': libro.posSaga,
            'tipo': libro.tipo,
            'autor': libro.autor,
            'genero': libro.genero,
            'editorial': libro.editorial,
            'fechaPubli': libro.fechaPubli,
            'idioma': libro.idioma,
            'imagen': libro.imagen,
          },
        );
      }

      // Agregar libro a la colección del usuario
      await connection.query(
        'INSERT INTO biblioteca.colecciones (iduser, libro_id) VALUES (@userId, @isbn)',
        substitutionValues: {'userId': userId, 'isbn': libro.isbn},
      );
    } finally {
      await connection.close();
    }
  }

  Future<Libros?> obtenerLibroPorISBN(String isbn) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      //'192.168.31.154',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT * FROM biblioteca.libros WHERE isbn = @isbn',
        substitutionValues: {'isbn': isbn},
      );

      if (results.isNotEmpty) {
        final row = results.first;
        return Libros(
          isbn: row[0] as String,
          nombre: row[1] as String,
          saga: row[2] as String?,
          posSaga: row[3] as int?,
          tipo: row[4] as String,
          autor: row[5] as String?,
          genero: row[6] as String?,
          editorial: row[7] as String?,
          fechaPubli: row[8] as String?,
          idioma: row[9] as String?,
          imagen: row[10] as String?,
        );
      }
      return null;
    } finally {
      await connection.close();
    }
  }

  Future<List<Libros>> obtenerTodosLosLibros() async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      //'192.168.31.154',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT * FROM biblioteca.libros',
      );

      List<Libros> libros = [];
      for (var row in results) {
        libros.add(Libros(
          isbn: row[0] as String,
          nombre: row[1] as String,
          saga: row[2] as String?,
          posSaga: row[3] as int?,
          tipo: row[4] as String,
          autor: row[5] as String?,
          genero: row[6] as String?,
          editorial: row[7] as String?,
          fechaPubli: row[8] as String?,
          idioma: row[9] as String?,
          imagen: row[10] as String?,
        ));
      }
      return libros;
    } finally {
      await connection.close();
    }
  }
}
