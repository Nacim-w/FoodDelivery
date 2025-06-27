class GoogleResponseModel {
  final String token;
  final String refreshToken;
  final String role;
  final bool missingPhoneNumber;

  GoogleResponseModel({
    required this.token,
    required this.refreshToken,
    required this.role,
    required this.missingPhoneNumber,
  });

  factory GoogleResponseModel.empty() {
    return GoogleResponseModel(
      token: '',
      refreshToken: '',
      role: '',
      missingPhoneNumber: false,
    );
  }

  factory GoogleResponseModel.fromJson(Map<String, dynamic> json) {
    return GoogleResponseModel(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      role: json['role'] ?? '',
      missingPhoneNumber: json['missingPhoneNumber'] ?? '',
    );
  }

  GoogleResponseModel copyWith({
    String? token,
    String? refreshToken,
    String? role,
    bool? missingPhoneNumber,
  }) {
    return GoogleResponseModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      role: role ?? this.role,
      missingPhoneNumber: missingPhoneNumber ?? this.missingPhoneNumber,
    );
  }
}
