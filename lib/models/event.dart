class Event {
  final int? id;
  final int? userId;
  final String? title;
  final String? description;
  final String? image;
  final String? date;
  final String? time;
  final String? typeOfParty;
  final String? privacy;
  final String? pricing;
  final int? capacityLimited;
  final int? attendeeLimit;
  final String? location;
  final String? createdAt;
  final String? updatedAt;
  final int? entrancePrice;
  final int? likeCount;
  final int? dislikeCount;
  final int? attendeesCount;
  final bool? spotsAvailable;
  final EventUser? user;
  final List<Attendee>? attendees;

  Event({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.image,
    this.date,
    this.time,
    this.typeOfParty,
    this.privacy,
    this.pricing,
    this.capacityLimited,
    this.attendeeLimit,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.entrancePrice,
    this.likeCount,
    this.dislikeCount,
    this.attendeesCount,
    this.spotsAvailable,
    this.user,
    this.attendees,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      date: json['date'],
      time: json['time'],
      typeOfParty: json['type_of_party'],
      privacy: json['privacy'],
      pricing: json['pricing'],
      capacityLimited: json['capacity_limited'],
      attendeeLimit: json['attendee_limit'],
      location: json['location'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      entrancePrice: (json['entrance_price'] ?? json['enterance_price']) as int?,
      likeCount: json['like_count'],
      dislikeCount: json['dislike_count'],
      attendeesCount: json['attendees_count'],
      spotsAvailable: json['spots_available'],
      user: json['user'] != null ? EventUser.fromJson(json['user']) : null,
      attendees: json['attendees'] != null
          ? (json['attendees'] as List<dynamic>)
          .map((attendeeJson) => Attendee.fromJson(attendeeJson))
          .toList()
          : null,
    );
  }
}

class EventUser {
  final int? id;
  final String? fName;
  final bool? verified;
  final int? age;
  final String? profile;
  final String? email;
  final String? userType;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? deviceToken;
  final String? isSubscribed;
  final String? lastSeen;
  final int? phone;
  final String? country;
  final String? city;
  final String? birthDate;
  final String? partner1Name;
  final String? partner2Name;
  final String? partner1Sex;
  final String? partner2Sex;
  final String? userRecentImages;
  final String? visibilityRecentImages;

  EventUser({
    this.id,
    this.fName,
    this.verified,
    this.age,
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
  });

  factory EventUser.fromJson(Map<String, dynamic> json) {
    return EventUser(
      id: json['id'],
      fName: json['f_name'],
      verified: json['verified'] == 1,
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
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      birthDate: json['birth_date'],
      partner1Name: json['Partner_1_name'],
      partner2Name: json['Partner_2_name'],
      partner1Sex: json['Partner_1_sex'],
      partner2Sex: json['Partner_2_sex'],
      userRecentImages: json['user_recent_images'],
      visibilityRecentImages: json['visibility_recent_images'],
    );
  }
}

class Attendee {
  final int? id;
  final String? fName;
  final bool? verified;
  final int? age;
  final String? profile;
  final String? email;
  final String? userType;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? deviceToken;
  final String? isSubscribed;
  final String? lastSeen;
  final int? phone;
  final String? country;
  final String? city;
  final String? birthDate;
  final String? partner1Name;
  final String? partner2Name;
  final String? partner1Sex;
  final String? partner2Sex;
  final String? userRecentImages;
  final String? visibilityRecentImages;
  final Pivot? pivot;

  Attendee({
    this.id,
    this.fName,
    this.verified,
    this.age,
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
    this.pivot,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: json['id'],
      fName: json['f_name'],
      verified: json['verified'] == 1,
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
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      birthDate: json['birth_date'],
      partner1Name: json['Partner_1_name'],
      partner2Name: json['Partner_2_name'],
      partner1Sex: json['Partner_1_sex'],
      partner2Sex: json['Partner_2_sex'],
      userRecentImages: json['user_recent_images'],
      visibilityRecentImages: json['visibility_recent_images'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
}

class Pivot {
  final int? eventId;
  final int? userId;
  final String? action;
  final String? actionStatus;
  final String? createdAt;
  final String? updatedAt;

  Pivot({
    this.eventId,
    this.userId,
    this.action,
    this.actionStatus,
    this.createdAt,
    this.updatedAt,
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
