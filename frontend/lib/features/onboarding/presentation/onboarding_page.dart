import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import 'widgets/onboarding_dot_indicator.dart';

class OnboardingData {
  final Color backgroundColor;
  final String imagePath;
  final String title;
  final String description;

  OnboardingData({
    required this.backgroundColor,
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      backgroundColor: const Color(0xFFB298E7),
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Mulai Harimu Tanpa Beban',
      description:
          'Kenali dirimu lebih dekat melalui jurnal singkat. Cukup luangkan beberapa menit sehari untuk mencatat apa yang kamu rasakan dan pikirkan hari ini.',
    ),
    OnboardingData(
      backgroundColor: const Color(0xFFD1F58C),
      imagePath: 'assets/images/onboarding_2.png',
      title: 'Lelah dan Penat Itu Wajar',
      description:
          'Merasa kewalahan dengan padatnya aktivitas? Pantau terus pola tidur, suasana hati, dan kebiasaan harianmu agar tahu kapan tubuh butuh jeda.',
    ),
    OnboardingData(
      backgroundColor: const Color(0xFF5A4AA2),
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Cegah Burnout Lebih Awal',
      description:
          'Jangan tunggu sampai benar-benar kehabisan energi. Mindara akan membantumu mengenali tanda-tanda kelelahan mental sejak dini agar kamu bisa kembali pulih.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed(AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pages[_currentIndex].backgroundColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final data = _pages[index];
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Mindara',
                        style: AppTypography.title3.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          letterSpacing: -0.20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(

                        padding: const EdgeInsets.only(
                          bottom: 200,
                          left: 40,
                          right: 40,
                        ),
                        child: index == 1

                            ? Transform.translate(
                                offset: const Offset(20, 0),
                                child: Image.asset(
                                  data.imagePath,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              )

                            : Image.asset(
                                data.imagePath,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(40, 48, 40, 40),
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _pages[_currentIndex].title,
                    style: AppTypography.title2.copyWith(
                      color: AppColors.mint900,
                      fontSize: 28,
                      height: 1.45,
                      letterSpacing: -0.40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _pages[_currentIndex].description,
                    style: AppTypography.body1.copyWith(
                      color: const Color(0xFF6B5EA8),
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: _currentIndex == 0
                              ? TextButton(
                                  onPressed: _goToLogin,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Skip',
                                    style: AppTypography.h6.copyWith(
                                      color: AppColors.mint900,
                                      fontWeight: AppTypography.bold,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  onPressed: _previousPage,
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 20,
                                    color: AppColors.mint900,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                        ),
                      ),

                      OnboardingDotIndicator(
                        length: _pages.length,
                        currentIndex: _currentIndex,
                      ),

                      SizedBox(
                        width: 80,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _currentIndex == _pages.length - 1
                              ? TextButton(
                                  onPressed: _goToLogin,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Selesai',
                                    style: AppTypography.h6.copyWith(
                                      color: AppColors.mint900,
                                      fontWeight: AppTypography.bold,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  onPressed: _nextPage,
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: AppColors.mint900,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
