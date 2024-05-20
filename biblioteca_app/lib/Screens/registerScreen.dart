import 'package:biblioteca_app/Screens/loginScreen.dart';
import 'package:biblioteca_app/Widgets/datosRegistro.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/Libro_Sphere.png"),
                  const SizedBox(height: 30),
                  DatosRegistro(
                    formKey: _formKey,
                    onUsernameChanged: (value) =>
                        setState(() => _username = value),
                    onPasswordChanged: (value) =>
                        setState(() => _password = value),
                    onConfirmPasswordChanged: (value) =>
                        setState(() => _confirmPassword = value),
                    currentPassword:
                        _password,
                    errorMessage: _errorMessage,
                  ),
                  ElevatedButton(
                    onPressed: _createAccount,
                    child: const Text("Crear"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancelar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      final isValidLogin =
          await Provider.of<UsersProvider>(context, listen: false)
              .register(_username, _password);
      if (isValidLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        setState(() {
          _errorMessage =
              'Error al registrar. El usuario ya puede existir o hubo otro problema.';
        });
      }
    }
  }
}
