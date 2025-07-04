// lib/shared/widgets/practice/modern_chat_input_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModernChatInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final bool isGenerating;
  final VoidCallback onSend;
  final VoidCallback onStopGeneration;

  const ModernChatInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.isGenerating,
    required this.onSend,
    required this.onStopGeneration,
  });

  @override
  State<ModernChatInputWidget> createState() => _ModernChatInputWidgetState();
}

class _ModernChatInputWidgetState extends State<ModernChatInputWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _animationController.dispose();
    super.dispose();
  }
  
  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
      
      if (hasText) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }
  
  void _handleSubmitted() {
    if (widget.enabled && _hasText) {
      widget.onSend();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Campo de texto expandible
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 44,
                    maxHeight: 120,
                  ),
                  decoration: BoxDecoration(
                    color: widget.enabled 
                        ? const Color(0xFFF9FAFB)
                        : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: widget.focusNode.hasFocus && widget.enabled
                          ? const Color(0xFF10B981)
                          : const Color(0xFFE5E7EB),
                      width: widget.focusNode.hasFocus ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // TextField expandible
                      Expanded(
                        child: TextField(
                          controller: widget.controller,
                          focusNode: widget.focusNode,
                          enabled: widget.enabled,
                          maxLines: null,
                          minLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF111827),
                            height: 1.4,
                          ),
                          decoration: InputDecoration(
                            hintText: widget.enabled 
                                ? 'Escribe tu respuesta...'
                                : widget.isGenerating 
                                    ? 'AI está escribiendo...'
                                    : 'Chat finalizado',
                            hintStyle: TextStyle(
                              color: widget.enabled 
                                  ? const Color(0xFF9CA3AF)
                                  : const Color(0xFFD1D5DB),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onSubmitted: (_) => _handleSubmitted(),
                        ),
                      ),
                      
                      // Botón de acción integrado
                      Padding(
                        padding: const EdgeInsets.only(right: 4, bottom: 4),
                        child: widget.isGenerating
                            ? _buildStopButton()
                            : _buildSendButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSendButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: widget.enabled && _hasText ? () {
          HapticFeedback.lightImpact();
          widget.onSend();
        } : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: widget.enabled && _hasText
                ? const Color(0xFF10B981)
                : const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(18),
            boxShadow: widget.enabled && _hasText
                ? [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            Icons.arrow_upward_rounded,
            color: widget.enabled && _hasText
                ? Colors.white
                : const Color(0xFF9CA3AF),
            size: 20,
          ),
        ),
      ),
    );
  }
  
  Widget _buildStopButton() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onStopGeneration();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3B30).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.stop_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}