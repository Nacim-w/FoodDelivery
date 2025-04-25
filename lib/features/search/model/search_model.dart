class SearchModel {
  final String title;
  final String description;
  final String type;
  final String id;

  SearchModel({
    required this.title,
    required this.description,
    required this.type,
    required this.id,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      title: json['title'],
      description: json['description'],
      type: json['type'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'id': id,
    };
  }
}
