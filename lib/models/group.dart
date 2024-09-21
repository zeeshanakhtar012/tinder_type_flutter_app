
import 'package:blaxity/models/user.dart';

class Group {
  final List<JoinRequest> joinRequests;
  final int id;
  final String img;
  final String title;
  final String owner;
  final String description;
  final bool isPrivate;
  final bool timeSensitive;
  final String createdAt;
  final String updatedAt;
  final int? attendeeLimit;
  final bool capacityLimited;
  final List<Member> members;
  final Chat chat;

  Group({
    required this.id,
    required this.img,
    required this.title,
    required this.owner,
    required this.description,
    required this.isPrivate,
    required this.timeSensitive,
    required this.createdAt,
    required this.updatedAt,
    this.attendeeLimit,
    required this.capacityLimited,
    required this.members,
    required this.chat,
    required this.joinRequests,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      img: json['img'],
      title: json['title'],
      owner: json['owner'],
      description: json['description'],
      isPrivate: json['is_private'] == 1,
      timeSensitive: json['time_sensitive'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      attendeeLimit: json['attendee_limit'],
      capacityLimited: json['capacity_limited'] == 1,
      members: (json['members'] as List<dynamic>?)
          ?.map((item) => Member.fromJson(item))
          .toList() ??
          [],
      chat: Chat.fromJson(json['chat']),
      joinRequests: (json['join_requests'] as List<dynamic>?)
          ?.map((item) => JoinRequest.fromJson(item))
          .toList() ??
          [],
    );
  }

}

class Member {
  final int id;
  final int groupId;
  final int userId;
  final bool isAdmin;
  final bool canJoin;
  final bool muted;
  final String createdAt;
  final String updatedAt;
  final bool joinStatus;
  final User? user;

  Member({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.isAdmin,
    required this.canJoin,
    required this.muted,
    required this.createdAt,
    required this.updatedAt,
    required this.joinStatus,
    this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      groupId: json['group_id'],
      userId: json['user_id'],
      isAdmin: json['is_admin'] == 1,
      canJoin: json['can_join'] == 1,
      muted: json['muted'] == 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      joinStatus: json['join_status']==1,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

}

// class User {
//   final int id;
//   final String fName;
//   final bool verified;
//   final String? profile;
//   final String email;
//   final String userType;
//   final String? deviceToken;
//   final String? lastSeen;
//   final bool activeNow;
//   final String? age;
//   final String? emailVerifiedAt;
//   final String? createdAt;
//   final String? updatedAt;
//   final int? phone;
//   final String? country;
//   final String? city;
//   final String? birthDate;
//   final String? partner1Name;
//   final String? partner2Name;
//   final String? partner1Sex;
//   final String? partner2Sex;
//   final String? userRecentImages;
//   final String? visibilityRecentImages;
//   final int? waitListStatus;
//   final int? coupleId;
//   final int? boostStatus;
//   final String? boostedAt;
//   final int? boostCount;
//   final int? goldenMember;
//   final int? profileViews;
//   final int? likes;
//
//   User({
//     required this.id,
//     required this.fName,
//     required this.verified,
//     this.profile,
//     required this.email,
//     required this.userType,
//     this.deviceToken,
//     this.lastSeen,
//     required this.activeNow,
//     this.age,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.phone,
//     this.country,
//     this.city,
//     this.birthDate,
//     this.partner1Name,
//     this.partner2Name,
//     this.partner1Sex,
//     this.partner2Sex,
//     this.userRecentImages,
//     this.visibilityRecentImages,
//     this.waitListStatus,
//     this.coupleId,
//     this.boostStatus,
//     this.boostedAt,
//     this.boostCount,
//     this.goldenMember,
//     this.profileViews,
//     this.likes,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       fName: json['f_name'] ?? '',
//       verified: json['verified'] == 1,
//       profile: json['profile'],
//       email: json['email'] ?? '',
//       userType: json['user_type'] ?? '',
//       deviceToken: json['device_token'],
//       lastSeen: json['last_seen'],
//       activeNow: json['active_now'] == 1,
//       age: json['age'],
//       emailVerifiedAt: json['email_verified_at'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       phone: json['phone'],
//       country: json['country'],
//       city: json['city'],
//       birthDate: json['birth_date'],
//       partner1Name: json['Partner_1_name'],
//       partner2Name: json['Partner_2_name'],
//       partner1Sex: json['Partner_1_sex'],
//       partner2Sex: json['Partner_2_sex'],
//       userRecentImages: json['user_recent_images'],
//       visibilityRecentImages: json['visibility_recent_images'],
//       waitListStatus: json['wait_list_status'],
//       coupleId: json['couple_id'],
//       boostStatus: json['boost_status'],
//       boostedAt: json['boosted_at'],
//       boostCount: json['boost_count'],
//       goldenMember: json['golden_member'],
//       profileViews: json['profile_views'],
//       likes: json['likes'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'f_name': fName,
//       'verified': verified ? 1 : 0,
//       'profile': profile,
//       'email': email,
//       'user_type': userType,
//       'device_token': deviceToken,
//       'last_seen': lastSeen,
//       'active_now': activeNow ? 1 : 0,
//       'age': age,
//       'email_verified_at': emailVerifiedAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'phone': phone,
//       'country': country,
//       'city': city,
//       'birth_date': birthDate,
//       'Partner_1_name': partner1Name,
//       'Partner_2_name': partner2Name,
//       'Partner_1_sex': partner1Sex,
//       'Partner_2_sex': partner2Sex,
//       'user_recent_images': userRecentImages,
//       'visibility_recent_images': visibilityRecentImages,
//       'wait_list_status': waitListStatus,
//       'couple_id': coupleId,
//       'boost_status': boostStatus,
//       'boosted_at': boostedAt,
//       'boost_count': boostCount,
//       'golden_member': goldenMember,
//       'profile_views': profileViews,
//       'likes': likes,
//     };
//   }
// }

class Chat {
  final int id;
  final String title;
  final int groupId;
  final String createdAt;
  final String updatedAt;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.title,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      title: json['title'],
      groupId: json['group_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      messages: (json['messages'] as List<dynamic>)
          .map((item) => Message.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'group_id': groupId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}
class Message {
  final int id;
  final int groupChatId;
  final int senderId;
  final String content;
  final String status;
  final int hasAttachment;
  final String createdAt;
  final String updatedAt;
  final List<Attachment> attachments;
  final List<Reaction> reactions;

  Message({
    required this.id,
    required this.groupChatId,
    required this.senderId,
    required this.content,
    required this.status,
    required this.hasAttachment,
    required this.createdAt,
    required this.updatedAt,
    required this.attachments,
    required this.reactions,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      groupChatId: json['group_chat_id'],
      senderId: json['sender_id'],
      content: json['content'],
      status: json['status'],
      hasAttachment: json['has_attachment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      attachments: (json['attachments'] as List)
          .map((i) => Attachment.fromJson(i))
          .toList(),
      reactions: (json['reactions'] as List)
          .map((i) => Reaction.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_chat_id': groupChatId,
      'sender_id': senderId,
      'content': content,
      'status': status,
      'has_attachment': hasAttachment,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'attachments': attachments.map((item) => item.toJson()).toList(),
      'reactions': reactions.map((item) => item.toJson()).toList(),
    };
  }
}

class Attachment {
  final int id;
  final int groupMessageId;
  final int userId;
  final String type;
  final String fileName;
  final String mimeType;
  final String size;
  final String createdAt;
  final String updatedAt;

  Attachment({
    required this.id,
    required this.groupMessageId,
    required this.userId,
    required this.type,
    required this.fileName,
    required this.mimeType,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      groupMessageId: json['group_message_id'],
      userId: json['user_id'],
      type: json['type'],
      fileName: json['file_name'],
      mimeType: json['mime_type'],
      size: json['size'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_message_id': groupMessageId,
      'user_id': userId,
      'type': type,
      'file_name': fileName,
      'mime_type': mimeType,
      'size': size,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Reaction {
  final int id;
  final int groupMessageId;
  final int userId;
  final String type; // Consider using an enum for type if it has specific values
  final String emoji; // Assuming reactions could include emojis or similar identifiers
  final String createdAt;
  final String updatedAt;

  Reaction({
    required this.id,
    required this.groupMessageId,
    required this.userId,
    required this.type,
    required this.emoji,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json['id'],
      groupMessageId: json['group_message_id'],
      userId: json['user_id'],
      type: json['type'],
      emoji: json['emoji'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_message_id': groupMessageId,
      'user_id': userId,
      'type': type,
      'emoji': emoji,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class JoinRequest {
  final int id;
  final int groupId;
  final int userId;
  final bool isAdmin;
  final bool canJoin;
  final bool muted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int joinStatus;
  final User user;

  JoinRequest({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.isAdmin,
    required this.canJoin,
    required this.muted,
    required this.createdAt,
    required this.updatedAt,
    required this.joinStatus,
    required this.user,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    return JoinRequest(
      id: json['id'],
      groupId: json['group_id'],
      userId: json['user_id'],
      isAdmin: json['is_admin'] == 1,
      canJoin: json['can_join'] == 1,
      muted: json['muted'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      joinStatus: json['join_status'],
      user: User.fromJson(json['user']),
    );
  }

}



