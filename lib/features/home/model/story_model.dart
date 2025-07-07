class StoryItemModel {
  final String storyId;
  final List<String> imageUrls;
  final String restaurantName;
  final String? restaurantLogoUrl;

  StoryItemModel({
    required this.storyId,
    required this.imageUrls,
    required this.restaurantName,
    this.restaurantLogoUrl,
  });

  factory StoryItemModel.empty() {
    return StoryItemModel(
      storyId: '',
      restaurantName: '',
      imageUrls: [],
      restaurantLogoUrl: null,
    );
  }

  factory StoryItemModel.fromJson(Map<String, dynamic> json) {
    return StoryItemModel(
      storyId: json['id'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      restaurantLogoUrl: json['restaurantLogo'], // nullable string
      imageUrls: json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'])
          : (json['url'] != null
              ? [json['url']]
              : []), // handle single url case
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storyId': storyId,
      'restaurantName': restaurantName,
      'restaurantLogo': restaurantLogoUrl,
      'imageUrls': imageUrls,
    };
  }

  StoryItemModel copyWith({
    String? storyId,
    String? restaurantName,
    String? restaurantLogoUrl,
    List<String>? imageUrls,
  }) {
    return StoryItemModel(
      storyId: storyId ?? this.storyId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantLogoUrl: restaurantLogoUrl ?? this.restaurantLogoUrl,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
