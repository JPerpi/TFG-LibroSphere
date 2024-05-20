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
  String? iduser;
  String? imagen;

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
    this.iduser,
    this.imagen,
  });

  @override
  String toString() =>
      "$nombre; $saga; $tipo; $autor; $genero; $editorial; $isbn; $fechaPubli; $idioma; $iduser";
}
