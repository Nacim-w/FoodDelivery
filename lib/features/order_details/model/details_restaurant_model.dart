class DetailsRestaurantModel {
  final String restaurantId;
  final String name;
  final String phone;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? logo;

  DetailsRestaurantModel({
    required this.restaurantId,
    required this.name,
    required this.phone,
    required this.address,
    this.latitude,
    this.longitude,
    this.logo,
  });

  factory DetailsRestaurantModel.fromJson(Map<String, dynamic> json) {
    return DetailsRestaurantModel(
      restaurantId: json['restaurantId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude'] != null)
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: (json['longitude'] != null)
          ? (json['longitude'] as num).toDouble()
          : null,
      logo: json['logo'],
    );
  }

  factory DetailsRestaurantModel.empty() {
    return DetailsRestaurantModel(
      restaurantId: '',
      name: '',
      phone: '',
      address: '',
      latitude: null,
      longitude: null,
      logo: null,
    );
  }
}
