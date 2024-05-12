import 'package:biblioteca_app/model/detalles.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'dart:convert';

class LUsersRepository {
  Future<bool> verificarUsuarioExistente(String username) async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'LibroSphere', 
      username: 'postgres', 
      password: 'postges',
    );

    await connection.open();

    try {
      final result = await connection.query(
          'SELECT COUNT(*) FROM usuarios WHERE username = @username',
          substitutionValues: {'username': username});
      final count = result.first[0] as int;
      return count > 0;
    } catch (e) {
      print('Error al verificar usuario existente: $e');
      throw Exception('Error al verificar usuario existente.');
    }
  }
}