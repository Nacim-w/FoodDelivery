class HomeProfileModel {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String address;
  final double? latitude;
  final double? longitude;

  HomeProfileModel({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.address,
    this.latitude,
    this.longitude,
  });

  factory HomeProfileModel.empty() {
    return HomeProfileModel(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      email: '',
      phoneNumber: '',
      address: '',
      latitude: null,
      longitude: null,
    );
  }

  factory HomeProfileModel.fromJson(Map<String, dynamic> json) {
    return HomeProfileModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  HomeProfileModel copyWith({
    String? id,
    String? username,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return HomeProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
