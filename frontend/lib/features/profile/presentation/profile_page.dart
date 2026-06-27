// lib/features/profile/presentation/profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/presentation/main_page.dart';
import '../../../app/router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // 1. Ambil data user dari AuthProvider yang sudah login
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    // Jika first name & last name ada, gabungkan. Jika kosong, pakai default
    final String fullName = user != null
        ? '${user.firstName} ${user.lastName}'.trim()
        : 'Pengguna';
    final String email = user?.email ?? 'pengguna@email.com';

    return Scaffold(
      backgroundColor: AppColors.secondaryLight, // 0xFFF2EEF9 (Lav-50)
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
                // Tombol Back (Lingkaran Putih)
                GestureDetector(
                  onTap: () {
                    // Kembali ke beranda (Tab Index 0)
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(initialIndex: 0),
                      ),
                      (route) => false,
                    );
                  },
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

                // Teks Judul Header
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
                        'Atur data diri dan keamanan akunmu di sini.', // Teks disesuaikan agar lebih relevan
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
          // BODY CONTENT (Bisa di-scroll)
          // ==========================================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              // padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 24),

                // --- KARTU PROFIL UTAMA ---
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      // Avatar Placeholder (Sesuai desain kuning di figma)
                      Container(
                        width: 140,
                        height: 140,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFEB3B), // Warna kuning cerah
                          shape: BoxShape.circle,
                          // TODO: Jika punya API foto profil, gunakan image: DecorationImage(...)
                        ),
                        child: Center(
                          child: Text(
                            fullName.isNotEmpty
                                ? fullName[0].toUpperCase()
                                : '?',
                            style: AppTypography.h1.copyWith(
                              color: AppColors.dark,
                              fontSize: 64,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        fullName,
                        style: AppTypography.h6.copyWith(
                          color: AppColors.dark,
                          fontSize: 20,
                          fontWeight: AppTypography.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: AppTypography.body2.copyWith(
                          color: AppColors.dark.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- KARTU MENU (Ubah Profil & Keamanan) ---
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      _buildMenuButton('Ubah Profile', () {
                        // Navigasi ke Halaman Edit Profil
                        Navigator.pushNamed(context, AppRouter.editProfile);
                      }),
                      const SizedBox(height: 12),
                      _buildMenuButton('Keamanan Akun', () {
                        Navigator.pushNamed(context, AppRouter.changePassword);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // --- TOMBOL KELUAR (MERAH KRITIS) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.burnoutCritical, // Warna D14040
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () => _confirmLogout(context),
                      child: Text(
                        'Keluar',
                        style: AppTypography.h6.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100), // Spasi aman dari Bottom Nav
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk tombol menu di dalam card putih
  Widget _buildMenuButton(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.secondaryLight, // Lav-50
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppTypography.h6.copyWith(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: AppTypography.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Helper Function untuk Dialog Konfirmasi Logout
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Keluar',
          style: AppTypography.h6.copyWith(fontWeight: AppTypography.bold),
        ),
        content: Text(
          'Yakin ingin keluar dari akun ini?',
          style: AppTypography.body1,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: AppTypography.body1.copyWith(color: AppColors.muted),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.burnoutCritical,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              // 1. Tutup Dialog
              Navigator.pop(ctx);

              // 2. Panggil fungsi logout dari AuthProvider untuk menghapus token
              await context.read<AuthProvider>().logout();

              // 3. Arahkan kembali ke halaman Login (dan hapus semua history tumpukan layar)
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            child: Text(
              'Keluar',
              style: AppTypography.body1.copyWith(
                color: Colors.white,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
