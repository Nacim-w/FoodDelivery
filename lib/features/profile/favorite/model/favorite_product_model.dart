class FavoriteProductModel {
  final String id;
  final String name;
  final String imageUrl;
  double price;

  FavoriteProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
  factory FavoriteProductModel.empty() {
    return FavoriteProductModel(
      id: '',
      name: '',
      imageUrl: '',
      price: 0.0,
    );
  }
  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
