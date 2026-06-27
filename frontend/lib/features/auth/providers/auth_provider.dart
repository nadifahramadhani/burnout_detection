import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../data/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  AuthProvider(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _user;
  UserModel? get user => _user;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _repository.login(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(
    String email,
    String password,
    String passwordConfirm,
    String firstName,
    String lastName,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.register(
        email,
        password,
        passwordConfirm,
        firstName,
        lastName,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    notifyListeners();
  }

  // Di dalam class AuthProvider
  // Di dalam class AuthProvider
  Future<bool> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    final user = await _repository.getProfile();
    if (user != null) {
      _user = user;
      _isLoading = false;
      notifyListeners();
      return true; // Sesi aktif
    }

    _isLoading = false;
    notifyListeners();
    return false; // Harus login ulang
  }
}
