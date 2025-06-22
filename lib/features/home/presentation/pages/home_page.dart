// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/common/app_bottom_navigation.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/navigation/route_names.dart';
import '../widgets/user_greeting_widget.dart';
import '../widgets/streak_section_widget.dart';
import '../widgets/progress_bar_widget.dart';
import '../widgets/practice_grid_widget.dart';
import '../widgets/practice_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Mock data - esto después vendrá del ViewModel/Provider
  final String userName = 'Alejandro';
  final int streakDays = 21;
  final double progressPts = 520;
  final double progressGoal = 800;
  final List<bool> weekChecks = [true, true, true, true, true, true, true];

  late final List<PracticeCardData> practiceList;

  @override
  void initState() {
    super.initState();
    _initializePracticeList();
  }

  void _initializePracticeList() {
    practiceList = [
      PracticeCardData(
        subtitle: 'A little bit of',
        titleBig: 'Technical\nPractice',
        icon: Icons.code_rounded,
        isLarge: true,
        onTap: () => _showFeatureComingSoon('Technical Practice'),
      ),
      PracticeCardData(
        subtitle: 'Practice',
        titleBig: 'Behavioral\nQuestions',
        counter: '30/60 remain',
        counterColor: Colors.orange,
        icon: Icons.psychology_rounded,
        onTap: () => _showFeatureComingSoon('Behavioral Questions'),
      ),
      PracticeCardData(
        subtitle: 'Practice',
        titleBig: 'Interview',
        icon: Icons.record_voice_over_rounded,
        onTap: () => _showFeatureComingSoon('Interview Practice'),
      ),
      PracticeCardData(
        subtitle: 'Practice',
        titleBig: 'Star Method',
        description: 'This is so\nimportant!',
        icon: Icons.star_rounded,
        onTap: () => _showFeatureComingSoon('STAR Method'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              
              // User greeting section
              UserGreetingWidget(
                userName: userName,
                onNotificationTap: _onNotificationTap,
              ),
              const SizedBox(height: 18),

              // Streak section
              StreakSectionWidget(
                streakDays: streakDays,
                weekChecks: weekChecks,
              ),
              const SizedBox(height: 20),

              // Section title and description
              const Text(
                'How would you like to practice today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Overall progress',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              
              // Progress bar
              ProgressBarWidget(
                current: progressPts,
                goal: progressGoal,
              ),
              const SizedBox(height: 28),

              // Practice grid
              PracticeGridWidget(practiceList: practiceList),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }

  void _onNotificationTap() {
    _showFeatureComingSoon('Notifications');
  }

  void _showFeatureComingSoon(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.construction, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$featureName feature coming soon! 🚧',
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