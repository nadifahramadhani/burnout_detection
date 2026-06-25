import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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

  void _handleRegister(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      final success = await authProvider.register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _confirmPasswordController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi Berhasil! Silakan Login.'),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRouter.login);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Gagal mendaftar'),
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
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Daftar Sekarang!',
                    style: AppTypography.title1.copyWith(
                      color: AppColors.mint900,
                      fontSize: 36,
                      fontWeight: AppTypography.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lengkapi data dirimu untuk memulai perjalanan jurnal mentalmu.',
                    style: AppTypography.body1.copyWith(
                      color: AppColors.mint900,
                      fontSize: 14,
                      fontWeight: AppTypography.medium,
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInputLabel('Email'),
                              const SizedBox(height: 6),
                              _buildTextField(
                                controller: _emailController,
                                hintText: 'Masukkan email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) =>
                                    val!.isEmpty ? 'Email wajib diisi' : null,
                              ),
                              const SizedBox(height: 12),

                              _buildInputLabel('Nama Depan'),
                              const SizedBox(height: 6),
                              _buildTextField(
                                controller: _firstNameController,
                                hintText: 'Contoh: Budi',
                                validator: (val) => val!.isEmpty
                                    ? 'Nama depan wajib diisi'
                                    : null,
                              ),
                              const SizedBox(height: 12),

                              _buildInputLabel('Nama Belakang'),
                              const SizedBox(height: 6),
                              _buildTextField(
                                controller: _lastNameController,
                                hintText: 'Contoh: Santoso',
                                validator: (val) => val!.isEmpty
                                    ? 'Nama belakang wajib diisi'
                                    : null,
                              ),
                              const SizedBox(height: 12),

                              _buildInputLabel('Password'),
                              const SizedBox(height: 6),
                              _buildTextField(
                                controller: _passwordController,
                                hintText: 'Minimal 6 karakter',
                                obscureText: true,
                                validator: (val) => val!.length < 6
                                    ? 'Password min. 6 karakter'
                                    : null,
                              ),
                              const SizedBox(height: 12),

                              _buildInputLabel('Konfirmasi Password'),
                              const SizedBox(height: 6),
                              _buildTextField(
                                controller: _confirmPasswordController,
                                hintText: 'Ulangi password',
                                obscureText: true,
                                validator: (val) {
                                  if (val!.isEmpty)
                                    return 'Konfirmasi password wajib diisi';
                                  if (val != _passwordController.text)
                                    return 'Password tidak cocok';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () => _handleRegister(authProvider),
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
                                    'Daftar',
                                    style: AppTypography.h6.copyWith(
                                      color: AppColors.mint900,
                                      fontSize: 18,
                                      fontWeight: AppTypography.bold,
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
                      onTap: () => Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRouter.login),
                      child: Text.rich(
                        TextSpan(
                          text: 'Sudah punya akun? ',
                          style: AppTypography.body2.copyWith(
                            color: AppColors.dark,
                            fontSize: 12,
                            fontWeight: AppTypography.medium,
                          ),
                          children: [
                            TextSpan(
                              text: 'Masuk',
                              style: AppTypography.body2.copyWith(
                                color: AppColors.dark,
                                fontSize: 12,
                                fontWeight: AppTypography.bold,
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
      style: AppTypography.body1.copyWith(color: AppColors.dark, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Color(0xFFFFB4AB), fontSize: 12),
      ),
    );
  }
}
