import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingProgressLiquid extends StatelessWidget {
  final LiquidController controller;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const OnboardingProgressLiquid({
    super.key,
    required this.controller,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: currentPage,
        count: totalPages,
        effect: WormEffect(
          dotHeight: 12,
          dotWidth: 12,
          spacing: 8,
          activeDotColor: Colors.black,
          dotColor: Colors.black26,
        ),
        onDotClicked: (i) => controller.animateToPage(page: i),
      ),
    );
  }
}
