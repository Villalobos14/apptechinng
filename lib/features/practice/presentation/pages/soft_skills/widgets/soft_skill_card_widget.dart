// lib/features/practice/presentation/pages/soft_skills/widgets/soft_skill_card_widget.dart
import 'package:flutter/material.dart';
import '../../../../data/models/soft_skill_model.dart';

class SoftSkillCardWidget extends StatelessWidget {
  final SoftSkill softSkill;
  final VoidCallback onTap;

  const SoftSkillCardWidget({
    super.key,
    required this.softSkill,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Gris claro como en el diseño chismosos
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
            Row(
              children: [
                // Ícono circular
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: softSkill.iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    softSkill.iconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Título
                Expanded(
                  child: Text(
                    softSkill.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                ),
                
                // Indicador de completado
                if (softSkill.isCompleted)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Descripción
            Text(
              softSkill.description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF666666),
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Progress bar
            Column(
              children: [
                // Barra de progreso
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: softSkill.progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333), // Negro como en el diseño
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Porcentaje y estado
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(softSkill.progress * 100).toInt()}% Complete',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF666666),
                      ),
                    ),
                    if (softSkill.isCompleted)
                      const Text(
                        'Mastered',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}