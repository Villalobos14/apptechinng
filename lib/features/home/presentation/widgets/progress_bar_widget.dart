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
        // Progress bar with exact colors
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5E5), // Exact gray color
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Progress fill
              Container(
                height: 12,
                width: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: percent,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF66BB6A), // Light green
                          Color(0xFF4CAF50), // Main green
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF4CAF50).withOpacity(0.3),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Progress labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Current points badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                current.toInt().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            // Goal points
            Text(
              '${goal.toInt()} pts • ${(goal - current).toInt()} to go',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ],
    );
  }
}