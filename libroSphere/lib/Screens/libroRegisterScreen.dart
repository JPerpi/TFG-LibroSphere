import 'package:biblioteca_app/Screens/libroRegistroBBDDScreen.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:provider/provider.dart';

class LibroRegisterScreen extends StatefulWidget {
  const LibroRegisterScreen({Key? key}) : super(key: key);

  @override
  _LibroRegisterScreenState createState() => _LibroRegisterScreenState();
}

class _LibroRegisterScreenState extends State<LibroRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _isbn = '';
  String _nombre = '';
  String _autor = '';
  String _saga = '';
  int? _posSaga;
  String _tipo = 'novela';  // Valor inicial
  final List<String> _tiposLibro = ['novela', 'poemario', 'manga', 'comic']; // Opciones del enum
  String _genero = '';
  String _editorial = '';
  String _fechaPubli = '';
  String _idioma = '';
  String _imagen = '';
  String _iduser = '';

  @override
  Widget build(BuildContext context) {
    final iduser = Provider.of<UsersProvider>(context).iduser;
    _iduser = iduser ?? '';
    final librosProvider = Provider.of<ProviderLibros>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Nuevo Libro"),
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
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final libroSeleccionado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LibroRegistroBBDDScreen(),
                          ),
                        );
                        if (libroSeleccionado != null) {
                          // Añadir el libro seleccionado a la biblioteca del usuario
                          await librosProvider.agregarLibroParaUsuario(libroSeleccionado, _iduser);
                          Navigator.pop(context); // Volver a la pantalla anterior después de añadir el libro
                        }
                      },
                      child: const Text('Seleccionar Libro Existente'),
                    ),
                    const SizedBox(height: 20),
                    const Text('O rellena los siguientes campos para añadir un libro manualmente:'),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: _buildFormRows(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Guardar Libro'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> _buildFormRows() {
    return [
      _buildTableRow('ISBN:', _isbn, (value) => setState(() => _isbn = value)),
      _buildTableRow('Nombre:', _nombre, (value) => setState(() => _nombre = value)),
      _buildTableRow('Autor:', _autor, (value) => setState(() => _autor = value)),
      _buildTableRow('Saga:', _saga, (value) => setState(() => _saga = value)),
      _buildTableRow('Posición en Saga:', _posSaga?.toString() ?? '', (value) => setState(() => _posSaga = int.tryParse(value))),
      TableRow(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Tipo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          DropdownButtonFormField(
            value: _tipo,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _tipo = newValue ?? _tipo;
              });
            },
            items: _tiposLibro.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      _buildTableRow('Género:', _genero, (value) => setState(() => _genero = value)),
      _buildTableRow('Editorial:', _editorial, (value) => setState(() => _editorial = value)),
      _buildTableRow('Fecha de Publicación:', _fechaPubli, (value) => setState(() => _fechaPubli = value)),
      _buildTableRow('Idioma:', _idioma, (value) => setState(() => _idioma = value)),
      _buildTableRow('Imagen URL:', _imagen, (value) => setState(() => _imagen = value)),
    ];
  }

  TableRow _buildTableRow(String label, String value, Function(String) onChanged) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(hintText: 'Introduce $label'),
          validator: (value) => value == null || value.isEmpty ? 'Este campo no puede estar vacío' : null,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProviderLibros>(context, listen: false);
      final nuevoLibro = Libros(
        isbn: _isbn,
        nombre: _nombre,
        autor: _autor,
        saga: _saga,
        posSaga: _posSaga,
        tipo: _tipo,
        genero: _genero,
        editorial: _editorial,
        fechaPubli: _fechaPubli,
        idioma: _idioma,
        imagen: _imagen,
      );
      await provider.agregarLibroParaUsuario(nuevoLibro, _iduser);
      Navigator.pop(context);
    }
  }
}
