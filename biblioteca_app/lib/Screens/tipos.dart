/* import 'package:biblioteca_app/Screens/libros.dart';
import 'package:biblioteca_app/model/tipos.dart';
import 'package:biblioteca_app/providers/librosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TiposScreen extends StatelessWidget {
  const TiposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final librosProvider = Provider.of<ProviderLibros>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(146, 255, 244, 143),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (librosProvider.tipos != null)
              for (Tipos tipo in librosProvider.tipos!)
                _widgetPersoProvincia(tipo, context)
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _widgetPersoProvincia(Tipos tipos, BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(tipos.img ?? ""),
                radius: 100.0,
              ),
              Text(
                tipos.tipo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'LeckerliOne',
                  color: Color.fromARGB(255, 255, 253, 253),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 1.0,
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
            builder: (context) => libros_Screen(nomTipo: tipos.tipo),
          ),
        );
      },
    );
  }
}
 */