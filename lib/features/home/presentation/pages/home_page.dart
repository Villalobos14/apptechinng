import 'package:flutter/material.dart';

import '../../../../shared/styles/app_colors.dart';
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
      cardColor: const Color(0xFF3F51B5), // Indigo más intenso
      accentColor: const Color(0xFF303F9F), // Indigo oscuro
      isLarge: true,
      onTap: () => _showFeatureComingSoon('Technical Practice'),
    ),
    PracticeCardData(
      subtitle: 'Practice',
      titleBig: 'Behavioral\nQuestions',
      counter: '30/60 remain',
      cardColor: const Color.fromARGB(255, 3, 185, 79), // Verde intenso
      accentColor: const Color.fromARGB(255, 4, 198, 104), // Verde claro brillante
      onTap: () => _showFeatureComingSoon('Behavioral Questions'),
    ),
    PracticeCardData(
      subtitle: 'Practice',
      titleBig: 'Interview\nReadiness',
      cardColor: const Color.fromARGB(255, 231, 192, 1), // Ámbar puro
      accentColor: const Color.fromARGB(255, 219, 201, 1), // Ámbar claro
      onTap: () => _showFeatureComingSoon('Interview Practice'),
    ),
    PracticeCardData(
      subtitle: 'Practice',
      titleBig: 'Star Method',
      description: 'This is so\nimportant!',
      cardColor: const Color(0xFFD50000), // Rojo intenso
      accentColor: const Color(0xFFFF1744), // Rojo brillante
      onTap: () => _showFeatureComingSoon('STAR Method'),
    ),
  ];
}


  void _showFeatureComingSoon(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(child: Text('🚧', style: TextStyle(fontSize: 12))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$featureName feature coming soon!',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1F2937),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        elevation: 8,
      ),
    );
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
              UserGreetingWidget(
                userName: userName,
                onNotificationTap: () => _showFeatureComingSoon('Notifications'),
              ),
              const SizedBox(height: 18),
              StreakSectionWidget(
                streakDays: streakDays,
                weekChecks: weekChecks,
              ),
              const SizedBox(height: 20),
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
              ProgressBarWidget(
                current: progressPts,
                goal: progressGoal,
              ),
              const SizedBox(height: 28),
              PracticeGridWidget(practiceList: practiceList),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      // bottomNavigationBar removido: ahora está en ShellRoute
    );
  }
}
