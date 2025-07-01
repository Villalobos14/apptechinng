// lib/features/practice/presentation/pages/soft_skills/widgets/softskills_header_widget.dart
import 'package:flutter/material.dart';

import '../../../../../../shared/styles/app_text_styles.dart';

class SoftskillsHeaderWidget extends StatelessWidget {
  final int points;
  
  const SoftskillsHeaderWidget({
    super.key,
    this.points = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black87,
            ),
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Title
        Expanded(
          child: Text(
            'Softskills Ready',
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              height: 1.1,
            ),
          ),
        ),
        
        // Points/Trophy section
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.amber.shade200,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events,
                size: 20,
                color: Colors.amber.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                '$points',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}