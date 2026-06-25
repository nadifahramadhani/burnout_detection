import 'package:flutter/material.dart';

import '../core/constants/app_typography.dart';
import '../features/onboarding/presentation/welcome_page.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import '../features/splash/presentation/splash_page.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/register_page.dart';
import '../features/home/presentation/main_page.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case main:
        return MaterialPageRoute(builder: (_) => const MainPage());
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
