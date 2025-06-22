import 'package:flutter/material.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';

class StreakSectionWidget extends StatelessWidget {
  final int streakDays;
  final List<bool> weekChecks;

  const StreakSectionWidget({
    super.key,
    required this.streakDays,
    required this.weekChecks,
  });

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$streakDays days of streak',
                style: AppTextStyles.streakCount,
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final checked = weekChecks[i];
              return Column(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: checked ? AppColors.accent : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: checked
                            ? AppColors.accent
                            : Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                    child: checked
                        ? const Icon(Icons.check,
                            size: 12, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    days[i],
                    style: AppTextStyles.labelSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: checked
                          ? AppColors.accent
                          : AppTextStyles.labelSmall.color,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
