class SavedLocation {
  final double latitude;
  final double longitude;
  final String name;

  SavedLocation({
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
      };
}
