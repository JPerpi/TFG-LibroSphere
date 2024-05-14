import 'package:biblioteca_app/model/detalles.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'dart:convert';

class UsersRepository {
  Future<bool> validarUsername(String username) async {
    final connection = PostgreSQLConnection(
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
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
      '192.168.1.189',
      5432,
      'LibroSphere',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();

    try {
      final results = await connection.query(
        'SELECT COUNT(*) FROM biblioteca.users WHERE username = @username AND password = @password',
        substitutionValues: {'username': username, 'password': password},
      );

      // Comprobar si hay algún registro que coincida
      return results.isNotEmpty && results.first[0] as int > 0;
    } catch (e) {
      print('Error al verificar la combinación de nombre de usuario y contraseña: $e');
      return false;
    } finally {
      await connection.close();
    }
  }
}