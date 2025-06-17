class StoryItemModel {
  final String storyId;
  final List<String> imageUrls;
  final String username;

  StoryItemModel({
    required this.storyId,
    required this.imageUrls,
    required this.username,
  });

  factory StoryItemModel.empty() {
    return StoryItemModel(
      storyId: '',
      username: '',
      imageUrls: [],
    );
  }

  factory StoryItemModel.fromJson(Map<String, dynamic> json) {
    return StoryItemModel(
      storyId: json['id'] ?? '',
      username: json['username'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storyId': storyId,
      'username': username,
      'imageUrls': imageUrls,
    };
  }

  StoryItemModel copyWith({
    String? storyId,
    String? username,
    List<String>? imageUrls,
  }) {
    return StoryItemModel(
      storyId: storyId ?? this.storyId,
      username: username ?? this.username,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
