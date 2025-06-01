class CategoryRestaurantModel {
  final String id;
  final String logoUrl;
  final String nom;
  final double averageRating;
  final String? description;

  CategoryRestaurantModel(
      {required this.id,
      required this.logoUrl,
      required this.nom,
      required this.averageRating,
      required this.description});

  factory CategoryRestaurantModel.empty() {
    return CategoryRestaurantModel(
      id: '',
      logoUrl: '',
      nom: '',
      averageRating: 0.0,
      description: '',
    );
  }

  factory CategoryRestaurantModel.fromJson(Map<String, dynamic> json) {
    return CategoryRestaurantModel(
      id: json['id'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      averageRating: json['averageRating'] as double? ?? 0.0,
      description: json['description'] as String? ?? '',
    );
  }

  CategoryRestaurantModel copyWith({
    String? id,
    String? logoUrl,
    String? nom,
    double? averageRating,
    String? description,
  }) {
    return CategoryRestaurantModel(
      id: id ?? this.id,
      logoUrl: logoUrl ?? this.logoUrl,
      nom: nom ?? this.nom,
      averageRating: averageRating ?? this.averageRating,
      description: description ?? this.description,
    );
  }
}
