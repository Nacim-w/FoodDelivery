class ForgotPasswordModel {
  final String? email;
  final String? code;
  final String? channel;
  final String? success;
  final String? message;

  ForgotPasswordModel({
    this.email,
    this.code,
    this.channel,
    this.success,
    this.message,
  });

  factory ForgotPasswordModel.empty() {
    return ForgotPasswordModel();
  }

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      email: json['email'],
      code: json['code'],
      channel: json['channel'],
      success: json['success'],
      message: json['message'],
    );
  }

  ForgotPasswordModel copyWith({
    String? email,
    String? code,
    String? channel,
    String? success,
    String? message,
  }) {
    return ForgotPasswordModel(
      email: email ?? this.email,
      code: code ?? this.code,
      channel: channel ?? this.channel,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (code != null) 'code': code,
      if (channel != null) 'channel': channel,
      if (success != null) 'success': success,
      if (message != null) 'message': message,
    };
  }
}
