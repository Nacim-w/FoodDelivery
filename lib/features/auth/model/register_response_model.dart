class RegisterResponseModel {
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String address;

  RegisterResponseModel({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory RegisterResponseModel.empty() {
    return RegisterResponseModel(
      username: '',
      firstname: '',
      lastname: '',
      email: '',
      phoneNumber: '',
      address: '',
    );
  }

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
    );
  }

  RegisterResponseModel copyWith({
    String? username,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? address,
  }) {
    return RegisterResponseModel(
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }
}
