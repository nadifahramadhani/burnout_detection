
import 'package:flutter/material.dart';
import '../data/journal_api.dart';
import '../models/detection_result_model.dart';
import '../../../core/network/api_client.dart';

class JournalProvider extends ChangeNotifier {
  late final JournalApi _api;

  JournalProvider(ApiClient apiClient) {
    _api = JournalApi(apiClient);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetectionResultModel? _resultData;
  DetectionResultModel? get resultData => _resultData;
  List<dynamic> _journals = [];
  List<dynamic> get journals => _journals;

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

  Future<void> fetchJournals() async {
    _isLoading = true;
    notifyListeners();
    try {
      _journals = await _api.getJournals();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
