import 'package:postgres/postgres.dart';
import 'package:bcrypt/bcrypt.dart';

class UsersRepository {
  PostgreSQLConnection _createConnection() {
    return PostgreSQLConnection(
      '192.168.1.189',  // Cambia a la IP correcta de tu servidor
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );
  }

  Future<bool> validarUsername(String username) async {
    final connection = _createConnection();
    await connection.open();

    try {
      final results = await connection.query(
        'SELECT COUNT(*) FROM biblioteca.users WHERE username = @username',
        substitutionValues: {'username': username},
      );
      int count = results.first[0] as int;
      return count > 0;
    } catch (e) {
      print('Error al verificar el nombre de usuario: $e');
      return false;
    } finally {
      await connection.close();
    }
  }

  Future<bool> validarLogin(String username, String password) async {
    final connection = _createConnection();
    await connection.open();

    try {
      final results = await connection.query(
        'SELECT password FROM biblioteca.users WHERE username = @username',
        substitutionValues: {'username': username},
      );

      if (results.isNotEmpty) {
        String hashedPassword = results.first[0] as String;
        return BCrypt.checkpw(password, hashedPassword);
      }

      return false;
    } catch (e) {
      print('Error al verificar la combinación de nombre de usuario y contraseña: $e');
      return false;
    } finally {
      await connection.close();
    }
  }

  Future<bool> registrarUsuario(String username, String password) async {
    final connection = _createConnection();
    await connection.open();

    try {
      String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      final int result = await connection.execute(
        "INSERT INTO biblioteca.users (username, password) VALUES (@username, @password)",
        substitutionValues: {'username': username, 'password': hashedPassword},
      );
      return result == 1;
    } catch (e) {
      print('Error al registrar usuario: $e');
      return false;
    } finally {
      await connection.close();
    }
  }
}
