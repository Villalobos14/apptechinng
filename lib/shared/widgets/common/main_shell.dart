// lib/shared/widgets/common/main_shell.dart

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../../../features/home/presentation/pages/home_page.dart';
import '../../../shared/widgets/common/placeholder_page.dart';
import '../../../shared/widgets/common/app_bottom_navigation.dart';
import '../../styles/app_colors.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  int _previousIndex = 0;
  static const _transitionDuration = Duration(milliseconds: 300);

  final List<Widget> _pages = const [
    HomePage(),
    PlaceholderPage(
      title: 'Tasks',
      subtitle: 'Your pending tasks will appear here',
      icon: Icons.task_alt_rounded,
    ),
    PlaceholderPage(
      title: 'Practice',
      subtitle: 'Choose your practice mode',
      icon: Icons.psychology_rounded,
    ),
    PlaceholderPage(
      title: 'History',
      subtitle: 'Your practice history and progress',
      icon: Icons.history_rounded,
    ),
    PlaceholderPage(
      title: 'Resources',
      subtitle: 'Educational videos and materials',
      icon: Icons.video_library_rounded,
    ),
  ];

  void _onItemTapped(int newIndex) {
    if (newIndex == _currentIndex) return;
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si vamos a un índice menor, invertimos la animación
    final reverse = _currentIndex < _previousIndex;

    return Scaffold(
      body: PageTransitionSwitcher(
        duration: _transitionDuration,
        reverse: reverse,
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.background,
            child: child,
          );
        },
        // La key hace que reconozca cambios de página
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
