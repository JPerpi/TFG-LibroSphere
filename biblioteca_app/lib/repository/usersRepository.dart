import 'package:biblioteca_app/model/detalles.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'dart:convert';

class usersRepository {
  Future<bool> validarUSername(String username) async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postges',
    );

    await connection.open();

    try {
      final results = await connection.query(
        'SELECT COUNT(*) FROM users WHERE username = @username',
        substitutionValues: {'username': username},
      );

      // Si hay al menos una fila en los resultados, significa que el nombre de usuario existe
      return results.isNotEmpty;
    } catch (e) {
      print('Error al verificar el nombre de usuario: $e');
      // En caso de error, consideramos que el nombre de usuario no existe
      return false;
    } finally {
      await connection.close();
    }
  }

  Future<bool> validarLogin(String username, String password) async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postges',
    );

    await connection.open();

    try {
      final results = await connection.query(
        'SELECT COUNT(*) FROM users WHERE username = @username AND password = @password',
        substitutionValues: {'username': username, 'password': password},
      );

      // Si hay al menos una fila en los resultados, significa que la combinación de nombre de usuario y contraseña es válida
      return results.isNotEmpty;
    } catch (e) {
      print('Error al verificar la combinación de nombre de usuario y contraseña: $e');
      // En caso de error, consideramos que la combinación de nombre de usuario y contraseña no es válida
      return false;
    } finally {
      await connection.close();
    }
  }
}