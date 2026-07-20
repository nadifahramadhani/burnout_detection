

import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class HistoryApi {
  final ApiClient _apiClient;

  HistoryApi(this._apiClient);

  Future<List<dynamic>> getHistory() async {
    try {

      final response = await _apiClient.dio.get('/history?page=1&per_page=7');
      return response.data['data'] ?? [];
    } on DioException catch (e) {

      throw _apiClient.handleException(e);
    } catch (e) {

      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
