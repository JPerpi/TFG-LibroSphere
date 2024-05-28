import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/model/review.dart';
import 'package:biblioteca_app/providers/reviewProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final reviews = await reviewProvider.getReviewsForBook(widget.libro.nombre);
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
        child: _reviews.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  final review = _reviews[index];
                  return _buildReviewCard(review);
                },
              ),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reseña de ${review.nombre}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            _buildInfoText("Personajes:", review.personajes.toString()),
            _buildInfoText("Relaciones:", review.relaciones.toString()),
            _buildInfoText("Mundo:", review.mundo.toString()),
            _buildInfoText("Personaje Favorito:", review.personajeFavorito ?? ''),
            _buildInfoText("Personaje Odiado:", review.personajeOdiado ?? ''),
            _buildInfoText("Frase Favorita:", review.fraseFavorita ?? ''),
            _buildInfoText("Capítulo Favorito:", review.capituloFavorito ?? ''),
            _buildInfoText("Fecha de Inicio:", review.fechaInicio),
            _buildInfoText("Fecha Final:", review.fechaFinal),
            const SizedBox(height: 10.0),
            const Text(
              'Reseña:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text(review.review ?? ''),
          ],
        ),
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
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
