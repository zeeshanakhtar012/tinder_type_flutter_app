class Blog {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? tags;
  final int userId;

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
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      userId: json['user_id'],
    );
  }
}
