// lib/features/journal/data/journal_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/detection_result_model.dart';

class JournalApi {
  // Ubah tipe kembalian di sini menjadi DetectionResultModel
  Future<DetectionResultModel> submitJournalAndDetect({
    required String token,
    required String textJurnal,
    required String mood,
    required double studyHours,
    required double sleepHours,
    required int exerciseMinute,
    required int breaksPerDay,
    required int coffeeIntake,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/journal');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "text_jurnal": textJurnal,
          "mood": mood,
          "pola_hidup": {
            "study_hours_per_day": studyHours,
            "sleep_hours": sleepHours,
            "exercise_minute": exerciseMinute,
            "breaks_per_day": breaksPerDay,
            "coffee_intake_mg": coffeeIntake,
          },
        }),
      );
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        return DetectionResultModel.fromJson(jsonResponse['data']);
      } else {
        // PERBAIKAN: Tangkap pesan error aslinya agar kita tahu apa yang salah!
        // Backend Python biasanya menaruh error di key 'message', 'msg', atau 'error'
        final backendError =
            jsonResponse['message'] ??
            jsonResponse['msg'] ??
            jsonResponse['error'] ??
            response.body; // Kalau aneh, print semua body-nya

        // Print ke terminal agar kamu bisa melihatnya
        print('=== ERROR DARI BACKEND ===');
        print(backendError);

        throw Exception(backendError.toString());
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi: $e');
    }
  }
}
