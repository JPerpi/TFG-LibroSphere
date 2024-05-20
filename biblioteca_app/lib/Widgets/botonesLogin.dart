import 'package:flutter/material.dart';

class BotonesLogin extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const BotonesLogin({
    Key? key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onLoginPressed,
          child: const Text("Entrar"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: onRegisterPressed,
          child: const Text("Registrarse"),
        ),
      ],
    );
  }
}
