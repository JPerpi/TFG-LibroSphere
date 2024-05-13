/* import 'package:biblioteca_app/model/detalles.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'dart:convert';

class LibrosRepository {
  Future<List<Libros>> getLibros(String tipo) async {
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
      'SELECT titulo, saga, img, autor, genero, tipo FROM libros WHERE tipo = @tipo',
      substitutionValues: {'tipo': tipo},
    );

    // Creamos una lista vacía para almacenar los objetos Libros
    List<Libros> listaLibros = [];

    // Iteramos sobre los resultados de la consulta y creamos un objeto Libros para cada fila
    for (final row in results) {
      // Creamos un nuevo objeto Libros utilizando el constructor
      Libros libro = Libros(
        nombre: row[0],
        saga: row[1],
        saga: row[1],
        tipo: row[2],
        autor: row[3],
        genero: row[4],
        editorial: row[5],
        isbn: row[5],
        fechaPubli: row[5],
        idioma: row[5],
      );
      // Añadimos el objeto Libros a la lista
      listaLibros.add(libro);
    }

    // Devolvemos la lista completa de objetos Libros
    return listaLibros;
  } catch (e) {
    print('Error al obtener tipos: $e');
    // Si hay un error, devolvemos una lista vacía
    return [];
  } finally {
    // Cerramos la conexión a la base de datos
    await connection.close();
  }
}

  Future<List<dynamic>> obtenerTipos() async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'LibroSphere', 
      username: 'postgres', 
      password: 'postges',
    );

    await connection.open();

    try {
      final results = await connection.query('SELECT tipo FROM libros');
      return results;
    } catch (e) {
      print('Error al obtener libros por tipo: $e');
      return [];
    } finally {
      await connection.close();
    }
  }

    Future<List<dynamic>> getDetalls(String titulo) async {
    final connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'LibroSphere', 
      username: 'postgres', 
      password: 'postges',
    );

    await connection.open();

    try {
      final results = await connection.query('SELECT * FROM libros WHERE nombre = @titulo', substitutionValues: {'nombre': titulo});
      return results;
    } catch (e) {
      print('Error al obtener libros por tipo: $e');
      return [];
    } finally {
      await connection.close();
    }
  }
} */