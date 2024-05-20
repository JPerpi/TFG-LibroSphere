import 'package:flutter/material.dart';

class DatosRegistro extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String) onUsernameChanged;
  final Function(String) onPasswordChanged;
  final Function(String) onConfirmPasswordChanged;
  final String currentPassword; 
  final String errorMessage;

  const DatosRegistro({
    Key? key,
    required this.formKey,
    required this.onUsernameChanged,
    required this.onPasswordChanged,
    required this.onConfirmPasswordChanged,
    required this.currentPassword, 
    this.errorMessage = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Correo Electrónico',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty || !value.contains('@')
                    ? 'Por favor, ingrese un correo válido.'
                    : null,
            onChanged: onUsernameChanged,
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) =>
                value == null || value.isEmpty || value.length < 6
                    ? 'La contraseña debe tener al menos 6 caracteres.'
                    : null,
            onChanged: onPasswordChanged,
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Confirmar Contraseña',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value != currentPassword) {
                return 'Las contraseñas no coinciden.';
              }
              return null;
            },
            onChanged: onConfirmPasswordChanged,
          ),
          const SizedBox(height: 30),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(errorMessage, style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
