// lib/shared/widgets/common/placeholder_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text_styles.dart';
import 'app_bottom_navigation.dart';
import '../../navigation/route_names.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const PlaceholderPage({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          title,
          style: AppTextStyles.headlineMedium,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 64,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              title,
              style: AppTextStyles.displaySmall,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 12),
              Text(
                subtitle!,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🚧 Coming Soon',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go(RouteNames.home),
              icon: const Icon(Icons.home_rounded),
              label: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(currentIndex: currentIndex),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/practice')) return 2;
    if (location.startsWith('/history')) return 3;
    if (location.startsWith('/resources')) return 4;
    
    return 0; // Default to home
  }
}