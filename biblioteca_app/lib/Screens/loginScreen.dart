import 'package:biblioteca_app/Screens/mainScreen.dart';
import 'package:biblioteca_app/Widgets/botonesLogin.dart';
import 'package:biblioteca_app/Widgets/datosLogin.dart';
import 'package:biblioteca_app/providers/usersProvider.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/Screens/registerScreen.dart';
import 'package:provider/provider.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: DatosLogin(
                  onUsernameChanged: (value) => setState(() => _username = value),
                  onPasswordChanged: (value) => setState(() => _password = value),
                  errorMessage: _errorMessage,
                ),
              ),
              const SizedBox(height: 30),
              BotonesLogin(
                onLoginPressed: _loginUser,
                onRegisterPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    final isValidLogin = await Provider.of<UsersProvider>(context, listen: false).login(_username, _password);
    if (isValidLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      setState(() => _errorMessage = 'Usuario o contraseña incorrectos');
    }
  }
}
