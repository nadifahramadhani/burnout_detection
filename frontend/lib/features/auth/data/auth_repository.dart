import '../models/user_model.dart';
import 'auth_api.dart';
import '../../../../core/storage/secure_storage_service.dart';

class AuthRepository {
  final AuthApi _authApi;
  final SecureStorageService _storageService;

  AuthRepository(this._authApi, this._storageService);

  Future<UserModel> login(String email, String password) async {
    final response = await _authApi.login(email, password);
    final responseData = response.data['data'];

    await _storageService.saveToken(responseData['token']);

    return UserModel.fromJson(responseData['user']);
  }

  Future<void> register(
    String email,
    String password,
    String passwordConfirm,
    String firstName,
    String lastName,
  ) async {
    await _authApi.register(
      email,
      password,
      passwordConfirm,
      firstName,
      lastName,
    );
  }

  Future<void> logout() async {
    try {
      await _authApi.logout();
    } finally {
      await _storageService.deleteToken();
    }
  }

  Future<UserModel?> getProfile() async {
    final token = await _storageService.getToken();
    if (token == null) return null;

    try {

      final response = await _authApi.getProfile();
      return UserModel.fromJson(response.data['data']);
    } catch (e) {

      await _storageService.deleteToken();
      return null;
    }
  }
}
