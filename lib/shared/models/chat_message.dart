// lib/shared/models/chat_message.dart
enum MessageType {
  user,
  ai,
  system,
}

class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
  });

  // Constructores de conveniencia
  ChatMessage.user({
    required this.content,
    DateTime? timestamp,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       type = MessageType.user,
       timestamp = timestamp ?? DateTime.now();

  ChatMessage.ai({
    required this.content,
    DateTime? timestamp,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       type = MessageType.ai,
       timestamp = timestamp ?? DateTime.now();

  ChatMessage.system({
    required this.content,
    DateTime? timestamp,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       type = MessageType.system,
       timestamp = timestamp ?? DateTime.now();

  // Getters de conveniencia
  bool get isUser => type == MessageType.user;
  bool get isAI => type == MessageType.ai;
  bool get isSystem => type == MessageType.system;

  // Serialización
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      content: json['content'],
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, type: $type, content: ${content.substring(0, content.length > 50 ? 50 : content.length)}...)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}