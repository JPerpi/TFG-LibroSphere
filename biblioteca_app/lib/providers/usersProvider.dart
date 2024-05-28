import 'package:biblioteca_app/repository/usersRepository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class UsersProvider extends ChangeNotifier {
  final UsersRepository _repository = UsersRepository();

  bool _usernameExists = false;
  bool get usernameExists => _usernameExists;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String? _iduser;
  String? get iduser => _iduser;
  Future<void> checkUsernameExists(String username) async {
    _usernameExists = await _repository.validarUsername(username);
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    try {
      bool isValid = await _repository.validarLogin(username, password);
      _iduser=username;
      return isValid;
    } catch (error) {
      print('Error al iniciar sesión: $error');
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
      try {
        bool exists = await _repository.validarUsername(username);
        print("Usuario existe: $exists");
        if (exists) {
          return false;
        } else {
          return await _repository.registrarUsuario(username, password);
        }
      } catch (error) {
        print('Error al registrar el usuario: $error');
        return false;
      }
    }
  // Añade los métodos setLightMode y setDarkMode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setUser(String userId) {
    _iduser = userId;
    notifyListeners();
  }

  void logout() {
    _iduser = null;
    notifyListeners();
  }
}