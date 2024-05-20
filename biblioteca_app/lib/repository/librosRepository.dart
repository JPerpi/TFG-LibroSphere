import 'package:biblioteca_app/model/libros.dart';
import 'package:postgres/postgres.dart';

class LibrosRepository {
  Future<List<Libros>> getLibros() async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    List<Libros> libros = [];
    try {
      await connection.open();
      List<List<dynamic>> results = await connection.query(
        'SELECT nombre, saga, "PosSaga", tipo, autor, genero, editorial, isbn, fechapubli, idioma, iduser, imagen FROM biblioteca.libros'
      );

      for (final row in results) {
        libros.add(Libros(
          nombre: row[0],
          saga: row[1] as String?,
          posSaga: row[2] as int?,
          tipo: row[3],
          autor: row[4] as String?,
          genero: row[5] as String?,
          editorial: row[6] as String?,
          isbn: row[7],
          fechaPubli: row[8] as String?,
          idioma: row[9] as String?,
          iduser: row[10] as String?,
          imagen: row[11] as String?,
        ));
      }
    } catch (e) {
      print('Error al obtener libros: $e');
    } finally {
      await connection.close();
    }
    return libros;
  }

  Future<bool> addLibro(Libros libro) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    
    try {
      final int result = await connection.execute(
        'INSERT INTO biblioteca.libros (nombre, saga, "PosSaga", tipo, autor, genero, editorial, isbn, fechapubli, idioma, iduser, imagen) VALUES (@nombre, @saga, @posSaga, @tipo, @autor, @genero, @editorial, @isbn, @fechaPubli, @idioma, @iduser, @imagen)',
        substitutionValues: {
          'nombre': libro.nombre,
          'saga': libro.saga,
          'posSaga': libro.posSaga,
          'tipo': libro.tipo,
          'autor': libro.autor,
          'genero': libro.genero,
          'editorial': libro.editorial,
          'isbn': libro.isbn,
          'fechaPubli': libro.fechaPubli,
          'idioma': libro.idioma,
          'iduser': libro.iduser,
          'imagen': libro.imagen
        }
      );
      return result == 1; // PostgreSQL retorna 1 si la fila se inserta correctamente
    } catch (e) {
      print('Error al insertar libro: $e');
      return false;
    }
  }

 Future<List<Libros>> getLibrosPorUsuario(String iduser) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();

    List<Libros> libros = [];
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT nombre, saga, "PosSaga", tipo, autor, genero, editorial, isbn, fechapubli, idioma, iduser, imagen FROM biblioteca.libros WHERE iduser = @iduser',
        substitutionValues: {'iduser': iduser}
      );

      for (final row in results) {
        libros.add(Libros(
          nombre: row[0],
          saga: row[1] as String?,
          posSaga: row[2] as int?,
          tipo: row[3],
          autor: row[4] as String?,
          genero: row[5] as String?,
          editorial: row[6] as String?,
          isbn: row[7],
          fechaPubli: row[8] as String?,
          idioma: row[9] as String?,
          iduser: row[10] as String?,
          imagen: row[11] as String?,
        ));
      }
    } catch (e) {
      print('Error al obtener libros: $e');
    } finally {
      await connection.close();
    }
    return libros;
  }

}
