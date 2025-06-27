class ReportModel {
  final String orderId;
  final String type; // Enum name as string, like "MISSING_PRODUCT"
  final String description;
  final String? imageUrl; // S3 URL of uploaded image

  ReportModel({
    required this.orderId,
    required this.type,
    required this.description,
    this.imageUrl,
  });

  factory ReportModel.empty() {
    return ReportModel(
      orderId: '',
      type: '',
      description: '',
      imageUrl: null,
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      orderId: json['orderId'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  ReportModel copyWith({
    String? orderId,
    String? type,
    String? description,
    String? imageUrl,
  }) {
    return ReportModel(
      orderId: orderId ?? this.orderId,
      type: type ?? this.type,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'type': type,
      'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}
