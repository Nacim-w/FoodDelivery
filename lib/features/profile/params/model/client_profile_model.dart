class ClientProfileModel {
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String address;

  ClientProfileModel({
    required this.firstname,
    required this.lastname,
    required this.phoneNumber,
    required this.address,
  });

  factory ClientProfileModel.empty() {
    return ClientProfileModel(
      firstname: '',
      lastname: '',
      phoneNumber: '',
      address: '',
    );
  }

  factory ClientProfileModel.fromJson(Map<String, dynamic> json) {
    return ClientProfileModel(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  ClientProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? phoneNumber,
    String? address,
  }) {
    return ClientProfileModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }
}
