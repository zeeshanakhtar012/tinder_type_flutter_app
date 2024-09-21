// models/post_model.dart

class Post {
  final int id;
  final int userId;
  final String content;
  final String createdAt;
  final String updatedAt;
  final String tag;
  final String title;
  final List<String> images;
  final User user;
  final List<Comment> comments;
  final List<Like> likes;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.tag,
    required this.title,
    required this.images,
    required this.user,
    required this.comments,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      tag: json['tag'],
      title: json['title'],
      images: List<String>.from(json['image']),
      user: User.fromJson(json['user']),
      comments: List<Comment>.from(json['comments'].map((c) => Comment.fromJson(c))),
      likes: List<Like>.from(json['likes'].map((l) => Like.fromJson(l))),
    );
  }
}

class User {
  final int id;
  final String fName;
  final String lName;
  final bool verified;
  final int age;
  final String? profile;
  final String email;
  final String userType;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String? deviceToken;
  final String isSubscribed;
  final String? lastSeen;
  final int phone;
  final String country;
  final String city;

  User({
    required this.id,
    required this.fName,
    required this.lName,
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
    required this.country,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fName: json['f_name'],
      lName: json['l_name'],
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
    );
  }
}

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String content;
  final String createdAt;
  final String updatedAt;
  final User user;
  final List<Reaction> reactions;
  final List<Reply> replies;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.reactions,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      reactions: List<Reaction>.from(json['reactions'].map((r) => Reaction.fromJson(r))),
      replies: List<Reply>.from(json['replies'].map((r) => Reply.fromJson(r))),
    );
  }
}

class Reaction {
  final int id;
  final int? commentId;
  final int? replyId;
  final int userId;
  final String type;
  final String createdAt;
  final String updatedAt;
  final User user;

  Reaction({
    required this.id,
    required this.commentId,
    required this.replyId,
    required this.userId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json['id'],
      commentId: json['comment_id'],
      replyId: json['reply_id'],
      userId: json['user_id'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class Reply {
  final int id;
  final int commentId;
  final int userId;
  final String content;
  final String createdAt;
  final String updatedAt;
  final List<Reaction> reactions;

  Reply({
    required this.id,
    required this.commentId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.reactions,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      commentId: json['comment_id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      reactions: List<Reaction>.from(json['reactions'].map((r) => Reaction.fromJson(r))),
    );
  }
}

class Like {
  final int id;
  final int userId;
  final int postId;
  final String createdAt;
  final String updatedAt;

  Like({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      userId: json['user_id'],
      postId: json['post_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
