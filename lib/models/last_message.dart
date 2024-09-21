import 'message.dart';

class LastMessage {
  String sender, lastMessage;
  int timestamp, counter;
  String chatRoomId;
  String status;
  MessageType type;
  String roomType;
  List<String> membersId;

//<editor-fold desc="Data Methods">

  LastMessage({
    required this.sender,
    required this.lastMessage,
    required this.timestamp,
    required this.counter,
    required this.chatRoomId,
    required this.status,
    required this.type,
    required this.roomType,
    required this.membersId,
  });

//<ed@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is LastMessage &&
              runtimeType == other.runtimeType &&
              sender == other.sender &&
              lastMessage == other.lastMessage &&
              timestamp == other.timestamp &&
              counter == other.counter &&
              chatRoomId == other.chatRoomId &&
              status == other.status &&
              type == other.type &&
              roomType == other.roomType &&
              membersId == other.membersId);

  @override
  int get hashCode =>
      sender.hashCode ^
      lastMessage.hashCode ^
      timestamp.hashCode ^
      counter.hashCode ^
      chatRoomId.hashCode ^
      status.hashCode ^
      type.hashCode ^
      roomType.hashCode ^
      membersId.hashCode;

  @override
  String toString() {
    return 'LastMessage{' +
        ' sender: $sender,' +
        ' lastMessage: $lastMessage,' +
        ' timestamp: $timestamp,' +
        ' counter: $counter,' +
        ' chatRoomId: $chatRoomId,' +
        ' status: $status,' +
        ' type: $type,' +
        ' roomType: $roomType,' +
        ' membersId: $membersId,' +
        '}';
  }

  LastMessage copyWith({
    String? sender,
    String? lastMessage,
    int? timestamp,
    int? counter,
    String? chatRoomId,
    String? status,
    MessageType? type,
    String? roomType,
    List<String>? membersId,
  }) {
    return LastMessage(
      sender: sender ?? this.sender,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
      counter: counter ?? this.counter,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      status: status ?? this.status,
      type: type ?? this.type,
      roomType: roomType ?? this.roomType,
      membersId: membersId ?? this.membersId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': this.sender,
      'lastMessage': this.lastMessage,
      'timestamp': this.timestamp,
      'counter': this.counter,
      'chatRoomId': this.chatRoomId,
      'status': this.status,
      "type": type.index,
      'roomType': this.roomType,
      'membersId': this.membersId,
    };
  }

  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      sender: map['sender'] as String,
      lastMessage: map['lastMessage'] as String,
      timestamp: map['timestamp'] as int,
      counter: map['counter'] as int,
      chatRoomId: map['chatRoomId'] as String,
      status: map['status'] as String,
      type: MessageType.values[map["type"]],
      roomType: map['roomType'] as String,
      membersId: List<String>.from(map['membersId']),
    );
  }

//</editor-fold>
}
