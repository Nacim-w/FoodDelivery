class TopCategoryModel {
  final String id;
  final String name;

  TopCategoryModel({
    required this.id,
    required this.name,
  });

  factory TopCategoryModel.empty() {
    return TopCategoryModel(
      id: '',
      name: '',
    );
  }

  factory TopCategoryModel.fromJson(Map<String, dynamic> json) {
    return TopCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  TopCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return TopCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
