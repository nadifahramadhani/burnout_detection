// lib/features/journal/data/journal_api.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/detection_result_model.dart';

class JournalApi {
  final ApiClient _apiClient;

  JournalApi(this._apiClient);

  Future<DetectionResultModel> submitJournalAndDetect({
    required String textJurnal,
    required String mood,
    required double studyHours,
    required double sleepHours,
    required int exerciseMinute,
    required int breaksPerDay,
    required int coffeeIntake,
  }) async {
    try {
      // Menggunakan Dio dari ApiClient. Token SUDAH otomatis masuk lewat Interceptor!
      final response = await _apiClient.dio.post(
        '/journal',
        data: {
          "text_jurnal": textJurnal,
          "mood": mood,
          "pola_hidup": {
            "study_hours_per_day": studyHours,
            "sleep_hours": sleepHours,
            "exercise_minute": exerciseMinute,
            "breaks_per_day": breaksPerDay,
            "coffee_intake_mg": coffeeIntake,
          },
        },
      );

      // Dio otomatis mengubah JSON menjadi Map, tidak perlu jsonDecode lagi
      return DetectionResultModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      // 👇 TAMBAHKAN 4 BARIS PRINT INI UNTUK MEMBONGKAR PESAN BACKEND 👇
      print("========================================");
      print("🚨 ALASAN ERROR 422 DARI BACKEND:");
      print(e.response?.data);
      print("========================================");

      // Melempar error ke UI
      throw _apiClient.handleException(e);
    }
  }

  Future<List<dynamic>> getJournals() async {
    try {
      // Ambil 5 jurnal terbaru
      final response = await _apiClient.dio.get('/journal?page=1&per_page=5');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      // 1. Tangkap khusus error dari server (DioException)
      throw _apiClient.handleException(e);
    } catch (e) {
      // 2. Tangkap error lainnya (misal error parsing data)
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
