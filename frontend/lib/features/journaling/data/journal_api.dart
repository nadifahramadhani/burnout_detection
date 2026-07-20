
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

      return DetectionResultModel.fromJson(response.data['data']);
    } on DioException catch (e) {

      print("========================================");
      print("🚨 ALASAN ERROR 422 DARI BACKEND:");
      print(e.response?.data);
      print("========================================");

      throw _apiClient.handleException(e);
    }
  }

  Future<List<dynamic>> getJournals() async {
    try {

      final response = await _apiClient.dio.get('/journal?page=1&per_page=5');
      return response.data['data'] ?? [];
    } on DioException catch (e) {

      throw _apiClient.handleException(e);
    } catch (e) {

      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
