import 'package:biblioteca_app/repository/usersRepository.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  final UsersRepository _repository = UsersRepository();

  bool _usernameExists = false;
  bool get usernameExists => _usernameExists;

  String? _iduser;
  String? get iduser => _iduser;

  String? _profilePicture;
  String? get profilePicture => _profilePicture;

  Future<void> checkUsernameExists(String username) async {
    _usernameExists = await _repository.validarUsername(username);
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    try {
      bool isValid = await _repository.validarLogin(username, password);
      if (isValid) {
        _iduser = username;
        _profilePicture = await _repository.obtenerImagenPerfil(username);
      }
      return isValid;
    } catch (error) {
      print('Error al iniciar sesión: $error');
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      bool exists = await _repository.validarUsername(username);
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

  Future<void> actualizarImagenPerfil(String imagePath) async {
    if (_iduser != null) {
      await _repository.actualizarImagenPerfil(_iduser!, imagePath);
      _profilePicture = imagePath;
      notifyListeners();
    }
  }

  void setUser(String userId) {
    _iduser = userId;
    notifyListeners();
  }

  void logout() {
    _iduser = null;
    _profilePicture = null;
    notifyListeners();
  }
}
