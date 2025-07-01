// lib/features/practice/presentation/widgets/practice_options_list_widget.dart
import 'package:flutter/material.dart';

import 'practice_card_widget.dart';

class PracticeOptionsListWidget extends StatelessWidget {
  final VoidCallback onSoftskillsReady;
  final VoidCallback onInterviewReady;
  final VoidCallback onSkillAssessment;

  const PracticeOptionsListWidget({
    super.key,
    required this.onSoftskillsReady,
    required this.onInterviewReady,
    required this.onSkillAssessment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Softskills Ready Card
        PracticeCardWidget(
          title: 'Softskills Ready',
          subtitle: 'Learn soft skills through role-play',
          progress: 73,
          cardColor: const Color(0xFF4CAF50), // Green
          onTap: onSoftskillsReady,
        ),
        
        const SizedBox(height: 20),
        
        // Interview Ready Card
        PracticeCardWidget(
          title: 'Interview Ready',
          subtitle: 'Learn soft skills through role-play',
          progress: 73,
          cardColor: const Color(0xFF5E35B1), // Purple
          onTap: onInterviewReady,
        ),
        
        const SizedBox(height: 20),
        
        // Skill Assessment Card
        PracticeCardWidget(
          title: 'Skill Assessment',
          subtitle: 'Learn soft skills through role-play',
          progress: 73,
          cardColor: const Color(0xFFE53935), // Red/Orange
          onTap: onSkillAssessment,
        ),
      ],
    );
  }
}