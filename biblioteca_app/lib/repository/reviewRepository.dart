import 'package:biblioteca_app/model/review.dart';
import 'package:postgres/postgres.dart';

class ReviewRepository {
  Future<List<Review>> getReviewsForBook(String libroId) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      List<List<dynamic>> results = await connection.query(
        'SELECT * FROM biblioteca.resenas WHERE libro_id = @libro_id',
        substitutionValues: {'libro_id': libroId},
      );

      List<Review> reviews = [];
      for (var row in results) {
        reviews.add(Review(
          personajes: row[0] as int?,
          relaciones: row[1] as int?,
          mundo: row[2] as int?,
          personajeFavorito: row[3] as String?,
          personajeOdiado: row[4] as String?,
          review: row[5] as String?,
          fraseFavorita: row[6] as String?,
          capituloFavorito: row[7] as String?,
          libroId: row[8] as String,
          nombre: row[9] as String,
          fechaInicio: row[10] as String,
          fechaFinal: row[11] as String,
        ));
      }

      return reviews;
    } catch (e) {
      print('Error al obtener reseñas: $e');
      return [];
    } finally {
      await connection.close();
    }
  }

  Future<void> addReview(Review review) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();
    try {
      await connection.query(
        'INSERT INTO biblioteca.resenas (personajes, relaciones, mundo, personajeFavorito, personajeOdiado, review, fraseFavorita, capituloFavorito, libro_id, nombre, fechaInicio, fechaFinal) VALUES (@personajes, @relaciones, @mundo, @personajeFavorito, @personajeOdiado, @review, @fraseFavorita, @capituloFavorito, @libro_id, @nombre, @fechaInicio, @fechaFinal)',
        substitutionValues: {
          'personajes': review.personajes,
          'relaciones': review.relaciones,
          'mundo': review.mundo,
          'personajeFavorito': review.personajeFavorito,
          'personajeOdiado': review.personajeOdiado,
          'review': review.review,
          'fraseFavorita': review.fraseFavorita,
          'capituloFavorito': review.capituloFavorito,
          'libro_id': review.libroId,
          'nombre': review.nombre,
          'fechaInicio': review.fechaInicio,
          'fechaFinal': review.fechaFinal,
        },
      );
    } catch (e) {
      print('Error al agregar reseña: $e');
    } finally {
      await connection.close();
    }
  }
}
