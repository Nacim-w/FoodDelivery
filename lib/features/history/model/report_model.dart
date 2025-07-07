class ReportModel {
  final String orderId;
  final String type;
  final String description;
  final List<String>? attachmentUrls;

  ReportModel({
    required this.orderId,
    required this.type,
    required this.description,
    this.attachmentUrls,
  });

  factory ReportModel.empty() {
    return ReportModel(
      orderId: '',
      type: '',
      description: '',
      attachmentUrls: [],
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      orderId: json['orderId'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      attachmentUrls: List<String>.from(json['attachmentUrls'] ?? []),
    );
  }

  ReportModel copyWith({
    String? orderId,
    String? type,
    String? description,
    List<String>? attachmentUrls,
  }) {
    return ReportModel(
      orderId: orderId ?? this.orderId,
      type: type ?? this.type,
      description: description ?? this.description,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'type': type,
      'description': description,
      if (attachmentUrls != null && attachmentUrls!.isNotEmpty)
        'attachmentUrls': attachmentUrls,
    };
  }
}
