import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {
  final PageController controller;
  final List<Map<String, String>> onboardingData;
  final Function(int) onPageChanged;

  const OnboardingImage({
    super.key,
    required this.controller,
    required this.onboardingData,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: controller,
        itemCount: onboardingData.length,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => Image.asset(
          onboardingData[index]['image']!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
