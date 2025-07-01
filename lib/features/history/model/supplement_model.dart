class SupplementModel {
  final String supplementId;
  final int quantity;

  SupplementModel({
    required this.supplementId,
    required this.quantity,
  });

  factory SupplementModel.empty() {
    return SupplementModel(
      supplementId: '',
      quantity: 0,
    );
  }

  factory SupplementModel.fromJson(Map<String, dynamic> json) {
    return SupplementModel(
      supplementId: json['supplementId'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  SupplementModel copyWith({
    String? supplementId,
    int? quantity,
  }) {
    return SupplementModel(
      supplementId: supplementId ?? this.supplementId,
      quantity: quantity ?? this.quantity,
    );
  }
}
