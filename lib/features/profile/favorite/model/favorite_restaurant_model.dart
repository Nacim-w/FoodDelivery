class FavoriteRestaurantModel {
  final String id;
  final String nom;
  final String logo;
  final double averageRating;

  FavoriteRestaurantModel({
    required this.id,
    required this.nom,
    required this.logo,
    required this.averageRating,
  });
  factory FavoriteRestaurantModel.empty() {
    return FavoriteRestaurantModel(
      id: '',
      nom: '',
      logo: '',
      averageRating: 0.0,
    );
  }
  factory FavoriteRestaurantModel.fromJson(Map<String, dynamic> json) {
    return FavoriteRestaurantModel(
      id: json['id'],
      nom: json['nom'],
      logo: json['logo'],
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
