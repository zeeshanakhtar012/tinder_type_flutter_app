class Message {
  String id;
  String senderId;
  String senderName;
  String senderProfileImage;
  String content;
  MessageType type; // voice, audio, image, video, file
  int timestamp;
  String status;
  Map<String, bool> cleared; // Map of userId to reaction

  // Additional properties for specific message types
  VoiceMessage? voiceMessage;
  AudioMessage? audioMessage;
  ImageMessage? imageMessage;
  VideoMessage? videoMessage;
  FileMessage? fileMessage;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderProfileImage,
    required this.content,
    required this.type,
    required this.timestamp,
    this.status = "sent",
    this.cleared = const {},
    this.voiceMessage,
    this.audioMessage,
    this.imageMessage,
    this.videoMessage,
    this.fileMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    MessageType messageType = MessageType.values[json["type"]];
    VoiceMessage? voiceMessage;
    AudioMessage? audioMessage;
    ImageMessage? imageMessage;
    VideoMessage? videoMessage;
    FileMessage? fileMessage;

    switch (messageType) {
      case MessageType.voice:
        voiceMessage = json["voiceMessage"] != null
            ? VoiceMessage(
          voiceUrl: json["voiceMessage"]["voiceUrl"],
          duration: json["voiceMessage"]["duration"],
        )
            : null;
        break;
      case MessageType.audio:
        audioMessage = json["audioMessage"] != null
            ? AudioMessage(
          audioUrl: json["audioMessage"]["audioUrl"],
          duration: json["audioMessage"]["duration"],
        )
            : null;
        break;
      case MessageType.image:
        imageMessage = json["imageMessage"] != null
            ? ImageMessage(
          imageUrl: json["imageMessage"]["imageUrl"],
        )
            : null;
        break;
      case MessageType.video:
        videoMessage = json["videoMessage"] != null
            ? VideoMessage(
          videoUrl: json["videoMessage"]["videoUrl"],
          duration: json["videoMessage"]["duration"],
        )
            : null;
        break;
      case MessageType.file:
        fileMessage = json["fileMessage"] != null
            ? FileMessage(
          fileName: json["fileMessage"]["fileName"],
          fileUrl: json["fileMessage"]["fileUrl"],
          fileSize: json["fileMessage"]["fileSize"],
        )
            : null;
        break;
      default:
        break;
    }

    return Message(
      id: json["id"],
      senderId: json["senderId"],
      senderName: json["senderName"],
      senderProfileImage: json["senderProfileImage"],
      content: json["content"],
      type: messageType,
      timestamp: json["timestamp"],
      status: json["status"] ?? "sent",
      cleared: Map<String, bool>.from(json["cleared"] ?? {}),
      voiceMessage: voiceMessage,
      audioMessage: audioMessage,
      imageMessage: imageMessage,
      videoMessage: videoMessage,
      fileMessage: fileMessage,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": id,
      "senderId": senderId,
      "senderName": senderName,
      "senderProfileImage": senderProfileImage,
      "content": content,
      "type": type.index,
      "timestamp": timestamp,
      "status": status,
      "reactions": cleared,
    };

    switch (type) {
      case MessageType.voice:
        json["voiceMessage"] = voiceMessage != null
            ? {
          "voiceUrl": voiceMessage!.voiceUrl,
          "duration": voiceMessage!.duration,
        }
            : null;
        break;
      case MessageType.audio:
        json["audioMessage"] = audioMessage != null
            ? {
          "audioUrl": audioMessage!.audioUrl,
          "duration": audioMessage!.duration,
        }
            : null;
        break;
      case MessageType.image:
        json["imageMessage"] = imageMessage != null
            ? {
          "imageUrl": imageMessage!.imageUrl,
        }
            : null;
        break;
      case MessageType.video:
        json["videoMessage"] = videoMessage != null
            ? {
          "videoUrl": videoMessage!.videoUrl,
          "duration": videoMessage!.duration,
        }
            : null;
        break;
      case MessageType.file:
        json["fileMessage"] = fileMessage != null
            ? {
          "fileName": fileMessage!.fileName,
          "fileUrl": fileMessage!.fileUrl,
          "fileSize": fileMessage!.fileSize,
        }
            : null;
        break;
      default:
        break;
    }

    return json;
  }

}

class FileMessage {
  String fileName;
  String fileUrl;
  String fileSize;

  FileMessage({
    required this.fileName,
    required this.fileUrl,
    required this.fileSize,
  });
}

class VideoMessage {
  String videoUrl;
  String duration;

  VideoMessage({
    required this.videoUrl,
    required this.duration,
  });
}

class ImageMessage {
  String imageUrl;

  ImageMessage({
    required this.imageUrl,
  });
}
class AudioMessage {
  String audioUrl;
  String duration;

  AudioMessage({
    required this.audioUrl,
    required this.duration,
  });
}
class VoiceMessage {
  String voiceUrl;
  String duration;

  VoiceMessage({
    required this.voiceUrl,
    required this.duration,
  });
}
enum MessageType {
  text,
  voice,
  audio,
  image,
  video,
  file,
}