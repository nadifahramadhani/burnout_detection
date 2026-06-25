import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage = SecureStorageService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Ambil token dari storage
    final token = await _storage.getToken();
    
    // Jika token ada, masukkan ke header
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}