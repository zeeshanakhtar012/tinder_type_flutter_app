
class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String? voiceUrl;
  final String? videoUrl;
  final String? imageUrl;
  final MessageType messageType;
  final DateTime timestamp;
  final MessageStatus;

  ChatMessage(
    this.MessageStatus, {
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.voiceUrl,
    this.videoUrl,
    this.imageUrl,
    required this.messageType,
    required this.timestamp,
  });
}

enum MessageType {
  text,
  voice,
  video,
  image,
  sent,
  delivered,
  read,
}