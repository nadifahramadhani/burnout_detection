// lib/features/history/data/history_api.dart

// 1. PASTIKAN IMPORT DIO DITAMBAHKAN DI SINI
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class HistoryApi {
  final ApiClient _apiClient;

  HistoryApi(this._apiClient);

  Future<List<dynamic>> getHistory() async {
    try {
      // Ambil 7 riwayat terakhir untuk grafik mingguan
      final response = await _apiClient.dio.get('/history?page=1&per_page=7');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      // 2. UBAH MENJADI 'on DioException catch (e)' AGAR SESUAI
      throw _apiClient.handleException(e);
    } catch (e) {
      // 3. Jaga-jaga jika ada error lain selain dari server (misal error parsing/hp lemot)
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
