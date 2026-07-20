import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/router.dart';
import 'core/network/api_client.dart';
import 'core/storage/secure_storage_service.dart';
import 'features/auth/data/auth_api.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/history/providers/history_provider.dart';
import 'features/journaling/providers/journal_provider.dart';
import 'features/profile/providers/profile_provider.dart';

import 'features/profile/presentation/edit_profile_page.dart';
import 'features/profile/presentation/change_password_page.dart';
import 'features/auth/presentation/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();
  final secureStorage = SecureStorageService();

  final authApi = AuthApi(apiClient);
  final authRepository = AuthRepository(authApi, secureStorage);

  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
        ChangeNotifierProvider(create: (_) => JournalProvider(apiClient)),
        ChangeNotifierProvider(create: (_) => HistoryProvider(apiClient)),
        ChangeNotifierProvider(create: (_) => ProfileProvider(apiClient)),
      ],
      child: const MindaraApp(),
    ),
  );
}

class MindaraApp extends StatelessWidget {
  const MindaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindara',
      debugShowCheckedModeBanner: false,
      initialRoute:
          AppRouter.splash,

      routes: {
        AppRouter.login: (context) => const LoginPage(),
        AppRouter.editProfile: (context) => const EditProfilePage(),
        AppRouter.changePassword: (context) => const ChangePasswordPage(),
      },

      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
