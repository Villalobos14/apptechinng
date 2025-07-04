// lib/features/practice/data/models/soft_skill_model.dart
import 'package:flutter/material.dart';

class SoftSkill {
  final String id;
  final String title;
  final String description;
  final IconData iconData;
  final double progress; // 0.0 a 1.0
  final bool isCompleted;
  final Color iconBackgroundColor;

  const SoftSkill({
    required this.id,
    required this.title,
    required this.description,
    required this.iconData,
    required this.progress,
    required this.isCompleted,
    required this.iconBackgroundColor,
  });

  // Factory method para crear datos de ejemplo
  static List<SoftSkill> getSampleSoftSkills() {
    return [
      const SoftSkill(
        id: 'conflict_resolution',
        title: 'Conflict Resolution',
        description: 'Learn to analyze complex situations and find practical and creative solutions to overcome obstacles.',
        iconData: Icons.psychology_outlined,
        progress: 1.0, // 100% completado
        isCompleted: true,
        iconBackgroundColor: Color(0xFF4CAF50),
      ),
      const SoftSkill(
        id: 'communication',
        title: 'Communication',
        description: 'Master verbal and non-verbal communication skills to express ideas clearly and effectively.',
        iconData: Icons.chat_bubble_outline,
        progress: 0.7, // 70% completado
        isCompleted: false,
        iconBackgroundColor: Color(0xFF2196F3),
      ),
      const SoftSkill(
        id: 'leadership',
        title: 'Leadership',
        description: 'Develop leadership qualities to inspire, motivate and guide teams towards success.',
        iconData: Icons.groups_outlined,
        progress: 0.3, // 30% completado
        isCompleted: false,
        iconBackgroundColor: Color(0xFFFF9800),
      ),
      const SoftSkill(
        id: 'emotional_intelligence',
        title: 'Emotional Intelligence',
        description: 'Understand and manage emotions effectively in yourself and others for better relationships.',
        iconData: Icons.favorite_outline,
        progress: 0.0, // 0% no iniciado
        isCompleted: false,
        iconBackgroundColor: Color(0xFFE91E63),
      ),
      const SoftSkill(
        id: 'time_management',
        title: 'Time Management',
        description: 'Learn to prioritize tasks, manage deadlines and optimize productivity in personal and professional life.',
        iconData: Icons.schedule_outlined,
        progress: 0.5, // 50% completado
        isCompleted: false,
        iconBackgroundColor: Color(0xFF9C27B0),
      ),
      const SoftSkill(
        id: 'teamwork',
        title: 'Teamwork',
        description: 'Collaborate effectively with others, build trust and contribute to achieving common goals.',
        iconData: Icons.handshake_outlined,
        progress: 0.8, // 80% completado
        isCompleted: false,
        iconBackgroundColor: Color(0xFF607D8B),
      ),
    ];
  }
}