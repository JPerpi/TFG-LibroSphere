class Detalles {
  late String titulo;
  String? saga;
  String? img;
  String? autor;
  String? genero;
  String? paginas;
  String? editorial;
  String? idioma;
  String? fechaPubli;
  String? isbn;
  String? edadLectura;
  String? posSaga;

  // Constructor amb arguments amb nom,
  // obligatoris i opcionals

  Detalles({required this.titulo, this.saga, this.img, this.autor,this.genero,this.paginas,this.editorial,this.idioma,this.fechaPubli,this.isbn,this.edadLectura,this.posSaga});
  Detalles.fromJSON(Map<String, dynamic> objecteJSON) {
    titulo = objecteJSON["titulo"] ?? "";
    saga = objecteJSON["saga"] ?? "";
    img = objecteJSON["img"] ?? "";
    autor = objecteJSON["autor"] ?? "";
    genero = objecteJSON["genero"] ?? "";
    paginas = objecteJSON["paginas"] ?? "";
    editorial = objecteJSON["editorial"] ?? "";
    idioma = objecteJSON["idioma"] ?? "";
    fechaPubli = objecteJSON["fechaPubli"] ?? "";
    isbn = objecteJSON["isbn"] ?? "";
    edadLectura = objecteJSON["edadLectura"] ?? "";
    posSaga = objecteJSON["posSaga"] ?? "";
  }
  @override
  String toString() => "$titulo; $saga; $img; $autor; $genero; $paginas; $editorial; $idioma; $fechaPubli; $isbn; $edadLectura";
}