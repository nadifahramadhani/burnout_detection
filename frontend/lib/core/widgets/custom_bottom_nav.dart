import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        // 1. POSISI: Kurangi padding bottom agar lebih dekat dengan garis home device
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 2),
        child: SizedBox(
          width: double.infinity,
          height: 104, // Tambah ruang total agar tidak overflow
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // 1. Kapsul Dasar (Bawah)
              Container(
                height:
                    80, // UKURAN: Kapsul dibesarkan (sebelumnya 72) agar nge-hug konten
                decoration: BoxDecoration(
                  color: AppColors.mint900,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),

              // 2. Lingkaran Besar di Tengah (Sebagai Tonjolan)
              Positioned(
                top: 0,
                child: Container(
                  width: 86, // Ukuran tonjolan disesuaikan dengan kapsul
                  height: 86,
                  decoration: const BoxDecoration(
                    color: AppColors.mint900,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // 3. Tombol Navigasi (Konten)
              Positioned(
                bottom: 8, // Beri jarak sedikit dari dasar kapsul
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Tombol Kiri (Home)
                    _buildNavItem(
                      icon: Icons.home_filled,
                      label: 'Home',
                      isActive: currentIndex == 1,
                      onTap: () => onTap(1),
                    ),

                    // Tombol Tengah (Jurnaling)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 24,
                      ), // Angkat tombol tengah
                      child: _buildNavItem(
                        icon: Icons.auto_fix_high,
                        label: 'Jurnaling',
                        isActive: currentIndex == 0,
                        onTap: () => onTap(0),
                      ),
                    ),

                    // Tombol Kanan (History)
                    _buildNavItem(
                      icon: Icons.bookmark,
                      label: 'History',
                      isActive: currentIndex == 2,
                      onTap: () => onTap(2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // LINGKARAN INDIKATOR
          Container(
            width: 48, // UKURAN: Disesuaikan agar fit dan tidak overflow
            height: 48,
            decoration: BoxDecoration(
              color: isActive ? AppColors.mint50 : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 26, // Ukuran ikon diseimbangkan
                color: isActive ? AppColors.mint900 : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // TEKS LABEL
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ],
      ),
    );
  }
}
