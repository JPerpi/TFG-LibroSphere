import 'package:biblioteca_app/Screens/libroRegisterScreen.dart';
import 'package:biblioteca_app/Screens/librosScreen.dart';
import 'package:biblioteca_app/Screens/settingsScreen.dart';
import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/Widgets/imgController.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final librosProvider = Provider.of<ProviderLibros>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    final userId = usersProvider.iduser;

    // Cargar los libros del usuario al construir la pantalla
    if (userId != null) {
      librosProvider.cargarLibrosPorUsuario(userId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        actions: [
          PopupMenuButton<String>(
            icon: const CircleAvatar(
              backgroundImage: AssetImage("assets/img/user_icon.png"),
            ),
            onSelected: (String value) {
              switch (value) {
                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen(nomTipo: '',)),
                  );
                  break;
                case 'logout':
                  usersProvider.logout();
                  librosProvider.clearLibros();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                  break;
                case 'dark_mode':
                  usersProvider.toggleDarkMode();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Ajustes de Usuario'),
              ),
              PopupMenuItem<String>(
                value: 'dark_mode',
                child: Text(usersProvider.isDarkMode ? 'Modo Claro' : 'Modo Oscuro'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/img/fondo.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: librosProvider.libros != null
                    ? GridView.builder(
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
                      )
                    : const Center(child: CircularProgressIndicator()),
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
                  child: const Text("Registrar Libro"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
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
              padding: const EdgeInsets.all(8),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                libro.nombre,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
