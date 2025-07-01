// lib/features/practice/presentation/pages/soft_skills/pages/softskills_practice_page.dart
import 'package:flutter/material.dart';

import '../../../../../../shared/styles/app_colors.dart';
import '../../../../../../shared/widgets/common/app_bottom_navigation.dart';
import '../../../../../home/presentation/widgets/user_greeting_widget.dart';
import '../widgets/softskills_header_widget.dart';
import '../widgets/softskills_description_widget.dart';
import '../widgets/practice_cards_swiper_widget.dart';

class SoftskillsPracticePage extends StatefulWidget {
  const SoftskillsPracticePage({super.key});

  @override
  State<SoftskillsPracticePage> createState() => _SoftskillsPracticePageState();
}

class _SoftskillsPracticePageState extends State<SoftskillsPracticePage> {
  final String userName = 'Alejandro';
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _bottomNavIndex = 2; // Practice tab is active

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

  void _onLearningJourneyTap() {
    _showFeatureComingSoon('Learning Journey');
  }

  void _onSpecifyScenarioTap() {
    _showFeatureComingSoon('Specify Your Own Scenario');
  }

  void _onRandomPracticeTap() {
    _showFeatureComingSoon('Random Practice');
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
                '$featureName exercise coming soon!',
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

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavSelected(int index) {
    // Handle bottom navigation
    if (index == 0) {
      // Home - Go back to main shell
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else if (index == 2) {
      // Practice - Go back to practice main
      Navigator.of(context).pop();
    }
    // Other indices can be handled later
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                
                // User Greeting Section - Fixed
                UserGreetingWidget(
                  userName: userName,
                  onNotificationTap: _onNotificationTap,
                ),
                
                const SizedBox(height: 24),
                
                // Softskills Header Section - Fixed
                const SoftskillsHeaderWidget(),
                
                const SizedBox(height: 16),
                
                // Description Section - Fixed
                const SoftskillsDescriptionWidget(),
                
                const SizedBox(height: 32),
                
                // Practice Cards Swiper - Only this section has swipe
                PracticeCardsSwiperWidget(
                  pageController: _pageController,
                  currentIndex: _currentIndex,
                  onPageChanged: _onPageChanged,
                  onLearningJourneyTap: _onLearningJourneyTap,
                  onSpecifyScenarioTap: _onSpecifyScenarioTap,
                  onRandomPracticeTap: _onRandomPracticeTap,
                ),
                
                const SizedBox(height: 100), // Extra space for bottom navigation
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _bottomNavIndex,
        onItemSelected: _onBottomNavSelected,
      ),
    );
  }
}