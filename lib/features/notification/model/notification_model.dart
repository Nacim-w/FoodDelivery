class NotificationModel {
  final String message;

  NotificationModel({
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  NotificationModel copyWith({
    String? message,
  }) {
    return NotificationModel(
      message: message ?? this.message,
    );
  }
}
