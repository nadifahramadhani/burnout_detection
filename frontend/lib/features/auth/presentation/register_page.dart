import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk 5 buah input field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/login.svg',
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Mindara',
                    style: AppTypography.title3.copyWith(
                      color: AppColors.mint900,
                      fontSize: 28,
                      fontWeight: AppTypography.bold,
                      letterSpacing: -0.20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Daftar Sekarang!',
                    style: AppTypography.title1.copyWith(
                      color: AppColors.mint900,
                      fontSize: 36, // Sedikit disesuaikan agar pas
                      fontWeight: AppTypography.bold,
                      height: 1.2,
                      letterSpacing: -0.40,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    'Lengkapi data dirimu untuk memulai perjalanan jurnal mentalmu.',
                    style: AppTypography.body1.copyWith(
                      color: AppColors.mint900,
                      fontSize: 14, // Disesuaikan agar lebih ringkas
                      fontWeight: AppTypography.medium,
                      height: 1.40,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 31),
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 56),
                        decoration: BoxDecoration(
                          color: AppColors.mint900,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Input Email
                            _buildInputLabel('Email'),
                            const SizedBox(height: 6), // Dari 8 ke 6
                            _buildTextField(
                              controller: _emailController,
                              hintText: '',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 12), // Dari 16 ke 12
                            // 2. Input Nama Depan
                            _buildInputLabel('Nama Depan'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: _firstNameController,
                              hintText: '',
                            ),
                            const SizedBox(height: 12),

                            // 3. Input Nama Belakang
                            _buildInputLabel('Nama Belakang'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: _lastNameController,
                              hintText: '',
                            ),
                            const SizedBox(height: 12),

                            // 4. Input Password
                            _buildInputLabel('Password'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: _passwordController,
                              hintText: '',
                              obscureText: true,
                            ),
                            const SizedBox(height: 12),

                            // 5. Input Konfirmasi Password
                            _buildInputLabel('Konfirmasi Password'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: _confirmPasswordController,
                              hintText: '',
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.mint200,
                              foregroundColor: AppColors.mint900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'Daftar',
                              style: AppTypography.h6.copyWith(
                                color: AppColors.mint900,
                                fontSize: 18,
                                fontWeight: AppTypography.bold,
                                height: 1.20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(AppRouter.login);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Sudah punya akun? ',
                          style: AppTypography.body2.copyWith(
                            color: AppColors.dark,
                            fontWeight: AppTypography.medium,
                            height: 1.33,
                            letterSpacing: -0.12,
                          ),
                          children: [
                            TextSpan(
                              text: 'Masuk',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.dark,
                                fontWeight: AppTypography.bold,
                                height: 1.33,
                                letterSpacing: -0.12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Text(
      text,
      style: AppTypography.body2.copyWith(
        color: const Color(0xFFFAFAFA),
        fontSize: 14,
        fontWeight: AppTypography.bold,
        height: 1.2,
        letterSpacing: -0.16,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTypography.body1.copyWith(color: AppColors.dark, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Color(0xFFD8D3EC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Color(0xFFD8D3EC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: AppColors.mint900),
        ),
      ),
    );
  }
}
