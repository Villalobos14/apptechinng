// lib/features/onboarding/presentation/pages/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:go_router/go_router.dart';
import 'package:techinng/shared/styles/app_colors.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';
import 'package:techinng/shared/navigation/route_names.dart';
import 'package:techinng/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:techinng/features/onboarding/presentation/widgets/onboarding_progress_liquid.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final LiquidController _liquidController = LiquidController();
  final ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      image: 'assets/images/boar1.png',
      title: 'Welcome to\nTeching',
      subtitle: 'Improve your employability in a fun and effective way!!',
      bgColor: Colors.white,
    ),
    OnboardingPageData(
      image: 'assets/images/boar2.png',
      title: 'Learn by\nDoing',
      subtitle:
          'Complete real-world challenges and projects that prepare you for the tech industry.',
      bgColor: Colors.white,
    ),
    OnboardingPageData(
      image: 'assets/images/boar3.png',
      title: 'Personalized\nLearning',
      subtitle:
          'Get tailored content based on your interests, skills, and career goals.',
      bgColor: Colors.white,
    ),
    OnboardingPageData(
      image: 'assets/images/boar4.png',
      title: 'Track Your\nGrowth',
      subtitle:
          'Visualize your progress, celebrate achievements, and stay motivated every step of the way.',
      bgColor: Colors.white,
    ),
  ];

  void _goBack() {
    final prev = _pageNotifier.value - 1;
    if (prev >= 0) {
      _liquidController.animateToPage(page: prev);
    }
  }

  void _goToLogin() {
    context.go(RouteNames.login);
  }

  void _nextPage() {
    final next = _pageNotifier.value + 1;
    if (next < pages.length) {
      _liquidController.animateToPage(page: next);
    } else {
      _goToLogin();
    }
  }

  @override
  void dispose() {
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages.map((data) => OnboardingPage(data: data)).toList(),
            liquidController: _liquidController,
            enableLoop: false,
            waveType: WaveType.circularReveal,
            enableSideReveal: false,
            fullTransitionValue: 300,
            onPageChangeCallback: (index) {
              _pageNotifier.value = index;
            },
          ),

          // Top Back / Skip
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: _pageNotifier,
                    builder: (_, index, __) {
                      return GestureDetector(
                        onTap: index == 0 ? null : _goBack,
                        child: Text(
                          'Back',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: index == 0 ? Colors.grey : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: _goToLogin,
                    child: Text('Skip', style: AppTextStyles.labelSmall),
                  ),
                ],
              ),
            ),
          ),

          // Bottom progress + Get Started
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: _pageNotifier,
              builder: (_, currentPage, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OnboardingProgressLiquid(
                      controller: _liquidController,
                      currentPage: currentPage,
                      totalPages: pages.length,
                      onNext: _nextPage,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _goToLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24), // 8px unificado
                          ),
                          elevation: 4,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: const Text("Get Started"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
