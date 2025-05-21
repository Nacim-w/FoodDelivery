class RestaurantProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  factory RestaurantProductModel.empty() {
    return RestaurantProductModel(
      id: '',
      name: '',
      imageUrl: '',
      price: 0.0,
      description: '',
    );
  }

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) {
    return RestaurantProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
    );
  }

  RestaurantProductModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? description,
  }) {
    return RestaurantProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }
}
