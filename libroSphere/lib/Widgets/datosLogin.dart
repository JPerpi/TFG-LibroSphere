import 'package:flutter/material.dart';

class DatosLogin extends StatefulWidget {
  final Function(String) onUsernameChanged;
  final Function(String) onPasswordChanged;
  final String errorMessage;

  const DatosLogin({
    Key? key,
    required this.onUsernameChanged,
    required this.onPasswordChanged,
    required this.errorMessage,
  }) : super(key: key);

  @override
  _DatosLoginState createState() => _DatosLoginState();
}

class _DatosLoginState extends State<DatosLogin> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/img/Libro_Sphere.png"),
        const SizedBox(height: 30),
        TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Usuario',
            border: OutlineInputBorder(),
          ),
          onChanged: widget.onUsernameChanged,
        ),
        const SizedBox(height: 30),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Contraseña',
            border: const OutlineInputBorder(),
            errorText: widget.errorMessage.isNotEmpty ? widget.errorMessage : null,
          ),
          onChanged: widget.onPasswordChanged,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
