import 'package:biblioteca_app/Screens/libros.dart';
import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/Screens/settingsScreen.dart';
import 'package:biblioteca_app/model/tipos.dart';
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
              backgroundImage: AssetImage("assets/images/user_icon.png"), // Cambia según tu asset
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>SettingsScreen(nomTipo: '',)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: librosProvider.tipos != null ? GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: librosProvider.tipos!.length,
              itemBuilder: (context, index) {
                return _buildTipoWidget(librosProvider.tipos![index], context);
              },
            ) : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Lógica para navegar a la pantalla de registro de libro
              },
              child: const Text("Registrar Libro"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipoWidget(Tipos tipos, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(tipos.img ?? ""),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Text(
            tipos.tipo,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
