import 'package:biblioteca_app/Screens/libroRegisterScreen.dart';
import 'package:biblioteca_app/Screens/librosScreen.dart';
import 'package:biblioteca_app/Screens/settingsScreen.dart';
import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/Widgets/imgController.dart';
import 'package:biblioteca_app/Widgets/userMenu.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final String username;

  const MainScreen({super.key, required this.username});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showSearchBar = false;
  String _selectedTipo = '';
  String _selectedGenero = '';
  bool _ordenAscendente = true;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userId = usersProvider.iduser;
    final librosProvider = Provider.of<ProviderLibros>(context, listen: false);
    if (userId != null) {
      librosProvider.cargarLibrosPorUsuario(userId);
    }
    librosProvider.cargarGeneros();
    librosProvider.cargarTipos();
  }

  @override
  Widget build(BuildContext context) {
    final librosProvider = Provider.of<ProviderLibros>(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      appBar: AppBar(
      title: const Text('Biblioteca'),
      actions: [
        IconButton(
          icon: Icon(_showSearchBar ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _showSearchBar = !_showSearchBar;
              if (!_showSearchBar) {
                librosProvider.buscarLibros('');  // Reset the search when closing
              }
            });
          },
        ),
        UserMenu(), // Añadir el menú de usuario aquí
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _showSearchBar ? 70 : 0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _showSearchBar
                    ? TextField(
                        decoration: const InputDecoration(
                          labelText: 'Buscar libros',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          librosProvider.buscarLibros(value);
                        },
                      )
                    : null,
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton<String>(
                      value: _selectedTipo.isEmpty ? null : _selectedTipo,
                      hint: const Text('Filtrar por tipo'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTipo = newValue ?? '';
                          librosProvider.filtrarPorTipo(_selectedTipo);
                        });
                      },
                      items: ['Todos', ...librosProvider.tipos]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value == 'Todos' ? '' : value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: _selectedGenero.isEmpty ? null : _selectedGenero,
                      hint: const Text('Filtrar per gènere'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGenero = newValue ?? '';
                          librosProvider.filtrarPorGenero(_selectedGenero);
                        });
                      },
                      items: ['Todos', ...librosProvider.generos]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value == 'Todos' ? '' : value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    IconButton(
                      icon: Icon(_ordenAscendente ? Icons.arrow_upward : Icons.arrow_downward),
                      onPressed: () {
                        setState(() {
                          _ordenAscendente = !_ordenAscendente;
                          librosProvider.ordenarLibros(_ordenAscendente);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: librosProvider.libros != null && librosProvider.libros!.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: librosProvider.libros!.length,
                        itemBuilder: (context, index) {
                          return _buildLibroWidget(librosProvider.libros![index], context, widget.username);
                        },
                      )
                    : Center(
                        child: librosProvider.libros == null
                            ? const CircularProgressIndicator()
                            : const Text('No se encontraron libros'),
                      ),
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

  Widget _buildLibroWidget(Libros libro, BuildContext context, String username) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LibrosScreen(libro: libro, username: username),
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
