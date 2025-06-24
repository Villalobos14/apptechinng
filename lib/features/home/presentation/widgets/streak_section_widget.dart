import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header text
          Text(
            'You are on a',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          
          // Main streak row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Streak text
              Text(
                '$streakDays day streak',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // 🔥 Fire Lottie animation
              Lottie.asset(
                'assets/lottie/fire.json',
                width: 48,
                height: 48,
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
                // 🛡️ Fallback in case Lottie doesn't load
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                },
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Week checkmarks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final checked = weekChecks[i];
              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: checked ? const Color(0xFF4CAF50) : Colors.transparent,
                      shape: BoxShape.circle,
                      border: checked ? null : Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: checked
                        ? const Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    days[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: checked 
                        ? Colors.black
                        : Colors.grey.shade600,
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