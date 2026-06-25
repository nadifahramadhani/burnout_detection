import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk memvalidasi form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengeksekusi login
  void _handleLogin(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      final success = await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Berhasil!'),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRouter.main);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Gagal login'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                  const SizedBox(height: 48),
                  Text(
                    'Selamat Datang!',
                    style: AppTypography.title1.copyWith(
                      color: AppColors.mint900,
                      fontSize: 40,
                      fontWeight: AppTypography.bold,
                      height: 1.45,
                      letterSpacing: -0.40,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Senang melihatmu kembali! Yuk, catat kabarmu hari ini.',
                    style: AppTypography.body1.copyWith(
                      color: AppColors.mint900,
                      fontSize: 16,
                      fontWeight: AppTypography.medium,
                      height: 1.50,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 31),
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 64),
                        decoration: BoxDecoration(
                          color: AppColors.mint900,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        //FORM
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInputLabel('Email'),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller: _emailController,
                                hintText: 'Masukkan email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    value!.isEmpty ? 'Email wajib diisi' : null,
                              ),
                              const SizedBox(height: 24),

                              _buildInputLabel('Password'),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller: _passwordController,
                                hintText: 'Masukkan password',
                                obscureText: true,
                                validator: (value) => value!.isEmpty
                                    ? 'Password wajib diisi'
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 24,
                        right: 24,
                        child: SizedBox(
                          height: 62,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () => _handleLogin(authProvider),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.mint200,
                              foregroundColor: AppColors.mint900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: authProvider.isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.mint900,
                                  )
                                : Text(
                                    'Masuk',
                                    style: AppTypography.h6.copyWith(
                                      color: AppColors.mint900,
                                      fontSize: 20,
                                      fontWeight: AppTypography.bold,
                                      height: 1.20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRouter.register),
                      child: Text.rich(
                        TextSpan(
                          text: 'Belum punya akun? ',
                          style: AppTypography.body2.copyWith(
                            color: const Color(0xFF0A0A0A),
                            fontSize: 12,
                            fontWeight: AppTypography.medium,
                          ),
                          children: [
                            TextSpan(
                              text: 'Daftar',
                              style: AppTypography.body2.copyWith(
                                color: const Color(0xFF0A0A0A),
                                fontSize: 12,
                                fontWeight: AppTypography.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
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
        height: 1.43,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTypography.body1.copyWith(color: AppColors.dark),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Color(0xFFFFB4AB)),
      ),
    );
  }
}
