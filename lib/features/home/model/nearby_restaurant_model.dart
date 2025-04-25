class NearbyRestaurantModel {
  final String id;
  final String logo;
  final String nom;
  final double averageRating;

  NearbyRestaurantModel(
      {required this.id,
      required this.logo,
      required this.nom,
      required this.averageRating});

  factory NearbyRestaurantModel.empty() {
    return NearbyRestaurantModel(
      id: '',
      logo: '',
      nom: '',
      averageRating: 0.0,
    );
  }

  factory NearbyRestaurantModel.fromJson(Map<String, dynamic> json) {
    return NearbyRestaurantModel(
      id: json['id'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      averageRating: json['averageRating'] as double? ?? 0.0,
    );
  }

  NearbyRestaurantModel copyWith({
    String? id,
    String? logo,
    String? nom,
    double? averageRating,
  }) {
    return NearbyRestaurantModel(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      nom: nom ?? this.nom,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}
