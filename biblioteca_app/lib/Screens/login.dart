import 'package:biblioteca_app/Screens/tipos.dart';
import 'package:flutter/material.dart';

class login_screen extends StatelessWidget {
  const login_screen({
    super.key,
  });

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/Libro_Sphere.png"),
                  const Text(
                    "LibroSphere",
                    style: TextStyle(fontFamily: 'LeckerliOne', fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Usuari',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contrasenya',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TiposScreen()
                      ),
                    );
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(width: 70.0),
                ElevatedButton(
                  onPressed: () {
                    _showRegisterDialog(context);
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           contentPadding: const EdgeInsets.all(16.0),
          title: const Text('Registro'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(height: 20, color: Color.fromARGB(255, 5, 5, 5)),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Usuari',
                     prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Registrar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel.lar'),
            ),
          ],
        );
      },
    );
  }
}
