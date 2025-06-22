import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';
import 'package:techinng/features/onboarding/presentation/widgets/onboarding_image.dart';
import 'package:techinng/features/onboarding/presentation/widgets/onboarding_text.dart';
import 'package:techinng/features/onboarding/presentation/widgets/onboarding_progress.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/boar1.png',
      'title': 'Welcome to\nTeching',
      'subtitle': 'Improve your employability in a fun and effective way!!',
    },
    {
      'image': 'assets/images/boar2.png',
      'title': 'Learn by\nDoing',
      'subtitle':
          'Complete real-world challenges and projects that prepare you for the tech industry.',
    },
    {
      'image': 'assets/images/boar3.png',
      'title': 'Personalized\nLearning',
      'subtitle':
          'Get tailored content based on your interests, skills, and career goals.',
    },
    {
      'image': 'assets/images/boar4.png',
      'title': 'Track Your\nGrowth',
      'subtitle':
          'Visualize your progress, celebrate achievements, and stay motivated every step of the way.',
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top: Back / Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _currentPage == 0 ? null : _goBack,
                    child: Text(
                      "Back",
                      style: AppTextStyles.labelSmall.copyWith(
                        color: _currentPage == 0 ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _goToLogin,
                    child: Text("Skip", style: AppTextStyles.labelSmall),
                  ),
                ],
              ),
            ),

            // Swipeable content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (_, index) {
                  final data = onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnboardingImage(imagePath: data['image']!),
                      const SizedBox(height: 20),
                      OnboardingTexts(data: data),
                    ],
                  );
                },
              ),
            ),

            // Bottom: progress + next button
            OnboardingProgress(
              currentPage: _currentPage,
              totalPages: onboardingData.length,
              onNext: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
