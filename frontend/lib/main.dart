import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/router.dart';
import 'core/network/api_client.dart';
import 'core/storage/secure_storage_service.dart';
import 'features/auth/data/auth_api.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/history/providers/history_provider.dart';

// 1. TAMBAHKAN IMPORT INI UNTUK JOURNAL PROVIDER
import 'features/journaling/providers/journal_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Core Services (Mesin Utama)
  final apiClient = ApiClient();
  final secureStorage = SecureStorageService();

  // 2. Inisialisasi API & Repository
  final authApi = AuthApi(apiClient);
  final authRepository = AuthRepository(authApi, secureStorage);

  runApp(
    // 3. Pasang Provider di urutan terluar aplikasi
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),

        // 2. PERBAIKI BARIS INI MENJADI LENGKAP
        ChangeNotifierProvider(create: (_) => JournalProvider(apiClient)),
        ChangeNotifierProvider(create: (_) => HistoryProvider(apiClient)),
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
          AppRouter.splash, // Pastikan splash screen menjadi route awal
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
