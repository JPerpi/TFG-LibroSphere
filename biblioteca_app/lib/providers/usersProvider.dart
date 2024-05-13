import 'package:biblioteca_app/repository/usersRepository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class usersProvider extends ChangeNotifier {
  final _repository = usersRepository();

  bool _usernameExists = false;
  bool get usernameExists => _usernameExists;

  Future<void> checkUsernameExists(String username) async {
    _usernameExists = await _repository.validarUSername(username);
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    return await _repository.validarLogin(username, password);
  }

  // Aquí podrías agregar métodos para manejar la lógica de cambiar el tema y otras funcionalidades relacionadas con los usuarios

}
