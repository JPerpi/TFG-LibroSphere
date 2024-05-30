class Review {
  int? personajes;
  int? relaciones;
  int? mundo;
  String? personajeFavorito;
  String? personajeOdiado;
  String? review;
  String? fraseFavorita;
  String? capituloFavorito;
  String libroId;
  String nombre;
  String fechaInicio;
  String fechaFinal;

  Review({
    this.personajes,
    this.relaciones,
    this.mundo,
    this.personajeFavorito,
    this.personajeOdiado,
    this.review,
    this.fraseFavorita,
    this.capituloFavorito,
    required this.libroId,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFinal,
  });

  @override
  String toString() =>
      "$libroId; $nombre; $personajes; $relaciones; $mundo; $personajeFavorito; $personajeOdiado; $review; $fraseFavorita; $capituloFavorito; $fechaInicio; $fechaFinal;";
}
