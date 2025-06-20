class ReportModel {
  final String orderId;
  final String type; // Enum name as string, like "MISSING_PRODUCT"
  final String description;

  ReportModel({
    required this.orderId,
    required this.type,
    required this.description,
  });

  factory ReportModel.empty() {
    return ReportModel(
      orderId: '',
      type: '',
      description: '',
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      orderId: json['orderId'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
    );
  }

  ReportModel copyWith({
    String? orderId,
    String? type,
    String? description,
  }) {
    return ReportModel(
      orderId: orderId ?? this.orderId,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'type': type,
      'description': description,
    };
  }
}
