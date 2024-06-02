class Libros {
  late String isbn;
  late String nombre;
  String? saga;
  int? posSaga;
  String? tipo;
  String? autor;
  String? genero;
  String? editorial;
  String? fechaPubli;
  String? idioma;
  String? imagen;

  Libros({
    required this.isbn,
    required this.nombre,
    this.saga,
    this.posSaga,
    this.tipo,
    this.autor,
    this.genero,
    this.editorial,
    this.fechaPubli,
    this.idioma,
    this.imagen,
  });

  @override
  String toString() =>
      "$isbn; $nombre; $saga; $posSaga; $tipo; $autor; $genero; $editorial; $fechaPubli; $idioma; $imagen";
}
