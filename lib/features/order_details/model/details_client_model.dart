class DetailsClientModel {
  final String clientId;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;

  DetailsClientModel({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  factory DetailsClientModel.fromJson(Map<String, dynamic> json) {
    return DetailsClientModel(
      clientId: json['clientId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }

  factory DetailsClientModel.empty() {
    return DetailsClientModel(
      clientId: '',
      firstName: '',
      lastName: '',
      phone: '',
      address: '',
    );
  }
}
