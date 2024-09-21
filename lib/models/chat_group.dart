import 'package:firebase_database/firebase_database.dart';

class ChatGroup {
  String id; // Group ID
  String eventId; // ID of the event associated with this chat group
  List<String> memberIds; // List of user IDs who joined the event and are part of this chat group
  Map<String, int> messageCounters; // Unread message counters for each user

  ChatGroup({
    required this.id,
    required this.eventId,
    required this.memberIds,
    required this.messageCounters,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'memberIds': memberIds,
      'messageCounters': messageCounters,
    };
  }

  factory ChatGroup.fromMap(Map<String, dynamic> map) {
    return ChatGroup(
      id: map['id'] as String,
      eventId: map['eventId'] as String,
      memberIds: List<String>.from(map['memberIds'] ?? []),
      messageCounters: Map<String, int>.from(map['messageCounters'] ?? {}),
    );
  }

  factory ChatGroup.fromSnapshot(DataSnapshot snapshot) {
    final value = snapshot.value as Map<Object?, Object?>?;
    if (value == null) {
      return ChatGroup(
        id: snapshot.key ?? '',
        eventId: '',
        memberIds: [],
        messageCounters: {},
      );
    }

    // Convert value to Map<String, dynamic>
    final valueMap = value.map((key, value) => MapEntry(key as String, value));

    return ChatGroup(
      id: snapshot.key ?? '',
      eventId: valueMap['eventId'] as String? ?? '',
      memberIds: (valueMap['memberIds'] as List<dynamic>?)
          ?.map((member) => member as String)
          .toList() ?? [],
      messageCounters: (valueMap['messageCounters'] as Map<dynamic, dynamic>?)
          ?.map((key, value) => MapEntry(key as String, value as int)) ?? {},
    );
  }
}
