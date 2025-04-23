class NearbyRestaurantModel {
  final String id;
  final String logo;
  final String nom;

  NearbyRestaurantModel({
    required this.id,
    required this.logo,
    required this.nom,
  });

  factory NearbyRestaurantModel.empty() {
    return NearbyRestaurantModel(
      id: '',
      logo: '',
      nom: '',
    );
  }

  factory NearbyRestaurantModel.fromJson(Map<String, dynamic> json) {
    return NearbyRestaurantModel(
      id: json['id'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
    );
  }

  NearbyRestaurantModel copyWith({
    String? id,
    String? logo,
    String? nom,
  }) {
    return NearbyRestaurantModel(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      nom: nom ?? this.nom,
    );
  }
}
