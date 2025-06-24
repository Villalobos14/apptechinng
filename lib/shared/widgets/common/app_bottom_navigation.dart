// lib/shared/widgets/common/app_bottom_navigation.dart

import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navigationItems.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                final active = idx == currentIndex;

                return GestureDetector(
                  onTap: () => onItemSelected(idx),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active
                          ? const Color.fromARGB(255, 186, 186, 186).withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Opacity(
                      opacity: active ? 1.0 : 0.6,
                      child: Image.asset(
                        'assets/images/${item.assetName}',
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            item.fallbackIcon,
                            size: 32,
                            color: active
                                ? const Color.fromARGB(255, 227, 227, 227)
                                : AppColors.gray600,
                          );
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  final String assetName;
  final IconData fallbackIcon;
  const _NavigationItem(this.assetName, this.fallbackIcon);
}

const _navigationItems = [
  _NavigationItem('casa1.png',     Icons.home_rounded),
  _NavigationItem('tareas2.png',   Icons.task_alt_rounded),
  _NavigationItem('cards.png',     Icons.psychology_rounded),
  _NavigationItem('newspapper.png',Icons.history_rounded),
  _NavigationItem('rocket3.png',   Icons.video_library_rounded),
];
