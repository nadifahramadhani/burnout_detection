import 'package:flutter/material.dart';
import '../../../core/network/api_client.dart';
import '../data/history_api.dart';

class HistoryProvider extends ChangeNotifier {
  late final HistoryApi _api;

  HistoryProvider(ApiClient apiClient) {
    _api = HistoryApi(apiClient);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _historyList = [];
  List<dynamic> get historyList => _historyList;

  Future<void> fetchWeeklyHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      _historyList = await _api.getHistory();
    } catch (e) {
      debugPrint('Error fetch history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
