// lib/shared/widgets/common/app_bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../styles/app_colors.dart';
import '../../navigation/route_names.dart';
import '../../navigation/app_router.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navigationItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isActive = index == currentIndex;
                
                return GestureDetector(
                  onTap: () => _onItemTapped(context, index),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppColors.accent.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Icon(
                      item.icon,
                      size: 32,
                      color: isActive 
                          ? AppColors.accent 
                          : Colors.grey.shade600,
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

  void _onItemTapped(BuildContext context, int index) {
    final route = _navigationItems[index].route;
    
    // Check if route is implemented using our helper
    if (AppRouter.isRouteImplemented(route)) {
      context.go(route);
    } else {
      // Show "coming soon" message for unimplemented routes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.construction, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_navigationItems[index].label} feature coming soon! 🚧',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.accent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  static const List<_NavigationItem> _navigationItems = [
    _NavigationItem(
      icon: Icons.home_rounded,
      route: RouteNames.home,
      label: 'Home',
    ),
    _NavigationItem(
      icon: Icons.task_alt_rounded,
      route: RouteNames.tasks,
      label: 'Tasks',
    ),
    _NavigationItem(
      icon: Icons.psychology_rounded,
      route: RouteNames.practice,
      label: 'Practice',
    ),
    _NavigationItem(
      icon: Icons.history_rounded,
      route: RouteNames.history,
      label: 'History',
    ),
    _NavigationItem(
      icon: Icons.video_library_rounded,
      route: RouteNames.resources,
      label: 'Resources',
    ),
  ];
}

class _NavigationItem {
  final IconData icon;
  final String route;
  final String label;

  const _NavigationItem({
    required this.icon,
    required this.route,
    required this.label,
  });
}