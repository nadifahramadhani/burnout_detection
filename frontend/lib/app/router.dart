import 'package:flutter/material.dart';

import '../core/constants/app_typography.dart';
import '../features/onboarding/presentation/welcome_page.dart'; // Import WelcomePage
import '../features/onboarding/presentation/onboarding_page.dart'; // Import OnboardingPage yang baru (Slider)
import '../features/splash/presentation/splash_page.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String welcome = '/welcome'; // Tambahkan rute welcome
  static const String onboarding = '/onboarding';
  static const String login = '/login';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        ); // Arahkan ke WelcomePage
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        ); // Arahkan ke OnboardingPage
      case login:
        return MaterialPageRoute(builder: (_) => const _LoginPlaceholderPage());
      default:
        return MaterialPageRoute(builder: (_) => const _NotFoundPage());
    }
  }
}

class _LoginPlaceholderPage extends StatelessWidget {
  const _LoginPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Login screen segera dibuat',
          style: AppTypography.h6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Halaman tidak ditemukan',
          style: AppTypography.h6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
