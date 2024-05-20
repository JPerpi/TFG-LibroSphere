import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/repository/librosRepository.dart';
import 'package:flutter/material.dart';

class ProviderLibros with ChangeNotifier {
  final _librosRepository=LibrosRepository();

  List<Libros>? libros;

  // Asegúrate de que el repositorio recibe la conexión a PostgreSQL
  ProviderLibros() {
    cargarLibros();
  }

  Future<void> cargarLibros() async {
    try {
      libros = await _librosRepository.getLibros();
      notifyListeners();
    } catch (error) {
      print('Error al cargar libros: $error');
    }
  }

  Future<void> cargarLibrosPorUsuario(String iduser) async {
    try {
      libros = await _librosRepository.getLibrosPorUsuario(iduser);
      notifyListeners();
    } catch (error) {
      print('Error al cargar libros: $error');
    }
  }

  Libros? libroPorNombre(String nombre) {
  if (libros == null) return null; // Si la lista de libros es nula, retorna null directamente.

  // Itera sobre la lista de libros y retorna el primero que coincida con el nombre.
  for (var libro in libros!) {
    if (libro.nombre == nombre) {
      return libro;
    }
  }

  return null; // Retorna null si ningún libro coincide.
}

  Future<bool> agregarLibro(
    String nombre,
    String autor,
    String saga,
    int? posSaga,
    String tipo,
    String genero,
    String isbn,
    String editorial,
    String? fechaPubli,
    String idioma,
    String? iduser,
    String? imagen // Asegúrate de manejar el id de usuario correctamente según tu lógica de negocio
  ) async {
    try {
      // Crear una nueva instancia de Libro
      Libros nuevoLibro = Libros(
        nombre: nombre,
        autor: autor,
        saga: saga,
        posSaga: posSaga,
        tipo: tipo,
        genero: genero,
        isbn: isbn,
        editorial: editorial,
        fechaPubli: fechaPubli,
        idioma: idioma,
        iduser: iduser,
        imagen:imagen,
      );

      // Agregar el libro a través del repositorio
      bool resultado = await _librosRepository.addLibro(nuevoLibro);
      if (resultado) {
        libros?.add(nuevoLibro);
        notifyListeners();
      }
      return resultado;
    } catch (e) {
      print('Error al agregar el libro: $e');
      return false;
    }
  }
}
