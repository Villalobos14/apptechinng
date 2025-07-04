// lib/shared/widgets/practice/ai_typing_indicator_widget.dart
import 'package:flutter/material.dart';

class AITypingIndicatorWidget extends StatefulWidget {
  const AITypingIndicatorWidget({super.key});

  @override
  State<AITypingIndicatorWidget> createState() => _AITypingIndicatorWidgetState();
}

class _AITypingIndicatorWidgetState extends State<AITypingIndicatorWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    // Crear animaciones para cada punto con delays escalonados
    _dotAnimations = List.generate(3, (index) {
      return Tween<double>(
        begin: 0.4,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.2, // Delay escalonado: 0.0, 0.2, 0.4
            0.8 + (index * 0.2), // Final escalonado: 0.8, 1.0, 1.2 (clamped to 1.0)
            curve: Curves.easeInOut,
          ),
        ),
      );
    });

    // Iniciar animación en loop
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Avatar del AI
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667EEA).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.smart_toy_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Burbuja con indicador de typing
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Texto "AI Coach está escribiendo"
              const Text(
                'AI Coach está escribiendo',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Puntos animados
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) {
                  return AnimatedBuilder(
                    animation: _dotAnimations[index],
                    builder: (context, child) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: index < 2 ? 4 : 0,
                        ),
                        child: Transform.scale(
                          scale: _dotAnimations[index].value,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                const Color(0xFFD1D5DB),
                                const Color(0xFF667EEA),
                                _dotAnimations[index].value,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}