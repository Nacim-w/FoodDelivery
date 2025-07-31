class SavedLocation {
  final double latitude;
  final double longitude;
  final String name;
  final String description;

  SavedLocation({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.description,
  });

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
        'description': description,
      };
}
