import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class OnboardingPageData {
  final String image;
  final String title;
  final String subtitle;
  final Color bgColor;

  OnboardingPageData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: data.bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30), // derecha
              blurRadius: 16,
              spreadRadius: 4,
              offset: const Offset(6, 0),
            ),
            BoxShadow(
              color: Colors.black.withAlpha(30), // izquierda
              blurRadius: 16,
              spreadRadius: 4,
              offset: const Offset(-6, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              data.image,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              data.title,
              style: AppTextStyles.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              data.subtitle,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
