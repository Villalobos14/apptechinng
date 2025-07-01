// lib/features/practice/presentation/widgets/practice_header_widget.dart
import 'package:flutter/material.dart';

import '../../../../shared/styles/app_text_styles.dart';

class PracticeHeaderWidget extends StatelessWidget {
  const PracticeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black87,
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Practice title and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Practice',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Learn soft skills through role-play',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}