import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  Future<Response> login(String email, String password) async {
    try {
      return await _apiClient.dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
    } on DioException catch (e) {
      throw _apiClient.handleException(e);
    }
  }

  Future<Response> register(
    String email,
    String password,
    String passwordConfirm,
    String firstName,
    String lastName,
  ) async {
    try {
      return await _apiClient.dio.post(
        ApiConstants.register,
        data: {
          'email': email,
          'password': password,
          'password_confirm': passwordConfirm,
          'first_name': firstName,
          'last_name': lastName,
        },
      );
    } on DioException catch (e) {
      throw _apiClient.handleException(e);
    }
  }

  Future<Response> logout() async {
    try {
      return await _apiClient.dio.post(ApiConstants.logout);
    } on DioException catch (e) {
      throw _apiClient.handleException(e);
    }
  }

  Future<Response> getProfile() async {

    return await _apiClient.dio.get('/profile');
  }
}
