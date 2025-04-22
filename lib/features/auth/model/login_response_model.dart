class LoginResponseModel {
  final String token;
  final String refreshToken;
  final String role;

  LoginResponseModel({
    required this.token,
    required this.refreshToken,
    required this.role,
  });

  factory LoginResponseModel.empty() {
    return LoginResponseModel(
      token: '',
      refreshToken: '',
      role: '',
    );
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      role: json['role'] ?? '',
    );
  }

  LoginResponseModel copyWith({
    String? token,
    String? refreshToken,
    String? role,
  }) {
    return LoginResponseModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      role: role ?? this.role,
    );
  }
}
