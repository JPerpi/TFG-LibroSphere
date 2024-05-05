import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class librodetall_Screen extends StatelessWidget {
  final String nomLibro;

  librodetall_Screen({
    super.key,
    required this.nomLibro,
  });

  @override
  Widget build(BuildContext context) {
    var librosProvider = Provider.of<ProviderLibros>(context);
    librosProvider.tituloActual = nomLibro;     
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration:
              const BoxDecoration(color: Color.fromARGB(200, 255, 255, 255)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 80),
              Image.network(librosProvider.detallesLibroActual?.img ?? ""),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.titulo ?? "",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Saga: ${librosProvider.detallesLibroActual?.saga}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.posSaga ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.autor ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.editorial ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.fechaPubli ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.genero ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.idioma ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.isbn ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      librosProvider.detallesLibroActual?.paginas ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
