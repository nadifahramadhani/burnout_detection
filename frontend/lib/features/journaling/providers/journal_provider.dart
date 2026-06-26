// lib/features/journal/providers/journal_provider.dart
import 'package:flutter/material.dart';
import '../data/journal_api.dart';
import '../models/detection_result_model.dart';
import '../../../core/network/api_client.dart';

class JournalProvider extends ChangeNotifier {
  late final JournalApi _api;

  // Konstruktor menerima ApiClient
  JournalProvider(ApiClient apiClient) {
    _api = JournalApi(apiClient);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetectionResultModel? _resultData;
  DetectionResultModel? get resultData => _resultData;

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
    _errorMessage = null;
    notifyListeners();

    try {
      // Langsung panggil API tanpa mikirin token lagi!
      _resultData = await _api.submitJournalAndDetect(
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
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
