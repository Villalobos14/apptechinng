// lib/features/practice/presentation/pages/soft_skills/pages/ai_exercise_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../shared/models/chat_message.dart';
import '../../../../../../shared/widgets/results/gamification_results_page.dart';
import '../../../../data/models/soft_skill_model.dart';
import '../../../../../../shared/widgets/practice/chat_avatars.dart';

class AIExercisePage extends StatefulWidget {
  final SoftSkill softSkill;

  const AIExercisePage({
    super.key,
    required this.softSkill,
  });

  @override
  State<AIExercisePage> createState() => _AIExercisePageState();
}

class _AIExercisePageState extends State<AIExercisePage>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  List<ChatMessage> _messages = [];
  bool _isAIGenerating = false;
  String _currentGeneratingText = '';
  bool _isExerciseCompleted = false;
  int _messageCount = 0;
  bool _showScrollButton = false;


  late AnimationController _typingAnimationController;
  late AnimationController _scrollButtonAnimationController;

  static const int maxMessages = 2;

  @override
  void initState() {
    super.initState();

    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scrollButtonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _initializeExercise();
    _setupScrollListener();

    // Listener para actualizar botón de envío
    _messageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _typingAnimationController.dispose();
    _scrollButtonAnimationController.dispose();
    super.dispose();
  }

  void _initializeExercise() {
    final welcomeMessage = ChatMessage.ai(
      content: _getInitialScenario(),
    );

    setState(() {
      _messages = [welcomeMessage];
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  String _getInitialScenario() {
    switch (widget.softSkill.id) {
      case 'conflict_resolution':
        return 'Hola! Soy tu AI Coach 🤖 Vamos a practicar resolución de conflictos.\n\n'
            '🎭 **Escenario:**\n'
            'Eres líder de un equipo de desarrollo. Dos de tus compañeros, Ana y Carlos, han tenido un desacuerdo sobre la arquitectura del proyecto.\n\n'
            '¿Cómo abordarías esta situación?';

      case 'communication':
        return 'Hola! Soy tu AI Coach 🤖 Vamos a practicar comunicación efectiva.\n\n'
            '🎭 **Escenario:**\n'
            'Tienes que presentar resultados de un proyecto complejo a stakeholders sin experiencia técnica.\n\n'
            '¿Cómo estructurarías tu presentación?';

      default:
        return 'Hola! Soy tu AI Coach 🤖 Vamos a practicar ${widget.softSkill.title}.\n\n'
            '🎭 **Escenario:**\n'
            'Te enfrentas a una situación que requiere aplicar esta soft skill.\n\n'
            '¿Cuál sería tu primer paso?';
    }
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final isAtBottom = _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100;

      final shouldShowButton =
          !isAtBottom && _scrollController.position.pixels > 200;

      if (shouldShowButton != _showScrollButton) {
        setState(() {
          _showScrollButton = shouldShowButton;
        });

        if (shouldShowButton) {
          _scrollButtonAnimationController.forward();
        } else {
          _scrollButtonAnimationController.reverse();
        }
      }
    });
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty || _isAIGenerating) return;

    final userMessage = ChatMessage.user(content: content);

    setState(() {
      _messages.add(userMessage);
      _messageCount++;
      _isAIGenerating = true;
      _currentGeneratingText = '';
    });

    _messageController.clear();
    _focusNode.unfocus();
    _scrollToBottom();

    // Iniciar animación de typing
    _typingAnimationController.repeat(reverse: true);

    // Simular generación de IA
    _simulateAIGeneration();
  }

  void _simulateAIGeneration() async {
    final responses = [
      'Excelente enfoque! Me gusta cómo consideras múltiples perspectivas. 🎯\n\n'
          'Ahora profundicemos: ¿Qué harías específicamente si una de las partes muestra resistencia inicial?',
      '¡Perfecto! 🌟 Has demostrado una comprensión sólida de ${widget.softSkill.title}. '
          'Tu enfoque muestra madurez profesional.\n\n'
          'Excelente trabajo en este ejercicio. ¡Has completado la práctica!'
    ];

    final responseIndex = (_messageCount - 1).clamp(0, responses.length - 1);
    final fullResponse = responses[responseIndex];

    // Simular typing letra por letra
    for (int i = 0; i <= fullResponse.length; i++) {
      if (!mounted || !_isAIGenerating) break;

      setState(() {
        _currentGeneratingText = fullResponse.substring(0, i);
      });

      // Velocidad variable
      final char = i > 0 ? fullResponse[i - 1] : '';
      final delay = char == ' '
          ? 30
          : char == '\n'
              ? 100
              : 50;
      await Future.delayed(Duration(milliseconds: delay));
    }

    // Finalizar generación
    if (mounted && _isAIGenerating) {
      final aiMessage = ChatMessage.ai(content: _currentGeneratingText);
      setState(() {
        _messages.add(aiMessage);
        _isAIGenerating = false;
        _currentGeneratingText = '';

        if (_messageCount >= maxMessages) {
          _isExerciseCompleted = true;
        }
      });

      _typingAnimationController.stop();
      _scrollToBottom();

      // Si ejercicio completado, navegar después de un delay
      if (_isExerciseCompleted) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          _navigateToGamification();
        });
      }
    }
  }

  void _stopGeneration() {
    if (_isAIGenerating) {
      HapticFeedback.mediumImpact();

      setState(() {
        _isAIGenerating = false;
        // Agregar mensaje parcial si hay contenido
        if (_currentGeneratingText.trim().isNotEmpty) {
          final partialMessage = ChatMessage.ai(
              content: _currentGeneratingText + '\n\n[Respuesta interrumpida]');
          _messages.add(partialMessage);
        }
        _currentGeneratingText = '';
      });

      _typingAnimationController.stop();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _navigateToGamification() {
    if (!mounted) return;

    // Navegación segura con puntos fijos
   Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => GamificationResultsPage(
        previousStreak: 15, // Streak anterior
        newStreak: 16, // Nuevo streak
        weekProgress: 0.6, // Progreso semanal (60%)
        skillName: widget.softSkill.title,
        motivationalMessage: "You're on fire! Keep the flame lit every day!",
      ),
    ),
  );
}

  void _exitExercise() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('¿Salir del ejercicio?'),
        content: const Text('Tu progreso se perderá si sales ahora.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: Stack(
              children: [
                _buildMessagesList(),
                if (_showScrollButton) _buildScrollToBottomButton(),
              ],
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final hasNotch = safeAreaTop > 24;

    return Container(
      padding: EdgeInsets.only(
        top: safeAreaTop + (hasNotch ? 8 : 4),
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.5)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _exitExercise,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.softSkill.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _isAIGenerating
                      ? 'AI Coach está escribiendo...'
                      : 'AI Coach • $_messageCount/$maxMessages',
                  style: TextStyle(
                    color: _isAIGenerating
                        ? const Color(0xFF10B981)
                        : const Color(0xFF6B7280),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value: (_messageCount / maxMessages).clamp(0.0, 1.0),
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: _messages.length + (_isAIGenerating ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _messages.length && _isAIGenerating) {
            return _buildGeneratingMessage();
          }

          final message = _messages[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildChatBubble(message),
          );
        },
      ),
    );
  }

  Widget _buildGeneratingMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAIAvatar(),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
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
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _currentGeneratingText.isEmpty
                ? _buildTypingIndicator()
                : _buildGeneratingText(),
          ),
        ),
      ],
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
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(width: 8),
        AnimatedBuilder(
          animation: _typingAnimationController,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                final opacity =
                    ((_typingAnimationController.value + index * 0.3) % 1.0);
                return Container(
                  margin: EdgeInsets.only(right: index < 2 ? 3 : 0),
                  child: Opacity(
                    opacity: (opacity < 0.5 ? opacity * 2 : (1 - opacity) * 2)
                        .clamp(0.3, 1.0),
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
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGeneratingText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            _currentGeneratingText,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF111827),
              height: 1.4,
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _typingAnimationController,
          builder: (context, child) {
            return Opacity(
              opacity: _typingAnimationController.value,
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

  Widget _buildChatBubble(ChatMessage message) {
    if (message.isSystem) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline_rounded,
                size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message.content,
                style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment:
          message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!message.isUser) ...[
          _buildAIAvatar(),
          const SizedBox(width: 12),
        ],
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: message.isUser ? const Color(0xFF10B981) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: message.isUser
                    ? const Radius.circular(20)
                    : const Radius.circular(4),
                bottomRight: message.isUser
                    ? const Radius.circular(4)
                    : const Radius.circular(20),
              ),
              border: message.isUser
                  ? null
                  : Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: message.isUser
                      ? const Color(0xFF10B981).withOpacity(0.2)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message.content,
              style: TextStyle(
                fontSize: 16,
                color: message.isUser ? Colors.white : const Color(0xFF111827),
                height: 1.4,
              ),
            ),
          ),
        ),
        if (message.isUser) ...[
          const SizedBox(width: 12),
          _buildUserAvatar(),
        ],
      ],
    );
  }

  // ✅ AVATAR CORREGIDO - CON IMAGEN
  Widget _buildAIAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // Importante para recorte circular
      child: Image.asset(
        'assets/images/avatar2.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error cargando avatar en AIExercisePage: $error');
          // Fallback elegante si no se puede cargar la imagen
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.psychology_alt_rounded, // Ícono más moderno
              color: Colors.white,
              size: 18,
            ),
          );
        },
      ),
    );
  }

Widget _buildUserAvatar() {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF10B981).withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias, // Importante para recorte circular
    child: Image.asset(
      'assets/images/avatar2.png', // ← Misma imagen que la IA
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('❌ Error cargando avatar de usuario: $error');
        // Fallback: Avatar con gradiente verde si hay error
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 18,
          ),
        );
      },
    ),
  );
}

  Widget _buildScrollToBottomButton() {
    return Positioned(
      bottom: 80,
      right: 20,
      child: ScaleTransition(
        scale: _scrollButtonAnimationController,
        child: GestureDetector(
          onTap: () {
            _scrollToBottom();
            HapticFeedback.lightImpact();
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.keyboard_arrow_down, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 0.5)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _focusNode.hasFocus
                          ? const Color(0xFF10B981)
                          : const Color.fromARGB(255, 197, 197, 197),
                      width: _focusNode.hasFocus ? 2 : 1,
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    enabled:
                        !_isExerciseCompleted, // Puede escribir aunque AI esté generando
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: _isExerciseCompleted
                          ? Colors.grey.shade400
                          : const Color(
                              0xFF111827), // o el color que tú quieras
                    ),

                    decoration: InputDecoration(
                      hintText: _isExerciseCompleted
                          ? 'Chat finalizado'
                          : 'Escribe tu respuesta...',
                      hintStyle: TextStyle(
                        color: _isExerciseCompleted
                            ? Colors.grey
                                .shade400 // un gris claro para chat finalizado
                            : Color.fromARGB(255, 190, 190, 190), // otro gris para cuando puede escribir
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    onSubmitted: (_) {
                      if (!_isAIGenerating &&
                          _messageController.text.trim().isNotEmpty) {
                        _sendMessage();
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Botón que cambia entre enviar y stop
              GestureDetector(
                onTap: _isAIGenerating
                    ? _stopGeneration
                    : (_messageController.text.trim().isNotEmpty &&
                            !_isExerciseCompleted)
                        ? _sendMessage
                        : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _isAIGenerating
                        ? const Color(0xFFFF3B30) // Rojo para stop
                        : (_messageController.text.trim().isNotEmpty &&
                                !_isExerciseCompleted)
                            ? const Color(0xFF10B981) // Verde para enviar
                            : const Color(0xFFE5E7EB), // Gris deshabilitado
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: (_isAIGenerating ||
                            (_messageController.text.trim().isNotEmpty &&
                                !_isExerciseCompleted))
                        ? [
                            BoxShadow(
                              color: (_isAIGenerating
                                      ? const Color(0xFFFF3B30)
                                      : const Color(0xFF10B981))
                                  .withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    _isAIGenerating
                        ? Icons
                            .stop_rounded // Icono de stop cuando está generando
                        : Icons
                            .arrow_upward_rounded, // Icono de enviar cuando puede enviar
                    color: (_isAIGenerating ||
                            (_messageController.text.trim().isNotEmpty &&
                                !_isExerciseCompleted))
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}