// lib/shared/widgets/practice/modern_chat_bubble_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/chat_message.dart';
import 'chat_avatars.dart';

class ModernChatBubbleWidget extends StatefulWidget {
  final ChatMessage message;
  final bool showTimestamp;
  final VoidCallback? onRegenerateResponse;

  const ModernChatBubbleWidget({
    super.key,
    required this.message,
    this.showTimestamp = false,
    this.onRegenerateResponse,
  });

  @override
  State<ModernChatBubbleWidget> createState() => _ModernChatBubbleWidgetState();
}

class _ModernChatBubbleWidgetState extends State<ModernChatBubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _showActions = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.message.isUser
          ? const Offset(0.3, 0.0)
          : const Offset(-0.3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Iniciar animación
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMessageBubble(),
            if (widget.showTimestamp || _showActions) ...[
              const SizedBox(height: 8),
              _buildMessageFooter(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble() {
    if (widget.message.isSystem) {
      return _buildSystemMessage();
    }

    return GestureDetector(
      onLongPress: () {
        HapticFeedback.mediumImpact();
        setState(() {
          _showActions = !_showActions;
        });
      },
      child: Row(
        mainAxisAlignment: widget.message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar del AI (solo para mensajes de AI)
          if (!widget.message.isUser) ...[
            _buildAIAvatar(),
            const SizedBox(width: 12),
          ],

          // Burbuja de mensaje
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: _buildChatBubble(),
            ),
          ),

          // Espaciador y avatar para mensajes del usuario
          if (widget.message.isUser) ...[
            const SizedBox(width: 12),
            _buildUserAvatar(),
          ],
        ],
      ),
    );
  }

Widget _buildAIAvatar() {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: FutureBuilder<bool>(
      future: _checkImageExists(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          // La imagen existe, mostrarla
          return Image.asset(
            'assets/images/avatar2.png',
            fit: BoxFit.cover,
          );
        } else {
          // Fallback: Avatar con gradiente bonito
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF667EEA), 
                  Color(0xFF764BA2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.psychology_alt_rounded,
              color: Colors.white,
              size: 18,
            ),
          );
        }
      },
    ),
  );
}

// Método auxiliar para verificar si la imagen existe
Future<bool> _checkImageExists() async {
  try {
    await DefaultAssetBundle.of(context).load('assets/images/avatar2.png');
    return true;
  } catch (e) {
    print('❌ Imagen no encontrada: $e');
    return false;
  }
}

  Widget _buildUserAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.person_rounded,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF6B7280),
            size: 16,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              widget.message.content,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: widget.message.isUser ? const Color(0xFF10B981) : Colors.white,
        borderRadius: _getBorderRadius(),
        boxShadow: [
          BoxShadow(
            color: widget.message.isUser
                ? const Color(0xFF10B981).withOpacity(0.2)
                : const Color(0xFF000000).withOpacity(0.08),
            blurRadius: widget.message.isUser ? 12 : 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: widget.message.isUser
            ? null
            : Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
      ),
      child: _buildMessageContent(),
    );
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: widget.message.isUser
          ? const Radius.circular(20)
          : const Radius.circular(4),
      bottomRight: widget.message.isUser
          ? const Radius.circular(4)
          : const Radius.circular(20),
    );
  }

  Widget _buildMessageContent() {
    final textColor =
        widget.message.isUser ? Colors.white : const Color(0xFF111827);

    // Detectar texto con formato **bold**
    if (widget.message.content.contains('**')) {
      return _buildFormattedText(textColor);
    }

    return Text(
      widget.message.content,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: -0.1,
      ),
    );
  }

  Widget _buildFormattedText(Color textColor) {
    final parts = widget.message.content.split('**');
    final spans = <TextSpan>[];

    for (int i = 0; i < parts.length; i++) {
      if (i.isEven) {
        // Texto normal
        spans.add(TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: -0.1,
          ),
        ));
      } else {
        // Texto en negrita
        spans.add(TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w600,
            height: 1.4,
            letterSpacing: -0.1,
          ),
        ));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildMessageFooter() {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.message.isUser ? 60 : 44,
        right: widget.message.isUser ? 44 : 60,
      ),
      child: Row(
        mainAxisAlignment: widget.message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // Timestamp
          if (widget.showTimestamp) ...[
            Text(
              DateFormat('HH:mm').format(widget.message.timestamp),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w400,
              ),
            ),
            if (_showActions && widget.onRegenerateResponse != null)
              const SizedBox(width: 12),
          ],

          // Acciones
          if (_showActions && widget.onRegenerateResponse != null)
            _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botón regenerar
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            widget.onRegenerateResponse?.call();
            setState(() {
              _showActions = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.refresh_rounded,
                  size: 14,
                  color: Color(0xFF6B7280),
                ),
                SizedBox(width: 4),
                Text(
                  'Regenerar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Botón copiar
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Clipboard.setData(ClipboardData(text: widget.message.content));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Mensaje copiado'),
                duration: Duration(seconds: 2),
              ),
            );
            setState(() {
              _showActions = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.copy_rounded,
              size: 14,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
      ],
    );
  }
}
