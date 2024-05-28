import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/repository/librosRepository.dart';
import 'package:flutter/material.dart';

class ProviderLibros with ChangeNotifier {
  final _librosRepository=LibrosRepository();

  List<Libros>? libros;

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

  void clearLibros() {
    libros = null;
    notifyListeners();
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
  if (libros == null) return null;
  for (var libro in libros!) {
    if (libro.nombre == nombre) {
      return libro;
    }
  }

  return null; 
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
    String? imagen
  ) async {
    try {
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
