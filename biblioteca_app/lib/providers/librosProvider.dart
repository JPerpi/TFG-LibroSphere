import 'package:flutter/material.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/repository/librosRepository.dart';

class ProviderLibros extends ChangeNotifier {
  final LibrosRepository _librosRepository = LibrosRepository();
  List<Libros>? _libros;
  List<Libros>? _filteredLibros;
  List<String> _generos = [];
  List<String> _tipos = [];

  List<Libros>? get libros => _filteredLibros ?? _libros;
  List<String> get generos => _generos;
  List<String> get tipos => _tipos;

  Future<void> cargarLibrosPorUsuario(String userId) async {
    _libros = await _librosRepository.obtenerLibrosPorUsuario(userId);
    _filteredLibros = _libros;
    notifyListeners();
  }

  Future<void> cargarGeneros() async {
    _generos = await _librosRepository.obtenerGeneros();
    notifyListeners();
  }

  Future<void> cargarTipos() async {
    _tipos = await _librosRepository.obtenerTipos();
    notifyListeners();
  }

  Future<void> agregarLibroParaUsuario(Libros libro, String userId) async {
    await _librosRepository.agregarLibroParaUsuario(libro, userId);
    _libros?.add(libro);
    _filteredLibros = _libros;
    notifyListeners();
  }

  Future<Libros?> obtenerLibroPorISBN(String isbn) async {
    return await _librosRepository.obtenerLibroPorISBN(isbn);
  }

  Future<List<Libros>> obtenerTodosLosLibros() async {
    return await _librosRepository.obtenerTodosLosLibros();
  }

  void clearLibros() {
    _libros = null;
    _filteredLibros = null;
    notifyListeners();
  }

  void buscarLibros(String query) {
    if (query.isEmpty) {
      _filteredLibros = _libros;
    } else {
      _filteredLibros = _libros?.where((libro) {
        return libro.nombre.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void filtrarPorTipo(String tipo) {
    if (tipo.isEmpty) {
      _filteredLibros = _libros;
    } else {
      _filteredLibros = _libros?.where((libro) => libro.tipo == tipo).toList();
    }
    notifyListeners();
  }

  void filtrarPorGenero(String genero) {
    if (genero.isEmpty) {
      _filteredLibros = _libros;
    } else {
      _filteredLibros = _libros?.where((libro) => libro.genero == genero).toList();
    }
    notifyListeners();
  }

  void ordenarLibros(bool ascendente) {
    _filteredLibros?.sort((a, b) => ascendente
        ? a.nombre.compareTo(b.nombre)
        : b.nombre.compareTo(a.nombre));
    notifyListeners();
  }
}
