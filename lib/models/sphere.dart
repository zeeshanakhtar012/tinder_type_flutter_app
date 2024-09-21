
import 'package:blaxity/models/user.dart';

class SphereResponse {
  String status;
  String likesCount;
  String viewsCount;
  String networksCount;
  List<User> singles;
  List<User> couples;

  SphereResponse({
    required this.status,
    required this.likesCount,
    required this.viewsCount,
    required this.networksCount,
    this.singles = const [],
    this.couples = const [],
  });

  factory SphereResponse.fromJson(Map<String, dynamic> json) {
    return SphereResponse(
      status: json['status'],
      viewsCount: json['viewsCount'].toString(),
      likesCount:json['likesCount'].toString(),
      networksCount: json['networksCount'].toString(),

      singles: (json['sphere_user']['singles'] as List)
          .map((user) => User.fromJson(user))
          .toList(),
      couples: (json['sphere_user']['couples'] as List)
          .map((user) => User.fromJson(user))
          .toList(),
    );
  }
}



