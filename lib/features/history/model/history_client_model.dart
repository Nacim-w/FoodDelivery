class ClientModel {
  final String clientId;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final double? longitude;
  final double? latitude;

  ClientModel({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    this.longitude,
    this.latitude,
  });

  factory ClientModel.empty() {
    return ClientModel(
      clientId: '',
      firstName: '',
      lastName: '',
      phone: '',
      address: '',
      longitude: null,
      latitude: null,
    );
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clientId: json['clientId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );
  }

  ClientModel copyWith({
    String? clientId,
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    double? longitude,
    double? latitude,
  }) {
    return ClientModel(
      clientId: clientId ?? this.clientId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}
