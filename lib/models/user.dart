import 'dart:developer';
import 'package:blaxity/models/event_action.dart';

class UserResponse {
  final String? message;
  final User user;
  String? has_couple;
  List<User>? Connections;

  UserResponse({
     this.message,
    required this.user,
     this.has_couple,
     this.Connections,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'] as String?,
      user: User.fromJson(json['user']),
      has_couple: json['has_couple'] as String?,
      Connections
          : (json['connections'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
class User {
  String? id;
  String? fName;
  int? verified;
  int? age;
  int? matching_percentage;
  String? profile;
  String? email;
  String? userType;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;
  String? isSubscribed;
  String? lastSeen;
  String? phone;
  String? country;
  String? city;
  String? birthDate;
  String? partner1Name;
  String? partner2Name;
  String? partner1Sex;
  String? partner2Sex;
  String? userRecentImages;
  String? visibilityRecentImages;
  int? waitListStatus;
  int? coupleId;
  String? boostStatus;
  String? boostedAt;
  String? boostCount;
  int? goldenMember;
  String? profileViews;
  String? likes;
  String? activeNow;
  List<Hobby>? hobbies;
  List<Desire>? desires;
  AdditionalInfo? additionalInfo;
  Reference? reference;
  Verification? verification;
  List<Match>? matches;
  List<Match>? matchedBy;
  List<Post>? posts;
  List<Comment>? comments;
  List<Notification>? notifications;
  List<OwnerEvent>? ownerEvent;
  List<EventAction>? eventsAction;
  List<Club>? clubs;
  List<Blog>? blogs;
  List<CallLog>? callLogsAsCaller;
  List<CallLog>? callLogsAsCalled;
  List<GroupMember>? groupMembers;
  List<Transaction>? transactions;
  List<User>? blockedUsers;
  CoupleRecentImage? coupleRecentImage;
  SingleRecentImage? singleRecentImage;
  List<Party>? parties;
  CommonCoupleData? commonCoupleData;
  List<LikedUserForSingle>? likedUserForSingle;
  List<LikedUserForCouple>? likedUserForCouple;
  List<CoupleMatch>? coupleMatches;
  int? isAdmin;
  String? stripeId;
  String? pmType;
  String? pmLastFour;
  String? trialEndsAt;
  String? username;
  int? scores;
  int? swipes;
  int? message_count;
  int? group_count;
   String? scored_at;
   int? partner_1_age;
   int? partner_2_age;
  User({
    this.id,
    this.fName,
    this.verified,
    this.age,
    this.matching_percentage,
    this.profile,
    this.email,
    this.userType,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deviceToken,
    this.isSubscribed,
    this.lastSeen,
    this.phone,
    this.country,
    this.city,
    this.birthDate,
    this.partner1Name,
    this.partner2Name,
    this.partner1Sex,
    this.partner2Sex,
    this.userRecentImages,
    this.visibilityRecentImages,
    this.waitListStatus,
    this.coupleId,
    this.boostStatus,
    this.boostedAt,
    this.boostCount,
    this.goldenMember,
    this.profileViews,
    this.likes,
    this.activeNow,
    this.hobbies,
    this.desires,
    this.additionalInfo,
    this.reference,
    this.verification,
    this.ownerEvent,
    this.eventsAction,
    this.clubs,
    this.blogs,
    this.callLogsAsCaller,
    this.callLogsAsCalled,
    this.groupMembers,
    this.transactions,
    this.blockedUsers,
    this.coupleRecentImage,
    this.singleRecentImage,
    this.parties,
    this.commonCoupleData,
    this.matches,
    this.matchedBy,
    this.posts,
    this.comments,
    this.notifications,
    this.likedUserForSingle,
    this.likedUserForCouple,
    this.coupleMatches,
    this.isAdmin,
    this.stripeId,
    this.pmType,
    this.pmLastFour,
    this.trialEndsAt,
    this.username,
    this.scores,
    this.swipes,
    this.message_count,
    this.group_count,
    this.scored_at,
    this.partner_1_age,
    this.partner_2_age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    log('ID: ${json['id']} Type: ${json['id'].runtimeType}');

    return User(
      id: json['id']?.toString(), // Convert int to String
      fName: json['f_name'] as String?,
      verified: json['verified'] is bool
          ? (json['verified'] ? 1 : 0)
          : (json['verified'] as int?) ?? 0, // Default to 0 if null
      age: json['age'] as int? ?? 0, // Default to 0 if null
      matching_percentage: json['matching_percentage'] as int? ?? 0, // Default to 0 if null
      profile: json['profile'] as String?,
      email: json['email'] as String?,
      userType: json['user_type'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deviceToken: json['device_token'] as String?,
      isSubscribed: json['is_subscribed'] is String
          ? json['is_subscribed']
          : json['is_subscribed']?.toString(),
      lastSeen: json['last_seen'] as String?,
      phone: json['phone'] is int ? json['phone'].toString() : json['phone'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      birthDate: json['birth_date'] as String?,
      partner1Name: json['Partner_1_name'] as String?,
      partner2Name: json['Partner_2_name'] as String?,
      partner1Sex: json['Partner_1_sex'] as String?,
      partner2Sex: json['Partner_2_sex'] as String?,
      userRecentImages: json['user_recent_images'] as String?,
      visibilityRecentImages: json['visibility_recent_images'] as String?,
      waitListStatus: json['wait_list_status'] as int? ?? 0, // Default to 0 if null
      coupleId: json['couple_id'] as int? ?? 0, // Default to 0 if null
      boostStatus: json['boost_status'] is int ? json['boost_status'].toString() : json['boost_status'] as String?,
      boostedAt: json['boosted_at'] as String?,
      boostCount: json['boost_count'] is int ? json['boost_count'].toString() : json['boost_count'] as String?,
      goldenMember: json['golden_member'], // Default to 0 if null
      profileViews: json['profile_views'] is int ? json['profile_views'].toString() : json['profile_views'] as String?,
      likes: json['likes'] is int ? json['likes'].toString() : json['likes'] as String?,
      activeNow: json['active_now'] is int ? json['active_now'].toString() : json['active_now'] as String?,
      hobbies: (json['hobbies'] as List<dynamic>?)
          ?.map((hobbie) => Hobby.fromJson(hobbie as Map<String, dynamic>))
          .toList(),
      desires: (json['desires'] as List<dynamic>?)
          ?.map((desires) => Desire.fromJson(desires as Map<String, dynamic>))
          .toList(),
      additionalInfo: json['additional_info'] != null
          ? AdditionalInfo.fromJson(json['additional_info'] as Map<String, dynamic>)
          : null,
      reference: json['reference'] != null
          ? Reference.fromJson(json['reference'] as Map<String, dynamic>)
          : null,
      verification: json['verification'] != null
          ? Verification.fromJson(json['verification'] as Map<String, dynamic>)
          : null,
      ownerEvent: (json['events'] as List<dynamic>?)
          ?.map((e) => OwnerEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventsAction: (json['event_actions'] as List<dynamic>?)
          ?.map((e) => EventAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      clubs: (json['clubs'] as List<dynamic>?)
          ?.map((clubJson) => Club.fromJson(clubJson as Map<String, dynamic>))
          .toList() ?? [], // Handle empty list
      blogs: (json['blogs'] as List<dynamic>?)
          ?.map((e) => Blog.fromJson(e as Map<String, dynamic>))
          .toList(),

      // Proper handling of `call_logs_as_caller` and `call_logs_as_called`:
      callLogsAsCaller: (json['call_logs_as_caller'] as List<dynamic>?)
          ?.map((e) => CallLog.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],

      callLogsAsCalled: (json['call_logs_as_called'] as List<dynamic>?)
          ?.map((e) => CallLog.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],

      groupMembers: (json['group_member'] as List<dynamic>?)
          ?.map((e) => GroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      blockedUsers: (json['blocked_users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),

      coupleRecentImage: json['couple_recent_images'] != null
          ? CoupleRecentImage.fromJson(json['couple_recent_images'] as Map<String, dynamic>)
          : null,
      singleRecentImage: json['single_recent_images'] != null
          ? SingleRecentImage.fromJson(json['single_recent_images'] as Map<String, dynamic>)
          : null,
      parties: (json['parties'] as List<dynamic>?)
          ?.map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedUserForSingle: (json['liked_user_for_single'] as List<dynamic>?)
          ?.map((item) => LikedUserForSingle.fromJson(item as Map<String, dynamic>))
          .toList(),
      likedUserForCouple: (json['liked_user_for_couple'] as List<dynamic>?)
          ?.map((item) => LikedUserForCouple.fromJson(item as Map<String, dynamic>))
          .toList(),
      coupleMatches: (json['couple_matches'] as List<dynamic>?)
          ?.map((item) => CoupleMatch.fromJson(item as Map<String, dynamic>))
          .toList(),
      matches: (json['matches'] as List<dynamic>?)
          ?.map((item) => Match.fromJson(item as Map<String, dynamic>))
          .toList(),
      matchedBy: (json['matched_by'] as List<dynamic>?)
          ?.map((item) => Match.fromJson(item as Map<String, dynamic>))
          .toList(),
      commonCoupleData: json['common__couple__data'] != null
          ? CommonCoupleData.fromJson(json['common__couple__data'] as Map<String, dynamic>)
          : null,
      isAdmin: json['is_admin'] as int?,
      stripeId: json['stripe_id'] as String?,
      pmType: json['pm_type'] as String?,
      pmLastFour: json['pm_last_four'] as String?,
      trialEndsAt: json['trial_ends_at'] as String?,
      username: json['username'] as String?,
      scores: json['scores'] as int?,
      scored_at: json['scored_at'] as String?,
      swipes: json['swipes'] as int?,
      message_count: json['message_count'] as int?,
      group_count: json['group_count'] as int?,
      partner_1_age: json['partner_1_age'] as int?,
      partner_2_age: json['partner_2_age'] as int?,
    );
  }
}


class Post {
  int? postId;
  String? content;

  Post({this.postId, this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'content': content,
    };
  }
}

class Comment {
  int? commentId;
  String? text;

  Comment({this.commentId, this.text});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['comment_id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'text': text,
    };
  }
}

class Notification {
  int? id;
  int? userId;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;

  Notification({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      body: json['body'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'body': body,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// Function to parse a list of notifications from JSON
List<Notification> parseNotifications(List<dynamic> notificationsJson) {
  return notificationsJson.map<Notification>((json) => Notification.fromJson(json)).toList();
}

class Desire {
  final int id;
  final int? userId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  Desire({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Desire object from a JSON map
  factory Desire.fromJson(Map<String, dynamic> json) {
    return Desire(
      id: json['id'],
      userId: json['user_id'] as int?,
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a Desire object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Hobby {
  final int id;
  final int? userId;
  final String hobbie;
  final String? brand;
  final String createdAt;
  final String updatedAt;
  final int? coupleId;

  Hobby({
    required this.id,
    this.userId,
    required this.hobbie,
    this.brand,
    required this.createdAt,
    required this.updatedAt,
    this.coupleId,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json['id'] as int,
      userId: json['user_id'] as int?,
      hobbie: json['hobbie'] as String,
      brand: json['brand'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      coupleId: json['couple_id'] as int?,
    );
  }

  // Optional: Add a toJson method if you need to serialize the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'hobbie': hobbie,
      'brand': brand,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'couple_id': coupleId,
    };
  }
}

class OwnerEvent {
  final int id;
  final String title;
  final String? description;
  final String date;
  final String time;
  final String location;
  final String createdAt;
  final String updatedAt;

  OwnerEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OwnerEvent.fromJson(Map<String, dynamic> json) {
    return OwnerEvent(
      id: json['id'],
      title: json['title'] as String,
      description: json['description'] as String?,
      date: json['date'] as String,
      time: json['time'] as String,
      location: json['location'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}
class Club {
  final int? id;
  final int? userId;
  final String? logo;
  final String? openingDate;
  final String? openingTime;
  final List<String>? freeService;
  final List<String>? recentImages;
  final String? location;
  final String? createdAt;
  final String? updatedAt;
  final String? longitude;
  final String? latitude;
  final String? closingTime;
  final String? closingDay;

  Club({
    this.id,
    this.userId,
    this.logo,
    this.openingDate,
    this.openingTime,
    this.freeService,
    this.recentImages,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.longitude,
    this.latitude,
    this.closingTime,
    this.closingDay,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      logo: json['logo'] as String?,
      openingDate: json['opening_date'] as String?,
      openingTime: json['opening_time'] as String?,
      freeService: (json['free_service'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recentImages: (json['recent_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      location: json['location'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      closingTime: json['closing_time'] as String?,
      closingDay: json['closing_day'] as String?,
    );
  }
}
class Blog {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;
  final List<String>? tags;
  final int? userId;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.tags,
    required this.userId,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userId: json['user_id'] as int?,
    );
  }
}
class CallLog {
  final int id;
  final int? userId;
  final String callType;
  final String callDate;
  final String callDuration;

  CallLog({
    required this.id,
    required this.userId,
    required this.callType,
    required this.callDate,
    required this.callDuration,
  });

  factory CallLog.fromJson(Map<String, dynamic> json) {
    return CallLog(
      id: json['id'],
      userId: json['user_id'] as int?,
      callType: json['call_type'] as String,
      callDate: json['call_date'] as String,
      callDuration: json['call_duration'] as String,
    );
  }
}
class GroupMember {
  final int id;
  final int groupId;
  final int? userId;
  final bool isAdmin;
  final bool canJoin;
  final bool muted;
  final String createdAt;
  final String updatedAt;
  final int joinStatus;

  GroupMember({
    required this.id,
    required this.groupId,
    this.userId,
    required this.isAdmin,
    required this.canJoin,
    required this.muted,
    required this.createdAt,
    required this.updatedAt,
    required this.joinStatus,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json['id'],
      groupId: json['group_id'],
      userId: json['user_id'] as int?,
      isAdmin: json['is_admin'] is bool ? json['is_admin'] : (json['is_admin'] == 1),
      canJoin: json['can_join'] is bool ? json['can_join'] : (json['can_join'] == 1),
      muted: json['muted'] is bool ? json['muted'] : (json['muted'] == 1),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      joinStatus: json['join_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'user_id': userId,
      'is_admin': isAdmin,
      'can_join': canJoin,
      'muted': muted,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'join_status': joinStatus,
    };
  }
}
class Transaction {
  final int id;
  final int? userId;
  final double amount;
  final String transactionType;
  final String transactionDate;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.transactionType,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'] as int?,
      amount: json['amount'].toDouble(),
      transactionType: json['transaction_type'] as String,
      transactionDate: json['transaction_date'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}
class SingleRecentImage {
  final List<String>? userRecentImages; // List to store multiple image URLs
  final int? id;
  final String? visibilityRecentImages;
  final String? createdAt;
  final String? updatedAt;
  final int? coupleId;

  SingleRecentImage({
    this.userRecentImages,
    this.id,
    this.visibilityRecentImages,
    this.createdAt,
    this.updatedAt,
    this.coupleId,
  });

  factory SingleRecentImage.fromJson(Map<String, dynamic> json) {
    return SingleRecentImage(
      userRecentImages: json['user_recent_images'] != null
          ? List<String>.from(json['user_recent_images'].map((x) => x as String))
          : null,
      id: json['id'] as int?,
      visibilityRecentImages: json['visibility_recent_images'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      coupleId: json['couple_id'] as int?,
    );
  }
}
class Party {
  final int id;
  final String name;
  final String description;
  final String date;
  final String time;
  final String location;
  final String createdAt;
  final String updatedAt;

  Party({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json['id'] ?? 0, // Default to 0 if id is null
      name: json['party_title'] ?? '', // Default to empty string if name is null
      description: json['description'] ?? '', // Default to empty string if description is null
      date: json['date'] ?? '', // Default to empty string if date is null
      time: json['time'] ?? '', // Default to empty string if time is null
      location: json['location'] ?? '', // Default to empty string if location is null
      createdAt: json['created_at'] ?? '', // Default to empty string if created_at is null
      updatedAt: json['updated_at'] ?? '', // Default to empty string if updated_at is null
    );
  }
}

class AdditionalInfo {
  final int id;
  final int? userId;
  final String? drinkingHabit;
  final String? smokingHabit;
  final String? bodyType;
  final String? safetyPractice;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdditionalInfo({
    required this.id,
    required this.userId,
    this.drinkingHabit,
    this.smokingHabit,
    this.bodyType,
    this.safetyPractice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      id: json['id'] as int,
      userId: json['user_id'] as int?,
      drinkingHabit: json['drinking_habit'] as String?,
      smokingHabit: json['smoking_habit'] as String?,
      bodyType: json['body_type'] as String?,
      safetyPractice: json['safety_practice'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class Reference {
  int? id;
  String? location;
  String? height;
  int? weight;
  String? eyeColor;
  String? ethnicity;
  String? smorking;
  String? piercing;
  String? shareLink;
  List<String>? language;
  String? sexuality;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? description;
  List<String>? attributes;
  List<String>? lookingFor;
  String? education;
  String? longitude;
  String? latitude;
  String? generatedQRCode;

  Reference({
    this.id,
    this.location,
    this.height,
    this.weight,
    this.eyeColor,
    this.ethnicity,
    this.smorking,
    this.piercing,
    this.shareLink,
    this.language,
    this.sexuality,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.attributes,
    this.lookingFor,
    this.education,
    this.longitude,
    this.latitude,
    this.generatedQRCode,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      id: json['id'] as int?,
      location: json['location'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as int?, // Make sure this is an int in your JSON
      eyeColor: json['eye_color'] as String?,
      ethnicity: json['ethnicity'] as String?,
      smorking: json['smorking']?.toString(), // Convert int to String
      piercing: json['piercing']?.toString(),
      shareLink: json['share_link'] as String?,
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sexuality: json['sexuality'] as String?,
      userId: json['user_id'] as int?, // user_id should be an int or null
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      description: json['description'] as String?,
      attributes: json['attributes'] != null
          ? List<String>.from(json['attributes'])
          : null,
      lookingFor: json['looking_for'] != null
          ? List<String>.from(json['looking_for'])
          : null,
      education: json['education'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      generatedQRCode: json['generated_QR_code'] as String?,
    );
  }
}

class Verification {
  final int id;
  final int? userId;
  final String? idDocument;
  final String? utilityBill;
  final String? selfie;
  final String status;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  Verification({
    required this.id,
    required this.userId,
    this.idDocument,
    this.utilityBill,
    this.selfie,
    required this.status,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      id: json['id'],
      userId: json['user_id'] as int?,
      idDocument: json['id_document'] as String?,
      utilityBill: json['utility_bill'] as String?,
      selfie: json['selfie'] as String?,
      status: json['status'] as String,
      rejectionReason: json['rejection_reason'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class CoupleRecentImage {
  final int? userId;
  final List<String> userRecentImages;
  final bool visibilityRecentImages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? coupleId;

  CoupleRecentImage({
    this.userId,
    required this.userRecentImages,
    required this.visibilityRecentImages,
    required this.createdAt,
    required this.updatedAt,
     this.coupleId,
  });

  factory CoupleRecentImage.fromJson(Map<String, dynamic> json) {
    return CoupleRecentImage(
      userId: json['user_id'] as int?,
      userRecentImages: (json['user_recent_images'] as List<dynamic>)
          .map((image) => image as String)
          .toList(),
      visibilityRecentImages: json['visibility_recent_images'] == "1",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      coupleId: json['couple_id'] as int?,
    );
  }
}

class CommonCoupleData {
  int? id;
  String? city;
  String? country;
  List<String>? desires;
  List<String>? hobbies;
  List<String>? partyTitles;
  List<String>? lookingFors;
  String? description;
  String? score;
  String? goldenMember;
  String? createdAt;
  String? updatedAt;

  CommonCoupleData({
    this.id,
    this.city,
    this.country,
    this.desires,
    this.hobbies,
    this.partyTitles,
    this.lookingFors,
    this.description,
    this.score,
    this.goldenMember,
    this.createdAt,
    this.updatedAt,
  });

  factory CommonCoupleData.fromJson(Map<String, dynamic> json) {
    return CommonCoupleData(
      id: json['id'] as int?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      desires: (json['desires'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      hobbies: (json['hobbies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      partyTitles: (json['party_titles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      lookingFors:  (json['looking_fors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      description: json['description'] as String?,
      score: json['score'] as String?,
      goldenMember: json['golden_member'] as String ?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
class LikedUserForSingle {
  int? id;
  int? userId;
  int? likedUserId;
  String? createdAt;
  String? updatedAt;
  int? coupleId;
  int? likedCoupleId;
  int? isDeleted;

  LikedUserForSingle({
    this.id,
    this.userId,
    this.likedUserId,
    this.createdAt,
    this.updatedAt,
    this.coupleId,
    this.likedCoupleId,
    this.isDeleted,
  });

  factory LikedUserForSingle.fromJson(Map<String, dynamic> json) {
    return LikedUserForSingle(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      likedUserId: json['liked_user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      coupleId: json['couple_id'] as int?,
      likedCoupleId: json['liked_couple_id'] as int?,
      isDeleted: json['is_deleted'] as int?,
    );
  }
}

class LikedUserForCouple {
  int? id;
  int? userId;
  int? likedUserId;
  String? createdAt;
  String? updatedAt;
  int? coupleId;
  int? likedCoupleId;
  int? isDeleted;

  LikedUserForCouple({
    this.id,
    this.userId,
    this.likedUserId,
    this.createdAt,
    this.updatedAt,
    this.coupleId,
    this.likedCoupleId,
    this.isDeleted,
  });

  factory LikedUserForCouple.fromJson(Map<String, dynamic> json) {
    return LikedUserForCouple(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      likedUserId: json['liked_user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      coupleId: json['couple_id'] as int?,
      likedCoupleId: json['liked_couple_id'] as int?,
      isDeleted: json['is_deleted'] as int?,
    );
  }
}
class CoupleMatch {
  int? id;
  int? userId;
  int? matchedUserId;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? coupleId;
  int? matchedCoupleId;

  CoupleMatch({
    this.id,
    this.userId,
    this.matchedUserId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.coupleId,
    this.matchedCoupleId,
  });

  factory CoupleMatch.fromJson(Map<String, dynamic> json) {
    return CoupleMatch(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      matchedUserId: json['matched_user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as String?,
      coupleId: json['couple_id'] as int?,
      matchedCoupleId: json['matched_couple_id'] as int?,
    );
  }
}

class Match {
  final int? id;
  final int? userId;
  final int? matchedUserId;
  final String? createdAt;
  final String? updatedAt;
  final String status;
  final int? coupleId;
  final int? matchedCoupleId;

  Match({
    required this.id,
    required this.userId,
    this.matchedUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.coupleId,
    this.matchedCoupleId,
  });

  // Factory constructor to create a Match instance from a JSON map
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      matchedUserId: json['matched_user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status']as String,
      coupleId: json['couple_id'] as int?,
      matchedCoupleId: json['matched_couple_id'] as int?,
    );
  }

  // Method to convert a Match instance to JSON map

  @override
  String toString() {
    return 'Match(id: $id, userId: $userId, matchedUserId: $matchedUserId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, coupleId: $coupleId, matchedCoupleId: $matchedCoupleId)';
  }
}

