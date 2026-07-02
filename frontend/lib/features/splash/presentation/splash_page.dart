import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/presentation/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Gunakan postFrameCallback agar context sudah valid
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSession();
    });
  }

  void _checkSession() async {
    // Kita panggil provider tanpa mengandalkan context halaman yang masih inisialisasi
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isAuthenticated = await authProvider.checkAuthStatus();

    if (!mounted) return;

    if (isAuthenticated) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(initialIndex: 0),
        ),
        (route) => false,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 28,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.spa_rounded,
                  color: AppColors.primary,
                  size: 52,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Mindara',
                style: AppTypography.h3.copyWith(color: AppColors.primaryDark),
              ),
              const SizedBox(height: 8),
              Text(
                'Kenali burnout lebih awal',
                style: AppTypography.body3.copyWith(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
