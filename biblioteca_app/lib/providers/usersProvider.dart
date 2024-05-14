import 'package:biblioteca_app/repository/usersRepository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class UsersProvider extends ChangeNotifier {
   final UsersRepository _repository = UsersRepository();

  bool _usernameExists = false;
  bool get usernameExists => _usernameExists;

  Future<void> checkUsernameExists(String username) async {
    _usernameExists = await _repository.validarUsername(username); 
    notifyListeners();
  }

  Future<bool>login(String username, String password) async {
    try {

      bool isValid = await _repository.validarLogin(username, password);
      return isValid;
    } catch (error) {
      print('Error al iniciar sesión: $error');
      return false; 
    }
  }
}
