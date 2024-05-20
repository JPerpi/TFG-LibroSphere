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

  String _nombre = '';
  String _autor = '';
  String _saga = '';
  int? _posSaga;
  String _tipo = 'novela';  // Valor inicial
  final List<String> _tiposLibro = ['novela', 'poemario', 'manga', 'comic']; // Opciones del enum
  String _genero = '';
  String _isbn = '';
  String _editorial = '';
  String _fechaPubli='';
  String _idioma = '';
  String _iduser = '';
  String _imagen = '';

  @override
  Widget build(BuildContext context) {
    final iduser = Provider.of<UsersProvider>(context).iduser;
    _iduser = iduser ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Nuevo Libro"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
    );
  }

  List<TableRow> _buildFormRows() {
    return [
      _buildTableRow('Nombre:', _nombre, (value) => _nombre = value),
      _buildTableRow('Autor:', _autor, (value) => _autor = value),
      _buildTableRow('Saga:', _saga, (value) => _saga = value),
      _buildTableRow('Posición en Saga:', _posSaga?.toString() ?? '', (value) => _posSaga = int.tryParse(value)),
      TableRow(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Tipo:'),
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
      _buildTableRow('Género:', _genero, (value) => _genero = value),
      _buildTableRow('ISBN:', _isbn, (value) => _isbn = value),
      _buildTableRow('Editorial:', _editorial, (value) => _editorial = value),
      _buildTableRow('Fecha de Publicación:', _fechaPubli, (value) => _fechaPubli = value),
      _buildTableRow('Idioma:', _idioma, (value) => _idioma = value),
      _buildTableRow('Imagen URL:', _imagen, (value) => _imagen = value),
    ];
  }

  TableRow _buildTableRow(String label, String value, Function(String) onChanged) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label),
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProviderLibros>(context, listen: false);
      provider.agregarLibro(
        _nombre,
        _autor,
        _saga,
        _posSaga,
        _tipo, // Cambiar a _tipo
        _genero,
        _isbn,
        _editorial,
        _fechaPubli,
        _idioma,
        _iduser,
        _imagen,
      );
      Navigator.pop(context);
    }
  }
}
