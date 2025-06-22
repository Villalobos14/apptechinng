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
      'subtitle': 'Complete real-world challenges and projects that prepare you for the tech industry.',
    },
    {
      'image': 'assets/images/boar3.png',
      'title': 'Personalized\nLearning',
      'subtitle': 'Get tailored content based on your interests, skills, and career goals.',
    },
    {
      'image': 'assets/images/boar4.png',
      'title': 'Track Your\nGrowth',
      'subtitle': 'Visualize your progress, celebrate achievements, and stay motivated every step of the way.',
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _handleTap(TapUpDetails details) {
    final width = MediaQuery.of(context).size.width;
    final dx = details.localPosition.dx;

    if (dx < width / 2) {
      _previousPage();
    } else {
      _nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapUp: _handleTap,
              ),
            ),
            Column(
              children: [
                // Encabezado (Back y Skip)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Back", style: AppTextStyles.labelSmall),
                      Text("Skip", style: AppTextStyles.labelSmall),
                    ],
                  ),
                ),

                const Spacer(flex: 2),

                // Imagen dinámica
                OnboardingImage(
                  controller: _controller,
                  onboardingData: onboardingData,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                ),

                const Spacer(),

                // Textos dinámicos
                OnboardingTexts(data: onboardingData[_currentPage]),

                const Spacer(flex: 2),

                // Progreso e ícono siguiente
                OnboardingProgress(
                  currentPage: _currentPage,
                  totalPages: onboardingData.length,
                  onNext: _nextPage,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
