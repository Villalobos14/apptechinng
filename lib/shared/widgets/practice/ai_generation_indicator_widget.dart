// lib/shared/widgets/practice/ai_generation_indicator_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AIGenerationIndicatorWidget extends StatefulWidget {
  final String currentText;
  final VoidCallback onStop;

  const AIGenerationIndicatorWidget({
    super.key,
    required this.currentText,
    required this.onStop,
  });

  @override
  State<AIGenerationIndicatorWidget> createState() => _AIGenerationIndicatorWidgetState();
}

class _AIGenerationIndicatorWidgetState extends State<AIGenerationIndicatorWidget>
    with TickerProviderStateMixin {
  late AnimationController _cursorAnimationController;
  late AnimationController _stopButtonAnimationController;
  late Animation<double> _cursorAnimation;
  late Animation<double> _stopButtonAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animación del cursor parpadeante
    _cursorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _cursorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_cursorAnimationController);
    
    // Animación del botón stop
    _stopButtonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _stopButtonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _stopButtonAnimationController,
      curve: Curves.easeOut,
    ));
    
    // Iniciar animaciones
    _cursorAnimationController.repeat(reverse: true);
    _stopButtonAnimationController.forward();
  }

  @override
  void dispose() {
    _cursorAnimationController.dispose();
    _stopButtonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar del AI
        _buildAIAvatar(),
        
        const SizedBox(width: 12),
        
        // Burbuja con contenido generándose
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGeneratingBubble(),
              const SizedBox(height: 8),
              _buildStopButton(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildAIAvatar() {
    return Container(
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
    );
  }
  
  Widget _buildGeneratingBubble() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
        minHeight: 50,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
      child: widget.currentText.isEmpty 
          ? _buildTypingIndicator()
          : _buildGeneratingText(),
    );
  }
  
  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AI Coach está escribiendo',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(width: 8),
        _buildAnimatedDots(),
      ],
    );
  }
  
  Widget _buildAnimatedDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _cursorAnimationController,
          builder: (context, child) {
            final delay = index * 0.3;
            final progress = (_cursorAnimationController.value + delay) % 1.0;
            final opacity = (progress < 0.5) ? progress * 2 : (1 - progress) * 2;
            
            return Container(
              margin: EdgeInsets.only(right: index < 2 ? 3 : 0),
              child: Opacity(
                opacity: opacity.clamp(0.3, 1.0),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF667EEA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
  
  Widget _buildGeneratingText() {
    // Detectar texto con formato **bold**
    if (widget.currentText.contains('**')) {
      return _buildFormattedGeneratingText();
    }
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.currentText,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF111827),
              fontWeight: FontWeight.w400,
              height: 1.4,
              letterSpacing: -0.1,
            ),
          ),
        ),
        // Cursor parpadeante
        AnimatedBuilder(
          animation: _cursorAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _cursorAnimation.value,
              child: Container(
                width: 2,
                height: 20,
                margin: const EdgeInsets.only(left: 2, top: 2),
                decoration: const BoxDecoration(
                  color: Color(0xFF667EEA),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildFormattedGeneratingText() {
    final parts = widget.currentText.split('**');
    final spans = <TextSpan>[];
    
    for (int i = 0; i < parts.length; i++) {
      if (i.isEven) {
        // Texto normal
        spans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: -0.1,
          ),
        ));
      } else {
        // Texto en negrita
        spans.add(TextSpan(
          text: parts[i],
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w600,
            height: 1.4,
            letterSpacing: -0.1,
          ),
        ));
      }
    }
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(children: spans),
          ),
        ),
        // Cursor parpadeante
        AnimatedBuilder(
          animation: _cursorAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _cursorAnimation.value,
              child: Container(
                width: 2,
                height: 20,
                margin: const EdgeInsets.only(left: 2, top: 2),
                decoration: const BoxDecoration(
                  color: Color(0xFF667EEA),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildStopButton() {
    return FadeTransition(
      opacity: _stopButtonAnimation,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          widget.onStop();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFF3B30),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF3B30).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.stop_rounded,
                color: Colors.white,
                size: 14,
              ),
              SizedBox(width: 6),
              Text(
                'Detener generación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}