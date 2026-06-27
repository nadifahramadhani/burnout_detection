// lib/features/profile/presentation/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  String? _selectedGender; // Variabel untuk menyimpan pilihan gender

  @override
  void initState() {
    super.initState();
    // PERBAIKAN: Ambil data dari ProfileProvider (yang bisa di-update)
    final profileUser = context.read<ProfileProvider>().user;
    final authUser = context.read<AuthProvider>().user;
    final user = profileUser ?? authUser;

    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');

    // PERBAIKAN: Masukkan data umur ke dalam input form jika ada
    _ageController = TextEditingController(
      text: user?.age != null ? user!.age.toString() : '',
    );

    // PERBAIKAN: Set gender yang sudah ada ('P' atau 'L')
    _selectedGender = user?.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jenis kelamin terlebih dahulu'),
          backgroundColor: AppColors.burnoutHigh,
        ),
      );
      return;
    }

    final provider = context.read<ProfileProvider>();

    // Kirim semua data termasuk gender ke backend
    final success = await provider.updateProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? 0,
      gender: _selectedGender!,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui!'),
          backgroundColor: AppColors.mint900,
        ),
      );
      Navigator.pop(context); // Kembali ke halaman Profile
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
      backgroundColor: AppColors.secondaryLight, // Lav-50
      body: Column(
        children: [
          // ==========================================
          // HEADER (HIJAU GELAP - Mint 900)
          // ==========================================
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
                        'Ubah Profile Kamu',
                        style: AppTypography.h6.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Perbarui informasi data dirimu',
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

          // ==========================================
          // FORM CONTENT
          // ==========================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- FOTO PROFIL (Static) ---
                      Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFEB3B),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _firstNameController.text.isNotEmpty
                                  ? _firstNameController.text[0].toUpperCase()
                                  : '?',
                              style: AppTypography.h1.copyWith(
                                color: AppColors.dark,
                                fontSize: 64,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // --- INPUT NAMA DEPAN ---
                      _buildInputField(
                        label: 'Nama Depan',
                        controller: _firstNameController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Nama depan wajib diisi'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // --- INPUT NAMA BELAKANG ---
                      _buildInputField(
                        label: 'Nama Belakang',
                        controller: _lastNameController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Nama belakang wajib diisi'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // --- INPUT GENDER (Dropdown) ---
                      _buildGenderDropdown(),
                      const SizedBox(height: 16),

                      // --- INPUT UMUR ---
                      _buildInputField(
                        label: 'Umur (Tahun)',
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Umur wajib diisi'
                            : null,
                      ),

                      const SizedBox(height: 40),

                      // --- TOMBOL SIMPAN ---
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mint200,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: provider.isLoading ? null : _submitUpdate,
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
                                    fontSize: 20,
                                    fontWeight: AppTypography.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk membuat kotak input estetik
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.body2.copyWith(
            fontWeight: AppTypography.bold,
            color: AppColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondaryLight, // Lav-50
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.mint900,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.burnoutCritical),
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget untuk membuat Dropdown Gender yang estetik
  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppTypography.body2.copyWith(
            fontWeight: AppTypography.bold,
            color: AppColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondaryLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.mint900,
                width: 1.5,
              ),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'P', child: Text('Perempuan')),
            DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ],
    );
  }
}
