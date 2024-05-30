import 'package:flutter/material.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/model/review.dart';
import 'package:biblioteca_app/providers/reviewProvider.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  final Libros libro;

  const ReviewScreen({Key? key, required this.libro}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  double _personajesRating = 0.0;
  double _mundoRating = 0.0;
  double _relacionesRating = 0.0;
  String _capituloFavorito = '';
  String _personajeFavorito = '';
  String _personajeOdiado = '';
  String _fraseFavorita = '';
  String _fechaInicio = '';
  String _fechaFin = '';
  String _review = '';

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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                const Text(
                  'Personajes:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Slider(
                  value: _personajesRating,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _personajesRating.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _personajesRating = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Mundo:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Slider(
                  value: _mundoRating,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _mundoRating.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _mundoRating = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Relaciones:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Slider(
                  value: _relacionesRating,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _relacionesRating.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _relacionesRating = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField('Personaje Favorito', (value) => _personajeFavorito = value),
                          const SizedBox(height: 16.0),
                          _buildTextField('Personaje Odiado', (value) => _personajeOdiado = value),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField('Fecha Inicio', (value) => _fechaInicio = value, hintText: 'MM/AA'),
                          const SizedBox(height: 16.0),
                          _buildTextField('Fecha Fin', (value) => _fechaFin = value, hintText: 'MM/AA'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                _buildTextField('Frase Favorita', (value) => _fraseFavorita = value),
                const SizedBox(height: 16.0),
                _buildTextField('Capítulo Favorito', (value) => _capituloFavorito = value),
                const SizedBox(height: 16.0),
                const Text(
                  'Reseña:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                TextFormField(
                  maxLines: 6,
                  onChanged: (value) => _review = value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: const Text('Guardar Reseña'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged, {String? hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: onChanged,
    );
  }

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      final review = Review(
        personajes: _personajesRating.toInt(),
        relaciones: _relacionesRating.toInt(),
        mundo: _mundoRating.toInt(),
        personajeFavorito: _personajeFavorito,
        personajeOdiado: _personajeOdiado,
        review: _review,
        fraseFavorita: _fraseFavorita,
        capituloFavorito: _capituloFavorito,
        libroId: widget.libro.isbn,
        nombre: widget.libro.nombre,
        fechaInicio: _fechaInicio,
        fechaFinal: _fechaFin, 
      );

      final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
      reviewProvider.addReview(review);

      Navigator.pop(context);
    }
  }
}
