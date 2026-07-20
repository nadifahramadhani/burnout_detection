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

        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 2),
        child: SizedBox(
          width: double.infinity,
          height: 104,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [

              Container(
                height:
                    80,
                decoration: BoxDecoration(
                  color: AppColors.mint900,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),

              Positioned(
                top: 0,
                child: Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    color: AppColors.mint900,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    _buildNavItem(
                      icon: Icons.home_filled,
                      label: 'Home',
                      isActive: currentIndex == 0,
                      onTap: () => onTap(0),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 24,
                      ),
                      child: _buildNavItem(
                        icon: Icons.auto_fix_high,
                        label: 'Jurnaling',
                        isActive: currentIndex == 1,
                        onTap: () => onTap(1),
                      ),
                    ),

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

          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive ? AppColors.mint50 : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 26,
                color: isActive ? AppColors.mint900 : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),

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
