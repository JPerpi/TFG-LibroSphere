import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/model/review.dart';
import 'package:biblioteca_app/providers/reviewProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biblioteca_app/Widgets/imgController.dart';

class VerReviewScreen extends StatefulWidget {
  final Libros libro;

  const VerReviewScreen({Key? key, required this.libro}) : super(key: key);

  @override
  _VerReviewScreenState createState() => _VerReviewScreenState();
}

class _VerReviewScreenState extends State<VerReviewScreen> {
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  void _loadReviews() async {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    final reviews = await reviewProvider.getReviewsForBook(widget.libro.isbn); // Use ISBN to get reviews
    setState(() {
      _reviews = reviews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reseñas de ${widget.libro.nombre}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/img/fondo.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Image.network(
                widget.libro.imagen ?? "assets/images/default_image.png",
                fit: BoxFit.cover,
                height: 300, // Ajustamos el tamaño de la imagen aquí
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.libro.nombre,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _reviews.isEmpty
                  ? const Center(child: Text('No hay reseñas disponibles'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        final review = _reviews[index];
                        return _buildReviewContent(review);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewContent(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoText("Personajes:", review.personajes.toString()),
          _buildInfoText("Relaciones:", review.relaciones.toString()),
          _buildInfoText("Mundo:", review.mundo.toString()),
          _buildInfoText("Personaje Favorito:", review.personajeFavorito ?? ''),
          _buildInfoText("Personaje Odiado:", review.personajeOdiado ?? ''),
          _buildInfoText("Frase Favorita:", review.fraseFavorita ?? ''),
          _buildInfoText("Capítulo Favorito:", review.capituloFavorito ?? ''),
          _buildInfoText("Fecha de Inicio:", review.fechaInicio),
          _buildInfoText("Fecha Final:", review.fechaFinal),
          _buildInfoText("Reseña:", review.review ?? ''), // Cambié para que sea igual que los demás
        ],
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF745E4D), // Cambié el color del texto a blanco
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14.0,
                color: Colors.black, // Cambié el color del texto a blanco
              ),
            ),
          ],
        ),
      ),
    );
  }
}
