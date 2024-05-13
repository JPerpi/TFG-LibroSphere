class Libros {
  late String nombre;
  String? saga;
  int? posSaga;
  String? tipo;
  String? autor;
  String? genero;
  String? editorial;
  String? isbn;
  String? fechaPubli;
  String? idioma;

  Libros({
    required this.nombre,
    this.saga,
    this.posSaga,
    this.tipo,
    this.autor,
    this.genero,
    this.editorial,
    required this.isbn,
    this.fechaPubli,
    this.idioma,
  });

  @override
  String toString() =>
      "$nombre; $saga; $tipo; $autor; $genero; $editorial; $isbn; $fechaPubli; $idioma";
}
