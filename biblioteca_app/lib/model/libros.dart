class Libros {
  late String titulo;
  String? saga;
  String? img;
  String? autor;
  String? genero;
  String? tipo;

  // Constructor amb arguments amb nom,
  // obligatoris i opcionals

  Libros({required this.titulo, this.saga, this.img, this.autor,this.genero,this.tipo});
  Libros.fromJSON(Map<String, dynamic> objecteJSON) {
    titulo = objecteJSON["titulo"] ?? "";
    saga = objecteJSON["saga"] ?? "";
    img = objecteJSON["img"] ?? "";
    autor = objecteJSON["autor"] ?? "";
    genero = objecteJSON["genero"] ?? "";
    tipo = objecteJSON["tipo"] ?? "";
  }
  @override
  String toString() => "$titulo; $saga; $img; $autor; $genero; $tipo";
}