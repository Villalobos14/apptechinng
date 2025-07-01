// lib/features/practice/presentation/pages/soft_skills/widgets/practice_cards_swiper_widget.dart
import 'package:flutter/material.dart';

import 'softskills_card_widget.dart';
import 'dots_indicator_widget.dart';

class PracticeCardsSwiperWidget extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onLearningJourneyTap;
  final VoidCallback onSpecifyScenarioTap;
  final VoidCallback onRandomPracticeTap;

  const PracticeCardsSwiperWidget({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onLearningJourneyTap,
    required this.onSpecifyScenarioTap,
    required this.onRandomPracticeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cards PageView with space for shadow
        SizedBox(
          height: 415, // Optimized height for shadow
          child: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: [
              // Learning Journey Card
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 15), // Reduced bottom padding
                child: SoftskillsCardWidget(
                  title: 'Learning Journey',
                  description: 'Follow a structured path to master essential soft skills',
                  cardColor: const Color.fromRGBO(76, 175, 80, 1), // Green RGB
                  onTap: onLearningJourneyTap,
                ),
              ),
              
              // Specify Your Own Card
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 15), // Reduced bottom padding
                child: SoftskillsCardWidget(
                  title: 'Specify Your Own',
                  description: 'Create custom scenarios tailored to your needs',
                  cardColor: const Color.fromRGBO(33, 150, 243, 1), // Blue RGB
                  onTap: onSpecifyScenarioTap,
                ),
              ),
              
              // Random Practice Card
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 15), // Reduced bottom padding
                child: SoftskillsCardWidget(
                  title: 'Random',
                  description: 'Train by surprise, just like real life.',
                  cardColor: const Color.fromRGBO(229, 57, 53, 1), // Red/Orange RGB
                  onTap: onRandomPracticeTap,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Dots Indicator
        DotsIndicatorWidget(
          currentIndex: currentIndex,
          totalDots: 3,
        ),
      ],
    );
  }
}