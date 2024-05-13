import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/Screens/register.dart';
import 'package:biblioteca_app/Screens/tipos.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/img/fondo.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        // Resto del código de tu pantalla de inicio de sesión
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/Libro_Sphere.png"),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contrasenya',
                      border: const OutlineInputBorder(),
                      errorText:
                          _errorMessage.isNotEmpty ? _errorMessage : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        _errorMessage =
                            ''; // Limpiar el mensaje de error al editar la contraseña
                      });
                    },
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _loginUser,
                  child: const Text("Entrar"),
                ),
                const SizedBox(height: 20),
                // Botón para navegar a la pantalla de registro
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const register_screen(),
                      ),
                    );
                  },
                  child: const Text("Registrarse"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método ficticio para verificar las credenciales del usuario
  Future<void> _loginUser() async {
    // Llama al proveedor para verificar las credenciales del usuario
    final userProvider = usersProvider(); // Instancia del proveedor
    final isValidLogin = await userProvider.login(_username, _password);

    if (isValidLogin) {
      // Si la autenticación es exitosa, navega a la pantalla principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const register_screen(),
        ),
      );
    } else {
      // Si la autenticación falla, muestra un mensaje de error y vacía el campo de contraseña
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
        _password = '';
      });
    }
  }
}