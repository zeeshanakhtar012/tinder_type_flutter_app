class Subscription {
  final int id;
  final String stripeProduct;
  final String stripePrice;
  final String price;
  final String duration;
  final List<String> features;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subscription({
    required this.id,
    required this.stripeProduct,
    required this.stripePrice,
    required this.price,
    required this.duration,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Subscription object from JSON
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      stripeProduct: json['stripe_product'],
      stripePrice: json['stripe_price'],
      price: json['price'],
      duration: json['duration'],
      features: List<String>.from(json['features']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
