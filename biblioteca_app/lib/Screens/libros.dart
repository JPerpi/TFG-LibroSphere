import 'package:biblioteca_app/Screens/librodetall.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class libros_Screen extends StatelessWidget {
  final String nomTipo;

  libros_Screen({
    super.key,
    required this.nomTipo,
  });

  @override
  Widget build(BuildContext context) {
    // Establece el tipo actual antes de construir el widget
    var librosProvider = Provider.of<ProviderLibros>(context);
    librosProvider.tipoActual=nomTipo;

    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Verifica que la lista de comarcas no sea nula antes de construir los widgets
            if (librosProvider.llistaLibros != null)
              Column(
                children: [
                  for (dynamic libro in librosProvider.llistaLibros!)
                    _widgetPersoComarques(libro, context),
                ],
              ),
            if (librosProvider.llistaLibros == null)
              const CircularProgressIndicator(), // Puedes cambiar esto por un indicador de carga personalizado
          ],
        ),
      ),
    );
  }

  Widget _widgetPersoComarques(Libros libros, BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/img/Libro_Sphere.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Card(
                child: Stack(
                  children: [
                    Image.network(
                      libros.tipo!,
                      height: 150,
                      width: 350,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Text(
                        libros.nombre,
                        style: const TextStyle(
                          fontFamily: 'LeckerliOne',
                          color: Color.fromARGB(255, 255, 253, 253),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(3.0, 3.0),
                              blurRadius: 0.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => librodetall_Screen(nomLibro: libros.nombre),
          ),
        );
      },
    );
  }
}
