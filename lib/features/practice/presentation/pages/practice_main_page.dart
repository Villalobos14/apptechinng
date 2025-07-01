// lib/features/practice/presentation/pages/practice_main_page.dart
import 'package:flutter/material.dart';

import '../../../../shared/styles/app_colors.dart';
import '../../../home/presentation/widgets/user_greeting_widget.dart';
import '../widgets/practice_header_widget.dart';
import '../widgets/practice_options_list_widget.dart';
import 'soft_skills/pages/softskills_practice_page.dart';

class PracticeMainPage extends StatefulWidget {
  const PracticeMainPage({super.key});

  @override
  State<PracticeMainPage> createState() => _PracticeMainPageState();
}

class _PracticeMainPageState extends State<PracticeMainPage> {
  final String userName = 'Alejandro';

  void _onNotificationTap() {
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
              child: const Center(child: Text('🔔', style: TextStyle(fontSize: 12))),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Notifications feature coming soon!',
                style: TextStyle(
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

  void _onSoftskillsReady() {
    // Navigate to Softskills Practice Page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SoftskillsPracticePage(),
      ),
    );
  }

  void _onInterviewReady() {
    // TODO: Navigate to interview practice
    _showFeatureComingSoon('Interview Ready');
  }

  void _onSkillAssessment() {
    // TODO: Navigate to skill assessment
    _showFeatureComingSoon('Skill Assessment');
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
              
              // User Greeting Section
              UserGreetingWidget(
                userName: userName,
                onNotificationTap: _onNotificationTap,
              ),
              
              const SizedBox(height: 32),
              
              // Practice Header Section
              const PracticeHeaderWidget(),
              
              const SizedBox(height: 32),
              
              // Practice Options List
              PracticeOptionsListWidget(
                onSoftskillsReady: _onSoftskillsReady,
                onInterviewReady: _onInterviewReady,
                onSkillAssessment: _onSkillAssessment,
              ),
              
              const SizedBox(height: 80), // Extra space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }
}