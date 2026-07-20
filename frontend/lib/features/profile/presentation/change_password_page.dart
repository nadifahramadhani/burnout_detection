

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/profile_provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitChangePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProfileProvider>();

    final success = await provider.changePassword(
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password berhasil diubah!'),
          backgroundColor: AppColors.mint900,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage),
          backgroundColor: AppColors.burnoutCritical,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.mint900,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.mint900,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Kamu',
                        style: AppTypography.h6.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Jaga selalu kerahasiaan akunmu',
                        style: AppTypography.body2.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keamanan Akun',
                          style: AppTypography.h6.copyWith(
                            color: AppColors.mint900,
                            fontSize: 20,
                            fontWeight: AppTypography.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ubah password secara berkala untuk menjaga akun tetap aman.',
                          style: AppTypography.body2.copyWith(
                            color: AppColors.dark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Form(
                    key: _formKey,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [

                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            bottom: 26,
                          ),
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 24,
                            right: 24,
                            bottom: 56,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mint900,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPasswordField(
                                label: 'Password Lama',
                                controller: _oldPasswordController,
                                obscureText: _obscureOld,
                                onToggleVisibility: () =>
                                    setState(() => _obscureOld = !_obscureOld),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Password lama harus diisi'
                                    : null,
                              ),
                              const SizedBox(height: 20),

                              _buildPasswordField(
                                label: 'Password Baru',
                                controller: _newPasswordController,
                                obscureText: _obscureNew,
                                onToggleVisibility: () =>
                                    setState(() => _obscureNew = !_obscureNew),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Password baru harus diisi';
                                  if (value.length < 6)
                                    return 'Password minimal 6 karakter';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              _buildPasswordField(
                                label: 'Konfirmasi Password',
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirm,
                                onToggleVisibility: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Konfirmasi password harus diisi';
                                  if (value != _newPasswordController.text)
                                    return 'Password tidak cocok';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          left: 24,
                          right: 24,
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.mint200,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              onPressed: provider.isLoading
                                  ? null
                                  : _submitChangePassword,
                              child: provider.isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.mint900,
                                      ),
                                    )
                                  : Text(
                                      'Simpan',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.body2.copyWith(
            color: Colors
                .white,
            fontWeight: AppTypography.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(
            color: AppColors.dark,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.mint200, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.burnoutCritical,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
