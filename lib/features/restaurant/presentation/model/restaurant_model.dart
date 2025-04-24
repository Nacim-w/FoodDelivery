class RestaurantModel {
  final String id;
  final String logo;
  final String nom;
  final double averageRating;

  RestaurantModel(
      {required this.id,
      required this.logo,
      required this.nom,
      required this.averageRating});

  factory RestaurantModel.empty() {
    return RestaurantModel(
      id: '',
      logo: '',
      nom: '',
      averageRating: 0.0,
    );
  }

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  RestaurantModel copyWith({
    String? id,
    String? logo,
    String? nom,
    double? averageRating,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      nom: nom ?? this.nom,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}
