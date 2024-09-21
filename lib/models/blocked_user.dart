import 'dart:convert';

class Pivot {
  final int userId;
  final int blockedUserId;

  Pivot({
    required this.userId,
    required this.blockedUserId,
  });

  // Factory constructor to create a Pivot instance from a JSON map
  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      blockedUserId: json['blocked_user_id'],
    );
  }

  // Method to convert a Pivot instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'blocked_user_id': blockedUserId,
    };
  }

  @override
  String toString() {
    return 'Pivot(userId: $userId, blockedUserId: $blockedUserId)';
  }
}

class BlockedUser {
  final int id;
  final String? fName;
  final int verified;
  final int? age;
  final String? profile;
  final String email;
  final String userType;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deviceToken;
  final String isSubscribed;
  final DateTime? lastSeen;
  final int? phone;
  final String? country;
  final String? city;
  final DateTime birthDate;
  final String? partner1Name;
  final String? partner2Name;
  final String? partner1Sex;
  final String? partner2Sex;
  final String? userRecentImages;
  final String? visibilityRecentImages;
  final int waitListStatus;
  final int? coupleId;
  final int boostStatus;
  final DateTime? boostedAt;
  final int boostCount;
  final int goldenMember;
  final int profileViews;
  final int likes;
  final int activeNow;
  final int isAdmin;
  final Pivot pivot;

  BlockedUser({
    required this.id,
    this.fName,
    required this.verified,
    this.age,
    this.profile,
    required this.email,
    required this.userType,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceToken,
    required this.isSubscribed,
    this.lastSeen,
    this.phone,
    this.country,
    this.city,
    required this.birthDate,
    this.partner1Name,
    this.partner2Name,
    this.partner1Sex,
    this.partner2Sex,
    this.userRecentImages,
    this.visibilityRecentImages,
    required this.waitListStatus,
    this.coupleId,
    required this.boostStatus,
    this.boostedAt,
    required this.boostCount,
    required this.goldenMember,
    required this.profileViews,
    required this.likes,
    required this.activeNow,
    required this.isAdmin,
    required this.pivot,
  });

  // Factory constructor to create a BlockedUser instance from a JSON map
  factory BlockedUser.fromJson(Map<String, dynamic> json) {
    return BlockedUser(
      id: json['id'],
      fName: json['f_name'],
      verified: json['verified'],
      age: json['age'],
      profile: json['profile'],
      email: json['email'],
      userType: json['user_type'],
      emailVerifiedAt: json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deviceToken: json['device_token'],
      isSubscribed: json['is_subscribed'],
      lastSeen: json['last_seen'] != null ? DateTime.parse(json['last_seen']) : null,
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      birthDate: DateTime.parse(json['birth_date']),
      partner1Name: json['Partner_1_name'],
      partner2Name: json['Partner_2_name'],
      partner1Sex: json['Partner_1_sex'],
      partner2Sex: json['Partner_2_sex'],
      userRecentImages: json['user_recent_images'],
      visibilityRecentImages: json['visibility_recent_images'],
      waitListStatus: json['wait_list_status'],
      coupleId: json['couple_id'],
      boostStatus: json['boost_status'],
      boostedAt: json['boosted_at'] != null ? DateTime.parse(json['boosted_at']) : null,
      boostCount: json['boost_count'],
      goldenMember: json['golden_member'],
      profileViews: json['profile_views'],
      likes: json['likes'],
      activeNow: json['active_now'],
      isAdmin: json['is_admin'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  // Method to convert a BlockedUser instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'verified': verified,
      'age': age,
      'profile': profile,
      'email': email,
      'user_type': userType,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'device_token': deviceToken,
      'is_subscribed': isSubscribed,
      'last_seen': lastSeen?.toIso8601String(),
      'phone': phone,
      'country': country,
      'city': city,
      'birth_date': birthDate.toIso8601String(),
      'Partner_1_name': partner1Name,
      'Partner_2_name': partner2Name,
      'Partner_1_sex': partner1Sex,
      'Partner_2_sex': partner2Sex,
      'user_recent_images': userRecentImages,
      'visibility_recent_images': visibilityRecentImages,
      'wait_list_status': waitListStatus,
      'couple_id': coupleId,
      'boost_status': boostStatus,
      'boosted_at': boostedAt?.toIso8601String(),
      'boost_count': boostCount,
      'golden_member': goldenMember,
      'profile_views': profileViews,
      'likes': likes,
      'active_now': activeNow,
      'is_admin': isAdmin,
      'pivot': pivot.toJson(),
    };
  }

  @override
  String toString() {
    return 'BlockedUser(id: $id, fName: $fName, verified: $verified, age: $age, profile: $profile, email: $email, userType: $userType, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, deviceToken: $deviceToken, isSubscribed: $isSubscribed, lastSeen: $lastSeen, phone: $phone, country: $country, city: $city, birthDate: $birthDate, partner1Name: $partner1Name, partner2Name: $partner2Name, partner1Sex: $partner1Sex, partner2Sex: $partner2Sex, userRecentImages: $userRecentImages, visibilityRecentImages: $visibilityRecentImages, waitListStatus: $waitListStatus, coupleId: $coupleId, boostStatus: $boostStatus, boostedAt: $boostedAt, boostCount: $boostCount, goldenMember: $goldenMember, profileViews: $profileViews, likes: $likes, activeNow: $activeNow, isAdmin: $isAdmin, pivot: $pivot)';
  }
}
