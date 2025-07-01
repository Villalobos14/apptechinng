// lib/features/practice/presentation/pages/soft_skills/widgets/softskills_description_widget.dart
import 'package:flutter/material.dart';

import '../../../../../../shared/styles/app_text_styles.dart';

class SoftskillsDescriptionWidget extends StatelessWidget {
  const SoftskillsDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48), // Align with title (after back button)
      child: Text(
        'Enhance your soft skills with daily exercises and interactive challenges',
        style: AppTextStyles.bodyLarge.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600,
          height: 1.4,
        ),
      ),
    );
  }
}