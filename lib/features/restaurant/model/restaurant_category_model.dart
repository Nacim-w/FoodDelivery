class RestaurantCategoryModel {
  final String id;
  final String name;

  RestaurantCategoryModel({
    required this.id,
    required this.name,
  });

  factory RestaurantCategoryModel.empty() {
    return RestaurantCategoryModel(
      id: '',
      name: '',
    );
  }

  factory RestaurantCategoryModel.fromJson(Map<String, dynamic> json) {
    return RestaurantCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  RestaurantCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return RestaurantCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
