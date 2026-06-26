class ApiConstants {
  // Ganti dengan IP laptop kamu saat test di HP fisik
  // Untuk emulator Android: 10.0.2.2
  // Untuk HP fisik: IP laptop (cek dengan ipconfig)
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';

  // Profile
  static const String profile = '/profile';
  static const String changePassword = '/profile/change-password';

  // Journal
  static const String journal = '/journal';

  // Lifestyle
  static const String lifestyle = '/lifestyle';
  static const String lifestyleLatest = '/lifestyle/latest';

  // Detection
  static const String detection = '/detection';
  static const String detectionLatest = '/detection/latest';

  // History
  static const String history = '/history';
  static const String historyByDate = '/history/date';
}
