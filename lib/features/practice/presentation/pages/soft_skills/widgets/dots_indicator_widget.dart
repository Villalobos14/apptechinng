// lib/features/practice/presentation/pages/soft_skills/widgets/dots_indicator_widget.dart
import 'package:flutter/material.dart';

class DotsIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final int totalDots;
  final Color activeColor;
  final Color inactiveColor;

  const DotsIndicatorWidget({
    super.key,
    required this.currentIndex,
    required this.totalDots,
    this.activeColor = Colors.black87,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalDots,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentIndex == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentIndex == index 
                ? activeColor 
                : inactiveColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}