class MatchResponse {
  String? status;
  int? isShow;
  String? message;
  String? userFLetter;
  String? matchFLetter;
  Match? match;

  MatchResponse({
    this.status,
    this.isShow,
    this.message,
    this.userFLetter,
    this.matchFLetter,
    this.match,
  });

  // Factory constructor to create an instance from JSON
  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      status: json['status'],
      isShow: json['is_show'],
      message: json['message'],
      userFLetter: json['user_f_letter'],
      matchFLetter: json['match_f_letter'],
      match: json['match'] != null ? Match.fromJson(json['match']) : null,
    );
  }

  // Method to convert the model to JSON (optional, useful for requests)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'is_show': isShow,
      'message': message,
      'user_f_letter': userFLetter,
      'match_f_letter': matchFLetter,
      'match': match?.toJson(),
    };
  }
}

class Match {
  int? userId;
  int? matchedCoupleId;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Match({
    this.userId,
    this.matchedCoupleId,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  // Factory constructor to create a Match instance from JSON
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      userId: json['user_id'],
      matchedCoupleId: json['matched_couple_id'],
      status: json['status'],
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      id: json['id'],
    );
  }

  // Method to convert the model to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'matched_couple_id': matchedCoupleId,
      'status': status,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'id': id,
    };
  }
}
