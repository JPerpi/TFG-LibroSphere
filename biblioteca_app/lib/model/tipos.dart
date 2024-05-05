class Tipos {
  late String tipo;
  String? img;

  // Constructor amb arguments amb nom,
  // obligatoris i opcionals

  Tipos({required this.tipo, this.img});
  Tipos.fromJSON(Map<String, dynamic> objecteJSON) {
    tipo = objecteJSON["tipo"] ?? "";
    img = objecteJSON["img"] ?? "";
  }
  @override
  String toString() => "$tipo; $img";
}