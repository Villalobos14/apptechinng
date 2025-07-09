// lib/shared/widgets/practice/chat_avatars.dart
import 'package:flutter/material.dart';

/// Avatares especializados para el chat de práctica de soft skills
class ChatAvatars {
  /// Avatar de la IA - Usado en todo el chat de práctica
  static Widget ai({double size = 32}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/avatar2.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error cargando avatar AI: $error');
          // Fallback elegante si hay error
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.psychology_alt_rounded,
              color: Colors.white,
              size: size * 0.56, // Proporción del ícono basada en el tamaño
            ),
          );
        },
      ),
    );
  }

  /// Avatar del usuario - Usado en todo el chat de práctica
  static Widget user({double size = 32}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/avatar2.png', // ← Misma imagen para ambos
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error cargando avatar de usuario: $error');
          // Fallback con gradiente verde para distinguir del AI
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: size * 0.56, // Proporción del ícono basada en el tamaño
            ),
          );
        },
      ),
    );
  }

  /// Avatar del sistema - Para mensajes informativos en el chat
  static Widget system({double size = 32}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Icon(
        Icons.info_outline_rounded,
        color: const Color(0xFF6B7280),
        size: size * 0.5,
      ),
    );
  }
}