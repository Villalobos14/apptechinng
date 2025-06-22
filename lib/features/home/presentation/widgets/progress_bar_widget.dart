import 'package:flutter/material.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';

class ProgressBarWidget extends StatelessWidget {
  final double current;
  final double goal;

  const ProgressBarWidget({
    super.key,
    required this.current,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (current / goal).clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            height: 6,
            color: Colors.grey.shade300,
            child: FractionallySizedBox(
              widthFactor: percent,
              alignment: Alignment.centerLeft,
              child: Container(color: AppColors.accent),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                current.toInt().toString(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${goal.toInt()} pts',
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}