import 'package:biblioteca_app/Screens/libroRegisterScreen.dart';
import 'package:biblioteca_app/Screens/librosScreen.dart';
import 'package:biblioteca_app/Screens/settingsScreen.dart';
import 'package:biblioteca_app/Widgets/imgController.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final librosProvider = Provider.of<ProviderLibros>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage("assets/img/user_icon.png"), 
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(nomTipo: '',)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: librosProvider.libros != null ? GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: librosProvider.libros!.length,
              itemBuilder: (context, index) {
                return _buildLibroWidget(librosProvider.libros![index], context);
              },
            ) : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de registro de un nuevo libro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LibroRegisterScreen()),
                );
              },
              child: Text("Registrar Libro"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLibroWidget(Libros libro, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LibrosScreen(libro: libro),
        ),
      );
    },
    child: Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ImgController(imagePath: libro.imagen ?? "assets/images/default_image.png"),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              libro.nombre,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
}