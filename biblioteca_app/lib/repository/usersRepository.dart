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
            'SELECT COUNT(*) FROM biblioteca.users WHERE username = @username',
            substitutionValues: {'username': username},
        );
        int count = results.first[0] as int;
        return count > 0;
    } catch (e) {
        print('Error al verificar el nombre de usuario: $e');
        return false;
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
      return results.isNotEmpty && results.first[0] as int > 0;
    } catch (e) {
      print(
          'Error al verificar la combinación de nombre de usuario y contraseña: $e');
      return false;
    } finally {
      await connection.close();
    }
  }

  Future<bool> registrarUsuario(String username, String password) async {
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
          "INSERT INTO biblioteca.users (username, password) VALUES (@username, @password)",
          substitutionValues: {'username': username, 'password': password});
      return result == 1;
    } catch (e) {
      print('Error al registrar usuario: $e');
      return false;
    }
  }
}
