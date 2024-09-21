class Boost {
  final int id;
  final String price;
  final int duration;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int boosts;
  final String stripePlan;
  final String name;

  Boost({
    required this.id,
    required this.price,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.boosts,
    required this.stripePlan,
    required this.name,
  });

  // Factory method to create a Boost object from JSON
  factory Boost.fromJson(Map<String, dynamic> json) {
    return Boost(
      id: json['id'],
      price: json['price'],
      duration: json['duration'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      boosts: json['boosts'],
      stripePlan: json['stripe_plan'],
      name: json['name'],
    );
  }
}
