import 'package:biblioteca_app/Screens/reviewScreen.dart';
import 'package:biblioteca_app/Screens/verReviewScreen.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';

class LibrosScreen extends StatelessWidget {
  final Libros libro;

  const LibrosScreen({Key? key, required this.libro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libro.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegar a la pantalla de ajustes si es necesario
            },
          ),
        ],
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
                libro.imagen ?? "", 
                fit: BoxFit.cover,
                height: 300, 
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              libro.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoText("Autor:", libro.autor ?? ''),
                        _buildInfoText("Saga:", libro.saga ?? ''),
                        _buildInfoText("Posición en Saga:", libro.posSaga?.toString() ?? ''),
                        _buildInfoText("Editorial:", libro.editorial ?? ''),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoText("Género:", libro.genero ?? ''),
                        _buildInfoText("ISBN:", libro.isbn ?? ''),
                        _buildInfoText("Fecha de Publicación:", libro.fechaPubli ?? ''),
                        _buildInfoText("Idioma:", libro.idioma ?? ''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewScreen(libro: libro)),
                    );
                  },
                  child: const Text("Agregar Reseña"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerReviewScreen(libro: libro)),
                    );
                  },
                  child: const Text("Ver Reseñas"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
