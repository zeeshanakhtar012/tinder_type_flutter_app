class EventRequest {
  final int id;
  final String fName;
  final int? verified;
  final int? age;
  final String profile;
  final String email;
  final String userType;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String deviceToken;
  final String isSubscribed;
  final String lastSeen;
  final String phone;
  final String? country;
  final String? city;
  final String? birthDate;
  final String? partner1Name;
  final String? partner2Name;
  final String? partner1Sex;
  final String? partner2Sex;
  final dynamic userRecentImages;
  final dynamic visibilityRecentImages;
  final int waitListStatus;
  final int? coupleId;
  final int boostStatus;
  final dynamic boostedAt;
  final int boostCount;
  final int goldenMember;
  final int profileViews;
  final int likes;
  final int activeNow;
  final Pivot pivot;

  EventRequest({
    required this.id,
    required this.fName,
    required this.verified,
    required this.age,
    required this.profile,
    required this.email,
    required this.userType,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceToken,
    required this.isSubscribed,
    required this.lastSeen,
    required this.phone,
    this.country,
    this.city,
    this.birthDate,
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
    required this.pivot,
  });

  factory EventRequest.fromJson(Map<String, dynamic> json) {
    return EventRequest(
      id: json['id'],
      fName: json['f_name'],
      verified: json['verified'],
      age: json['age'],
      profile: json['profile'],
      email: json['email'],
      userType: json['user_type'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deviceToken: json['device_token'],
      isSubscribed: json['is_subscribed'],
      lastSeen: json['last_seen'],
      phone: json['phone'].toString(),
      country: json['country'],
      city: json['city'],
      birthDate: json['birth_date'],
      partner1Name: json['Partner_1_name'],
      partner2Name: json['Partner_2_name'],
      partner1Sex: json['Partner_1_sex'],
      partner2Sex: json['Partner_2_sex'],
      userRecentImages: json['user_recent_images'],
      visibilityRecentImages: json['visibility_recent_images'],
      waitListStatus: json['wait_list_status'],
      coupleId: json['couple_id'],
      boostStatus: json['boost_status'],
      boostedAt: json['boosted_at'],
      boostCount: json['boost_count'],
      goldenMember: json['golden_member'],
      profileViews: json['profile_views'],
      likes: json['likes'],
      activeNow: json['active_now'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }
}

class Pivot {
  final int eventId;
  final int userId;
  final String action;
  final String actionStatus;
  final String createdAt;
  final String updatedAt;

  Pivot({
    required this.eventId,
    required this.userId,
    required this.action,
    required this.actionStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      eventId: json['event_id'],
      userId: json['user_id'],
      action: json['action'],
      actionStatus: json['action_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
