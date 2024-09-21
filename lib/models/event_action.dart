import 'dart:convert';

class EventAction {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String? image;
  final String date;
  final String time;
  final String typeOfParty;
  final String privacy;
  final String pricing;
  final int capacityLimited;
  final int attendeeLimit;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? enterancePrice;
  final int endStatus;
  final Pivot pivot;

  EventAction({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.time,
    required this.typeOfParty,
    required this.privacy,
    required this.pricing,
    required this.capacityLimited,
    required this.attendeeLimit,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.enterancePrice,
    required this.endStatus,
    required this.pivot,
  });

  // Factory constructor to create an EventAction instance from a JSON map
  factory EventAction.fromJson(Map<String, dynamic> json) {
    return EventAction(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'] as String?,
      date: json['date'],
      time: json['time'],
      typeOfParty: json['type_of_party'],
      privacy: json['privacy'],
      pricing: json['pricing'],
      capacityLimited: json['capacity_limited'],
      attendeeLimit: json['attendee_limit'],
      location: json['location'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      enterancePrice: json['enterance_price'],
      endStatus: json['end_status'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  // Method to convert an EventAction instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'image': image,
      'date': date,
      'time': time,
      'type_of_party': typeOfParty,
      'privacy': privacy,
      'pricing': pricing,
      'capacity_limited': capacityLimited,
      'attendee_limit': attendeeLimit,
      'location': location,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'enterance_price': enterancePrice as int?,
      'end_status': endStatus,
      'pivot': pivot.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventAction(id: $id, userId: $userId, title: $title, description: $description, image: $image, date: $date, time: $time, typeOfParty: $typeOfParty, privacy: $privacy, pricing: $pricing, capacityLimited: $capacityLimited, attendeeLimit: $attendeeLimit, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, enterancePrice: $enterancePrice, endStatus: $endStatus, pivot: $pivot)';
  }
}

class Pivot {
  final int userId;
  final int eventId;
  final String action;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pivot({
    required this.userId,
    required this.eventId,
    required this.action,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a Pivot instance from a JSON map
  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      eventId: json['event_id'],
      action: json['action'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a Pivot instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'event_id': eventId,
      'action': action,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Pivot(userId: $userId, eventId: $eventId, action: $action, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
