// lib/features/journal/providers/journal_provider.dart

import 'package:flutter/material.dart';
import '../data/journal_api.dart';
import '../models/detection_result_model.dart';
// Import SecureStorageService kamu
import '../../../core/storage/secure_storage_service.dart';

class JournalProvider extends ChangeNotifier {
  final JournalApi _api = JournalApi();

  // 1. Deklarasi Storage
  final SecureStorageService _storage;

  // 2. Konstruktor yang meminta Storage dari main.dart
  JournalProvider(this._storage);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetectionResultModel? _resultData;
  DetectionResultModel? get resultData => _resultData;

  // Fungsi yang akan dipanggil oleh Tombol Deteksi di UI
  Future<bool> detectBurnout({
    required String textJurnal,
    required String mood,
    required double studyHours,
    required double sleepHours,
    required int exerciseMinute,
    required int breaksPerDay,
    required int coffeeIntake,
  }) async {
    _isLoading = true;
    _errorMessage = null; // Reset error
    notifyListeners(); // Memunculkan animasi loading di UI

    try {
      // 3. Mengambil Token dari Secure Storage menggunakan fungsi getToken() kamu
      final String? token = await _storage.getToken();

      // Jika token tidak ditemukan, tolak prosesnya
      if (token == null || token.isEmpty) {
        throw Exception('Sesi telah habis. Silakan login kembali.');
      }

      // 4. Masukkan token otomatis ke pemanggilan API
      _resultData = await _api.submitJournalAndDetect(
        token: token,
        textJurnal: textJurnal,
        mood: mood,
        studyHours: studyHours,
        sleepHours: sleepHours,
        exerciseMinute: exerciseMinute,
        breaksPerDay: breaksPerDay,
        coffeeIntake: coffeeIntake,
      );

      _isLoading = false;
      notifyListeners();
      return true; // Berhasil!
    } catch (e) {
      // Tangkap error jika gagal
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners(); // Sembunyikan loading
      return false; // Gagal!
    }
  }
}
