class HistoryRestaurantModel {
  final String restaurantId;
  final String name;
  final String phone;
  final String address;
  final double commission;
  final double latitude;
  final double longitude;
  final String logo;

  HistoryRestaurantModel({
    required this.restaurantId,
    required this.name,
    required this.phone,
    required this.address,
    required this.commission,
    required this.latitude,
    required this.longitude,
    required this.logo,
  });

  factory HistoryRestaurantModel.empty() {
    return HistoryRestaurantModel(
      restaurantId: '',
      name: '',
      phone: '',
      address: '',
      commission: 0.0,
      latitude: 0.0,
      longitude: 0.0,
      logo: '',
    );
  }

  factory HistoryRestaurantModel.fromJson(Map<String, dynamic> json) {
    return HistoryRestaurantModel(
      restaurantId: json['restaurantId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      commission: (json['commission'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      logo: json['logo'] ?? '',
    );
  }

  HistoryRestaurantModel copyWith({
    String? restaurantId,
    String? name,
    String? phone,
    String? address,
    double? commission,
    double? latitude,
    double? longitude,
    String? logo,
  }) {
    return HistoryRestaurantModel(
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      commission: commission ?? this.commission,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      logo: logo ?? this.logo,
    );
  }
}
