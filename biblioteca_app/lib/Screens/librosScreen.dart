import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';

class LibrosScreen extends StatelessWidget {
  final Libros libro;

  const LibrosScreen({Key? key, required this.libro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libro.nombre), // Título del AppBar con el nombre del libro
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegar a la pantalla de ajustes si es necesario
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      libro.imagen ?? "", // Asumiendo que tienes una URL de imagen en tu modelo
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Autor: ${libro.autor}"),
                          Text("Saga: ${libro.saga}"),
                          Text("Posición en Saga: ${libro.posSaga}"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Editorial: ${libro.editorial}"),
                        Text("Género: ${libro.genero}"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ISBN: ${libro.isbn}"),
                        Text("Fecha de Publicación: ${libro.fechaPubli}"),
                        Text("Idioma: ${libro.idioma}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Volver"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
