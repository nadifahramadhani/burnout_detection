import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(flex: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 120, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Mindara',
                        style: AppTypography.title3.copyWith(
                          color: AppColors.mint900,
                          fontSize: 48,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Temani harimu dengan jurnal singkat, pantau pola hidup, dan kenali tanda burnout lebih awal.',
                        style: AppTypography.h6.copyWith(
                          color: AppColors.dark,
                          fontWeight: AppTypography.medium,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 62,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(AppRouter.onboarding);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.mint200,
                        foregroundColor: AppColors.mint900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ayo Mulai',
                            style: AppTypography.h6.copyWith(
                              color: AppColors.mint900,
                              fontWeight: AppTypography.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 24),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
