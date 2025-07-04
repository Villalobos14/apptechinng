// lib/features/practice/presentation/providers/chat_state_provider.dart
import 'package:flutter/foundation.dart';
import '../../../../shared/models/chat_message.dart';
import '../../data/models/soft_skill_model.dart';

enum ChatGenerationState {
  idle,
  generating,
  stopping,
  error,
}

class ChatStateProvider extends ChangeNotifier {
  final SoftSkill softSkill;
  
  // Estado del chat
  List<ChatMessage> _messages = [];
  ChatGenerationState _generationState = ChatGenerationState.idle;
  String _currentGeneratingMessage = '';
  String? _errorMessage;
  int _messageCount = 0;
  bool _isExerciseCompleted = false;
  
  // Control de scroll
  bool _isAtBottom = true;
  bool _showScrollToBottomButton = false;
  
  // Configuración
  static const int maxMessages = 2;
  
  ChatStateProvider({required this.softSkill}) {
    _initializeChat();
  }
  
  // Getters
  List<ChatMessage> get messages => List.unmodifiable(_messages);
  ChatGenerationState get generationState => _generationState;
  String get currentGeneratingMessage => _currentGeneratingMessage;
  String? get errorMessage => _errorMessage;
  int get messageCount => _messageCount;
  bool get isExerciseCompleted => _isExerciseCompleted;
  bool get isAtBottom => _isAtBottom;
  bool get showScrollToBottomButton => _showScrollToBottomButton;
  bool get canSendMessage => _generationState == ChatGenerationState.idle && !_isExerciseCompleted;
  bool get isGenerating => _generationState == ChatGenerationState.generating;
  
  void _initializeChat() {
    final welcomeMessage = ChatMessage.ai(
      content: _getInitialScenario(),
    );
    _messages.add(welcomeMessage);
    notifyListeners();
  }
  
  String _getInitialScenario() {
    switch (softSkill.id) {
      case 'conflict_resolution':
        return 'Hola! Soy tu AI Coach 🤖 Vamos a practicar resolución de conflictos.\n\n'
            '🎭 **Escenario:**\n'
            'Eres líder de un equipo de desarrollo. Dos de tus compañeros, Ana y Carlos, han tenido un desacuerdo sobre la arquitectura del proyecto. Ana prefiere un enfoque más tradicional, mientras que Carlos quiere implementar tecnologías nuevas. La tensión ha escalado y está afectando al resto del equipo.\n\n'
            '¿Cómo abordarías esta situación? Describe tu primer paso.';
      
      case 'communication':
        return 'Hola! Soy tu AI Coach 🤖 Vamos a practicar comunicación efectiva.\n\n'
            '🎭 **Escenario:**\n'
            'Tienes que presentar los resultados de un proyecto complejo a stakeholders que no tienen experiencia técnica. El proyecto tuvo algunos retrasos y desafíos técnicos, pero finalmente fue exitoso.\n\n'
            '¿Cómo estructurarías tu presentación para comunicar efectivamente tanto los desafíos como los logros?';
      
      default:
        return 'Hola! Soy tu AI Coach 🤖 Vamos a practicar ${softSkill.title}.\n\n'
            '🎭 **Escenario:**\n'
            'Te enfrentas a una situación desafiante en tu trabajo que requiere aplicar esta soft skill.\n\n'
            '¿Cuál sería tu primer paso?';
    }
  }
  
  Future<void> sendMessage(String content) async {
    if (!canSendMessage || content.trim().isEmpty) return;
    
    // Agregar mensaje del usuario
    final userMessage = ChatMessage.user(content: content.trim());
    _messages.add(userMessage);
    _messageCount++;
    
    // Cambiar estado a generando
    _generationState = ChatGenerationState.generating;
    _currentGeneratingMessage = '';
    _errorMessage = null;
    
    notifyListeners();
    
    try {
      // Simular generación de respuesta de IA
      await _generateAIResponse();
    } catch (e) {
      _handleError('Error al generar respuesta: ${e.toString()}');
    }
  }
  
  Future<void> _generateAIResponse() async {
    final responses = [
      'Excelente enfoque! Me gusta cómo consideras múltiples perspectivas. 🎯\n\n'
      'Ahora, profundicemos: ¿Qué harías específicamente si una de las partes muestra resistencia inicial a colaborar? ¿Tienes alguna técnica de persuasión en mente?',
      
      '¡Perfecto! 🌟 Has demostrado una comprensión sólida de ${softSkill.title}. '
      'Tu enfoque muestra madurez profesional y consideración por todos los involucrados.\n\n'
      'Excelente trabajo en este ejercicio. ¡Has completado la práctica!'
    ];
    
    final responseIndex = (_messageCount - 1).clamp(0, responses.length - 1);
    final fullResponse = responses[responseIndex];
    
    // Simular typing character por character
    for (int i = 0; i <= fullResponse.length; i++) {
      if (_generationState == ChatGenerationState.stopping) {
        break;
      }
      
      _currentGeneratingMessage = fullResponse.substring(0, i);
      notifyListeners();
      
      // Velocidad variable de typing (más rápido en espacios)
      final delay = fullResponse[i - 1 < 0 ? 0 : i - 1] == ' ' ? 30 : 50;
      await Future.delayed(Duration(milliseconds: delay));
    }
    
    // Solo agregar mensaje si no fue detenido
    if (_generationState != ChatGenerationState.stopping) {
      final aiMessage = ChatMessage.ai(content: _currentGeneratingMessage);
      _messages.add(aiMessage);
      
      // Verificar si el ejercicio está completo
      if (_messageCount >= maxMessages) {
        _isExerciseCompleted = true;
      }
    }
    
    // Resetear estado
    _generationState = ChatGenerationState.idle;
    _currentGeneratingMessage = '';
    notifyListeners();
  }
  
  void stopGeneration() {
    if (_generationState == ChatGenerationState.generating) {
      _generationState = ChatGenerationState.stopping;
      
      // Agregar mensaje parcial si hay contenido
      if (_currentGeneratingMessage.trim().isNotEmpty) {
        final partialMessage = ChatMessage.ai(
          content: _currentGeneratingMessage + '\n\n[Respuesta interrumpida]'
        );
        _messages.add(partialMessage);
      }
      
      _generationState = ChatGenerationState.idle;
      _currentGeneratingMessage = '';
      notifyListeners();
    }
  }
  
  void _handleError(String error) {
    _generationState = ChatGenerationState.error;
    _errorMessage = error;
    _currentGeneratingMessage = '';
    notifyListeners();
    
    // Auto-reset error después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (_generationState == ChatGenerationState.error) {
        _generationState = ChatGenerationState.idle;
        _errorMessage = null;
        notifyListeners();
      }
    });
  }
  
  void retryLastMessage() {
    if (_generationState == ChatGenerationState.error && _messages.isNotEmpty) {
      _generationState = ChatGenerationState.generating;
      _errorMessage = null;
      notifyListeners();
      
      _generateAIResponse().catchError((e) {
        _handleError('Error al reintentar: ${e.toString()}');
      });
    }
  }
  
  void updateScrollPosition({required bool isAtBottom, required bool showButton}) {
    if (_isAtBottom != isAtBottom || _showScrollToBottomButton != showButton) {
      _isAtBottom = isAtBottom;
      _showScrollToBottomButton = showButton;
      notifyListeners();
    }
  }
  
  void markScrolledToBottom() {
    _isAtBottom = true;
    _showScrollToBottomButton = false;
    notifyListeners();
  }
  
  void completeExercise() {
    if (!_isExerciseCompleted) {
      final completionMessage = ChatMessage.system(
        content: '🎉 ¡Ejercicio completado! Excelente trabajo practicando ${softSkill.title}.',
      );
      _messages.add(completionMessage);
      _isExerciseCompleted = true;
      notifyListeners();
    }
  }
  
  // Método para regenerar última respuesta
  void regenerateLastResponse() {
    if (_messages.isNotEmpty && _messages.last.isAI && !isGenerating) {
      // Remover último mensaje de IA
      _messages.removeLast();
      
      // Iniciar nueva generación
      _generationState = ChatGenerationState.generating;
      _currentGeneratingMessage = '';
      notifyListeners();
      
      _generateAIResponse().catchError((e) {
        _handleError('Error al regenerar: ${e.toString()}');
      });
    }
  }
}