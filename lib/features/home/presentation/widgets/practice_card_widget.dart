import 'package:flutter/material.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';

class PracticeCardData {
  final String titleBig;
  final String? subtitle;
  final String? description;
  final String? counter;
  final Color? counterColor;
  final IconData icon;
  final bool isLarge;
  final VoidCallback? onTap;

  PracticeCardData({
    required this.titleBig,
    this.subtitle,
    this.description,
    this.counter,
    this.counterColor,
    required this.icon,
    this.isLarge = false,
    this.onTap,
  });
}

class PracticeCardWidget extends StatelessWidget {
  final PracticeCardData data;

  const PracticeCardWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: data.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.subtitle != null) ...[
              Text(
                data.subtitle!,
                style: AppTextStyles.cardSubtitle,
              ),
              const SizedBox(height: 2),
            ],
            Flexible(
              child: Text(
                data.titleBig,
                style: data.isLarge 
                    ? AppTextStyles.cardTitleLarge 
                    : AppTextStyles.cardTitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (data.description != null) ...[
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  data.description!,
                  style: AppTextStyles.cardDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (data.counter != null)
                  Text(
                    data.counter!,
                    style: AppTextStyles.cardCounter.copyWith(
                      color: data.counterColor,
                    ),
                  ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    data.icon,
                    size: 20,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}