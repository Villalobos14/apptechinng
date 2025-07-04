// lib/features/practice/presentation/pages/soft_skills/pages/learning_journey_menu_page.dart
import 'package:flutter/material.dart';

import '../../../../../../shared/styles/app_colors.dart';
import '../../../../../../shared/widgets/common/app_bottom_navigation.dart';
import '../../../../../home/presentation/widgets/user_greeting_widget.dart';
import '../../../../data/models/soft_skill_model.dart';
import '../widgets/soft_skill_card_widget.dart';
import '../widgets/softskills_header_widget.dart';
import 'ai_exercise_page.dart';

class LearningJourneyMenuPage extends StatefulWidget {
  const LearningJourneyMenuPage({super.key});

  @override
  State<LearningJourneyMenuPage> createState() => _LearningJourneyMenuPageState();
}

class _LearningJourneyMenuPageState extends State<LearningJourneyMenuPage> {
  final String userName = 'Alejandro';
  final int currentPoints = 25;
  int _bottomNavIndex = 2; // Practice tab active
  
  // Lista de soft skills (temporal - después vendrá del backend)
  late final List<SoftSkill> softSkills;

  @override
  void initState() {
    super.initState();
    softSkills = SoftSkill.getSampleSoftSkills();
  }

  void _onNotificationTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(child: Text('🔔', style: TextStyle(fontSize: 12))),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Notifications feature coming soon!',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1F2937),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        elevation: 8,
      ),
    );
  }

  void _onSoftSkillTap(SoftSkill softSkill) {
    // Navegar al ejercicio de IA
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIExercisePage(softSkill: softSkill),
      ),
    );
  }

  void _onBottomNavSelected(int index) {
    if (index == 0) {
      // Home - Go back to main shell
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else if (index == 2) {
      // Practice - Go back to practice main
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header fijo
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // User Greeting
                  UserGreetingWidget(
                    userName: userName,
                    onNotificationTap: _onNotificationTap,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Softskills Header con puntos
                  SoftskillsHeaderWidget(points: currentPoints),
                ],
              ),
            ),
            
            // Lista scrolleable de soft skills con fade effect ✨
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,  // Top fade
                      Colors.black,       // Visible area
                      Colors.black,       // Visible area  
                      Colors.transparent, // Bottom fade
                    ],
                    stops: [0.0, 0.05, 0.95, 1.0], // Ajustable: fade del 5%
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: ListView.builder(
                  padding: EdgeInsets.zero, // Removemos padding para fade suave
                  itemCount: softSkills.length + 2, // +2 para espacios
                  itemBuilder: (context, index) {
                    // Espacio al inicio
                    if (index == 0) {
                      return const SizedBox(height: 24);
                    }
                    
                    // Espacio al final
                    if (index == softSkills.length + 1) {
                      return const SizedBox(height: 44);
                    }
                    
                    // Soft skill card
                    final softSkillIndex = index - 1;
                    final softSkill = softSkills[softSkillIndex];
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SoftSkillCardWidget(
                        softSkill: softSkill,
                        onTap: () => _onSoftSkillTap(softSkill),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _bottomNavIndex,
        onItemSelected: _onBottomNavSelected,
      ),
    );
  }
}