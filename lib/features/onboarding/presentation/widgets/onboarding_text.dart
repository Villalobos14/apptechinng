import 'package:flutter/material.dart';
import 'package:techinng/shared/styles/app_text_styles.dart';

class OnboardingTexts extends StatelessWidget {
  final Map<String, String> data;

  const OnboardingTexts({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data['title']!, style: AppTextStyles.headlineLarge),
          const SizedBox(height: 10),
          Text(data['subtitle']!, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
