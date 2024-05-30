import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';

class LibroRegistroBBDDScreen extends StatefulWidget {
  @override
  _LibroRegistroBBDDScreenState createState() => _LibroRegistroBBDDScreenState();
}

class _LibroRegistroBBDDScreenState extends State<LibroRegistroBBDDScreen> {
  List<Libros> _libros = [];
  List<Libros> _filteredLibros = [];
  bool _showSearchBar = false;

  @override
  void initState() {
    super.initState();
    _loadLibros();
  }

  Future<void> _loadLibros() async {
    final librosProvider = Provider.of<ProviderLibros>(context, listen: false);
    List<Libros> libros = await librosProvider.obtenerTodosLosLibros();
    setState(() {
      _libros = libros;
      _filteredLibros = libros;
    });
  }

  void _filterLibros(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredLibros = _libros;
      });
    } else {
      setState(() {
        _filteredLibros = _libros.where((libro) {
          return libro.nombre.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Libro Existente'),
        actions: [
          IconButton(
            icon: Icon(_showSearchBar ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                if (!_showSearchBar) {
                  _filterLibros('');  // Reset the search when closing
                }
              });
            },
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
                          _filterLibros(value);
                        },
                      )
                    : null,
              ),
              Expanded(
                child: _filteredLibros.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredLibros.length,
                        itemBuilder: (context, index) {
                          final libro = _filteredLibros[index];
                          return ListTile(
                            leading: Image.network(
                              libro.imagen ?? 'assets/img/default_image.png',
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(libro.nombre),
                            subtitle: Text(libro.autor ?? ''),
                            onTap: () {
                              Navigator.pop(context, libro);
                            },
                          );
                        },
                      )
                    : const Center(child: Text('No hay libros disponibles')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
