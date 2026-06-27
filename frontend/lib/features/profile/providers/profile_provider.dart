// lib/features/profile/providers/profile_provider.dart

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../auth/models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiClient _apiClient;

  ProfileProvider(this._apiClient);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  UserModel? _user;
  UserModel? get user => _user;

  // 1. Mengambil data profil dari backend
  Future<void> loadProfile() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiClient.dio.get('/profile');

      if (response.statusCode == 200 && response.data['data'] != null) {
        _user = UserModel.fromJson(response.data['data']);
      }
    } on DioException catch (e) {
      _errorMessage = _apiClient.handleException(e).toString();
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 2. Menyimpan pembaruan profil ke backend
  // 2. Menyimpan pembaruan profil ke backend
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required int age,
    required String gender, // <-- TAMBAHKAN INI
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiClient.dio.put(
        '/profile',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "age": age,
          "gender": gender, // <-- TAMBAHKAN INI
        },
      );

      if (response.statusCode == 200) {
        // Tarik data terbaru langsung dari database agar selalu fresh
        await loadProfile();
        return true;
      }
      return false;
    } on DioException catch (e) {
      _errorMessage = _apiClient.handleException(e).toString();
      return false;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 3. Menyimpan password baru (Kita siapkan untuk UI selanjutnya)
  // 3. Menyimpan password baru
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiClient.dio.put(
        '/profile/change-password', // <--- PERBAIKAN 1: Tambahkan /profile di depannya
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "confirm_new_password":
              confirmPassword, // <--- PERBAIKAN 2: Samakan key dengan backend Python
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      _errorMessage = _apiClient.handleException(e).toString();
      return false;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
