import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'auth_interceptor.dart';
import 'api_exception.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));
    dio.interceptors.add(AuthInterceptor());
  }

  Exception handleException(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final errorMessage = e.response?.data['message'] ?? 'Terjadi kesalahan pada server';
      return ApiException(errorMessage);
    }
    return ApiException('Tidak dapat terhubung ke server. Periksa koneksi internetmu.');
  }
}